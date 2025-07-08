VAR sleep_hours = 0

=== grind_sleep

= opt

 + (do) [Sleep] 
    You sleep.
    // To make sure you don't wake up prematurely
    ~ deltastat(sleepiness, 2)
    
    ~ current_activity = sleep
    // sleep broken into two hour stretches, in case alarm interrupts you
    // leaving you still sleepy
    -> ffa(hour, 2) ->
    ~ sleep_hours += 2
    {decstat(sleepiness) == min:-> wake_up}
    {__interrupt != "":-> wake_up}    
    -> ffa(hour, 2) ->
    ~ sleep_hours += 2
    {__interrupt != "":-> wake_up}   
    {decstat(sleepiness) == min:-> wake_up}
    -> ffa(hour, 2) ->
    ~ sleep_hours += 2
    {decstat(sleepiness) == min:-> wake_up}
    {__interrupt != "":-> wake_up}   
    -> ffa(hour, 2) ->
    ~ sleep_hours += 2
    ~deltastat(lust, -2)
    ~decstat(addiction)
    // Must be min by now
    -> wake_up


 - (wake_up)
//  >>> INTERRUPT: {__interrupt} TIME: {ampm()}
  {__interrupt:
 
    - "morning_alarm": Your alarm wakes you at {ampm()}.
    
    - "dick_pic_challenge": You grab the phone from the bedside table,  and take a photo of your boner.
        {sv(sleepiness) > min: 
            -> cont -> 
            You try to get back to sleep.
            -> do
        }
    - "taunt":

         {sv(sleepiness) > min: 
            -> cont -> 
            You try to get back to sleep.
            -> do
        }       
    - "":

        You wake up <>
        {sv(sleepiness):
            - min: feeling refreshed
            - low: feeling ok
            - medium:, but you don't think you've had enough sleep
            - high: after a disturbed night
        }<>.
    }
    // Note: Needed to remove it because of edge case of alarm "waking" you after you're asleep
    ~ current_activity -= sleep

->->
