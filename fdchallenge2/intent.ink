/* 
All of Bella's actions are commands
Manage commands (illocutionary forces, e.g. greet, comma)
and purposes (perlocutionary forces -- stat-changing effects of Bella's actions/words)

*/
LIST commands = cmd_yes, cmd_no, cmd_kneel, cmd_logon, cmd_tribute, cmd_increase_addiction, cmd_increase_obedience, cmd_increase_sleepiness, cmd_increase_lust, cmd_decrease_confidence, cmd_again, cmd_tribute_more, cmd_double_it,cmd_send_item, cmd_repeat_after_me, cmd_haggle_game, cmd_greet, cmd_unlock_item, cmd_do_activity

// Some commands may change stats, but the stat_changing_commands are available too,
// and are meant to be use as a mixin for other commands to boost/decrease stats in addition to the 
// command's hard-coded effect on stats.
//
VAR stat_changing_commands = (cmd_increase_addiction, cmd_increase_obedience, cmd_increase_sleepiness, cmd_increase_lust, cmd_decrease_confidence)

LIST responses = resp_obedient

LIST standard_tributes = trib5=5, trib10=10, trib20=20, trib50=50, trib100=100,trib200=200,trib250=250,trib500=500,trib1000=1000,trib5000=5000,trib10000=10000,trib100000=100000

LIST all_binary_tributes = trib1=1, trib2=2, trib4=4, trib8=8, trib16=16,trib32=32,trib64=64,trib128=128,trib256=256,trib512=512,trib1024=1024,trib2048=2048,trib4096=4096,trib8192=8192,trib16384=16384,trib32768=32768

VAR previous_tribute = 10

// For cmd_again
VAR last_args = ()

// For cmd_repeat_after_me
VAR last_phrase_to_repeat = ""

// Set by allow_disobey_if_low_obedience
VAR obeyed_cmd = false
=== intent


= allow_disobey_if_low_obedience

+ [Obey Her]
    ~ obeyed_cmd = true
    ~incstat(obedience)
+ {obedience < obedience.high}[Ignore Her]
    ~decstat(obedience)
    ~decstat(confidence)
    ~decstat(confidence)
    ~ obeyed_cmd = false
-
->->

= command_repeat_after_me(phrase, t, args)
// If it's an order to repeat a second time, e.g. "Say it again", the phrase is the order, 
// and you have to say last_phrase_to_repeat.
// Otherwise, phrase is the exact words you have to repeat.

{args ? cmd_again: 
    -> M_B(phrase) ->
    -> allow_disobey_if_low_obedience ->
    {obeyed_cmd:-> M_Y(last_phrase_to_repeat+"{||!|!!||}") ->}
-else:
    {phrase == "\{BELLA_NAME\}":
        -> M_B("{~Say,|keep repeating |keep typing }\my name") ->
        ~ phrase = BELLA_NAME
    - else:
        -> M_B("{~Say,|repeat after me:|type }\"{phrase}\"") ->
    }
    -> allow_disobey_if_low_obedience ->
    {obeyed_cmd:-> M_Y(phrase) ->}
    ~ last_phrase_to_repeat = phrase
}


->->
// args should contain an item
= command_send_item(msg, t, args)
-> M(msg, t, args+BELLA) ->
~ temp item = args ^ LIST_ALL(media)
{item == ():>>> ASSERT !!! args contains an item: {args}}
~ temp is_photo = has_tag(item, photo)
{is_photo:{camera()}|{videocam()}} {BELLA_NAME} has sent you a {is_photo:photo|video}!
-> cont ->

// If in chat session, prompt to unlock it
{current_activity == fsa_chat:
    ->command_unlock_item(msg, t, args) ->->
- else:
    {You gaze at it...|Wow.|You feel that in your balls.|No escape.}
    // It's titled "<> 
    // -> lookup_media(item, true) ->
    // <>".

}


-> cont ->

->->

= command_tribute(msg, t, args)

    ~ temp tribute_amount = trib2num(args)
    {tribute_amount == 0: // You repeat your previous tribute!
        ~ tribute_amount = previous_tribute
    - else:
        {msg=="":
            msg = {~Pay me |Send |Tribute |} {tribute_amount}.
        }
    }

    
    {obedience>=obedience.high: -> do_tribute}

    + (do_tribute) [Send ${tribute_amount}]
        -> cc.pay(BELLA_FULL_NAME, tribute_amount, true) ->
        {You get a slight thrill when you pay her.|You get that weird rush...|You feel that in your balls.|You feel like paying more.|"Good boy", she says.|You want to keeping paying.|She's ruining you, and you love it.|Your're just an ATM.|No escape.}
        ~ incstat(addiction)
        ~ incstat(lust)
        ~ previous_tribute = tribute_amount
    + {obedience <= obedience.medium}[Ignore]
        You ignore her demand.
        ~ decstat(confidence)

    -

->->

 = command_haggle_game(msg, t, args)
 
 -> allow_disobey_if_low_obedience ->
 {not obeyed_cmd:->->}
 
 ~ speech_type = speech_type_wa
  -> M_B("{Buy my panties.|How much would you pay to kiss my feet?}") ->
    
 ~incstat(lust)


-> haggle("{sniffing my panties|the privilege of holding my {?used|} knickers up to your nose|kissing my {?beautiful|perfect|amazing||} feet}", trib2num(args), 20) ->

