/datum/martial_art/resting_rous
	name = "Resting Rous"
	id = MARTIALART_RESTINGROUS
	allow_temp_override = FALSE
//	help_verb = /mob/living/carbon/human/proc/resting_rous_help
	smashes_tables = TRUE
//	var/old_grab_state = null

/datum/martial_art/resting_rous/on_projectile_hit(mob/living/carbon/human/A, obj/projectile/P, def_zone)
	. = ..()
	if(A.incapacitated(FALSE, TRUE)) //NO STUN
		return BULLET_ACT_HIT
	if(!(A.mobility_flags & MOBILITY_USE)) //NO UNABLE TO USE
		return BULLET_ACT_HIT
	if(!isturf(A.loc)) //NO MOTHERFLIPPIN MECHS!
		return BULLET_ACT_HIT
	A.visible_message("<span class='danger'>[A] deflects [P]!</span>", "<span class='danger'>I deflect [P]!</span>")
	playsound(src, pick('sound/blank.ogg'), 75, TRUE)
	P.firer = A
	P.setAngle(rand(0, 360))//SHING
	return BULLET_ACT_FORCE_PIERCE

/datum/martial_art/resting_rous/teach(mob/living/carbon/human/H, make_temporary = FALSE)
	. = ..()
	if(!.)
		return
	ADD_TRAIT(H, TRAIT_NOGUNS, RESTING_ROUS_TRAIT)

/datum/martial_art/resting_rous/on_remove(mob/living/carbon/human/H)
	. = ..()
	REMOVE_TRAIT(H, TRAIT_NOGUNS, RESTING_ROUS_TRAIT)