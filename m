Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77805CFD2F6
	for <webhook@archiver.kernel.org>; Thu, 27 Nov 2025 13:37:47 +0000 (UTC)
Received: from AS8PR04CU009.outbound.protection.outlook.com (AS8PR04CU009.outbound.protection.outlook.com [52.101.70.9])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.18506.1764250657316067356
 for <cip-dev@lists.cip-project.org>;
 Thu, 27 Nov 2025 05:37:37 -0800
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@siemens.com header.s=selector2 header.b=rAwlfd2H;
 spf=pass (domain: siemens.com, ip: 52.101.70.9, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sjTYtMsE9Bb7h4mpf33JdvVYlnIuSS5F7c2rISwBgd2itPx/7jgoC8F4HTpcfLo/zr5aTAli59IB2faSantDQdONCiTFvs4piQd7119boROYyVeRUy3Bs/Ub7jd4yqfbpKYZlkdl3/nqsOC5r7FzqlJZNcptnXsySzIBsIWZKZ4osUNHYTt5z5KKqPOjFPw8MoGPXIU8wu5fhPfUixj+/G4xSSuE3UTkws1MFLKRV8UCLGIfDvs1Rxm1ZVMVX7q92qGR2COtMrkaaWF2hGMUKZB7Oit36vMNg1JfhhjR4klujIFYRPt2svgKPyjA26KPOtrQQ84i6ipNaL5NTLQS0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OdqL4mBlweQGkw5k1pDPOK88N1Nyd3Yd0oVnAqMU4Cs=;
 b=Yjm/SR3mIuxDJcsCRs+3vcYpzQyY49YGT9vhiil+bLaH6VcsPwlTkL4k/ADsgeWdg/LRwTAEwGBPMKcv/dYYgVDq/AU6IhzVzpOUKjwcYWmHy30HtbeTZy/LRRZndAto5rDEqDe59bafXzsM3vf9wJx23CyLHIDLdQzeZcSH+JPxwAmjGK/8CbVt3tXs35ky/mVnZSmKGz9W0qRNCrmzvddIe3xVbeJ7wiuDGmpZByFgpPIqYwWL2z0NRmMsx63TCYSGTQkimvF3ky/4IkLdlwNjVHThjuRInBt4vXRES6A9KaX8H1/AWMqxX2EF8D9UkLK/Q2+cvBV2m1ElYQpCkg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OdqL4mBlweQGkw5k1pDPOK88N1Nyd3Yd0oVnAqMU4Cs=;
 b=rAwlfd2H3Pxzo3NJR0vadypYJX/lMG++7NG5tPE6aqE42Gaol4pyhBFRUKRevRUKZtNcKhVZz9z1PSquIf7mdQqCjbrly4Vx/t7vkQMnjVEPYdcCm0/tvKdkZ0XDvaQxX7a7JzFJL74XQOW9NmMHxxglEsTaNf9XrNHgibwXMQZcepggc3NqKEONIVJ0l3XRWINKdvAn0roPH6VlRF/ojcKe9neOa4A86IVL4XvvxVYhS2hwhO5BXK8x8yb48Y+yQ39+XP1O0Kqk2hmWlj07b954YIqrVLJpSJwAfeeOjIr0yLTxT4MU+/7jRf2ZvPmlAjGRIrxnPyNPO9LDuxkN3A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by AS2PR10MB7480.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:590::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9366.13; Thu, 27 Nov
 2025 13:37:34 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%6]) with mapi id 15.20.9366.012; Thu, 27 Nov 2025
 13:37:34 +0000
Message-ID: <d1f88d49-e317-4782-9ac9-fce1bf21bd7b@siemens.com>
Date: Thu, 27 Nov 2025 14:37:33 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [isar-cip-core][PATCH 3/6] arm64: Switch to cip_merged_defconfig
To: Sai Sree Kartheek Adivi <s-adivi@ti.com>, cip-dev@lists.cip-project.org
CC: Biju Das <biju.das.jz@bp.renesas.com>
References: <cover.1763399717.git.jan.kiszka@siemens.com>
 <ae9f51993b0cf98e41452074a51cf1a15716f21d.1763399717.git.jan.kiszka@siemens.com>
 <9d4406c8-6599-437a-b4b0-d2f07d6442f9@ti.com>
 <6a1364ba-93c7-43e4-a153-213048963da6@siemens.com>
 <1883153f-6108-4351-87b3-835c88d32de0@ti.com>
 <f842cf21-f6a5-4e0e-97b0-00f3e6761ae3@siemens.com>
 <b6cd2368-e868-4667-ad0e-321a468dbcb0@ti.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <b6cd2368-e868-4667-ad0e-321a468dbcb0@ti.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: FR3P281CA0104.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a1::20) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|AS2PR10MB7480:EE_
