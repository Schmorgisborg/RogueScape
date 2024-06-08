/datum/keybinding/mob
	category = CATEGORY_HUMAN
	weight = WEIGHT_MOB


/datum/keybinding/mob/face_north
	hotkey_keys = list("CtrlW", "CtrlNorth")
	classic_keys = list("CtrlNorth")
	name = "face_north"
	full_name = "Face North"
	description = ""

/datum/keybinding/mob/face_north/down(client/user)
	var/mob/M = user.mob
	M.northface()
	return TRUE


/datum/keybinding/mob/face_east
	hotkey_keys = list("CtrlD", "CtrlEast")
	classic_keys = list("CtrlEast")
	name = "face_east"
	full_name = "Face East"
	description = ""

/datum/keybinding/mob/face_east/down(client/user)
	var/mob/M = user.mob
	M.eastface()
	return TRUE


/datum/keybinding/mob/face_south
	hotkey_keys = list("CtrlS", "CtrlSouth")
	classic_keys = list("CtrlSouth")
	name = "face_south"
	full_name = "Face South"
	description = ""

/datum/keybinding/mob/face_south/down(client/user)
	var/mob/M = user.mob
	M.southface()
	return TRUE

/datum/keybinding/mob/face_west
	hotkey_keys = list("CtrlA", "CtrlWest")
	classic_keys = list("CtrlWest")
	name = "face_west"
	full_name = "Face West"
	description = ""

/datum/keybinding/mob/face_west/down(client/user)
	var/mob/M = user.mob
	M.westface()
	return TRUE


/datum/keybinding/mob/target_head_cycle
	hotkey_keys = list("Numpad8")
	name = "target_head_cycle"
	full_name = "Target: Cycle head"
	description = ""

/datum/keybinding/mob/target_head_cycle/down(client/user)
	var/client/H = user.mob
	H.body_toggle_head()
	return TRUE

/datum/keybinding/mob/target_r_arm
	hotkey_keys = list("Numpad4")
	name = "target_r_arm"
	full_name = "Target: right arm"
	description = ""

/datum/keybinding/mob/target_r_arm/down(client/user)
	var/client/H = user.mob
	H.body_r_arm()
	return TRUE

/datum/keybinding/mob/target_body_chest
	hotkey_keys = list("Numpad5")
	name = "target_body_chest"
	full_name = "Target: Body"
	description = ""

/datum/keybinding/mob/target_body_chest/down(client/user)
	var/client/H = user.mob
	H.body_chest()
	return TRUE

/datum/keybinding/mob/target_left_arm
	hotkey_keys = list("Numpad6")
	name = "target_left_arm"
	full_name = "Target: left arm"
	description = ""

/datum/keybinding/mob/target_left_arm/down(client/user)
	var/client/H = user.mob
	H.body_l_arm()
	return TRUE

/datum/keybinding/mob/target_right_leg
	hotkey_keys = list("Numpad1")
	name = "target_right_leg"
	full_name = "Target: Right leg"
	description = ""

/datum/keybinding/mob/target_right_leg/down(client/user)
	var/client/H = user.mob
	H.body_r_leg()
	return TRUE

/datum/keybinding/mob/target_body_groin
	hotkey_keys = list("Numpad2")
	name = "target_body_groin"
	full_name = "Target: Groin"
	description = ""

/datum/keybinding/mob/target_body_groin/down(client/user)
	var/client/H = user.mob
	H.body_groin()
	return TRUE

/datum/keybinding/mob/target_left_leg
	hotkey_keys = list("Numpad3")
	name = "target_left_leg"
	full_name = "Target: left leg"
	description = ""

/datum/keybinding/mob/target_left_leg/down(client/user)
	var/client/H = user.mob
	H.body_l_leg()
	return TRUE

