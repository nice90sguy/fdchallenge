

VAR DID_READ_MESSAGE = false

LIST WAM_RESPONSE_TYPE = WAM_READ, WAM_IGNORE, WAM_MISS,  WAM_CHOOSE, WAM_SILENT, WAM_READ_MISSED, WAM_PAUSE, WAR_HUMILIATED, WAR_POLITE, WAR_FRIENDLY, WAR_ADDICTED, WAR_OBEDIENT

VAR WAM_CONTINUOUS =  (WAM_READ, WAM_SILENT)
VAR WAM_CONTPAUSE = (WAM_READ, WAM_SILENT, WAM_PAUSE)


=== wa
  
= m(msg, args)
~ temp from =  args ^ LIST_ALL(MSG_PEOPLE)

 ~ temp t = now()  // Message has just arrived
 
 // Default sender is Bella
{from == ():
    ~ args += BELLA
}

~ temp old_speech_type = speech_type
~ speech_type = speech_type_wa
~ temp response_type = args ^ LIST_ALL(WAM_RESPONSE_TYPE)


// default is choose to read it/read oldest/ignore for now
{response_type == ():
    ~ response_type = WAM_CHOOSE + WAM_READ_MISSED
}
//~ args -= response_type

~ DID_READ_MESSAGE = false

// Must respond if you're very obedient
{response_type ? WAM_CHOOSE and obedience >= obedience.high:
    ~ response_type -= WAM_CHOOSE
    ~ response_type += WAM_READ
}

 
{
    
    - response_type ? WAM_IGNORE:
        {not (response_type ? WAM_SILENT):
            {warn()} You receive {unread_message_count:another|a} WhatsApp message, but you don't read it right now.
        }
        -> ignoreit
        
    - response_type ? WAM_MISS:

        {not (response_type ? WAM_SILENT):
            {warn()} You receive {unread_message_count:another|a} WhatsApp message at {ampm()}, but you don't hear your phone.
        
        }
        -> ignoreit 
    - response_type ? WAM_CONTINUOUS:
        -> ffa(second, 5) ->  

        -> readit
    - else:
        {warn()} New WhatsApp Message from {msg_name(from)}!
        {unread_message_count:<i>You also have {unread_message_count} unread message{unread_message_count!=1:s}.} 
}


+ (readit)[{response_type ? WAM_READ:Read it now|👠 Read it now! }]

    -> ffa(second,10) ->
     -> respond_to_msg(msg, args, t) ->

    ~ DID_READ_MESSAGE = true
    {response_type ? WAM_PAUSE:
        -> cont ->
    }
    
+ (ignoreit){response_type ? WAM_CHOOSE}[Read Later]
    // Add to missed messages
        // remove all commands from the message, you've missed it
    // {_DEBUG:>>> MISSED COMMAND(s): {args ^ LIST_ALL(commands)}}
    // ~ args = args - LIST_ALL(commands)
    -> unread_message_log.add(msg, args) ->
    ~ decstat(obedience)

-

// Allow option to read old messages, if any, if WAM_READ_MISSED

   
+ {unread_message_count and response_type ? WAM_READ_MISSED} [Read them] -> read_missed_messages ->
+ {obedience <= obedience.medium and addiction <= addiction.medium and unread_message_count and response_type ? WAM_READ_MISSED} [Delete them without reading] -> unread_message_log.clear ->

+ ->
-

// Restore speech type
~ speech_type = old_speech_type
->->

