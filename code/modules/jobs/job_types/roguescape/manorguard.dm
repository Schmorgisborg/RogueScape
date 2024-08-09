/datum/job/roguetown/manorguard
	title = "Guard"
	flag = ADVENTURER
	department_flag = SERFS
	faction = "Kingdom"
	total_positions = 6
	spawn_positions = 6

	allowed_sexes = list("male", "female")
	allowed_races = list("Humen",
	"Humen",
	"Dwarf",
	"Elf")
	allowed_ages = list(AGE_ADULT, AGE_MIDDLEAGED)

	tutorial = "An elite guardsman, sent to protect the innocent from the undead."
	display_order = JDO_GUARD

	outfit = /datum/outfit/job/roguetown/manorguard
	give_bank_account = 22
	min_pq = -4


/datum/job/roguetown/manorguard/after_spawn(mob/living/L, mob/M, latejoin = TRUE)
	..()
	if(ishuman(L))
		var/mob/living/carbon/human/H = L
		if(istype(H.cloak, /obj/item/clothing/cloak/stabard/surcoat/guard))
			var/obj/item/clothing/S = H.cloak
			var/index = findtext(H.real_name, " ")
			if(index)
				index = copytext(H.real_name, 1,index)
			if(!index)
				index = H.real_name
			S.name = "guard's tabard ([index])"


/datum/outfit/job/roguetown/manorguard/pre_equip(mob/living/carbon/human/H)
	..()
	head = /obj/item/clothing/head/roguetown/helmet
	pants = /obj/item/clothing/under/roguetown/chainlegs
	cloak = /obj/item/clothing/cloak/stabard/surcoat/guard
	neck = /obj/item/clothing/neck/roguetown/gorget
	armor = /obj/item/clothing/suit/roguetown/armor/chainmail
	shirt = /obj/item/clothing/suit/roguetown/shirt/shortshirt/merc
	shoes = /obj/item/clothing/shoes/roguetown/boots
	if(prob(50))
		beltl = /obj/item/flashlight/flare/torch/lantern
	l_hand = /obj/item/candle/yellow/lit
	belt = /obj/item/storage/belt/rogue/leather
	beltr = /obj/item/rogueweapon/sword
	backr = /obj/item/storage/backpack/rogue/satchel
	if(H.mind)
		H.mind.adjust_skillrank(/datum/skill/combat/axesmaces, 3, TRUE)
		H.mind.adjust_skillrank(/datum/skill/combat/wrestling, 4, TRUE)
		H.mind.adjust_skillrank(/datum/skill/combat/unarmed, 3, TRUE)
		H.mind.adjust_skillrank(/datum/skill/combat/swords, 4, TRUE)
		H.mind.adjust_skillrank(/datum/skill/combat/polearms, 3, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/swimming, 2, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/climbing, 2, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/athletics, 3, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/reading, 1, TRUE)
		H.change_stat("strength", rand(1,2))
		H.change_stat("perception", 2)
		H.change_stat("endurance", 2)
		H.change_stat("speed", rand(1,2))

		var/datum/atom_hud/K = GLOB.huds[DATA_HUD_KINGDOM]
		K.add_hud_to(H)
		H.civilization = "Psydonia"
		H.kingdom_perms = list(0,0,0,1)
		H.king_hud_set_status()
		H.add_basic_kingdom_verbs()

	if(H.gender == FEMALE)
		var/acceptable = list("Tomboy", "Bob", "Curly Short")
		if(!(H.hairstyle in acceptable))
			H.hairstyle = pick(acceptable)
			H.update_hair()
	H.verbs |= /mob/proc/haltyell
	ADD_TRAIT(H, RTRAIT_HEAVYARMOR, TRAIT_GENERIC)
