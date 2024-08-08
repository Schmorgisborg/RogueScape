/mob/living/carbon/proc/king_hud_set_status()
	var/image/holder = hud_list[KING_HUD]
	var/icon/I = icon(icon, icon_state, dir)
	holder.pixel_y = I.Height() - world.icon_size
	if(civilization == "none" || civilization == "" || !civilization)
		holder.icon_state = ""
		holder.overlays.Cut()
	else
		if(civilization == "Psydonia")
			holder.icon_state = "psydonia"
			holder.mouse_opacity = MOUSE_OPACITY_TRANSPARENT
			update_icon()
		else
			holder.icon_state = "base"
			holder.color = GLOB.custom_civs[civilization][4]
			var/image/overc = image("icon" = GLOB.custom_civs[civilization][2])
			overc.color = GLOB.custom_civs[civilization][3]
			holder.overlays += overc
			var/image/overc1 = image("icon" = GLOB.custom_civs[civilization][2], "icon_state" = "[GLOB.custom_civs[civilization][2]]_1")
			holder.overlays += overc1
			holder.mouse_opacity = MOUSE_OPACITY_TRANSPARENT
			update_icon()

/*
/obj/structure/poster/kingdom/New()
	..()
	invisibility = 101
	spawn(10)
		if (kingdom != "none")
			name = "[kingdom]'s poster"
			desc = "This is a [kingdom] flier."
			var/image/overc = image("icon" = icon, "icon_state" = "[bstyle]_c1")
			overc.color = color1
			overlays += overc
			var/image/overc1 = image("icon" = icon, "icon_state" = "[bstyle]_c2")
			overc1.color = color2
			overlays += overc1
			var/image/overs = image("icon" = icon, "icon_state" = "[bstyle]_base")
			overlays += overs
	update_icon()
	invisibility = 0

/mob/living/carbon/proc/process_kingdom_hud(var/mob/M, var/mob/Alt)

	if (!can_process_hud(M))
		return
	if (!ishuman(M))
		return

	var/mob/living/carbon/human/viewer = M

	testing("[viewer] processing kingdom huds.")

	var/datum/arranged_hud_process/P = arrange_hud_process(M, Alt, GLOB.kingdom_hud_users)
	for (var/mob/living/carbon/human/perp in P.Mob.in_view(P.Turf))
		if(!perp)
			continue

		var/image/holderf = perp.hud_list[BASE_FACTION]
		holderf.icon = 'icons/roguetown/misc/kingdompip.dmi'
		holderf.plane = HUD_PLANE
		holderf.icon_state = ""

		if (viewer == perp)
			holderf.icon_state = "civp" //player hud
		else if (perp.civilization == "none")
			holderf.icon_state = "" //none for wanderers
		else if (perp.civilization == viewer.civilization && viewer.civilization != "none" && perp.leader == FALSE)
			holderf.icon_state = "civp" //same faction is green
		else if (perp.civilization == viewer.civilization && viewer.civilization != "none" && perp.leader == TRUE)
			holderf.icon_state = "civpl" //same faction is green
		else
			holderf.icon_state = "" //other factions are red
		perp.hud_list[BASE_FACTION] = holderf
		if (perp.civilization == viewer.civilization && viewer.civilization != "none")
			P.Client.images += perp.hud_list[BASE_FACTION]
		else
			P.Client.images += perp.hud_list[FACTION_TO_ENEMIES]

/datum/arranged_hud_process
	var/client/Client
	var/mob/Mob
	var/turf/Turf

/mob/living/carbon/proc/arrange_hud_process(var/mob/M, var/mob/Alt, var/list/hud_list)
	hud_list |= M
	var/datum/arranged_hud_process/P = new
	P.Client = M.client
	P.Mob = Alt ? Alt : M
	P.Turf = get_turf(P.Mob)
	return P

/mob/living/carbon/proc/can_process_hud(var/mob/M)
	if (!M)
		return FALSE
	if (!M.client)
		return FALSE
	if (M.stat != CONSCIOUS)
		return FALSE
	return TRUE

/mob/proc/in_view(var/turf/T)
	return view(T)

/mob/observer/eye/in_view(var/turf/T)
	var/list/viewed = new
	for (var/mob/living/carbon/human/H in GLOB.mob_list)
		if (get_dist(H, T) <= 7)
			viewed += H
	return viewed

/mob/living/carbon/proc/handle_hud_list()
	if(stat == DEAD)
		hud_list[BASE_FACTION].icon_state = ""
		hud_list[BASE_FACTION].overlays.Cut()
		hud_list[FACTION_TO_ENEMIES].icon_state = ""
		hud_list[FACTION_TO_ENEMIES].overlays.Cut()

	if(stat != DEAD)

		if(civilization != "none")
			var/image/holder = hud_list[FACTION_TO_ENEMIES]
			holder.icon = null
			holder.icon_state = null
			hud_list[FACTION_TO_ENEMIES] = holder

			var/image/holder2 = hud_list[BASE_FACTION]
			holder2.icon = 'icons/roguetown/misc/kingdompip.dmi'
			holder2.plane = HUD_PLANE

			holder2.overlays.Cut()

			hud_list[BASE_FACTION] = holder2
*/
