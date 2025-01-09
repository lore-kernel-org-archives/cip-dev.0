Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9807CE77197
	for <webhook@archiver.kernel.org>; Thu,  9 Jan 2025 15:27:09 +0000 (UTC)
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (EUR05-DB8-obe.outbound.protection.outlook.com [40.107.20.55])
 by mx.groups.io with SMTP id smtpd.web11.51246.1736436426493334298
 for <cip-dev@lists.cip-project.org>;
 Thu, 09 Jan 2025 07:27:06 -0800
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@siemens.com header.s=selector2 header.b=IJwYTotu;
 spf=pass (domain: siemens.com, ip: 40.107.20.55, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=s7vHH0be//On5m9duz7ECuSsFcykn+n49iyW6jq3y2wmhJIUZbuVfoQngnDptaQeFEn+gZn4xdH2u1vkQB4+Ff3Sj/80kaT9wFzlHapqPaJVMyAumYArNxScXePdd0rkVeWCyOqKzDgGmw6lEOh2SajaDh9oX/Wf5g5/29lMq8+YFnApUbyTpnzp0tsMbcdPvJpL+aniyz8W3vfBkaaTite+KfWr/buLYnrdx3fSBeVwlPoEvBapNeVbJ+h0pVkBWP+zkUcZeVfH42xgftVewK7ahE+gQDp9FmskR3NO9gOaRUtL6Gspvk4UB1RTYD3n3KEGWWFOH7dl6/2u20wjjA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=P0jZKJ7B2ofDz/RzLvf9iWiN7PqBsmfW5FXLeBWya1o=;
 b=lVYV+bZ6Dlrr/3laimL6V7Si4jloKnLvP6eqDS/sPA86jnReoY8pUZSZiZ6FKdMhUnAz5OKNVhtvB84XeFx/7SxKqvR7SozcX7Xk4TuegUqGy8K2dr5tPtyp06fyuLqpjcGkLE+44bnyHqRpJbJv3gvVfSbqxzdFgoNqja0OyPk9tal8mTCcmwcw1qLve195FTaw91Wb4c0PKdBDH6Rm0POQKLL6aM+FwKuonBASp0JdRbaYzF5vjsqgNaZHbIcMwBmlCNG3mQI2kqo0HuJKUBR9rVsPy4TqzQqcLjdfjMxkEyOXOGhnnOU6anxcnyBQJuHmCtb5LJlSFki5h9nTGg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=P0jZKJ7B2ofDz/RzLvf9iWiN7PqBsmfW5FXLeBWya1o=;
 b=IJwYTotuzdmabbwZ5ZVkQi+HtrUyaJTBpIuFPKm3fxh3qpGswo9l9WczaFZOrfzTn2q0V+g0WXVZGsL8K9a9ea8b/l3V9PThSb4DPRVbr/Gdb6mBC9Sc1PCZug15vyUqmUbq+pS+KeNdH+sBgA6wKVTXGG0M5uCO1gNQ6sNbwVD1Hc6cC+UhG7Asvu3cJClkzI1l/2J+0cdDdNAwjGDPxuOxgJlDr+onw87pldYVJ6nwFaeDaccTcjYm58JDvwYcc8l4r/uXhpXtCGPrU3m+4Vl79NBrPj08i3F2db7YeG+6pkdJPyVlJSNR4QPvRY2AKqV/wIJM34xiwFuDqjJq8g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by DB9PR10MB7626.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:337::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8335.10; Thu, 9 Jan
 2025 15:27:03 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%4]) with mapi id 15.20.8335.010; Thu, 9 Jan 2025
 15:27:03 +0000
