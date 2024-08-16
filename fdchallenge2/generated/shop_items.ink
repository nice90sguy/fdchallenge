LIST search_tags = photo, video, Addiction, Ass,  ATM, Brat, Breasts, CEI, Chastity, Edging, Feet, Heels, Humiliation, Hypnosis, Intox, Joi, Kneel, Legs, Lingerie, Nude, Praise, Worship

LIST media = media_2_photo_Ass_Kneel_Worship_=30, media_3_photo_Legs_Chastity_Lingerie_Addiction_Heels_=50, media_4_photo_Ass_Nude_Humiliation_Joi_Addiction_=40, media_5_photo_Feet_Breasts_Joi_CEI_=45, media_6_photo_ATM_Legs_Heels_=60, media_7_video_Ass_Hypnosis_Legs_Edging_Lingerie_Addiction_Kneel_Worship_Praise_Heels_=120, media_8_video_Hypnosis_Edging_Addiction_=120, media_9_video_Hypnosis_Breasts_Joi_Kneel_=120, media_10_video_Hypnosis_Edging_Heels_=200, media_11_video_Ass_Chastity_Humiliation_Joi_Addiction_=120, media_12_video_ATM_Joi_Edging_Addiction_Brat_=120, media_13_video_atm_=120, media_14_video_Ass_Breasts_Brat_=120, media_15_video_Legs_Praise_=120, media_16_video_Ass_Nude_Hypnosis_ATM_Addiction_Worship_=120, media_17_video_Hypnosis_Edging_Addiction_=120, media_18_video_Hypnosis_Humiliation_Brat_=120, media_19_video_Ass_Nude_Feet_Breasts_Joi_=120, media_20_video_Hypnosis_Feet_Praise_Heels_=120, media_21_video_Chastity_Humiliation_Joi_Addiction_=120, media_22_video_Hypnosis_ATM_Lingerie_Heels_Brat_=120 

VAR available_items = (media_2_photo_Ass_Kneel_Worship_, media_3_photo_Legs_Chastity_Lingerie_Addiction_Heels_, media_4_photo_Ass_Nude_Humiliation_Joi_Addiction_, media_5_photo_Feet_Breasts_Joi_CEI_, media_6_photo_ATM_Legs_Heels_, media_7_video_Ass_Hypnosis_Legs_Edging_Lingerie_Addiction_Kneel_Worship_Praise_Heels_, media_8_video_Hypnosis_Edging_Addiction_, media_9_video_Hypnosis_Breasts_Joi_Kneel_, media_10_video_Hypnosis_Edging_Heels_, media_11_video_Ass_Chastity_Humiliation_Joi_Addiction_, media_12_video_ATM_Joi_Edging_Addiction_Brat_, media_13_video_atm_, media_14_video_Ass_Breasts_Brat_, media_15_video_Legs_Praise_, media_16_video_Ass_Nude_Hypnosis_ATM_Addiction_Worship_, media_17_video_Hypnosis_Edging_Addiction_, media_18_video_Hypnosis_Humiliation_Brat_, media_19_video_Ass_Nude_Feet_Breasts_Joi_, media_20_video_Hypnosis_Feet_Praise_Heels_, media_21_video_Chastity_Humiliation_Joi_Addiction_, media_22_video_Hypnosis_ATM_Lingerie_Heels_Brat_)

=== function media_from_id(id)
{typeof(id) != lst_t:
    ~ id = "{id}_"
}
    ~ return _media_from_id(id, LIST_ALL(media))
=== function _media_from_id(id, media_list)
{media_list == ():
    ~ return ()
}
~ temp media_item = LIST_MIN(media_list)
{"{media_item}" ? "{id}":
    ~ return media_item
}
~ return _media_from_id(id, media_list-media_item)

