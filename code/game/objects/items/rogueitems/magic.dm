/obj/item/book/rune/granter
	var/list/remarks = list() //things to read about while learning.
	var/pages_to_mastery = 2 //Essentially controls how long a mob must keep the rune in his hand to actually successfully learn
	var/reading = FALSE //sanity
	var/oneuse = TRUE //default this is true, but admins can var this to 0 if we wanna all have a pass around of the rod form rune
	var/used = FALSE //only really matters if oneuse but it might be nice to know if someone's used it for admin investigations perhaps
	icon = 'icons/roguetown/items/books.dmi'

/obj/item/book/rune/granter/proc/turn_page(mob/user)
	playsound(user, pick('sound/blank.ogg'), 30, TRUE)
	if(do_after(user,50, user))
		if(remarks.len)
			to_chat(user, "<span class='notice'>[pick(remarks)]</span>")
		else
			to_chat(user, "<span class='notice'>I keep reading...</span>")
		return TRUE
	return FALSE

/obj/item/book/rune/granter/proc/recoil(mob/user) //nothing so some runes can just return

/obj/item/book/rune/granter/proc/already_known(mob/user)
	return FALSE

/obj/item/book/rune/granter/proc/on_reading_start(mob/user)
	to_chat(user, "<span class='notice'>I start reading [name]...</span>")

/obj/item/book/rune/granter/proc/on_reading_stopped(mob/user)
	to_chat(user, "<span class='notice'>I stop reading...</span>")

/obj/item/book/rune/granter/proc/on_reading_finished(mob/user)
	to_chat(user, "<span class='notice'>I finish reading [name]!</span>")

/obj/item/book/rune/granter/proc/onlearned(mob/user)
	used = TRUE

/obj/item/book/rune/granter/attack_self(mob/user)
	if(reading)
		to_chat(user, "<span class='warning'>You're already reading this!</span>")
		return FALSE
	if(!user.can_read(src))
		return FALSE
	if(already_known(user))
		return FALSE
	if(used)
		if(oneuse)
			recoil(user)
		return FALSE
	on_reading_start(user)
	reading = TRUE
	for(var/i=1, i<=pages_to_mastery, i++)
		if(!turn_page(user))
			on_reading_stopped()
			reading = FALSE
			return
	if(do_after(user,50, user))
		on_reading_finished(user)
		reading = FALSE
	return TRUE

/obj/item/book/rune/granter/action
	var/granted_action
	var/actionname = "catching bugs"

/obj/item/book/rune/granter/action/already_known(mob/user)
	if(!granted_action)
		return TRUE
	for(var/datum/action/A in user.actions)
		if(A.type == granted_action)
			to_chat(user, "<span class='warning'>I already know all about [actionname]!</span>")
			return TRUE
	return FALSE

/obj/item/book/rune/granter/action/on_reading_start(mob/user)
	to_chat(user, "<span class='notice'>I study the rune intently, siphoning energy and the knowledge of [actionname].</span>")

/obj/item/book/rune/granter/action/on_reading_finished(mob/user)
	to_chat(user, "<span class='notice'>I feel like you've got a good handle on [actionname]!</span>")
	var/datum/action/G = new granted_action
	G.Grant(user)
	onlearned(user)

/obj/item/book/rune/granter/spell
	name = "rune"
	dropshrink = 0.5
	var/spell
	var/spellname = "conjure bugs"

/obj/item/book/rune/granter/spell/already_known(mob/user)
	if(!spell)
		return TRUE
	for(var/obj/effect/proc_holder/spell/knownspell in user.mind.spell_list)
		if(knownspell.type == spell)
			if(user.mind)
				to_chat(user,"<span class='warning'>You've studied this type of rune in the past.</span>")
			return TRUE
	return FALSE

/obj/item/book/rune/granter/spell/on_reading_start(mob/user)
	to_chat(user, "<span class='notice'>I study the rune intently, siphoning energy and the knowledge of [spellname].</span>")

/obj/item/book/rune/granter/spell/on_reading_finished(mob/user)
	to_chat(user, "<span class='notice'>The power of [spellname] is emblazened in your mind!</span>")
	if(spell)
		var/obj/effect/proc_holder/spell/S = new spell
		user.mind.AddSpell(S)
	if(user.mind.get_skill_level(/datum/skill/magic/arcane) <= 5)
		user.mind.adjust_experience(/datum/skill/magic/arcane, 250, FALSE)
 	onlearned(user)

/obj/item/book/rune/granter/spell/recoil(mob/user)
	user.visible_message("<span class='warning'>[src] glows with a faint light!</span>")

