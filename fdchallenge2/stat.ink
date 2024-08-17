CONST MAX_STAT_VALUE = 5 //

// General horniness, need for release
LIST lust = min, (low), medium, high, max
VAR _flt_lust = 0.0
~ _flt_lust = LIST_VALUE(lust)

// Self-confidence, Self-esteem. Lowered by being humiliated, or not being able to pay {BELLA_NAME}.  Affects your ability to earn
LIST confidence = min, low, medium, (high), max
VAR _flt_confidence = 0.0
~ _flt_confidence = LIST_VALUE(confidence)

// If your obedience is high, you won't be able to disobey or ignore {BELLA_NAME}.
// This can lead rapidly to financial ruin!
LIST obedience = min, (low), medium, high, max
VAR _flt_obedience = 0.0
~ _flt_obedience = LIST_VALUE(obedience)

// Addiction is the need to contact her, or log on to her site.
// When high, you'll crave every chance to contact her, and so will be unable to ignore her
// messages.
LIST addiction = min, (low), medium, high, max
VAR _flt_addiction = 0.0
~ _flt_addiction = LIST_VALUE(addiction)

// This value is set by a function that maps the amount of money in your account to the list values
LIST wealth = ruined, dont_ask, in_debt, barely_keeping_afloat, (doing_ok), flush, rich

// Increases every six hours (day+night), goes to low after eating
LIST hunger = min, (low), medium, high, max
VAR _flt_hunger = 0.0
~ _flt_hunger = LIST_VALUE(hunger)

// Increases every six hours you're awake, goes to low after sleep
LIST sleepiness = min, (low), medium, high, max
VAR _flt_sleepiness = 0.0
~ _flt_sleepiness = LIST_VALUE(sleepiness)
// Decreases with exercise
LIST fitness = min, low, medium, (high), max
VAR _flt_fitness = 0.0
~ _flt_fitness = LIST_VALUE(fitness)

== function stat_pc(_stat)
{ _stat:
  - sleepiness:  
        ~ return _stat_pc(_flt_sleepiness)
  - lust:  
        ~ return _stat_pc(_flt_lust)
  - hunger:  
        ~ return _stat_pc(_flt_hunger)
  - addiction:  
        ~ return _stat_pc(_flt_addiction)
  - confidence:  
        ~ return _stat_pc(_flt_confidence)
  - obedience:  
        ~ return _stat_pc(_flt_obedience)
  - fitness:  
        ~ return _stat_pc(_flt_fitness)
   
} 

== function _stat_pc(_v)
~ return INT(((_v-1) * 25) + 0.5)

=== stats

= display
<- grind_stat.display
->->



= reset(_path)
{_path:
 - adventure:

        ~ setstat(sleepiness, sleepiness.low)
        ~ setstat(lust,lust.low)
        ~ setstat(addiction,addiction.high)
        ~ setstat(hunger,hunger.low)
        ~ setstat(confidence,confidence.high)
        ~ setstat(obedience,obedience.low)
        ~ setstat(fitness,fitness.medium)
- sub:
        ~ setstat(sleepiness,sleepiness.min)
        ~ setstat(lust,lust.low)
        ~ setstat(hunger,hunger.low)
        ~ setstat(addiction,addiction.low)
        ~ setstat(confidence,confidence.low)
        ~ setstat(obedience,obedience.medium)
        ~ setstat(fitness,fitness.low)

}
->->


== function stat_snapshot
~ return (sleepiness + lust + addiction + hunger + confidence + obedience + fitness + num2trib(_cc))

== function load_snapshot(snapshot)

    ~ setstat(sleepiness, snapshot ^ LIST_ALL(sleepiness))
    ~ setstat(lust,snapshot ^ LIST_ALL(lust))
    ~ setstat(hunger, snapshot ^ LIST_ALL(hunger))
    ~ setstat(addiction, snapshot ^ LIST_ALL(addiction))
    ~ setstat(confidence, snapshot ^ LIST_ALL(confidence))
    ~ setstat(obedience, snapshot ^ LIST_ALL(obedience))
    ~ setstat(fitness, snapshot ^ LIST_ALL(fitness))
    ~ _cc = trib2num(snapshot)


