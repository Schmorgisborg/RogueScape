/mob/proc/add_stress(event)
	return FALSE

/mob/proc/remove_stress(event)
	return FALSE

/mob/proc/update_stress()
	return FALSE

/mob/proc/adjust_stress(amt)
	return FALSE

/mob/proc/has_stress(event)
	return FALSE

/mob/living/carbon
	var/stress = 6
	var/list/stress_timers = list()
	var/oldstress = 0
	var/stressbuffer = 0
	var/list/negative_stressors = list()
	var/list/positive_stressors = list()

/mob/living/carbon/adjust_stress(amt)
	stress += amt
	if(stress > 32)
		stress = 32
	if(stress < 0)
		stressbuffer = stress
		stress = 0

/mob/living/carbon/update_stress()
	if(HAS_TRAIT(src, TRAIT_NOMOOD))
		stress = 0
		if(hud_used)
			if(hud_used.stressies)
				hud_used.stressies.update_icon()
		return
	for(var/datum/stressevent/D in negative_stressors)
		if(D.timer)
			if(world.time > D.time_added + D.timer)
				adjust_stress(-1*D.stressadd)
				negative_stressors -= D
				qdel(D)
	for(var/datum/stressevent/D in positive_stressors)
		if(D.timer)
			if(world.time > D.time_added + D.timer)
				adjust_stress(-1*D.stressadd)
				positive_stressors -= D
				qdel(D)
	if(stress != oldstress)
		if(stress > oldstress)
			to_chat(src, "<span class='red'>I gain stress.</span>")
		else
			to_chat(src, "<span class='green'>I gain peace.</span>")
		
		switch(stress)
			if(0)
				if(!src.has_status_effect(/datum/status_effect/moodgood))
					src.remove_status_effect(/datum/status_effect/moodbad)
					src.remove_status_effect(/datum/status_effect/moodvbad)

					src.apply_status_effect(/datum/status_effect/moodgood)
			if(21 to 27)
				if(!src.has_status_effect(/datum/status_effect/moodbad))
					src.remove_status_effect(/datum/status_effect/moodvbad)
					src.remove_status_effect(/datum/status_effect/moodgood)

					src.apply_status_effect(/datum/status_effect/moodbad)
			if(28 to 32)
				if(!src.has_status_effect(/datum/status_effect/moodvbad))
					src.remove_status_effect(/datum/status_effect/moodgood)
					src.remove_status_effect(/datum/status_effect/moodbad)

					src.apply_status_effect(/datum/status_effect/moodvbad)
			else
				src.remove_status_effect(/datum/status_effect/moodgood)
				src.remove_status_effect(/datum/status_effect/moodbad)
				src.remove_status_effect(/datum/status_effect/moodvbad)

	oldstress = stress
	if(hud_used)
		if(hud_used.stressies)
			hud_used.stressies.update_icon()

	
/mob/living/carbon/has_stress(event)
	var/amount
	for(var/datum/stressevent/D in negative_stressors)
		if(D.type == event)
			amount++
	for(var/datum/stressevent/D in positive_stressors)
		if(D.type == event)
			amount++
	return amount

/mob/living/carbon/add_stress(event)
	if(HAS_TRAIT(src, TRAIT_NOMOOD))
		return FALSE
	
	var/datum/stressevent/N = new event()
	var/countofus = 0
	if(N.stressadd > 0)
		for(var/datum/stressevent/D in negative_stressors)
			if(D.type == event)
				countofus++
				D.time_added = world.time
				if(N.stressadd > D.stressadd)
					D.stressadd = N.stressadd
	else
		for(var/datum/stressevent/D in positive_stressors)
			if(D.type == event)
				countofus++
				D.time_added = world.time
				if(N.stressadd < D.stressadd)
					D.stressadd = N.stressadd
	if(N.max_stacks) //we need to check if we should be added
		if(countofus >= N.max_stacks)
			return
	else //we refreshed the timer
		if(countofus >= 1)
			return
	if(N.stressadd > 0)
		negative_stressors += N
	else
		positive_stressors += N
	adjust_stress(N.stressadd)
	return TRUE

/mob/living/carbon/remove_stress(event)
	if(HAS_TRAIT(src, TRAIT_NOMOOD))
		return FALSE
	var/list/eventL
	if(islist(event))
		eventL = event
	for(var/datum/stressevent/D in negative_stressors)
		if(eventL)
			if(D.type in eventL)
				adjust_stress(-1*D.stressadd)
				negative_stressors -= D
				qdel(D)
		else
			if(D.type == event)
				adjust_stress(-1*D.stressadd)
				negative_stressors -= D
				qdel(D)
	for(var/datum/stressevent/D in positive_stressors)
		if(eventL)
			if(D.type in eventL)
				adjust_stress(-1*D.stressadd)
				positive_stressors -= D
				qdel(D)
		else
			if(D.type == event)
				adjust_stress(-1*D.stressadd)
				positive_stressors -= D
				qdel(D)
	return TRUE

