LIST _pow2 = _pow2_0=1,_pow2_1=2,_pow2_2=4,_pow2_3=8,_pow2_4=16,_pow2_5=32,_pow2_6=64,_pow2_7=128,_pow2_8=256,_pow2_9=512,_pow2_10=1024,_pow2_11=2048,_pow2_12=4096,_pow2_13=8192,_pow2_14=16384,_pow2_15=32768,_pow2_16=65536,_pow2_17=131072,_pow2_18=262144,_pow2_19=524288,_pow2_20=1048576,_pow2_21=2097152,_pow2_22=4194304,_pow2_23=8388608,_pow2_24=16777216,_pow2_25=33554432,_pow2_26=67108864,_pow2_27=134217728,_pow2_28=268435456,_pow2_29=536870912,_pow2_30=1073741824


== function list2num(arg)

{typeof(arg) == int_t:
    ~ return arg
}

~ arg = arg ^ LIST_ALL(_pow2)
 ~ temp sum = 0
{arg == ():
    ~ return sum
}
~ temp _min = LIST_MIN(arg)
~ return LIST_VALUE(_min) + list2num(arg-_min)


== function num2list(v)
{typeof(v) == lst_t:
    ~ return v ^ LIST_ALL(_pow2)
}
~ temp n = ()
~ return _num2list(1, v, n)
    
== function _num2list(cumprod, ref v, ref n)    
{v == 0:
    ~ return n
}
{v % 2:
    ~ n += _pow2(cumprod)
}
~ v = v / 2
~ return  _num2list(cumprod * 2, v, n)
 
// sets a var, which may be an int or a list containing _pow2s, to a numerical value, which also may be an int or a list containing _pow2s.
// returns the value as an int
== function set_val(ref var, val)
// assume val is an int
~ temp val_as_int  = val

{typeof(var) == int_t:
   {typeof(val) == int_t:
        ~ var += val
    -else:
        // var is an int, val is a list
        ~ val_as_int = list2num(val) 
        ~ var += val_as_int
    }
- else:
    ~ var -= LIST_ALL(_pow2)
    {typeof(val) == int_t:
        // var is a list, val is an int
        ~ var += num2list(val)
    -else:
        // both var and val are lists
        ~ var += val
        ~ val_as_int = list2num(val) 
    }
}
~ return val_as_int






    