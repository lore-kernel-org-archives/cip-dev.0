Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 260E7C83F03
	for <webhook@archiver.kernel.org>; Thu,  3 Jul 2025 12:17:36 +0000 (UTC)
Received: from OSPPR02CU001.outbound.protection.outlook.com (OSPPR02CU001.outbound.protection.outlook.com [40.107.159.50])
 by mx.groups.io with SMTP id smtpd.web10.21058.1751545051679996291
 for <cip-dev@lists.cip-project.org>;
 Thu, 03 Jul 2025 05:17:34 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=of+kkkaW;
 spf=pass (domain: siemens.com, ip: 40.107.159.50, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JexXPXyltIIv8AsWyZv8U6Oyn/KY3VjAr2U/1rr4+cia2w9D94luZfIDSS5jKCorQ/53JLXnjqRjro8BpWESZsnxXB28/wmuX3WVEiZWaySrLyN7e8X3p2ZfkFFC43aV0sLYYxGeeLaxaAxI8GOvHwGnE1V+Lokta7TekZCR77QQpe4ttxVPEYTdCS9g8p701wjHZNawhqM4iNlDxs+8NYh219IiEc79wpduxIcY6/nwJuKYVqkpmzPkmE0PqOH6HnByM3TTeZtrO78Sq0ls06b9a/jIE6FHKaq18Clg3CXj56q7FTVZlXaV6C/JCGZCyFxI87yKuZQZgXL10TEnFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ODVl62aT/WUOSZEHUdx2btOjdtus1TtoykKJKhayX4o=;
 b=LQoW8iwJteb1G4Tan0R9nxRxXk/dABKadH47tWACCmfcL0mZiOjeQmQ89214v/Eeo36u8RdiKaqh5IcNnF2cavLJafT2os5wM9B6l492IjHXT/41jkJXA6jI/kNtZoAIOHg7Sjmb1TAkPwARF9t5G8jKChY71LtyEb1aUC+UW+oYrOugm6mWM4UZBBkGJpim1LPfsx0pbjsRUdvBCmNQmEQRuILx7Ohrp69wQk6mUc3p3p41AZM/bkN8fe4RDFVXDOxEBNma3GXRxBvmputG17Q4DvJ+V9BR0ZMM8f2/uIphsIHX6iU07hk1tM5BO+2FljdkM2OP2696YJL25xBq7Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ODVl62aT/WUOSZEHUdx2btOjdtus1TtoykKJKhayX4o=;
 b=of+kkkaWDyhEvr5ClMZ1qX1nFD4KYPWly7Sipisl3C+mERZJ2Z4KaIf46C4sHplI1fDHVCcCCR4vrBVXscC5ZR/Wxn7iUpB9RSg+IEib3M87Bu/92g9Z32uwBHxJQY0E16cfgZOEOBNitfo7NWsI08YkTGSKbKnemMdTd2URWPCk8uBAvSBE/W3sqyaA/oL8ckr1xxYRwnbr/9+zeO3oUSrd0lRm0c1xe9biZCXJn+61RsX0/RGNwWptCpB8/OC9PFjgq4+uVd7ik1+f5fclkwGYLkVmbPeI1cwcO026EJvM4twVtoHdpg/p4Br81tWLE0mmBKeSHCv+xc+MV/2qVw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by AS2PR10MB7479.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:591::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.21; Thu, 3 Jul
 2025 12:17:30 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%7]) with mapi id 15.20.8901.018; Thu, 3 Jul 2025
 12:17:30 +0000
