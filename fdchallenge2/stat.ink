=== stats

\----------------------------------------------------<br><>
Your last activity: <b>{current_activity:{current_activity}|(none)}</b><br><>
<b>Exercise: </b>{grind_exercise.do}</b> times.<br><>
<b>Fan Site: </b>{grind_fansite.do}</b> times.<br><>
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
// Relationship stats:<p><>

// {path==adventure:{DispStat(angie_relationship)}<br><>}
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

LIST _stat_dm = _stat_dm_0=0,_stat_dm_1,_stat_dm_2,_stat_dm_3,_stat_dm_4,_stat_dm_5,_stat_dm_6,_stat_dm_7,_stat_dm_8,_stat_dm_9,_stat_dm_10,_stat_dm_11,_stat_dm_12,_stat_dm_13,_stat_dm_14,_stat_dm_15,_stat_dm_16,_stat_dm_17,_stat_dm_18,_stat_dm_19,_stat_dm_20,_stat_dm_whole_step=20

LIST stat_t = Sleepiness, Hunger, Lust, Submissiveness, Addiction, Confidence, Fitness, AngieRelationship, MelanieRelationship
// Add stat_name to each var so that for a given stat, when passed to a function, we know what stat we're dealing with, (for display funcs)
VAR sleepiness = (Sleepiness, _stat_dm_whole_step)
VAR hunger = (Hunger, _stat_dm_whole_step)
VAR lust = (Lust, _stat_dm_2)
VAR obedience = (Submissiveness, _stat_dm_1)
VAR addiction = (Addiction, _stat_dm_1)
VAR confidence = (Confidence, _stat_dm_1)
VAR fitness = (Fitness, _stat_dm_2)
VAR angie_relationship = (AngieRelationship, _stat_dm_whole_step)
VAR melanie_relationship = (MelanieRelationship, _stat_dm_whole_step)

// stat value
=== function sv(p_stat)
~ return list2num(p_stat)

// stat quantized value (i.e. one of min..max)
=== function sq(p_stat)
~ return p_stat ^ LIST_ALL(quantized_stat_val)

// return quantized_stat value (i.e. LIST_VALUE of min..max) as an int
=== function sqi(p_stat)
~ return LIST_VALUE(sq(p_stat))

=== function setstat(ref p_stat, val)

~ temp quantized_value = ()
{typeof(val) == lst_t:
    ~ quantized_value = val ^ LIST_ALL(quantized_stat_val)
    {quantized_value != ():
        ~ val = LIST_VALUE(quantized_value)
    }
}
// set value, and cast val to int if necessary
~ val = set_val(p_stat, val)

// update the _stat_val to the nearest quantized value
~ p_stat -= LIST_ALL(quantized_stat_val)
~ p_stat += quantized_value

{val == 100:
    ~ p_stat += max
- else:
    ~ p_stat += LIST_RANGE(LIST_ALL(quantized_stat_val), val-9, val+10)
}

VAR SHOW_STATS=false
=== function deltastat(ref p_stat, delta)
{SHOW_STATS:
    ~DispDelta(p_stat, delta)
}

~ temp multiplier = p_stat ^ LIST_ALL(_stat_dm)
{multiplier == ():
    ~ multiplier = 1
- else:
    ~ multiplier = LIST_VALUE(multiplier)
}
~ delta = list2num(delta) * multiplier
~ temp current_val = list2num(p_stat)
~ temp new_val = current_val + delta
{new_val < 0:
    ~ new_val = 0
}
{new_val > 100:
    ~ new_val = 100
}
~ setstat(p_stat, new_val)
~ return sq(p_stat)

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
    - AngieRelationship:  
       Closeness to {msg_name(ANGIE)} (Yandere)       
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
    - AngieRelationship: 
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
{SHOW_STATS:
    {stat_icon(_stat)} {stat_name(_stat)}: {_stat ^ LIST_ALL(quantized_stat_val)} ({list2num(_stat)}%)
}
