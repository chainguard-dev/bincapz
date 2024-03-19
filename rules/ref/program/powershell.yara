rule powershell : notable {
  strings:
	$val = /powershell[ \w\-]{0,32}/ fullword
	$not_completions = "powershell_completion"
  condition:
	$val and none of ($not*)
}