Message-ID: <6998b4c3-adfd-4302-8cea-06ae7dd1b485@siemens.com>
Date: Thu, 3 Jul 2025 14:17:29 +0200
User-Agent: Mozilla Thunderbird
From: Jan Kiszka <jan.kiszka@siemens.com>
To: cip-dev <cip-dev@lists.cip-project.org>
Subject: [isar-cip-core][PATCH] kas: Update to 4.8.1
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0299.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:e7::10) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|AS2PR10MB7479:EE_
X-MS-Office365-Filtering-Correlation-Id: ed3eec5b-62cc-483b-8e57-08ddba2b94d5
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?djhLUzlBd2liZXdqbkFpVGc5cnBNRW1FNTJCNXExcWszL3RGWW1QQ0JRUXFl?=
 =?utf-8?B?N0FFV0JsRkdHaXdnN1hQUE9oZXMwY1JFK1QzR2J5TjVxQTQ5eTZNRDIwRGdn?=
 =?utf-8?B?bHhIbjZLYkh3L1dCb0psQXZLUXk1YmN2MGZyYlBHWE0vdzZHekN6cEIydTZZ?=
 =?utf-8?B?R0kySlkrVHB1K3dIY0laRjNVVEZGVjBMZ0t6RlhRTVRwTGtWVmJaNVRGYWFx?=
 =?utf-8?B?QUhLUjdyY05BUzlJSG4yV1pDZTZMazgrcDRLSXJDYW5vWjZZRTdVam04YTkw?=
 =?utf-8?B?M29rUlFtRC9LQ3pBaURnbkpsRjlTamNwd1JQNnBjYUI2VXJsZU1iaHFMRGJK?=
 =?utf-8?B?aktVakd0Lzg0TjE0SmhOMzBWZnRLQlNSWWQ5R2tqYnBHTUFwWVVUS2RkOHBz?=
 =?utf-8?B?aG9CbTlqS01jdFNyNXVyNzB0aXpUdC9SazVPVHpDOUhTRlJ5UlFoMTdHV3lB?=
 =?utf-8?B?OWwxMFVrMlFKUHpEaVJnYW8zR21NeDh4V2VHWEI4ZTFnTytDMW1wekdtTjc2?=
 =?utf-8?B?RXNoV1RjRnJzdFNROER1MHEvNnY5Y3VPeFZyWFQ1RUNud1VrdzM4VTVrcW0x?=
 =?utf-8?B?eHNWQ0NmSG9QK3RWZ243bldabDVVV3ZFcml2czVNSldOU2ZCUkplTDFpeGln?=
 =?utf-8?B?MlluNXRDVGdUQW5qYkhBeXZlZVBiZWJjTTFXSWUwQ0tSY2ZnRHQwek10bmtS?=
 =?utf-8?B?RGNBdmxDTjF5bGRpZnkyTGNuN2tRak9Hdm9PdFU0NUpoayt5MTNhNmczWlJ5?=
 =?utf-8?B?R3VxaWNFWlQzMG5sLzVLanIvZUdjenpjREE0ZHlSTUk4b2tBMlhxZnZKQ2kz?=
 =?utf-8?B?bVpPdncxVk9PZE1KZXRoRStCOXpON1E3UUVlazNpbDJndEVIdGtmWGR2UDFW?=
 =?utf-8?B?Rkd4ZWxYa3luT0JESndvOHp2OG1GTnJiQk1UQWFRSjZEdzFpWnZ5YXY3TmIx?=
 =?utf-8?B?MzZvclFwTTRwSWtDZE9yRnFaWElsR3phNTlkeTczTTRrQ1pFOTM2ZUVoQmtp?=
 =?utf-8?B?amVvOVl6UER3NXd2bVluMnBpVTl3bG1BS25UaXJhK25SVHdlbUo3LzRwdlY0?=
 =?utf-8?B?dXdpTFN0RTBvaGswNEQzZEs4aTFSRElTMjZLM2NpdWluVzFTdEN1UC80eGZz?=
 =?utf-8?B?ZEtGSTFObVoxMmJSNDlCMnpxSGhTdGZNQU9BSHYwZWZrbEZuN0JZVEJVdDVt?=
 =?utf-8?B?cmp6alltd3JoS0ZKV29pdFpyUDkvczBxYlBqWXNRWmdRT29JL0Rhekh5OTJr?=
 =?utf-8?B?cm5PT3JyWGIvUmN5ckE4WEZiclNobUVtK1c5SGpmOGFiS2NwSW1HRVZMRWIx?=
 =?utf-8?B?R3dtTUozVFFrdEhWbi9qdDBqSkFRSWRMOUZKRnBSOERoS1FlNDU3RFZEOVZs?=
 =?utf-8?B?WEUxUm9VWm4ySkZkOExIWlBLQ0huUzFiRnZWY05SMzRySFR4Zm5wNk1MRkI0?=
 =?utf-8?B?c01oUUVRNmRuRy9UN1lJVUVjZnFnS255Y1VJSnp2VWoyNlRVendGN2tIaWhu?=
 =?utf-8?B?T0VWSnVkNC9veTBiQmQ1aVJzeTdQakExK0g1Z1JYTFYxYWJ5Q1VZS1haMHZT?=
 =?utf-8?B?R2M3MGhKZi9YT0pwbEpoMFcxZjBIMWFFWnR0KytjQjdiODErT28yTEx4Y0cx?=
 =?utf-8?B?dTE5S1l0SS9kYTZtaGNtdWdFai80d2JmUEJydTgwMlVPWGVvZGF3ZWgzdHhz?=
 =?utf-8?B?TnpRYzlvNGNvTUQ3ZU5QZHBGdlNXRTFvR3c3amtHWGt4T25FdTFyWHBnemVU?=
 =?utf-8?B?WnB3OTYxbEkwUVBTOEtZZ3VwUG1RcFE1QXJwaGdlK0tRQTlxTGFXUmdwZHBB?=
 =?utf-8?Q?x34CJKwmfnOvTkZkWOOfdw4ADgyQlUdUkh+/0=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?TTlFeFJiWmMzdGhLNWN6bzN6aUw3c0xMSmNPU1Vad2NraTBjNFJWTXIwN2VF?=
 =?utf-8?B?SjY2b3hHeXRBNGJTMU9QWnoyVUlkbTJlaUFFR2sxdlRCYlVMeEFpVVhKMnpN?=
 =?utf-8?B?VXFqQ1EyTTVwOUhleXA1cGt5L203Q2lBa3QzSHZQUlU3emYrWDNDN01Sc3h5?=
 =?utf-8?B?L2FpUXVsamZGVG9ydDQwSUtmYlFuajFrdXlGNTArZ251SCtNVGhrRW8zWmMz?=
 =?utf-8?B?NVJsR3VMZGFVSVJZY2h3S1hyZGdNWEszb1pLY21qRFJ5R2VrOVN6Q2EwMnlP?=
 =?utf-8?B?Q1VGTkpsWS9kUU1nZytEQ3FPSm5DczB0TENUdXdZWndFY1lrb21qWTdoSGtI?=
 =?utf-8?B?TVYvNk5rOWNXNGRTaUtYajRBbXhlOXZRVDUvMytpRjV6clJURDNNZ01ZejNh?=
 =?utf-8?B?UzZXNXhxSlp2TnowNFBmNU95MzVWbFBXU3c1a0VCMzVyYUIvV1VrcWUvMnZE?=
 =?utf-8?B?OFArS2NlWGd6bnYzQ0U0ak1NdDVmOHAvRXZiallNRUdUZ1dsMlBHN1VSL2tJ?=
 =?utf-8?B?dkdnSG02VzdkT0t4d3ZPOG9FUUdtdVJYeTN2eHN1L3BDbFpqMHhlK3hWeCtt?=
 =?utf-8?B?SHVyb1ZMazVOR21DZDNPRTd1UkJxallJckpjLzNzNFg2QlBuZ1Fxd29kNUw4?=
 =?utf-8?B?VStJL2NYcVBwaFpXbFhSYTdzLzU1L05aaDhZVzJpZlpXSUNiRXU5Nml3Ujl2?=
 =?utf-8?B?WDFiUUxDMnFMRFoydHZSVVNhdFZTaG42dEEvc2JNRXZXZGZDaDNCOTl5R2lJ?=
 =?utf-8?B?ay9WczNFWnVFN1o1QkZCSjZ2c1d1b3YyNGZCRVJWOTkyNVN4WE1rUmFNclBP?=
 =?utf-8?B?dXdkRENiOUhNV21zdDRsWlgxV1VuVjN1RHR2aXJPZUpoS2FBb09OcWZKUm5p?=
 =?utf-8?B?Q2pETkEwS1IycDlMYUVFNEtLN0pPUU9aaXhMRHhYSDlNV3VtenZMK3MxdTJU?=
 =?utf-8?B?YlJpb2RYWldmTkRxalM2bUhvSHZEdGdBNEwvcHc4YmNBdmRiUGdiT2FNdy9R?=
 =?utf-8?B?U1QyR0ZpNjl1SnBVOUpZeEkzSW5IV0h4Q241elpoK0tobzNjYUxKSkZjaHk4?=
 =?utf-8?B?a3cxcmhMMEpJdm1FRVR2WFZRYjZOLyszL1luRkdaNVljTEg2OXRaSnpPbEFM?=
 =?utf-8?B?VWVIUndMRmlieUJmVjM0QTByYXRKcVY5TTc0N05TdG1UbUpyYkZ3WDUyV0t0?=
 =?utf-8?B?U0NhU3dJZ3ljQ2Q2Um8rMzYxZnJDV3FsUVk1MWdCV3BUWklLKytXOG9XWmdr?=
 =?utf-8?B?RmVuY0VidmQxeTZPT0F4OVcwKzJwRHhJbTR3UkRsR0ovREdGcmw0YXYycE1l?=
 =?utf-8?B?a3VVN1lQMVA0WGlnMExtZWQ3UzljSDZJWENpZHBHSjZZZVlPdGlzcnFvMzBM?=
 =?utf-8?B?bG1RdFJ0UExVM1JTU3I4bGlBQ2VQUHorYks4ZDhmSzV2aTlGampnSWdOR04v?=
 =?utf-8?B?RG02ZFNmb3ZsSnIrdUM0WlZvWWNwei8razFyVFNQQnpNa01yMSt5Q09nU0hz?=
 =?utf-8?B?cFdUblJUOUhuNGlIYUgzaWNveTQrVjlFWDE4M3FPUEVraHVaSjF0bzByNWRt?=
 =?utf-8?B?SlE0QXhHRTJUUzVqdnlLVlVyYTBTamkyVWNOMElVRmF4UUN0Znl6U2xJSTBB?=
 =?utf-8?B?TGFKNE9RYktuVUw2OUVjbWZIU1dmZ0Q4RkcrZlRHSzFYc0dUbmZ2L3RLbGRa?=
 =?utf-8?B?ZjVscmFGb0tRZWdoTHc3TkxPMnRMNlZtaHJtVjcyOGVkWGkxZmxUR3NxQWFr?=
 =?utf-8?B?Sm5uN3NBY1VMV2I1UjllTmVlZ3BUd2I5V0F0NXlNU092ZlhEZ2p3V0tzN2tK?=
 =?utf-8?B?RkpoQ0pWdHdLSjZuY2ZpVldVNDJmRWFQV0swbHBHaFFLakpLZE9JU3RvWFlm?=
 =?utf-8?B?SHk5dXRYVGZTRlZOYnl1dDJ5Zi9kSlRoelk3V012bUp4NmhScjVzZkkvZjN3?=
 =?utf-8?B?R2ZTaHZPd1FJWC9HaGhBd2xQY2R5b1pad0NDMndlNEV0cTZaUmtEMTBhYkla?=
 =?utf-8?B?aU1RQ1VsbHg3R2xJRkhadUlTY1IyNjVKbDhjNTZkZkJSWFhSV3QwZXFwTnR3?=
 =?utf-8?B?Tm5JM0ZKcDZ3ZlVaTERkMDNSM2F1T3FWK2FibWRhNk5VdHI5MjkvSXVwVy9K?=
 =?utf-8?B?cS93L0JEeGhkVTdzWEJQVWZYNEtlQWF3cWl6dFYzM25JTndyUEdvaXNSVTNh?=
 =?utf-8?B?MVE9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ed3eec5b-62cc-483b-8e57-08ddba2b94d5
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jul 2025 12:17:30.1343
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kgiHISiEN1DFvCchV2bqIjLSmsC8ggQskwkIDD2JZvj1RfNqgOQpiY9W+lz/aGT2Qa4VD4TjPmxZk2vf8AFcNQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS2PR10MB7479
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 03 Jul 2025 12:17:36 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/19325

