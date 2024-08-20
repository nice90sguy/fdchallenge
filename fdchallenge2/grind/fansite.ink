=== grind_fansite
= opt
{path==adventure:
You know it's a bad idea, but maybe you could {bella_online():have a "chat" with {BELLA_NAME}, she's probably|see if {BELLA_NAME} might be} online right now... 
}
<><br><>
+ + (do) [Fan Login 💳] ->
{path != adventure:
     {warn()} You don't have a pin code for the Fan Site.
    {hint()} (Maybe you should have ordered something different at the bar that night!)
    -> cont ->
    -> grind.after_activity
}
    ~ current_activity = logon_fansite
    
    You log on to {BELLA_NAME}'s fan site!
    
    -> fansite