Received: from PA4PR04CU001.outbound.protection.outlook.com (PA4PR04CU001.outbound.protection.outlook.com [40.107.162.8])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.3942.1794223179016651746
 for <cip-dev@lists.cip-project.org>;
 Mon, 09 Nov 2026 03:19:39 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=UjtZbtIU;
 spf=pass (domain: siemens.com, ip: 40.107.162.8, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oQQvwi+zCcfQhdHbRju+bq3WPBkzJrmwZnDzDSLd/RcRIS5CHdnDXgedSWLS86mcSnVbrLlScFKf0vuI+JsXSlTzbjXsZuSHOLaStJz94+SL4JyuJ+Bbk9riSu11OCIBr3kDzTLu0To1uRAw3ljDLAgZS1sbgirCTNzSHGwXYaUDB0d591GMkLm1qRUNp6C4NjyIcyJKJj31CUFa5ovY74Vf8UhpuM2ZNjm5wnoSMSQt/7ACnC/JKeF3/6AtyH4p5uT9dR69ODsDRiqEQdtB9UX3mGI4Wt5iBYOd//fgRJga5G+a76O3D2CM6xxTr66EBYAjreTUqSobeGxwEqrCjw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tSyVfLFM1AmRWRSUT8pcVOl+88M65duG411B3i43IZI=;
 b=yO0SIeJa1Pg6SzkIY2C2McK8U7VCt3T4FOaO0mC47PQ8FqVhkSPBc3HUZXmBUCdY+HHe12P5CmjSWhHw5//z31JmLBsQeFrysTf5hy25sZ+r2VDdJ/xA8xP7RMjSXF0IPqAtLmzSdq+UbS7uigLfRlOccFaOOmTskOmwnnS9lW3q6HcIPaUHpoo1WB8WRQbuHEBW1mJ5E+8YoJP2DQVM0xOXpbucDFSETOhL0y5myW5ZFdWnFklI9qNhLj67k69DgojTlK16ZAoMbeFA1auGzBe4H5lkV14WWEL7oSyJDv5DG24JYvRqKCM4m3/tjJU+jqR2w26O2p9je9VQc85Hbw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tSyVfLFM1AmRWRSUT8pcVOl+88M65duG411B3i43IZI=;
 b=UjtZbtIU2MO17QtDW6PCCY/k3vrdmE25Pep0vc9fSg2kVtTEyQrMOZ71WNwOruAEO1LuWhgVF9nALVu08IwwHU4MX9FEyVaixwcNyKHGJwGJcMNoGBtUWzi7/IS1NdvtHn3VZP7WlT5tUPHP8QN6unuUqmXBmxX85lpqLk0+9B2KqVn4f5PKnRNWVRw9hKB89mnFNG8wA5qDoBeUHTzbV6FQvrrgzvodXM1/8kty6tseXSHxvGFVMN0obWhT4PI0Ql426LFD7dNoMpHeuVfC0b1OHbdEhrZ5/ArKdbRHC4LaHlqaOSi6901nd5qlWmi0wosYKxEY7uXoFzT216kQlw==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AMCPR10MB992291.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:785::10) by BR2PR10MB992285.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:2c8:18::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.8; Mon, 9 Nov 2026
 11:19:35 +0000
Received: from AMCPR10MB992291.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::fbce:789a:27cf:d1e]) by AMCPR10MB992291.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::fbce:789a:27cf:d1e%5]) with mapi id 15.21.0615.007; Mon, 9 Nov 2026
 11:19:35 +0000