From: Jan Kiszka <jan.kiszka@siemens.com>

Primarily housekeeping.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 .gitlab-ci.yml |   4 +-
 kas-container  | 293 +++++++++++++++++++++++++++++++------------------
 2 files changed, 189 insertions(+), 108 deletions(-)

diff --git a/.gitlab-ci.yml b/.gitlab-ci.yml
index f7a81276..7c05ad4f 100644
--- a/.gitlab-ci.yml
+++ b/.gitlab-ci.yml
@@ -1,7 +1,7 @@
 #
 # CIP Core, generic profile
 #
-# Copyright (c) Siemens AG, 2019-2024
+# Copyright (c) Siemens AG, 2019-2025
 # Copyright (c) Toshiba Corporation, 2020
 #
 # Authors:
@@ -12,7 +12,7 @@
 # SPDX-License-Identifier: MIT
 #
 
-image: ghcr.io/siemens/kas/kas-isar:4.7
+image: ghcr.io/siemens/kas/kas-isar:4.8.1
 
 variables:
   GIT_STRATEGY: clone
diff --git a/kas-container b/kas-container
index d6118b97..0e99898b 100755
--- a/kas-container
+++ b/kas-container
@@ -2,7 +2,7 @@
 #
 # kas - setup tool for bitbake based projects
 #
-# Copyright (c) Siemens AG, 2018-2024
+# Copyright (c) Siemens AG, 2018-2025
 #
 # Authors:
 #  Jan Kiszka <jan.kiszka@siemens.com>
@@ -27,7 +27,8 @@
 
 set -e
 
