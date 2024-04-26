rule progname : notable {
	meta:
		description = "get the current process name"
		ref = "https://linux.die.net/man/3/program_invocation_short_name"
	strings:
		$ref = "program_invocation_short_name"
	condition:
		any of them in (1200..3000)
}

rule process_name : notable {
	meta:
		description = "get the current process name"
	strings:
		$ref = "processName"
		$ref2 = "process_name"
	condition:
		any of them
}