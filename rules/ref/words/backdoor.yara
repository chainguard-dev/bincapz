
rule backdoor : suspicious {
  meta:
    description = "References a 'backdoor'"
    hash_2023_UPX_0c25a05bdddc144fbf1ffa29372481b50ec6464592fdfb7dec95d9e1c6101d0d_elf_x86_64 = "818b80a08418f3bb4628edd4d766e4de138a58f409a89a5fdba527bab8808dd2"
    hash_2023_FontOnLake_27E868C0505144F0708170DF701D7C1AE8E1FAEA_elf = "d7ad1bff4c0e6d094af27b4d892b3398b48eab96b64a8f8a2392e26658c63f30"
    hash_2023_FontOnLake_45E94ABEDAD8C0044A43FF6D72A5C44C6ABD9378_elf = "f60c1214b5091e6e4e5e7db0c16bf18a062d096c6d69fe1eb3cbd4c50c3a3ed6"
  strings:
    $ref = /[a-zA-Z\-_ ]{0,16}backdoor[a-zA-Z\-_ ]{0,16}/ fullword
    $ref2 = /[a-zA-Z\-_ ]{0,16}BACKDOOR[a-zA-Z\-_ ]{0,16}/ fullword
    $ref3 = /[a-zA-Z\-_ ]{0,16}Backdoor[a-zA-Z\-_ ]{0,16}/
    $ref4 = /[a-zA-Z\-_ ]{0,16}backd00r[a-zA-Z\-_ ]{0,16}/
  condition:
    any of them
}
