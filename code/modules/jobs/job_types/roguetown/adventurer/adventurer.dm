GLOBAL_LIST_EMPTY(billagerspawns)
/*shittyplaceholder


*/
/datum/job/roguetown/adventurer
	title = "Adventurer"
	flag = ADVENTURER
	department_flag = SERFS
	faction = "Station"
	total_positions = 9999
	spawn_positions = 128
	allowed_races = list("Humen",
	"Elf",
	"Half-Elf",
	"Dwarf",
	"Tiefling",
	"Dark Elf",
	"Aasimar"
	)
	tutorial = "Adventurers have played crucial roles in recent events occurring all over Wyrld's surface and depths, and even in adjacent dimensions and planes, ranging from slaying apocalyptic demons, destroying powerful dragons which have laid waste to entire settlements, to discovering long-lost secrets of gods."
	allowed_patrons = list("Psydon", "Saradomin", "Guthix", "Zamorak")

	outfit = /datum/outfit/job/roguetown/adventurer/genadventurer
	outfit_female = /datum/outfit/job/roguetown/adventurer/genadventurer

	var/isvillager = FALSE
	var/ispilgrim = FALSE
	display_order = JDO_ADVENTURER
	show_in_credits = TRUE
	min_pq = -1
/datum/outfit/job/roguetown/adventurer/genadventurer/pre_equip(mob/living/carbon/human/H)
	pants = /obj/item/clothing/under/roguetown/tights/black
	shirt = /obj/item/clothing/suit/roguetown/shirt/undershirt/random
	shoes = /obj/item/clothing/shoes/roguetown/boots

/datum/job/roguetown/adventurer/after_spawn(mob/living/L, mob/M, latejoin = TRUE)
	..()
	if(L)
		var/mob/living/carbon/human/H = L
		H.advsetup = 1
		H.invisibility = INVISIBILITY_MAXIMUM
		H.become_blind("advsetup")
		H.Stun(100)
		if(!H.possibleclass)
			H.possibleclass = list()
		var/list/classes = GLOB.adv_classes.Copy()
		var/list/special_classes = list()
		var/classamt = 10
		if(isvillager)
			GLOB.billagerspawns |= H
#ifdef TESTSERVER
		classamt = 999
#endif
		for(var/I in shuffle(classes))
			var/datum/advclass/A = I
			if(!(H.gender in A.allowed_sexes))
				testing("[A.name] fail11")
				continue
			if(!(H.dna.species.name in A.allowed_races))
				testing("[A.name] fail22")
				continue
			if(!(H.age in A.allowed_ages))
				testing("[A.name] fail33")
				continue
			if(A.maxchosen > -1)
				if(A.amtchosen >= A.maxchosen)
					testing("[A.name] fail9")
					continue

			if(!isvillager && !ispilgrim) //adventurer
				if(A.ispilgrim || A.isvillager)
					continue
			if(isvillager) //towner
				if(!A.isvillager)
					continue

//			if(ispilgrim) //pilgrim
//				if(A.ispilgrim)
//					continue

			if(A.plevel_req > M.client.patreonlevel())
				testing("[A.name] fail6")
				continue
			if(A.special_req)
				special_classes += A
				testing("[A.name] fail5")
				continue
			if(CONFIG_GET(flag/usewhitelist))
				if(M.client)
					if((!M.client.whitelisted()) && A.whitelist_req)
						testing("[A.name] fail4")
						continue
			if(H.possibleclass.len >= classamt)
				testing("[A.name] fail3")
				continue
			var/the_prob = A.pickprob
#ifdef TESTSERVER
			the_prob = 100
#endif
			if(M.client.patreonlevel() >= 0)
				the_prob = 100
			if(prob(the_prob))
				testing("[A.name] SUC1")
				H.possibleclass += A

		for(var/X in special_classes)
			var/datum/advclass/A = X
			if(!A.special_req)
				continue
			if(!M.client)
				continue
			else
				if(find_class_json(A.name, M.client.ckey))
					if(prob(A.pickprob))
						H.possibleclass += A
						continue

/client
	var/whitelisted = 2
	var/blacklisted = 2

/client/proc/whitelisted()
	if(whitelisted != 2)
		return whitelisted
	else
		if(check_whitelist(ckey))
			whitelisted = 1
		else
			whitelisted = 0
		return whitelisted

/client/proc/blacklisted()
	if(blacklisted != 2)
		return blacklisted
	else
		if(check_blacklist(ckey))
			blacklisted = 1
		else
			blacklisted = 0
		return blacklisted

/proc/find_class_json(name, keyy)
	if(!name || !keyy)
		return
	var/json_file = file("[global.config.directory]/roguetown/donatorclasses.json")
	if(fexists(json_file))
		var/list/configuration = json_decode(file2text(json_file))
		var/list/donatorss = configuration["[name]"]
		if(isnull(donatorss))
			donatorss = list()
		for(var/X in donatorss)
			X = ckey(X)
			if(X == keyy)
				return TRUE

/mob/living/carbon/human/proc/advsetup()
	if(!advsetup)
		testing("RETARD")
		return TRUE
	var/blacklisted = check_blacklist(ckey)
	if(possibleclass.len && !blacklisted)
		var/datum/advclass/C = input(src, "What is my class?", "Adventure") as null|anything in sortNames(possibleclass)
		if(C && advsetup)
			if(C.maxchosen > -1)
				for(var/datum/advclass/A in GLOB.adv_classes)
					if(A.type == C.type)
						if(A.amtchosen >= A.maxchosen)
							possibleclass -= C
							to_chat(src, "<span class='warning'>Not enough slots for [C] left! Choose something different.</span>")
							return FALSE
						else
							A.amtchosen++
			if(alert(src, "[C.name]\n[C.tutorial]", "Are you sure?", "Yes", "No") != "Yes")
				return FALSE
			if(advsetup)
				advsetup = 0
				C.equipme(src)
				invisibility = 0
				cure_blind("advsetup")
				return TRUE
	else
		testing("RETARD2")
		advsetup = 0
		invisibility = 0
		cure_blind("advsetup")
		return TRUE
