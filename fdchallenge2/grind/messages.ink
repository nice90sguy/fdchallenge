=== grind_messages

= opt
You have {unread_message_count:{print_number(unread_message_count)}|no} unread message{unread_message_count!=1:s}.
<><br><>

+ + (do) {unread_message_count}[Read Messages 💬] ->
    // -> message_log.disp ->
    // -> p1("Respond to messages (newest first)") ->
    ~ speech_type = speech_type_wa
    -> wa.read_missed_messages ->
    ->ffa(minute, 10)->
    -> grind.after_activity
    
=== taunt
LIST taunts = taunt_send_pic_and_repeat_after_me,taunt_tribute, taunt_addiction, taunt_humiliate

    ~ temp response_type = WAM_MISS
    {with_phone_activites ? current_activity:
        ~ response_type = WAM_CHOOSE
    }
    // >>> TAUNT at {hhmmss(now())}
    // -> ffa(minute, 3) ->
    // ->->
    // Dont wake from deep sleep
    {current_activity == sleep and sleepiness >= sleepiness.medium:
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
        }
    
    }


    {LIST_RANDOM(LIST_ALL(taunts)):
        {
        - taunt_send_pic_and_repeat_after_me: ->do_taunt_send_pic_and_repeat_after_me(response_type) ->
        // - taunt_haggle_game: -> do_taunt_haggle_game(response_type) ->
        - taunt_tribute: -> do_taunt_tribute(response_type) ->
        - taunt_addiction: -> do_taunt_addiction(response_type) ->
        - taunt_humiliate: -> do_taunt_humiliate(response_type) ->
        }
    }
    ~ decstat(confidence)
    {current_activity == sleep and response_type != WAM_MISS:You manage to get back to sleep.}

->->

= do_taunt_addiction(response_type)
    {response_type ? WAM_READ:
     -> wa.m("{You love me|No escape|Good boy|💋|😈|welcome to My world|your reprogrammed|human atm|good slave|hi slave}", WAM_CONTPAUSE+ cmd_increase_addiction) ->
        You feel an aching desire for her.
        ~incstat(lust)
    }
    

->-> 
= do_taunt_humiliate(response_type)
    {response_type ? WAM_READ:
     -> wa.m("{kneel|jerk to my pics|youre pathetic|kiss my shoes|worship|{~i want to|beg me to|im gonna} {~piss|shit|spit} in your mouth}", WAM_CONTPAUSE+cmd_decrease_confidence + cmd_increase_addiction) ->

        You can't help it, but the message triggers you.
        ~incstat(lust)
         You can't help it, but the message triggers you.
        ~decstat(confidence)       
    }
    

->->        
// Bella sends you a pic, then does "repeat" commands
= do_taunt_send_pic_and_repeat_after_me(response_type)
    
    ~ temp available_photos = search(photo, available_items, match_any)
    
    { available_photos == ():
>>> Bella has no more photos to send!
        ->->
    }
    -> wa.m("💋", response_type + cmd_send_item + LIST_MIN(available_photos) + cmd_increase_lust) ->
    {response_type ? WAM_READ:
        -> wa.m("{How hot?|lol i bet your drooling 🤤|Stare and go dumb|So weak...}", WAM_CONTPAUSE) ->

        -> wa.m("{thank you|I love you|no escape|\{BELLA_NAME\}}", WAM_CONTINUOUS + cmd_repeat_after_me) ->
        {not obeyed_cmd: ->taunt_disobeyed->->}
        -> wa.m("Again.", WAM_CONTINUOUS + cmd_again + cmd_increase_obedience) ->
        {not obeyed_cmd: ->taunt_disobeyed->->}
        -> wa.m("{Good boy. Again|Keep going|repeat 💋}", WAM_CONTINUOUS + cmd_again + cmd_increase_obedience) ->
        {not obeyed_cmd: ->taunt_disobeyed->->}
        -> wa.m("{Again!|more|and again}", WAM_CONTINUOUS + cmd_again) ->
        {not obeyed_cmd: ->taunt_disobeyed->->}
        -> wa.m("{Good boy.|You 😍 me lol}", WAM_CONTPAUSE + cmd_increase_obedience + cmd_increase_lust + cmd_decrease_confidence) ->
        
        ~incstat(lust)
        ~incstat(addiction)
    }


->->
= taunt_disobeyed
-> wa.m("{~Ah sweet, trying to resist 💋|lol You know you can't win|So weak...|Your cock is mine, don't fight it lol|Resistance is fuile lol}", WAM_CONTPAUSE) ->
    ~ decstat(obedience)
    ~ decstat(confidence)
->->

// Bella sends you a pic, then does "repeat" commands
= do_taunt_haggle_game(response_type)
    ~ temp cmd = cmd_haggle_game
    ~ temp v = RANDOM(10,25) * 10
    ~ temp msg = "It's crazy deal time!"

 -> wa.m(msg, response_type + num2trib(v) + cmd) ->
->->

= do_taunt_tribute(response_type)

    ~ temp cmd = cmd_tribute
    ~ temp v = RANDOM(1,2 * LIST_VALUE(obedience)) * 50
    ~ temp msg = "Show me how obedient you are. Send me {v} now"

 -> wa.m(msg, response_type + num2trib(v) + cmd) ->
 ->->
 