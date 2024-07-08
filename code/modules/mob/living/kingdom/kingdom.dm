GLOBAL_LIST_EMPTY(kingdomlist)

/mob/living/carbon/human
	var/civilization = "none" //what civilization this person belongs to
	var/leader = FALSE
	//leadership (total control!), announcement, give titles, recruitment
	var/list/kingdom_perms = list(0,0,0,0)
	var/title = ""
	var/religious_title = ""
	var/announcement_cooldown = 0
	var/list/left_kingdoms = list() //kingdom leaving cooldown (to prevent tax avoidance)
	var/religion = "none" //what religion this person belongs to
	var/religion_type = "none"
	var/religion_style = "none"
	var/religious_leader = FALSE
	var/religious_clergy = FALSE


/mob/New()
	..()
	verbs += /mob/living/carbon/human/proc/create_kingdom
	verbs += /mob/living/carbon/human/proc/abandon_kingdom
	verbs += /mob/living/carbon/human/proc/transfer_kingdom
	verbs += /mob/living/carbon/human/proc/become_leader
	verbs += /mob/proc/kingdom_list

/mob/living/carbon/human/proc/make_commander()
	verbs += /mob/living/carbon/human/proc/Commander_Announcement

/mob/living/carbon/human/proc/remove_commander()
	verbs -= /mob/living/carbon/human/proc/Commander_Announcement


/mob/living/carbon/human/proc/make_title_changer()
	verbs += /mob/living/carbon/human/proc/Add_Title
	verbs += /mob/living/carbon/human/proc/Remove_Title

/mob/living/carbon/human/proc/remove_title_changer()
	verbs -= /mob/living/carbon/human/proc/Add_Title
	verbs -= /mob/living/carbon/human/proc/Remove_Title

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
			create_kingdom_pr(choosename)
			make_commander()
			make_title_changer()
			return

/mob/living/carbon/human/proc/create_kingdom_pr(var/newname = "none")
	if (!ishuman(src))
		return
	var/mob/living/carbon/human/H = src
	for(var/i = 1, i <= map.custom_kingdom_nr.len, i++)//mackcivf list needs to be redone
		if (map.custom_kingdom_nr[i] == newname)
			to_chat(usr, "<span class='warning'>That kingdom already exists. Choose another name.</span>")
			return
	if (newname != null && newname != "none")
		var/choosecolor1 = "#000000"
		var/choosecolor2 = "#FFFFFF"
		var/choosesymbol = "star"
		choosesymbol = WWinput(src, "Choose a symbol for the new kingdom:", "Kingdom Creation", "Cancel", list("Cancel","star","sun","moon","cross","big cross","saltire"))
		if (choosesymbol == "Cancel")
			return
		choosecolor1 = WWinput(H, "Choose main/symbol color:", "Color" , "#000000", "color")
		if (choosecolor1 == null || choosecolor1 == "")
			return
		choosecolor2 = WWinput(H, "Choose the secondary/background color:", "Color" , "#FFFFFF", "color")
		if (choosecolor2 == null || choosecolor2 == "")
			return

		H.civilization = newname
		H.leader = TRUE
		H.kingdom_perms = list(1,1,1,1)
		map.custom_kingdom_nr += newname
												//ind						mil					med			leader money	symbol	main color	backcolor, sales tax, business tax
		var/newnamev = list("[newname]" = list(map.default_research,map.default_research,map.default_research,H,0,choosesymbol,choosecolor1,choosecolor2,10,10))
		map.custom_civs += newnamev
		to_chat(usr, "<big>You are now the leader of the <b>[newname]</b> kingdom.</big>")
		return
	else
		return


/mob/living/human/proc/abandon_kingdom()
	set name = "Abandon Kingdom"
	set category = "Kingdom"
	var/mob/living/human/U

	if (istype(src, /mob/living/human))
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
			kingdom_leaving_proc()

/mob/living/human/proc/kingdom_leaving_proc()
	if (civilization == null || civilization == "none")
		return FALSE
	left_kingdoms += list(list(civilization,world.realtime+864000)) //24 hours
	if (map.custom_civs[civilization][4] != null)
		if (map.custom_civs[civilization][4].real_name == real_name)
			map.custom_civs[civilization][4] = null
	civilization = "none"
	name = replacetext(real_name,"[title] ","")
	title = ""
	leader = FALSE
	kingdom_perms = list(0,0,0,0)
	src << "You left your kingdom."
	remove_commander()
	return TRUE

