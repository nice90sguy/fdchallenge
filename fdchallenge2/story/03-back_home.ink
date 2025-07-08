/* 
Chapter 3, you arrive back home.

If you're on the adventure path, you subscribe to Bella's fansite, and unlock it.

If you're on the dom path, you will have receieved a missed message from Angie. You read it and decide to play it cool (your response to the message was setup as a callback when Angie sent the message in chapter 2, you won't find your response in this file). Angie may invite you to meet in the cafe. By the time you read this, the game will be in grind (free-roam) mode, and you'll go the cafe, meet her and return (progressing your relationship with her).

If you're on the sub path, your stats will get set so that you're obsessed with her, and, when the grind phase starts, you'll have an option to visit her fan site (at a huge cost). That will set you on the "prisoner" route, where you end up selling your apartment.

This chapter segues into a week's daily grind, after which your stats will determnine what happens in chapter 4.


*/

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
{path==dom and sv(angie_relationship) > low: -> Angie.cafe_meeting_invite ->}
~ _ffh(1)




// Set up taunts
// None for dom path until after Angie progress
{path:
    - sub:

        -> Taunt.reset(LIST_ALL(bella_taunts), 6) ->
    - adventure:
        -> Taunt.reset(LIST_ALL(bella_taunts), 12) ->
}

// Setup the daily grind - 7 days
~ location = location_apartment
-> grind(->until_one_week_has_passed) ->

->->

= slug_shower
You feel better after your shower. You wipe the steam off the mirror with a towel and appraise yourself.  You're getting a little flabby, you really should start exercising.


You're jet-lagged. What time is it anyway? You look at your phone to check the time. It's {approx_time(now())}.


{path==dom: 

-> Angie.first_call_to_angie
}


->->

= sub_path
You arrive home and unpack.  You find your phone in the bottom of your travel case. You plug it in.

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
    
    ~ otr("You wish you could scroll back through the story of your life, back to when she showed you the password...")
    -> password_entry
    - -
-
-> ffa(minute, 10) ->
-> SCENE_START(location_laptop) ->

<i>You look at the screen.   Along the top, three photos of her.   She's' even more stunning in them than you remember.
<i>The first image shows her in an elegant black evening dress, sitting by a fountain in the atrium of a palacial hotel.  She's wearing diamond jewelry, and her hair is up.
<i>The center image shows her on a diving board, in a red skimpy bikini,  against a pure blue sky, about to dive, her back arched gracefully.  Her figure is utterly incredible.
<i>And the last one is... puzzling.  It's a close-up of her hand, her wrist adorned with a diamond bracelet and with diamond and ruby rings on her fingers; she's clutching a bunch of gold and platinum credit cards.  Presumably she's showing off her wealth and success...
<i>Below it, there's a video, its banner image showing her seated at a white desk in a modern-looking office.  She's wearing a dark blue two-piece skirt and flared jacket suit with a smart, business-like white shirt. It looks as though the photographer was on his or her knees to shoot the video, because she seems to be looking slightly down at you.

<i>It's the only clickable item on the page, so you click it...
-> cont ->
Welcome to my private Fan Club  page!
I'm {BELLA_FULL_NAME}.
TODO add name to knowledge
<i>At last, you know her name!
-> cont ->
To become My fan, you need to pass a few tests first.
You've already passed the first one,  which is to know the password to access this page!
That means I already know you, either because you were one of my "super-fans" on my old site, or maybe you're one of the extra-special, lucky people that I've met in real life, who I decided were slaveworthy -- sorry, fanworthy 😈.

<i>"Slaveworthy"??

You might be wondering why I'm so particular about who I allow into My Club.  The reason is simple. It's a matter of economics.  Some people go for the "long tail", and try to amass as many followers as possible.  And that's how I started.  On My original site I  had over 30,000 "fans",  all of whom no doubt adored and worshipped Me.  But I quickly noticed that fewer than one percent of them were actually providing anything more than a few dollars here and there.  And of that less than one percent, only ten percent of those were really worth My while communicating with.  Those are what I call my "super-fans".

So I started again, with my new site, which, instead of allowing anyone to join for free, became a paid subscription site, by invitation only.  Now, I bet you're feeling privileged to be reading this, because, yes, YOU HAVE BEEN INVITED TO BECOME A MEMBER OF MY FAN CLUB!
-> cont ->

<i>Your "scam" alarm goes off. But your curiosity overrides it, and you keep watching. Is it just curiosity, though?  The way she talks is kind of mesmerising, and you want to hear more of it.

I bet you're full of questions now.  "Why should I join?"  "How much is it"?

Well, I can answer the first one for you right now:
You don't have a choice. <i>(She pauses, then laughs)</i>  That's right, it's not up to you, I've decided for you.  Because that's what you need: Someone decisive, someone to help manage your life, and your finances.  You need my help. Let's face it, you're not doing a great job of it right now, are you"? <i>(She laughs.)
-> cont ->
<i>She's... some kind of money management consultant...
<i>Whatever she is, that last sentence of hers strikes a nerve. In fact you think she's some kind of mind-reader.

