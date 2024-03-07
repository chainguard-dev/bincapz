
rule rename_system_binary: suspicious {
  meta:
	description = "Renames system binary"
  strings:
    $ref = /(mv|cp|ln) \/(bin|usr\/bin)\/[ \.\w\/]{0,64}/
  condition:
	$ref
}

