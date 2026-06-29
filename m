Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2025C43458
	for <webhook@archiver.kernel.org>; Mon, 29 Jun 2026 10:44:12 +0000 (UTC)
Received: from DUZPR83CU001.outbound.protection.outlook.com (DUZPR83CU001.outbound.protection.outlook.com [52.101.66.66])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.89435.1782729843557875373
 for <cip-dev@lists.cip-project.org>;
 Mon, 29 Jun 2026 03:44:04 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=spo8fHuA;
 spf=pass (domain: siemens.com, ip: 52.101.66.66, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Sph4QUi6j91dAdGB9YQe/lv6pqFFrGnL1hY4HtgivIydi2KPgGhMF4yNKxIF6Eg8VNwUw6deEwYpgo8GvGBTn5Flk0XHNyQ7W4rzI9iGe8bIz0zIuTqyFMtRwTllYDfygR1w6UZ91oFVGgus21oB0NaViQ5Tr9TPA9vZvR8YITnwTn4OpS/dkWnYoZHcp3Cm/s4EBrKTpolXzl+mH748p/cCO0CLFev56JyvegtLlYWegI0mfsdjbkXNqELsUigVceCHcPXE55rRfA3zMt9D0UO9o40l/Bp9sbkT8Yn0n/+HE0JOAjCvrFmbuGPHRBj6/OJnFIdf9sVtKboQCNIJcQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iq3mCXdwBJGyfHJ+zeQ0CBy94N8abvzqwyw3/EYYVQ0=;
 b=H3/msg376nPVs4JqWUE5TlAcIMIXrbaZpBx9zubO+cmX8SYDGjA6mhs9lMc+MPo3PxgO49m0eK5QE/RCbi/R8gKlnye1oNt7IGoZIVA2TYwDg0tqdSBl0qX3I6u5q5C+APIrgXfFerXGZZM75YV+B0Ixbd+8psv81fbLVxICveSAwvyF34KHD+7XrUIdqawabptrMlfd7GbcryrQbgtND6IY/mD18Y8ZwETjjLvK4M476EOkC5HDxODKRZ32RnNuEtOQ5Slr6uZxg7hJGqezobnA8H3k8Yf5PgylDMFKjJtoXkoTZv1Qft2qyKNmEGQI8czW9F1G59wTilHJksEz+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iq3mCXdwBJGyfHJ+zeQ0CBy94N8abvzqwyw3/EYYVQ0=;
 b=spo8fHuAH8XgQ10nahdPHhrG44sdgfG2vmi/vTgutuCcEesiqcHWcK4QWbsVBzQ6h8ez1Xkc+akAAq2dMDXvAhPmhhzEvXxadxLZWm4XzJghD1oYTe7urYKaZeQZH27Gs61Tkc99OHe18r5liTj35HXEF+AMH/CYf302JofrNTqYUh8SMRES96Ao7PcLBAD/XsW088M69nj3l2P6N8lj/xiAN+ncuFDFdsoJ99HiybDIyqP9dORh+yqIO7JDfBTCiDJDBhcm5GgR8prgc11yHsk00t0j1ThFiZshqddaC9aTV/kyxObGrV1k7zS/ft0cu7k4d6TuFE8pDq4tEIfg+w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by VI0PR10MB8498.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:800:235::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.19; Mon, 29 Jun
 2026 10:43:59 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1%3]) with mapi id 15.21.0159.018; Mon, 29 Jun 2026
 10:43:59 +0000
