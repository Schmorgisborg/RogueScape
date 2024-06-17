/datum/job/roguetown/monk
	title = "Monk"
	flag = MONK
	department_flag = SERFS
	faction = "Station"
	total_positions = 10
	spawn_positions = 10

	allowed_races = list("Humen",
	"Humen",
	"Elf",
	"Half-Elf",
	"Elf",
	"Dwarf",
	"Aasimar"
	)
	tutorial = "You're here in Wyrld to spread the blessings and word of your the Divine."
	allowed_patrons = list("Psydon", "Saradomin", "Guthix")
	outfit = /datum/outfit/job/roguetown/monk

	display_order = JDO_MONK
	give_bank_account = TRUE

/datum/outfit/job/roguetown/monk
	name = "Acolyte"
	jobtype = /datum/job/roguetown/monk

/datum/outfit/job/roguetown/monk/pre_equip(mob/living/carbon/human/H)
	..()
	H.verbs |= /mob/living/carbon/human/proc/churchexcommunicate
	H.verbs |= /mob/living/carbon/human/proc/churchannouncement
	var/datum/patrongods/A = H.PATRON
	var/obj/item/book/rogue/bibble/T = new()
	l_hand = /obj/item/candle/yellow/lit
	H.put_in_hands(T)
	switch(A.name)
		if("Psydon")
			head = /obj/item/clothing/head/roguetown/roguehood/astrata
			neck = /obj/item/clothing/neck/roguetown/psicross/astrata
			wrists = /obj/item/clothing/wrists/roguetown/wrappings
			shoes = /obj/item/clothing/shoes/roguetown/sandals
			armor = /obj/item/clothing/suit/roguetown/shirt/robe/astrata
			belt = /obj/item/storage/belt/rogue/leather/rope
			beltl = /obj/item/flint
			if(prob(50))
				beltr = /obj/item/flashlight/flare/torch/lantern
		if("Guthix")
			head = /obj/item/clothing/head/roguetown/dendormask
			neck = /obj/item/clothing/neck/roguetown/psicross/dendor
			armor = /obj/item/clothing/suit/roguetown/shirt/robe/dendor
			belt = /obj/item/storage/belt/rogue/leather/rope
			if(prob(50))
				beltr = /obj/item/flashlight/flare/torch/lantern
		if("Saradomin")
			head = /obj/item/clothing/head/roguetown/necrahood
			neck = /obj/item/clothing/neck/roguetown/psicross/necra
			shoes = /obj/item/clothing/shoes/roguetown/boots
			pants = /obj/item/clothing/under/roguetown/trou/leather/mourning
			armor = /obj/item/clothing/suit/roguetown/shirt/robe/necra
			belt = /obj/item/storage/belt/rogue/leather/rope
			if(prob(50))
				beltr = /obj/item/flashlight/flare/torch/lantern
	if(H.mind)
		switch(A.name)
			if("Psydon")
				H.mind.AddSpell(new /obj/effect/proc_holder/spell/invoked/heal/lesser)
				H.mind.AddSpell(new  /obj/effect/proc_holder/spell/invoked/heal)
				H.mind.AddSpell(new  /obj/effect/proc_holder/spell/invoked/revive)
			if("Guthix")			
				H.mind.AddSpell(new /obj/effect/proc_holder/spell/invoked/heal/lesser)
				H.mind.AddSpell(new  /obj/effect/proc_holder/spell/targeted/blesscrop)
				H.mind.AddSpell(new  /obj/effect/proc_holder/spell/targeted/beasttame)
			if("Saradomin")
				H.mind.AddSpell(new /obj/effect/proc_holder/spell/invoked/heal/lesser)
				H.mind.AddSpell(new /obj/effect/proc_holder/spell/targeted/burialrite)
				H.mind.AddSpell(new /obj/effect/proc_holder/spell/targeted/churn)
		H.mind.adjust_skillrank(/datum/skill/misc/sewing, 2, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/medicine, rand(2,3), TRUE)
		H.mind.adjust_skillrank(/datum/skill/combat/unarmed, rand(1,4), TRUE)
		H.mind.adjust_skillrank(/datum/skill/combat/wrestling, rand(1,5), TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/reading, 3, TRUE)
		H.mind.adjust_skillrank(/datum/skill/magic/holy, 3, TRUE)
		if(H.age == AGE_OLD)
			H.mind.adjust_skillrank(/datum/skill/magic/holy, rand(1,2), TRUE)
		H.change_stat("intelligence", 1)
		H.change_stat("endurance", rand(0,1))
		H.change_stat("perception", rand(-1,0))
