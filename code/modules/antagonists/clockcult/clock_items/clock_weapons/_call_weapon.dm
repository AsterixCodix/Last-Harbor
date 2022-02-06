//This is the innate action for "binding" and calling weapons to yourself. These weapons can appear and disappear at will.
//You can invoke a cooldown period by calling "weapon_reset(cooldown in deciseconds)." By default, this only applies to dismissing weapons.
/datum/action/innate/call_weapon
	name = "Call Weapon"
	desc = "This definitely shouldn't exist."
	icon_icon = 'icons/mob/actions/actions_clockcult.dmi'
	button_icon_state = "ratvarian_spear"
	background_icon_state = "bg_clock"
	check_flags = AB_CHECK_RESTRAINED|AB_CHECK_STUN|AB_CHECK_CONSCIOUS
	buttontooltipstyle = "clockcult"
	var/cooldown = 0
	var/obj/item/clockwork/weapon/weapon_type //The type of weapon to create
	var/obj/item/clockwork/weapon/weapon

/datum/action/innate/call_weapon/IsAvailable(silent = FALSE)
	if(!is_servant_of_ratvar(owner))
		qdel(src)
		return
	if(cooldown > world.time)
		return
	return ..()

/datum/action/innate/call_weapon/Activate()
	if(!owner.get_empty_held_indexes())
		to_chat(usr, SPAN_WARNING("You need an empty hand to call forth your [initial(weapon_type.name)]!"))
		return
	if(weapon)
		if(weapon.loc == owner)
			owner.visible_message(SPAN_DANGER("[owner]'s [weapon.name] flickers and disappears!"))
			to_chat(owner, "<span class='brass'>You dismiss [weapon].</span>")
			QDEL_NULL(weapon)
			weapon_reset(RATVARIAN_WEAPON_COOLDOWN * 0.5)
			return
		else
			weapon.visible_message(SPAN_WARNING("[weapon] suddenly flickers and disappears!"))
			owner.visible_message(SPAN_DANGER("A [weapon.name] suddenly flickers into [owner]'s hands!"), "<span class='brass'>You recall [weapon] to you.</span>")
	else
		weapon = new weapon_type (get_turf(usr), src)
		owner.visible_message(SPAN_WARNING("A [weapon.name] materializes in [owner]'s hands!"), "<span class='brass'>You call forth your [weapon.name]!</span>")
	weapon.forceMove(get_turf(owner))
	owner.put_in_hands(weapon)
	owner.update_action_buttons_icon()
	return TRUE

/datum/action/innate/call_weapon/proc/weapon_reset(cooldown_time)
	cooldown = world.time + cooldown_time
	addtimer(CALLBACK(owner, /mob.proc/update_action_buttons_icon), cooldown_time)
	owner.update_action_buttons_icon()
	QDEL_NULL(weapon)