-KAS_IMAGE_VERSION_DEFAULT="4.7"
+KAS_CONTAINER_SCRIPT_VERSION="4.8.1"
+KAS_IMAGE_VERSION_DEFAULT="${KAS_CONTAINER_SCRIPT_VERSION}"
 KAS_CONTAINER_IMAGE_PATH_DEFAULT="ghcr.io/siemens/kas"
 KAS_CONTAINER_IMAGE_NAME_DEFAULT="kas"
 KAS_CONTAINER_SELF_NAME="$(basename "$0")"
@@ -40,8 +41,9 @@ usage()
 
 	printf "%b" "Usage: ${SELF} [OPTIONS] { build | shell } [KASOPTIONS] [KASFILE]\n"
 	printf "%b" "       ${SELF} [OPTIONS] { checkout | dump | lock } [KASOPTIONS] [KASFILE]\n"
+	printf "%b" "       ${SELF} [OPTIONS] { diff } [KASOPTIONS] config1 config2\n"
 	printf "%b" "       ${SELF} [OPTIONS] for-all-repos [KASOPTIONS] [KASFILE] COMMAND\n"
-	printf "%b" "       ${SELF} [OPTIONS] { clean | cleansstate | cleanall } [KASFILE]\n"
+	printf "%b" "       ${SELF} [OPTIONS] { clean | cleansstate | cleanall | purge} [KASFILE]\n"
 	printf "%b" "       ${SELF} [OPTIONS] menu [KCONFIG]\n"
 	printf "%b" "\nPositional arguments:\n"
 	printf "%b" "build\t\t\tCheck out repositories and build target.\n"
@@ -57,6 +59,8 @@ usage()
 		    "keep downloads.\n"
 	printf "%b" "cleanall\t\tClean build artifacts, sstate cache and " \
 		    "downloads.\n"
+	printf "%b" "purge\t\t\tRemove all data managed by kas. Run with '--dry-run'\n"
+	printf "%b" "     \t\t\tto check what would be removed\n"
 	printf "%b" "menu\t\t\tProvide configuration menu and trigger " \
 		    "configured build.\n"
 	printf "%b" "\nOptional arguments:\n"
@@ -80,7 +84,7 @@ usage()
 		    "environment.\n"
 	printf "%b" "--repo-ro\t\tMount current repository read-only\n" \
 		    "\t\t\t(default for build command)\n"
-	printf "%b" "--repo-rw\t\tMount current repository writeable\n" \
+	printf "%b" "--repo-rw\t\tMount current repository writable\n" \
 		    "\t\t\t(default for shell command)\n"
 	printf "%b" "-h, --help\t\tShow this help message and exit.\n"
 	printf "%b" "\n"
@@ -128,6 +132,12 @@ enable_isar_mode()
 		KAS_CONTAINER_COMMAND="sudo --preserve-env ${KAS_CONTAINER_COMMAND}"
 		# preserved user PATH may lack sbin needed by privileged podman
 		export PATH="${PATH}:/usr/sbin"
+	elif [ "${KAS_DOCKER_ROOTLESS}" = "1" ]; then
+		export DOCKER_HOST="${DOCKER_HOST:-unix:///var/run/docker.sock}"
+		debug "kas-isar does not support rootless docker. Using system docker"
+		# force use of well-known system docker socket
+		KAS_CONTAINER_COMMAND="sudo --preserve-env ${KAS_CONTAINER_COMMAND}"
+		KAS_DOCKER_ROOTLESS=0
 	fi
 }
 
@@ -155,28 +165,94 @@ enable_unpriv_userns_docker()
 	fi
 }
 
-run_clean()
+# Params: NAME CREATE_MODE
+check_and_expand()
+{
+	eval _varval=\"\$"$1"\"
+	[ -z "$_varval" ] && return
+	case "$2" in
+	required)
+		[ ! -d "$_varval" ] && fatal_error "Variable $1 set, but \"$_varval\" is not a directory."
+		;;
+	create)
+		[ ! -d "$_varval" ] && trace mkdir "$_varval"
+		;;
+	createrec)
+		trace mkdir -p "$_varval"
+		;;
+	esac
+	realpath -e "$_varval"
+}
+
+# Params: FILE
+# Returns: root repo dir of file
+repo_path_of_file()
+{
+	_DIR="$(dirname "$1")"
+	_REPO_DIR=$(git -C "${_DIR}" rev-parse --show-toplevel 2>/dev/null) \
+		|| _REPO_DIR=$(hg --cwd "${_DIR}" root 2>/dev/null) \
+		|| _REPO_DIR=${_DIR}
+	echo "$_REPO_DIR"
+}
+
+# Params: ARG
+process_file_arg()
+{
+	_KAS_FILES=
+	_KAS_FIRST_FILE=
+	_KAS_REPO_DIR=
+	# SC2086: Double quote to prevent globbing and word splitting.
+	# shellcheck disable=2086
+	for FILE in $(IFS=':'; echo $ARG); do
+		if ! KAS_REAL_FILE="$(realpath -qe "$FILE")"; then
+			fatal_error "configuration file '${FILE}' not found"
+		fi
+		if [ -z "${_KAS_FILES}" ]; then
+			_KAS_FIRST_FILE="${KAS_REAL_FILE}"
+			_KAS_FILES="${KAS_REAL_FILE}"
+			_KAS_REPO_DIR=$(repo_path_of_file "${_KAS_FIRST_FILE}")
+		else
+			_KAS_FILES="${_KAS_FILES}:${KAS_REAL_FILE}"
+		fi
+	done
+	KAS_FILES="${KAS_FILES} ${_KAS_FILES}"
+	KAS_FIRST_FILES="${KAS_FIRST_FILES} ${_KAS_FIRST_FILE}"
+	KAS_REPO_DIRS="${KAS_REPO_DIRS} ${_KAS_REPO_DIR}"
+}
+
+# Params: NAME CONTAINER_PATH MODE
+# If the dir is not below KAS_WORK_DIR, the dir is mounted into the container.
+forward_dir()
 {
-	if [ -n "${KAS_ISAR_ARGS}" ]; then
-		# SC2086: Double quote to prevent globbing and word splitting.
-		# shellcheck disable=2086
-		trace ${KAS_CONTAINER_COMMAND} run -v "${KAS_BUILD_DIR}":/build:rw \
-				--workdir=/build --rm ${KAS_ISAR_ARGS} \
-				${KAS_CONTAINER_IMAGE} \
-				sudo rm -rf tmp
+	eval _varval=\"\$"$1"\"
+	[ -z "$_varval" ] && return
+	FW_DIR_REL=$(realpath -q --relative-base="${KAS_WORK_DIR}" "$_varval")
+	if [ "${FW_DIR_REL}" = "$_varval" ]; then
+		KAS_RUNTIME_ARGS="${KAS_RUNTIME_ARGS} -v ${FW_DIR_REL}:$2:$3 -e $1=$2"
 	else
-		trace rm -rf "${KAS_BUILD_DIR}"/tmp*
+		KAS_RUNTIME_ARGS="${KAS_RUNTIME_ARGS} -e $1=/work/${FW_DIR_REL}"
 	fi
+}
 