/datum/stressevent
	var/timer
	var/stressadd
	var/desc
	var/time_added
	var/max_stacks = 0 //if higher than 0, can stack

/datum/stressevent/proc/get_desc(mob/living/user)
	return desc

/datum/stressevent/test
	timer = 5 SECONDS
	stressadd = 3
	desc = "<span class='red'>This is a test event.</span>"

/datum/stressevent/testr
	timer = 5 SECONDS
	stressadd = -3
	desc = "<span class='green'>This is a test event.</span>"

#ifdef TESTSERVER
/client/verb/add_stress()
	set category = "DEBUGTEST"
	set name = "stressBad"
	if(mob)
		mob.add_stress(/datum/stressevent/test)
/client/verb/remove_stress()
	set category = "DEBUGTEST"
	set name = "stressGood"
	if(mob)
		mob.add_stress(/datum/stressevent/testr)

/client/verb/filter1()
	set category = "DEBUGTEST"
	set name = "TestFilter1"
	if(mob)
		mob.remove_client_colour(/datum/client_colour/test1)
		mob.remove_client_colour(/datum/client_colour/test2)
		mob.remove_client_colour(/datum/client_colour/test3)
		mob.add_client_colour(/datum/client_colour/test1)
/client/verb/filter2()
	set category = "DEBUGTEST"
	set name = "TestFilter2"
	if(mob)
		mob.remove_client_colour(/datum/client_colour/test1)
		mob.remove_client_colour(/datum/client_colour/test2)
		mob.remove_client_colour(/datum/client_colour/test3)
		mob.add_client_colour(/datum/client_colour/test2)
/client/verb/filter3()
	set category = "DEBUGTEST"
	set name = "TestFilter3"
	if(mob)
		mob.remove_client_colour(/datum/client_colour/test1)
		mob.remove_client_colour(/datum/client_colour/test2)
		mob.remove_client_colour(/datum/client_colour/test3)
		mob.add_client_colour(/datum/client_colour/test3)

/client/verb/do_undesaturate()
	set category = "DEBUGTEST"
	set name = "TestFilterOff"
	if(mob)
		mob.remove_client_colour(/datum/client_colour/test1)
		mob.remove_client_colour(/datum/client_colour/test2)
		mob.remove_client_colour(/datum/client_colour/test3)

/client/verb/do_flash()
	set category = "DEBUGTEST"
	set name = "doflash"
	if(mob)
		var/turf/T = get_turf(mob)
		if(T)
			T.flash_lighting_fx(30)
#endif

//**********************************************
//************** NEGATIVE STRESS ****************
//*************************************************

/datum/stressevent/vice
	timer = 15 MINUTES
	stressadd = 10
	desc = list("<span class='red'>I need to sate my vice, before it gets worse.</span>")
/datum/stressevent/vice2
	timer = 15 MINUTES
	stressadd = 20
	desc = list("<span class='red'>I can't wait much longer.</span>")
/datum/stressevent/vice3
	timer = 15 MINUTES
	stressadd = 30
	desc = list("<span class='red'>The world is bleak and wretched.</span>")
/*
/datum/stressevent/failcraft
	timer = 15 SECONDS
	stressadd = 1
	max_stacks = 10
	desc = "<span class='red'>I've failed to craft something.</span>"
*/
/datum/stressevent/miasmagas
	timer = 10 SECONDS
	stressadd = 6
	desc = "<span class='red'>Smells like death here.</span>"

/datum/stressevent/peckish
	timer = 20 MINUTES
	stressadd = 4
	desc = "<span class='red'>I'm peckish.</span>"

/datum/stressevent/hungry
	timer = 20 MINUTES
	stressadd = 8
	desc = "<span class='red'>I'm hungry.</span>"

/datum/stressevent/starving
	timer = 20 MINUTES
	stressadd = 16
	desc = "<span class='red'>I'm starving.</span>"

/datum/stressevent/drym
	timer = 20 MINUTES
	stressadd = 3
	desc = "<span class='red'>I'm a little thirsty.</span>"

/datum/stressevent/thirst
	timer = 20 MINUTES
	stressadd = 9
	desc = "<span class='red'>I'm thirsty.</span>"

/datum/stressevent/parched
	timer = 20 MINUTES
	stressadd = 15
	desc = "<span class='red'>I'm going to die of thirst.</span>"

/datum/stressevent/dismembered
	timer = 30 MINUTES
	stressadd = 16
	desc = "<span class='red'>My limb was severed!.</span>"