== function setstat(ref _stat, val)
    ~ _stat = val
{ _stat:
  - sleepiness:  
        ~ _flt_sleepiness = LIST_VALUE(sleepiness)
  - lust:  
        ~ _flt_lust = LIST_VALUE(lust)
  - hunger:  
        ~ _flt_hunger = LIST_VALUE(hunger)
  - addiction:  
        ~ _flt_addiction = LIST_VALUE(addiction)
  - confidence:  
        ~ _flt_confidence = LIST_VALUE(confidence)
  - obedience:  
        ~ _flt_obedience = LIST_VALUE(obedience)
  - fitness:  
        ~ _flt_fitness = LIST_VALUE(fitness)
   
}    
    


== function incstat(_stat)
~ return deltastat(_stat, 1)

== function decstat(_stat)
~ return deltastat(_stat, -1)

VAR SHOW_STAT_CHANGES = false
// each stat has its own "speed" for inc and dec, which is it's "delta"
// e.g. if delta is 0.1, it takes 10 increments to actually change to the 
// next highest state
=== function deltastat(_stat, amount)
{SHOW_STAT_CHANGES:<br>}
{_stat:
  - sleepiness:  
{SHOW_STAT_CHANGES:<>😴 {amount > 0:{amount > 1: ⏫|🔼}|{amount < -1: ⏬|🔽}} <>}
        ~ _deltastat_sub1(sleepiness, _flt_sleepiness, 1.0 * amount)
  - lust:  
{SHOW_STAT_CHANGES:<>🌶️ {amount > 0:{amount > 1: ⏫|🔼}|{amount < -1: ⏬|🔽}} <>}
        ~ _deltastat_sub1(lust, _flt_lust, 0.1 * amount)
  - hunger:  
{SHOW_STAT_CHANGES:<>🍕 {amount > 0:{amount > 1: ⏫|🔼}|{amount < -1: ⏬|🔽}} <>}
        ~ _deltastat_sub1(hunger, _flt_hunger, 1.0 * amount)
  - addiction:  
{SHOW_STAT_CHANGES:<>💉 {amount > 0:{amount > 1: ⏫|🔼}|{amount < -1: ⏬|🔽}} <>}
        ~ _deltastat_sub1(addiction, _flt_addiction, 0.05 * amount)
  - confidence:  
{SHOW_STAT_CHANGES:<>🦚 {amount > 0:{amount > 1: ⏫|🔼}|{amount < -1: ⏬|🔽}} <>}
        ~ _deltastat_sub1(confidence, _flt_confidence, 0.05 * amount)
  - obedience:  
{SHOW_STAT_CHANGES:<>🙏🏻 {amount > 0:{amount > 1: ⏫|🔼}|{amount < -1: ⏬|🔽}}} <>
        ~ _deltastat_sub1(obedience, _flt_obedience, 0.05 * amount)
  - fitness:  
{SHOW_STAT_CHANGES:<>💪🏻 {amount > 0:{amount > 1: ⏫|🔼}|{amount < -1: ⏬|🔽}}} <>
        ~ _deltastat_sub1(fitness, _flt_fitness, 0.1 * amount)
   
}

~ return _stat

=== function _deltastat_sub1(ref statevar, ref flt_statevar, delta)

~ temp la = LIST_ALL(statevar)
~ temp _max = LIST_COUNT(la)

~ flt_statevar += delta 
{flt_statevar < 1:
    ~ flt_statevar = 1
}
{flt_statevar > _max:
    ~ flt_statevar = _max 
}
 ~ statevar = item_at_index(la, INT(flt_statevar + 0.5))
 

