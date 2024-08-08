/datum/job/roguetown/grabber
	title = "Grabber"
	flag = GRABBER
	department_flag = PEASANTS
	faction = "Mansion"
	total_positions = 2
	spawn_positions = 2

	allowed_races = list("Humen",
	"Humen",
	"Elf",
	"Half-Elf",
	"Dwarf",
	"Dwarf"
	)

	tutorial = "A worker for the nightmaster. Ruthless and dimwitted, when they're not abusing denizens, they're processing spice and dust."
	allowed_patrons = list("Psydon", "Saradomin", "Guthix", "Zamorak")
	outfit = /datum/outfit/job/roguetown/grabber
	display_order = JDO_GRABBER
	give_bank_account = TRUE

/datum/outfit/job/roguetown/grabber/pre_equip(mob/living/carbon/human/H)
	..()
	if(prob(50))
		beltl = /obj/item/flashlight/flare/torch/lantern
	l_hand = /obj/item/candle/yellow/lit
	if(H.mind)
		H.mind.adjust_skillrank(/datum/skill/combat/swords, pick(2,3), TRUE)
		if(H.gender == MALE)
			H.mind.adjust_skillrank(/datum/skill/combat/axesmaces, rand(2,4), TRUE)
		else
			H.mind.adjust_skillrank(/datum/skill/combat/swords, 1, TRUE)
		H.mind.adjust_skillrank(/datum/skill/combat/wrestling, rand(2,5), TRUE)
		H.mind.adjust_skillrank(/datum/skill/combat/unarmed, rand(2,5), TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/swimming, rand(3,4), TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/climbing, 2, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/athletics, 1, TRUE)

		var/datum/atom_hud/K = GLOB.huds[DATA_HUD_KINGDOM]
		K.add_hud_to(H)
		H.civilization = "Night Manor"
		H.kingdom_perms = list(0,0,0,0)
		king_hud_set_status()
		add_basic_kingdom_verbs()
	if(H.gender == MALE)
		shoes = /obj/item/clothing/shoes/roguetown/boots/leather
		pants = /obj/item/clothing/under/roguetown/tights/sailor
		beltr = /obj/item/rogueweapon/mace
		belt = /obj/item/storage/belt/rogue/leather/rope
		shirt = /obj/item/clothing/suit/roguetown/armor/gambeson
		if(prob(70))
			armor = /obj/item/clothing/suit/roguetown/armor/leather/vest/sailor
		H.change_stat("strength", 2)
		H.change_stat("intelligence", -3)
		H.change_stat("endurance", 3)
		H.change_stat("constitution", 2)
	else
		shoes = /obj/item/clothing/shoes/roguetown/gladiator
		pants = /obj/item/clothing/under/roguetown/tights/sailor
		beltr = /obj/item/rogueweapon/sword/cutlass
		belt = /obj/item/storage/belt/rogue/leather/rope
		shirt = /obj/item/clothing/suit/roguetown/armor/gambeson
		if(prob(75))
			armor = /obj/item/clothing/suit/roguetown/armor/leather/vest/sailor
		H.change_stat("strength", 1)
		H.change_stat("perception", 2)
		H.change_stat("intelligence", -3)
		H.change_stat("endurance", 4)
		H.change_stat("speed", 3)
		H.change_stat("constitution", 1)
