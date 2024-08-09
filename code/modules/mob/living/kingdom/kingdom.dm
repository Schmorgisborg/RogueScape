/mob/living/carbon
	var/civilization = "none"
	var/leader = FALSE
	var/title = ""
	var/announcement_cooldown = 0
	var/list/kingdom_perms = list(0,0,0,0)	//leadership, announcements, titles, recruitment
	var/list/left_kingdoms = list()

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
	else if(src.left_kingdoms.len)
		for (var/i in left_kingdoms)
			if (i[1]==U.civilization && i[2] > (world.time + 5 MINUTES))
				to_chat(U, "<span=danger>You can't create a kingdom, you just recently abandoned [i[1]].</span>")
				return
	else
		var/choosename = input(src, "Choose a name for the kingdom:") as text|null
		if (choosename != null && choosename != "")
			if(create_kingdom_pr(choosename))
				add_basic_kingdom_verbs()
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
		for(var/i = 1, i <= GLOB.custom_civs.len, i++)//color comparison, civ13f
			if (GLOB.custom_civs[i][1] == choosecolor1 && GLOB.custom_civs[i][2] == choosecolor2)
				to_chat(usr, "<span class='warning'>Another kingdom has the same color scheme.</span>")
				return

		H.civilization = newname
		var/datum/atom_hud/hud = GLOB.huds[DATA_HUD_KINGDOM]
		hud.add_hud_to(H)

		H.leader = TRUE
		H.kingdom_perms = list(1,1,1,1)
		GLOB.kingdomlist += newname
		var/newnamev = list("[newname]" = list(newname,choosesymbol,choosecolor1,choosecolor2,H))
		GLOB.custom_civs += newnamev
		king_hud_set_status()
		to_chat(usr, "<big>You are now the king of the <b>[newname]</b> kingdom.</big>")
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
	left_kingdoms += list(list(civilization,world.time))
	if (GLOB.custom_civs[civilization][5] != null)
		if (GLOB.custom_civs[civilization][5].real_name == real_name)
			GLOB.custom_civs[civilization][5] = null
	civilization = "none"
	var/datum/atom_hud/H = GLOB.huds[DATA_HUD_KINGDOM]
	H.remove_hud_from(src)
	name = replacetext(real_name,"[title] ","")
	title = ""
	leader = FALSE
	kingdom_perms = list(0,0,0,0)
	src << "You left your kingdom."
	remove_basic_kingdom_verbs()
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
		if (GLOB.custom_civs[U.civilization][5] != null)
			if (GLOB.custom_civs[U.civilization][5].real_name == U.real_name)
				var/list/closemobs = list("Cancel")
				for (var/mob/living/carbon/human/M in oview(4))
					if (M.civilization == U.civilization)
						closemobs += M
				if(!closemobs)
					return
				var/choice2 = WWinput(usr, "Who to nominate as the new King?", "Kingdom Leadership", "Cancel", closemobs)
				if (choice2 == "Cancel")
					return
				else
					GLOB.custom_civs[U.civilization][4] = choice2
					visible_message("<big>[choice2] is the new king of [U.civilization]!</big>")
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
				to_chat(usr, "<span class='warning'>You are not the King, so you can't transfer the kingdom's nobility.</span>")
				return
		else
			to_chat(usr, "<span class='warning'>There is no King, so you can't transfer the kingdom's nobility.</span>")

/mob/living/carbon/human/proc/become_leader()
	set name = "Become King"
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
		if (GLOB.custom_civs[U.civilization][5] != null)
			to_chat(usr, "<span class='warning'>There already is a King. They must transfer the nobility or be removed first.</span>")
			return
		else if (GLOB.custom_civs[U.civilization][5] == null)
			GLOB.custom_civs[U.civilization][5] = U
			visible_message("<big>[U] is now the King of [U.civilization]!</big>")
			U.leader = TRUE
			U.kingdom_perms = list(1,1,1,1)
			make_title_changer()
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
				for (var/mob/living/carbon/human/M in oview(4))
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
				for (var/mob/living/carbon/human/M in oview(4))
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
	icon_state = "banner_b"
	desc = "A plain banner, click to set it to your kingdom's heraldry."
	var/bstyle = "banner_b"
	var/kingdom = "none"
	var/symbol = ""
	var/color1 = "#000000"
	var/color2 = "#FFFFFF"
	resistance_flags = FLAMMABLE
	layer = ABOVE_MOB_LAYER

