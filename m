Received: from DUZPR83CU001.outbound.protection.outlook.com (DUZPR83CU001.outbound.protection.outlook.com [52.101.66.23])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.471.1794202396092082851
 for <cip-dev@lists.cip-project.org>;
 Sun, 08 Nov 2026 21:33:17 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=ICLSs9BZ;
 spf=pass (domain: siemens.com, ip: 52.101.66.23, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BWV60wIB6wCEtv0NaLT+gj5Z9oLg3bD3hDQqgbmt2LHMHjFKUIrbC+PXQ1C2sYQYNbW8gfxZ7NWsvRPv6UICW8+fpj1gAavNnpyd0Wf/LgBv4iMt3V6P2gWw4PzCB4O6ppWQZTgdTvqoY2V/80MfuhP6rzCKp+wI3Yf9ibCGG+F1M5bwvUZUkfi97WNMiwVT06LywOy9wXpMq/cXq59nWGMoMkLN3hNtjYt4v65FnbRXnccbT/KUzkZQEdbEMAm/fBPyQLpgxere4yfoWAMgn4itj0tLdDBuAQ0fpUWedt4KryKOB7hRS75eFImwu8Uc8g9RqunB/UrN0cJR/YZPhQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QjlM/e/VIoWcfsnQaFswR8zSENjP2ADv3+/Ufq20oqo=;
 b=IxqEv2XVPPfE/6scNkjLC23DqvLYyp3oSXa4JT+ltXBBcf9qfREUhIxKeVNos5e4pt2FhYD/rCeMNwDT2ZFYr1/NNnxmW+WdD7WreYKCQ8r8IV5FjlzXlyTPNihKd/Arl4ZlGzJsj7nTyliAYww0OFU0Im33qFs8PoteJ7DNQMAENkl630GV5NtxQC9G7U5P5p4VSQ/GCrGVxvSdSuZdQW192NS4x/jFfQv3t6RxqdEQi8pK6ie/0DJsDmyCcjICS1ngdLDhQT+PDcNW3ffTwni3jajW3y02FlCLAqbfXtOkR3FR+nDUC6klWoF6+6SgF8m7WH+CJ0DSpXq2Z1tHKw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QjlM/e/VIoWcfsnQaFswR8zSENjP2ADv3+/Ufq20oqo=;
 b=ICLSs9BZtstzTMZqb0QqHAlY4XaGytexoDtIEuLWUFBkPwnPftp3HXOTTpYR+q8Pd55UNBtNlmDI7+sQ0suqPzmPZ+1WiZxpw29DNIVW7c4IwgCfUgfK3gTQjOT4a3QhlniiLpPgmcszncg1ZguES0EqrybrRTxcuVQ+2SRJh3ZPBkn6XqZTAhA87xFFx2f+xnqpv+3jV8RonnmtGSGeZhhnDIJXTbXSHoR923mM5sQUTObfK4ysh1h+c/5OElLVwvR4fsUfuDTo3dR4K0rZ24nvYXNj8rYcgYHYjX24tYdsxbMyR+UP7TpFvVOcSGJxrI3YJCvJevTtQ6ZEn2UP4A==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AMCPR10MB992291.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:785::10) by PA2PR10MB8850.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:102:422::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.5; Mon, 9 Nov 2026
 05:33:11 +0000
Received: from AMCPR10MB992291.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::fbce:789a:27cf:d1e]) by AMCPR10MB992291.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::fbce:789a:27cf:d1e%5]) with mapi id 15.21.0615.005; Mon, 9 Nov 2026
 05:33:11 +0000
Message-ID: <3d29420b-d281-4450-ae04-0e9418261dbe@siemens.com>
Date: Mon, 9 Nov 2026 06:33:10 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [isar-cip-core][PATCH] wic: de0-nano-soc: Fix serial console
 device name to ttyS0
