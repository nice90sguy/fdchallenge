LIST MSG_PEOPLE = MSG_PEOPLE_BELLA, MSG_PEOPLE_MELANIE, MSG_PEOPLE_ANGIE, ANGIE_FULL_NAME, ANGIE_UNKNOWN, MSG_PEOPLE_YOU, MSG_PEOPLE_AL
LIST LAST_MSG_RESULT = LAST_MSG_RESULT_SUCCESS, LAST_MSG_RESULT_INSUFFICIENT_CREDITS

VAR BELLA = (MSG_PEOPLE_BELLA, LAST_MSG_RESULT_SUCCESS)
VAR YOU = MSG_PEOPLE_YOU
VAR ANGIE = MSG_PEOPLE_ANGIE
VAR AL = MSG_PEOPLE_AL
VAR MELANIE = MSG_PEOPLE_MELANIE

== function msg_name(person)
{person ^ LIST_ALL(MSG_PEOPLE):
    - MSG_PEOPLE_AL:
        ~ return "Al"
    - MSG_PEOPLE_BELLA: 
        ~ return BELLA_NAME
    - MSG_PEOPLE_MELANIE:
        ~ return girlfriend_name
    - MSG_PEOPLE_ANGIE:
        ~ return "Angie"
    - ANGIE_FULL_NAME:
        ~ return "Angela Scott"
    - ANGIE_UNKNOWN:
        ~ return "+44 7024 922200"
    - MSG_PEOPLE_YOU:
        ~ return "You"
    - else:
        ~ return person
}


 // Message from Bella
 === M_B(msg)
-> M(msg, now(), BELLA)

 === M(msg, t, ref args)

~ set_result_success(args)
{ speech_type:
    - speech_type_voice: -> M_v(msg, t, args) ->
    - speech_type_wa: -> M_wa(msg, t, args) ->
    - speech_type_chat: -> M_chat(msg, t, args, ->null_cb) ->
}

{args ? WAM_PAUSE:-> cont ->}
->->



//Message from you
=== M_Y(msg)
-> M(msg, now(), YOU) ->->

//Message from Bella with pause
=== M_BP(msg)
~ temp from = BELLA+WAM_PAUSE
-> M(msg, now(), from) ->
-> ffa(second, 5) ->->

//Message from you with pause
=== M_YP(msg)
-> M(msg, now(), YOU) ->
{YOU ^ LAST_MSG_RESULT_SUCCESS:-> p1("Wait for her to reply") ->}
->->

// wa Message start
=== function M_wa_S(from)

~ temp e = "{from == MSG_PEOPLE_YOU:i|b}"
~ temp e_o = "{e != "":<{e}>}"
~ temp t = now()
{_LITEROTICA_EXPORT:

    ~ e_o = ""
}
 {e_o}{ddmm(t)} {hhmm(t)} ({msg_name(from)}) {e_o}<>
 
// wa Message end
=== function M_wa_E(from)

~ temp e = "{from == YOU:i:b}"

~ temp e_e = "{e != "":</{e}>}"
{_LITEROTICA_EXPORT:
    ~ e_e = ""

}
{e_e}
 
=== M_wa(msg, t, ref args)

 ~ temp from =  args ^ LIST_ALL(MSG_PEOPLE)
~ temp e = "{from == MSG_PEOPLE_YOU:i|{now()-t < 60:b}}"
~ temp e_o = ""
~ temp e_e = ""

{_LITEROTICA_EXPORT:
    ~ e_e = ""
    ~ e_o = ""
}
 {e_o}{ddmm(t)} {hhmm(t)} ({msg_name(from)}) {e_o}{msg}{e_e}
->->

 === M_v(msg, t, ref args)
  {t == now(): ->ffa(second, 5) ->}
  
  \"{msg}\"
  
 ->->
 

 === M_chat(msg, t, ref args, ->cb)
    ~ temp from =  args ^ LIST_ALL(MSG_PEOPLE)
    ~ temp e = "{from == MSG_PEOPLE_BELLA:b|{from==MSG_PEOPLE_YOU:i}}"
    ~ temp e_o = "{e != "":<{e}>}"
    ~ temp e_e = "{e != "":</{e}>}"
    {_LITEROTICA_EXPORT:
        ~ e_e = ""
        ~ e_o = ""
    }
     {t == now(): ->ffa(second, 5) ->}
     
    ~ temp formatted_msg = "{from!=MSG_PEOPLE_YOU:💬 }{from==MSG_PEOPLE_YOU:({credits-cost_per_message})} {e_o}{msg}{e_e}{from==MSG_PEOPLE_YOU: 🗨️}"
    {current_activity ? fsa_chat:
        {from == MSG_PEOPLE_YOU:
           
            ~ temp fs_tx_result = ()
            -> fansite_credits.pay(cost_per_message, fs_tx_result) ->
            {fs_tx_result  == FS_TX_FAIL:
                ~ args -= LIST_ALL(LAST_MSG_RESULT)
                ~ args += LAST_MSG_RESULT_INSUFFICIENT_CREDITS
                ->->
            }
        }
        
        {formatted_msg}
        
    - else:
        {not bella_online():
            ~ chat_offline_messages += "{formatted_msg}<br>"
        }
    }
    // She 
    {from != MSG_PEOPLE_YOU and not (current_activity ? fsa_chat):
        ~ chat_last_args = args
        ~ chat_last_t = t
        ~ chat_last_msg = msg
        ~ chat_last_cb = cb
    }
->->

=== function set_result_success(ref args)
    ~ args -= LIST_ALL(LAST_MSG_RESULT)
    ~ args += LAST_MSG_RESULT_SUCCESS

=== function set_result_insufficient_credits(ref args)
    ~ args -= LIST_ALL(LAST_MSG_RESULT)
    ~ args += LAST_MSG_RESULT_INSUFFICIENT_CREDITS
