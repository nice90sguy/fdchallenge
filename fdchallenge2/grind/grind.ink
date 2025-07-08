
/*
Daily grind.

After every activity, builds a list of options


*/


// Note to dev: Don't check against this list, use the VARS below
// depending on your location
LIST _all_activities = sleep, work, full_days_work, jerk_off,  porn, exercise, breakfast, snack, dinner, takeout, logon_fansite, banking, youtube, introspect, messages, swim, weights, running_machine, running, walking, cafe_return_home, hangout_pub, hangout_cafe, coffee, ba_with_al, ba_regulars, ba_return_home, angie_sex, fsa_add_credits, fsa_chat, fsa_shop, fsa_video_session, fsa_tribute, fsa_goon, fsa_logout

VAR grind_until = ->error

=== grind(->until)
~ grind_until = until



VAR fansite_activities = (fsa_add_credits, fsa_chat, fsa_shop, fsa_video_session, fsa_tribute, fsa_goon, fsa_logout)


VAR bar_activities = ()
~ bar_activities = (ba_with_al, ba_regulars, ba_return_home, jerk_off, snack)

LIST people_in_bar = al

VAR hunger_reducing_activities = (snack, dinner, breakfast)
VAR lust_reducing_activities =  (jerk_off)
VAR max_addiction_activities =  (logon_fansite, banking, messages)
VAR apartment_activities = ()
~ apartment_activities = (sleep, work, full_days_work, jerk_off,  porn, exercise, breakfast, snack, dinner, takeout, logon_fansite, banking, youtube, introspect, messages, hangout_pub, hangout_cafe)

VAR hovel_activities = ()
~ hovel_activities = (sleep, work, jerk_off,  breakfast, snack, dinner, takeout, logon_fansite, banking, youtube, introspect, messages)
VAR gym_activities = ()
~ gym_activities = (swim, weights, running_machine, messages)


VAR park_activities = ()
~ park_activities = (running, walking, introspect, jerk_off)

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


VAR grind_logged_on_to_fansite = false


{_DEBUG:>>> Initializing vars and setting up timer callbacks}
 
VAR prev_interval = FAR_FUTURE
~ prev_interval = FAR_FUTURE
~ set_interval_cb(3600,->on_the_hour)



// {grind}
// ------------------------------------------------------
// First time init and hint


{grind == 1:
{hint()} This mini-game is the "Daily Grind".  As the name suggests, it's a repetitve, real-time simulation of the next 24 hours of your life, hour by hour, minute by f***ing minute...<br><>
    Your choice of activity will alter your stats, and could end up opening, or possibly closing doors to possible futures!<br><>
    Try to stick to a healthy routine, socialize a little too. Don't get too distracted, or spend too much time contempating your navel. Unless you have some kind of self-destructive urge, that is... 😁<br><>
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
        -> grind.build_opts
    }
}
-> DONE 


= day_rollover
{_DEBUG:>>> Day rollover to <b>{today()}, {month_name()} {ord(_day)}}

 ~ activities_done_today = ()
->->





    
= on_the_hour

{num_dick_pics_to_send > 0:
    -> Bella.dick_pic_challenge ->

 - else: 
    {analog_clk()}
}
{prev_interval == FAR_FUTURE:
~ prev_interval = epoch_time - _interval
}
// From now, prev_interval should always be 1 hour less than current time
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
    
    -7: ~ __interrupt = "morning_alarm"
        
    -9: {location == location_hovel:-> Bella.daily_instruction}
    
    -12: -> update_hunger_sleepiness ->
    
    -18: 
        -> update_hunger_sleepiness ->
        ~ __interrupt = "cafe_closing"
        
}

