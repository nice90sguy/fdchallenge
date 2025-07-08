
== grind_banking
= opt

+  (do) [Money ({cc_balance()})] ->
    ~ current_activity += banking
    + + (tried_overdraft_1) {need_more_money and not tried_overdraft_1} [Try to increase your overdraft] 
        You try, but fail.
        {hint()} You'll  find other ways to finance your addiction, next time you select this option!
        
    + + (tried_overdraft_2) {need_more_money and tried_overdraft_1 and not tried_overdraft_2} [Sell your car]
        You sell your three-year-old, low-mileage VW.  You only get $15,000, half what you paid for it.
        -> cc.deposit(15000) ->
        ~ need_more_money = false
    + +  (tried_overdraft_final){need_more_money and tried_overdraft_2 and not tried_overdraft_final} [Remortgage your flat]
        You manage to get $50,000 from the mortgage company.
        -> cc.deposit(50000) -> 
        // The first call to Bella.become_her_tenant schedules a WhatsApp message for 8 AM next morning
        -> Bella.become_her_tenant ->

    + +  ->
        {need_more_money and tried_overdraft_final and location == location_hovel and not ending_ruin.triggered: 
            -> ending_ruin.triggered ->
        -else:
            You don't need more money (yet!)
        }

    - -  
    ~ current_activity -= banking

    
-
->->


    