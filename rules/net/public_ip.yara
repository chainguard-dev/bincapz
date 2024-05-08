
rule iplookup_website_value : suspicious {
  meta:
    description = "public service to discover external IP address"
    hash_2023_Unix_Coinminer_Xanthe_7ea1 = "7ea112aadebb46399a05b2f7cc258fea02f55cf2ae5257b331031448f15beb8f"
    hash_2023_Unix_Trojan_Ipstorm_1996 = "1996927b41960a2af8e49cf745ed6668bc5b8d7855c2bb116f98104163e29000"
    hash_2023_Unix_Trojan_Ipstorm_2f6f = "2f6f44e3e2baf701ae1ee3826986f89df4e5314c8ba50615fb6580f1ef54c830"
  strings:
    $ipify = "ipify.org"
    $wtfismyip = "wtfismyip"
    $iplogger = "iplogger.org"
    $getjsonip = "getjsonip"
    $ipconfig_me = "ifconfig.me"
    $icanhazip = "icanhazip"
    $ident_me = "ident.me" fullword
    $showip_net = "showip.net" fullword
    $ifconfig_io = "ifconfig.io" fullword
    $ifconfig_co = "ifconfig.co" fullword
    $ipinfo = "ipinfo.io"
    $ipify_b = "ipify.org" base64
    $wtfismyip_b = "wtfismyip" base64
    $iplogger_b = "iplogger.org" base64
    $getjsonip_b = "getjsonip" base64
    $ipinfo_b = "ipinfo.io" base64
    $ipify_x = "ipify.org" xor(1-255)
    $wtfismyip_x = "wtfismyip" xor(1-255)
    $iplogger_x = "iplogger.org" xor(1-255)
    $getjsonip_x = "getjsonip" xor(1-255)
    $ipinfo_x = "ipinfo.io" xor(1-255)
  condition:
    any of them
}

rule iplookup_website_base64 : critical {
  meta:
    description = "public service to discover external IP address"
  strings:
    $ipify_b = "ipify.org" base64
    $wtfismyip_b = "wtfismyip" base64
    $iplogger_b = "iplogger.org" base64
    $getjsonip_b = "getjsonip" base64
    $ipinfo_b = "ipinfo.io" base64
  condition:
    any of them
}

rule iplookup_website_xor : critical {
  meta:
    description = "public service to discover external IP address"
  strings:
    $ipify_x = "ipify.org" xor(1-255)
    $wtfismyip_x = "wtfismyip" xor(1-255)
    $iplogger_x = "iplogger.org" xor(1-255)
    $getjsonip_x = "getjsonip" xor(1-255)
    $ipinfo_x = "ipinfo.io" xor(1-255)
  condition:
    any of them
}

rule python_list_comprehension : suspicious {
  meta:
    description = "discover IP address via socket connection"
  strings:
    $ref = "[socket.socket(socket.AF_INET, socket.SOCK_DGRAM"
  condition:
    any of them
}
