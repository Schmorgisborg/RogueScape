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
		M.transform *= 0.4
		I.pixel_x = 0
		M.pixel_y = 8
		add_overlay(M)

/obj/machinery/plinth/proc/shock_cycle()
	var/closest_dist = 0
	var/obj/machinery/etcher/closest_etcher
	var/static/things_to_shock = /obj/machinery/etcher

	for(var/A in oview(src, 5))
		if(istype(A, /obj/machinery/etcher))
			var/dist = get_dist(src, A)
			var/obj/machinery/etcher/C = A
			if(dist <= 5 && (dist < closest_dist || !closest_etcher))
				closest_dist = dist
				closest_etcher = C

	if(closest_etcher)
		src.Beam(closest_etcher, icon_state="lightning[rand(1,12)]", time=5, maxdistance = INFINITY)
		var/zapdir = get_dir(src, closest_etcher)
		if(zapdir)
			. = zapdir



//?		shock_victim.electrocute_act(20, src, 1)


