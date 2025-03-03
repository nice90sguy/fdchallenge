=== grind_cafe
= opt
How about getting out of the apartment and going to the cafe...
<><br><>
+ (do) [Go {activities_done_today ? hangout_cafe:back} to the cafe] ->
    ~ current_activity = hangout_cafe

    You take your laptop and charger and head to the cafe.
    ->ffa(minute, 30) ->
    You get there, find a table and plug in your laptop.
    ~ location = location_cafe
    -> grind.after_activity
    
    
=== grind_cafe_coffee
= opt

    
    {sq(sleepiness):
        - min: You're pretty speedy, better not drink {activities_done_today ? coffee:another|any} coffee right now.
        - low: You don't really feel like you need a coffee.
        - medium: Maybe a caffe latte?
        - high: Time for a coffee!
        - max: Gotta have a coffee!
    }
    <><br><>
+  (do) {sq(sleepiness) > min}[Get {activities_done_today ? coffee:another|a} coffee] ->
    You order a {sleepiness > medium:double espresso|caffe latte}.
    -> cc.pay(CAFE_NAME, 5, true) ->
    -> ffa(minute, 15) ->
    ~ current_activity = coffee
    ~ activities_done_today += (coffee)
    ~ decstat(sleepiness)

- 

    -> grind.after_activity

=== grind_cafe_return_home
= opt
+ + (do) [Go Back Home] ->
    You head home.
    ->ffa(minute, 30) ->
~ activities_done_today += hangout_cafe


~ location = location_home
->grind.after_activity
->->
