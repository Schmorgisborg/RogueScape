/obj/item
	var/ingredient = FALSE // check if it can be used in the cauldron.
	var/possible_potions = "none"

/obj/machinery/light/rogue/cauldron
	name = "cauldron"
	desc = "It's empty"
	icon = 'icons/roguetown/misc/structure.dmi'
	icon_state = "barrel1"
	base_state = "barrel1"
	density = TRUE
	opacity = FALSE
	anchored = TRUE
	max_integrity = 300
	var/list/ingredients = list()
	var/maxingredients = 2
	var/cooking = 0
	var/potion_result = "bland"
	fueluse = 5 MINUTES
	crossfire = FALSE

	var/healthpot_weight = 0
	var/manapot_weight = 0
	var/antidote_weight = 0
//	var/healthpot_weight = 0

/obj/machinery/light/rogue/cauldron/Initialize()
	create_reagents(900, DRAINABLE | AMOUNT_VISIBLE | REFILLABLE)
	icon_state = "barrel[rand(1,3)]"
	. = ..()

/obj/machinery/light/rogue/cauldron/Destroy()
	chem_splash(loc, 2, list(reagents))
	qdel(reagents)
	..()

/obj/machinery/light/rogue/cauldron/examine(mob/user)
	. = ..()

/obj/machinery/light/rogue/cauldron/process()
	..()
	if(on)
		if(ingredients.len)
			if(cooking < 30)
				cooking++
			//	playsound(src, "bubbles", 30, FALSE)
			else if(cooking == 30)
				for(var/obj/item/I in ingredients)
					switch(I.possible_potions)
						if("healthpot")
							healthpot_weight++
						if("manapot")
							manapot_weight++
						if("antidote")
							antidote_weight++
				switch(2)
					if(healthpot_weight)
						reagents.add_reagent(/datum/reagent/healthpot, 90)
						potion_result = "metallic"
					if(manapot_weight)
						reagents.add_reagent(/datum/reagent/manapot, 90)
						potion_result = "sweet"
					if(antidote_weight)
						reagents.add_reagent(/datum/reagent/antidote, 90)
						potion_result = "sickly sweet"
				to_chat(user, "<span class='info'>The cauldron finishes boiling with a faint, [potion_result] smell.</span>")
				playsound(src,'sound/misc/smelter_fin.ogg', 30, FALSE)
				cooking = 31

/obj/machinery/light/rogue/cauldron/burn_out()
	cooking = 0
	..()

/obj/machinery/light/rogue/cauldron/attackby(obj/item/I, mob/user, params)
	if(!I.ingredient)
		to_chat(user, "<span class='warning'>I can't put this in the cauldron!</span>")
		return TRUE
	if(ingredients.len >= maxingredients)
		to_chat(user, "<span class='warning'>Nothing else can fit.</span>")
		return TRUE
	else if(!user.transferItemToLoc(I,src))
		to_chat(user, "<span class='warning'>[I] is stuck to my hand!</span>")
		return TRUE
	to_chat(user, "<span class='info'>I add [I] to [src].</span>")
	ingredients += ingr
	playsound(src, "bubbles", 60, TRUE)
	try_potion(I)
	return TRUE
	..()

/obj/machinery/light/rogue/cauldron/attack_hand(mob/user, params)
	if(on)
		if(ingredients.len)
			to_chat(user, "<span class='warning'>Something's brewing.</span>")
			return
		else
			to_chat(user, "<span class='info'>It's empty.</span>")
			burn_out()
			return
	else
		if(ingredients.len)
			var/obj/item/I = ingredients[ingredients.len]
			ingredients -= I
			I.loc = user.loc
			user.put_in_active_hand(I)
			user.visible_message("<span class='info'>[user] pulls [I] from [src].</span>")
			return
		to_chat(user, "<span class='info'>It's empty.</span>")
		return ..()

/obj/machinery/light/rogue/cauldron/proc/try_potion(obj/item/ingr)
	return

/datum/crafting_recipe/cauldron
	name = "cauldron"
	result = /obj/structure/cauldron
	reqs = list(/obj/item/ingot/iron = 2,
				/obj/item/natural/stone = 4)
	verbage = "crafts"
	time = 50
	craftsound = null
	skillcraft = /datum/skill/craft/masonry

