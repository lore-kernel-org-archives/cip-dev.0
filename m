Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2EDF6FCEE91
	for <webhook@archiver.kernel.org>; Wed, 25 Feb 2026 11:47:42 +0000 (UTC)
Received: from AM0PR02CU008.outbound.protection.outlook.com (AM0PR02CU008.outbound.protection.outlook.com [52.101.72.49])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.43453.1772020057949187111
 for <cip-dev@lists.cip-project.org>;
 Wed, 25 Feb 2026 03:47:38 -0800
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@siemens.com header.s=selector2 header.b=DjEIK1RB;
 spf=pass (domain: siemens.com, ip: 52.101.72.49, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PiHoRIvxu26DSn5MzO9hq4j5ywMT8YuB2R41sHbq0rLb/g3694fGvznXq0/XCcl4amPPCAPONSPLkFGh3YDRZDm4S70m1nmoKCqSn0pt4fCa2NvtaDWloXH1H7yk7crseolXzipZC24Vk0Pt2zsJTnLzNPVAoIJcrt7EJmfXLVWouKu+KgUWR70KQm/6WxHllFIS88T9T8UXvLSGgorOJRbsvIOAqyFkouUBkru3SPgTtnthooWeTLNyWDpiSUOfFtN/Gki+Yx/AJ4cSc2wU+GdiGsZWSn2dZRrFCTC4b8qBjFOQVi6qTJlEF3Tx9oRZMQDkh35U0N6RpeoU0Mi/hQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iN2CglGNJ8yObz723nif1YCUYRp6sf6KoZifAOkNnFg=;
 b=eEfcDV3tsWN3VVTuKfJFtVZDwOnyTqbX387Sps+ZYvHAUXqIF1EIQZbY9yvyJro+FpEUticI0i0Px8OMcvYxBnOjIVWd5IUh8OWbaj2ySBy4LTT52GL/Lrjru9M8zWe6q0W8szJoq9cKDtDIB/e4O/zx7kmLA1y8FPmrtgV/XhSklE0aMRO7BxRYsqVL0pc55nTVXOY4LdUSspW8+LyUG+T+lZ18g2dHzvaE9L49b9bdahfE3sADNZlIbPdZnOI0qYFwj0JJZjm3vcZuWGxYcWHdOwdWxJdPEYONF8OhkqrSeOm7wkNCwsdEi0pr21pek1/6kKGDOci82KYVq2/Eng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iN2CglGNJ8yObz723nif1YCUYRp6sf6KoZifAOkNnFg=;
 b=DjEIK1RBVI+Pmq2/v/maq65n7f6O10tn28A64tLtPZLomgHRpnl7ulLq+fHy9teDCeR616kGocsvXgJUyLtZ0zurM44q/NEW8tMv6UfWtn4L/AclSjHJ6LHnhTLPX1D8I6sB998zGShO1XQgy4tjkzllZcV0VFovYdGztF6J7UwRAP9NoDfkv3YUe+u8d3VmiZgBSZbCxtoSpuZkqH03tRdiNEW2dSzHUD5otDVjGpAVgxP6sUxi6pnZdqEhVMVRstvnkyhNOT/4xAqbpn3B6U/4IKhliLs/nzvLXjJKPIBc+bJOKHk4J9VJTDmQXENu/rtO3FOYTiMffnqYd9BPPQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by DU0PR10MB6899.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:466::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.23; Wed, 25 Feb
 2026 11:47:34 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1%6]) with mapi id 15.20.9632.017; Wed, 25 Feb 2026
 11:47:34 +0000
Message-ID: <4eb6eda3-2ceb-4f72-9bc7-f30a1974afe8@siemens.com>
Date: Wed, 25 Feb 2026 12:47:32 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [cip-dev] i915 in 6.12 kernel
To: Pavel Machek <pavel@nabladev.com>,
 Stephen Ecker <stephenecker240@gmail.com>
CC: cip-dev@lists.cip-project.org
References: <CAK9C7GAcSFAbw+Z8hU904aZvaG+uKCCdmomxM-8QRc679z91sg@mail.gmail.com>
 <9927e980-b0d0-43a0-913c-cff2bda757e3@siemens.com>
 <aZ7Gz00emqLIThnm@duo.ucw.cz>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <aZ7Gz00emqLIThnm@duo.ucw.cz>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: DUZP191CA0005.EURP191.PROD.OUTLOOK.COM
 (2603:10a6:10:4f9::19) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|DU0PR10MB6899:EE_
