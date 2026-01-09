Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 012E2D26D99
	for <webhook@archiver.kernel.org>; Fri,  9 Jan 2026 19:33:32 +0000 (UTC)
Received: from AM0PR02CU008.outbound.protection.outlook.com (AM0PR02CU008.outbound.protection.outlook.com [52.101.72.30])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.18142.1767987203765970912
 for <cip-dev@lists.cip-project.org>;
 Fri, 09 Jan 2026 11:33:24 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=n9SyUTBM;
 spf=pass (domain: siemens.com, ip: 52.101.72.30, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YPYAP4F5di7+brmYJi/EDhGsuQTJgBhNLpfFmLmNKFbol0Vk0i/x2yyPSc+X3HufxJHGzU727zZj96823oYR1NYKsCQt0QMsMyGvQxWGXBzknesY5ZrMlwMH8alKKwCKO4ZtrE98Sepv3e0uWFbA6Gkkl96yMNCR9NilFeXwTqGt1hL9fZVZEn5SqHp24tXGydhiYb0MKFf6KOD4SvQ7tQsL4cDJN4YBYeyhsj/WvmggmCHrTv0zwTpQuezm7agtt0++kUc8p287qUocn8g+Ii/fRKPyZWWzbym+rC1W9GKFGEeMOkof7EjYuwhWFmdvFxyrYi5A5Azxm1tMsPHFKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hv7MfS5X/1cBvQ/QLJOSTfIT9efe54ZzyyqiQVqfOss=;
 b=r+3aTp1yVdz34HOkz2BpLWb2La2J8xMHhP5jaQWpMY0Tfdj73Di5TxZ2lzFEBXMdIvY86LinUITKQikIz3uDHYmNZ2WYmGETZeYxpn0um3uDmENK12kC9Hhj6k+CGrDg1yQyKXMQUcgz9q4tqh2AqIzH4Pv3lTbVs0WBEbT5nUo5AphAHRaY06yiGiMEJ8rYr2+WvmHV8dhLt6nb5l8lHMC5czgLQMoTVe/pXHXrnTCfxNn65+za3382cGyWyBP9/7mkszKbKv1+EY2N334kntw16lGqalVP1sVQh5DTb2F1wgNHZaGgvm4MUTbf7Rytno3jlhuNYuRO7eGx0WkfTQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hv7MfS5X/1cBvQ/QLJOSTfIT9efe54ZzyyqiQVqfOss=;
 b=n9SyUTBM+jNv7VbpTsS7eRRMaM+FCfuDWRGcjl3c5G7iOTZ68C26yt7BiAfiwaqzyngpEp8a3ktS5/dWFyBxElWqtDl3mypnj5mUE80IHTSXgSc7iWVQUucCij77MjVEY8JP8rAEvofmSX6sZIMv9GH8jAO61Rvm5/3UX9lCdoGhBG02TcwBgh2tfU8tZmKXERZap9xXqR0Z5+MRFnJr+M+oSG890Ni6r01bODimrrRmCaMN/N+noAbBg7lX7wqa7lfopgD/Pz/77tujysbCfX03A87/au1xHl3NDoT9jbjYa6OcbLhvIYtRFgl4J9A3ZS6nw/dzLCIG0VgLqMfdgw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by GV1PR10MB9060.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:1d1::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.3; Fri, 9 Jan
 2026 19:33:18 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1%6]) with mapi id 15.20.9499.003; Fri, 9 Jan 2026
 19:33:18 +0000
