===hotel_room_after_bar
~ DVARS()
// You're back in your room (without her if adventure)
{_DEBUG:(Paths Split)}
// path branch
+ {path == sub} -> J(->sub_path) ->
+ {path == dom} -> J(->dom_path) ->
+ {path == adventure} -> J(->adventure_path) ->
- 

->->

= sub_path 
/*
You've met Bella in the bar, and you've exchanged phone numbers.
You've eaten and paid for the Shellfish Platter, and gotton drunk.
She's sent you the url of her site.
She's ripped you off for a meal and you've scanned the QR code to her site

*/
Back in your room, you manage to gather up your clothes and stuff them into your suitcase, ready for your early departure to the airport tomorrow morning.  
->wa.m("Hi", WAM_MISS) ->
You brush your teeth perfunctorily.
-> ffa(minute,10) ->
->wa.m("Hi", WAM_MISS) ->
You flop on the bed.
-> ffa(minute,5) ->
->wa.m("Hey", WAM_READ + WAM_READ_MISSED) ->
You reply:
->M_Y("Hi! sry didn't hear my phone") ->
->wa.m("Did you check my site", WAM_CONTINUOUS) ->
-> wa.r("Not yet sry") ->
<> (Why are you apologizing?)
->wa.m("Why not?", WAM_CONTINUOUS) ->
-> wa.r("tbh I'm pretty drunk lol, was going to bed") -> 
-> ffa(minute, 1) ->
You don't get another message from her.  Is she pissed off with you after that reply?
After a minute, she does respond:
->wa.m("What's your room no", WAM_READ) ->
That takes you by surprise, in fact it wakes you right up.  Is it possible?  Does she want to pay you a visit?
You reply telling her your room number.
->wa.m("I'll be there in 5 minutes.  <br>I want to thank you for paying for me earlier.", WAM_READ) ->
Oh yeah, you remember now:  You paid for her!  You can't wait to see how she's going to "thank" you....

You look around the room, and quickly tidy away your stuff, throwing away the used tissue and candy wrappers from your bedside table.  You run to the bathroom to make sure you look presentable.
You sniff your armpits, and give yourself an extra wash "down there", just in case.

-> ffa(minute, 8) ->
-> laterp(true) ->
->wa.m("Get naked now 😈.", WAM_READ) ->

You don't even think about it:  You tear off your shirt hurriedly, losing a couple of buttons in the process, and push down your pants and underpants, dropping them to the floor, revealing your raging boner.

You reply:
-> wa.r("I'm naked") ->
->wa.m("I'm outside yr door", WAM_CONTINUOUS) ->

You open the door to your room, hiding behind it in case someone in the corridor sees you.

"Hi-" you start to say, but she walks right in without even looking at you.

She stands at the foot of the bed and finally looks at you, with an impatient expression. "Shut the door.  Go lie down on the bed, on your back."
Again, without thinking, you do as she says.  Your dick is ready to burst now. What a way to end the week. And she knows your favourite position, without even asking! You're going to be ridden cowgirl by the hottest woman you've ever seen.

-> cont ->
-> S("Hotel Bedroom", ->hotel_room_after_bar_sub_scene) ->

->->

= dom_path 
TODO back in hotel room dom path
-> tbc

= adventure_path 
/*
You've met Bella in the bar, but you still don't know her name or who she is.
She's ripped you off for a meal and you've scanned the QR code to her site
She's also told you the "password" to her site.
You're pretty obsessed with her already.
Tunnels on to flight back home, becoming her fan.
*/
You throw off your clothes and climb into bed. Your head's spinning when you lay down, so you sit up.  You feel more drunk than you should do after those three whiskeys.  You really should have ordered some food.  Oh yeah, you did...
<i>Damn.  that woman... what a devious bitch...

...but man, so fucking hot.  And not just the way she looked:  The way she spoke to you was so hypnotic.  And when she told you, "Do it!" and you just obeyed, it was like what those ladies did in Dune.  Maybe she's one of them, those, what were the called?  "Bene Gesserit," you say aloud.

...Yeah, you feel drunk, but not so drunk that it's affected your dick.
You pick up your phone, open Safari and find her fan page. It's just a blank page, with a white background, and two buttons: "Fan Login", and "Become My Fan".
You're too damn tired to continue.  Maybe tomorrow.
You turn out the lights, and close your eyes.  You can still see her though, casually painting her shiny lips...  Your hand grabs your dick and you start stroking slowly, and you recall her, her perfume... "Do it", she commands, and you fall to your knees and begin licking her pussy...
...But, yeah, you're damn too tired to continue.  Maybe tomorrow.

