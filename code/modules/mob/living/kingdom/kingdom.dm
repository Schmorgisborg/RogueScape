/mob/living/carbon
	var/civilization = "none"
	var/leader = FALSE
	var/title = ""
	var/announcement_cooldown = 0
	var/list/kingdom_perms = list(0,0,0,0)
	var/list/left_kingdoms = list()
	var/skip_kingdom_huds = TRUE

/////////////   kingdom   /////////////

/mob/living/carbon/human/proc/create_kingdom()
	set name = "Create Kingdom"
	set category = "Kingdom"
	var/mob/living/carbon/human/U

	if (istype(src, /mob/living/carbon/human))
		U = src
	else
		return

	if (U.civilization != "none")
		to_chat(src, "<span class='warning'>You are already in a kingdom. Abandon it first.</span>")
		return
	else
		var/choosename = input(src, "Choose a name for the kingdom:") as text|null
		if (choosename != null && choosename != "")
			if(create_kingdom_pr(choosename))
				make_commander()
				make_title_changer()

/mob/living/carbon/human/proc/create_kingdom_pr(var/newname = "none")
	if (!ishuman(src))
		return
	var/mob/living/carbon/human/H = src
	for(var/i = 1, i <= GLOB.kingdomlist.len, i++)
		if (GLOB.kingdomlist[i] == newname)
			to_chat(usr, "<span class='warning'>That kingdom already exists. Choose another name.</span>")
			return
	if (newname != null && newname != "none")
		var/choosecolor1 = "#000000"
		var/choosecolor2 = "#FFFFFF"
		var/choosesymbol = "star"
		choosesymbol = WWinput(src, "Choose a symbol for the new kingdom:", "Kingdom Creation", "Cancel", list("Cancel","psy","star","sun","moon","cross","big cross","saltire"))
		if (choosesymbol == "Cancel")
			return
		choosecolor1 = WWinput(H, "Choose main/symbol color:", "Color" , "#000000", "color")
		if (choosecolor1 == null || choosecolor1 == "")
			return
		choosecolor2 = WWinput(H, "Choose the secondary/background color:", "Color" , "#FFFFFF", "color")
		if (choosecolor2 == null || choosecolor2 == "")
			return

		H.civilization = newname
		var/datum/atom_hud/hud = GLOB.huds[DATA_HUD_KINGDOM]
		hud.add_hud_to(H)
		H.leader = TRUE
		H.kingdom_perms = list(1,1,1,1)
		GLOB.kingdomlist += newname
		var/newnamev = list("[newname]" = list(H,choosesymbol,choosecolor1,choosecolor2))
		GLOB.custom_civs += newnamev
		to_chat(usr, "<big>You are now the leader of the <b>[newname]</b> kingdom.</big>")
		return 1
	else
		return


/mob/living/carbon/human/proc/abandon_kingdom()
	set name = "Abandon Kingdom"
	set category = "Kingdom"
	var/mob/living/carbon/human/U

	if (istype(src, /mob/living/carbon/human))
		U = src
	else
		return
	if (U.civilization == "none")
		to_chat(usr, "You are not part of any kingdom.")
		return
	else
		var/confirmation = WWinput(src, "Are you sure you want to leave your kingdom? Everyone will know of your fickle loyalty.", "", "Stay in kingdom", list("Leave", "Stay in kingdom"))
		if (confirmation == "Stay in kingdom")
			return
		else
			abandon_kingdom_proc()

/mob/living/carbon/human/proc/abandon_kingdom_proc()
	if (civilization == null || civilization == "none")
		return FALSE
	left_kingdoms += list(list(civilization,world.time)) //like 10 minutes.
	if (GLOB.custom_civs[civilization][1] != null)//mackcivf more lists of SHIT
		if (GLOB.custom_civs[civilization][1].real_name == real_name)
			GLOB.custom_civs[civilization][1] = null
	civilization = "none"
	var/datum/atom_hud/H = GLOB.huds[DATA_HUD_KINGDOM]
	H.remove_hud_from(src)
	name = replacetext(real_name,"[title] ","")
	title = ""
	leader = FALSE
	kingdom_perms = list(0,0,0,0)
	src << "You left your kingdom."
	remove_commander()
	remove_title_changer()
	king_hud_set_status()
	return TRUE

