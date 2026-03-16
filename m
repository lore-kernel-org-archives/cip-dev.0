Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64288F4645C
	for <webhook@archiver.kernel.org>; Mon, 16 Mar 2026 12:31:23 +0000 (UTC)
Received: from DB3PR0202CU003.outbound.protection.outlook.com (DB3PR0202CU003.outbound.protection.outlook.com [52.101.84.53])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.49388.1773664278694567133
 for <cip-dev@lists.cip-project.org>;
 Mon, 16 Mar 2026 05:31:19 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=DVxw+/H1;
 spf=pass (domain: siemens.com, ip: 52.101.84.53, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fb6QKdwUFIg2HUNfJKkZUbpCcnLbAbf+8lfOHqFVBrmvp5EbHPNeyMIgGeY12po0MLCwK1dX9d2NpYxAVgDN/iHm+8z9lhLqimnUZg2w9TrPiqpDqYPFE2kRLOLnPdBCmwRFQAL/WfmTbK2+kLj9tTOlZrVrvzxl00QUi0r+5uxWaZ65EMGP1/zI8j1SA72Gj8Ox1oVCBGCxrn/oSIMvYb4p6J/uSS9ou1O0Gsud5OcNSccaSo/m79+UtH6yTxlEppK8FyaHTFC+2CX8LN4nE1aXjlqlQBeDcU5O9Llv3VHiqeAZufPyWlwmQ1nXcFxWLI0+c9/DfveBI0AZDpfxZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xGrDTktBZNi/jmXEIYP0ZugGyIthkBF1kzT78BD5Cdw=;
 b=eXapUrTAljaDRa6xRmNiTb0nYGwTHYpGc1kslrSeH9M+D0C8YTz3n5ua2UpN3FbcOKZbX1Tn9ujX0tRKJ5isDI1qxd4MOqOfb0eF7prEzxoz21RAREHh4auBJi6koQ7MzWkNip8ym0FhHqUlcGQuE6JPXOucpc939RVsqbUjsBTe3A0VzI+E2Wup+GTgcVOZ4tADlizG38f2b7ZKvkQcEwlRXfzhYDdPT+LzG1RPsU29ioWAU8EBa1msX9eeCuXzmn/k52Dprx/7H3FrnWhAMWXK2//roYwGQbdC239HDiIi3bUNWbIvvwLc4j2jpzwVOuzzS5fM9pog4a2en6EeKg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xGrDTktBZNi/jmXEIYP0ZugGyIthkBF1kzT78BD5Cdw=;
 b=DVxw+/H1LTqb0gP5vNWNiriTttYMC0gTjfNA/T/54Qq5q5M21pVjT/i1TCc0qb1x7bBuBTn63E1iOhl1ioSKiMFutLfMAxTcdKPN8ZA6InXea+PVHTmMyME9GfuIAVwMh0oC73j/B2xHuYalflwwSMWydPAjuYqHiiY1X0WWzUWuoNMJkoRf7D0SzTeJRB7LeXCeTkYNf3l3vTGXZ2EO9+Ih/fWg8Fwj5zfWkihzJ5JulGUsZENxtMuk6q2iWtZ0CIBXZKeyANK9oi6y+6kkyBTRP+phd+3dQSuoVL1dS9imTd5fNIVIZC5lX3RKjI3D2vYxcRzs18vn7Xwr/LWzBg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by VI1PR10MB8231.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:800:1d1::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.24; Mon, 16 Mar
 2026 12:31:15 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1%6]) with mapi id 15.20.9700.022; Mon, 16 Mar 2026
 12:31:14 +0000
