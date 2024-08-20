/*
Story intro, where you meet Bella for the first time.

Takes place in a new york hotel room/bar

It has a major three way fork, depending on what you choose from the bar, which leads you irrevocably down sub, adventure or dom paths in any future scenes and affecting your behaviour and choices drastically in the chat games and in your future "daily grind".

The narrative gathers after your time in the bar with her, back in your hotel room, where it splits again depending on whether you're alone or with her.
The narrative ends with you alone/with her in your room, then oversleeping and rushing to catch the plane back to london, with your phone out of charge (so you can't use it till you get back).
*/
=== meeting_bella
-> init ->
-> scenes

= init
CONST girlfriend_name = "Melanie"

CONST HOTEL_NAME = "Hotel Royale, Manhattan NY"

// ----------------------------------------------------------------------------------
// Set Game Start date and time
~ set_dMy(26,July,2024)
~ set_hms(20, 27, 52)


// -> END
// Set initial money
// Five days at Silverman Brothers
-> cc.deposit(daily_contract_rate() * 5) ->
-> cc.disp_balance ->
->->

= scenes

// Scenes in this chapter

-> S("A Hotel Bedroom, Manhattan, NY", ->hotel_room) ->
-> S("Hotel Bar, Manhattan, NY", ->hotel_bar) ->
-> S("Your Hotel Room", ->hotel_room_after_bar) ->
{_DEBUG:(Paths Join)}
-> eod ->
-> ffa(hour, 8) ->
-> ffa(minute, 2) ->
-> S("Hotel Bedroom, Manhattan, NY", ->hotel_room_after_bar.next_morning)->
-> ffa(hour, 3) ->
-> S("Airplane, Somewhere over the Atlantic", ->hotel_room_after_bar.airplane)->
->->
// ----------------------------------------------------------------------------------
// SCENE:
// Last night in New York
= hotel_room
It’s your last evening in New York, and for once you’re not asleep on your feet by eight PM.   After a week here, you’re finally over your jet lag, but tomorrow you have to go back home and be jet lagged all over again.
It’s been a tough week, they sure work you hard at Silverman Brothers.  But at $1,000 dollars a day, the contract is worth it!  And they paid for your flight, first class, and for this 5-star hotel.
So all in all, a good week! And the ${(daily_contract_rate() * 5) / 1000}K you just made is just about enough to get you that MacBook Pro you’ve been drooling over. 
You feel a small pang of guilt at the thought of blowing your money like that.  You really need to start putting some money away for tax.
You remember what your girlfriend {girlfriend_name} always used to say to you:
"You've never been good with money".   
-> cont ->
One time, after she said it, she'd added, "What you need to do is let me handle all your finances." Then she laughed and said she was only kidding.  But you didn't laugh, because you knew she wasn't kidding at all --  and that she was right. She'd struck a nerve, you got angry and said some pretty nasty stuff to her, then she got angry, and it ended up in a big argument. You apologized later, you even bought her that big bunch of flowers.  But it was too late. You broke up two weeks after that fight.

Money.  You don't care about it, one way or the other, but {girlfriend_name} sure did.
She could have been the one. It could have worked, it could have been great. 

You look at yourself in the closet mirror, and stroke your chest comfortingly.
You repeat the same words you said to her at the end of the fight:

"Fuck you, it's my damn money, and my damn life!"



-> ffa(minute, 20) ->

->->
// ----------------------------------------------------------------------------------
// SCENE:
// Hotel bar

=== hotel_bar
~ DVARS()
// Menu items
LIST bar_menu_options = jack_daniels=10,oysters=25, shrimp=20, bouillabaise=50, shellfish_platter=150, ace_of_spades=250

VAR bar_bill = 0

