
/datum/advclass/bard
	name = "Bard"
	tutorial = "Bards have a near magical ability to weave music and tales, \
	and although they're reknown for being cowardly, they tend to be very bold."
	allowed_sexes = list("male", "female")
	allowed_races = list("Humen",
	"Humen",
	"Half-Elf",
	"Elf",
	"Elf",
	"Dwarf",
	"Dwarf",
	"Tiefling",
	"Aasimar"
	)
	outfit = /datum/outfit/job/roguetown/adventurer/bard

/datum/outfit/job/roguetown/adventurer/bard/pre_equip(mob/living/carbon/human/H)
	..()
	H.mind.adjust_skillrank(/datum/skill/combat/knives, 3, TRUE)
	H.mind.adjust_skillrank(/datum/skill/combat/swords, rand(2,4), TRUE)
	H.mind.adjust_skillrank(/datum/skill/combat/bows, 2, TRUE)
	H.mind.adjust_skillrank(/datum/skill/combat/unarmed, rand(1,5), TRUE)
	H.mind.adjust_skillrank(/datum/skill/craft/crafting, 1, TRUE)
	H.mind.adjust_skillrank(/datum/skill/misc/swimming, 2, TRUE)
	H.mind.adjust_skillrank(/datum/skill/misc/climbing, 2, TRUE)
	H.mind.adjust_skillrank(/datum/skill/misc/riding, 3, TRUE)
	H.mind.adjust_skillrank(/datum/skill/misc/sewing, 1, TRUE)
	H.mind.adjust_skillrank(/datum/skill/misc/reading, 3, TRUE)
	H.mind.adjust_skillrank(/datum/skill/craft/cooking, 1, TRUE)
	H.mind.adjust_skillrank(/datum/skill/misc/sneaking, 3, TRUE)
	H.mind.adjust_skillrank(/datum/skill/misc/stealing, 1, TRUE)
	H.mind.adjust_skillrank(/datum/skill/misc/music, rand(3,6), TRUE)
	head = /obj/item/clothing/head/roguetown/bardhat
	shoes = /obj/item/clothing/shoes/roguetown/boots
	pants = /obj/item/clothing/under/roguetown/tights/random
	shirt = /obj/item/clothing/suit/roguetown/shirt/shortshirt
	if(prob(30))
		gloves = /obj/item/clothing/gloves/roguetown/fingerless
	belt = /obj/item/storage/belt/rogue/leather
	armor = /obj/item/clothing/suit/roguetown/armor/leather/vest
	cloak = /obj/item/clothing/cloak/raincloak/blue
	if(prob(50))
		cloak = /obj/item/clothing/cloak/raincloak/red
	if(prob(50))
		cloak = /obj/item/clothing/cloak/raincloak/green
	backl = /obj/item/storage/backpack/rogue/satchel
	beltr = /obj/item/rogueweapon/huntingknife/idagger/steel
	if(prob(50))
		beltl = /obj/item/flashlight/flare/torch/lantern
	if(H.dna?.species)
		if(H.dna.species.id == "human")
			backr = /obj/item/rogue/instrument/lute
		if(H.dna.species.id == "dwarf")
			backr = /obj/item/rogue/instrument/accord
		if(H.dna.species.id == "elf")
			backr = /obj/item/rogue/instrument/harp
		if(H.dna.species.id == "tiefling")
			backr = /obj/item/rogue/instrument/guitar
	ADD_TRAIT(H, RTRAIT_MEDIUMARMOR, TRAIT_GENERIC)
	H.change_stat("perception", 1)
	H.change_stat("speed", 2)
