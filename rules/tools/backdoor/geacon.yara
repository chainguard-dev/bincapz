
rule c2_geacon_cobalt_strike : critical {
  meta:
    description = "Geacon is a Cobalt Strike beacon"
  strings:
    $geacon_coded = "geacon coded"
    $geacon = "geacon/"
    $darkr4y = "darkr4y"
    $cuz = "cuz life is shit"
    $packet_change = "packet.ChangeCurrentDir"
    $convert_str = "ConvertStr2GBK"
    $fake_ie = "Mozilla/5.0 (Windows NT 10.0; Win64; x64)"
  condition:
    filesize < 20971520 and 2 of them
}
