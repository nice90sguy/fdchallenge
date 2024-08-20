

LIST bar_activities = ba_with_al, ba_with_angie, ba_regulars, ba_return_home

LIST people_in_bar = angie, al

=== bar
//~ _DEBUG = true
{_DEBUG: ->stats.display->}
{bar == 1:
{hint()} 
TODO bar intro
Welcome to {grind_location_desc()}!
-> cont ->

}
<b>{grind_location_desc()} </b><br>{pod_img()}  It's <b>{tm_hour ==0 and tm_min==0:midnight|{ampm()} {period_of_day()==night:at|in the} {period_of_day()}}.
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

// Introduce Angie if you haven't talked with her in the bar before
{possible_activities ? ba_with_angie and (not bar_with_angie):
    You see a familiar woman. You try to remember where you know her from.
    She's looking at you and smiling!
}
 + + (do) ->
 // Note, must be first option b/c of "Go and Talk to her" menu wording
    { possible_activities ? ba_with_angie:
            <- bar_with_angie.opt
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

=== bar_with_angie

= opt

+ + (do) {(events ? met_angie_in_bar) or opt == 1}[{opt==1:Go and talk to her|Hang out {activities_done_today ? ba_with_angie:more } with {msg_name(ANGIE)}}] ->

// First time you meet her is special
{do == 1:
    Her name's {msg_name(ANGIE)}.  Of course, you sat next to her on the plane!
    ~ events += met_angie_in_bar
    TODO angie meeting, might change below stats
    You have a nice time with her.
    ~ angie_affection = angie_affection.like
    ~deltastat(confidence, 3)
    ~deltastat(addiction, -3) 
    ~deltastat(obedience, -3) 

    -> ffa(hour, 2) ->
    -> bar_return_home
- else:
    You hang out with {msg_name(ANGIE)}
}
    ~incstat(confidence)
    ~decstat(addiction)    
    -> ffa(hour, 2) ->
~ activities_done_today += (ba_with_angie,socialize)
->bar.after_activity

=== bar_regulars
= opt
+ + (do) [Hang out {activities_done_today ? ba_regulars:more } with the Regulars] ->
    You hang out with the Regulars
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
~ grind_location = location_home
->grind.after_activity
