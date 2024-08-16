=== grind_youtube

= opt
+ + (do) [Watch {current_activity==youtube:more} Youtube] ->
    You watch Youtube videos for far too long.
    ~ current_activity = youtube
    ->ffa(second, 3 * about_an_hour())->
    -> grind.after_activity
    