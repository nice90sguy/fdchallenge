
/*
// Search a list by a list of search tags. If any items in the list contain one or more of the search tags, they're added to search_results.
// The items in the list to be searched should each be "tagged" with its categories:

// For example:

// Example usage:

// LIST movies = avatar_sf_animated_, dumbo_animated_,  _2001_a_space_odyssey_sf_

// LIST search_tags = sf, animated, adult, comedy

// VAR search_results = ()
// {search(sf, LIST_ALL(movies), search_results)}
// Search results: {search_results}

// To find movies that are BOTH sf and comedy, you can do two searches, and return 
// the intersection.

A ^ B 
*/
LIST search_match_type = match_all, match_any
CONST _SEPARATOR="_"


=== function search(tags, list, match_type)
~ temp result = ()
{match_type:
     - match_any:
        ~ result = ()
    - match_all:
         ~ result = list
    - else:
        >>> search: match_type must be one of {LIST_ALL(search_match_type)}
        ~ return ()
}
~ _search_(tags, list, result, match_type)
~ return result


=== function _search_(tags, list, ref result, match_type)

{tags != ():
    ~ temp first_tag = LIST_MIN(tags)

    ~ search_tag(first_tag, list, result, match_type)

    ~ _search_(tags-first_tag, list, result, match_type)
}    

// If match_type is match_all, remove all the items from partial_result that DONT have the given tag (result += found_tags)
// If match_type is match_any, add all the items that have the given tag to partial_result  (result -= LIST_INVERSE(found_tags))
=== function search_tag(tag, list, ref partial_result, match_type)
{list != ():

    ~ temp item = LIST_MIN(list)

    ~ temp match = has_tag(item, tag)

    {match_type:
    - match_any:
    
        {match:
            ~ partial_result += item
        }
        
    - match_all:
        {not match:
            
            ~ partial_result -= item   
        }
    }
    ~ search_tag(tag, list-item, partial_result, match_type)
}

=== function has_tag(item, tag)

~ return "{item}" ? "{tag}{_SEPARATOR}"

=== function get_tags(item, possible_tags)

    ~ temp item_tags = ()
    ~ _get_tags(item, possible_tags, item_tags)

    ~ return item_tags
    
=== function _get_tags(item, possible_tags, ref item_tags)
~ temp tag = LIST_MIN(possible_tags)
{tag != ():
    {has_tag(item, tag):
        ~ item_tags += tag
    }
    ~ _get_tags(item, possible_tags-tag, item_tags)
}

=== list_utils
= move_item(item, ref from, ref to)
    ~ from -= item
    ~ to += item
->->



