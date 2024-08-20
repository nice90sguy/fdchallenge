VAR chat_offline_messages = ""
VAR chat_last_args = ()
VAR chat_last_t = 0
VAR chat_last_msg = ""

LIST fsa_chat_activities = fsa_chat_greet
== fansite_chat
= opt
+ + (do) [Chat with Me 💬] 
{do == 1: {hint()} (More features of chat cumming soon!)}
    ~ current_activity = fsa_chat
    ~ speech_type = speech_type_chat

    // Set cost per message based on addiction
    
    {sq(addiction) < max: 
            ~ cost_per_message = 1
    - else: 
            ~ cost_per_message = 10
    }

    //     ~ nmsg()
    //     ~ amsg("<b>💋 Welcome to My Chat!</b>")
    //     ~ amsg("I am online here every Monday to Saturday, usually between {ampm_hm(bella_online_start_hour, 0)} and  {ampm_hm(bella_online_end_hour,0)}")
    //     ~ amsg("If you see I'm online, say something, that will alert me that you're online too!")
    //     ~ amsg("")    
    //     -> M_B(_msg) ->
    // }
    // Display and respond to any offline messages first
    {chat_offline_messages:
        {chat_offline_messages}
        ~ chat_offline_messages = ""
    }
    // First convo if first time chatting
    {do == 1 and fansite_return_to == ->grind.after_activity:-> adventure_initial_convo -> fansite.after_activity}
    // Check the last_args for any command
    
    {chat_last_args != ():
        -> p1("Respond") ->
        -> intent.respond(chat_last_msg, chat_last_t, chat_last_args+cmd_noecho) ->
        ~ chat_last_args = ()
    }    
    
    {not bella_online(): {BELLA_NAME} isn't online right now. ({ampm()})}
    // Don't wait if we haven't set up the hourly callback, otherwise we might wait forever
    + + + {not bella_online() and grind.on_the_hour}  [Wait for her to come online]
        ~ incstat(obedience)
        -> ff2h(1) -> do ->
    + + + [Leave Chat]    
    + + + [Say Hello]
            -> M_Y("hello") ->
            You know what you have to do:
     
-> cont ->
     -> intent.respond("{~Send.|Tip Me|}", now(), cmd_tribute + Confidence + num2list(sqi(addiction))) ->
       {bella_online():
            -> taunt ->
        }

    - - -
        
    ~ activities_done_today += fsa_chat

    -> fansite.after_activity
->->


= adventure_initial_convo

~ set_bella_online(false) // Should already be false 
-> p1("Respond") ->
-> intent.respond(chat_last_msg, chat_last_t, chat_last_args) ->

You notice she's offline now, so you sit back and wait. You re-read what she typed, and think to yourself, "Maybe I should say hi or something."  Or maybe be a little more polite.  You type:
-> M_Y("Hello") -> 
-> p1("Wait for her to come online") ->
-> ffa(second, 63) ->
You wait for less than a minute, and then...
~ set_bella_online(true)
-> M_B("Hi") ->
The shock of reading her instant reply make you suddenly find yourself unable to respond for a minute.
-> cont ->
-> M_B("Well? lol") ->
-> M_Y("sry i couldnt think of what to say lol") ->

You're beginning to wake up to the weird impulsiveness, not to say insanity of what you've done.   Why did you so quickly decide to do this?  And why do you have such a strong impluse to jump to do what she tells you, almost as though her commands are bypassing your brain?
Does she even remember who you are? 
-> cont ->
~decstat(confidence)
-> M_Y("I dont know if you remember me, I'm the guy whose oysters you ate! It was my last night in New York") ->
-> M_B("ofc I remember") ->

She doesn't continue after that, and you're stumped for what to say.  She's not very talkative!
-> cont ->
-> ffa(second, 20) ->
You wonder if she'd be annoyed if you just quit the chat and logged off.
{hint()} (She would be very annoyed!)

Maybe you should ask what you're actually getting from her for your ${FAN_CLUB_SIGNON_FEE}.  But somehow you don't feel like offending her.
You notice that every time you've been sending her chat messages, there's been a little number next to your message:

-> M_YP("There's a number next to my chat messages") ->

-> M_B("thats your credits.") ->

-> M_Y("It's going down by {print_number(cost_per_message)} all the time?") ->

She doesn't respond for a minute, but then types:

-> M_B("type something now") ->

~ cost_per_message = 10
You type
-> M_Y("hello, world") ->
-> cont ->
You type it again, to double-check:
-> M_Y("hello, world") ->
-> cont ->
-> M_B("lol keep talking, {YOUR_NAME}") ->
-> cont ->
You figure out that every time you send a message, the site charges you. And that {BELLA_NAME} is seemingly able to change the price!
-> M_B("type hello world again, you nerd  {YOUR_NAME} lol") ->
You ignore her, but she types it again!
-> intent.respond("hello world", now(), BELLA+cmd_repeat_after_me) ->
{obeyed_cmd:-> intent.respond("Good boy. Again.", now(), BELLA+cmd_again) -> }
-> M_B("lol dont worry im setting the price back to only one credit for a message.  You need your credits for more than chatting {devil_happy()}") ->
~ cost_per_message = 1
-> ffa(minute, 1) ->
-> cont ->
You don't know why, but you're kind of turned on by this conversation. 
~ set_bella_online(false)
You wait around to see if she's going to say anything else, but it doesn't look like it.
You type
-> M_Y("ty lol") ->
, and notice that it only cost you one credit, as she promised.
You sit back, wondering even more than ever who she is, and leave the chat, to explore the rest of her site.
-> ffa(second, 30) ->
->->


= taunt
{RANDOM(1,4):
    -1:
        -> intent.respond("{Jerk and goon 🤤|UNLOCK IT||Go on.|Uulock}", now(), cmd_send_item+LIST_RANDOM(available_items)) ->
    -2: 
        -> intent.respond("I will obey {BELLA_NAME}", now(), cmd_repeat_after_me) ->
    -3:
        -> intent.respond("I will obey {BELLA_NAME}", now(), cmd_repeat_after_me) ->
    -4:
        -> M_B("Take off your pants,and get on your knees.") ->
        -> p1e("You do as she says") ->
        <><i>, and go down on your knees.
        -> cont ->
        -> M_B("now, start stroking.") -> 
        
        -> intent.respond("I live for {BELLA_NAME}", now(), cmd_repeat_after_me) ->
        -> M_B("now, start stroking faster.") -> 
        ->p1("speed up") ->
        -> M_B("Faster!") -> 
        ->p1e("You feel you're about to cum") ->      
        <><i>, but just as you're about to, she types:
        ~ temp ad_hoc_tribute = 20*LIST_VALUE(addiction)
        ~ temp tx_result = FS_TX_FAIL
        -> M_B("Pay your cum tax, if you want to cum. {ad_hoc_tribute} credits.") ->
        You take your hand off your dick and type furiously on the keyboard, rushing to do as you're told:
        -> fansite_credits.pay(ad_hoc_tribute, tx_result) -> 
        {tx_result ? FS_TX_SUCCESS:
            You cum.
            ~ incstat(addiction)
            
            {sq(addiction) >= high:
                ~ incstat(lust)
            }
        - else:
            You don't cum.
        }

    
}
->->



