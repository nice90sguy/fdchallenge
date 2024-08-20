VAR HAGGLE_LAST_BID = 0
CONST HAGGLE_MAX_ALLOWED_BID = 10000
LIST HAGGLE_RESULT = SOLD,RESERVE_NOT_REACHED,WELSHED
VAR _reserve_price = 0
VAR _haggle_item_desc = ""
VAR initial_bid = 0
=== haggle(arg_haggle_item_desc, arg_reserve_price, bid)
~ initial_bid = bid
~ _reserve_price = arg_reserve_price
~ _haggle_item_desc = arg_haggle_item_desc

 {haggle == 1: 
 {hint()} "This is a "Haggle", one of {BELLA_NAME}'s mini-games in this story. She'll keep raising the price until you choose "Ripoff" (i.e. stick with your last bid).  She has a "reserve" price which she never tells you. If you bid more than the reserve price, you'll get what she's offering and of course have to pay for it.<br>If you fail to bid above her reserve price, you get nothing -- but you'll still have to pay her! <br>If you don't have enough in your account she'll be pissed off, and negative consequences could ensue for you.  The outcome of a Haggle will never alter your major path through the story however.
 
  {hint()} Remember to keep track of what you're agreeing to pay!
 }


~ HAGGLE_RESULT = RESERVE_NOT_REACHED

~ temp bid_s = "{print_number(bid)}"
~ temp bid_sc = "{print_number_c(bid)}"
-> M_B("{&Is {_haggle_item_desc} worth {bid_s} bucks to you?|{bid_sc} dollars would be - what?|So what do you say? Let's start out at {the ridiculously low price of|} {HAGGLE_LAST_BID==bid:your last bid: }{bid_s} bucks...}") ->
~ HAGGLE_LAST_BID = 0

+ [Bargain] -> M_Y("That's a bargain.") -> nextround(bid)
-

- (play)

    +  [Ripoff] You really want to, but you just can't bring yourself to pay that much.
        -> M_B("{Such a big spender {_emo("🙄")}|Cheapskate.|Really? You're quitting already?|Pathetic lol.|} {_emo("😁")}") -> endplay

    +  [Bargain] -> M_Y("That's a bargain.") ->
        -> nextround(bid)

    
= nextround(bid)
        -> ffa(second, 20) ->
        { bid == HAGGLE_MAX_ALLOWED_BID:
            -> M_B("Ok, I'm not greedy, I'll accept ${comma_ify(bid)} 😁") -> endplay
        }
        
        ~ HAGGLE_LAST_BID = bid
        
        ~ temp opt = RANDOM(1,5)
        { opt:
         - 1: ~ bid += initial_bid
         - 2: ~ bid += 2 * initial_bid
         - 3: ~ bid = 2 * bid 
         - 4: ~ bid += initial_bid
         - 5: ~ bid += initial_bid
        }
        { bid > HAGGLE_MAX_ALLOWED_BID:
            ~ bid = HAGGLE_MAX_ALLOWED_BID
        }
        -> M_B("{~Damn right.|You're right, that{~'s| really is}{~ not enough| a bargain| too low}.|Not enough.|Yeah, too cheap.|I want more.|Keep going.|Is that all?|} {~I deserve|You need to pay|Give me} {~at least|} ${comma_ify(bid)} {~ for {_haggle_item_desc}|. You know {_haggle_item_desc} is worth it}.") -> play

= endplay
    {haggle == 1: {hint()} {BELLA_NAME} has learned something about you from this!}
    
    -> cc.pay(BELLA_FULL_NAME(), HAGGLE_LAST_BID, true) ->
    {TX_RESULT == TX_SUCCESS:
    - else: // Transaction failed
    
        ~ HAGGLE_RESULT = WELSHED
        {devil_angry()} "<b>Never</b> have an empty wallet. Understand?"
        ~ incstat(obedience)
        ~deltastat(confidence, -5)
        ->->
    
    }
    
    {HAGGLE_LAST_BID >= _reserve_price:
        // {devil_happy()} Good boy. I accept your tribute.
        ~ HAGGLE_RESULT = SOLD
        ~ incstat(obedience)
    
    - else:
        //  {devil_angry()} That was nowhere near enough. Pay more next time.
            ~ HAGGLE_RESULT = RESERVE_NOT_REACHED
            ~ decstat(obedience)
            ~ decstat(confidence)
        }
    
->->
