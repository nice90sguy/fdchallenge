=== grind_fansite
= opt
{path==adventure:
You know it's a bad idea, but maybe you could see if {BELLA_NAME} is online right now... 
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