Message-ID: <f029d08c-e404-4b40-91dd-f2adb38456dc@siemens.com>
Date: Fri, 9 Jan 2026 20:33:17 +0100
User-Agent: Mozilla Thunderbird
From: Jan Kiszka <jan.kiszka@siemens.com>
To: cip-dev <cip-dev@lists.cip-project.org>
Subject: [isar-cip-core][PATCH v2] u-boot-bbb: Disable problematic GRUB
 workaround
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR2P281CA0125.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9d::19) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|GV1PR10MB9060:EE_
X-MS-Office365-Filtering-Correlation-Id: 4b80e278-86e6-470c-15be-08de4fb5f0cd
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?aEU0ckFZY0dERWNGNXNXTHgzSklUVllaRFg1eHNldUc0UnlzSVFQaXhtdkZ0?=
 =?utf-8?B?TUVBQUVCc2pIanh5RWdDNHRaUUhDWXZKVmVQVlhOdHVSQVpGSE1tNHB6bTIv?=
 =?utf-8?B?c2lGU0h3WCsraC9SK3hycnMwZXpuZDNPcU50SmYvMVgzMmxoMDQrMlo5L2hO?=
 =?utf-8?B?ZFVsM2dDanVLbGppbEt1S3BaWmxOSm1neE9VTmg0WDBLRXlka3NnSnhtTGhW?=
 =?utf-8?B?WTVORjZCZnEwWjgyNStEY2t5SWlnS0I3c3Bpd2tyNFVVaVNjOVB5UmNYYVFS?=
 =?utf-8?B?MURBeVAybTBYL3g3cXN2ejkzL1pwVFFuc3lOc1RXbnczekdGRnN2cFZWdDR0?=
 =?utf-8?B?ZjR6aUo3d2dmaUxqd1M4RVRpTTMrbnJ2ZGhZbHhidWMvdTFyeEhEWC84MmMz?=
 =?utf-8?B?SStQTkxHZmZlT1I0QzV3WUFpZEVJRXVsdjhXayt5amlTUGJLVHJXejVIRFFj?=
 =?utf-8?B?ZzZxdTZaTU1LNStXUHprTmNwUHB6TXdJUXB3OXlqTnZyWjhhKzd6UWMwMGxL?=
 =?utf-8?B?Y0g0a1lkL0Y3N1hZSE1sc3VKdERyU2M2SnY3bTBmelVOWE9RWWpzL0h3bGxP?=
 =?utf-8?B?dHJURnpKRDkxS3N4NExuOGNGa1hqa0FKMzRrQ1NTYVZ0RE1UN3d0REJwQjdo?=
 =?utf-8?B?UlR1SXlqNFVXRTl5MmN1dTErRzA0MExsUksvam1mT0NxMFcvVFRJN3VkaGdh?=
 =?utf-8?B?QUM2MnZMMEtvVTdsTEMyS2xrOGVVSnRXN0tsekdZeXNrWTJPRVhWOG8zWWFF?=
 =?utf-8?B?dlprNVdwZW1TZU92REs4cnkzRXk4bUJRTUhEdW83cG5zRmhxWUxkdWJWT1NW?=
 =?utf-8?B?OWp0Q1hsYmdNdUc0QmdvbU1sQXdvdXZVNWlDL1U1Q2dXSXlEeWk2SzExd2lz?=
 =?utf-8?B?dkJ5RFdXMjRCZTFEWDJPR05XZFFZZzdESi9aV0lqOVdxMDdaZ0d5L2wyYkhH?=
 =?utf-8?B?RmZPd3VVOW5tTThVZVYzMU5yRTRCTjJadzNHdnNMKzVMWERjZDRNc2RVeHpx?=
 =?utf-8?B?VlRHSXRod2VBRE0wZGY1U3hZa0ZyV2gvQjdTeFo0TVJZY05PaDlQMUdIOVdT?=
 =?utf-8?B?ZTlvaS9kRWd5ZmlCWno4ZEFjUU1nejNERkpXOC92MGdQbWZSaGZHK0RVcFVz?=
 =?utf-8?B?cVZ6MEZQOWVvYUdUZ3J5RnQ2SjAvTHAwa0gxVUliZXJxUXNOREM2RmdYK0Zr?=
 =?utf-8?B?eWJHTnhjWTlOSUd6OHJTT2NVZkQwTmZTMXY2M3E0RkZSaVNZdXRjVTN3UXRQ?=
 =?utf-8?B?TTNZZVlWMlZTZDZaTEVHRFJSNXp6VlBaK3lwc243c3M1N2pvVS9IdGZGOTZH?=
 =?utf-8?B?M2lEUFdmYkx4aGNGbFFWZFVxQjFrKzJDVlZSRjdOK3o2RkNKWXVNUHpBNFpY?=
 =?utf-8?B?b05YZ0x6L1B3cVJBUjB2NlUrRy81RWpnMDcxZjhmS1hlTjFqQlhkUHI5MmE5?=
 =?utf-8?B?VkwwOW5zVDQrRXNnK21Lbk1zMWM3Rzl5WHBMaXBJS2hNa3NpQWtxVlRxZUZm?=
 =?utf-8?B?RlJmZDkyTE0xdDRBbk1hNktES1Brb0oxck9BbHdkd0tzOFE3b3ZoNmNzbEY2?=
 =?utf-8?B?clkrYUcwL3JxYXM5Y3lkcWNXUGt0RC9YNUE4dk0vY21tUDNQS0V1aERKSUdk?=
 =?utf-8?B?Z044M2Q4bVhmV3loRmM5SXFITGx1VjlIakNqL0x5OFZ0NDgvbmFldFZDdyt6?=
 =?utf-8?B?dnAvdGc3ZURJWmVldVZ3STJlWXF4Zk9mQXp3UG96bkFQNkFtRnNnYUYrZXd6?=
 =?utf-8?B?bmw4RCtlSU43MzY2eHMwSm50MmlQeEZVN1dHN2hCYWR1ZVJkZkFBMEdZc2ln?=
 =?utf-8?B?OHpVQzg3bnRPK2l1UlBtcmJsczNieEQ1cFVMS2VyYUZPell6RXdab3VROGl4?=
 =?utf-8?B?RTNEZWJCemJWZFpkdEtQQ2tXeXhoakdLa2pYcHVaNkVUbzBNOS8zTDNkaWQ1?=
 =?utf-8?Q?h5EqLRisMQNEXKtnXufmLyX1F0c3DH7/?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?VElNQ0pmMXdFbk9sNjkyUEJJSkhpZFdWM3VsbWJVcUNZY1NjNTJWd3pTTEFo?=
 =?utf-8?B?QlpGSjE3cmRNa3JEVUVPOUgybVpBbzBOZEFDcmp6M1FUZEh2UjZaczh6N3ZE?=
 =?utf-8?B?SlFwWTlqeGNKRDJQb0pQRWNCRFF0a24zSzNXbUNwWDZoaVJodVV2QWN6VTdi?=
 =?utf-8?B?VzBidEQvcHZQM1dlWGVOTTVnZ0tuUTdRN1BvTXdJTlgvTjhNUlJSVXQyeFp2?=
 =?utf-8?B?WXFsaXpLT3owbVljaWtIOUp2L0ZRaFBMZUxIWGlxRUZCUEZQTjhmZFB6clpv?=
 =?utf-8?B?YmlBRGluK3l1ZmVJWlVVNUZDMEJhUTRkNTJwd21OaGRrY20veFpmd2VicHR5?=
 =?utf-8?B?U3BZeU1rVnhRNU8veVh0OFpvZkdTNEhWMUMwNWxiaTJZNHFMekRUVHFPK1JW?=
 =?utf-8?B?WjhuOWYybzVSeUNEVnlrMSt6ckxZdWtYWXk5RzlwM1RzTWtGbHFhVDYxeWZP?=
 =?utf-8?B?L0EwV1o4QUhHbU90cG5tRy9iQkZEWkVWMHZHdjhESkhLcC9JQjdDYWFGWHRU?=
 =?utf-8?B?Rk1Ca282S2M4OVZHeDVVMks1U1kvSDFOOE1uVkh2L01aQ3hvQlBoMlBGd2ln?=
 =?utf-8?B?L3pwTTAwTVRvK0s4WGxoWlQ0K2lHV1p4Ykg0Z1FhZzhtRG5WQXJRSXgva2ZX?=
 =?utf-8?B?REhQeEVzVmo0dlE3NHRWT3ZsSTVDcVRWd2tNVFhwMlNGRGZtRkNDcFpaejhV?=
 =?utf-8?B?aFJ6TXUwVGhGSHpnZDF0bWFqdGk2NWs2YU8rWG44YzNoQ0FhNXVNMXplMTZ2?=
 =?utf-8?B?dzhQZnZqM0VTeWF1TE1VQVNVU3RtblhiZGFva1Z1WDdKVCsyRjNaZ2NZazgv?=
 =?utf-8?B?WEdkeWkzQm1YdnEvTlQvbTRtS2MrSHZwWVVlL2FYM0k3NERiNzBuNnJQZG00?=
 =?utf-8?B?c2lwVGNUbVhUODB4S3Vhc3hSU1NYSjRtb25Kd3N3V25rS3gzRldSRXY4RGRL?=
 =?utf-8?B?WWpXRVZTdUVQdnBpK1pyaklpU3dYbkl2VjhLQmZKT1RIanJOS3QwTEh2ZGhO?=
 =?utf-8?B?RDFldDM0elg1amxpTGpxNXlRSWY0d0ZGVlFhZ2wzQjlqZjNSM0dVTTRSYmwz?=
 =?utf-8?B?eG1CZncvTkdUSTArcXBaMkZmaGpuaVZvR1FNMWkyc3VDNS9sZFJRaDQ0Y2dM?=
 =?utf-8?B?OHhEdnMzWGh3NUZZRHNjNlFNbXNaNDRhWHRjNEYxK3NJZ0NyR014d0pvemh6?=
 =?utf-8?B?T1BaejNxb05uWE85MVp6ZkF2d3FacEdKT0ZhWXdUWTdZTGRyQ3NRRmNEMVZV?=
 =?utf-8?B?SFhlYlRZZTJ4Vnk1a3RvRmNNSlEzcXVBcmxBcjVJcmxuSEtZOVhuZHNqY00z?=
 =?utf-8?B?cFhUdEdsZ3BXR1FsT2ZXdFF6MC9MNnMzblRwNlppbm1KWjRvT003OVVvSEo0?=
 =?utf-8?B?T2djNHlnaTVVczRyTFA2TVlKM1NTeXkvbzhGRnZHNWRXaXdlR2tCZkU5akMr?=
 =?utf-8?B?QkhIeGY0T0xJcGJiMVZTb3I3Zk9Dc2QzTXphVTZTVVgyemNXaXhGbU96ZjRj?=
 =?utf-8?B?ZDk3NnNrUk83V0ZERUkwdVYrSmhHMzlqdGxjMU93MEdWQnBJZVZlYXJUOWtC?=
 =?utf-8?B?a3NIVC9qUGN3L2YzOWhMZ0ljTFcrdm5Mamp3N21Zb2ZtSWVVeTl5T1lTY21V?=
 =?utf-8?B?dHc2enNFYXlxVEdHR0Zlbm1FVTBkaXFBNGFyTnhJRkw3ZkxWeVVIdzEvc01V?=
 =?utf-8?B?cFIrR255ekVwWHowZHBFNXgzS3F5ZzErOWcrZVpxaEpHcW1LcFpXeGttMTFZ?=
 =?utf-8?B?clFDaUVLYlNON3BNZFFHZFVtczVOQTF4SEI2RlRpKzl4S001OVlMdFVhZlFY?=
 =?utf-8?B?aHZTUlpTQ2lZVWRXWDhUaUwxU09YL0svckZWd2pSRW02THM3MDFsbWVMUXBX?=
 =?utf-8?B?cFVJMGNFa25ndU80SFRLVzJMNlRNdXRCRnJUYXU5bVNjMkZaeWZlT2Z1Uk1o?=
 =?utf-8?B?MWZPcU1UYjdsMS8rM1JJRk10dWU5K0dVbmlkb0poVWgwbXVuMEwxWkdPK21J?=
 =?utf-8?B?YXp1a1hvVmRDM21YaXN6emNLRUFDZUtLSFhMS0hFVDBUL1lYdVFLMGk3ZFJ0?=
 =?utf-8?B?UzlGaG9Bd1dQZWpsUk5PaDBPZEdMTlQzN2hmdEF2TWJnSkVncE1GZ1M4MHh6?=
 =?utf-8?B?OFZPcFV1YnluWkNqOEYxTmR6VGhXcTVSb0x5VkpPditGcHlQQ0syOFMra21O?=
 =?utf-8?B?NXFjV1l4RHBrK2NmNkd1SlY0TVFtcE1nVlVVK3h0ekFLSTVyUTRta0FkTjZl?=
 =?utf-8?B?Zm1NL2F0THBWVEdwVE5QM0pJcWdRL0sxeEV6NmVJOCtiU1JEMFdWa2xoTzhF?=
 =?utf-8?B?R1JPd3JnMW5JREdtVmhSMXA1NEhESFM2eElMeFgrQUVNb2tJK1paZz09?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4b80e278-86e6-470c-15be-08de4fb5f0cd
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jan 2026 19:33:18.3734
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: snPH5RqwjeZKLkhg9Cbmf8eO+gR43YxA/ds4Pvl/rbMGmOvFskNRJPzFdr5hblF4zIyMGPvKMHmySADi1S39Jg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR10MB9060
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 09 Jan 2026 19:33:32 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/21525

