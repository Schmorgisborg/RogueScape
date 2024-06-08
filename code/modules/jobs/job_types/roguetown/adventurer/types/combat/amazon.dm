/datum/advclass/amazon
	name = "Amazon"
	tutorial = "Amazons are warrior-women from less civilized area of the old land."
	allowed_sexes = list("female")
	allowed_races = list("Humen",
	"Dwarf")
	outfit = /datum/outfit/job/roguetown/adventurer/amazon
	allowed_ages = list(AGE_ADULT, AGE_MIDDLEAGED)
	pickprob = 13
	maxchosen = 6

/datum/outfit/job/roguetown/adventurer/amazon/pre_equip(mob/living/carbon/human/H)
	..()
	H.mind.adjust_skillrank(/datum/skill/combat/polearms, 3, TRUE)
	H.mind.adjust_skillrank(/datum/skill/combat/swords, 1, TRUE)
	H.mind.adjust_skillrank(/datum/skill/combat/knives, 1, TRUE)
	H.mind.adjust_skillrank(/datum/skill/combat/bows, 3, TRUE)
	H.mind.adjust_skillrank(/datum/skill/combat/wrestling, 3, TRUE)
	H.mind.adjust_skillrank(/datum/skill/combat/unarmed, 2, TRUE)
	H.mind.adjust_skillrank(/datum/skill/craft/crafting, 1, TRUE)
	H.mind.adjust_skillrank(/datum/skill/misc/swimming, 2, TRUE)
	H.mind.adjust_skillrank(/datum/skill/misc/climbing, 2, TRUE)
	H.mind.adjust_skillrank(/datum/skill/misc/riding, 2, TRUE)
	H.mind.adjust_skillrank(/datum/skill/misc/athletics, 1, TRUE)
	belt = /obj/item/storage/belt/rogue/leather/rope
	beltr = /obj/item/flint
	shoes = /obj/item/clothing/shoes/roguetown/gladiator
	if(prob(44))
		backr = /obj/item/storage/backpack/rogue/satchel
	if(prob(30))
		armor = /obj/item/clothing/suit/roguetown/armor/leather
	if(prob(30))
		armor = /obj/item/clothing/suit/roguetown/armor/leather/hide
	if(prob(70))
		armor = /obj/item/clothing/suit/roguetown/armor/chainmail/chainkini
	wrists = /obj/item/clothing/wrists/roguetown/bracers/leather
	if(prob(50))
		shoes = /obj/item/clothing/shoes/roguetown/boots
	if(prob(75))
		r_hand = /obj/item/rogueweapon/sword/iron
		H.mind.adjust_skillrank(/datum/skill/combat/swords, 2, TRUE)
	else
		r_hand = /obj/item/rogueweapon/spear
		H.mind.adjust_skillrank(/datum/skill/combat/polearms, 1, TRUE)
	H.change_stat("strength", 2)
	H.change_stat("intelligence", -3)
	H.change_stat("perception", 1)
	H.change_stat("endurance", 1)
	ADD_TRAIT(H, TRAIT_STEELHEARTED, TRAIT_GENERIC)
	ADD_TRAIT(H, RTRAIT_MEDIUMARMOR, TRAIT_GENERIC)
	if(H.wear_mask) //for stupid retards with bad eyes
		var/obj/I = H.wear_mask
		H.dropItemToGround(H.wear_mask, TRUE)
		qdel(I)
