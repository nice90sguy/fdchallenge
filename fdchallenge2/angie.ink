
/*
    Angie story:
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
=== Angie

= cafe_meeting_invite
{_DEBUG:>>> SENT INVITE}
    ~ temp meeting_t = next_hm(11,0)
    -> wa.m_cb("Hi there {sq(angie_relationship == high):sexy}. Fancy meeting up for a coffee sometime today? Say, eleven?", WAM_MISS + ANGIE_FULL_NAME + cmd_meet + location_cafe + num2list(meeting_t), ->Angie.meet_in_cafe) ->

    
->->
/*
This is a "callback" that never returns.
At the beginning, set IN_CALLBACK to false, do stuff, then tunnel on to grind.after_activity
*/
= meet_in_cafe

~ IN_CALLBACK = false

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
        "Half and hour, max," you say.
        "Make it fifteen minutes, and I'll still be here."
        You jump in an Uber and get there in fifteen minutes.
        -> cc.pay("Uber", 10, true) ->
        -> ffa(minute, 15) ->
    }
    ~ location = location_cafe
    You walk into the cafe and see her there.  She smiles and waves, and you sit down opposite her. 
    "I'm so sorry, I just caught up in things, and lost track of time!"
    You sit down opposite her, and look at her. 
    ->  slug_cafe_meeting ->

- else:
    Angie walks in and looks around. She sees you and smiles.
    She sits down  opposite you and takes off her jacket. 
    ~incstat(angie_relationship)
    ->  slug_cafe_meeting ->


}
~ IN_CALLBACK = false
-> grind.after_activity

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

    -> ffa(hour, 1) ->
    -> cont ->
->->
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
    * [Give her your real number]
        You give her your number, with a vague sense of foreboding.
        -> wa.m_cb("Hi", WAM_SILENT+WAM_MISS+ANGIE_UNKNOWN+WAM_CALLBACK,  ->respond_to_angie_hi) ->
        ~ setstat(angie_relationship, low)
    -

    




->->

= respond_to_angie_hi
>>> angie_relationship: {list2num(angie_relationship)}% ({sq(angie_relationship)})
    You look at the time of the message, and figure out it must be from {msg_name(ANGIE)}.  Checking your notepad, you confirm it.
    Great.  But you're not going to call her back.  Wait a couple of days. Play it cool.
    -> cont ->
->->
// You've just come out of the shower
= phone_sex
You reply to her message.
{M_wa_S(YOU)} hi {msg_name(ANGIE)}.  :)
->ffa(minute, 2)->
-> cont ->
You've just finished drying off, when your phone starts buzzing. She's calling you right back! You <>
-> p1e("answer it") ->
<>.

"Hello, {YOUR_NAME}! I thought you wouldn't reply to my message," she says.
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
    
-
~ setstat(angie_relationship, high)
->->

= first_bar_meeting

"Hi there," you say to her, but she's engrossed in her laptop.
You stand there for a moment, looking at her now from close range, then you remember: Her name's {msg_name(ANGIE)}.  Of course, you sat next to her on the plane!

Now that you're confident that she's not a random stranger, you <>
+ raise your voice
+ tap her on the shoulder
+ shut the lid of her laptop
- 
<> and say, "Hi, {msg_name(ANGIE)}."
~ state_flags += gs_with_angie
"Hello, {YOUR_NAME}, What a coincidence!"
You have a nice time with her.

~ setstat(angie_relationship, medium)
{_DEBUG:>>> {angie_relationship}}
{_DEBUG: >>> {DispStat(angie_relationship)}}
    ~deltastat(confidence, 3)
    ~deltastat(addiction, -3) 
    ~deltastat(obedience, -3) 
    -> ffa(hour, 2) ->
~ state_flags -= gs_with_angie
->->

= subsequent_bar_meeting
~ state_flags += gs_with_angie
TODO angie  subsequent meetings, might change below stats
// subsequent meetings
~ incstat(angie_relationship)
You hang out with {msg_name(ANGIE)}.
{_DEBUG: >>> {DispStat(angie_relationship)}}
~incstat(confidence)
~decstat(addiction)    
-> ffa(hour, 2) ->
~ state_flags -= gs_with_angie



->->

= yandere
TODO Yandere
>>> Yandere
->->

