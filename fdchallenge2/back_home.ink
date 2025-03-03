=== back_home
VAR timestamp_backhome = 0
// Mark the day
~ timestamp_backhome = now()
{_DEBUG:>>> Scatter back home}
// path branch
+ {path == sub} -> sub_path ->
+ {path == dom} -> dom_path ->
+ {path == adventure} -> adventure_path ->
- 
{_DEBUG:>>> Gather back_home}

What you need, you decide, is to forget about {path==dom:women altogether|her}, and start taking care of yourself. You change into your running shorts and shoes, and jog to the supermarket, where you stock up on healthy stuff.
-> ffa(hour, 2) ->
You get home.  What you need now, is a long, hot shower.
-> slug_shower ->



~ _ffd(1)
// ~ SHOW_STATS = true
You go bed without even looking at your phone{path == dom: again|, and forget all about her}.
-> cont ->
    ~setstat(sleepiness, min)
    ~setstat(hunger, medium)
    ~current_activity = sleep
~ _ffh(6)
{path==dom and sq(angie_relationship) > low: -> Angie.cafe_meeting_invite ->}
~ _ffh(1)
~ grind_return_to = ->here


~ grind_days = 7

// Set up taunts
// None for dom path until after Angie progress
{path:
    - sub:
        -> Taunt.reset(LIST_ALL(bella_taunts), 6) ->
    - adventure:
        -> Taunt.reset(LIST_ALL(bella_taunts), 12) ->
}


-> grind
+ (here) ->
-
-> one_week_later

= slug_shower
You feel better after your shower. You wipe the steam off the mirror with a towel and appraise yourself.  You're getting a little flabby, you really should start exercising.


You're jet-lagged. What time is it anyway? You look at your phone to check the time. It's {approx_time(now())}.


{path==dom: 

-> Angie.first_call_to_angie
}


->->

= sub_path
You arrive home, and unpack.  You find your phone in the bottom of your travel case. You plug it in.

You're feeling pretty out of it after the long flight, and before that, the mad dash to catch the plane, and before that... was that real? You're not sure anymore.
You feel both hungry and nauseous at the same time. You're not sure whether you should eat or not.  As soon as you open the door of your fridge, you realise you've got nothing in the place anyway, so that settles it.
You spend the next hour or so going through the pile of post; a couple of bills, but mosty junk.
When you see the bill from your phone company, your stomach lurches.  And it's not because of the amount, which is actually lower than usual because you've been so busy with work the last month.  It's reading the word "Pay" in bill that triggers an sudden urge to pay <i>{BELLA_NAME}</i>.  The urge is so strong that it shocks and scares you.
Something strange has happened to you. You feel -- divorced from reality, and it's more than just the jet-lag and the long-haul flight.  Its definitely Her.
There's been something there, a connection in your subconscious mind, an irrational association between paying and sexual gratification. It's been there for a while, waiting for someone like Her to come along:   She's pressed that trigger, and now you've gone insane.
    
   -> stats.reset(sub) -> 
 

{_DEBUG: >>> unread_message_count=={unread_message_count}}
-> cont ->


->->

= dom_path
Eventually, on {today()} {period_of_day()}, you arrive back home with a neckache and in a crabby mood.  You plug your phone in, and wait for it to charge.
-> stats.reset(dom) -> 
-> ffa(minute, 15) ->
-> tp ->
Fifteen minutes later, it's fully charged.  You check whether you have any messages.  There's one, from an unknown number:
    -> wa.read_missed_messages(true) ->
->->

= adventure_path
Eventually, on {today()} {period_of_day()}, you arrive back home with a neckache and in a crabby mood.  You plug your phone in, and wait for it to charge: You just can't wait to find out who that woman was...
While you're waiting, you try to rationalize the effect she's had on you: You don't know anything about her, not even her name, but you're obsessing over her. Does she do this to every guy she meets?  Get into their heads like that?  Or was there something special between you?
You think you might have a crush on her.
You wonder if she has any ass pics on her website.

-> stats.reset(adventure) -> 
-> ffa(minute, 15) ->
-> tp ->
Your phone has enough charge to turn on now.
You decide to use your laptop instead of your phone to access her fan page.  You carefully copy the url she sent you into the address bar of your browser and get to the page with the two buttons:

- (trylogin)
* [Fan Login 💳 ]
The page is asking you for a "pin code" -- wtf is that supposed to mean?

    You hit the back button and try the other option:
-> cont -> trylogin

+ (password_entry)[Become My Fan 😍]

     - - (enter_password)
    ~ temp guess = ()
    > Enter password:
    -> select(LIST_ALL(become_my_fan_password), guess, "password") ->
    + + {guess == become_my_fan_password} ->
    > Correct.
        
    + + ->
        > Incorrect.
    
    ~ otr("You wish you could scroll back through the story of your life, back to when she told you the password...")
    -> password_entry
    - -
-
-> ffa(minute, 10) ->
-> SCENE(location_laptop, ->become_my_fan) ->

Woah, that gave you a reality check:
{print_number_c(FAN_CLUB_SIGNON_FEE)} dollars!?

You shut the laptop and stand up.  Your post-orgasm bliss fades, and you start to recover your senses.  You're conflicted as to what to do:
-> p1e("{devil_happy()}Just stop fighting the truth about who you are, you know {BELLA_NAME}'s right.  Do what she says; become her \"super-fan\".") ->

-> p1e("{angel()} But she's so obviously trying to scam you!") ->

-> p1e("{devil_happy()}So what? You know what will happen to you if ignore her, don't you?") ->
-> p1e("{devil_happy()} Precisely zip.  You'll just go on with your stupid, meaningless life.") ->
-> p1e("And you'll never see her again.") ->

+ [Do it {devil_happy()}]
 -> p1e("{bella_icon()} As if you had a choice {_emo("(laugh)")} ...") ->
 ~incstat(addiction)
 ~incstat(obedience)
+ [Escape while you still have a chance {angel()}]
    -> p1e("{bella_icon()} Too late. {_emo("(laugh)")} That's right, you never had a choice.") ->
-

-> ffa(minute,5) ->
-> cc.pay(BELLA_FULL_NAME, FAN_CLUB_SIGNON_FEE, true) ->
// Bella sends an offline chat message to you.
TODO Make her onboarding message
-> M_chat("Whenever you enter My chat room, always greet Me, and always respond to any offline messages I may have left you.  And do it immediately.  That will notify me that you're online.", now(), (), ->null_cb) ->

-> M_chat("Do you understand? Reply 'Yes, {BELLA_NAME}' when you've read this.", now(), cmd_yes, ->null_cb) ->


-> later(true) ->
<> your phone alerts you.
-> ffa(minute, 2) ->
~ speech_type = speech_type_wa
-> wa.m("Good boy", WAM_READ + WAM_PAUSE) ->
You can see she's continuing to type...
-> M_B("The pin code to My Fan Site is 78284.") ->
-> M_B("Logon now, and read my chat message there.") ->
-> cont ->
You do as she says.  For some reason your fingers are trembling as you type the pin code...
-> cont ->
-> ffa(second, 30) ->

~ fansite_return_to = ->here1

// Note, not a tunnel, logout will come back here
~ unlocked_fansite = true
-> fansite

+ (here1) ->
-
// Bugfix v. 51
~ fansite_return_to = ->grind.after_activity

->->

