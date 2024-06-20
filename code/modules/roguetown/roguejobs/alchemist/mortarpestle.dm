/obj/item
	var/dust_result =  //  check if it can be used by the mortar/pestle.

/obj/structure/mortarpestle
	name = "mortar and pestle"
	desc = ""
	icon = 'icons/roguetown/misc/structure.dmi'
	icon_state = "millstone"
	density = TRUE
	anchored = TRUE
	blade_dulling = DULLING_BASH
	max_integrity = 100

/obj/structure/mortarpestle/attackby(obj/item/I, mob/living/user, params)
	if(I.dust_result)
		playsound(loc, 'sound/foley/scribble.ogg', 100, FALSE)
		if(do_after(user, 10, target = src))
			new S.dust_result(get_turf(loc))
			qdel(S)
		return
	..()
