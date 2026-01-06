Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99DC8C47BF2
	for <webhook@archiver.kernel.org>; Tue,  6 Jan 2026 14:06:50 +0000 (UTC)
Received: from PA4PR04CU001.outbound.protection.outlook.com (PA4PR04CU001.outbound.protection.outlook.com [40.107.162.26])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.90465.1767708405093334438
 for <cip-dev@lists.cip-project.org>;
 Tue, 06 Jan 2026 06:06:45 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=saP0Sfkn;
 spf=pass (domain: siemens.com, ip: 40.107.162.26, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=n8xEn3iOFXJy438JtZuCrQLoq+WUau6HODU0UqWz2qXXnzI8BjoVdj3jXHmwQ6RmJkg4yqUJQC8EMchmIibe5L4bFqNvJQGLqzT3N283gg4za0Lmcr8rw3TA3xL8KmO6WuS2o4PoEBrSxQEnpZzCdQUrunbD3XhewkV01pzef7LauENH6yn2LdG4V0BSah9Hh5CGVA6T0I3cxInCUzu1W3ufKWq4qoBid7VbKuL9z7obn5FD46gkT//wafF/GBwd1yWHk9rBTAKzvrmrzsMUVI0CwxOTnletTvRLmZNnv3+ULuW15SC00emdrWcZRukQFXT1/oLCgyv+RcL2EQ8lmA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gYUBWhmrShQi5xD7Sw9UourQFXsuCjRlqvwKXQE7zJc=;
 b=TnOMNNbarYhRAcYMLK8mIQ1yBFg4JuVkjOQIeUo55LJL4dGybOrYvkoSjDsocpZwGabDtB+TnRNn4m8V4hYXikKku1eUMVqkSC54z4jFvcflh00UcL7qNzuZchikVJa1/gFfmmPATN66peAc5qMLOXRW3gjhv+nNev8dSEVeasfKWJuK6lgqV9A5mecFGGbZLC4UPhZVXyH0orwgMWz3e0yFiU5RafABN06xtwfczTfYUGOymO6vECWqdNdKersuc158uI1DMr8UEisD4LTfTMdV6pvycGWcIu9GFBC6lv6FcJiJOrMRuILG4pZAXA/95DnFA/pwJ+u5B3h3j2FdOA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gYUBWhmrShQi5xD7Sw9UourQFXsuCjRlqvwKXQE7zJc=;
 b=saP0Sfknl01/XBqFzWHg9lLJqcHeJNXVZfNMwQqle652jCxNSTrvRYc55HMa3eJIAjz5gvqu0AS/14DTTH2gbuo4TeNBE+bYIbfzdsGdo0/IKkqnhxdfkm4XvA2QbZRbWwiBbCoGmFfct9MM/HqAyp0xyI4GDdHr9X8BgmbrHfjoQ9waxOcNOSDzJERwxgEWAVkul3D02eGdm+d7ZacqiV+MgxqKlR+drrDdGnAmG5QXr/HRuudtciKOycBfJO1y1ybdAyhyad0lkuIIDYP5upp/UzdwJkubONIEAa7ROCZh4N4rV7E5LFSxY/Mqkr3dVcijTvI+23lX1cODCD9MQA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by DU4PR10MB8468.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:55b::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.2; Tue, 6 Jan
 2026 14:06:40 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%6]) with mapi id 15.20.9478.004; Tue, 6 Jan 2026
 14:06:39 +0000
