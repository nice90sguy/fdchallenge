/*
<b>What's your favourite color?</b>
LIST colors = (red), (blue), (green)
~ temp favourite_colors = ()
-> multiselect(colors, favourite_colors, 1, 1) ->
Your favorite color is {favourite_colors}, eh? Interesting...
*/
=== function null_lookup_fn(item)
    ~ return item
=== select(_l, ref _s, _item_name)
 -> multiselect_opts(_l, _s, 1, 1, _item_name, "", ->null_lookup_fn)->
 ->->
 
 === select_with_lookup(_l, ref _s, _item_name, ->lookup_fn)
 -> multiselect_opts(_l, _s, 1, 1, _item_name, "", lookup_fn)->
 ->->
 
 === multiselect(_l, ref _s, _limit_min, _limit_max, _item_name)
 -> multiselect_opts(_l, _s, _limit_min, _limit_max, _item_name, "D", ->null_lookup_fn)->
 ->->
 
  === multiselect_with_lookup(_l, ref _s, _limit_min, _limit_max, _item_name, ->lookup_fn)
 -> multiselect_opts(_l, _s, _limit_min, _limit_max, _item_name, "D", lookup_fn)->
 ->->
=== multiselect_opts(_l, ref _s, _limit_min, _limit_max, _item_name, _config, ->lookup_fn)

// Set the maximum limit to MULTISELECT_MAX to allow "limitless" number of options!
CONST MULTISELECT_MAX = 10000

// "Local" vars, prefixed to avoid namespace clash
VAR _387_i = 1
VAR _387_sel_lst = ()
VAR _387_limit_max = 0
VAR _387_limit_min = 0
VAR _387_n_sel = 0
VAR _387_sel = ()
VAR _387_sel_item_name = ""
VAR _387_sel_onetime_scroll_hint = "<i>🧠 Use the up/down arrows to scroll."
VAR _387_sel_lookup_fn = 0
// (re)initialize vars
~ _387_i = 1
~ _387_sel_lst =_l
~ _387_limit_max = _limit_max
~ _387_limit_min = _limit_min
~ _387_n_sel = LIST_COUNT(_s)
~ _387_sel = _s
~ _387_sel_item_name = _item_name
~ _387_sel_lookup_fn = null_lookup_fn

// config options
VAR _387_cfg_opt_display_selections = false
{ _config ? "D":
    ~ _387_cfg_opt_display_selections = true
-else:
    ~ _387_cfg_opt_display_selections = false
}
~ _387_sel_lookup_fn = lookup_fn

{_387_sel_onetime_scroll_hint != "" and (5 < LIST_COUNT(_387_sel_lst)): 
{_387_sel_onetime_scroll_hint}
~ _387_sel_onetime_scroll_hint = ""
}
{ _387_limit_min == _387_limit_max:
    {_387_limit_min != 1: Pick {_387_limit_min} {_item_name}s.}
 - else: // _387_limit_min < _387_limit_max. TODO: Validate
    Pick {_387_limit_min: at least {_387_limit_min} item{_387_limit_min != 1:s}|as many {_item_name}s as you want} {_387_limit_max != MULTISELECT_MAX:, but no more than {_387_limit_max}}.
}

-> ssel -> 


~ _s = _387_sel
->->

= ssel

{ _387_n_sel >= _387_limit_max : 
 ->->
}
{_387_cfg_opt_display_selections:{_387_n_sel:Selected: <i>{l2s(_387_sel)}</i>}}

<- ssel_up(->ssel)
<- ssel_opt(_387_i)
<- ssel_opt(_387_i+1) 
<- ssel_opt(_387_i+2) 
<- ssel_opt(_387_i+3) 
<- ssel_opt(_387_i+4) 
<- ssel_dn(->ssel)
+ {_387_n_sel >= _387_limit_min} [<i>(Done)</i>]
    ->->
+ ->

->->
= ssel_up(->to)
+ {_387_i > 1} [⬆️]
    ~ _387_i -= 5
    { _387_i < 1:
        ~ _387_i = 1
    }
    ->to
    
= ssel_dn(->to)
~ temp n = LIST_COUNT(_387_sel_lst)
+ {_387_i+5 <= n} [⬇️]
    ~ _387_i += 5
    { _387_i > n:
        ~ _387_i = n
    }
    ->to

= ssel_opt(_i)

~ temp _val = item_at_index(_387_sel_lst, _i)

~ temp _disp_val = _387_sel_lookup_fn(_val)
+ {_val} [{_387_sel ? _val: <b>✅}{_disp_val}]

    {_387_sel ? _val:
        ~ _387_sel -= _val
        ~ _387_n_sel--
    - else:
        ~ _387_sel += _val
        ~ _387_n_sel++
    }

    ~ temp n_more_selections_required = _387_limit_min -_387_n_sel
    //
    { _387_limit_max == MULTISELECT_MAX and n_more_selections_required <= 0:
        Pick more {_387_sel_item_name}s, or select (Done).
     -else: 
         ~ temp n_more_selections_allowed = _387_limit_max -_387_n_sel

        {n_more_selections_required > 0:
            Pick {n_more_selections_required} more {_387_sel_item_name}{n_more_selections_required != 1:s}. 
        -else:
            {n_more_selections_allowed > 0:You can pick up to {n_more_selections_allowed} more {_387_sel_item_name}{n_more_selections_allowed != 1:s}.}
            }
    
         
    
    }
    -> ssel
- 
->->

LIST digits = _1_,_2_,_3_,_4_,_5_,_6_,_7_,_8_,_9_,_0_


=== function l2s(l)

{typeof(l) == str_t:

    ~return l
}
 ~ return _l2s(l, " ")
 
=== function _l2s(l, sep)
~ temp l1 = LIST_MIN(l)
{l1 == ():
    ~ return ""
}
{
 - l1 ^ LIST_ALL(digits):
   {_l2s_digits(l1)}{sep}<>
   
  
 - else: // no lookup, just output use the list value
    ~ return l
}

{_l2s(l - l1, sep)}

=== function _l2s_digits(l)
{l:
    - _0_: 0
    - _1_: 1
    - _2_: 2
    - _3_: 3
    - _4_: 4
    - _5_: 5
    - _6_: 6
    - _7_: 7
    - _8_: 8
    - _9_: 9

}



    
    

