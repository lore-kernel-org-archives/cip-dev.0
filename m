Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 606C6CE8D68
	for <webhook@archiver.kernel.org>; Fri, 14 Nov 2025 17:50:56 +0000 (UTC)
Received: from DB3PR0202CU003.outbound.protection.outlook.com (DB3PR0202CU003.outbound.protection.outlook.com [52.101.84.7])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.4380.1763142648216385717
 for <cip-dev@lists.cip-project.org>;
 Fri, 14 Nov 2025 09:50:48 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=L7cJU6NR;
 spf=pass (domain: siemens.com, ip: 52.101.84.7, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GGqegGjYWqEUH87340knZ/bzAbEBvaXDsnxQIuaKIqvBV/F3AMCjboyqYUv3a4dpzHYjtxlSXR1kc2xcCBbAN++U1cnbFmTylIMP+sRDzDAdc4dxQsHSMB46KTs/UyUNLL2TNsG1E0xPPS9R0tKtpNRq9w/Ht/YmmbxiWepS20TzJkMgm885/XdnVNTEkaAPNvlLuC4Ks0nExF1YO6PKx47louDgY7FrKSwGFcL+KoYbclLrqH3g65T+tZTugrNZdAYl7EDe0vBrIN8zVMfLp1swuRLU3MTayp0K6xEBwpGy/cJIDlsouPpmFOhQ5Xlgvz9pBdpzb0YSDJLroudKew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PPfiusQUnxhfc+SYp8X7cDHKOP1tCBEPDvPzAozL9Cs=;
 b=K2LAo1qU9beilo72gGXW7EFrlhVn0z3SqrEV0Trx3qgVRrDXweWiGwdVkK28bGllMi/1Bhz9/e/TjjKCG4OP3JWiesiXxRpHDqcWcqq7CE0ym4ZVgQfWaobtYEF7ORIuxS/ssCd1WhnLrxH3s7GuvQnR54nD0mg+UC/EmxSo2ttuC+TmBVJrxG04aguunvi7801ce5gKUbx1a95RgGPXqlLJR5l2oWX/mTCRBrUdU/I9W3qrQGUYUt+pS2JTB1OiiPARFppn/no1Z3ZZ8CRPA+elm7ua2mLoAv+pRrfS6B270mzilriGMRblE5tc8/qUvTsWSu6FVjV5LAv57MVVow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PPfiusQUnxhfc+SYp8X7cDHKOP1tCBEPDvPzAozL9Cs=;
 b=L7cJU6NR4sR7/NNtwO4AkIOo/tfUru4p84sIokgPuQgGlb1A57MxNhbmC5RU/GOaZ3KoHKvjLHK9u5QuZeD092qVR+babQfjNA2W8gCoqVCbU0O486J23VYZqbn0abUpYUiWnvh1sfxG7ZkjbNll/iyfUPfisxQFX0O7GzahBSxo0FmA128m8HK27SGFlBKg+S6V85IHaUI9qa4dBBydHPfRYH2HYXvrog81vsnTUp+xJa8LLDY/toK5Tu0p2+rY8NgQk5Wdc4RDWO/ZpUKSjbSDMlDSUNYiPo6X3I0kPgRWs/7H/zHuwZoOJQCssacnHWtSqO9ZlvspX0ev6T/ukA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by DB8PR10MB3226.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:11d::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.18; Fri, 14 Nov
 2025 17:50:45 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%6]) with mapi id 15.20.9320.013; Fri, 14 Nov 2025
 17:50:45 +0000
