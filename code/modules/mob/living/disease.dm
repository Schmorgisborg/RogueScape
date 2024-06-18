/****************************************************
				DISEASE MODULE
****************************************************/
/mob/living/carbon
	var/disease_rate = 0 //Speed of wound infection
	var/disease_tracker = 0
	var/list/diseases = list()
	var/list/master_disease_list = list("rattles","bonefever","witbane","collywobbles","ataxia","blackheart","dampworm","greenspore","rustchancre","swampfever","witlesspox")
	var/disease_threshhold = DISEASE_THRESHHOLD //Threshold before disease rolls begin
	var/disease_max = DISEASE_MAX //Max amount of diseases contracted

/mob/living/carbon/proc/handle_disease()
	if(disease_max <= 0)//Already have 2 diseases
		return

	disease_rate = get_disease_rate()
	disease_threshhold -= max(disease_rate, 0)
	if((disease_threshhold <= 0))//Once infection builds up
		disease_max--

		var/rtd = rand(1,master_disease_list.len)
		if(prob(60))
			rtd = 0
		if(disease_tracker == rtd)//No duplicate diseases
			rtd = 0
		disease_tracker = rtd
		switch(rtd)//Pick a disease
			if(1)
				apply_status_effect(/datum/status_effect/debuff/disease/rattles)
				to_chat(src, "<span class='warning'>I've contracted rattles!</span>")
			if(2)
				apply_status_effect(/datum/status_effect/debuff/disease/witbane)
				to_chat(src, "<span class='warning'>I've contracted witbane!</span>")
			if(3)
				apply_status_effect(/datum/status_effect/debuff/disease/bonefever)
				to_chat(src, "<span class='warning'>I've contracted bone break fever!</span>")
			if(4)
				apply_status_effect(/datum/status_effect/debuff/disease/collywobbles)
				to_chat(src, "<span class='warning'>I've contracted collywobbles!</span>")
			if(5)
				apply_status_effect(/datum/status_effect/debuff/disease/ataxia)
				to_chat(src, "<span class='warning'>I've contracted ataxia!</span>")
			if(6)
				apply_status_effect(/datum/status_effect/debuff/disease/blackheart)
				to_chat(src, "<span class='warning'>I've contracted black-heart blight!</span>")
			if(7)
				apply_status_effect(/datum/status_effect/debuff/disease/dampworm)
				to_chat(src, "<span class='warning'>I've contracted dampworm!</span>")
			if(8)
				apply_status_effect(/datum/status_effect/debuff/disease/greenspore)
				to_chat(src, "<span class='warning'>I've contracted greenspore!</span>")
			if(9)
				apply_status_effect(/datum/status_effect/debuff/disease/rustchancre)
				to_chat(src, "<span class='warning'>I've contracted rust chancre!</span>")
			if(10)
				apply_status_effect(/datum/status_effect/debuff/disease/swampfever)
				to_chat(src, "<span class='warning'>I've contracted swamp fever!</span>")
			if(11)
				apply_status_effect(/datum/status_effect/debuff/disease/witlesspox)
				to_chat(src, "<span class='warning'>I've contracted witless pox!</span>")
			
			else//Lucky dog
				to_chat(src, "<span class='warning'>My wound burns!</span>")
				disease_threshhold = DISEASE_THRESHHOLD
				disease_rate = 0
				disease_max++
				return
		disease_threshhold = DISEASE_THRESHHOLD

	disease_rate = 0

/mob/living/carbon/proc/get_disease_rate()//Get disease rate from all limbs
	var/dr = 0
	for(var/x in bodyparts)
		var/obj/item/bodypart/limb = x
		dr += limb.get_diseaserate()
	dr = clamp(dr, 0, 20)
	return dr

/obj/item/bodypart/proc/get_diseaserate()//Sum disease rate from wounds
	var/current_dr = 0
	for(var/datum/wound/W in wounds)
		if(W.disease_rate)
			current_dr += W.disease_rate
	if(bandage)//Clean bandage slows, bloody bandage accelerates
		if(!HAS_BLOOD_DNA(bandage))
			current_dr *= 0.3
		else
			current_dr *= 1.2
	return current_dr

/obj/item/bodypart/proc/treat_diseaserate()//Negate infection
	for(var/datum/wound/W in wounds)
		if(W.disease_rate)
			W.disease_rate = 0

