rule tty_shell : suspicious {
  meta:
    hash_2023_trojan_seaspy_barracuda = "3f26a13f023ad0dcd7f2aa4e7771bba74910ee227b4b36ff72edc5f07336f115"
  strings:
    $s_tty_shell = "tty shell" nocase
    $s_SSLshell = /SSL *Shell/ nocase
    $s_shellChannel = "ShellChannel"
    $not_login = "login_shell"
  condition:
    filesize < 26214400 and any of ($s*) and none of ($not*)
}

rule python_pty_spawner : suspicious {
  meta:
    ref1 = "https://juggernaut-sec.com/docker-breakout-lpe/"
    ref2 = "https://www.mandiant.com/resources/blog/barracuda-esg-exploited-globally"
  strings:
    $pty_spawn_bash = /pty.spawn\(\"\/bin\/[\w\" -\)]{,16}/
  condition:
    any of them
}