Message-ID: <3331bf6f-b66a-4029-bc7a-ba0ddbc747b4@siemens.com>
Date: Mon, 16 Mar 2026 13:31:12 +0100
User-Agent: Mozilla Thunderbird
From: Jan Kiszka <jan.kiszka@siemens.com>
To: cip-dev <cip-dev@lists.cip-project.org>
Subject: [isar-cip-core][PATCH] gnu-efi: Drop self-built version for trixie
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR2P281CA0013.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a::23) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|VI1PR10MB8231:EE_
X-MS-Office365-Filtering-Correlation-Id: 636f1b1f-2938-477c-6993-08de8357e9a9
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|366016|1800799024|376014|56012099003|18002099003|55112099003;
X-Microsoft-Antispam-Message-Info: 
	p9GzvNrPLIETKPpKJlpM8pvo6RVcn4KAvS00dTXrJ9WRKe73fvrHRG90D0vcf1kJf6S+3P05AaaaiiBoW+vBLKbFS46v6fmt5hvxqXIa2ohXctd30C9aN8AUrk4g5BKkspVL5oLJ7dw57F8XCLT80wIUgCCQ+MTYx0lbmUO9WNoldkHLTNMvgv5MvsPhOWxH3o9sxsPwsHU3a1JrlJbFyxP9n+aYbhC9cXuCWjGosbJnXFy1Ua/v5mz/Y1ZGgLmHH/m1lpoN5v3SQmDo9v4ngqHjXMKVjSuyoenOBOMu5Gb8FYJgLHfP39D9ApFYnFrWgGxAq0f97Uo3Ok9QSOhSJE+Xh3KT5b2GVxxyqU4vYz9KQ9qOJCO0KWzfuQS0xsTSAhuLwAZP5sCzrw66dy4MpHe5QXmSJw/tSZ75YgmSnpKWNqjq6HP/40J2vLoE7m68dtNOIMpuoQx2Fof6Jzv3caMCrE1/tWkCZx1jA6Ce03BxdKPYDL3oYsvCufUVhTjMa8dYCQWurL9kVswphpKh2E1eR/ho481pfZRBy0el/Hp631itG9V4GsHIBgt695f7Ti4koMduWEkJ2u7oqLF6opN3AatIDWdsZks60ZfZeyghrFSx40ubnS16gxjqmjdmnnYF3i7IVM4CjgnFtciAVj0CEO6XPKJ5bRIuN/dRblNu4AlSxwN+vdH4bvfjlQ/RnwsvEpEnY6zDqY4wkcwQVP3jSWB7OVBZo+DYobnDAhw=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(56012099003)(18002099003)(55112099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?Z3huclQ3Unl4T0pMakE0SUR2NE5LQ2ZnTW9zY0xyK0x1bzk3cnlabEowSlVS?=
 =?utf-8?B?UU1uK0pMUmdLaHU2R04yditMWndRQ0dReGdVcUMvcElVSW9IUVpxNkxnSDFv?=
 =?utf-8?B?K211V1EwOUZIUUwwSkRKN1RQdXUvdmlGNGhxTWQzVllxME1hMmhZNGp2Yys5?=
 =?utf-8?B?UGJrWlZUTDM5NHppQUw2OFZGdFlZTzRkSGFJM1pIamdTT3d0eW1qZGwwQ1hx?=
 =?utf-8?B?RlBaNDRWVWFpL0NBN0owRzZzeC9rdzdYcVlyZEhEL1lBWnJ6eHF0Yy9WUmR0?=
 =?utf-8?B?dFg1L1UxZGJGcTlXUEJRLzhyVmdXVWpPczhJVlpJcGdxdGJHR2FjaDF5L0hZ?=
 =?utf-8?B?Q3RBMWM5WmpCUGVaUE5kckgwZGJyU1l4cHpMbnVqSHpJZ1NUVUZjQVYvY2Zi?=
 =?utf-8?B?bUlpTlRoREFVNHgrVGRRczBBSERLUUtBVVhYK3Z6czN6MzVKMmNVa0U1aWFI?=
 =?utf-8?B?Rzl6bm5KSldHZUc3bTluTkNSelBXZGxVLyt0WGV2RjZEZHQ4dWpuL2RYQ2xI?=
 =?utf-8?B?TzJZeXJvbXZZb2tlREljRjYwSFVlM1hXM0d0Y0U0STg0WURha0ZBZkZlb3Jq?=
 =?utf-8?B?L2xDN1ZYbHI4NXFxTWMxcHBnUDd6UW51MlVMZVdOcFpDNHB1RWp0NlpwUlRa?=
 =?utf-8?B?ZS9LL1htb3J6WGhLbW4yeURMQUpiSzVTeEkwcDN6QUY4ZTA1Q1F2eU5WSUpv?=
 =?utf-8?B?V1hzNERSa28rdGw2R0N2eWo0c0UvODRIb2Q4NDJmWFhHOEZYMy8yRVQ1dTNJ?=
 =?utf-8?B?R1FnSktGTzM4eUxvcCtKTVd2SnRWK3dFdC9xS3BtS0RYOTFWSktkc1VUSTJp?=
 =?utf-8?B?TFM3RUR4R1dlMlBNLzZDYnRtUnY3NXdDaTM0aEMzeklKaDlPUUF2ZjNDbDF5?=
 =?utf-8?B?a1h5ck9NNmxuNDNXNlhPa201ZXUxQm81eVBuVVlvSDRrd2lQSkZuQXNOenI0?=
 =?utf-8?B?ZURHOFlCSXA2Um5velVXNkY3MTZCUDdhWkFUNUREeko0T3ZpalRlc0srMkw2?=
 =?utf-8?B?RHJIZGpqL2YycEpuUE40QzhSUlNNdW9tVzN6YUdGV2J0YXFDL1FWWG8yeVhz?=
 =?utf-8?B?bUNDYUxVYUdwaW5jQkNqU1d4UVNHTVBqRHdjUTM3aW1vRDZ5VFFiYTlsV1BD?=
 =?utf-8?B?ODdvZEtmcFFhOTgrZG1wRUhFYWRFK1JDNklReS9RaWpvU3FKb3g1Y00rVG93?=
 =?utf-8?B?VXAzOENvRU1Bd1ZwanNrTnZNQlFzQXlKajYrZzBoWXd2Nk5zcVFtbVhGcDVJ?=
 =?utf-8?B?TjJMeUM4WStiOWFrWUxrRU5kR25FSkZabkwxSm1CaFBza2c1WUNiMlNOSGY0?=
 =?utf-8?B?RWVIRkFFM3dTbjNPNllRQmZSQWczM00wbmdLY0plbFpEVnR0aFJ2OEx3cnFM?=
 =?utf-8?B?S0hVdEtJdG0xSTNEUFJYK2REaGpITkU5emcrRnZZemFnK2l4YlU2aWhqV2Q2?=
 =?utf-8?B?RmEvK1ZBc2UxMk9tY0IyY0xmb29Va1NNMWkyYmxBbFlaZXlheFFWVnUzL3Y2?=
 =?utf-8?B?bkJXUlJNU0xoaEpwaER0R3BObnpVd2hGSDVSRjlURmRyRjBlb1dsZnp4S3Y2?=
 =?utf-8?B?bGFTR2kvYnRjOHZ4d2JkcDU3b0l5QTlZTmI4TDJscmFyd0tFVHI1TnA0bUpQ?=
 =?utf-8?B?SGI0OU80cjVVZTdBYmNwSWwvMU9zcVcrbG9NSzliTk9XVUI0QkJxM0xNM2o0?=
 =?utf-8?B?M2NVdk5OLzdzb1NxbGhUT2ljRTl3MmE3SFkyRFkvYUJadUh0MUpqSlZkUmRN?=
 =?utf-8?B?SnQ2NWNzVUVVODUzMTdNUko3R09JZUlsbTFxM2wvQityL1VIcmo2OGRaYXc3?=
 =?utf-8?B?ci9jTFZhYVpzYTZZSEFPQ1lZYkFUUjBWTmRSNEFKeUIxSDhNaTBra1hOOUhu?=
 =?utf-8?B?QUs2ZlUvWjI0MU9jYnBUUmZ3WmljU1IrcHhzbnRyajdPMmxyOExCTVRYN3Vp?=
 =?utf-8?B?MGt4RDlOOXBxZldHeXI5R3FobTVJOWw5bWF3ayt0OVdSMG44bjVRL0t1TStk?=
 =?utf-8?B?VkczbHY3VjRMbU9jdi9ycEdKdjlEQUUrK0JVZXRBWEJ1dElrRlRQOWpaRXVl?=
 =?utf-8?B?R090QjIrVzRJalpEL0JoVytVaVQ5aGl2Z21WaE9GWVpVcmtXNFI1bGt1Tlgx?=
 =?utf-8?B?ZmU3ekNkNUpsR255OU1wUUhkL29sRFdxdGkxc2llR1lGSlVaRUY2bmk4bGs5?=
 =?utf-8?B?c3FvR1drYWg2dktUbjZQT3NPR2VSS04wVVhwSklHSFYwRkM1bXZpUTdjY1hn?=
 =?utf-8?B?UzVJWElQa0FrL2VqSisxdXNTMTlhbTZWbTRxUFdibEZUWUlrZXdEOEJXQjVJ?=
 =?utf-8?B?ZVRCUW9YaEl3WEJFL0hhM3JTekpmZUJONTlGdC9nY2VVbnFHcTNOZz09?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 636f1b1f-2938-477c-6993-08de8357e9a9
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Mar 2026 12:31:14.6015
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: V9/gvmg8oxVx5TXJJfeRtaCh7NmMalHN0yBr/LtKOGpfcFVZyZN4hkI4l+80I4aofWoJeX7YAiyd0PYY+GdCnA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR10MB8231
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 16 Mar 2026 12:31:23 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/22383

From: Jan Kiszka <jan.kiszka@siemens.com>

Debian bug #1086705 has been backported to trixie as well. Drop our own
self-built version which is now breaking the build.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 .../efibootguard/efibootguard_0.21-1+cip.bb   |  2 -
 .../0001-ARM32-Split-headers-and-code.patch   | 93 -------------------
 recipes-devtools/gnu-efi/gnu-efi_latest.bb    | 25 -----
 3 files changed, 120 deletions(-)
 delete mode 100644 recipes-devtools/gnu-efi/files/0001-ARM32-Split-headers-and-code.patch
 delete mode 100644 recipes-devtools/gnu-efi/gnu-efi_latest.bb

diff --git a/recipes-bsp/efibootguard/efibootguard_0.21-1+cip.bb b/recipes-bsp/efibootguard/efibootguard_0.21-1+cip.bb
index f5dd1933..b847b611 100644
--- a/recipes-bsp/efibootguard/efibootguard_0.21-1+cip.bb
+++ b/recipes-bsp/efibootguard/efibootguard_0.21-1+cip.bb
@@ -39,8 +39,6 @@ DEPENDS:buster   = "python-shtab"
 DEPENDS:bullseye = "python-shtab"
 DEPENDS:bookworm = "python-shtab"
 
-DEPENDS:trixie = "gnu-efi"
-
 # needed for buster, bullseye could use compat >= 13
 python() {
     arch = d.getVar('DISTRO_ARCH')
diff --git a/recipes-devtools/gnu-efi/files/0001-ARM32-Split-headers-and-code.patch b/recipes-devtools/gnu-efi/files/0001-ARM32-Split-headers-and-code.patch
deleted file mode 100644
index 2f15d246..00000000
--- a/recipes-devtools/gnu-efi/files/0001-ARM32-Split-headers-and-code.patch
+++ /dev/null
@@ -1,93 +0,0 @@
-From 24a4cd0e5653fd84b004c00c808c45cc3fb7a7e2 Mon Sep 17 00:00:00 2001
-From: Callum Farmer <gmbr3@opensuse.org>
-Date: Mon, 23 Sep 2024 16:51:49 +0100
-Subject: [PATCH] ARM32: Split headers and code
-
-* Force code to be at known dest of 4096
-* Move _start into .text
-* Load the _start symbol address and then minus 4096 to get the load
-  address
-
-Signed-off-by: Callum Farmer <gmbr3@opensuse.org>
----
- gnuefi/crt0-efi-arm.S  | 21 +++++++++++----------
- gnuefi/elf_arm_efi.lds |  1 +
- 2 files changed, 12 insertions(+), 10 deletions(-)
-
-diff --git a/gnuefi/crt0-efi-arm.S b/gnuefi/crt0-efi-arm.S
-index 9c2c467..ad02ca1 100644
---- a/gnuefi/crt0-efi-arm.S
-+++ b/gnuefi/crt0-efi-arm.S
-@@ -45,11 +45,11 @@ optional_header:
- 	.2byte	0x10b				// PE32+ format
- 	.byte	0x02				// MajorLinkerVersion
- 	.byte	0x14				// MinorLinkerVersion
--	.4byte	_etext - _start		// SizeOfCode
-+	.4byte	_text_size - ImageBase		// SizeOfCode
- 	.4byte	_alldata_size - ImageBase		// SizeOfInitializedData
- 	.4byte	0				// SizeOfUninitializedData
--	.4byte	_start - ImageBase		// AddressOfEntryPoint
--	.4byte	_start - ImageBase		// BaseOfCode
-+	.4byte	_text - ImageBase		// AddressOfEntryPoint
-+	.4byte	_text - ImageBase		// BaseOfCode
- 	.4byte	_reloc - ImageBase		// BaseOfData
- 
- extra_header_fields:
-@@ -67,7 +67,7 @@ extra_header_fields:
- 	.4byte	_image_end - ImageBase		// SizeOfImage
- 
- 	// Everything before the kernel image is considered part of the header
--	.4byte	_start - ImageBase		// SizeOfHeaders
-+	.4byte	_text - ImageBase		// SizeOfHeaders
- 	.4byte	0				// CheckSum
- 	.2byte	EFI_SUBSYSTEM			// Subsystem
- 	.2byte	0				// DllCharacteristics
-@@ -100,10 +100,10 @@ extra_header_fields:
- section_table:
- 
- 	.ascii	".text\0\0\0"
--	.4byte	_evtext - _start // VirtualSize
--	.4byte	_start - ImageBase	// VirtualAddress
--	.4byte	_etext - _start		// SizeOfRawData
--	.4byte	_start - ImageBase	// PointerToRawData
-+	.4byte	_text_vsize - ImageBase // VirtualSize
-+	.4byte	_text - ImageBase	// VirtualAddress
-+	.4byte	_text_size - ImageBase		// SizeOfRawData
-+	.4byte	_text - ImageBase	// PointerToRawData
- 	.4byte	0		// PointerToRelocations (0 for executables)
- 	.4byte	0		// PointerToLineNumbers (0 for executables)
- 	.2byte	0		// NumberOfRelocations  (0 for executables)
-@@ -148,7 +148,7 @@ section_table:
- 	.2byte	0			// NumberOfLineNumbers
- 	.4byte	0x40000040		// Characteristics (section flags)
- 
--.balign 256
-+.text
- .globl	_start
- .type _start,%function
- _start:
-@@ -159,7 +159,8 @@ _start:
- 	adr		r1, .L_DYNAMIC
- 	ldr		r0, [r1]
- 	add		r1, r0, r1
--	adr		r0, ImageBase
-+	adr		r0, _start
-+	sub		r0, r0, #0x1000
- 	bl		_relocate
- 	teq		r0, #0
- 	bne		0f
-diff --git a/gnuefi/elf_arm_efi.lds b/gnuefi/elf_arm_efi.lds
-index afe17af..b7e3fb1 100644
---- a/gnuefi/elf_arm_efi.lds
-+++ b/gnuefi/elf_arm_efi.lds
-@@ -5,6 +5,7 @@ SECTIONS
- {
-   .text 0 : {
-     *(.text.head)
-+    . = 0x1000;
-     _text = .;
-     *(.text)
-     *(.text.*)
--- 
-2.43.0
-
diff --git a/recipes-devtools/gnu-efi/gnu-efi_latest.bb b/recipes-devtools/gnu-efi/gnu-efi_latest.bb
deleted file mode 100644
index 2272a2b9..00000000
--- a/recipes-devtools/gnu-efi/gnu-efi_latest.bb
+++ /dev/null
@@ -1,25 +0,0 @@
-#
-# CIP Core, generic profile
-#
-# Copyright (c) Siemens AG, 2023
-#
-# Authors:
-#  Jan Kiszka <jan.kiszka@siemens.com>
-#
-# SPDX-License-Identifier: MIT
-#
-
-inherit dpkg
-
-CHANGELOG_V="<orig-version>+cip"
-
-SRC_URI = "apt://${BPN}"
-SRC_URI += "file://0001-ARM32-Split-headers-and-code.patch;apply=no"
-
-do_prepare_build() {
-	deb_add_changelog
-
-	cd ${S}
-	quilt import -f ${WORKDIR}/*.patch
-	quilt push -a
-}
-- 
2.47.3

