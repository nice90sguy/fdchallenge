INCLUDE ../lib/format.ink
INCLUDE ../lib/gmtime.ink
INCLUDE ../lib/time.ink
INCLUDE ../lib/utils.ink
INCLUDE ../lib/multiselect.ink
INCLUDE ../lib/search.ink

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

INCLUDE fansite/fansite.ink
INCLUDE fansite/add_credits.ink
INCLUDE fansite/chat.ink
INCLUDE grind/messages.ink
INCLUDE grind/stat.ink
INCLUDE fansite/shop.ink

INCLUDE generated/shop_items.ink
INCLUDE work.ink
INCLUDE work_proposition.ink



# author nice90sguy@gmail.com
# theme dark

~ SEED_RANDOM(857)

// TESTING
//-> lookup_media(14, false)-> END
// -> TEST -> END
// === TEST

// ~ set_dMy(26,July,2024)
// ~ set_hms(20, 27, 52)
// -> work_proposition_bella -> END
// ~ set_interval_cb(1800, ->INTERVAL_CB)
// ~ set_timer_cb(43*60, ->PHONE_CALL)
// >> next interval at {hhmm(_next_interval)}
// >> next timer at {hhmm(_next_timer)}
// -> ffa(hour, 4) ->
// -> END
// Define an hourly interval callback
// = INTERVAL_CB
// >> time {ampm()}
// ->->
// Define an event to occur in 43 minutes' time
// = PHONE_CALL
// >> You get a phone call {approx_time(epoch_time)}!
// >> You set a reminder about it for 20 minutes' time.
// ~ set_timer_cb(19*60, ->REMINDER)
// ->->
// = REMINDER
// >> Your reminder goes off {approx_time(epoch_time)}!
// You call back, and have an hour long conversation.
// The time before your conversation is {ampm()}
// -> ffa(second, 3600) ->
// The time after your conversation is {ampm()}
// ->->
// END TESTING

VAR _DEBUG = false
VAR _LITEROTICA_EXPORT = false
(Version 0.036)
-> main

== main
* [Fan Login 💳 ]
    You haven't unlocked this option yet. Become My fan first!
    -> J(->main)

* [Become My Fan 😍] Good boy. Let's see if you're worthy...
    -> cont -> J(->meeting_bella) -> S("Your Apartment", ->back_home) -> tbc


* [I don't want to play your mind games 😁] Ok bye -> END

* {_DEBUG} [(🐞DEBUG - Fast-Forward  Game to "Daily Grind"  stage)]  ->
    * * [Sub Path]
        ~ path = sub
    * * [Adventure Path]
        ~ path = adventure
    - -
    ~ _DEBUG = false
    -> cc.deposit(1000) ->

    ~ set_dMy(26,July,2024)
    ~ set_hms(6, 35, 5)

    ~ timestamp_backhome = now()-SECS_DAY
    -> stats.reset(path) ->
    ~ setstat(sleepiness, sleepiness.min)
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


