rule ref {
	meta:
		description = "Elliptic curve algorithm used by TLS and SSH"
	strings:
		$ref = "ed25519"
	condition:
		any of them
}