/datum/stressevent/dwarfshaved
	timer = 40 MINUTES
	stressadd = 6
	desc = "<span class='red'>I'd rather cut my own throat than my beard.</span>"

/datum/stressevent/viewdeath
	timer = 3 MINUTES
	stressadd = 4
	desc = "<span class='red'>Death...</span>"

/datum/stressevent/viewdeath/get_desc(mob/living/user)
	if(ishuman(user))
		var/mob/living/carbon/human/H = user
		if(H.dna?.species)
			return "<span class='red'>Another [H.dna.species.id] perished.</span>"
			stressadd = 4
	return desc


/datum/stressevent/viewdismember
	timer = 1 MINUTES
	max_stacks = 1
	stressadd = 0
	//desc = "<span class='grey'>Butchery.</span>"


/datum/stressevent/fviewdismember
	timer = 1 MINUTES
	max_stacks = 1
	stressadd = 0
	//desc = "<span class='red'>I saw something horrible!</span>"

/datum/stressevent/viewgib
	timer = 5 MINUTES
	stressadd = 2
	desc = "<span class='red'>I saw something ghastly.</span>"

/datum/stressevent/bleeding
	timer = 5 MINUTES
	stressadd = 6
	desc = list("<span class='red'>I think I'm bleeding.</span>","<span class='red'>I'm bleeding.</span>")

/datum/stressevent/painmax
	timer = 10 MINUTES
	stressadd = 10
	desc = "<span class='red'>THE PAIN!</span>"

/datum/stressevent/freakout
	timer = 15 SECONDS
	stressadd = 2
	desc = "<span class='red'>I'm panicing!</span>"

/datum/stressevent/felldown
	timer = 5 MINUTES
	stressadd = 1
	desc = "<span class='grey'>I fell. I'm a fool.</span>"

/datum/stressevent/burntmeal
	timer = 15 MINUTES
	stressadd = 12
	desc = "<span class='red'>YUCK!</span>"

/datum/stressevent/rotfood
	timer = 15 MINUTES
	stressadd = 12
	desc = "<span class='red'>YUCK!</span>"

/datum/stressevent/psycurse
	timer = 10 MINUTES
	stressadd = 18
	desc = "<span class='red'>Oh no! I've received divine punishment!</span>"

/datum/stressevent/badmeal
	timer = 15 MINUTES
	stressadd = 12
	desc = "<span class='red'>It tastes VILE!</span>"

/datum/stressevent/vomit
	timer = 10 MINUTES
	stressadd = 4
	max_stacks = 2
	desc = "<span class='red'>I puked!</span>"

/datum/stressevent/vomitself
	timer = 5 MINUTES
	stressadd = 2
	max_stacks = 6
	desc = "<span class='red'>I puked on myself!</span>"

/datum/stressevent/delf
	timer = 5 MINUTES
	stressadd = 4
	desc = "<span class='red'>A dark one... what a wretched sign of things to come.</span>"

/datum/stressevent/tieb
	timer = 1 MINUTES
	stressadd = 1
	desc = "<span class='red'>Helldweller... better stay away.</span>"

/datum/stressevent/paracrowd
	timer = 15 SECONDS
	stressadd = 2
	desc = "<span class='red'>There are too many people who don't look like me here.</span>"

/datum/stressevent/parablood
	timer = 15 SECONDS
	stressadd = 3
	desc = "<span class='red'>There is so much blood here.. it's like a battlefield!</span>"

/datum/stressevent/parastr
	timer = 2 MINUTES
	stressadd = 2
	desc = "<span class='red'>That beast is stronger.. and might easily kill me!</span>"

/datum/stressevent/paratalk
	timer = 2 MINUTES
	stressadd = 2
	desc = "<span class='red'>They are plotting against me in evil tongues..</span>"

/datum/stressevent/coldhead
	timer = 60 SECONDS
	stressadd = 2
	desc = "<span class='red'>My head is cold and ugly.</span>"

/datum/stressevent/sleeptime
	stressadd = 4
	desc = "<span class='red'>I'm tired.</span>"

/datum/stressevent/trainsleep
	timer = 0
	stressadd = 4
	desc = "<span class='red'>My muscles ache.</span>"

/datum/stressevent/tortured
	stressadd = 6
	max_stacks = 5
	desc = "<span class='red'>I'm broken.</span>"
	timer = 60 SECONDS

/datum/stressevent/confessed
	stressadd = 6
	desc = "<span class='red'>I've confessed to sin.</span>"
	timer = 15 MINUTES

/datum/stressevent/confessedgood
	stressadd = 3
	desc = "<span class='red'>I've confessed to sin, it feels good.</span>"
	timer = 15 MINUTES

/datum/stressevent/maniac
	stressadd = 4
	desc = "<span class='red'>THE MANIAC COULD BE HERE!</span>"
	timer = 30 MINUTES

