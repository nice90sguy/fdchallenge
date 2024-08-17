=== grind_bar
= opt
Maybe go out for a drink...
<><br><>
+ + (do) [Socialize] ->

    ~ current_activity = socialize
    ~ people_in_bar = ()
    
    + + + [Call Al and see if he wants to meet up]
        "Sure," he says.
        ~ people_in_bar += al
    + + + {events ? met_angie_in_bar} [Call Angie]
        {angie_affection:
            - (): >>> Should not be able to meet up with Angie if unknown affection
            - hate:
                You try to call her, but can't get through.
            - dislike:
                TODO try to make Angie like you
                She doesn't answer, and you leeave an apologetic message for your behaviour last time.
                ~ angie_affection++
            - like:
                She answers, and you agree to meet up.
                 ~ people_in_bar += angie
            - love:
                She answer immediately, and sounds really excited to meet up!
                 ~ people_in_bar += angie
                
        }
    + + + [Just go out on your own]
    - - -
    // put her in the bar so you can meet her
    {(events ? met_angie_on_plane) and not (events ? met_angie_in_bar): 
        ~ people_in_bar += angie
    }
    ~ grind_location = location_bar
    -> bar