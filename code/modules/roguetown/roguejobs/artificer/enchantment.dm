/obj/item/rogueweapon/sword/enchanted
	var/active = FALSE
	var/cooldowny
	var/cdtime
	var/activetime
	var/activate_sound

/obj/item/rogueweapon/sword/enchanted/attack_right(mob/user)
	if(loc != user)
		return
	if(cooldowny)
		if(world.time < cooldowny + cdtime)
			to_chat(user, "<span class='warning'>Nothing happens.</span>")
			return
	user.visible_message("<span class='warning'>[user] twists the [src]!</span>")
	if(activate_sound)
		playsound(user, activate_sound, 100, FALSE, -1)
	cooldowny = world.time
	addtimer(CALLBACK(src, .proc/finished), activetime)
	active = TRUE
	update_icon()
	activate(user)

/obj/item/rogueweapon/sword/enchanted/proc/activate(mob/user)
	user.update_inv_hands()

/obj/item/rogueweapon/sword/enchanted/proc/finished()
	active = FALSE
	update_icon()
	if(ismob(loc))
		var/mob/user = loc
		user.visible_message("<span class='warning'>The sword settles down.</span>")
		user.update_inv_hands()

/obj/item/rogueweapon/sword/enchanted/cutlass
	name = "cutlass"
	desc = "Used by pirates and deckhands."
	icon_state = "cutlass"
	possible_item_intents = list(/datum/intent/sword/cut, /datum/intent/sword/thrust)
	gripped_intents = null
	wdefense = 6

	cdtime = 1 MINUTES
	activetime = 8 SECONDS
	activate_sound = 'sound/magic/antimagic.ogg'

/obj/item/rogueweapon/sword/enchanted/cutlass/update_icon()
	..()
	if(active)
		icon_state = "cutlassactive"
	else
		icon_state = "cutlass"

/obj/item/rogueweapon/sword/enchanted/cutlass/activate(mob/user)
	. = ..()
	AddComponent(/datum/component/enchant/lifesteal, TRUE, FALSE, FALSE, ITEM_SLOT_RING, INFINITY, FALSE)

/obj/item/rogueweapon/sword/enchanted/cutlass/finished()
	. = ..()
	var/datum/component/lsenchant = GetComponent(/datum/component/enchant/lifesteal)
	if(lsenchant)
		lsenchant.RemoveComponent()


///

