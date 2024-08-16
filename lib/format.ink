/*
return an ordinal from a number
e.g. 1 -> "1st"
12 -> "12th"
33 -> "33rd"
etrc
*/
=== function ord(num)
{ num >= 10 && num <= 20: 
    ~ return num + "th" 
}

{ num % 10:
 - 0: ~ return num + "th"
 - 1: ~ return num + "st"
 - 2: ~ return num + "nd"
 - 3: ~ return num + "rd"
 - else: ~ return num + "th"
 }
 
// Add leading zeros to number if necessary
 === function leading_zeros(n, maxnum_zeros)
    ~ temp num_zeros = maxnum_zeros - num_digits(n)
    {num_zeros <= 0:
        {n}
    - else:
        {repchar("0", num_zeros)}{n}
    }
    

// non-negative numbers only!
== function num_digits(n)
    {n < 10:
        ~ return 1
    }
    ~ return num_digits(n/10)+1
    
== function repchar(char, n)

    {n > 0:
        {char}<>
        {repchar(char, n-1)}<>
    }
    
== function comma_ify(n)

~ temp isminus = n < 0
{ isminus:
    ~ n  = -n
    \-<>
}
{_comma_ify(n,  num_digits(n)-1)}

    
== function _comma_ify(n, order_of_magnitude)
{ order_of_magnitude < 3:{n % 1000}|{_comma_ify(n/1000, order_of_magnitude-3)},{leading_zeros(n % 1000,3)}}


// EOF
