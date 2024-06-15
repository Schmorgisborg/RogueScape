/****************************************************
				DISEASE MODULE
****************************************************/
/mob/living
	var/list/is_diseased = list()

/mob/living/proc/update_disease_rate()
	var/newdr = 0
	for(var/datum/wound/W in is_diseased)
		newdr += W.disease_rate
		to_chat(src, "<span class='danger'>wound specific rate [W.disease_rate]</span>")
	return newdr

/mob/living/proc/handle_disease()
	disease_rate = update_disease_rate()
	disease_threshhold -= max(disease_rate, 0)
	to_chat(src, "<span class='warning'>dis rate [disease_rate]</span>")
	if(!disease_rate)
		return
/*	if(disease_threshhold <= 0)
		var/disease_holder = world.time + DISEASE_TIMER
		to_chat(src, "<span class='warning'>It BREATHES!</span>")
		if(prob(disease_rate*10) & (disease_holder < world.time))*/
	var/rtd = rand(1,4)
	if(contracted_diseases[rtd])
		return
	contracted_diseases[rtd] += 1
	switch(rtd)
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


/mob/living/proc/cure_disease()
	del(contracted_diseases)
	disease_rate = 0
	disease_threshhold = DISEASE_THRESHHOLD
	remove_status_effect(/datum/status_effect/debuff/rattles)
	remove_status_effect(/datum/status_effect/debuff/witbane)
	remove_status_effect(/datum/status_effect/debuff/bonefever)
	remove_status_effect(/datum/status_effect/debuff/collywobbles)
