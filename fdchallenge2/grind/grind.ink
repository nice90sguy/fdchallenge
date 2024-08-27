
/*
Daily grind.

After every activity, builds a list of options


*/


=== grind

// Note to dev: Don't check against this list, use the VARS below
// depending on your location
LIST _all_activities = sleep, work, full_days_work, jerk_off,  porn, exercise, breakfast, snack, dinner, takeout, logon_fansite, banking, youtube, introspect, messages, swim, weights, running_machine, running, walking, return_home, socialize


VAR home_activities = ()
~ home_activities = (sleep, work, full_days_work, jerk_off,  porn, exercise, breakfast, snack, dinner, takeout, logon_fansite, banking, youtube, introspect, messages, socialize)

VAR gym_activities = ()
~ gym_activities = (swim, weights, running_machine, messages, return_home)


VAR park_activities = ()
~ park_activities = (running, walking, introspect, return_home)

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


VAR evening_only_activites = (socialize, dinner , takeout)

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
// Where to go after num days has been reached
VAR grind_return_to = ->error



{_DEBUG: >>> Initializing vars and setting up timer callbacks}


// Set initial location to home
~ location = location_home
~ grind_start_day = day_rollover // read-count
~ grind_end_day = grind_start_day + grind_days

~ set_interval_cb(3600,->on_the_hour)
// Set the callback, but not the time yet
~ set_timer_cb(FAR_FUTURE,->grind_messages.taunt)


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

// (Re)init interrupts and alarms which may have been cleared



= day_rollover
{_DEBUG:>>> Day rollover to <b>{today()}, {month_name()} {ord(_day)}}

 ~ activities_done_today = ()
->->

= morning_alarm
{current_activity == sleep:
    {warn()} Your alarm wakes you at {ampm()}.
        -> cont -> grind.build_opts
}
->->

VAR prev_interval = FAR_FUTURE
= on_the_hour
{analog_clk()}
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
    {true:
    {_DEBUG:>>> Clock: {ampm()}}
    }

    // Specific things that happen at certain hours of the day:
    {tm_hour:
        -0:
            -> day_rollover -> update_hunger_sleepiness ->
        -6: -> update_hunger_sleepiness ->
        -7: {current_activity==sleep:-> morning_alarm ->}
        -12: -> update_hunger_sleepiness ->
        -18: -> update_hunger_sleepiness ->
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
            -> grind.build_opts
    }
    // If only one possible activity now, jump to it
    {(LIST_COUNT(possible_activities) == 1) and (possible_activities != current_activity):
        -> opts
    }
    // Randomly taunt some time in the next hour, more often if on sub path
    {path == sub:
        {RANDOM(1, 100) <= 25:
            ~ _next_timer = now() + RANDOM(10,50) * 60
        }
    - else:
        {RANDOM(1, 1000) <= sqi(obedience):
            ~ _next_timer = now() + RANDOM(10,50) * 60
        }
    }

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
~ continue_prompt = true


Final stat ({path} path):
~ temp current_show_stats = SHOW_STATS
~ SHOW_STATS = true
-> stats.display ->
~ SHOW_STATS = current_show_stats
{_DEBUG:>>> RETURN FROM GRIND {grind_return_to}}
->grind_return_to

= build_opts

// Check whether we've reached the end of grind days
{day_rollover >= grind_end_day:->end_grind}


{_DEBUG:>>> LAST_ACTIVITY: {current_activity}}
// Display the location, current time and period of day
<b>Day {day_rollover+1}: <b> {today()}
<b>{location_desc()}.</b><br>{pod_img()}  It's <b>{tm_hour ==0 and tm_min==0:midnight|{ampm()} {period_of_day()==night:at|in the} {period_of_day()}}.

// update current time vars
~ current_period = period_of_day()
~ current_t = now()
{_DEBUG: >>> (REMOVE STAT DISPLAY) ->stats.display->}

// Bella's work proposition, after 4 days, before evening, and she hasn't propositioned you already
{path==adventure and day_rollover>=4 and (current_period < evening) and (not work_proposition_bella):
-> work_proposition_bella -> build_opts
}

~ possible_activities = ()


