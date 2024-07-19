/mob/New()
	..()
	verbs += /mob/living/carbon/human/proc/create_kingdom
	verbs += /mob/living/carbon/human/proc/abandon_kingdom
	verbs += /mob/living/carbon/human/proc/transfer_kingdom
	verbs += /mob/living/carbon/human/proc/become_leader
	verbs += /mob/proc/kingdom_list

/mob/living/carbon/human/proc/make_commander()
	verbs += /mob/living/carbon/proc/king_declare

/mob/living/carbon/human/proc/remove_commander()
	verbs -= /mob/living/carbon/proc/king_declare


/mob/living/carbon/human/proc/make_title_changer()
	verbs += /mob/living/carbon/human/proc/Add_Title
	verbs += /mob/living/carbon/human/proc/Remove_Title

/mob/living/carbon/human/proc/remove_title_changer()
	verbs -= /mob/living/carbon/human/proc/Add_Title
	verbs -= /mob/living/carbon/human/proc/Remove_Title

/mob/proc/kingdom_list()
	set name = "Check Kingdom List"
	set category = "Kingdom"
	var/list/facl[]
	for (var/i=1,i<=GLOB.kingdomlist.len,i++)
		var/nu = 0
		facl += list(GLOB.kingdomlist[i] = nu)

	for (var/relf in facl)
		facl[relf] = 0
		for (var/mob/living/carbon/human/H in world)
			if (relf == H.civilization && H.stat != DEAD)
				facl[relf] += 1

	var/body = "<html><head><title>Kingdom List</title></head><b>KINGDOM LIST</b><br><br>"
	for (var/relf in facl)
		if (facl[relf] > 0)
			body += "<b>[relf]</b>: [facl[relf]] members.</br>"
	body += {"<br>
		</body></html>
	"}

	usr << browse(body,"window=kingdoms_window;border=1;can_close=1;can_resize=1;can_minimize=0;titlebar=1;size=250x450")

/mob/living/carbon/human/verb/recruit()
	set category = "Kingdom"
	set name = "Recruit"
	set desc = "Invite into your kingdom."

	set src in oview(1)

	var/mob/living/carbon/human/user

	if (!ishuman(src))
		return

	if (!ishuman(usr))
		return
	else
		user = usr

	if (user.stat || user.restrained() || !isliving(user))
		return

	if (user == src)
		to_chat(user, "You cannot recruit yourself.")
		return

	if (user.civilization == "none" || user.civilization == null)
		to_chat(user, "You are not part of a kingdom.")
		return

	if (!user.leader || user.kingdom_perms[4] == 0)
		to_chat(user, "You don't have the permissions to recruit.")
		return

	if (user.civilization == src.civilization)
		to_chat(user, "They are already a member of your kingdom.")
		return

	if (!istype(src) || src.incapacitated() || src.client == null)
		to_chat(user, "The target does not seem to respond...")
		return

	if (left_kingdoms.len)
		for (var/i in left_kingdoms)
			if (i[1]==user.civilization && i[2] > (world.time + 5 MINUTES))
				to_chat(user, "<span=danger>You can't recruit [usr], they only recently abandoned the kingdom.</span>")
				return
	var/answer = WWinput(src, "[usr] wants to recruit you into his faction, [user.civilization]. Will you accept?", null, "Yes", list("Yes","No"))
	if (answer == "Yes")
		to_chat(usr, ("[src] accepts your offer. They are now part of [user.civilization]."))
		to_chat(src, ("You accept [usr]'s offer. You are now part of [user.civilization]."))
		src.abandon_kingdom_proc()
		spawn(1)
			src.civilization = user.civilization
			var/datum/atom_hud/H = GLOB.huds[DATA_HUD_KINGDOM]
			H.add_hud_to(src)
		return
	else if (answer == "No")
		to_chat(usr, "[src] has rejected your offer.")
		return
	else
		return

/mob/living/carbon/human/verb/kingdom_perms()
	set category = "Kingdom"
	set name = "Kingdom Perms"
	set desc = "Change the kingdom permissions of this person."

	set src in oview(1)

	var/mob/living/carbon/human/user

	if (!ishuman(src))
		return

	if (!ishuman(usr))
		return
	else
		user = usr

	if (user.restrained() || !isliving(user))
		return

	if (user.civilization == "none" || user.civilization == null)
		to_chat(user, "You are not part of a kingdom.")
		return

	if (!user.leader || user.kingdom_perms[1] == 0)
		to_chat(user, "You don't have the permissions to change kingdom permissions.")
		return

	if (!ishuman(src) || src.incapacitated() || src.client == null)
		to_chat(user, "The target does not seem to respond...")
		return

	var/answer = WWinput(user, "Add or Remove a permission?", null, "Add", list("Add","Remove","Cancel"))
	if (answer == "Add")
		var/list/a2list = list("Cancel")
		if (kingdom_perms[1] == 0)
			a2list += "Permission Management"
		if (kingdom_perms[2] == 0)
			a2list += "Announcements"
		if (kingdom_perms[3] == 0)
			a2list += "Giving Titles"
		if (kingdom_perms[4] == 0)
			a2list += "Recruitment"
		var/answer2 = WWinput(user, "Which permission to add?", null, "Cancel", a2list)
		switch(answer2)
			if ("Permission Management")
				kingdom_perms[1] = 1
			if ("Announcements")
				kingdom_perms[2] = 1
				make_commander()
			if ("Giving Titles")
				kingdom_perms[3] = 1
				make_title_changer()
			if ("Recruitment")
				kingdom_perms[4] = 1
				leader = 1
			else
				return
	else if (answer == "Remove")
		var/list/a3list = list("Cancel")
		if (kingdom_perms[1] == 1)
			a3list += "Permission Management"
			to_chat(src, "<big>You gained the Permission Management.</big>")
		if (kingdom_perms[2] == 1)
			a3list += "Announcements"
			to_chat(src, "<big>You gained the Announcement permission.</big>")
		if (kingdom_perms[3] == 1)
			a3list += "Giving Titles"
			to_chat(src, "<big>You gained the Title Giving permission.</big>")
		if (kingdom_perms[4] == 1)
			a3list += "Recruitment"
			to_chat(src, "<big>You gained the Recruitment permission.</big>")

		var/answer3 = WWinput(user, "Which permission to remove?", null, "Cancel", a3list)
		switch(answer3)
			if ("Permission Management")
				kingdom_perms[1] = 0
				to_chat(src, "<big>You lost the Permission Management.</big>")
			if ("Announcements")
				kingdom_perms[2] = 0
				to_chat(src, "<big>You lost the Announcement permission.</big>")
				remove_commander()
			if ("Giving Titles")
				kingdom_perms[3] = 0
				to_chat(src, "<big>You lost the Title Giving permission.</big>")
				remove_title_changer()
			if ("Recruitment")
				kingdom_perms[4] = 0
				to_chat(src, "<big>You lost the Recruitment permission.</big>")
			else
				return
	else
		return

/mob/living/carbon/proc/king_declare()
	set category = "Kingdom"
	set name = "Kingdom Announcement"
	set desc = "Announce to everyone in your kingdom."
	if (stat != DEAD)
		var/messaget = "Announcement"
		var/message = input("Global message to send:", "IC Announcement", null, null)
		if (message && message != "")
			message = sanitize(message, 500, extra = FALSE)
			message = replacetext(message, "\n", "<br>")
		for (var/mob/living/carbon/human/M)
			if (civilization == M.civilization && civilization != "none" && world.time > announcement_cooldown)
				messaget = "[name] announces:"
				to_chat(M, "<big><span class=notice><b>[messaget]</b></big><p style='text-indent: 50px'>[message]</p></span>", 2)
		announcement_cooldown = world.time+1800//civ13f
		log_admin("Kingdom Announcement: [key_name(usr)] - [messaget] : [message]")
	else
		to_chat(src, "<span class='danger'>You can't make an annoucement while you're dead!</span>")
