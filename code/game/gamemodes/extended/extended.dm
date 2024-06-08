/datum/game_mode/extended
	name = "secret extended"
	config_tag = "secret_extended"
	report_type = "extended"
	false_report_weight = 0
	required_players = 0

	announce_span = "danger"
	announce_text = "The"

	var/allmig = TRUE

	var/roundvoteend = FALSE
	var/ttime

/datum/game_mode/extended/pre_setup()
	return 1

/datum/game_mode/extended/generate_report()
	return ""

/datum/game_mode/extended/announced
	name = "extended"
	config_tag = "extended"
	false_report_weight = 0

/datum/game_mode/extended/check_finished()
	ttime = world.time - SSticker.round_start_time
	if(ttime >= GLOB.round_timer)
		if(!roundvoteend && !SSvote.mode)
			SSvote.initiate_vote("endround", pick("Zlod", "Sun King", "Gaia", "Moon Queen", "Aeon", "Gemini", "Aries"))
	if(ttime > 180 MINUTES) //3 hour cutoff
		return TRUE

/datum/game_mode/extended/proc/undeadratio()
	var/undead = 0
	var/living = 0
	for(var/mob/living/carbon/human/player in GLOB.human_list)
		if(player.mind)
			if(player.stat != DEAD)
				if(isbrain(player))
					continue
				var/datum/antagonist/D = player.mind.has_antag_datum(/datum/antagonist/skeleton)
				if(D)
					undead++
					continue
				else
					living++
					continue
	if(living >= undead)
		return "living"
	else
		return "undead"