Message-ID: <186aa280-32ae-45b6-8e79-7a3774da02b0@siemens.com>
Date: Mon, 9 Nov 2026 12:19:35 +0100
User-Agent: Mozilla Thunderbird
From: Jan Kiszka <jan.kiszka@siemens.com>
To: cip-dev <cip-dev@lists.cip-project.org>
Subject: [isar-cip-core][PATCH] Enable watchdog on de0-nano-soc
Content-Language: en-US
Cc: Nobuhiro Iwamatsu <nobuhiro.iwamatsu.x90@mail.toshiba>
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR2P281CA0042.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:92::15) To AMCPR10MB992291.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:785::10)
Return-Path: jan.kiszka@siemens.com
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AMCPR10MB992291:EE_|BR2PR10MB992285:EE_
X-MS-Office365-Filtering-Correlation-Id: 67830f9f-c89d-47c5-6d30-08df3e53560a
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|23010399003|376014|1800799024|18002099003|10067099003|55112099003|11063799006|261028144727099003|261102123227099003|261022105027099003|56012099006|261021123027099003|261021121427099003|261026121527099003|261026140227099003|261009223027099003;
X-Microsoft-Antispam-Message-Info: 0B9fh+VWfSAuzvRZnpiAus4fGTBPRA4mTfIjdv6Rf25BQSIzGy1yZPxoscpEyrvgA5AAJ0ETf16/ZivViir6EZfTwGGqiiZ9qVwCtbxIYeBipvKnvWes15LxvbTZxSY8HGaembkR+zpnuShMdkfnQSaPWHQXqbQEpIo43mSDbfRAoR49G7W3J7gFdiJLPWu3OVTB//kOG/4YPXEGpoG/LoXeZY4TfC4ViOo5VX3CjDgnHi6hiG3VZER+ufGnw9ryD1tLp+mXRc4Y+Cy4PcA62a5ofdTA2sbp44UrMfARbQP2wpZKt4NoU+FnqsTzgEcIpHCo5Iqn+VDB3rwAY1b01/eQVl4eImkcJiYHgc2Sko+S6Jcny9lhTcNlyMhIKrBFJsFlmQsV7uuVi3BJK/7hKxbw8rKLpeUjx1AWDn7n3B6WOC3X4AUSnhKIeHi5rjGmsBfaZZiRcmOUkKgc8z9mJpoyC3UHbtz2r6LSU3Fv1za7cujPQf9DB/Qo0nrKra4Ch6Lc1FOiRCQvbgjvM5ac9UqT150mpk0dqStFHF0Ao4OX255YospZvgY/RuCEZeShoDqdviR+IUx6oOWu850ibOg2DhZPKpfm2/td5lMWJjZEVXf+/bO6Qfhmwe5jDbMJA12O86wE2MsIkPuIwDd9+D1dZN7Mp+D4tR5AXJvmFsY=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AMCPR10MB992291.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(23010399003)(376014)(1800799024)(18002099003)(10067099003)(55112099003)(11063799006)(261028144727099003)(261102123227099003)(261022105027099003)(56012099006)(261021123027099003)(261021121427099003)(261026121527099003)(261026140227099003)(261009223027099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aEc3bGtOSDI1dXJBTGo2bTlTSHZwU0lYWldZSzFSbGNXKzkxRnJHdDFGQytm?=
 =?utf-8?B?SDdCY3NZRWRmQlJ3MlFqOFpZMGVMWW5OTHEveW5kWEJtOUd3alVDVFpCRnFw?=
 =?utf-8?B?Wm5pZGFkU1JJaGtmU3Rpc1RZdW1aOXJhaTVPNmR2RzJDTzZaU1gwaXhuUDNz?=
 =?utf-8?B?Ni9tVjMrcnhEVGIydEM1T1hkR01DRW83YS93RGZRdU83RHlCaXZXOHJyVzRK?=
 =?utf-8?B?dTZ0Z3czYnp3N3JqZjFRa3FHUDZ4eG04M25TZmRaSHIvcFhSdGRGSnhzcmJa?=
 =?utf-8?B?NnFyUmJtUGdZYm5RalIwc1I5eHZCTE1wUHJtb1RqeHlOU0NLWHozQ1hIYjlh?=
 =?utf-8?B?R2c2QTlTY09JYnQ2SzRjajFaR3A4ZDZKbStHZUdoOG1HNlJXU3RNLzc2am1t?=
 =?utf-8?B?ZUxIR0F0ZnhMZVcwbkVYcThiMzZxLzA2aW9WOEZkZWt3NmlIOVRtMGsvQlhj?=
 =?utf-8?B?ZTRjeFJnZnZad1RvdUVsa0NTSHM4S3BTdjJtMGlyTysyQm1VZEpKVU9VbjNh?=
 =?utf-8?B?NlpzVGYvOVl0ajJSMThtc2dRVUFHUnd1ZWxibUtld3pNWExZU3B5NUUwVU1v?=
 =?utf-8?B?NnJLNm9NdmtXbzU5czNkd3dlQUp5SW04dEVldVFPYTlxTDh1Z0J3b0tUMFBK?=
 =?utf-8?B?R3V3aWxaSGFCKzBNa2o1ZU9CSXNGUS92TmRZWnZWV0djaFk2cms1NHVNdU90?=
 =?utf-8?B?QSs0YlpxSnlZanQwRjFFK1IrM3JtUTd0VlAvVG50bVRsK09VWE8vcnVKMnZI?=
 =?utf-8?B?SEVZdlgvZEJnSW5iZDVZNkEyKzRuYi9sRWxDSkRFZFdFMU5KRE0rRnFJZlBu?=
 =?utf-8?B?b0RKK1RzUjl6RWVUQUhMNE5zTk0ydXc0WmpNVnpmRi84QUUwT0JvbzRtTXlB?=
 =?utf-8?B?WmVQd3NlN0k1MUVYT3RSQi9wM2xWd1Y2c0FoajB1WmduMEpNZXNKS0duT21G?=
 =?utf-8?B?QVNLWGZwanRyQ01hL1RSditzaFpDc1p4TGt3RFNIbWN5cXFpNFRvMUxpMjRp?=
 =?utf-8?B?OXdZaFZSKy93Vlpid1VtZmpCek1oU2FoSXdLMHRhWXEvbmd2dmlvNnhFall6?=
 =?utf-8?B?eUR3TGxKZXkrODBXYXVSZUJOdU94a3k5WHB1d3lWNXRuQmZjd3JGQWhzZWRP?=
 =?utf-8?B?MUR5QXRjYkpJU1pCOWZSSE5QSlUxQThmcmVYVWhwa0VvOXJ0RVJlcXN1S3ZE?=
 =?utf-8?B?V29OLzFRU1YwanpzTklxeWpTVUM4MjlPVVBvdVRxRUc3bWhXUDY0S1Bta01R?=
 =?utf-8?B?TVlPM2k1RVFwdzJZWWl2RFI4WE15RkEzTS9TcVhWNjF4dUhBL0ZTRlRMbmFp?=
 =?utf-8?B?OElqZXlXM0lJeVJTTHRGajRtQWg5MjdZcUZ1UDluL1ZmamlFL2djcjFaRHU0?=
 =?utf-8?B?bGp6VFg0UFhlc3I5T3ZHTkMzWE50SGQrWGlieVVhYk43OHQwNlViTjFybldB?=
 =?utf-8?B?Mk1QS1BPYTI4SXI3aGdWTmMzbHFuQ21nT28rWmdhUGlndTY0NkdSVEExay9j?=
 =?utf-8?B?eE1NMFFOZk1xMGRpM25uNlZKd0I4bVlWRkFTalQxbWZSVkhTemJ0VGJ4ZlVI?=
 =?utf-8?B?QTlqYUdSRCsrd1JHNC9oRW5PamF4MWhyTUJqUURaTWFuRzZncnpYRGhDWVRk?=
 =?utf-8?B?ZktReUNzclA1bXpTTDJMakl5NnBNd1luTlFBdzE1Z3VpOU9GRWdYYStYQ2tW?=
 =?utf-8?B?d2FVTk1MdlhRZThxUFBvV29rcWwvVmlHNU5kRndOWUZoZ3pPTnVDT3ZHUlR5?=
 =?utf-8?B?UVJHSkJHRVY0dEdXUTFSMVRqNDdlUjBrMCt1OFBDWWFZZmQ3SGdhUWNNOUxu?=
 =?utf-8?B?NFVOQStuYVgyaWw0RkxCWXRmREFVcGFwOXprb3d1blBXaU9ta2VLWmdiMmVi?=
 =?utf-8?B?Mm1sZFEvamx3Y1hpTTdsR1VKaTN6OC9HcTRyL0ZhYi9ZVWJTTTlxMithbWVR?=
 =?utf-8?B?Z0lQcWRVOERCaXAzS3dOSG9EQlpFY01NbmhMV3VZdy9yaGFja3hML0ozS21i?=
 =?utf-8?B?ZVRsZVpNRU4zZTN6d29OWC9ZQWNwQmhFMmVTQ2dUQytEZXE2YTJKa0Vtd0R0?=
 =?utf-8?B?L3gySEtUYzM5WHFmZ3ZCMnlzYnQrZElpSklCOGRWSWFua0lqY3l0QTF5OUky?=
 =?utf-8?B?bElmNzlqRzlDNWFOTlBZSXBaMGVMQWVHMURKUnpGT0NvdUI2TG8rbUp5L2ht?=
 =?utf-8?B?ZUQ3Y2hGU3pwUTVPOHdFdVRreDdmbjJ2d1AzWk85M2xycE4vbTBhYmQ0MHl4?=
 =?utf-8?B?NEZLcW9vd0NZUjhMa3BKQ2dqSWpYc2U0WlV3eEFvS3JXcTlQdUcvREZ1REpK?=
 =?utf-8?B?Y1BETnJheWlpSlRrUkY4TEtHbk1DbnV4SG5RKy9WR2JUaGtqS1JsQT09?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 67830f9f-c89d-47c5-6d30-08df3e53560a
