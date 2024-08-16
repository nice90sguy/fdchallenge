=== grind_jerk_off

= opt
~ temp wanked = (activities_done_today ? jerk_off)
{lust:
    - lust.max: If you don't cum now, you'll die...
    - lust.high: You're <i>really</i> horny...
    - lust.medium: You're {current_activity == jerk_off:still} feeling a little {~... on edge|edgy|horny|in need of relief|...antsy}. Maybe you should "take care" of yourself {wanked:again}...?
    - lust.low: Your balls are empty...
    - lust.min: Masturbation? Nah...
}<><br><>
+ + (do) [{~Choke the chicken|Spank the monkey|Flog the dolphin|Beat yourself off|Jack off|Buff the banana|Have a wank|Play with yourself|Toot your horn|Fight the purple helmet warrior|Rub the one-eyed snake|Commit spermicide|Take your turn at the self-serve station|Fish with your zipper trout|Beat the shit out of your midget friend|Make some mayo|Polish the family jewels|Test-fire the old meat missle|Wrap your hand around your penis and move it in a thrusting movement} {wanked:again}] ->
TODO  jerkoff
    You jerk off.
    ~ current_activity = jerk_off
     ~decstat(lust)
    ~ activities_done_today += jerk_off
    ~ incstat(addiction)
    
    ->ffa(minute, 10)->
    -> grind.after_activity
    