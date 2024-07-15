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
			holderf.icon_state = "" //nomads are yellow
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

	if(skip_kingdom_huds && stat != DEAD)
		skip_kingdom_huds = FALSE

		if (base_kingdom)
			var/image/holder = hud_list[FACTION_TO_ENEMIES]
			holder.icon = null
			holder.icon_state = null
			hud_list[FACTION_TO_ENEMIES] = holder

			var/image/holder2 = hud_list[BASE_FACTION]
			holder2.icon = 'icons/roguetown/misc/kingdompip.dmi'
			holder2.plane = HUD_PLANE

			holder2.overlays.Cut()

			hud_list[BASE_FACTION] = holder2
