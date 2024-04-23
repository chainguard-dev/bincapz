rule execall : notable {
	meta:
		syscall = "execve"
		pledge = "exec"
		description = "executes external programs"
	strings:
		$execl = "execl" fullword
		$execle = "execle" fullword
		$execlp = "execlp" fullword
		$execv = "execv" fullword
		$execvp = "execvp" fullword
		$execvP = "execvP" fullword

		$go = "syscall.libc_execve_trampoline"
	condition:
		any of ($exec*) and not $go
}

rule execve : notable {
	meta:
		syscall = "execve"
		pledge = "exec"
		description = "executes external programs"
	strings:
		$execve = "execve" fullword
		$go = "syscall.libc_execve_trampoline"
		$execve_f = "fexecve" fullword
	condition:
		any of ($exec*) and not $go
}

rule exec_cmd_run : notable {
	meta:
		syscall = "execve"
		pledge = "exec"
		description = "executes external programs"
	strings:
		$ref = "exec.(*Cmd).Run"
		$ref2 = ").CombinedOutput"
	condition:
		any of them
}


rule perl_system : notable {
	meta:
		syscall = "execve"
		pledge = "exec"
		description = "executes external programs"
	strings:
		$ref = "system("
	condition:
		all of them
}


rule subprocess : notable {
	meta:
		syscall = "execve"
		pledge = "exec"
		description = "execute external program"
		ref = "https://man7.org/linux/man-pages/man2/execve.2.html"
	strings:
		$naked = "subprocess"
		$val = /subprocess\.\w{1,16}[\(\"\/\w\'\.\- \,\[\]]{0,64}/
	condition:
		any of them
}


rule posix_spawn : notable {
	meta:
		syscall = "posix_spawn"
		pledge = "exec"
		description = "spawn a process"
		ref = "https://man7.org/linux/man-pages/man3/posix_spawn.3.html"
	strings:
		$ref = "posix_spawn"
	condition:
		all of them
}


rule go_exec : notable {
	meta:
		syscall = "posix_spawn"
		pledge = "exec"
		description = "run external command"
		ref = "https://pkg.go.dev/os/exec"
	strings:
		$ref = "exec_unix.go"
	condition:
		all of them
}

rule npm_exec : notable {
	meta:
		syscall = "posix_spawn"
		pledge = "exec"
		description = "spawn a process"
		ref = "https://nodejs.org/api/child_process.html"
	strings:
		$child = "child_process"
		$ref_val = /exec\([\'\"][\w \/\'\)]{0,64}/
	condition:
		all of them
}
