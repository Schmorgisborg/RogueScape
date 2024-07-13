
/obj/machinery/etcher
	icon = 'icons/roguetown/misc/forge.dmi'
	name = "etcher"
	icon_state = "etcher"
	var/obj/item/rogueweapon/enchanting
	max_integrity = 500
	density = TRUE
	damage_deflection = 25
	climbable = TRUE

/obj/machinery/etcher/attackby(obj/item/I, mob/living/user, params)
	if(istype(I, /obj/item/rogueweapon) && !enchanting)
		var/obj/item/rogueweapon/W = I
		if(W.enchantable)
			if(W.enchanted)
				to_chat(user, "<span class='warning'>[W] is already enchanted!</span>")
				..()
				return
			W.forceMove(src)
			enchanting = W
			update_icon()
			return

	if(istype(I, /obj/item/rogueweapon/hammer))
		user.changeNext_move(CLICK_CD_MELEE)
		if(enchanting)
			if(enchanting.currecipe)
				var/obj/machinery/plinth/P = locate(/obj/machinery/plinth) in oview(4,src)
				if(P)
					if(P.plinth_item)
						enchanting.currecipe.plinth_held = P.plinth_item
						if(P.plinth_item.name == enchanting.currecipe.plinth_item[1].name)
							if(iscarbon(user))
								var/mob/living/carbon/C = user
								C.rogfat_add(3)
							switch(enchanting.currecipe.advance(user))
								if(TRUE)
									playsound(src,pick('sound/items/bsmith1.ogg','sound/items/bsmith2.ogg','sound/items/bsmith3.ogg','sound/items/bsmith4.ogg'), 100, FALSE)
								if(FALSE)
									shake_camera(user, 1, 1)
									playsound(src,'sound/items/bsmithfail.ogg', 100, FALSE)
								if(2)
									shake_camera(user, 1, 1)
									P.shock_cycle(src)
									P.bad_rune()
							if(prob(40))
								P.shock_cycle(src)
							if(prob(20))
								user.flash_fullscreen("whiteflash")
								var/datum/effect_system/spark_spread/S = new()
								var/turf/front = get_turf(src)
								S.set_up(1, 1, front)
								S.start()
					else
						to_chat(user, "<span class='warning'>I must place the [enchanting.currecipe.plinth_item[1].name] on my plinth.</span>")
						return
				else
					to_chat(user, "<span class='warning'>I need a plinth.</span>")
					return
			else
				if(choose_recipe(user))
					user.flash_fullscreen("whiteflash")
					shake_camera(user, 1, 1)
					playsound(src,pick('sound/items/bsmith1.ogg','sound/items/bsmith2.ogg','sound/items/bsmith3.ogg','sound/items/bsmith4.ogg'), 100, FALSE)
				else
					return
			for(var/mob/M in GLOB.player_list)
				if(!is_in_zweb(M.z,src.z))
					continue
				var/turf/M_turf = get_turf(M)
				var/far_smith_sound = sound(pick('sound/items/smithdist1.ogg','sound/items/smithdist2.ogg','sound/items/smithdist3.ogg'))
				if(M_turf)
					var/dist = get_dist(M_turf, loc)
					if(dist < 7)
						continue
					M.playsound_local(M_turf, null, 100, 1, get_rand_frequency(), falloff = 5, S = far_smith_sound)
		else
			to_chat(user, "<span class='warning'>There's nothing to enchant.</span>")
			return
		return
	if(enchanting && enchanting.currecipe && enchanting.currecipe.needed_item && istype(I, enchanting.currecipe.needed_item))
		enchanting.currecipe.item_added(user)
		qdel(I)
		return
	..()

/obj/machinery/etcher/proc/choose_recipe(user)
	if(!enchanting)
		return
	var/list/appro_recipe = GLOB.etcher_recipes.Copy()
	for(var/I in appro_recipe)
		var/datum/etcher_recipe/R = I
		if(!R.req_item)
			appro_recipe -= R
		if(!istype(enchanting, R.req_item))
			appro_recipe -= R
	if(appro_recipe.len)
		var/datum/chosen_recipe = input(user, "Choose A Creation", "Etcher") as null|anything in sortNames(appro_recipe.Copy())
		if(!enchanting.currecipe && chosen_recipe)
			enchanting.currecipe = new chosen_recipe.type(enchanting)
			return TRUE
	return FALSE

/obj/machinery/etcher/attack_hand(mob/user, params)
	if(enchanting)
		var/obj/item/I = enchanting
		enchanting = null
		I.loc = user.loc
		user.put_in_active_hand(I)
		update_icon()

/obj/machinery/etcher/update_icon()
	cut_overlays()
	if(enchanting)
		var/obj/item/I = enchanting
		I.pixel_x = 0
		I.pixel_y = 0
		var/mutable_appearance/M = new /mutable_appearance(I)
		M.transform *= 0.5
		M.pixel_y = -6
		add_overlay(M)

/obj/machinery/etcher/bullet_act(obj/projectile/P)
	if(istype(P, /obj/projectile/magic/lightning))
		P.damage = 0
	..()

/obj/machinery/light/rogue/forge/attackby(obj/item/W, mob/living/user, params)
	if(istype(W, /obj/item/rogueweapon) && on)
		var/obj/item/rogueweapon/I = W
		if(!I.currecipe)
			return
		if(I.currecipe.enchant_progress == 100)
			I.enchantable = FALSE
			I.enchanted = TRUE
			I.enchantment = I.currecipe.enchantment
			I.currecipe = null
			I.forceMove(user)
			user.put_in_active_hand(I)
			I.update_icon()
			user.visible_message("<span class='info'>[user] emblazens runes upon [W].</span>")
			return
	..()

/datum/crafting_recipe/roguetown/etcher
	name = "etcher"
	result = /obj/machinery/etcher
	reqs = list(/obj/item/ingot/iron = 2,
				/obj/item/alch/magicdust = 1,
				/obj/item/grown/log/tree/small = 1)
	verbage = "crafts"
	time = 50
	craftsound = 'sound/foley/Building-01.ogg'
	skillcraft = /datum/skill/craft/masonry
