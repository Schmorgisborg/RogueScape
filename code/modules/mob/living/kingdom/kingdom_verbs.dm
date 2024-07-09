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


/mob/living/carbon/human/verb/recruit()
	set category = null
	set name = "Recruit"
	set desc = "Invite into your kingdom."

	set src in view(1)

	var/mob/living/human/user

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

	if (!user.leader || user.faction_perms[4] == 0)
		to_chat(user, "You don't have the permissions to recruit.")
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
		src.faction_leaving_proc()
		spawn(1)
			src.civilization = user.civilization
		return
	else if (answer == "No")
		to_chat(usr, "[src] has rejected your offer.")
		return
	else
		return

/mob/living/carbon/human/verb/faction_perms()
	set category = null
	set name = "Kingdom Perms"
	set desc = "Change the kingdom permissions of this person."

	set src in view(1)

	var/mob/living/human/user

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

	if (!user.leader || user.faction_perms[1] == 0)
		to_chat(user, "You don't have the permissions to change kingdom permissions.")
		return

	if (!ishuman(src) || src.incapacitated() || src.client == null)
		to_chat(user, "The target does not seem to respond...")
		return

	var/answer = WWinput(user, "Add or Remove a permission?", null, "Add", list("Add","Remove","Cancel"))
	if (answer == "Add")
		var/list/a2list = list("Cancel")
		if (faction_perms[1] == 0)
			a2list += "Permission Management"
		if (faction_perms[2] == 0)
			a2list += "Announcements"
		if (faction_perms[3] == 0)
			a2list += "Giving Titles"
		if (faction_perms[4] == 0 && map.nomads)
			a2list += "Recruitment"
		var/answer2 = WWinput(user, "Which permission to add?", null, "Cancel", a2list)
		switch(answer2)
			if ("Permission Management")
				faction_perms[1] = 1
			if ("Announcements")
				faction_perms[2] = 1
				make_commander()
			if ("Giving Titles")
				faction_perms[3] = 1
				make_title_changer()
			if ("Recruitment")
				faction_perms[4] = 1
				leader = 1
			else
				return
	else if (answer == "Remove")
		var/list/a3list = list("Cancel")
		if (faction_perms[1] == 1)
			a3list += "Permission Management"
			to_chat(src, "<big>You gained the Permission Management.</big>")
		if (faction_perms[2] == 1)
			a3list += "Announcements"
			to_chat(src, "<big>You gained the Announcement permission.</big>")
		if (faction_perms[3] == 1)
			a3list += "Giving Titles"
			to_chat(src, "<big>You gained the Title Giving permission.</big>")
		if (faction_perms[4] == 1)
			a3list += "Recruitment"
			to_chat(src, "<big>You gained the Recruitment permission.</big>")

		var/answer3 = WWinput(user, "Which permission to remove?", null, "Cancel", a3list)
		switch(answer3)
			if ("Permission Management")
				faction_perms[1] = 0
				to_chat(src, "<big>You lost the Permission Management.</big>")
			if ("Announcements")
				faction_perms[2] = 0
				to_chat(src, "<big>You lost the Announcement permission.</big>")
				remove_commander()
			if ("Giving Titles")
				faction_perms[3] = 0
				to_chat(src, "<big>You lost the Title Giving permission.</big>")
				remove_title_changer()
			if ("Recruitment")
				faction_perms[4] = 0
				to_chat(src, "<big>You lost the Recruitment permission.</big>")
			else
				return
	else
		return
