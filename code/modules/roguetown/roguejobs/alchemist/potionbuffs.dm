/datum/status_effect/buff/strengthpot
	id = "hungryt2"
	alert_type = /obj/screen/alert/status_effect/buff/strengthpot
	effectedstats = list("strength" = 3)
	duration = rand(18,30) SECONDS

/obj/screen/alert/status_effect/buff/strengthpot
	name = "Strength"
	desc = "Power rushes through your veins."
	icon_state = "hunger2"

/datum/status_effect/buff/intelligencepot
	id = "hungryt3"
	alert_type = /obj/screen/alert/status_effect/buff/intelligencepot
	effectedstats = list("intelligence" = 3)
	duration = rand(180,300) SECONDS

/obj/screen/alert/status_effect/buff/intelligencepot
	name = "Intelligence"
	desc = "Power rushes through your veins."
	icon_state = "hunger3"



/*
/datum/status_effect/buff/foodbuff
	id = "foodbuff"
	alert_type = /obj/screen/alert/status_effect/buff/foodbuff
	effectedstats = list("constitution" = 1,"endurance" = 1)
	duration = 10 MINUTES

/datum/status_effect/buff/foodbuff/on_apply()
	owner.add_stress(/datum/stressevent/goodfood)
	return ..()

/obj/screen/alert/status_effect/buff/foodbuff
	name = "Great Meal"
	desc = ""
	icon_state = "foodbuff"*/
