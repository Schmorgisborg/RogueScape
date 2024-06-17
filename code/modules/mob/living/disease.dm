/****************************************************
				DISEASE MODULE
****************************************************/
/mob/living/proc/update_disease_rate()//Check wounds for disease rate; add it to newdr
	get_disease_rate()
	var/newdr = 0
	for(var/datum/wound/W in simple_wounds)
		newdr += W.disease_rate
		
	return newdr

/mob/living/carbon/proc/get_disease_rate()//Copy disease rate from body parts
	var/dr = 0
	for(var/x in bodyparts)
		var/obj/item/bodypart/limb = x
		dr += limb.get_diseaserate()
		to_chat(src, "<span class='danger'>limb specific rate [limb.disease_rate]</span>")
	return dr

//Main proc
/mob/living/proc/handle_disease()
	if(disease_max <= 0)
		return
	if(last_disease_time > (world.time - 2 MINUTES))
		return

	disease_rate = get_disease_rate()
	to_chat(src, "<span class='warning'>dis rate [disease_rate]</span>")
	if(!disease_rate)
		return

	disease_threshhold -= max(disease_rate, 0)
	if(disease_threshhold <= 0)
		to_chat(src, "<span class='warning'>It BREATHES!</span>")
		var/rtd = rand(1,4)
		disease_max--
		switch(rtd)//disease_threshhold <= 0
			if(1)
				apply_status_effect(/datum/status_effect/debuff/rattles)
				to_chat(src, "<span class='warning'>I've contracted rattles!</span>")
			if(2)
				apply_status_effect(/datum/status_effect/debuff/witbane)
				to_chat(src, "<span class='warning'>I've contracted witbane!</span>")
			if(3)
				apply_status_effect(/datum/status_effect/debuff/bonefever)
				to_chat(src, "<span class='warning'>I've contracted bone break fever!</span>")
			if(4)
				apply_status_effect(/datum/status_effect/debuff/collywobbles)
				to_chat(src, "<span class='warning'>I've contracted collywobbles!</span>")

	last_disease_time = world.time
	disease_rate = 0
	
/mob/living/proc/cure_disease()
	disease_rate = 0
	disease_max = DISEASE_MAX
	disease_threshhold = DISEASE_THRESHHOLD
	remove_status_effect(/datum/status_effect/debuff/rattles)
	remove_status_effect(/datum/status_effect/debuff/witbane)
	remove_status_effect(/datum/status_effect/debuff/bonefever)
	remove_status_effect(/datum/status_effect/debuff/collywobbles)