-	if [ "$1" != "clean" ]; then
-		SSTATE_DIR=${SSTATE_DIR:-${KAS_BUILD_DIR}/sstate-cache}
-		trace rm -rf "${SSTATE_DIR}"
+check_docker_rootless()
+{
+	KAS_DOCKER_ROOTLESS=0
+	if [ "$(docker context show)" = "rootless" ]; then
+		KAS_DOCKER_ROOTLESS=1
+	fi
+}
 
-		if [ "$1" = "cleanall" ]; then
-			DL_DIR=${DL_DIR:-${KAS_BUILD_DIR}/downloads}
-			trace rm -rf "${DL_DIR}"
-		fi
+enable_docker_rootless()
+{
+	warning "Rootless docker used, only limited functionality available."
+	if [ "${KAS_WORK_DIR}" = "${KAS_REPO_DIR}" ]; then
+		warning "On docker rootless a exclusive KAS_WORK_DIR should be used" \
+		        "as kas temporarily changes the ownership of this directory."
+	fi
+	if [ "${KAS_REPO_MOUNT_OPT}" = "rw" ]; then
+		fatal_error "Docker rootless requires read-only repo."
 	fi
+	KAS_RUNTIME_ARGS="${KAS_RUNTIME_ARGS} -e KAS_DOCKER_ROOTLESS=1"
 }
 
 KAS_GIT_OVERLAY_FILE=""
@@ -197,13 +273,18 @@ set_container_image_var()
 	KAS_CONTAINER_IMAGE="${KAS_CONTAINER_IMAGE:-${KAS_CONTAINER_IMAGE_DEFAULT}}"
 }
 
-KAS_WORK_DIR=$(readlink -fv "${KAS_WORK_DIR:-$(pwd)}")
-if ! [ -d "${KAS_WORK_DIR}" ]; then
-	fatal_error "KAS_WORK_DIR '${KAS_WORK_DIR}' is not a directory"
-fi
-
-KAS_BUILD_DIR=$(readlink -fv "${KAS_BUILD_DIR:-${KAS_WORK_DIR}/build}")
-trace mkdir -p "${KAS_BUILD_DIR}"
+# SC2034: DIR appears unused (ignore, as they are used inside eval)
+# shellcheck disable=2034
+setup_kas_dirs()
+{
+	KAS_WORK_DIR="${KAS_WORK_DIR:-$(pwd)}"
+	KAS_WORK_DIR="$(check_and_expand KAS_WORK_DIR required)"
+	KAS_BUILD_DIR="$(check_and_expand KAS_BUILD_DIR create)"
+	KAS_REPO_REF_DIR="$(check_and_expand KAS_REPO_REF_DIR required)"
+	DL_DIR="$(check_and_expand DL_DIR createrec)"
+	SSTATE_DIR="$(check_and_expand SSTATE_DIR createrec)"
+}
+setup_kas_dirs
 
 KAS_CONTAINER_ENGINE="${KAS_CONTAINER_ENGINE:-${KAS_DOCKER_ENGINE}}"
 if [ -z "${KAS_CONTAINER_ENGINE}" ]; then
@@ -235,6 +316,7 @@ case "${KAS_CONTAINER_ENGINE}" in
 docker)
 	KAS_CONTAINER_COMMAND="docker"
 	enable_unpriv_userns_docker
+	check_docker_rootless
 	;;
 podman)
 	KAS_CONTAINER_COMMAND="podman"
@@ -287,7 +369,7 @@ while [ $# -gt 0 ]; do
 		if [ -z "${SSH_AUTH_SOCK}" ]; then
 			fatal_error "no SSH agent running"
 		fi
-		KAS_SSH_AUTH_SOCK=$(readlink -fv "$SSH_AUTH_SOCK")
+		KAS_SSH_AUTH_SOCK=$(realpath -e "$SSH_AUTH_SOCK")
 		shift 1
 		;;
 	--aws-dir)
@@ -329,7 +411,8 @@ while [ $# -gt 0 ]; do
 	--*)
 		usage
 		;;
-	clean|cleansstate|cleanall)
+	clean|cleansstate|cleanall|purge)
+		KAS_REPO_MOUNT_OPT_DEFAULT="ro"
 		KAS_CMD=$1
 		shift 1
 		break
@@ -346,6 +429,12 @@ while [ $# -gt 0 ]; do
 		shift 1
 		break
 		;;
+	diff)
+		KAS_REPO_MOUNT_OPT_DEFAULT="ro"
+		KAS_CMD=$1
+		shift 1
+		break
+		;;
 	dump)
 		if printf '%s\0' "$@" | grep -xqz -- '--inplace\|-i'; then
 			KAS_REPO_MOUNT_OPT_DEFAULT="rw"
