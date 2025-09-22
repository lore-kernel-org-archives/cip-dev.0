Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5537CA100F
	for <webhook@archiver.kernel.org>; Mon, 22 Sep 2025 15:33:30 +0000 (UTC)
Received: from DU2PR03CU002.outbound.protection.outlook.com (DU2PR03CU002.outbound.protection.outlook.com [52.101.65.58])
 by mx.groups.io with SMTP id smtpd.web11.55160.1758555203927932454
 for <cip-dev@lists.cip-project.org>;
 Mon, 22 Sep 2025 08:33:25 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=Ww7ajQw1;
 spf=pass (domain: siemens.com, ip: 52.101.65.58, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=brGE58ZbR8NKrpASlyMQWDXp9YeasDmsX3M+awe8YXESwtVdWzIwhHA0Ca6jjz3CkniuiNX6FtC1iCpw3YdzFzSacbfAac3ltkMhfVhF8uBuREkM3Xj61EUEJ0Vtvz0iKA8wYnQGb8sOldlACoU/KmP9tj9tyd6TG7Dk97qSPlBhTOalef2WN7y3x35Ytp8pWTURDJlL1Yz3L2qdHhcXRaWi6fcHyHlP+Ers3TFqnxFrmy66Y+n/0i0psQCsa1VPtvBymm1qcF5uQgLK/hQVHb7e9Kon/i5X/9F1vbwDa7q/IXLVybjUilc+I4wc72sFXixuFNuTcN65BTUupWCdyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HCUfbUkThyqFOchAjz/0jcVRLqh4xIX4KxJkvR5KIY4=;
 b=gPeVYsCSJ+mBJypYNlQ2NY+SvrSLHW6e5qe1m0d7s+SFf2EO6t5/iP6AkpszPxzkWgddyNvdd6HH3hRj4LOzD5Wu2Zks6DZB7kLQLiMS33PA/WVIGrJU8EXLNgb5LIJ+y3ihPwC3A4Pu9om+E0rbf2ZkUHzMtASa9E9ys9lV2/2NYQpaHnR7pBRUnhUXM2ad+ZpEctSBU+yddUjjEkBRdDiUabt+3h6dgvDm134p6gKknEXZqQfPARGMhbGsNNMC9DiuPIxOiFwzJBAGO/XuPFaBXXHyOaVm7tFGvVGrG4ghrs9pjEbMcqg28vulVoB7bLnUBhBzb8eXRIcHeEnoxw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HCUfbUkThyqFOchAjz/0jcVRLqh4xIX4KxJkvR5KIY4=;
 b=Ww7ajQw1RYSNlBMmrDnOuPCZnopj9fSLm9CvupicppHSvdUha/llN4+thowVi2FQ5Ng4RUBTuxjIfGa4oalHd6mlqQMMOGBe4f8BIxcbJHTyVvzgZ3oWKfpXxNxhBToPmZMIZqJXPDzxIuZHDaBLd+IIZo3dvbqqxQ3NKjSfhq6y0QOwDWg4VdwyygfmY7djqfIvQ2wKm0tG8IhftNZYflF0PPnEVVQOZ0FfbiVvToWg6TpDgp3Z2d7x9mj6GRc+Lb+GitJXyk1gbgUdPqYip/yNowhJ8kBeM/ecQz+IfJmQiICCG7S7J9Lfnh3FIo4qjgDF/kItt044XNt46Y0VXg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by GV1PR10MB8674.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:1ce::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.20; Mon, 22 Sep
 2025 15:33:20 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%6]) with mapi id 15.20.9137.018; Mon, 22 Sep 2025
 15:33:20 +0000
