// Work proposition from Al and from Bella 


VAR tagged_videos = ()
VAR untagged_videos = ()
VAR skipped_videos = ()

=== work_proposition_bella
-> wa.m("We need to talk",WAM_READ+WAM_PAUSE) ->
You don't know what she means, but you suddenly feel dread.  She's definitely serious about something.  You respond quickly:
{M_wa_S(YOU)}Ok.

{M_wa_S(BELLA)} You're a tech guy arent you
You're not sure where she's going with this:
-> cont ->
{M_wa_S(YOU)}Yes.
{M_wa_S(BELLA)} i have a great job for you
You wait for her to go on. The app shows that she's busy typing...
-> cont ->
...and typing...
-> cont ->
-> ffa(minute, 3) ->
Eventually you get a long message from her:
{M_wa_S(BELLA)} 
I have some videos on my site that need their tags checked, there are a lot of them.  Some of them will also need to be converted to .mp4 files.  i will pay you for the work of course,  a fair rate, dont worry.  you need to start today. i will send you the links to the files in a minute and then you can start immediately.  i suggest you empty your balls before you start work from now on, you will not be very productive otherwise lol
{M_wa_S(BELLA)} the work won't take long, if you do it non stop. I'll pay you ${payment_for_correct_video_tag} per video if you tag them correctly. 
{M_wa_S(BELLA)} oh in case you were wondering, no you dont have a choice and yes, im serious about all this.  
{M_wa_S(BELLA)} any questions?


{M_wa_S(YOU)}no

{M_wa_S(BELLA)}good. start now
~ employer = bella_org
-> cont ->
That seems to be the end of that conversation.
~ available_employers = bella_org
{hint()}  Choose "Work for {BELLA_NAME}" from the activity menu!


 ~ untagged_videos = search(video, LIST_ALL(media), match_any)
// Number of videos: {LIST_COUNT(untagged_videos)}

// Total cost of videos: {LIST_TOTAL(untagged_videos)}
// ~ temp video_ = LIST_RANDOM(untagged_videos)
// -> tag_a_video(video_) ->

->->

VAR payment_for_correct_video_tag = 100

==  tag_a_video(video_)
~ temp lum_arg = ()

->lookup_media(video_, lum_arg) ->
>>> lum_arg = {lum_arg}
~ temp actual_tags = (lum_arg ^ LIST_ALL(search_tags))-video

{_DEBUG:>>> Video: ({video_})}
    -> ffa(minute, 5) ->
    ~ lum_arg = lum_desc
    It's titled: "<> ->lookup_media(video_, lum_arg) ->
    <>"
+ [Make a wild guess at the tags]
    -> ffa(minute, 5) ->
+ [Watch the video first]
    ~ lum_arg = lum_narr
    ->lookup_media(video_, lum_arg) ->
    -> ffa(minute, 15) ->
    ~ incstat(lust)
+ [Come back to this one later] ->
    -> list_utils.move_item(video_, untagged_videos, skipped_videos) ->-> 
-
-> ffa(minute, 5) ->
~ temp guessed_tags = ()
~ temp num_actual_tags = LIST_COUNT(actual_tags)

The video has {print_number(num_actual_tags)} tag{num_actual_tags!=1:s}.
-> multiselect(LIST_ALL(search_tags)-photo-video, guessed_tags, num_actual_tags, num_actual_tags, "tag") ->
~ temp matched_tags = actual_tags ^ guessed_tags
~ temp num_wrong_tags = num_actual_tags - LIST_COUNT(matched_tags)
{num_wrong_tags:
    - 0:
        ~incstat(confidence)
        ->cc.receive(employer_name(), payment_for_correct_video_tag, true) ->
        -> list_utils.move_item(video_, untagged_videos, tagged_videos) ->
        Right!  {print_number_c(LIST_COUNT(tagged_videos))} down, {print_number(LIST_COUNT(untagged_videos)+LIST_COUNT(skipped_videos))} to go!
        ->->
    
    - num_actual_tags:
        ~decstat(confidence)
        You were way off the mark with your guesses!     
     -else:
        You got {list_with_commas(matched_tags)} right, but the other {print_number(num_wrong_tags)} {num_wrong_tags==1:was|were} wrong. You'll need to come back to it later.

}
// only reach here if not all correct   
-> list_utils.move_item(video_, untagged_videos, skipped_videos) ->->   



->->

