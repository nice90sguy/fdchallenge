

LIST bar_activities = ba_with_al, ba_with_angie, ba_regulars, ba_return_home

LIST people_in_bar = angie, al

=== bar
//~ _DEBUG = true
{_DEBUG: ->stats.display->}
{bar == 1:
{hint()} 
TODO bar intro
Welcome to {location_desc()}!
-> cont ->

}
<b>{location_desc()} </b><br>{pod_img()}  It's <b>{tm_hour ==0 and tm_min==0:midnight|{ampm()} {period_of_day()==night:at|in the} {period_of_day()}}.
-> build_opts

 {_DEBUG:>>> END BAR}
->->

= build_opts
{_DEBUG: People in bar: {people_in_bar}}
+ (opts) ->
~ possible_activities = ()

{people_in_bar ? al:
    ~ possible_activities += ba_with_al
}
// Allow bar_with_angie if you met her on plane (adventure path)

{people_in_bar ? angie:
    ~ possible_activities += ba_with_angie
}
// Always allow bar_regulars
~ possible_activities += ba_regulars
// Always allow bar_return_home
~ possible_activities += ba_return_home


 + + (do) ->
 // Note, must be first option b/c of "Go and Talk to her" menu wording
    { possible_activities ? ba_with_angie:
            <- angie_bar.opt
    }
    { possible_activities ? ba_with_al:
            <- bar_with_al.opt
    }

    { possible_activities ? ba_regulars:
            <- bar_regulars.opt
    }
    { possible_activities ? ba_return_home:
            <- bar_return_home.opt
    }
 + + ->
 - -

-
+ (after_activity) ->
   -> bar
-


-> bar
->->

=== bar_with_al
= opt
+ + (do) [Hang out {activities_done_today ? ba_with_al:more } with Al] ->
    You hang out with Al
    ~incstat(confidence)
    ~decstat(addiction)    
    -> ffa(hour, 2) ->
~ activities_done_today += (ba_with_al,socialize)
->bar.after_activity


=== bar_regulars
= opt
+ + (do) [Hang out {activities_done_today ? ba_regulars:more } with the Regulars] ->
    You hang out with the Regulars.
    ~incstat(sleepiness)
    ~incstat(confidence)
    ~decstat(addiction)    
    -> ffa(hour, 2) ->
~ activities_done_today += (ba_regulars,socialize)
->bar.after_activity 

=== bar_return_home
= opt
+ + (do) [Go Home] ->
    You go home.
~ activities_done_today += socialize
// empty the bar
~ people_in_bar = ()
~ location = location_home
->grind.after_activity




->->
