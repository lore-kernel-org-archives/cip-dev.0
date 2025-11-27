Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52804D11183
	for <webhook@archiver.kernel.org>; Thu, 27 Nov 2025 12:59:47 +0000 (UTC)
Received: from MRWPR03CU001.outbound.protection.outlook.com (MRWPR03CU001.outbound.protection.outlook.com [40.107.130.43])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.17849.1764248383297296283
 for <cip-dev@lists.cip-project.org>;
 Thu, 27 Nov 2025 04:59:43 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=YucwtC/w;
 spf=pass (domain: siemens.com, ip: 40.107.130.43, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=i1+PjpIT7f6wIdY9YvODV4EO6eQGkKaCNXI7VIknUQ0YJq+xgTcAavVDxNUoeOF+NFbVvcTYpTml77BpNSVcCU3OzUwh5whgVqKXmrSAeRW1qerS0zRGI4fvSucl7iK3qpF4imrnYS8vWiBrj0Yi8JsXNS8xmIUQJh0JTwLn+wa5Y7BwHgHcjeumnUMgyzdbcBuPhY3Xo3x6whbEIkiFu1XHywHW8HOJfdcDMRICX9P/4nPE+L8txFDSegDSjIbjv9A6bkxGARNuwHfz/ZTfpXEePqJHJcqpNX2MMvKGjXaz89Y2TYiDdBSY0Of8KSI5TLXBW1C6BoExE7QMCuZUPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=X+/atRvctXsVymoNWjNDRYZPUBzP798TTOs4qpDSRpk=;
 b=Vb3CakuEVM3LEQ1mDhnDXuCAwUbeLh4LtFLghIN2qajeJgXa7Mr7SbBND3XIxs5teLnrLYT7GkSqxPdRwQ+220Z73NhUd/gRFoz0BazaO3btDNrtBr8nYDkCvHNzlybRcp9/Aq20srikZZ9jYx67Wz43K/Hi82MOKWV2WH9b5JzEpuBpAbn9HrSekb3P9pYGPSMNnJ5HnG99kr2PujhSNDNEG4+m0nS1dUbfgsABqyLQdxO6wyizi3kJ3r7W8n5RCc8FAXe8uxyfHm9+Ua1jyqKAYE+MpLy2VwiDQUliX1WImkFDM8SYp3b1MjPKVdJd9AQgYeLascTKL/yQElMgtw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=X+/atRvctXsVymoNWjNDRYZPUBzP798TTOs4qpDSRpk=;
 b=YucwtC/wq/XqD1c5bTTgtKwPYVpuhuDA5xnVPoZTGcnlIpHaaiVmBwwv+vAGWUE+x087y3hzsijW1EnUvLGJKonvrenSo5kq3yA4v9zfCFe5byPHUavbJHDe5qVaw6o9Mwt0NL5b3IebZZOr3LfC/cfETddri2vg3pp5C/jDzq0U50w9ZUOl2JBzfz73rk49qyZglO3qXcpVB7QMcl2hYoZX42i/S49yidU5WFG03nXBP2uqmkMoL/GN5P1WBoNa8cV9uOz7AjPEfzSF5oCxy4Fqn+TrZwRLK5avqi0hRv7MzWPD3rI4OYYopgtuSCNAvIcZpTySXQQFxdvcIcfjVw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by AM7PR10MB3858.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:17d::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9366.14; Thu, 27 Nov
 2025 12:59:39 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%6]) with mapi id 15.20.9366.012; Thu, 27 Nov 2025
 12:59:39 +0000
