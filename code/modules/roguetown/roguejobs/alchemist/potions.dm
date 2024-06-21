//Basic
/datum/reagent/additive
	name = "additive"
	reagent_state = LIQUID

//Potions
/datum/reagent/medicine/healthpot
	name = "Health Potion"
	description = "Gradually regenerates all types of damage."
	reagent_state = LIQUID
	color = "#ff0000"
	taste_description = "red"
	overdose_threshold = 0
	metabolization_rate = REAGENTS_METABOLISM
	alpha = 173

/datum/reagent/medicine/healthpot/on_mob_life(mob/living/carbon/M)
	M.blood_volume = min(M.blood_volume+5, BLOOD_VOLUME_MAXIMUM)
	M.adjustBruteLoss(-2*REM, 0)
	M.adjustFireLoss(-2*REM, 0)
	M.adjustOxyLoss(-1, 0)
	M.adjustOrganLoss(ORGAN_SLOT_BRAIN, -5*REM)
	M.adjustCloneLoss(-2*REM, 0)
	M.visible_message("<span class='info'>HEALTH POT doing it's stuff (base meta)</span>")
	..()
	. = 1


/datum/reagent/medicine/stronghealth
	name = "Strong Health Potion"
	description = "Quickly regenerates all types of damage."
	color = "#ff0000"
	metabolization_rate = 2 * REAGENTS_METABOLISM

/datum/reagent/medicine/stronghealth/on_mob_life(mob/living/carbon/M)
	M.blood_volume = min(M.blood_volume+5, BLOOD_VOLUME_MAXIMUM)
	M.adjustBruteLoss(-8*REM, 0)
	M.adjustFireLoss(-8*REM, 0)
	M.adjustOxyLoss(-5, 0)
	M.adjustOrganLoss(ORGAN_SLOT_BRAIN, -5*REM)
	M.adjustCloneLoss(-5*REM, 0)
	M.visible_message("<span class='info'>STRONG HEALTH POT doing it's stuff (2x meta)</span>")
	..()
	. = 1

//
/datum/reagent/medicine/manapot
	name = "Mana Potion"
	description = "Gradually regenerates stamina."
	reagent_state = LIQUID
	color = "#0000ff"
	taste_description = "sweet mana"
	overdose_threshold = 0
	metabolization_rate = 2 * REAGENTS_METABOLISM
	alpha = 173

/datum/reagent/medicine/manapot/on_mob_life(mob/living/carbon/M)
	M.rogstam_add(100)
	..()
	. = 1


/datum/reagent/medicine/strongmana
	name = "Mana Potion"
	description = "Gradually regenerates stamina."
	color = "#0000ff"
	metabolization_rate = 4 * REAGENTS_METABOLISM

/datum/reagent/medicine/strongmana/on_mob_life(mob/living/carbon/M)
	M.rogstam_add(300)
	..()
	. = 1


/datum/reagent/medicine/antidote
	name = "Poison Antidote"
	description = ""
	reagent_state = LIQUID
	color = "#00ff00"
	taste_description = "sickly sweet"
	metabolization_rate = REAGENTS_METABOLISM

/datum/reagent/medicine/antidote/on_mob_life(mob/living/carbon/M)
	M.adjustToxLoss(-4, 0)


/datum/reagent/medicine/diseasecure
	name = "Disease Cure"
	description = ""
	reagent_state = LIQUID
	color = "#ffbf00"
	taste_description = "dirt"
	metabolization_rate = 30 * REAGENTS_METABOLISM

/datum/reagent/medicine/diseasecure/on_mob_life(mob/living/carbon/M)
	M.cure_disease()


//Buff potions
/datum/reagent/medicine/strengthbuff
	name = "Strength"
	description = ""
	reagent_state = LIQUID
	color = "#00B4FF"
	taste_description = "protein"
	metabolization_rate = REAGENTS_METABOLISM * 100

/datum/reagent/medicine/strengthbuff/on_mob_life(mob/living/carbon/M)
	M.apply_status_effect(/datum/status_effect/buff/strengthpot)
	return ..()


//Poisons
/datum/reagent/berrypoison
	name = "Berry Poison"
	description = ""
	reagent_state = LIQUID
	color = "#00B4FF"
	taste_description = "burning"
	metabolization_rate = REAGENTS_METABOLISM

/datum/reagent/berrypoison/on_mob_life(mob/living/carbon/M)
	M.add_nausea(9)
	M.adjustToxLoss(3, 0)
	return ..()


/datum/reagent/strongpoison
	name = "Strong Berry Poison"
	description = ""
	reagent_state = LIQUID
	color = "#00B4FF"
	taste_description = "burning"
	metabolization_rate = REAGENTS_METABOLISM

/datum/reagent/strongpoison/on_mob_life(mob/living/carbon/M)
	M.add_nausea(20)
	M.adjustToxLoss(12, 0)
	return ..()

//Potion reactions
/datum/chemical_reaction/alch/stronghealth
	name = "Strong Health Potion"
	id = /datum/reagent/medicine/stronghealth
	results = list(/datum/reagent/medicine/stronghealth = 5)
	required_reagents = list(/datum/reagent/medicine/healthpot = 5, /datum/reagent/additive = 5)
	mix_message = "oh shit health worked!"

/datum/chemical_reaction/alch/strongmana
	name = "Strong Mana Potion"
	id = /datum/reagent/medicine/strongmana
	results = list(/datum/reagent/medicine/strongmana = 5)
	required_reagents = list(/datum/reagent/medicine/manapot = 5, /datum/reagent/additive = 5)
	mix_message = "oh shit mana worked!"

/datum/chemical_reaction/alch/strongpoison
	name = "Strong Health Potion"
	id = /datum/reagent/strongpoison
	results = list(/datum/reagent/strongpoison = 5)
	required_reagents = list(/datum/reagent/berrypoison = 5, /datum/reagent/additive = 5)
	mix_message = "oh shit poison worked!"
