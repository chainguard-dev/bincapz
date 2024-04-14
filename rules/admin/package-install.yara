rule yum_installer : notable {
  meta:
	description = "Installs software using yum"
  strings:
    $val = /yum install[ \w\-\_%]{0,32}/
  condition:
	$val
}

rule dnf_installer : notable {
  meta:
	description = "Installs software using dnf"
  strings:
    $val = /dnf install[ \w\-\_%]{0,32}/
  condition:
	$val
}

rule rpm_installer : notable {
  meta:
	description = "Installs software using rpm"
  strings:
    $val = /rpm -i[ \w\-\_%]{0,32}/
  condition:
	$val
}

rule apt_installer : notable {
  meta:
	description = "Installs software using apt"
  strings:
    $val = /apt install[ \w\-\_%]{0,32}/
  condition:
	$val
}

rule apt_get_installer : notable {
  meta:
	description = "Installs software using apt-get"
  strings:
    $val = /apt-get install[ \w\-\_%]{0,32}/

	$foo = "install foo"
  condition:
	$val and not $foo
}

rule apk_installer : notable {
  meta:
	description = "Installs software using APK"
  strings:
    $val = /apk add[ \w\-\_%]{0,32}/
  condition:
	$val
}

rule pip_installer_regex : notable {
  meta:
	description = "Includes 'pip install' command for installing Python modules"
  strings:
    $regex = /pip[3 \'\"]{0,5}install[ \'\"\w\-\_%]{0,32}/
  condition:
	any of them
}