/datum/stressevent/drankrat
	stressadd = 12
	desc = "<span class='red'>I drank from a lesser creature.</span>"
	timer = 1 MINUTES

/datum/stressevent/lowvampire
	stressadd = 8
	desc = "<span class='red'>I'm dead... what comes next?</span>"

/datum/stressevent/oziumoff
	stressadd = 20
	desc = "<span class='blue'>I need another hit.</span>"
	timer = 1 MINUTES

//**********************************************
//************** POSITIVE STRESS ****************
//**********************************************

/datum/stressevent/viewsinpunish
	timer = 15 MINUTES
	stressadd = -5
	desc = "<span class='green'>I saw a sinner get punished!</span>"

/datum/stressevent/viewexecution
	timer = 15 MINUTES
	stressadd = -5
	desc = "<span class='green'>I saw a lawbreaker get punished!</span>"

/datum/stressevent/psyprayer
	timer = 20 MINUTES
	stressadd = -6
	desc = "<span class='green'>The Gods smiles upon me.</span>"

/datum/stressevent/joke
	timer = 30 MINUTES
	stressadd = -8
	desc = "<span class='green'>I heard a good joke.</span>"

/datum/stressevent/tragedy
	timer = 30 MINUTES
	stressadd = -8
	desc = "<span class='green'>Life isn't so bad after all.</span>"

/datum/stressevent/blessed
	timer = 15 MINUTES
	stressadd = -6
	desc = "<span class='green'>Psydon's light shines brightly.</span>"

/datum/stressevent/triumph
	timer = 60 MINUTES
	stressadd = -30
	desc = "<span class='green'>I remember a TRIUMPH.</span>"

/datum/stressevent/drunk
	timer = 10 MINUTES
	stressadd = -6
	desc = list("<span class='green'>Alcohol eases the pain.</span>","<span class='green'>Alcohol, my true friend.</span>")

/datum/stressevent/pweed
	timer = 15 MINUTES
	stressadd = -6
	desc = list("<span class='green'>A relaxing smoke.</span>","<span class='green'>A flavorful smoke.</span>")

/datum/stressevent/weed
	timer = 5 MINUTES
	stressadd = -10
	desc = "<span class='blue'>I love you sweet leaf.</span>"

/datum/stressevent/high
	timer = 5 MINUTES
	stressadd = -14
	desc = "<span class='blue'>I'm so high, don't take away my sky.</span>"

/datum/stressevent/hug
	timer = 30 MINUTES
	stressadd = -3
//	desc = "<span class='green'>Somebody gave me a nice hug.</span>"

/datum/stressevent/stuffed
	timer = 10 MINUTES
	stressadd = -10
	desc = "<span class='green'>I'm stuffed! Feels good.</span>"

/datum/stressevent/goodfood
	timer = 10 MINUTES
	stressadd = -8
	desc = list("<span class='green'>A meal fit for a king!</span>","<span class='green'>Delicious!</span>")

/datum/stressevent/prebel
	timer = 5 MINUTES
	stressadd = -5
	desc = "<span class='green'>Down with the tyranny!</span>"

/datum/stressevent/music
	timer = 5 MINUTES
	stressadd = -4
	desc = "<span class='green'>The music is relaxing.</span>"
/datum/stressevent/music/two
	stressadd = -6
	desc = "<span class='green'>The music is very relaxing.</span>"
/datum/stressevent/music/three
	stressadd = -8
	desc = "<span class='green'>The music saps my stress.</span>"
/datum/stressevent/music/four
	stressadd = -10
	desc = "<span class='green'>The music is heavenly.</span>"
	timer = 10 MINUTES
/datum/stressevent/music/five
	stressadd = -12
	timer = 10 MINUTES
	desc = "<span class='green'>The music is strummed by an angel.</span>"
/datum/stressevent/music/six
	stressadd = -14
	timer = 10 MINUTES
	desc = "<span class='green'>The music is a blessing from Psydon.</span>"

/datum/stressevent/vblood
	stressadd = -5
	desc = "<span class='boldred'>Virgin blood!</span>"
	timer = 5 MINUTES

/datum/stressevent/bathwater
	stressadd = -8
	desc = "<span class='blue'>Relaxing.</span>"
	timer = 15 MINUTES

/datum/stressevent/ozium
	stressadd = -8
	desc = "<span class='blue'>I've taken a hit and entered a painless world.</span>"
	timer = 10 MINUTES

/datum/stressevent/moondust
	stressadd = -6
	desc = "<span class='green'>Moondust surges through me.</span>"

/datum/stressevent/moondust_purest
	stressadd = -12
	desc = "<span class='green'>PURE moondust surges through me!</span>"
