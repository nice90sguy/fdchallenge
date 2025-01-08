/* 
All of Bella's actions are commands
Manage commands (illocutionary forces, e.g. greet, comma)
and purposes (perlocutionary forces -- stat-changing effects of Bella's actions/words)

*/
LIST commands = cmd_yes, cmd_no, cmd_kneel, cmd_logon, cmd_tribute, cmd_again, cmd_tribute_more, cmd_double_it,cmd_send_item, cmd_repeat_after_me, cmd_haggle_game, cmd_greet, cmd_unlock_item, cmd_noecho, cmd_setflag, cmd_clearflag, cmd_noemit, cmd_meet, cmd_cb

// Some commands may change stats, but the stat_changing_commands are available too,
// and are meant to be use as a mixin for other commands to boost/decrease stats in addition to the 
// command's hard-coded effect on stats.
//


LIST responses = resp_obedient


VAR last_tribute = 10

// For cmd_again
VAR last_args = ()

// For cmd_repeat_after_me
VAR last_phrase_to_repeat = ""

// Set by allow_disobey_below_obedience_threshold
VAR obeyed_cmd = false
=== intent

= command_cb(msg, t, args, ->cb)

-> cb(msg, t, args) ->->

= cmd_adhoc(msg, obedience_threshold)

+ [{msg}]
    ~ obeyed_cmd = true
    ~incstat(obedience)
+ {obedience < obedience_threshold}[Ignore Her]
    ~decstat(obedience)
    ~ obeyed_cmd = false
-
->->

= allow_disobey_below_obedience_threshold(threshold)
-> cmd_adhoc("Obey Her", threshold)


= command_meet(msg, t, args, cb)
{_DEBUG: >>> CMD INVITE}
~ temp where = args ^ LIST_ALL(location)
~ temp when = list2num(args) // epoch time
~ temp with = args ^ LIST_ALL(MSG_PEOPLE)
{when == 0:
    ~ when = now() + 3600
}
You arrange to meet {msg_name(with)} {location_name(where)} at {hhmm(when)}.

 ~ set_timer_cb(when - epoch_time, cb)
->->

= command_repeat_after_me(phrase, t, args)
// If it's an order to repeat a second time, e.g. "Say it again", the phrase is the order, 
// and you have to say last_phrase_to_repeat.
// Otherwise, phrase is the exact words you have to repeat.

{args ? cmd_again: 
    -> M_B(phrase) ->
    -> allow_disobey_below_obedience_threshold(medium) ->
    {obeyed_cmd:-> M_Y(last_phrase_to_repeat+"{||!|!!||}") ->}
-else:
    {phrase == "\{BELLA_NAME\}":
        -> M_B("{~Say |keep repeating |keep typing }\my name") ->
        ~ phrase = BELLA_NAME
    - else:
        -> M_B("{~Say,|repeat after me:|type }\"{phrase}\"") ->
    }
    -> allow_disobey_below_obedience_threshold(medium) ->
    {obeyed_cmd:-> M_Y(phrase) ->}
    ~ last_phrase_to_repeat = phrase
}


->->
// args should contain an item
= command_send_item(msg, t, args)
~ temp item = args ^ LIST_ALL(media)


 
{item == ():
>>> ASSERT !!! args contains an item: {args}
~ item = (photo, media_22_)
~ args += item
~ args += num2list(100)
}

-> lookup_media(item, item) ->
 // Item now contains tags and media type
 
~ temp is_photo = (item ? photo)
{is_photo:{camera()}|{videocam()}} {BELLA_NAME} has sent you a {is_photo:photo|video}!
-> cont ->

// If in chat session, prompt to unlock it
{current_activity == fsa_chat:
    ->command_unlock_item(msg, t, args) ->->
- else:
    {She's just incredible...|You gaze at it...|Triggered.|You need more.|More.|You're so fucked.|You almost cum looking at it.|Wow.|You feel that in your balls.|OMFG...|No escape.}
    // It's titled "<> 
    // -> lookup_media(item, true) ->
    // <>".

}


-> cont ->

->->

