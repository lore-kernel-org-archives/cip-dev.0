Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5CDD9CDE017
	for <webhook@archiver.kernel.org>; Fri, 14 Nov 2025 06:57:57 +0000 (UTC)
Received: from MRWPR03CU001.outbound.protection.outlook.com (MRWPR03CU001.outbound.protection.outlook.com [40.107.130.68])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.12548.1763103470654311892
 for <cip-dev@lists.cip-project.org>;
 Thu, 13 Nov 2025 22:57:51 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=sUO5iWCO;
 spf=pass (domain: siemens.com, ip: 40.107.130.68, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ToN1EpMh9oCzau7SardFDWN2Cg1ziBwBgz7HyZxFQsqAk2Ebuf/dVOczPYzMBmW0hs1A/fgMSOi7mBVzRadfU57ZFw3hTVPTHS1TcWBqSCYKdUHu+xGmV/qqOtSFAWH36/41RxCoOpYd2fu/bWJELmcotVNiZE3XT+iNxSTPQplsJHv3rV+FRQWRfHy1EoV89IIa8lLDxtnYpbolRBXUVsn3r7a5rAljoaCQqMfpSZ2Y8qDJ3SMQ0cm8BMXy6W6E3UL7/UFbKdtIBdSFj/saGPPIlMCa7Csier507k1bavXdba667f757u00tqjQWv/3YxMbq1T7ZCc6NieKbBbTaw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uJGo4GmViD2xis2qdut9Z+dgl0wz4CWv//8j1QBV28k=;
 b=FxEDfNjsQB9lg6Cme+P9f7O1aHQHpzCQ4gkAZQXfBGfyTUlgQUTyNPH6DYKQhdGp7Ch/eX1mg0DbYMPsnmBqpp+1J2l1YwN4lV+GjiWVzOES4z2w4hFSc4qNActEhZoUioGTBfx9ZGDEsOg6CtyGz/MqLuOdBRKeVCG5DWcUoPQl2jxH7vqcc2amE4KMQz3CjEcHthYZ93goVJRjpPfqsoi1MZCR1Rmbuebk8ONer1pIifIsW4sHNWIJB+38MTyiyDIKjGHEhtQem0kS54qYmqSZcrEJP9fyLXnhP2PLmvpk4ABKAGw5eItPaWbOpGC743yfA9VmpvDstKHsy8dL4A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uJGo4GmViD2xis2qdut9Z+dgl0wz4CWv//8j1QBV28k=;
 b=sUO5iWCO86b8XBXluX2JCTVDQTDlc5MjUyGd6g9kLDx+V3DKe/f6z3UgIuctYPx1QvCCuuMD9KgVWcWCMvkwO4IYR78F1WxfxgY1UR2sjgw6T8mDuDaWLw9VMjoSXSnwo0DJUdm8GTSIoRO4AoTWfJ9t2rDeqtUXIU8gVJUF7CbPZhzL78YtYDyz7buD1ecxClS++kH65Dyo4sgGcSwOXFXkEnPuJx6w4redStebFWmtFExkA6IZtzoVWZcr3DRODTJnKnB9mLHON6/30NvP9wZxh9qHmKLeovJi6ar2yOrC+b/akvkadr7+3TvmuiF+qqvXiPawWtWQJvXHTSGU9Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by DB9PR10MB6524.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:3d4::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.17; Fri, 14 Nov
 2025 06:57:47 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%6]) with mapi id 15.20.9320.013; Fri, 14 Nov 2025
 06:57:47 +0000
Message-ID: <6b9feb19-856e-43a1-ab2b-38311130d71e@siemens.com>
Date: Fri, 14 Nov 2025 07:57:46 +0100
User-Agent: Mozilla Thunderbird
From: Jan Kiszka <jan.kiszka@siemens.com>
Subject: [PATCH 4.4.y-cip] ARM: 8933/1: replace Sun/Solaris style flag on
 section directive (part II)
