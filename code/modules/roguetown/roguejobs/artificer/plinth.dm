/obj/machinery/plinth
	icon = 'icons/roguetown/misc/forge.dmi'
	name = "plinth"
	icon_state = "plinth"
	var/obj/item/rune/plinth_item
	max_integrity = 500
	density = TRUE
	climbable = TRUE

/obj/machinery/plinth/attackby(obj/item/I, mob/living/user, params)
	if(istype(I, /obj/item/rune) && !plinth_item)//must go after hammer after we get there
		plinth_item = I
		plinth_item.forceMove(src)
		update_icon()
		return
	..()

/obj/machinery/plinth/attack_hand(mob/user, params)
	if(plinth_item)
		var/obj/item/I = plinth_item
		plinth_item = null
		I.loc = user.loc
		user.put_in_active_hand(I)
		update_icon()
	..()

/obj/machinery/plinth/update_icon()
	cut_overlays()
	if(plinth_item)
		var/obj/item/I = plinth_item
		I.pixel_x = 0
		I.pixel_y = 0
		var/mutable_appearance/M = new /mutable_appearance(I)
		M.transform *= 0.5
		add_overlay(M)
