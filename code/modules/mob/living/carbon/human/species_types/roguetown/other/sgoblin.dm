/mob/living/carbon/human/species/human/sgoblin
	race = /datum/species/human/sgoblin
	icon = 'icons/roguetown/mob/monster/goblins.dmi'
	icon_state = "blank"
	gender = MALE
	bodyparts = list(/obj/item/bodypart/chest/goblin, /obj/item/bodypart/head/goblin, /obj/item/bodypart/l_arm/goblin,
					 /obj/item/bodypart/r_arm/goblin, /obj/item/bodypart/r_leg/goblin, /obj/item/bodypart/l_leg/goblin)
	rot_type = /datum/component/rot/corpse/goblin
	var/gob_outfit = /datum/outfit/job/roguetown/npc/goblin
	ambushable = FALSE
	base_intents = list(INTENT_HELP, INTENT_DISARM, INTENT_GRAB, /datum/intent/unarmed/claw)
	possible_rmb_intents = list()

/datum/species/human/sgoblin
	name = "Goblin"
	id = "sgoblin"
	desc = "<b>Goblin</b><br>\
	Disgusting creachers."
	default_color = "FFFFFF"
	species_traits = list(EYECOLOR,HAIR,FACEHAIR,LIPS,STUBBLE,OLDGREY)
	inherent_traits = list(TRAIT_NOMOBSWAP)
	default_features = list("mcolor" = "FFF", "ears" = "Goblin", "wings" = "None")
	mutant_bodyparts = list("ears")
	use_skintones = 1
	possible_ages = list(AGE_YOUNG, AGE_ADULT, AGE_MIDDLEAGED)
	disliked_food = NONE
	liked_food = NONE
	changesource_flags = MIRROR_BADMIN | WABBAJACK | MIRROR_MAGIC | MIRROR_PRIDE | ERT_SPAWN | RACE_SWAP | SLIME_EXTRACT
	limbs_icon_m = 'icons/roguetown/mob/bodies/m/mg.dmi'
	limbs_icon_f = 'icons/roguetown/mob/bodies/m/mg.dmi'
	dam_icon = 'icons/roguetown/mob/bodies/dam/dam_male.dmi'
	dam_icon_f = 'icons/roguetown/mob/bodies/dam/dam_female.dmi'
	soundpack_m = /datum/voicepack/goblin
	soundpack_f = /datum/voicepack/goblin
	offset_features = list(OFFSET_ID = list(0,0), OFFSET_GLOVES = list(0,0), OFFSET_WRISTS = list(0,0),\
	OFFSET_CLOAK = list(0,0), OFFSET_FACEMASK = list(0,-4), OFFSET_HEAD = list(0,-4), \
	OFFSET_FACE = list(0,-4), OFFSET_BELT = list(0,-5), OFFSET_BACK = list(0,-4), \
	OFFSET_NECK = list(0,-4), OFFSET_MOUTH = list(0,-4), OFFSET_PANTS = list(0,0), \
	OFFSET_SHIRT = list(0,0), OFFSET_ARMOR = list(0,0), OFFSET_HANDS = list(0,-3), \
	OFFSET_ID_F = list(0,-4), OFFSET_GLOVES_F = list(0,-4), OFFSET_WRISTS_F = list(0,-4), OFFSET_HANDS_F = list(0,-4), \
	OFFSET_CLOAK_F = list(0,0), OFFSET_FACEMASK_F = list(0,-5), OFFSET_HEAD_F = list(0,-5), \
	OFFSET_FACE_F = list(0,-5), OFFSET_BELT_F = list(0,-5), OFFSET_BACK_F = list(0,-5), \
	OFFSET_NECK_F = list(0,-5), OFFSET_MOUTH_F = list(0,-5), OFFSET_PANTS_F = list(0,0), \
	OFFSET_SHIRT_F = list(0,0), OFFSET_ARMOR_F = list(0,0), OFFSET_UNDIES = list(0,0), OFFSET_UNDIES_F = list(0,0))
	specstats = list("strength" = -1, "perception" = -1, "intelligence" = -1, "constitution" = -1, "endurance" = -1, "speed" = -1, "fortune" = -1)
	specstats_f = list("strength" = -1, "perception" = -1, "intelligence" = -1, "constitution" = -1, "endurance" = -1, "speed" = -1, "fortune" = -1)
	enflamed_icon = "widefire"

/datum/species/human/sgoblin/check_roundstart_eligible()
	return TRUE

/datum/species/human/sgoblin/get_skin_list()
	return sortList(list(
	"skin1" = "#698F3A",
	"skin2" = "#394433",
	"skin3" = "#CA9920",
	"skin4" = "6E8A74"
	))


/datum/species/human/sgoblin/get_hairc_list()
	return sortList(list(
	"black - oil" = "181a1d",
	"black - cave" = "201616",
	"black - rogue" = "2b201b",
	"black - midnight" = "1d1b2b",

	"brown - mud" = "362e25",
	"brown - oats" = "584a3b",
	"brown - grain" = "58433b",
	"brown - soil" = "48322a",

	"red - berry" = "48322a",
	"red - wine" = "82534c",
	"red - sunset" = "82462b",
	"red - blood" = "822b2b",

	"blond - pale" = "9d8d6e",
	"blond - dirty" = "88754f",
	"blond - drywheat" = "8f8766",
	"blond - strawberry" = "977033"

	))

/datum/species/human/sgoblin/random_name(gender,unique,lastname)
	var/randname
	if(unique)
		if(gender == MALE)
			for(var/i in 1 to 10)
				randname = pick( world.file2list("strings/rt/names/other/tiefm.txt") )
				if(!findname(randname))
					break
		if(gender == FEMALE)
			for(var/i in 1 to 10)
				randname = pick( world.file2list("strings/rt/names/other/tieff.txt") )
				if(!findname(randname))
					break
	else
		if(gender == MALE)
			randname = pick( world.file2list("strings/rt/names/other/tiefm.txt") )
		if(gender == FEMALE)
			randname = pick( world.file2list("strings/rt/names/other/tieff.txt") )
	return randname

/datum/species/human/sgoblin/random_surname()
	return ""
