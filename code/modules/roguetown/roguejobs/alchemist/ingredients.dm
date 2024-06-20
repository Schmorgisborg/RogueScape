//mortar and pestle
/obj/item/alch
	name = "dust"
	desc = "A generic item, this shouldn't exist."
	icon = 'icons/roguetown/items/alch.dmi'//Need icon, alch.dmi doesn't exist
	icon_state = ""
	w_class = WEIGHT_CLASS_NORMAL
	dust_result = null

/obj/item/rogueore/gold
	dust_result = /obj/item/alch/golddust

/obj/item/ingot/gold
	dust_result = /obj/item/alch/golddust

/obj/item/rogueore/iron
	dust_result = /obj/item/alch/irondust

/obj/item/ingot/iron
	dust_result = /obj/item/alch/irondust

//potions
/obj/item/natural/dirtclod
	possible_potion = "antidote"

/obj/item/ash
	possible_potion = "antidote"

/obj/item/alch/golddust
	possible_potion = ""

/obj/item/alch/irondust
	possible_potion = ""
