/mob/living/carbon/human/species/sgoblin
	race = /datum/species/sgoblin
	bodyparts = list(/obj/item/bodypart/chest/goblin, /obj/item/bodypart/head/goblin, /obj/item/bodypart/l_arm/goblin,
					 /obj/item/bodypart/r_arm/goblin, /obj/item/bodypart/r_leg/goblin, /obj/item/bodypart/l_leg/goblin)
	rot_type = /datum/component/rot/corpse/goblin
	ambushable = FALSE
	base_intents = list(INTENT_HELP, INTENT_DISARM, INTENT_GRAB, /datum/intent/unarmed/claw)
	possible_rmb_intents = list()

/datum/species/sgoblin
	name = "Goblin"
	id = "dwarf"
	desc = "<b>Goblin</b><br>\
	Disgusting creachers."
	default_color = "FFFFFF"
	species_traits = list(EYECOLOR,HAIR,FACEHAIR,LIPS,STUBBLE,OLDGREY,GOBLIN)
	inherent_traits = list(TRAIT_GENERIC, TRAIT_TOXIMMUNE)
	default_features = list("mcolor" = "FFF", "ears" = "Goblin", "wings" = "None")
	mutant_bodyparts = list("ears")
	use_skintones = 1
	possible_ages = list(AGE_YOUNG, AGE_ADULT, AGE_MIDDLEAGED, AGE_OLD)
	disliked_food = NONE
	liked_food = NONE
	changesource_flags = MIRROR_BADMIN | WABBAJACK | MIRROR_MAGIC | MIRROR_PRIDE | ERT_SPAWN | RACE_SWAP | SLIME_EXTRACT
	limbs_icon_m = 'icons/roguetown/mob/bodies/m/mg.dmi'
	limbs_icon_f = 'icons/roguetown/mob/bodies/m/mg.dmi'
	dam_icon = 'icons/roguetown/mob/bodies/dam/dam_male.dmi'
	dam_icon_f = 'icons/roguetown/mob/bodies/dam/dam_female.dmi'
	use_f = TRUE
	custom_clothes = TRUE
	soundpack_m = /datum/voicepack/goblin
	soundpack_f = /datum/voicepack/goblin
	no_equip = list(SLOT_SHIRT, SLOT_WEAR_MASK, SLOT_GLOVES, SLOT_SHOES, SLOT_PANTS, SLOT_S_STORE)
	offset_features = list(OFFSET_ID = list(0,0), OFFSET_GLOVES = list(0,0), OFFSET_WRISTS = list(0,0),\
	OFFSET_CLOAK = list(0,-5), OFFSET_FACEMASK = list(0,-5), OFFSET_HEAD = list(0,-5), \
	OFFSET_FACE = list(0,-5), OFFSET_BELT = list(0,-5), OFFSET_BACK = list(0,-5), \
	OFFSET_NECK = list(0,-5), OFFSET_MOUTH = list(0,-5), OFFSET_PANTS = list(0,-5), \
	OFFSET_SHIRT = list(0,-5), OFFSET_ARMOR = list(0,-1), OFFSET_HANDS = list(0,-4), \
	OFFSET_ID_F = list(0,-5), OFFSET_GLOVES_F = list(0,-4), OFFSET_WRISTS_F = list(0,-4), OFFSET_HANDS_F = list(0,-4), \
	OFFSET_CLOAK_F = list(0,0), OFFSET_FACEMASK_F = list(0,-5), OFFSET_HEAD_F = list(0,-5), \
	OFFSET_FACE_F = list(0,-5), OFFSET_BELT_F = list(0,-5), OFFSET_BACK_F = list(0,-5), \
	OFFSET_NECK_F = list(0,-5), OFFSET_MOUTH_F = list(0,-5), OFFSET_PANTS_F = list(0,-5), \
	OFFSET_SHIRT_F = list(0,-5), OFFSET_ARMOR_F = list(0,-1), OFFSET_UNDIES = list(0,0), OFFSET_UNDIES_F = list(0,0))
	specstats = list("strength" = -1, "perception" = -1, "intelligence" = -1, "constitution" = -1, "endurance" = -1, "speed" = -1, "fortune" = -1)
	specstats_f = list("strength" = -1, "perception" = -1, "intelligence" = -1, "constitution" = -1, "endurance" = -1, "speed" = -1, "fortune" = -1)
	enflamed_icon = "widefire"

/datum/species/sgoblin/on_species_gain(mob/living/carbon/C, datum/species/old_species)
	..()
	RegisterSignal(C, COMSIG_MOB_SAY, .proc/handle_speech)
	C.grant_language(/datum/language/hellspeak)

/datum/species/sgoblin/after_creation(mob/living/carbon/C)
	..()
	C.grant_language(/datum/language/hellspeak)
	to_chat(C, "<span class='info'>I can speak Infernal with ,h before my speech.</span>")

/datum/species/sgoblin/on_species_loss(mob/living/carbon/C)
	. = ..()
	UnregisterSignal(C, COMSIG_MOB_SAY)
	C.remove_language(/datum/language/hellspeak)

/datum/species/sgoblin/get_skin_list()
	return sortList(list(
	"skin1" = "698F3A",
	"skin2" = "5B6950",
	"skin3" = "CA9920",
	"skin4" = "6E8A74"
	))

/datum/species/sgoblin/get_hairc_list()
	return sortList(list(
	"black - cave" = "201616",
	"black - rogue" = "2b201b",
	"black - midnight" = "1d1b2b",

	"red - blood" = "822b2b",

	"green - forest" = "29674E",
	"green - bog" = "0B1C1A",

	"blue - river" = "3B5782",
	"blue - mystic" = "272646"
	))

/datum/species/sgoblin/random_name(gender,unique,lastname)
	var/randname
	if(unique)
		if(gender == MALE)
			for(var/i in 1 to 10)
				randname = pick( world.file2list("strings/rt/names/other/goblinm.txt") )
				if(!findname(randname))
					break
		if(gender == FEMALE)
			for(var/i in 1 to 10)
				randname = pick( world.file2list("strings/rt/names/other/goblinf.txt") )
				if(!findname(randname))
					break
	else
		if(gender == MALE)
			randname = pick( world.file2list("strings/rt/names/other/goblinm.txt") )
		if(gender == FEMALE)
			randname = pick( world.file2list("strings/rt/names/other/goblinf.txt") )
	return randname

/datum/species/sgoblin/random_surname()
	return ""
