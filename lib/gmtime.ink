// BEGIN gmtime.ink

/*
Copyright (c) 2024 nice90sguy@gmail.com
Portions copied right (!) from  Un*x gmtime.c

See also:
https://stackoverflow.com/questions/15627307/epoch-seconds-to-date-conversion-on-a-limited-embedded-device
This gmtime code has been checked against https://www.epochconverter.com/

   Example:
   ~ epoch_time = 1720872518 // 2024-07-13 12:08:38
   
   ~ gmtime() 

    Date: <b>{day_name()}, {month_name()} {ord(_day)}
    Time: <b>{l0(tm_hour)}:{l0(tm_min)}:{l0(tm_sec)}
*/
VAR dayno = 0
VAR _year = 0
VAR epoch_time = 0
VAR _month = 1
VAR _day = 0
VAR tm_sec = 0
VAR tm_min = 0
VAR tm_hour = 0
VAR tm_wday = 0
CONST SECS_DAY = 86400
CONST EPOCH_YR = 1970
CONST YEAR0 = 1900
CONST FAR_FUTURE = 2147483647 // 03:14:07 on Tuesday, 19 January 2038
/* 

Convert an "epoch_time" t, which should be a unix timestamp (seconds since Jan 01 , 1970), update these global variables (which are all integer values):

   _year - The _year
   _month - The _month (Jan is 1)
   _day - _day of the _month
   tm_wday - The _day of the week (Sun is 0, Sat is 6)
   tm_hour - The hour (0 - 23)
   tm_min - Minutes past the hour
   tm_sec - Seconds past the minute
   
   returns t.

*/
=== function gmtime(t)
    ~ _year = EPOCH_YR
    ~ temp dayclock = t % SECS_DAY
    ~ dayno = t / SECS_DAY
    ~ tm_sec = dayclock % 60
    ~ tm_min = (dayclock % 3600) / 60
    ~ tm_hour = dayclock / 3600
    ~ tm_wday = (dayno + 4) % 7
    ~ gmtime_loop_1_recursion()
    ~ _month = 1
    ~ gmtime_loop_2_recursion()
     ~ _day = dayno + 1
    ~ return t

=== function gmtime_loop_1_recursion
    ~ temp yearsize = YEARSIZE()
    { dayno < yearsize: 
      ~ return
     }

  ~ dayno -= yearsize
  ~ _year++
  ~ return gmtime_loop_1_recursion()
 
=== function gmtime_loop_2_recursion

  ~ temp month_length = month_duration_days(_month)
    { dayno < month_length:
        ~ return
    }

    ~ dayno -= month_length
    ~ _month++
    ~ return gmtime_loop_2_recursion()

// returns 1 if leap _year, 0 otherwise
=== function LEAPYEAR()
    ~ temp is_leap_year = (!(_year % 4) && ((_year % 100) || !(_year % 400)))
    { is_leap_year:
        ~ return 1
    - else:
        ~ return 0
    }
    
=== function YEARSIZE()
     { LEAPYEAR() == 1:
        ~ return 366
     -   else:
        ~ return 365
    }
    
=== function month_duration_days(m)
    ~ temp add_day_to_feb = LEAPYEAR()
    
    { m:
        - 1: ~ return 31
        - 2: ~ return 28 + add_day_to_feb
        - 3: ~ return 31
        - 4: ~ return 30
        - 5: ~ return 31
        - 6: ~ return 30
        - 7: ~ return 31
        - 8: ~ return 31
        - 9: ~ return 30   
        - 10: ~ return 31
        - 11: ~ return 30
        - 12: ~ return 31  
      }

=== function _date(t, ref d, ref m)
~ temp _now = epoch_time
~ gmtime(t)
~ d = _day
~ m = _month
~ gmtime(_now)

=== function datetime(t)
~ temp _now = epoch_time
~ gmtime(t)
{today()}, {month_name()} {ord(_day)} {last_displayed_year!=_year:, {_year}|} {l0(tm_hour)}:{l0(tm_min)}:{l0(tm_sec)}
~ gmtime(_now)


=== function _time(t, ref h, ref m, ref s)
~ temp _now = epoch_time
~ gmtime(t)
~ h = tm_hour
~ m = tm_min
~ s = tm_sec
~ gmtime(_now)


=== function hhmm(t)
~ temp h = 0
~ temp m = 0
~ temp s = 0
~ _time(t, h, m, s)
{l0(h)}:{l0(m)}

=== function hhmmss(t)
~ temp h = 0
~ temp m = 0
~ temp s = 0
~ _time(t, h, m, s)
{l0(h)}:{l0(m)}:{l0(s)}

=== function ddmm(t)
~ temp d = 0
~ temp m  = 0
~ _date(t, d, m)
{l0(d)}/{l0(m)}

// Add leading zeros for _day, _month, hour etc if < 10
=== function l0(num)
    { num < 10: 
        ~ return "0"+num
    - else:
        ~ return num
    }
    
LIST MONTH_NAMES = January,February,March,April,May,June,July,August,September,October,November,December
=== function month_name()
    ~ return MONTH_NAMES(_month)

LIST DAY_NAMES = Sunday=0,Monday,Tuesday,Wednesday,Thursday,Friday,Saturday
=== function today()
    ~ return DAY_NAMES(tm_wday)
=== function tomorrow()
    ~ return DAY_NAMES((tm_wday+1) % 7)
=== function yesterday()
    ~ return DAY_NAMES((tm_wday+6) % 7)


// The timestamp at next hh:mm o'clock
== function next_hm(h, m)
~ temp t = ((epoch_time / SECS_DAY) * SECS_DAY) + (3600 * h) + (60 * m)
{ t < epoch_time:
    ~ t += SECS_DAY
}
~ return t

=== function now()
    ~ return epoch_time

=== function set_time(t)
    ~ epoch_time = gmtime(t)

=== function set_dMy(d,m,y)
 ~ set_dmy(d,LIST_VALUE(m),y)
 
// set epoch time to midnight on _day/_month/_year (>= Jan 1, 1970)
=== function set_dmy(d,m,y)
{m > 12: 
    ~ m = m % 12
}
{m == 0: 
    ~ m = 12
}


// Start on Jan 1, 1970, reset datetime vars
~ _year = EPOCH_YR
~ _month = 1
~ dayno = 0
~ _set_dmy_y(y)
~ _set_dmy_m(m)

// If d > number of days in m, adjust to last _day of _month
{d > month_duration_days(m):
    ~ d = month_duration_days(m)
}
~ epoch_time = (dayno + d-1) * SECS_DAY
~ gmtime(epoch_time)


=== function _set_dmy_y(y)
{ _year == y:
    ~return
}

~ dayno += YEARSIZE()
~ _year++

~ return _set_dmy_y(y)


=== function _set_dmy_m(m)
{ _month == m:
    ~return
}

~ dayno += month_duration_days(_month)
~ _month++

~ return _set_dmy_m(m)
 
// Set time to hour and minute  and second on the current _day
=== function set_hms(h, m, s)
~ epoch_time = (epoch_time / SECS_DAY) * SECS_DAY + 3600 * h + 60 * m + s
~ gmtime(epoch_time)


// Fast forward (or flashback!) to hour and minute on the current _day
=== function set_hm(h, m)
~ set_hms(h, m, 0)

    
// END gmtime.ink
