
LIST FF_FLAGS = fff_bypass_record
LIST FF_TIMEUNITS = second, minute, hour, day, week, month, year

LIST DAYINTERVALS = morning=5, afternoon=12, evening=18, night=22

// For e.g. "10 minutes later..." or "6 months later"...
VAR prev_ff_units = ()
VAR prev_ff_by = 0

// Depends on gmtime.ink

// fast forward time by "by" TIMEUNITS
// returns elapsed time in seconds
// Use this function instead of directly calling the underscore_ functions that it dispatches.
// That way, the function "later()" will work properly.
=== function ff(units, by)
~ temp _now = epoch_time
{ units ? fff_bypass_record:
    ~  units -= fff_bypass_record
- else:
    ~ prev_ff_units = units
    ~ prev_ff_by = by
}
{ units:
    - second: ~ _ffs(by)
    - minute: ~ _ffm(by)   
    - hour: ~ _ffh(by)
    - day: ~ _ffd(by)
    - month: ~ _ffmo(by)
    - year: ~ _ffy(by)
}


~ return epoch_time - _now

// Get Future time without actually fast-forwarding to it
=== function ft(units, by)
   ~ temp now_ = epoch_time
   ~ ff(units, by)
   ~ temp future_time = epoch_time
   ~ epoch_time = gmtime(now_)
   ~ return future_time


// fast forward by years
== function _ffy(y)
~ set_dmy(_day, _month, _year + y)

// fast forward by months
== function _ffmo(m)
~ temp _m  = (_month + m) % 12
{_m == 0:
    ~ _m = 12
}
~ temp ny = (_month + m) / 12 // number of years ahead
~ set_dmy(_day, _m, _year + ny)


// fast forward by seconds
=== function _ffs(s)

~ epoch_time += s
~ gmtime(epoch_time)
//<i>{s} seconds{s > 1:s} later...

// fast forward by minutes
=== function _ffm(m)
~ epoch_time += m * 60
~ gmtime(epoch_time)
//<i>{m} minute{m > 1:s} later...


// fast forward by hours
=== function _ffh(h)
~ epoch_time += h * _interval
~ gmtime(epoch_time)
//<i>{h} hour{h > 1:s} later...

// fast forward to an exact hour
=== ff2h(h)
// modulo hour
    ~ epoch_time -= epoch_time % _interval
    -> ffa(hour, h) ->
    ->->

// Fast forward to midnight d days ahead
=== function _ffd(d)
    ~ epoch_time = epoch_time / SECS_DAY
    ~ epoch_time += d
    ~ epoch_time = epoch_time * SECS_DAY
    ~ gmtime(epoch_time)


// fast forward to a named day of the week (i.e. 1-7 days ahead)
// if tm_wday currently == dow, ff by one week
=== ff2DOW(dow)
-> ff2dow(LIST_VALUE(dow)) ->->

// fast forward to a day of the week (i.e. 1-7 days ahead)
// if tm_wday currently == dow, ff by one week
=== ff2dow(dow)
    ~ temp interval = dow - tm_wday
    {interval <= 0:
        ~ interval += 7
    }
    -> ffa(day, interval) ->->


=== function approx_time(t)

~ temp _now = epoch_time
~ gmtime(t)
~ temp m = tm_min
~ temp h = tm_hour
~ gmtime(_now)
CONST approx_time_crudeness_m = 5
~ temp m_approx = (INT(m + 7.5) / approx_time_crudeness_m) * approx_time_crudeness_m

{ 
 -m_approx < m: {~a little after|shortly after|just after} <>
 - m_approx == m:at <>
 -else:
    {~a little before|shortly before|just before} <>

}
{m_approx == 60:
    ~ h++
    ~m_approx = 0
}
{ampm_hm(h, m_approx)}


// AM/PM for hour
=== function ampm_hm(h, m)
    {h==12:{h}|{h % 12}}{m::{l0(m)}} {h < 12:a.m.|p.m.}
  
// AM/PM for current hour
=== function ampm()
~ ampm_hm(tm_hour, tm_min)

// AM PM for some epoch_time




// Alarm utils

