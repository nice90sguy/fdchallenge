VAR _taunt_frequency_hours = 6
VAR _available_taunts = ()

=== Taunt

= reset(taunts, h)
~ _taunt_frequency_hours  = h
// Starts the periodic callback loop
-> _clear -> _do ->

~ _available_taunts = taunts
->->

= add(t)
~ _available_taunts += t
->->

= _clear
~ _available_taunts = ()
->->

= remove(t)
~ _available_taunts -= t
->->

= set_frequency(h)
~ _taunt_frequency_hours = h
->-> 
= _do
// Initialise available taunts first time
{_available_taunts != ():


    ~ temp response_type = WAM_MISS
    {with_phone_activites ? current_activity:
        ~ response_type = WAM_CHOOSE
    }
    // >>> TAUNT at {hhmmss(now())}
    // -> ffa(minute, 3) ->
    // ->->
    // Dont wake from deep sleep
    {current_activity == sleep and sv(sleepiness) >= medium:
        ~ response_type = WAM_MISS
    }

    
    {response_type != WAM_MISS:
    
        {
        - current_activity == sleep:You're woken at {ampm()} by a message:
        
        - (work, full_days_work) ? current_activity:
            ~ response_type = WAM_READ
            Your concentration is ruined at {approx_time(now())} by a message:
        
        - current_activity == swim:
            You've just started changing out of your swimming gear when your phone dings:
        - current_activity == jerk_off:
            She must have hidden cameras!  At the worst possible time, your phone distracts you:
        - state_flags ? gs_with_angie:
            Your phone dings. Angie looks at you quizzically.  You glance at it, then put the phone away quickly.
            "Who was that?" She asks, smiling.
            "Oh, nothing, just work stuff," you say.
        }
    
    }


    {LIST_RANDOM(_available_taunts):
        
        - bella_taunt_send_pic_and_repeat_after_me: ->Bella.do_taunt_send_pic_and_repeat_after_me(response_type) ->
        // - taunt_haggle_game: -> do_taunt_haggle_game(response_type) ->
        - bella_taunt_tribute: -> Bella.do_taunt_tribute(response_type) ->
        - bella_taunt_addiction: -> Bella.do_taunt_addiction(response_type) ->
        - bella_taunt_humiliate: -> Bella.do_taunt_humiliate(response_type) ->
        - bella_taunt_dick_pics: -> Bella.do_taunt_dick_pics(response_type) ->
        - bella_taunt_spend: -> Bella.do_bella_taunt_spend(response_type) ->
        - angie_taunt_fear: -> Angie.do_taunt_fear(response_type) -> 
        
    }
    ~ decstat(confidence)
    {current_activity == sleep and response_type != WAM_MISS:You manage to get back to sleep.}
    
- else:
    {_DEBUG: >>> No taunts availible, rescheduling}
}
// Randomly schedule taunt some time in the future.

{_taunt_frequency_hours >= 0:
    
    
    ~ set_timer_cb(_taunt_frequency_hours * RANDOM(10,50) * 60, ->_do)
//   >>> NEXT TAUNT AT {hhmm(__next_timer)}, One of {_available_taunts}
}
    

->->
