Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47D70CFD31F
	for <webhook@archiver.kernel.org>; Mon, 24 Nov 2025 09:57:37 +0000 (UTC)
Received: from AS8PR04CU009.outbound.protection.outlook.com (AS8PR04CU009.outbound.protection.outlook.com [52.101.70.30])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.13404.1763978247140378316
 for <cip-dev@lists.cip-project.org>;
 Mon, 24 Nov 2025 01:57:27 -0800
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@siemens.com header.s=selector2 header.b=i+vr9xLx;
 spf=pass (domain: siemens.com, ip: 52.101.70.30, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vWET2aLrB5/M0j0NyiIgg8zg9NnXiSWhIXVDpx9vw7jYMHqJ0sRsiydim5XwzfX3ttmNfPdZ/s/ydNRwZkf3qz57p21JbmytVmWFustKZSgHIxUntXUAV6PNosKHI8g2ZcokN3CubCFx76T14NsSoC0Y9bT19YsKm7jmfDv5NfJd4dDDNGUPC6b/512uSegEH5jaLadmRUIh1onuMllekG7/8OC75qIaNUTWj5en6PRyJ+ZSUBLj/ZGy+kmZv2+LS41H/XVkhjFrgDYAA841D9WVRG7fSUqMu44DD0NHEsI+jYm7DAN9f9XMfCI0/7FQjXrj+r5WxxiVqmd4bxxOig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JRdtNAxENQQWTKm3qdYGbQA5zwuSih5Ap7hffuxooZE=;
 b=rhWs4c5ZZda/EcB7KBXZLZc1e9lGy0+daBUv6Gypy0FHrrZnRXqCuUaScV/pKaO7t4gN1bguGqzal41h71LOw/YeTmhsQFt5UhIrVF9shr/iGcPub1tEebjvHqLn4ssKFr4nFFYqK/f6+napN/RNrCwzeG4oXqxq+bsumryBjyoj5p7YODOxWlrGO2Jiq9M1WZah2rUw4OaaPymJ6cyoSCMCqtslSqs5+JnhEl30YHnchsPqgWZO3lLGoMzjAW+54LH4wR97V5mifvVuijfCtiFMJ+nLyu1D5vo7tynBxh+swI9JOEDckTHvjzr7nssTbLD+9jA8+F+WCzUXHCuQcQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JRdtNAxENQQWTKm3qdYGbQA5zwuSih5Ap7hffuxooZE=;
 b=i+vr9xLxN046JuSydCgHFcfruQ66LJqn8/GmBDobsArEtvM02EZtxc5SvKLisbvTHpFLXJhDAwhnWPGglMRza1s74/Y/gTo1AO3UIqDP+r653QwSvZyVbbxmU5lOYY0Z3HWSfRF5OP3WhnwxbZVKh7l9ZrWJmf+LXi0PZ2Kmwvi9ikMGzeRUnk5N6Zo4vrhHHanGTbujUwpMrxiH2QiKEz5viEPto1dBo8ozXVxI4dOXyLVYytzxISGmo3/hK+03yAeD6j5zS6IcwuHH4/AF5qESkeUdh8llOJfBUgV99grwWW2zIujR6hx7KTTI7Ok6AIoiymUwm5YN8ejw2Yhg4w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by DU0PR10MB6753.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:47a::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9343.17; Mon, 24 Nov
 2025 09:57:21 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%6]) with mapi id 15.20.9343.016; Mon, 24 Nov 2025
 09:57:21 +0000
Message-ID: <6a1364ba-93c7-43e4-a153-213048963da6@siemens.com>
Date: Mon, 24 Nov 2025 10:57:19 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [isar-cip-core][PATCH 3/6] arm64: Switch to cip_merged_defconfig
To: Sai Sree Kartheek Adivi <s-adivi@ti.com>, cip-dev@lists.cip-project.org
CC: Biju Das <biju.das.jz@bp.renesas.com>
References: <cover.1763399717.git.jan.kiszka@siemens.com>
 <ae9f51993b0cf98e41452074a51cf1a15716f21d.1763399717.git.jan.kiszka@siemens.com>
 <9d4406c8-6599-437a-b4b0-d2f07d6442f9@ti.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <9d4406c8-6599-437a-b4b0-d2f07d6442f9@ti.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: FR5P281CA0057.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f0::15) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|DU0PR10MB6753:EE_
