/obj/item/ash
	name = "ash"
	icon = 'icons/obj/objects.dmi'
	icon_state = "ash"
	possible_item_intents = list(/datum/intent/use)
	w_class = WEIGHT_CLASS_TINY

/obj/item/ash/attack(mob/living/M, mob/user)
	testing("attack")
	treat(M, user)

/obj/item/ash/proc/treat(mob/living/M, mob/user)
	if(!M.can_inject(user, TRUE))
		return
	if(!ishuman(M))
		return
	var/mob/living/carbon/human/H = M
	var/obj/item/bodypart/affecting = H.get_bodypart(check_zone(user.zone_selected))
	if(!affecting)
		return
	if(!get_location_accessible(H, check_zone(user.zone_selected)))
		to_chat(user, "<span class='warning'>Something in the way.</span>")
		return
	if(affecting.bandage)
		to_chat(user, "<span class='warning'>A bandage is blocking the limb.</span>")
		return
	var/used_time = 35
	if(H.mind)
		used_time -= (H.mind.get_skill_level(/datum/skill/misc/medicine) * 4)
	playsound(loc, 'sound/foley/bandage.ogg', 100, FALSE)
	if(!do_mob(user, M, used_time))
		return

	user.dropItemToGround(src)
	qdel(src)
	affecting.treat_diseaserate()

	var/bodypart_name = replacetext("[affecting]", "the ", "")
	if(M == user)
		user.visible_message("<span class='notice'>[user] treats [user.p_their()] [bodypart_name].</span>", "<span class='notice'>I treat my [bodypart_name].</span>")
	else
		user.visible_message("<span class='notice'>[user] treats [M]'s [bodypart_name].</span>", "<span class='notice'>I treat [M]'s [bodypart_name].</span>")

/obj/item/ash/Crossed(mob/living/L)
	. = ..()
	if(istype(L))
		var/prob2break = 33
		if(L.m_intent == MOVE_INTENT_SNEAK)
			prob2break = 0
		if(L.m_intent == MOVE_INTENT_RUN)
			prob2break = 100
		if(prob(prob2break))
			qdel(src)