X-MS-Office365-Filtering-Correlation-Id: 81a58e1c-5dc3-4ab3-a409-08de7463aa37
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: 
	zoYK5h4QHSmVnim9A/f0bSs4pVBcSScfZ5/CKtpKWWLAagP8nqSKNWtfwii/4l3yTz1ztgoX8cMh8NFInt4k+i+bKJwv26eu48W/1rtTiY0SqgkOF+35pYjhWqKXQOpubq0rD2HgqFCAgADwHmdv0z80QUT3vS8Cq+GChawAUQHbMprYwqtWCkAr1Y4fTfxjHwN//chVqbgCTuH54Z/LyW1A7rdq+rqkQFrVnHIvmrSQMzdBwzb+6AvmOeYWRD4NKmqywqFv4ZSWVn02XCrNYyDtwnrEE+Mz15n7Bh1vvySeSfX5q8aCFHn5/U388fHtrGoRsSVleh2SuCM+SyHN0PgEAZ5SYcuzvhMgofleSR78d70xhbEKSPrM691rpXch1qbRfZuAkgjtcavz9W58vbr8VIV4ZPPajvfV5PB0C5zaxWJ0iGtMkRXJSwnrWRcLc/oadPaCm0p7a4TvrN5yPMp8SesjtxckoPof08qZTYVig6opUae0r6lDmTGOA6dE14nu8VOoXMenfKkSVHktcLVYDZiMTfo/FdsRecFyn6NXhaZq7XkNPSS/GyKN7v7Tgytu2nDp9rkyPiMkhFtNv0FdmXrgdeoBZdFBMDbFuCxcqW6pYO95nPf4/n/EjXXXRq7JeIlQ2xhOTwhT1qLyOyOQ0fwxP6eYWSCJUfXGV/OCQG0lqiH4bJU6b1KOOfMRxFG48nkb2kDMMe1cilqMs22zZHcAtRWtBPUSTcfc/48zjKcZtVWVbkCRIWaUT1y2
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?1EJi31DtSCIzooD5AC1pcHriOdjv2AqIPJoI0ejrJezAYwJnfTn3ZNyOIisA?=
 =?us-ascii?Q?jogIXw71jTxTzVi4cC4mlZYs6A5A10J4sdyOI/a+JABgWRUOG9eiJ5IK3TrX?=
 =?us-ascii?Q?3xA4W2c6FVBs53j8Ux0QdF6/hNDHQ23RuT6MiGCJdEzppwKY3mfZDVnOts35?=
 =?us-ascii?Q?ppUxemD4TyMxgM/B8wIMlFN5GEJpBCdmYM5dvg52ZKvUngBMJVypsR32ed/W?=
 =?us-ascii?Q?8by2c5bWoPaM8a6SIpFzjCeemu0ATFrbpq6ERbl3yIZx/xpHgepHwz4KiHsc?=
 =?us-ascii?Q?pO/tYQ7FCjGnKH4L0ZU8i4bdevM/UZ4hjeT07ler8k2IB5y8+TcNKETvl/Q9?=
 =?us-ascii?Q?Ldiw9p6TdMd0A73csAERK4mkjLGFcd/TBjfKgfrxXoMqM4Xlp1fr4I9rB2fq?=
 =?us-ascii?Q?7u2NZNyuQzriPhUs/XOX6d7RU8RZ9FVn+2tGzCA3cJIYdRb9ea0yHti9pMXr?=
 =?us-ascii?Q?xOIu6AZEQL2TGRm54DliV5Xq3tDhjtdDx6aI4TLPO/TFOXw4Ha0jv6NaXI4h?=
 =?us-ascii?Q?MfdTtyHZ2rhDTwSIiiYqGpcaGnN0kgrYXVGWjyEZwvfkkCkckKnd2EhpRTA+?=
 =?us-ascii?Q?RjYk3vKPeAw584y16T+3S4EhVYC5E9+4SLQj9RUMhnStMi2fQ9b7AO4MfgDG?=
 =?us-ascii?Q?En98YcvxK/WMyDSTCZQnMT72SIgn/P64VRIe37l69dA/++hqib8RYSYKGOf3?=
 =?us-ascii?Q?oZsaSwTtOAc+pSdmjcP1uYWursTcPVzAXkFAQgBl5cnurslHdEqa90aUBqHE?=
 =?us-ascii?Q?k1E2ap7Qyv7zD5no3PIHAR48Bi6E+3TmbT1lX3czOeSXd+1n8xWrNbiWDYWf?=
 =?us-ascii?Q?tSgC2uHC2WUYA3hkm0wT8yVKWwB9oxvHLf85SI0Ed2aRDlAWoMCgmKlAbLHn?=
 =?us-ascii?Q?S+RQC5uz0kA8HebqPH/FbK226ykj9nObA7gsLNMBI8DPiGGuQoQC/loIrHWK?=
 =?us-ascii?Q?AxD5TGbHV8gektfWcBfp/3As0hGaGG0gC5mvopuOYGP1OrgiVPcCbt/xgxsy?=
 =?us-ascii?Q?3PBkn/WZx4GEu/U2ge/u9ssWNoRZtfMoDMipsNJO73RKoRc/S6MrUcPLv9Oz?=
 =?us-ascii?Q?mICb7ULPOfHSXJfwJf+Wy4/EyNFBSLhuvIW0+8oUqM5d856UlFk6zD/UY9jZ?=
 =?us-ascii?Q?J87opPVvYd4tlcltZE4rBtGjPz+Y0Lyx9Ju9Th7w1yuB0m0DU9+oizsQfkU/?=
 =?us-ascii?Q?0m7wrForNrnmRwgpirtMvam2vc65rc7byDPE3/od2+UWUltRJWCsf2+KmCER?=
 =?us-ascii?Q?/Z48UmwU4s7PZYpvCTzt0S3Cm0K++beTqysuPtK+DJP0zquStG2AwKsluQ6C?=
 =?us-ascii?Q?1kzO47Otoj4SPlARbULR1+PV4UflVaswK9pEKD3J0Ot4DyuXjyENxZ2ejxq1?=
 =?us-ascii?Q?uiKK/UH5GG4M+oaLGxWT52Mh+YK58jbU8QBU0RKrO15Z/neshOETRj08vVgT?=
 =?us-ascii?Q?TZmKPKBb09iyErbgXotifaXqi6PySvrCsNppBiSFVOo3Uvxq8R2l4YkkmGTb?=
 =?us-ascii?Q?SxREI9nAOJrBz9NoAU5LvUDM60O/O1vmLs+WipHMeK7GrfLkCeTnuy7Qs8Hm?=
 =?us-ascii?Q?ZzG9RqWY5jy6v+uLc2iwjbxk8JqJIT4QWd2OF4xMYFDjSYrVvv7KbSWzc1cW?=
 =?us-ascii?Q?QVoPXr+kDhtLZlEYUEsCjKj4heX50vPOj7aLw2efiVnMrB3fa5wjrUOKZJYG?=
 =?us-ascii?Q?kh0/RtKzG0Ihr6PlfDIkCJLWJN9y/qbP0xGAsddO+D2lqxQN1mz6PViO4AVh?=
 =?us-ascii?Q?M5zWGxhyqQ=3D=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 81a58e1c-5dc3-4ab3-a409-08de7463aa37
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Feb 2026 11:47:34.1289
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: R3L9qftqv+SCImHd5ZzIAQ9iHQ5SrqEB91/Jm+W9yxhDBRJkbXQ2C3CjqOTYSVm2V9YvAt2iAtA6/pXrxTmoAg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR10MB6899
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 25 Feb 2026 11:47:42 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/21930

