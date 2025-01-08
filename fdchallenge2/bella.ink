=== Bella ===
LIST bella_taunts = bella_taunt_send_pic_and_repeat_after_me,bella_taunt_tribute, bella_taunt_addiction, bella_taunt_humiliate, bella_taunt_dick_pics

LIST hovel_taunts = bella_taunt_spend

VAR num_dick_pics_to_send = 0
->->

/*
After you remorgage your flat, Bella "suggests" you sell your house.
She rents out a bedset to you at a ridiculously high daily rent, and her tributes
increase.
*/

VAR old_timer_cb = 0

// In hovel, bella wakes you at 9 AM with your instruction for the day
= daily_instruction


->p1e("{warn()} It's <b>{l0(tm_hour)}:{l0(tm_min)}. </b> Your phone's ringing!") ->
->p1("Answer it 📞") -> 
    You answer it.
{daily_instruction:
    -1: 
        -> M_chat("Good morning, slave.", now()-1800, (), ->null_cb ) ->
        -> M_chat("Here are your instructions for the day:", now()-1700, (), ->null_cb ) ->
        "Log on now."  You haven't heard her speaking to you since that night in New York.  Her voice instantly triggers you, and you're immediately hard.
        -> M_chat("Send me your full bank details, including cards, CCW etc, for all yr accounts", now()-1700, cmd_cb, ->obey_1 ) ->
        // exits this stitch here
        -> wa.m("Logon Now.", WAM_CONTINUOUS + cmd_logon + cmd_noemit) 
    -2:
        "Good morning, sleepyhead!"
        "Good morning."
        "Get naked."
        -> p1("Obey") ->
        "My God, look at that erection!"
        -> cont ->
    -else:
        "{Do you like your new home?|Happy?|Love me?|Enjoying your new life?|Spend all day naked.|I want you to clean the apartment today.|Go have a shower.|Isn't it a lovely morning?}"
        -> p1e("\"{Yes Goddess|Yes Bella.}\"")->
        "Good boy.  Speak tomorow, byeee!"

}
-> p1("She ends the call.") ->
->->



= obey_1
You spend the next ten minutes sending her all you bank details.
~ set_bella_online(true)
{bella_chat()} check its all correct
-> p1("Check all the details are correct") ->
~ cost_per_message = 0
its all correct, {BELLA_NAME} {you_chat()}
{bella_chat()} you don't need to type. I can hear you, remember? And see you 🤣
{bella_chat()}  one minute i will test 
-> ffa(minute, 10) ->
You wait.
-> cc.pay("Saks Fifth Avenue", 775, true) ->
-> cc.pay("Embraceable Me Clothing", 1560, true) ->
-> cont ->
{bella_chat()} yep looks good. Bye
~ set_bella_online(false)
-> Taunt.set_frequency(5) -> Taunt.clear -> Taunt.add(bella_taunt_spend) -> Taunt.do


->->
// Randomly spending your money
= do_bella_taunt_spend(response_type)
{not bella_online():
    // Only spend when offline
    { RANDOM(1,12):

        -2: 
        // Books
        -> cc.pay("{~Borders Books|Fetish Comix Store|Jim's Antiquarian Books|Folio Rare Books}", RANDOM(10,50) * RANDOM(5,7), true)
        -3:
        // Art
        -> cc.pay("Sothebys", RANDOM(10,25) * 1000, true) ->    
        -4 :
        // Misc
        -> cc.pay("Amazon", RANDOM(10,25) * 23, true) ->   
        -5: 
            // Food
        -> cc.pay("{~Dilshads Deli|Green Fingers|Pole and Line Seafood|Butcher and Baker}", RANDOM(10,20) * RANDOM(2,4), true) 
        -6:
            // Dining Out
        -> cc.pay("{~Nobu|Nobu|Nobu|Pearl Restaurant|Ginos Sicily|Kerala Rice|Paddys Bar|Paddys Bar|Paddys Bar|Rooftop Bar and Grill}", RANDOM(250, 1000), true)    
        -7:
            // Beauty
         -> cc.pay("{~Eve Perfumier|Tiffany|Mac Beauty|Victorias Secret}", 100 * RANDOM(25, 100), true)   
         -8:
              -> cc.pay("{~Saks Fifth Avenue|Embraceable Me Clothing|Dior Paris|Victoria Alperton Couture}", 5 * RANDOM(250, 1000), true)      
        - else:
            -> cc.pay("{~Starbucks|Peets Coffee|MunchHousen|Cha Cha Chai}", RANDOM(2,3) *5, true) -> do_bella_taunt_spend(response_type)
    }
}
->->
= become_her_tenant
// First call, schedule convo

