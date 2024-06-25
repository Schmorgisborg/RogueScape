//shield
/datum/advclass/cleric
	name = "Cleric"
	tutorial = "Clerics are wandering warriors of the Gods, an asset to any party."
	allowed_sexes = list("male","female")
	allowed_races = list("Humen", "Elf", "Dwarf")
	allowed_patrons = list("Psydon", "Saradomin", "Guthix")
	ispilgrim = FALSE
	vampcompat = FALSE
	outfit = /datum/outfit/job/roguetown/adventurer/cleric

/datum/outfit/job/roguetown/adventurer/cleric/pre_equip(mob/living/carbon/human/H)
	var/allowed_patrons = list("Psydon", "Saradomin", "Guthix")
	..()
	var/datum/patrongods/A = H.PATRON
	if(!(A.name in allowed_patrons))
		var/list/datum/patrongods/options = list(/datum/patrongods/psydon, /datum/patrongods/saradomin, /datum/patrongods/guthix)
		qdel(H.PATRON)
		var/datum/patrongods/newest = pick(options)
		H.PATRON = new newest
	neck = /obj/item/clothing/neck/roguetown/psicross/original
	armor = /obj/item/clothing/suit/roguetown/armor/plate
	wrists = /obj/item/clothing/wrists/roguetown/bracers/leather
	pants = /obj/item/clothing/under/roguetown/trou/leather
	shoes = /obj/item/clothing/shoes/roguetown/boots/leather
	belt = /obj/item/storage/belt/rogue/leather
	beltr = /obj/item/rogueweapon/mace
	if(prob(50))
		beltl = /obj/item/flashlight/flare/torch/lantern
	if(H.mind)
		H.mind.adjust_skillrank(/datum/skill/combat/axesmaces, 4, TRUE)
		H.mind.adjust_skillrank(/datum/skill/combat/crossbows, 2, TRUE)
		H.mind.adjust_skillrank(/datum/skill/combat/bows, 1, TRUE)
		H.mind.adjust_skillrank(/datum/skill/combat/wrestling, 2, TRUE)
		H.mind.adjust_skillrank(/datum/skill/combat/unarmed, 3, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/climbing, 1, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/athletics, 3, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/reading, 3, TRUE)
		H.mind.adjust_skillrank(/datum/skill/magic/holy, 1, TRUE)
		if(H.age == AGE_OLD)
			H.mind.adjust_skillrank(/datum/skill/combat/axesmaces, 1, TRUE)
			H.mind.adjust_skillrank(/datum/skill/magic/holy, 1, TRUE)
		H.change_stat("strength", 1)
		H.change_stat("perception", -2)
		H.change_stat("intelligence", 2)
		H.change_stat("constitution", 2)
		H.change_stat("endurance", 3)
		H.change_stat("speed", -1)
	ADD_TRAIT(H, RTRAIT_HEAVYARMOR, TRAIT_GENERIC)
	H.mind.AddSpell(new /obj/effect/proc_holder/spell/invoked/heal/lesser)
	H.mind.AddSpell(new  /obj/effect/proc_holder/spell/invoked/heal)
