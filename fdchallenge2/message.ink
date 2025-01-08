LIST MSG_PEOPLE = BELLA, MELANIE, ANGIE, ANGIE_FULL_NAME, ANGIE_UNKNOWN, YOU, AL

== function msg_name(person)
{person:
    - AL:
        ~ return "Al"
    - BELLA: 
        ~ return BELLA_FULL_NAME
    - MELANIE:
        ~ return girlfriend_name
    - ANGIE:
        ~ return "Angie"
    - ANGIE_FULL_NAME:
        ~ return "Angela Scott"
    - ANGIE_UNKNOWN:
        ~ return "+44 7024 922200"
    - YOU:
        ~ return "You"
    - else:
        ~ return BELLA_FULL_NAME
}


 // Message from Bella
 === M_B(msg)
-> M(msg, now(), BELLA)

 === M(msg, t, args)


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
-> M(msg, now(), BELLA) ->
-> ffa(second, 5) ->->

//Message from you with pause
=== M_YP(msg)
-> M(msg, now(), YOU) ->
-> p1("Wait for her to reply") ->->

// wa Message start
=== function M_wa_S(from)

~ temp e = "{from == YOU:i|b}"
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
 
=== M_wa(msg, t, args)

 ~ temp from =  args ^ LIST_ALL(MSG_PEOPLE)
~ temp e = "{from == YOU:i|{now()-t < 60:b}}"
~ temp e_o = ""
~ temp e_e = ""

{_LITEROTICA_EXPORT:
    ~ e_e = ""
    ~ e_o = ""
}
 {e_o}{ddmm(t)} {hhmm(t)} ({msg_name(from)}) {e_o}{msg}{e_e}
->->

 === M_v(msg, t, from)
  {t == now(): ->ffa(second, 5) ->}
  
  \"{msg}\"
  
 ->->
 

 === M_chat(msg, t, args, ->cb)
    ~ temp from =  args ^ LIST_ALL(MSG_PEOPLE)
    ~ temp e = "{from == BELLA:b|{from==YOU:i}}"
    ~ temp e_o = "{e != "":<{e}>}"
    ~ temp e_e = "{e != "":</{e}>}"
    {_LITEROTICA_EXPORT:
        ~ e_e = ""
        ~ e_o = ""
    }
     {t == now(): ->ffa(second, 5) ->}
     
    ~ temp formatted_msg = "{from!=YOU:💬 }{from==YOU:({credits-cost_per_message})} {e_o}{msg}{e_e}{from==YOU: 🗨️}"
    {current_activity ? fsa_chat:
        {from == YOU:
            ~ temp tx_result = ()
            -> fansite_credits.pay(cost_per_message, tx_result) ->
        }
        
        {formatted_msg}
        
    - else:
        {not bella_online():
            ~ chat_offline_messages += "{formatted_msg}<br>"
        }
    }
    // She 
    {from != YOU and not (current_activity ? fsa_chat):
        ~ chat_last_args = args
        ~ chat_last_t = t
        ~ chat_last_msg = msg
        ~ chat_last_cb = cb
    }
->->



