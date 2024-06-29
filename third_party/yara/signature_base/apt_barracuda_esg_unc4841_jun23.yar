
rule APT_UNC4841_ESG_Barracuda_CVE_2023_2868_Forensic_Artifacts_Jun23_1 : SCRIPT {
   meta:
      description = "Detects forensic artifacts found in the exploitation of CVE-2023-2868 in Barracuda ESG devices by UNC4841"
      author = "Florian Roth"
      reference = "https://www.mandiant.com/resources/blog/barracuda-esg-exploited-globally"
      date = "2023-06-15"
      modified = "2023-06-16"
      score = 75
      id = "50518fa1-33de-5fe5-b957-904d976fb29a"
   strings:
      $x01 = "=;ee=ba;G=s;_ech_o $abcdefg_${ee}se64" ascii
      $x02 = ";echo $abcdefg | base64 -d | sh" ascii
      $x03 = "setsid sh -c \"mkfifo /tmp/p" ascii
      $x04 = "sh -i </tmp/p 2>&1" ascii
      $x05 = "if string.match(hdr:body(), \"^[%w%+/=" ascii
      $x06 = "setsid sh -c \"/sbin/BarracudaMailService eth0\""
      $x07 = "echo \"set the bvp ok\""
      $x08 = "find ${path} -type f ! -name $excludeFileNameKeyword | while read line ;"
      $x09 = " /mail/mstore | xargs -i cp {} /usr/share/.uc/"
      $x10 = "tar -T /mail/mstore/tmplist -czvf "

      $sa1 = "sh -c wget --no-check-certificate http"
      $sa2 = ".tar;chmod +x "
   condition:
      1 of ($x*)
      or all of ($sa*)
}

rule APT_MAL_UNC4841_SEASPY_Jun23_1 {
   meta:
      description = "Detects SEASPY malware used by UNC4841 in attacks against Barracuda ESG appliances exploiting CVE-2023-2868"
      author = "Florian Roth"
      reference = "https://blog.talosintelligence.com/alchimist-offensive-framework/"
      date = "2023-06-16"
      score = 85
      hash1 = "3f26a13f023ad0dcd7f2aa4e7771bba74910ee227b4b36ff72edc5f07336f115"
      id = "bcff58f8-87f6-5371-8b96-5d4c0f349000"
   strings:
      $sx1 = "usage: ./BarracudaMailService <Network-Interface>. e.g.: ./BarracudaMailService eth0" ascii fullword
      $s1 = "fcntl.tmp.amd64." ascii
      $s2 = "Child process id:%d" ascii fullword
      $s3 = "[*]Success!" ascii fullword
      $s4 = "NO port code" ascii
      $s5 = "enter open tty shell" ascii

      $op1 = { 48 89 c6 f3 a6 0f 84 f7 01 00 00 bf 6c 84 5f 00 b9 05 00 00 00 48 89 c6 f3 a6 0f 84 6a 01 00 00 }
      $op2 = { f3 a6 0f 84 d2 00 00 00 48 89 de bf 51 5e 61 00 b9 05 00 00 00 f3 a6 74 21 48 89 de }
      $op3 = { 72 de 45 89 f4 e9 b8 f4 ff ff 48 8b 73 08 45 85 e4 ba 49 3d 62 00 b8 44 81 62 00 48 0f 45 d0 }
   condition:
      uint16(0) == 0x457f
      and filesize < 9000KB
      and 3 of them
      or 5 of them
}

rule APT_MAL_UNC4841_SEASPY_LUA_Jun23_1 {
   meta:
      description = "Detects SEASPY malware related LUA script"
      author = "Florian Roth"
      reference = "https://blog.talosintelligence.com/alchimist-offensive-framework/"
      date = "2023-06-16"
      score = 90
      hash1 = "56e8066bf83ff6fe0cec92aede90f6722260e0a3f169fc163ed88589bffd7451"
      id = "a44861d0-107e-589b-8cf1-3fbc2f5c78dc"
   strings:
      $x1 = "os.execute('rverify'..' /tmp/'..attachment:filename())" ascii fullword
      $x2 = "log.debug(\"--- opening archive [%s], mimetype [%s]\", tmpfile" ascii fullword

      $xe1 = "os.execute('rverify'..' /tmp/'..attachment:filename())" ascii base64
      $xe2 = "log.debug(\"--- opening archive [%s], mimetype [%s]\", tmpfile" ascii base64
   condition:
      filesize < 500KB and 1 of them
}

rule APT_HKTL_Proxy_Tool_Jun23_1 {
   meta:
      description = "Detects agent used as proxy tool in UNC4841 intrusions - possibly Alchemist C2 framework implant"
      author = "Florian Roth"
      reference = "https://www.mandiant.com/resources/blog/barracuda-esg-exploited-globally"
      date = "2023-06-16"
      score = 75
      hash1 = "ca72fa64ed0a9c22d341a557c6e7c1b6a7264b0c4de0b6f717dd44bddf550bca"
      hash2 = "57e4b180fd559f15b59c43fb3335bd59435d4d76c4676e51a06c6b257ce67fb2"
      id = "0e406737-3083-53c2-a6d2-14c07794125a"
   strings:
      //$a1 = "Go build" // not available in all samples
      $a2 = "/src/runtime/panic.go"

      $s1 = "main.handleClientRequest" ascii fullword
      $s2 = "main.sockIP.toAddr" ascii fullword
      // $s3 = "main.slave" ascii fullword
   condition:
      (
         uint16(0) == 0x5a4d // Windows PE
         or uint32be(0) == 0x7f454c46 // ELF
         or uint16(0) == 0xfeca or uint16(0) == 0xfacf or uint32(0) == 0xbebafeca or uint32(0) == 0xbebafeca // MacOS
      )
      and filesize < 10MB
      and all of them
}

