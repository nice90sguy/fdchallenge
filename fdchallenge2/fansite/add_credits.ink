VAR cost_per_message = 2
CONST cost_per_video_minute = 20
CONST min_video_session_duration = 30
CONST min_credits_for_video_session = 600
VAR total_chat_time = 0
VAR credits = 0
CONST max_daily_credits = 200

LIST fs_transaction_goods = fs_unlock_photo, fs_unlock_video, fs_send_message, fs_send_photo, fs_tribute

LIST fs_tx_status = FS_TX_SUCCESS, FS_TX_FAIL
== fansite_add_credits
= opt
+ + (do) [Add Credits 💳] 
    -> ffa(second, 20) ->
    ~ temp could_chat = credits >= cost_per_message // Could chat before adding
    + + +  [100 credits for $100]
        -> fansite_credits.add(100, 100) ->

    + + +  [500 credits for $450]
        -> fansite_credits.add(500, 450) ->
    
    + + +  [5000 credits for $4,000]
        -> fansite_credits.add(5000, 4000) ->
        
    + + +  [I've changed my mind]

    - - -
    {not could_chat && credits >= cost_per_message: 
     {hint()} You can now chat with {BELLA_NAME}!
    }
-> fansite.after_activity
->->


=== fansite_credits


// Arg is a combination of fs_transaction_goods and tribute amount

= pay(price, ref result)

~ temp goods = result ^ LIST_ALL(fs_transaction_goods)
{credits < price:
    {warn()} You don't have enough credits to do that right now.
    ~decstat(confidence)
    ~ result = FS_TX_FAIL
- else: 
    ~ credits -= price
    ~  result = FS_TX_SUCCESS
}
->->

// Add credits
= add(_credits, amount)
-> cc.pay("FindomFans Inc", amount, true) ->
// If ran out of money, get humiliated
{TX_RESULT == TX_FAILED:
    ~ deltastat(confidence, -10)
    ~ decstat(addiction)
    -else: 
        ~ credits += _credits
     ~ incstat(addiction)
    }
->->
// Pay credits
= pc(_credits)


->->
    