// reset if player has restarted
~ bar_menu_options = ()
You head downstairs to the hotel bar for a shot or two. Or maybe three -- it’s your last night here, and you can relax.
-> cont ->
You sit yourself at the plush bar, and the barman hands you a menu.  You weren’t really planning to eat, but maybe you should put something in your stomach before you drink anything.
You order a Jack Daniels and examine the menu.  Looks like this is a seafood place.  Not your favorite food.  The only thing that you feel comfortable ordering is the Jumbo Shrimp.  You can't go wrong with that.  
Or maybe try something new and go for the oysters? You’ve never eaten them, they always looked so – alien and weird and slimy.  Why the fuck would anybody eat that shit?
Then you look down the menu to find a more expensive item.  If it's expensive it should be pretty good...  Ah, yes, the Bouillabaise.  And it says it's "Our House Specialty". At  ${LIST_VALUE(bouillabaise)} it better be special!  Yeah, why not act like a rich guy!
Out of curiosity, you scan the menu looking for the most expensive item they have.  It's the "Shellfish Platter".  Fuck, it's ${LIST_VALUE(shellfish_platter)}!  Oh, "For Two People," it says. No, you're not that hungry. And besides, all those pincers, eyes on stalks, and tentacles will give you nightmares.
-> ffa(minute, 5) ->
{hint()}
You don't know it at the time, but the future direction of your life hangs on this decision...

You're leaning towards...

+ [Jumbo Shrimp (${LIST_VALUE(shrimp)})] ...the shrimp.
    ~ bar_menu_options = shrimp
    ~ path = sub
    


+ [Shigoku Oysters (${LIST_VALUE(oysters)})] ...the oysters.
    ~ bar_menu_options = oysters
    ~ path = adventure

+ [Bouillabaise (${LIST_VALUE(bouillabaise)})] ...the Bouillabaise.
    ~ bar_menu_options = bouillabaise
    ~ path = dom

-
// Set stats based on chosen path
-> stats.reset(path) ->


// path branch

{_DEBUG:(Paths Split)}
{path:
 - sub: -> J(->sub_path) ->
 - dom: -> J(->dom_path) ->
 - adventure: -> J(->adventure_path) ->
}

{_DEBUG: >>> Gather}
- 
{_DEBUG:(Paths Join)}
->->

= sub_path
~ DVARS()
// ----------------------------------------------------------------------------------
// She gets you to switch orders to Seafood Platter and pay for her.
// You scan QR code, but also gets your phone number (forces you to eventual ruin)

"I'll have the shrimp", you say to the barman, but he's looking over your shoulder you and grinning like an idiot.

You turn to see who's distracting his attention:
-> cont ->
She's stunning; <>
-> J(-> slug_first_sight) ->
-> ffa(minute, 20) ->
-> J(-> slug_first_talk) ->  
-> ffa(minute, 20) ->
She stops suddenly and resumes checking her phone, like she’s bored of teasing you.  You were probably too easy for her, you think.

You take out your own phone, and pretend you’re doing Important Stuff on it, but you’re not:  You’re just thinking about her, and wishing you were a different guy, with the confidence to flirt with her, or even just  to look at her again.  You started out OK with her, managing to talk to her semi-normally, but then she just cut straight through all your defences, and went directly to the truth:  “You’re a horny loser, and I’m way out of your league.” Yeah.  Way out of your league. But to your surprise you hear her ask, 

“Are you eating anything?”

You look at her, but she’s still playing with her phone.

“Yeah, I’m getting the shrimp. I heard you ordered the oysters.”

She barely nods,  still engrossed in her phone.  You wait for her to say something, but she’s ignoring you. Looks like that’s the end of that conversation. But:

-> ffa(second, 30) ->
“So what are you, a tech guy over here on a contract with one of the financial houses?” she asks after a while.

“Yes!  How the hell did you know that?”

“Kind of obvious.  British accent, shy guy alone in a bar in this hotel on a Friday evening.  This is where all the big financial houses put up their people.”

“Well, you got me pegged.”

“What do you make?”

“Huh?”

“How much do you get paid per day? A grand? Two?”

“I don’t think that’s really something I feel comfortable talking about…”

“I’m just curious.”

“Okay.  Well, even so-”

"-hey, forget it. Whatever, it's a lot less than I-"

"- ${comma_ify(daily_contract_rate())} a day. If that-"
~ incstat(obedience)


“-change your order.”

“What?”

“Don’t get the shrimp. Go for the Shellfish Platter.”