Content-Language: en-US
To: cip-dev <cip-dev@lists.cip-project.org>, Ulrich Hecht <uli@fpond.eu>
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR0P281CA0159.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:b3::15) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|DB9PR10MB6524:EE_
X-MS-Office365-Filtering-Correlation-Id: 919e8bda-dbb7-446f-ed14-08de234b1e22
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?dEt5cG04NG43VWZCVW96V05LSTNzaU02K0RVTUN2NVY4V3l4Wm9xQ0pzUEJk?=
 =?utf-8?B?dy90VVFYM1ZPZWgxSEZjTWVJWXQwQjY0TVdVZlJLVWJ3OUdpTDhMOFBVZnYv?=
 =?utf-8?B?eDdLSFR1cWVEeWhvZFp1eUc2RWFIRDlmR2p6YmowUDRvM2hSOXRsTlRkRFhK?=
 =?utf-8?B?ekp1VTh6UFd5TzJkODBFNENlb2gvME5aK1hiU1VzT3N3UXcyUjlxRUdDbzZu?=
 =?utf-8?B?dzBxWjcxQWJiemloT3hhN3BvamRMV2Z2Q2g2dGJ4Ni9VMDNiamloMGwrNUlO?=
 =?utf-8?B?SVIwRU9nT3UvQjd3Ty9SeHdOc1prOHFMejV1N1RTT0doQlo0M2hTOHZtVXc0?=
 =?utf-8?B?R0RsVnRaZnRJSmVNcUx1cklUUUw0WmNrUkxmbWpjR2R2Mmw3T3ljMmwrTHFv?=
 =?utf-8?B?VHFYbktIdXEyRUZtOCs4Q25WMWltVjF0cDBQQWY4aTBQZEJaUlNiTFE4MTU2?=
 =?utf-8?B?RHdGRzVyRjM0aXFMc2pIZ0dnejl2Q2EvS2lGMjVSOG9IakQ5MEtGbEhrd2Nz?=
 =?utf-8?B?SmdBMVg2bkoxcG9DU1lmMnA3TUZnNG5nY3ZhRzRySGhqS3FVQWw2VGMrUGdE?=
 =?utf-8?B?czR6YTZZT2I4TlFTVU8vbUl2eUM5Um5TZWVpTDhaMEZwTmVYSnNpSTJSa2hD?=
 =?utf-8?B?dW1TVFVudHV0Wm1RTC8wbFRYbHRPUGErSnBleThDajRmZjhVNU1lQ2h1aTNP?=
 =?utf-8?B?N0MxMVpPQS9BN0VCN3ljeUlTMlFmSk9Qam5GaXNDU0Q4dUpDeW5oa1JJL1px?=
 =?utf-8?B?QW10TmdFampzc3BVYTF1OFFhVWp6UUxjN1h3ays1UkszVnZDZm41aDBaQVVR?=
 =?utf-8?B?QytRVit1eG13VkNZTjluWDZhK3RwSWdORXc3UjBqWTZDYmNRd2JlUC85Uk5L?=
 =?utf-8?B?K0RIeE50TVZMRU8zQVR2cjB6KzdubS9lckxhWTYvWnNXaUl1MVVUT01EZm51?=
 =?utf-8?B?ejY1WmdDMWhGNERZQ2dEM1E3SWNmZHA0NC9Td3Z6SGVYMFE0YTY1SFFkS0tZ?=
 =?utf-8?B?SnpWaXlNcnB2L0JFY1RuUlZBTWpLL0xPcDZlaG16cGFXNHNSRzFhNUU0YWJY?=
 =?utf-8?B?RksxMXl3ZEZsYTB0TVdEaURVaDNZVXVCcDNrSmlsenN1R29LYnlYcUQ4SndD?=
 =?utf-8?B?Z1BITFlDbjFjRUFYaG0xQUhYYUZTOHdTZ3ZCMWJBSzRSQVd0S0ZSQ3FQK3ow?=
 =?utf-8?B?b2hOUEhmY0xkNkZBYitYazEzSGVrMVNOQzFQWkVVUENQMG5JVnlMeFBCWmow?=
 =?utf-8?B?bm0wTkFSSHh0UVJXaXZoUlVtK3hYQXlXdGNnVWFtU2dzVUlvM1BrbzBxVFBr?=
 =?utf-8?B?QUtBa0ZEbjhOcEMrZjJJYTB0MHpISWFoVW83QlB5WllRRUY5WGpvNjBVclBN?=
 =?utf-8?B?ODRiN3loZ1hCdkFUSkNnemYyM2pKTjhVSW1XZUxUOHp2cmhKeTV2YmFON204?=
 =?utf-8?B?bElnSFJEajhObVdxeHNXZk1uU3FuQUxsdFZ1cUZXdm1wSUpiYlQ2aWEwMk5K?=
 =?utf-8?B?V25pSmNOZ2Z0M1I3ZllkUnRZTklRdk5jcmN6RXFpa29IVlpWZnRHUnhYK2x6?=
 =?utf-8?B?YWZJYlBtVEQvWVhaQk5YajkxdkNZRWJva3dxd2FDZzBwUGl6cmtVUkJyUG1T?=
 =?utf-8?B?N2hwU3RmdHhVM0l1QytKZzBzbEdDOEVQWXNibWNWaXlTUGdaT21jbU1YMGJs?=
 =?utf-8?B?eFFKWlBFUEV2Y09jYlZuWG83WWVmNys2bkFGWVlUMnRxK1lYZ1RpbjNWL2hV?=
 =?utf-8?B?dDhyUEtGM1pwdkEwZUJSWlloTlZCRE9ld2VQNDZjOHZDejBxMkRFUEpNZFFv?=
 =?utf-8?B?U2VFWE8zRXRDazhSMThreURIVTduaDh2VWtxckU0dk80dENvSXdkdFpKOHQ0?=
 =?utf-8?B?NDlzSi9FNzJweEIwUlIvWDhpTXdJZ3hxWnZjcG1RNEp6Smc9PQ==?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?YWJNN0xhbmhFclVOeW0xaEJHNVhPUVJZOUF1VEtzT0w1dFJjQ0QyYjZ4NmZo?=
 =?utf-8?B?UnoxVEVYM3pHWGRhUy84YXdBQTJ4QUx4L1NBR2d4VU5OWWdoNTR3enN3ZXN5?=
 =?utf-8?B?TnUvUmN6Sm13OUlmWk50Mk5oaGlFeUE3bnZMb3dhRi9EOWY0b0VkWVF4ek1X?=
 =?utf-8?B?VVFKb0NuTkZCaVFtMTA5aUhUb0dVT3JONUZkUjNFTGt4b0VrMlFrampzK20y?=
 =?utf-8?B?bmpTanhYMHlZUUorQTBvdURyUkJlWTM3NFQyb1pVb0xWZDZYcVBqa21TeWVt?=
 =?utf-8?B?aU9LbEV2U2xHL1hSbkU3SnVlNWRhY2FaQ3JLa1FuQjBUTVBJZnFCdjhvcWNz?=
 =?utf-8?B?RDhkZm9tUU5TMjZWeUpNeGpMbjM5dTY0bit4L21nMm4zRlJINnBDWURDOEJF?=
 =?utf-8?B?ZEVjQmlwODFmbUpBaElYSHZGZDY1SWprc2Fhem5JRXh1eUh0SDMvUnRROEw4?=
 =?utf-8?B?R0hqYURTeHcwZlBwbEs5QTRMdTN6R3lGM3BLY2tYVFFpOW9FRU4wQXVzN09K?=
 =?utf-8?B?bG5QbFRoUlUyVU5OK21td2NqdEZHbUhDeGVNZ01jZkRMVVJTMXVYVjkzRWV0?=
 =?utf-8?B?UFpmS0oxZ2NuMGQ4alU3NmFHVG80ZDZrQjV1RGs2VXRYVFQvUllMQW9RQWlO?=
 =?utf-8?B?ZG1NNVkwTWRSNFEyOXpWY3owQWFyT0IxaE9WUGZaeGVBTE1vMkE2Vm1qU0Q1?=
 =?utf-8?B?L3hWM3JtYU5PVE5BQXBUYU01L1lGOTMxRjhTeHRCbWVLZHdVSXZqUENsUmph?=
 =?utf-8?B?OU9ZcUZibE1VUGJ0NUs2S2xMNGYzNHUwYkJGV0tKa1lFUlZibmpOWmlVOHFr?=
 =?utf-8?B?Wld3bzluNzByN05IUDd1OUVKTTlLTFJhOVlIOEg0MFI2ME5yUWpRa1lxNVR2?=
 =?utf-8?B?Z3FDODV6bzNLbEtIWDNucjJzZk9lSjFsd2dpYkxFY01TbjZiSkFHSW5MY0tR?=
 =?utf-8?B?ZGRPYWxHS1hxQllBTllocUs5MnZYRXBiVTc3K1FpN085aU9FYlZCOVF0d3hL?=
 =?utf-8?B?ckJXYmlmMXJEMmptYys0ZDdvWXpMMmJYTlZLcWJMdk5zWjVzQ2lKSUFtTGVZ?=
 =?utf-8?B?YzNPOXRQVzM2RXhuV3Z5VGhIWS8vT0RoUU5ybkp1V0dyNDNiMjAybTZrQkht?=
 =?utf-8?B?bFpleDk2UVV5U1VUTHlzazJ5K3FCdDZMRTY1OFFWQW9xWXBzSkw4eVpNb01Z?=
 =?utf-8?B?dE5kazdrMnFqK0p1bURyMEQxSFpLWkRtZkdYWC9MaDZMWUFVT3R4OGVGaGZM?=
 =?utf-8?B?UllJYW9RRDN3RWVUN2hwaENmcTN2WXB2Z0JtZmlmNjFLZGlTTzkwQnkyTGJQ?=
 =?utf-8?B?VUJKOC9tQ05STHJzWlppZE8zdVBheUhvZzNhMUhiWml3bmRSandJSzh5dkt2?=
 =?utf-8?B?bytBZHgrKzVYdVVYazZkWjBaK0pBazlGQjdTRzNFaDBoNUpYNStNYmdVTy9p?=
 =?utf-8?B?bzM0ejNnSk9LdVZnb1FnNGVpaGhJb3YyNGgrdFRNa1lnV1lGYzVjV29FL2ZX?=
 =?utf-8?B?ME9TWk1hNWc1OUFPSDZlT0JkbXphZG0xS1BNKzRDVnZ0MFZUWWRtcDU5Smh3?=
 =?utf-8?B?SWwyQkNjOGRQdWFHVjJ3Q3BLRFh0VDBoZW1wSkVlVDRtMkN6SnVhWVN6RnBq?=
 =?utf-8?B?eGhuZGo2ZStxa1NMRFhSRksrU3orOUR6Rys5c1N5d3UxdEhyUTIxWnBYSzhl?=
 =?utf-8?B?cXFPeE55aDhMV2J2ZVpjYWdVWm0wRUJMYnFvaEcyaUVLRHFpWnhEdXRtWXRP?=
 =?utf-8?B?K09rL3QvN2xQNnFSNC9vRDFIb0ZFMi9OUGpnZy9aVFV1ekJKRks1QXlTL0lM?=
 =?utf-8?B?VW82WWtkeHZ0QnYrcjB3cWxxTjFBUlhHTDJXcnFxQTVRS1kwcndDUFZZUHZW?=
 =?utf-8?B?V09nK1N4NXRUM0NheFV0aU1kUFV5eUp6bDNNQmR5TGtIZXoybEJRT0tTOGJI?=
 =?utf-8?B?ZGZNUzZPUUFjelpuQ2VwSXZBa1dqcWQ2bzhwRitET3A3Ly8xdkJmcElyR1Zm?=
 =?utf-8?B?azY0ZEFWMTNIdXdNMnJVckhjNEUrOFhGa0x6VllUN0Q4aGphaXFaUXRJZzdt?=
 =?utf-8?B?UVhSR2tsMG9DZjhKcTdxblhnNWFDdWNKZk0wNStiVW9LdHRpVXdWU1Bvd2lz?=
 =?utf-8?B?R2RyWGtRbUNRU3ZkcHRUNkc5S0w2bmxmRklrMDJWZzVuTlJ1SVNRczRXajl4?=
 =?utf-8?B?bkE9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 919e8bda-dbb7-446f-ed14-08de234b1e22
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Nov 2025 06:57:47.0083
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7RbOklTPU8ZfVJPkXV3WjBI9bvmAVauX2OpVW54Tj8s3Dq6AcQTLdcfz3PFEezMavB2fxSAL4gfnQIoj4Z4Avw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR10MB6524
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 14 Nov 2025 06:57:57 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/20534

