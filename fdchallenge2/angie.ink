
/*
    Angie story during first 7 day grind:
    Each time you ignore her, her obsession grows
    
    Dom path
    Meet her on plane, exchange numbers.
    Day 1:
    See a missed text, ignore it
    If you call her on day 0, arrange to meet her in cafe on day 1.
    If you go out socialising with Al, she's there.  Chat with her or ignore her
    
    Day 2:
    (not met her yet) If you go out socialising with Al, she's with another guy, closes her path, opens Bella path again (at a cost)
    (met her) if you go out socialising with Al, she starts to stalk you
    (met her) if you go out with her, she invites herself to your place, sex. yandere
    Day 3-7 You're either on Bella path, stalk, yandere
    if you're being stalked, random messages, see her in bar, gym, running. If you contact her, she comes back to your place, and you're on yandere path
    if you're yandere, she hangs around with you, sex.  Each time you have sex, you get more trapped, cant eat, sleep.  If you reach max yandere, you open up bella chat, where you get her number, and she starts taunts. Each sex with angie reduces bella addiction, each bella interaction reduces angie yandere.
    The higher the yandere, the more dangerous she becomes.  If she takes your phone, she closes bella path
    
    Angie stats: These continually increase until max, all you can do is delay it, never reduce it.
    If you ignore her, the more she pesters you.
    
    min - you don't communicate with her at all, she pesters you
    low - you've met her, but keep your distance, she pesters you
    med - you met her in the cafe, and got on well, but no sex yet
    high - you've fucked, or jerked off together in the shower
    max - youre addicted to her
    
*/
LIST angie_taunts = angie_taunt_fear
VAR angie_location = location_angie_apartment

=== Angie
// You've just come out of the shower after arriving back from the airport
= first_call_to_angie

{angie_knows_your_number:
    You notice that message from {msg_name(ANGIE)} again. She was really cute...  
    But it might appear a little desperate to respond so soon.  You decide to
- else:
 You remember that woman on the plane. {msg_name(ANGIE)}. She was really cute.  Why the fuck did you give her a fake number? 
 "Well, you can always make the first move and call her yourself, idiot," you say to yourself.
    But you don't want to sound desperate.  You decide to
}


 * <> stick to your plan, and not{angie_knows_your_number: respond| call her} yet.
    
 * <> change your mind, and send her a message right now.
        {angie_knows_your_number:
            You reply to her message.
            {M_wa_S(YOU)} hi {msg_name(ANGIE)}.  :)
        - else:
            You send her a bullshitting message:
            {M_wa_S(YOU)} hi {msg_name(ANGIE)}, this is {YOUR_NAME},  not sure if you tried to call, but I think I might have given you my old number by mistake.  Hope you got home safely.
        }
        You see whether the message got delivered. It did, but the ticks don't turn blue. You shrug.  You've sent the message, so at least she knows you're not ignoring her.
        ->ffa(minute, 2)->
        -> cont ->
        -> phone_sex ->
 -
->->
= cafe_meeting_invite

    ~ temp meeting_t = next_hm(11,0)

    -> wa.m_cb("Hi there {sv(angie_relationship == high):sexy}. Fancy meeting up for a coffee sometime today? Say, eleven?", WAM_MISS + ANGIE_FULL_NAME + cmd_meet + location_cafe + num2list(meeting_t), ->Angie.meet_in_cafe) ->

{_DEBUG:>>> SENT INVITE FOR {hhmm(meeting_t)}}    
->->
/*
This is a "callback" that never returns.
See Angie.cafe_meeting_invite
At the beginning, set IN_CALLBACK to false, do stuff, then tunnel on to grind.after_activity.
*/
= meet_in_cafe

// ~ IN_CALLBACK = false

{location != location_cafe:
    // Edge case, you're on your way there.
    {current_activity == hangout_cafe:
        {warn()} It's {ampm()}. You're running late!
        -> p1("Call her and tell her you're on your way") ->
         "That's ok, no rush," she says.
    - else:
        {warn()} It's {ampm()} and you forgot to meet {msg_name(ANGIE)}!
        ~ decstat(confidence)
        -> p1("Call her and apologize") ->
        ~ incstat(obedience)
        You call her up.
        "That's ok," she says, lightly.  "I'm still here. How long will it take you to get here?"
        "Half an hour, max," you say.
        "Make it fifteen minutes, and I'll still be here."
        You jump in an Uber and get there in fifteen minutes.
        -> cc.pay("Uber", 10, true) ->
        -> ffa(minute, 15) ->
    }
    ~ location = location_cafe
    You walk into the cafe and see her there.  She smiles and waves, and you sit down opposite her. 
    "I'm so sorry, I just got caught up in things, and lost track of time!"
    You sit down opposite her, and look at her. 
    ->  slug_cafe_meeting ->

- else:
    Angie walks in and looks around. She sees you and smiles.
    She sits down  opposite you and takes off her jacket. 
    ~incstat(angie_relationship)
    ->  slug_cafe_meeting ->


}