Message-ID: <784f746d-4c3c-439e-a634-a305bea9ad50@siemens.com>
Date: Mon, 29 Jun 2026 12:43:57 +0200
User-Agent: Mozilla Thunderbird
From: Jan Kiszka <jan.kiszka@siemens.com>
To: cip-dev <cip-dev@lists.cip-project.org>
Subject: [isar-cip-core][PATCH] linux-cip: Update to 4.19.325-cip134 and
 6.12.94-cip26
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PA7P264CA0221.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:102:374::17) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|VI0PR10MB8498:EE_
X-MS-Office365-Filtering-Correlation-Id: 1921db28-2926-4e4b-35c4-08ded5cb53f0
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|366016|23010399003|376014|1800799024|18002099003|55112099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info: 
	MA1WOkXXgXk+RPG5qz4tBrfjg6hkBqEv9fAar8va+3Blxbno6fVe5E0JOQhM4jTDNDqoynpZtdTDsW2Q9GoPoAI/KN61MgcqdACsnEyW8HsfTiIpqIKT/RXBk/8ZKvrQ+4KmJXiPMSZlhagyP6uN3Mv1/tWor3Ux9SdruJeJjKKV1Kn+VxLgmphKc12aYnF1PYFAUYYdN1sDATXopp0MzcIatEqeXLyJ7AeFfW/wverfbtVwDDqeGtdx3TrJR37V71uipLD0RNV/RYp5sl+popQuZHh6qj3Kgwf7aVEj4iitMLBtqSLAO9QRJyIEMgQ7DB/0vHLmPEm9l9hGwgBZLIetE4rYAY5nhdrJZVxRPGKsEyxKm1nNQJs59F8cW9PNj7+KdB2BMqrPhmXIRerR9QKd4ijC+/GVXBrhQ8u7cMLgiztm8LKxCD1znJdsEdztUofQaxLPY3r4q/OLIAUc/9GV/J8+TQl78qmnhdrmeWJY6uatMKHIlSd5vwo1j8QaPW2FR1LpECgHNqacwqLDn4EVZ7z0ZFaNV1w/kwRSgEm24UC2rpsxKvpnbj2UxmdO//iSRrA4kEA7GqkycRywxJLzSVkGLT7/FtX48THZ9v+bALO6B7QfTF0QId6tM/0yv6Sg0l5wP6wkCtDo92Gi2cmgC61qSJsgt3lpDCx8U1g=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(23010399003)(376014)(1800799024)(18002099003)(55112099003)(11063799006)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?SFFXS2hCQ3ZNeVpqWURkVkFBZmluQ3ZadXZEbGxYY25MWEx5QU96cVpKazR5?=
 =?utf-8?B?c0hBQmxacVhqUHAwa241S09pYkJFamtaaVBwdWR6aklTSG1IVGx6bDNYRGg0?=
 =?utf-8?B?L2dab29zSmJCRWVvR2lIa2RIMmZnaVFGQ3dXeVl2b2JnNjcyZVRQV3pWTFVI?=
 =?utf-8?B?U0NXQktIdVd6ZC9tb0RyTDcyeGdsMEc0KzBwUXJjY211TTNCZEc2UVZDUFNH?=
 =?utf-8?B?Yzc2VEV4UXU1eUF2c2VBWFIrNWg5cVNiMzAwK3AwUFdLeUtMbHloNHlwZXFj?=
 =?utf-8?B?KzI2bHZaaFdPMmdxbWUyNWFMSXBRWHEwTGt4VFE3enlZNm9MVm95SElBVEJS?=
 =?utf-8?B?YUVPNHhQSDBjMm1Uc2hFOW5UM3J2SG5UTm0rWW9iVTV0czloWFBvT0wwdStl?=
 =?utf-8?B?WkIvK1VOdHBESDZYa2Zra1NJRGtIaEJLVEI3aEVuWUNQckNKMm9ldk9tSzlZ?=
 =?utf-8?B?MzhHQUZya3RCblRtMjZNSDl5Mit6NC9rY0tDWWhMdU5MTnY1ZU1rWjBONEpa?=
 =?utf-8?B?UlFDdFpCZDVJUExYY08wcDNhSlordWZLODFGSFlIZm9KVnord0NmTXJDcU9R?=
 =?utf-8?B?a1BLMHJIVE5CWElNczVzYlhhRmhmNStQYXdlbVNjMnBjMFVSVWZuOGt5bldl?=
 =?utf-8?B?S3pkZlhCTVdsVFIwNU1YSnV0YmFudDlieXhXV25zTjRFdFhPbUxqSXhlSXY0?=
 =?utf-8?B?MndPK2xhQ09wRGR1UFlBdFIvRjRMZTRJUkhHMUJYcXQ4cU03bVYyaGZtZVIx?=
 =?utf-8?B?cFZ2NUtkMDZOeDN4WHZZZTl0Q2dxRVkzVnJsWWF2WlRmYXN6KzhQUmVlbUQ0?=
 =?utf-8?B?OG02OUg1WnQ2Y0F1SWVrdEtzanpvWStIdVZZVmZxRFV4T3pWS0tBUXhBYWFL?=
 =?utf-8?B?d2tqandPS3F0dnNMZUpualcrY1NMZGlJU2xnYjNyL0R2a3NsNU1IRjBZZFBi?=
 =?utf-8?B?SHkyOXRYTG0rRG5kMktzVjBZTnc4ajI3S3lrbS9WY2xKaUI4eG83YTBhdmFW?=
 =?utf-8?B?K1ZXdUZTZ3hRM25vcHRaUmM1dFMwUFc1cEJZOTZIY2JXNlY3Ymdpa0twcHJ3?=
 =?utf-8?B?YnNqMHNJSWFnMnJGWXp2MWphVEZadGNXZ3pyQmt0aDNmcGdOc0ZTejVlVmFu?=
 =?utf-8?B?UG1jT29oVERRVjNRS2hvTDJ0QmU0QjVEUEZzWGVOSjBKN3J2R0gzVW9GUThF?=
 =?utf-8?B?L3crS3JvTlFmblhUSGRlOFFFbjVWaXNwNFJBVnJkMTFQczMrTWJiR0loUUYx?=
 =?utf-8?B?VWNWSjN3RmxmUlViSXZia2hhTXNqZFdIWmdFRUdsVC96WEM3RjA0dVJUbFNW?=
 =?utf-8?B?RkRTeFl0Z3p0ZG5JS0xIenNtUjRXdW5vU2pTbWpUQzRVdVpxanQ1NDVDZ3I5?=
 =?utf-8?B?akJCeDhaWENjUlVuMUhGUmhqbFRXeHRjZHpVTTNNY09GUmFTcXlPQ0RsOGF2?=
 =?utf-8?B?UkYycC9Yck1kdUNXeW1wQ01FZUxtaGtDb0Y4bjZrNmZYejJBenVaNWs4aWtH?=
 =?utf-8?B?ZStGc0VYZk5mMGNZY3hpcW9CS1pVSCtseHVVRHJjVjNqb2YyRXU1U010Vnhh?=
 =?utf-8?B?WGRURHRyR2xCbkhLMG9TcTBhN0NYaFo5ek9jbnNYNWhkaUJkTmYwUjlXL3RK?=
 =?utf-8?B?NTcxOHQrZU9MK0cwU3F4QVRvcFcyeEE0Z2dvK3phdk5wNlIyTzcrSnN2Q1U1?=
 =?utf-8?B?ZXUrVXJjN1BIQ3cyTkJrUjVHZnRnaDRDY0JDMThSMHBnbUJwcU1yUllrcGt3?=
 =?utf-8?B?THFzcTU5alhHRk9nem9XalBCVlpaVU4vcWdCT0pyUnNVWUVPeUJvNkFwdGVs?=
 =?utf-8?B?clBySndhMWx4VitXM3NyZmRQYitIbkU2S2VaNEszckk4cmpKR2d6Q2p6dUNo?=
 =?utf-8?B?QWxzdnl3bkVvUVlIWDM4bStBYk5Wd2xKelV2a3BCc3NOOFRLV2N5QUZSMnBM?=
 =?utf-8?B?cXRGdms3TCt6YkNxL251R1ErTnc1djRRemV1Z2JyNnpNcFlYNHJTd1hyYjJD?=
 =?utf-8?B?SkNlZkYzdnI3VkVRcEk0a09oakJsYWxxOG51Zit2WVZkdlB5SThqNnVMRENa?=
 =?utf-8?B?SXRZKzN5MWUzbUFTVG5FWkdIczB6MFhPNzI2Rm9ZLzFYSXZjakwzRzVpQ2lE?=
 =?utf-8?B?NGluYk5iaUFwMFpZWERJc0UrVkZqWE9XeDFzZGNuYjFycVJmcmNPWW1uekNE?=
 =?utf-8?B?VEZHbndmeWJRRHAwLzlmcW0zcWI5RmlCSXBYYlhBZWo4eFBPU3U4KzB0V0Zx?=
 =?utf-8?B?NTY5UXM2QkNCRFMxdEdpMTNrYVFsbFJiaEh5UjIvNzBFd1l3K24zbFhkRFla?=
 =?utf-8?B?MHJGNE5Bem83bzUvTnJ0dmVPemlKMkpOa3hvaXQxcHVxcWxjN2NYVE02OU5T?=
 =?utf-8?Q?LDJLW7kD4J33hSps=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1921db28-2926-4e4b-35c4-08ded5cb53f0
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jun 2026 10:43:59.7711
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Xkr53enC6KdjV4YrLkzn/Ikt+kL5vO7Gf3ugsZYAhXB1qo7L9zRux3NDvuaU+KR01osj8m4elKHXgBdQ6pJKIw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR10MB8498
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 29 Jun 2026 10:44:12 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/23302

