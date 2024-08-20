=== one_week_later

// Create an offline message for you to read iff adventure path
-> M_chat("One week later", now(), BELLA) ->

~ grind_location = location_park

// ~ set_timer_cb(FAR_FUTURE-epoch_time,->grind_messages.taunt)
~ff(day,1)
~ff(hour,10)
~ff(minute, 12)
~ set_interval_cb(3600,->on_the_hour)
-> ldtp(grind_location_desc()) ->
<i>One week has passed since you got back from your week in New York...

You're sitting on a bench in your local park, after a half-hour run.  You took your phone with you this time, although you usually leave it at home.  That was a little.. Weird.
Yeah, everything's "weird" since you got back from New York.  No, since before that... since She walked into the bar.  
You're definitily not right - you tap your forehead - <i>up there.

You pick up your phone and look for messages from her.  None.  Maybe you should log on and see if she's left any messages on her chat page...

{hint()} From this point in the game, you can choose to display your stat changes every time they occur, which will give you insight into the result of your choices.
<><br>Do you want to do that now?
   + [Yes]
    Ok, you'll see stat changes from now on.
    ~ SHOW_STATS = true
   + [No]
    Ok, your stat changes will remain hidden.
   -

<i>She's really got to you.  It's not really her, its you, you realize: It's your addictive personality,  which she's tapped into.  
<i>Of course she's unbelievably sexy, and few guys could resist the continual barrage of seduction she's been bombarding you with. And that's how she got to you, of course; but its more than that; she instantly found your weak spot, almost as soon as she met you in the hotel bar; you get turned on every time you send her money. She's <i>sexualized</i> the act of paying her. 
<i>You're a findom addict.  

<i>Even the word turns you on now.

"God, help me."
-> cont ->
{datetime(epoch_time)}
~ speech_type = speech_type_wa
-> wa.m("Hi {YOUR_NAME}",  MELANIE+WAM_READ) ->
You're too shocked by the timing of her message to reply to it.  Could <i>{girlfriend_name}</i> be the only person who can help you now?




-> cont ->

-> tbc

// <-  grind_stat.narrate


{path:
    -adventure:->adventure_choices ->
    -sub:->sub_choices -> 
    -dom:->dom_choices ->
}


= sub_choices
/*
    Bella: Will ruin you, taking more and more, forcing you to sell items
   Melanie wll try to contact you, but you ignore her.
    
*/
->->
= adventure_choices

~ fansite_return_to = ->adventure_choices_after_fansite
-> fansite
= adventure_choices_after_fansite

/*
    Bella: Can leave you alone if addiction isn't too high (don't think you reduce it below high during grind though)
        She will "offer" to take percentage of your income, provided you visit her site daily
        If your self esteem is low, she will "employ" you, meaning you get a subsistence fee. Otherwise, you can choose it.
        
    Angie: If affection is high, you can attempt romance, but it's ruined by her seeing your messages and your confidence is reset to zero, and you go to ruin path (sub)
    
    Melanie:  Will try to hook up with you, and similar outcome as with Angie.
    
*/

TODO adventure choices
->->
= dom_choices
/*
   You try to contact Melanie, but she ignores you.
    
*/
->->
= on_the_hour

{prev_interval == FAR_FUTURE:
~ prev_interval = epoch_time - _interval
}
// From now, prev_interval should always be 1 less than current time
{prev_interval != epoch_time - 3600:
    >>> !!! Callback missed: prev_interval != epoch_time - _interval
    -> END
- else: 
    ~ prev_interval = epoch_time
}

{true:>>> Clock (on_the_hour): {ampm()}}

    
    // Specific things that happen at certain hours of the day:
    // {tm_hour:
    //     -0:
    //         -> day_rollover -> update_hunger_sleepiness ->
    //     -6: -> update_hunger_sleepiness ->
    //     -7: {current_activity==sleep:-> morning_alarm ->}
    //     -12: -> update_hunger_sleepiness ->
    //     -18: -> update_hunger_sleepiness ->
    // }
->->