X-MS-Office365-Filtering-Correlation-Id: 02b765c1-2e3d-4002-4d79-08de2b3fdc36
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?iW/2nfHJMGk3aNXdc0M6cxQZK073hMed63GFqbq8nZwqQ8xZlXGrZX+cfgSt?=
 =?us-ascii?Q?e7yHmYhRKoHQl1d2qpiizqCZfgV2mAPVi8zhs0ip7ErpFqtL6BcOmOADOjn0?=
 =?us-ascii?Q?yxXcHQ+e/UlvLTWbTsVK3qnDRLs3qvGvFoQePASFPvNT8hmqFdkhu76Wy+9/?=
 =?us-ascii?Q?oQtk6SbprEpi1TQgLMsOyADmoHYzDQTO90k/I91xtLZWaYgqFoJlyt4Y1cWS?=
 =?us-ascii?Q?dHWXrJZ7mOytP22/CVZcJe7AX+utSmGtIsyxOIAnosxSiWVM11qpW0cD18PJ?=
 =?us-ascii?Q?j1RrSAMi/iZVbY2rnkdJefV5XgdsUlQwbuR9KsThrRQ9Ba/pq/+jlOwm9sEx?=
 =?us-ascii?Q?sg0UqBmmqVcMa74NAkyx/IibdspmYApjH3xewnfGzIMi4q8u4zVkkzkp2dEF?=
 =?us-ascii?Q?TVT8UKpc9RFhYmrtm5NPeYRfnuitnmBJO2vxn0PzawbzUcW1d1XCDNyVwJSE?=
 =?us-ascii?Q?aVyohOP0aUtfnZTgVQUqcswUm/+qFz04vPIWu0SJeqWnuzirZm4kmjwFWEZl?=
 =?us-ascii?Q?VWltk7jeIlhF6NvF+yedBn5x99kuCLDBFKzbw5Ate77T42P/54SJiFwfeAF7?=
 =?us-ascii?Q?TnMV786PIrfaN8OQ000ZT2moLrT/cZr5bWLWBCYCzvT3HYXkkqRDkQN/HrMh?=
 =?us-ascii?Q?S7dYbPx6xG8+HWq53kE5xzrsCehV+1EYFlG6ySuV2x4Ke5/bmbeDCNl5XUzn?=
 =?us-ascii?Q?2PmPmMwYHlaE4C8vwQbiYieLbeW+c3ygje2uqcU4WTf+MR/FIkY3KFlGHBTT?=
 =?us-ascii?Q?T79K7lkTlWSD3ZtBVCS/Vf7l5abcRZ9c6ZR4TBo4IIn2FXyL/1HguKCLgAm1?=
 =?us-ascii?Q?p8b6vrHZNhRdYYHGhDp+52OZeG2572H64qkjYlx9+g96DCToPMQHDZkD41zu?=
 =?us-ascii?Q?VSGyQ3X15vy5kIrf4eqRYou0X+YOBIl9OOkruM+wHqK++3plDrdssuMwaDrU?=
 =?us-ascii?Q?Nmsoqc/HUKzTSQkFzHfEd2aOmCk9iJrdHYPWkWKy4jhzrBkRhd0XOrlnKfPH?=
 =?us-ascii?Q?SMUaPxvQN343cjpDc+tn5FrFyppmt2eaj14jxHRxECXNO44Q/BvUbzW7+ozw?=
 =?us-ascii?Q?7DVbSyOAkoWfxQMJ9W0bEjH1ktTelqNxHqLYzZdTQXjbExJEqM1Cfay4mjHZ?=
 =?us-ascii?Q?WCphi/m6iM+txPtKEXoVOnyG/XsnDpXhnDFXCJb7WEFFcRcd2EOipSfE9WHf?=
 =?us-ascii?Q?NsnzwIIB87ae47Qznytw7SVbSsH/Y9sXoVfaZ0dVilIoxWBqEAYIVeaiSz1F?=
 =?us-ascii?Q?pLnwUCY9MoE3DdkayfyT8VC1MSD7pZ+qT9bAsnUowZrakuFRMZFKuidZzrTn?=
 =?us-ascii?Q?xj5dVYuiU6KpIhwn5nPNg4sxRFqF+UamwFk7W8sHhNO9De2ZL6eHU0vclm1m?=
 =?us-ascii?Q?WFxiHQyZvkq9QWLubLS9UeKwUkqXdgSFMOjkxnAscqJtst4SWXe+DiHYuzTI?=
 =?us-ascii?Q?MTi0gkikPBargDt+JRb/dUgqp2YgjGEc?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?brQHhLSkFHc9q4s1jD4sT1DnmwlNW/hs2VqHwB7DrJ8jFBrBnHEcWarPSAuy?=
 =?us-ascii?Q?26oU2aWw4CW7YKWCzwW+hlQ2hzZ+nzm5LEFvHxSUt9k1bIy2SVy8y0R3C20S?=
 =?us-ascii?Q?blU/9E4FuGNkzFTH8yCWCRj1W6FWZdXlKpcCVoYY4t2x6QEWERDRrVY1cgsi?=
 =?us-ascii?Q?QSgSw4oZ/0vAZmFhjLNLjSV2CdJeTMETIn3RBvuhK6aeW67yEDHUF7c11hc+?=
 =?us-ascii?Q?3Lquss9WtCYZDuCEOSvGOmd/FOOWYzw2rseNpMLC9WQ42bb89SW6taGebL32?=
 =?us-ascii?Q?7kTv4a1WUo8AtbzXyGwrAfEEkDqGmEEtlY9XTAK/UBz7iks3uxyz6gS+H7IM?=
 =?us-ascii?Q?a/XktZoXK4AyNb6/G+Mf/2fGeyJbLYVzuYdyyaW2F2HHlPamcJE0C+gv1Ynv?=
 =?us-ascii?Q?E1oEoEUfbxsVSFmjNedYMkkbYGlZ2nsV2ycBjzSx0+9a9cb3eUdaYoLmP0U9?=
 =?us-ascii?Q?sUJsMY1w/B8hHon9ZQahuD7aRiIWiynQD6cHbdHd4HlG7amwdUf1/mrRPe1I?=
 =?us-ascii?Q?pwhF9J5EV5pRO04+NITumw74a1Uhk/Eybh+tX0OCkBQhy0oEsENojqX5neT1?=
 =?us-ascii?Q?aJGZAD6bBBsL91EQvOGCWNvHz5oCajg5mDyGu4eNwK3HNxzvLwD+GOSOFqKd?=
 =?us-ascii?Q?6AET+kEO+YCvhYtPcNw7wBFjxEzKjoJS5MxHPpi9voXB2cuWugn10OfGvTyx?=
 =?us-ascii?Q?QGIoPBxtkgHwr3THApk+n2MxJnM3WoRAh9K9Gq2RWOiFy5Zr9xOoBKNzdKxs?=
 =?us-ascii?Q?eWnTuaQJnJToDNwjbUKaiC3hskmpPCj/hQYaJzWAoCK1KjrQWE1pWTizj8g1?=
 =?us-ascii?Q?dMoKHzdC41xU93tlRHzILs3N55eZbDll9ZuMNAhCkbJnXKWUUCzWMO2pyKNt?=
 =?us-ascii?Q?xiQcRkh4vhBrGSbGjuEOL4njWSmILG+LiGRDawcblKj3snL3rn9Zaqt1enIl?=
 =?us-ascii?Q?y0OOP16XJ04Da4TWiDSXba3tl6orBVzMfwFWrLNTy6IfoI2uUVTz4+anUxSe?=
 =?us-ascii?Q?/464Xy9QsuDN+ShUGflE5P9pAx0Gu6DXVV995TzEs0Gs2SewGAhh1ONb2XqG?=
 =?us-ascii?Q?Yb3+ae0UkjbflmKzNZyurGqSsbnac3KXWp1xC+LG/3RVysM8HJxCNKnjbbFE?=
 =?us-ascii?Q?JOU8s5IV1aZfG5P3JZu6vOQZeRgnNPwr5lsVIapVeSj1x9Sj5LbexpIQ7kQ3?=
 =?us-ascii?Q?doNwl6qgQ3U6QWARfe0/cEbifm+TCjh5WzB8AMADpyw2J+9M3vNPKS2uV3Bf?=
 =?us-ascii?Q?YBI8DJR4nsBNPDT5p+vTCyLQiqJAvJmetLItYICbwzIYbSleUlzBFfBKOfw+?=
 =?us-ascii?Q?6Z9uNib1kecwyB3ZQwAd38tHC0cwr8eCryFRqxjl3wuaHvScy2XnzdPcRAEl?=
 =?us-ascii?Q?YDvZeeZpayPml4DWdAyVON3VyLPQrxBjddnz1p9LrFEoDQgPClZ0/QiQp8ve?=
 =?us-ascii?Q?nmoHaJZuZMH/XNQnQudah7EWQL5uBPIiiGs3tHEz2PuNmodkpbxCGOY0Kpfj?=
 =?us-ascii?Q?wrpK3P0Ta8u4+L7OVGa+LXG7PaYYCw5JWUcwyagMZC+nX5wTmBi0DHfP5JAe?=
 =?us-ascii?Q?lppi8BIf556IiKQBT91+InZj2ZtjXEBrdMOsjel22p89i/agOMJ1tCLjiHQK?=
 =?us-ascii?Q?pQ=3D=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 02b765c1-2e3d-4002-4d79-08de2b3fdc36
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Nov 2025 09:57:21.1624
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zzZ0jpUDsjOOio0ixkjEPZHnNU6QJg4UNnHYXyK8nGHEIgh4T3CJ5TyOnv/mbJe+wia9+K7tffaurulipAnKzw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR10MB6753
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 24 Nov 2025 09:57:37 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/20704

