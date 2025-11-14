Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B7F4CEACC9
	for <webhook@archiver.kernel.org>; Fri, 14 Nov 2025 19:47:27 +0000 (UTC)
Received: from AS8PR04CU009.outbound.protection.outlook.com (AS8PR04CU009.outbound.protection.outlook.com [52.101.70.0])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.6818.1763149645100270028
 for <cip-dev@lists.cip-project.org>;
 Fri, 14 Nov 2025 11:47:25 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=pmtxAF1u;
 spf=pass (domain: siemens.com, ip: 52.101.70.0, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SmI3d6zVQCEv9JIijoXWCpERKbmVAahl+/sVKgRdZXfn3mBxv2xtxwKi1Pf0iepICDQifPheU9AWmQ3nBwyVObOHiwEz3pSShYz/jh9cron5GtfWQXoyJAzttsAVqqUEg1oja0kvAXBlfehFQoswxk7rKyVJBSNkNn5MfmlFG7VSfmXi7yfz5BPptnDTzgjGCuqfZH0dkwEreXfFhC5nnlk6X7QRGrQfeuNBPppiBKWGzKtByYM3BVwWweXtkltPRl/NimRIWjcXMaMMlFaKDdruND5nVUDQkI2ogi/mQidFWaktj54eUlX3lzfBXXFFwyq/zJeDOdWDvVbOYogG5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mGEYRnnPXLCZ9I00xJsu6lB1oW6MI8Q9GlWo1V70NcU=;
 b=GbOp78VAYdIZtT1L3/6u5feEq1ua4LdIUk8H/+aWvdcK6taiVWyLY90ZjMuyVC2hdLwqq/Y7Mc7HcCNlDxAeTlZZ0Tcq+UrVtJdLRbkOPSo6kIPQ/kZw3vVVrNPn2MlwjLBOHx7v1ec1QDtme7go6/4cvdwhDDjlCtUX1RRF5RneWWU4xmhu7ZkIFJSsVyrnTEAVIh7ToTC7HUIQS6kn1d7yE7bBoN4zMU4MG1vw8JCXzwxqS/ufmW7oQavqHMdtQ0hd3SxfmAUIif3Mczb2R+w4n7nOpvt3A27iQFEI8II/P11m3vZR/4hHP7jE29oJhx+fnTayggWm6Buz734S3A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mGEYRnnPXLCZ9I00xJsu6lB1oW6MI8Q9GlWo1V70NcU=;
 b=pmtxAF1utd5aYnBeZ4AeHRYB3SaaFKM9Xiv067FjmkzQv68S4/ENJEHuYTjnxmh4Pil+nKdzvhr3WVQ357O6PKTGXdLT38519vjRhlXolz6yS9AibW55X2bImlsZxJJTMBjfDkkTb4FOsIFIA9fql8DecsaBhuaQkN8M0Y6NtkgPutoCaW4Y4khSWzOXvHSLlVWZVND5jDlxSJU7yW5F8Fz8pc0ef0IW/HZXbefC5DALLBwG/mb+seeS1R6J3Vwj5C3mJ5PiaJ5V4JO2rDFh1pCaB3c+cePqJBDpReDMLwrLZZ+10/by2D++TouOqGJIQO9dVh/ZQjQRng5amoV8iA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by PR3PR10MB3754.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:4b::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.17; Fri, 14 Nov
 2025 19:47:21 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%6]) with mapi id 15.20.9320.013; Fri, 14 Nov 2025
 19:47:21 +0000
