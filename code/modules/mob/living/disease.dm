/****************************************************
				DISEASE MODULE
****************************************************/
/mob/living/carbon/proc/handle_disease()
	if(disease_max <= 0)//Already have 2 diseases
		return

	disease_rate = get_disease_rate()
	disease_threshhold -= max(disease_rate, 0)
	if((disease_threshhold <= 0))//Once infection builds up
		disease_max--

		var/rtd = rand(1,4)
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
	remove_status_effect(/datum/status_effect/debuff/disease/rattles)
	remove_status_effect(/datum/status_effect/debuff/disease/witbane)
	remove_status_effect(/datum/status_effect/debuff/disease/bonefever)
	remove_status_effect(/datum/status_effect/debuff/disease/collywobbles)

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
	effectedstats = list("speed" = -1, "strength" = -1, "constituion" = -2)

/obj/screen/alert/status_effect/debuff/disease/bonefever
	name = "Bone Break Fever"

/datum/status_effect/debuff/disease/witbane
	id = "witbane"
	alert_type = /obj/screen/alert/status_effect/debuff/disease/witbane
	effectedstats = list("intelligence" = -2, "fortune" = -1)

/obj/screen/alert/status_effect/debuff/disease/witbane
	name = "Witbane"

/datum/status_effect/debuff/disease/collywobbles
	id = "collywobbles"
	alert_type = /obj/screen/alert/status_effect/debuff/disease/collywobbles
	effectedstats = list("endurance" = -2, "strength" = -1)

/obj/screen/alert/status_effect/debuff/disease/collywobbles
	name = "Collywobbles"
