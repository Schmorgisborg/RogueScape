/datum/job/roguetown/sgoblin
	title = "Tribesman"
	f_title = "Tribeswoman"
	flag = GRAVEDIGGER
	department_flag = PEASANTS
	faction = "Goblin"
	total_positions = 12
	spawn_positions = 12

	allowed_sexes = list("male", "female")
	allowed_races = list("Goblin")
	allowed_patrons = list("Zamorak")
	tutorial = "One nasty little thing."

	outfit = /datum/outfit/job/roguetown/sgoblin
	show_in_credits = TRUE
	give_bank_account = FALSE
	display_order = JDO_GOBLIN

/datum/job/roguetown/sgoblin/after_spawn(mob/living/L, mob/M, latejoin = TRUE)
	..()
	if(L)
		var/mob/living/carbon/human/H = L
		if(M.mind)
			M.mind.special_role = "Goblin"
			M.mind.assigned_role = "Goblin"

		H.cmode_music = 'sound/music/combatbandit.ogg'

		var/obj/item/organ/eyes/eyes = H.getorganslot(ORGAN_SLOT_EYES)
		if(eyes)
			eyes.Remove(H,1)
			QDEL_NULL(eyes)
		eyes = new /obj/item/organ/eyes/night_vision/zombie
		eyes.Insert(H)
		H.ambushable = FALSE
		H.update_body()
		ADD_TRAIT(H, TRAIT_TOXIMMUNE, TRAIT_GENERIC)
//		var/datum/antagonist/new_antag = new /datum/antagonist/goblin()
//		H.mind.add_antag_datum(new_antag)

/datum/outfit/job/roguetown/sgoblin/pre_equip(mob/living/carbon/human/H)
	..()
	var/loadout = rand(1,5)
	switch(loadout)
		if(1) //tribal spear
			r_hand = /obj/item/rogueweapon/spear/stone
			armor = /obj/item/clothing/suit/roguetown/armor/leather/hide
		if(2) //tribal axe
			r_hand = /obj/item/rogueweapon/stoneaxe
			armor = /obj/item/clothing/suit/roguetown/armor/leather/hide
		if(3) //tribal club
			r_hand = /obj/item/rogueweapon/mace/woodclub
			armor = /obj/item/clothing/suit/roguetown/armor/leather/hide
			if(prob(10))
				head = /obj/item/clothing/head/roguetown/helmet/leather
		if(4) //lightly armored sword/flail/daggers
			if(prob(50))
				r_hand = /obj/item/rogueweapon/sword/iron
			else
				r_hand = /obj/item/rogueweapon/mace/spiked
			if(prob(30))
				l_hand = /obj/item/rogueweapon/shield/wood
			if(prob(23))
				r_hand = /obj/item/rogueweapon/huntingknife/stoneknife
				l_hand = /obj/item/rogueweapon/huntingknife/stoneknife
			armor = /obj/item/clothing/suit/roguetown/armor/leather
			if(prob(80))
				head = /obj/item/clothing/head/roguetown/helmet/leather
		if(5) //heavy armored sword/flail/shields
			if(prob(30))
				armor = /obj/item/clothing/suit/roguetown/armor/plate/half/iron
			else
				armor = /obj/item/clothing/suit/roguetown/armor/leather
			if(prob(80))
				head = /obj/item/clothing/head/roguetown/helmet
			else
				head = /obj/item/clothing/head/roguetown/helmet/leather
			if(prob(50))
				r_hand = /obj/item/rogueweapon/sword/iron
			else
				r_hand = /obj/item/rogueweapon/mace/spiked
			if(prob(20))
				r_hand = /obj/item/rogueweapon/flail
			l_hand = /obj/item/rogueweapon/shield/wood
	if(H.mind)
		var/datum/atom_hud/K = GLOB.huds[DATA_HUD_KINGDOM]
		K.add_hud_to(H)
		H.civilization = "Creachers"
		H.kingdom_perms = list(0,0,0,0)
		H.king_hud_set_status()
		H.make_kingdomless()
