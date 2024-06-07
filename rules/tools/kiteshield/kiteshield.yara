rule kiteshield : high {
  meta:
    author = "Alex.Turing, Wang Hao"
    date = "2024-05-28"
    description = "Rule to identify files packed by Kiteshield"
    hash_amdc6766_1 = "4d79e1a1027e7713180102014fcfb3bf"
    hash_amdc6766_2 = "2c80808b38140f857dc8b2b106764dd8"
    hash_amdc6766_3 = "a42249e86867526c09d78c79ae26191d"
    hash_amdc6766_4 = "909c015d5602513a770508fa0b87bc6f"
    hash_amdc6766_5 = "57f7ffaa0333245f74e4ab68d708e14e"
    hash_amdc6766_6 = "5ea33d0655cb5797183746c6a46df2e9"
    hash_amdc6766_7 = "7671585e770cf0c856b79855e6bdca2a"
    hash_gafgyt_1 = "4afedf6fbf4ba95bbecc865d45479eaf"
    hash_gafgyt_2 = "5c9887c51a0f633e3d2af54f788da525"
    hash_winnti_1 = "f5623e4753f4742d388276eaee72dea6"
    hash_winnti_2 = "951fe6ce076aab5ca94da020a14a8e1c"
    reference = "https://blog.xlab.qianxin.com/kiteshield_packer_is_being_abused_by_linux_cyber_threat_actors"
    tool = "Kiteshield"
    tool_repository = "https://github.com/GunshipPenguin/kiteshield"
    
  strings: 
    $loader_jmp = {31 D2 31 C0 31 C9 31 F6 31 FF 31 ED 45 31 C0 45 31 C9 45 31 D2 45 31 DB 45 31 E4 45 31 ED 45 31 F6 45 31 FF 5B FF E3}
    // "/proc/%d/status"
    $loader_s1 = {ac f4 f7 e9 e4 a7 ac ee a4 ff f9 ef fb e5 e2}
    // "TracerPid:"
    $loader_s2 = {d7 f6 e4 e5 e2 fa d9 e3 ef b6}
    // "/proc/%d/stat"
    $loader_s3 = {ac f4 f7 e9 e4 a7 ac ee a4 ff f9 ef fb}
    // "LD_PRELOAD"
    $loader_s4 = {cf c0 da d6 d5 cd c5 c5 ca c8}
    // "LD_AUDIT"
    $loader_s5 = {cf c0 da c7 d2 cc c0 de}
    // "LD_DEBUG"
    $loader_s6 = {cf c0 da c2 c2 ca dc cd}
    // "0123456789abcdef"
    $loader_s7 = {b3 b5 b7 b5 b3 bd bf bd b3 b5 ec ec ec f4 f4 f4}
    // Elf Magic
    $elf_magic = {7f 45 4c 46}
    // ET_EXEC
    $et_exec = {02 00}
    // EM_X86_64
    $em_x86_64 = {3e 00}
    // EM_AARCH64
    $em_aarch64 = {b7 00}

  condition:
    $loader_jmp and all of ($loader_s*) and $elf_magic and $et_exec and any of ($em_*)
}