On 25.02.26 10:54, Pavel Machek wrote:
> Hi!
>=20
>>> Has anyone been able to apply the patches for the i915 module in 6.12
>>> with RT?=C2=A0 It was working ok in 6.11 when it RT was still an out-of=
-tree
>>> patch
>>
>> You can pick them up from
>> https://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-stable-rt.git/l=
og/?h=3Dv6.12-rt-rebase,
>> they should apply.
>>
>> But CIP decided to maintain only a single tree with 6.12, and that means
>> that we can only accept backports from newer kernels. Unfortunately, the
>> i915 patches are still not ready for being proposed upstream. I'm not
>> into their details, you may ask for more details on the linux-rt-users l=
ist.
>=20
> Yes, applying the patches should be relatively easy.
>=20
> Impression from RT meetings was that cleaning them up so they are of
> suitable quality for the merge may be more of a challenge. Suggestion
> would be to avoid i915 hardware if you care about realtime and
> long-term maintenance.

For some (or all) newer Intel SoCs, the Xe driver seems to be the
alternative that does not need downstream patches. I do not fully
understand if it is the driver for current and future SoCs or if there
is only partial overlap. Anyway, trying it out if it claims to support a
given platform would make a lot of sense.

Other than that, it seems the discussion in [1] didn't lead to things
moving forward for the i915 yet. Maybe time to ask again, also because
of what may happen once distros take the same path as CIP did (see Ben's
opening of the thread).

Jan

[1]
https://lore.kernel.org/linux-rt-users/2d4a5031-307d-4f29-8875-13b8b599b220=
@linux.intel.com/T/#m5155ecf06d57ea0bc4a71e1583b250abff6cf209
--=20
Siemens AG, Foundational Technologies
Linux Expert Center

