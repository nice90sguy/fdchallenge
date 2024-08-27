=== stats

\----------------------------------------------------<br><>
Your last activity: <b>{current_activity:{current_activity}|(none)}</b><br><>
<b>Exercise: </b>{grind_exercise.do}</b> times.<br><>
<b>Fan Site: </b>{grind_logon_fansite.do}</b> times.<br><>
\----------------------------------------------------
->->

= display
\----------------------------------------------------<br><>
-> cc.disp_balance ->

Long-term stats:<p><>
{DispStat(confidence)}<br><>
{DispStat(obedience)}<br><>
{DispStat(fitness)}<br><>
{DispStat(addiction)}<br><>
</p>
Short-term stats:<p><>
{DispStat(hunger)}<br><>
{DispStat(sleepiness)}<br><>
{DispStat(lust)} <br><>
</p>
Relationship stats:<p><>

{path==adventure:{DispStat(angie_relationship)}<br><>}
// {DispStat(melanie_relationship)}<br><>
// </p>
\----------------------------------------------------<br><>

->->


->->
= reset(_path)
{_path:
 - adventure:

        ~ setstat(sleepiness, low)
        ~ setstat(lust,low)
        ~ setstat(addiction,high)
        ~ setstat(hunger,low)
        ~ setstat(confidence,low)
        ~ setstat(obedience,low)
        ~ setstat(fitness,medium)
        ~ setstat(angie_relationship,medium)
        ~ setstat(melanie_relationship,low)        
- sub:
        ~ setstat(sleepiness,min)
        ~ setstat(lust,low)
        ~ setstat(hunger,low)
        ~ setstat(addiction,low)
        ~ setstat(confidence,low)
        ~ setstat(obedience,medium)
        ~ setstat(fitness,low)
- dom:
        ~ setstat(sleepiness,min)
        ~ setstat(lust,low)
        ~ setstat(hunger,low)
        ~ setstat(addiction,min)
        ~ setstat(confidence,high)
        ~ setstat(obedience,min)
        ~ setstat(fitness,medium)
- else:
>>> Can't reset to {_path}
}
->->


// 
// Values are centered on their ranges
// i.e. 
// min = 1-20
// low = 21-40
// med = 41-60
// high = 61-80
// max  = 81-100
LIST quantized_stat_val = min=10, low=30, medium=50, high=70, max=90

// number of steps between succesive _stat_vals
// multipliers for stat delta, can be set per stat. 1 means 1 percent, whole_step is 20 percent

LIST _stat_sensitivity = _stat_sensitivity_0=0, _stat_sensitivity_1, _stat_sensitivity_2, _stat_sensitivity_3, _stat_sensitivity_4, _stat_sensitivity_5, _stat_sensitivity_6, _stat_sensitivity_7, _stat_sensitivity_8, _stat_sensitivity_9, _stat_sensitivity_10, _stat_sensitivity_11, _stat_sensitivity_12, _stat_sensitivity_13, _stat_sensitivity_14, _stat_sensitivity_15, _stat_sensitivity_16, _stat_sensitivity_17, _stat_sensitivity_18, _stat_sensitivity_19, _stat_sensitivity_20, _stat_sensitivity_whole_step=20

LIST stat_t = Sleepiness, Hunger, Lust, Submissiveness, Addiction, Confidence, Fitness, AngieYandere, MelanieRelationship