/obj/structure/banner/kingdom/attack_hand(mob/user, params)
	if(src.symbol == "")
		var/mob/living/carbon/human/U
		if (istype(user, /mob/living/carbon/human))
			U = user
			if(U.civilization != (null || "none"))
				kingdom = U.civilization
				color1 = GLOB.custom_civs[kingdom][3]
				color2 = GLOB.custom_civs[kingdom][4]
				symbol = GLOB.custom_civs[kingdom][2]

				name = "[kingdom]'s banner"
				desc = "This is a [kingdom] banner."
				icon_state = bstyle
				var/image/overc = image("icon" = icon, "icon_state" = "[bstyle]_1")
				overc.color = color1
				overlays += overc
				var/image/overc1 = image("icon" = icon, "icon_state" = "[bstyle]_2")
				overc1.color = color2
				overlays += overc1
				var/image/overs = image("icon" = icon, "icon_state" = "b_[symbol]")
				overs.color = color1
				overlays += overs

				update_icon()
	else
		..()

/obj/structure/banner/kingdom/attackby(mob/user)
	if (user.used_intent?.blade_class == BCLASS_CUT)
		user.visible_message("<span class ='danger'>[user] starts cutting through \the [src]!</span>", "<span class ='danger'>You start cutting through \the [src]!</span>")
		if (do_after(user, 130, src))
			user.visible_message("<span class ='warning'>[user] cuts \the [src] to ribbons!</span>", "<span class = 'warning'>You cut \the [src] to ribbons!</span>")
			qdel(src)
	else
		..()

/obj/item/weapon/poster/kingdom
	name = "blank flier"
	icon = 'icons/roguetown/misc/banners.dmi'
	icon_state = "poster_rolled"
	desc = "An empty flier, use it inhand to set it."
	var/kingdom = "none"
	var/color1 = "#000000"
	var/color2 = "#FFFFFF"
	var/bstyle = ""
	var/newdesc = ""
	resistance_flags = FLAMMABLE
	force = 0

/obj/item/weapon/poster/kingdom/attack_self(mob/living/carbon/user)
	. = ..()
	if (user.civilization != "none")
		kingdom = user.civilization
		color1 = GLOB.custom_civs[kingdom][3]
		color2 = GLOB.custom_civs[kingdom][4]
		bstyle = GLOB.custom_civs[kingdom][2]
		name = "rolled [kingdom]'s flier"
		desc = "This is a rolled [kingdom] flier. Ready to deploy."
		newdesc = input(src, "Set a description for the flier: ") as text|null
		if(length(newdesc) > 64)
			to_chat(user,"<span class ='warning'>Sorry, maximum of 64 characters.</span>")
			newdesc = "A flier for [kingdom]."
		else if(newdesc == "")
			newdesc = "A flier for [kingdom]."
	else
		to_chat(user,"<span class ='warning'>You have no kingdom to display.</span>")


/obj/structure/poster/kingdom
	name = "kingdom flier"
	icon = 'icons/roguetown/misc/banners.dmi'
	icon_state = "flier"
	desc = "A blank flier."
	var/kingdom = "none"
	var/color1 = "#000000"
	var/color2 = "#FFFFFF"
	var/bstyle = "psy"
	resistance_flags = FLAMMABLE
	layer = BELOW_MOB_LAYER

/obj/structure/poster/kingdom/New()
	..()
	invisibility = 101
	spawn(10)
		if (kingdom != "none")
			name = "[kingdom]'s flier"
			desc = "This is a [kingdom] flier."
			var/image/overc = image("icon" = icon, "icon_state" = "flier_base")
			overc.color = color2
			overlays += overc
			var/image/overc1 = image("icon" = icon, "icon_state" = "[bstyle]_c1")
			overc1.color = color1
			overlays += overc1
	update_icon()
	invisibility = 0

/obj/structure/poster/kingdom/attackby(mob/user)//mackcivf
	if (user.used_intent.type == INTENT_HARM)
		if(icon_state == "poster_ripped")
			qdel(src)
		else
			user.visible_message("<span class ='danger'>[user] starts tearing down \the [src]!</span>", "<span class ='danger'>You start tearing down \the [src]!</span>")
			if (do_after(user, 70, src))
				user.visible_message("<span class ='warning'>[user] tears \the [src] down!</span>", "<span class = 'warning'>You tear off \the [src] down!</span>")
				overlays.Cut()
				icon_state = "poster_ripped"
				color = color2
				update_icon()
	else
		..()

/datum/crafting_recipe/roguetown/kingdom/poster
	name = "kingdom flier"
	result = list(/obj/item/weapon/poster/kingdom)
	reqs = list(/obj/item/natural/cloth = 2)
	verbage = "construct"
	craftsound = 'sound/foley/Building-01.ogg'
	skillcraft = /datum/skill/craft/carpentry


/datum/crafting_recipe/roguetown/kingdom/banner
	name = "kingdom banner"
	result = list(/obj/structure/banner/kingdom)
	reqs = list(/obj/item/grown/log/tree/small = 2,
				/obj/item/natural/cloth = 2)
	verbage = "construct"
	craftsound = 'sound/foley/Building-01.ogg'
	skillcraft = /datum/skill/craft/carpentry
