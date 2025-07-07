
/*
Daily grind.

After every activity, builds a list of options


*/

// Where to go after num days has been reached

=== grind(ndays)
~ grind_days = ndays

// Note to dev: Don't check against this list, use the VARS below
// depending on your location
LIST _all_activities = sleep, work, full_days_work, jerk_off,  porn, exercise, breakfast, snack, dinner, takeout, logon_fansite, banking, youtube, introspect, messages, swim, weights, running_machine, running, walking, cafe_return_home, hangout_pub, hangout_cafe, coffee, ba_with_al, ba_regulars, ba_return_home, angie_sex

VAR bar_activities = ()
~ bar_activities = (ba_with_al, ba_regulars, ba_return_home)

LIST people_in_bar = al

VAR apartment_activities = ()
~ apartment_activities = (sleep, work, full_days_work, jerk_off,  porn, exercise, breakfast, snack, dinner, takeout, logon_fansite, banking, youtube, introspect, messages, hangout_pub, hangout_cafe)

VAR hovel_activities = ()
~ hovel_activities = (sleep, work, jerk_off,  breakfast, snack, dinner, takeout, logon_fansite, banking, youtube, introspect, messages)
VAR gym_activities = ()
~ gym_activities = (swim, weights, running_machine, messages)


VAR park_activities = ()
~ park_activities = (running, walking, introspect)

VAR cafe_activities = ()
~ cafe_activities = (coffee, snack, work, logon_fansite, youtube, messages, cafe_return_home)

// Exercise is Fitness, self-esteem improving
VAR exercise_activites = ()
~ exercise_activites = gym_activities + park_activities


// When you have your phone with you
VAR with_phone_activites = ()
// No phone when out in the park
~ with_phone_activites = LIST_ALL(_all_activities) - park_activities

VAR at_computer_activites = (porn, youtube, logon_fansite, work, full_days_work)

VAR morning_only_activites = (breakfast,full_days_work)


VAR afternoon_only_activites = ()


VAR evening_only_activites = (hangout_pub, dinner , takeout)

VAR night_only_activites = (introspect, sleep)

VAR possible_activities = ()
VAR current_activity = ()
VAR activities_done_today = ()

VAR current_period = ()
VAR current_t = 0


//VAR force_grind_activity = false

VAR grind_days = 0
VAR grind_start_day = 0
VAR grind_end_day = 0




{_DEBUG: >>> Initializing vars and setting up timer callbacks}


// Set initial location to home
~ location = location_home
~ grind_start_day = day_rollover // read-count
~ grind_end_day = grind_start_day + grind_days

~ set_interval_cb(3600,->on_the_hour)



// {grind}
// ------------------------------------------------------
// First time init and hint


{grind == 1:
{hint()} This mini-game is the "Daily Grind".  As the name suggests, it's a repetitve, real-time simulation of the next week of your life, day by day, hour by hour, minute by f***ing minute...<br><>
    Your choice of activity will alter your stats, and could end up opening, or possibly closing doors to possible futures!<br><>
    Try to stick to a healthy routine, socialize a little too. Don't get too distracted, or spend too much time contempating your navel. Unless you have some kind of self-destructive urge, that is... 😁<br><>
    Lastly, be patient, good (and bad) things happen to those who wait -- and I promise you, in seven days' time, you'll escape this endless, tedious, <b>Daily Grind...
    -> cont ->
}

-> build_opts

// end init
// ------------------------------------------------------

= _pa(activity_code, ->tunnel_to_run)
{possible_activities ? activity_code: 
    ~ temp entryTurnChoice = TURNS()
    
    -> tunnel_to_run ->
    
    {entryTurnChoice != TURNS():
        -> cont ->
        -> grind.after_loop
    }
}
-> DONE 


= day_rollover
{_DEBUG:>>> Day rollover to <b>{today()}, {month_name()} {ord(_day)}}

 ~ activities_done_today = ()
->->

= morning_alarm
{location == location_apartment and current_activity == sleep:
    {warn()} Your alarm wakes you at {ampm()}.
        -> cont -> 

        -> grind.after_loop
}
->->