From: Nick Desaulniers <ndesaulniers@google.com>

[ Upstream commit 790756c7e0229dedc83bf058ac69633045b1000e ]

It looks like a section directive was using "Solaris style" to declare
the section flags. Replace this with the GNU style so that Clang's
integrated assembler can assemble this directive.

The modified instances were identified via:
$ ag \.section | grep #

Link: https://ftp.gnu.org/old-gnu/Manuals/gas-2.9.1/html_chapter/as_7.html#SEC119
Link: https://github.com/ClangBuiltLinux/linux/issues/744
Link: https://bugs.llvm.org/show_bug.cgi?id=43759
Link: https://reviews.llvm.org/D69296

Acked-by: Nicolas Pitre <nico@fluxnic.net>
Reviewed-by: Ard Biesheuvel <ardb@kernel.org>
Reviewed-by: Stefan Agner <stefan@agner.ch>
Signed-off-by: Nick Desaulniers <ndesaulniers@google.com>
Suggested-by: Fangrui Song <maskray@google.com>
Suggested-by: Jian Cai <jiancai@google.com>
Suggested-by: Peter Smith <peter.smith@linaro.org>
Signed-off-by: Russell King <rmk+kernel@armlinux.org.uk>
[Jan: add bits missing in part I (e47595d2e9fa) ]
Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---

