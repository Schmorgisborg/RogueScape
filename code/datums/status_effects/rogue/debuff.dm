/datum/status_effect/debuff
	status_type = STATUS_EFFECT_REFRESH

///////////////////////////

/datum/status_effect/debuff/hungryt1
	id = "hungryt1"
	alert_type = /obj/screen/alert/status_effect/debuff/hungryt1
	effectedstats = list("strength" = -1, "endurance" = -1)
	duration = 100

/obj/screen/alert/status_effect/debuff/hungryt1
	name = "Peckish"
	desc = "<span class='warning'>Hunger exists only in the mind of the living.</span>\n"
	icon_state = "hunger1"

/datum/status_effect/debuff/hungryt1/on_apply()
	. = ..()
	if(iscarbon(owner))
		var/mob/living/carbon/C = owner
		to_chat(C, "<span class='info'>My stomach is rumbling.</span>")
		C.remove_stress(list(/datum/stressevent/hungry,/datum/stressevent/starving))
		C.add_stress(/datum/stressevent/peckish)

/datum/status_effect/debuff/hungryt1/on_remove()
	. = ..()
	if(iscarbon(owner))
		var/mob/living/carbon/C = owner
		C.remove_stress(/datum/stressevent/peckish)

/datum/status_effect/debuff/hungryt2
	id = "hungryt2"
	alert_type = /obj/screen/alert/status_effect/debuff/hungryt2
	effectedstats = list("speed" = -1,"strength" = -2, "endurance" = -2)
	duration = 100

/obj/screen/alert/status_effect/debuff/hungryt2
	name = "Famished"
	desc = "<span class='warning'>My stomach is hurting.</span>\n"
	icon_state = "hunger2"

/datum/status_effect/debuff/hungryt2/on_apply()
	. = ..()
	if(iscarbon(owner))
		var/mob/living/carbon/C = owner
		to_chat(C, "<span class='warning'>My stomach is starting to hurt.</span>")
		C.remove_stress(list(/datum/stressevent/peckish,/datum/stressevent/starving))
		C.add_stress(/datum/stressevent/hungry)

/datum/status_effect/debuff/hungryt2/on_remove()
	. = ..()
	if(iscarbon(owner))
		var/mob/living/carbon/C = owner
		C.remove_stress(/datum/stressevent/hungry)

/datum/status_effect/debuff/hungryt3
	id = "hungryt3"
	alert_type = /obj/screen/alert/status_effect/debuff/hungryt3
	effectedstats = list("speed" = -2,"strength" = -4, "endurance" = -4, "constitution" = -2)
	duration = 100
	var/start_starve
	var/next_check = 0

/obj/screen/alert/status_effect/debuff/hungryt3
	name = "STARVING"
	desc = "<span class='boldwarning'>I AM STARVING!</span>\n"
	icon_state = "hunger3"

/datum/status_effect/debuff/hungryt3/on_apply()
	. = ..()
	if(iscarbon(owner))
		var/mob/living/carbon/C = owner
		to_chat(C, "<span class='danger'>I'm weak from hunger, I feel like I'm dying.</span>")
		C.remove_stress(list(/datum/stressevent/hungry,/datum/stressevent/peckish))
		C.add_stress(/datum/stressevent/starving)
		start_starve = world.time
		START_PROCESSING(SSprocessing, src)

/datum/status_effect/debuff/hungryt3/process()
	if(next_check > world.time)
		return
	if(prob(95))
		return
	var/starved = world.time - start_starve
	switch(starved)
		if(5 MINUTES to 30 MINUTES)
			to_chat(owner, "<span class=warning>I'm dying of hunger.")
			owner.adjustBruteLoss(10)
		if(30 MINUTES to 60 MINUTES)
			owner.adjustBruteLoss(30)
			if(ishuman(owner) || prob(50))
				var/mob/living/carbon/human/H = owner
				H.heart_attack()
	next_check = world.time + 5 MINUTES

/datum/status_effect/debuff/hungryt3/on_remove()
	. = ..()
	if(iscarbon(owner))
		var/mob/living/carbon/C = owner
		C.remove_stress(/datum/stressevent/starving)
		START_PROCESSING(SSprocessing, src)

////////////////////


/datum/status_effect/debuff/thirstyt1
	id = "thirsty1"
	alert_type = /obj/screen/alert/status_effect/debuff/thirstyt1
	effectedstats = list("endurance" = -1)
	duration = 100

/obj/screen/alert/status_effect/debuff/thirstyt1
	name = "Dry Mouth"
	desc = "<span class='warning'>I could use a drink.</span>\n"
	icon_state = "thirst1"


