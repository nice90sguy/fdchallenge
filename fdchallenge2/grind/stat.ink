=== grind_stat
= do
   -> stats.display ->
->->
= opt
+ + [Introspect 💭] ->
    You spend a few minutes in contemplation...
    -> ffa(second, about_an_hour() / 3) ->
    ~ decstat(confidence)
    ~ activities_done_today += introspect
    <- narrate 
    + + + {_DEBUG} [🐞 Reset (adventure) ] -> stats.reset(adventure) ->
    + + + {_DEBUG} [🐞 Reset (sub) ] -> stats.reset(sub) -> 
    + + + [Back] -> 
    - - -
- -
-> grind



// Present introspection as a narrative
= narrate
// General health, diet, sleep


// Total number of hours slept / number of days
{grind.day_rollover > 0:

    ~ temp avg_sleep_hours = sleep_hours / grind.day_rollover
    {think()} You're sleeping about {print_number(avg_sleep_hours)} hours a day, which is <>
    {sleep_hours == 8:perfect|{sleep_hours>4:ok|not all that good}} <>. <>
}
// Diet. One dinner and one breakfast is perfect, and not too many snacks.

    ~ temp day_num = grind.day_rollover+1
    ~ temp breakfasts_per_day_pc = 100 *  grind_breakfast.do / day_num
    {day_num==1:
        ~ breakfasts_per_day_pc = 100  // assume ate breakfast
    }
    ~ temp dinners_per_day_pc = 100 * grind_dinner.do / day_num
    {day_num==1:
        ~ dinners_per_day_pc = 100  // assume ate breakfast
    }
    ~ temp snacks_per_day =  grind_snack.do / day_num
   
    ~ temp good_diet = true
    {think()} Your diet <> 
    {
    - dinners_per_day_pc == 100 and breakfasts_per_day_pc  == 100:
        is perfect <>
    - dinners_per_day_pc > 80 and breakfasts_per_day_pc  > 80:
        is pretty good <>
    - else:
        ~ good_diet = false
        could {~do with improvement|be better} <>

    }
    <>

    {
        - snacks_per_day > 2:
            , {good_diet:but|and} you're snacking way too much
        - snacks_per_day > 1:
            , {good_diet:but|and} you're snacking too much
        - else: 
            {good_diet:and|but at least} you're {~keeping your snacking to a minimum|not eating too many snacks}
    }<>. <>
  
    // Fitness and exercise
    ~ temp fit = LIST_VALUE(fitness)
    ~ temp ex_days_missed = day_num - num_times_actually_did_exercise
     ~ temp good_exercise = true
    {ex_days_missed:
        -0: You're keeping {~diligently|} to {~your|a great} {~exercise|fitness} {~regime |routine }
        -1: You're doing {~pretty|} well with maintaining your {~fitness |health |exercise {~regime |routine }}
        - else:
            ~ good_exercise = false
            You're not keeping up {ex_days_missed > 2:at all|very} well with your daily {~work-outs |exercise }
    }
    <>
    {sq(fitness):
        - max: 
            {good_exercise:and it's paying off. Your vital signs are great|but {?against the odds|} it's not affecting your health at all, which is perfect}
        - high: 
            {good_exercise:and it's maintaining your health.|but your health isn't suffering}
       - medium: 
            {good_exercise:which is keeping you reasonably fit|and your health could improve}
       - low: 
            {good_exercise:but you still need to improve your lifestyle; you're pretty unhealthy|and your health has suffered}
       - min: 
            {good_exercise:but to no avail. You're not at all healthy|and your health has suffered a lot because of it}
    }
    <>.
{think()}
    // Addiction/Submissiveness/Self Esteem
    {sq(addiction):
        - max: 
            But none of that matters to you.  You're spending every waking hour thinking about... Her...
        - high: 
            But to be honest, your physical condition isn't the issue: You're addicted to her, and you know that sooner or later, there'll be no escape
       - medium: 
            You're spending too much time obsessing over {BELLA_NAME}
       - low: 
            You're not addicted to {BELLA_NAME} yet, but you can feel her pull. You need to stay focused on your life
       - min: 
            You think about {BELLA_NAME} often, but you haven't let her get to you
    }
    <> 
    {
        - sq(confidence) >= high:
            ; {sq(addiction) < medium:and|yet somehow} you're feeling {sq(confidence) == max:supremely|really} self-confident! Maybe she's done this to you
        - sq(confidence) < medium:
            . You don't think you can cope without Her in your life
    }
    <>
    
    {sq(obedience):
        - max: 
            . You have no choice; you have no will. It's like she said, it's not up to you anymore
        - high: 
            . You just need to keeping on doing what she tells you, and you'll be fine
       - medium: 
            . You need to obey {BELLA_NAME}
       - low: 
            , but at least you're managing to resist her
       - min: 
            , but you're still in charge of your own decisions
    } <>!
    
  
->DONE