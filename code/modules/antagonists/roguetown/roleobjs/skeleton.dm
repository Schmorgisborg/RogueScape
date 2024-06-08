
/datum/antagonist/skeleton
	name = "Skeleton"
	increase_votepwr = FALSE

/datum/antagonist/skeleton/examine_friendorfoe(datum/antagonist/examined_datum,mob/examiner,mob/examined)
	if(istype(examined_datum, /datum/antagonist/vampirelord))
		var/datum/antagonist/vampirelord/V = examined_datum
		if(!V.disguised)
			return "<span class='boldnotice'>Another deadite.</span>"
	if(istype(examined_datum, /datum/antagonist/zombie))
		return "<span class='boldnotice'>Another deadite.</span>"
	if(istype(examined_datum, /datum/antagonist/skeleton))
		return "<span class='boldnotice'>Another deadite. My ally.</span>"

/datum/antagonist/skeleton/on_gain()
	if(!(locate(/datum/objective/skeleton) in objectives))
		var/datum/objective/skeleton/winObjective = new
		winObjective.owner = owner
		objectives += winObjective
		return
	return ..()

/datum/antagonist/skeleton/on_removal()
	return ..()


/datum/antagonist/skeleton/greet()
	owner.announce_objectives()
	..()

/datum/antagonist/skeleton/roundend_report()
	return
	var/traitorwin = FALSE

	if(objectives.len)//If the traitor had no objectives, don't need to process this.
		for(var/datum/objective/objective in objectives)
			objective.update_explanation_text()
			if(objective.check_completion())
				traitorwin = TRUE

	if(traitorwin)
		owner.adjust_triumphs(1)
		owner.current.playsound_local(get_turf(owner.current), 'sound/misc/triumph.ogg', 100, FALSE, pressure_affected = FALSE)
		to_chat("<span class='big bold'>WIN.</span>")
	else
		owner.current.playsound_local(get_turf(owner.current), 'sound/misc/fail.ogg', 100, FALSE, pressure_affected = FALSE)
		to_chat("<span class='big bold'>LOSS.</span>")
