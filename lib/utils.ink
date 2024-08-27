// BEGIN utils.ink
VAR continue_prompt = true

=== list_utils
= move_item(item, ref from, ref to)
    ~ from -= item
    ~ to += item
->->

== function LIST_TOTAL(l)
{ l == ():
    ~ return 0
}
~ temp l1 = LIST_MIN(l)
~ return LIST_VALUE(l1) + LIST_TOTAL(l-l1)

== function INC(ref l)

{ l < LIST_MAX(LIST_ALL(l)):

    ~l++
}

== function DEC(ref l)
{ l > LIST_MIN(LIST_ALL(l)):
    ~l--
}

// e.g. 
// LIST stat = min, (low), med, high, max
// 
// LIST_REVERSE(stat) == high



// One line prompt 
=== cont
{continue_prompt:
-> p1("Continue...") ->
}
->->

=== p1(text)
+ [<i>{text}</i>]
-
->->

// One line prompt with prompt text emitted
=== p1e(text)
+ <i><>{text}</i>
-
->->
 == function do_not_use_alert(msg)
  ⚠️ {msg}
  
  == function alert_q(msg)
  ❓{msg}
  
 VAR YES = false
 VAR NO = true
  == yesno(q)

  ~ YES = false
   ❓({q})
   + [Yes]
    ~ YES = true
   + [No]
   -
    ~ NO = not YES
 ->->
    
  
 VAR one_time_reminders = ""
 == function otr(msg)
 { one_time_reminders ? msg:
    
 -else:
          🧠 ️<i>{msg}</i>
          ~ one_time_reminders += ";" + msg
          }


VAR _msg = ""
// New message
== function nmsg
    ~ _msg = "<br><center>====================================</center><br>"
    ~ return ""
    
// Add to message with line break
== function amsg(text)
    ~ _msg += text + "<br>"
    ~ return _msg


/*
	Takes the bottom element from a list, and returns it, modifying the list.

	Returns the empty list () if the source list is empty.

	Usage: 

	LIST fruitBowl = (apple), (banana), (melon)

	I eat the {pop(fruitBowl)}. Now the bowl contains {fruitBowl}.

*/

=== function pop(ref _list) 
    ~ temp el = LIST_MIN(_list) 
    ~ _list -= el
    ~ return el 
    
    
/*
    Converts a number between -1,000,000,000 and 1,000,000,000 into its printed (integer) equivalent.

    Usage: 

    There are {print_number(RANDOM(100000,10000000))} stars in the sky.

    Pi is roughly {print_number(3.1417)}.

*/

VAR __print_number_init_cap = false

=== function print_number_c(x)
 ~ __print_number_init_cap = true
 ~ print_number(x)
 
=== function print_number(x) 
~ x = INT(x) // cast to an int, since this function can only handle ints!

~ temp _c = __print_number_init_cap

{
    - x >= 1000000:
        ~ temp k = x mod 1000000
        {print_number((x - k) / 1000000)} million{ k > 0:{k < 100: and|{x mod 100 != 0:<>,}} {print_number(k)}}
    - x >= 1000:
        ~ temp y = x mod 1000
        {print_number((x - y) / 1000)} thousand{ y > 0:{y < 100: and|{x mod 100 != 0:<>,}} {print_number(y)}}
    - x >= 100:
        ~ temp z = x mod 100
        {print_number((x - z) / 100)} hundred {z > 0:and {print_number(z)}}
    - x == 0:
        zero
    - x < 0: 
        minus {print_number(-1 * x)}
    - else:
        { x >= 20:
            { x / 10:
                - 2: {_c:Twenty|twenty}
                - 3: {_c:Thirty|thirty}
                - 4: {_c:Forty|forty}
                - 5: {_c:Fifty|fifty}
                - 6: {_c:Sixty|sixty}
                - 7: {_c:Seventy|seventy}
                - 8: {_c:Eighty|eighty}
                - 9: {_c:Ninety|ninety}
            }
            { x mod 10 > 0:
                ~ _c = false
                <>-<>
            }
        }
        { x < 10 || x > 20:
            { x mod 10:
                - 1: {_c:One|one}
                - 2: {_c:Two|two}
                - 3: {_c:Three|three}
                - 4: {_c:Four|four}
                - 5: {_c:Five|five}
                - 6: {_c:Six|six}
                - 7: {_c:Seven|seven}
                - 8: {_c:Eight|eight}
                - 9: {_c:Nine|nine}
            }
        - else:
            { x:
                - 10: {_c:Ten|ten}
                - 11: {_c:Eleven|eleven}
                - 12: {_c:Twelve|twelve}
                - 13: {_c:Thirteen|thirteen}
                - 14: {_c:Fourteen|fourteen}
                - 15: {_c:Fifteen|fifteen}
                - 16: {_c:Sixteen|sixteen}
                - 17: {_c:Seventeen|seventeen}
                - 18: {_c:Eighteen|eighteen}
                - 19: {_c:Nineteen|nineteen}
            }
        }
} 
~ __print_number_init_cap = false


