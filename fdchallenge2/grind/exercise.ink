
// Need this var, because grind_exercise.do count also includes the times you changed your mind!
VAR num_times_actually_did_exercise = 0
=== grind_exercise
= opt
{current_period:
    - night: It's a bit late to go out for exercise.
    - else:
        {fitness:
            - min: You've become really unfit. Maybe today's the day you should try to get back in shape...
            - low: You're not really taking care of your body enough. A bit of exercise would do you good!
            - medium: You're starting to do well with your exercise regimen. You should keep it up!
            - high:It's <>
            {current_period:
             - morning:a perfect
             - evening:getting late, but there's still
             - afternoon:not a bad
             } <> time to exercise.
            - max: Gotta work out, you need those endorphins!
            }
}<><br><>
+  (do) [Exercise] ->
    Time for some exercise!
     ~ temp prev_activity = current_activity // in case you change your mind
    ~ current_activity = exercise
    + + {current_period != night} [Park]
        You head out to the park for some fresh air.
        ~ location = location_park
        ~ num_times_actually_did_exercise++
        
    + + {current_period != night} [Gym]
        You head to the gym.
        ~ location = location_gym 
        ~ num_times_actually_did_exercise++

    + + [{current_period != night:Change your mind and go home|Shit, is that the time??}]
        You change your mind and go back to your apartment.
         ~ location = location_home
         ~ current_activity = prev_activity
    - -
-
    
    -> grind.after_activity
    
=== grind_park_running
= opt
    How about a run?<><br><>
+  (do) {current_period != night} [Go for a run] ->
    You go for a 10K run around the park.  You see trees and people.
    You feel a lot fitter after that.

    ~ current_activity = running
    -> ffa(hour, 1) ->
    -> cont ->
    You get home<> ->later(false) ->
    <>.
    ~ activities_done_today += (exercise,running)
    ~decstat(lust)
    ~ incstat(hunger)
    ~ incstat(confidence)
    ~ deltastat(fitness, 2)
    // bonus for morning exercise
    {current_period == morning:
        ~ incstat(fitness)
    }
    ~ decstat(addiction)
- 
    ~ location = location_home
    -> grind.after_activity

->->

=== grind_park_walking
= opt
    Or maybe just a brisk walk today?<><br><>
+  (do) {current_period != night} [Brisk walk] ->
    You go for a long walk, which clears your mind.
    ~ current_activity = walking
    -> ffa(hour, 2) ->
    -> cont ->
    You get home<> -> later(false) -> 
    <>.
    ~ activities_done_today += (exercise, walking)
    ~decstat(lust)
    ~ incstat(hunger)
    ~ deltastat(confidence, 2)
    ~ incstat(fitness)
    // bonus for morning exercise
    {current_period == morning:
        ~ incstat(fitness)
    }
    ~ decstat(addiction)
- 
    ~ location = location_home
    -> grind.after_activity

->->

=== grind_gym_swim
= opt
    A swim will relax you. The pool doesn't look too full at this time of day.<><br><>
+  (do) {current_period != night} [Swim] ->
    You do forty lengths of the pool.
    ~ current_activity = swim
    -> ffa(hour, 1) ->
    -> cont ->
    // travel home
    -> ffa(minute, 15) ->
    You head out, and get home<> -> later(false) -> 
    <>.
    ~ activities_done_today += (exercise,swim)
    ~decstat(lust)
    ~ incstat(hunger)
    ~ deltastat(confidence, 2)
    ~ incstat(fitness)
    ~ decstat(addiction)
- 
    ~ location = location_home
    -> grind.after_activity

->->

=== grind_gym_weights
= opt
    Let's get your body toned!<><br><>
+  (do) {current_period != night} [Weights] ->
    You try not to focus on the fit bodies around you, while you do some weight training.
    ~ current_activity = weights
    -> ffa(hour, 2) ->
    -> cont ->
    // travel home
    -> ffa(minute, 15) ->
    You head out, and get home<> -> later(false) -> 
    <>.
    ~ activities_done_today += (exercise,weights)
    ~incstat(lust)
    ~ incstat(hunger)
    ~ incstat(confidence)
    ~ incstat(fitness)
    ~ decstat(addiction)
- 

    ~ location = location_home
    -> grind.after_activity

->->

=== grind_gym_running_machine
= opt
    Or a bit of cardio...<><br><>
+  (do) {current_period != night} [Running] ->
    You jog for 1/2 hour on the treadmill.
    ~ current_activity = running_machine
    -> ffa(minute, 30) ->
    -> cont ->
    // travel home
    -> ffa(minute, 15) ->
    You head out, and get home<> -> later(false) -> 
    <>.
    ~ activities_done_today += (exercise,running_machine)
    ~incstat(lust)
    ~ incstat(hunger)
    ~ incstat(confidence)
    ~ incstat(fitness)
    ~ decstat(addiction)
- 

    ~ location = location_home
    -> grind.after_activity

->->
    