Message-ID: <683e0568-60bd-4afa-95f9-eef19c6b06de@siemens.com>
Date: Tue, 6 Jan 2026 15:06:38 +0100
User-Agent: Mozilla Thunderbird
From: Jan Kiszka <jan.kiszka@siemens.com>
To: cip-dev <cip-dev@lists.cip-project.org>
Subject: [isar-cip-core][PATCH] x86-uefi: Switch to systemd-boot
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR3P281CA0117.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a3::8) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|DU4PR10MB8468:EE_
X-MS-Office365-Filtering-Correlation-Id: 0b168cb1-e6a5-41da-2c67-08de4d2ccfdb
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?TUZ3S1FRN0hzdHJWK0Q0Qlo0cTc1aHVEa25vZGFsZkMyS3d2Q3hjWXJkSW5V?=
 =?utf-8?B?Rm9Zdmorank0ZmhqWldlbkV5US9GR3R5SXBBKzd3cFdiVDZKanpBa1lFL0JQ?=
 =?utf-8?B?STFISnMzNkljNU1tNkE3aDU2WGpMb0J5SUhmRHpJSFZUS244K3NzNXpqR2VQ?=
 =?utf-8?B?clZpSDV3MWlCRk8xbXNaTy9RandSUTNoUWhoOXQ5Nzk3bDl3cldUUldGYUlC?=
 =?utf-8?B?azQycTJVWTU4b3J4N01KMmZLelVjaHhsVkYzeXBnVDl1QS9WNFcvZmNzZWx3?=
 =?utf-8?B?cDNuV2h3dWNkRGptQXBabmNUU1NiR1kwZE1kbGtVTWd2MzJKRjlteGFIeGlo?=
 =?utf-8?B?akxBUWE0MnMzWnR5d2NKcmVqWENURHYxWUpOdFR6ekZvY25ic1ZXcHhCY2tn?=
 =?utf-8?B?MDNQVlRkODZPTWl6SlhzYzBERS9nVzMvTWhQYVg2RCtsWFRoUG5iRjlDWjU2?=
 =?utf-8?B?QUZXbFUrV1NrU2hMd1M1S2tQVCtSUEt6dHJ2d08vdmZaL25KTXpNU0F0azdB?=
 =?utf-8?B?ZDVQZXNDZkkycjM1TGVJRytqaWN5NzhCRDVjVlpCMTltd3k1cVBJdUdtMGJZ?=
 =?utf-8?B?NVJCemRzeG9FWk9xbkhsb1IzYklMRmhnU0pvcXdxQ0lTd2hyc0RsbTZUUGc4?=
 =?utf-8?B?SW5QZmk4c2QxUVdaa0hHbVZGVUhoaS9GcXRTZW9FMjJxSVZWYlZ3TkpwK0Nk?=
 =?utf-8?B?NUUvYXZYVXpkZ0NKemQ4UkRXcHJ6cDhuMjVtVTRGWUNkNk9OR3l2TWlaL0xw?=
 =?utf-8?B?dHBtZEY0eGVoWURsUkVNVk1XcXFJK1pSQWQxdzBacm9oSHkwUysya2w5eW1Q?=
 =?utf-8?B?UHJaOElRZ1IyeE5VQWszZzdHbjYvYWNCMFFrQVFqcHp2ODAwR0doVGJ3SkpY?=
 =?utf-8?B?QWUrNFc3WmZ6SmViWWlwRXNwSWZMTG1TNGloLzk4TDdSWnpQSWNKNWpaNkQw?=
 =?utf-8?B?MXpZUmkyWWVudi9iQkNLNndhQzR5UzRaOUUzcHUvK1VZMkY5emZQc1c0alJT?=
 =?utf-8?B?NXdYQTN0OWwxMCsxOFpBb21FbVFlaTBYK1UrR3Z0OStmVWk5NjJFRE5vWHZw?=
 =?utf-8?B?dmJqM21rRFU4WGk0RXBFbjRzNzFwWXFtSEczcFRwVVIxa0R0eklrYVFFa3dS?=
 =?utf-8?B?SHdINUdUcnNhUkNUT0hLM0lCU3ZkN2J6L1lMZFF0RTFic25kQTV0eXk2MXJU?=
 =?utf-8?B?ZDcwWW9WQ21ac21wK1JqRHFZeng0SWxMck5aS2xwaG40R0toSXRtZlRLWm82?=
 =?utf-8?B?eHFtYytoSmVpTHpxMWlmeVpDT1BISlZsdm9NTTBwZEhZMnVpSzRhZkpZZkVF?=
 =?utf-8?B?OUpJZldPTzBNVDVJMVYwWmNVSEpTME1Pck1jZG0rd2NuRzFjcVh5dEd0WUdh?=
 =?utf-8?B?bHNlZ3BVM2wzR1hZcS9ZdVBxUGtGbWhiVUh6UWdqWGZBQzQ4SFhyVThBUkxi?=
 =?utf-8?B?REoreE9Rc2xoVm5rN3Q4bldHVktoemhJLzZhVVJyYTN2VS92Ui9YZlhGeWE3?=
 =?utf-8?B?NUZHa2pqZFhML29FYXdwSmZtRWlaVmZCYXluOFFwUjVTaFZCQ0hjRnAwMXZq?=
 =?utf-8?B?bTJHc2VqYU1EaXNlT0JReGMwelNSb1pEaUptbitwVWJLY2Zzb0ZLbkJKaWhZ?=
 =?utf-8?B?SlRIc0xyQ1N4Q2VQZnNscVFXOWcvZ3VHTmJvWTJpc0lVUW13cnlpYkVnM2ph?=
 =?utf-8?B?MW1zWWFLcnJBcWN0V2V1ZTYwSFJCZVViNWszVWFVZk8wNkJkSFlNUjJvWlJJ?=
 =?utf-8?B?aWtIaXZQNENWTlV0TGY3VXE3eXFwK2FjaVNETlJ3aXlmdng0L2NFcW9XL2tK?=
 =?utf-8?B?YlY0WCtVWmlFSlcwMzdtcTFtK3RFdEc3dHF4MENJbVRwVkhlWlIxUmtaSFFh?=
 =?utf-8?B?WmdycGtlVVc0YUw1QXp5ZEdVa2ZuRy90WjhJQ2JEeUVYK1dQbmtNKzZGSnFV?=
 =?utf-8?Q?NK9LGbfb6LknCcUonzzgXTBM7Pl3xz+R?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?dVlvbnZMbXZRS1JqZkt5SXpwS2paR2ZQR3BnNW5Oak1TbFpNN0E0Rit2UjZ4?=
 =?utf-8?B?VFZzUEg3NTJsUGxZb25sU2lra3FvUkQvRHRrNnJicVhuMmN1czJ1a0JMYlR1?=
 =?utf-8?B?MWJxZDdzTzZsVnl3MEtjd1RreUQ3TjgxcFE1d3RtUkRaaG1HMXA4dENzaFRF?=
 =?utf-8?B?dkhraFJHMEZXM0kwVEdJZFlRcDBBSHl1K0EvQm1WL29iV2N1N2c4ODA3MlEr?=
 =?utf-8?B?THM4dmI5MWxMbHJIV2hvdUl1WjFaWStjZkZzaFdVM1VBY3lwTkZpR1hGK0Na?=
 =?utf-8?B?dmxOYWt0YlltcDdieWNLRDRyRFJsQ01SN3MzWm83eVUzTEgvbmdac1R1Nm00?=
 =?utf-8?B?RUd2ZXlmU3ZiU2I2YjVjZ1ZaQWNUMGxENW5IRmY1LzJsM1RDRXFDM0R4VTRl?=
 =?utf-8?B?blk1MGl4Z09ITHBOVXhpWVh0bGV2a2g0YmFhdVNoa01yd1BXR2dPQ1lBekVs?=
 =?utf-8?B?OUhjdDVXbXNXRjhxQ0czdkRTR3Z1Q2JKTHBYUWZaQmJENzZGMzlRclRGc3hD?=
 =?utf-8?B?RTcvOWF4elBjaDVpTGQ2Ym1hTkc5TTlycm95cnBiTjBsZkwyTFM5d1ExSXhW?=
 =?utf-8?B?S2dPaDJrUHEwVCtrV1V6ZEkzd2dhNVNrZU9ndUxoSEx3ekM4b3RqZ2JPbGwr?=
 =?utf-8?B?WFN6aGhlK1RXYzZXZVg3Z1Y1Vkd3WmtHQVhoLzRobHlWVFdOVGt2WFZYMDZ5?=
 =?utf-8?B?QjAzVDFGb0x0dWorNndrRHBEMUxDVlYwNXRUVlVjYnFNcmtNSFdiRGpkNGcw?=
 =?utf-8?B?Q1Zhc1BMM3p2UGlHbWlDY1NDNzdkWEtZaWUvS05YNzErVjhqS0djdDVoWnFY?=
 =?utf-8?B?WGVCQ0tsOUpVeWgwTGJtT0duakhicThWNFVscnk0ZDYrMFArZjlUbEd6Q2hS?=
 =?utf-8?B?bmcxRFlzSGFzenp5OHd2SkVKSHF3M2hrMXZReVhLUTVLZzY0WHkyZWdSN0VS?=
 =?utf-8?B?b3VCa0ptNnVaWk5Ed3dDZzlzWFN6eFB1SUFZMUxJaHdzWElZVkgyT2ZuK2Nm?=
 =?utf-8?B?dU1EdFlaeWFkNmQrS1lkVGdvOHM3d3F0WkZFallzdGppRWhJalIwWllURThw?=
 =?utf-8?B?eGtXOTYxVTJNZUIzbnB2T2lGcklZY2lTd1VHUGhiRHhSNHFab2t3WjBBZHp6?=
 =?utf-8?B?dFdwTzRVMmdBZXM3Sm1iclBPWVpBUWdJbGp2bkVIOW1Sdk56Mkd4UjVsL2xr?=
 =?utf-8?B?VDQ3bmd5M2VaR09LVjJiQWpsM3p5UEFqeG9oRkxXSWFLYXYyeWFiRWNPdXJo?=
 =?utf-8?B?Z1ZWOGhYZzA2dC83WGNRZ0xROTd3eVhUOXhVa1BGS0t5dDBYSjFjZ1JNaWNo?=
 =?utf-8?B?NXVDa3BWWW4wb25DdDdBL1R3VTA4VkNqWFVSTDdteFcxSUdCUXl6Mmhqanpx?=
 =?utf-8?B?K0RCSTJTbUN6emhoTVBZNHpyQ3llMXZTRmlDTFdYa00zSy9scGRVSk5vanlM?=
 =?utf-8?B?NkFmWHhLcFIwQWdYSm1LenRtOUZUMlRiNFhRTUhUYnVId3hiQXFNYWlRejdQ?=
 =?utf-8?B?d1ZUQ29NUGNDa3BLeGJmTC83S09sQ0Z6RDdFK3ZzUzJpNWF6L1BiUjFRcmVx?=
 =?utf-8?B?azB0cUpwUjNBalZsbUdJRFRyNEJORDJOYU1FN3hyMjJjazZQVGRRMGxVUkxV?=
 =?utf-8?B?dE5UNDBtZlp5dVNhczFHVURvOW9lRzZwa1U5TFJMWHBLbEN3UWRidHhKY0x4?=
 =?utf-8?B?bkNDcEw1cmt2VGpHUVk0MGhHVFNvMDNyQlFuYXhrZFVRdXlOcWJDTkxNa1Rt?=
 =?utf-8?B?bkg0UEhYUUM2WVdqWDJUT0xjWXJ3cVBVRy8xWVFxcmFldzUxUXVhTGE4Tk9U?=
 =?utf-8?B?NHcrZmwxbElvM1NsbW0ybVBIRmczZnBDWTdIM0VPU0dPTGxmZGlUQ29oeVJs?=
 =?utf-8?B?c2VIQVVMTTg5MlFPcW91c3Buc3l3WXJYSW8wZlNCVk5naGdwVVhUdTl1R1RL?=
 =?utf-8?B?SWNNbzgwQk55R3JrTktaamZtc3ZDNE9hNU5VMHpDL1A5bklIS0IrUFBkNnI0?=
 =?utf-8?B?eWI1OG16SVNoQ0I5SFpNTUwwbTg0QUJiNGlXS0VFUklDbVFUa1kwdEFacXk3?=
 =?utf-8?B?aWEwMlJUVStHd3R2ZmN1T0U5Y0RMckZ2R0ZtRjhTOFIvZnNrNU4yVHFTQWNQ?=
 =?utf-8?B?TjJvV2JCZk1Pd0dqUGprZFhXU3BZYzB3c2JTd1ZaRFQxbHY3VERtS0hnN2tv?=
 =?utf-8?B?ZE1QV0x4cStZS1JZTzBFV0prcFFvYUk3WFVoZ1ZPeXNTZTlzT3NKcFNkRTky?=
 =?utf-8?B?NTNjZUtVNU1Kb1RaQUNDZmRvOEZwa3NySlcwRTVnZkxmZFBrZXJxdXYxVGZH?=
 =?utf-8?B?MzZiMk4vN09ESXNMNEhiNzV2ZzU3ZFJDYTlXL1owZEdWOFliekpYdz09?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0b168cb1-e6a5-41da-2c67-08de4d2ccfdb
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jan 2026 14:06:39.5472
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wntqpdOlPYgxOiXA818rFHzbXzh6YgqUxRWWF2hK9dmZTEzAev0jWARqvCc5g2HpyJiHsSiHLMccCvtELvD0cw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU4PR10MB8468
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 06 Jan 2026 14:06:50 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/21385