/*
	Converts a string to the corresponding list element from a particular list. Note the element doesn't need to be in the list variable at that moment in time! 

	Useful for sending parameters into the ink from the game: the game can store and pass in the string ID of the list element as a parameter.

	Returns the empty list () if the element isn't found.

	Usage: 

	LIST capitalCities = Paris, London, NewYork

	~ temp thisCity = string_to_list("Paris", capitalCities)
	~ capitalCities += thisCity
	I've now visited {thisCity}.

	Optimisation:

	The code below works in inky, but can be externalised to speed up performance in game, with the following external C# function binding:

	story.BindExternalFunction("STRING_TO_LIST", (string itemKey) => {
        try
        {
            return InkList.FromString(itemKey, story);
        }
        catch
        {
            return new InkList();
        }
    }, true);

*/
LIST type = int_t, str_t, lst_t
=== function typeof(val)

{"{val+10000}" == "":
    ~ return lst_t
}

{"{val+1}" ? "{val}":
    ~ return str_t
}
~ return int_t

=== function string_to_list(stringElement, listSource)
     ~ return stringAsPickedFromList(stringElement, LIST_ALL(listSource) ) 

=== function stringAsPickedFromList(stringElement, listToTry)
    ~ temp minElement = LIST_MIN(listToTry) 
    {minElement:
        { stringElement == "{minElement}":
            ~ return minElement
        }
        ~ return stringAsPickedFromList(stringElement, listToTry - minElement)
    }       
    ~ return () 
    
// When you can't use var(index)
== function item_at_index(_v, _i)

{_i == 1:
    ~ return LIST_MIN(_v)
}
~ _v -= LIST_MIN(_v) 
~ return item_at_index(_v, _i - 1)

// END utils.ink

/*
	Threads in a given flow as a tunnel, with a given location to tunnel back to. 

	If choices within this content are taken, they should end with a tunnel return (->->).

	Useful for "pasting in" the same block of optional content into multiple locations.

	Usage: 


	- (opts)
		<- thread_in_tunnel(-> eat_apple, -> opts)
		<- thread_in_tunnel(-> eat_banana, -> get_going)
		*	[ Leave hungry ]
			-> get_going

	=== get_going
		You leave. 
		-> END 

	=== eat_apple 
		*	[ Eat an apple ]
			You eat an apple. It doesn't help.
			->->

	=== eat_banana 
		*	[ Eat a banana ]
			You eat a banana. It's very satisfying.
			->->
		
		
*/

=== thread_in_tunnel(-> tunnel_to_run, -> place_to_return_to)

    ~ temp entryTurnChoice = TURNS()
    
    -> tunnel_to_run ->
 
 	// if the tunnel contained choices which were chosen, then the turn count will 
 	// have increased, so we should use the given return point to continue the flow.
    {entryTurnChoice != TURNS():
        -> place_to_return_to      
    }  

    // otherwise the given tunnel simply ran through, in which case we should treat
    // this as a side-thread, and close it down.
    -> DONE 

/*
	Takes a list and prints it out, using commas. 

	Dependenices: 

		This function relies on the "pop" function. 

	Usage: 

		LIST fruitBowl = (apples), (bananas), (oranges)

		The fruit bowl contains {list_with_commas(fruitBowl)}.
*/

=== function list_with_commas(list)
	{ list:
		{_list_with_commas(list, LIST_COUNT(list))}
	}

=== function _list_with_commas(list, n)
	{pop(list)}{ n > 1:{n == 2: and |, }{_list_with_commas(list, n-1)}}

	