Message-ID: <9472ffa1-90e6-4247-8313-3982bf3c4d19@siemens.com>
Date: Fri, 14 Nov 2025 18:50:43 +0100
User-Agent: Mozilla Thunderbird
From: Jan Kiszka <jan.kiszka@siemens.com>
To: cip-dev <cip-dev@lists.cip-project.org>
Subject: [isar-cip-core][PATCH] Set default provider of factory-reset-helper
Content-Language: en-US
Cc: Quirin Gylstorff <quirin.gylstorff@siemens.com>
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0072.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:ce::17) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|DB8PR10MB3226:EE_
X-MS-Office365-Filtering-Correlation-Id: 47ddf7b4-bbc5-45ee-a1d8-08de23a65604
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?L3laQ3R3T01DVzBYOStjRmx5dTFTNWtuM080b24rOC91Ny9FQU95L2VUV2JM?=
 =?utf-8?B?MW45S0ZLakFyMHBKUW9xdHpGcFJJTHpxL3k5bVo0OUp2SmNXMWpKZVpwbUNu?=
 =?utf-8?B?ZUFrN3dYTDRLNUlGZHF6bzVOcEZrRzd0bnhjamZHTy9iVzVTVFYwSVUrREls?=
 =?utf-8?B?OUxaTGJtN3JkWHpXZEphbGlueFdIeENUdEJtMDA0L2swVlVLY0dEejUvcXY4?=
 =?utf-8?B?U0xEaVpOSmFVR3M1Z3FjbFFWdk9OQll6TEt1Y2FicENlVUgvOTlpVUVPSndV?=
 =?utf-8?B?T1JZY0svWVRsZjBQam8weXA2M2VoR0w4WVZ2c1FqNXcrRlhpWUJ4dkwyaG53?=
 =?utf-8?B?OWFCZGJYNktjMW0xd2IvWWY2TGdkMC9LcXJHUTJZSStTZzhjenNnKzZKRFha?=
 =?utf-8?B?YkxuRXZrNzJ0OGpTK0YvYklXMmsrU3ZremlKeWhjcHBFYzBBdFNlYVdTMGQ3?=
 =?utf-8?B?eHcrSnlHQ2hsMDFzT3J2dDBMd1Z3TCtqc3VGQm1xQWphbUJxa3h5SWdGbTEz?=
 =?utf-8?B?RTFwY3JGM0pYNGM0MzNwV3dlVmtRYzN5OEV3QzJIalRNaW9UcTREcFpvZ2VI?=
 =?utf-8?B?amV5UzdNOXEwemNLQ09yYUUvUW0wZE1PeC9lNEx1eGxhdWhLSzRaNHE0ZmdV?=
 =?utf-8?B?WW1VNHBZZ0JzdFhidldoRk9YOVgzTG5tdVlRV0oxZEhDM2o5VWRKSVF1eGZx?=
 =?utf-8?B?c0dxTWUwTzNBaGY4cTU3QnVhc2Nhd1U3YjVnM0lISDIxVTMzT1QrVGxzYmRa?=
 =?utf-8?B?ZERvUTRWanNoeENyaVlBdFZkWGN1YUR0TE5RaFNjREdLa1ptQ0U4VzJHUGZ5?=
 =?utf-8?B?UVRrWnp5R1pLVVlvbjkzZGdHTGNWZGRvVVJOSmtDOWhyRTRKYTVZd0s0cEUv?=
 =?utf-8?B?MFdOaDh4VmY0Y2g2NlI5MTZpZ2tkSERvaVBlcWFSWVZFMkFHdVZXR256cTFX?=
 =?utf-8?B?L3lKSVRKdkY2L1VPNmN4ckdmenNzd0lDNmxtem8yTEdNWS9OMFBkaEJLbElQ?=
 =?utf-8?B?MVJRVThrUU4yN2hTcUx6V2s1N0hqTXZNMy9SL21DS2dvZllBb1p2Vno5OGg2?=
 =?utf-8?B?NzFoTG9oY2pHbjQ5dWVqbnNIeC9qYVVONnFKUmMyWE1LaTArVkRSOS95MXB2?=
 =?utf-8?B?V3RrNENRQ202aFY4YWF6WmFqb1lIZ3hXRWE1QVhoVmZOVG9MOXlUNDRRRUtB?=
 =?utf-8?B?MTRwRWxTSEx1ZTVXbFVkNUhCWVZweXBjaGRqdklEdHpORGFPVzVERjg0ZGJE?=
 =?utf-8?B?NHlXV0RKWlc1dTVnK25vRm4xamltVXB6OFhqZldBcUUvTVZCeWdvbzhVZXJB?=
 =?utf-8?B?eW0zR1NWSjFPQmZnU2tTbUc2RmdGeFVBQW4wcEhxRThWbUxBeWtvUnJDdEpm?=
 =?utf-8?B?NDFLNlQxK1BuRHNpOWFCVExYbGRIRlYxak1NbGFmalk5WHV6b2oxdVZOT2pq?=
 =?utf-8?B?TmppTEFxbUxXTEpKenRkVnJpRW4wQnFNcmRYL1ZVcnhhc09zWXNjcFpWRERu?=
 =?utf-8?B?N04wKzlpSjloNkJvaG5DZFpoejYzbTE5N1pTazVwTFIxVDJUVStyR3Y0eUt2?=
 =?utf-8?B?a3VzaGZETzlEYjdqeTdKQldMbmNRYnJhc2Rvc1E5a0FPYTdUdmtEajA0QlZ4?=
 =?utf-8?B?RkRZL2FNbFdnOHFxdmlSRU5WbC9xTE1xNHk0Z3Yzdi9yalJvbEpvUWhibHFE?=
 =?utf-8?B?a21Ed1NGdjluVXBvSC9sdW8zNDZjMUpwNUJPNjNvVjJyRWJCcUszMGlTQ1Ir?=
 =?utf-8?B?bnNDaWJWTmdleTJNVVRUNVpDRmV4RjNaVWhQU05TdTJqZlQyOVRxQy9Rb1BE?=
 =?utf-8?B?V2E5emkzNVFNYWd3VC96OGk3bW5oSWRlaitYZ3RJNVIxWjJvNHB3a1hHdHhU?=
 =?utf-8?B?b2tNbXlEakRWaW1ZSE1jWUFPLytNTVdUWkx4bzRZY01UNjVBU3NJbkpmbVB5?=
 =?utf-8?Q?SbvtckkM//uwczt8Nt7mhmELIZ5LwgFY?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?S292RlBPM2NGdVQrSlFBNms0LzRiTEpuNHZLWVlvaHRhUTEwbHArS1ptbjJS?=
 =?utf-8?B?aWU3aEthcm9WNEhURzFBRCtZMitPc1NCMXpRR1lJaFVoNUcyYlBtK0c1bTN0?=
 =?utf-8?B?QTZjN0FOVE1IWEpSQURhZEtIQ0piWVg1N0NjblFOejExcktFY0x2aVZCTFU2?=
 =?utf-8?B?QklyeU5ocHpMa21HZkVDV2x3WkNpei9QaGMwUzZPNjV5N2lkTEF1WkVRSHVV?=
 =?utf-8?B?U1o5S0dMSG1sTkdKZ0J3K3pjVVIxQVMxaVdXbXZ1OXVLbzQwc2c2M3A2VEs3?=
 =?utf-8?B?OVo3VVp1VTdFMmNya3lkYkdTUlNpNUVDSit0Ti9VK2tnYi9oWStlQ3M0dTk5?=
 =?utf-8?B?WCtzQXU3VW1NV05hMGdlRVlWR3JjUTZRUTBEYy9YRnM5VFJoKzk3V29EOFV5?=
 =?utf-8?B?MWdqWVpvSlFjRXFHUkdsdVVldisycDJnTU8rTy9Pb05DVWlMNTZ4eDFvcE93?=
 =?utf-8?B?WEZTQVlXRkpNSUxOTjd6NnllVldzblZDMWJaR2laU1RWN3l4a3MxNVRwdGsz?=
 =?utf-8?B?eTB1Tmp3VlJTNmpuMURYaURGUjEvVVUwMTNPWGwvNGEyV2pMZXhuakx3dUJZ?=
 =?utf-8?B?MVhXWGZpWXhldTltcmtWMGJQRkJzVlVnUXdjbkxKNm42SmVza1g3eW9scTZG?=
 =?utf-8?B?RGpzMnd1bnptUnF6SjRzc2NCZTRlMmVNWnJNM1lnUVIxZm94QkM2MitmRWVC?=
 =?utf-8?B?aFpmaldCQ2hwSUpBSXZ0NUk2aUtvKy9WUTBHTkZXTERvdG92Zm1QMi9nb0VD?=
 =?utf-8?B?TFk2WHBlaU9ITzhjVVFaeWdFelNnNnI2K2pLVkxTODR3K29YVlRaa1ovcVZM?=
 =?utf-8?B?cy9ZNUJ5TlBna2U0OXFYeld4ZExUOVNENkdPWVM2djRDRXNqN1ZpR2pvYXZw?=
 =?utf-8?B?M1Vxb3VQKzZ0emFvQTNXMitmRklRRTZjQTIxNllwREdYNUZrOGFvTTlpYVp4?=
 =?utf-8?B?dzlERm12SEVSQUo4MFBoblkzMzFLWXYvWnhTUTdFUE0xZnVFUFV6NUxzMkZ2?=
 =?utf-8?B?U2hHd1ZSOVRBMnhYT05zcHF5SHNDQkFpbmJrZnFhTThYMHBPcEt6NzB3elhY?=
 =?utf-8?B?a2hNVVN2em8xeTJwa04rVEVIODNqZkVvTzJ4S3JwdVIrV1R3bkN6cE96Q0s3?=
 =?utf-8?B?YTdDMWRVaS82VkNVUi8rSWd6YWZQVU5wTElyMTBzcSsrYlhaaEpLcElCV0pa?=
 =?utf-8?B?NGtxVSs5RmRYd09YNFY4cFQ2aGFFVzBtV3Z1ajF6ak5mOHB4OXg3aHY5RlZa?=
 =?utf-8?B?c0lYZGtDYW94R3ptaDlORFA1aWZXb2RuVUkzdWI4SUt1eGZJN0pRVG5zSTFE?=
 =?utf-8?B?WWk1emcxUkIrSGZpbTFOTEZwSHg4ZE42cjdiVXFTUzJKbGQ4bDJ5bXVrUkRw?=
 =?utf-8?B?REpTMFlsUU9TWDhHQlpyT2NIRWtkN0R6U05ocDNpK2k4K2h5czgrRmREQlIr?=
 =?utf-8?B?dVprL1RYYXN3eEx1UUdQK1NlVWJlWVA1ZmxvbkZvTHpnK29EVWZuK21raC8z?=
 =?utf-8?B?bHhEdnVMT1dUdHFyUnVTRlozYlNzdWFNSXFDdDV2WFI1OVJqN0JBT29hb0pI?=
 =?utf-8?B?WnhpaHVxaHBmOEpZd0Y5N09ZcFRhY3RnT2ZPbU9FditLc1hjd2ZldVgxRlVn?=
 =?utf-8?B?NytDSVJsSG9qYXNFMzl4aGFjMW8rRDhDUDhkVEFDK0VQYzVEMHIvV1dsZDVW?=
 =?utf-8?B?NWxDb0ZSS0tOL21aalRHcnNXZzNXNEhHbk5yVWJZZGFHOXJueWdSU0NSRk9q?=
 =?utf-8?B?Uy9ZeEhyNjQwb2lkUDRQa1NVaWw4OXZjaXBHWVN2bFNob0xKbHU4K0M4NzZv?=
 =?utf-8?B?M3V4R2lxdE9YcnFPeEd0QjI4SkVyb21JM1VIOUJ3NjZVeUZDblFBWWFaVEU2?=
 =?utf-8?B?UGUwOElVUGtCMEx4RkI5WjdWRHhMcmJFNEdRaEk4cjM2eWwzbCthREpicmo0?=
 =?utf-8?B?NDlIWUJmeHA3VTRlNThlbVFORWxvRmdtWFNwQTM5dGtCUmlWS24ydnhmZVJX?=
 =?utf-8?B?K1ZySXI2TXZ2cW9USXBpSDhNRmloNUlET0gwS2d1cEVMUlhvbXk2TnhDM1Vk?=
 =?utf-8?B?YWxmYXRNQ3FNWldwU2wxUDk1N2lUSXpmSnhLVnBMQlhLeVRmekZzUDVscXJ1?=
 =?utf-8?B?UzY5aUtncDBiSnU2S3VCeGdyZ1BmTzdNSS85RTdoVlNoeFczWVoyUFNtVTZW?=
 =?utf-8?B?SUE9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 47ddf7b4-bbc5-45ee-a1d8-08de23a65604
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Nov 2025 17:50:44.9537
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fxTj5AyOBfluEYmFoeT6L7sO8lBT5zjVV7QFRiTG2gjGo0zAG9X5ZqeqjOPNhJnV0bGoSjX+S9i/aLVj0A05ig==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR10MB3226
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 14 Nov 2025 17:50:56 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/20565

