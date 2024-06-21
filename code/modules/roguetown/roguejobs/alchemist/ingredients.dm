//mortar and pestle
/obj/item/alch
	name = "dust"
	desc = "A generic item, this shouldn't exist."
	icon = 'icons/roguetown/items/alch.dmi'//Need icon, alch.dmi doesn't exist
	icon_state = ""
	w_class = WEIGHT_CLASS_NORMAL
	dust_result = null

//pestle recipes
/obj/item/rogueore/gold
	dust_result = /obj/item/alch/golddust

/obj/item/ingot/gold
	dust_result = /obj/item/alch/golddust

/obj/item/rogueore/iron
	dust_result = /obj/item/alch/irondust

/obj/item/ingot/iron
	dust_result = /obj/item/alch/irondust

//dust mix
/datum/crafting_recipe/roguetown/alch/feaudust
	name = "feau dust"
	result = /obj/item/alch/feaudust
	reqs = list(/obj/item/alch/irondust = 2,
				/obj/item/alch/golddust = 1)
	structurecraft = /obj/structure/table/wood
	verbage = "mixes"
	craftsound = 'sound/foley/scribble.ogg'
	skillcraft = null

//potion ingredients
/obj/item/natural/dirtclod
	possible_potion = "antidote"

/obj/item/ash
	possible_potion = "antidote"

/obj/item/alch/golddust
	name "gold dust"
	possible_potion = "strong"

/obj/item/alch/irondust
	name = "iron dust"
	possible_potion = "long"

/obj/item/alch/feaudust
	name = "feau dust"
	possible_potion = "robust"