Message-ID: <d281707c-e468-4038-b691-ef44ccdb065f@siemens.com>
Date: Fri, 14 Nov 2025 20:47:20 +0100
User-Agent: Mozilla Thunderbird
From: Jan Kiszka <jan.kiszka@siemens.com>
To: cip-dev <cip-dev@lists.cip-project.org>
Subject: [isar-cip-core][PATCH] u-boot: Avoid broken DEPENDS when appending
 STATIC_KEYS_DEPENDS
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0178.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:b7::6) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|PR3PR10MB3754:EE_
X-MS-Office365-Filtering-Correlation-Id: a4e888ba-13bc-480e-397d-08de23b6a00e
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?Y0J3YTR4WHZvem1oQ0ZjUXJjNXlxTlZEUW14R1pJZkVQQ0dwU0NhQnlJci9r?=
 =?utf-8?B?TnNkOU45eHMrUExYVThwVUxJVGhnb0dlSFhHdW5JazJFUk1vWCtQYlQvRGVt?=
 =?utf-8?B?S2pTYk9FdHZ4Nnh0WEhHMlNRTU0zcW10VG5aRUh6b09TVU9FV05FazRnTTl3?=
 =?utf-8?B?UDBHTDB6Y2JHS0kzNm96ZkFxTHc0TDFIZEtkS3M0MzJFaDlCR2tUSUpTNFl3?=
 =?utf-8?B?UUdSYTVCUWZ3Y2QzdHdJSXg0UnRSRUI2Yy85Yis3OVJQcTFHdWJSSGlFOHY5?=
 =?utf-8?B?OWVWbm5iRlgvL1dUOU84L3dqUGxzWnJIbU1UVEhBREtxZ29PMTVPMlMrM3pw?=
 =?utf-8?B?ZDR6dU1oVVUzd0ZRQWJad3NCWEFhQ01pVVg4Y0g3bkxEME5iU2dWUHJqWWRl?=
 =?utf-8?B?b3M5OWN6UUR6OCt1UDlOcGxvV3hOb25zL0lzYVZtbXR0ZFQ0WkJQN2tUOGpa?=
 =?utf-8?B?ZXpNVGt1bE5UUHdNZFlOaDFmbjI1MTExMWEwc1ZENUVrVWhpSTlCbk9hRlo2?=
 =?utf-8?B?eWxRZStiZTZQWnBERHdtb2xLdE1xS2IrMElXOTcrOHFPZElnMWtPbWNVb2pL?=
 =?utf-8?B?aWkrY1BjV0NCRG9Lb2ZrQzI5VkNCc3YzdlRsK2VTSnArN25aVXFsSktGNE12?=
 =?utf-8?B?SUh5aHM5WFpoTzY5d3BuVkpjUVhsU1NtS0FYR3FoVTRmS0VKZTdFKzBrd3M3?=
 =?utf-8?B?amJUQ01qcUZwNDJrdDQxSEJzbWhVTmR5WWNDTE9jWHd5Mk1TV1E3NjZHNkh1?=
 =?utf-8?B?blEyK2xiUkh5YjJOQVBXQXRVY0o5eElLS2dKL2R3eWI3RHk0TmYwUy9VOW1C?=
 =?utf-8?B?MnNGSjNiZGYxMWZ0NlZqR2JCVy8rcFhnajFrSEdIeUJoMTV5UUJWQnJ6bVgr?=
 =?utf-8?B?eUZodGxtV3k0SHd2QVVjQzJybEgycFBpcU1vWEtteTRKU1hKb1FJbmFjaXVj?=
 =?utf-8?B?bEVZUEhvb01ZWkFGTUFmRWRVeS9HbElxTFpOZEpSUVZNZnpiTy9WdlJGdDZG?=
 =?utf-8?B?dkJ1bGtWZW8xNC84Zk1OZXpsdWZzQ2M5T1EzTVQ2Y08ybTIyMGpWNFphSUZu?=
 =?utf-8?B?aUhDOTNjOXY3NjVQY3ZIOGhBajNhZnBFd2QzVU9QT2todXpST210QU9xMnJK?=
 =?utf-8?B?ZjVMU1pvWDRVdFh6WG91clN2bzhYQytNRS9qUDcxYmV6L1BIbUlOS200dGhH?=
 =?utf-8?B?WjV0ZG9uZlpudS9oR25rd0RNZEFXVWI2WjRIRUxIbmRSa2wrWW1RNHQxSzJB?=
 =?utf-8?B?NFlaQ0NHTjVvMmlpRThTQjJnM2lES2FoYk9rSkF2dU1CQ3VuZUw1RmJYd0Uw?=
 =?utf-8?B?cldCVlk1UzVjbXA1cXJDOEk3QU05M2VmVlgrY2ZiNVk0Y3hUYXp2WHJBQ29O?=
 =?utf-8?B?TjFvUkRjdzhoUU1Pemo3SHRwZ1JYT2JTcmpqd2dpK0lMbDNSQXpKenVhTjZw?=
 =?utf-8?B?L0t3SVA4TWNBVzVuVEdsRTUrSjNiejlvaUpvcWJVd1ZOaUhnR2dZMGlHZEtT?=
 =?utf-8?B?WHFzMldSc1FkTmZYMGFGOCt3MU1MZHBLdFFjTlQyNjE5UG13SUE0RTk2bXoz?=
 =?utf-8?B?QXR4czBmcGFJUnltcTNEaElTckYzYXRLTmFlemR3UkdoOTcyWnd3RDhlZnYx?=
 =?utf-8?B?TEROUllZcWNESWRKbHZEMXBxdytVS1F1OWw3ZmZNYzhtK21pQXRCYkk3QWhU?=
 =?utf-8?B?dVN1Wk1aZEQ1VTlsN0lWRjFDREUvUEYyem82MzZzeGEzRDQxbFNmLzc4ZmR4?=
 =?utf-8?B?T1JJSnhGSDJNTlJUWkhDMFhhREVlelF2Qm9Nb2ROUXE5L0NZN0hyeFk0Q0t4?=
 =?utf-8?B?NVBFMVltNnhyREtRM285dkRiSlY3Z1YrN1kyMmxkUUVBMmhoZ3RGRG94eFNV?=
 =?utf-8?B?ZDVBUmE4Z0NWd2dvdTA4bFZhMnBKaUhpYTVNRGJIUjlod1VQenpodTNVb3JK?=
 =?utf-8?Q?CKHVuVgcAvOwcAObOavWRg9Jwip3WFRY?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?SDlOQWtQK21yMHZvTHJVVlhyUkRTaENrTXBVVWtsQXFnTzlkaXM5SVhkM29R?=
 =?utf-8?B?enhDY0hUVXVoZU52aWRFR0FjSnAxdVBKZ1NtTGs3YnBnOGpSSXNSbnRKNzk1?=
 =?utf-8?B?b3N5SU9naExMSjFJUkQrZUxMQmV0UFBXUkU1RjRTakpVRzlITy9yM0NNUTZx?=
 =?utf-8?B?QXJaUnVwdWVFL290UURpS2ZmNE1NdkpRc1UrcGpZL2dGZDF2bGhoMXRhRWM5?=
 =?utf-8?B?S0ExVHhzTGt1SGZxL3JTVTJZTjJBWkhzMnF6Y2FKaGhKSTBhYzBPVlN6UXYr?=
 =?utf-8?B?eGxzOVAxSnA2MldQZjNNVGhURmtaWXA5M2haUnNsVTBSZmxKSXVXR3lyZTAv?=
 =?utf-8?B?QVJoVi9IN204VjdwYkNaelRjbWdvaWVrbUdLV3ZLSHcxUVFWSVAzem9nNkNr?=
 =?utf-8?B?UVY5MDdyNG8rN1NNRlhKNzcwUGFMaUh6Z0hLblRaTXdJMmJIOTdIWlV5Smp1?=
 =?utf-8?B?Ni9mZXQwdzdlajFoY0hnKzdLOXkySjhoMlh2TDF2Ump2TXJNVk1PNWk2bHdJ?=
 =?utf-8?B?dlJwSU4zQ2xFaUsyTjhBVmhHMDBYcnk2TE94RW1oeUoxYi9kMEd2bktPYVI5?=
 =?utf-8?B?S1lLbm1lclJwVHBRckJUa25ySjdFUk9mNHJXcGtVbzg0ZHZZY3cxMGZFSWlk?=
 =?utf-8?B?cW5uUE4zS1BRNkRibVkvSVB2ejdia3hPaE1FNjJQRGJWWEZ4TVNnM1NDRmlX?=
 =?utf-8?B?TzVsUm9ucFBLNnROU2l5QUVZM2VQM3IzZDJvN01tcGw3Zktjc0JvbzZkVk5C?=
 =?utf-8?B?RHFyazM0WUQ3dE9LUUFlRVdsTnFSa3AxWFJEZkMxempKRU9hdnRBQXVNNEF5?=
 =?utf-8?B?UVhXeEJlUmcrMURlT1c4UkJUdmJJODN3OXB0NDRnbzlSdWJmVHZtVkRabFUr?=
 =?utf-8?B?Skc2cElpdVk0NG5tYkhnUnV4TjJ5TldBOENCL2hYNjV4QkZMbkkrekpqdzNB?=
 =?utf-8?B?Ny9TYkdoSlVLZklCY2N5OUFCYXhiOGQzU2s2S21iMXJhRzVRODlkbXZzK1hI?=
 =?utf-8?B?bERvVFdiR3lLSU40aFdhNE1PVzlwNEEzM24xL1M3SkVwS1hmZFRIbTZEV1dw?=
 =?utf-8?B?TmJlelh4aWpSM3RIMnZMeTVnY3pQOW0wOVVXc1ArNFBIV1VmcnJsUjFDOWVm?=
 =?utf-8?B?c3YwZDJjdzZxOGliUFcrUlhMcU9jeGZCMkE3RzVJelBKYnhTQzZNcGgrU2Z0?=
 =?utf-8?B?d0pTZGFNajdPMjQ3ckxsRUhMY2NJdXZyMkpIL0pZVHhqakF5NUo5QWVXcjM1?=
 =?utf-8?B?b05oZEE4U0E2ZFlMTWNHYlRORzhZenhNY1l5TUl2UzRMT2t4Sm1abTd1M0Vm?=
 =?utf-8?B?bmNxbE1nZlc0SUszdkNNOUNNdnpNSi9RajhEQnBsWFhWQ1dMM2VacWROQ1RB?=
 =?utf-8?B?NmJTM0ZMWm9oSTJPemFQc20zQktQMzRlYkJPNXA1SU5ZUVdvazdZQjZOY05W?=
 =?utf-8?B?bWNsRkxkNjFGa3ZIWk9oV3pwaTVIZSt2d0xmZThPWGk0QTlrbndnZG9BL0M1?=
 =?utf-8?B?U200Z2ZwOU9LUlVMcVVTMDZxV0QyOVlHNnJXYUg4eVR5QjhFTHVxOVpGUnlr?=
 =?utf-8?B?MjZWWExqMEdsOHNyeEVHYWE2c3owNFB1cTRFVGVZMkVmSGxmSnZiYlk5YU9j?=
 =?utf-8?B?ejZxUHpzKzQxZzBWdzI1YjVwYVI2WUdzd08zbWlGN3B4UVE3emFIODFOdUkw?=
 =?utf-8?B?eUY4Qjh5MzNsUFhNSHlxa0F5MEg5RGdQT3hWTzUzclg3Y2haRXNML1MyQTlI?=
 =?utf-8?B?Z2NTazl3ZnV4d2oxQlZGUS9YSGZ0WFBSeW1pOHd4ZDdtRXpkc2NvWlE3b2R0?=
 =?utf-8?B?VEFidG1HYS81bG1JNFRHeXF4ZE12Y0R0TE44QnhNRnJYSFIrQ3ZhazVuU3Z1?=
 =?utf-8?B?S0psR2tqUjc5VEN0TW0zd1Q2KzFjK21sZzc4YVJ5YVg2TXMvV1MwOGtjVVlx?=
 =?utf-8?B?bUZQWEkyVDlGTFhuWkdjd2gzcm40S0tsaGFCWkt4Z2ovSVBLMTNOVUFQMTJ0?=
 =?utf-8?B?OGo4dzdVcDR5MVdERi9UREloMHBQdy8yWExoYi9TSXUwWlZMTlpyUEMzbmtO?=
 =?utf-8?B?dHpyalI1RTJ0TytSL20xcTNGanlhNmVhSnVSV2t2c09UaVFDWGtZRXhBZEIz?=
 =?utf-8?Q?tjkXKVjuZ5mxz52TzFdGWv3pS?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a4e888ba-13bc-480e-397d-08de23b6a00e
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Nov 2025 19:47:21.1410
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3gu6Fhd31TxP/k0wVSHB80EFjGEAK8bCc3MVIYWsGWr9MH9XfxQOxsQLKxGnEX9s50uiletxBCsZ6uWSs29lBQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3PR10MB3754
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 14 Nov 2025 19:47:27 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/20571

