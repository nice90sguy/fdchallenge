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
INCLUDE list2string.ink
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

INCLUDE fansite/fansite.ink
INCLUDE fansite/add_credits.ink
INCLUDE fansite/chat.ink
INCLUDE grind/messages.ink
INCLUDE grind/stat.ink
INCLUDE fansite/shop.ink

INCLUDE bar/bar.ink
INCLUDE generated/media_items.ink
INCLUDE work.ink
INCLUDE work_proposition.ink
INCLUDE one_week_later.ink
INCLUDE ../lib/list2num.ink
INCLUDE angie.ink
INCLUDE location.ink




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
(Version 0.052)
-> main

== main
* [Fan Login 💳 ]
    You haven't unlocked this option yet. Become My fan first!
    ->main

* [Become My Fan 😍] Good boy. Let's see if you're worthy...
    -> cont ->meeting_bella ->back_home ->one_week_later -> tbc


+ [Options ⚙️]
    + +(opt_stats) [{SHOW_STATS:Hide|Show} Stat Changes]
        ~ SHOW_STATS = not SHOW_STATS
        {SHOW_STATS: {hint()} You'll see changes to your stats as they occur. {opt_stats==1:{warn()} This will clutter the output with lots of icons, especially during the grind phase of the game! You might want to play through the game first without this option.}|{hint()} You won't see any stat changes.}
    - - -> main

* [I don't want to play your mind games 😁] Ok bye -> END


* {_DEBUG} [(🐞DEBUG - Fast-Forward  Game to "Daily Grind"  stage)]  ->
    * * [Sub Path]
        ~ path = sub
    * * [Adventure Path]
        ~ path = adventure
        -> Angie.plane_meeting ->
    - -
    ~ _DEBUG = false
    -> cc.deposit(1000) ->

    ~ set_dMy(26,July,2024)
    ~ set_hms(6, 35, 5)

    ~ timestamp_backhome = now()-SECS_DAY
    -> stats.reset(path) ->
    ~ setstat(sleepiness, min)
    ~ current_activity = sleep
    -> grind.morning_alarm ->
    -> END

== fanlogin
{bella()} The [Fan Login] option is for Fan Club members Only!  <br>Not in My Fan Club yet? You know what to do!

* [I'm already in Your Fan Club, and I know my pin code (Game)]
    ->tbc
* [Huh? What pin code (Story)]
    ->->
-
->->
