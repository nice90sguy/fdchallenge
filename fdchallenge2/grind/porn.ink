=== grind_porn
= opt

~ temp watched_porn = (activities_done_today ? porn)
{sq(lust):
    - max: No {watched_porn:more} porn!
    - high: Maybe watching {watched_porn:more} porn isn't such a good idea right now.
    - medium: You could always look at some {watched_porn:more} porn...{period_of_day() == morning: At this time of day? What are you thinking!}
    - low: How about watching a little {watched_porn:more} adult entertainment? {period_of_day() == morning: Although maybe it's a little early for that...}
    - min: You're feeling slightly bored.
} <><br><>
+ + (do) [Watch {watched_porn:more} porn{watched_porn:!}] ->
    You watch porn.
    ~ current_activity = porn
    ~incstat(lust)
    ~decstat(obedience)
    ~decstat(confidence)
    ->ffa(hour, 2)->
    ~ activities_done_today += porn
    -> grind.after_activity
    