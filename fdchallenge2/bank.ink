
VAR _cc = 0
VAR _limit = -1000


=== cc
->init

LIST TX_RESULT = (TX_FAILED), TX_SUCCESS

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
    {to==BELLA_FULL_NAME:

    ~otr("There are serious consequences if you can't pay {BELLA_NAME}!")

    }  
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





