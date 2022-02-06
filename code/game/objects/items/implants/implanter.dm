/obj/item/implanter
	name = "implanter"
	desc = "A sterile automatic implant injector."
	icon = 'icons/obj/items_and_weapons.dmi'
	icon_state = "implanter0"
	item_state = "syringe_0"
	lefthand_file = 'icons/mob/inhands/equipment/medical_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/equipment/medical_righthand.dmi'
	throw_speed = 3
	throw_range = 5
	w_class = WEIGHT_CLASS_SMALL
	custom_materials = list(/datum/material/iron=600, /datum/material/glass=200)
	var/obj/item/implant/imp = null
	var/imp_type = null


/obj/item/implanter/update_icon_state()
	if(imp)
		icon_state = "implanter1"
	else
		icon_state = "implanter0"

/obj/item/implanter/attack(mob/living/M, mob/user)
	if(!istype(M))
		return
	if(user && imp)
		if(M != user)
			M.visible_message(SPAN_WARNING("[user] is attempting to implant [M]."))

		var/turf/T = get_turf(M)
		if(T && (M == user || do_mob(user, M, 50)))
			if(src && imp)
				if(imp.implant(M, user))
					if (M == user)
						to_chat(user, SPAN_NOTICE("You implant yourself."))
					else
						M.visible_message("[user] has implanted [M].", SPAN_NOTICE("[user] implants you."))
					imp = null
					update_icon()
				else
					to_chat(user, SPAN_WARNING("[src] fails to implant [M]."))

/obj/item/implanter/attackby(obj/item/W, mob/user, params)
	if(istype(W, /obj/item/pen))
		if(!user.is_literate())
			to_chat(user, SPAN_NOTICE("You prod at [src] with [W]!"))
			return
		var/t = stripped_input(user, "What would you like the label to be?", name, null)
		if(user.get_active_held_item() != W)
			return
		if(!user.canUseTopic(src, BE_CLOSE))
			return
		if(t)
			name = "implanter ([t])"
		else
			name = "implanter"
	else
		return ..()

/obj/item/implanter/Initialize(mapload)
	. = ..()
	if(imp_type)
		imp = new imp_type(src)
	update_icon()

/obj/item/implanter/adrenalin
	name = "implanter (adrenalin)"
	imp_type = /obj/item/implant/adrenalin

/obj/item/implanter/emp
	name = "implanter (EMP)"
	imp_type = /obj/item/implant/emp

/obj/item/implanter/stealth
	name = "implanter (stealth)"
	imp_type = /obj/item/implant/stealth

/obj/item/implanter/hijack
	name = "implanter (hijack)"
	imp_type = /obj/item/implant/hijack