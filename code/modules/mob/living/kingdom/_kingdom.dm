GLOBAL_LIST_INIT(kingdomlist, list("Psydonia","Night Manor", "Creachers"))//map.custom_faction_nr
GLOBAL_LIST_INIT(custom_civs, list(
							"Psydonia" = list("Psydonia","psy","#40284E","#A88B61", null),
							"Night Manor" = list("Night Manor","moon","#ff0000","#00ff00", null),
							"Creachers" = list("Creachers","upsy","#ff0000","#0000ff", null)))
GLOBAL_LIST_INIT(kingdom_hud_users, list())

#define isclient(A) istype(A, /client)
#define isdatum(A) istype(A, /datum)

//HUD
/mob/living/carbon/proc/king_hud_set_status()
	var/image/holder = hud_list[KING_HUD]
	var/icon/I = icon(icon, icon_state, dir)
	holder.pixel_y = I.Height() - world.icon_size
	if(civilization == "none" || civilization == "" || !civilization)
		holder.icon_state = ""
		holder.overlays.Cut()
	else
		holder.icon_state = "[GLOB.custom_civs[civilization][2]]_1"
		holder.color = GLOB.custom_civs[civilization][4]
		var/image/overc = image("icon" = GLOB.custom_civs[civilization][2])
		overc.color = GLOB.custom_civs[civilization][3]
		holder.overlays += overc
		holder.mouse_opacity = MOUSE_OPACITY_TRANSPARENT
		update_icon()
