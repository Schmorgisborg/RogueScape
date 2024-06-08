/proc/give_special_items(mob/living/carbon/human/H)
	if(!H.mind)
		return
	switch(H.ckey)
		if("a")
			H.mind.special_items["Winged Cap"] = /obj/item/clothing/head/roguetown/helmet/winged
		if("b")
			H.mind.special_items["Headband"] = /obj/item/clothing/head/roguetown/headband