@@ -369,7 +458,7 @@ KAS_EXTRA_BITBAKE_ARGS=0
 # parse kas sub-command options
 while [ $# -gt 0 ] && [ $KAS_EXTRA_BITBAKE_ARGS -eq 0 ]; do
 	case "$1" in
-	--skip|--target|--task)
+	--format|--indent|--provenance|--skip|--target|--task)
 		KAS_OPTIONS="${KAS_OPTIONS} $1 $2"
 		shift 1
 		shift 1 || KAS_OPTIONS="--help"
@@ -382,11 +471,6 @@ while [ $# -gt 0 ] && [ $KAS_EXTRA_BITBAKE_ARGS -eq 0 ]; do
 	-E|--preserve-env)
 		fatal_error "$1 is not supported with ${KAS_CONTAINER_SELF_NAME}"
 		;;
-	--provenance)
-		KAS_OPTIONS="${KAS_OPTIONS} $1 $2"
-		shift 1
-		shift 1 || KAS_OPTIONS="--help"
-		;;
 	--)
 		KAS_EXTRA_BITBAKE_ARGS=$#
 		;;
@@ -406,29 +490,13 @@ while [ $# -gt 0 ] && [ $KAS_EXTRA_BITBAKE_ARGS -eq 0 ]; do
 				unset ARG
 			fi
 		fi
-		KAS_FILES=
-		# SC2086: Double quote to prevent globbing and word splitting.
-		# shellcheck disable=2086
-		for FILE in $(IFS=':'; echo $ARG); do
-			if ! KAS_REAL_FILE="$(realpath -qe "$FILE")"; then
-				fatal_error "configuration file '${FILE}' not found"
-			fi
-			if [ -z "${KAS_FILES}" ]; then
-				KAS_FIRST_FILE="${KAS_REAL_FILE}"
-				KAS_FILES="${KAS_REAL_FILE}"
-			else
-				KAS_FILES="${KAS_FILES}:${KAS_REAL_FILE}"
-			fi
-		done
+		process_file_arg "$ARG"
 		;;
 	esac
 done
 
-if [ -n "${KAS_FIRST_FILE}" ]; then
-	KAS_FILE_DIR="$(dirname "${KAS_FIRST_FILE}")"
-	KAS_REPO_DIR=$(git -C "${KAS_FILE_DIR}" rev-parse --show-toplevel 2>/dev/null) \
-		|| KAS_REPO_DIR=$(hg --cwd "${KAS_FILE_DIR}" root 2>/dev/null) \
-		|| KAS_REPO_DIR=${KAS_FILE_DIR}
+if [ -n "${KAS_FIRST_FILES}" ]; then
+	KAS_REPO_DIR=$(echo "${KAS_REPO_DIRS}" | awk '{print $1}')
 else
 	KAS_REPO_DIR=$(pwd)
 fi
@@ -441,8 +509,8 @@ if [ -n "${SOURCE_DIR_HOST}" ]; then
 fi
 
 if [ "${KAS_CMD}" = "menu" ]; then
-	if [ -z "${KAS_FIRST_FILE}" ]; then
-		KAS_FIRST_FILE="Kconfig"
+	if [ -z "${KAS_FIRST_FILES}" ]; then
+		KAS_FIRST_FILES="Kconfig"
 	fi
 
 	# When using the menu plugin, we need to track the KAS_REPO_DIR outside
@@ -451,20 +519,26 @@ if [ "${KAS_CMD}" = "menu" ]; then
 	# on the host. This data is then added to the .config.yaml where it can
 	# be evaluated by the next invocation of kas-container.
 
-	if ! [ "$(realpath -qe "${KAS_REPO_DIR}")" = "$(realpath -qe "${KAS_WORK_DIR}")" ]; then
-		set -- "$@" -e _KAS_REPO_DIR_HOST="$(readlink -fv "${KAS_REPO_DIR}")"
+	KAS_REPO_DIR=$(check_and_expand KAS_REPO_DIR required)
+	if ! [ "${KAS_REPO_DIR}" = "${KAS_WORK_DIR}" ]; then
+		set -- "$@" -e _KAS_REPO_DIR_HOST="${KAS_REPO_DIR}"
 	fi
 
-	BUILD_SYSTEM=$(tr '\n' '\f' 2>/dev/null < "${KAS_FIRST_FILE}" | \
+	if [ "$(echo "${KAS_FIRST_FILES}" | wc -w)" -ne "1" ]; then
+		fatal_error "menu plugin only supports a single Kconfig file"
+	fi
+	BUILD_SYSTEM=$(tr '\n' '\f' 2>/dev/null < "${KAS_FIRST_FILES}" | \
 		sed -e 's/\(.*\fconfig KAS_BUILD_SYSTEM\f\(.*\)\|.*\)/\2/' \
 		    -e 's/\f\([[:alpha:]].*\|$\)//' \
 		    -e 's/.*default \"\(.*\)\".*/\1/')
 else
-	if [ -z "${KAS_FIRST_FILE}" ]; then
-		KAS_FIRST_FILE="${KAS_WORK_DIR}/.config.yaml"
+	if [ -z "${KAS_FIRST_FILES}" ]; then
+		KAS_FIRST_FILES="${KAS_WORK_DIR}/.config.yaml"
 	fi
 
-	BUILD_SYSTEM=$(grep -e "^build_system: " "${KAS_FIRST_FILE}" 2>/dev/null | \
+	# We only get the first build system and let kas check if mixed
+	_KAS_FIRST_FILE=$(echo "${KAS_FIRST_FILES}" | awk '{print $1}')
+	BUILD_SYSTEM=$(grep -e "^build_system: " "${_KAS_FIRST_FILE}" 2>/dev/null | \
 		sed 's/build_system:[ ]\+//')
 fi
 
@@ -474,32 +548,51 @@ elif [ -z "${ISAR_MODE}" ]; then
 	enable_oe_mode
 fi
 
+# clean can be executed without config, hence manually forward the build system
+if [ "${ISAR_MODE}" = "1" ] && echo "${KAS_CMD}" | grep -qe "^clean\|purge"; then
+	KAS_OPTIONS="${KAS_OPTIONS} --isar"
+fi
+
 set_container_image_var
 
-# short circuit for clean* commands. We just need
-# the build-system information, but no repo mounts, etc...
-if echo "${KAS_CMD}" | grep -qe "^clean"; then
-	run_clean "${KAS_CMD}"
-	exit 0
+if [ "${KAS_DOCKER_ROOTLESS}" = "1" ]; then
+	KAS_REPO_MOUNT_OPT_DEFAULT="ro"
 fi
-
 KAS_REPO_MOUNT_OPT="${KAS_REPO_MOUNT_OPT:-${KAS_REPO_MOUNT_OPT_DEFAULT}}"
 
-KAS_FILES="$(echo "${KAS_FILES}" | sed 's|'"${KAS_REPO_DIR}"'/|/repo/|g')"
-
 if [ "$(id -u)" -eq 0 ] && [ "${KAS_ALLOW_ROOT}" != "yes" ] ; then
 	fatal_error "Running as root - may break certain recipes." \
 	            "Better give a regular user docker access. Set" \
 	            "KAS_ALLOW_ROOT=yes to override."
 fi
 
+if [ "${KAS_DOCKER_ROOTLESS}" = "1" ]; then
+	enable_docker_rootless
+fi
+
+if [ "${KAS_CMD}" = "diff" ]; then
+	if [ "$(echo "${KAS_FILES}" | wc -w)" -eq "2" ]; then
+		_KAS_REPO_DIR1="$(echo "${KAS_REPO_DIRS}" | awk '{print $1}')"
+		_KAS_REPO_DIR2="$(echo "${KAS_REPO_DIRS}" | awk '{print $2}')"
+		_KAS_FILES1="$(echo "${KAS_FILES}" | awk '{print $1}' | sed 's|'"${_KAS_REPO_DIR1}"'/|/repo/|g')"
+		_KAS_FILES2="$(echo "${KAS_FILES}" | awk '{print $2}' | sed 's|'"${_KAS_REPO_DIR2}"'/|/repo2/|g')"
+		KAS_FILES="${_KAS_FILES1} ${_KAS_FILES2}"
+		set -- "$@" -v "${_KAS_REPO_DIR2}:/repo2:${KAS_REPO_MOUNT_OPT}"
+	fi
+else
+	KAS_FILES="$(echo "${KAS_FILES}" | sed 's|'"${KAS_REPO_DIR}"'/|/repo/|g')"
+fi
 set -- "$@" -v "${KAS_REPO_DIR}:/repo:${KAS_REPO_MOUNT_OPT}" \
 	-v "${KAS_WORK_DIR}":/work:rw -e KAS_WORK_DIR=/work \
-	-v "${KAS_BUILD_DIR}":/build:rw \
 	--workdir=/repo \
-	-e KAS_BUILD_DIR=/build \
+	-e KAS_CONTAINER_SCRIPT_VERSION="${KAS_CONTAINER_SCRIPT_VERSION}" \
 	-e USER_ID="$(id -u)" -e GROUP_ID="$(id -g)" --rm --init
 
+forward_dir KAS_BUILD_DIR "/build" "rw"
+forward_dir DL_DIR "/downloads" "rw"
+forward_dir KAS_REPO_REF_DIR "/repo-ref" "rw"
+forward_dir SSTATE_DIR "/sstate" "rw"
+
 if git_com_dir=$(git -C "${KAS_REPO_DIR}" rev-parse --git-common-dir 2>/dev/null) \
 	&& [ "$git_com_dir" != "$(git -C "${KAS_REPO_DIR}" rev-parse --git-dir)" ]; then
 	# If (it's a git repo) and the common dir isn't the git-dir, it is shared worktree and
@@ -516,11 +609,9 @@ if git_com_dir=$(git -C "${KAS_REPO_DIR}" rev-parse --git-common-dir 2>/dev/null
 	fi
 fi
 
+KAS_SSH_DIR="$(check_and_expand KAS_SSH_DIR required)"
 if [ -n "${KAS_SSH_DIR}" ] ; then
-	if [ ! -d "${KAS_SSH_DIR}" ]; then
-		fatal_error "passed KAS_SSH_DIR '${KAS_SSH_DIR}' is not a directory"
-	fi
-	set -- "$@" -v "$(readlink -fv "${KAS_SSH_DIR}")":/var/kas/userdata/.ssh:ro
+	set -- "$@" -v "${KAS_SSH_DIR}":/var/kas/userdata/.ssh:ro
 fi
 
 if [ -n "${KAS_SSH_AUTH_SOCK}" ]; then
@@ -531,11 +622,9 @@ if [ -n "${KAS_SSH_AUTH_SOCK}" ]; then
 		-e SSH_AUTH_SOCK=/ssh-agent/ssh-auth-sock
 fi
 
+KAS_AWS_DIR="$(check_and_expand KAS_AWS_DIR required)"
 if [ -n "${KAS_AWS_DIR}" ] ; then
-	if [ ! -d "${KAS_AWS_DIR}" ]; then
-		fatal_error "passed KAS_AWS_DIR '${KAS_AWS_DIR}' is not a directory"
-	fi
-	set -- "$@" -v "$(readlink -fv "${KAS_AWS_DIR}")":/var/kas/userdata/.aws:ro \
+	set -- "$@" -v "${KAS_AWS_DIR}":/var/kas/userdata/.aws:ro \
 		-e AWS_CONFIG_FILE="${AWS_CONFIG_FILE:-/var/kas/userdata/.aws/config}" \
 		-e AWS_SHARED_CREDENTIALS_FILE="${AWS_SHARED_CREDENTIALS_FILE:-/var/kas/userdata/.aws/credentials}"
 fi
@@ -544,7 +633,7 @@ if [ -n "${AWS_WEB_IDENTITY_TOKEN_FILE}" ] ; then
 		echo "Passed AWS_WEB_IDENTITY_TOKEN_FILE '${AWS_WEB_IDENTITY_TOKEN_FILE}' is not a file"
 		exit 1
 	fi
-	set -- "$@" -v "$(readlink -fv "${AWS_WEB_IDENTITY_TOKEN_FILE}")":/var/kas/userdata/.aws/web_identity_token:ro \
+	set -- "$@" -v "$(realpath -e "${AWS_WEB_IDENTITY_TOKEN_FILE}")":/var/kas/userdata/.aws/web_identity_token:ro \
 		-e AWS_WEB_IDENTITY_TOKEN_FILE="${AWS_CONFIG_FILE:-/var/kas/userdata/.aws/web_identity_token}" \
 		-e AWS_ROLE_ARN="${AWS_ROLE_ARN}"
 fi
@@ -556,7 +645,7 @@ if [ -n "${KAS_GIT_CREDENTIAL_STORE}" ] ; then
 		fatal_error "passed KAS_GIT_CREDENTIAL_STORE '${KAS_GIT_CREDENTIAL_STORE}' is not a file"
 	fi
 	KAS_GIT_CREDENTIAL_HELPER_DEFAULT="store --file=/var/kas/userdata/.git-credentials"
-	set -- "$@" -v "$(readlink -fv "${KAS_GIT_CREDENTIAL_STORE}")":/var/kas/userdata/.git-credentials:ro
+	set -- "$@" -v "$(realpath -e "${KAS_GIT_CREDENTIAL_STORE}")":/var/kas/userdata/.git-credentials:ro
 fi
 
 GIT_CREDENTIAL_HELPER="${GIT_CREDENTIAL_HELPER:-${KAS_GIT_CREDENTIAL_HELPER_DEFAULT}}"
@@ -566,17 +655,22 @@ if [ -n "${GIT_CREDENTIAL_HELPER}" ] ; then
 fi
 
 if [ -f "${NETRC_FILE}" ]; then
-	set -- "$@" -v "$(readlink -fv "${NETRC_FILE}")":/var/kas/userdata/.netrc:ro \
+	set -- "$@" -v "$(realpath -e "${NETRC_FILE}")":/var/kas/userdata/.netrc:ro \
 		-e NETRC_FILE="/var/kas/userdata/.netrc"
 fi
 
+if [ -f "${NPMRC_FILE}" ]; then
+	set -- "$@" -v "$(realpath -e "${NPMRC_FILE}")":/var/kas/userdata/.npmrc:ro \
+		-e NPMRC_FILE="/var/kas/userdata/.npmrc"
+fi
+
 if [ -f "${GITCONFIG_FILE}" ]; then
-	set -- "$@" -v "$(readlink -fv "${GITCONFIG_FILE}")":/var/kas/userdata/.gitconfig:ro \
+	set -- "$@" -v "$(realpath -e "${GITCONFIG_FILE}")":/var/kas/userdata/.gitconfig:ro \
 		-e GITCONFIG_FILE="/var/kas/userdata/.gitconfig"
 fi
 
 if [ -f "${REGISTRY_AUTH_FILE}" ]; then
-	set -- "$@" -v "$(readlink -fv "${REGISTRY_AUTH_FILE}")":/var/kas/userdata/.docker/config.json:ro \
+	set -- "$@" -v "$(realpath -e "${REGISTRY_AUTH_FILE}")":/var/kas/userdata/.docker/config.json:ro \
 		-e REGISTRY_AUTH_FILE="/var/kas/userdata/.docker/config.json"
 fi
 
@@ -584,19 +678,6 @@ if [ -t 1 ]; then
 	set -- "$@" -t -i
 fi
 
-if [ -n "${DL_DIR}" ]; then
-	trace mkdir -p "${DL_DIR}"
-	set -- "$@" \
-		-v "$(readlink -fv "${DL_DIR}")":/downloads:rw \
-		-e DL_DIR=/downloads
-fi
-
-if [ -n "${SSTATE_DIR}" ]; then
-	trace mkdir -p "${SSTATE_DIR}"
-	set -- "$@" \
-		-v "$(readlink -fv "${SSTATE_DIR}")":/sstate:rw \
-		-e SSTATE_DIR=/sstate
-fi
 if [ -n "${SSTATE_MIRRORS}" ]; then
 	if echo "${SSTATE_MIRRORS}" | grep -q "file:///"; then
 		warning "SSTATE_MIRRORS contains a local path." \
@@ -605,18 +686,18 @@ if [ -n "${SSTATE_MIRRORS}" ]; then
 	set -- "$@" -e "SSTATE_MIRRORS=${SSTATE_MIRRORS}"
 fi
 
-if [ -n "${KAS_REPO_REF_DIR}" ]; then
-	if [ ! -d "${KAS_REPO_REF_DIR}" ]; then
-		fatal_error "Passed KAS_REPO_REF_DIR '${KAS_REPO_REF_DIR}' is not a directory"
-	fi
-	set -- "$@" \
-		-v "$(readlink -fv "${KAS_REPO_REF_DIR}")":/repo-ref:rw \
-		-e KAS_REPO_REF_DIR=/repo-ref
+# propagate timezone information
+if [ -f "/etc/localtime" ]; then
+	set -- "$@" -v "$(realpath -e "/etc/localtime")":/etc/localtime:ro
+fi
+if [ -f "/etc/timezone" ]; then
+	set -- "$@" -v "$(realpath -e "/etc/timezone")":/etc/timezone:ro
 fi
 
 for var in TERM KAS_DISTRO KAS_MACHINE KAS_TARGET KAS_TASK KAS_CLONE_DEPTH \
            KAS_PREMIRRORS DISTRO_APT_PREMIRRORS BB_NUMBER_THREADS PARALLEL_MAKE \
-           GIT_CREDENTIAL_USEHTTPPATH; do
+           GIT_CREDENTIAL_USEHTTPPATH \
+           TZ; do
 	if [ -n "$(eval echo \$${var})" ]; then
 		set -- "$@" -e "${var}=$(eval echo \"\$${var}\")"
 	fi
-- 
2.43.0

