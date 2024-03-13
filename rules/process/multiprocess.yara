
rule py_multiprocessing : notable {
	meta:
		syscall = "pthread_create"
		description = "uses python multiprocessing"
	strings:
		$ref = "multiprocessing"
	condition:
		any of them
}
