INCLUDE ../lib/format.ink
INCLUDE ../lib/gmtime.ink
INCLUDE ../lib/time.ink
INCLUDE ../lib/utils.ink
INCLUDE ../lib/multiselect.ink
INCLUDE ../lib/list2num.ink

INCLUDE debug.ink
INCLUDE utils.ink
INCLUDE state.ink
INCLUDE stat.ink
INCLUDE bank.ink
INCLUDE haggle.ink
INCLUDE intent.ink
INCLUDE message.ink
INCLUDE whatsapp.ink

INCLUDE story/01-last-night-in-hotel.ink
INCLUDE story/02-plane.ink
INCLUDE story/03-back_home.ink
INCLUDE story/04-one_week_later.ink
INCLUDE story/99-endings.ink

INCLUDE grind/grind.ink
INCLUDE grind/exercise.ink
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
INCLUDE grind/angie.ink
INCLUDE grind/messages.ink
INCLUDE grind/stat.ink

INCLUDE fansite/fansite.ink
INCLUDE fansite/add_credits.ink
INCLUDE fansite/chat.ink
INCLUDE fansite/shop.ink

INCLUDE location.ink
INCLUDE generated/media_items.ink
INCLUDE work.ink

INCLUDE bella.ink
INCLUDE angie.ink
INCLUDE cafe.ink
INCLUDE taunt.ink


# author nice90sguy@gmail.com
# theme dark

VAR _DEBUG = false
VAR _LITEROTICA_EXPORT = false

~ SEED_RANDOM(857)
~ SHOW_STATS = false
~ DISPLAY_ANALOG_CLOCK = false
~ continue_prompt = true
// -> TEST
// // TESTING
// // -> ending_ruin.do
// === TEST
// >>> Clock: {ampm()}
// ~ set_interval_cb(3600,->TEST_CB)
// -> ffa(hour, 3)-> 
// >>> Clock: {ampm()}
// ~ set_interval_cb(FAR_FUTURE, ->null_cb)
// -> ffa(hour, 3)-> END
// End test
// // ->TEST


// === TEST_CB

// >>> Clock: {ampm()}
// ->->

/*
    Changelog:
    V.076:
    Added story/ directory and refactored story text/code.  02-plane will develop Angie's storyline in V.077
    
    Added ruin ending.  After remortgaging your flat and moving into to Bella's place, if you go into debt (transcations declined), she kicks you out.
    Many bugfixes:
    * Major refactoring of grind using "thread_in_tunnel" concept. All activities now end with ->DONE for "opt", and ->-> for "do".
    * grind gets called recursively when there's a callback
    * grind is now a proper tunnel, no need for return_to.
    * TODO: Make fansite a tunnel too, still uses (->return_to)
    * Fixed ffa so that extra time is accrued properly when a callback calls ffa recursively
    * Lots of typos
    
*/

(Version 0.076 {_DEBUG: 🐞DEBUG - DO NOT PUBLISH})
-> main

== main

*  [Story 😍] 
    {warn()} By committing to play this game, I hereby confirm that:
    + + (T_and_C)->
        * * * I'm sexually submissive
        * * * I will be mindfucked, hypnotised, and manipulated
        * * * My life will be completely controlled by {BELLA_FULL_NAME}
        * * * I will be driven to financial ruin 
        * * * I will be degraded, humiliated and verbally abused, and will enjoy every minute of it
        * * * {CHOICE_COUNT() == 0} ->
        {bella_icon()} Good boy. I'll hold you to that.
    -> cont -> last_night_in_hotel -> airplane -> back_home -> one_week_later -> tbc
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
                {stat_icon(Addiction)} - {stat_name(Addiction)} {stat_icon(AngieRelationship)} - {stat_name(AngieRelationship)} {stat_icon(MelanieRelationship)} - {stat_name(MelanieRelationship)}
            }
            
        -else: {hint()} You won't see any stat changes.
        }
    + + (opt_analog_time)[{DISPLAY_ANALOG_CLOCK:Hide|Show} Clock]
        ~ DISPLAY_ANALOG_CLOCK = not DISPLAY_ANALOG_CLOCK
        {DISPLAY_ANALOG_CLOCK:
            {hint()} You'll see a clock displaying the current time every hour.
          -else: {hint()} You won't see the clock.
          }
    + + (opt_continue_prompt)[{continue_prompt:Hide|Show} "continue" prompts]
        ~ continue_prompt = not continue_prompt
        {continue_prompt:
            {hint()} The story will pause after paragraphs.
          -else: {hint()} The story will contain fewer prompts (not recommendeded).
          }    
    + + (opt_debug){_DEBUG} [Turn {_DEBUG:off|on} debug tracing]
    ~ _DEBUG = not _DEBUG
    {opt_debug==1:{warn()} This will clutter the output with masses of debug trace messages!}
    {hint()} Debugging is now {_DEBUG:on|off}.
    + + [(Back)] -> main
    - - -> main


-
>>> Error, should not get here!
-> END


->->
