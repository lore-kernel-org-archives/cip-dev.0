Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 446AFCD4F3C
	for <webhook@archiver.kernel.org>; Mon, 18 May 2026 11:41:00 +0000 (UTC)
Received: from PA4PR04CU001.outbound.protection.outlook.com (PA4PR04CU001.outbound.protection.outlook.com [40.107.162.28])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.6469.1779104458614811289
 for <cip-dev@lists.cip-project.org>;
 Mon, 18 May 2026 04:40:59 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=wRhBRr73;
 spf=pass (domain: siemens.com, ip: 40.107.162.28, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hwqqq/6D+Qba/sJO/TYttMcMVp5wrjCREH7AAkLtPyfiWcYdKMyq1xkb8Kdmh60ZjZeZRprP44N/jokZk1Bhrl2B0BDm0cMBU7qkzTc+rKxSjxlz63w6973Hka9MKtKVPIQPiFLNMjqApZI3z8FTA2iEMQkZDgA1ayJegZNp4c8ycuZV63NmSUO25UCNR+JJAcgqXrBALCmra1LRTeVQLIpIDwROdQLO8/eL5iZuCYx/pvtnkTRY0NxgqYB98VhyaoCRzjH+AZ5T1G7D4+bqz1Y7p7rf3fKcrYgk72gf4W8R7NbDXspuNaxW1i/yOCM1BXutJYdJ7HOlchSEu3oRqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LjouD2+aRZ7tHHNUXB1SRZptdIAcbnINBBE5Va2yUk0=;
 b=GxcqH8kB4EaQ9GcBe7dATCHkTJ85x/V6XL0F9OflzkM7CEa1pJxTD1uX9uYwmYk4zmVxRnsi6QNzd3i7vzHFnustZzTs+Ru0rB47HK2ij7BMyhpFr4yMj/3G9sgJKUkG+PntHzLLa/BsPrWflEnmybpIreD93LCQzRQi4/G8PmepJo5Wk3HnN3nk7lwp35SuFuu6GjXIWHkzhwJMHB2yt/r11J7fzcWbRE28Bj6CszHTMM3p/CUksZ8JC5wJcyW1AjoOfDtRvDjSnbxXWa36bkvJgqamOJJwIMnUszPmhanGd3a7f5moucAwbEN7rN0y1mE0fXzhsudgtlKOrMajJQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LjouD2+aRZ7tHHNUXB1SRZptdIAcbnINBBE5Va2yUk0=;
 b=wRhBRr73UwAhtT4MU5UWxvDX7YPs5C0xI1yoPTX0rykziloVE+G0kJ2kjzEhQYauejNW28h7L5MDxhYscW1U1VhAwxuW42xWlFLBj0cFPbJj685vsXn0qRL344yx1IHwDCGxw8p+Cvxq29tpolEsXa8+mMg1wesXYpNFqzYFQu4sv5TLA6zta82HxMZblDE6zjp1edX5JbvkmHj47C43PGFpmF032LQWZtN4uKpZAY/SLtUv4UQWzk7/W0Xtr5Xc0udFJ0keJhUEVUKlhViPMqeP22m7Pf6FEWnkjcAbhinJFV/waFPeSzYPJkEDqPpYhEvsb/3Mtl0nH4slwPBWWg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by DB9PR10MB9888.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:614::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.25.23; Mon, 18 May
 2026 11:40:54 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1%3]) with mapi id 15.21.0025.022; Mon, 18 May 2026
 11:40:54 +0000
Message-ID: <d39a6a25-85c4-46e3-9708-9c299760abcc@siemens.com>
Date: Mon, 18 May 2026 13:40:40 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [isar-cip-core][PATCH v2] linux-cip: Update to 5.10.256-cip73,
 6.1.173-cip56, 6.12.88-cip23, 4.19.325-cip130-rt47