“Yeah, but it’s for two people, I don’t think I could…”   

She turns to you again and stares at you like you’re a complete idiot.  

“Oh! You mean you’ll share!  Okay, sure!”

-> cont ->

You signal to the bartender, and change your order proudly.

"And another bottle," she tells him. She explains to you, "You have to drink Champagne with the Seafood Platter."
You think that maybe "grape on grain" might not be such a good idea. Maybe you better order some bread to go with the food.


Your mood is now completely lifted.  Even though she's kind of rude and brusque with you, she's actually talking to you!  You're talking, and sharing a meal, with the hottest woman you've ever seen!

You introduce yourself:  "Hi, I'm {YOUR_NAME}. And you are...?"

She ignores your question, and instead asks you one:

"So, you're from England?"

"Yes.  London. I'm going back tomorrow," you say.  After you say it, it sounds to you like you're implying something by that; like it's kind of a last chance for something to happen between you. As if.

"I go there sometimes.  Give me your phone number, maybe we can hook up."  She holds up her phone, ready to type it in.

You're shocked, she hasn't even told you her name yet, and she's already asking for your phone number!  You should be suspicious, but you're so flattered, you immediately do what she says and give  her your number.
~ incstat(obedience)
TODO add your phone number to knowledge when you tell her
"You have WhatsApp?" She asks, while she's typing it into her phone.

"Yes."

"Good boy."  

Why the fuck are you a "good boy" for having WhatsApp on your phone?  Is she part of their sales team or something?


-> wa.m("Hi", WAM_CHOOSE) ->


{_DEBUG:(Paths Split)}
+ {unread_message_count} -> J(->ignored_first_message) ->
+ {unread_message_count == 0} -> J(->didnt_ignore_first_message) ->