// Add stat_name to each var so that for a given stat, when passed to a function, we know what stat we're dealing with, (for display funcs)
VAR sleepiness = (Sleepiness, _stat_sensitivity_whole_step)
VAR hunger = (Hunger, _stat_sensitivity_whole_step)
VAR lust = (Lust, _stat_sensitivity_2)
VAR obedience = (Submissiveness, _stat_sensitivity_1)
VAR addiction = (Addiction, _stat_sensitivity_1)
VAR confidence = (Confidence, _stat_sensitivity_1)
VAR fitness = (Fitness, _stat_sensitivity_2)
VAR angie_relationship = (AngieYandere, _stat_sensitivity_5)
VAR melanie_relationship = (MelanieRelationship, _stat_sensitivity_whole_step)
/*
stats are designed to be opaque.   You should only read and set their "quantized" values, one of min, low, medium, high, max.
You can increment and decrement their values, and raise or lower them by a delta value.
Internally, the increment, decrement and delta functions mutliplier the "real value" change of the stat by its "sensitivity" (one of the constants in LIST _stat_sensitivity).
The "real value" of a stat is a number between zero and 100, and its quantized value is the quantized_stat_val closest to its real value.
So if the real value of var is 55, sq(var)  == medium.


The purpose of all this complexity is to make stat tuning and balance easier.
Simply changing the sensitivity of a stat increases or decreases the granularity of the delta(), inc() and dec() functions, which may be scattered all across the game in many files and stitches.  
You can, of course,  dynamically change a stat's sensitivity in the game.  So you can e.g. simulate onset of PTSD by increasing the sensitivity of the "fear" stat variable!



*/
// stat value
=== function _sv(p_stat)

~ return list2num(p_stat)


// stat quantized value (i.e. one of min..max)
=== function sq(p_stat)
~ temp val = _sv(p_stat)
{val == 100:
    ~ return max
- else:
    ~ return LIST_RANGE(LIST_ALL(quantized_stat_val), val-9, val+10)
}

// return quantized_stat value as an int (just gets the LIST_VALUE of the quantized list number)
=== function sqi(p_stat)
~ return LIST_VALUE(sq(p_stat))

// set status to a value or quantized value (one of min, low, medium etc.)
// value is clamped to [0 <= v <= 100]
=== function setstat(ref p_stat, val)
{typeof(val) == lst_t:
    {LIST_ALL(quantized_stat_val) ? val:
        ~ val = LIST_VALUE(val ^ LIST_ALL(quantized_stat_val))
    } 
- else:
    ~ val = list2num(val)

}
{val < 0:
    ~ val = 0
}
{val > 100:
    ~ val = 100
}
~ set_val(p_stat, val)
~ return sq(p_stat)



VAR SHOW_STATS=false
// returns the quantized value (min, low. etc.)
=== function deltastat(ref p_stat, delta)
{SHOW_STATS:
    ~DispDelta(p_stat, delta)
}

~ temp multiplier = p_stat ^ LIST_ALL(_stat_sensitivity)
{multiplier == ():
    ~ multiplier = 1
- else:
    ~ multiplier = LIST_VALUE(multiplier)
}
~ delta = delta * multiplier
~ return setstat(p_stat, _sv(p_stat) + delta)


=== function incstat(ref p_stat)
    ~ return deltastat(p_stat, 1)
    
=== function decstat(ref p_stat)
    ~ return deltastat(p_stat, -1)
    
=== function stat_type(_stat)
~ return _stat ^ LIST_ALL(stat_t)

== function stat_name(_stat)
{stat_type(_stat):
    - Sleepiness:  
        Sleepiness
    - Hunger:  
        Hunger
    - Lust:  
        Horniness
    - Addiction:  
        Findom addiction ({BELLA_NAME})
    - Confidence:  
        Self-esteem
    - Fitness:  
        Physical fitness
    - Submissiveness:  
        Submissiveness
    - AngieYandere:  
       {msg_name(ANGIE)} (Yandere)       
    - MelanieRelationship:  
       Closeness to {girlfriend_name} (Love Interest)      
}
== function stat_icon(_stat)
{stat_type(_stat):
    -  Sleepiness:  
        😴
    - Hunger:  
        🍕
    - Lust:  
        🌶️
    - Addiction:  
        💉
    - Confidence:  
        🦚
    - Fitness:  
        💪
    - Submissiveness:  
        🙏
    - AngieYandere: 
        👩🏻‍🦰
    - MelanieRelationship:
        🧍🏻‍♀️
        
}
=== function DispDelta(_stat, delta)
{SHOW_STATS:
    {stat_icon(_stat)}
    <>{delta > 0:{delta > 1: ⏫|🔼}|{delta < -1: ⏬|🔽}}
}<>

=== function DispStat(_stat)

{stat_icon(_stat)} {stat_name(_stat)}: {_stat ^ LIST_ALL(quantized_stat_val)} ({list2num(_stat)}%)