To: Nobuhiro Iwamatsu <nobuhiro.iwamatsu.x90@mail.toshiba>
Cc: cip-dev@lists.cip-project.org
References: <1794196929-2063-1-git-send-email-nobuhiro.iwamatsu.x90@mail.toshiba>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <1794196929-2063-1-git-send-email-nobuhiro.iwamatsu.x90@mail.toshiba>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0033.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:c7::16) To AMCPR10MB992291.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:785::10)
Return-Path: jan.kiszka@siemens.com
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AMCPR10MB992291:EE_|PA2PR10MB8850:EE_
X-MS-Office365-Filtering-Correlation-Id: 72fa0acd-a28c-43d4-477f-08df3e22f1bd
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|23010399003|376014|1800799024|18002099003|22082099003|6133799003|10067099003|55112099003|11063799006|261028144727099003|261102123227099003|261022105027099003|56012099006|261021123027099003|261021121427099003|261026121527099003|261026140227099003|261009223027099003;
X-Microsoft-Antispam-Message-Info: xbdHXg1p9MHQbhaZb2IdyGbtBuZHM3+oOFbbueRynULX6aQPD/RRcHnfMC8qUL2EZ/zPBp1N0I96vx9HBc4SbM1cRCt3PdOPrPoAXx9kMvzF4mbQ0R+WX0mVQXzCqPRS3B7HjZv5fGftpxHI4LWOTRV+6dVsurst5nrzCyP6cdmbhGz3GWG94WD/p1aArhBw1Jwtel0kx4abWdt6FXai9Lx3iSabyx6Ke2He+edsI/3U4BP23UGmzkm0rPE3htCyn6eXRRB/tn5mpiy7E4EEZ1d/qameycduuU1WvtSyaKvPvYjO69g4xITOAHzM7Z7ABs5EUBiHX5EDVNHLLLCwmj4+JEZya8AwDMZ/M6S6+rAPReHq2Da/yDl1L2+KuDQq80Barej1W8PlNd5Nsta2+JnR1BSQ1xeDspxt89EgnXCsBlN+NNHMouE0OuoFwhVvs2ek3wrPJKj1d3ldzoiiNdP8OcS74TmpLArFzG93EI5YbIqA//yR3auvZWTys9oUs/qBKCfS80QZAM4Et2oVzoYhcZ6jA8MOEBQb9/L2qgkjzfPlC4SXODQELJq4DFmiQwTrZoCqwArfPsAC2Sme5keTn+aRhcHezyoyuotdMKEAO3CxCoDp7eHai1xIyUdIfmcOx+/EDpCzbiDieaJxBpb/mgkuY6E8YG4Z9GPe9R4=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AMCPR10MB992291.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(23010399003)(376014)(1800799024)(18002099003)(22082099003)(6133799003)(10067099003)(55112099003)(11063799006)(261028144727099003)(261102123227099003)(261022105027099003)(56012099006)(261021123027099003)(261021121427099003)(261026121527099003)(261026140227099003)(261009223027099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RERpNkZxMXR3TTJ0NDJrZ05xbmZwUzZEaVVVV0NUeTF1VmMvS2xNUTE1Z090?=
 =?utf-8?B?aDcyWUJseERmRHgzd1JmN3o5ZWI5THRvbUVtS3pMWkFRRDBjTXRFY1dabXRL?=
 =?utf-8?B?NXd1YmJ6ZjlFYUJ6RFlndnNaMGdWY1VIcFN6MHdUTSsya3JmcE1qSkRPR3Nw?=
 =?utf-8?B?SU5yUDYxT1VoQ1BVTzBXYlFidDZqU3ZyenkvUVlabmNiOUtFNi91VURkN1VY?=
 =?utf-8?B?ajVZSUt5Q0x0SFhXT2VieDFLT0xRdFNMZE9vd2lPenJ2YTZKTGF1QkxsSHNo?=
 =?utf-8?B?enA3WUxvVFlScTFEUWxONVpscjViL1BsQjlXTVc4UGpzeFNKODYzUnJNbThk?=
 =?utf-8?B?Q0xJaTk1aVRYaWxycU1sS1BjWkE0b3Yrc1ZnK2ZZcmdKeVVHck1OMndZVnlj?=
 =?utf-8?B?YUV4R2h5VDFaNjc1YlFaQ1BKVnN1cHp1UkRqOEcxano2dWI2ekZ0S0trT3Vz?=
 =?utf-8?B?enZBZlV0ZG5Xc0xhMmRoZ2RiM25YTndMS1lOMVQ5QXd1MUdhNzJuL0ZkdGxW?=
 =?utf-8?B?STQ4UU1VYktkNjNIelZDNFlvbG5DalZMbjNSdE4yaTg4c2p0NGF1dGNaSW4w?=
 =?utf-8?B?MFRrdHg5YmpodzI2V25FZitXa3BkL0pLZUVrdUlXS283cmJDYXltTm5TVm1M?=
 =?utf-8?B?OHE5T0hJOHdCbytCQWpYZDNLQkVsZENUZG1VbzBwV3VrTEIyUitHTElpaW5l?=
 =?utf-8?B?WkNHWHZKZDZMK0Q0OFVtMnVMVWEvY3cvRGg3bENFakhWSFFoaEVWOXRxUTZG?=
 =?utf-8?B?N0NYbU5WdnFDeXloTW0yVVZhOTJWM1ZLaWlXaTRRTkozeENRK1VuT2laSHRk?=
 =?utf-8?B?MGs5UktZa3hWVkJGMjhwbGcyT1VGUGcrQ3NNd0tHeEtkZ1krMnA4OVZjSE9p?=
 =?utf-8?B?SXRMaW5WR0lNOEIvSTh1bjFJRkh2dEx4NCswcks2NDFsbmRjK3FqY2JvYjdN?=
 =?utf-8?B?c0ZkSnIvbUpjWlJ4Sll1Um5qL3N5a2QrYmdycXR3YlFlZElCeStFMDY0T1dR?=
 =?utf-8?B?aXM3VjBhbUJVSDZuOS9QVTdOWE93QnNFSVdJSkRmc20xZmtxcy9ob1JkaC9h?=
 =?utf-8?B?b21jbDl0YnRmeWFwMzFGS0N4ZHBDY29jclRTN2lkdW5oYXVkSnpQWlpBanQy?=
 =?utf-8?B?T3BxYStBbE1SK05jd1FGTnlLaTBxcENjejRKejhLL1hBdnhyeG1VRVRKaDE4?=
 =?utf-8?B?WkFLZ1pmVGswZ2xXSXdKd3FlMGc4czFUR2ZlVVg4NWlYbUFqN2hYRDhGMndk?=
 =?utf-8?B?ZkYxR3MwL3RNZnp5RTRPOUxEYU53OUp3TWYrbHNFaWRRVkY5ZStSeHhmRFYx?=
 =?utf-8?B?MGNIazVOY3dwdXAvV3IxMGVsdWFXVUhvdFNoZ1pWSDEyRUhmVkhRQTNhWndD?=
 =?utf-8?B?ZkFxMyt0ak9pd3dWNW9QQWppdVV2UHRJSUFzQjVOaDhibkcwN1AzR2xUZTBZ?=
 =?utf-8?B?TnhETUVpUDA4NzBqc2l6d2JNVlhkT3JTLzRHSjQ4YkNqVUh2ZkdNam9LSEE2?=
 =?utf-8?B?dTlPZnNHeVdSWmxGcFNvM3BFdFQ2cTJaYkoyVm9xc2x5UmxsTDNzd2hDaSt1?=
 =?utf-8?B?YmdCTVJ2TG5URW05d1FYcU9pZXdEUzRMUGFDcXYrVTBKUjlHLzZIUzRiWXJC?=
 =?utf-8?B?N201cDMyUkQ4YnNNRzhDSmJUN3VjYmtkQVh5Z1FHYUlicHZxb1Z4bHNoT21J?=
 =?utf-8?B?K3NYYmUrSWNTL0U5QUxYWFVYRjBDUUNQTkN5TEpzalp3Zm5XVTV2eXk2UFRB?=
 =?utf-8?B?ZDN6UGU1clNWRDJuOWwrZkNqZ3FjOVptRTlTa3RCci9vSy8xUUc0dlAzWFlB?=
 =?utf-8?B?ZzF6L3dmM0NMZkFzVFlQNTZ4RkdlVDB3OTA5QWhBQWhmaGt4bDNiMHNQc3p1?=
 =?utf-8?B?R3hpWlJEZHlXQytndGcrcXNmK0JCbmI4dVNWb3crRSt3YjE0aC9zcW4xdjFh?=
 =?utf-8?B?WWUwZW1DQlVCMXhxblFlTUQ4alZRblBNdTYvaVVIYk4xNFRDY2Nmam1hcGVG?=
 =?utf-8?B?MEFRSTFaK1ZtY1E5eWMxWFZBNTlZaGlkQW5mM2dqQVRreVVSQUZFQzRxazFE?=
 =?utf-8?B?TGU1M3UxRndYTkNsb21ZUk8xRWZvOHBsWmhZQnE4TE9TaEdvQitCcXZDRm53?=
 =?utf-8?B?SU9Hb0FSd1lreFhmQWg1Yy9pNER6Q2MzRE5mbkI4ekJwKy9jVVdMdGllTkt3?=
 =?utf-8?B?V1NucllRV3NBeUZ0ajMrOVhQVVZKd2JJQ1VsbEZIYkZqRW9DUGIwbGs3RFRY?=
 =?utf-8?B?NDhMdnVCUE51TzBQZldGMHFwK01TeElXcG9uTlhqSkxMczZFa0xoZW5uZWk4?=
 =?utf-8?B?YjlpdzZhSTA1anJXMWFSZ1NKcXBBNVppZjBlQ0RtR2FBMkk1aEJlZz09?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 72fa0acd-a28c-43d4-477f-08df3e22f1bd