VAR prev_interval = FAR_FUTURE

= cafe_closing
    The cafe is closing.
    -> p1("Go Home") -> 
    ~ location = location_home
    ~ _ffm(30)
    -> grind.after_loop
    
= on_the_hour
{num_dick_pics_to_send > 0:
    -> Bella.dick_pic_challenge ->

 - else: 
    {analog_clk()}
}
{prev_interval == FAR_FUTURE:
~ prev_interval = epoch_time - _interval
}
// From now, prev_interval should always be 1 less than current time
{prev_interval != epoch_time - 3600:
    >>> !!! Callback missed: prev_interval != epoch_time - _interval
    -> END
- else:
    ~ prev_interval = epoch_time
}

{_DEBUG:>>> Clock: {ampm()}}
    

// Specific things that happen at certain hours of the day:
{tm_hour:
    -0:
        -> day_rollover -> update_hunger_sleepiness ->
    -6: -> update_hunger_sleepiness ->
    -7: {current_activity==sleep and location == location_apartment:-> morning_alarm ->}
    -9: {location == location_hovel:-> Bella.daily_instruction}
    -12: -> update_hunger_sleepiness ->
    -18: 
        -> update_hunger_sleepiness ->
        {location == location_cafe:
            -> cafe_closing
        }
        
}

{true or (tm_wday != 0):
    {tm_hour:
    - bella_online_start_hour:
        ~ set_bella_online(true)

    - bella_online_end_hour:
        ~ set_bella_online(false)
    }
}

~ temp forced_activities = check_max_stats()