Now, I want you stand up. Yes, right now.
-> intent.cmd_adhoc("Stand up", low) ->

<i>You're standing up now. You didn't even think to do it.

Good.  Now, say it out loud: "{BELLA_NAME}, I want you to help manage my life."
-> intent.cmd_adhoc("\"{BELLA_NAME}, I want you to help manage my life.\"", low) ->

<i>She pauses and smiles, giving you exactly enough time to reply.  It's like she's there with you in your room, and can hear you.

Good boy.  Now beg me:  Say, "Please {BELLA_NAME}, help me manage my money."

-> intent.cmd_adhoc("\"Please {BELLA_NAME}, help me manage my money.\"", low) ->

Now. Take off your pants, and take out your dick, and grab hold of it.
-> cont ->
<i>What the actual fuck??  Did she she just say that?
-> intent.cmd_adhoc("Do it", medium) ->


{obeyed_cmd:
Don't move your hand yet.
 -> p1e("<i>No, Ma'am... (Damn...)") ->
 Now, start stroking, slowly, and repeat after me: "{BELLA_FULL_NAME} controls my money."

-> p1e("<i>\"{BELLA_FULL_NAME} controls my money.\"") ->
-else:
<i>She laughs and says,</i> "It's okay if you don't want to."
 -> p1e("<i>\"Thank you for your understanding\"") ->
 <>, you say to the screen.
 -> cont ->

}


{obeyed_cmd:"{BELLA_FULL_NAME} controls my bank account."}

{obeyed_cmd:<i>"{BELLA_FULL_NAME} controls my bank account."|->cont->}

"My money belongs to {BELLA_NAME}."

{obeyed_cmd:<i>"My money belongs to {BELLA_NAME}."|->cont->}

{not obeyed_cmd: You don't understand it, you should be completely put off by her blatent attempt to hypnotise you, or whatever she's trying to do, but you're now getting so hard, you find yourself pulling out your dick and stroking. ->cont->}
"Faster now. {BELLA_NAME} controls my dick."

{obeyed_cmd:<i>"{BELLA_NAME} controls my dick..."|->cont->}

"Keep repeating it."

-> p1e("\"{BELLA_NAME} controls my dick...\"") ->
"Faster!"
-> p1e("\"{BELLA_NAME} controls my dick...\"") ->
-> p1e("\"{BELLA_NAME} controls my dick...\"") ->


<i>You cum, and almost pass out.

"{BELLA_NAME} controls me."

<i>"{BELLA_NAME}... controls... me...."

Good!  See how great things are gonna be for you?
-> cont ->

Now, I said at the beginning that you'd have to pass a couple of tests.  Well, that was the first one.  It wasn't so hard was it?

The second and final test is to send me your tribute, sorry, I mean your membership fee.  Click the "Apply Now" button that's about to appear on this page, when this video ends. Good luck!

<i>The video fades to white, and sure enough, a button appears on the page.  You click it.
-> cont ->


-> ffa(minute, 64) ->
Please answer all questions:


<b>Enter your phone \#:
- (loop2)
+ [Enter your number]
    I've sent you a verification code.  Enter it when you receive it.
    + + [Enter the verification code]624433
        Good boy. You're verified. Only two more steps left!
        
        Make sure you have WhatsApp Messaging installed on your phone, it's how I'll send you your pin code, as well as updates, links to my videos and other special treats!
        + + +[ ☑️ I already have WhatsApp]
* [No way am I giving you my number!]
    Field cannot be blank
    -> loop2
-
-> wa.m("Here are My bank details: Name: {BELLA_FULL_NAME} a/c no. 12330001 s/c 01-09-09", WAM_READ) ->
-> wa.m("The membership fee is ${FAN_CLUB_SIGNON_FEE}.", WAM_READ) ->
-> cont ->

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
~ temp args = BELLA
-> M_chat("Whenever you enter My chat room, always greet Me, and always respond to any offline messages I may have left you.  And do it immediately.  That will notify me that you're online.", now(), args, ->null_cb) ->
~ args = BELLA+cmd_yes+cmd_noemit

-> M_chat("Do you understand? Reply 'Yes, {BELLA_NAME}' when you've read this.", now(), args, ->null_cb) ->


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

~ unlocked_fansite = true
-> grind_logon_fansite ->

-> grind(->until_the_first_time_logged_out_of_fansite) ->

// -> grind(1) ->
You log out, and feel like you've just been in an alternate reality.
You look around the room, and shut the laptop lid.
->p1e("Or maybe this is the alternate reality?") ->
Automatically you open up the laptop again and... shut it.  You rub your eyes. It's Jet lag. 
->p1e("Yeah, it's just jet lag.") ->

->->