LIST ALARM_TYPE = ALARM_TYPE_INTERVAL, ALARM_TYPE_TIMER
VAR _next_interval = FAR_FUTURE
VAR _next_timer = FAR_FUTURE
VAR _interval = 3600 // default one hour
VAR _interval_cb = 0
VAR _timer_cb = 0


== function _did_stop_ffa_at_alarm_time(ref future_time)

    {_next_interval <= _next_timer:
        {future_time >= _next_interval:
            ~ future_time = _next_interval
            ~ return ALARM_TYPE_INTERVAL
        }
    - else:
        {future_time >= _next_timer:
            ~ future_time = _next_timer
            ~ return ALARM_TYPE_TIMER
        }
    }
    ~ return ()
// 
== function set_interval_cb(interval, ->cb)
{_DEBUG:{IN_CALLBACK:>>> !!! Should not set interval callback within callback {_interval_cb}}}
    ~ _interval = interval
    ~ _next_interval = (epoch_time / _interval) * _interval + _interval
    ~ _interval_cb = cb
    
== function set_timer_cb(seconds_from_now, ->cb)

{_DEBUG:{IN_CALLBACK:>>> !!! Should not set callback within callback {_timer_cb}}}
    ~ _next_timer = epoch_time + seconds_from_now

    ~ _timer_cb = cb
// Prevent rentry
VAR IN_CALLBACK = false
//VAR ff_in_callback_time = 0
// fast forward time, checking for interrupt

 == ffa(units, by)
~ temp future_time = ft(units, by)
{IN_CALLBACK:
{_DEBUG:>>> !!! Should not call ffa from within callback {_interval_cb}. Accruing {future_time-epoch_time}s.}
}

    ~ temp extra_time = 0


    ~ temp stopped_time = future_time
    ~ temp alarm =_did_stop_ffa_at_alarm_time(stopped_time)

    {alarm != ():
        ~ extra_time = future_time - stopped_time
        {alarm == ALARM_TYPE_INTERVAL:
            ~ _next_interval += _interval
        -else:
            ~ _next_timer = FAR_FUTURE
        }
        ~ IN_CALLBACK = true
        ~ epoch_time = gmtime(stopped_time)
        {alarm==ALARM_TYPE_INTERVAL:-> _interval_cb ->|-> _timer_cb ->}

        ~ IN_CALLBACK = false
        
        -> ffa(second + fff_bypass_record, extra_time) ->
     - else: 

//        ~ ff_in_callback_time = 0
        ~ ff(units, by)
        ->->
    }

 ->->
 
 
 // ff to start of tomorrow (midnight tonight), or wind back to beginning (midnight) of today
=== eod 
-> ffa(day, 1) ->->

=== bod
~ _ffd(0)
->->


=== function about_a_minute
~ return 60 + (-10+RANDOM(0,20))

=== function about_an_hour
~ return _interval + (60  * (-10+RANDOM(0,20)))

=== later(sos)
{prev_ff_units == day and prev_ff_by == 1:the next day}
{sos:{print_number_c(prev_ff_by)}|{print_number(prev_ff_by)}} {prev_ff_units}{prev_ff_by!=1:s|} later<>
->->
=== laterp(sos)
{not prev_ff_units:
    ->->
}
    <i><>-> later(sos) -> 
    ...
    -> cont ->

->->

// The timestamp at previous hh:mm o'clock
== function prev_hm(h, m)
~ temp t = ((epoch_time / SECS_DAY) * SECS_DAY) + (_interval * h) + (60 * m)
{ t > epoch_time:
    ~ t -= SECS_DAY
}
~ return t
== function hours_since(t)
~ return (epoch_time - t) / _interval

== function minutes_since(t)
~ return (epoch_time - t) / 60

== function days_since(t)
~ return (epoch_time / SECS_DAY - t / SECS_DAY) 

=== function period_of_day()
  
{tm_hour >= LIST_VALUE(night) or tm_hour < LIST_VALUE(morning): 
    ~ return night
}

{ tm_hour >= LIST_VALUE(evening) and tm_hour < LIST_VALUE(night): 
    ~ return evening
}

{ tm_hour>= LIST_VALUE(afternoon) and tm_hour < LIST_VALUE(evening):
    ~ return afternoon
}

~ return morning


