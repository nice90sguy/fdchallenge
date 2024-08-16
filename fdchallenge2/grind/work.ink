/* -------------------------------------------------------------------------------

*/

VAR available_employers = ()
== function set_available_employers_based_on_confidence_level
{available_employers ? bella_org:
// no choice!
    ~ return
}

{confidence >= confidence.high:
     ~ available_employers += silverman
- else:
    {available_employers ? silverman:You don't feel up to working for the investment bank today.}
     ~ available_employers -= silverman
}
{confidence >= confidence.medium:
     ~ available_employers += food_bank
- else:
    {available_employers ? food_bank:You don't feel up to working for Al today.}
     ~ available_employers -= food_bank
}
{confidence >= confidence.low:
     ~ available_employers += own_project
- else:
    {available_employers ? own_project:You don't even feel up to working on your own stuff today.}
     ~ available_employers -= own_project
}


=== grind_work


= opt
{CHOICE_COUNT()==0:How about if you do|Or possibly, do} {activities_done_today ? work:another|an} hour's work{current_period == morning and (activities_done_today !? breakfast): before breakfast}{current_period > afternoon: even though it's late}...<br><>


+ + (do)[{current_activity==work:Keep working|Work}{employer==bella_org: for {BELLA_NAME}}] ->

    ~ set_available_employers_based_on_confidence_level()
    ~ current_activity = work
     ~ temp pay = 0
    -> select_employer ->
    {employer:
        - ():->grind.after_activity
        - silverman:
            You do an hour or so's work. It's tiring.
            ~ incstat(sleepiness)
            -> ffa(second, 1 * about_an_hour()) ->
            ~ pay = hourly_contract_rate() 
        - food_bank:
            You do a few hours or so's work for Al. It feels good to apply your skills for a good cause.
            ~ incstat(confidence)
            ~ pay = 3 * hourly_contract_rate() 
            -> ffa(second, 3 * about_an_hour()) ->
        - own_project:
            You do a couple of hour's or so's work on that game you've been developing, that you'll never finish...
            ~ incstat(confidence)
            -> ffa(second, 2 * about_an_hour()) ->      
        - bella_org:

            {untagged_videos == ():
                ~ untagged_videos = skipped_videos
                ~ skipped_videos = ()
            }
    
            ~ temp video_ = LIST_RANDOM(untagged_videos)
            
           {video_ != ():
                You look down the list of untagged videos.  This one looks interesting:
                -> tag_a_video(video_) ->
            - else:
                 {hint()} You've tagged all the videos!
                        // Removing  bella_org from  available_employers will allow next call of set_available_employers_based_on_confidence_level() to  return something other than (bella_org) every time!
                         ~ available_employers -= bella_org
            }

    }



   ~ activities_done_today += work

    {pay>0: -> cc.receive(employer_name(), pay, true) ->}


    {tm_hour >= 18: It's after six, time to stop. }
    
    + + + + {tm_hour < 18} [Continue Working] -> do

    + + + + [Stop Work] -> grind.after_activity


/* --------------------------------------------------------------------------------

*/

= select_employer 

// No choice?
{LIST_COUNT(available_employers) == 1:->->}

+ {available_employers ? silverman} [{employer==silverman:Keep working for} Silverman]
    ~ employer = silverman
+ {available_employers ? food_bank} [{employer==food_bank:Keep working for} Al's Food Bank]
    ~ employer = food_bank
+ {available_employers ? own_project} [{employer==own_project:Keep working|Work} on your own project]
    ~ employer = own_project
+ {available_employers ? bella_org} [{employer==bella_org:Keep working for|Work for } {BELLA_NAME}]
    ~ employer = bella_org
-
->->

= grind_work_silverman
->->
=== grind_full_days_work
= opt

    Now, you're <i>really</i> going to get down to a full day's work. {hourly_contract_rate>0:You need the money...}    <><br><>
+ + (do){(silverman, food_bank) ? employer}[Do a Full Day's Work for {employer_name()}] ->

    You down a coffee, switch on your laptop, and start work.
    ~ current_activity = full_days_work


    -> ffa(second, next_hm(18,00)-now()) ->
    ~ incstat(confidence)
    You carry on  working until...
    -> cont ->
    You look at time. Wow, {ampm_hm(tm_hour, 0)} already!
    ~ temp pay = daily_contract_rate()
    {pay>0: -> cc.receive(employer_name(), pay, true) ->}
    -> grind.after_activity

    
->->