/obj/item/book/rune/granter/spell/onlearned(mob/user)
	..()
	if(oneuse)
		user.visible_message("<span class='warning'>[src] glows dark, and then crumbles!</span>")
		qdel(src)

/obj/item/book/rune/granter/spell/fireball
	spell = /obj/effect/proc_holder/spell/invoked/projectile/fireball
	spellname = "fireball"
	icon_state = "fireRune"
	name = "fire rune"
	desc = "Brimming with power."
	remarks = list("To understand these archaic things...", "Just catching them on fire won't do...", "Accounting for crosswinds... really?", "I think I just burned my hand...", "Merely a flick of the hand.")

/obj/item/book/rune/granter/spell/fireball/recoil(mob/user)
	..()
	explosion(user.loc, 1, 0, 2, 3, FALSE, FALSE, 2)
	qdel(src)

/obj/item/book/rune/granter/spell/lightning
	spell = /obj/effect/proc_holder/spell/invoked/projectile/lightningbolt
	spellname = "lightning"
	icon_state = "airRune"
	name = "air rune"
	desc = "Light like a feather."
	remarks = list("To understand these archaic things...", "Is it really that simple?", "Accounting for crosswinds... really?", "I think I just shocked my hand...", "Merely a flick of the hand.")

/obj/item/book/rune/granter/spell/lightning/recoil(mob/user)
	..()
	explosion(user.loc, 1, 0, 2, 3, FALSE, FALSE, 2)
	qdel(src)

/obj/item/book/rune/granter/spell/essence
	spell = null
	spellname = "arcane magic"
	pages_to_mastery = 6
	icon_state = "runeEssence"
	name = "rune essence"
	desc = "The source of magic in our world."
	remarks = list("My head hurts...", "I'll never understand this!", "I can't look away...", "Maybe...")

/obj/item/book/rune/granter/spell/essence/recoil(mob/user)
	..()
	qdel(src)
/////////////////////////////////////////Scrying///////////////////

/obj/item/scrying
	name = "scrying orb"
	desc = ""
	icon = 'icons/roguetown/items/misc.dmi'
	icon_state ="scrying"
	throw_speed = 3
	throw_range = 7
	throwforce = 15
	damtype = BURN
	force = 15
	hitsound = 'sound/blank.ogg'
	sellprice = 30
	dropshrink = 0.6

	var/mob/current_owner
	var/last_scry


/obj/item/scrying/attack_self(mob/user)
	. = ..()
	if(world.time < last_scry + 30 SECONDS)
		to_chat(user, "<span class='warning'>I look into the ball but only see inky smoke. Maybe I should wait.</span>")
		return
	var/input = stripped_input(user, "Who are you looking for?", "Scrying Orb")
	if(!input)
		return
	if(!user.key)
		return
	if(world.time < last_scry + 30 SECONDS)
		to_chat(user, "<span class='warning'>I look into the ball but only see inky smoke. Maybe I should wait.</span>")
		return
	if(!user.mind || !user.mind.do_i_know(name=input))
		to_chat(user, "<span class='warning'>I don't know anyone by that name.</span>")
		return
	for(var/mob/living/carbon/human/HL in GLOB.human_list)
		if(HL.real_name == input)
			var/turf/T = get_turf(HL)
			if(!T)
				continue
			var/mob/dead/observer/screye/S = user.scry_ghost()
			if(!S)
				return
			S.ManualFollow(HL)
			last_scry = world.time
			user.visible_message("<span class='danger'>[user] stares into [src], \their eyes rolling back into \their head.</span>")
			addtimer(CALLBACK(S, /mob/dead/observer/.proc/reenter_corpse), 8 SECONDS)
			if(!HL.stat)
				if(HL.STAPER >= 15)
					if(HL.mind)
						if(HL.mind.do_i_know(name=user.real_name))
							to_chat(HL, "<span class='warning'>I can clearly see the face of [user.real_name] staring at me!.</span>")
							return
					to_chat(HL, "<span class='warning'>I can clearly see the face of an unknown [user.gender == FEMALE ? "woman" : "man"] staring at me!</span>")
					return
				if(HL.STAPER >= 11)
					to_chat(HL, "<span class='warning'>I feel a pair of unknown eyes on me.</span>")
			return
	to_chat(user, "<span class='warning'>I peer into the ball, but can't find [input].</span>")
	return

/////////////////////////////////////////Crystal ball ghsot vision///////////////////

/obj/item/crystalball/attack_self(mob/user)
	user.visible_message("<span class='danger'>[user] stares into [src], \their eyes rolling back into \their head.</span>")
	user.ghostize(1)