X-MS-Exchange-CrossTenant-AuthSource: AMCPR10MB992291.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Nov 2026 05:33:11.6150
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 65yU6Uudz9rUxFC0wob4hOCtjsxCIowEZDYNyUgBP+TWN+8FxlWVciJu0mIqX+i7R28yl5xW+PJpkqRstQHibQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA2PR10MB8850
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by lin-tor-korg-lkml-alma10-1 with HTTPS for <cip-dev@lists.cip-project.org>; Mon, 09 Nov 2026 05:33:27 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/24679

On 09.11.26 05:02, Nobuhiro Iwamatsu wrote:
> The serial console device filename for the DE0-Nano-SoC is ttyS0, not ttyO0.
> This changes from ttyO0 to ttyS0.
> 
> Signed-off-by: Nobuhiro Iwamatsu <nobuhiro.iwamatsu.x90@mail.toshiba>
> ---
>  wic/de0-nano-soc-efibootguard.wks.in | 2 +-
>  wic/de0-nano-soc.wks                 | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/wic/de0-nano-soc-efibootguard.wks.in b/wic/de0-nano-soc-efibootguard.wks.in
> index a1c1108..724f54f 100644
> --- a/wic/de0-nano-soc-efibootguard.wks.in
> +++ b/wic/de0-nano-soc-efibootguard.wks.in
> @@ -17,4 +17,4 @@ part --source empty --sourceparams "${ABROOTFS_SOURCEPARAMS_B}" --align 1024 --f
>  ${WIC_HOME_PARTITION}
>  ${WIC_VAR_PARTITION}
>  
> -bootloader --ptable gpt-hybrid --source "de0-nano-soc-firmware" --append="rootwait console=ttyO0,115200 omap_wdt.early_enable=1 omap_wdt.nowayout=1 watchdog.handle_boot_enabled=0"
> +bootloader --ptable gpt-hybrid --source "de0-nano-soc-firmware" --append="rootwait console=ttyS0,115200 omap_wdt.early_enable=1 omap_wdt.nowayout=1 watchdog.handle_boot_enabled=0"

