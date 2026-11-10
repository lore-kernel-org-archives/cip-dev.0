Received: from AM0PR83CU005.outbound.protection.outlook.com (AM0PR83CU005.outbound.protection.outlook.com [52.101.69.2])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.631.1794328442353946061
 for <cip-dev@lists.cip-project.org>;
 Tue, 10 Nov 2026 08:34:02 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=avJVvKSB;
 spf=pass (domain: siemens.com, ip: 52.101.69.2, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Zf4wToiXmOD0njkMOA8+FAj5Sx/8r5LUQbGNHHLPOQINU7AbtGhjEOIOmbabFJ8uzOOXC7nggKHbDZ7JyLo/eUkK1ylY5sEZhMDG6U4rNe/TpXqtiaFItkxPOmL/aAoggrw4F76NhV1HdqbxyTEfYcW7pJYXdTFaK22eSv4gZvXgOuBxuNHTR+pDfoSP/opRm2Oat0C/24DaLh/I93upYxa2c3r4RpjcapDGPvvkOgUWsTCttHOSWIH3zQjDfZ978cCjHkQv0j3CF48QwrrnnPQNucYqhL8m8ZmRbOtKE+KCot3GhjovwwGt76ikpc1damRqrRQ8OIV0w0QhuXa0KQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+uhGzcMH2eLCQOcV9d4Vbc5kbLz53YsCemKhU/DF74w=;
 b=c/zz4v4GxBN6RTi5NmIVrV3PVy+Pq/Ozq+WrUSs9p/PawkyPfKuQO295MU/Td03EUL7r7aEar2JIEbtlPIwzafY/CxElxxLDdxFuZh/UeLsl1KsEfCVrxHiiggIjicaDzQUjgh9x6Kn63vT2hwVLvQjd58eduiX4Q5hGvUdZeLvhvuq0Fq0HgXjj6FKDhJUa88BIWNonEsdv0CUw4n8i9pCBIibvRKDRDTQ2+883MLuAO3wRo6TnVZbHXYneyIoHU9PlNSxI/J1T/EsurQS+eUpD3wsI9wFd4Z0+u14II7YCcOk1No4BFI+PIqSufVYWkCc6Iyh0V/IRlXTCBkwIuA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+uhGzcMH2eLCQOcV9d4Vbc5kbLz53YsCemKhU/DF74w=;
 b=avJVvKSB2+mrp6nNjBVvThzKHkuTQ/2j6Vx37Bur0Bu+phOhlz6hg+inbZvyBIPVv5aKLdeiCZ5l6MkSe5VX1tigVNXAUnSZg/MUxYypXyylk3QKXYONZNEJeE9Rv9EuEBsbwtrqD8mwxl3Y9zUH/fmpTScgqUxqWz+h1gx3tI4RzQFKHvXGKRvhenEMOB68cAX8QzU7pQrbAWrbRvNFJJk9qnXcboboXdocDj4MvQwzhqBKaKQ/uUScZJKIrtSvAkPx09qNb/1/HbAkIlehG01uZFxsWu7wS40lpdOFHQqLrKHQzAVvzIDwyFs6vF9zDjt98rgPnjDdjS6HcI6EHg==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AMCPR10MB992291.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:785::10) by AS2PR10MB6616.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:55f::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.8; Tue, 10 Nov
 2026 16:33:58 +0000
Received: from AMCPR10MB992291.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::fbce:789a:27cf:d1e]) by AMCPR10MB992291.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::fbce:789a:27cf:d1e%5]) with mapi id 15.21.0615.007; Tue, 10 Nov 2026
 16:33:58 +0000
Message-ID: <87ba589e-3b20-4272-b264-74225378e6e0@siemens.com>
Date: Tue, 10 Nov 2026 17:33:57 +0100
User-Agent: Mozilla Thunderbird
From: Jan Kiszka <jan.kiszka@siemens.com>
To: cip-dev <cip-dev@lists.cip-project.org>
Subject: [isar-cip-core][PATCH] u-boot: Use release artifacts instead of
 generated archives
