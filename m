Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E677CCD4F3C
	for <webhook@archiver.kernel.org>; Mon, 18 May 2026 11:26:19 +0000 (UTC)
Received: from AM0PR83CU005.outbound.protection.outlook.com (AM0PR83CU005.outbound.protection.outlook.com [52.101.69.20])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.6351.1779103569903821820
 for <cip-dev@lists.cip-project.org>;
 Mon, 18 May 2026 04:26:13 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@siemens.com header.s=selector2 header.b=xiUElMqc;
 spf=pass (domain: siemens.com, ip: 52.101.69.20, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KZ9tlHM/kVXUtnB+wxOY9TTlbqRTmRTFDkYubWB0vnziDY8rkI9mHEx3eTXLTLvC57jS47B5hFw/MfG6guqutrJcJ/YvAeQYs4pnaob8kFyIIoupFDLX4ELBXE8snbBcCO29W3XtmSYYmE0t2Mcl6NhFVfEKZUP9gj9Karc5+g4rkQlsh3w4i0XnbVUKLvtQDyWvIAsOQuxLEqb95UDAlJxqSIVVH6H2vU5kVGA/qMiOeD5D/PwK5HkKrBO0xxmy7uD4w29H2/e0P1BjQXcrqvoEoKsN0Yy+G01AjT52cdEI2XK6n5N5ixbV+u3SVfrpHk5fDeHKmCmLnlQvdGAs9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aRbESVWWPNkP+Ag5WuQv9wkxhw8hpKL9idDMuYZf6o4=;
 b=kwMe/YydYzZYbW/GhQwNtvMa0dmXRVhIc8RV8xk0ebkVCqBpTkH5adI5iPkcouMaDzlbIPcawdInjg2ngzy3/rf8T/iJUtEyuZyDEoEJIPkjYpzUwBH+Rsxwi3SWHo/NjFzq5SwmouMMOlqArhQs2a30mFFgqIrWzNiCdZpW3RJGoklD8MBFDivTuIG186UdGf1sLkxGc2xRVpWFxjvMrqVACwKQwZNV+wUYLHQCBEv0buTGqrLQPcCfdb+qIzirnVR1LYaY4LxBb8QbNoS6bF2uRMLVcCaW7uPII3ffB4Za0K6Vyx92OkpfaK8n8YOEyKkXgc79cwdxmfXDGh+a+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aRbESVWWPNkP+Ag5WuQv9wkxhw8hpKL9idDMuYZf6o4=;
 b=xiUElMqcPtMz1jkvJ2riSiDYklrIu4RvWGZCqMoPRPYMBKA3cVu5Y1Wk5DqG4qnx/a2fg4ewXqyiZ5Kpz6cyUEYb008XKmxbhc9EBeUw3uObGY/WxLFkSY37MEqKqS7bwmAXA6Ptctiw3mXiV1SP4h/7WbJUPCGKBjKtFL/pV3op4OYKLD+vnVajZuv8XkZoXfUr+tRbWJ7Ql0nays/rUvf6CrEF7Cg4n2ZBzTwAp74LPNS261mP1rjfP5BJrLXun/pYeuyBKnEFD7Mpx8tiP80O3v49AHfg4Q2dQi3nukoQ/jTjeJAy/3lILjBfUeBT2xcE6mnw1JOc6CGuup3OOA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by DU4PR10MB8365.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:55e::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.25.23; Mon, 18 May
 2026 11:26:01 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1%3]) with mapi id 15.21.0025.022; Mon, 18 May 2026
 11:26:01 +0000
Message-ID: <dd5a1087-5bfb-4897-b4fb-71c23db1e469@siemens.com>
Date: Mon, 18 May 2026 13:25:45 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [isar-cip-core][PATCH] linux-cip: Update to 5.10.256-cip73,
 6.1.173-cip56, 6.12.88-cip23
To: "Singh, Gourav (FT FDS CES LX PBU 2)" <gouravsingh@siemens.com>,
 "cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>
References: <20260518093800.1396160-1-gouravsingh@siemens.com>
 <8415400d-0ab5-44f0-94be-18d7becf9c14@siemens.com>
 <KL1PR0601MB46971E9E965F4339D11F6117BC032@KL1PR0601MB4697.apcprd06.prod.outlook.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <KL1PR0601MB46971E9E965F4339D11F6117BC032@KL1PR0601MB4697.apcprd06.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: ZRAP278CA0001.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:10::11) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|DU4PR10MB8365:EE_
