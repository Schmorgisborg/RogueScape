/obj/structure/telescope
	name = "telescope"
	desc = "A mysterious telescope pointing towards the stars."
	icon = 'icons/roguetown/misc/structure.dmi'
	icon_state = "telescope"
	density = TRUE
	anchored = FALSE

/obj/structure/telescope/attack_hand(mob/user)
	if(!ishuman(user))
		return

	var/mob/living/carbon/human/H = user
	var/random_message = pick("You can see the moon rotating.", "Looking at the image of Psydon blinds you!", "The stars smile at you.", "Nepolx is red today.", "Blessed yellow strife.", "You see a star!")
	to_chat(H, "<span class='notice'>[random_message]</span>")

	if(random_message == "Looking at the image of Psydon blinds you!")
		if(do_after(H, 25, target = src))
			var/obj/item/bodypart/affecting = H.get_bodypart("head")
			to_chat(H, "<span class='warning'>The blinding light causes you intense pain!</span>")
			if(affecting && affecting.receive_damage(0, 5))
				H.update_damage_overlays()


/obj/structure/globe
	name = "globe"
	desc = "A mysterious globe representing the world."
	icon = 'icons/roguetown/misc/structure.dmi'
	icon_state = "globe"
	density = TRUE
	anchored = FALSE

/obj/structure/globe/attack_hand(mob/user)
	if(!ishuman(user))
		return

	var/mob/living/carbon/human/H = user
	var/random_message = pick("you spin the globe!", "You land on mountains!", "You land on forests!", "You land on an ocean.", "You land on an ocean.", "You land on a peculiar landmark!")
	to_chat(H, "<span class='notice'>[random_message]</span>")