// ------------------------------------------------------
// initial list of possible activities based on location
{location:
    - location_home:
        ~ possible_activities = home_activities
    - location_gym:
        ~ possible_activities = gym_activities
    - location_park:
        ~ possible_activities = park_activities
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

// No need to jerk off if lust min
{sq(lust) <= low:
    ~ possible_activities -= jerk_off
}

// can't do a full days' except immediately after breakfast
{current_activity != breakfast:

        ~ possible_activities -= full_days_work
-else:
    You already ate breakfast{current_period==morning:, you can now get down to a full day's work!|.}
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
{possible_activities ? socialize:
    {(activities_done_today ? socialize):
        You can't socialize any more.
        ~ possible_activities -= socialize
    }
}
// Prevent working beyond the afternoon
{current_period > afternoon:

    It's too late to work now.
    ~ possible_activities -= (work, full_days_work)

}
// Prevent two consecutive runs
{current_activity == running:
        You can't run anymore.
        ~ possible_activities -= running
}
// prevent two consecutive snacks
{(possible_activities ? snack) and (current_activity ? snack):
    {sq(hunger) < high:
        You can't have another snack now, you're not that hungry!
        ~ possible_activities -= snack
    }

}

// prevent snack immediately after breakfast
{(possible_activities ? snack) and (current_activity == breakfast):
    {sq(hunger) < high:
        You can't have a snack straight after breakfast!
        ~ possible_activities -= snack
    }

}
// If your horniness and addiction is low, and your self-esteem is high, don't allow distraction while working
{(sq(lust) < medium) and (sq(addiction) < high) and (sq(confidence) > medium) and (current_activity ^ (work, full_days_work)) != ():
    ~ possible_activities -= porn
    ~ possible_activities -= logon_fansite

- else:
    {at_computer_activites ?  current_activity:
        While you're at your computer, you could always do a little "surfing"...
    ~ possible_activities += porn
    ~ possible_activities += logon_fansite

    }
}



// sq(Sleepiness) < medium, don't sleep
{sq(sleepiness) < medium:
    // You're not sleepy...
    ~ possible_activities -= sleep

}

// Sleepiness high, unable to work, exercise, go out
{sq(sleepiness) >= high:
    You're too tired to go out, or work...
    ~ possible_activities -= (exercise, work, socialize)

}

// Become introspective if zero confidence
{sq(confidence) == min:
    ~ possible_activities += introspect
    // Can't work if confidence is min
    {possible_activities ^ (work, full_days_work) != ():
            Actually, you just don't even have the motivation to work today...
            ~ possible_activities -= work
            ~ possible_activities -= full_days_work
    }
}

~ temp forced_activities = check_max_stats()
~ possible_activities -= LIST_INVERT(forced_activities)
// Can't do forced activites, need to go home
{possible_activities == ():
    {location != location_home:
        {_DEBUG:>>> Need to go home: None of {forced_activities} available at {location}.}
            ~ location = location_home
            -> grind
    - else:
        ~ possible_activities = forced_activities
        -> opts
    }
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
+ (opts) ->
    ->  build_decision_narrative ->
 + + (do) ->

    {possible_activities ? breakfast: <-grind_breakfast.opt}
    {possible_activities ? full_days_work: <-grind_full_days_work.opt}
    {possible_activities ? work: <-grind_work.opt}
    {possible_activities ? sleep:<- grind_sleep.opt}
    {possible_activities ? youtube: <-grind_youtube.opt}
    {possible_activities ? exercise: <-grind_exercise.opt}
    {possible_activities ? porn: <-grind_porn.opt}
    {possible_activities ? jerk_off: <-grind_jerk_off.opt}
    {possible_activities ? snack: <-grind_snack.opt}
    {possible_activities ? dinner: <-grind_dinner.opt}
    {possible_activities ? socialize: <-grind_bar.opt}
    {possible_activities ? logon_fansite: <-grind_logon_fansite.opt}
    {possible_activities ? banking: <-grind_banking.opt}
    {possible_activities ? introspect: <-grind_introspect.opt}
    {possible_activities ? messages: <-grind_messages.opt}
    {possible_activities ? running: <-grind_park_running.opt}
    {possible_activities ? walking: <-grind_park_walking.opt}
    {possible_activities ? swim: <-grind_gym_swim.opt}
    {possible_activities ? weights: <-grind_gym_weights.opt}
    {possible_activities ? running_machine: <-grind_gym_running_machine.opt}
//  <- opt_esc


-
+ (after_activity) ->
    -> cont ->
   -> grind.build_opts
-
->->

 = build_decision_narrative
 /*
 First of all, look at the max stats, and list the stat-reducing activites for those.
 Then, in no particular order, talk about the high stats, and how to reduce them.
 Then, mention some or all the remaining available activities.

 */

 // Max stats

 // When any of sleepiness, hunger, lust, addiction are maxed, they will be the only option available, so the narrative can end quickly.

 {sq(sleepiness) == max:
    You can hardly keep your eyes open...
    ->->
 }
 {sq(hunger) == max:
    You can't go on until you eat something. Anything.
    ->->
 }
  {sq(lust) == max:
    If you don't stroke that dick now, you'll die...
    ->->
 }
 {sq(addiction) == max:
    You need another fix of {BELLA_NAME}...
    ->->
 }
 // ------------------------------------------------------------------

 You decide what you should do now...
 // Your general (progress) feelings


 // ------------------------------------------------------------------
 // Are you sleepy?
 {sq(sleepiness) >= medium:
 You're feeling{sq(sleepiness) == high: really } {sq(sleepiness) == medium: a little } sleepy{current_period != night:, even though it's still {current_period == evening: a little|way too} early to go to bed}...
 }
<><br><>
 ->->


=== function check_max_stats
// If certain stats have reached max, remove every activity from choice except the ones that reduce those stats. The order is decreasing priority
~ temp tmp_poss_act = possible_activities
{sq(hunger) == max or  sq(lust) == max or sq(sleepiness) == max or sq(addiction) == max:
    ~ tmp_poss_act = ()
    {

    // Hack. Ignore your hunger when you're in the bar
    - sq(hunger) == max and location != location_bar:

        { sq(confidence) > min:
            {
            - possible_activities ? breakfast:
                Gotta have breakfast <i>now.
                ~ tmp_poss_act += breakfast
            - possible_activities ? dinner:
                You need food now.
                ~ tmp_poss_act += dinner
            - else:
                Gotta eat something <i>now.
                ~ tmp_poss_act += snack

            }
         - else:
            // Zero confidence, eating disorder, snack
            ~ tmp_poss_act += snack
        }
        <><br><>
    - sq(lust) == max:
        You need release <i>now.<><br><>
        ~ tmp_poss_act += jerk_off

    // If max sleepiness, you have to sleep
    - sq(sleepiness) == max :
        ~ tmp_poss_act += sleep

    // Over-complex:
    // max addiction and min confidence, not sleeping, and not doing a fansite activity, and evening or night
    - sq(addiction) == max and sq(confidence) == min and current_activity != sleep and (path == adventure) and ("{current_activity}" !? "fsa_" and period_of_day() >= evening):
        ~ tmp_poss_act += logon_fansite

    }
}
{_DEBUG:>>> tmp_poss_act = {tmp_poss_act}}
{tmp_poss_act == ():
    ~ return possible_activities
}
~ return tmp_poss_act