From: Jan Kiszka <jan.kiszka@siemens.com>

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 recipes-kernel/linux/linux-cip-rt_6.12.92-cip25.bb              | 1 -
 recipes-kernel/linux/linux-cip-rt_6.12.94-cip26.bb              | 1 +
 ...inux-cip_4.19.325-cip133.bb => linux-cip_4.19.325-cip134.bb} | 2 +-
 .../{linux-cip_6.12.92-cip25.bb => linux-cip_6.12.94-cip26.bb}  | 2 +-
 4 files changed, 3 insertions(+), 3 deletions(-)
 delete mode 120000 recipes-kernel/linux/linux-cip-rt_6.12.92-cip25.bb
 create mode 120000 recipes-kernel/linux/linux-cip-rt_6.12.94-cip26.bb
 rename recipes-kernel/linux/{linux-cip_4.19.325-cip133.bb => linux-cip_4.19.325-cip134.bb} (68%)
 rename recipes-kernel/linux/{linux-cip_6.12.92-cip25.bb => linux-cip_6.12.94-cip26.bb} (59%)

diff --git a/recipes-kernel/linux/linux-cip-rt_6.12.92-cip25.bb b/recipes-kernel/linux/linux-cip-rt_6.12.92-cip25.bb
deleted file mode 120000
index 1afb3642..00000000
--- a/recipes-kernel/linux/linux-cip-rt_6.12.92-cip25.bb
+++ /dev/null
@@ -1 +0,0 @@
-linux-cip_6.12.92-cip25.bb
\ No newline at end of file
diff --git a/recipes-kernel/linux/linux-cip-rt_6.12.94-cip26.bb b/recipes-kernel/linux/linux-cip-rt_6.12.94-cip26.bb
new file mode 120000
index 00000000..9866e05a
--- /dev/null
+++ b/recipes-kernel/linux/linux-cip-rt_6.12.94-cip26.bb
@@ -0,0 +1 @@
+linux-cip_6.12.94-cip26.bb
\ No newline at end of file
diff --git a/recipes-kernel/linux/linux-cip_4.19.325-cip133.bb b/recipes-kernel/linux/linux-cip_4.19.325-cip134.bb
similarity index 68%
rename from recipes-kernel/linux/linux-cip_4.19.325-cip133.bb
rename to recipes-kernel/linux/linux-cip_4.19.325-cip134.bb
index 6dbedc2d..0d60731d 100644
--- a/recipes-kernel/linux/linux-cip_4.19.325-cip133.bb
+++ b/recipes-kernel/linux/linux-cip_4.19.325-cip134.bb
@@ -11,4 +11,4 @@
 
 require linux-cip-release.inc
 
