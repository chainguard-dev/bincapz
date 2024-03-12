rule discord_password_post_chat : suspicious {
  meta:
	description = "gets passwords, makes HTTP requests, and uses Telegram"
  strings:
	$c3 = "api.telegram"
	$c4 = "Telegram"

	$h1 = "get("
	$h2 = "post("
	$h3 = "GET"
	$h4 = "POST"
	$h5 = "https://"
	$h6 = "x-www-form-urlencoded"

	$p1 = "password"
	$p2 = "Password"
	$p3 = "credentials"
	$p4 = "creds" 
  condition:
	any of ($c*) and any of ($h*) and any of ($p*)
}