As you drift off, you suddenly sit up straight.

"I didn't even find out her name!"


->->

=next_morning

You wake up, look at your phone to check the time.  It's switched off.  You try to turn it on, but it's dead -- you forgot to charge it last night!
You look at the clock by the bed. Holy shit, it's {print_number(tm_hour)} o'clock, and your plane leaves in less than two hours!
Somehow you make it in time, rushing through the airport without a moment to spare. You don't have any time to charge the phone at the airport, but at least they have sockets on the plane, so it'll be charged by the time you land. You settle into your seat. 
->->


= airplane
{path:
- sub:
You can't stop thinking about what happened last night.  You let her take hundreds of dollars from you, for... {sold_ass: kissing her ass|nothing}.  And you didn't care that she teased you{not sold_ass: and tricked you}.  In fact, you liked it!  No, more than that: You wanted her to take more,  to take everything from you. To take over completely.
And it wasn't just because she was so fucking gorgeous-looking.  It was something else.  She made you pay, for her meal, for her fancy drinks, and then she made you pay for the pleasure of -- paying her. And now you're craving to pay her more.
You want to pay her <i>now..
-> J(->slug_airplane_no_phone) ->
Anyway there's no reception up here.  
Wtf? Were you really intending to transfer money to her?? Maybe by the time you land, you'll be over this crazy feeling.
Maybe.
You manage to get a couple of hours sleep, but she's in there in your dreams. There's no escape from her now.    

- adventure:
    A woman sits in the next seat to you.  She's very nice-looking, with a big smile and great legs, which you notice while untangling your seatbelt from hers.  You end up talking with her. Her name's {msg_name(ANGIE)}. She's a recruitmant consultant for an agency you sometimes use.  You watch a couple of inflight movies together, laughing at the same places in the movie.  You're obviously suited, with the same sense of humor; and she wants to exchange numbers. 
    -> J(->slug_airplane_no_phone) -> 
    You get her to write down her number in your notepad, old-school.
    // {hint()} Don't lose that number!
    // -> cont ->
    Before you know it, you've landed.  You've even forgotten all about that woman you met last night.  Until now, when you realise that subconsciously, you've never stopped thinking about her since you first set eyes on her. Who the fuck was she?  And what was her name? You gotta find out as soon as you get home.
- dom:
    TODO airplane dom
}

-> eod ->
// 6 hour flight + 5 hours ahead + 2 hours
-> ffa(hour, 13) ->
-> ffa(minute, 15) ->

->->

= slug_airplane_no_phone
You reach for your phone in your backpack, but it's not there.  Fuck, did you leave it at the hotel? No, you distinctly remember packing it. Oh yeah, you put it in your suitcase which has gone in the hold. <>
->->

= hotel_room_after_bar_sub_scene
-> ffa(minute, 30) ->
She undoes the button of her jeans and pulls down the zipper, keeping her eyes fixed on you.  "That's right," she says, keep watching."
You see her black lace panties as she pushes the top of her jeans down a few inches. 
"Stroke your dick.  Slowly," she says.  You grasp your dick and start stroking.

She comes closer to you, around the side of the bed, and pushes the top of her jeans down further.  She rubs her pussy through her panties lightly with her middle finger.  You watch, mesmerised.  Her shiny red fingernails...
"Slower, {YOUR_NAME}."

She kneels and bends over you, her face inches from yours, shrouding you in her shadow, and her perfume.  She's going to kiss you, with those incredible lips...
~ incstat(lust)
-> cont ->

"Tell me why I'm here,  {YOUR_NAME}," she whispers.

You're barely able to speak: 

