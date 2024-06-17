/datum/job/roguetown/butler
	title = "Younker"
	flag = BUTLER
	department_flag = PEASANTS
	faction = "Station"
	total_positions = 1
	spawn_positions = 1

	f_title = "Maid"
	allowed_races = list("Humen",
	"Humen",
	"Elf",
	"Dwarf",
	"Half-Elf",
	"Dark Elf"
	)
	allowed_ages = list(AGE_ADULT)

	tutorial = "Servitude unto death, but you don't consider yourself a slave. A talented craftsman in many forms, at the whim of the Nightman."

	outfit = /datum/outfit/job/roguetown/butler
	display_order = JDO_YOUNKER
	give_bank_account = TRUE

/datum/outfit/job/roguetown/butler/pre_equip(mob/living/carbon/human/H)
	..()
	if(H.mind)
		H.mind.adjust_skillrank(/datum/skill/combat/knives, rand(2,3), TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/reading, 1, TRUE)
		H.mind.adjust_skillrank(/datum/skill/craft/cooking, 3, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/medicine, 3, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/sewing, 3, TRUE)
		H.mind.adjust_skillrank(/datum/skill/craft/weaponsmithing, pick(1,2), TRUE)
		H.mind.adjust_skillrank(/datum/skill/craft/blacksmithing, pick(1,2), TRUE)
		H.mind.adjust_skillrank(/datum/skill/craft/armorsmithing, pick(1,2), TRUE)
	belt = /obj/item/storage/belt/rogue/leather
	if(prob(50))
		beltl = /obj/item/flashlight/flare/torch/lantern
	l_hand = /obj/item/candle/yellow/lit
	if(H.gender == MALE)
		pants = /obj/item/clothing/under/roguetown/tights
		shirt = /obj/item/clothing/suit/roguetown/shirt/undershirt
		shoes = /obj/item/clothing/shoes/roguetown/shortboots
		armor = /obj/item/clothing/suit/roguetown/armor/leather/vest/black
		H.change_stat("intelligence", 1)
		H.change_stat("perception", 1)
	else
		armor = /obj/item/clothing/suit/roguetown/shirt/dress/gen
		shoes = /obj/item/clothing/shoes/roguetown/simpleshoes
		cloak = /obj/item/clothing/cloak/apron/waist
		H.mind.adjust_skillrank(/datum/skill/misc/sneaking, pick(1,2), TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/stealing, pick(2,3), TRUE)
		H.change_stat("strength", -1)
		H.change_stat("intelligence", 1)
		H.change_stat("perception", 1)

