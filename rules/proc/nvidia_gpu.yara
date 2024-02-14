
rule proc_nvidia_gpus : notable {
	meta:
		description = "get GPU info"
	strings:
		$ref = "/proc/driver/nvidia/gpus" fullword
	condition:
		any of them
}