Message-ID: <27ce56ad-1a4e-4d3b-9a9f-3d15320cf660@siemens.com>
Date: Mon, 22 Sep 2025 17:33:19 +0200
User-Agent: Mozilla Thunderbird
From: Jan Kiszka <jan.kiszka@siemens.com>
To: cip-dev <cip-dev@lists.cip-project.org>
Subject: [isar-cip-core][PATCH] linux-cip: Update to 4.19.325-cip124,
 5.10.241-cip64-rt28, 6.1.151-cip46[-rt24]
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0126.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:b9::7) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|GV1PR10MB8674:EE_
X-MS-Office365-Filtering-Correlation-Id: a8a97c41-80fd-45d1-d721-08ddf9ed5b99
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?VHB0OGUzMjdZS1BCZWJ1WXVyOEFKNVFvTWdkTTJRZ0x6NU9uZDNxaHUrMkRY?=
 =?utf-8?B?VjNKRFZOWjB5RVR3NVhBNnVlY1dQWVZVcFU5YnRsZlNSZlU0MXA3VGJkanpV?=
 =?utf-8?B?Mlhpb09ZbnFLbDAvQmFZcnhmZ3diekNpdFlzdTV1YWRrK0lBOG05S3ZjZ3dm?=
 =?utf-8?B?Vlg1WmVJK1VFRGhKS21KUFNITGFwbitNRy8wa2ZNNHcxeUZWb0RrdE95S0hs?=
 =?utf-8?B?WUEwMUxPdkdaK0xPQjl2RkxudFVadFJ4aEVBWTgrWW4vblRmMElja3p2a0dV?=
 =?utf-8?B?cEV2R2VLendhUXZXSDl0dUFjTzU5Nit5VHFkanBMakhoYzRDQi85UU1SUm9I?=
 =?utf-8?B?bTJUaVh6OFRkTVg5dm9jN0psMzhmRms0UnlNbi9Zc3B4QmZUeEdQNGFpaXBB?=
 =?utf-8?B?YjdzUTRETUVPVG9jZE1saFgyY1J6eUtRekZXaHRaeVZ1Mk5laktoRE1OYVI1?=
 =?utf-8?B?MXFpdVBxOWZTYWVTRUVBQ2JOc2MwYkRhYXlqK1VGTXM0MFBrZGZ5SHRDcEdo?=
 =?utf-8?B?dnRIZkdRL25ndG0xbEtDb2NCZzRnaWEwei96Y1ZYbmhKYlozQ0dHK2tqNzcr?=
 =?utf-8?B?WTNQRVdoVzR3UFZxYU83eTFLK0c5bkpSdDlOaTNKNmhCVFlETE02UDNPQldN?=
 =?utf-8?B?OXZhNjYwTGtmYTZFSm5ZQ01vS3BpTzNWQk1wT25iR0N3cDhxRVBQUloyUWNS?=
 =?utf-8?B?RVRFVWhUZnVEY1Y2UDJhK2tVZGcrODQ0OU0xNnMyOHlFdkJ6bE42MU9lRVYr?=
 =?utf-8?B?aC9iZHRNNlpsUk03b2ZiQ20xenFCOGpCN0VydU00NDhBZnJISUhiQm5yNnpS?=
 =?utf-8?B?NTFPZk1wTFlsKzYveWMvajdjSmg1VzA3Z1BkOCtRbUxEM1VEdjNMQVNsK25w?=
 =?utf-8?B?UmpRWGJMSGdFUm81STF6UnlMcHpxWDU4c2N2bWNCSkVmQ2E5Q0hSZDRkWXkv?=
 =?utf-8?B?RFZSQVhZcjNHckkrMzZjbGtxTzVTdFRhUDhzaFFxREo4QzV5TkdlTVBaZ1Ew?=
 =?utf-8?B?N3FnZjNSQU1HRUZ6aU1keURLWXhUR1YyVmhLQmtsb3hHaTVJY21NelJhZ2l5?=
 =?utf-8?B?YmhpU3dzY2JISUxsU0EwUXpyRDJ0OVdVZGM0WDdNYmxubGlxRCtEZkh2a1ZY?=
 =?utf-8?B?VU9PbTJVQ3BPWjJtOU55OXJpOExQN0hBUTVsSER3RHVTTEcvdEwyTWZzcThV?=
 =?utf-8?B?ZlVnWTZzRlBrempIK1BjVzZib2hMNS9tQWRpL1cyTEM2U0lGZ0prYndBQVp4?=
 =?utf-8?B?MUJzWE9leVNodThvbVdxNFdOTGdQd0tZVXJiQlhGVTdzTkdESUxIdG9vbmZ1?=
 =?utf-8?B?STM4T3gyRHk4OXk3eWh5ZlZaa000MForSnVuYlJ4REp2U2lMbEdjU2FSaU83?=
 =?utf-8?B?RXZobUFCRWd0Qm9oNlBwRTI3cVY2Z3NKV1hFRjhFZEtmcEFjdjZDbXA0RzBq?=
 =?utf-8?B?bUkybUgxVjIrL0Y2MGx3UEpFZFk3bVlBNEFUczhnWSswYmdrTS9EbWExcG5s?=
 =?utf-8?B?ZmdPNVFtTXVyVlJrMWZTcytVNXJIMW1vczFWdWVBOEdvQlBadXo5Q2k1Zzhu?=
 =?utf-8?B?Z3ZZelNRQ3UxTWtva1BYOTZWV0paaTRGN241RTBKelZlMjdLVjA4dEpqT1ZV?=
 =?utf-8?B?SkVpY0FNMGlBTEJLTThrVzk3WDN4YjRpNWpJSUFic2F5eVdXdXZ4S09Ma0ZD?=
 =?utf-8?B?NEdJUXN0eDhOZlAxaVd1dld0elQ4ZFRhakMwMGs4ZWxEdzArZkRMUDNvYnVk?=
 =?utf-8?B?VVZBMys5ZU1TMFlYeXh3aGVhUlpCWU4zeXZBMGZKU3NQaDM1RWRaajhTK3V3?=
 =?utf-8?B?SUpNNGVuVytaSFdtc0MrMnIwSHdiT09rb2U1N0ZCQ2wzSUwrWUkvWTZGQTVy?=
 =?utf-8?B?b1RRWHZjS0QrelJwK2VCZmFrSmJzbVdBcWdOZFlHMkdhemdxWkRnRlRMME0w?=
 =?utf-8?Q?677HTGH4gGA=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?TFl3MTlLMzZ0ZDVKM2I5aTRQT2ZmSVA5cUN3NW84ZlQzeVJuZGU3eHM1NkEv?=
 =?utf-8?B?dFROd0tVdzFkWTNrM0kraUI1bHA3RnFCdzdNUWlzQ2l4cnhNQ1JDaEN5UnE2?=
 =?utf-8?B?Mm8zenBQUHgyeTZ6MXpKbExYVENUVlRQZnlaYVl2SEltdElkeTY0L1JKS1VO?=
 =?utf-8?B?bEhSUDNDb0JhSm8vT1V2Z1p4Yk9xa3FWQ3lTanpSMXdsdnp2L0ZmZkUrZExW?=
 =?utf-8?B?aGtVTG1iZ1N3ZXVXMVhqSmlKcy82Q3FndDZpb2lRTHBCWmdOdjQ4Q3l6TjVQ?=
 =?utf-8?B?bHh0ckVtZmJSOUt6ZTdaRmFROHFoZGJ0eERyT0tBMlk1SVZUbWRVV1ovZEZa?=
 =?utf-8?B?WkowRWkwWkNtdHRkSW1TV2JNOXkvdWhSWitOTFVvUXlZTzJnV0JEOTdQYXFz?=
 =?utf-8?B?NWtmbDRndkZqcTY2UVlaa1d4TDlZMzFBNjNzT1RmZ1d3ZUtMbi9RSVAvaXFw?=
 =?utf-8?B?eEJoS1dicWZSbXpYcytObDZVdW1MV0Y0RTRHVGdUWTFzTVBoN0xHM21GTVd2?=
 =?utf-8?B?NEpNeTFQTFVqYUhRTjBXOGlhaFl5aHpUbmdzSVF6UTBvN215ZW5QUjhpalZV?=
 =?utf-8?B?VXRsYWhoSjQ4cVNvVEc1Z1JxWHlvL0IzSWduSkQrUndmWDR5Sy9sRzR3Nyto?=
 =?utf-8?B?amJIUVh5bWJCRkNQYjFUbmY1ckxPcVl0K255TVp1YWtYMWxuVGpCZDBpZWUz?=
 =?utf-8?B?MVliQldDZ1VqOXhnK2xmcG5UbEdvL3JLeEcydlo3WnZZdnpaVWlQUGRzN3Zv?=
 =?utf-8?B?VlJJcHMzVXpzcGNadEY2R25CVjdFYTQxLzAvMndGNVFjZzcvY0x5d0t1Rnhs?=
 =?utf-8?B?bklZQVhPUDkvbWRpNW5GVEkrYlkrSXgvdTkxd1J3cHJaT1hJUXJ6cVhzcldS?=
 =?utf-8?B?ODNsYmtTNzN0VUtuVXFNYjNtWVBhSmtUdzlJYko2YUJ1NlBKVTcwMkFXUkpk?=
 =?utf-8?B?QXR3Uk80SFdtOHN6dzNpajZreTV3WmhrUXNrR3lNZXZER05RMU4wMklkQ09h?=
 =?utf-8?B?dVlJNldhdlFFMmxuSlQzZU5sM05FTldSOFcyMDlTeUxuZHVYbVBITzFKTVBr?=
 =?utf-8?B?aWgzTWdDMmUwZ2szczh2RUoxV1NKTjMrWDFHY3RyR1BEa2pmNTBuUytxK3pW?=
 =?utf-8?B?NG90NktrZWx3Nmo0alpESmxSd01KbVpmZWl6UkhobllOV0xWaGJWTzA1MVh4?=
 =?utf-8?B?MzArUmRZYUdpNHliMStMR3crK1pIQVVKYzVIUDJLeXBKcDNmQjZpYlBCb09a?=
 =?utf-8?B?TGpSNUJPVk5CM2t3Qm8vVUtkQXdUYTNuOWtLYWVQUUo1VW1SWTdJMk4rcTJy?=
 =?utf-8?B?TzcwV1BUR2UvdFBjcTkwUUJkN1BjZmZoTXRkbVBobnBYbFB4OWtWNEN6dUZt?=
 =?utf-8?B?NzRxZnN5a0FMMkppZi9lejhoQ1FqUzBYRHFWa0tnTCtPek5zMWEzRDFVVncv?=
 =?utf-8?B?U0dIenlZbnZ0c1p0dmpXT3lQQzVocklxcFQ2OTV1Rk50UzdpZlFLbjR5Rzhk?=
 =?utf-8?B?WGhPWm54Ym11TnhWS2xaWitKeTc5cEJDV1poSm9lOUlSbENlMFVLWEpiN2F5?=
 =?utf-8?B?UlgwQzJjOERiSE1hSlFnUC80L2NYVWZIMEI3U0krcFlKSXFJSWkxVmpoNURk?=
 =?utf-8?B?UFFVZUU2Rk5GdFV3bWgzUjFaL2R5Qi9zd3RkQUJIb0pjMHhPbEFNRjhhTXNn?=
 =?utf-8?B?eTZYTlBxN2F6c2dXOGtBQUlRdS9CRTJwR0k3YlhncDVyalJqMythTFBrYUVV?=
 =?utf-8?B?aUxMazhCczZpODJFTjBTOHRYT05xWXhFMHgxQk1vekFLbGZ1NmtaL1A2VjZT?=
 =?utf-8?B?YzFWcVRNdWJFb01qQmEydVNCbjdQUDBYMkJEZlZMUW9jUzdqckVCa1VyamhJ?=
 =?utf-8?B?TlNueXZQdUZWaEY0N0NtcHk3RU41RFJZSmY5enQ2a1NnWGg2cmppYWpESVhB?=
 =?utf-8?B?S05mN2lQak9aanRmd25JZGU4TGJ5NVhBb1diN3gxcGNGUzhKMFNUNWVoRVN6?=
 =?utf-8?B?Y1BoL09GZzhxK1hFSDJvWUV4RitDUC9jUFJnWU1PVEVsNXpJbDFUOGJTZVRw?=
 =?utf-8?B?MHJySjlOUHNrOUxOMjBOT0lyMmtTTGZSVjRLS25YVmZvdDZ1c2MzV2lhMW9P?=
 =?utf-8?Q?W+gk4LFqE5NyaFOOHfstAtdwL?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a8a97c41-80fd-45d1-d721-08ddf9ed5b99
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Sep 2025 15:33:19.7794
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mBxZ7wGuloPetZVWZIU/P1k1BFTYpX6w9G5+ncEuu32rXzxhiKJwRdK5qjxRbYhN/6/eq3TtUDJ10Pc97UnzYQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR10MB8674
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 22 Sep 2025 15:33:30 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/20090

