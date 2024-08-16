



VAR owned_items = ()
VAR favourite_items = ()

== fansite_shop
= opt

+ + (do) [Shop 🛒] ->
{do == 1: {hint()} (Some menu items aren't availble in this version)}
    ~ current_activity = fsa_shop
    {_DEBUG:>>> DEBUG: Available items: {available_items}}
    Unlocked items: {owned_items}
    + + + {available_items != ()} [Unlock item(s)]
            {hint()} (Cumming soon)
    + + + [Search for items]
        ~ temp found_items = ()
        -> search_dialog(LIST_ALL(search_tags), available_items, found_items, match_any) ->
        
        {found_items == ():No items available for {search_tags}).-> do}
        
        Found {LIST_COUNT(found_items)} items.

        Add them to your favourites?
        + + + + [Yes]
            ~ favourite_items += found_items
        + + + + [No]
        - - - -
        
    + + + [Browse]
        {hint()} (Cumming soon)
    + + + [Fap to some of your unlocked items]   
        {hint()} (Cumming soon)
    + + + [Back to My Page]
    - - - -> fansite.after_activity
    ~ activities_done_today += fsa_shop
    -> fansite.after_activity


=== inventory
// Items -- values are their prices



= item_desc(item)
{ item:
    - p1: 
A photo of Me 
    - else: 
(No description available)
}
->->

= unlock_item(item, price)
    ~ temp tx_result = ()
    -> fansite_credits.pay(price, tx_result) ->
    {tx_result == FS_TX_SUCCESS:
        -> list_utils.move_item(item, available_items, owned_items) ->
        {bella_online():-> M_B("Good boy.")}

        {current_activity !? fsa_shop:
           {hint()} You can find photos and videos you've unlocked in the Shop 🛒
        }  
    }


->->
=== function inventory_find_photo
    ~ temp available_photos = search(photo, available_items, match_any)
    
    { available_photos == ():>>> Bella has no more photos to send you!}
    ~ temp chosen_photo = LIST_MIN(available_photos)
    {chosen_photo:
        ~ chosen_photo += num2trib(LIST_VALUE(chosen_photo))
    }
    ~ return chosen_photo


