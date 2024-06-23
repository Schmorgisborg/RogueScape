/obj/item/rune/granter
	var/list/remarks = list() //things to read about while learning.
	var/pages_to_mastery = 2 //Essentially controls how long a mob must keep the rune in his hand to actually successfully learn
	var/reading = FALSE //sanity
	var/oneuse = TRUE //default this is true, but admins can var this to 0 if we wanna all have a pass around of the rod form rune
	var/used = FALSE //only really matters if oneuse but it might be nice to know if someone's used it for admin investigations perhaps
	w_class = WEIGHT_CLASS_TINY
	icon = 'icons/roguetown/items/books.dmi'

/obj/item/rune/granter/proc/turn_page(mob/user)
	//playsound(user, pick('sound/blank.ogg'), 30, TRUE)
	if(do_after(user,50, user))
		return TRUE
	return FALSE

/obj/item/rune/granter/proc/recoil(mob/user)
	to_chat(user, "<span class='notice'>It feels very light.</span>")
	return

/obj/item/rune/granter/proc/already_known(mob/user)
	return FALSE

/obj/item/rune/granter/proc/on_start(mob/user)
	to_chat(user, "<span class='notice'>I start reading [name]...</span>")

/obj/item/rune/granter/proc/on_stopped(mob/user)
	to_chat(user, "<span class='notice'>I stop reading...</span>")

/obj/item/rune/granter/proc/on_finished(mob/user)
	to_chat(user, "<span class='notice'>I finish reading [name]!</span>")

/obj/item/rune/granter/proc/onlearned(mob/user)
	used = TRUE

/obj/item/rune/granter/attack_self(mob/user)
	if(reading)
		//to_chat(user, "<span class='warning'>You're already reading this!</span>")
		return FALSE
	if(already_known(user))
		return FALSE
	if(used)
		if(oneuse)
			recoil(user)
		return FALSE
	on_start(user)
	reading = TRUE
	if(remarks.len)
		to_chat(user, "<span class='notice'>[pick(remarks)]</span>")
	for(var/i=1, i<=pages_to_mastery, i++)
		if(!turn_page(user))
			on_stopped()
			reading = FALSE
			return
	if(do_after(user,50, user))
		on_finished(user)
		reading = FALSE
	return TRUE

/*example
/obj/item/rune/granter/action
	var/granted_action
	var/actionname = "catching bugs"

/obj/item/rune/granter/action/already_known(mob/user)
	if(!granted_action)
		return TRUE
	for(var/datum/action/A in user.actions)
		if(A.type == granted_action)
			to_chat(user, "<span class='warning'>I already know all about [actionname]!</span>")
			return TRUE
	return FALSE

/obj/item/rune/granter/action/on_start(mob/user)
	to_chat(user, "<span class='notice'>I study the rune intently, siphoning energy and the knowledge of [actionname].</span>")

/obj/item/rune/granter/action/on_finished(mob/user)
	to_chat(user, "<span class='notice'>I feel like you've got a good handle on [actionname]!</span>")
	var/datum/action/G = new granted_action
	G.Grant(user)
	onlearned(user)
*/

/obj/item/rune/granter/spell
	name = "rune"
	dropshrink = 0.3
	var/spell
	var/spellname = "no spell"

/obj/item/rune/granter/spell/on_start(mob/user)
	user.visible_message("<span class='warning'>[user] begins siphoning the rune.</span>")

/obj/item/rune/granter/spell/on_finished(mob/user)
	for(var/obj/effect/proc_holder/spell/knownspell in user.mind.spell_list)
		if(knownspell.type == spell)
			spell = null
	if(spell)
		to_chat(user, "<span class='notice'>The power of [spellname] is emblazened in your mind!</span>")
		var/obj/effect/proc_holder/spell/S = new spell
		user.mind.AddSpell(S)
		if(user.mind.get_skill_level(/datum/skill/magic/arcane) <= 5)
			user.mind.adjust_experience(/datum/skill/magic/arcane, 100, FALSE)
	else if(user.mind.get_skill_level(/datum/skill/magic/arcane) <= 5)
		to_chat(user, "<span class='notice'>Arcane power is emblazened in your mind!</span>")
		user.mind.adjust_experience(/datum/skill/magic/arcane, 150, FALSE)
 	onlearned(user)

/obj/item/rune/granter/spell/recoil(mob/user)
	user.visible_message("<span class='warning'>[src] glows with a faint light!</span>")

/obj/item/rune/granter/spell/onlearned(mob/user)
	..()
	if(oneuse)
		user.visible_message("<span class='warning'>[src] glows dark, and then crumbles!</span>")
		qdel(src)

/obj/item/rune/granter/spell/fire_rune
	spell = /obj/effect/proc_holder/spell/invoked/projectile/fireball
	spellname = "fireball"
	icon_state = "fire_rune"
	name = "fire rune"
	desc = "Warm with power."
	remarks = list("To understand these archaic things...", "Just catching them on fire won't do...", "Accounting for crosswinds... really?", "I think I just burned my hand...")

/obj/item/rune/granter/spell/water_rune
	spell = /obj/effect/proc_holder/spell/invoked/arcaneheal
	spellname = "arcaneheal"
	icon_state = "water_rune"
	name = "water rune"
	desc = "A bit moist."
	remarks = list("To understand these archaic things...", "Mana flows through all living things...", "This spell will fatigue me...", "The spell should flow like water...")

/obj/item/rune/granter/spell/air_rune
	spell = /obj/effect/proc_holder/spell/invoked/projectile/lightningbolt
	spellname = "lightning"
	icon_state = "air_rune"
	name = "air rune"
	desc = "Cool to the touch."
	remarks = list("To understand these archaic things...", "Done properly this could...", "I think I just shocked my hand...")

/obj/item/rune/granter/spell/blank_rune
	spell = null
	spellname = "arcane magic"
	icon_state = "blank_rune"
	name = "rune essence"
	desc = "The source of magic in our world."
	remarks = list("My head hurts...", "I'll never understand this!", "I don't want to look away...")

/obj/item/rune/granter/spell/blank_rune/recoil(mob/user)
	..()
	qdel(src)
