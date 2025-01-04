INCLUDE ../lib/format.ink
INCLUDE ../lib/gmtime.ink
INCLUDE ../lib/time.ink
INCLUDE ../lib/utils.ink
INCLUDE ../lib/multiselect.ink

INCLUDE utils.ink
INCLUDE state.ink
INCLUDE stat.ink
INCLUDE bank.ink
INCLUDE haggle.ink
INCLUDE intent.ink
INCLUDE message.ink
INCLUDE whatsapp.ink

INCLUDE grind/grind.ink
INCLUDE grind/exercise.ink

INCLUDE become_my_fan.ink
INCLUDE meeting_bella.ink
INCLUDE back_home.ink
INCLUDE last_night_in_hotel.ink

INCLUDE debug.ink

INCLUDE grind/snack.ink
INCLUDE grind/banking.ink
INCLUDE grind/porn.ink
INCLUDE grind/youtube.ink
INCLUDE grind/jerk_off.ink
INCLUDE grind/fansite.ink
INCLUDE grind/work.ink
INCLUDE grind/sleep.ink
INCLUDE grind/breakfast.ink
INCLUDE grind/bar.ink
INCLUDE grind/cafe.ink

INCLUDE fansite/fansite.ink
INCLUDE fansite/add_credits.ink
INCLUDE fansite/chat.ink
INCLUDE grind/messages.ink
INCLUDE grind/stat.ink
INCLUDE fansite/shop.ink
INCLUDE location.ink
INCLUDE generated/media_items.ink
INCLUDE work.ink
INCLUDE one_week_later.ink
INCLUDE ../lib/list2num.ink
INCLUDE bella.ink
INCLUDE angie.ink
INCLUDE cafe.ink










# author nice90sguy@gmail.com
# theme dark

VAR _DEBUG = false
VAR _LITEROTICA_EXPORT = true

~ SEED_RANDOM(857)
~ SHOW_STATS = false
~ DISPLAY_ANALOG_CLOCK = true

// TESTING
// -> Angie.plane_meeting ->
// -
//      <- grind_bar.opt
 
// + ->
// FOO

// -> END
(Version 0.070)
-> main

== main

*  [Story 😍] 
    {warn()} By committing to play this game, I hereby confirm that:
    + + (T_and_C)->
        * * * [I'm sexually submissive]
        * * * [I will be mindfucked, hypnotised, and manipulated] 
        * * * [My life will be completely controlled by {BELLA_FULL_NAME}]
        * * * [I will be driven to financial ruin] 
        * * * [I will be degraded, humiliated and verbally abused, and will enjoy every minute of it] 
        * * * {CHOICE_COUNT() == 0} ->
        Good boy. I'll hold you to that.
    -> cont ->meeting_bella ->back_home ->one_week_later -> tbc
        - - - -> T_and_C
    - -
    


+ [Options ⚙️]
    + +(opt_stats) [{SHOW_STATS:Hide|Show} Stat Changes]
        ~ SHOW_STATS = not SHOW_STATS
        {SHOW_STATS: 
            {hint()} You'll see changes to your stats as they occur. 
            {opt_stats==1:
                {warn()} This will clutter the output with lots of icons, especially during the grind phase of the game! You might want to play through the game first without this option. The stats are:
                Short-term stats: - Change during the day
                {stat_icon(Sleepiness)} - {stat_name(Sleepiness)} {stat_icon(Hunger)} - {stat_name(Hunger)} {stat_icon(Lust)} - {stat_name(Lust)}

                Long-term stats: - Change over days
                {stat_icon(Fitness)} - {stat_name(Fitness)} {stat_icon(Submissiveness)} - {stat_name(Submissiveness)} {stat_icon(Confidence)} - {stat_name(Confidence)}
                Relationship stats:
                {stat_icon(Addiction)} - {stat_name(Addiction)} {stat_icon(AngieYandere)} - {stat_name(AngieYandere)} {stat_icon(MelanieRelationship)} - {stat_name(MelanieRelationship)}
            }
            
        -else: {hint()} You won't see any stat changes.
        }
    + + (opt_debug){_DEBUG} [Turn {_DEBUG:off|on} debug tracing]
    ~ _DEBUG = not _DEBUG
    {opt_debug==1:{warn()} This will clutter the output with masses of debug trace messages!}
    {hint()} Debugging is now {_DEBUG:on|off}.

    - - -> main



* {_DEBUG}[(🐞DEBUG - Fast-Forward  Game to "Daily Grind"  stage)]  ->
    * * [Sub Path]
        ~ path = sub
    * * [Adventure Path]
        ~ path = adventure
        -> Angie.plane_meeting ->
        ~ unlocked_fansite = true
    - -
    -> cc.deposit(5000) ->
    ~ set_dMy(26,July,2024)
    ~ set_hms(6, 35, 5)

    ~ timestamp_backhome = now()-SECS_DAY
    -> stats.reset(path) ->
    ~ setstat(sleepiness, min)
    ~ current_activity = sleep
    ~ grind_return_to = ->here
    -> fansite_credits.add(1000, 1000) ->
    -> inventory.unlock_item(media_1_, 100) ->
    -> inventory.unlock_item(media_2_, 100) ->    
    ~ grind_days = 7
    -> grind
    + (here) ->
    -
    -> END

== fanlogin
{bella_icon()} The [Fan Login] option is for Fan Club members Only!  <br>Not in My Fan Club yet? You know what to do!

* [I'm already in Your Fan Club, and I know my pin code (Game)]
    ->tbc
* [Huh? What pin code (Story)]
    ->->
-
->->