// If you can't do forced activites at your current location, you need to go home and do them there
{(possible_activities ^ forced_activities) == ():
// >>> {possible_activities} {forced_activities}
    { location != location_home:
        {_DEBUG:>>> Need to go home: None of {forced_activities} available at {location}.}
        {location:
            - location_gym:
                You run home as quick as you can, and...
            - location_park:
                You run home as quick as you can, and...
            - location_bar:
                {forced_activities == sleep:You're too tired to socialize anymore.} You say goodbye and leave the bar, and stagger home...
            - else:
                You have to go home now.
        }
    
    }
    -> cont ->

    ~ location = location_home

}
// If only one possible activity now, jump to it

// {(LIST_COUNT(possible_activities) == 1) and (possible_activities != current_activity):
//     -> grind.opts
// }


->->

= update_hunger_sleepiness
 {_DEBUG:>>> 6 Hourly stat change - Update hunger, sleepiness}

// -> tps ->
~ incstat(hunger)

{current_activity != sleep:
    ~ incstat(sleepiness)
}
->->

= end_grind
{_DEBUG:>>> GRIND END DAY REACHED}
~ set_interval_cb(FAR_FUTURE,->error)
// Set the callback, but not the time yet
~ set_timer_cb(FAR_FUTURE,->error)
// ~ continue_prompt = true


Final stat ({path} path):
~ temp current_show_stats = SHOW_STATS
~ SHOW_STATS = true
\------------------------------------------------------
grind: {grind}
after_loop: {after_loop}
build_opts: {build_opts}
morning_alarm: {morning_alarm}
cafe_closing: {cafe_closing}
sleep: {grind_sleep}
on_the_hour: {on_the_hour}
CALLBACK_STACK: {CALLBACK_STACK}
day_rollover: {day_rollover}
\------------------------------------------------------

// -> stats.display ->
~ SHOW_STATS = current_show_stats
{_DEBUG:>>> RETURN FROM GRIND}

->->

= build_opts

{CALLBACK_STACK:
    {_DEBUG: Shouldn't build opts in callback! returning. (Stack={CALLBACK_STACK})}
    ->->
}
// Check whether we've reached the end of grind days
{day_rollover >= grind_end_day: 

->end_grind

}


{_DEBUG:>>> LAST_ACTIVITY: {current_activity}}
// Display the location, current time and period of day
<b>Day {day_rollover+1}: <b> {today()}
<b>{location_desc()}.</b><br>{pod_img()}  It's <b>{tm_hour ==0 and tm_min==0:midnight|{ampm()} {period_of_day()==night:at|in the} {period_of_day()}}.

// update current time vars
~ current_period = period_of_day()
~ current_t = now()
{_DEBUG: >>> (REMOVE STAT DISPLAY) ->stats.display->}

// Bella's work proposition, after 4 days, before evening, and she hasn't propositioned you already
{path==adventure and day_rollover>=4 and (current_period < evening) and (not Bella.work_proposition):
-> Bella.work_proposition ->
-> grind.build_opts
}

~ possible_activities = ()


// ------------------------------------------------------
// initial list of possible activities based on location
{location:
    - location_apartment:
        ~ possible_activities = apartment_activities
    - location_hovel:
        ~ possible_activities = hovel_activities
    - location_gym:
        ~ possible_activities = gym_activities
    - location_park:
        ~ possible_activities = park_activities
    - location_cafe:
          ~ possible_activities = cafe_activities
    - location_bar:
          ~ possible_activities = bar_activities
}

{path==dom and day_rollover==0 and (current_period == morning) and unread_message_count:
    ~ possible_activities = (breakfast, messages)

}

// Can't see Al in bar if he's not there
{location == location_bar and (not (people_in_bar ? al)):
    ~ possible_activities -= ba_with_al
}

// Restrict activites based on time of day
// Some of these may get removed with further checks below, e.g. can't have two breaksfasts in one day

{LIST_INVERT(current_period) ? morning:
    ~ possible_activities -= morning_only_activites
}

{LIST_INVERT(current_period) ? afternoon:
    ~ possible_activities -= afternoon_only_activites
}

{LIST_INVERT(current_period) ? evening:
    ~ possible_activities -= evening_only_activites
}

{LIST_INVERT(current_period) ? night:
    ~ possible_activities -= night_only_activites
}


// If current activity is fansite
// ------------------------------------------------------
// further checks

//
// You can't have a snack straight after breakfast
{current_activity == breakfast:

    ~ possible_activities -= snack
}
// Prevent second breakfast
{activities_done_today ? breakfast:

    ~ possible_activities -= breakfast

}
// Cant go out to cafe until after breakfast
{not (activities_done_today ? breakfast):

    ~ possible_activities -= hangout_cafe

}
// Cafe only open between 9 and 6
{tm_hour > 6 and tm_hour < 9:
    The cafe doesn't open until nine.
    ~ possible_activities -= hangout_cafe

}
{tm_hour >= 18:

    ~ possible_activities -= hangout_cafe

}
// No need to jerk off if lust min
{sv(lust) <= low:
    ~ possible_activities -= jerk_off
}

// can't do a full days' except immediately after breakfast
{current_activity != breakfast:

        ~ possible_activities -= full_days_work
-else:
    {sv(addiction) < max: You already ate breakfast{current_period==morning:, you can now get down to a full day's work!|.}}
}
// Prevent second dinner
{activities_done_today ? dinner:
        You already ate this evening.
    ~ possible_activities -= dinner
}
// Prevent two exercises per day
{possible_activities ? exercise:
    {(activities_done_today ? exercise):
        You already exercised today.
        ~ possible_activities -= exercise
    }
}
// Prevent socializing more than once a day
{possible_activities ? hangout_pub:
    {(activities_done_today ? hangout_pub):
        You can't go back to the pub again.
        ~ possible_activities -= hangout_pub
    }
}
// Prevent working beyond the afternoon
{current_period > afternoon:

    {current_activity != sleep:It's too late to work now.}
    ~ possible_activities -= (work, full_days_work)

}
// Prevent two consecutive runs
{current_activity == running:
        You can't run anymore.
        ~ possible_activities -= running
}
// prevent two consecutive snacks
{(possible_activities ? snack) and (current_activity ? snack):
    {sv(hunger) < high:
        You can't have another snack now, you're not that hungry!
        ~ possible_activities -= snack
    }

}

// prevent snack immediately after breakfast
{(possible_activities ? snack) and (current_activity == breakfast):
    {sv(hunger) < high:
        You can't have a snack straight after breakfast!
        ~ possible_activities -= snack
    }

}
// If your horniness and addiction is low, and your self-esteem is high, don't allow distraction while working
{(sv(lust) < medium) and (sv(addiction) < high) and (sv(confidence) > medium) and (current_activity ^ (work, full_days_work)) != ():
    ~ possible_activities -= porn
    ~ possible_activities -= logon_fansite

- else:
    {at_computer_activites ?  current_activity:
        {current_activity != sleep:While you're at your computer, you could always do a little "surfing"...}
    ~ possible_activities += porn
    ~ possible_activities += logon_fansite

    }
}
// Cafe closes at 6
{location == location_cafe and tm_hour >= 18:
    The cafe closes at six.
    ~ possible_activities = cafe_return_home
}


// sv(Sleepiness) < medium, don't sleep
{sv(sleepiness) < medium:
    // You're not sleepy...
    ~ possible_activities -= sleep

}

// Sleepiness high, unable to work, exercise, go out
{sv(sleepiness) >= high:
    {current_activity != sleep:You're too tired to go out}
    ~ possible_activities -= (exercise, work, hangout_pub, hangout_cafe)
    // Bugfix:  Allow working for Bella
    {available_employers == bella_org:
       <>...
        ~ possible_activities += work
    - else:
        <>, or work...
    }
}

// Become introspective if zero confidence
{sv(confidence) == min:
    ~ possible_activities += introspect
    // Can't work if confidence is min
    {possible_activities ^ (work, full_days_work) != ():
            // Allow work 
            {not (available_employers ? bella_org):
                Actually, you just don't even have the motivation to work today...
                ~ possible_activities -= work
                ~ possible_activities -= full_days_work
            }
    }
}

{path == dom:
    ~ possible_activities -= logon_fansite
    >>> {angie_location} {location}
    {angie_location == location:
        ~ possible_activities += angie_sex
    }
}

~ temp forced_activities = check_max_stats()
~ possible_activities -= LIST_INVERT(forced_activities)
// Can't do forced activites, need to go home
{possible_activities == ():
    {location != location_home:
        {_DEBUG:>>> Need to go home: None of {forced_activities} available at {location}.}
            ~ location = location_home
            -> grind.build_opts
    - else:
        ~ possible_activities = forced_activities
        
    }
}


// If you're on sub path, and there are unread messages, and you can read them, make that the ponly option
{path == sub and (possible_activities ? messages) and unread_message_count:
You have to read your messages before anything else.
    ~ possible_activities = messages
}

// If sex with angie is a possible activity, and you haven't ever done it with her,
// Force that activity now
{(possible_activities ? angie_sex) and grind_angie_sex.do == 0:
 >>> {grind_angie_sex.do}
    ~ possible_activities = angie_sex
}
// Stuck in an endless loop?
// reset your confidence, and start a new regimen from next Monday!
{possible_activities - banking == ():
TODO slug_life_reset
>>> There are no activities you can do. Please report this as a bug.
>>> Resetting your stats.
    // reset confidence, so you can work again
    -> stats.reset(path) ->
    -> ff2DOW(Monday) ->
    ~ set_hm(6,30)
     ~ activities_done_today = ()
    -> cont ->
    -> grind.build_opts
}



{_DEBUG:>>> Possible Activities: {possible_activities}}
<- slug_build_decision_narrative


<- _pa(angie_sex, ->grind_angie_sex)
<- _pa(breakfast, ->grind_breakfast)
<- _pa(full_days_work, ->grind_full_days_work)
<- _pa(work, ->grind_work)
<- _pa(hangout_cafe, ->grind_cafe)
<- _pa(sleep, ->grind_sleep)
<- _pa(youtube, ->grind_youtube)
<- _pa(exercise, ->grind_exercise)

<- _pa(porn, ->grind_porn)
<- _pa(jerk_off, ->grind_jerk_off)
<- _pa(coffee, ->grind_cafe_coffee)
<- _pa(snack, ->grind_snack)
<- _pa(cafe_return_home, ->grind_cafe_return_home)

<- _pa(dinner,  ->grind_dinner)
<- _pa(hangout_pub, ->grind_bar)
<- _pa(logon_fansite, ->grind_logon_fansite)
<- _pa(banking, ->grind_banking)
<- _pa(introspect, ->grind_introspect.opt)
<- _pa(messages,  ->grind_messages)

<- _pa(running, ->grind_park_running)
<- _pa(walking, ->grind_park_walking)

<- _pa( swim, ->grind_gym_swim)
<- _pa(weights, ->grind_gym_weights)
<- _pa(running_machine, ->grind_gym_running_machine)

<- _pa(ba_with_al, -> grind_bar_with_al)
<- _pa(ba_regulars, -> grind_bar_regulars)
<- _pa(ba_return_home, -> grind_bar_return_home)


-> DONE

 = slug_build_decision_narrative
 /*
 First of all, look at the max stats, and list the stat-reducing activites for those.
 Then, in no particular order, talk about the high stats, and how to reduce them.
 Then, mention some or all the remaining available activities.

 */

 // Max stats

 // When any of sleepiness, hunger, lust, addiction are maxed, they will be the only option available, so the narrative can end quickly.

 {sv(sleepiness) == max:
    {current_activity != sleep:You can hardly keep your eyes open...<><br><>}
    -> DONE
 }
 {sv(hunger) == max:
    You can't go on until you eat something. Anything.<><br><>
    -> DONE
 }
  {sv(lust) == max:
    If you don't stroke that dick now, you'll die...<><br><>
    -> DONE
 }
 {sv(addiction) == max:
    You need another fix of {BELLA_NAME}...
    -> DONE
 }
 // ------------------------------------------------------------------

 You decide what you should do now...
 // Your general (progress) feelings


 // ------------------------------------------------------------------
 // Are you sleepy?
 {sv(sleepiness) >= medium:
 You're feeling{sv(sleepiness) == high: really } {sv(sleepiness) == medium: a little } sleepy{current_period != night:, even though it's still {current_period == evening: a little|way too} early to go to bed}...<><br><>
 }

-> DONE

= after_loop
-> build_opts

=== function check_max_stats

// If certain stats have reached max, remove every activity from choice except the ones that reduce those stats. The order is decreasing priority
~ temp tmp_poss_act = possible_activities
{_DEBUG:>>> tmp_poss_act = {tmp_poss_act}}
{sv(hunger) == max or  sv(lust) == max or sv(sleepiness) == max or sv(addiction) == max:

    ~ tmp_poss_act = ()
    {

    // Hack. Ignore your hunger when you're in the bar
    - sv(hunger) == max and location != location_bar:

        { sv(confidence) > min:
            {
            - possible_activities ? breakfast:
                // Gotta have breakfast <i>now.
                ~ tmp_poss_act += breakfast
            - possible_activities ? dinner:
                // You need food now.
                ~ tmp_poss_act += dinner
            - else:
                // Gotta eat something <i>now.
                ~ tmp_poss_act += snack

            }
         - else:
            // Zero confidence, eating disorder, snack
            ~ tmp_poss_act += snack
        }
        <><br><>
    - sv(lust) == max:
        // You need release <i>now.<><br><>
        ~ tmp_poss_act += jerk_off

    // If max sleepiness, you have to sleep
    - sv(sleepiness) == max :
        ~ tmp_poss_act += sleep

    // Over-complex:
    // max addiction and min confidence, not sleeping, and not doing a fansite activity, and evening or night
    - sv(addiction) == max and sv(confidence) == min and current_activity != sleep  and ("{current_activity}" !? "fsa_" and period_of_day() >= evening):
        ~ tmp_poss_act += logon_fansite
        ~ tmp_poss_act += messages
        ~ tmp_poss_act += banking  // added to prevent endless loop, when max addiction but no access to fansite

    }
}
{_DEBUG:>>> tmp_poss_act = {tmp_poss_act}}
{tmp_poss_act == ():
    ~ return possible_activities
}
~ return tmp_poss_act