/datum/status_effect/debuff/thirstyt1/on_apply()
	. = ..()
	if(iscarbon(owner))
		var/mob/living/carbon/C = owner
		to_chat(C, "<span class='info'>I could use a drink.</span>")
		C.remove_stress(list(/datum/stressevent/thirst,/datum/stressevent/parched))
		C.add_stress(/datum/stressevent/drym)

/datum/status_effect/debuff/thirstyt1/on_remove()
	. = ..()
	if(iscarbon(owner))
		var/mob/living/carbon/C = owner
		C.remove_stress(/datum/stressevent/drym)

/datum/status_effect/debuff/thirstyt2
	id = "thirsty2"
	alert_type = /obj/screen/alert/status_effect/debuff/thirstyt2
	effectedstats = list("endurance" = -2, "speed" = -1)
	duration = 100

/obj/screen/alert/status_effect/debuff/thirstyt2
	name = "Parched"
	desc = "<span class='warning'>I desperately need a drink.</span>\n"
	icon_state = "thirst2"

/datum/status_effect/debuff/thirstyt2/on_apply()
	. = ..()
	if(iscarbon(owner))
		var/mob/living/carbon/C = owner
		to_chat(C, "<span class='warning'>I desperately need a drink.</span>")
		C.remove_stress(list(/datum/stressevent/drym,/datum/stressevent/parched))
		C.add_stress(/datum/stressevent/thirst)

/datum/status_effect/debuff/thirstyt2/on_remove()
	. = ..()
	if(iscarbon(owner))
		var/mob/living/carbon/C = owner
		C.remove_stress(/datum/stressevent/thirst)

/datum/status_effect/debuff/thirstyt3
	id = "thirsty3"
	alert_type = /obj/screen/alert/status_effect/debuff/thirstyt3
	effectedstats = list("strength" = -2, "speed" = -2, "endurance" = -3)
	duration = 100
	var/start_thirst
	var/next_check

/obj/screen/alert/status_effect/debuff/thirstyt3
	name = "Dehydration"
	desc = "<span class='boldwarning'>I AM DYING OF THIRST!</span>\n"
	icon_state = "thirst3"

/datum/status_effect/debuff/thirstyt3/on_apply()
	. = ..()
	if(iscarbon(owner))
		var/mob/living/carbon/C = owner
		to_chat(C, "<span class='danger'>I can barely swallow, I'm dizzy from dehydration.</span>")
		C.remove_stress(list(/datum/stressevent/thirst,/datum/stressevent/drym))
		C.add_stress(/datum/stressevent/parched)
		start_thirst = world.time
		START_PROCESSING(SSprocessing, src)

/datum/status_effect/debuff/thirstyt3/process()
	if(next_check > world.time)
		return
	if(prob(95))
		return
	var/thirsty = world.time - start_thirst
	switch(thirsty)
		if(5 MINUTES to 30 MINUTES)
			to_chat(owner, "<span class=warning>I'm dying of thirst.")
			owner.adjustBruteLoss(10)
		if(30 MINUTES to 60 MINUTES)
			owner.adjustBruteLoss(30)
			if(ishuman(owner) && prob(50))
				var/mob/living/carbon/human/H = owner
				H.heart_attack()
	next_check = world.time + 5 MINUTES

/datum/status_effect/debuff/thirstyt3/on_remove()
	. = ..()
	if(iscarbon(owner))
		var/mob/living/carbon/C = owner
		C.remove_stress(/datum/stressevent/parched)

