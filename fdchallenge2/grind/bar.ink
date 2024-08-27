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
    + + + {Angie.first_bar_meeting} [Call Angie]
        {sq(angie_relationship):
            - min:
                You try to call her, but can't get through.
            - low:
                TODO try to make Angie like you
                She doesn't answer, and you leave an apologetic message for your behaviour last time.
                ~ incstat(angie_relationship)
            - medium:
                She answers, and you agree to meet up.
                 ~ people_in_bar += angie
            - high:
                She answer immediately, and sounds really excited to meet up!
                 ~ people_in_bar += angie
            - max:
                -> Angie.yandere -> grind.after_activity
                
        }
    + + + [Just go out on your own]
    - - -
    // Met her on plane but haven't seen her in bar yet? put her in the bar so you can meet her there
    {Angie.plane_meeting and not Angie.first_bar_meeting: 
        ~ people_in_bar += angie
    }
    ~ location = location_bar
    -> bar