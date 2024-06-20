/obj/item
	var/dust_result//  check if it can be used by the mortar/pestle.

/obj/structure/mortarpestle
	name = "mortar and pestle"
	desc = ""
	icon = 'icons/roguetown/misc/structure.dmi'
	icon_state = "mortarpestle"
	density = FALSE
	anchored = TRUE
	blade_dulling = DULLING_BASH
	max_integrity = 100

/obj/structure/mortarpestle/attackby(obj/item/I, mob/living/user, params)
	if(I.dust_result)
		user.visible_message("<span class='info'>[user] begins grinding up [I].</span>")
		playsound(loc, 'sound/foley/scribble.ogg', 100, FALSE)
		if(do_after(user, 10, target = src))
			new S.dust_result(get_turf(loc))
			qdel(S)
		return
	..()

/datum/crafting_recipe/roguetown/cauldron
	name = "mortar and pestle"
	result = /obj/structure/mortarpestle
	reqs = list(/obj/item/natural/stone = 3)
	verbage = "crafts"
	time = 30
	craftsound = 'sound/foley/Building-01.ogg'
	skillcraft = /datum/skill/craft/masonry