rule SUSP_FScan_Port_Scanner_Output_Jun23 : SCRIPT {
   meta:
      description = "Detects output generated by the command line port scanner FScan"
      author = "Florian Roth"
      reference = "https://www.mandiant.com/resources/blog/barracuda-esg-exploited-globally"
      date = "2023-06-15"
      score = 70
      id = "7eb4b27f-0c5b-5d7e-b759-95d7894d5822"
   strings:
      $s1 = "[*] NetInfo:" ascii
      $s2 = ":443 open" ascii
      $s3 = "   [->]"
   condition:
      filesize < 800KB and all of them
}

rule SUSP_PY_Shell_Spawn_Jun23_1 : SCRIPT {
   meta:
      description = "Detects suspicious one-liner to spawn a shell using Python"
      author = "Florian Roth"
      reference = "https://www.mandiant.com/resources/blog/barracuda-esg-exploited-globally"
      date = "2023-06-15"
      score = 70
      id = "15fd2c9a-c425-5d4d-9209-fd3826074d6c"
   strings:
      $x1 = "python -c import pty;pty.spawn(\"/bin/" ascii
   condition:
      1 of them
}

/* Mandiant Rules */
/* Source: https://www.mandiant.com/resources/blog/barracuda-esg-exploited-globally */

rule APT_MAL_Hunting_LUA_SEASIDE_1 {
    meta:
        description = "Hunting rule looking for strings observed in SEASIDE samples."
        author = "Mandiant"
        date = "2023-06-15"
        score = 70
        reference = "https://www.mandiant.com/resources/blog/barracuda-esg-exploited-globally"
        hash = "cd2813f0260d63ad5adf0446253c2172"
        id = "86eaff7b-4ca0-53cd-8886-da66a36c778f"
    strings:
        $s1 = "function on_helo()"
        $s2 = "local bindex,eindex = string.find(helo,'.onion')"
        $s3 = "helosend = 'pd'..' '..helosend"
        $s4 = "os.execute(helosend)"
    condition:
        filesize < 1MB and all of ($s*)
}

rule APT_MAL_LNX_Hunting_Linux_WHIRLPOOL_1 {
    meta:
        description = "Hunting rule looking for strings observed in WHIRLPOOL samples."
        author = "Mandiant"
        date = "2023-06-15"
        score = 70
        reference = "https://www.mandiant.com/resources/blog/barracuda-esg-exploited-globally"
        hash = "177add288b289d43236d2dba33e65956"
        id = "a997bd65-c502-53a0-8bb8-62daaa916f0d"
    strings:
        $s1 = "error -1 exit" fullword
        $s2 = "create socket error: %s(error: %d)\n" fullword
        $s3 = "connect error: %s(error: %d)\n" fullword
        $s4 = {C7 00 20 32 3E 26 66 C7 40 04 31 00}
        $c1 = "plain_connect" fullword
        $c2 = "ssl_connect" fullword
        $c3 = "SSLShell.c" fullword
    condition:
        uint32(0) == 0x464c457f and filesize < 15MB and (all of ($s*) or all of ($c*))
}

rule APT_MAL_LUA_Hunting_SKIPJACK_1 {
    meta:
        author = "Mandiant"
        date = "2023-06-15"
        reference = "https://www.mandiant.com/resources/blog/barracuda-esg-exploited-globally"
        description = "Hunting rule looking for strings observed in SKIPJACK installation script."
        hash = "e4e86c273a2b67a605f5d4686783e0cc"
        score = 70
        id = "0026375c-7f37-5ef9-bd55-5b9fc499e5d2"
    strings:
        $str1 = "hdr:name() == 'Content-ID'" base64
        $str2 = "hdr:body() ~= nil" base64
        $str3 = "string.match(hdr:body(),\"^[%w%+/=\\r\\n]+$\")" base64
        $str4 = "openssl aes-256-cbc" base64
        $str5 = "mod_content.lua"
        $str6 = "#!/bin/sh"
    condition:
        all of them
}

rule APT_MAL_LUA_Hunting_Lua_SKIPJACK_2 {
    meta:
        author = "Mandiant"
        date = "2023-06-15"
        reference = "https://www.mandiant.com/resources/blog/barracuda-esg-exploited-globally"
        description = "Hunting rule looking for strings observed in SKIPJACK samples."
        hash = "87847445f9524671022d70f2a812728f"
        score = 70
        id = "e1eac294-fe60-5bb2-bae4-0f7bcbe6b1db"
    strings:
        $str1 = "hdr:name() == 'Content-ID'"
        $str2 = "hdr:body() ~= nil"
        $str3 = "string.match(hdr:body(),\"^[%w%+/=\\r\\n]+$\")"
        $str4 = "openssl aes-256-cbc"
        $str5 = "| base64 -d| sh 2>"
    condition:
        all of them
}
rule APT_MAL_LUA_Hunting_Lua_SEASPRAY_1 {
    meta:
        author = "Mandiant"
        date = "2023-06-15"
        reference = "https://www.mandiant.com/resources/blog/barracuda-esg-exploited-globally"
        description = "Hunting rule looking for strings observed in SEASPRAY samples."
        hash = "35cf6faf442d325961935f660e2ab5a0"
        score = 70
        id = "8c744b85-b61e-56d0-8a9e-ae6a954e1b95"
    strings:
        $str1 = "string.find(attachment:filename(),'obt075') ~= nil"
        $str2 = "os.execute('cp '..tostring(tmpfile)..' /tmp/'..attachment:filename())"
        $str3 = "os.execute('rverify'..' /tmp/'..attachment:filename())"
    condition:
        all of them
}