/mob/living/carbon/human/proc/transfer_kingdom()
	set name = "Transfer Kingdom Leadership"
	set category = "Kingdom"
	var/mob/living/carbon/human/U

	if (istype(src, /mob/living/carbon/human))
		U = src
	else
		return
	if (U.civilization == "none")
		to_chat(usr, "You are not part of any kingdom.")
		return
	else
		if (GLOB.custom_civs[U.civilization][1] != null)
			if (GLOB.custom_civs[U.civilization][1].real_name == U.real_name)
				var/list/closemobs = list("Cancel")
				for (var/mob/living/carbon/human/M in range(4,loc))
					if (M.civilization == U.civilization)
						closemobs += M
				var/choice2 = WWinput(usr, "Who to nominate as the new Leader?", "Kingdom Leadership", "Cancel", closemobs)
				if (choice2 == "Cancel")
					return
				else
					GLOB.custom_civs[U.civilization][4] = choice2
					visible_message("<big>[choice2] is the new leader of [U.civilization]!</big>")
					var/mob/living/carbon/human/CM = choice2
					CM.make_commander()
					CM.make_title_changer()
					CM.leader = TRUE
					CM.kingdom_perms = list(1,1,1,1)
					U.leader = FALSE
					U.kingdom_perms = list(0,0,0,0)
					U.remove_title_changer()
					U.remove_commander()
			else
				to_chat(usr, "<span class='warning'>You are not the Leader, so you can't transfer the kingdom's leadership.</span>")
				return
		else
			to_chat(usr, "<span class='warning'>There is no Leader, so you can't transfer the kingdom's leadership.</span>")

/mob/living/carbon/human/proc/become_leader()
	set name = "Become Kingdom Leader"
	set category = "Kingdom"
	var/mob/living/carbon/human/U

	if (istype(src, /mob/living/carbon/human))
		U = src
	else
		return
	if (U.civilization == "none")
		to_chat(usr, "You are not part of any kingdom.")
		return
	else
		if (GLOB.custom_civs[U.civilization][1] != null)
			to_chat(usr, "<span class='warning'>There already is a Leader of the kingdom. He must transfer the leadership or be removed first.</span>")
			return
		else if (GLOB.custom_civs[U.civilization][1] == null)
			GLOB.custom_civs[U.civilization][1] = U
			visible_message("<big>[U] is now the Leader of [U.civilization]!</big>")
			U.leader = TRUE
			U.kingdom_perms = list(1,1,1,1)
			U.make_title_changer()
			make_commander()

/mob/living/carbon/human/proc/Add_Title()
	set name = "Give Kingdom Title"
	set category = "Kingdom"
	var/mob/living/carbon/human/U

	if (istype(usr, /mob/living/carbon/human))
		var/mob/living/carbon/human/H = usr
		if (H.civilization == "none")
			to_chat(usr, "You are not part of any kingdom.")
			return
		else
			if (H.kingdom_perms[3] == 0)
				to_chat(usr, "<span class='warning'>You don't have the permissions to give titles.</span>")
				return

			else
				var/list/closemobs = list("Cancel")
				for (var/mob/living/carbon/human/M in range(4,loc))
					if (M.civilization == H.civilization)
						closemobs += M
				var/choice2 = WWinput(usr, "Who to give a title to?", "Kingdom Title", "Cancel", closemobs)
				if (choice2 == "Cancel")
					return
				else
					U = choice2
					var/inp = input(usr, "Choose a title to give:") as text|null
					if (inp == "" || !inp)
						return
					else
						U.title = inp
						U.name = "[U.title] [U.name]"
						to_chat(src, "[src] is now a [U.title].")
						return


/mob/living/carbon/human/proc/Remove_Title()
	set name = "Remove Kingdom Title"
	set category = "Kingdom"
	var/mob/living/carbon/human/U

	if (istype(usr, /mob/living/carbon/human))
		var/mob/living/carbon/human/H = usr
		if (H.civilization == "none")
			to_chat(usr, "You are not part of any kingdom.")
			return
		else
			if (H.kingdom_perms[3] == 0)
				to_chat(usr, "<span class='warning'>You don't have the permissions to remove titles.</span>")
				return

			else
				var/list/closemobs = list("Cancel")
				for (var/mob/living/carbon/human/M in range(4,loc))
					if (M.civilization == H.civilization && M.title != "")
						closemobs += M
				var/choice2 = WWinput(usr, "Who to remove a title from?", "Kingdom Title", "Cancel", closemobs)
				if (choice2 == "Cancel")
					return
				else
					U = choice2
					if (U && U.title != "")
						U.fully_replace_character_name(U.real_name,replacetext(U.real_name,"[U.title] ",""))
						to_chat(usr, "[src]'s title of [U.title] has been removed by [usr].")
						U.title = ""
						return
					else
						to_chat(usr, "[src] has no title.")
						return

////////////////POSTERS, BANNERS, ETC//////////////////////////////

