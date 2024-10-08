/mob/living/carbon/human
	var/datum/charflaw/charflaw

/mob/proc/sate_addiction()
	return

/mob/living/carbon/human/sate_addiction()
	if(istype(charflaw, /datum/charflaw/addiction))
		var/datum/charflaw/addiction/A = charflaw
		remove_stress(list(/datum/stressevent/vice,/datum/stressevent/vice2,/datum/stressevent/vice3))
		A.sated = TRUE
		A.satefail = 0
		A.time = initial(A.time) //reset roundstart sate offset to standard
		A.next_sate = world.time + 15 MINUTES

/datum/charflaw/addiction
	var/next_sate = 0
	var/sated = TRUE
	var/time = 15 MINUTES
	var/debuff //so heroin junkies can have big problems
	var/needsate_text
	var/satefail = 0

/datum/charflaw/addiction/New()
	..()
	time = 15 MINUTES
	next_sate = world.time + time


/datum/charflaw/addiction/flaw_on_life(mob/user)
	if(!ishuman(user))
		return
	if(user.mind.antag_datums)
		for(var/datum/antagonist/D in user.mind.antag_datums)
			if(istype(D, /datum/antagonist/vampirelord) || istype(D, /datum/antagonist/werewolf) || istype(D, /datum/antagonist/skeleton) || istype(D, /datum/antagonist/zombie))
				return
	var/mob/living/carbon/human/H = user
	var/oldsated = sated
	if(oldsated)
		if(next_sate)
			if(world.time > next_sate)
				sated = FALSE
				next_sate = world.time + time
	if(sated != oldsated)
		if(needsate_text)
			satefail++
			to_chat(user, "[needsate_text]")

	if(!sated && (world.time > next_sate))
		next_sate = world.time + time
		switch(satefail)
			if(1)
				H.add_stress(/datum/stressevent/vice)
				to_chat(user, "<span class='warning'>Enough of this. [needsate_text]</span>")
			if(2)
				H.remove_stress(/datum/stressevent/vice)
				H.add_stress(/datum/stressevent/vice2)
				to_chat(user, "<span class='warning'>It gets worse by the moment... [desc]</span>")
			if(3)
				H.remove_stress(/datum/stressevent/vice2)
				H.add_stress(/datum/stressevent/vice3)
				to_chat(user, "<span class='warning'>The smell of sweat on my skin makes me sick, my heart is weak. [needsate_text]</span>")
			if(4 to 10)
				H.remove_stress(/datum/stressevent/vice3)
				H.heart_attack()
				H.add_stress(/datum/stressevent/vice3)
				to_chat(user, "<span class='warning'>[needsate_text]</span>")
		satefail++
		if(debuff)
			H.apply_status_effect(debuff)

/datum/status_effect/debuff/addiction
	id = "addiction"
	alert_type = /obj/screen/alert/status_effect/debuff/addiction
	effectedstats = list("endurance" = -1,"fortune" = -1)
	duration = 100


/obj/screen/alert/status_effect/debuff/addiction
	name = "Addiction"
	desc = ""
	icon_state = "debuff"


/// ALCOHOLIC

/datum/charflaw/addiction/alcoholic
	name = "Alcoholic"
	desc = "Drinking alcohol is my favorite thing."
	time = 2 MINUTES
	needsate_text = "Time for a drink."


/// JUNKIE

/datum/charflaw/addiction/junkie
	name = "Junkie"
	desc = "I need a real high to take the pain of this rotten world away."
	time = 2 MINUTES
	needsate_text = "Time to reach a new high."

/// Smoker

/datum/charflaw/addiction/smoker
	name = "Smoker"
	desc = "I need to smoke something to take the edge off."
	time = 2 MINUTES
	needsate_text = "Time for a flavorful smoke."

/// GOD-FEARING

/datum/charflaw/addiction/godfearing
	name = "Devout Follower"
	desc = "I need to pray to the Divine."
	time = 2 MINUTES
	needsate_text = "Time to pray."
