=== grind_messages

= opt
You have {unread_message_count:{print_number(unread_message_count)}|no} unread message{unread_message_count!=1:s}.
<><br><>

+ + (do) {unread_message_count}[Read Messages 💬] ->
    // -> message_log.disp ->
    // -> p1("Respond to messages (newest first)") ->
    ~ speech_type = speech_type_wa
    -> wa.read_missed_messages(true) ->
    ->ffa(minute, 10)->
    -> grind.after_activity
    
= 
