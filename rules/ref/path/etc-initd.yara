rule etc_initd : medium {
  meta:
    description = "references /etc/init.d"
  strings:
    $ref = /etc\/init\.d\/[\w\/\.]{0,32}/ fullword
  condition:
    any of them
}

rule etc_initd_short_file : high {
  meta:
    description = "references short filename within /etc/init.d"
  strings:
    $ref = /etc\/init\.d\/[\w\.]{2,4}/ fullword
  condition:
    any of them
}
