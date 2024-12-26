
== grind_banking
= opt
+ + (do) [Money] ->
    ~ current_activity += banking
    + + + [Check your bank balance]
        -> cc.disp_balance ->
    + + +(tried_overdraft) {not tried_overdraft} [Try to increase your overdraft] 
        You try, but fail.
        {hint()} You'll  find other ways to finance your addiction, next time you select this option!
        
    + + +(sell_car) {tried_overdraft and not sell_car} [Sell your car]
        You sell your brand-new VW.  You only get $15,000, half what you paid for it.
        -> cc.deposit(15000) ->
    + + + (remortgage){sell_car and not remortgage} [Remortgage your flat]
        You manage to get $50,000 from the mortgage company.
        -> cc.deposit(50000) ->    
    + + + (sell_flat){remortgage and not sell_flat} [Sell your flat]
        You sell your apartment and move into a cheap motel.
        -> cc.deposit(350000) ->   
    - - - 
    ~ current_activity -= banking
    -> grind.after_activity 
    



    