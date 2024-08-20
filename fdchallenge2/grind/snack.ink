=== grind_snack
= opt
// don't allow consecutive snacking
{current_activity != snack: 


    {sq(hunger) >= high:
        {fitness:
            - min: You've really need to stop snacking.  It's made you really fat
            - low: You really should cut down on your snacks
            - else: You know snacking's not so healthy
        } <>, but you're just so damn hungry right now.
    }

}
+ + (do){current_activity != snack or sq(confidence) == min} [Eat a snack] ->
    ~ current_activity = snack
    You eat <>
    {
     - sq(confidence) >= high:
        {~a banana|an apple|some peanuts}
     - sq(confidence) == medium:
        {~a cheese sandich|some leftover pasta. You don't bother heating it up}
     - else:
        {~a bag of potato chips|a chocolate bar|two chocolate bars}
        ~ decstat(fitness)
    } <>.
    -> ffa(minute, 15) ->
    ~ decstat(hunger)

    ~ activities_done_today += snack
- -
-> grind.after_activity