From: Jan Kiszka <jan.kiszka@siemens.com>

This is on by default in U-Boot when building for arm32. We are not
using GRUB (we should never use it), and it started to break the boot of
the BBB with kernel 6.1 and older since we switched to the merged
defconfig. However, disabling it also on the DE-Nano-SoC caused issues
there, thus keep this limited to the BBB.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 recipes-bsp/u-boot/files/no-grub-workaround.cfg | 2 ++
 recipes-bsp/u-boot/u-boot-bbb_2025.07.bb        | 5 +++++
 2 files changed, 7 insertions(+)
 create mode 100644 recipes-bsp/u-boot/files/no-grub-workaround.cfg

diff --git a/recipes-bsp/u-boot/files/no-grub-workaround.cfg b/recipes-bsp/u-boot/files/no-grub-workaround.cfg
new file mode 100644
index 00000000..dc09edd6
--- /dev/null
+++ b/recipes-bsp/u-boot/files/no-grub-workaround.cfg
@@ -0,0 +1,2 @@
+### Disable grub workaround
+# CONFIG_EFI_GRUB_ARM32_WORKAROUND is not set
diff --git a/recipes-bsp/u-boot/u-boot-bbb_2025.07.bb b/recipes-bsp/u-boot/u-boot-bbb_2025.07.bb
index 956aa446..f886d05d 100644
--- a/recipes-bsp/u-boot/u-boot-bbb_2025.07.bb
+++ b/recipes-bsp/u-boot/u-boot-bbb_2025.07.bb
@@ -11,12 +11,17 @@
 
 require u-boot-common-${PV}.inc
 
+SRC_URI += "file://no-grub-workaround.cfg"
+
 COMPATIBLE_MACHINE = "^(bbb)$"
 
 U_BOOT_CONFIG = "am335x_evm_defconfig"
 U_BOOT_BIN = "all"
 
 do_prepare_build:append() {
+    sed -ni '/### Disable grub workaround/q;p' ${S}/configs/${U_BOOT_CONFIG}
+    cat ${WORKDIR}/no-grub-workaround.cfg >> ${S}/configs/${U_BOOT_CONFIG}
+
     echo "MLO u-boot.img /usr/lib/u-boot/${MACHINE}" > \
         ${S}/debian/u-boot-${MACHINE}.install
 }
-- 
2.51.0