X-MS-Office365-Filtering-Correlation-Id: 967a58b3-d9c0-4c0a-5115-08de2dba1eda
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?ZtiUZgKg0lPnLYvh1FqY/MPHnAUPyr2w7D0UgTtRy4nuPq2FhvBTqbtfHCSI?=
 =?us-ascii?Q?o/8zlKeF6V0a0xlmKMi8wx/RK2+p1Tg8MHfVHCrl18Opge1f3a9DwOymVHRZ?=
 =?us-ascii?Q?tyBpQWVPtC5C9zI56YYmUFI//d8T/aAlPbsd6/pfDqO+jdyRzXQe0vEivspd?=
 =?us-ascii?Q?fyK7Pwxmd8BcHrqysIr+KfG2J98iGe3okk8ocpSz0Yy86Tr3AteWrJYqzo/r?=
 =?us-ascii?Q?K2WDpj0bQ/UKhrkjUaUQ6fLdXh6ktmAfvR/zMvL3uzjcvtFxwlFQP+hTbx6y?=
 =?us-ascii?Q?Zh8DWdHQCn1+bj2mSmjTMdXoqkadwZqoIyEoqrUHkI/PTrz8CYUY9Oiik0d/?=
 =?us-ascii?Q?4Vwmgqk56avl2tky9MibkAAFpoiVRmO/Y4EV/rR32lVhVgY305BAIlLKxVLG?=
 =?us-ascii?Q?TAW4Ol/YBa2yueI811xrphfxyq6Rtwg+Cuu/zjxec+fnuqvHEG6oD0kRpzNb?=
 =?us-ascii?Q?EGcOpsu4gx3lw+Rx5vM7IegG/1AZPQa/GQSamDOUZ9WNpNrdVoKV0qOydbKK?=
 =?us-ascii?Q?prw0iCzZnt8AKDrzvHc3THe+f1kfOYKEgEJT8tOVJjLIP/ziBt2qv4NmSaXn?=
 =?us-ascii?Q?QIglFg4lFXOmBya7Ie/+/0kbTdE44fGnRjdcYGE8KFPCaCB8jZQCR9O4hva/?=
 =?us-ascii?Q?vuYLfralL4kk634k68935mZGRpePT60FQtSFEHzkKRq73YIduqm046/6fjJG?=
 =?us-ascii?Q?jhqcgEZLnIvdrlU/Zc/jwF6GwrSBHul6PijesCjWkkIaIyqpejzxyXqtWHn+?=
 =?us-ascii?Q?7AwBME/2XVNrL5EoOiqtFCUYLNinGhcYx4tpjtpwpBCbIWEXYZdAZ6bz+oJd?=
 =?us-ascii?Q?f2L7Gwa4N8AWEUzp9Ug29JtlxuKihpS//RdosUljCPav0A30ybZpGN95a5fu?=
 =?us-ascii?Q?wQcbE8Pv65Af9iKoGSdd7iqfYMwpZhigVuJ/dAtuZ8C4KVs5Sywp4PHtQs0W?=
 =?us-ascii?Q?IRamu2FerD56FRLu6NPnShXBvIvwPoEpYjje7mZ6mr4dGYTJUYxNz2tmlwMC?=
 =?us-ascii?Q?Mt9tviyTqiYiLFIvuAbmGrwTz1Ee0TEwYoeSErwRNd3VAnU/tbeoLhE+0nLc?=
 =?us-ascii?Q?+nPk6IxGFs9ZNrJA15caDe5nF1kiWpQEhaI4f1UxEf4pIzG3rdKKIn+q91IT?=
 =?us-ascii?Q?GXFmfv/0DejsXLUbAumcBGagUDamgOnJnszuHAWy6S7SK/Hr+16HYVFJc4lh?=
 =?us-ascii?Q?9v9FhowxR+dyAlfqPLbTU4fcSG4phLeVA8uwdZti5fvlI5aqgx+Ih6mWL3YE?=
 =?us-ascii?Q?qQn7qeWMcdNWhKYmgzEpeUEoTQ0cfELckk5Qkgq14XuvyQQ3l0TVKhc7ZpiO?=
 =?us-ascii?Q?k4w5J4KgcD/xUx3crCkiHIPB53WK5OavsaLspmSHUNwIEiO9yCQuaf4rj6iK?=
 =?us-ascii?Q?B4tx7c/s3Rj/I9UXRYZ/S4aFR51rdvdqzHcQ1yq7Pb+iiUaUI8LkDr9asHB6?=
 =?us-ascii?Q?ZvGWpnO7NIVYpd2/4ZaECxFyVgD8FdvW?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?R544n2BfdxZQxWdRIAKNijIBIhbV+FbV2fMsPXFIItfD2bMul+zoHByMGwDC?=
 =?us-ascii?Q?TbrEW6pkSzkVaV9HtEjgdCQiX7ED/fPQq80q47dSlJbB6NiX+9ujr5EZ7j4D?=
 =?us-ascii?Q?XthWA1+gGxOAmGz2HM4vvCP0ldh9QthHw9f48Fu7aoMpmw/SOw4WV8eT3ILz?=
 =?us-ascii?Q?wMGel2R1KPeKNYzd3q9hwddoGmBHfXjniFQe0HEdxbJGbTbuxJ8DH2jBvTgC?=
 =?us-ascii?Q?Hqhw6oGezayHYv5kgg8iu2OjlSdB21/JdX6IPiRIfEuCytDfgt0eCwfdFUzg?=
 =?us-ascii?Q?XmTXDfbs7CRQHUU5E8GyUBAAse4ySCWo90ysw5ZsFRBpjNbW4oQEnVgo60Dy?=
 =?us-ascii?Q?USPGh8D/Qo+9zUZWL1OhHLpCTg/N7Az1J7mSUmMH9+9vAIFpSAkJSalNWdAf?=
 =?us-ascii?Q?vUT6vGKYO3t6sWtpOCMN09LxNn89+2UylSli/wtTRCEJImGCNw09MfqxjTWW?=
 =?us-ascii?Q?vmn0Z8z0jg+4R3aETYP39YfmVcgL9unNEE24aqiMWupjW6+mBhxWn7zdTVoF?=
 =?us-ascii?Q?HPh9q2sTURf7bp5LhbGTH5I7ojdwpfc6w3GIzVLffFHtO1fgm5+mYSPaIj1c?=
 =?us-ascii?Q?9KLKUkwd2NqGoCLczb6xHxFTrbZpSRqsDxRpS1Vcs+0SqT8/vs/MFJmo/rYv?=
 =?us-ascii?Q?XzedHWgGmUGBTzSQoaBkuvf4loE1lL1qyovI9wgDWTR6Kl7bg53k5VuJNMLR?=
 =?us-ascii?Q?VaKR3SHivTd3qVGXGsiMD9cDJcdyBY5DbADnzG4zk9ZRfGbrAFFuZK9lmf58?=
 =?us-ascii?Q?4iKhiIiJoykBYSodPGvyGc+VPxNAV6tWUQtAV+z7aPqh9cmZKndEX9GcHHUC?=
 =?us-ascii?Q?tgt/xq5hCrOuRxZVA06kqlnTANRbgiBHUkMflZ6KmYfk/90qGD6yVcQxILtu?=
 =?us-ascii?Q?BW/tZVe2kGHzyBK9WHRF8Z6gC1RmPxzxXWLQJB6bO2wOF0kTBx4OTco9FglV?=
 =?us-ascii?Q?8JW06Ff0NeMD1rESEFXyphmp3j/8aBOwijJIUQSFQJ37czmwUlQA09kKkZOx?=
 =?us-ascii?Q?05NXZvPE30405xhdmhlihs73tuDrixg2mYtDVxosQcTOJjhRsd5GDNykbbQr?=
 =?us-ascii?Q?EDE9szuyYOjHxOgjHg1rDTN3Zd4GOUdCcXjJ0BdB9KzUWvGnFapoImTFBbjF?=
 =?us-ascii?Q?R3s0plEvuyruAhCNJ9zSkc47TkGOVJRCTfyo32G5vgI7+oB+T/IzEbb0V5RK?=
 =?us-ascii?Q?Qa2/rTJOv6OL9Z4BlL2ZzYzkEWK1sn3zJbNo91V+NqJRw3XJU+fEIJf8lFAH?=
 =?us-ascii?Q?yJ3f0mY5wxhfkQERwh5jF8W5NS4LLh7QALUECaiKvhun2qJTM+iTyVm34QLc?=
 =?us-ascii?Q?6jFtMTBki/6i+lKKBAtKnpguesBOPpfPK/Wqde0vG818joJ8KTiboCPZj8B1?=
 =?us-ascii?Q?GJce5qefQn3ifXk1CiMBU88alzgj8BIeNXVysN3uumeLnEmvoz6wle0/KUt9?=
 =?us-ascii?Q?tWyNwXnHPgD0/HC3KvK8Tuz7fTvHHLy0fNm5vzPTpw2DDuYkzdY+nRRzcJsE?=
 =?us-ascii?Q?PaU3peOkl0f7u8nrF1Y9C9E4F61Ftmm0u70JCds+Ou+feR5BxTSZYiKFOKNp?=
 =?us-ascii?Q?P2BX9pyIjyUeYe8uzcz95DlJ11IcViScYbuwMRRhOVEdyUExAbPaeLgNRg5e?=
 =?us-ascii?Q?TQ=3D=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 967a58b3-d9c0-4c0a-5115-08de2dba1eda
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Nov 2025 13:37:33.9836
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DlSDjcVhWta59aVdFxIUTNkArROkUvyUhxmJLdlVQB8FOsfMr5By9RG2FZczQQsrN9eqkl7hU689jABxj9LYtg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS2PR10MB7480
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 27 Nov 2025 13:37:47 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/20758

