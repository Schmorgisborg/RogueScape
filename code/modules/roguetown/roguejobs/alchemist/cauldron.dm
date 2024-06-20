/obj/item
	var/possible_potion // check if it can be used in the cauldron, and what potion.

/obj/machinery/light/rogue/cauldron
	name = "cauldron"
	desc = ""
	icon = 'icons/roguetown/misc/lighting.dmi'
	icon_state = "cauldron1"
	base_state = "cauldron"
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
	if(ingredients.len)
		DISABLE_BITFIELD(reagents.flags, AMOUNT_VISIBLE)
		DISABLE_BITFIELD(reagents.flags, REFILLABLE)
	else
		ENABLE_BITFIELD(reagents.flags, AMOUNT_VISIBLE)
		ENABLE_BITFIELD(reagents.flags, REFILLABLE)
	. = ..()

/obj/machinery/light/rogue/cauldron/process()
	..()
	if(on)
		if(ingredients.len)
			if(cooking < 30)
				cooking++
//				playsound(src, "bubbles", 40, FALSE)
			else if(cooking == 30)
				for(var/obj/item/I in ingredients)
					switch(I.possible_potion)
						if("healthpot")
							healthpot_weight++
						if("manapot")
							manapot_weight++
						if("antidote")
							antidote_weight++
					qdel(I)
				if(healthpot_weight >= 2)
					reagents.add_reagent(/datum/reagent/medicine/healthpot, 90)
					potion_result = "metallic"
				if(manapot_weight >= 2)
					reagents.add_reagent(/datum/reagent/medicine/manapot, 90)
					potion_result = "sweet"
				if(antidote_weight >= 2)
					reagents.add_reagent(/datum/reagent/medicine/antidote, 60)
					potion_result = "sickly sweet"
				src.visible_message("<span class='info'>The cauldron finishes boiling with a faint [potion_result] smell.</span>")
				playsound(src, "bubbles", 100, TRUE)
				playsound(src,'sound/misc/smelter_fin.ogg', 40, FALSE)
				ingredients = list()
				cooking = 31

/obj/machinery/light/rogue/cauldron/burn_out()
	cooking = 0
	..()

/obj/machinery/light/rogue/cauldron/attackby(obj/item/I, mob/user, params)
	if(I.possible_potion)
		if(ingredients.len >= maxingredients)
			to_chat(user, "<span class='warning'>Nothing else can fit.</span>")
			return TRUE
		else if(!user.transferItemToLoc(I,src))
			to_chat(user, "<span class='warning'>[I] is stuck to my hand!</span>")
			return TRUE
		for(I in ingredients())
			to_chat(user, "<span class='warning'>There's already [I] in the cauldron.</span>")
			return TRUE
		to_chat(user, "<span class='info'>I add [I] to [src].</span>")
		ingredients += I
		playsound(src, "bubbles", 100, TRUE)
		return TRUE
	..()

/obj/machinery/light/rogue/cauldron/attack_hand(mob/user, params)
	if(on)
		if(ingredients.len)
			to_chat(user, "<span class='warning'>Something's brewing.</span>")
			return
		else
			to_chat(user, "<span class='info'>Nothing's brewing.</span>")
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

/datum/crafting_recipe/roguetown/cauldron
	name = "cauldron"
	result = /obj/machinery/light/rogue/cauldron
	reqs = list(/obj/item/ingot/iron = 2,
				/obj/item/natural/stone = 4,
				/obj/item/grown/log/tree/small = 1)
	verbage = "crafts"
	time = 50
	craftsound = 'sound/foley/Building-01.ogg'
	skillcraft = /datum/skill/craft/masonry