= command_tribute(msg, t, args)

    ~ temp tribute_amount = list2num(args)
    {tribute_amount == 0: // You repeat your previous tribute!
        ~ tribute_amount = last_tribute
    - else:
        {msg=="":
            ~ msg = "{~Pay me |Send |Send me|Tip|Tip me|} {tribute_amount}."
        }
    }

    
    {sq(obedience) == max or sq(addiction) == max: -> do_tribute}

    + (do_tribute) [Send ${tribute_amount}]
        -> cc.pay(BELLA_FULL_NAME, tribute_amount, true) ->
        {TX_RESULT != TX_SUCCESS:
            ~ decstat(confidence)
        - else:
            {You get a slight thrill when you pay her.|You get that weird rush...|You feel that in your balls.|You feel like paying more.|<i>"Good boy"</i>, she says in your head.|You want to keeping paying.|She's ruining you, and you love it.|Your're just an ATM.|No escape.}
            ~ incstat(addiction)
            ~ incstat(lust)
        }
        ~ last_tribute = tribute_amount
        
    + {sq(obedience) <= medium}[Resist]
        You resist.
        ~ last_tribute = 0
        ~ decstat(confidence)

    -

->->

 = command_haggle_game(msg, t, args)
 
 -> allow_disobey_below_obedience_threshold(medium) ->
 {not obeyed_cmd:->->}
 
 ~ speech_type = speech_type_wa
  -> M_B("{Buy my panties.|How much would you pay to kiss my feet?}") ->
    
 ~incstat(lust)

~ speech_type = speech_type_wa
-> haggle("{sniffing my panties|the privilege of holding my {?used|} knickers up to your nose|kissing my {?beautiful|perfect|amazing||} feet}", list2num(args), 20) ->
{_DEBUG:>>> HAGGLE RESULT: {HAGGLE_RESULT}}
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
 ~ temp price = list2num(args)
 ~ temp item = args ^ LIST_ALL(media)
 {price == 0:
    ~ price = LIST_VALUE(item) * sqi(addiction) / 10
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
= respond(msg, t, args, cb)

//  {_DEBUG:>>> RESPOND: {msg} {t}, {args}}
~ temp gs_flags = args ^ LIST_ALL(state_flags)
~ temp cmds  = args ^ LIST_ALL(commands)
~ temp from = args ^ LIST_ALL(MSG_PEOPLE)
{from == ANGIE_FULL_NAME:
    ~ from = ANGIE
}
{not (cmds ^ (cmd_noemit, cmd_again)):
     -> M(msg, t, args) ->
}
// Set/Clear game state flags
{gs_flags != ():
    {
     - cmds ^ cmd_setflag:
        ~ state_flags += gs_flags
        >>> GAME STATE: + {gs_flags}
     - cmds ^ cmd_clearflag:
      ~ state_flags -= gs_flags
        >>> GAME STATE: - {gs_flags}
     - else:
        >>> Error: Game state flag(s) {gs_flags} were in command arg, but no cmd_setflag or cmd_clearflag command.
    }
}

// Stat-changing commands

// DEBUG
{(cmds ^ LIST_ALL(stat_t)) != ():
     {_DEBUG:>>> COMMAND STATUS BOOST(s): {cmds ^ LIST_ALL(stat_t)}}
}
// END DEBUG

{cmds ? Submissiveness:
        ~ incstat(obedience)
}
{cmds ? Addiction:
        ~ incstat(addiction)
}
{cmds ? Lust:
        ~ incstat(lust)
}
{cmds ? Sleepiness:
        ~ incstat(sleepiness)
}
{cmds ? Confidence:
        ~ decstat(confidence)
}
~ cmds -= LIST_ALL(stat_t)

// NOTE, testing for equality, not inclusion.
{cmds == cmd_again:
    -> respond(msg, t, last_args + cmd_again + cmd_noemit, 0) ->
    ~ last_args -= cmd_again
- else:

    { 
    - cmds == cmd_cb:
        -> command_cb(msg, t, args, cb) ->
        
    - cmds ? cmd_logon:
            You log on to her fan site...
            -> cont -> fansite
    - cmds ? cmd_greet:
        {now()-t > 60:You know you're late replying, but...}
        ->wa.r3choices("Hi!", "Hello {msg_name(from)}", "🍆 😆",) ->
        ~ incstat(obedience)

    - cmds ? cmd_meet:
        {now()-t > 3600:You know you're late replying, but...}
        -> M_Y("Sure {msg_name(from)}!") ->
        -> command_meet(msg, t, args, cb) ->
        ~ incstat(obedience)
        
    - cmds ? cmd_yes:
        {now()-t > 3600:You know you're late replying, but...}
        -> M_Y("yes {msg_name(from)}") ->
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
            
    - cmds ? cmd_noecho:
           {_DEBUG:>>> cmd_noecho, not emitting message}    
    - else:
      {not (cmds == ()): 
           {_DEBUG:>>> UNHANDLED COMMAND(S) {cmds}}
      }

    }
    // Only set last_args if not cmd_again
    ~ last_args = cmds
}
->->