From: Jan Kiszka <jan.kiszka@siemens.com>

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 ...10.239-cip62-rt27.bb => linux-cip-rt_5.10.241-cip64-rt28.bb} | 2 +-
 ...6.1.141-cip43-rt23.bb => linux-cip-rt_6.1.151-cip46-rt24.bb} | 2 +-
 ...inux-cip_4.19.325-cip123.bb => linux-cip_4.19.325-cip124.bb} | 2 +-
 .../{linux-cip_6.1.148-cip45.bb => linux-cip_6.1.151-cip46.bb}  | 2 +-
 4 files changed, 4 insertions(+), 4 deletions(-)
 rename recipes-kernel/linux/{linux-cip-rt_5.10.239-cip62-rt27.bb => linux-cip-rt_5.10.241-cip64-rt28.bb} (68%)
 rename recipes-kernel/linux/{linux-cip-rt_6.1.141-cip43-rt23.bb => linux-cip-rt_6.1.151-cip46-rt24.bb} (59%)
 rename recipes-kernel/linux/{linux-cip_4.19.325-cip123.bb => linux-cip_4.19.325-cip124.bb} (68%)
 rename recipes-kernel/linux/{linux-cip_6.1.148-cip45.bb => linux-cip_6.1.151-cip46.bb} (59%)

