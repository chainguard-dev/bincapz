rule ransomware_mention : suspicious {
	meta:
		description = "Mentions ransomware"
	strings:
		$ransomware = "ransomware"
		$locker = "locker encrypt"
	condition:
		any of them
}


rule ransom_detection {
  meta:
    hash_2020_gonnacry = "f5de75a6db591fe6bb6b656aa1dcfc8f7fe0686869c34192bfa4ec092554a4ac"
    hash_2023_RedAlert_redniev = "039e1765de1cdec65ad5e49266ab794f8e5642adb0bdeb78d8c0b77e8b34ae09"
    hash_2023_HelloKitty_A = "556e5cb5e4e77678110961c8d9260a726a363e00bf8d278e5302cb4bfccc3eed"
    hash_2022_babuk_conti = "8b57e96e90cd95fc2ba421204b482005fe41c28f506730b6148bcef8316a3201"
    hash_2023_Sodinokibi = "f864922f947a6bb7d894245b53795b54b9378c0f7633c521240488e86f60c2c5"
    hash_2023_LockBit_locker_Apple_M1_64 = "3e4bbd21756ae30c24ff7d6942656be024139f8180b7bddd4e5c62a9dfbd8c79"
    hash_2021_TsunamiCNC = "450a7e35f13b57e15c8f4ce1fa23025a7c313931a394c40bd9f3325b981eb8a8"
    hash_2021_trojan_Mirai_adconn = "458e3e66eff090bc5768779d5388336c8619a744f486962f5dfbf436a524ee04"
    hash_2021_Merlin_ispoh = "683e1eb35561da89db96c94f400daf41390bd350698c739c38024a1f621653b3"
    hash_2021_miner_TQ = "7955542df199c6ce4ca0bb3966dcf9cc71199c592fec38508dad58301a3298d0"
    hash_2021_miner_whnqj = "9f20d2cf098609450792723a4410c6887fdaa00e53f207671fcf1eb22d9fb008"
  strings:
    $s_data_recovery = "data recovery"
    $s_to_my_address = "to my address"
    $not_node = "NODE_DEBUG_NATIVE"
    $not_private = "/System/Library/PrivateFrameworks/"
    $not_signed = "PKCS7_SIGNED"
    $s_already_encrypted = "already encrypted"
    $s_audit = "audit of"
    $s_be_decrypted = "be decrypted"
    $s_blake2b = "blake2b"
    $s_corporate_data = "corporate data"
    $s_decrypt = "DECRYPTDIR"
    $s_decrypting = "Decrypting" fullword
    $s_decryptor = "decryptor"
    $s_enc_file = "enc_file"
    $s_enc_stage = "EncryptionStage"
    $s_encrypt_file = "encrypt file" nocase
    $s_encrypt_under_file = "encrypt_file"
    $s_encrypted = "encrypted" fullword
    $s_encrypted_caps = "ENCRYPTED"
    $s_encrypting = "Encrypting" nocase
    $s_encing = "encing"
    $s_encrypt_all = "encrypt_all"
    $s_entire_network = "entire network"
    $s_esxcli = "esxcli"
    $s_esxi = "esxi"
    $s_EVIDENCE = "EVIDENCE"
    $s_gained_full = "gained full access"
    $s_get_in_touch = "get in touch"
    $s_hi_friends = "Hi friends"
    $s_iles_txt = "iles.txt"
    $s_immediate_sale = "immediate sale"
    $s_install_tor = "install TOR"
    $s_insurance = "insurance"
    $s_is_encrypted = "s encrypted by"
    $s_key_iv = "KEY = %s IV = %s"
    $s_lck = "%s.lck"
    $s_LEAKAGE = "LEAKAGE"
    $s_leaks = "leaks" nocase fullword
    $s_live_chat = "live chat"
    $s_live_chat2 = "live-chat"
    $s_locker = "locker" nocase fullword
    $s_lose_access = "lose access"
    $s_negotiable = "negotiable"
    $s_negotiation_process = "negotiation process"
    $s_negotiations_open = "negotiations open"
    $s_negotiators = "negotiators"
    $s_our_chat = "our chat"
    $s_our_decryption = "our decryption"
    $s_our_security = "our security"
    $s_permanently = "permanently destroyed"
    $s_process_of = "already in progress"
    $s_ransom = "ransom" fullword
    $s_recover = "recover "
    $s_recoverfiles = "recoverfiles"
    $s_refuse_to_pay = "refuse to pay"
    $s_remain_silent = "remain silent"
    $s_restore_docs = "restore documents" nocase
    $s_restore_my = "restore-my"
    $s_rypted_f = "rypted_f"
    $s_this_offer = "this offer"
    $s_to_board = "board of directors"
    $s_to_decrypt = "to decrypt"
    $tor_browser = "TOR Browser" nocase
    $tor_download = "torproject.org/download"
    $tor_onion = /\w\.onion\W/
    $s_unfortunately_your = "unfortunately your" nocase
    $s_urandom = "/dev/urandom"
    $s_vulnerabilities = "vulnerabilities"
    $s_was_encrypted = "was encrypted"
    $s_we_stole = "we stole"
    $s_xlsx = "xlsx"
    $s_you_can = "You can request"
    $s_you_decide = "you decide"
    $s_you_pay = "you pay "
    $s_your_competitors = "your competitors"
    $s_your_data = "your data"
    $s_your_docs = "your documents" nocase
    $s_your_ench = "your_enc"
    $s_your_files = "your files" nocase
    $s_your_network = "Your network"
    $s_your_security = "your security"
  condition:
    filesize < 20971520 and 6 of ($s_*) and any of ($tor*) and none of ($not*)
}
