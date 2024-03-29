
rule memfd_create : notable {
	meta:
		syscall = "memfd_create"
		description = "create an anonymous file"
		capability = "CAP_IPC_LOCK"
	strings:
		$ref = "memfd_create" fullword
	condition:
		any of them
}