These are likely all copy&paste issues, taken from the bbb. There are 
even references to the omap_wdt left, also not found on the
de0-nano-soc.

I assume you have the board in manual testing right now - could you 
check if this enables the U-Boot watchdog and makes the kernel take over 
properly?

diff --git a/recipes-bsp/u-boot/u-boot-de0-nano-soc_2026.01.bb b/recipes-bsp/u-boot/u-boot-de0-nano-soc_2026.01.bb
index b8cba972..400272bd 100644
--- a/recipes-bsp/u-boot/u-boot-de0-nano-soc_2026.01.bb
+++ b/recipes-bsp/u-boot/u-boot-de0-nano-soc_2026.01.bb
@@ -21,6 +21,9 @@ do_prepare_build:append() {
     cat <<EOF >> ${S}/configs/${U_BOOT_CONFIG}
 ### DE0 Nano SoC extra config
 CONFIG_USE_BOOTCOMMAND=y
-CONFIG_BOOTCOMMAND="bootefi bootmgr"
+CONFIG_BOOTCOMMAND="bootefi bootmgr
+CONFIG_WDT=y
+CONFIG_WATCHDOG_TIMEOUT_MSECS=60000
+CONFIG_DESIGNWARE_WATCHDOG=y"
 EOF
 }
diff --git a/wic/de0-nano-soc-efibootguard.wks.in b/wic/de0-nano-soc-efibootguard.wks.in
index 724f54f6..b61a68a4 100644
--- a/wic/de0-nano-soc-efibootguard.wks.in
+++ b/wic/de0-nano-soc-efibootguard.wks.in
@@ -17,4 +17,4 @@ part --source empty --sourceparams "${ABROOTFS_SOURCEPARAMS_B}" --align 1024 --f
 ${WIC_HOME_PARTITION}
 ${WIC_VAR_PARTITION}
 
