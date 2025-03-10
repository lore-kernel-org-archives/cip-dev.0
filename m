Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9BD51C282DE
	for <webhook@archiver.kernel.org>; Mon, 10 Mar 2025 20:43:39 +0000 (UTC)
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (EUR05-AM6-obe.outbound.protection.outlook.com [40.107.22.68])
 by mx.groups.io with SMTP id smtpd.web10.49355.1741639417029161152
 for <cip-dev@lists.cip-project.org>;
 Mon, 10 Mar 2025 13:43:37 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@siemens.com header.s=selector2 header.b=QF4/3Djx;
 spf=pass (domain: siemens.com, ip: 40.107.22.68, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RID9V7l1J4uKgUFoCqEkAYLSQungwfHsjGz3ElVLu+g4Pq3d6XxV/IojW+cYAtkMoiSY4l9Abf5qNOZKvRpLqXzJAHMtrkOXSwydPfK90AOXsLxIgUzjKdAHaC/AD+oPbTK3EpsJOHbbIzKpqt6sW6RXKwbMvOQAOa42BJgXR76n5TdCKtscbvt/GclwR7yKUixWTLiIDWBsgn4tg+2HO+ZQhBG+Gyqe4T4rZHPUSUaVJmqdQsu1hbEEuNKO5bmK2OyWxoMl2tsrBfAEDOsKLRMS3UUbdc52pmpFBqzk+VVVHggoVauPvtqR9W7ddRrmOIhXpQ47AcRIuoCuAP6dzA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=v7ZiMWC4emQnqAiHsIynuEBsV5RCmTNZF6ds4g39HLw=;
 b=xb1aSxXp6B7F5QL6NEmk/MeTHMAQtUlg6Ci27mqN5z7vNtdzyxDB8k7QjuyyK8Y3GO/KYxEBSKBQXrz/nu054JQ4A606r8NfWFWwtWLyk46T225VcY21JPNuPS82sEDyP9z2D5FtbstciZ9hjhHEh6lhTUMRuxj/x+i7p1uT+qpKVROQRs7S/DoyXvO8XJ9yE0FnFxJXt6OFY0cggMbxtq+BjSoZdQZIGuQPleo67znpHHs4WSp98gjtp3HVTJ7inrGPM9Xz8sAMP6DSzcXcT+IBqARDwqno7UPDICxerVP2uPucA+Ww9ImBJw0NvC4yD/6DEek9XIzeyMF+J9kpYQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=v7ZiMWC4emQnqAiHsIynuEBsV5RCmTNZF6ds4g39HLw=;
 b=QF4/3DjxK2yexphNMCAQOmKJIg6k00/QExMcj1k4Jl1GTXulDjucO/wu5gz7W/2m3XkDrO1znT8zDRMjc87Vywu0B7ZPnss7B5SPnbvEyQ4uj3pAoBEOnnHA9LtLG8ciEmdyorogZJnqOJmyurDu3L6n8yyl+ChDVlzIZEWrEg+vpbR/6pxpPjouUY49Dhmmt5PSP5q2IPpDMFjSaWeD7Xh/RLypWGJGP3s+k0kyfbyIcqv3o6vIIA4TrelD3/+fiy+2rAa+ym7ZrU8NZdxQHySkrz0EkSf2OGHgb6qLBVAZt5CcNvI7bgnka/MCadErWIsm8swE6/RimwNtdHYKmA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by AS1PR10MB5747.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:47e::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.27; Mon, 10 Mar
 2025 20:43:34 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%4]) with mapi id 15.20.8511.026; Mon, 10 Mar 2025
 20:43:33 +0000
Message-ID: <22f01b35-2d08-4b94-bb72-37d82f3b21be@siemens.com>
Date: Mon, 10 Mar 2025 21:43:32 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [isar-cip-core][PATCH] ebg-secure-boot-signer: convert to signer
 provider that hooks sign-secure-image
To: =?UTF-8?B?w4dldGluLCBHw7ZraGFuIChGVCBEIEVVIFRSIEMmRSk=?=
 <gokhan.cetin@siemens.com>,
 "cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>
