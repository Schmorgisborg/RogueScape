//mortar and pestle
/obj/item/alch
	name = "dust"
	desc = ""
	icon = 'icons/roguetown/misc/alchemy.dmi'
	icon_state = "irondust"
	w_class = WEIGHT_CLASS_TINY
	dust_result = null


//pestle recipes
/obj/item/seeds
	dust_result = /obj/item/alch/seeddust
	..()

/obj/item/rogueore/gold
	dust_result = /obj/item/alch/golddust
	possible_potion = "manapot"
	..()

/obj/item/ingot/gold
	dust_result = /obj/item/alch/golddust
	possible_potion = "intelligencepot"
	..()

/obj/item/rogueore/iron
	dust_result = /obj/item/alch/irondust
	possible_potion = "healthpot"
	..()

/obj/item/ingot/iron
	dust_result = /obj/item/alch/irondust
	possible_potion = "strengthpot"
	..()

//potion ingredients
/obj/item/alch/bone
	name = "bones"
	icon_state = "bone"
	force = 7
	throwforce = 5
	w_class = WEIGHT_CLASS_SMALL
	dust_result = /obj/item/alch/bonemeal
	possible_potion = "strengthpot"

/obj/item/alch/sinew
	name = "sinew"
	icon_state = "sinew"
	possible_potion = "strengthpot"

/obj/item/natural/dirtclod
	possible_potion = "antidote"
	..()

/obj/item/ash
	possible_potion = "antidote"
	..()


//ingredients generated from mortar & pestle
/obj/item/alch/golddust
	name = "gold dust"
	icon_state = "golddust"
	possible_potion = "strong"

/obj/item/alch/irondust
	name = "iron dust"
	icon_state = "irondust"
	possible_potion = "long"

/obj/item/alch/feaudust
	name = "feau dust"
	icon_state = "feaudust"
	possible_potion = "robust"

/obj/item/alch/bonemeal
	name = "bone meal"
	icon_state = "bonemeal"
	possible_potion = "manapot"

/obj/item/alch/viscera
	name = "viscera"
	icon_state = "viscera"
	possible_potion = "healthpot"

/obj/item/alch/seeddust
	name = "seed dust"
	icon_state = "seeddust"
	possible_potion = "manapot"

//dust mix
/datum/crafting_recipe/roguetown/alch/feaudust
	name = "feau dust"
	result = list(/obj/item/alch/feaudust,
				/obj/item/alch/feaudust)
	reqs = list(/obj/item/alch/irondust = 2,
				/obj/item/alch/golddust = 1)
	structurecraft = /obj/structure/table/wood
	verbage = "mixes"
	craftsound = 'sound/foley/scribble.ogg'
	skillcraft = null