/obj/structure/banner/kingdom
	name = "kingdom banner"
	icon = 'icons/roguetown/misc/banners.dmi'
	icon_state = "banner_a"
	desc = "A white banner."
	var/bstyle = "banner_a"
	var/kingdom = "none"
	var/symbol = "cross"
	var/color1 = "#000000"
	var/color2 = "#FFFFFF"
	resistance_flags = FLAMMABLE
	layer = ABOVE_MOB_LAYER

/obj/structure/banner/kingdom/banner_a
	bstyle = "banner_a"
/obj/structure/banner/kingdom/banner_b
	bstyle = "banner_b"
/obj/structure/banner/kingdom/New()
	..()
	invisibility = 101
	spawn(10)
		if (kingdom != "none")
			name = "[kingdom]'s banner"
			desc = "This is a [kingdom] banner."
			icon_state = bstyle
			var/image/overc = image("icon" = icon, "icon_state" = "[bstyle]_1")
			overc.color = color1
			overlays += overc
			var/image/overc1 = image("icon" = icon, "icon_state" = "[bstyle]_2")
			overc1.color = color2
			overlays += overc1
			var/image/overs = image("icon" = icon, "icon_state" = "b_[GLOB.custom_civs[kingdom][2]]")
			overs.color = color1
			overlays += overs
	update_icon()
	invisibility = 0

/datum/crafting_recipe/roguetown/kingdom/banner
	name = "kingdom banner"
	result = list(/obj/structure/poster/kingdom/New)
	reqs = list(/obj/item/grown/log/tree/small = 2,
				/obj/item/natural/cloth = 2)
	verbage = "construct"
	craftsound = 'sound/foley/Building-01.ogg'
	skillcraft = /datum/skill/craft/carpentry

/obj/structure/banner/kingdom/attackby(mob/user)
	if (user.used_intent?.blade_class == BCLASS_CUT)
		user.visible_message("<span class ='danger'>[user] starts cutting through \the [src]!</span>", "<span class ='danger'>You start cutting through \the [src]!</span>")
		if (do_after(user, 130, src))
			user.visible_message("<span class ='warning'>[user] cuts \the [src] to ribbons!</span>", "<span class = 'warning'>You cut \the [src] to ribbons!</span>")
			qdel(src)
	else
		..()

/obj/item/weapon/poster/kingdom
	name = "rolled kingdom poster"
	icon = 'icons/roguetown/misc/banners.dmi'
	icon_state = "poster_rolled"
	desc = "A rolled poster."
	var/kingdom = "none"
	var/color1 = "#000000"
	var/color2 = "#FFFFFF"
	var/bstyle = "prop_lead"
	resistance_flags = FLAMMABLE
	force = 0

/obj/item/weapon/poster/kingdom/lead
	bstyle = "prop_lead"
/obj/item/weapon/poster/kingdom/work
	bstyle = "prop_work"
/obj/item/weapon/poster/kingdom/mil1
	bstyle = "prop_mil1"
/obj/item/weapon/poster/kingdom/mil2
	bstyle = "prop_mil2"

/obj/item/weapon/poster/kingdom/New()
	..()
	if (kingdom != "none")
		name = "rolled [kingdom]'s poster"
		desc = "This is a rolled [kingdom] flier. Ready to deploy."

/obj/structure/poster/kingdom
	name = "kingdom flier"
	icon = 'icons/roguetown/misc/banners.dmi'
	icon_state = "prop_lead"
	desc = "A blank flier."
	var/kingdom = "none"
	var/color1 = "#000000"
	var/color2 = "#FFFFFF"
	var/bstyle = "prop_lead"
	resistance_flags = FLAMMABLE
	layer = BELOW_MOB_LAYER

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

/datum/crafting_recipe/roguetown/kingdom/poster
	name = "kingdom poster"
	result = list(/obj/item/weapon/poster/kingdom)
	reqs = list(/obj/item/natural/cloth = 2)
	verbage = "construct"
	craftsound = 'sound/foley/Building-01.ogg'
	skillcraft = /datum/skill/craft/carpentry

/obj/structure/poster/kingdom/attackby(mob/user)//mackcivf
	if (user.used_intent == INTENT_HELP)
		user.visible_message("<span class ='danger'>[user] starts tearing down \the [src]!</span>", "<span class ='danger'>You start tearing down \the [src]!</span>")
		if (do_after(user, 70, src))
			user.visible_message("<span class ='warning'>[user] tears \the [src] down!</span>", "<span class = 'warning'>You tear off \the [src] down!</span>")
			overlays.Cut()
			icon_state = "poster_ripped"
			color = color2
			update_icon()
	else
		..()