CC: "Gylstorff, Quirin (FT RPD CED OES-DE)" <quirin.gylstorff@siemens.com>
References: <20250306093516.3232063-1-gokhan.cetin@siemens.com>
 <3f756d50-aa21-484e-aa52-f91531451dc0@siemens.com>
 <87b88c83-3fce-4038-b8b6-cfe83056fb9a@siemens.com>
 <PRAPR10MB54225595622204A578B7E92880CA2@PRAPR10MB5422.EURPRD10.PROD.OUTLOOK.COM>
 <38368d3f-3c33-467a-8e0a-8fce11de6415@siemens.com>
 <PRAPR10MB5422A552AB83D38C445E1C4180D62@PRAPR10MB5422.EURPRD10.PROD.OUTLOOK.COM>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <PRAPR10MB5422A552AB83D38C445E1C4180D62@PRAPR10MB5422.EURPRD10.PROD.OUTLOOK.COM>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: FR0P281CA0178.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:b4::6) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|AS1PR10MB5747:EE_
X-MS-Office365-Filtering-Correlation-Id: 9eaf4371-d2d3-49c6-502e-08dd6014398f
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?/XLGUeQz44UfOVQSQn1HRlaCCekQEXSc/hLFqc77133kWgmKhOs2HNd655Dj?=
 =?us-ascii?Q?/thE7vY/t6Duj0+A0eBE/hbFFZmmq7/qSjARWVzfKm3s9OIZUJKrhhDkmEkL?=
 =?us-ascii?Q?Jlsmr2vN9X/DD9Lol0FSHXLMPs/oXLNBGUfnddGLoxbR4VgNYt0KoxpRWBe1?=
 =?us-ascii?Q?3DAVPWC8mSlZVsNBR/ko3ufXQGgA0V9QGI+fPy2BJKupM/VtRZExJYT/3t+0?=
 =?us-ascii?Q?iWOXHdSprSL+LvhIOCYBOhRbNNtcXWjCdoBCX67Spx7A76MoSTV0XHyjRi9i?=
 =?us-ascii?Q?PdDEA8W77REaDsGqahnXOnv3E7ZbhyG/j4ZNgy2Tm8ls6KwdUiN6u/dZi+Z3?=
 =?us-ascii?Q?C4dEg2fvnjOEUC8Tco2t7ee9dYeLKwyNTQzOlUJDeH2Y3iFleAaiucsZQRvF?=
 =?us-ascii?Q?2/ywldcwvWrSWnURNjK0iDwhsB77A9RQUSaZsNy2QYpwNhmEhnAKFoKzDrFH?=
 =?us-ascii?Q?rES+clH2yfj6BlNoFmNv+QqxKz4qFpUuFBnGLJEQQa9CJ7KnzFNCxX+x+TrL?=
 =?us-ascii?Q?oXFPZO5OfKBdaYJjq0xwxhQctcSN60Td1odvWH7Uvx+4XRejDAR02PLna+iX?=
 =?us-ascii?Q?23jpyq4PHBx4PfnwnJ0LtDn7OQIvR/Rizolvu1KcnCxdJn/2SLS0YPMtfmUE?=
 =?us-ascii?Q?NAdeKHuSvtv4oFePN7eB2jSMxrRTA5XbtjEoWL+4OpqcSLX1nxrafjxqLYFM?=
 =?us-ascii?Q?i2+F7HDqTUmh0sQID20HigyY2oGWFsW11TwTYmLIv/qhFQ12KFQmt+uaBACo?=
 =?us-ascii?Q?xyBdC+ZMtI9dl04jfVB4XV48ddBF6FI47TwfHg85q6ftvqxx601UCRAQoUQb?=
 =?us-ascii?Q?xL6dIXFr8+FS58VJaIbvU1w57xC/Z752kCZe/dnIsK8hwWvakidbOLRtwZqF?=
 =?us-ascii?Q?hX6Zd9NHckQFASOHQTfVxuEMkrzZuhOVV6FMO8wMdVnzRpeOMgk/tXa5qsrx?=
 =?us-ascii?Q?3JLtdqnOvOJcPhIYyLsuTFhXnvKtzd4Bx/rDAmYn5o00OcWxhIKjHZPopuUE?=
 =?us-ascii?Q?QDmdrlHAk0Dcv6cJbuHpLwFowtDRSYFSYwzK+4cUkS/YNktEt5dq3IadKifD?=
 =?us-ascii?Q?4KBoZr6CDMxszGKhicID/aYpO2g7k+u/TXbq4FeQZncHNAgdUGESCQUQYdn6?=
 =?us-ascii?Q?cnvVQEHcHkqTvM3lCNnoORRu8+PKlJzhUD7zBkD5KMdPrdfUYvmxWzRSWUAR?=
 =?us-ascii?Q?MNnOvei/3FDGWp2WwcEym5soliwwjqpgBY3QdO1tQJgBy0T19WK+OPRHkhOc?=
 =?us-ascii?Q?6CAUX2F2lWZtSRuakudH+IP54bFPH/pkS+CYT4tAFhMNLqHqDIJtP7vfIimG?=
 =?us-ascii?Q?j7wmWaNijlBF5l+vp7fKYWogyOrqjYJ/npgsLPgqOMATmbROPrOV5FsZMjqj?=
 =?us-ascii?Q?nN7aRYy5Y/vbL14ca6/sUL6zhAJY?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?brf6zBsore2AHVukUQPaOddVCObMejdPlPOPXnqZwjfvdGzFasc//hhohWz3?=
 =?us-ascii?Q?1N4qswGXxPlMumcwARXHM059LozWPWl+zWLw2VdLq3EyIlhBt7cT4SkDHNW7?=
 =?us-ascii?Q?z9i+DIjYw5jNHa7AK6IbcLWg4SOZK/+BS1llbUeVJ2PRiwIx6Ai2Bp8T32cK?=
 =?us-ascii?Q?1F9UkpSD5z32yCMhF30c2rrOw3BEerAhelrLLxFVtv25Y/yS2X69bEVT1GZf?=
 =?us-ascii?Q?o9AufeStAk4sDkigOTNH4cc1+KCH7UCoIUWK5BIIu6IogPJgYknREBMjcMtM?=
 =?us-ascii?Q?mYRCfAYdZfdHUE0AYOV1CBT9blCYyugc1ifFuBjLzmcrykEelG+6QMPOhBpi?=
 =?us-ascii?Q?zgg9LNHNHb10/7v7aQCMvy3AEGzc8noV7WSGt2C1LMFgq/t+iy2fAEsAePRz?=
 =?us-ascii?Q?aSEieoqI7mUXN7TGFLTbgkqY00XsIPVaJtRtL/b3sp25feUUejOLdw4N9k4u?=
 =?us-ascii?Q?+c+jsCwJQs+OKhe2AGhgQ2Cg3aFwF/BD2d4jaXHsuBLtIcVSUpcxEIaebbvO?=
 =?us-ascii?Q?jK8HOJqN3OT4zQvrgUnCeBg3x3EzkqjQa1yRgdSO9nxcpTz3aU3Hq1vI5YKM?=
 =?us-ascii?Q?NKHDAx2eaxIpHKA0LpzanjUVxRb/kQwCm8VeAltx72oVDzaQjWkkDhCkEHyh?=
 =?us-ascii?Q?VVsKiGWw7b/YZFp87YS0+YnKsCZSjiAcEEVWAO80mdu/Y9J/mrpydyGwUfLK?=
 =?us-ascii?Q?rYNM+y6A0KrS/iNEfim1VT8YtlE9SI7iUiUuJ7RbNxZTYeTi9uIevlyQfJpl?=
 =?us-ascii?Q?fcQmB/Z3IMFRfZ+eoOxPYFBpZTHHXlUyzswFRCQV6P2dO0UrzfiM5DGjoA5n?=
 =?us-ascii?Q?R3PnlV+FCcJ34yTr4PUVjOdjz8x8qTWtCZxoYsixq00X4y7ylbJk5GmI/UUw?=
 =?us-ascii?Q?KdebmxsFgdds7TIqEmHq5TEEO7kcmGFELJX2ahKQSTE7zGLKiMvPNUdfCw2G?=
 =?us-ascii?Q?etGtnYmSCYKpdnrSZ+mSItvRPj7DQQGUOfcpQT1j4b6SM1xlKtMObRHl7tq4?=
 =?us-ascii?Q?8R7cqHUBhBrxpzHgi74Fsdsoxj6O9ktE5cNitp4qkJQq4OD7rqdMAlecdwil?=
 =?us-ascii?Q?mRQCIUHz30ZHBDKnwUVtachu/HL1nuJKUQMrdC3q48FuXyGtR1bcKsnrRqS1?=
 =?us-ascii?Q?XdczpeixOqOvV4z9P0F8zejPzz0bXrH0k2MauG+LezjVSYqup2NUdBVQq3wX?=
 =?us-ascii?Q?HR96cdChxBu/xeR7ebB2Cad6gXZtvCyusOGgeBZD0eGhISjUFYgD8GfP7nDT?=
 =?us-ascii?Q?0GnccFlu8wSvZCLgV7MKnEo5EX/AahDnIFz0z41WGP3QFwEbLmshwdOZ53U2?=
 =?us-ascii?Q?k6fcJrDX6/9MLYmVtUeBfgp/6qDCHqsk/twL2skcYokeCTIWIAqKAuv23B9E?=
 =?us-ascii?Q?IxvJO/oRs899BXVP2BAqDPq9ip2lGgU47RPUWbHqekoI+OLk8xXvzXUdtNWj?=
 =?us-ascii?Q?U3ROJZn+IW0JuWuJQ1WD1uD2wAKpolWrq6KcvJMOeUV0APcC8m+ZIEnIeafV?=
 =?us-ascii?Q?CPWisUlPODdwd29nAHozYWPSoLqzUkZGxeTbRReo2k6NGDKfT2jE+JSYhYd1?=
 =?us-ascii?Q?p1lI6SQPLSCyCzoU3mfx1mkSotBkdUhHS/PabXetTY2o2XSIuNEQ3nF4EgJu?=
 =?us-ascii?Q?Jg=3D=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9eaf4371-d2d3-49c6-502e-08dd6014398f
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Mar 2025 20:43:33.8950
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: p+wBe7/rts0CaDPtvvnkdQqJM+gDIoIrg9SsQ4D9Fxz+QNgQ6x6b13V2WtMFUTBBT9B0AkY7XvOChwlNpsTsZQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS1PR10MB5747
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 10 Mar 2025 20:43:39 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/18078

