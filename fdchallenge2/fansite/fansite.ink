

LIST fansite_activities = fsa_add_credits, fsa_chat, fsa_shop, fsa_video_session, fsa_tribute, fsa_logout

VAR force_fansite_activity = false
=== fansite
{fansite == 1:
{bella()} Welcome to My Fan Page! I'm sure you'll be here a lot!

The first thing you need to do is to add some credits, it looks like you don't have any yet!  You won't be able to do much here unless you have plenty of them!
I suggest you purchase as many credits as you can, because the more you buy, the cheaper they are!
That's your first lesson in money management, and guess what, I gave it to you for free! Ain't I  generous? 

I'm usually online here between {ampm_hm(bella_online_start_hour, 0)} and  {ampm_hm(bella_online_end_hour, 0)}.

But even when I'm not here, there's plenty to do!

You can browse my amazing pics and videos and other merch in My shop.  Or if you're feeling weak, you can always tribute Me.  That will make Me <i>really</i> happy; and, therefore, of course, it will make you happy too. Win win!!

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
{_DEBUG: >>> forced_activity = {force_fansite_activity}}
    { possible_activities ? fsa_chat:

        {force_fansite_activity:
            -> fansite_chat.do
        -else:
            <- fansite_chat.opt
        }
    }
    { possible_activities ? fsa_add_credits:
        {force_fansite_activity:
            -> fansite_add_credits.do
        -else:
            <- fansite_add_credits.opt
        }
    }
    { possible_activities ? fsa_tribute:
        {force_fansite_activity:
            -> fansite_tribute.do
        -else:
            <- fansite_tribute.opt
        }
    }
    { possible_activities ? fsa_shop:
        {force_fansite_activity:
            -> fansite_shop.do
        -else:
            <- fansite_shop.opt
        }
    }
    { possible_activities ? fsa_logout:
        {force_fansite_activity:
            -> fansite_logout.do
        -else:
            <- fansite_logout.opt
        }
    }

 - -
-
+ (after_activity) ->
    {not force_fansite_activity:
        -> cont ->
    }
    // force activity is one-shot
    ~ force_fansite_activity = false
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

    ~ force_fansite_activity = false
    
    -> grind.after_activity
    

== fansite_tribute
= opt
~ temp tx_result = ()
~ temp price = 0
+ + (do) [Tribute 💵] ->
    + + + [100 credits] -> 
        ~ price = 100
    + + +  {credits} [All your credits] -> 
        ~ price = credits


    - - - -> fansite_credits.pay(price, tx_result) -> 
    {tx_result ? FS_TX_SUCCESS:
        {That felt good.|You want to that again.|Pay more.}
        ~ incstat(addiction)
        ~ incstat(lust)
    }
    -> fansite.after_activity
    

    