/*


/datum/status_effect/debuff/hungryt1
	id = "hungryt1"
	alert_type = /obj/screen/alert/status_effect/debuff/hungryt1
	effectedstats = list("strength" = -1, "constitution" = -1)
	duration = 90 MINUTES

/obj/screen/alert/status_effect/debuff/hungryt1
	name = "Hungry"
	desc = "Hunger exists only in the mind of the living."
	icon_state = "hunger1"

/datum/status_effect/debuff/hungryt2
	id = "hungryt2"
	alert_type = /obj/screen/alert/status_effect/debuff/hungryt2
	effectedstats = list("strength" = -3, "constitution" = -2, "endurance" = -1)
	duration = 90 MINUTES

/obj/screen/alert/status_effect/debuff/hungryt2
	name = "Hungry"
	desc = "Hunger exists only in the mind of the living."
	icon_state = "hunger2"

/datum/status_effect/debuff/hungryt3
	id = "hungryt3"
	alert_type = /obj/screen/alert/status_effect/debuff/hungryt3
	effectedstats = list("strength" = -6, "constitution" = -3, "endurance" = -2)
	duration = 90 MINUTES

/obj/screen/alert/status_effect/debuff/hungryt3
	name = "Hungry"
	desc = "Hunger exists only in the mind of the living."
	icon_state = "hunger3"

////////////////////

/datum/status_effect/debuff/thirstyt1
	id = "thirsty"
	alert_type = /obj/screen/alert/status_effect/debuff/thirstyt1
	effectedstats = list("endurance" = -1)
	duration = 90 MINUTES

/obj/screen/alert/status_effect/debuff/thirstyt1
	name = "Thirsty"
	desc = "I need water."
	icon_state = "thirst1"

/datum/status_effect/debuff/thirstyt2
	id = "thirsty"
	alert_type = /obj/screen/alert/status_effect/debuff/thirstyt2
	effectedstats = list("speed" = -1, "endurance" = -2)
	duration = 90 MINUTES

/obj/screen/alert/status_effect/debuff/thirstyt2
	name = "Thirsty"
	desc = "I need water."
	icon_state = "thirst2"

/datum/status_effect/debuff/thirstyt3
	id = "thirsty"
	alert_type = /obj/screen/alert/status_effect/debuff/thirstyt3
	effectedstats = list("strength" = -1, "speed" = -4, "endurance" = -4)
	duration = 90 MINUTES

/obj/screen/alert/status_effect/debuff/thirstyt3
	name = "Thirsty"
	desc = "I need water."
	icon_state = "thirst3"

*/////////

/datum/status_effect/debuff/uncookedfood
	id = "uncookedfood"
	effectedstats = null
	duration = 1

/datum/status_effect/debuff/uncookedfood/on_apply()
	if(iscarbon(owner))
		var/mob/living/carbon/C = owner
		C.add_nausea(100)
	return ..()

/datum/status_effect/debuff/badmeal
	id = "badmeal"
	effectedstats = null
	duration = 1

/datum/status_effect/debuff/badmeal/on_apply()
	owner.add_stress(/datum/stressevent/badmeal)
	return ..()

/datum/status_effect/debuff/burnedfood
	id = "burnedfood"
	effectedstats = null
	duration = 1

/datum/status_effect/debuff/burnedfood/on_apply()
	owner.add_stress(/datum/stressevent/burntmeal)
	if(iscarbon(owner))
		var/mob/living/carbon/C = owner
		C.add_nausea(100)
	return ..()

/datum/status_effect/debuff/rotfood
	id = "rotfood"
	effectedstats = null
	duration = 1

/datum/status_effect/debuff/rotfood/on_apply()
	owner.add_stress(/datum/stressevent/rotfood)
	if(iscarbon(owner))
		var/mob/living/carbon/C = owner
		C.add_nausea(200)
	return ..()

/datum/status_effect/debuff/bleeding
	id = "bleedingt1"
	alert_type = /obj/screen/alert/status_effect/debuff/bleedingt1
	effectedstats = list("speed" = -1)
	duration = 100

/obj/screen/alert/status_effect/debuff/bleedingt1
	name = "Dizzy"
	desc = ""
	icon_state = "bleed1"

/datum/status_effect/debuff/bleedingworse
	id = "bleedingt2"
	alert_type = /obj/screen/alert/status_effect/debuff/bleedingt2
	effectedstats = list("strength" = -1, "speed" = -2)
	duration = 100

/obj/screen/alert/status_effect/debuff/bleedingt2
	name = "Faint"
	desc = ""
	icon_state = "bleed2"

/datum/status_effect/debuff/bleedingworst
	id = "bleedingt3"
	alert_type = /obj/screen/alert/status_effect/debuff/bleedingt3
	effectedstats = list("strength" = -3, "speed" = -4)
	duration = 100

/obj/screen/alert/status_effect/debuff/bleedingt3
	name = "Drained"
	desc = ""
	icon_state = "bleed3"

/datum/status_effect/debuff/sleepytime
	id = "sleepytime"
	alert_type = /obj/screen/alert/status_effect/debuff/sleepytime
	effectedstats = list("speed" = -1, "endurance" = -1, "fortune" = -1)

/obj/screen/alert/status_effect/debuff/sleepytime
	name = "Tired"
	desc = ""
	icon_state = "sleepy"

/datum/status_effect/debuff/trainsleep
	id = "trainsleep"
	alert_type = /obj/screen/alert/status_effect/debuff/trainsleep
	effectedstats = list("strength" = -1, "endurance" = -1)

/obj/screen/alert/status_effect/debuff/trainsleep
	name = "Muscle Soreness"
	desc = ""
	icon_state = "muscles"