X-MS-Exchange-CrossTenant-AuthSource: AMCPR10MB992291.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Nov 2026 11:19:35.7311
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 70ZQE37ZJNgisuKlHgndInRHipW3z8EvHjbs4gySkoD5L3X0Xcdh6rKNOOxu/Mb4xOEKCGejM6krT1iPBoTyFA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BR2PR10MB992285
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by lin-tor-korg-lkml-alma10-1 with HTTPS for <cip-dev@lists.cip-project.org>; Mon, 09 Nov 2026 11:19:42 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/24696

From: Jan Kiszka <jan.kiszka@siemens.com>

Start the watchdog of the de0-nano-soc via U-Boot, setting it to 60 s,
allowing Linux to take over after boot. Our kernel configs already
contain the required options.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---

Would need on-device testing. I currently do not have any access - 
Iwamatsu-san, maybe you can give this a try.

 recipes-bsp/u-boot/u-boot-de0-nano-soc_2026.01.bb | 7 +++++--
 wic/de0-nano-soc-efibootguard.wks.in              | 4 ++--
 2 files changed, 7 insertions(+), 4 deletions(-)

diff --git a/recipes-bsp/u-boot/u-boot-de0-nano-soc_2026.01.bb b/recipes-bsp/u-boot/u-boot-de0-nano-soc_2026.01.bb
index b8cba972..400272bd 100644
--- a/recipes-bsp/u-boot/u-boot-de0-nano-soc_2026.01.bb
+++ b/recipes-bsp/u-boot/u-boot-de0-nano-soc_2026.01.bb
@@ -1,7 +1,7 @@
 #
 # CIP Core, generic profile
 #
-# Copyright (c) Siemens AG, 2025
+# Copyright (c) Siemens AG, 2025-2026
 #
 # Authors:
 #  Jan Kiszka <jan.kiszka@siemens.com>
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
@@ -1,7 +1,7 @@
 #
 # CIP Core, generic profile
 #
-# Copyright (c) Siemens AG, 2019-2025
+# Copyright (c) Siemens AG, 2019-2026
 #
 # SPDX-License-Identifier: MIT
 #
@@ -17,4 +17,4 @@ part --source empty --sourceparams "${ABROOTFS_SOURCEPARAMS_B}" --align 1024 --f
 ${WIC_HOME_PARTITION}
 ${WIC_VAR_PARTITION}
 
-bootloader --ptable gpt-hybrid --source "de0-nano-soc-firmware" --append="rootwait console=ttyS0,115200 omap_wdt.early_enable=1 omap_wdt.nowayout=1 watchdog.handle_boot_enabled=0"
+bootloader --ptable gpt-hybrid --source "de0-nano-soc-firmware" --append="rootwait console=ttyS0,115200 dw_wdt.nowayout=1 watchdog.handle_boot_enabled=0"
-- 
2.47.3
