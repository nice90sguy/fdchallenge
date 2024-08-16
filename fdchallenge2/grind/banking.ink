== grind_banking
= opt
+ + (do) [Banking] ->
    ~ current_activity += banking
    + + + [Check your balance]
        -> cc.disp_balance ->
    + + + [Try to increase your overdraft] 
        You try, but fail.
    - - - 
    ~ current_activity -= banking
    -> grind.after_activity 