{HAGGLE_RESULT:
 - SOLD:
    -> M_B("{Good boy. {?Expect them in the post.|}|Inhale them and surrender.}") ->
    ~ incstat(lust)
    ~ incstat(obedience)
 - RESERVE_NOT_REACHED:
     -> M_B("{No panties for you, loser.|Loser lol}") ->
    ~ incstat(lust)
    ~ decstat(confidence)
}
->->

 = command_unlock_item(msg, t, args)
 ~ temp price = trib2num(args)
 ~ temp item = args ^ LIST_ALL(media)
 {price == 0:
    ~ price = LIST_VALUE(item)
 }
 + [Unlock for {not price:free|{price} credits} now]
    -> inventory.unlock_item(item, price) ->
    ~ incstat(obedience)
 + [Later]
    ~ decstat(obedience)
 -
->->
/*
Respond to a message that has a command in the args.
Dispatches the full payload (message text, time_sent, and args) to the specific command processors.

If it doesn't contain a command, just emit the message.

So:
    M("Hello", now(), cmd_greet+BELLA) just emits "Hello" (in  Bella's current speech style),

    respond("Hello", now(), (BELLA)) does the same thing,
but:
    respond("Hello", now(), cmd_greet+BELLA)
    
triggers command_greet("Hello", now(), (BELLA))


*/
= respond(msg, t, args)
//  {_DEBUG:>>> RESPOND: {msg} {t}, {args}}
~ temp cmds  = args ^ LIST_ALL(commands)

// Stat-changing commands

// DEBUG
{(cmds ^ stat_changing_commands) != ():
     {_DEBUG:>>> COMMAND STATUS BOOST(s): {cmds ^ stat_changing_commands}}
}
// END DEBUG

{cmds ? cmd_increase_obedience:
        ~ incstat(obedience)
}
{cmds ? cmd_increase_addiction:
        ~ incstat(addiction)
}
{cmds ? cmd_increase_lust:
        ~ incstat(lust)
}
{cmds ? cmd_increase_sleepiness:
        ~ incstat(sleepiness)
}
{cmds ? cmd_decrease_confidence:
        ~ decstat(confidence)
}
~ cmds -= stat_changing_commands

// NOTE, testing for equality, not inclusion.
{cmds == cmd_again:
    -> respond(msg, t, last_args + cmd_again) ->
    ~ last_args -= cmd_again
- else:

    { 
    // Force an activity
    - cmds ? cmd_do_activity:


        ~ temp fansite_activity = args ^ LIST_ALL(fansite_activities)
        {fansite_activity != ():
            ~ force_fansite_activity = true
            ~ possible_activities = fansite_activity
{_DEBUG: >>> Forced activity: {fansite_activity}}
            -> cont -> fansite.do ->
        }
        ~ temp grind_activity = args ^ LIST_ALL(_all_activities)
        {grind_activity != ():
            ~ force_grind_activity = true
            ~ possible_activities = grind_activity
{_DEBUG:>>> Forced activity: {grind_activity}}
            -> cont -> grind.do ->
        }
    - cmds ? cmd_logon:

            -> M(msg, t, args) ->
            You log on to her fan site...
            -> cont -> fansite ->
    - cmds ? cmd_greet:
        {now()-t > 60:You know you're late replying, but...}
        ->wa.r3choices("Hi!", "Hello {BELLA_NAME}", "🍆 😆",) ->
        ~ incstat(obedience)
        
    - cmds ? cmd_yes:
        {now()-t > 3600:You know you're late replying, but...}
        -> M_Y("yes bella") ->
        ~ incstat(obedience)
    
    - cmds ? cmd_tribute:

        {msg != "": -> M(msg, t, args) ->}
        -> command_tribute(msg, t, args) ->
    
    - cmds ? cmd_haggle_game:
        -> command_haggle_game(msg, t, args) ->
    
    - cmds ? cmd_send_item:
        -> command_send_item(msg, t, args) ->
        
    - cmds ? cmd_unlock_item:
        -> command_unlock_item(msg, t, args) ->        
      - cmds ? cmd_repeat_after_me:
            -> command_repeat_after_me(msg, t, args) ->
            
    
      - else:
      {not (cmds == ()): 
           {_DEBUG:>>> UNHANDLED COMMAND(S) {cmds}}
    
        - else:
         {_DEBUG:>>> (respond) NO_COMMAND TO PROCESS, emitting message}
        -> M(msg, t, args) ->
        }
    }
    // Only set last_args if not cmd_again
    ~ last_args = cmds
}
->->

== function trib2num(arg)
~ arg = arg ^ (LIST_ALL(standard_tributes) + LIST_ALL(all_binary_tributes))
 ~ temp sum = 0
{arg == ():
    ~ return sum
}
~ temp _min = LIST_MIN(arg)
~ return LIST_VALUE(_min) + trib2num(arg-_min)

== function num2trib(v)
{v > 65535: {_DEBUG:>>> num2trib max is < {v}}}
~ temp bt = ()
~ return _num2trib(1, v, bt)
    
== function _num2trib(cumprod, ref v, ref bt)    
{v == 0:
    ~ return bt
}
{v % 2:
    ~ bt += all_binary_tributes(cumprod)
}
~ v = v / 2
~ return  _num2trib(cumprod * 2, v, bt)
 
    
    







