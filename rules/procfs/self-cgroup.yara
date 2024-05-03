
rule pid_self_cgroup : notable {
	meta:
		description = "accesses /proc files within own cgroup"
	strings:
		$val = /\/proc\/self\/cgroup[a-z\/\-]{0,32}/
	condition:
		any of them
}
