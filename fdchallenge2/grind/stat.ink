=== grind_stat
= do
    <- display 
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

= display
\----------------------------------------------------<br><>
-> cc.disp_balance ->
Lus: <b>{lust} ({_stat_pc(_flt_lust)}%)</b> Con: <b>{confidence} ({_stat_pc(_flt_confidence)}%)</b> Obe: <b>{obedience} ({_stat_pc(_flt_obedience)}%)</b> Add: <b>{addiction}({_stat_pc(_flt_addiction)}%)</b> Fit: <b>{fitness}({_stat_pc(_flt_fitness)}%)</b> Hun: <b>{hunger} ({_stat_pc(_flt_hunger)}%)</b> Sle: <b>{sleepiness} ({_stat_pc(_flt_sleepiness)}%)</b><br><>
\----------------------------------------------------<br><>
Your last activity: <b>{current_activity:{current_activity}|(none)}</b><br><>
<b>Exercise: </b>{grind_exercise.do}</b> times.<br><>
<b>Fan Site: </b>{grind_fansite.do}</b> times.<br><>
\----------------------------------------------------
->DONE

// Present introspection as a narrative
= narrate
// General health, diet, sleep
\*************
{think()}
// Total number of hours slept / number of days
{grind.day_rollover == 0:
    You haven't slept yet.
- else: 

    ~ temp avg_sleep_hours = sleep_hours / grind.day_rollover
    You're sleeping about {print_number(avg_sleep_hours)} hours a day, which is <>
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
    Your diet <> 
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
        -0: You're keeping {~diligently|} to {~your|a great exercise} {~regime |routine }
        -1: You're doing {~pretty|} well with maintaining your {~fitness |health |exercise {~regime |routine }}
        - else:
            ~ good_exercise = false
            You're not keeping up {ex_days_missed > 2:at all|very} well with your daily {~work-outs |exercise }
    }
    <>
    {fitness:
        - fitness.max: 
            {good_exercise:and it's paying off. Your vital signs are great|but {?against the odds|} it's not affecting your health at all, which is perfect}
        - fitness.high: 
            {good_exercise:and it's keeping you in good health.|but your health isn't suffering}
       - fitness.medium: 
            {good_exercise:which is keeping you reasonably fit|and your health could improve}
       - fitness.low: 
            {good_exercise:but you still need to improve your lifestyle; you're pretty unhealthy|and your health has suffered}
       - fitness.min: 
            {good_exercise:but to no avail. You're not at all healthy|and your health has suffered a lot because of it}
    }
    <>.
{think()}
    // Addiction/Submissiveness/Self Esteem
    {addiction:
        - addiction.max: 
            But none of that matters to you.  You're spending every waking hour thinking about... Her...
        - addiction.high: 
            But to be honest, your physical state isn't the issue: You're addicted to her, and you know that sooner or later, there'll be no escape
       - addiction.medium: 
            You're spending far too much time obsessing over {BELLA_NAME}
       - addiction.low: 
            You're not addicted to {BELLA_NAME} yet, but you can feel her pull. You need to stay focused on your life
       - addiction.min: 
            You think about {BELLA_NAME} often, but you haven't let her get to you
    }
    <> 
    {
        - confidence >= confidence.high:
            ; {addiction < addiction.medium:and|yet somehow} you're feeling supremely self-confident! Maybe she's done this to you
        - confidence < confidence.medium:
            . You don't think you can cope without Her in your life
    }
    <>
    
    {obedience:
        - obedience.max: 
            . You have no choice; you have no will. It's like she said, it's not up to you anymore
        - obedience.high: 
            . You just need to keeping on doing what she tells you, and you'll be fine
       - obedience.medium: 
            . You need to obey {BELLA_NAME}
       - obedience.low: 
            , but at least you're managing to resist her
       - obedience.min: 
            , but you're still in charge of your own decisions
    } <>!
    
 \*************   
->DONE