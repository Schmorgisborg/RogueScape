/datum/job/roguetown/skeleton
	title = "Skeleton"
	flag = GRAVEDIGGER
	department_flag = PEASANTS
	faction = "Undead"
	total_positions = 12
	spawn_positions = 12

	allowed_sexes = list("male", "female")
	allowed_races = list("Humen","Dark Elf","Elf","Dwarf")
	allowed_patrons = list("Zamorak")
	tutorial = "The only creation loved by Zamorak, your purpose is to kill the inhabitants so they don't kill one another."

	outfit = /datum/outfit/job/roguetown/skeleton
	show_in_credits = TRUE
	give_bank_account = FALSE
	display_order = JDO_SKELETON

/datum/job/roguetown/skeleton/after_spawn(mob/living/L, mob/M, latejoin = TRUE)
	..()
	if(L)
		var/mob/living/carbon/human/H = L
		if(M.mind)
			M.mind.special_role = "Skeleton"
			M.mind.assigned_role = "Skeleton"
		if(H.dna && H.dna.species)
			H.dna.species.species_traits |= NOBLOOD
			H.dna.species.soundpack_m = new /datum/voicepack/skeleton()
			H.dna.species.soundpack_f = new /datum/voicepack/skeleton()
		var/obj/item/bodypart/O = H.get_bodypart(BODY_ZONE_R_ARM)
		if(O)
			O.drop_limb()
			qdel(O)
		O = H.get_bodypart(BODY_ZONE_L_ARM)
		if(O)
			O.drop_limb()
			qdel(O)
		H.regenerate_limb(BODY_ZONE_R_ARM)
		H.regenerate_limb(BODY_ZONE_L_ARM)
		for(var/obj/item/bodypart/B in H.bodyparts)
			B.skeletonize()
		H.remove_all_languages()
		H.grant_language(/datum/language/hellspeak)
		H.base_intents = list(INTENT_HELP, INTENT_DISARM, INTENT_GRAB, /datum/intent/unarmed/claw)
		H.update_a_intents()
		H.cmode_music = 'sound/music/combatbandit.ogg'

		var/obj/item/organ/eyes/eyes = H.getorganslot(ORGAN_SLOT_EYES)
		if(eyes)
			eyes.Remove(H,1)
			QDEL_NULL(eyes)
		eyes = new /obj/item/organ/eyes/night_vision/zombie
		eyes.Insert(H)
		H.ambushable = FALSE
		H.underwear = "Nude"
		if(H.charflaw)
			QDEL_NULL(H.charflaw)
		H.update_body()
		H.mob_biotypes = MOB_UNDEAD
		H.faction = list("undead")
		H.name = "Skeleton"
		H.real_name = "Skeleton"
		ADD_TRAIT(H, TRAIT_NOMOOD, TRAIT_GENERIC)
		ADD_TRAIT(H, TRAIT_NOFATSTAM, TRAIT_GENERIC)
		ADD_TRAIT(H, TRAIT_NOHUNGER, TRAIT_GENERIC)
		ADD_TRAIT(H, TRAIT_NOBREATH, TRAIT_GENERIC)
		ADD_TRAIT(H, TRAIT_NOPAIN, TRAIT_GENERIC)
		ADD_TRAIT(H, TRAIT_TOXIMMUNE, TRAIT_GENERIC)
		ADD_TRAIT(H, TRAIT_SHOCKIMMUNE, TRAIT_GENERIC)
		var/datum/antagonist/new_antag = new /datum/antagonist/skeleton()
		H.mind.add_antag_datum(new_antag)

/datum/outfit/job/roguetown/skeleton/pre_equip(mob/living/carbon/human/H)
	..()
	wrists = /obj/item/clothing/wrists/roguetown/bracers/leather
	if(prob(50))
		wrists = /obj/item/clothing/wrists/roguetown/bracers
	belt = /obj/item/storage/belt/rogue/leather
	if(prob(40))
		armor = /obj/item/clothing/suit/roguetown/armor/chainmail/iron
	if(prob(10))
		head = /obj/item/clothing/head/roguetown/helmet
	if(prob(10))
		head = /obj/item/clothing/head/roguetown/helmet/skullcap
	if(prob(10))
		head = /obj/item/clothing/head/roguetown/helmet/horned
	if(prob(10))
		head = /obj/item/clothing/head/roguetown/helmet/kettle
	if(prob(50))
		beltr = /obj/item/rogueweapon/sword
		if(H.gender == FEMALE)
			beltr = /obj/item/rogueweapon/sword/sabre
	if(H.gender == FEMALE)
		H.STASTR = 8
	else
		H.STASTR = 10
	H.STASPD = rand(7,10)
	H.STAINT = 1
	H.STACON = 3
	if(H.mind)
		var/datum/atom_hud/K = GLOB.huds[DATA_HUD_KINGDOM]
		K.add_hud_to(H)
		H.civilization = "Creachers"
		H.kingdom_perms = list(0,0,0,0)
		king_hud_set_status()
		make_kingdomless()