From: Jan Kiszka <jan.kiszka@siemens.com>

Avoids having to replicate the common case into most machine confs.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 conf/distro/cip-core-common.inc | 2 ++
 conf/machine/bbb.conf           | 2 --
 conf/machine/hihope-rzg2m.conf  | 2 --
 conf/machine/iwg20m.conf        | 2 --
 conf/machine/qemu-amd64.conf    | 1 -
 conf/machine/qemu-arm.conf      | 2 --
 conf/machine/qemu-arm64.conf    | 2 --
 conf/machine/qemu-riscv64.conf  | 2 --
 8 files changed, 2 insertions(+), 13 deletions(-)

diff --git a/conf/distro/cip-core-common.inc b/conf/distro/cip-core-common.inc
index b5c0d5ac..0b45636a 100644
--- a/conf/distro/cip-core-common.inc
+++ b/conf/distro/cip-core-common.inc
@@ -25,3 +25,5 @@ PREFERRED_VERSION_linux-cip-rt-native ?= "${PREFERRED_VERSION_linux-cip-rt}"
 PREFERRED_VERSION_linux-cip-rt-kbuildtarget ?= "${PREFERRED_VERSION_linux-cip-rt}"
 
 TEE_SUPPLICANT_IN_USERLAND ?= "0"
