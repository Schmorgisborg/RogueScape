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

/obj/item/reagent_containers/food/snacks/grown/rogue/sweetleaf
	dust_result = /obj/item/alch/sweetdust
	..()

/obj/item/reagent_containers/food/snacks/grown/rogue/sweetleafdry
	dust_result = /obj/item/alch/sweetdust
	..()

/obj/item/reagent_containers/food/snacks/grown/rogue/pipeweed
	dust_result = /obj/item/alch/tobaccodust
	..()

/obj/item/reagent_containers/food/snacks/grown/rogue/pipeweeddry
	dust_result = /obj/item/alch/tobaccodust
	..()

/obj/item/rogueore/gold
	dust_result = /obj/item/alch/golddust
	..()

/obj/item/ingot/gold
	dust_result = /obj/item/alch/golddust
	..()

/obj/item/rogueore/silver
	dust_result = /obj/item/alch/silverdust
	..()

/obj/item/ingot/silver
	dust_result = /obj/item/alch/silverdust
	..()

/obj/item/rogueore/iron
	dust_result = /obj/item/alch/irondust
	..()

/obj/item/ingot/iron
	dust_result = /obj/item/alch/irondust
	..()

/obj/item/rogueore/coal
	dust_result = /obj/item/alch/coaldust
	..()

/obj/item/rune/granter/spell/fire_rune
	dust_result = firedust
	..()

/obj/item/rune/granter/spell/air_rune
	dust_result = airdust
	..()

/obj/item/rune/granter/spell/blank_rune
	dust_result = runedust
	..()

//potion ingredients, sorted by potion

/obj/item/alch/viscera
	name = "viscera"
	icon_state = "viscera"
	possible_potion = "healthpot"

/obj/item/natural/chaff/wheat
	possible_potion = "healthpot"

/obj/item/alch/bonemeal
	name = "bone meal"
	icon_state = "bonemeal"
	possible_potion = "manapot"

/obj/item/alch/seeddust
	name = "seed dust"
	icon_state = "seeddust"
	possible_potion = "manapot"

/obj/item/natural/dirtclod
	possible_potion = "antidote"
	..()

/obj/item/alch/coaldust
	name = "coal dust"
	//icon_state = "coaldust"
	possible_potion = "antidote"

/obj/item/ash
	possible_potion = "diseasecure"
	..()

/obj/item/alch/silverdust
	name = "silver dust"
	//icon_state = "silverdust"
	possible_potion = "diseasecure"

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
	drop_shrink = 0.5
	dust_result = /obj/item/alch/viscera
	possible_potion = "strengthpot"

/obj/item/alch/firedust
	name = "fire rune dust"
	//icon_state = "firedust"
	possible_potion = "strengthpot"

/obj/item/reagent_containers/powder/ozium
	possible_potion = "perceptionpot"
	..()

/obj/item/alch/tobaccodust
	name = "tobacco dust"
	//icon_state = "tobaccodust"
	possible_potion = "perceptionpot"

/obj/item/alch/airdust
	name = "air rune dust"
	//icon_state = "airdust"
	possible_potion = "intelligencepot"

/obj/item/alch/runedust
	name = "rune dust"
	//icon_state = "runedust"
	possible_potion = "intelligencepot"

obj/item/alch/sweetdust
	name = "sweet leaf dust"
	//icon_state = "sweetdust"
	possible_potion = "intelligencepot"

/obj/item/reagent_containers/powder/moondust
	..()


/obj/item/reagent_containers/powder/moondust_purest
	..()

//Modifier ingredients
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

//dust mix crafting
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
