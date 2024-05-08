
rule diamorphine_linux_kernel_rootkit : critical {
  meta:
    ref = "https://github.com/m0nad/Diamorphine"
  strings:
    $pfx_hacked_getdents = "hacked_getdents"
    $pfx_original_getdents = "original_getdents"
    $pfx_give_root = "give_root"
    $pfx_hacked_kill = "hacked_kill"
    $pfx_module_show = "module_show"
    $pfx_is_invisible = "is_invisible"
  condition:
    4 of them
}