-> grind_cafe_return_home.do


= slug_cafe_meeting
 She's wearing a low-cut pink long-sleeved tee shirt, revealing her cleavage, and you can't help noticing her tattoo,  right above her breast, of a bee. But you look up at her face quickly, before she notices.
 
 "Like it?" She asks you, smiling.
 
 * {phone_sex}[Comment on it] ->
    "It's very... noticeable," you laugh. "So, why a bee?"
    "Because I'm sweet as honey."
    "And presumably because you have a bit of sting too?"
    "Me??" She says, playing a hand over her chest innocently. "No, I'm not the stinging type."
    
 * [Show interest in her as a person] ->
    "Yeah, it's kind of cool."
    "I was going for hot, but never mind."
    
 - 
She leans forward and looks you in the eyes, with a wide, smile, and sighs happily.
But she doesn't seem to want to say anything.
Eventually you ask her, smiling too to hide your unease, "What?"
She looks down shyly, then stares absently at her empty coffee cup.
You're about to ask her if she wants another coffee, when she she looks at you intently and asks, "Do you believe in love at first sight?"
* [Yes (Psycho alert)]
    "I..."
* [Ummm... (Psycho alert)]
    "I, urm..."
-
"I do," she says, before you can formulate a response.
<i>That settles it then... 
She goes on:  "I felt that way about Jimmy."
"Your ex?"
She nods quickly.
<i>Damaged goods,</i> you think. Well, maybe she's not so different from you.
-> p1("Wait patiently for her to continue") ->
"I was so sure about him, you know?", she says, giving you another of her unnerving, wide-eyed stares. She's still smiling, which you're now interpreting as an attempt to keep up a brave face.
"So, you broke up?"
"No."
-> p1("Awkward silence") ->
"So, you and... Jimmy are still together."
"No."
    -> cont ->
