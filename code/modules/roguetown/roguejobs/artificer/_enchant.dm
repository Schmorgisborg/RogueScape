/obj/item/rogueweapon
	var/enchantable = FALSE
	var/enchanted
	var/enchantment
	var/datum/etcher_recipe/currecipe
	var/active = FALSE
	var/cooldowny
	var/cdtime = 1 MINUTES
	var/activetime = 8 SECONDS
	var/activate_sound = 'sound/magic/antimagic.ogg'
	var/temp_icon

//AddComponent(/datum/component/enchant/lifesteal)
/obj/item/rogueweapon/attack_right(mob/user)
	if(enchantable && !enchanted)
		..()
		return
	if(loc != user)
		return
	if(cooldowny)
		if(world.time < cooldowny + cdtime)
			to_chat(user, "<span class='warning'>Nothing happens.</span>")
			return
	user.visible_message("<span class='warning'>The [src] glows in [user]'s hand!</span>")
	if(activate_sound)
		playsound(user, activate_sound, 100, FALSE, -1)
	cooldowny = world.time
	addtimer(CALLBACK(src, .proc/finished), activetime)
	active = TRUE
	update_icon()
	activate(user)

/obj/item/rogueweapon/proc/activate(mob/user)
	user.update_inv_hands()
	if(enchantment)
		AddComponent(enchantment)
	else
		user.visible_message("<span class='warning'>Something went wrong, oh no!</span>")

/obj/item/rogueweapon/proc/finished()
	active = FALSE
	update_icon()
	if(ismob(loc))
		var/mob/user = loc
		user.visible_message("<span class='warning'>The [src] settles down.</span>")
		user.update_inv_hands()
	var/datum/component/enchant_holder = src.GetComponent(enchanted)
	if(enchant_holder)
		enchant_holder.RemoveComponent()

/obj/item/rogueweapon/update_icon()
	..()
	if(active)
		icon_state = "[icon_state]active"
	else if(!temp_icon)
		temp_icon = icon_state
	else
		icon_state = temp_icon
