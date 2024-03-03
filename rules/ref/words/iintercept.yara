rule interceptor : suspicious {
	meta:
		description = "References interception"
	strings:
		$ref = /intercept[\w\_]{0,64}/ fullword
	condition:
		any of them
}