=== lookup_media(id, narrative)
~ temp p_media = media_from_id(id)
{p_media:

	-media_7_video_Ass_Hypnosis_Legs_Edging_Lingerie_Addiction_Kneel_Worship_Praise_Heels_: 
		->media_narratives.narr_7("Goddess Mind-Fuck",narrative)
	-media_8_video_Hypnosis_Edging_Addiction_: 
		->media_narratives.narr_8("Fall deeper under my spell",narrative)
	-media_9_video_Hypnosis_Breasts_Joi_Kneel_: 
		->media_narratives.narr_9("Your new purpose",narrative)
	-media_10_video_Hypnosis_Edging_Heels_: 
		->media_narratives.narr_10("Goon to My Shiny Heels",narrative)
	-media_11_video_Ass_Chastity_Humiliation_Joi_Addiction_: 
		->media_narratives.narr_11("Leave your GF",narrative)
	-media_12_video_ATM_Joi_Edging_Addiction_Brat_: 
		->media_narratives.narr_12("Buy Me Stuff, Keep Me Happy",narrative)
	-media_13_video_atm_: 
		->media_narratives.narr_13("Advice from a Financial Advisor",narrative)
	-media_14_video_Ass_Breasts_Brat_: 
		->media_narratives.narr_14("Pay Off My Student Debt",narrative)
	-media_15_video_Legs_Praise_: 
		->media_narratives.narr_15("Making Me Happy Makes You Hard",narrative)
	-media_16_video_Ass_Nude_Hypnosis_ATM_Addiction_Worship_: 
		->media_narratives.narr_16("Goddess of Love",narrative)
	-media_17_video_Hypnosis_Edging_Addiction_: 
		->media_narratives.narr_17("Embrace Your Addiction",narrative)
	-media_18_video_Hypnosis_Humiliation_Brat_: 
		->media_narratives.narr_18("Job Interview Switcheroo",narrative)
	-media_19_video_Ass_Nude_Feet_Breasts_Joi_: 
		->media_narratives.narr_19("The Joy of Joi",narrative)
	-media_20_video_Hypnosis_Feet_Praise_Heels_: 
		->media_narratives.narr_20("You need My Praise",narrative)
	-media_21_video_Chastity_Humiliation_Joi_Addiction_: 
		->media_narratives.narr_21("You don't need Sex, You have Me",narrative)
	-media_22_video_Hypnosis_ATM_Lingerie_Heels_Brat_: 
		->media_narratives.narr_22("Stop Spending on You",narrative)
	-media_2_photo_Ass_Kneel_Worship_: 
		->media_narratives.narr_2("Ass to die for",narrative)
	-media_3_photo_Legs_Chastity_Lingerie_Addiction_Heels_: 
		->media_narratives.narr_3("Count the days",narrative)
	-media_4_photo_Ass_Nude_Humiliation_Joi_Addiction_: 
		->media_narratives.narr_4("Pray for release",narrative)
	-media_5_photo_Feet_Breasts_Joi_CEI_: 
		->media_narratives.narr_5("Eat your cum and thank me",narrative)
	-media_6_photo_ATM_Legs_Heels_: 
		->media_narratives.narr_6("Shopping Spree",narrative)

}->->

===  media_narratives


 

= narr_7(title, narrative)
{not narrative:
	{title}
	->->
}

 
 // Goddess Mind-Fuck
 
 <i>She's wearing red lace underwear. She glides casually around her living room; her  red stilletto heels make a clicking sound on the wooden parquet floor.
 "Get on your knees."
 -> p1("Get on your knees") ->
 "Good boy."
 
<i>Close up of her ass. Her black lace panties are pulled up tight.  We look up at that perfect ass, for minutes...
-> p1("Keep watching") ->
<i>She strokes her butt-cheek gently, and finally starts speaking:
"That's right, fall deeper..."
<i>Time seems to slow down...
-> p1("Keep watching") ->
<i>You feel numb. Your dick is so hard, but you don't stroke...
-> p1("Keep watching") ->
"Good boy..."
<i>Cross-fade to her on her sofa, her bare legs stretched casually along it.
"I'm so perfect, aren't I... look at these long... perfectly shaped legs..."
<i> She raises one leg, and waggles her ankle slowly, drawing attention to her heels.
"Yes, my good boy addict, they're so perfect.  Your Goddess is perfect..."
"Pray to your Goddess, my good boy.  Stay on your knees, and pray to me. You like being my good boy, don't you?"
-> p1("Yes Goddess") ->
<i>She laughs... </i> "Yes you do.  And because you've been so good, such a good worshipper, I'm get to let you stroke to me."
"But what do good worshippers do for Goddess {BELLA_NAME}?"