{become_her_tenant == 1:
    ~ old_timer_cb = set_timer_cb(2 * about_an_hour(), ->become_her_tenant)
{_DEBUG:>> SCHEDULED MESSAGE}
    ->->
}
{_DEBUG:>>> TEST {not need_more_money or not grind_banking.remortgage or become_her_tenant> 2:NOT} PASSED TO BECOME BELLA'S TENANT}

-> wa.m("We need to talk",WAM_READ+WAM_PAUSE, ) ->
She sounds serious.  You respond instantly:
{M_wa_S(YOU)}ok

{M_wa_S(BELLA)} I have a suggestion...

-> p1("Wait for her to continue") ->
{M_wa_S(BELLA)} you own your place, right
-> p1("Uh-oh...") ->
{M_wa_S(YOU)}yes
{M_wa_S(BELLA)} How much is it worth?
~ temp price = 0
* [Tell her the truth]
    ~ price = 500000
    {M_wa_S(YOU)}i guess around three-fifty.
    {M_wa_S(BELLA)} Is that all?  😆
    {M_wa_S(YOU)}maybe more, i'm not sure {BELLA_NAME}
    -> p1e("{M_wa_S(BELLA)} sell it to me.") ->
    {M_wa_S(YOU)}What??
    {M_wa_S(BELLA)} I'll offer you 500K for it. cash.
    -> p1e("You're unable to reply") ->
    <>, you're too stunned by her sudden generous offer.
* [Inflate the price]
    ~ price = 350000
    {M_wa_S(YOU)}i guess around five hundred thousand.
    -> p1e("{M_wa_S(BELLA)} sell it to me.") ->
    {M_wa_S(YOU)}What??
    {M_wa_S(BELLA)} I'll offer you 350K for it. cash.
    -> p1e("You're unable to reply") ->
    <>, you're too stunned by her sudden offer. And she got its value right on the nose.  She's obviously been doing her research.
-
-> cont ->
{M_wa_S(BELLA)} Do it.
-> p1e("Hesitate, there has to be a catch") ->    
{M_wa_S(BELLA)} do it, {YOUR_NAME}.    
-> p1("Agree") ->    
{M_wa_S(YOU)}Ok.
{M_wa_S(BELLA)}But there's one condition 
-> p1("I knew it") ->
-> p1("Bella is typing...") ->
-> p1("and typing...") ->
{M_wa_S(BELLA)} you must agree to move out of your place tonight, into a new place. I'm gonna give you the address and where to pick up keys from. its one of my London properties that i reserve specially for my fans who visit there, but im letting you stay there instead.
{M_wa_S(BELLA)}  it has security cams so i can check on you 24/7.  later we will arrange for you to move your stuff. but for now, you have to stay there. now, i bet you want to know why im doing all this for you, don't you?
-> cont ->
It sounds like she wants to keep you prisoner there, but so what if there's security cams? You can just leave, it's not like she can do anything about it.  {price == 500000:And you'll have made 150k over the value of your flat.  You can just go out and buy a nicer one!}
{M_wa_S(YOU)}Because... you like me?
{M_wa_S(BELLA)} That's right. I like you, and I'm proud of the way you're learning to appreciate the value of money.
-> p1e("{M_wa_S(BELLA)} so we have a deal.") ->
{M_wa_S(YOU)}Yes
{M_wa_S(BELLA)} Ok. I made the transfer now. Get going. I just sent you details
-> cc.receive(BELLA_FULL_NAME, price, true) ->
-> cont ->
You check your account, and sure enough, she's transferred the money, just like that! How rich is she, actually, to be able to spend that much money as though it was small change to her?  

In a daze, you pack a suitcase and your backpack and pick up the key to her place. To your consternation, it's at a local newsagent.  You tell the guy that {BELLA_FULL_NAME} sent you to collect a package, and he hands you an envelope with a key, and an address. 

You take the tube to a run-down suburb, and find the place. It's a tower block, built in the 1960's, in a state of disrepair.  The elevator works, but stinks of piss.  You notice a syringe on the floor of the lift as it clanks and whines and slowly takes you up to the tenth floor.
You walk along the outer walkway, passing doors boarded up with metal sheeting, until you get to the place. You walk in.
-> cont ->
To your surprise, it's not as bad as it looks from the outside.  It's a single, large room, with a single bed in the corner, a kitchen area, and a bathroom.  Although the furniture is basic, it's clean and the fixtures and fittings all work. 
You feel a sense of gratitude and relief that the place isn't as bad as you feared.
You investigate the cutlery in the kitchen drawers.  When you open the fridge, it's empty, except for a bottle of Champagne.
-> wa.m("Take it out", WAM_READ) ->
You're shocked. How did she know? 
You look around wildly, expecting to see her there.  Then you notice the cams in the foor corners of the ceiling.  
{M_wa_S(BELLA)} You saw the cams 📹
{M_wa_S(BELLA)} Take it out, i said.  Read the label.
You do as she says, and read the label.
{M_wa_S(BELLA)} Say it aloud. I have audio as well as video.
"Armand de Brignac Blanc de Noirs".

{M_wa_S(BELLA)} Recognize it?
"Yes."
{M_wa_S(BELLA)} Pay me for it. ${LIST_VALUE(ace_of_spades)}.
-> cont ->
-> cc.pay(BELLA_FULL_NAME, LIST_VALUE(ace_of_spades), true) ->
{M_wa_S(BELLA)} Good boy. Now open it. And drink a toast to your Goddess
-> p1e("You do as she says") -> 
<>, and raise your glass to the ceiling cameras. You gulp down the Champagne.  It's amazing, the best drink you've ever tasted.

-> cont ->
{M_wa_S(BELLA)}Again.
You fill up you glass, feeling light-headed, and drink it as a single gulp.
{M_wa_S(BELLA)}Finish it.  Go on, you deserve it, my Good boy
You drink again... and again... 
Unsteadily, you try to put the empty bottle back onto the counter, but you miss, and the bottle falls onto the floor and rolls away.
In a daze, you stumble onto the bed, and pass out.
~ _ffd(1)
~ current_activity = sleep
~ setstat(sleepiness, max)
~ setstat(addiction, max)
~ setstat(obedience, max)
~ setstat(confidence, min)
~ cost_per_message = cost_per_message * 10
~ location_home = location_hovel
~ location = location_home
~ need_more_money = false
-> Taunt.clear() -> Taunt.add(hovel_taunts) -> Taunt.set_frequency(12) ->

-> grind.after_activity

 
= name
Bella
->->
= do_taunt_dick_pics(response_type)
    -> Taunt.remove(do_taunt_dick_pics) -> // Only once
    {response_type ^ (WAM_READ + WAM_CHOOSE):
     -> wa.m("Send me a pic of your dick.", response_type + Addiction) ->
        ~incstat(lust)
    {warn()} Obeying her will seriously mess up your life for the next 24 hours, and you'll never be the same again!
     -> intent.allow_disobey_below_obedience_threshold(medium) ->
     {obeyed_cmd:
        {location:
            - location_gym: You run into the toilet, push down your gym shorts and take a photo of your dick.
            - location_bar: You run into the toilet, undo your pants and take a photo of your dick.
            - else: 
                {current_activity == sleep: 
                    You grab the phone from the bedside table,  and take a photo of your boner.
                 - else: You unzip your fly and haul out your hard dick.  You take a pic and send it.
                }
                
        }
        -> ffa(minute, 2) ->
        {M_wa_S(YOU)} (img0001.jpg)
        {M_wa_S(BELLA)} Send me one every hour, on the hour, for the next 24 hrs.  Every time you fail, you have to pay  $100. UNDERSTAND??"
        {M_wa_S(YOU)} {Yes, Bella|yes i understand|yes mistress}
        {M_wa_S(BELLA)} Oh, one more thing...
        -> cont ->
        {M_wa_S(BELLA)} Make sure you're nice and hard every time. 😈
        -> cont ->
        ~num_dick_pics_to_send = 24
        {think()} (Fuck...)
        -> cont ->
        You set an hourly alarm on your phone.
        -> cont ->

     }
    }
    

->-> 

= dick_pic_challenge
->p1("It's {ampm()}! {Hurry up and send that pic!|You know what you have to do!|Damn...|Oh boy...|Obey!|Just do it.|Oh my God|}") ->
~ num_dick_pics_to_send--
~ incstat(addiction)
~ decstat(confidence)
~ incstat(obedience)

{location:
    - location_gym: You run into the toilet, push down your gym shorts and take a photo of your dick.
    - location_bar: You run into the toilet, undo your pants and take a photo of your dick.
    - else:
        {current_activity == sleep:
            You grab the phone from the bedside table,  and take a photo of your boner.
        - else: 
            { num_dick_pics_to_send:
             -23:  You unzip your fly and haul out your hard dick.  You take a pic and send it.
             -22: It takes only a few strokes to get hard. You take a photo of your cock.
             -21: You stroke your cock frantically until it's sort of hard. You're beginning to get an idea that this might be a difficult challenge...
             -20: How many more to go? (strokes)
             -19: You pump your dick and do your duty...
             -12: Like Pavlov's dog, at the sound of the alarm, your cock springs to attention.  You take a photo.
             -10: You're fully trained now.
             -8: Obey.
             -6: I belong to Bella.
             -4: My cock is no longer under my control.
             -2: This is my new life.
             -0: Is this the last one? I don't want to stop.
             -else: You take another dick pic.
               
            }
           
        }
        
}
{num_dick_pics_to_send == 0: -> p1("Well done, you made it through the challenge! But at what cost?") ->}


->->
= do_taunt_addiction(response_type)

    {response_type ^ (WAM_READ + WAM_CHOOSE):
     -> wa.m("{You love me|No escape|Good boy|💋|😈|welcome to My world  👑| your reprogrammed|human atm|good slave|hi slave}", response_type+ Addiction) ->
        You feel an aching desire for her.
        ~incstat(lust)
    }
    

->-> 
= do_taunt_humiliate(response_type)

    {response_type ^ (WAM_READ + WAM_CHOOSE):
     -> wa.m("{kneel|jerk to my pics|say I'm a pathetic loser|kiss my shoes|worship Me|Lie on yr back. {~i want to|beg me to|im gonna} {~piss|shit|spit} in your mouth}", response_type + Confidence + Addiction ) ->
        The message triggers you...
        ~incstat(lust)
        -> intent.allow_disobey_below_obedience_threshold(medium) ->
        {obeyed_cmd: 
            You can't help but obey.
        - else:
            You manage to resist.
            ~decstat(addiction)
        }

    
    }
    

->->

// Bella sends you a pic, then does "repeat" commands
= do_taunt_send_pic_and_repeat_after_me(response_type)
    // HACK:  All possible items minus available items will give a media item which, when looked up,
    // won't be found.  The default for media items that are not in the index is to categorized as a photo.  See the -else statement in the long "switch" statement in lookup_media.
    ~ temp available_photos = LIST_INVERT(available_items)
    
    { available_photos == ():
>>> {BELLA_NAME} has no more photos to send!
        ->->
    }
    -> wa.m("💋", response_type + cmd_send_item + LIST_RANDOM(available_photos) +  photo  + Lust) ->
    {response_type ^ (WAM_READ + WAM_CHOOSE):
        -> wa.m("{How hot?|lol i bet your drooling 🤤|Stare and go dumb|So weak...|Complete surrender.}", WAM_CONTPAUSE + Submissiveness) ->

        -> wa.m("{thank you|I love you|I'm {BELLA_NAME}'s loser|No escape.|\{BELLA_NAME\}}", WAM_CONTINUOUS + cmd_repeat_after_me + Confidence) ->
        {not obeyed_cmd: ->taunt_disobeyed->->}
        -> wa.m("Again.", WAM_CONTINUOUS + cmd_again + Submissiveness) ->
        {not obeyed_cmd: ->taunt_disobeyed->->}
        -> wa.m("{Good boy. Again|Keep going|repeat 💋}", WAM_CONTINUOUS + cmd_again + Submissiveness) ->
        {not obeyed_cmd: ->taunt_disobeyed->->}
        -> wa.m("{Again!|more|and again|Again.}", WAM_CONTINUOUS + cmd_again + Submissiveness) ->
        {not obeyed_cmd: ->taunt_disobeyed->->}
        -> wa.m("{Good boy.|You 😍 me lol|So fuckin pathetic}", WAM_CONTPAUSE + Submissiveness + Lust + Confidence) ->
        
        ~incstat(lust)
        ~incstat(addiction)
    }


->->
= taunt_disobeyed
-> wa.m("{~Ah sweet, trying to resist 💋|lol You know you can't win|So weak...|Your cock is mine, don't fight it lol|Resistance is futile lol}", WAM_CONTPAUSE) ->
    ~ decstat(obedience)
    ~ incstat(confidence)
    ~ decstat(addiction)
->->

// Bella sends you a pic, then does "repeat" commands
= do_taunt_haggle_game(response_type)
    ~ temp cmd = cmd_haggle_game
    ~ temp v = RANDOM(10,25) * 10
    ~ temp msg = "It's crazy deal time!"

 -> wa.m(msg, response_type + num2list(v) + cmd) ->
->->

= do_taunt_tribute(response_type)

    ~ temp cmd = cmd_tribute+Submissiveness+ cmd_noemit
    // Tribute round number close to half his assets
    ~ temp v = _cc / 2
    ~ v = v / 10
    ~ v = v * 10

    {
      - v < 100: 
        ->-> // don't demand tribute
      - v > 10000:
       ~ v = 10000
      - v > 1000:
        ~ v = 1000
      - v > 500:
        ~ v = 500
      - else:
        ~ v = v
    }
    ~ temp msg = "Show me how obedient you are. Send me ${comma_ify(v)} now"
    ~incstat(addiction)
 -> wa.m(msg, response_type + num2list(v) + cmd) ->

    ~decstat(addiction)

 ->->
 
// Work proposition from Al and from Bella 


VAR tagged_videos = ()
VAR untagged_videos = ()
VAR skipped_videos = ()

= work_proposition
-> wa.m("We need to talk",WAM_READ+WAM_PAUSE) ->
You don't know what she means, but you suddenly feel dread.  She's definitely serious about something.  You respond quickly:
{M_wa_S(YOU)}Ok.

{M_wa_S(BELLA)} You're a tech guy arent you
You're not sure where she's going with this:
-> cont ->
{M_wa_S(YOU)}Yes.
{M_wa_S(BELLA)} i have a great job for you
You wait for her to go on. The app shows that she's busy typing...
-> cont ->
...and typing...
-> cont ->
-> ffa(minute, 3) ->
Eventually you get a long message from her:
{M_wa_S(BELLA)} 
I have some videos on my site that need their tags checked, there are a lot of them.  Some of them will also need to be converted to .mp4 files.  i will pay you for the work of course,  a fair rate, dont worry.  you need to start today. i will send you the links to the files in a minute and then you can start immediately.  i suggest you empty your balls before you start work from now on, you will not be very productive otherwise lol
{M_wa_S(BELLA)} the work won't take long, if you do it non stop. I'll pay you ${payment_for_correct_video_tag} per video if you tag them correctly. 
{M_wa_S(BELLA)} oh in case you were wondering, no you dont have a choice and yes, im serious about all this.  
{M_wa_S(BELLA)} any questions?


{M_wa_S(YOU)}no

{M_wa_S(BELLA)}good. start now
~ employer = bella_org
-> cont ->
That seems to be the end of that conversation.
~ available_employers = bella_org
{hint()}  Choose "Work for {BELLA_NAME}" from the activity menu!


-> search_media(video, LIST_ALL(media), untagged_videos) ->

// Number of videos: {LIST_COUNT(untagged_videos)}

// Total cost of videos: {LIST_TOTAL(untagged_videos)}
// ~ temp video_ = LIST_RANDOM(untagged_videos)
// -> tag_a_video(video_) ->

->->

VAR payment_for_correct_video_tag = 100

==  tag_a_video(video_)
~ temp lum_arg = ()

->lookup_media(video_, lum_arg) ->
{_DEBUG:>>> (CHEAT)<i> Media Info = {lum_arg}}
~ temp actual_tags = (lum_arg ^ LIST_ALL(search_tags))-video

{_DEBUG:>>> Video: ({video_})}
    -> ffa(minute, 5) ->
    ~ lum_arg = lum_desc
    It's titled: "<> ->lookup_media(video_, lum_arg) ->
    <>"
+ [Make a wild guess at the tags]
    -> ffa(minute, 5) ->
+ [Watch the video first]
    ~ lum_arg = lum_narr
    ->lookup_media(video_, lum_arg) ->
    -> ffa(minute, 15) ->
    ~ incstat(lust)
+ [Come back to this one later] ->
    -> list_utils.move_item(video_, untagged_videos, skipped_videos) ->-> 
-
-> ffa(minute,10) ->
~ temp guessed_tags = ()
~ temp num_actual_tags = LIST_COUNT(actual_tags)

The video has {print_number(num_actual_tags)} tag{num_actual_tags!=1:s}.
-> multiselect(LIST_ALL(search_tags)-photo-video, guessed_tags, num_actual_tags, num_actual_tags, "tag") ->
~ temp matched_tags = actual_tags ^ guessed_tags
~ temp num_wrong_tags = num_actual_tags - LIST_COUNT(matched_tags)
{num_wrong_tags:
    - 0:
        ~incstat(confidence)
        ->cc.receive(employer_name(), payment_for_correct_video_tag, true) ->
        -> list_utils.move_item(video_, untagged_videos, tagged_videos) ->
        Right!  {print_number_c(LIST_COUNT(tagged_videos))} down, {print_number(LIST_COUNT(untagged_videos)+LIST_COUNT(skipped_videos))} to go!
        ->->
    
    - num_actual_tags:
        ~decstat(confidence)
        You were way off the mark with your guesses!     
     -else:
        You got {list_with_commas(matched_tags)} right, but the other {print_number(num_wrong_tags)} {num_wrong_tags==1:was|were} wrong. You'll need to come back to it later.

}
// only reach here if not all correct   
-> list_utils.move_item(video_, untagged_videos, skipped_videos) ->->   

->->

// Bella now speaks to you directly.
= do_taunt_hovel
{warn()} Your phone is ringing! 
-> p1("Answer it") ->

{do_taunt_hovel:
- 1: 
    "Put your phone on speaker."
    -> p1("Obey") ->
    "Good boy."

- else:
    TODO  taunt hovel
}
->->