Message-ID: <97407325-cebb-44ee-ad13-485cb26efd7c@siemens.com>
Date: Thu, 27 Nov 2025 13:59:38 +0100
User-Agent: Mozilla Thunderbird
From: Jan Kiszka <jan.kiszka@siemens.com>
To: cip-dev <cip-dev@lists.cip-project.org>
Subject: [isar-cip-core][PATCH] linux-cip: Update kernel config revision
Content-Language: en-US
Cc: Adithya Balakumar <Adithya.Balakumar@toshiba-tsip.com>
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0339.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:ea::13) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|AM7PR10MB3858:EE_
X-MS-Office365-Filtering-Correlation-Id: 7a8fdd02-39d1-4281-3a19-08de2db4d340
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?NFRheGlsZGJlMTVIVGF4UklhWERJTjJjNVFaTGxTVFBySUdDMlVsdVQrejNP?=
 =?utf-8?B?Y1loZHpxL0dYSUJvclExbUF4K25FUEhWUFRqTUIySGU4V1NkMUtqcWY2cEV1?=
 =?utf-8?B?NE5neHFadlg2ME9yQ0lQZzMwczlxcWxyVzZIclZxTGREVzM2MUxodXJjancv?=
 =?utf-8?B?NmxRcFMrTWNtKzdaMWhETkJiMmVieklMZ2dIeW9pMVAwbUt2U0E3SjA4N0hP?=
 =?utf-8?B?cWZ6c0xhYXJIUEZNMjlKNTBBdVdEV24ycHZmWEd2ZVFDTFhmUksvTjF2c0p2?=
 =?utf-8?B?Yk5waUhMS2JBbzJzQml4ZHAwa0NQZTV5VDJ0Sy8rQVdXSXdMUWh6bko5Q0ty?=
 =?utf-8?B?YkVjZG5XelY2Ymp0aktQKzZKYXcreEVPL1JkeFJtOTRUOVYyMDFkZjJKS09t?=
 =?utf-8?B?bWNEWVBkVWF0Tm0wbE9ZNDRsa1o3cmdUblh2VVNNNmVvRjQ2MkZyRXY1U0Z5?=
 =?utf-8?B?SUVxQ0RwQS9zcE9TNTdHNDgzMFBvSnZiemlhL3RwdEF4KzV0dkM5Z0prWkZW?=
 =?utf-8?B?dUJrZ1FSUVFWdjRrVFlGaFphbitWbVZWVGp0RDVMbjRKVmFvQWUwL1JzOGZO?=
 =?utf-8?B?eDZDRm1qYkNCTThURFBPblpLWmlacGp6OXk2UTdaZU91VWM3ODNIc2xkNXF3?=
 =?utf-8?B?SFpwMytGT1liVDBNMEE5VlVVaTRxbS9LV1NDYnBxM3Fuc3dvUXVLY09paEEr?=
 =?utf-8?B?ZE1LNVQySWJGYzQza3FYMFlaS0xwTndHTlgyR0VCeDF1TnBiT2hmRkJzQ0lp?=
 =?utf-8?B?bkRRdkptVGtXV3oxbnR2NWN3RktqYmloWFZiTkh2R3dMbHU1dXRubnhTbXd4?=
 =?utf-8?B?VXNwcW1TTnBDZmxmV3RXdmN4UlFhdW5MTTEvOS9NalZRNkpvK1BlbFZLOE50?=
 =?utf-8?B?UFplWjF3WklRMjFuY2pkUEpvbWw5U1VITnhyd0dKbFJ2ajF6dzNkTmNDRGJw?=
 =?utf-8?B?aFZpSGVMS08ySTFFZUV3aGFwSGI0MGRodllJQldoMVplWGc0SjR2Ym8rdU1o?=
 =?utf-8?B?bStsYjN6azBSejI3TjEvNWxLczF5RDVBMkdjZ1hHb0piTkRCZy85ZGZNSVBx?=
 =?utf-8?B?bWV0V1ZGYUJrMFg4U2hKRXVrSTdaV3MxbmFrbUp6cHhKM1ZwOUFmdCtVZFA5?=
 =?utf-8?B?MGxkSDRnMnVRK1FQS0V5dGZTR0IyS3pDR3MyUUI2M3ZCakFCa1FPb3VmWGVE?=
 =?utf-8?B?TlBZZWFPOGtub1Fic2xkbnV2M1dpeVRlZHQ0Ulc5YkJwNmIzK21sekJNVW4z?=
 =?utf-8?B?WDVyNlJ0VUNHOFV6ZG9iVklPMmwvMjcyLyt5RFhHV01XVlNPZ1RERm9STXdS?=
 =?utf-8?B?STh2bVZxTzUzaWR5a05jWGMyTDZocTZyWFVYTVh2bmdmOHBlRkRoZDNSSWQ4?=
 =?utf-8?B?cjR1OURGQzAxYTc5Q1pVQWxobUFoSzVnNm5EelVlYTV2TGR5ZWc3V2htTkZS?=
 =?utf-8?B?RUduZEduL0lCcVZYVy85VnFjQUZmQkNKNE5FcVc2OFBOSmphTGxTTGFmYTlN?=
 =?utf-8?B?NnRLbWplaUFBZFlHWlcrTkZnVEJXY01XaFovRStsYzFacU55MDA5aTNPdWNG?=
 =?utf-8?B?KzFqL2xVcFBCc0ZTMUFEb3h6eHNnVjdleDdWanpwTFJOdVVJbWtUbk1RQi9q?=
 =?utf-8?B?VGhTTHYvSllKSU9LaExadEg3bzVHaW9xWi9GQ0poSFJ3NFNLZTcrazF6OGhx?=
 =?utf-8?B?NFREWlgvZENBRHhxQ0EzNzJWcVlVeko4bTlqZlllOEZvQ2JXMXZINENhUUZC?=
 =?utf-8?B?OWxVZHN3MTVscU8rQW9VRHk5TWJMZzd5bHptWDM0MzBTcUVzdEdYWDdyYWZ5?=
 =?utf-8?B?b1o2Zk5rMys0eWgyK0hYSG5JWDlibzM4bmtEa1EyRmU2UHZJclNETk10bmdu?=
 =?utf-8?B?Y3hhWHNhcy9MbnBjWFNaZXhnaFdVQmp5Yk1KTEtKZXo2WWFBNDBHbmxoWStp?=
 =?utf-8?Q?dziV8lYOQK4Fnq2uS1SPcVVEB50SRHzA?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?OTBFOWQxV2EzbFVpRUJObjlkUHhESlpEck51RmQ0Ri80M0tpVk5adVZYYnUw?=
 =?utf-8?B?TEJvbm1FWGxYcUw0TXVzbnVUNmphZE1ZcFc2RnRFdGxRT1U2QXhFVW9XK1pL?=
 =?utf-8?B?bVNWRzF4dFpmT0dSNGFZcjVKTUdWVFdyTzMydlZ2QzJSa0FHZjdtdHFNRDJ4?=
 =?utf-8?B?RnF3QXp6bW1uRnBsWWt5UStmVUd4V0ZPdlN0OE81ek1GdXZsZUtWazBCMHEy?=
 =?utf-8?B?TjJvLzF5VjQ1WS9XVC9kQmU1YkpKb1ZWeFZLeFNPeGZKd3dwcDhoUHBHT213?=
 =?utf-8?B?ZG0velg0Kyt4aFZhd2h3bHFjMWtrUS9iTEozdHFMUVcrVlpjTHNNN3BWNUNY?=
 =?utf-8?B?Um9xUzQyR05SakFqTnF2ZHRnUHNVbm9uOFVzTTZRSDVPaksyNXNvYmlTcFlC?=
 =?utf-8?B?YTBjc2pHVUVUWXpUcVgybWx6M0hyRGxoMlJkTVNlU09mVXRqQjU2dFFWbm9E?=
 =?utf-8?B?aERGd3VkNGNQYmJxL0U1eUQxaFVyWEE2ZGhOZ0pjUXZpYlgwRE45OVFnbEh3?=
 =?utf-8?B?TXpqTTd3Y2VoNjJnaktOc3hoS1RwZ3l3dmxGckZoVEhCd0xCOTFzZVQySDQx?=
 =?utf-8?B?aWNJYW1VTWU1VUUwV1lVd3lqWTc1UFprYnhxQWY4bUNDOHgxOWdRTy9lQzJu?=
 =?utf-8?B?U09FVm16bUIxL3oxSUlYbTZmL1BBM1VsUTBMK1VrLzFwTnlYRFdNd1Zad3dZ?=
 =?utf-8?B?OHJOZHRkam01UVRQTkZzbzc0WkJheit4OTdRQmFmeHFuODh2TmdGa3BVZ3Uw?=
 =?utf-8?B?QXN1Sm5jS1YzdVNBUXdHcXk0UmUrMEtuOWFERjI2cDFmSFplbExJTWRKYTdD?=
 =?utf-8?B?V0FQaG85dmFHS0JFM3dCdGRWUjQrd1BaaEM5QTZwOTNEVVh3b0lYZENIaGZy?=
 =?utf-8?B?eTZxUWlQVGZNU2c0WXBpNlRxTGxQdzlHY3hVdHphQ3ArZ1NBc3Q1a2hJVWlX?=
 =?utf-8?B?ZjhnL3lERWcxL0JWM09JMThwaUR1ZFFhVnR5RnM5TCs5MFUra0NkWDM5VU00?=
 =?utf-8?B?RWJvSWt3WlZWMWZNK3VYL1VaYXUxd3c2Z1NvU1luMHk1NXRwelduMjFPZXQv?=
 =?utf-8?B?TEFoSnlMMlJWUndIOExJOXByNUV1NHJON0VoVXN3L3pJSUxvWjJpR0JZZkRh?=
 =?utf-8?B?R2Uya1RpRnJPcWN1eUhMdmJXVHVYOExzSEpXdVZYL3h5Zm1iaDhmMmVSdnpm?=
 =?utf-8?B?U245UEtKMjlvbkRSajgwKzFRaDQ0V1FHY1J5UVJIcUdHWGpZdC9TcTRLOGRU?=
 =?utf-8?B?UWU3alFvL1RLdDRZTzhRTHpnd3A3WmN5R3prcDN2UXp6YnV1Qml6cEJYT0JD?=
 =?utf-8?B?L3J4QkdUTEJuN3VETFQ4dUYrT0hlbEI0NUFGM3FIUnVtTUxpV3ZocEw1YnBE?=
 =?utf-8?B?dU5pY3NqVVNqWTJJZmZtajVsUXdncGp5WTFTZWx5dDQ5L3VhNDN3SjUxUXpu?=
 =?utf-8?B?V0p2NE9ZdSsxMWF5Nnp4K0xENzR1SXg3eVh5UW1hdDZ2OWhYdzNxM0pjUHhG?=
 =?utf-8?B?eWJFOVovQUlBcnpUdUwxTEJoVjkxWFBja1VGdUg0RGtWcU1ONWZVWFNwNmxN?=
 =?utf-8?B?NHRFTGtDNDgvV3EweDd1bmc0V3VGU0dOYkNSdzdRTXpwenBkbDVOeVVIZnlo?=
 =?utf-8?B?Wm90cldMWVVSdXkxZVFIMm9VVi9XYlBJdk9lTVNYMEM3VHRmVThqUHZQZFZU?=
 =?utf-8?B?aDhhMWtySUY2VWw4Rnd6eXR0N3NhNnU3ejgzdHFibkllKzVtU08xWW9ScTBq?=
 =?utf-8?B?d2k3T2NSQVRtQUpyWE5Ma2ZBczFoVGpzNkpxcDk0V3hJYitzd012YzFnMGRY?=
 =?utf-8?B?ZHEyS0gyK09LVUFJZnd2VkF5UWlkMnlmYmJpLzMvb3oreGpuT2tYb3laK0di?=
 =?utf-8?B?RUlFYmNLaTRoOUNHZStQNm9qdkpZSU5DaWlxTjUxTGFwYVlBWVpyZzJjVmFl?=
 =?utf-8?B?NGdTUkJMYzZGQ0swSGhKUllnS3VYS1JweUU1U0pwcFJrdjhsTmtQcDAwRm1t?=
 =?utf-8?B?WklBbyt5bCs0eDVHenN5QThSZ1FHTG5wKzBab2JrT3BNYWw1RzlqYThYNHFQ?=
 =?utf-8?B?S3ZKczRnT1RDUUZEVWdqQXNTSGpvUFgzbHlPakgxaCsxUzVDcDV6a2JLVXdm?=
 =?utf-8?B?QkFaQ1daWXlUZ0VZUE9hYTJvaUNHd1BkTTFzWmdkcWVBWmFoeGhUL0g4cCtu?=
 =?utf-8?B?a2c9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7a8fdd02-39d1-4281-3a19-08de2db4d340
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Nov 2025 12:59:39.6037
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2NaZc7j72bqufo5qRzGIx4Rdlg+8rPxgzKeq7Zj+h0DxJGurFOGt0QEWssLenfGGFUy4LfIVAIIbds5rL6bD3g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR10MB3858
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 27 Nov 2025 12:59:47 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/20757

From: Jan Kiszka <jan.kiszka@siemens.com>

This should resolve the issue that AUDIT_SYSCALLS went off in the merged
defconfig.

Close #140
Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---

I squeezed this into next now before switching to merged defconfigs.

 recipes-kernel/linux/cip-kernel-config.inc | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/recipes-kernel/linux/cip-kernel-config.inc b/recipes-kernel/linux/cip-kernel-config.inc
index e944a128..6393ed5c 100644
--- a/recipes-kernel/linux/cip-kernel-config.inc
+++ b/recipes-kernel/linux/cip-kernel-config.inc
@@ -15,7 +15,7 @@ SRC_URI:append = " ${@ \
     if d.getVar('USE_CIP_KERNEL_CONFIG') == '1' else '' \
     }"
 
-SRCREV_cip-kernel-config ?= "ba0204aa6c1c5a41dcb4fa1087b5ef5dd3ebf81f"
+SRCREV_cip-kernel-config ?= "fd712bb82f87c73dd9c0b4f0970edf5dacfe028f"
 
 do_fetch[vardeps] += "SRCREV_cip-kernel-config"
 
-- 
2.51.0

