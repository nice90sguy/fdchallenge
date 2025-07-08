


// This hack is so that "logout" can be called from anywhere.
// The way the activity builder is designed, it makes it hard to use redirects as tunnel params, because they need to get propagated
//VAR fansite_return_to = ->error
VAR unlocked_fansite = false




VAR session_tribute_count = 0

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

~ session_tribute_count = 0
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
// Don't allow logout if there are pending pmessages
~ temp unread_offline_message = (chat_offline_messages != "")

// DO allow logout if you have no credits left, even if you haven't tributed enough times
~ temp untributed = credits and (session_tribute_count < num_tributes_required_this_session())

// {session_tribute_count} tributes out of {num_tributes_required_this_session()} - untributed = {untributed}

+ (do) [Log out] ->
    
    {unread_offline_message: -> p1e("{warn()} You can't log out until you read your offline messages!") ->->}
    {untributed: -> p1e("{warn()} You need to tribute her {session_tribute_count: again|first}!") ->->}
    
    ~ grind_logged_on_to_fansite = false
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
    
        {That felt good.|You want to do that again.|Pay more.|Why does it feel so good?|Triggered.|You need help.|More.|Again.}
        ~ incstat(addiction)
        ~ decstat(confidence)
        {sv(addiction) >= high:
            ~ incstat(lust)
        }
        ~session_tribute_count++
        ~ set_result_success(YOU)

    - else:
        ~ set_result_insufficient_credits(YOU)

    }

    ~ activities_done_today = fsa_tribute
-
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
    
=== function num_tributes_required_this_session()
{sv(addiction) > medium: 
    ~ return 2
}
~ return 1


    