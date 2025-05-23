// Set a client's focus to an object and override these procs on that object to let it handle keypresses
/// Called when a key is pressed down initially
/datum/proc/key_down(key, client/user, full_key)
	SHOULD_CALL_PARENT(TRUE)
	return

/// Called when a key is released
/datum/proc/key_up(key, client/user)
	return

/// Called once every frame
/datum/proc/keyLoop(client/user)
	set waitfor = FALSE
	return

/// removes all the existing macros
/client/proc/erase_all_macros()
	var/erase_output = ""
	var/list/macro_set = params2list(winget(src, "default.*", "command")) // The third arg doesnt matter here as we're just removing them all
	for(var/k in 1 to length(macro_set))
		var/list/split_name = splittext(macro_set[k], ".")
		var/macro_name = "[split_name[1]].[split_name[2]]" // [3] is "command"
		erase_output = "[erase_output];[macro_name].parent=null"
	winset(src, null, erase_output)


/client/proc/set_macros()
	set waitfor = FALSE

	//Reset the buffer
	for(var/key in keys_held)
		keyUp(key)

	erase_all_macros()

	var/list/macro_set = SSinput.macro_set
	for(var/k in 1 to length(macro_set))
		var/key = macro_set[k]
		var/command = macro_set[key]
		winset(src, "default-[REF(key)]", "parent=default;name=[key];command=[command]")

	winset(src, null, "map.focus=true")

	update_special_keybinds()
