/datum/species/human/sgoblin/check_roundstart_eligible()
	return TRUE

/datum/species/human/sgoblin/get_spec_undies_list(gender)
	if(!GLOB.underwear_list.len)
		init_sprite_accessory_subtypes(/datum/sprite_accessory/underwear, GLOB.underwear_list, GLOB.underwear_m, GLOB.underwear_f)
	var/list/spec_undies = list()
	var/datum/sprite_accessory/X
	switch(gender)
		if(MALE)
			for(var/O in GLOB.underwear_m)
				X = GLOB.underwear_list[O]
				if(X)
					if("sgoblin" in X.specuse)
						if(X.roundstart)
							spec_undies += X
			return spec_undies
		if(FEMALE)
			for(var/O in GLOB.underwear_f)
				X = GLOB.underwear_list[O]
				if(X)
					if("sgoblin" in X.specuse)
						if(X.roundstart)
							spec_undies += X
			return spec_undies

/datum/species/human/sgoblin/get_spec_hair_list(gender)
	if(!GLOB.hairstyles_list.len)
		init_sprite_accessory_subtypes(/datum/sprite_accessory/hair,GLOB.hairstyles_list, GLOB.hairstyles_male_list, GLOB.hairstyles_female_list)
	var/datum/sprite_accessory/X
	var/list/spec_hair = list()
	switch(gender)
		if(MALE)
			for(var/O in GLOB.hairstyles_male_list)
				X = GLOB.hairstyles_list[O]
				if(X)
					if("sgoblin" in X.specuse)
						spec_hair += X
			return spec_hair
		if(FEMALE)
			for(var/O in GLOB.hairstyles_female_list)
				X = GLOB.hairstyles_list[O]
				if(X)
					if("sgoblin" in X.specuse)
						spec_hair += X
			return spec_hair

/datum/species/human/sgoblin/get_spec_facial_list(gender)
	if(!GLOB.facial_hairstyles_list.len)
		init_sprite_accessory_subtypes(/datum/sprite_accessory/facial_hair, GLOB.facial_hairstyles_list, GLOB.facial_hairstyles_male_list, GLOB.facial_hairstyles_female_list)
	var/datum/sprite_accessory/X
	var/list/spec_hair = list()
	switch(gender)
		if(MALE)
			for(var/O in GLOB.facial_hairstyles_male_list)
				X = GLOB.facial_hairstyles_list[O]
				if(X)
					if("sgoblin" in X.specuse)
						spec_hair += X
			return spec_hair
		if(FEMALE)
			for(var/O in GLOB.facial_hairstyles_female_list)
				X = GLOB.facial_hairstyles_list[O]
				if(X)
					if("sgoblin" in X.specuse)
						spec_hair += X
			return spec_hair