On 10.03.25 20:21, =C3=87etin, G=C3=B6khan (FT D EU TR C&E) wrote:
>> Things I would change:
>>  - ebg-secure-boot-signer -> ebg-signer-pesign/sbsign,
>>    PREFERRED_PROVIDER to select, default on sbsign for now
>>  - secure-boot-secrets -> secure-boot-signature-provider
>>  - secure-boot-signature-provider should deliver all what is needed for
>>    both variants: certs, keys (where applicable), core signing script;
>>    for file-based keys, a standard core script should be provided to all
>>   implementers
>=20
> If core signing script would be part of the PROVIDER recipes, maybe, firs=
t thing can be the fixing of `signwith` parameter on the wic plugin, as it =
is already a customization layer of this chain (as already done with swupda=
te class and swupdate signer).
> Or, as you stated, I agree to have both tools available depending on the =
needs, and until we experience pesign for a while (or other options if avai=
lable),
> we can just provide our core signer script from downstream and don't use =
existing one as there is no direct dependency to it as of now.

If pesign turns out to be able to obsolete sbsign for our needs, we will
eventually be able to drop one - any maybe even folder the signing tools
into the wic plugin. But that's not in sight yet.

>=20
> secure-boot-secrets can be revisited, providing only public certificate i=
s still possible by implementing another provider, but making SB_KEY option=
al, (or separate -key provider package) could be an option for reusability =
of existing recipes.
>=20
> On downstream, additionally, we use secure-boot-secrets for signing out-o=
f-tree kernel modules (by providing a kernel module signer which depends se=
cure-boot-secrets),
> so I would prefer to keep them separated from the secure-boot-signature-p=
rovider package.

Now we already have two users of the same interface, and that needs
coordination. This can only be done upstream. So present your module
signing procedure as well. Did you patch linux/scripts/sign-file.c for that=
?

Jan

--=20
Siemens AG, Foundational Technologies
Linux Expert Center