"He... died."
Involuntarily you reach out and take her hands in yours.  They're little, delicate hands, cool hands.  With bright green fingernails.
"That must have been so terrible for you," you say.
"Not really", she says, pulling her hands away suddenly and looking away, with a sullen, angry expression. "He'd already broken our trust. I didn't love him anymore by then."
She continues, "He was... afraid of love. Afraid of me, in a way."
You say, gently, "Well, that's kind of a guy thing.  We're not that good with emotions."
She looks at you angrily and says, "Why are you defending him?"
"I'm not trying to defend him, I'm just trying to-"
"-You don't know what he did."
You can guess.
"He fucked someone behind your back?"
"No". She shakes her head rapidly, on the verge of tears. "But he would have done, I'm sure, if he'd had the chance."
"Sounds like he felt trapped," you say, imagining yourself in Jimmy's shoes.  She's clearly emotionally unstable, and super intense.
She shrugs her shoulders, shaking off the memory of Jimmy, and all that negativity, and looks at you again with shining eyes.
She sinks a little lower in her chair, looks around quickly, and then you suddenly feel something pressing on your groin. 
->p1e("\"Angie, what are you...\"") ->
You look down. She's taken off one of her trainers, and she's kneading your rapidly growing cock with her toes.
"Hey..." You say, not really wanting her to stop.
But then she thinks better of it, it seems, and lowers her foot to the ground.
"Angie, you naughty girl," you laugh.  
-> p1("So what if she's crazy, she's hot as fuck, and I'm horny as fuck") ->
She slips off her seat and disappears under the table. You assume she's looking for her trainer, to put it back on, having thought better of her impulses.
"That's right, Angie, there's a time and a place for -"
-> p1e("Suddenly, you feel her hands undoing your zipper") ->
<>.  You're too shocked to do anything.  You feel her cool fingers pulling out your dick, and then...
-> cont ->
Her lips clamp over the end of your dick.  You feel her tongue rotating quickly, bringing you to a very, quick, powerful...
-> cont ->
...orgasm.
You look around the cafe.  Nobody noticed.
"Ah, here it is," she says, and emerges from under the table, brandishing her trainer.
She wipes her mouth with a paper napkin and looks at you, expecting you to say something.
"Thank you," you say.
"No, thank you," she says, stroking your hand.
"Really?  You're thanking me for sucking me off?"
"No.  I'm thanking you, for not being afraid of love."
-> p1("AND... the Psycho is back...") ->
"You're one up on me, now", she says.
"You mean, I owe you an orgasm, right?"
"Right."
"Ok," you laugh, "next time we meet here, I'll reciprocate."
"Oh, I don't think I can wait that long."
"Angie, I have to get back home now."
"Yes, let's go", she says.
* (angie_stalker)[{angel()} It's time to set her straight...]
    "Look, Angie.  You're... I mean, I really like you, but I think you're, I mean let's just take things a little slow.   I've just come out of relationship, and-"
    -> p1e("\"-I know.\"") ->
    "You do?"
    "Yes, you told me on the plane.  Her name is {girlfriend_name} and she's an entertainment lawyer."
    "Wow, did I tell you all that?"
    "Well," she laughs, "You told me her name. She's very pretty."
    -> p1("What the actual fuck...") ->
    "'She's very pretty'?? How the hell do you know what she looks like?"
    "I found her on Insta," she says, like it was obvious.
    You look at her in disbelief. "You... found her on Insta."
    She looks at you in the eye, and says, "I know she hurt you, but I promise you, I'll never do that to you."
    "She didn't hurt me, Angie.  It's just, I... we weren't right for each other."
    Angie beams widely, thinking that you've implied that she and you, on the other hand, are right for each other.
    
    "I'm sorry, Angie, but I'm not looking for a relationship right now.  can't we just be, you know, friends?"
    "...with benefits, right?" She says.
    "Well, yeah..."
    She doesn't say anything, but picks up her phone and taps rapidly with two thumbs.
    -> wa.m("😞💔", WAM_READ+ANGIE) ->
    "Angie, I'm sorry you feel that way."
    "No," she says, "that's you.  You poor guy."
    
* (angie_yandere)[{devil_happy()} ...but that blowjob was... rather good...]
    "Okay.  It's only a short walk from here."
    "I know," she says.
    -> p1("You know??") ->    
    "Yes, you told me on the plane.  Don't you remember anything we talked about?"
    "Well, I was too busy looking at your legs most of the time."
    "I noticed. Well,  you can look at my legs some more."

* [{angel()} ...She's trouble, and you know it...]
    -> angie_stalker 
* [{devil_happy()} ...So what?  I can take care of myself.]
    -> angie_yandere
-

{angie_stalker:
>>>
    -> Taunt.reset(angie_taunt_fear, 12) ->
>>>
}
-> cont ->


-> ffa(hour, 1) ->

-> cont ->

You pay the bill, and leave the cafe {angie_yandere: together}.
{angie_yandere: 
    ~ angie_location = location_home
}

->->
/*
This is your first meeting with Angie.
*/

= plane_meeting
A woman sits in the next seat to you.  She's very nice-looking, with a big smile and great legs, which you notice while untangling your seatbelt from hers.  
She seems familiar.  It turns out she lives not far from you, and goes to the same gym and cafe as you!  That must be where you've seen her, you think.
You end up talking with her. Her name's {msg_name(ANGIE)}. You watch a couple of inflight movies together, laughing at the same places in the movie.
She wants to exchange phone numbers. 
You reach for your phone in your backpack, but it's not there.  Fuck, did you leave it at the hotel? No, you distinctly remember packing it. Oh yeah, you put it in your suitcase which has gone in the hold. <>
    You get her to write down her number in your notepad, old-school.
{hint()} Whichever option you choose now, you haven't seen the last of her!
    * [Give her a fake number]
        You give her a fake number. There's something about her that rings alarm bells.
        ~ setstat(angie_relationship, min)
    *(angie_knows_your_number)[Give her your real number]
        You give her your number, with a vague sense of foreboding.
        -> wa.m_cb("Hi", WAM_SILENT+WAM_MISS+ANGIE_UNKNOWN+WAM_CALLBACK,  ->respond_to_angie_hi) ->
        ~ setstat(angie_relationship, low)
    -
->->

= respond_to_angie_hi
{_DEBUG: >>> angie_relationship: {list2num(angie_relationship)}% ({sv(angie_relationship)})}
    You look at the time of the message, and figure out it must be from {msg_name(ANGIE)}.  Checking your notepad, you confirm it.
    Great.  But you're not going to call her back.  Wait a couple of days. Play it cool.
    -> cont ->
->->
// You've just come out of the shower
= phone_sex

You've just finished drying off, when your phone starts buzzing. She's calling you right back! You <>
-> p1e("answer it") ->
<>.

"Hello, {YOUR_NAME}! {angie_knows_your_number:I thought you wouldn't reply to my message,"|I was starting to think you might have given me a fake number!"} she says.
"Now, why would you think that?"
"Well, I had the feeling you were going to be one of those guys who plays it cool, you know." She laughs.
"Nah," you say, "I don't play games like that!"
"Oh, I'm so glad.  I really felt, like, we had a connection when we were talking on the plane. Maybe it was just my imagination..."
You're not sure what to say.  If you agree, that might be moving things a little too fast.  But you can't out and out contradict her, that would be so harsh.  So you don't reply at all, and there's a slightly
->p1e("awkard pause") ->
->ffa(second, 10) ->
<>.  After a few seconds, she asks you how you feel after the flight.
"Oh," you say, "a little spaced out, but much better after I took a shower."
"Oh, me too!" She responds excitedly. "...in fact, I'm actually standing naked in the bathroom right now."
-> cont ->
You don't know what to say to that.  But your dick stirs.  You reply
* "Me too."
* "Um, TMI, {msg_name(ANGIE)}..."
-
"...and... I'm touching myself..." she replies. Her voice now sounds echo-y, she must have put her phone on speaker...
->wa.m("(photo)", ANGIE+ WAM_READ) ->
It's a picture of her hand over her groin... and you can just see a teasing hint of her pussy behind her spread fingers...
-> cont ->
You know you're expected to reciprocate.  You let the towel drop to the floor, and you're pleased to find that no fluffing is required.  You proudly take a dick pic and send it to her.
* [Engage Dom mode (make her cum, then jerk off)]
    "Rub your pussy, round and round... nice and slow..."
    ->p1("Wait while she obeys") ->
    "Keep going... a little faster now."
    ->p1e("You hear her moan quietly") ->
    <>, and she starts to speak: "Mmm, I'm getting so wet down there..."
    ->p1("Tell her to shut up and keep going") ->
    "Shh.  No talking. Start patting your clit, very lightly..."
    ->p1("Wait while she obeys") ->
     ->p1e("\"Faster\"") ->   
     <> you say, your voice quiet, but firm.
     ->p1e("\"Faster.\"") -> 
     <> You're still speaking quietly, but with a intense, commanding tone.
     ->p1e("\"Stop.\"") ->  
     You hear her panting.  She's obeying you.
     "Now, my cock is very big, and it's rock hard. And it's ready to skewer you."
     ->p1e("\"Are you ready for my dick, {msg_name(ANGIE)}?\"") ->  
      ->p1e("\"Yes.\"") -> 
     "Good girl. Now push your fingers inside you. Deep.  How many fingers?"
     + +  (choices) ->
         * * * [One] 
            "One", she says.
            "Wrong". -> choices
         * * *  [Two]
            "Two."
            "Wrong". -> choices
         * * * [Three]
            "Three," she gasps.
            "Good girl.  Do it."
            "Now, I'm plunging my big, hard, dick deep inside you now, and I'm fucking your tight, wet, pussy.  Fast and hard.  Faster... Faster..."
            ->p1e("\"Faster...\"") ->
            ->p1e("\"Faster...\"") ->
            You hear her squeal.
            ->p1("End the call") ->
            You end the call.  That ought to do it.  You start to jerk off, but after three strokes you cum. "Damn," you say to yourself, wiping your knuckles on the towel.
         - - -
     - -
* [Engage Sub mode (cock-sucking)]
>>> TODO
TODO: Angie shower sub mode    
-
~ setstat(angie_relationship, high)
->->

= respond_to_taunt(msg, t, args)
//~ IN_CALLBACK = false
{do_taunt_fear:
    - 1: "Thanks for that, Angie, so damn deep. As deep as a fucking fortune cookie," you say to yourself.
    - 2: Please stop.
    - else: >>>  TODO
}
-> cont ->
->->
= do_taunt_fear(response_type)

 -> wa.m_cb("{once:
    - Never let fear get the better of you.
        -> Taunt.set_frequency(6) ->
    - To love at all is to be vulnerable. Love anything and your heart will be wrung and possibly broken.
    - The greatest mistake you can make in life is to be continually fearing you will make one.
    - Love is what we were born with. Fear is what we learned here.
    - You can’t always wait for the perfect time. Sometimes you have to dare to do it because life is too short to wonder what could have been.
    - The only thing we have to fear is fear itself.
    - The best thing to hold onto in life is each other.
    - In the end, we only regret the chances we didn't take.
    - -> Taunt.remove(angie_taunt_fear) ->
 }", ANGIE + WAM_CHOOSE + cmd_cb, ->respond_to_taunt) ->
 

->->

= first_time_at_your_place
You have sex for the first time.
-> ffa(hour, 2) ->
Angie leaves.
~ angie_location = location_angie_apartment

->->




