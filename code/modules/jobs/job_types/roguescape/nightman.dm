/datum/job/roguetown/nightman
	title = "Nightman"
	flag = JESTER
	department_flag = PEASANTS
	faction = "Mansion"
	total_positions = 1
	spawn_positions = 1

	allowed_sexes = list("male")
	allowed_races = list("Humen",
	"Dark Elf"
	)

	tutorial = "A low life, somehow already well established in Wyrld."
	allowed_patrons = list("Psydon", "Saradomin", "Guthix", "Zamorak")
	allowed_ages = list(AGE_ADULT, AGE_MIDDLEAGED, AGE_OLD)
	outfit = /datum/outfit/job/roguetown/nightman
	display_order = JDO_NIGHTMAN

/datum/outfit/job/roguetown/nightman/pre_equip(mob/living/carbon/human/H)
	..()
	shoes = /obj/item/clothing/shoes/roguetown/shortboots
	pants = /obj/item/clothing/under/roguetown/trou/leather
	armor = /obj/item/clothing/suit/roguetown/armor/leather/vest/sailor/nightman
	beltr = /obj/item/rogueweapon/lordscepter
	belt = /obj/item/storage/belt/rogue/leather
	if(prob(50))
		beltl = /obj/item/flashlight/flare/torch/lantern
	l_hand = /obj/item/candle/yellow/lit
	backpack_contents = list(/obj/item/roguekey/vampire = 1)
	ADD_TRAIT(H, RTRAIT_HEAVYARMOR, TRAIT_GENERIC)
	ADD_TRAIT(H, RTRAIT_NOBLE, TRAIT_GENERIC)
	if(H.mind)
		H.mind.adjust_skillrank(/datum/skill/combat/wrestling, 4, TRUE)
		H.mind.adjust_skillrank(/datum/skill/combat/unarmed, 4, TRUE)
		H.mind.adjust_skillrank(/datum/skill/combat/crossbows, 4, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/reading, 2, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/sneaking, 4, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/stealing, 5, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/climbing, 1, TRUE)
		H.change_stat("strength", 1)
		H.change_stat("intelligence", -1)

		var/datum/atom_hud/K = GLOB.huds[DATA_HUD_KINGDOM]
		K.add_hud_to(H)
		H.civilization = "Night Manor"
		H.kingdom_perms = list(1,1,1,1)
		king_hud_set_status()
		add_basic_kingdom_verbs()
		make_commander()
		make_title_changer()
	if(H.dna?.species)
		if(H.dna.species.id == "human")
			H.dna.species.soundpack_m = new /datum/voicepack/male/zeth()
		if(H.dna.species.id == "elf" || "dwarf" || "delf")
			armor = /obj/item/clothing/suit/roguetown/armor/leather/vest/sailor