diff --git a/recipes-kernel/linux/linux-cip-rt_5.10.239-cip62-rt27.bb b/recipes-kernel/linux/linux-cip-rt_5.10.241-cip64-rt28.bb
similarity index 68%
rename from recipes-kernel/linux/linux-cip-rt_5.10.239-cip62-rt27.bb
rename to recipes-kernel/linux/linux-cip-rt_5.10.241-cip64-rt28.bb
index 521dd4da..09bc40cc 100644
--- a/recipes-kernel/linux/linux-cip-rt_5.10.239-cip62-rt27.bb
+++ b/recipes-kernel/linux/linux-cip-rt_5.10.241-cip64-rt28.bb
@@ -11,4 +11,4 @@
 
 require linux-cip-release.inc
 
-SRC_URI[sha256sum] = "72a79a744898d774fe4f5235345b70595c97fce31f7482a2d35fca9549e6303d"
+SRC_URI[sha256sum] = "681e2ed1c9407c6050c0b60432050c09cb3257f654368fe3d48880945fddd1c3"
diff --git a/recipes-kernel/linux/linux-cip-rt_6.1.141-cip43-rt23.bb b/recipes-kernel/linux/linux-cip-rt_6.1.151-cip46-rt24.bb
similarity index 59%
rename from recipes-kernel/linux/linux-cip-rt_6.1.141-cip43-rt23.bb
rename to recipes-kernel/linux/linux-cip-rt_6.1.151-cip46-rt24.bb
index 0dbe34be..79ca1996 100644
--- a/recipes-kernel/linux/linux-cip-rt_6.1.141-cip43-rt23.bb
+++ b/recipes-kernel/linux/linux-cip-rt_6.1.151-cip46-rt24.bb
@@ -7,4 +7,4 @@
 
 require linux-cip-release.inc
 
