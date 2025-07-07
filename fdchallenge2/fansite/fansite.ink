

LIST fansite_activities = fsa_add_credits, fsa_chat, fsa_shop, fsa_video_session, fsa_tribute, fsa_goon, fsa_logout


// This hack is so that "logout" can be called from anywhere.
// The way the activity builder is designed, it makes it hard to use redirects as tunnel params, because they need to get propagated
//VAR fansite_return_to = ->error
VAR unlocked_fansite = false
VAR allowed_to_log_out = false
=== fansite

//~ fansite_return_to = p_fansite_return_to
{fansite == 1:
{bella_icon()} Welcome to My Fan Page! I'm sure you'll be here a lot!

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

-> fansite.build_opts


-> error("Shouldnt get here")

= _pa(activity_code, ->tunnel_to_run)
// allowed_to_log_out: {allowed_to_log_out}
{possible_activities ? activity_code: 
    ~ temp entryTurnChoice = TURNS()
    
    -> tunnel_to_run ->
    
    {entryTurnChoice != TURNS():
        {allowed_to_log_out:
            // For next time
            ~ current_activity -= LIST_ALL(fansite_activities)
            ~allowed_to_log_out = false
            ->-> // tunnel out
        }
       -> fansite.build_opts
    }
}
->DONE 

= build_opts

Time: {l0(tm_hour)}:{l0(tm_min)} <> ->bella_status-> 
<i> Credits: {credits}

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

{chat_offline_messages != "":
    {warn()} Bella has sent you chat messages while you were offline!
}

// Bella may have decided that you don't have enough credits, even though
// You have sufficent credits for chatting
{enough_credits:
    ~ enough_credits = (credits >= cost_per_message)
}
{not enough_credits:
    {warn()} You need to get credits if you want to chat with {BELLA_NAME}.
    ~ possible_activities = (fsa_logout, fsa_add_credits, fsa_chat)
    {path==adventure and not finished_initial_convo:
    ~ possible_activities -= fsa_chat
}
}


{sv(addiction) >= high:
    ~ possible_activities += fsa_goon
}

{path==adventure and not finished_initial_convo:
    ~ possible_activities -= (fsa_logout, fsa_shop, fsa_goon)
}

// Need to add this, othewise on_the_hour thinks we need to log on when addiction is max
~ possible_activities += logon_fansite


<- _pa(fsa_chat, ->fansite_chat)
<- _pa(fsa_goon, ->fansite_goon)
<- _pa(fsa_add_credits, ->fansite_add_credits)
<- _pa(fsa_tribute, ->fansite_tribute)
<- _pa(fsa_shop, ->fansite_shop)
<- _pa(fsa_logout, ->fansite_logout)


->DONE

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
~ temp unread_offline_message = (chat_offline_messages != "")
~ temp untributed = credits and not (activities_done_today? fsa_tribute)

{unread_offline_message: {warn()} You can't log out until you read your offline messages!}
{untributed: {warn()} You can't end your first session of the day without tipping her first!}
+ (do) {not unread_offline_message and not untributed} [Log out] ->
    ~ allowed_to_log_out = true
-

->->

== fansite_tribute
= opt
~ temp tx_result = ()

+ (do) [Tip Me! 💵] ->
    ~ temp tip_amount = sqi(addiction) // quantized addiction level as number
    + + [{tip_amount} credits] -> 
    + + [{tip_amount * 10} credits] -> 
     ~ tip_amount = tip_amount * 10
    + +  {credits} [All your credits ({comma_ify(credits)})] -> 
        ~ tip_amount = credits


    - - -> fansite_credits.pay(tip_amount, tx_result) -> 
    {tx_result ? FS_TX_SUCCESS:
        {That felt good.|You want to do that again.|Pay more.}
        ~ incstat(addiction)
        ~ decstat(confidence)
        {sv(addiction) >= high:
            ~ incstat(lust)
        }

    }
    ~ activities_done_today = fsa_tribute
->->

== fansite_goon
= opt


+  (do) [Goon to My profile pics 😵‍💫] ->
    You stare at her profile pics. You lose track of time....
    ->ffa(second, 4 * about_an_hour()) ->
    ~ incstat(lust)
    ~ incstat(addiction)
    
    ~ activities_done_today = fsa_goon
-
->->
    


    