On 26.11.25 11:25, Sai Sree Kartheek Adivi wrote:
>=20
>=20
> On 11/24/25 16:35, Jan Kiszka wrote:
>> On 24.11.25 11:36, Sai Sree Kartheek Adivi wrote:
>>>
>>>
>>> On 11/24/25 15:27, Jan Kiszka wrote:
>>>> On 24.11.25 10:31, Sai Sree Kartheek Adivi wrote:
>>>>>
>>>>>
>>>>> On 11/17/25 22:45, Jan Kiszka wrote:
>>>>>> From: Jan Kiszka <jan.kiszka@siemens.com>
>>>>>>
>>>>>> Allows to use the same kernel for all arm64 targets.
>>>>>>
>>>>>> Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
>>>>>> ---
>>>>>> =C2=A0=C2=A0=C2=A0 conf/machine/hihope-rzg2m.conf | 4 ++--
>>>>>> =C2=A0=C2=A0=C2=A0 conf/machine/ti-am62px-sk.conf | 2 +-
>>>>>> =C2=A0=C2=A0=C2=A0 2 files changed, 3 insertions(+), 3 deletions(-)
>>>>>>
>>>>>> diff --git a/conf/machine/hihope-rzg2m.conf b/conf/machine/hihope-
>>>>>> rzg2m.conf
>>>>>> index 0b3acf49..485683b2 100644
>>>>>> --- a/conf/machine/hihope-rzg2m.conf
>>>>>> +++ b/conf/machine/hihope-rzg2m.conf
>>>>>> @@ -1,7 +1,7 @@
>>>>>> =C2=A0=C2=A0=C2=A0 #
>>>>>> =C2=A0=C2=A0=C2=A0 # CIP Core, generic profile
>>>>>> =C2=A0=C2=A0=C2=A0 #
>>>>>> -# Copyright (c) Siemens AG, 2019
>>>>>> +# Copyright (c) Siemens AG, 2019-2025
>>>>>> =C2=A0=C2=A0=C2=A0 #
>>>>>> =C2=A0=C2=A0=C2=A0 # Authors:
>>>>>> =C2=A0=C2=A0=C2=A0 #=C2=A0 Quirin Gylstorff <quirin.gylstorff@siemen=
s.com>
>>>>>> @@ -13,7 +13,7 @@ DISTRO_ARCH =3D "arm64"
>>>>>> =C2=A0=C2=A0=C2=A0 =C2=A0 IMAGE_FSTYPES ?=3D "wic"
>>>>>> =C2=A0=C2=A0=C2=A0 -KERNEL_DEFCONFIG =3D "cip-kernel-config/
>>>>>> ${KERNEL_DEFCONFIG_VERSION}/
>>>>>> arm64/renesas_defconfig"
>>>>>> +KERNEL_DEFCONFIG =3D "cip-kernel-config/${KERNEL_DEFCONFIG_VERSION}=
/
>>>>>> arm64/cip_merged_defconfig"
>>>>>> =C2=A0=C2=A0=C2=A0 USE_CIP_KERNEL_CONFIG =3D "1"
>>>>>> =C2=A0=C2=A0=C2=A0 DTB_FILES =3D "r8a774a1-hihope-rzg2m-ex.dtb"
>>>>>> =C2=A0=C2=A0=C2=A0 IMAGE_BOOT_FILES =3D "${KERNEL_IMAGE} ${DTB_FILES=
}"
>>>>>> diff --git a/conf/machine/ti-am62px-sk.conf b/conf/machine/ti-am62px=
-
>>>>>> sk.conf
>>>>>> index 589f071e..bf3cf9ab 100644
>>>>>> --- a/conf/machine/ti-am62px-sk.conf
>>>>>> +++ b/conf/machine/ti-am62px-sk.conf
>>>>>> @@ -23,6 +23,6 @@ IMAGE_BOOT_FILES =3D " \
>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /usr/lib/u-boot/${MACHINE=
}/tiboot3-am62px-hs-fs-
>>>>>> evm.bin;tiboot3.bin"
>>>>>> =C2=A0=C2=A0=C2=A0 =C2=A0 USE_CIP_KERNEL_CONFIG =3D "1"
>>>>>> -KERNEL_DEFCONFIG =3D "cip-kernel-config/${KERNEL_DEFCONFIG_VERSION}=
/
>>>>>> arm64/ti_defconfig"
>>>>>> +KERNEL_DEFCONFIG =3D "cip-kernel-config/${KERNEL_DEFCONFIG_VERSION}=
/
>>>>>> arm64/cip_merged_defconfig"
>>>>>
>>>>> Jan, I'm seeing a boot issue after this change. The boot stops at
>>>>> initramfs with the following log
>>>>>
>>>>> No tpm device exists or supports pcr_hash 'sha256' or 'ecc' - cannot
>>>>> create a encrypted device!
>>>>>
>>>>> But the tpm2 device is available and the `tpm2 getcap algorithms`
>>>>> command confirms that the device supports sha256 and ecc.
>>>>>
>>>>> It's working with ti_defconfig. So looks like there is some timing
>>>>> issue / race condition when the tpm support is built as inbuilt
>>>>> instead
>>>>> of module.
>>>>
>>>> And there is no other module missing in the initramfs that might be
>>>> built-in with your config? If you re-run the encryption hook manually
>>>> from the initramfs later, that will work then?
>>>
>>> yes. Once after the boot stops at initramfs with above error, running
>>> `/scripts/local-top/crypt` manually starts encryption without any
>>> issues.
>>>
>>>>
>>>>>
>>>>> I'll run some more tests to properly identify the issue and post a fi=
x
>>>>> in here or cip-kernel-config repo.
>>>>>
>>>>>> =C2=A0=C2=A0=C2=A0 =C2=A0 WDOG_TIMEOUT =3D "0"
>>>>>
>>>>
>>>> Thanks for reporting. Finding the root cause will be important to avoi=
d
>>>> that other users will run into similar issues later on.
>>>
>>> Yup, actively working on it.
>>>
>>
>> Is initramfs-tee-ftpm-hook included in the build? That is supposed to
>> wait for the ftpm to appear.
>=20
> Just found out that it's not included in the build. The recipe itself is
> built but the local-top is not added to the SRC_URI.
>=20
> There are 2 issues.
> 1. TEE_SUPPLICANT_IN_USERLAND is not set.
> 2. the initramfs-tee-ftpm-hook recipe has an issue. There is a missing :
> while adding supp-user to the OVERRIDES.
>=20
> I'll send a patch fixing [1] in sometime. I've sent a PATCH on isar-
> users for [2] but I don't see it on the list. Will try to repost in
> sometime if I still don't find it.

I had a look at the config diff again but still didn't spot anything
that could explain the different behavior. Fact is that the userland
supplicant should no longer be used - pulling it in is likely only
papering over the underlying synchronization issue we may still have.

Did you also try with just the initramfs-tee-ftpm-hook of isar fixed
while keeping TEE_SUPPLICANT_IN_USERLAND =3D "0"? If that still causes
issues on your board, maybe you could add "set -x" to
isar/meta/recipes-initramfs/initramfs-tee-ftpm-hook/files/local-top and
also to recipes-initramfs/initramfs-crypt-hook/files/local-top-complete
and share a boot log. I hope that this will tell us more about what is
going on.

Jan

--=20
Siemens AG, Foundational Technologies
Linux Expert Center