Note that building with cip_merged_defconfig and gcc14 from trixie 
(which becomes possible with this patch) generates several warnings, and 
some might indicate backporting issues. Please check!

 arch/arm/boot/compressed/piggy.lz4.S    | 2 +-
 arch/arm/boot/compressed/piggy.lzma.S   | 2 +-
 arch/arm/boot/compressed/piggy.lzo.S    | 2 +-
 arch/arm/boot/compressed/piggy.xzkern.S | 2 +-
 4 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/arm/boot/compressed/piggy.lz4.S b/arch/arm/boot/compressed/piggy.lz4.S
index 3d9a575618a3e..710f07de46ede 100644
--- a/arch/arm/boot/compressed/piggy.lz4.S
+++ b/arch/arm/boot/compressed/piggy.lz4.S
@@ -1,4 +1,4 @@
-	.section .piggydata,#alloc
+	.section .piggydata, "a"
 	.globl	input_data
 input_data:
 	.incbin	"arch/arm/boot/compressed/piggy.lz4"
diff --git a/arch/arm/boot/compressed/piggy.lzma.S b/arch/arm/boot/compressed/piggy.lzma.S
index d7e69cffbc0a5..cfea81ae8f4b4 100644
--- a/arch/arm/boot/compressed/piggy.lzma.S
+++ b/arch/arm/boot/compressed/piggy.lzma.S
@@ -1,4 +1,4 @@
-	.section .piggydata,#alloc
+	.section .piggydata, "a"
 	.globl	input_data
 input_data:
 	.incbin	"arch/arm/boot/compressed/piggy.lzma"
diff --git a/arch/arm/boot/compressed/piggy.lzo.S b/arch/arm/boot/compressed/piggy.lzo.S
index a425ad95959a7..236976d8dc7d1 100644
--- a/arch/arm/boot/compressed/piggy.lzo.S
+++ b/arch/arm/boot/compressed/piggy.lzo.S
@@ -1,4 +1,4 @@
-	.section .piggydata,#alloc
+	.section .piggydata, "a"
 	.globl	input_data
 input_data:
 	.incbin	"arch/arm/boot/compressed/piggy.lzo"
diff --git a/arch/arm/boot/compressed/piggy.xzkern.S b/arch/arm/boot/compressed/piggy.xzkern.S
index 5703f300d0278..a135d3b549c5e 100644
--- a/arch/arm/boot/compressed/piggy.xzkern.S
+++ b/arch/arm/boot/compressed/piggy.xzkern.S
@@ -1,4 +1,4 @@
-	.section .piggydata,#alloc
+	.section .piggydata, "a"
 	.globl	input_data
 input_data:
 	.incbin	"arch/arm/boot/compressed/piggy.xzkern"
-- 
2.51.0

