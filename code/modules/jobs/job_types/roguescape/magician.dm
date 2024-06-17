/datum/job/roguetown/magician
	title = "Grand Wizard"
	flag = ADVENTURER
	department_flag = SERFS
	faction = "Station"
	total_positions = 3
	spawn_positions = 3

	allowed_races = list("Humen",
	"Humen",
	"Elf",
	"Aasimar",
	"Half-Elf")
	allowed_sexes = list(MALE, FEMALE)
	spells = list(/obj/effect/proc_holder/spell/invoked/projectile/fireball, /obj/effect/proc_holder/spell/invoked/projectile/lightningbolt, /obj/effect/proc_holder/spell/invoked/projectile/fetch)
	display_order = JDO_GRANDWIZARD
	tutorial = "You swore your fealty to the kingdom, seek the old Lord; establish a tower in this new land."
	outfit = /datum/outfit/job/roguetown/magician
	min_pq = -4

/datum/outfit/job/roguetown/magician/pre_equip(mob/living/carbon/human/H)
	..()
	ADD_TRAIT(H, RTRAIT_SEEPRICES, type)
	shoes = /obj/item/clothing/shoes/roguetown/shortboots
	armor = /obj/item/clothing/suit/roguetown/shirt/robe/black
	cloak = /obj/item/clothing/cloak/black_cloak
	belt = /obj/item/storage/belt/rogue/leather/plaquesilver
	beltr = /obj/item/flashlight/flare/torch/lantern
	beltl = /obj/item/rogueweapon/huntingknife/idagger/
	neck = /obj/item/clothing/neck/roguetown/talkstone
	pants = /obj/item/clothing/under/roguetown/tights/random
	id = /obj/item/scomstone
	if(H.mind)
		H.mind.adjust_skillrank(/datum/skill/misc/reading, 6, TRUE)
		H.mind.adjust_skillrank(/datum/skill/magic/arcane, pick(6,5), TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/riding, 2, TRUE)
		H.mind.adjust_skillrank(/datum/skill/combat/polearms, 2, TRUE)
		H.mind.adjust_skillrank(/datum/skill/combat/knives, 2, TRUE)
		H.change_stat("strength", pick(0,1))
		H.change_stat("intelligence", 2)
		H.change_stat("constitution", -2)
		H.change_stat("speed", -2)
		if(H.age == AGE_OLD)
			H.change_stat("intelligence", 1)
			if(H.dna.species.id == "human")
				belt = /obj/item/storage/belt/rogue/leather/plaquegold
				cloak = null
				head = /obj/item/clothing/head/roguetown/wizhat
				armor = /obj/item/clothing/suit/roguetown/shirt/robe/wizard
				H.dna.species.soundpack_m = new /datum/voicepack/male/wizard()
	ADD_TRAIT(H, RTRAIT_NOBLE, TRAIT_GENERIC)
	ADD_TRAIT(H, RTRAIT_MEDIUMARMOR, TRAIT_GENERIC)
