
rule usbmon_webproxy_zipper {
  strings:
    $usbmon = "usbmon" fullword
    $webproxy = "WebProxy"
    $web_proxy = "webproxy"
    $zip = "zip" fullword
  condition:
    $usbmon and $zip and any of ($web*)
}
