Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACA30CCF9F0
	for <webhook@archiver.kernel.org>; Thu, 30 Oct 2025 11:53:46 +0000 (UTC)
Received: from OSPPR02CU001.outbound.protection.outlook.com (OSPPR02CU001.outbound.protection.outlook.com [40.107.159.31])
 by mx.groups.io with SMTP id smtpd.web10.23622.1761825224466470209
 for <cip-dev@lists.cip-project.org>;
 Thu, 30 Oct 2025 04:53:44 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@siemens.com header.s=selector2 header.b=FYwonCTO;
 spf=pass (domain: siemens.com, ip: 40.107.159.31, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VlWwHrpb0BgPR00jqFfSAAfUuF98rDqdmzm2PhiYwUohUYQnnO2RhQUFzNQ+Ooi/G7kiIPRW9PNvvs4l3Ii5wSl7SAVKeBn1nF8d5UfpGjDM+UabBdqfAMPyYV2YRqeeooalEsqpDO4sMp/EjD7McGZ+8T/N/Mruqq2ezZ8wqXMObXAYpalVDy+zUsfH78NOSExgQW0MTbzC44ac+Oadbo0GamXYfHdjrivXNMhHjdmWuPxy9aWUjGIsV9hveJqFWMy7IicfJS79Lq0yPEoOp9NLQrukJrwho7HK851Ix7YNReMOgQXIDVIgQD+1dvI3nlw2DpB7hbPwaMlpIJugDA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=D5vkmlkz+xTXy5okWzyMAJIG2ZSISlRb+6lVnuLTuf8=;
 b=kPBTHRdV0iHBiNfy03+Ae3cDtHf7litvMslCnDvyxC819WhtakLEM+z8Sz84BmeU07o62fdqV+xuBik0yct71hlWJEro8mUk9ChWXXzU4NtFQTg8Z1Qd29ELUFFLn1Lkh412p0SAXtXkCa6FHw2maqT903UjYC+UhUHlULEXQx2c9tC0pbnHzT479YiMABd9IdqxuZ3ijQu4Ckbl0ENOqBRGVwdiAiHFs8jGO2cCqJdwXndpxWjfFvpMDvWb5UBTR3TEb3C77NFs2ZXHPkAivrP8PvvCwU0OQVAfE7i0PBQpX2t7wHN7uzUcLwOqfabnx8jyxE4D/0+VTFJSZ3QHtg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=D5vkmlkz+xTXy5okWzyMAJIG2ZSISlRb+6lVnuLTuf8=;
 b=FYwonCTOZ1tR91NTFDUZHkEWGkalEegQue5Zw+hBVCeZ6BnoMc3jUfQvdPXIce6GYMOw0M0HLx8sWa3JmlUGjsCKnI01TfmDAmu+zt4G7sTEuFYUWwzPX+JTwk+3slOJWggYu5Km4PsSw+JdAdN4MBL91MfzeejQH38G8wQivLtC23sAiqQFdRNiVXYH/Phu0oChBlxM05USjf24aZx+D7Xb7u8XubVo88LwEBvch/5/+N0sjJqdcAXerko6WNqSZ2uj01+BU58/adG0t/8Jw5IJp8uOlko4fv7U3Afg5pBMj3QrUFA8dy4vB+BiF+BUcQcRuOC5FM/OAa2ritZVQw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by AS8PR10MB6555.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:566::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.13; Thu, 30 Oct
 2025 11:53:40 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%6]) with mapi id 15.20.9275.013; Thu, 30 Oct 2025
 11:53:40 +0000
Message-ID: <08d9a3fb-8db8-49c3-997c-8bd3934617f0@siemens.com>
Date: Thu, 30 Oct 2025 12:53:38 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: isar-cip-core: swupdate process fails on trixie builds
To: "Teli, Ranjana" <ranjana.teli@siemens.com>,
 "cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>
