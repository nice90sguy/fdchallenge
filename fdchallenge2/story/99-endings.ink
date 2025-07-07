// You're in Bella's hovel, and she's spent all your money, or youve gone broke.
// Note: This scene occurs at 9 AM, when she's calling you (see grind.on_the_hour, which tunnels to Bella.morning_alarm
=== ending_ruin
= do
~ alarms_enabled = false // We don't want any callbacks to disturb the narrative

->SCENE_START(location_hovel) ->
You haven't heard from Bella yet. You look around for your phone by the bed but it's not there, you left it on the kitchen table. You jump out of bed, naked, and run to get it.  She doesn't like it when you don't pick up immediately!

As you head back to bed, you hear the sound of a key being used in your front door!
Could it be...
<i>Her!??</i>
-> cont ->
The door opens, and a short, squat woman appears with an anxious expression on her face, a bunch of keys in one hand, and a shopping bag in the other.  She's talking on her phone, cradling between her hunched shoulder and her era, her neck twisted uncomfortably to keep it in place.

She steps into the room quickly, oblivious to you and your nakedness. 
"Yes Mrs, Bella, I'm here now.  Yes, Mrs Bella... Yes, I hoover and... of course, bathroom floor too, all rooms..."

You follow her, incredulous, while she wlaks with quick little steps into the kitchen.  She puts her keys and shopping bag on the kitchen table, and opens the fridge.  She takes out a bottle of Champagne from the bag and sets in on the shelf in the fridge door.

"Yes, I did this just now, yes, Mrs Bella, I put it in the refrigerator."

She looks up at you, while she says "Yes, the man is here, he is here in the kitchen with me, Mrs Bella."

She jerks out her arm presenting the phone to you, and you hear Bella's voice:

"Julia is going to clean my apartment now.  I'll call you back on your phone in one minute. In the meantime, get dressed. You're going out. I want Julia to do a thorough job and I don't want you hovering around while she tries to tidy up your mess."

"I...yes," you stammer, but she's already ended the call.  You hand the phone back to Julia and dress hurriedly, and with barely enough time before she calls you back.

"Good boy.  Now. Why don't you walk to the park.  You look terrible. You've completely let yourself go the last few days."

"I'm sorry, Bella. I haven't been sleeping very-"

"-Why are the payments not going through on your cards?"

You knew that was coming. "I, I'm sorry Goddess, I.. I don't think the bank will..."

"What about your job at Silverman?"

Did she really think you were still capable of working? Didn't she know how far she's driven you to mindless addiction? How utterly hopeless a wreck you've become?"

"I..."

"Go back to them, beg them if necessary, for more work.  Otherwise, you'll be of no use to anyone."

"Yes, you're right.  I'm sure I can... I can call my manager, he's..." ...you trail off, hearing how stupid and deluded your words sound. They'll take one look at you and see the state you're in, and laugh you out of the office.

-> cont ->

-> ffa(minute, 28) ->

You arrive at the park.  It's empty, except for one or two people walking their dogs. You sit down on a park bench.  Bella has made it clear that until you can start tributing her again, you're not staying in her apartment anymore. In fact, she's cutting you off completely from her life.

You burst into tears, and plead with her:  "But, Goddess, I don't have anywhere to stay... please give me a little time to..."

To your surprise, she responds to your pathetic pleas not with anger or disgust, but with amusement and even pity, almost affection. You instantly get hard on hearing her change of tone, such is your relief: "Oh, you're really useless.  Well, I've arranged that for you, because I knew you woudln't be able to do that yourself.   I spoke to your friend Al this morning.  He's going to put you up on his couch.

You're speechless: Bella has spoken to Al?
-> cont ->

Bella, guessing your shock, laughs and says, "You idiot, you don't even remember I know everyhting about you.  You sent me all your contacts days ago. Yes, I've had quite a few chats with Al over the last couple of days.  I like him.  He's nice, and kind, and generous."  Bella laughs again.  "He's very like you, in some ways, isn't he?"

You're still unable to respond, so Bella continues:

"Did you know that he's about to inherit quite a lot of money?  I've been advising him on how best to invest it."

"Yes, Bella..." you manage to say weakly. You finally understand: You're being thrown on the scrap-heap -- and getting replaced.

Bella seems to realise that you've figured out what's happening, because she says, "Don't worry, it will take at least another couple of weeks for the sale of his house to go through, so you'll be able to stay there until you find your feet, until, of course, it becomes my house."

"Yes, Bella."

"I told Julia to put the Champagne in the fridge.  I like to do that with new guests. It creates a nice weloming touch, don;t you think?  Oh I know it's a little extravagent of me, but... well, life is for living isn't it?"

"Yes..."  You're distracted by something shiny on the ground at your feet.  You pick it up. It's a pound coin. Leaving the phone on the bench, you wander off, dazedly, feeling the coin in your hand.

You see a homeless man, limping and zig-zagging along the path, his eyes downcast, scavenging for cigarette butts.  As he passes, you hold out your hand and proffer the coin.  He doesn't make eye contact, but looks at the coin.  He takes it silently, nodding his head impercetably.

You walk on, and speed up, feeling the bright morning sunshine on your tear-stained face.


->END

= triggered
{triggered == 1: {hint()}<> (Ruin Ending triggered!)}
->->