"That's right, they don't cum. So stay on the edge for your Goddess..."

<i>You've lost track of time, and you're so hypnotised, you hardly notice that the video has ended...
-> ffa(minute, 45) ->
->->

 

= narr_8(title, narrative)
{not narrative:
	{title}
	->->
}

 
// Fall deeper under my spell

<i>A red and green rotating spiral...
-> p1("Get lost in it...") ->
"You need me."
"You need me."
"You need me more than anything..."
"Stroke."
-> p1("Jerk slowly...") ->
"Your mind is empty..."
"Your balls, so, so full..."
-> p1("Jerk faster...") ->
"Stroke."
-> p1("Jerk faster...") ->
-> p1("You're almost there...") ->
"Now, Stop."
<i>Her lips fade in to center of the spiral, while it fades out.  We see her face.

"Stay on the edge, thinking of me..."
-> p1("Ow... my ballss...") ->
"...until you buy my next video."
<i>Video fades to white...<i>
-> ffa(minute, 15) ->
->->

 

= narr_9(title, narrative)
{not narrative:
	{title}
	->->
}

// Your new purpose

// TODO media_9_video_Hypnosis_Breasts_Joi_Kneel_ description to be written
<i>A close-up of her cleavage, with a gold heart-pending nestling there.  Her middle-finger slides up and down between her round breasts.
"This is your challenge for today, my mindless gooners," <i>she says.

"Stare at them..."
-> p1("Stare at them") ->
"...while on your knees..."
-> p1("Go down onto your knees") ->
"...and stroke that fat dick..."
-> p1("Already on it...") ->
"...and..."
<i> She snaps her fingers, and says, </i> "DROP."
-> p1("Your eyes fall closed.") ->
<i>You really ought to be watching, you're meant to be looking for content tags here, and besides... the view you're missing...
<i>With an effort, you manage to open your eyes, but...
"Eyes closed.  Just listen to my voice, in your head, controlling that hand of yours, up and down, up and down..."
<i>It's true: She's controlling your hand...
-> p1("Time out of mind passes...") ->
"Open your eyes."
<i>There they are again.  Hello {BELLA_NAME}'s beautiful boobs...
"Ten."
<i>Fuck, this is a cum countdown!  You stroke faster.
~incstat(lust)
-> p1("Nine...") ->
~incstat(lust)
-> p1("Eight...") ->
~incstat(lust)
-> p1("Seven...") ->
~incstat(lust)
You explode...
~setstat(lust, lust.min)
<i>Fuck...
->->

 

= narr_10(title, narrative)
{not narrative:
	{title}
	->->
}

 // Hypnosis_Edging_Heels_
 // Goon to My Shiny Heels
<i>Her red-nailed fingers caress the sides of her shiny black stilletto-heeled shoe, with scarlet undersoles.
"Goon to my shiny heels."
<i>She's sitting on an office chair, turned sideways from a desk.  She pulls her show part-way off so that it dangles from her toe. She sets it rocking like a pendulum, making the bright light reflecting off it into the camera flash on and off like a slow beacon.
"Keep stroking, keep gooning."
-> p1("Goon") ->
<i>Minutes pass...
-> p1("Goon") ->
"No break from edging, no break from gooning..."
-> p1("Goon") ->
"Keep ging, keep stroking, gooners gonna goon.."
-> p1("Goon") ->
<i>Ten minutes later...
"Now.  I want you to replay this video for me.  Do it now, gooner.  You know you have to..."
<i>She smiles, waiting for you to restart the video from the beginning again...

