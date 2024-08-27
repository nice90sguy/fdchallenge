

LIST fansite_activities = fsa_add_credits, fsa_chat, fsa_shop, fsa_video_session, fsa_tribute, fsa_logout


// This hack is so that "logout" can be called from anywhere.
// The way the activity builder is designed, it makes it hard to use redirects as tunnel params, because they need to get propagated
VAR fansite_return_to = ->grind.after_activity
=== fansite
{fansite == 1 and fansite_return_to == ->grind.after_activity:
{bella()} Welcome to My Fan Page! I'm sure you'll be here a lot!

The first thing you need to do is to add some credits, it looks like you don't have any yet!  You won't be able to do much here unless you have plenty of them!
I suggest you purchase as many credits as you can, because the more you buy, the cheaper they are!
That's your first lesson in money management, and guess what, I gave it to you for free! Ain't I  generous? 

I'm usually online here between {ampm_hm(bella_online_start_hour, 0)} and  {ampm_hm(bella_online_end_hour, 0)}.

But even when I'm not here, there's plenty to do!

You can browse my amazing pics and videos and other merch in My shop.  Or if you're feeling weak, you can always tip Me.  That will make Me <i>really</i> happy; and, therefore, of course, it will make you happy too. Win win!!

When I'm online, you can chat with Me.  But make sure you always greet Me first.  And you know what I mean by "greet".  If you don't, you soon will 🤣

If I like you, you can even book a private, one on one video session with Me! I charge by the minute, so make sure your credits are topped up before you do that, or I might ban you from this site indefinitely!  Just remember, Time is Money.  My time, your money.

Welcome, and congratulations for being one of My SUPER FANS!!


-> cont ->

}



-> build_opts

 {_DEBUG:>>> END FANSITE}
->->

= build_opts
Time: {l0(tm_hour)}:{l0(tm_min)} <> ->bella_status-> 
<i> Credits: {credits}
+ (opts) ->
~ possible_activities = ()
// Always allow logout
~ possible_activities += fsa_logout
// Always allow adding credits
~ possible_activities += fsa_add_credits
// Always allow tribute
~ possible_activities += fsa_tribute
// Always allow shop
~ possible_activities += fsa_shop
// Only allow chat if enough credits
{credits >= cost_per_message:
~ possible_activities += fsa_chat
}
 + + (do) ->

    {possible_activities ? fsa_chat:<- fansite_chat.opt}
    {possible_activities ? fsa_add_credits:<- fansite_add_credits.opt}
    {possible_activities ? fsa_tribute:<- fansite_tribute.opt}
    {possible_activities ? fsa_shop:<- fansite_shop.opt}
    {possible_activities ? fsa_logout:<- fansite_logout.opt}
    

 - -
-
+ (after_activity) ->
        -> cont ->
   -> fansite
-


-> fansite
->->

= bella_status
{bella_online(): 💗|🩶} <i>{BELLA_NAME} is {bella_online(): online!|offline.}</i><>
->->

CONST bella_online_start_hour = 22
CONST bella_online_end_hour = 8
VAR bella_online_now = false

== function bella_online()
    ~ return bella_online_now
== function set_bella_online(online)
{online != bella_online_now:
    {hint()} {BELLA_NAME} has {online:come online!|gone offline.}
    ~ bella_online_now = online
}
    
== fansite_logout
= opt
+ + (do) [Log out] ->
    {chat_offline_messages != "":
    
        {warn()} You can't log out until you read your offline messages!
        -> fansite.after_activity
        
    }
    // If you have any credits, you have to tribute her once per day
    {credits and not (activities_done_today? fsa_tribute):
        {warn()} You can't end your first session of the day without tipping her first!
        -> fansite.after_activity
    }
    
    -> fansite_return_to
    

== fansite_tribute
= opt
~ temp tx_result = ()

+ + (do) [Tip Me! 💵] ->
    ~ temp tip_amount = sqi(addiction) // quantized addiction level as number
    + + + [{tip_amount} credits] -> 
    + + + [{tip_amount * 10} credits] -> 
     ~ tip_amount = tip_amount * 10
    + + +  {credits} [All your credits] -> 
        ~ tip_amount = credits


    - - - -> fansite_credits.pay(tip_amount, tx_result) -> 
    {tx_result ? FS_TX_SUCCESS:
        {That felt good.|You want to do that again.|Pay more.}
        ~ incstat(addiction)
        ~ decstat(confidence)
        {sq(addiction) >= high:
            ~ incstat(lust)
        }

    }
    ~ activities_done_today = fsa_tribute
    -> fansite.after_activity
    

    