+ [To thank me for the meal] "T-To thank me for the meal,"
+ [I don't know] "I- I don't know,"
    ~ decstat(confidence)
-
<> you gasp.

"I'm here to <i>help</i> you, {YOUR_NAME}.  Poor, poor {YOUR_NAME}..."

She stands up quickly and does up her jeans.

Your hand leaves your cock.

"I didn't tell you to stop stroking. Keep going." She says it quietly, but to you it's an incontrovertible command.  You do as she says.

"If you'd looked at my site, you would know why I'm here.  You see, my site is all about helping people with your problem."

"My... problem?"

"Yes.  You have a real problem with money.  Don't you?"

You can't believe it: She knows you.  She's right.  Or did you tell her about you and {girlfriend_name} earlier, and why you broke up? 

"Yes. Yes I do," you say.

"Tell me. You made, let's see: {print_number(daily_contract_rate() * 5)} this week. Right?

"Right!" <i>(I must have told her that, but I don't remember. What else did I say??)

"And you were probably just going to blow it on something stupid. Like, I dunno..."

"A Macbook Pro," you say.

"Like a Macbook Pro. Or an overpriced meal you didn't even want, and two bottles of Champagne."

"Yes... But {BELLA_NAME}, I thought-"

"Shh.  Just listen.  And keep stroking."

+ [Keep stroking] You stroke your dick, while she continues talking to you gently:
~ incstat(lust)
-
"It's a common problem. Actually, it's more than just a problem with some people, it's almost a disease, this lack of control over  money.The good news, is that that there's a cure..."

She picks up your phone from the bedside table.

"It's locked," she says.  

You tell her the passcode to your phone; she didn't need to  explicitly tell you to do it.

"Good boy", she murmurs.  "Stroke faster.  Not too fast."

You keep stroking, getting closer to the edge, while she swipes and taps at your phone.

"Tch, Tch. Oh dear," she says.

"I'm going through your recent credit card transactions.  You really aren't managing your finances very well at all..."

"N-No..."

"Look at this: ${bar_bill} for the meal tonight.  You really need to be much more careful with your money."

"And, when we go back through the transactions, we see the same pattern, don't we:  Meals out here and there, wasting money on silly toys, subscriptions,  expensive DIY tools you probably use only once...  And what's this?  A payment of £60 to a... florist?"

"I-"

"<i>Hands off your dick.</i> Was that for your girfriend?"

You let go of your bursting cock and tell her about your fight with {girlfriend_name}.

She laughs and says, "See, I'm not the only one who thinks so.  You're so lucky we met."

She puts the phone back on the bedside table, and then climbs onto the bed and over you so she's straddling your waist. She strokes your chest with a fingernail. Even though your hand is no longer on your dick, you feel like you're going to cum any second.
She picks up the phone again, and types into it.

"There, I've set up a new payee. Me."

She looks down at you. She's waiting for you to respond.

"Thank me."

+ [Thank you] "Thank you," you say quietly.
~ incstat(obedience)
-
"Good boy." She pats your cheek affectionately.


You wonder if she's going to get up off you now, and let you "finish yourself off". But you're kind of hoping she won't.  Your eyes flutter closed... You feel like you've totally lost any sense of reality... maybe this is all a dream, and you'll wake up and find that you've - 
-> ffa(minute, 15) ->
<b> -- Wake up --

\- Startled, you open your eyes wide. 
"Wake up, {YOUR_NAME}.  Pay attention."

She's sitting on the sofa now, one leg crossed over the other, still with your phone in her hand.  How long were you asleep?

-> cont ->

You don't know if she's just starting speaking to you, or whether you've missed what she's been saying for however long you blanked out for. You prop yourself up on one elbow at look at her.  It looks like the fun is over, and she's begun some fucking lecture, because she's saying,  "Now, the first way I'm going to help you is this:  I'm going to make you learn the difference between <i>value</i>, and <i>price</i>."

"If the price of something is <i>higher</i> than its value, that's a <i>ripoff</i>."

She pauses.
+ [Nod]
    ~ incstat(obedience)
-
"If the price is <i>lower</i> than its value, that's a <i>bargain</i>."

+ [Nod again -- She's so smart]
    ~ incstat(obedience)
-

"Okay, now, how do we figure out the value in the first place?  By working out what we're prepared to pay."

"So, let's take a simple example:"


+ [Look keen and attentive and ready to take notes]
    ~ incstat(obedience)
-

"How much would you be willing to pay to get back together with your ex?"

"You mean, {girlfriend_name}? Right now? I don't know.."

"Ballpark figure."

"Right now, I don't want to get back with her. Not since you, since I..."

"- Good. So, spending sixty pounds on some flowers for her would be a...?"

- (try_again)
* ["Bargain."] -> try_again
* "Ripoff."
-
"Right. Now, let's try a harder one," she says.  

She stands up, and undresses slowly, down to her black lace underwear.  Not that her figure was hidden before, but now you see her perfectly toned body in all its glory.


"Yes, a much harder one," she smiles, watching your boner grow.

"I feel a little short without my heels," she says, half to herself, although she looks to be at least five feet seven in her bare feet.  She puts her heels back on.

She turns around, showing her beatiful ass.  She strokes it, and asks you,

"You like my ass, don't you?"

+ [Nod]
-

She points to the floor just behind her and says, "Come over here, and get on your hands and knees."

+ [Obey] ->
    Instantly, you roll off the bed onto the floor and crawl over to her. You look up at her perfect ass.  You're panting like a dog.  The more you look at it, the more it weakens you, makes you more desperate, longing to just let her ass smother you, trap you beween those round cheeks, until you surrender completely, spending the rest of your life beneath those overwhelming-- 
-

"-Now, how much are you going to pay me to kiss this ass? It had better be enough!"

You look up and see that she's holding your phone.

"Yeah, that's right, put your money where your mouth is -- or rather, where you want it to be!" She laughs.
-> ffa(minute, 30) ->
"I-"
-> haggling
= haggling
~ temp reserve = 200
~ temp starting_bid = 50
-> haggle("my ass", reserve, starting_bid) ->

+  {HAGGLE_RESULT == RESERVE_NOT_REACHED} ->

    "You really have no idea of the value of a dollar, do you?" She says, looking down at you with pity.
    "Tell you what, as it's your first time playing..."
    She taps on your phone, and your hear it make a "Ding!" sound...
    -> cc.receive(BELLA_FULL_NAME, HAGGLE_LAST_BID, true) ->
    "Try again. And don't be a cheapskate this time."
    ~ reserve += 50
    ~ starting_bid = starting_bid + 50
    -> haggle("my amazing ass", reserve, starting_bid) ->
    + + {HAGGLE_RESULT == RESERVE_NOT_REACHED} ->
    -> cc.pay(BELLA_FULL_NAME, 100, false) ->
    "Looks like you still have a lot to learn. Here's your first lesson:"
    She taps on your phone angrily, then throws it on the sofa. She pulls off her heels, puts her jeans and tee shirt back on, and slides her feet into her shoes quickly, and walks out.
    You stand up and walk over to the wardrobe mirror and look at your boner, which is still pulsing hopefully.
    "Shut up," you say to it.
    
    -> cont ->
    You go back to bed.  Within minutes you're asleep...
    + + {HAGGLE_RESULT == SOLD} ->
    ~ incstat(obedience)
    "<i>Now</i> you're getting it," she says.
    -> sold_ass
    + + ->
    - - 
    
+ (sold_ass) {HAGGLE_RESULT == SOLD} ->
    "Good Boy. My ass is definitely worth {print_number(HAGGLE_LAST_BID)} dollars."

    -> slug_ass_kissing ->

-
-> ffa(hour, 1) ->
-> dtp ->
-> wa.m("Thanks for a wonderful evening lol", WAM_MISS) ->
-> ffa(minute, 5) ->

~ temp long_message = "\
You're probably asleep now.  When you wake up you'll realize that \
you can't survive without me.  I've already taken over your mind, your will, and your wallet.\
I own you now, completely.  You know it.  Every minute of the day you'll think of Me now.  No woman \
will ever come close to me. xxx \
"
-> wa.m(long_message, WAM_MISS) ->
-> ffa(minute,5) ->

~ long_message = "I'm now in charge of your finances.  You will be much happier this way.\
I will control when, and how much you spend on everything. Everything you earn, everything you own, it all belongs to me."
-> wa.m(long_message, WAM_MISS) ->

~ long_message = "You will send money, buy me gifts\
whenever I demand it, and do it immediately. \
Start your new life now, by replying \"Yes {BELLA_NAME} \" to this message, and transferring $100 to me "
//  {_DEBUG:>>> TESTING, changed from WAM_MISS to WAM_READ}
-> wa.m(long_message, WAM_MISS + cmd_tribute + cmd_yes + num2trib(100)) ->
//  {_DEBUG:>>> TESTING}
-> cont ->

-> ffa(minute,2) ->

-> wa.m("ps check my site. If yr a good boy I'll give you the password 😍", WAM_MISS) ->
-> cc.disp_balance ->


->->

= slug_ass_kissing

You wait.  She's just standing there above you, not moving.  You hear her fingernails tapping on your phone.
Is she going to let you, or not?  Or is it up to you now, to make a move?
You just paid her {print_number(HAGGLE_LAST_BID)} dollars.  You really should insist that she holds up her end of the deal.
Your face moves closer to her ass, but she stops you,  her hand on the crown of your head.
"Thank me first."

"Thank-" you start to say, but she grabs your hair and pushes her ass back, burying your face between her butt-cheeks.
-> ffa(minute, 3) ->
She holds you there, for what feels like an eternity.  You don't need to breathe, you don't need anything... except {BELLA_NAME}...

When she lets you go, you collape onto the floor.  You were unaware of it at the time, but you must have come all over the floor, because you can feel the wetness of the jizz on your cheek, and its scent hits your nose.
"Have a safe flight," you hear her say, but you're unable to respond.

-> ffa(minute, 30) ->
~ setstat(lust, lust.min)
You manage to crawl into your bed.

->->
