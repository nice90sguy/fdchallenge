=== grind_bar
= opt
Maybe go out for a drink...
<><br><>
+ (do) [Go to the pub] ->

    ~ current_activity = hangout_pub
    ~ people_in_bar = ()
    
    + + [Call Al and see if he wants to meet up]
        "Sure," he says.
        ~ people_in_bar += al
    + + [Just go out on your own]
    
    - -
    You walk briskly to the pub.
    ~ incstat(fitness)
    -> ffa(minute, 30) ->
    ~ location = location_bar
    {do == 1:
    {hint()} 
    TODO bar intro
    Welcome to {location_desc()}!
    -> cont ->
    
    }
    <b>{location_desc()} </b><br>{pod_img()}  It's <b>{tm_hour ==0 and tm_min==0:midnight|{ampm()} {period_of_day()==night:at|in the} {period_of_day()}}.
-
->->

=== grind_bar_with_al
= opt

+ (do) [Hang out {activities_done_today ? ba_with_al:more } with Al] ->
    You hang out with Al
    ~incstat(confidence)
    ~decstat(addiction)    
    -> ffa(hour, 2) ->
~ activities_done_today += (ba_with_al,hangout_pub)
-
->->



=== grind_bar_regulars
= opt
 + (do) [Hang out {activities_done_today ? ba_regulars:more } with the Regulars] ->
    You hang out with the Regulars.
    ~incstat(sleepiness)
    ~incstat(confidence)
    ~decstat(addiction)    
    -> ffa(hour, 2) ->
~ activities_done_today += (ba_regulars,hangout_pub)
-
->->

=== grind_bar_return_home
= opt
+ (do) [Go Home] ->
    You go home.
~ activities_done_today += hangout_pub
// empty the bar
~ people_in_bar = ()
~ location = location_home
-
->->

