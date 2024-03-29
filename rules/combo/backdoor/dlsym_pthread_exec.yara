
rule dlsym_pthread_exec: suspicious {
	meta:
		description = "Resolves library, creates threads, calls programs"
	strings:
		$dlsym = "dlsym" fullword
		$openpty = "pthread_create" fullword
		$system = "execl" fullword
	condition:
		all of them in (1200..3000)
}
