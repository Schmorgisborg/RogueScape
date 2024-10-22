/datum/advclass/monk
	name = "Warrior-Monk"
	allowed_sexes = list("male", "female")
	tutorial = "A traveling warrior-monk, unmatched in unarmed combat with otherworldly strength."
	allowed_races = list("Humen",
	"Humen",
	"Elf",
	"Elf",
	"Half-Elf",
	"Dwarf",
	"Aasimar"
	)
	outfit = /datum/outfit/job/roguetown/adventurer/monk
	isvillager = FALSE
	ispilgrim = FALSE
	vampcompat = FALSE


/datum/outfit/job/roguetown/adventurer/monk/pre_equip(mob/living/carbon/human/H)
	..()
	head = /obj/item/clothing/head/roguetown/roguehood
	neck = /obj/item/clothing/neck/roguetown/psicross
	shoes = /obj/item/clothing/shoes/roguetown/shortboots
	cloak = /obj/item/clothing/cloak/raincloak/furcloak/brown
	armor = /obj/item/clothing/suit/roguetown/shirt/robe
	belt = /obj/item/storage/belt/rogue/leather/rope
	if(prob(50))
		beltr = /obj/item/flashlight/flare/torch/lantern
	backl = /obj/item/storage/backpack/rogue/backpack
	var/obj/item/rogueweapon/woodstaff/W = new()
	H.put_in_hands(W)
	if(H.mind)
		H.mind.adjust_skillrank(/datum/skill/misc/reading, 3, TRUE)
		H.mind.adjust_skillrank(/datum/skill/combat/unarmed, 5, TRUE)
		H.mind.adjust_skillrank(/datum/skill/combat/wrestling, 4, TRUE)
		H.change_stat("strength", 1)
		H.change_stat("intelligence", 1)
		H.change_stat("endurance", 2)
		H.change_stat("perception", -1)
