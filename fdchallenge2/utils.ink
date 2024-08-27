// Time prompt
=== tp

    Time now: <b>{l0(tm_hour)}:{l0(tm_min)}
    
+ [<i>Continue...</i>]
-
->->

// Time prompt with seconds
=== tps
    
    Time now: <b>{l0(tm_hour)}:{l0(tm_min)}:{l0(tm_sec)}
    
-> cont ->
->->
// Date prompt
=== dp
    
    
    Date:  <b>{today()}, {month_name()} {ord(_day)}
    
-> cont ->
->->
// Date and time prompt
VAR last_displayed_year = 0
=== dtp
    
    Date: <b>{today()}, {month_name()} {ord(_day)} {last_displayed_year!=_year:, {_year}|}</b><br><>
    Time: <b>{ampm()} // :{l0(tm_sec)}
    ~ last_displayed_year = _year
    
-> cont ->
->->


== tbc
{warn()} <b>(TODO)</b><i> To be continued...
-> END




== function pod_img
{period_of_day():
    - morning: 🌄 
    - afternoon: ☀️
    - evening: 🌇
    - night: 🌃
    } <>

== function warn
<p>⚠️ <i><>

== function think
<p> 💭<i><>
== function hint
<p>🧠 <i><>

== function bella
<p>👩🏻 <i><>

== function devil_angry
👿 <i><>

== function angel
 👼🏻<i><>

== function devil_happy
😈 <i><>

== function question
<p>❓<i><>

== function camera
📷 <i><>

== function videocam
📹 <i><>

== function bella_chat
💬<>

== function you_chat
<>🗨️

VAR DISPLAY_ANALOG_CLOCK=true
== function analog_clk
{DISPLAY_ANALOG_CLOCK:
 <>   {tm_hour % 12:
        -1:🕐
        -2:🕑
        -3:🕒
        -4:🕓
        -5:🕔
        -6:🕕
        -7:🕖
        -8:🕗
        -9:🕘
        -10:🕙
        -11:🕚
        -0:🕛
    }
    <>
}

LIST speech_type = (speech_type_voice), speech_type_wa, speech_type_chat

=== function _emo(emoji)
{ speech_type==speech_type_voice:
    { emoji:
        - "🙄": (rolls eyes)
        - "😁": (laughs)
        - "(laugh)" :😁
        - "(rolleyes)": 🙄:
        - else:  {_DEBUG:>>> Can't interpret emoji for voice}
        
    }
- else: {emoji}
}
    

// thread
VAR CRCHOICE = 0
== crchoice(msg, opt, ->from)
* {msg} [{msg}] -> M_Y(msg) ->
~ CRCHOICE = opt
->from

== cr3choices(choice1,choice2,choice3)
- (opts)
<- crchoice(choice1, CHOICE_COUNT()+1, ->opts)
<- crchoice(choice2, CHOICE_COUNT()+1,  ->opts)
<- crchoice(choice3, CHOICE_COUNT() +1,->opts)
* ->

->->