// Gather
- 
{_DEBUG:(Paths Join)}
-> wa.m("Check my site:", WAM_CHOOSE) ->
She sends you a third message!  {unread_message_count:This time you can't ignore it.}   



-> wa.m("<u>htpps:\/\/bit\/ly\/467738", WAM_READ) ->  

"\"{BELLA_FULL_NAME()}\".  Nice name. Ok, I'll take a look at your site later," You say.
"Yes, you will."  
{BELLA_NAME}'s three word response is slightly weird and unsettling.  Like she's giving you an order.  What's even weirder about it, is that it made your dick twitch.
-> cont -> 
-> slug_seafood_platter ->
-> cont ->
-> slug_finished_seafood_platter ->

->->

= didnt_ignore_first_message
So that's her name:  {BELLA_FULL_NAME()}.
~ knowledge += bella_name
You respond:
->wa.r3choices("Hi!", "Hello {BELLA_NAME}", "🍆 😆",)->

She immediately sends you another one:

->->

= ignored_first_message
    You don't read it yet, but she immediately sends you another one!
->->




= adventure_path
~ DVARS()
// ----------------------------------------------------------------------------------
// She order oysters
// You scan her QR code (leads to become_my_fan)

You ask the barman, trying to sound like you know something about food, “How are the oysters today?”

“Get them. This is the best place for oysters in the city,” says a woman’s voice. You turn around, and then you see her: 
-> J(-> slug_first_sight) ->
"That's why I usually come here," she says.
You're so stunned at the sight of her, you're not paying attention to what she's saying.
"For the oysters," she explains, seeing your dumb look.
-> J(-> slug_first_talk) ->  
-> ffa(minute, 22) ->
-> J(-> slug_qr_code) -> 
-> ffa(minute, 30) ->
-> laterp(true) ->
-> J(->slug_oysters) ->
-> ffa(minute, 40) ->
->->

= dom_path
~ DVARS()
// ----------------------------------------------------------------------------------
// You offer to switch orders to Seafood Platter and pay for her.
// She doesn't give you QR code, but you exchange phone numbers (forces you to eventual ruin)
After the barman takes your order, you look around idly at the people there. Mainly businesspeople chatting and relaxing after work on a friday, like you.
-> ffa(minute, 15) ->
You're feeling slightly lonely there all by yourself at the bar.  Here you are, looking good, flush with money, and you're doing -- what? Nothing.  Drinking whiskey, that's what.

A woman walks in, and instantly catches your attention.  She's fucking awesome looking!


-> J(-> slug_first_sight) ->
-> ffa(minute, 20) ->
-> J(-> slug_first_talk) ->
-> ffa(minute, 20) ->
-> J(-> slug_qr_code) -> 
-> ffa(minute, 20) ->
"Unless you've got what it takes to get me into the sack."
-> cont ->
You're not sure you heard right.  You look at her, and she <i>smirking</i>.  You hate that word, but no other word describes that sly smile of hers so well.
You dick uncurls rapidly, and you peg her quickly:  She's a hooker.  High-class maybe, but definitely a hooker.
You want to ask her immediately how much she charges,  but you're enjoying the flirting too much, so, with the word "smirk" still in your head, you say to her, putting on a fake scowl of diapproval,

"Hey, This is a "No Smirking" bar, lady".

She hides her reaction; she sips her champagne and eyes you over the glass.

You decide to be up-front as her: "I guess what it takes, is -- money."

She puts the glass down as says, "Maybe".

"'Maybe'? What, you want to see my wang-doodle right now or something?" You laugh.

"No, that will get you thrown out of here.  And you wouldn't want that, would you?"

She accompanies her last words by stretching out her perfect leg towards you again and resting the point of her shoe on your shin.  She leaves it there for a few seconds, then pulls back her foot, but not before giving your shin a little jab with it.

"So what are <i>you</i> into?" you ask her.
->cont->
"Guys who know how to treat a lady."

Suddenly you have an idea:

"Hey, wanna share the Shellfish Platter? My treat."

"Of course it would be your treat.  Sure."


"And you have to lay off the rye,  Champagne is the only drink to accompany it."

"Okay, let's get another bottle. Buy maybe you should order it, I can't even pronounce it!"

Either she doesn't find that amusing, or she took you seriously, and thinks you're uneducated.  Maybe  

She makes another tiny gesture with her finger, and the barman appears like a genie again, in front of her.  She orders a bottle of some other fancy-sounding stuff, and starts tapping on her phone.  She doesn't want to talk.  Or more accurately, let's face it, she doesn't want to talk to <i>you</i>. 

You're starting to doubt she's a hooker after all.  You regret your blunt remark about money,  yet she didn't seem to be offended by it.  You're genuiniely curious about her now.

She calls herself an "influencer":  Okay, that could mean anything.  You decide to ask her, to row back a little on your earlier disdainful attitude.

"So what sort of stuff do you say?  I mean on your fan page?"

She suddenly fixes you with a gaze so intense, it stuns you.

"I talk about how to manage finances."

-> cont ->


"Yeah, I thought so," she laughs.

Wh-what did you think?" you stammer.

"You're a fuck-up, aren't you?"

"I don't know what you mean..."

"Yes you do. You know exactly what I mean.  You don't know the value of a dollar.  You probably earn a decent salary,  but you spend it all on yourself.  You don't save, you acquire money, but you're not accruing any wealth."

She's struck a nerve.  Who the hell does this hooker think she is, lecturing you.

"It's my damn money.  And don't you think it's a bit rich- I mean rude, to lecture me after I've just offered to buy you a {print_number(LIST_VALUE(shellfish_platter))} dollar meal!"

"Don't forget the Champagne, too."

"Yeah. And the goddamn Champagne.  I don't even drink the stuff."

She gets up off her stool and moves onto the one right next to you!  You feel an uncontrollable urge to grab her shoulders and kiss her,  knead and squeeze her round tits, plunge you dick into her tight pussy...

"Take out your credit cards," she says.

-> cont ->

"Why?"

She doesn't answer you, but opens up her purse and takes out an array of gold and platinum cards, placing them one by one on the bar in front of you.  This draws the barman's attention, and he asks her, "Can I get you anything else?"

She looks at you.  "Yeah.  Check please."

He raises an eyebrow, and asks her, "Did you want me to cancel the order?"

"No, it's okay."

He hands her the bill, neatly folded in two.

She throws a Gold Amex on top of it without looking at it.


You feel humiliated, angry, chastened, and... confused.  What did you do wrong?  Why is she so pissed off all of a sudden?

-> cont ->

"Hey,  don't do that.  I told you, it's my treat.  I'm sorry, can't we just start again?

She picks up her card and puts it back in her purse.

"That's better-" you start to say.

She stands up quickly. "See ya," she says, and starts to walk out!

"What the fuck!?  Hey, what did I say?  What did I do?"

She doesn't even turn around.

"Hey, you didn't even tell me your name!" you shout, as she exits.

-> cont ->

The barman is looking at you.  You fumble for your credit card.  Then you change your mind, and unfold the bill.


"I think there's a mistake here," you say, to the barman trying to keep calm.


~ bar_bill += 1 * LIST_VALUE(bouillabaise)
~ bar_bill += 1 * LIST_VALUE(oysters)
~ bar_bill += 1 * LIST_VALUE(shellfish_platter)
~ bar_bill += 2 * LIST_VALUE(ace_of_spades)
~ bar_bill += 2 * LIST_VALUE(jack_daniels)
~ bar_bill = INT(bar_bill * 1.15)

He looks at the check and says, "No, that's right, two JDs, one Bouillabaise, one Oysters, one Shellfish Platter, Two Armand de Brignac Blanc de Noirs. Plus fifteen percent cover charge. {print_number_c(bar_bill)} dollars."

"You're sure that's right? {print_number_c(LIST_VALUE(ace_of_spades))} bucks? for a fucking <i>bottle of fizzy wine</i>?

"Only the best for the best, sir. You know who she is, of course?"

"No, but I sure I know <i>what</i> she is.  A fuckin' hooker."

"You mean you didn't recognize her?" says the bartender.

"That was {BELLA_FULL_NAME()}."

->cont ->

You wish you could turn back the clock and start the evening again. You don't know what you did worng, but whatever it was, you'd do it differently this time.

{hint()} Maybe you should have ordered something other than the Bouillabaise...

-> END
->->

// Slugs --------------------------------------------------------

= slug_first_sight
~ DVARS()
You don’t recognize her, but she <i>has</i> to be a movie star. Whatever “it” is about movie stars, she has “it”.  She’s wearing a low-cut black tee shirt and tight jeans; but she makes that casual outfit look like she could be at the Oscars – she exudes class, and pure – charisma.
->->

= slug_first_talk
~ DVARS()
{path==adventure:You snap out of your trance and manage to say, “Thanks for the recommendation!”}

She seats herself on a barstool two seats away from you{path==dom:!|.}  
You check her out{not (path==dom): discreetly}, looking at her via the mirror behind the bar. She's busy on her phone, giving you a chance to turn and glance directly at her. You notice that she’s wearing heels.  <i>Really</i> high heels.  You look at them and think to yourself, “Why is she wearing those? Could she possibly be a... nah, she's definitely not.”
To your embarrassment she catches you looking down at her shoes. She straightens one leg towards you, giving you a better look.
"Like them? They're Louboutain <i>Pigalle,</i>” she says, and before you can formulate a reply, she turns back to face the bar and raises a finger.   The barman, who’s yards away at the far end of the bar, rushes straight over to her and takes her order, which you overhear: Some fancy-sounding Champagne – and she’s going for the oysters{path==adventure: too!|.}
"Keep the champagne  in the cooler for me," she tells the barman, handing him a twenty dollar bill.
He breaks out into a big dumb grin and says "yes, ma'am!"
"Oh, and make sure you give me a tulip glass.  I don't do flute."
The barman's grin widens, and he nods.  He lingers there for a moment until it's clear he's dismissed, because she ignores him and picks up her phone again. She uses its camera as a mirror,  carefully applying lipstick to her full lips.  You watch her, transfixed. She's got to be a celebrity, you think, but you can't place her at all. When she’s finished, she looks at you, and asks, “how’s that?”

-> cont ->
{ path:
    - sub: 
        "Amazing... you look... just – wow,” you blurt.
    - dom: 
        "Pretty damn perfect..."  you say.  And your dick agrees.
    - adventure: 
        You can't answer her, she's literally left you speechless.
}

She smiles broadly at this, satisfied.  Clearly that was the effect she was intending.

“Are you – famous?”  You manage to ask her.
“You could say that,” she replies.
“Are you, like, a movie or pop star, and I’m being a total dick not recognizing you?”
“I’m neither.  I’m an influencer.”
{ path:
    - sub: 
        You're not into social media at all, you think it's shallow and stupid.  Your disappointment in her answer clearly shows in your face, because she looks at you with disdain for a fraction of a second and quickly decides you're of no interest to her.  She turns away.
        
        You ask her, almost apologetically, "Sorry, I know you must think I'm stupid, but what exactly does an influencer do?"
        
        She ignores you.
        
        "Sorry, I didn't mean-", you begin, but she turns and interrupts you:
        
        "-I'm an influencer. That means I..."
        
        Again, she stretches her leg towards you; she's touching  your shin with the tip of her heel.  She starts stroking your shin...
        
        "...<i>Influence</i> people..."
        
        "...the way I'm influencing you right now."
        
        She sure is.   You're growing quickly hard.
        -> cont ->
    
    - else: 
“Ah, okay, that explains it,” you answer. “I’m not into social media, sorry.”  
<i>Idiot, why did I say that to her</i>, you think, but she doesn’t seem offended by it:  In fact, maybe it’s cool that you said that; maybe she’s actually sick of everybody recognising her. Yeah, you’ve actually made her interested in you, with your remark.
}

->->

= slug_qr_code
~ DVARS()
She picks up her phone and taps on it quickly, then she holds it up to you, showing the screen.  It's a QR code. 
“That’s my fan page.” She waits for you to pick up your phone.

{path == sub:
    You oblige, and scan the QR code, but don't click the link.
    ~ incstat(obedience)
TODO qr code slug text for sub path is too short
-else:

    You look at her, and say {path==dom:coolly}, "I just said, I'm not into social media.  I'm sure your fan site is great, but..."
    "...but you're not into social media, I get it," she says, putting her phone away.
    You’ve blown it, you think, and down your shot of JD angrily, immediately raising your hand and looking for the bartender for a refill.
    
    She takes a gulp of her champagne and signals to the bartender too.  Of course he ignores you like you don't exist, and goes straight to her.
    "Refill?" He asks, with his same dumb, broad smile.
    "Yes. But I have to say, I'm finding this <i>Blanc de Noirs</i> a tad sweet,"  she says. "You're sure it's 2016? Show me the bottle." You wait while he carefully takes a bottle from behind the counter, wipes the melted ice from it with a cloth, and shows her the label. She glances at it and nods. He pours some champagne into her glass, wipes the bottle again, and returns it to the cooler behind the bar.

    “So, what <i>are</i> you into?” She asks.  You turn to look at her, but she’s looking straight ahead, at her reflection in the mirror behind the bar.  Involuntarily, you glance at her legs again.

    "I thought so", she says with a little smile.

    She turns back to you, fixes you with a stare and says,  "You know, there's a lot more on my fan site."

    -> cont ->
    "Well, that was pretty unambiguous," you think.  And now you see her in a different light:  She's one of those OnlyF*ns types, dancing around naked in her bedroom while her "fans" ogle her and jerk off.
    But no, that doesn't fit with how she looks... she's altogether too classy for that sort of behaviour.
    Whatever she is, she's more than piqued your curiosity: you'd <i>really</i> like to see more of her... "content".
    Trying not to sound either too keen or too uninterested, you laugh and say, "Ok, it's <i>that</i> kind of fan site. Okay, just to make you happy, I'll check it out."
    "Nope, too late now, Jack, you've blown your chance," she says.
    
    Yeah, you have.
    
    "Unless..." she adds, looking at you thoughtfully.
    
    She's giving you a second chance!
    
    "Unless what? Unless I-"

    {path==adventure:"-Ah, here are your oysters", she interrupts.}
}
->->

= slug_oysters
~ DVARS()
You gaze at the five oysters on your plate.  One of them seems to be still alive, the pale, slimy flesh writhing and distorting  slowly and disgustingly.
You're aware she's looking at you, and probably laughing inside at your obvious reluctance to eat them.

Although it will only delay the inevitable, you decide to act like a gentleman and offer your plate to her until the second plate arrives.
"You ordered the same as me, right?  Why don't you take mine, I can wait," you say.

"Ok, sure," she says, and grabs the plate from you.  She pours an oyster into her mouth, eyeing you while she does.

"Any good?" You ask.

"Great. Needs salsa," she says, and tips out a whole saucer of cilantro and chilli sauce over the remaining four.  "They never give you enough sauce in this place."

You order another JD, while she swipes and taps on her phone with one hand, and finishes off the oysters one by one. 

-> slug_watching_her_eat_oysters ->

The second plate of oysters arrive, but she gestures to the bartender to put it in front of her instead of you.  Did she misunderstand your chivalrous gesture earlier? Did she think you were actually <i>giving</i> her your portion?

* (protest)[Protest]
    ~ decstat(obedience)
    "Hey, I think those were mine," you say.
    She looks at you, puzzled, and then says, "No these are mine.  I already ate yours."


* [Say nothing]
You say nothing, thinking of the {print_number(LIST_VALUE(oysters))} dollars they're going to charge you for them.
    ~ incstat(obedience)
-

You {protest: stare at her in disbelief|watch her } while she picks up an oyster, ready to start on your plate.
    
"Try one, they're really good." She holds it out towards you.  
"Thanks," you say, although you don't know why you're thanking <i>her</i> for one of your oysters.
    
You lean across the barstool separating the two of you, try to take it from her, but she withdraws her hand.
"You need to pour it into your mouth, like this:"  She says, demonstrating.
"I know," you say.  "You've given me quite a few demonstrations of how to do it."
"Yeah, I noticed you watching me.  I should have charged admission."
    
She stands up, and comes over to you. She stands very close, her chest almost touching your face.
    
"Lean your head right back," she says.  
    
    
<i>"What are you...!?"</i> you gasp.
    
"Do it."
    
Her sudden command bypasses your brain, and you arch your neck and hold your head back.  You screw up your face like a kid being made to swallow their medicine.
    
You feel the weird, cold slimy mollusc slither down your throat.  It's as disgusting as you feared it would be.
-> cont ->
"Good boy," she says. Something about the way she says it makes you feel like you've passed some sort of test.

She repeats it: "Yes, you are a very good boy."

 "In fact," she says decidedly, "I think I'll let you apply for my fan club after all."
For some reason, your dick uncurls when she says that.  But it shrinks again when she adds, "But there's just one thing you have to do..."

"...Don't tell me, eat another oyster," you say.

"Nope.  Just pay for mine."

"You mean, as well as for mine? The ones you ate all of?"

"Not all of them.  You had one too. Good boy."

"Oh... you..." You burst out laughing at her sheer, unabashed... <i>chutzpah</i>.  "Okay. Sure. Sure, I'll pay for your damn oysters."

"And my drinks."

"Sure. And your damn drinks."

"Such a good boy.  Here: She holds out her phone, and you scan the QR code onto your phone gratefully.

"You're fun," you say.

"Oh, before I forget, the password is "{become_my_fan_password}". All lowercase."
You're confused:  "Password? You mean to your site?"
But she doesn't answer. Then, without warning, she gets up off her barstool and walks away!

-> cont ->

You're so surprised that you're speechless.  You watch her swaying ass as she exit the bar, wondering if you've said something to offend her.

The bartender distracts your attention.

"Your check, sir," he says, sliding a tray towards you with one finger.  It's folded up -- which is usually a sign that you're going to get an unpleasant surprise when you unfold it.

The bartender watches you as you look at it.
"I think there's a mistake here," you say, trying to keep calm.


~ bar_bill += 2 * LIST_VALUE(oysters)
~ bar_bill += 3 * LIST_VALUE(jack_daniels)
~ bar_bill += LIST_VALUE(ace_of_spades)
~ bar_bill = INT(bar_bill * 1.15)

He looks at the check and says, "No, that's right, three JDs, two Shigoku Oysters, One Armand de Brignac Blanc de Noirs."

"You're sure that's right? {print_number_c(LIST_VALUE(ace_of_spades))} bucks? for a fucking <i>bottle of fizzy wine</i>?

"Only the best for the best, sir. You know who she is, of course?"

"No, but I sure I know <i>what</i> she is.  A fuckin' hooker."

"Hardly," says the bartender, raising his eyebrow.
-> cc.pay(HOTEL_NAME, bar_bill, true) -> 

// This transaction will never fail, but:
// + {TX_RESULT == TX_FAILED} - go somewhere
// + {TX_RESULT == TX_SUCCESS} - go somewhere else
// -
~ decstat(confidence)
You pay the bill and go up to your bedroom, {girlfriend_name}'s words echoing in your head:
<i>You've never been good with money. 

-> cc.disp_balance ->

->->

= slug_seafood_platter
The shellfish platter arrives.  The bartender, to whom you now seem to have become completely invisible, places it in front of {BELLA_NAME}. As you feared, it looks completely disgusting, not to say scary-looking.    {BELLA_NAME} dives straight in. You decide you're going to to pass on the whole thing, but she pats on the empty barstool between you; you're torn between the desire to accept the invitation to sit right next to her, and the fear of having to eat that shit if you do.  No contest...
    ...You stand up, feeling the effect of the alochol you've imbibed --  Yeah, you <i>really</i> ought to eat something. You sit next to her.

She's starting with the oysters. <>
-> slug_watching_her_eat_oysters ->



->->

= slug_watching_her_eat_oysters
-> ffa(minute,10) ->
Maybe it's your ego, but you get the feeling that she's miming cunnilingus , for your benefit... Of course, that's what they say about oysters, you remember: they're an aphrodisiac, and that they kind of taste like pussy...

She's defintely got an incredibly sexual vibe to her, you think as you watch her.  She's not merely super-hot-looking;  there's also an extra quality there... like she's some kind of -- royalty? No, not exactly royalty, but she exudes a kind of regalness, like she's used to being in command, and is far above you. {path==sub:Maybe she's super-rich; she didn't seem at all impressed when you told her how much you earn.} And yet here she is,{path==adventure: sitting casually by herself at a bar,} dribbling oyster-pussy juice down her chin just like a regular person... <i>{path==adventure:Three feet away from |right next to }you...</i>
->->

= slug_finished_seafood_platter
-> ffa(hour, 1) ->
-> laterp(true) ->
You've lost track of time.  You don't remember much of the meal, only that you tried some it, and it didn't make you puke.  The jet lag, coupled with the whiskeys and what feels like a whole bottle of champagne, have left your brain completely numb.  You stare vacantly at the plate,  at the  piles of shells and carapaces, like the remains of some grotesque massacre on an alien planet.
You think you did most of the talking, but you're not really sure what you said. Hopefully nothing stupid. {BELLA_NAME} is ignoring you, and looking at her phone again. Maybe you should call it a night, you think.  You try to summon the will to stand up, but before you do, she suddenly gets up from her barstool, checks herself in the mirror behind the bar, and says to you,
"Well, see ya." 
Then, without warning, she just walks away!

The bartender hands you your bill.  You're too drunk to read it,  so you fumble for your credit card and pay without looking at it. You mumble goodnight to him, even though he's serving another customer twenty feet away by now. You find your way back up to your room.

~ incstat(obedience)

~ bar_bill += 2 * LIST_VALUE(ace_of_spades)
~ bar_bill += 2 * LIST_VALUE(jack_daniels)
~ bar_bill += LIST_VALUE(shellfish_platter)
~ bar_bill = INT(bar_bill * 1.15)
-> cc.pay(HOTEL_NAME, bar_bill, true) -> 
// // This transaction will never fail because balance is enough at this stage of the game, but here's how to deal with it:
// + {TX_RESULT == TX_FAILED} -> gather
// + {TX_RESULT == TX_SUCCESS} -> gather
// - (gather) 
->->


