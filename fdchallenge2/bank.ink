
VAR _cc = 0
VAR _limit = -1000

=== function cc_balance()
{ _cc < 0:
    ${comma_ify(-_cc)} overdrawn
- else:
    ${comma_ify(_cc)} 
}
~ return

=== cc
->init

LIST TX_RESULT = (TX_FAILED), TX_SUCCESS
VAR need_more_money = false
= disp_balance
<p> 💳 <i>Current Balance: <>
{ _cc < 0:
    ${comma_ify(-_cc)} overdrawn
- else:
    ${comma_ify(_cc)} 
}
</p>
->->



= deposit(amount)
  ~ _cc +=  amount
  ->->
  
= receive(from, amount, disp_transaction)
  ~ _cc +=  amount
      {disp_transaction:
<p> 💳 <i>You just received ${comma_ify(amount)} from {from}.</p>
     }
  ->->
  
= pay(to, amount, disp_transaction)
~ TX_RESULT = TX_FAILED
{_cc - amount < _limit:
     {_DEBUG:>>> Transaction failed (Balance {_cc} - Amount {amount} < overdraft limit {_limit})}
    {warn()} Your bank has declined your transaction.
    You need to get more money!
    -> cont ->
    ~ need_more_money = true

    
- else: 
    ~  _cc -= amount
    ~ TX_RESULT = TX_SUCCESS
     {disp_transaction:
<p> 💳 <i>You just paid ${comma_ify(amount)} to {to}.</p>

     }

}
->->

= init
->->





