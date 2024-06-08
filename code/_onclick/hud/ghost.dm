/obj/screen/ghost
	icon = 'icons/mob/screen_ghost.dmi'

/obj/screen/ghost/MouseEntered()
//	flick(icon_state + "_anim", src)
	..()

/obj/screen/ghost/jumptomob
	name = "Jump to mob"
	icon_state = "jumptomob"

/obj/screen/ghost/jumptomob/Click()
	var/mob/dead/observer/G = usr
	G.jumptomob()

/obj/screen/ghost/orbit
	name = "Orbit"
	icon_state = "orbit"

/obj/screen/ghost/orbit/Click()
	var/mob/dead/observer/G = usr
	G.follow()
//skull
/obj/screen/ghost/orbit/rogue
	name = "ETERNITY"
	icon = 'icons/mob/ghostspin.dmi'
	icon_state = ""
	screen_loc = "WEST-4,SOUTH+6"
	nomouseover = FALSE

/obj/screen/ghost/orbit/rogue/Click(location, control, params)


/obj/screen/ghost/reenter_corpse
	name = "Reenter corpse"
	icon_state = "reenter_corpse"

/obj/screen/ghost/reenter_corpse/Click()
	var/mob/dead/observer/G = usr
	G.reenter_corpse()

/obj/screen/ghost/teleport
	name = "Teleport"
	icon_state = "teleport"

/obj/screen/ghost/teleport/Click()
	var/mob/dead/observer/G = usr
	G.dead_tele()

/obj/screen/ghost/pai
	name = "pAI Candidate"
	icon_state = "pai"

/obj/screen/ghost/pai/Click()
	var/mob/dead/observer/G = usr
	G.register_pai()

/datum/hud/ghost/New(mob/owner)
	..()
	var/obj/screen/using

	using =  new /obj/screen/backhudl/ghost()
	using.hud = src
	static_inventory += using

	using = new /obj/screen/grain
	using.hud = src
	static_inventory += using

	scannies = new /obj/screen/scannies
	scannies.hud = src
	static_inventory += scannies
	if(owner.client?.prefs?.crt == TRUE)
		scannies.alpha = 70

	using = new /obj/screen/ghost/orbit/rogue()
	using.hud = src
	static_inventory += using

/datum/hud/ghost/show_hud(version = 0, mob/viewmob)
	// don't show this HUD if observing; show the HUD of the observee
	var/mob/dead/observer/O = mymob
	if (istype(O) && O.observetarget)
		plane_masters_update()
		return FALSE

	. = ..()
	if(!.)
		return
	var/mob/screenmob = viewmob || mymob
	if(!screenmob.client.prefs.ghost_hud)
		screenmob.client.screen -= static_inventory
	else
		screenmob.client.screen += static_inventory

/datum/hud/eye/New(mob/owner)
	..()
	var/obj/screen/using

	using =  new /obj/screen/backhudl/ghost()
	using.hud = src
	static_inventory += using

	using = new /obj/screen/grain
	using.hud = src
	static_inventory += using

	scannies = new /obj/screen/scannies
	scannies.hud = src
	static_inventory += scannies
	if(owner.client?.prefs?.crt == TRUE)
		scannies.alpha = 70

/datum/hud/eye/show_hud(version = 0, mob/viewmob)
	// don't show this HUD if observing; show the HUD of the observee
	var/mob/dead/observer/O = mymob
	if (istype(O) && O.observetarget)
		plane_masters_update()
		return FALSE

	. = ..()
	if(!.)
		return
	var/mob/screenmob = viewmob || mymob
	if(!screenmob.client.prefs.ghost_hud)
		screenmob.client.screen -= static_inventory
	else
		screenmob.client.screen += static_inventory

/datum/hud/obs/New(mob/owner)
	..()
	var/obj/screen/using

	using =  new /obj/screen/backhudl/obs()
	using.hud = src
	static_inventory += using

	using = new /obj/screen/grain
	using.hud = src
	static_inventory += using

	scannies = new /obj/screen/scannies
	scannies.hud = src
	static_inventory += scannies
	if(owner.client?.prefs?.crt == TRUE)
		scannies.alpha = 70