References: <TYZPR06MB758380BBC1865D10C891850F9CFAA@TYZPR06MB7583.apcprd06.prod.outlook.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <TYZPR06MB758380BBC1865D10C891850F9CFAA@TYZPR06MB7583.apcprd06.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: FR0P281CA0202.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:ad::17) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|AS8PR10MB6555:EE_
X-MS-Office365-Filtering-Correlation-Id: fe6de208-cd67-4d1e-055c-08de17aaf78e
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?UAJWFzVdIgWBHW1baz6g9/9OUNuzHOVA71gZeUb/wXGhcKumWYEOkfRVYIO3?=
 =?us-ascii?Q?Jz2qVdYZGP9GcRMGbgzXrAnmsWskueX+eiKTfVvJurt0/UL+1/f7fFt3NvgB?=
 =?us-ascii?Q?S6NOipY27vGFD8MjTBmJMvcStA6vLJRH4INA/8sGwf5p3YRnJ9c3np4wAoqA?=
 =?us-ascii?Q?L53prS7VpEUDNld8Afuhh/UtZm1ryjb3W6gYOj57iVcDobqnjFaBPluDsyW0?=
 =?us-ascii?Q?V43exngBLKnac0UuJMBaxF0hJ9tbgyRjhxx9wGLo21O2K5MqS5I0bTiBEvnR?=
 =?us-ascii?Q?I9aEBL1brxGtJCgA6N/I/BjUwp+rSP9eQfuZl5SHEdMMLY3gZ4d9R2qT/h7p?=
 =?us-ascii?Q?LaNPSop+GOXSdeswssugsHCt/tZMCT1W6CSSgUKDoyD50uMP6m6LJI/Zmk3b?=
 =?us-ascii?Q?JV0Ba7sXuCbcQHsBEbS+4WhIe3+Rbn5UJMxq0xePTC+GGaN3KIJKz967nGbj?=
 =?us-ascii?Q?6aiQAmclnyjPpCdRTKgQNMO+o145jndjSfJbVtsPB/fchbG2sFrcwigdOfQm?=
 =?us-ascii?Q?HGU1/EcDAcNg7I6P3Wb9+1vDZjt0XKgEAGu56aHA3ahHYEfTJCm088YLe5pT?=
 =?us-ascii?Q?EWY3u22IuCR5Sb67rriW90azCamEDVor4YVcqkfgpj9KUE/hyf6kbZTmqF6g?=
 =?us-ascii?Q?PqXr7nD6R27Pi7cWa5omD0KKcY2FNfhNzdWsC3yVM2mK4SMd/ILteJwgHWZZ?=
 =?us-ascii?Q?u/VvcB3kLH43LQvOmO/VQI65ql6/KUz8KD5FJ0pj66ZaiqFp0KDJpZzwOlQ8?=
 =?us-ascii?Q?IwOzK7Q5pqGzXxuop44Beeu+MCA1BPULiUAniWSHIVk5vzNqbFVPDLldScal?=
 =?us-ascii?Q?WmtRsPFjsnv/JekKM/3czDL4AaMZCFe2WQpM5ORgVK05eTDEYM7xA4itXJ0h?=
 =?us-ascii?Q?nfra14UJRHJEAxaDQ7h6Rb3ct6osrdK3if7Snrw4j8pfOqAbZKnsU4W8Q3po?=
 =?us-ascii?Q?fWZ/hub3t+vIZRG97TocOXUZ3E+y5fx3n18qaQo2f+b0BalviUbiWnZBbpAl?=
 =?us-ascii?Q?nx/r0hanir1mKRsBN6yx3AJhW0QU4NScKZUZwiG/iQu3tb+jTc6LcoA2GNKm?=
 =?us-ascii?Q?yYftUMXs2ypHBqbB9HS8K0O0ZM9F8p1SUMdVglklrAdjXmkx3DgiH7wzM/yU?=
 =?us-ascii?Q?rbCO22S0m/Bvn9P1rZyX47cazuA0x0PcLwrMZxDunWzSb/XemLmd3ybvxs3Q?=
 =?us-ascii?Q?o3HayUu769d7G1IYMp1Fp+ZHrqcxxqRGMxcEXO20/CLgXshrzesZ7HFTxsRC?=
 =?us-ascii?Q?xnUFO2zC0oXC2oIZQEoCy/pzlM92j5aCKEGHQWEvill8TNC3Dzy5ubOBm4IS?=
 =?us-ascii?Q?CGpawK6mB0E1eqR4U/xKwjxPaNdCxsWVtLc/aBfUX+uL4ZfzBb3fOegKoyG9?=
 =?us-ascii?Q?uzPFf2CD5kMuLmghhoQ3AwGrooZveEEJktCVZOpzGwRQ4bkbbl66GrrlDLc1?=
 =?us-ascii?Q?OCvoiSejRzUzI5QDp1YpGqz0GWaZ3+5BmlEcsa8QEfPJhipA3Xowsg=3D=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?tmYjyZc0jjp1Du6eaRXbI57sOCYeJXHmdCudzRXo9jCWB28tZfoP+62SXaLH?=
 =?us-ascii?Q?A+vUIVPWWYi2/LUS6IPOEadfCM0mw6xYHxxh6MDXwrvXEVO0fcpUOkJfti0L?=
 =?us-ascii?Q?ZVVLFoPH69RjjufUFS3mTDPsEQpMZF4sC20/WF4K9nWKnE2aWX8G7gvmLF8e?=
 =?us-ascii?Q?sg7UHjQBZcL/rs3IbTevs7PaPmVQ/AUm149U7bR2guGgBXpvRfse7rjV8pDF?=
 =?us-ascii?Q?jWF32nlKhTeXN5SJXVSuanWuwXh6Hrabi73j5X/3na19gldPxwo0KrvWUmEh?=
 =?us-ascii?Q?NL7/4AC3PXp1S/fjIvTc65QL8xZ5I58YI1FOK/XNbk+uuuf5wrcXEKKztUzh?=
 =?us-ascii?Q?6YsGHFpJ8yraM3RqkEEskkkfoOuqcnpamT96+gLd8vIB/U0ozuVbsbUW5rh+?=
 =?us-ascii?Q?L3A+ACwXLltfhZA/WYYEMQAH+NXHw4SpovPKdbZqjx5WlVupJZpd5LU4P+Gx?=
 =?us-ascii?Q?pOYfLvlkAN6Y6Tt56s26fN8vXmwLSl9zrtaWlKPlGbK494+jj+RVSFIic4l1?=
 =?us-ascii?Q?boNN7OjgaggqWRCCo+CiDSTfPzf4sLvtzt5IxJANPXx+8gETjCJ3wrn167jY?=
 =?us-ascii?Q?valZGmeyXaelX1u91XHGw7oDPMlNr1LCKOqxnh2lDtXLpnJ3jW4VfEk4SQfu?=
 =?us-ascii?Q?xSj6jpgF0C0sCh+Bi3Sf+5y6YDOcGUapbCiXhJ5URwJ+9SInkOa960I/Wlez?=
 =?us-ascii?Q?e/nxJLfnSHhLeBXLg6y0uaWGsfaN6Y1tdDcev3dfJIr7nIumBs0YTzj7VNtD?=
 =?us-ascii?Q?IdoOmprAD6EJuF5h9nePr/7FdK7hS0J+rGsn7r1Y33GdpdV0mMBRLPo4Q2ou?=
 =?us-ascii?Q?IV3bJheFdfjMW8x6+S6ErelD2D0TgTyPNDhlwOEs2run8aTOwIKRpovIYevY?=
 =?us-ascii?Q?NuWoDnKe9jpNDZC+EV0EdC7hm0M+EnQQITZt1t/i38yGuJaRJGZOM7Mfgymy?=
 =?us-ascii?Q?5MtqWcJew9DgjPLg48LqMcJyRFNZ1u98zZVj3JLlSQHvYHhhFGozIDaBU8I5?=
 =?us-ascii?Q?kl0OIIrnNOPp3vIzidznGOJj644MGnJ5wW0H7//8j7MWexWkBRRAd/pfOdq6?=
 =?us-ascii?Q?kJjAQO1p29o2qcYbRdpJIzVl4XLaatamiQUMLYx1eJcBAb3Dt7jDjLnYqdkM?=
 =?us-ascii?Q?G5EWO/Dki7lV/R2mzEAhhR8oBVKTM9u1og5oLuPJbgfbSWnQh3gsieltjYrk?=
 =?us-ascii?Q?uzooq5O47z3mSrlnNIIlBcdxYWZD5TFlYQWn+Umirx7KqTA5ODUNLlsSCqTc?=
 =?us-ascii?Q?uvOXzZEmdhnIbYDQoe6Qj/cTRVsxbNsdkcKyvPWGKvUFyT0/11yOyxnaBPNJ?=
 =?us-ascii?Q?QJWt+4/5wWFlKWJ8nSJ/WY1D7rg0iEuCP9OJrujNZnLz82ItyDO47BIDLs04?=
 =?us-ascii?Q?b4w26Ff4VFqpOuPU1S9mB8MNk2c2UNYmDngnSzUVBvl1A+NFtPWpg5rfuu3C?=
 =?us-ascii?Q?7aaoqpJ3jEWdELN923xusq2OcbCle3PjOACkVqsHk1ZNlnmclaCXsngdPclJ?=
 =?us-ascii?Q?f5ZIsuRlRxUVf4zp119la2qq+nhJMoP5g2YUOoOL2YiEHVcrPu+AMe+TFWJL?=
 =?us-ascii?Q?CenzX3GWJVPPY8/j5c2SdAx8Jug5Zvt6Iss5FMaNRksQpx6pj5SU/Ot43B19?=
 =?us-ascii?Q?JQ=3D=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fe6de208-cd67-4d1e-055c-08de17aaf78e
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Oct 2025 11:53:40.0627
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: c149QFfABX0PrDNwN3BRBnoPe/czCLBM5YFSULxGfnSC+b2w1y8bUPWcmY5UDkj+Q1nR7tQOsqZyhIW5kcNKAw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR10MB6555
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 30 Oct 2025 11:53:46 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/20285

