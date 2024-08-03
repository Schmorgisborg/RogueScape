/datum/advclass/monk
	name = "Warrior Monk"
	allowed_sexes = list("male", "female")
	tutorial = "A warrior of the Gods, unmatched in unarmed combat with otherworldly strength and reflexes."
	allowed_races = list("Humen", "Elf", "Dwarf")
	outfit = /datum/outfit/job/roguetown/adventurer/monk
	isvillager = FALSE
	ispilgrim = FALSE
	vampcompat = FALSE


/datum/outfit/job/roguetown/adventurer/monk/pre_equip(mob/living/carbon/human/H)
	..()
	head = /obj/item/clothing/head/roguetown/roguehood
	neck = /obj/item/clothing/neck/roguetown/psicross/original
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
		H.mind.adjust_skillrank(/datum/skill/craft/crafting, 1, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/reading, 3, TRUE)
		H.mind.adjust_skillrank(/datum/skill/combat/unarmed, 5, TRUE)
		H.mind.adjust_skillrank(/datum/skill/combat/wrestling, 4, TRUE)
		var/datum/martial_art/resting_rous/grant = new /datum/martial_art/resting_rous
		grant.teach(H)
		H.change_stat("strength", rand(1,2))
		H.change_stat("intelligence", 1)
		H.change_stat("endurance", 2)
		H.change_stat("perception", -1)
