
rule fake_user_agent_msie : suspicious {
  meta:
	description = "pretends to be MSIE"
  strings:
    $u_MSIE = /compatible; MSIE[ \;\(\)\w]{0,32}/
    $u_msie = /compatible; msie[ \;\(\)\w]{0,32}/
    $u_msie2 = /MSIE 9.0{/
	$not_access_log = "\"GET http://"
	$not_pixel = "Pixel 5"
	$not_ipad = "iPad Mini"
  condition:
    any of ($u_*) and none of ($not_*)
}

rule fake_user_agent_khtml_val : suspicious {
  strings:
    $u_khtml = /KHTML, like Gecko\w Version\/\d+.\d+ Safari/
    $not_nuclei = "NUCLEI_TEMPLATES"
    $not_electron = "ELECTRON_RUN_AS_NODE"
	$not_access_log = "\"GET http://"
  condition:
    any of ($u_*) and none of ($not_*)
}


rule fake_user_agent_chrome : notable {
  strings:
    $u_chrome = "(KHTML, like Gecko) Chrome"
    $not_nuclei = "NUCLEI_TEMPLATES"
    $not_electron = "ELECTRON_RUN_AS_NODE"
	$not_access_log = "\"GET http://"
  condition:
    any of ($u_*) and none of ($not_*)
}

rule fake_user_agent_wordpress : suspicious {
  strings:
    $u_wordpress = "User-Agent: Internal Wordpress RPC connection"
    $not_nuclei = "NUCLEI_TEMPLATES"
    $not_electron = "ELECTRON_RUN_AS_NODE"
	$not_access_log = "\"GET http://"
  condition:
    any of ($u_*) and none of ($not_*)
}

rule fake_user_agent_firefox : notable {
  strings:
    $u_gecko = "Gecko/20"
    $not_nuclei = "NUCLEI_TEMPLATES"
    $not_electron = "ELECTRON_RUN_AS_NODE"
	$not_access_log = "\"GET http://"
  condition:
    any of ($u_*) and none of ($not_*)
}

rule fake_user_agent_netscape {
	strings:
		$u_mozilla = "Mozilla/4" fullword
		$not_access_log = "\"GET http://"
  	condition:
    	any of ($u_*) and none of ($not_*)
}


rule fake_user_agent_curl {
	strings:
		$u_curl = "User-Agent: curl/"
		$not_access_log = "\"GET http://"
  	condition:
    	any of ($u_*) and none of ($not_*)
}

rule elf_faker_val : notable {
  meta:
	description = "Fake user agent"
  strings:
	$val = /Mozilla\/5[\.\w ]{4,64}/
  condition:
    uint32(0) == 1179403647 and $val
}


rule lowercase_mozilla_val : suspicious {
  meta:
	description = "Fake user agent"
  strings:
	$ref = /mozilla\/\d{1,2}\.[\.\w ]{0,32}/
  condition:
	$ref
}
