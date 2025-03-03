LIST location = location_apartment, location_gym, location_park, location_bar, location_cafe, location_hotel_bar, (location_hotel_room), location_airplane, location_laptop, location_hovel, location_angie_apartment

VAR location_home = location_apartment
== ldtp()

{location != ():Location: <b>{location_desc()}}</b><br><>
-> dtp ->->

== SCENE(loc, ->scene)
{_DEBUG:<i><>}
{_DEBUG:{scene}}
~ location = loc
{location != ():Location: <b>{location_desc()}}</b><br><>
-> dtp ->scene -> cont ->->

== function location_desc

{location:
    - location_hotel_room: 🛏️ Hotel Bedroom, Manhattan, NY
    - location_hotel_bar: 🍸Hotel Bar, Manhattan, NY   
    - location_airplane: ✈️Airplane, Somewhere over the Atlantic
    - location_apartment: 🏠 Your apartment
    - location_hovel: 🐀 Guest Apartment, Skankly Towers
    - location_gym: 🏋🏻‍♂️ Local gym
    - location_park: 🏞️Local park
    - location_bar: 🍻Prince of Wales Pub
    - location_cafe: ☕Better Caffe Latte Than Never
    - location_laptop:💻 Your Laptop Screen
    - location_angie_apartment: 🏢 Angie's Apartment
    - else: (Unknown)
}<>

== function location_name(loc)

{loc:
    - location_hotel_room: in the bedroom
    - location_hotel_bar: in the bar 
    - location_airplane: on the plane
    - location_apartment: at your place
    - location_hovel: at your miserable bedsit 
    - location_gym: at the gym
    - location_park: in the park
    - location_bar: at the pub
    - location_cafe: in the café
    - location_laptop: on your laptop screen
    - location_angie_apartment: at Angie's place
    - else: (Unknown)
}<>