On 24.11.25 10:31, Sai Sree Kartheek Adivi wrote:
>=20
>=20
> On 11/17/25 22:45, Jan Kiszka wrote:
>> From: Jan Kiszka <jan.kiszka@siemens.com>
>>
>> Allows to use the same kernel for all arm64 targets.
>>
>> Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
>> ---
>> =C2=A0 conf/machine/hihope-rzg2m.conf | 4 ++--
>> =C2=A0 conf/machine/ti-am62px-sk.conf | 2 +-
>> =C2=A0 2 files changed, 3 insertions(+), 3 deletions(-)
>>
>> diff --git a/conf/machine/hihope-rzg2m.conf b/conf/machine/hihope-
>> rzg2m.conf
>> index 0b3acf49..485683b2 100644
>> --- a/conf/machine/hihope-rzg2m.conf
>> +++ b/conf/machine/hihope-rzg2m.conf
>> @@ -1,7 +1,7 @@
>> =C2=A0 #
>> =C2=A0 # CIP Core, generic profile
>> =C2=A0 #
>> -# Copyright (c) Siemens AG, 2019
>> +# Copyright (c) Siemens AG, 2019-2025
>> =C2=A0 #
>> =C2=A0 # Authors:
>> =C2=A0 #=C2=A0 Quirin Gylstorff <quirin.gylstorff@siemens.com>
>> @@ -13,7 +13,7 @@ DISTRO_ARCH =3D "arm64"
>> =C2=A0 =C2=A0 IMAGE_FSTYPES ?=3D "wic"
>> =C2=A0 -KERNEL_DEFCONFIG =3D "cip-kernel-config/${KERNEL_DEFCONFIG_VERSI=
ON}/
>> arm64/renesas_defconfig"
>> +KERNEL_DEFCONFIG =3D "cip-kernel-config/${KERNEL_DEFCONFIG_VERSION}/
>> arm64/cip_merged_defconfig"
>> =C2=A0 USE_CIP_KERNEL_CONFIG =3D "1"
>> =C2=A0 DTB_FILES =3D "r8a774a1-hihope-rzg2m-ex.dtb"
>> =C2=A0 IMAGE_BOOT_FILES =3D "${KERNEL_IMAGE} ${DTB_FILES}"
>> diff --git a/conf/machine/ti-am62px-sk.conf b/conf/machine/ti-am62px-
>> sk.conf
>> index 589f071e..bf3cf9ab 100644
>> --- a/conf/machine/ti-am62px-sk.conf
>> +++ b/conf/machine/ti-am62px-sk.conf
>> @@ -23,6 +23,6 @@ IMAGE_BOOT_FILES =3D " \
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /usr/lib/u-boot/${MACHINE}/tiboot3-am62px=
-hs-fs-
>> evm.bin;tiboot3.bin"
>> =C2=A0 =C2=A0 USE_CIP_KERNEL_CONFIG =3D "1"
>> -KERNEL_DEFCONFIG =3D "cip-kernel-config/${KERNEL_DEFCONFIG_VERSION}/
>> arm64/ti_defconfig"
>> +KERNEL_DEFCONFIG =3D "cip-kernel-config/${KERNEL_DEFCONFIG_VERSION}/
>> arm64/cip_merged_defconfig"
>=20
> Jan, I'm seeing a boot issue after this change. The boot stops at
> initramfs with the following log
>=20
> No tpm device exists or supports pcr_hash 'sha256' or 'ecc' - cannot
> create a encrypted device!
>=20
> But the tpm2 device is available and the `tpm2 getcap algorithms`
> command confirms that the device supports sha256 and ecc.
>=20
> It's working with ti_defconfig. So looks like there is some timing
> issue / race condition when the tpm support is built as inbuilt instead
> of module.

And there is no other module missing in the initramfs that might be
built-in with your config? If you re-run the encryption hook manually
from the initramfs later, that will work then?

>=20
> I'll run some more tests to properly identify the issue and post a fix
> in here or cip-kernel-config repo.
>=20
>> =C2=A0 =C2=A0 WDOG_TIMEOUT =3D "0"
>=20

Thanks for reporting. Finding the root cause will be important to avoid
that other users will run into similar issues later on.

Jan

--=20
Siemens AG, Foundational Technologies
Linux Expert Center

