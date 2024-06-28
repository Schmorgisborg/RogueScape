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

//TRAIT_ANTIMAGIC
/datum/component/enchant/anti_magic
	var/magic = FALSE
	var/holy = FALSE
	var/psychic = FALSE
	var/allowed_slots = ~ITEM_SLOT_BACKPACK
	var/charges = INFINITY
	var/blocks_self = TRUE
	var/datum/callback/reaction
	var/datum/callback/expire

/datum/component/enchant/anti_magic/Initialize(_magic = FALSE, _holy = FALSE, _psychic = FALSE, _allowed_slots, _charges, _blocks_self = TRUE, datum/callback/_reaction, datum/callback/_expire)
	if(isitem(parent))
		RegisterSignal(parent, COMSIG_ITEM_EQUIPPED, .proc/on_equip)
		RegisterSignal(parent, COMSIG_ITEM_DROPPED, .proc/on_drop)
	else if(ismob(parent))
		RegisterSignal(parent, COMSIG_MOB_RECEIVE_MAGIC, .proc/protect)
	else
		return COMPONENT_INCOMPATIBLE

	magic = _magic
	holy = _holy
	psychic = _psychic
	if(_allowed_slots)
		allowed_slots = _allowed_slots
	if(!isnull(_charges))
		charges = _charges
	blocks_self = _blocks_self
	reaction = _reaction
	expire = _expire

/datum/component/enchant/anti_magic/proc/on_equip(datum/source, mob/equipper, slot)
	if(!CHECK_BITFIELD(allowed_slots, slotdefine2slotbit(slot))) //Check that the slot is valid for antimagic
		UnregisterSignal(equipper, COMSIG_MOB_RECEIVE_MAGIC)
		return
	RegisterSignal(equipper, COMSIG_MOB_RECEIVE_MAGIC, .proc/protect, TRUE)

/datum/component/enchant/anti_magic/proc/on_drop(datum/source, mob/user)
	UnregisterSignal(user, COMSIG_MOB_RECEIVE_MAGIC)

/datum/component/enchant/anti_magic/proc/protect(datum/source, mob/user, _magic, _holy, _psychic, chargecost, self, list/protection_sources)
	if(((_magic && magic) || (_holy && holy) || (_psychic && psychic)) && (!self || blocks_self))
		protection_sources += parent
		reaction?.Invoke(user, chargecost)
		charges -= chargecost
		if(charges <= 0)
			expire?.Invoke(user)
			qdel(src)
		return COMPONENT_BLOCK_MAGIC

