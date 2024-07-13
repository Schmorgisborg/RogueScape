/obj/machinery/plinth
	icon = 'icons/roguetown/misc/forge.dmi'
	name = "plinth"
	icon_state = "plinth"
	var/obj/item/rune/plinth_item
	max_integrity = 500
	density = TRUE
	climbable = TRUE

/obj/machinery/plinth/attackby(obj/item/I, mob/living/user, params)
	if(istype(I, /obj/item/rune) && !plinth_item)
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

/obj/machinery/plinth/proc/shock_cycle(obj/machinery/etcher/E)
	var/obj/projectile/P = new /obj/projectile/magic/lightning(src.loc)
	P.damage = 50
	var/angle = round(Get_Angle(src,E))
	P.fire(angle)

/obj/machinery/plinth/proc/bad_rune()
	var/obj/item/I = plinth_item
	I.loc = src.loc
	plinth_item = null
	qdel(I)
	update_icon()

/datum/crafting_recipe/roguetown/plinth
	name = "etcher"
	result = /obj/machinery/plinth
	reqs = list(/obj/item/grown/log/tree/small = 2)
	verbage = "crafts"
	time = 50
	craftsound = 'sound/foley/Building-01.ogg'
	skillcraft = /datum/skill/craft/masonry
