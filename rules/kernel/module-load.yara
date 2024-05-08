
rule init_module : notable {
  meta:
    description = "Load Linux kernel module"
    syscall = "init_module"
    capability = "CAP_SYS_MODULE"
    hash_2023_Linux_Malware_Samples_5d63 = "5d637915abc98b21f94b0648c552899af67321ab06fb34e33339ae38401734cf"
    hash_2023_Linux_Malware_Samples_b82d = "b82d4d3d7f3a31bf2ad88315f52cb544aa4d9b786e3db61fdfabd25a790de410"
    hash_2023_LQvKibDTq4_diamorphine = "e93e524797907d57cb37effc8ebe14e6968f6bca899600561971e39dfd49831d"
  strings:
    $ref = "init_module" fullword
  condition:
    all of them
}

rule kernel_module_loader : suspicious {
  meta:
    hash_2023_init_d_vm_agent = "663b75b098890a9b8b02ee4ec568636eeb7f53414a71e2dbfbb9af477a4c7c3d"
    hash_2023_rc0_d_K70vm_agent = "663b75b098890a9b8b02ee4ec568636eeb7f53414a71e2dbfbb9af477a4c7c3d"
    hash_2023_rc1_d_K70vm_agent = "663b75b098890a9b8b02ee4ec568636eeb7f53414a71e2dbfbb9af477a4c7c3d"
  strings:
    $insmod = /insmod [ \$\%\w\.\/_-]{1,32}\.ko/
  condition:
    all of them
}
