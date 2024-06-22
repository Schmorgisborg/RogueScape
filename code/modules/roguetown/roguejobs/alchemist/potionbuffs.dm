/obj/screen/alert/status_effect/buff/alch
	desc = "Power rushes through your veins."
	icon_state = "fortifystat"

/datum/status_effect/buff/alch/strengthpot
	id = "strpot"
	alert_type = /obj/screen/alert/status_effect/buff/alch/strengthpot
	effectedstats = list("strength" = 3)
	duration = 10 SECONDS

/obj/screen/alert/status_effect/buff/alch/strengthpot
	name = "Strength"

/datum/status_effect/buff/alch/intelligencepot
	id = "intpot"
	alert_type = /obj/screen/alert/status_effect/buff/alch/intelligencepot
	effectedstats = list("intelligence" = 3)
	duration = 10 SECONDS

/obj/screen/alert/status_effect/buff/alch/intelligencepot
	name = "Intelligence"

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
