LIST location = location_home, location_gym, location_park, location_bar, location_cafe, location_hotel_bar, (location_hotel_room), location_airplane, location_laptop


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
    - location_home: 🏠 Your apartment
    - location_gym: 🏋🏻‍♂️ Local gym
    - location_park: 🏞️Local park
    - location_bar: 🍻Prince of Wales Pub
    - location_cafe: ☕Better Caffe Latte Than Never
    - location_laptop:💻 Your Laptop Screen
    - else: (Unknown)
}<>