Message-ID: <52d71d4f-784d-4f8e-8d66-18fe2a912503@siemens.com>
Date: Thu, 9 Jan 2025 16:27:02 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: btrfs support in initramfs-crypt-hook
To: Stephen Ecker <stephenecker240@gmail.com>, cip-dev@lists.cip-project.org
References: <CAK9C7GBuqQsWQahLo1pkpmSRGUr-Xi9ncPF6=ZNgkWOBZBaKNQ@mail.gmail.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <CAK9C7GBuqQsWQahLo1pkpmSRGUr-Xi9ncPF6=ZNgkWOBZBaKNQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: FR2P281CA0122.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9d::11) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|DB9PR10MB7626:EE_
X-MS-Office365-Filtering-Correlation-Id: 0ec52e0b-b75d-4802-2c0c-08dd30c21161
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?996nYckWlaxWexSfBtCcP32LWsl9OKDFUInJ/tC8IN/gz/E4wv2ejCfRhs7l?=
 =?us-ascii?Q?lzYnYfQSgPk4nqlxszOeh9sZtEfbTvk/isAPG7AwO+R0lquVEJFo/e5NAsNQ?=
 =?us-ascii?Q?eUFIUaop+VWnApnEdDoM8DcpN8YMTmeot3PePQa3ahzfuDSwSRwp2mL3uhds?=
 =?us-ascii?Q?1Ndpj+XZf8FPzIeLSa9MGjy44XmUQu8bv30U8tzZV3/eIErA3rxiUfWduxT3?=
 =?us-ascii?Q?ybTERp+Tymqan4cKamycNMoC0X1RjiQkAVrMmyP/iB9p6KCeNMjRmp5CHP75?=
 =?us-ascii?Q?eClb+CX1y1tD/KN65a31wwUHIZqa8DWV97sqjdNzOiztWRT3BzjuyBAPhZg0?=
 =?us-ascii?Q?TccO4xvAh+cxegFFuRM6xGJR1pBcIYbk5HGlRO9SEOmfZsvFEtLIrfbIxHma?=
 =?us-ascii?Q?e85hKMDZE9CuoyhRyz6WIw0houaNOehli29sHrQyfxcccWND5v6/hO79TI1H?=
 =?us-ascii?Q?WzlNQbcCfRXfOFj31InXfXuf50lsFbV66dA/kLaqBuHscJtaSNOfrcXATXx3?=
 =?us-ascii?Q?QKoq0Az86iKmB/pBCZEsnfhFj/M2f8dMNJWAvwcglRzn2L5oCvl9zH7OZT+4?=
 =?us-ascii?Q?4oSgbJ7EGybx1TbRvU8zKKOYGYDTDu74llB0YTFl4j2LINphacbFTM14Yr3e?=
 =?us-ascii?Q?RCRPeBGq6EIJOSolzQpSk3iaCOZWkK/VK6rhgGsBH6BQg/QwE3rjn+MNlsH+?=
 =?us-ascii?Q?H5Euu433mu9OxSW9ghKS5PV0Xp5aOfpBuFDYn3Ou3qNek4b+ZV2L1Uwwqfmc?=
 =?us-ascii?Q?FySOGQvzVP4Qda+wA3Hu5rrwZ8onUqPq483tmV1qehTt9UCIB33wUPmUAqNg?=
 =?us-ascii?Q?O7KtIC3yCSRdqw8D+H7qfYaZVfCMhp92aFX4kJyh3Z3BZKE29B+EFooiwEnj?=
 =?us-ascii?Q?4mJdNamgvYV8hRzYFcn20dNJv2ZW9EWU3sGrT3kCX+RCdQuUbwV5u6NbzA0k?=
 =?us-ascii?Q?JXvZc9OpAE9DxbhGoHLCOscAchvMHul6XO/fXHx50NCMQJ9Ypfk4aUqTOg3/?=
 =?us-ascii?Q?DcQIFgYgaB4nTRIia/aYU+sikWk1weduPAwwMPdHjHQ019N0sic3hLQSm0hA?=
 =?us-ascii?Q?ce0m++pfH8hvdpMjszAgX/J2o4lPGdPWD2+kyNwAwM9ZZdSAel1WZFWiEvK6?=
 =?us-ascii?Q?wQ+4swqhvl/c8uN++nECferGcGnp+1+sPSsOZ17+herUkaTsZFr3uajPEp+2?=
 =?us-ascii?Q?9b+wIYJtPC5mu0DwiOMKT4/W9sc5+vMHfuEP1reUlM10V/G1kzDjYbUbwH4K?=
 =?us-ascii?Q?lHwJbNAUEn/1/7xpFX3jyjhlpjrqdpykqaaCTCsgbUpzf/F/b8uDhSJsqrhi?=
 =?us-ascii?Q?n/MMbVDlDpJK6J8QYKwSj6jvaHQKdK7wOSLTRdpzBpFbyykLHmynaci+1DnE?=
 =?us-ascii?Q?0gWs0L6F5FBMEqcEnJB1FA/DwvBi?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?KYKAj5bwEJTvxjWG8s+BCmumsqSl9Mh8pjhDcH2uo4P8b4q0awDpoDrC6nF4?=
 =?us-ascii?Q?Z38rcquwJ5sSuShzCX2R41lu/cE/keDnCuP2kMyVwhl3n8Cii8i69E+lk6Qc?=
 =?us-ascii?Q?T7snRgUIzYVrcxnwKXSYBFdrudtySU7FXsseTTJNUTOkPqqDvuG/zb11gEEQ?=
 =?us-ascii?Q?WznB+/UiBw06t9W93Bfafl2OXssoYGzoPSEp0KMUfd9xxXZemlJOee/wUvG2?=
 =?us-ascii?Q?BxKPvyBp8SHw6mjZ2KNSxr9fpdwu2JVtIZGps35b1W1L3KKwFm92DYJYpOUL?=
 =?us-ascii?Q?bO1H+ETODgEdE7cNJAI7Xf1qy4KhKC8tnuinA/dv1THLouAkOJR+LSelySKl?=
 =?us-ascii?Q?AcCbHUaAaO75tCbT55NzC/GyNJaof5CPw5Sk5AZPOzRlVk1ht8jMDBMyLLw/?=
 =?us-ascii?Q?2EIqoRTJClfV6qr+kY0iMkbt9xlVCIq2cJK7nBpauDRYO/71+kMCrxCc/tyt?=
 =?us-ascii?Q?bhllR5HYhdBHB4DwBQIPOcKUIrpOy23FCLLL1E6K8W0/MBTi8CcrXc153GqR?=
 =?us-ascii?Q?TYb0oHlLc+Nt3eWSsyBwQ96E84Zvv6nkike1x+wywUdDu3b+ppJBDo5QDMmT?=
 =?us-ascii?Q?TbhF/z2S7q717I8AJvUW8NrFhu6by75Nn22qqT2a8ZeBO7qgf+pAvjeKiSgP?=
 =?us-ascii?Q?XwmqGV+FOLH4//wNRrJVfk+uzpN9pmLDYZz2QqUuyLRlaXJ1TxZ5acDt8UH/?=
 =?us-ascii?Q?IVyPOvkanOaJtL8T+k2GmQilnkh66QhyOllC2WOGPOZeJu+W0kwTvAi0Bllv?=
 =?us-ascii?Q?IpKzgCArLlYI30rfhq3sCYRitWTPp3p4aHgjYrfKO8+Lo1GMDdmGH4JR8a+6?=
 =?us-ascii?Q?SK4HnFPefW4WkH9jkIZznz3wdTGWMko1gWlT9c3prCuBuscUkau0dKq1G3UV?=
 =?us-ascii?Q?9R0PWJMvAiXzwzfvs0Evm4U59YW4ns2b91RLLlp4r3ahLOfJv8SNb/940Xrd?=
 =?us-ascii?Q?//jBFD6Vwv0djxWSCz9G3wsmtpVCnCn3EFNIgJspmpZZyZczIiRMWDOoDvkY?=
 =?us-ascii?Q?x2hmVz7oNsTXTge3oK+MFUv8imMydMvBJH7dT1gHDvJb89yq7CZJFTHSVwqC?=
 =?us-ascii?Q?RpsWcaywZRxR1jwTVSg+y/DRkuvrn6duUYXzCJ5eP7Zq8oryLd/cLneLaD4O?=
 =?us-ascii?Q?JxQBmyl1SH8eNwZ81ShVPAp2ltL06Q2Kf/TQhInnfZPfxzGAMqCxZYM7u8Gc?=
 =?us-ascii?Q?xMwiJ0avvIdcQJqVcbJEjDSIuZw6nQiK1HR5IFNzaTjReExDEZ3AHtVcTAxK?=
 =?us-ascii?Q?deHEhX5EB5uS4BdeXXjBduZfqwmevHa4XkFSQYPTCCN/j8nwnYO7MPZ+SV+A?=
 =?us-ascii?Q?r7eJ6my4pgpy/t0gyMF1tESeNF8a2xBcyfoPrjqiFtBYLgMpCzIr5FIl8rXl?=
 =?us-ascii?Q?/024mjXGzQ4q+TKVjQdpWoSvhlNtf9i2EHrtDD0DJhRDYIjz2rn+iIzv7cnn?=
 =?us-ascii?Q?EQBiAsaLqhf49Hycane7culrxjgNNwAr+fX7D0LCX0LDekgie0fcxf4FX2mD?=
 =?us-ascii?Q?QdeOfFK0pU8pcfvzHorZRhl90l/kHGsLTwbncjwuZWhu/2szxe7+r7r0BqYK?=
 =?us-ascii?Q?uwMKqjrzI5MnkPfLA0uqGB+UxChRsJowTfDV8W58+rSE3km1ncxDRdMp86c1?=
 =?us-ascii?Q?qg=3D=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0ec52e0b-b75d-4802-2c0c-08dd30c21161
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jan 2025 15:27:03.2657
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mzkTsdTLhpoGfsbXMWGQPPWVdKuj+cF19QGmIDIov9WO4/SEE/JX3hn8zRrybz87Z3V7c81bjvY5w7t1p4BhPg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR10MB7626
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 09 Jan 2025 15:27:09 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/17515

On 09.01.25 13:37, Stephen Ecker wrote:
> Is the reason for lack of support here due to not having a package for
> btrfs-progs-static, or was there some other reason?
>=20
> I made my own recipe for building the btrfs-progs-static package.=C2=A0 W=
ould
> this be worth submitting a PR to add this support?
>=20

Primarily lack of use case so far - there are some operational
challenges with btrfs for embedded and offline image building.

But adding btrfs support is imaginable. It would "just" require at least
some test coverage in-tree.

BTW, why an own btrfs packages, why not picking from upstream
btrfs-progs? That will need a strong reasoning.

Jan

--=20
Siemens AG, Foundational Technologies
Linux Expert Center