On 29.10.25 10:56, Teli, Ranjana wrote:
> Hi Jan,
> SWUpdate on trixie builds failing with pre-built Debian's SWUpdate
> [ 2024.12] package.
> *Steps to reproduce:*
>=20
>      1.
>         Build the base image with SWUpdate feature:
>=20
>         |$ ./kas-container build kas-cip.yml:kas/board/x86-uefi.yml:kas/
>         opt/ebg-swu.yml:kas/opt/trixie.yml|
>=20
>      2.
>         After successful build, copy the image artifacts to a separate
>         location:
>=20
>         |build/tmp/deploy/images/x86-uefi/cip-core-image-cip-core-
>         trixie-x86-uefi.wic build/tmp/deploy/images/x86-uefi/cip-core-
>         image-cip-core-trixie-x86-uefi.wic.wic.bmap $ mkdir base-image $
>         cp build/tmp/deploy/images/x86-uefi/wic* base-image/|
>=20
>  3.
>     Rebuild the image with the rt kernel as part of the modifications
>     for the update-image:
>=20
>     |$ ./kas-container --ssh-dir ~/.ssh/ build kas-cip.yml:kas/board/
>     x86-uefi.yml:kas/opt/ebg-swu.yml:kas/opt/trixie.yml:kas/opt/rt.yml|
>=20
>  4. After successful build, the update image will be available as:
>=20
>     |build/tmp/deploy/images/x86-uefi/cip-core-image-cip-core-trixie-
>     x86-uefi.swu|
>=20
>  5. Boot the SIMATIC IPC device with the base image and apply swupdate
>     with the generated update image
>=20
> *Result:*
> The SWUpdate process failed with *|"swupdate_async_start returns -1"|
> *=C2=A0error message.
> Attached file is a detailed log of the observed error.
> *Findings:*
> The same update process was tested using selfbuilt swupdate as done for
> bookworm [ *SWUpdate 2023.12*=C2=A0] on the *Trixie*=C2=A0build, and the =
update
> *completed successfully*=C2=A0without any errors.
>=20
> Regards,
> Ranjana Teli

Just for general reference: This issues is further discussed in
https://gitlab.com/cip-project/cip-core/isar-cip-core/-/issues/135. It
is probably an upstream SWUpdate problem (and then a Debian backport topic)=
.

Jan

--=20
Siemens AG, Foundational Technologies
Linux Expert Center