X-MS-Office365-Filtering-Correlation-Id: dab4efdf-ec6f-40c7-8c8b-08deb4d03d5f
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|1800799024|366016|376014|55112099003|22082099003|18002099003|56012099003|4143699003|3023799003|11063799003;
X-Microsoft-Antispam-Message-Info: 
	X2wiruXJUhMZv+q+FbgLMRsuxoyjkHKwoBtLQEJisAvvuinCpS2RDSHVjANSG/cVtwhEFkYd7MRLDYal6X+Hl3W9BxrvqB8MPBFnaA6c+e4UBcyW4rH4xe2NCwRZuHJQZi9HjyA+FBAI2EM+Pn+LZjMJq0uxsiw9c/MCYjNqFa/Wk3nqPwSVjyyBuv8jJI2ur8Gk7ECsd6erBGK85uyJ6/jWWLBnlIjPM1prgjanhkm4xYexsjnjs1SU8+hcec9kZBLoDtg4SBRoUGN8hHJLxMTqsN1oeHw/i8dGcFs2u6YOj2590+zCQlt5OOfSzgPTl81Oq+qF/2jJ6xogSklsFdSdCtJJ4z/JJnIWgETOhI3Db6jfdwoz1QjwAAH6DmIDsfWG7OaZNAuJwm2fIybtic2T4cFWslBkEOVetDwU5BVYGNLbrYDGrpWPTPMmeUwyYY0wYQN+QBhhZgjPCj+cUz7LYNoQhHjJxm4aVE8FxyubUTJx2b5sCu/f8m1napePzNOE1xtx/gtt2Sx/bG7mPcVOWmNd5dkzdBXQ5StOEPMEktv+uVpjyo2LNDCNWlFckWZImCjaimQzJyUpAt8YMYGvpmNTNkYJOQ98/G6xj8OUIXj0umeaaPpXAVgkSLeTVmNLaKFE28qAXLDtlFIVcsNhYNtPaBJ8mA5i6mZHMaw2EsHSJXRKtwPMaF3d6llo
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(55112099003)(22082099003)(18002099003)(56012099003)(4143699003)(3023799003)(11063799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?p/4Y9dEoo0ms/V/astK5M7sHb6B8qDaqub8IAqjahASRliv1bvfixfNvETSV?=
 =?us-ascii?Q?kB5tR9FCdG58GPhJ8gziAwbK/IFJPVMcvqrmQR7d/5LNoQJ2zCv28vP1lmT8?=
 =?us-ascii?Q?pfthmYBHy1dwCZ+uGBkRYRUT7sZ9Y8Df/TLgmcBJCetes87Mg8IihkrtrAiJ?=
 =?us-ascii?Q?xfWwRtc6dcdDrHestaskkT88EhfQ9x6di2Yfev6MVmAfrCfAaNiT+B535Uuq?=
 =?us-ascii?Q?SfUtZlNhT7T/EiCyN/VJVugpV5vIyWrBOCn7sI4xgTQFR6lCAoc0kzuZOVfc?=
 =?us-ascii?Q?IErlbPzBaNFPGk0lWabJPJYDsHaCvypOaXQnbYzAwxWOxeT0dfCwHyv9XOj0?=
 =?us-ascii?Q?vmpNVZjeKp10lRsNCozm/0DcDZa8SKT2RbNrPaxEtrSJ+KpurFlIacsKae2i?=
 =?us-ascii?Q?IU5Z8Bjn0SEK2IR/rTTWnv7JJGXY4A61uIZ6ebPIPa5jPZbxu8ZDgx0wXzjL?=
 =?us-ascii?Q?VESsunvmW7siOdpXzwuM48qDAfwB6N02XYEIZoJHTWWhmVX8b3uhb6+WJq4V?=
 =?us-ascii?Q?ynY7NuCW49uZYELG4yPljC9/3yp8MaTmgx3faWb8G3pFZMxK/jicu/GEm8MT?=
 =?us-ascii?Q?2wNX0B5PMAxsDecz+FYVRP+h7B/yFvdoEsirVHBUSoMlRO2mSyMcZ61SdkHZ?=
 =?us-ascii?Q?Rw1NWVa27hSAQWNCqCQErcLTB8VQcKKJoozAA6RdKL+9oWpCQzypjAX/EoM9?=
 =?us-ascii?Q?I6mpdEmZXd7XLAG9+kgaADUaNPm0VbYgCjamIdTnCYThkfAZ/vjpTK4AbzZv?=
 =?us-ascii?Q?dhFMG28bgGljR3rCtb0ejTjhLAxULOpiuxXyR2QoISMpWDMfrKk86vXBXm1A?=
 =?us-ascii?Q?s8fmE0COGh8vI0vFDTNbJrWq3xlWcLu+yM3SRx5cfljcZ+jCPm4s4YVf3pBF?=
 =?us-ascii?Q?bxC5fG8YjPVoTfJJiszbLPnkQd19l9qu8tnLQ/AmXQ+3IH/3Dr+Ix0og2SI0?=
 =?us-ascii?Q?sEAXjNfkQuV3S33NtJY+ubi1UezDhbZGIp0keJHid9kprJU0tSj3q7Cu0sSa?=
 =?us-ascii?Q?893P/RJvXnEhpJd+Wqxgv+Yp6BrdMvHXrH9hmgbO4JOkdOlsWAmiDRe6SOp8?=
 =?us-ascii?Q?MaCLLOeGfbdRgZjCfd9eoYeQ6xBaxXN8ysI0rOGJ7UhWclbAHSXicq6iyZG7?=
 =?us-ascii?Q?UVTdVytsXaLtmYiXPc+vXMIFTAfRQo2I/JSB7GBkI26uVNmoObUg/0bT0OwU?=
 =?us-ascii?Q?ZI82KAk7H5mMa6ApTSkp1HrvKKJWvN16IVZUfYqVyePhpELnhoJR+42Cz8E/?=
 =?us-ascii?Q?IPLV0NTFiWGJtjngcQUDR03Vr8T2E8SzI9LSAb7kN4HXS2VDRIR5j60OpwkW?=
 =?us-ascii?Q?NFVx5GDlpqLcQuAmvl+/FMI1FTWSdwQIvJ1WWl+UUM/v9XDSd97Dsuyck4/P?=
 =?us-ascii?Q?7U/zCMyEoqigeUq/JgxQvPltFycWHR768dLy5zsdLwizSsFiq5PgI6X1Q18K?=
 =?us-ascii?Q?FMwmd4Nh5IarGiy4/aKmsnoo27MXcDkLnt0MrHBmsatV8ruaQ4i2W1Hl+Zg0?=
 =?us-ascii?Q?y089yDefyYWP942zSElkpBisl4SiB6ctNEezbqWjQ0FUi9dxMn9wWcjBOmom?=
 =?us-ascii?Q?+DMGkTvvhuAPN2yUqMkV3hjv8xsqITg/QgNhQvwGwTe6OdhSjsk7WUpRnCP8?=
 =?us-ascii?Q?W5U3YDMBQIEwXS1trH7y/ZOOjlyQcAQYBQv2RxjWqAsKa0sMW5Q9yCto58U4?=
 =?us-ascii?Q?pD1bSvcesNCARuWbrqcMB2NYXP8twBDOEW5E93vTqnW9ofAO5PSxUWEqhm80?=
 =?us-ascii?Q?QKN+RxlfSg=3D=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dab4efdf-ec6f-40c7-8c8b-08deb4d03d5f
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 May 2026 11:26:01.1937
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EW2MOGaa1TOg4McPqMcmsN9zD7svhGCaOI4ae0dz3VnKja56t0S9NQlm35/xY9wtF5dvDbQb9K3FdrPNZI8x5g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU4PR10MB8365
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 18 May 2026 11:26:19 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/22974

On 18.05.26 12:30, Singh, Gourav (FT FDS CES LX PBU 2) wrote:
> Hi Jan,
>=20
> Thank you for pointing that out! I wasn't aware of the scripts/update-lin=
ux-cip.sh script and had made the changes manually =E2=80=94 I now understa=
nd why 4.19-cip-rt was missed as a result.
>=20
> I tried running the script but ran into a GPG verification failure (sha25=
6sums.asc invalid for all versions). As a temporary workaround I commented =
out the exit 1 to let the script complete and will use its output for the u=
pdated patch.

You need to import the keys of the CIP kernel maintainers into you local
GPG keyring - or enhance the tool to fetch those automatically if missing.

Jan

>=20
> Thanks,
> Gourav
>=20
> -----Original Message-----
> From: Kiszka, Jan (FT RPD CED) <jan.kiszka@siemens.com>=20
> Sent: 18 May 2026 15:14
> To: Singh, Gourav (FT FDS CES LX PBU 2) <gouravsingh@siemens.com>; cip-de=
v@lists.cip-project.org
> Subject: Re: [isar-cip-core][PATCH] linux-cip: Update to 5.10.256-cip73, =
6.1.173-cip56, 6.12.88-cip23
>=20
> On 18.05.26 11:38, Gourav Singh wrote:
>> Signed-off-by: Gourav Singh <gouravsingh@siemens.com>
>> ---
>>  recipes-kernel/linux/linux-cip-rt_6.12.85-cip22.bb            | 1 -
>>  recipes-kernel/linux/linux-cip-rt_6.12.88-cip23.bb            | 1 +
>>  ...inux-cip_5.10.254-cip72.bb =3D> linux-cip_5.10.256-cip73.bb} | 4=20
>> ++--  ...{linux-cip_6.1.170-cip55.bb =3D> linux-cip_6.1.173-cip56.bb} |=
=20
>> 2 +-  ...{linux-cip_6.12.85-cip22.bb =3D> linux-cip_6.12.88-cip23.bb} |=
=20
>> 2 +-
>>  5 files changed, 5 insertions(+), 5 deletions(-)  delete mode 120000=20
>> recipes-kernel/linux/linux-cip-rt_6.12.85-cip22.bb
>>  create mode 120000 recipes-kernel/linux/linux-cip-rt_6.12.88-cip23.bb
>>  rename recipes-kernel/linux/{linux-cip_5.10.254-cip72.bb =3D>=20
>> linux-cip_5.10.256-cip73.bb} (54%)  rename=20
>> recipes-kernel/linux/{linux-cip_6.1.170-cip55.bb =3D>=20
>> linux-cip_6.1.173-cip56.bb} (59%)  rename=20
>> recipes-kernel/linux/{linux-cip_6.12.85-cip22.bb =3D>=20
>> linux-cip_6.12.88-cip23.bb} (59%)
>>
>> diff --git a/recipes-kernel/linux/linux-cip-rt_6.12.85-cip22.bb=20
>> b/recipes-kernel/linux/linux-cip-rt_6.12.85-cip22.bb
>> deleted file mode 120000
>> index ed5ab00..0000000
>> --- a/recipes-kernel/linux/linux-cip-rt_6.12.85-cip22.bb
>> +++ /dev/null
>> @@ -1 +0,0 @@
>> -linux-cip_6.12.85-cip22.bb
>> \ No newline at end of file
>> diff --git a/recipes-kernel/linux/linux-cip-rt_6.12.88-cip23.bb=20
>> b/recipes-kernel/linux/linux-cip-rt_6.12.88-cip23.bb
>> new file mode 120000
>> index 0000000..306c2a9
>> --- /dev/null
>> +++ b/recipes-kernel/linux/linux-cip-rt_6.12.88-cip23.bb
>> @@ -0,0 +1 @@
>> +linux-cip_6.12.88-cip23.bb
>> \ No newline at end of file
>> diff --git a/recipes-kernel/linux/linux-cip_5.10.254-cip72.bb=20
>> b/recipes-kernel/linux/linux-cip_5.10.256-cip73.bb
>> similarity index 54%
>> rename from recipes-kernel/linux/linux-cip_5.10.254-cip72.bb
>> rename to recipes-kernel/linux/linux-cip_5.10.256-cip73.bb
>> index b4beedc..4d2fec6 100644
>> --- a/recipes-kernel/linux/linux-cip_5.10.254-cip72.bb
>> +++ b/recipes-kernel/linux/linux-cip_5.10.256-cip73.bb
>> @@ -1,7 +1,7 @@
>>  #
>>  # CIP Core, generic profile
>>  #
>> -# Copyright (c) Siemens AG, 2021-2023
>> +# Copyright (c) Siemens AG, 2026
>=20
> 2021-2026. OTOH, those changes are generated by scripts/update-linux-cip.=
sh anyway - or did you actually created them manually? Probably, because yo=
u missed 4.19-cip-rt...
>=20
> Jan
>=20
> --
> Siemens AG, Foundational Technologies
> Linux Expert Center


--=20
Siemens AG, Foundational Technologies
Linux Expert Center

