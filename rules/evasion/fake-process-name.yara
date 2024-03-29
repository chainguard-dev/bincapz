rule fake_kworker : critical {
  meta:
	description = "Pretends to be a kworker kernel thread"
  strings:
	$kworker = /\[{0,1}kworker\/[\d:\]]{1,5}/
	$kworker2 = "kworker" fullword
	$kworker3 = "[kworker"
  condition:
	any of them
}

rule fake_syslogd : critical {
  meta:
	description = "Pretends to be syslogd"
  strings:
	$ref = "[syslogd]"
  condition:
	any of them
}

rule bash_sets_name : critical {
  meta:
	description = "uses 'exec -a' to set a process name"
	ref = "https://www.jamf.com/blog/cryptojacking-macos-malware-discovered-by-jamf-threat-labs/"
  strings:
	$ref = "exec -a"
  condition:
	any of them
}