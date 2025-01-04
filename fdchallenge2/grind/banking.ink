
== grind_banking
= opt
+ + (do) [Money ({cc_balance()})] ->
    ~ current_activity += banking
    + + +(tried_overdraft) {need_more_money and not tried_overdraft} [Try to increase your overdraft] 
        You try, but fail.
        {hint()} You'll  find other ways to finance your addiction, next time you select this option!
        
    + + +(sell_car) {need_more_money and tried_overdraft and not sell_car} [Sell your car]
        You sell your brand-new VW.  You only get $15,000, half what you paid for it.
        -> cc.deposit(15000) ->
        ~ need_more_money = false
    + + + (remortgage){need_more_money and sell_car and not remortgage} [Remortgage your flat]
        You manage to get $50,000 from the mortgage company.
        -> cc.deposit(50000) -> 
        -> Bella.become_her_tenant ->

    + + + ->
        You don't need more money (yet!)
    - - - 
    ~ current_activity -= banking
    -> grind.after_activity 
    



    