To: Gourav Singh <gouravsingh@siemens.com>, cip-dev@lists.cip-project.org
References: <20260518103226.1527605-1-gouravsingh@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <20260518103226.1527605-1-gouravsingh@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: ZR0P278CA0134.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:40::13) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|DB9PR10MB9888:EE_
X-MS-Office365-Filtering-Correlation-Id: 987be6da-9597-41b3-6145-08deb4d2520b
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|1800799024|366016|376014|55112099003|56012099003|22082099003|18002099003|11063799003;
X-Microsoft-Antispam-Message-Info: 
	sQVOmKJVETFYfCjux8AEzRrUAkD+xLu/IZf540OmilVfsC1bNuhgxR5+J9X+rvNRsLALPHql4kwe2Xqt6wdufRCdMBGsIDepI61V+L+Ou13y6kglhfwPXvw9DWvfCyvheK5SD6LCEpouxW74SzkKPy9+5R54F+nda1oAFaTzZkbW8/3uc0c8jSEDC0He8eRhWGyBF88k1BrFCsSpm+fPYthoMC0WKroUNaT+JFc37yZnUDmRyafp+ONkIhySDoWLXNOzqFSbsrFQBv1rvc54y3zQDb8gLpng3N9o5tkaLFCflcRikDiB/u83rFcIetuDOWa/Gm1iQb0eqZsUXmWwKhk/1LEqHgIhvU7OUIilDVvtLQ8pyJ8jxLJ0wKxf4ngyTS02skFzbNKaDlgHoSHUkuf06xhDsHTsfpkGhXL1oLSFMsqRAUZBxgTP5RkwmXrxEcl5qrtvDJ+kcoALneSIJYOmg8zgKMJS6PQILkEkbFlbmuwnnQu2F+pRycp4KKvj9By+1lkVkI2QazTzdieS8xilM1EOnMCgZnAZcY2Rpl1Y1ukjwYswNnuiq6ItQbRBoiUGMiTQOLcX3KUb3l9Guh5BciEC5xqVEb61zyI8uRa5nCQPiC+22JeubyoK25qo5K4ZuQ6jfo003iNDm5X/WYkyTZpeuVl3edUORNcrbRZMT12kpVAtmN2KMk59k63x
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(55112099003)(56012099003)(22082099003)(18002099003)(11063799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?ekphaTdld1RyZ0Fid2tVdk9tTjNYYVgyY3JMN2V3U0tCYlEvaEo4YmxZR1U3?=
 =?utf-8?B?TmxwNEJDMW5ueGJoS1ByY3BtTG1mWDNlQUhGLzI1YkMvL3dvSzd1NnFlUVB4?=
 =?utf-8?B?QStkbmRHbE5YLzNKdVpIOWRVZEdtOUNHSjc3d25RcHFBUFN0NEVLOE9DamhP?=
 =?utf-8?B?OWxXWktvTTV4L004Uk1ZRkczWWFSZjNyZEpCUndzWTgrM2FMbUpoTlV0UmpT?=
 =?utf-8?B?OFFOMGhFRDJDdHNkdHBGRGtjdElNMGxuMjQ0cWdTQnJuSEdxdTVKaVNxK1J2?=
 =?utf-8?B?UjM4aGY2a21CZ2kvb1djdnJRM3oySHpKb2V6MUhHTldyczVVcXZONS8rRmds?=
 =?utf-8?B?aWxzc3EraXRKZGk0MUx5Y2drK2hiUGRMTXhuWmVKS1RxbTNTZTNoZVhFYy9W?=
 =?utf-8?B?TVhCN0VTalVWRzBZZXJtSnJsOUQwZ2NCd2UxRkl3dUxjcW5VZ2RtVCtzUXlr?=
 =?utf-8?B?eUhzUlpqUlA0bFVxOFpyOEMrTzVYTzNnZmNoVnhxRVkrdGltUjhwQU9vMU85?=
 =?utf-8?B?bWNud1lObitNUG5wMG9LZWtnMEFHQk03UzFFa05nMFJyTDNYVzVUS0M2c3Aw?=
 =?utf-8?B?RFRnb1M1YlE1NzZLVk1BSXVaSFlDQnNEVFJnTVdSc2grTmhmUUZYYWtRdzZu?=
 =?utf-8?B?ekd6blNpQWZsK3BYN0U1OWh4OVphREwrYVJ6Umx4SHFaRTlCaitKcm96K3FC?=
 =?utf-8?B?WnliQlZyTzlLUFBaRHhjM3psamZSZkdoN3VHV0sxaHFUK2FBdG9SYWt1Mk1Q?=
 =?utf-8?B?eGs0L0hZQzVyck4wV1U0YjZrNnM4Snk2ck5wYWdxSnAwV28zUFhEdWZsam5j?=
 =?utf-8?B?S005alhHUy82bU9oNmVhc3pJcUxkU3dBZGVHTEFtNkNuVXIrdHJpb3JaQ1B4?=
 =?utf-8?B?SGljcUNiWjBacWNFRzBjNEU0NUVHclo4NGJCVE1QQXcvaGxIeW1sRlhRaTNa?=
 =?utf-8?B?dUQ5Tkh6a2RsemxGT1ltQ0NTNUtmRWpyQVp4SGpTYThuUjFTb1lhcmk2djcv?=
 =?utf-8?B?TG9GaExac01mUDQyVVhPeDRGRHl1dzdPUUwwemUvS2VIMDYzdVVKeEo2aTd5?=
 =?utf-8?B?cktwb0ZySHlVeDRwZGlrTHNHU0RyQTNtb2tzdGtMRks0MFZvcUlKZS9GQ2ZH?=
 =?utf-8?B?dFd6eldaWUxUaHdQWis2MUxXbXB6a25rTDh6dlpLdHJESWRvcXhzVmJmNmtU?=
 =?utf-8?B?OTFJSmRmZzVSMkdtR3IvQ3poM0hZTTlWZjFhZzhqRzFrY2lvdkdZdy9GaXdy?=
 =?utf-8?B?eGVxUU5ISk9RYUgxbUR1V0g5bWdlRldFRDlUbkw0MEpNc3E0VExlYm9NTWxZ?=
 =?utf-8?B?aE4yOFFwMGJ3TGpkZ2lpMnhSbC9MTkN0Q3dHby94RFA3dEJTMGZmQkpRRUtj?=
 =?utf-8?B?N2JPUW54RGcrR0MvQzFHaVpzZENnMUR3Ylp1Mlcrcys3cFhGSkFKQ3NrV0tB?=
 =?utf-8?B?WVQ4Tng1Rm9hMVE5Rk1MYTNxMGFRT0NLSVN1MkhOc0pqbmlwWm85eUdpYnVL?=
 =?utf-8?B?cTNPUHVyUzdRNHVGRCtkZFVPeEFMUlJKdlZvR1FUQjdiNC9ZUjIxTHAyZ25G?=
 =?utf-8?B?eDNUbE1yWERDZll3SkpDeldhWTU5ZEpuM2NqRzk0VDJsa2J1eWJQTGlRQmRR?=
 =?utf-8?B?YjFuWnNRUEZ1WmxrUjlKa0luLzhBdzVEd21YUWtSdmJEZ3k1czIzRFR0OWRZ?=
 =?utf-8?B?cTNlb2ZzSERRUFQ3aVJNTGxVU0MweVhTbmVyc2lBVnprMFBVaEs5NXdtaXo4?=
 =?utf-8?B?UHdJUzlEcG50RFdBQ2VYeHRHVTlHVjNhNlJJOCthVWZPL1dleGdybVYyUzN3?=
 =?utf-8?B?VGlxZ21TTXV1L29zd3dOMGhhTzhjSnZJWTFhY3JzV3pneVM0K2R6UmtiYk1z?=
 =?utf-8?B?UC9Jam1BUWd1bWxXcWZDUTBzbGdCVUdsTnltUWRQRjFxcGpZNUdvUU85aHl3?=
 =?utf-8?B?M1dGemdrc2NPRm5mSDdsS0ZveWw3Q2c2RDk0NHA5THlyUllmTTU4Y2JGd3Jh?=
 =?utf-8?B?d1pwbm9WT2pTakpIdHdzMVc0SUVDOTdQOXo1QzFMOWFJOTYvWDFyRlYyWEd6?=
 =?utf-8?B?bXg5Mk4wbmY5NzBIZGg5cm56NGpoUGJLOVNndGl0S0l0emoxUThGT1krWmkx?=
 =?utf-8?B?LzZYMDhSYmp2cmw2eEVQZ1c5S3l0VVFDMjBSTzFlWFBjUjBVVEdaQlpCdnVz?=
 =?utf-8?B?VUlXVjUwQVNzRG9UTXhIdEpjZzlzR250Nmp1YnUrZGkrS1dOa3lRMTVBWkRu?=
 =?utf-8?B?dHdENUtHcC84bTA4ay9iQmhHVEtkRnZGYVVGcHh4NStmU1VqNzNOTlI2TmlM?=
 =?utf-8?B?ampVRG5sam9Za1pDRlI4LzZjczYvMnBDM0ZqemROZVZCNU1yb0U4dz09?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 987be6da-9597-41b3-6145-08deb4d2520b
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 May 2026 11:40:54.6971
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: u94piye3AVkb8PA0hY2D8bgPs22TmQ/oFZ9VxPTOn12Ij1gtQmqe1IbjcA+4zOo+jMThU8lkzCtrstypfLAWOg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR10MB9888
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 18 May 2026 11:41:00 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/22975

On 18.05.26 12:32, Gourav Singh wrote:
> Signed-off-by: Gourav Singh <gouravsingh@siemens.com>
> ---
>  ...25-cip130-rt47.bb => linux-cip-rt_4.19.325-cip132-rt48.bb} | 4 ++--
>  recipes-kernel/linux/linux-cip-rt_6.12.85-cip22.bb            | 1 -
>  recipes-kernel/linux/linux-cip-rt_6.12.88-cip23.bb            | 1 +
>  ...inux-cip_5.10.254-cip72.bb => linux-cip_5.10.256-cip73.bb} | 4 ++--
>  ...{linux-cip_6.12.85-cip22.bb => linux-cip_6.1.173-cip56.bb} | 2 +-
>  ...{linux-cip_6.1.170-cip55.bb => linux-cip_6.12.88-cip23.bb} | 2 +-
>  6 files changed, 7 insertions(+), 7 deletions(-)
>  rename recipes-kernel/linux/{linux-cip-rt_4.19.325-cip130-rt47.bb => linux-cip-rt_4.19.325-cip132-rt48.bb} (54%)
>  delete mode 120000 recipes-kernel/linux/linux-cip-rt_6.12.85-cip22.bb
>  create mode 120000 recipes-kernel/linux/linux-cip-rt_6.12.88-cip23.bb
>  rename recipes-kernel/linux/{linux-cip_5.10.254-cip72.bb => linux-cip_5.10.256-cip73.bb} (54%)
>  rename recipes-kernel/linux/{linux-cip_6.12.85-cip22.bb => linux-cip_6.1.173-cip56.bb} (59%)
>  rename recipes-kernel/linux/{linux-cip_6.1.170-cip55.bb => linux-cip_6.12.88-cip23.bb} (59%)
> 
> diff --git a/recipes-kernel/linux/linux-cip-rt_4.19.325-cip130-rt47.bb b/recipes-kernel/linux/linux-cip-rt_4.19.325-cip132-rt48.bb
> similarity index 54%
> rename from recipes-kernel/linux/linux-cip-rt_4.19.325-cip130-rt47.bb
> rename to recipes-kernel/linux/linux-cip-rt_4.19.325-cip132-rt48.bb
> index 4ab07e3..59489cf 100644
> --- a/recipes-kernel/linux/linux-cip-rt_4.19.325-cip130-rt47.bb
> +++ b/recipes-kernel/linux/linux-cip-rt_4.19.325-cip132-rt48.bb
> @@ -1,7 +1,7 @@
>  #
>  # CIP Core, generic profile
>  #
> -# Copyright (c) Siemens AG, 2019-2025
> +# Copyright (c) Siemens AG, 2019-2026
>  #
>  # Authors:
>  #  Jan Kiszka <jan.kiszka@siemens.com>
> @@ -11,4 +11,4 @@
> 
>  require linux-cip-release.inc
> 
> -SRC_URI[sha256sum] = "15950e3c757037ceaf02d19f64519618fa7f1119905e6f975f7ae3658c1d5b6e"
> +SRC_URI[sha256sum] = "65230ec52117a1896b2ec285cfca7ecc0cdf09441613e23cd7dea590d92e0859"
> diff --git a/recipes-kernel/linux/linux-cip-rt_6.12.85-cip22.bb b/recipes-kernel/linux/linux-cip-rt_6.12.85-cip22.bb
> deleted file mode 120000
> index ed5ab00..0000000
> --- a/recipes-kernel/linux/linux-cip-rt_6.12.85-cip22.bb
> +++ /dev/null
> @@ -1 +0,0 @@
> -linux-cip_6.12.85-cip22.bb
> \ No newline at end of file
> diff --git a/recipes-kernel/linux/linux-cip-rt_6.12.88-cip23.bb b/recipes-kernel/linux/linux-cip-rt_6.12.88-cip23.bb
> new file mode 120000
> index 0000000..306c2a9
> --- /dev/null
> +++ b/recipes-kernel/linux/linux-cip-rt_6.12.88-cip23.bb
> @@ -0,0 +1 @@
> +linux-cip_6.12.88-cip23.bb
> \ No newline at end of file
> diff --git a/recipes-kernel/linux/linux-cip_5.10.254-cip72.bb b/recipes-kernel/linux/linux-cip_5.10.256-cip73.bb
> similarity index 54%
> rename from recipes-kernel/linux/linux-cip_5.10.254-cip72.bb
> rename to recipes-kernel/linux/linux-cip_5.10.256-cip73.bb
> index b4beedc..4d2fec6 100644
> --- a/recipes-kernel/linux/linux-cip_5.10.254-cip72.bb
> +++ b/recipes-kernel/linux/linux-cip_5.10.256-cip73.bb
> @@ -1,7 +1,7 @@
>  #
>  # CIP Core, generic profile
>  #
> -# Copyright (c) Siemens AG, 2021-2023
> +# Copyright (c) Siemens AG, 2026
>  #
>  # Authors:
>  #  Jan Kiszka <jan.kiszka@siemens.com>
> @@ -11,4 +11,4 @@
> 
>  require linux-cip-release.inc
> 
> -SRC_URI[sha256sum] = "59e32e7cedd32bfc3a42e673898384f23931219911e4ca6a4215a375393944e6"
> +SRC_URI[sha256sum] = "b911f12ba8975ab4c114713c03275662457190fd9709148a4ad735705019e7f8"
> diff --git a/recipes-kernel/linux/linux-cip_6.12.85-cip22.bb b/recipes-kernel/linux/linux-cip_6.1.173-cip56.bb
> similarity index 59%
> rename from recipes-kernel/linux/linux-cip_6.12.85-cip22.bb
> rename to recipes-kernel/linux/linux-cip_6.1.173-cip56.bb
> index fecdba2..1138c23 100644
> --- a/recipes-kernel/linux/linux-cip_6.12.85-cip22.bb
> +++ b/recipes-kernel/linux/linux-cip_6.1.173-cip56.bb
> @@ -7,4 +7,4 @@
> 
>  require linux-cip-release.inc
> 
> -SRC_URI[sha256sum] = "b99c97c032e3516475e90853a3075274cdc64000699fb5425fcff39c3b998b93"
> +SRC_URI[sha256sum] = "0332d054d7ab7f74506184d1616ac9dd9d77ef2f33c3de1f7128466ec0d8d933"
> diff --git a/recipes-kernel/linux/linux-cip_6.1.170-cip55.bb b/recipes-kernel/linux/linux-cip_6.12.88-cip23.bb
> similarity index 59%
> rename from recipes-kernel/linux/linux-cip_6.1.170-cip55.bb
> rename to recipes-kernel/linux/linux-cip_6.12.88-cip23.bb
> index a339926..f61cbf9 100644
> --- a/recipes-kernel/linux/linux-cip_6.1.170-cip55.bb
> +++ b/recipes-kernel/linux/linux-cip_6.12.88-cip23.bb
> @@ -7,4 +7,4 @@
> 
>  require linux-cip-release.inc
> 
> -SRC_URI[sha256sum] = "2b0b200234b03aea3ed77de553935512ad42b25ee260e00745b0729ed892cf63"
> +SRC_URI[sha256sum] = "c7044d8f5135c80bb32c5f194a940b1bdf8904cd80eea1aee90588be0e12d59d"
> --
> 2.39.5
> 

Thanks, applied (with copyright year adjustment in the end).

Jan

-- 
Siemens AG, Foundational Technologies
Linux Expert Center

