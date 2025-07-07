=== grind_logon_fansite
= opt
{unlocked_fansite:
You know it's a bad idea, but maybe you could {bella_online():have a "chat" with {BELLA_NAME}, she's probably|see if {BELLA_NAME} might be} online right now... 
}
<><br><>
+  (do) [Fan Login 💳] ->
    {not unlocked_fansite:{warn()} You don't have a pin code for the Fan Site.}
    + +  {not unlocked_fansite} [Beg {BELLA_NAME} for access]
        You send  {BELLA_NAME} a message:
        {M_wa_S(YOU)} Please can I have access to your website Goddess
        You wait for her reply...
        -> cont ->
        -> wa.m("Tribute 10k", WAM_READ + WAM_PAUSE) ->
        -> intent.command_tribute("Tribute 10k", now(), num2list(10000)) ->
        {last_tribute > 0 and TX_RESULT == TX_SUCCESS:
            -> wa.m("Good boy. Again", WAM_READ + WAM_PAUSE) ->
            -> intent.command_tribute("Tribute 10k", now(), num2list(0)) ->
            { last_tribute > 0 and TX_RESULT == TX_SUCCESS:
                -> wa.m("Again", WAM_READ + WAM_PAUSE) ->
                -> intent.command_tribute("Tribute 10k", now(), num2list(0)) ->
                {last_tribute > 0  and TX_RESULT == TX_SUCCESS:
                    -> wa.m("More", WAM_READ + WAM_PAUSE) ->
                    -> intent.command_tribute("Tribute 10k", now(), num2list(0)) ->
                    {last_tribute > 0  and TX_RESULT == TX_SUCCESS:
                    -> wa.m("more", WAM_READ + WAM_PAUSE) ->
                    -> intent.command_tribute("Tribute 10k", now(), num2list(0)) ->
                        {last_tribute > 0  and TX_RESULT == TX_SUCCESS:
                            ~ unlocked_fansite = true
                            -> wa.m("The pin code is 78284. enjoy 💋", WAM_READ + WAM_PAUSE) ->
    
                        }
                    }
                }
            }
        }

    + +  {not unlocked_fansite}[Change your mind]

    + +  ->
         ~ current_activity = logon_fansite
        
        You log on to {BELLA_NAME}'s fan site!
        
        -> fansite ->
   - -
-

->->