rule github_raw_usercontent : notable {
  meta:
    hash_2018_MacOS_CoinTicker = "c344730f41f52a2edabf95730389216a9327d6acc98346e5738b3eb99631634d"
	description = "References raw.githubusercontent.com"
  strings:
    $raw_github = "raw.githubusercontent.com"
    $not_node = "NODE_DEBUG_NATIVE"
  condition:
	$raw_github and $not_node
}


rule github_raw_user : notable {
  meta:
    hash_2018_MacOS_CoinTicker = "c344730f41f52a2edabf95730389216a9327d6acc98346e5738b3eb99631634d"
  strings:
    $github = "github.com"
    $raw_master = "raw/master"
    $raw_main = "raw/main"
    $not_node = "NODE_DEBUG_NATIVE"
  condition:
    $github and any of ($raw*) and none of ($not*)
}