/mob/living/carbon/proc/cure_disease()//Fully cured
	disease_rate = 0
	disease_tracker = 0
	disease_max = DISEASE_MAX
	disease_threshhold = DISEASE_THRESHHOLD
	for(var/x in bodyparts)
		var/obj/item/bodypart/limb = x
		limb.treat_diseaserate()
	for(var/x in diseases)
		var/datum/status_effect/debuff/disease/cure = x
		remove_status_effect(cure)

//Debuffs
/obj/screen/alert/status_effect/debuff/disease/
	desc = ""
	icon_state = "disease"

/datum/status_effect/debuff/disease/rattles
	id = "rattles"
	alert_type = /obj/screen/alert/status_effect/debuff/disease/rattles
	effectedstats = list("speed" = -2, "intelligence" = -1, "fortune" = -1)

/obj/screen/alert/status_effect/debuff/disease/rattles
	name = "Rattles"

/datum/status_effect/debuff/disease/bonefever
	id = "bonefever"
	alert_type = /obj/screen/alert/status_effect/debuff/disease/bonefever
	effectedstats = list("endurance" = -1, "strength" = -1, "constituion" = -2)

/obj/screen/alert/status_effect/debuff/disease/bonefever
	name = "Bone Break Fever"

/datum/status_effect/debuff/disease/witbane
	id = "witbane"
	alert_type = /obj/screen/alert/status_effect/debuff/disease/witbane
	effectedstats = list("intelligence" = -2, "perception" = -1, "fortune" = -1)

/obj/screen/alert/status_effect/debuff/disease/witbane
	name = "Witbane"

/datum/status_effect/debuff/disease/collywobbles
	id = "collywobbles"
	alert_type = /obj/screen/alert/status_effect/debuff/disease/collywobbles
	effectedstats = list("endurance" = -3, "strength" = -1)

/obj/screen/alert/status_effect/debuff/disease/collywobbles
	name = "Collywobbles"

/datum/status_effect/debuff/disease/ataxia
	id = "ataxia"
	alert_type = /obj/screen/alert/status_effect/debuff/disease/ataxia
	effectedstats = list("speed" = -2, "strength" = -2)

/obj/screen/alert/status_effect/debuff/disease/ataxia
	name = "Ataxia"

/datum/status_effect/debuff/disease/blackheart
	id = "blackheart"
	alert_type = /obj/screen/alert/status_effect/debuff/disease/blackheart
	effectedstats = list("strength" = -1, "endurance" = -2, "fortune" = -1)

/obj/screen/alert/status_effect/debuff/disease/blackheart
	name = "Black-Heart Blight"

/datum/status_effect/debuff/disease/dampworm
	id = "dampworm"
	alert_type = /obj/screen/alert/status_effect/debuff/disease/dampworm
	effectedstats = list("speed" = -2, "constitution" = -1, "intelligence" = -1)

/obj/screen/alert/status_effect/debuff/disease/dampworm
	name = "Dampworm"

/datum/status_effect/debuff/disease/greenspore
	id = "greenspore"
	alert_type = /obj/screen/alert/status_effect/debuff/disease/rattles
	effectedstats = list("constitution" = -3, "speed" = -1)

/obj/screen/alert/status_effect/debuff/disease/greenspore
	name = "Rattles"

/datum/status_effect/debuff/disease/rustchancre
	id = "rustchancre"
	alert_type = /obj/screen/alert/status_effect/debuff/disease/rustchancre
	effectedstats = list("speed" = -2, "constitution" = -1, "endurance" = -1)

/obj/screen/alert/status_effect/debuff/disease/rustchancre
	name = "Rust Chancre"

/datum/status_effect/debuff/disease/swampfever
	id = "swampfever"
	alert_type = /obj/screen/alert/status_effect/debuff/disease/swampfever
	effectedstats = list("strength" = -2, "endurance" = -2)

/obj/screen/alert/status_effect/debuff/disease/swampfever
	name = "Swamp Fever"

/datum/status_effect/debuff/disease/witlesspox
	id = "witlesspox"
	alert_type = /obj/screen/alert/status_effect/debuff/disease/witlesspox
	effectedstats = list("intelligence" = -3, "fortune" = -1)

/obj/screen/alert/status_effect/debuff/disease/witlesspox
	name = "Witless Pox"