+
+PREFERRED_PROVIDER_factory-reset-helper ?= "factory-reset-helper-file"
diff --git a/conf/machine/bbb.conf b/conf/machine/bbb.conf
index 3005b336..af6b3299 100644
--- a/conf/machine/bbb.conf
+++ b/conf/machine/bbb.conf
@@ -18,5 +18,3 @@ KERNEL_DEFCONFIG = "cip-kernel-config/${KERNEL_DEFCONFIG_VERSION}/arm/cip_bbb_de
 
 # for SWUpdate setups: watchdog is configured in U-Boot
 WDOG_TIMEOUT = "0"
-
-PREFERRED_PROVIDER_factory-reset-helper = "factory-reset-helper-file"
diff --git a/conf/machine/hihope-rzg2m.conf b/conf/machine/hihope-rzg2m.conf
index 447745a1..0b3acf49 100644
--- a/conf/machine/hihope-rzg2m.conf
+++ b/conf/machine/hihope-rzg2m.conf
@@ -20,5 +20,3 @@ IMAGE_BOOT_FILES = "${KERNEL_IMAGE} ${DTB_FILES}"
 
 WIRELESS_FIRMWARE_PACKAGE = "firmware-ti-connectivity"
 INSTALL_WIRELESS_TOOLS ?= "1"
