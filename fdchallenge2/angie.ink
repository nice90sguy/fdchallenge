

=== Angie

= plane_meeting
A woman sits in the next seat to you.  She's very nice-looking, with a big smile and great legs, which you notice while untangling your seatbelt from hers.  You end up talking with her. Her name's {msg_name(ANGIE)}. You watch a couple of inflight movies together, laughing at the same places in the movie.  You're obviously suited, with the same sense of humor; and she wants to exchange numbers. 

You reach for your phone in your backpack, but it's not there.  Fuck, did you leave it at the hotel? No, you distinctly remember packing it. Oh yeah, you put it in your suitcase which has gone in the hold. <>
    You get her to write down her number in your notepad, old-school.



->->

= first_bar_meeting

"Hi there," you say to her, but she's engrossed in her laptop.
You stand there for a moment, looking at her now from close range, then you remember: Her name's {msg_name(ANGIE)}.  Of course, you sat next to her on the plane!

Now that you're confident that she's not a random stranger, you 
+ raise your voice
+ tap her on the shoulder
+ shut the lid of her laptop
- 
<> and say, "Hi, {msg_name(ANGIE)}."

    You have a nice time with her.
    ~ setstat(angie_relationship, medium)
>>> {angie_relationship}
 >>> {DispStat(angie_relationship)}
    ~deltastat(confidence, 3)
    ~deltastat(addiction, -3) 
    ~deltastat(obedience, -3) 
    -> ffa(hour, 2) ->
- else:
    TODO angie  subsequent meetings, might change below stats
    // subsequent meetings
    ~ incstat(angie_relationship)
    You hang out with {msg_name(ANGIE)}.
    >>> {DispStat(angie_relationship)}
    ~incstat(confidence)
    ~decstat(addiction)    
    -> ffa(hour, 2) ->



->->

= yandere
TODO Yandere
>>> Yandere
->->
// Opts for bar encounters
=== angie_bar

= opt

{opt:
// First time
    -1:
    You see a familiar-looking woman at a table, working on a laptop. You try to remember where you know her from.
    
// The second read-count of angie_bar.opt will always occur on the same night if you DON'T say hi to her, because meeting either the regulars of Al will end with looping the opts in the bar for that night.
//  If you do talk to Angie, then read-count will be 2 on the next time you go to the bar, but Angie.first_bar_meeting will be true, so the follwing text will not be emitted. <phew>
    - 2:
        That woman is here again.  You really should go and talk to her.
    - 3:
    {not Angie.first_bar_meeting: You look around the bar, and notice that the woman with the laptop isn't here tonight.}
}

+ + (do) {opt < 3} [Go and talk to her] 
        ->  Angie.first_bar_meeting -> 
        ~ activities_done_today += (ba_with_angie,socialize)
        ->bar_return_home
