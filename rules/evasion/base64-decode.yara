rule base64_decode : notable python {
  meta:
	description = "decode base64 strings"
	ref = "https://docs.python.org/3/library/base64.html"
  strings:
	$b64decode = "b64decode"
  condition:
	any of them
}

rule urlsafe_decode64 : notable ruby {
  meta:
	description = "decode base64 strings"
	ref = "https://ruby-doc.org/3.3.0/stdlibs/base64/Base64.html"
  strings:
	$urlsafe_decode64_ruby = "urlsafe_decode64"
  condition:
	any of them
}

rule powershell_decode : notable {
  meta:
	description = "decode base64 strings"
	ref = "https://learn.microsoft.com/en-us/dotnet/api/system.convert.frombase64string?view=net-8.0"
  strings:
	$ref = "[System.Convert]::FromBase64String" ascii
  condition:
	any of them
}