From: Jan Kiszka <jan.kiszka@siemens.com>

Add a missing space so that DEPENDS is not corrupted. Didn't affect any
in-tree recipe so far, thus remained unnoticed.

Fixes: 4f8e836566a2 ("u-boot: Prepare for different build dependency without built-in UEFI keys")
Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 recipes-bsp/u-boot/u-boot-common-2025.07.inc | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/recipes-bsp/u-boot/u-boot-common-2025.07.inc b/recipes-bsp/u-boot/u-boot-common-2025.07.inc
index 96c7ee96..92b5e9ce 100644
--- a/recipes-bsp/u-boot/u-boot-common-2025.07.inc
+++ b/recipes-bsp/u-boot/u-boot-common-2025.07.inc
@@ -38,7 +38,7 @@ STATIC_KEYS_BUILD_DEPENDS = ", \
 STATIC_KEYS_BUILD_DEPENDS:append:buster   = ", pesign"
 STATIC_KEYS_BUILD_DEPENDS:append:bullseye = ", pesign"
 STATIC_KEYS_BUILD_DEPENDS:append:bookworm = ", pesign"
-STATIC_KEYS_DEPENDS = "secure-boot-secrets"
+STATIC_KEYS_DEPENDS = " secure-boot-secrets"
 
 SECURE_BOOT_BUILD_DEPENDS = "${STATIC_KEYS_BUILD_DEPENDS}"
 SECURE_BOOT_BUILD_DEPENDS:ftpm-stmm = ""
-- 
2.51.0