= read_missed_messages
~ temp t =  0
~ temp arg = ()
~ temp msg = ""
+ (loop_missed_msgs)  ->
     {unread_message_count==0:
     ->->
     - else: 
          {question()} Read your {unread_message_count > 1:{unread_message_count}} missed message{unread_message_count > 1:s}:
     }

  +  + [Yes {unread_message_count > 1: (Oldest first)}] -> 
        -> unread_message_log.pop_oldest(msg, arg, t) ->
         -> respond_to_msg(msg, arg, t) -> loop_missed_msgs
  +  + {unread_message_count > 1}[Yes (Newest first)] -> 
        -> unread_message_log.pop_newest(msg, arg, t) ->
         -> respond_to_msg(msg, arg, t) -> loop_missed_msgs
  +  + {unread_message_count}[I've changed my mind]
    ->->

-


->->

= respond_to_msg(ref msg, ref args, ref t)
{_DEBUG:>>> RESPOND TO MESSAGE: {msg}, {t} {args}}
// Do nothing if the time is zero (no message in slot)
{t:
    // If the message contains any commands, dispatch to command handler,
    // Which may or may not emit the message
    {(args ^ LIST_ALL(commands)) != ():

        -> intent.respond(msg, t, args) ->
    -else: 
         {_DEBUG:>>> respond_to_msg NO_COMMAND_IN_MESSAGE}
    // emit the message if it's not blank
        ->M_wa(msg, t, args) ->
    }
}
->->

 // Chat message (from you)
= r(msg)
-> ffa(second,10) ->
~ speech_type = speech_type_wa
-> M_Y(msg) ->

->->


= r3choices(choice1,choice2,choice3)

+ (chose1) {choice1} [{choice1}] -> r(choice1)
+ (chose2) {choice2} [{choice2}] -> r(choice2)
+ (chose3) {choice3} [{choice3}] -> r(choice3)

-
->->

VAR _msglog_txt_0 =""
VAR _msglog_txt_1 =""
VAR _msglog_txt_2 =""
VAR _msglog_txt_3 =""
VAR _msglog_txt_4 =""
VAR _msglog_txt_5 =""
VAR _msglog_txt_6 =""
VAR _msglog_txt_7 =""
VAR _msglog_txt_8 =""
VAR _msglog_txt_9 =""

VAR _msglog_arg_0 =()
VAR _msglog_arg_1 =()
VAR _msglog_arg_2 =()
VAR _msglog_arg_3 =()
VAR _msglog_arg_4 =()
VAR _msglog_arg_5 =()
VAR _msglog_arg_6 =()
VAR _msglog_arg_7 =()
VAR _msglog_arg_8 =()
VAR _msglog_arg_9 =()

VAR _msglog_t_0 = 0
VAR _msglog_t_1 = 0
VAR _msglog_t_2 = 0
VAR _msglog_t_3 = 0
VAR _msglog_t_4 = 0
VAR _msglog_t_5 = 0
VAR _msglog_t_6 = 0
VAR _msglog_t_7 = 0
VAR _msglog_t_8 = 0
VAR _msglog_t_9 = 0

CONST MAX_MSG_LOG_NUM = 9

VAR unread_message_count = 0

=== unread_message_log
>>> Do not direct to message_log, use its stitches
-> END

// Adds a message to the front of the queue (slot zero)
= add(msg, arg)

{_msglog_t_9 != 0:
    {warn()} You've lost some old messages! Better read them as soon as possible!
    ~ decstat(confidence)
    ~ incstat(obedience)
- else: 
    ~ unread_message_count++
}
{_msglog_t_7 != 0:{warn()} Your message log is almost full! Better read them as soon as possible!}
~ _msglog_txt_9 = _msglog_txt_8
~ _msglog_txt_8 = _msglog_txt_7
~ _msglog_txt_7 = _msglog_txt_6
~ _msglog_txt_6 = _msglog_txt_5
~ _msglog_txt_5 = _msglog_txt_4
~ _msglog_txt_4 = _msglog_txt_3
~ _msglog_txt_3 = _msglog_txt_2
~ _msglog_txt_2 = _msglog_txt_1
~ _msglog_txt_1 = _msglog_txt_0
~ _msglog_txt_0 = msg

~ _msglog_arg_9 = _msglog_arg_8
~ _msglog_arg_8 = _msglog_arg_7
~ _msglog_arg_7 = _msglog_arg_6
~ _msglog_arg_6 = _msglog_arg_5
~ _msglog_arg_5 = _msglog_arg_4
~ _msglog_arg_4 = _msglog_arg_3
~ _msglog_arg_3 = _msglog_arg_2
~ _msglog_arg_2 = _msglog_arg_1
~ _msglog_arg_1 = _msglog_arg_0
~ _msglog_arg_0 = arg

~ _msglog_t_9 = _msglog_t_8
~ _msglog_t_8 = _msglog_t_7
~ _msglog_t_7 = _msglog_t_6
~ _msglog_t_6 = _msglog_t_5
~ _msglog_t_5 = _msglog_t_4
~ _msglog_t_4 = _msglog_t_3
~ _msglog_t_3 = _msglog_t_2
~ _msglog_t_2 = _msglog_t_1
~ _msglog_t_1 = _msglog_t_0
~ _msglog_t_0 = now()

->->

= clear

    ~ temp msg = ""
    ~ temp arg = ()
    ~ temp t = 0
    -> pop_oldest(msg, arg, t) ->
    {t > 0:->clear}
{_DEBUG: unread_message_count after clear() is {unread_message_count} (should be 0)}
->->

    
= pop_newest(ref msg, ref cmd, ref t)

~ msg = _msglog_txt_0
~ _msglog_txt_0 = _msglog_txt_1
~ _msglog_txt_1 = _msglog_txt_2
~ _msglog_txt_2 = _msglog_txt_3
~ _msglog_txt_3 = _msglog_txt_4
~ _msglog_txt_4 = _msglog_txt_5
~ _msglog_txt_5 = _msglog_txt_6
~ _msglog_txt_6 = _msglog_txt_7
~ _msglog_txt_7 = _msglog_txt_8
~ _msglog_txt_8 = _msglog_txt_9
~ _msglog_txt_9 = ""

~ cmd += _msglog_arg_0
~ _msglog_arg_0 = _msglog_arg_1
~ _msglog_arg_1 = _msglog_arg_2
~ _msglog_arg_2 = _msglog_arg_3
~ _msglog_arg_3 = _msglog_arg_4
~ _msglog_arg_4 = _msglog_arg_5
~ _msglog_arg_5 = _msglog_arg_6
~ _msglog_arg_6 = _msglog_arg_7
~ _msglog_arg_7 = _msglog_arg_8
~ _msglog_arg_8 = _msglog_arg_9
~ _msglog_arg_9 = ()

~ t = _msglog_t_0
~ _msglog_t_0 = _msglog_t_1
~ _msglog_t_1 = _msglog_t_2
~ _msglog_t_2 = _msglog_t_3
~ _msglog_t_3 = _msglog_t_4
~ _msglog_t_4 = _msglog_t_5
~ _msglog_t_5 = _msglog_t_6
~ _msglog_t_6 = _msglog_t_7
~ _msglog_t_7 = _msglog_t_8
~ _msglog_t_8 = _msglog_t_9
~ _msglog_t_9 = 0

// If found a message, decrement count
{t:
    ~ unread_message_count--
}
->->

// Gets oldest message and sets its date to zero
= pop_oldest(ref msg, ref arg,  ref t)

{
- _msglog_t_9:
    ~ msg = _msglog_txt_9
    ~ t = _msglog_t_9
    ~ arg = _msglog_arg_9
    ~ _msglog_t_9 = 0
- _msglog_t_8:
    ~ msg = _msglog_txt_8
    ~ t = _msglog_t_8
    ~ arg = _msglog_arg_8
    ~ _msglog_t_8 = 0
- _msglog_t_7:
    ~ msg = _msglog_txt_7
    ~ t = _msglog_t_7
    ~ arg = _msglog_arg_7
    ~ _msglog_t_7 = 0
- _msglog_t_6:
    ~ msg = _msglog_txt_6
    ~ t = _msglog_t_6
    ~ arg = _msglog_arg_6
    ~ _msglog_t_6 = 0
- _msglog_t_5:
    ~ msg = _msglog_txt_5
    ~ t = _msglog_t_5
    ~ arg = _msglog_arg_5
    ~ _msglog_t_5 = 0
- _msglog_t_4:
    ~ msg = _msglog_txt_4
    ~ t = _msglog_t_4
    ~ arg = _msglog_arg_4
    ~ _msglog_t_4 = 0
- _msglog_t_3:
    ~ msg = _msglog_txt_3
    ~ t = _msglog_t_3
    ~ arg = _msglog_arg_3
    ~ _msglog_t_3 = 0
- _msglog_t_2:
    ~ msg = _msglog_txt_2
    ~ t = _msglog_t_2
    ~ arg = _msglog_arg_2
    ~ _msglog_t_2 = 0
- _msglog_t_1:
    ~ msg = _msglog_txt_1
    ~ t = _msglog_t_1
    ~ arg = _msglog_arg_1
    ~ _msglog_t_1 = 0
- _msglog_t_0:
    ~ msg = _msglog_txt_0
    ~ t = _msglog_t_0
    ~ arg = _msglog_arg_0
    ~ _msglog_t_0 = 0
}
// If found a message, decrement count
{t:
    ~ unread_message_count--
}
->->

=== function _message_log_next_free_slot(n)

{n > MAX_MSG_LOG_NUM or _mlog_t(n) == FAR_FUTURE:
    ~ return n
- else:
    ~ return _message_log_next_free_slot(n+1)
}

== function _mlog_t(n)
{n:
    - 0:
        ~ return _msglog_t_0
    - 1:
        ~ return _msglog_t_1
    - 2:
        ~ return _msglog_t_2        
    - 3:
        ~ return _msglog_t_3       
    - 4:
        ~ return _msglog_t_4
    - 5:
        ~ return _msglog_t_5
    - 6:
        ~ return _msglog_t_6
    - 7:
        ~ return _msglog_t_7       
    - 8:
        ~ return _msglog_t_8        
    - 9:
        ~ return _msglog_t_9 
}
== function _mlog_txt(n)
{n:
    - 0:
        ~ return _msglog_txt_0
    - 1:
        ~ return _msglog_txt_1
    - 2:
        ~ return _msglog_txt_2        
    - 3:
        ~ return _msglog_txt_3       
    - 4:
        ~ return _msglog_txt_4
    - 5:
        ~ return _msglog_txt_5
    - 6:
        ~ return _msglog_txt_6
    - 7:
        ~ return _msglog_txt_7       
    - 8:
        ~ return _msglog_txt_8        
    - 9:
        ~ return _msglog_txt_9 
}        
== function _mlog_arg(n)
{n:
    - 0:
        ~ return _msglog_arg_0
    - 1:
        ~ return _msglog_arg_1
    - 2:
        ~ return _msglog_arg_2        
    - 3:
        ~ return _msglog_arg_3       
    - 4:
        ~ return _msglog_arg_4
    - 5:
        ~ return _msglog_arg_5
    - 6:
        ~ return _msglog_arg_6
    - 7:
        ~ return _msglog_arg_7       
    - 8:
        ~ return _msglog_arg_8        
    - 9:
        ~ return _msglog_arg_9 
}


