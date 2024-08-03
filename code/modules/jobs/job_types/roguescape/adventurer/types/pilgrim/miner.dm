/datum/advclass/miner
	name = "Miner"
	allowed_sexes = list("male")
	allowed_races = list("Humen", "Dark Elf", "Dwarf")
	outfit = /datum/outfit/job/roguetown/adventurer/miner
	isvillager = TRUE
	ispilgrim = TRUE

/datum/outfit/job/roguetown/adventurer/miner/pre_equip(mob/living/carbon/human/H)
	..()
	head = /obj/item/clothing/head/roguetown/armingcap
	pants = /obj/item/clothing/under/roguetown/trou
	armor = /obj/item/clothing/suit/roguetown/armor/workervest
	shirt = /obj/item/clothing/suit/roguetown/shirt/undershirt/random
	shoes = /obj/item/clothing/shoes/roguetown/boots/leather
	belt = /obj/item/storage/belt/rogue/leather/rope
	if(prob(50))
		beltr = /obj/item/flashlight/flare/torch/lantern
	beltl = /obj/item/rogueweapon/pick
	backl = /obj/item/storage/backpack/rogue/backpack
	if(H.mind)
		H.mind.adjust_skillrank(/datum/skill/combat/axesmaces, 1, TRUE)
		H.mind.adjust_skillrank(/datum/skill/combat/wrestling, rand(1,3), TRUE)
		H.mind.adjust_skillrank(/datum/skill/combat/unarmed, rand(1,3), TRUE)
		H.mind.adjust_skillrank(/datum/skill/craft/crafting, 2, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/swimming, 1, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/climbing, 2, TRUE)
		H.change_stat("strength", rand(1,2))
		H.change_stat("intelligence", -2)
		H.change_stat("endurance", 1)
