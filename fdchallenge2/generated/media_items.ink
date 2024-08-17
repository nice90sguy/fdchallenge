LIST search_tags = photo, video, Addiction, Ass,  ATM, Brat, Breasts, CEI, Chastity, Edging, Feet, Goon, Heels, Homewrecker, Humiliation, Hypnosis, Intox, Joi, Kneel, Legs, Lingerie, Lips, Nude, Praise, Worship

LIST media = media_1_=30, media_2_=30, media_3_=50, media_4_=40, media_5_=45, media_6_=60, media_7_=120, media_8_=120, media_9_=120, media_10_=200, media_11_=120, media_12_=120, media_13_=120, media_14_=120, media_15_=120, media_16_=120, media_17_=120, media_18_=120, media_19_=120, media_20_=120, media_21_=120, media_22_=120 

VAR available_items = (media_1_, media_2_, media_3_, media_4_, media_5_, media_6_, media_7_)

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

LIST lookup_media_arg_t = lum_desc, lum_narr
=== lookup_media(ref id, ref arg)
~ temp p_media = media_from_id(id)
~ arg += p_media

{p_media:

	-media_1_: 
        ~ arg += (video, Ass, Hypnosis, Legs, Edging, Lingerie, Addiction, Kneel,Worship, Praise, Heels)
        {arg ? lum_desc:Goddess Mind-Fuck}
        {arg ? lum_narr:
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
}
	-media_2_:
        ~ arg += (video, Hypnosis, Edging, Addiction)
        {arg ? lum_desc:Fall deeper under my spell}
        {arg ? lum_narr:
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
}
	-media_3_: 
        ~ arg += (video, Hypnosis, Breasts, Joi, Kneel)
        {arg ? lum_desc:Your new purpose}
        {arg ? lum_narr:
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
-> p1e("Your eyes fall closed.") ->
<i>You really ought to be watching, you're meant to be looking for content tags here, and besides... the view you're missing...
<i>With an effort, you manage to open your eyes, but...
"Eyes closed.  Just listen to my voice, in your head, controlling that hand of yours, up and down, up and down..."
<i>It's true: She's controlling your hand...
-> p1e("Time out of mind passes...") ->
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
}
	-media_4_: 
        ~ arg += (video, Hypnosis, Edging, Heels)
        {arg ? lum_desc:Goon to My Shiny Heels}
        {arg ? lum_narr:	
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
"Keep going, keep stroking, gooners gonna goon.."
-> p1("Goon") ->
<i>Ten minutes later...
"Now.  I want you to replay this video for me.  Do it now, gooner.  You know you have to..."
<i>She smiles, waiting for you to restart the video from the beginning again...

}
	-media_5_: 
        ~ arg += (video, Ass, Worship, Humiliation, Homewrecker)
        {arg ? lum_desc:Lucky Chair}
        {arg ? lum_narr:
<i>We're in an "office", on the "boss's" side of a desk.  {BELLA_NAME} walks in, carrying a transparant plastic chair.  She's in the typical porno office attire, white shirt tucked into short black skirt. Bare legs.
"Hi!  I hope you don't mind that I brought my own chair, I just have a weird thing about it in job interviews, it's a sort of superstition."
<i>She pauses an looks into camera with a keen look, as though you're asking her a question.
-> cont ->
<i>She laughs.
"Yes, it has actually brought me luck! In fact it's brought me luck in a hundred percent of my job interviews so far!"
-> p1e("Another pause.") ->
"Well, that's nice of you to say, but I don't want to test that, in case it really is the chair, and not me being good at interviews.  I guess it could just be because it gives me confidence."


-> p1e("Another pause while she's listening to you.") ->
"Okay, why do I think I'm suitible for the job as your assistant?"

<i>She crosses her legs. Did you see a flash of red panties?
-> cont ->

"Well, I think my best asset is... <i>She laughs</i>, well <i>one</i> of my best assets is that I'm very thorough when it comes to research.
"For example, I've researched everything about this job really carefully.  I've even researched
-> p1e("You.") ->

"Oh yes, I know all about you.  For example, I know you're married, and your wife's name."
-> p1e("She sees that what she said has caused a reaction") ->
<><i> in you, and continues,
"I even know her birthday.  So I'd always remember to send her flowers, even if you forgot it!"

"But I know more than that."
-> cont ->

->p1e("</i>\"I also know you like to look up women's skirts\"") ->
<>, <i> she continues.
"Oh yes, that's pretty well-known in the building."
<i> She stands up, and steps out of her skirt.  She sits down again.

"Come here," <i> she says. We move around the desk until we're on the same side as her.

"Now lie down, with your head under my "lucky chair"".

-> cont ->


<i>A view from the floor, below herchair.  Her ass-cheeks are pressed down onto it, making two pale pink ovals.  As she moves slightly, the ovals change shape.
"I know you love being below me," she croons. 
"Worshipping my ass, worshipping my beautiful, perfect-
->p1e("She raises herself up, then presses her ass back down on the seat") ->
<>- 
"ASS."
-> cont ->
"You're just a pathetic loser."

-> cont ->

"Losers like you shouldn't be married.  They shouldn't have to spend their time and money on their ugly wives."

"Miserably fucking their wives, while all the time, all they can think about is being under some hot, young ass."

-> cont ->

"So, the sooner you give me the job, the soon you can start divorce proceedings, and start doing what you're meant to be doing."

-> cont ->
->p1e("Lying on the floor,") ->
->p1e("while your p.a. handles everything:") ->
->p1e("Your appointments,") ->
->p1e("and every other aspect of your loser life.") ->

<i>We hold on this view of her for a few minutes, until we dissolve to her on the other side of the desk again.

"So, have I got the job?"

<i>She laughs.

"See I told this chair was lucky.

<i>Fade out.
-> ffa(minute, 30) ->
-> cont ->
//Leave your GF
// TODO media_11_
}
	-media_6_: 
        ~ arg += (video, Chastity, Humiliation, Joi, Addiction)
        {arg ? lum_desc:You don't need Sex, You have Me}
        {arg ? lum_narr:
<i>She's wearing tight jeans and a black tee shirt.  She's sitting crossed legged at the foot of a stairwell, wearing trainers.
"It's time for you to admit it."
"You're just a jerk-off addict." 
<i>She smiles, and lets that sink in.
-> p1("Keep watching") ->
"You've been buying my videos, and you jerk... and jerk..." <i>(She mimes it)</i> ..and jerk, but you can't stop."

"Tell you what:"  <i>She stands up, turns around, showing you her ass, her curves, then comes close to the camera.</i>

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
}
    -media_7_:
         ~ arg += (video, Brat, Breasts, ATM)
        {arg ? lum_desc:Pay off My Student Debt}
        {arg ? lum_narr:
            <i>A bratty student flashes her tits at you and forces you to give her your credit card
            <i>(Yeah I ran out of Mojo writing this one... nng)
        }
    - else:
    // Make all other items return a photo for now
        ~ arg += photo
        {arg ? lum_desc:{p_media} has no description yet}
        {arg ? lum_narr:{p_media} has no narrative yet}
    
}
->->