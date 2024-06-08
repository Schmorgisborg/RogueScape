/mob/living/carbon/human/species/elf/dark
	race = /datum/species/elf/dark

/datum/species/elf/dark
	name = "Dark Elf"
	id = "elf"
	desc = "<b><font color='olive'>I am a Dark Elf</font></b><br>\
	<font color='teal'>Dark elves are not looked fondly on by any other race, even other elves. The women \
	tend to be stronger than the average men. Before the war, public opinion was turning \
	to accept them, but many dark elves turned to Zizo. Very few have been seen in this \
	new land, and people tend to see their presense as a bad omen.</font><br>\
	<font color='#008888'>Dark elves have a boon for Intelligence, endurance, and speed.<br>\
	They are ailed by their fortune and constitution.</font>"
	species_traits = list(EYECOLOR,HAIR,FACEHAIR,LIPS,OLDGREY)
	inherent_traits = list(TRAIT_NOMOBSWAP)
	default_features = list("mcolor" = "FFF", "ears" = "ElfW", "wings" = "None")
	use_skintones = 1
	skinned_type = /obj/item/stack/sheet/animalhide/human
	disliked_food = NONE
	liked_food = NONE
	possible_ages = list(AGE_ADULT, AGE_MIDDLEAGED, AGE_OLD)
	changesource_flags = MIRROR_BADMIN | WABBAJACK | MIRROR_MAGIC | MIRROR_PRIDE | ERT_SPAWN | RACE_SWAP | SLIME_EXTRACT
	limbs_icon_m = 'icons/roguetown/mob/bodies/m/mem.dmi'
	limbs_icon_f = 'icons/roguetown/mob/bodies/f/fm.dmi'
	dam_icon = 'icons/roguetown/mob/bodies/dam/dam_male.dmi'
	dam_icon_f = 'icons/roguetown/mob/bodies/dam/dam_female.dmi'
	hairyness = "t3"
	mutant_bodyparts = list("ears")
	use_f = TRUE
	soundpack_m = /datum/voicepack/male/elf
	soundpack_f = /datum/voicepack/female/elf
	offset_features = list(	OFFSET_ID = list(0,0), OFFSET_GLOVES = list(0,1), OFFSET_WRISTS = list(0,1), OFFSET_HANDS = list(0,0), \
	OFFSET_CLOAK = list(0,1), OFFSET_FACEMASK = list(0,0), OFFSET_HEAD = list(0,0), \
	OFFSET_FACE = list(0,0), OFFSET_BELT_F = list(0,0), OFFSET_BACK = list(0,0), \
	OFFSET_NECK = list(0,0), OFFSET_MOUTH = list(0,0), OFFSET_PANTS = list(0,1), \
	OFFSET_SHIRT = list(0,1), OFFSET_ARMOR = list(0,1), OFFSET_UNDIES = list(0,1),\
	OFFSET_ID_F = list(0,-1), OFFSET_GLOVES_F = list(0,0), OFFSET_WRISTS_F = list(0,0), OFFSET_HANDS_F = list(0,0), \
	OFFSET_CLOAK_F = list(0,0), OFFSET_FACEMASK_F = list(0,-1), OFFSET_HEAD_F = list(0,-1), \
	OFFSET_FACE_F = list(0,-1), OFFSET_BELT_F = list(0,-1), OFFSET_BACK_F = list(0,-1), \
	OFFSET_NECK_F = list(0,-1), OFFSET_MOUTH_F = list(0,-1), OFFSET_PANTS_F = list(0,0), \
	OFFSET_SHIRT_F = list(0,0), OFFSET_ARMOR_F = list(0,0), OFFSET_UNDIES_F = list(0,0))
	specstats = list("strength" = -1, "perception" = 0, "intelligence" = 2, "constitution" = -1, "endurance" = 2, "speed" = 2, "fortune" = -1)
	specstats_f = list("strength" = 0, "perception" = -1, "intelligence" = 1, "constitution" = -1, "endurance" = 1, "speed" = 1, "fortune" = -1)
	enflamed_icon = "widefire"
	possible_faiths = list(FAITH_SPIDER)
	patreon_req = 0

/datum/species/elf/dark/get_span_language(datum/language/message_language)
	if(!message_language)
		return
	if(message_language.type == /datum/language/elvish)
		return list(SPAN_DELF)
	return message_language.spans
/*
/datum/species/elf/dark/on_species_gain(mob/living/carbon/C, datum/species/old_species)
	. = ..()
	C.remove_language(/datum/language/common)

/datum/species/elf/dark/on_species_loss(mob/living/carbon/C)
	. = ..()
	C.grant_language(/datum/language/common)
*/
/datum/species/elf/dark/check_roundstart_eligible()
	return TRUE

/datum/species/elf/dark/get_skin_list()
	return sortList(list(
	"skin1" = "9796a9",
	"skin2" = "897489",
	"skin3" = "938f9c",
	"skin4" = "737373",
	"skin5" = "6a616d",
	"skin6" = "5f5f70"
	))

/datum/species/elf/dark/get_hairc_list()
	return sortList(list(
	"black - oil" = "181a1d",
	"black - cave" = "201616",
	"black - rogue" = "2b201b",
	"black - midnight" = "1d1b2b",

	"white - cavedew" = "dee9ed",
	"white - spiderweb" = "f4f4f4"

	))

/datum/species/elf/dark/random_name(gender,unique,lastname)
	var/randname
	if(unique)
		if(gender == MALE)
			for(var/i in 1 to 10)
				randname = pick( world.file2list("strings/rt/names/elf/elfdm.txt") )
				if(!findname(randname))
					break
		if(gender == FEMALE)
			for(var/i in 1 to 10)
				randname = pick( world.file2list("strings/rt/names/elf/elfdf.txt") )
				if(!findname(randname))
					break
	else
		if(gender == MALE)
			randname = pick( world.file2list("strings/rt/names/elf/elfdm.txt") )
		if(gender == FEMALE)
			randname = pick( world.file2list("strings/rt/names/elf/elfdf.txt") )
	return randname

/datum/species/elf/dark/random_surname()
	return " [pick(world.file2list("strings/rt/names/elf/elfsnf.txt"))]"

/datum/species/elf/dark/get_accent_list()
	return strings("french_replacement.json", "french")
