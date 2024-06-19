GLOBAL_LIST_EMPTY(patronlist)

#define CLERIC_SPELLS "Cleric"
#define PRIEST_SPELLS "Priest"

/datum/patrongods
	var/name
	var/domain
	var/summary
	var/worshippers
	var/t0
	var/t1
	var/t2
	var/t3

/datum/patrongods/psydon
	name = "Psydon"
	domain = "The Magus, he guides mankind even in his death."
	summary = "The ascended prophet and primary God of the trinity, he created this Wyrld."
	worshippers = "The Noble Hearted, Healers, Preachers"
	t0 = /obj/effect/proc_holder/spell/invoked/heal/lesser
	t1 = /obj/effect/proc_holder/spell/targeted/sacred_flame_rogue
	t2 = /obj/effect/proc_holder/spell/invoked/heal
	t3 = /obj/effect/proc_holder/spell/invoked/revive

/datum/patrongods/saradomin
	name = "Saradomin"
	domain = "God of the Afterlife, the silent."
	summary = "The guiding light of the dead, not much is known of this powerful deity."
	worshippers = "Widowers, Gravekeepers, Necromancers"
	t0 = /obj/effect/proc_holder/spell/invoked/heal/lesser
	t1 = /obj/effect/proc_holder/spell/targeted/burialrite
	t2 = /obj/effect/proc_holder/spell/targeted/churn
	t3 = /obj/effect/proc_holder/spell/targeted/soulspeak

/datum/patrongods/guthix
	name = "Guthix"
	domain = "The Shaman, healer of nature and men."
	summary = "Once thought to be a mere mortal, now nature bends to his follower's will."
	worshippers = "Druids, Farmers, Shamans"
	t0 = /obj/effect/proc_holder/spell/invoked/heal/lesser
	t1 = /obj/effect/proc_holder/spell/targeted/blesscrop
	t2 = /obj/effect/proc_holder/spell/targeted/beasttame
	t3 = null

/datum/patrongods/zamorak
	name = "Zamorak"
	domain = "God of Chaos, he and his followers spread destruction."
	summary = "Shunned by the common man, he creates monsters to keep the inhabitants strong."
	worshippers = "Dark-hearted, Monsters, Chaos Worshippers"
	t0 = null
	t1 = null
	t2 = null
	t3 = null