From: Jan Kiszka <jan.kiszka@siemens.com>

More lightweight, and we already use it for non-x86 target.

Only affects the base image, we continue to use EFI Boot Guard on the
update images.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 conf/machine/x86-uefi.conf | 4 ++--
 wic/x86_64-generic.wks     | 4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/conf/machine/x86-uefi.conf b/conf/machine/x86-uefi.conf
index 6bb607a9..84cf8bbe 100644
--- a/conf/machine/x86-uefi.conf
+++ b/conf/machine/x86-uefi.conf
@@ -1,7 +1,7 @@
 #
 # CIP Core, generic profile
 #
-# Copyright (c) Siemens AG, 2019-2024
+# Copyright (c) Siemens AG, 2019-2026
 #
 # SPDX-License-Identifier: MIT
 #
@@ -10,7 +10,7 @@ DISTRO_ARCH = "amd64"
 
 IMAGE_FSTYPES ?= "wic"
 WKS_FILE ?= "x86_64-generic.wks"
-IMAGER_INSTALL:wic += "${GRUB_BOOTLOADER_INSTALL}"
+IMAGER_INSTALL:wic += "${SYSTEMD_BOOTLOADER_INSTALL}"
 USE_CIP_KERNEL_CONFIG = "1"
 
 PREFERRED_PROVIDER_factory-reset-helper = "factory-reset-helper-efi"
diff --git a/wic/x86_64-generic.wks b/wic/x86_64-generic.wks
index a2b9c21b..75e29cf7 100644
--- a/wic/x86_64-generic.wks
+++ b/wic/x86_64-generic.wks
@@ -1,12 +1,12 @@
 #
 # CIP Core, generic profile
 #
-# Copyright (c) Siemens AG, 2019
+# Copyright (c) Siemens AG, 2019-2026
 #
 # SPDX-License-Identifier: MIT
 #
 
-part /boot --source bootimg-efi-isar --sourceparams "loader=grub-efi" --label efi --part-type EF00 --align 1024 --fsuuid 0x4321dcba --uuid cf142945-6fa1-4945-b0f2-b8d6226298c0
+part /boot --source bootimg-efi-isar --sourceparams "loader=systemd-boot" --label efi --part-type EF00 --align 1024 --fsuuid 0x4321dcba --uuid cf142945-6fa1-4945-b0f2-b8d6226298c0
 
 part / --source rootfs --fstype ext4 --mkfs-extraopts "-T default" --label platform --align 1024 --fsuuid 1f55d66a-40d8-11ee-be56-0242ac120002 --uuid f225331b-2d9c-45a2-bcfe-4a6e86287dfb
 
-- 
2.51.0