->->

 

= narr_11(title, narrative)
{not narrative:
	{title}
	->->
}

//Leave your GF
// TODO media_11_video_Ass_Chastity_Humiliation_Joi_Addiction_ description to be written
->->

 

= narr_12(title, narrative)
{not narrative:
	{title}
	->->
}

// TODO media_12_video_ATM_Joi_Edging_Addiction_Brat_ description to be written
->->

 

= narr_13(title, narrative)
{not narrative:
	{title}
	->->
}

// TODO media_13_video_atm_ description to be written
->->

 

= narr_14(title, narrative)
{not narrative:
	{title}
	->->
}

// TODO media_14_video_Ass_Breasts_Brat_ description to be written
->->

 

= narr_15(title, narrative)
{not narrative:
	{title}
	->->
}

// TODO media_15_video_Legs_Praise_ description to be written
->->

 

= narr_16(title, narrative)
{not narrative:
	{title}
	->->
}

// TODO media_16_video_Ass_Nude_Hypnosis_ATM_Addiction_Worship_ description to be written
->->

 

= narr_17(title, narrative)
{not narrative:
	{title}
	->->
}

// TODO media_17_video_Hypnosis_Edging_Addiction_ description to be written
->->

 

= narr_18(title, narrative)
{not narrative:
	{title}
	->->
}

// TODO media_18_video_Hypnosis_Humiliation_Brat_ description to be written
->->

 

= narr_19(title, narrative)
{not narrative:
	{title}
	->->
}

// TODO media_19_video_Ass_Nude_Feet_Breasts_Joi_ description to be written
->->

 

= narr_20(title, narrative)
{not narrative:
	{title}
	->->
}

// TODO media_20_video_Hypnosis_Feet_Praise_Heels_ description to be written
->->

 

= narr_21(title, narrative)
{not narrative:
	{title}
	->->
}


<i>She's wearing tight jeans and a black tee shirt.  She's sitting crossed legged at the foot of a stairwell, wearing trainers.
"It's time for you to admit it."
"You're just a jerk-off addict." 
<i>She smiles, and lets that sink in.
-> p1("Keep watching") ->
"You've been buying my videos, and you jerk... and jerk..." <i>(She mimes it)</i> ..and jerk, but you can't stop."

"Tell you what:"  <i>She stands up, turns around, showing you her ass, her curves, then come close to the camera.</i>

"Let's put an end to that today.  You'll always been a fuckin' loser, but at least you can try."

"So take out your dick, and start stroking."
-> p1("Keep watching") ->
<i>She gives you time to get to the edge...
"Now cum for me.  Jerk your stupid, pathetic dumb brains out."
"Good."
"Now..."
<i>She holds out a chastiity cage.
"Put it on."
-> p1("Keep watching") ->
"That's right.  That was your last time.  From now on, you're gonna just have to suffer."
<i>...Video ends.
 ->ffa(minute, 21) ->
->->

 

= narr_22(title, narrative)
{not narrative:
	{title}
	->->
}

// TODO media_22_video_Hypnosis_ATM_Lingerie_Heels_Brat_ description to be written
->->

 

= narr_2(title, narrative)
{not narrative:
	{title}
	->->
}

->->

 

= narr_3(title, narrative)
{not narrative:
	{title}
	->->
}

// TODO media_3_photo_Legs_Chastity_Lingerie_Addiction_Heels_ description to be written
->->

 

= narr_4(title, narrative)
{not narrative:
	{title}
	->->
}

// TODO media_4_photo_Ass_Nude_Humiliation_Joi_Addiction_ description to be written
->->

 

= narr_5(title, narrative)
{not narrative:
	{title}
	->->
}

// TODO media_5_photo_Feet_Breasts_Joi_CEI_ description to be written
->->

 

= narr_6(title, narrative)
{not narrative:
	{title}
	->->
}

// TODO media_6_photo_ATM_Legs_Heels_ description to be written
->->


->->
