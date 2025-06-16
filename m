Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F47FC71155
	for <webhook@archiver.kernel.org>; Mon, 16 Jun 2025 11:58:15 +0000 (UTC)
Received: from AS8PR04CU009.outbound.protection.outlook.com (AS8PR04CU009.outbound.protection.outlook.com [52.101.70.11])
 by mx.groups.io with SMTP id smtpd.web11.28656.1750075094536375693
 for <cip-dev@lists.cip-project.org>;
 Mon, 16 Jun 2025 04:58:14 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=wN0V8AKV;
 spf=pass (domain: siemens.com, ip: 52.101.70.11, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RT4dGZ8oE7JGLoXVNxcC7tJkbvwuS14U6EPiaAFBSd+G8cdhfIZF2KiohRSXfd+FZUzuNarQSS7cy36diMY0ivJUBzgq4DNqNzYm5R3PNVlycCgDz01aMMJLVFGo9I0r1MjNy4nLBZOqtjjpo0uMH5gKnwNcNsI5LbNvbwnpUf/2yfcZAiXTuCD8/M5raT5keQZOC/12DkGhOd+KpcfqrBpqce5vtS0S84XPcQN8kHQKK0J592P/Bkxgy0598umHNnbSZEkZPm8s3g9XHRZ/xTKd7gBTg8N+vBtopJ47gBQoyJ2lmWsmhfyEJH22BwHTiyYQw4vzgcClvupppVv8bA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ijkQf34PHEEqXwb/Yy/JcUQTS5GnT5jfEyHnwjMjCKE=;
 b=BOfKOOKsE0stgH+Xk4icfNdNakm5nmtne4YQTEPZteNcCLR115/Xyax0cHhtOK/TeXj5viSrBAK1Aejenk/9JV5y5LyiZlbCKEgZwheXNMP3Hw2UdEHkBkrMkpyB8tUednSaTrPGrpOC9OACGNRtjmNYeZVR443p24gI0rMqioaShPc20Zb6gyq+7EFY/u5yGZh+RR85xkFj2IdAAylDIIWG5s2HBG7bZO3liVJn2JCH4x0/xJNnYypOGwhwW82Pd8V75XkPghYg0dlk6+CojVMNjWO5H3xNh1IioXiqxiH+gPCf6ESZWMyC/o62U6vEWrjNSfKyBLDVmMxiOyxOuQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ijkQf34PHEEqXwb/Yy/JcUQTS5GnT5jfEyHnwjMjCKE=;
 b=wN0V8AKVE4g78ke0YefqDBrR2MfKu+oN3XhR0nO1OyfO5oy47IHS+7d69HzYaDezD8CNoNjfNKuKMB/L+B7OnN59M/bxdUfJQzGVfeYv6pt2aEajemja4hludbnPAPtUmA6sk4B/By66vSyx4GMCFWgzT4fNk1nbzXPmn8rgJ+8nRk/wepAQ8kGVoSvHMPhtvt8a3dz3MFFn/BIq/Qe0bCFix6LXa0Dg+6tbpRd9byyHcwcpmkwHzBfk7AmpBlrZC64scXB4NdIinl+1ITkJ+sTQ7UanOFjpUjKu12H8OWKWUxSE6dMU1VHm1M6gFmaZla+adbTg0DRQrLrf2PPuXQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by AS8PR10MB7066.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:5a9::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.23; Mon, 16 Jun
 2025 11:58:10 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%5]) with mapi id 15.20.8835.027; Mon, 16 Jun 2025
 11:58:10 +0000
Message-ID: <fa874401-2923-4265-899d-15faf686ee50@siemens.com>
Date: Mon, 16 Jun 2025 13:58:08 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 0/4] initramfs-crypt-hook patch
Content-Language: en-US
From: Jan Kiszka <jan.kiszka@siemens.com>
To: Claudius Heine <ch@denx.de>, cip-dev@lists.cip-project.org
Cc: Quirin Gylstorff <quirin.gylstorff@siemens.com>,
 Alexander <alexander.heinisch@siemens.com>