-SRC_URI[sha256sum] = "41eaf5a2f74b849626659246e868bf4b2d570b4e26e395eddc48258a787d2724"
+SRC_URI[sha256sum] = "52eaf229fbe6f601ac1e5288ac70ae118486db6c317e78b42cb2e4fef93e66e8"
diff --git a/recipes-kernel/linux/linux-cip_4.19.325-cip123.bb b/recipes-kernel/linux/linux-cip_4.19.325-cip124.bb
similarity index 68%
rename from recipes-kernel/linux/linux-cip_4.19.325-cip123.bb
rename to recipes-kernel/linux/linux-cip_4.19.325-cip124.bb
index da1ca312..946c709e 100644
--- a/recipes-kernel/linux/linux-cip_4.19.325-cip123.bb
+++ b/recipes-kernel/linux/linux-cip_4.19.325-cip124.bb
@@ -11,4 +11,4 @@
 
 require linux-cip-release.inc
 
-SRC_URI[sha256sum] = "79b1f71b255fdf4cdc67c8e7b38f110ac95691a9c5f20bce2f83107b8112cdff"
+SRC_URI[sha256sum] = "fc5004889dc159a59b6c6b85146584ad3393149efbff34ad8b25288fbd792b78"
diff --git a/recipes-kernel/linux/linux-cip_6.1.148-cip45.bb b/recipes-kernel/linux/linux-cip_6.1.151-cip46.bb
similarity index 59%
rename from recipes-kernel/linux/linux-cip_6.1.148-cip45.bb
rename to recipes-kernel/linux/linux-cip_6.1.151-cip46.bb
index 6cd91f26..402dbba6 100644
--- a/recipes-kernel/linux/linux-cip_6.1.148-cip45.bb
+++ b/recipes-kernel/linux/linux-cip_6.1.151-cip46.bb
@@ -7,4 +7,4 @@
 
 require linux-cip-release.inc
 
-SRC_URI[sha256sum] = "7566ef5e23e2215edd31e285b779aff2619e9d85ff90c0f7a1d69264524679bf"
+SRC_URI[sha256sum] = "1dffd99104ce9c9b75d387f345bbd3a5c2e5f9ae112315c5fe1c830c38c4299b"
-- 
2.51.0