/mob/living/human/proc/transfer_kingdom()
	set name = "Transfer Kingdom Leadership"
	set category = "Kingdom"
	var/mob/living/human/U

	if (istype(src, /mob/living/human))
		U = src
	else
		return
	if (U.civilization == "none")
		to_chat(usr, "You are not part of any kingdom.")
		return
	else
		if (map.custom_civs[U.civilization][4] != null)
			if (map.custom_civs[U.civilization][4].real_name == U.real_name)
				var/list/closemobs = list("Cancel")
				for (var/mob/living/human/M in range(4,loc))
					if (M.civilization == U.civilization)
						closemobs += M
				var/choice2 = WWinput(usr, "Who to nominate as the new Leader?", "Kingdom Leadership", "Cancel", closemobs)
				if (choice2 == "Cancel")
					return
				else
					map.custom_civs[U.civilization][4] = choice2
					visible_message("<big>[choice2] is the new leader of [U.civilization]!</big>")
					var/mob/living/human/CM = choice2
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

/mob/living/human/proc/become_leader()
	set name = "Become Kingdom Leader"
	set category = "Kingdom"
	var/mob/living/human/U

	if (istype(src, /mob/living/human))
		U = src
	else
		return
	if (U.civilization == "none")
		to_chat(usr, "You are not part of any kingdom.")
		return
	else
		if (map.custom_civs[U.civilization][4] != null)
			to_chat(usr, "<span class='warning'>There already is a Leader of the kingdom. He must transfer the leadership or be removed first.</span>")
			return
		else if (map.custom_civs[U.civilization][4] == null)
			map.custom_civs[U.civilization][4] = U
			visible_message("<big>[U] is now the Leader of [U.civilization]!</big>")
			U.leader = TRUE
			U.kingdom_perms = list(1,1,1,1)
			U.make_title_changer()
			make_commander()

/mob/living/human/proc/Add_Title()
	set name = "Give Kingdom Title"
	set category = "Kingdom"
	var/mob/living/human/U

	if (istype(usr, /mob/living/human))
		var/mob/living/human/H = usr
		if (H.civilization == "none")
			to_chat(usr, "You are not part of any kingdom.")
			return
		else
			if (H.kingdom_perms[3] == 0)
				to_chat(usr, "<span class='warning'>You don't have the permissions to give titles.</span>")
				return

			else
				var/list/closemobs = list("Cancel")
				for (var/mob/living/human/M in range(4,loc))
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


/mob/living/human/proc/Remove_Title()
	set name = "Remove Kingdom Title"
	set category = "Kingdom"
	var/mob/living/human/U

	if (istype(usr, /mob/living/human))
		var/mob/living/human/H = usr
		if (H.civilization == "none")
			to_chat(usr, "You are not part of any kingdom.")
			return
		else
			if (H.kingdom_perms[3] == 0)
				to_chat(usr, "<span class='warning'>You don't have the permissions to remove titles.</span>")
				return

			else
				var/list/closemobs = list("Cancel")
				for (var/mob/living/human/M in range(4,loc))
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
//good fucking god


/obj/structure/banner/kingdom
	name = "kingdom banner"
	icon = 'icons/obj/banners.dmi'
	icon_state = "banner_a"
	desc = "A white banner."
	var/bstyle = "banner_a"
	var/kingdom = "none"
	var/symbol = "cross"
	var/color1 = "#000000"
	var/color2 = "#FFFFFF"
	flammable = TRUE
	layer = 3.21

/obj/structure/banner/kingdom/banner_a
	bstyle = "banner_a"
/obj/structure/banner/kingdom/banner_b
	bstyle = "banner_b"
/obj/structure/banner/kingdom/New()
	..()
	invisibility = 101
	spawn(10)
		if (kingdom != "none" && map)
			name = "[kingdom]'s banner"
			desc = "This is a [kingdom] banner."
			icon_state = bstyle
			var/image/overc = image("icon" = icon, "icon_state" = "[bstyle]_1")
			overc.color = color1
			overlays += overc
			var/image/overc1 = image("icon" = icon, "icon_state" = "[bstyle]_2")
			overc1.color = color2
			overlays += overc1
			var/image/overs = image("icon" = icon, "icon_state" = "b_[map.custom_civs[kingdom][6]]")
			overs.color = color1
			overlays += overs
		update_icon()
		invisibility = 0


/obj/structure/banner/kingdom/attackby(obj/item/weapon/W as obj, mob/user as mob)
	if (W.sharp)
		user.visible_message("<span class ='danger'>[user] starts ripping off \the [src]!</span>", "<span class ='danger'>You start ripping off \the [src]!</span>")
		if (do_after(user, 130, src))
			user.visible_message("<span class ='warning'>[user] rips \the [src]!</span>", "<span class = 'warning'>You rip off \the [src]!</span>")
			qdel(src)
	else
		..()

