/datum/job/roguetown/mason
	title = "Artificer"
	flag = MASON
	department_flag = SERFS
	faction = "Station"
	total_positions = 6
	spawn_positions = 6
	allowed_races = list("Humen",
	"Humen",
	"Elf",
	"Dwarf",
	"Dwarf",
	"Aasimar"
	)
	allowed_sexes = list(MALE, FEMALE)
	tutorial = "The creators of the former kingdom. Masters of construction and capable warriors."
	outfit = /datum/outfit/job/roguetown/mason
	display_order = JDO_ARTIFICER

/datum/outfit/job/roguetown/mason/pre_equip(mob/living/carbon/human/H)
	..()
	if(H.mind)
		H.mind.adjust_skillrank(/datum/skill/combat/axesmaces, rand(2,4), TRUE)
		H.mind.adjust_skillrank(/datum/skill/combat/wrestling, rand(1,3), TRUE)
		H.mind.adjust_skillrank(/datum/skill/combat/unarmed, rand(1,3), TRUE)
		H.mind.adjust_skillrank(/datum/skill/craft/crafting, rand(4,5), TRUE)
		H.mind.adjust_skillrank(/datum/skill/craft/carpentry, rand(4,5), TRUE)
		H.mind.adjust_skillrank(/datum/skill/craft/masonry, rand(4,5), TRUE)
		H.mind.adjust_skillrank(/datum/skill/craft/engineering, rand(2,4), TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/swimming, 1, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/climbing, 3, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/athletics, 1, TRUE)
	head = /obj/item/clothing/head/roguetown/hatfur
	if(prob(50))
		head = /obj/item/clothing/head/roguetown/hatblu
	neck = /obj/item/clothing/neck/roguetown/gorget
	armor = /obj/item/clothing/suit/roguetown/armor/chainmail
	cloak = /obj/item/clothing/cloak/apron/waist/brown
	pants = /obj/item/clothing/under/roguetown/trou
	shirt = /obj/item/clothing/suit/roguetown/shirt/undershirt/random
	shoes = /obj/item/clothing/shoes/roguetown/boots/leather
	belt = /obj/item/storage/belt/rogue/leather
	beltl = /obj/item/rogueweapon/stoneaxe/woodcut
	if(prob(50))
		beltl = /obj/item/flashlight/flare/torch/lantern
	l_hand = /obj/item/candle/yellow/lit
	backl = /obj/item/storage/backpack/rogue/backpack
	backpack_contents = list(/obj/item/flint, /obj/item/rogueweapon/hammer/claw)
	H.change_stat("strength", 2)
	H.change_stat("intelligence", 1)
	H.change_stat("endurance", 1)
	H.change_stat("constitution", 1)
	H.change_stat("speed", -1)

	ADD_TRAIT(H, RTRAIT_MEDIUMARMOR, TRAIT_GENERIC)