{true or (tm_wday != 0):
    {tm_hour:
    - bella_online_start_hour:
        ~ set_bella_online(true)

    - bella_online_end_hour:
        ~ set_bella_online(false)
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
// ~ continue_prompt = true


Current stats ({path} path):
~ temp current_show_stats = SHOW_STATS
~ SHOW_STATS = true
// \------------------------------------------------------
// grind: {grind}
// build_opts: {build_opts}
// sleep: {grind_sleep}
// on_the_hour: {on_the_hour}
// CALLBACK_STACK: {CALLBACK_STACK}
// day_rollover: {day_rollover}
// \------------------------------------------------------

-> stats.display ->
~ SHOW_STATS = current_show_stats
{_DEBUG:>>> RETURN FROM GRIND}

->->

= build_opts

{CALLBACK_STACK:
    {_DEBUG: Shouldn't build opts in callback! returning. (Stack={CALLBACK_STACK})}
    ->->
}

// Check whether we should exit
{grind_until(): ->end_grind}


{_DEBUG:>>> LAST_ACTIVITY: {current_activity}}
// Display the location, current time and period of day
{grind_logged_on_to_fansite:
    Time: {l0(tm_hour)}:{l0(tm_min)} <> ->fansite.bella_status-> 
    <i> Credits: {credits}
- else:
    <b>Day {day_rollover+1}: <b> {today()}
    <b>{location_desc()}.</b><br>{pod_img()}  It's <b>{tm_hour ==0 and tm_min==0:midnight|{ampm()} {period_of_day()==night:at|in the} {period_of_day()}}.
}

// update current time vars
~ current_period = period_of_day()
~ current_t = now()

// Bella's work proposition, after 4 days, before evening, and she hasn't propositioned you already
{path==adventure and day_rollover>=4 and (current_period < evening) and (not Bella.work_proposition):
-> Bella.work_proposition ->
-> grind.build_opts
}

// Bella's work proposition, after 4 days, before evening, and she hasn't propositioned you already
{Bella.become_her_tenant == 1 and (current_period == afternoon):
// No callbacks while we progress the story
~ enable_callbacks(false)
-> Bella.become_her_tenant ->
~ enable_callbacks(true)
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

// >>> Possible Activities: {possible_activities}

// Deal with max sleepiness first
{sv(sleepiness) == max:
// you can only sleep when you're at home. If you're on the fansite, you need to log out first
        {location != location_home:
            ->p1e("You need to sleep. Go home now!") ->
            ~ location = location_home
        }
        {grind_logged_on_to_fansite:
            ->p1e("You can't keep your eyes open... You log out!") ->
            ~ grind_logged_on_to_fansite = false

        }
        ~ possible_activities = sleep
        -> activity_menu
}
// Deal with max hunger next
{sv(hunger) == max:
// If you can't eat at current location, go home.  If you're on the fansite, you need to log out first


        {grind_logged_on_to_fansite:
            ->p1e("You have to eat now. You log out!") ->
            ~ grind_logged_on_to_fansite = false

        }
        {(possible_activities ^ hunger_reducing_activities) == ():
            ->p1e("You're too hungry. Go home now!") ->
            {location_home:
             - location_apartment:
                ~ possible_activities = apartment_activities
            - location_hovel:
                ~ possible_activities = hovel_activities            
            }
            ~ location = location_home
        }
        // Now, you're either out somewhere you can snack, or at home.
        // If you're at home,  pick the most appropriate way of eating
        {location == location_home:
            {period_of_day():
                - morning:
                    ~ possible_activities = breakfast
                - evening:
                    ~ possible_activities = dinner
                - else:
                    ~ possible_activities = snack
            }
        }
        
        -> activity_menu
}

// Deal with max lust next
{sv(lust) == max:
// If you can't jerk off at current location, go home.  If you're on the fansite, you need to log out first


        {(possible_activities ^ lust_reducing_activities) == ():
            ->p1e("You're too horny... Go home now!") ->
            {location_home:
             - location_apartment:
                ~ possible_activities = apartment_activities
            - location_hovel:
                ~ possible_activities = hovel_activities            
            }
            ~ location = location_home
            
        }
        ~ possible_activities -= LIST_INVERT(lust_reducing_activities)
        -> activity_menu
}

// Deal with max addiction last. Force logon to fansite
{sv(addiction) == max and sv(confidence) == min and current_activity != sleep  and period_of_day() >= evening and (not grind_logged_on_to_fansite):
// If you can't logon to fansite at current location, go home.

        {(possible_activities ^ logon_fansite) == ():
            ->p1e("You need her. Go home now!") ->
           {location_home:
             - location_apartment:
                ~ possible_activities = apartment_activities
            - location_hovel:
                ~ possible_activities = hovel_activities            
            }
            ~ location = location_home
            

            
        }
        ~ possible_activities -= LIST_INVERT(max_addiction_activities)
        -> activity_menu
}

{path==dom and day_rollover==0 and (current_period == morning) and unread_message_count:
    ~ possible_activities = (breakfast, messages)
    -> activity_menu

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
{tm_hour >= 18 or tm_hour < 9:
    {tm_hour < 9:The cafe doesn't open until nine.}
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
    ~ possible_activities += porn
    ~ possible_activities += logon_fansite

    }
}
// Cafe closes at 6
{location == location_cafe and tm_hour >= 18:
    The cafe closes at six.
    ~ possible_activities = cafe_return_home
    -> activity_menu
}


// sv(Sleepiness) < medium, don't sleep
{sv(sleepiness) < medium:
    // You're not sleepy...
    ~ possible_activities -= sleep

}

// Sleepiness high, unable to work, exercise, go out
{sv(sleepiness) >= high and current_activity != sleep:
    You're too tired to go out
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
    {angie_location == location:
        ~ possible_activities += angie_sex
    }
}



// If you're on sub path, and there are unread messages, and you can read them, make that the only option
{path == sub and (possible_activities ? messages) and unread_message_count:
You have to read your messages before anything else.
    ~ possible_activities = messages
    -> activity_menu
}

// If sex with angie is a possible activity, and you haven't ever done it with her,
// Force that activity now
{(possible_activities ? angie_sex) and grind_angie_sex.do == 0:
 >>> {grind_angie_sex.do}
    ~ possible_activities = angie_sex
    -> activity_menu
}

// Always allow logout
~ possible_activities += fsa_logout
// Always allow adding credits
~ possible_activities += fsa_add_credits
// Always allow tribute
~ possible_activities += fsa_tribute
// Always allow shop
~ possible_activities += fsa_shop
// Only allow chat if enough credits
{credits >= cost_per_message:
~ possible_activities += fsa_chat
}

{chat_offline_messages != "":
    {warn()} Bella has sent you chat messages while you were offline!
}

// Bella may have decided that you don't have enough credits, even though
// You have sufficent credits for chatting
{enough_credits:
    ~ enough_credits = (credits >= cost_per_message)
}
{grind_logged_on_to_fansite and not enough_credits:
    ~ otr("You need to get credits if you want to chat with {BELLA_NAME}.")
    ~ possible_activities = (fsa_logout, fsa_add_credits, fsa_chat)
    {path==adventure and not finished_initial_convo:
    ~ possible_activities -= fsa_chat
}
}


{sv(addiction) >= high:
    ~ possible_activities += fsa_goon
}

{path==adventure and not finished_initial_convo:
    ~ possible_activities -= (fsa_logout, fsa_shop, fsa_goon)
}

{grind_logged_on_to_fansite:
    ~ possible_activities -= LIST_INVERT(fansite_activities)
    // >>> LIST_INVERT(fansite_activities): {LIST_INVERT(fansite_activities)}

- else:
    ~ possible_activities -= fansite_activities
}
// >>> Possible Activities: {possible_activities}
{possible_activities == ():
>>> No Possible Activities! 
->END

}
+ (activity_menu) ->
-
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

<- _pa(swim, ->grind_gym_swim)
<- _pa(weights, ->grind_gym_weights)
<- _pa(running_machine, ->grind_gym_running_machine)

<- _pa(ba_with_al, -> grind_bar_with_al)
<- _pa(ba_regulars, -> grind_bar_regulars)
<- _pa(ba_return_home, -> grind_bar_return_home)

<- _pa(fsa_chat, ->fansite_chat)
<- _pa(fsa_goon, ->fansite_goon)
<- _pa(fsa_add_credits, ->fansite_add_credits)
<- _pa(fsa_tribute, ->fansite_tribute)
<- _pa(fsa_shop, ->fansite_shop)
<- _pa(fsa_logout, ->fansite_logout)

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



 // ------------------------------------------------------------------
 // Are you sleepy?
 {sv(sleepiness) >= medium:
 You're feeling{sv(sleepiness) == high: really } {sv(sleepiness) == medium: a little } sleepy{current_period != night:, even though it's still {current_period == evening: a little|way too} early to go to bed}...<><br><>
 }

-> DONE


// Grind termination tests
=== function until_one_week_has_passed
~ return grind.day_rollover >= 7

=== function until_the_first_time_logged_out_of_fansite
~ return fansite_logout != 0 and not grind_logged_on_to_fansite 









