
rule metasploit : notable {
  meta:
    description = "Has references to Minecraft"
    hash_2023_UPX_0c25a05bdddc144fbf1ffa29372481b50ec6464592fdfb7dec95d9e1c6101d0d_elf_x86_64 = "818b80a08418f3bb4628edd4d766e4de138a58f409a89a5fdba527bab8808dd2"
  strings:
    $val1 = "minecraft" fullword
    $val2 = "Minecraft" fullword
    $val3 = "MINECRAFT" fullword
  condition:
    any of them
}
