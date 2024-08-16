=== back_home
VAR timestamp_backhome = 0
// Mark the day
~ timestamp_backhome = now()
{_DEBUG:>>> Scatter back home}
// path branch
+ {path == sub} -> J(->sub_path) ->
+ {path == dom} -> J(->dom_path) ->
+ {path == adventure} -> J(->adventure_path) ->
- 
{_DEBUG:>>> Gather back_home}
What you need, you decide, is to forget about her, and start taking care of yourself. You change into your running shorts and shoes, and jog to the supermarket, where you stock up on healthy stuff.
You take a long, hot shower, which relaxes you.


~ _ffd(1)

You go bed without even looking at your phone, and forget all about her.
-> cont ->
    ~setstat(sleepiness, sleepiness.min)
    ~setstat(hunger, hunger.medium)
    ~current_activity = sleep
~ _ffh(7)
    -> grind.morning_alarm


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
TODO back_home dom path
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
-> S("Become My Fan", ->become_my_fan) ->

Woah, that gave you a reality check:
{print_number_c(FAN_CLUB_SIGNON_FEE)} dollars!?

You shut the laptop and stand up.  You notice that your dick is really hard!  You weren't aware that you were so turned on until just now.  It's like your dick is voting "Do it", like in the old cartoons, with the devil and angel on your shoulders.
But you don't seem to have an angel on your other shoulder.  "C'mon, angel, say something, snap me out of this!" you say aloud.
Maybe the angel has nothing to say about this because it agrees with your dick... you should pay up. Stop fighting reality, you know {BELLA_NAME}'s right.  Do what she says; become her "super-fan".  And if you don't, you know what will happen, don't you.  You'll just go on with your stupid, meaningless life. 
And you'll never see her again.
{hint()} This your last chance to choose!
+ [Do it 😈]
 {bella()} As if you had a choice {_emo("(laugh)")} ...
 ~incstat(addiction)
 ~incstat(obedience)
+ [.......... 👼🏻]
    {bella()} You don't have a choice. {_emo("(laugh)")} That's right, it's not up to you, I've decided for you.
-

-> ffa(minute,5) ->
-> cc.pay(BELLA_FULL_NAME, FAN_CLUB_SIGNON_FEE, true) ->
// Bella sends an offline chat message to you.
TODO Make her onboarding message
-> M_chat("Whenever you enter My chat room, always greet Me, and always respond to any offline messages I may have left you.  And do it immediately.  That will notify me that you're online.", now(), ()) ->

-> M_chat("Do you understand? Reply 'Yes, {BELLA_NAME}' when you've read this.", now(), cmd_yes) ->


-> later(true) ->
<> your phone alerts you.
-> ffa(minute, 2) ->
-> wa.m("Good boy", WAM_CONTINUOUS + cmd_increase_addiction) ->
-> wa.m("The pin code to My Fan Site is 78284.", WAM_CONTINUOUS + cmd_increase_addiction) ->
-> wa.m("Logon now, and read my chat message there.", WAM_CONTINUOUS + cmd_increase_addiction) ->
-> wa.m("Respond immediately to it, even if I'm not online.", WAM_READ + cmd_increase_addiction + cmd_do_activity + logon_fansite)

// NOTE: Does not tunnel-on!
