//lifesteal
/datum/component/enchant/lifesteal
	var/flat_heal // heals a constant amount every time a hit occurs
	var/static/list/damage_heal_order = list(BRUTE, BURN, OXY)

/datum/component/enchant/lifesteal/Initialize(flat_heal=0)
	if(!isitem(parent) && !ishostile(parent) && !isgun(parent))
		return COMPONENT_INCOMPATIBLE

	src.flat_heal = flat_heal

/datum/component/enchant/lifesteal/RegisterWithParent()
	if(isgun(parent))
		RegisterSignal(parent, COMSIG_PROJECTILE_ON_HIT, .proc/projectile_hit)
	else if(isitem(parent))
		RegisterSignal(parent, COMSIG_ITEM_AFTERATTACK, .proc/item_afterattack)
	else if(ishostile(parent))
		RegisterSignal(parent, COMSIG_HOSTILE_ATTACKINGTARGET, .proc/hostile_attackingtarget)

/datum/component/enchant/lifesteal/UnregisterFromParent()
	UnregisterSignal(parent, list(COMSIG_ITEM_AFTERATTACK, COMSIG_HOSTILE_ATTACKINGTARGET, COMSIG_PROJECTILE_ON_HIT))

/datum/component/enchant/lifesteal/proc/item_afterattack(obj/item/source, atom/target, mob/user, proximity_flag, click_parameters)
	if(!proximity_flag)
		return
	do_lifesteal(user, target)

/datum/component/enchant/lifesteal/proc/hostile_attackingtarget(mob/living/simple_animal/hostile/attacker, atom/target)
	do_lifesteal(attacker, target)

/datum/component/enchant/lifesteal/proc/projectile_hit(atom/fired_from, atom/movable/firer, atom/target, Angle)
	do_lifesteal(firer, target)

/datum/component/enchant/lifesteal/proc/do_lifesteal(atom/heal_target, atom/damage_target)
	var/mob/living/healing = heal_target
	var/mob/living/damaging = damage_target
	if(isliving(heal_target) && isliving(damage_target))
		if(damaging.stat != DEAD)
			healing.heal_ordered_damage(flat_heal, damage_heal_order)


//FIRE ENCHANT
/datum/component/enchant/brand
	var/flat_burn // deals a constant amount every time a hit occurs

/datum/component/enchant/brand/Initialize(flat_burn=0)
	if(!isitem(parent) && !ishostile(parent) && !isgun(parent))
		return COMPONENT_INCOMPATIBLE
	src.flat_burn = flat_burn

/datum/component/enchant/brand/RegisterWithParent()
	if(isgun(parent))
		RegisterSignal(parent, COMSIG_PROJECTILE_ON_HIT, .proc/projectile_hit)
	else if(isitem(parent))
		RegisterSignal(parent, COMSIG_ITEM_AFTERATTACK, .proc/item_afterattack)
	else if(ishostile(parent))
		RegisterSignal(parent, COMSIG_HOSTILE_ATTACKINGTARGET, .proc/hostile_attackingtarget)

/datum/component/enchant/brand/UnregisterFromParent()
	UnregisterSignal(parent, list(COMSIG_ITEM_AFTERATTACK, COMSIG_HOSTILE_ATTACKINGTARGET, COMSIG_PROJECTILE_ON_HIT))

/datum/component/enchant/brand/proc/item_afterattack(obj/item/source, atom/target, mob/user, proximity_flag, click_parameters)
	if(!proximity_flag)
		return
	do_burn(target)

/datum/component/enchant/brand/proc/hostile_attackingtarget(mob/living/simple_animal/hostile/attacker, atom/target)
	do_burn(target)

/datum/component/enchant/brand/proc/projectile_hit(atom/fired_from, atom/movable/firer, atom/target, Angle)
	do_burn(target)

/datum/component/enchant/brand/proc/do_burn(mob/living/carbon/burn_victim)
	burn_victim.adjustFireLoss(10, 0)