-bootloader --ptable gpt-hybrid --source "de0-nano-soc-firmware" --append="rootwait console=ttyS0,115200 omap_wdt.early_enable=1 omap_wdt.nowayout=1 watchdog.handle_boot_enabled=0"
+bootloader --ptable gpt-hybrid --source "de0-nano-soc-firmware" --append="rootwait console=ttyS0,115200 dw_wdt.nowayout=1 watchdog.handle_boot_enabled=0"

TIA!

> diff --git a/wic/de0-nano-soc.wks b/wic/de0-nano-soc.wks
> index df4bcec..a968bb3 100644
> --- a/wic/de0-nano-soc.wks
> +++ b/wic/de0-nano-soc.wks
> @@ -11,4 +11,4 @@ part --source rawcopy --sourceparams "file=/usr/lib/u-boot/de0-nano-soc/u-boot-w
>  part /boot --source bootimg-efi-isar --sourceparams "loader=systemd-boot,dtb=socfpga_cyclone5_de0_nano_soc.dtb" --label efi --part-type EF00 --align 1024 --fsuuid 0x4321dcba --uuid 16d61432-ec24-42fa-a4b8-b2bc20a26f5e --use-uuid
>  part / --source rootfs --fstype ext4 --mkfs-extraopts "-T default" --label platform --align 1024 --fsuuid 1f55d66a-40d8-11ee-be56-0242ac120002 --uuid 25d57b24-f34d-412e-8c88-28629f23aa0d --use-uuid
>  
> -bootloader --ptable gpt-hybrid --source "de0-nano-soc-firmware" --timeout=0 --append "rootwait console=ttyO0,115200"
> +bootloader --ptable gpt-hybrid --source "de0-nano-soc-firmware" --timeout=0 --append "rootwait console=ttyS0,115200"

All correct - I'm just confused that I didn't notice this while bringing 
up the board. I swear I used the UART as well, and that means it must 
have worked.

Thanks, applied.

Jan

-- 
Siemens AG, Foundational Technologies
Linux Expert Center