Content-Language: en-US
Cc: Nobuhiro Iwamatsu <nobuhiro.iwamatsu.x90@mail.toshiba>
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR3P281CA0100.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a1::18) To AMCPR10MB992291.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:785::10)
Return-Path: jan.kiszka@siemens.com
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AMCPR10MB992291:EE_|AS2PR10MB6616:EE_
X-MS-Office365-Filtering-Correlation-Id: 98d0515a-13c6-4902-66a6-08df3f486b57
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|23010399003|376014|1800799024|18002099003|12006099003|10067099003|55112099003|3023799007|11063799006|261028144727099003|261021123027099003|261102123227099003|261021121427099003|261022115727099003|261026121527099003|261026140227099003|261022105027099003|261022075727099003|261009223027099003|56012099006|260925021911599003|260925022911599003|260925021311599003;
X-Microsoft-Antispam-Message-Info: LvhDXp9ZO5uYGga6vHVMEptXT/R2m6mSKZQQ6mxEHqJ5mj8l0wdAXGaWiwqUiL3Q29ImP8zljPkMx6QGIRLlK8EOAiekoRKR3Gcb9C4JDBXam4q2mvXI3d3tIgxhZRjdANBdcyxdxfn6HA9p0ri4Cb6PqNm4M7jv1ZZx9eLfFJKH6XdqCkFrt6InDTIMPwMD4H5zUPQFCAmI0wksfb2iBIyKibujTdf1m5MfUZFX8kwjWzNxNslJbTqmkPrj8ipWyvLUkTUPqaEybQbOXbwcIYv/Gs5bVZ8ZF3/+DkVfaYNVEWX+0DVVnp22gIK8RV4gMbQEVUT2x3DnA+adC3exqzc+piR5QpBKTlcHsDEJPrGYg/0cVhlsjcyEPAn6FBpV0J09a7gyXh6ySj9X5aEBULDyo7dTKsKKTW6BnMU+zU1FoRRiop0GdsJSS8pJJsG73EworzPexilBDKecG0xgqF8lc6zbdO6cW1siPLUIiGdRT2IiyoXo1dxEZ0Ej1+31YHM5+2uwk9M+cHOX2xZCP+v1HSebC91Hm/J0yQlAlb53Bv1NqFBSYZkX4LokbeKqSxZiTTtlwaH2j68dJ2QpjeahoTQUsD5NjsqA5dLWuT8vrwqKCuhShYA7MRkO5q0u
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AMCPR10MB992291.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(23010399003)(376014)(1800799024)(18002099003)(12006099003)(10067099003)(55112099003)(3023799007)(11063799006)(261028144727099003)(261021123027099003)(261102123227099003)(261021121427099003)(261022115727099003)(261026121527099003)(261026140227099003)(261022105027099003)(261022075727099003)(261009223027099003)(56012099006)(260925021911599003)(260925022911599003)(260925021311599003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NWo0NnRuUndUVnFQVHB5a01zcXJXSFpBUllERmhBTUw5b3dCSFd1Wld5WFpH?=
 =?utf-8?B?N08rSytndWdPaktxWHhaYmpJbEoyYXk1aGR3b3Z1Tjk4czZZSmdHTTIyd3NG?=
 =?utf-8?B?N3M5YldzL1V2SjBmeEljVHBKbnR0cWR5UW82aXNLeTRQaWN6MjBaeWtIQXF6?=
 =?utf-8?B?a2RLR1ZlYmFrOGRQZnF5OHc5SllNNFZWRUVjK1Ira0FWeG1jMzlFSzIxRy9W?=
 =?utf-8?B?RVJPaHkxeG0xMmFxNVlsbHJQaVRSWGZjUXJkRDFjODBkSDRTczgrcVlXcmQ3?=
 =?utf-8?B?eFo1czU5Z3N6bWs0Z1ZsSjZ5TW81eTVFWmdsM3FXcGxwUE5YRUUzRm1HZWpV?=
 =?utf-8?B?NjgxM3NkeVhpbXRHT1VNK1Y2VXBMN2VCZnVpaTZWSHpUSDFKczd0b1JibDdK?=
 =?utf-8?B?VmN2NXl1azRCL0ZDdVhYNW1OVHZGL3hPRXRmSkVOY1NpYVpHRTFpUHJ6MGQv?=
 =?utf-8?B?RDF0N2lvUFc4eEhYanYxK1NybEprOG4xTEh1SVRMenNlVWJhZlRBWnptKzNO?=
 =?utf-8?B?NFRZYnVqVXJSWXA5ZGhpSkVnT0RLZ1R4QW9uTURHeVJJc0JGMXpCamU2Wmp0?=
 =?utf-8?B?RU1JMXRNZVVFL3FpUXhhcGIvbWwwSHFhSnFKaW5xZ2VBdEdJdCtobmZJb01Q?=
 =?utf-8?B?bGNrZFVGSVQ1RGUrVWpPeVZsUWRzYjlnaHVVQms0YWRGZStwZDVycUh6ZjEz?=
 =?utf-8?B?WkRweUtKblRXNnoxYmNjQU50dng1R3c4cWdyY21jUnBFeTUwWlVFTUR4Y2xo?=
 =?utf-8?B?b2Y5S1JkVDdKZlVxUkxyd3h3ZHl6S2hCcVVWaVIzR0hPdUo0ejBBVlp1dnpo?=
 =?utf-8?B?ZVdRS0JkY0VzdTluNFFJaFJEVVpFNExiUGo5dTVRNmtMKzBrTnhHa3JYT25F?=
 =?utf-8?B?QjhtZnRyL2thTzkyWnZVUDU2TWRnNXRWMFRDYVBSaU1iSzBiNDBxdmJRVlUv?=
 =?utf-8?B?RHNYRHZwcDhWQzdTOVNCdG9JemwzMm9zZWhNTUh0Y1ZZMHNONWo1c1k1ZStt?=
 =?utf-8?B?RU9BbzRncHZyeFRYbXVEeGgrZUcyT3N4ODBYTzR2NitBWEZRUHBOMDh5d3N0?=
 =?utf-8?B?QnJ6d0tKYUdEdGhiMTNsMTZQQlpzejRuNG45cGRkOS9kYlRobC8rR1VFZzE0?=
 =?utf-8?B?MmVUdW5IZ1JWMVpNZnZXVXZxMmxJNEZ0OC9WbXgrZzMzVFVIbmRBTExRNlVk?=
 =?utf-8?B?bXVDV1I1cGo0Q1hpdFJrWGF4YjBLWVAwS1BmUmU4eUJsenJTczJpQVp4OWlD?=
 =?utf-8?B?NXgzcWsxdi8ralVLNGloZHlTT1h2Ym1CdzB3ZjNOcXFINmVDanlFWWhwZ3Nz?=
 =?utf-8?B?SWVRck43aWN1aW5JRWNwc0Mza2NqREYvd3lGVEFEcWNOTHF3d2srSGVZYlpY?=
 =?utf-8?B?cHlyQ0F3MHZ2dXBJTWxSOTVoOFBsR3l0cHE2aWJtbjVKaWlSNWdUeVpIY2lt?=
 =?utf-8?B?VnNuSU1yRlNUamFYNis1MFRHdHBHRHFMZ284Z1B5U0c5aCtnZStDQ0xXbFF6?=
 =?utf-8?B?aSt2a3ZGRTg2MlpIUTdaQUY1Qzh1VGVVY1dWdDFSUFgzaDF1V2MrV2Exb1JP?=
 =?utf-8?B?U2NseENjRFA3NGFHUHVHamtJUzlra0lxSjRJcXdUVmtYUEZrbnNkSi9PVDAx?=
 =?utf-8?B?a2k5VWxsdFVSUklhNDlWQjZCRThJNmJYRXhtNHN1QmpYNUl3aU5VeWVOQXRz?=
 =?utf-8?B?cTVrNEp3RGJsYzNmaFRlNHZ3dDZMQkJHSGRQZVFxTGlieWVld2lPZERTOUhs?=
 =?utf-8?B?VzIxdDZrM1JzMS9HTjlBbGU2TEZTbUpBT2NMcEV3eEVsRlYxOEIvMktWK210?=
 =?utf-8?B?MXVYcjliZy80UGN1NW53Q0NkQm1lUlppMVc3aHVIS1d1OXpMc2pIaXNEVXNp?=
 =?utf-8?B?d1k4Wkk1S0FwRGVPcXllRHFMY0RISkk1MUFIVFFQNTBHRDg0SlZrNFRnY2dD?=
 =?utf-8?B?WmJDcmZsWlIvR21HaWNsUG5FL1YwV0RZSDVLb0pvMlpZS3Z3eFM3bm8rNFlt?=
 =?utf-8?B?MUhjeldpWVNlSlhHMEtoK2hOREs1aXJQd0hnNEdETkJXVWZFZUdFWkZSWnQ3?=
 =?utf-8?B?dFZrU1FXQy9Zdyswa1JCMGtmQU1sVmVOZ3laL0tJK1FWTU1zeFVGVU1sVmxt?=
 =?utf-8?B?MzJEeE0xaHZ3UHlrMkpKektqWkg2MUp2VVRDaG52bVVIZ2ZHMUFWZW9aVVJV?=
 =?utf-8?B?V0JkaWwrNVhBNk9XR2Vzcm0zdUdyTE4ySEd5VHhiTUgzdnYwYkVLSUl2dk5R?=
 =?utf-8?B?V0tLK1ZSckZ5SnZnazY0VkNyUXczcFMzMldQNXRRNnA1bE9xSzZKcXV1UFhK?=
 =?utf-8?B?ZWQrN3M3SlN3T3p5SUt0VFhZdmI5VStYdGdiblo3OEIraUJ5Si9rZz09?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 98d0515a-13c6-4902-66a6-08df3f486b57
X-MS-Exchange-CrossTenant-AuthSource: AMCPR10MB992291.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Nov 2026 16:33:58.1730
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: l5cVt9/TBCfOkK4HJvrcLP2/YmhcsCLWvZ4NOvnWAeYDZv+zvwevCjyHhHTGk199FcjgIw4bBeFI/lrDxdd2xg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS2PR10MB6616
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by lin-tor-korg-lkml-alma10-1 with HTTPS for <cip-dev@lists.cip-project.org>; Tue, 10 Nov 2026 16:34:07 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/24734

From: Jan Kiszka <jan.kiszka@siemens.com>

Should reduce the load on the gitlab server and gives us the bits
faster.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 recipes-bsp/u-boot/u-boot-common-2026.01.inc | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/recipes-bsp/u-boot/u-boot-common-2026.01.inc b/recipes-bsp/u-boot/u-boot-common-2026.01.inc
index 60dffe0b..8166379a 100644
--- a/recipes-bsp/u-boot/u-boot-common-2026.01.inc
+++ b/recipes-bsp/u-boot/u-boot-common-2026.01.inc
@@ -1,7 +1,7 @@
 #
 # CIP Core, generic profile
 #
-# Copyright (c) Siemens AG, 2022-2025
+# Copyright (c) Siemens AG, 2022-2026
 #
 # Authors:
 #  Jan Kiszka <jan.kiszka@siemens.com>
@@ -16,7 +16,7 @@ MAINTAINER = "cip-dev <cip-dev@lists.cip-project.org>"
 FILESPATH:append := ":${FILE_DIRNAME}/files"
 
 SRC_URI += " \
-    https://git.u-boot-project.org/u-boot/u-boot/-/archive/v${PV}/u-boot-v${PV}.tar.bz2 \
+    https://git.u-boot-project.org/u-boot/u-boot/-/releases/v${PV}/downloads/u-boot-${PV}.tar.bz2 \
     file://0001-spl-Kconfig-Add-missing-SPL_LOAD_BLOCK-for-SYS_MMCSD.patch \
     file://0002-spl-mmc-Account-for-SYS_MMCSD_RAW_MODE_U_BOOT_USE_PA.patch \
     file://0003-spl-mmc-Respect-sector-value-passed-to-mmc_load_imag.patch \
@@ -34,7 +34,7 @@ SRC_URI += " \
     file://0006-mmc-Call-back-to-optee-after-a-successful-mmc_init.patch \
     file://0007-mmc-Make-MMC-Device-not-found-a-debug-output.patch \
     file://rules.tmpl;subdir=debian"
-SRC_URI[sha256sum] = "536c2204bb875236dcba41f5a5802090039a4b7a704dd284fcb9640e66a84a8a"
+SRC_URI[sha256sum] = "b60d5865cefdbc75da8da4156c56c458e00de75a49b80c1a2e58a96e30ad0d54"
 
 SRC_URI:append:ftpm-stmm = " \
     file://ftpm-stmm.cfg"
@@ -42,7 +42,7 @@ SRC_URI:append:ftpm-stmm = " \
 SRC_URI:append:secureboot = " \
     file://secure-boot.cfg"
 
-S = "${WORKDIR}/u-boot-v${PV}"
+S = "${WORKDIR}/u-boot-${PV}"
 
 DEBIAN_BUILD_DEPENDS += ", libssl-dev:native, libssl-dev:${DISTRO_ARCH}, \
     libgnutls28-dev:native, libgnutls28-dev:${DISTRO_ARCH}"
-- 
2.47.3
