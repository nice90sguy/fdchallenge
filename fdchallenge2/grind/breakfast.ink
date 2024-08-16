=== grind_breakfast

= opt

{activities_done_today ? breakfast:\
 {_DEBUG:>>> ASSERT {->opt}: activities_done_today ? breakfast}}

-> why ->
+ + (do) [Eat breakfast]
    ~ current_activity = breakfast
    You eat a delicious breakfast. The coffee perks you up.
    ~ setstat(hunger,hunger.min)
    ~ decstat(sleepiness)
    -> ffa(minute, 30) ->
    ~ activities_done_today += breakfast
- - -> grind.after_activity


= why
You haven't had breakfast yet<>
{
- hunger <= hunger.low: , but you're not really hungry. Still, it's the most important meal of the day.
- hunger < hunger.medium:, not that you're particularly hungry.
- else: , and you're {hunger == hunger.max:desperate to eat something!|{hunger == hunger.high:very|pretty} hungry}.
}
<><br><>
->->


=== grind_dinner

= opt

{activities_done_today ? dinner:\
 {_DEBUG:>>> ASSERT {->opt}: activities_done_today ? dinner}}

LIST meal_type = meal_type_unhealthy, meal_type_healthy
You really ought to eat something{tm_hour >= 21: before it gets too late| now} {hunger < hunger.medium:, even though you're not particulalry hungry}.
<><br><>
+ + (do) [Dinner]
// If fit and high confidence, eat healthy
// If unfit and low confidence, eat unhealthy
// otherwise, flip a coin

    ~ current_activity = dinner
    ~ temp what_to_eat = ()
    {
    - fitness > fitness.medium and confidence > confidence.medium:
        ~ what_to_eat = meal_type_healthy
    - fitness < fitness.medium and confidence < confidence.medium:
        ~ what_to_eat = meal_type_unhealthy
    - else: 
        ~ what_to_eat = LIST_RANDOM((meal_type_unhealthy, meal_type_healthy))
    }
    {what_to_eat:
        - meal_type_healthy:
            { shuffle:
                - You cook {~a lean steak|grilled seabass|chicken|turkey} with {a side salad|boiled potatoes|saffron rice|green beans}.
                - You make {a real Italian pasta Genovese|tuna sushi|a proper Keralan curry with freshly gound spices|jerk chicken, rice and peas|a minestrone|a three egg omelette, with baguette}.
            }
            ~ deltastat(hunger,-3)
            ~ incstat(confidence)
            ~ incstat(fitness)
            -> ffa(minute, 60) ->
        - else:
            { shuffle:
                - Pizza time!
                - One burger won't do today.
            }
            ~ deltastat(hunger,-3)
            ~ decstat(fitness)
            -> ffa(minute, 30) ->            
    }

    ~ activities_done_today += dinner
- - -> grind.after_activity