References: <20250320-initramfs-crypt-hook-patches-2-v6-0-ef10c11cad94@denx.de>
 <201dcdc7-c272-4201-8180-ced6c0073c82@siemens.com>
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <201dcdc7-c272-4201-8180-ced6c0073c82@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0005.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:c8::13) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|AS8PR10MB7066:EE_
X-MS-Office365-Filtering-Correlation-Id: fa9f6241-9738-4f96-8ac2-08ddaccd1090
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?aDVpM1dTOUhGYXUyTWdlSE5FN2VSdzhvb0JlTFg5am1WVmt6dTVtalM2bzZn?=
 =?utf-8?B?U1Fpd1JQMmFkMmVVSG05cktwOEc3ZDg0VVY2a0Rzczd1TElRTkhta0xpVU4w?=
 =?utf-8?B?ZlFqYzJJZ3ZGWEloMVkwOFZPckZTeS9QWjhjWG80VDRERUlkZE1teGZvR2Fj?=
 =?utf-8?B?ZHZnbUpJZGVBWk5BWlQ5MS9NQjIwSC9BWGFISi8wSThzQ0Y1YXVXMmUvQU04?=
 =?utf-8?B?bmk1Z04zd3Fxak1hY2NnUGFGd2FBcDRIZFZ1c3habG5VdlNyTDFHT01EWmJY?=
 =?utf-8?B?UEhnSlIxaWQwSUU0V0tXbVhFVTN6MlloUWdQdE45VEkvaTZOZkt3Q1ArUDdj?=
 =?utf-8?B?amhodnlJVXVLU0NVdXovRjVISkdyd3FIa2R5M0hpMGgwMUFvWGNJd3QzSXB4?=
 =?utf-8?B?RXNEaExzY2JRSVlxYi91VXlmcFRldHkwM1hnUTRiYkFRdDhtRCtkbk9vakJQ?=
 =?utf-8?B?aGpVOVRWZlZ2RERieUM1THNZL2F2S0xFb2swTEVIenlzbjNPb3JQV054Qytj?=
 =?utf-8?B?QTBqMzVMR3NLUGRRRUc0dTh5TWNISW1CM0NOZWw0L2tUa3dla0huYXpPVmxG?=
 =?utf-8?B?MlZISFUwTEd1ZnFxTXU3VDNPZmVhcE1yaWJ6WUdEMTB3TFVlcUZuMEg0cUNt?=
 =?utf-8?B?bSsrZjVIb042VmsvL3RTbERqN2dLZGRVQ3RDV2k3Tmx2cmt1T1NBckFoeG1i?=
 =?utf-8?B?cEFjaVNYV2t6eDY3UWZPOGtmeWtNUThabENFQmF4bStJbmhLWW5LVXRoZXhH?=
 =?utf-8?B?a0szaG5CQ2dtcXovTE43OW44NnRxdlVnL0dSbkxEWVpRTnRtQXZuRi94U0cx?=
 =?utf-8?B?T0lwNURrb2JTOE1YaEFXaU5HT0phbjZUQmM2SUprK3E5em1CNnMzWU1JUFc0?=
 =?utf-8?B?ektxTmN5TkdIUWZoNTNuT0c2VDNRZE42RTN3cFZZRjlKMDBGY0hLOVQxeXJ0?=
 =?utf-8?B?S2JXZEJyWWxtR280elBFTm54MjZLcURCNEhyWXdTWkxXcXU2MFNGTFR3ZENs?=
 =?utf-8?B?ZGV2Tzl6eis2aDhUTlk3NklxTW04NDdObWwwUSt5dk5uZk50ZnN0U3pDMWpj?=
 =?utf-8?B?b1d2U1czdmg1QTZxbGUwa1MzZ0JaWGJaOEMvQlhuTTFTNVFRNnlMaTk2R1BW?=
 =?utf-8?B?c2duQWdmRDZWVVEvUkJudklmRC9XMjF6WktibGlOVmUxNno0WFUreEsvMVp4?=
 =?utf-8?B?ZWRkQnQza011bmZNZ2FQV1NjcmlXc1lqVTlWeVIyZXE1d3ZJc1VpVmZhRCtK?=
 =?utf-8?B?dnlpY1ppdjVYV05pT3hjTXdQMjI2alBhbmFNc3NBd21pYWV3RGtoaHRzRVBt?=
 =?utf-8?B?akNWQnhYS1JMVGhHcWlJeUljQUQzbkNHUVdkeWtCR2NpNVRxcXpoZlA1Mm52?=
 =?utf-8?B?d0RyMUd2MXI2dVA5L0xBZHJoV0JJU0MrcFRzb2w1K29pVlBNc0xsYTlSbURT?=
 =?utf-8?B?YWJ3OVM2UXFObnZISmRodk8xdG5zbWt2WW5pZ0d5YnNTTmdxRHpWQzB6U1pn?=
 =?utf-8?B?bkR5OFpzV21VKzUxMC83SmZ5KzgrNjA5cENic2cyRVAxeFFMQm5OVDc0WFUv?=
 =?utf-8?B?c09ZL2tXaGNldmxONWx4QWYxcDk2QWNJYkNRWU1MemlYQlBWQWZES09sd2x5?=
 =?utf-8?B?STlzUXBIditWNzE1VDM5WGdLVCtjN3RIUytUcXN2aUFSdTdtWjRRdjBBVEVm?=
 =?utf-8?B?bWVsUm5pZ05NRHg5WURNL1Y0blBwbWJCQzVQZ0JjTDcxWFN1d3FDS0x1emRR?=
 =?utf-8?B?VG1RcFIwMmd2M0pDOW1yZjJBVWNtd1dwSzdoMStkS3ozeFZSSlRWT1k3Rld6?=
 =?utf-8?B?dWVLU1JIVjIyWXNRbEVHeGtrdS9Eb1R1SGZNa0tvc1dNREs3c2R0NkRtQlZZ?=
 =?utf-8?B?Y2pZYmZwRTYrYUZuSmpCaTVBQTR5QlR2UUVtbVN0Tkw2eTBZdjk5Tlk1UXhr?=
 =?utf-8?Q?m/B2h4gP+fI=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?WGdMdm1qb2hWaytSSGg0SkFqbmZlNUxGWHVYcFh1djR5K3FqK0xhbDBjY2Rl?=
 =?utf-8?B?NmlOTnJPb2pQdm0wMXY0ZXVBeGhCSitMTTdpMFNvU2Y4UnpsYkttMjNRMVVL?=
 =?utf-8?B?cXdIRGpYMkpUM29pK2NoNmpwL3RlRk1zOWZVeldnOGJTVEgrNHBxVmtjbXJM?=
 =?utf-8?B?YzRzT2c3M0xvdC91QWYyMTFYYmRlMDIwUGRjSDFFZk5sT1VxcnkyNjhkUmZa?=
 =?utf-8?B?bEYzNGZrTmZWN1lkYVFId3pxNThxK210TzJzazk2UGlWWEVkNlA5TVlLMzlK?=
 =?utf-8?B?UGxWcDQzMzYwUldMSjMrclY4eUp2Q3lUb25CMmNIRVd1UWcwN0RGTys4NXQ5?=
 =?utf-8?B?NS9BbTkwVVY2YWQwblZaZnBFZ0ppVEFNUno0Q3FmUUVTSkQrSE8wWENiNjd6?=
 =?utf-8?B?SW9YZDg2aGZLMHhYUnp4OFQ4V2RBdXg1NnFqeVFGdTZvR3cwb0FoMHhDRExN?=
 =?utf-8?B?ZUo4eEcxUXJkNUtZTHlYb3dhUllvTjE1ZEdsZTdmNzQ4cXg4cVltOTBuQ085?=
 =?utf-8?B?Mm9ndjJQUUZGTGcyaUlpMkdxUVozanNHWks4T1FZOVc3T1FYWi9xWFZETzJK?=
 =?utf-8?B?VjZTSmI4RjUvYlBERWExWHBoTG9BVy8wdXJ1M1ZSLzlhS1JFYmFzRkdIbzN6?=
 =?utf-8?B?N3o2eUZqaG1WREJLUEE0VlZnUnFjSVdhWFk3OWhwbGp1Z3dQL2dzditYM0V5?=
 =?utf-8?B?UXhCdlk4UEZrcFlTQllKbXJhNjFoOFpDMWU1YUNpYW5JRi9Fa21DTWFTWXhQ?=
 =?utf-8?B?aXRjUE1HWTgxTjBaK09SaG5DTUQ5OHY3Mjc5dUVsZzNFMWszMmlqTDVoUHRk?=
 =?utf-8?B?VSs5MGk0VGFRaXcrNDQ3R3pwTlVYdzBnM2JIenR1Z1IwSU8veWF6WUU4Nk5Z?=
 =?utf-8?B?MjRFWGc1Z00rTksralFjZ3JZRGFUemhHaHhCWkMzQlltNk9lZlNCbjV6bGtI?=
 =?utf-8?B?YzZZODNpVDJxc0xuNi81blNDMk5aVjg3ZzB3Y1Y5dkozeEhmazArclpIWFYx?=
 =?utf-8?B?bjdIT3d1eCtmcHNCYnkxbjVVbXlqbnZPWXI0citRTnJtcWY3akxBaEIzRkE3?=
 =?utf-8?B?RHRQQXVIQzFiUERNbndMMnoxczd3RDhiR1ZHcm92d0l3Z0xnRTJiZ05KWUFr?=
 =?utf-8?B?c1hQby9ocERrRHNzUkk5c0tLbUR3OG1DUHZlSTh4ZGoreUE4eWRNcEV4MWxD?=
 =?utf-8?B?QnFuQ3lIUGg2NmtxcUxUaWR6ZkJ5OEc5YTZlbDFPL0h1ZTZrQnJOdU9KVWdm?=
 =?utf-8?B?cC9PRWZwcGFHbFJ1TWEyNTJyRGdDOC82S3RxQ2g0ZENPRU5zOWo4SjJkV1BJ?=
 =?utf-8?B?Y3ZjUlp4UElRVEZNbURleGQzT0p2Y2xEWUwxbGUyaDcvZ2J3VTA1d01ST2ZD?=
 =?utf-8?B?YmhKYzB0SnpPZnZ1ZEZTMzlqWUM1ZnZjcGhKMHlmNWR3UlRIcmQ3cU9IcW9n?=
 =?utf-8?B?ZVpQWG5tM0h3cEZvVEFzZVV4dUg5NE9ZMUpFZTJWV2tTYUEzNzBTYk12UkhG?=
 =?utf-8?B?VUEzK1BZOVl4Z1lVSmR0Qkd4ZWlxT1R0V2VHeUx2Q2NYZXdFUVpOVDUxeVdU?=
 =?utf-8?B?RFZVRkp0TllHNGNCOGNKbktldFgzN3R6OFc3MTBUc3ZjYkVKTWJNVG1xL1dQ?=
 =?utf-8?B?WStJR09tdlRqSldwQ0VwaGY1ODY4NFFQSUlJRDIydG41bmlvRlBkaDVEaWJ2?=
 =?utf-8?B?NERqTkorV1FHTWFCVFlpYXBCUVBMWXJyN3VYWmE3UEl5TmtlQ0lIczZ2RUh1?=
 =?utf-8?B?N2pTbzZhclp6REN3UitUS3ZxQWRkbktHKytjcDBGZ0ZjUG1MajBHRmNzRGpO?=
 =?utf-8?B?Sm84Z3NRVHVhNlZEUFBsSXphbC91OU9vdlIzMW5xQ1lQWXhkcG16N3R0NWxW?=
 =?utf-8?B?RkFsYWlQVVl2WkNnWSt6ZTExM0V2TFNmQ0MwdkNacEp1UWFGSDFsbXVlTnYy?=
 =?utf-8?B?OWJKTUZYcC9LK3JOaEdVbHVYWXVUaXZGRzBhQnNLWmlBMVNMT1FENkljdmpH?=
 =?utf-8?B?dk4zUldSZTRQWUtsU2NLTkZBRUJQZTJOdW9IWG82TU9MdmhvRnlQRWlwbmti?=
 =?utf-8?B?ZGRjS0ZUVTBLc0RBOFZiVkxhZXhWN2N1dmNuV1JHTk92MUZxTFN1dlFmZllT?=
 =?utf-8?B?ck55VEVKajhWNWxEcHh6OXVOeFNVK0t2SEJEYkcyd0kwNkFFT0xrZ1dkUVhm?=
 =?utf-8?B?b0E9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fa9f6241-9738-4f96-8ac2-08ddaccd1090
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jun 2025 11:58:10.4784
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: E61Ln64sZbV4Et9mDBEi7MPhf1BybJW9P0EoxgN9TPB4BalxDZ8EBkVlH3Zh8vH7LTy88ivwf4b0PemwMhY6cQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR10MB7066
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 16 Jun 2025 11:58:15 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/19108

On 16.06.25 13:11, Jan Kiszka wrote:
> On 20.03.25 08:43, Claudius Heine wrote:
>> Hi,
>>
>> here is v6 of my patchset.
>>
>> I fixed the issue I found in the last patchset, now the `format-if-empty` process is a bit more power-fail save.
>>
>> But I suppose that if the luks header could not be written fully, and the `luks` fs type is not detected, it might still cause issues, but I am not sure I can prevent that effectively.
>>
> 
> Did you document that potential catch in README.tpm2.encryption.md?
> Didn't spot it yet.
> 
> Please also bump the recipe version after your update (likely in the
> last patch).
> 
> And please rebase on top of next - I just merged the tpm2_shutdown fix.
> 

Err, I commented on v6 but meant v7. Comments still apply there.

Jan

-- 
Siemens AG, Foundational Technologies
Linux Expert Center

