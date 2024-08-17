VAR sleep_hours = 0

=== grind_sleep

= opt

+ + (do)   [Sleep]
    You sleep.
    // To make sure you don't wake up prematurely
    ~ deltastat(sleepiness, 1)
    
    ~ current_activity = sleep
    // sleep broken into two hour stretches, in case alarm interrupts you
    // leaving you still sleepy
    -> ffa(hour, 2) ->
    ~ sleep_hours += 2
    {decstat(sleepiness) == sleepiness.min:-> wake_up}
    -> ffa(hour, 2) ->
    ~ sleep_hours += 2
    {decstat(sleepiness) == sleepiness.min:-> wake_up}
    -> ffa(hour, 2) ->
    ~ sleep_hours += 2
    {decstat(sleepiness) == sleepiness.min:-> wake_up}
    -> ffa(hour, 2) ->
    ~ sleep_hours += 2
    ~deltastat(lust, -2)
    ~decstat(addiction)
    // Must be min by now
    -> wake_up


- - (wake_up)
    You wake up <>
    {sleepiness:
        - sleepiness.min: feeling refreshed
        - sleepiness.low: feeling ok
        - sleepiness.medium:, but you don't think you've had enough sleep
        - sleepiness.high: after a disturbed night
    }<>.
    // Note: Needed to remove it because of edge case of alarm "waking" you after you're asleep
    ~ current_activity -= sleep
-> grind.after_activity


->->