/obj/structure/banner/kingdom/team
	var/team = null
	name = "team banner"
	desc = "A sports team banner."

/obj/structure/banner/kingdom/team/New()
	..()
	assign_team()

/obj/structure/banner/kingdom/team/attackby(obj/item/weapon/W as obj, mob/user as mob)
	return

/obj/structure/banner/kingdom/team/attack_hand(mob/user as mob)
	return

/obj/structure/banner/kingdom/team/proc/assign_team(new_team = null)
	if (!new_team)
		new_team = src.team
	if (!new_team)
		return
	if (map && map.ID == MAP_FOOTBALL)
		var/obj/map_metadata/football/FM = map
		if (FM.team1 == src.team)
			color1 = FM.teams[src.team][FM.team1_kit]["shirt_color"]
			color2 = FM.teams[src.team][FM.team1_kit]["shorts_color"]
		else if  (FM.team2 == src.team)
			color1 = FM.teams[src.team][FM.team2_kit]["shirt_color"]
			color2 = FM.teams[src.team][FM.team2_kit]["shorts_color"]
		else
			color1 = FM.teams[src.team]["main uniform"]["shirt_color"]
			color2 = FM.teams[src.team]["main uniform"]["shorts_color"]
		var/image/overc = image("icon" = icon, "icon_state" = "[bstyle]_1")
		overc.color = color1
		overlays += overc
		var/image/overc1 = image("icon" = icon, "icon_state" = "[bstyle]_2")
		overc1.color = color2
		overlays += overc1
		name = "[src.team] banner"
		update_icon()

/obj/structure/banner/kingdom/team/team1

/obj/structure/banner/kingdom/team/team2

/obj/item/weapon/poster/kingdom
	name = "rolled kingdom poster"
	icon = 'icons/obj/banners.dmi'
	icon_state = "poster_rolled"
	desc = "A rolled poster."
	var/kingdom = "none"
	var/color1 = "#000000"
	var/color2 = "#FFFFFF"
	var/bstyle = "prop_lead"
	flammable = TRUE
	force = 0
	flags 

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
	spawn(10)
		if (kingdom != "none")
			name = "rolled [kingdom]'s poster"
			desc = "This is a rolled [kingdom] propaganda poster. Ready to deploy."

/obj/structure/poster/kingdom
	name = "kingdom propaganda poster"
	icon = 'icons/obj/banners.dmi'
	icon_state = "prop_lead"
	desc = "A blank poster."
	var/kingdom = "none"
	var/color1 = "#000000"
	var/color2 = "#FFFFFF"
	var/bstyle = "prop_lead"
	flammable = TRUE
	layer = 3.2
/obj/structure/poster/kingdom/New()
	..()
	invisibility = 101
	spawn(10)
		if (kingdom != "none")
			name = "[kingdom]'s poster"
			desc = "This is a [kingdom] propaganda poster."
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

/obj/structure/poster/kingdom/attackby(obj/item/weapon/W as obj, mob/user as mob)
	if (W.sharp)
		user.visible_message("<span class ='danger'>[user] starts ripping off \the [src]!</span>", "<span class ='danger'>You start ripping off \the [src]!</span>")
		if (do_after(user, 70, src))
			user.visible_message("<span class ='warning'>[user] rips \the [src]!</span>", "<span class = 'warning'>You rip off \the [src]!</span>")
			overlays.Cut()
			icon_state = "poster_ripped"
			color = color2
			update_icon()
	else
		..()

/mob/proc/kingdom_list()
	set name = "Check Kingdom List"
	set category = "Kingdom"
	if (map && map.civilizations)
		map.facl = list()
		for (var/i=1,i<=map.custom_kingdom_nr.len,i++)
			var/nu = 0
			map.facl += list(map.custom_kingdom_nr[i] = nu)

		for (var/relf in map.facl)
			map.facl[relf] = 0
			for (var/mob/living/human/H in world)
				if (relf == H.civilization && H.stat != DEAD)
					map.facl[relf] += 1

		var/body = "<html><head><title>Kingdom List</title></head><b>KINGDOM LIST</b><br><br>"
		for (var/relf in map.facl)
			if (map.facl[relf] > 0)
				body += "<b>[relf]</b>: [map.facl[relf]] members.</br>"
		body += {"<br>
			</body></html>
		"}

		usr << browse(body,"window=artillery_window;border=1;can_close=1;can_resize=1;can_minimize=0;titlebar=1;size=250x450")
	else
		return