-SRC_URI[sha256sum] = "7f3b7d51b94d7c5696f0403d2467908891d4b97abb3abae01582b8415fa0832d"
+SRC_URI[sha256sum] = "5a5a9570fb597f77229b7fc5ed0926e354cd0ed337bdf07099f53b8d71c31293"
diff --git a/recipes-kernel/linux/linux-cip_6.12.92-cip25.bb b/recipes-kernel/linux/linux-cip_6.12.94-cip26.bb
similarity index 59%
rename from recipes-kernel/linux/linux-cip_6.12.92-cip25.bb
rename to recipes-kernel/linux/linux-cip_6.12.94-cip26.bb
index fe2ca8ea..71c50324 100644
--- a/recipes-kernel/linux/linux-cip_6.12.92-cip25.bb
+++ b/recipes-kernel/linux/linux-cip_6.12.94-cip26.bb
@@ -7,4 +7,4 @@
 
 require linux-cip-release.inc
 
-SRC_URI[sha256sum] = "c29d46ea7b96b4d0f3ee8d39d73067b977747ec46331a9f8e47a1db272dde9e5"
+SRC_URI[sha256sum] = "cea8e7a9e8d00822a4445e096784d8add80662cd9f1f3c426ef17bb331c62c30"
-- 
2.47.3

