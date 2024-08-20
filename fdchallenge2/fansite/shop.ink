



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
        -> search_media_dialog(LIST_ALL(search_tags), available_items, found_items) ->
        
        {found_items == ():No items available for {search_tags}).-> do}
        ~ temp n_found = LIST_COUNT(found_items)
        Found {n_found} item{n_found!=1:s}.
        
        -> disp_titles(found_items) ->
        Add {n_found==1:it|them} to your favourites?
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

= disp_titles(m)
{m != ():
 ~ temp tags = (lum_desc)
-> lookup_media(LIST_MIN(m), tags) ->
-> disp_titles(m-LIST_MIN(m)) ->
}
->->

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
=== inventory_find_photo(ref chosen_photo)
    
    ~ temp available_photos = ()
    -> search_media(photo, available_items, available_photos) ->
    
    { available_photos == ():>>> Bella has no more photos to send you!}
    ~ chosen_photo = LIST_MIN(available_photos)
    {chosen_photo:
        ~ chosen_photo += num2list(LIST_VALUE(chosen_photo))
    }
->->