-
-PREFERRED_PROVIDER_factory-reset-helper = "factory-reset-helper-file"
diff --git a/conf/machine/iwg20m.conf b/conf/machine/iwg20m.conf
index 401ca571..f5d5dda6 100644
--- a/conf/machine/iwg20m.conf
+++ b/conf/machine/iwg20m.conf
@@ -20,5 +20,3 @@ KERNEL_DEFCONFIG = "cip-kernel-config/${KERNEL_DEFCONFIG_VERSION}/arm/renesas_sh
 DTB_FILES = "r8a7743-iwg20d-q7-dbcm-ca.dtb"
 KERNEL_IMAGE="zImage"
 IMAGE_BOOT_FILES = "${KERNEL_IMAGE} ${DTB_FILES}"
-
-PREFERRED_PROVIDER_factory-reset-helper = "factory-reset-helper-file"
diff --git a/conf/machine/qemu-amd64.conf b/conf/machine/qemu-amd64.conf
index dd96fae6..7db2a9db 100644
--- a/conf/machine/qemu-amd64.conf
+++ b/conf/machine/qemu-amd64.conf
@@ -12,5 +12,4 @@ IMAGE_FSTYPES ?= "ext4"
 USE_CIP_KERNEL_CONFIG = "1"
 KERNEL_DEFCONFIG = "cip-kernel-config/${KERNEL_DEFCONFIG_VERSION}/x86/cip_merged_defconfig"
 
-PREFERRED_PROVIDER_factory-reset-helper = "factory-reset-helper-file"
 PREFERRED_PROVIDER_factory-reset-helper:swupdate = "factory-reset-helper-efi"
diff --git a/conf/machine/qemu-arm.conf b/conf/machine/qemu-arm.conf
index 768ea997..6e1192a1 100644
--- a/conf/machine/qemu-arm.conf
+++ b/conf/machine/qemu-arm.conf
@@ -15,5 +15,3 @@ KERNEL_DEFCONFIG ?= "cip-kernel-config/${KERNEL_DEFCONFIG_VERSION}/arm/qemu_arm_
 
 # watchdog is not yet supported in our QEMU executor for this platform, disable it
 WDOG_TIMEOUT = "0"
-
-PREFERRED_PROVIDER_factory-reset-helper = "factory-reset-helper-file"
diff --git a/conf/machine/qemu-arm64.conf b/conf/machine/qemu-arm64.conf
index dfb986de..cd8187b6 100644
--- a/conf/machine/qemu-arm64.conf
+++ b/conf/machine/qemu-arm64.conf
@@ -16,5 +16,3 @@ KERNEL_DEFCONFIG ?= "cip-kernel-config/${KERNEL_DEFCONFIG_VERSION}/arm64/cip_mer
 
 # watchdog is not yet supported in our QEMU executor for this platform, disable it
 WDOG_TIMEOUT = "0"
-
-PREFERRED_PROVIDER_factory-reset-helper = "factory-reset-helper-file"
diff --git a/conf/machine/qemu-riscv64.conf b/conf/machine/qemu-riscv64.conf
index 399672ac..5d45c0ec 100644
--- a/conf/machine/qemu-riscv64.conf
+++ b/conf/machine/qemu-riscv64.conf
@@ -18,5 +18,3 @@ KERNEL_DEFCONFIG ?= "cip-kernel-config/${KERNEL_DEFCONFIG_VERSION}/riscv/cip_mer
 
 # watchdog is not yet supported in our QEMU executor for this platform, disable it
 WDOG_TIMEOUT = "0"
-
-PREFERRED_PROVIDER_factory-reset-helper = "factory-reset-helper-file"
-- 
2.51.0

