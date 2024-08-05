Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8F0EC3DA4A
	for <webhook@archiver.kernel.org>; Mon,  5 Aug 2024 15:04:07 +0000 (UTC)
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (EUR05-AM6-obe.outbound.protection.outlook.com [40.107.22.66])
 by mx.groups.io with SMTP id smtpd.web10.10176.1722870244063145690
 for <cip-dev@lists.cip-project.org>;
 Mon, 05 Aug 2024 08:04:04 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@siemens.com header.s=selector2 header.b=gc6OV0tY;
 spf=pass (domain: siemens.com, ip: 40.107.22.66, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=F8Lf/W9KKaJArnPa2QHwDoxentXxjpfNUTGTeJNwQ1C24pMAN+OeMEaKXk+ZK369Vr4EJyEWQBa2xKhJ694mOfd+SSd7mcSYUxPr/TDsHSIJWI2EQwyugXb/vn1vlpYB960GeRdTNpU8+aZPUQOJCY3mVjHB9Zg+sUN4Jk2bTkZ0sqCDoaoRsnxFEl2xrHYyfIRerEDJ9BM6HmfIsx6Xiv5bV4Vqp2nig4J56QNvytSx0rCJ6sATaGcKaQlNavADk6ohzJgbHhUKd+ji9/RhHmL86isMxMOWhXMwRNkIMocJVYCC/5b2qxkW147Uaqu7t5h2ONBqfTwyOXC5xAjV4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZU7CL9KV6XV1kwNv8h5PwHzI+7OBOcIUbBEcZd1qJcY=;
 b=LyjvvpHtzgHQwhWBVPykdHEp0PJfUGMXTkFM1Ng3OmBthlB+VTDEc4yMqPkbsH8uRu/zSgsJohDzLhPTjOW916X2yKrOJHpRKB6WYCrrT59EINDi/M8CkthjijFdSuu1J4RTx/Jlp3iqrYhzmdaAXqSoyLVet9dqm8gWCG0kaqXFo8/kDnVhyNwlsXNWxwPx0swzKkkU08xms4GUom8awad5ObZxnwySk+QkcjrABKxZ/lP6tmDTXsAOpeGwuqFOEZ75LDN5LiRBSBod79uljwMp7dbfxwwZYXFGEA46pT9Tk61mbDA+crBy4UdeN/Br8aOMWRN9BvdqoFh0zk32mQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZU7CL9KV6XV1kwNv8h5PwHzI+7OBOcIUbBEcZd1qJcY=;
 b=gc6OV0tYGyEhoSB91mfYjMuwaa4X7M/Tt3nVObvrmeyAzugQ+SPwqgyV+jwik8XdOlCgtpccg+VeCdUupAxAioEJpV1hCgqHHVF0DYdNTbO9zKsoiLjo2jwNdb50z9ETx6bRjcjyyMz7Tx1GoHHJj7JTBaOi/VBnBJp3E3S0kNh7GN71QOY2GrKyMg/xbu1Z+Pc7/et9bMMMWFhpcVvzUNmxtF15WAunDZgqhCLGFsx0ghmyxEinwbBeqo2f3LUxmNAjvWF9l4FTwlneyCc7PIXdi73rySr+peJ1rRq7KFJIZVPS2krsxrYvfRdIyRhvbia4MB2BUxvo9PybmqFTQQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by DB9PR10MB5931.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:39b::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.25; Mon, 5 Aug
 2024 15:04:00 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%4]) with mapi id 15.20.7828.023; Mon, 5 Aug 2024
 15:03:59 +0000
Message-ID: <38219e54-0ecd-4a5e-86d3-3d90b2c2a09f@siemens.com>
Date: Mon, 5 Aug 2024 17:03:55 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] README.m-com-x86.md: Add hardware details
To: "Schilling, Benjamin" <schilling.benjamin@siemens.com>,
 "cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>
References: <17E052EC654FA61F.30444@lists.cip-project.org>
 <GVXPR10MB58372AC0B85BE9E5DF0E0D3588B72@GVXPR10MB5837.EURPRD10.PROD.OUTLOOK.COM>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <GVXPR10MB58372AC0B85BE9E5DF0E0D3588B72@GVXPR10MB5837.EURPRD10.PROD.OUTLOOK.COM>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: CH0PR04CA0004.namprd04.prod.outlook.com
 (2603:10b6:610:76::9) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|DB9PR10MB5931:EE_
X-MS-Office365-Filtering-Correlation-Id: 7987bce2-38ba-465e-50eb-08dcb55fd5fd
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?2murwoEgHoD9xRuSZjrtqUYwKTmOc2n0hEmU7hcsWIV1VaAUQmJFK6zMuvUc?=
 =?us-ascii?Q?OaiYysMQNbgM0p+2MgYst7sqEdRTfSSOryYcSPg3F5LHlRhAB/d+J69oN8zS?=
 =?us-ascii?Q?t+UhhB3nFGZL6DTwYNsHQQMKU+xce1HvhRDRaGZ+6ThOdR6+B6V09biWX8/B?=
 =?us-ascii?Q?dZoy7wgbyHjxAe328FGh6ivoiuYdWNS0Eh4aqaNC75gv4JsyIo7gGIVT4oMc?=
 =?us-ascii?Q?bBz5nXQAZOSoBA7Xljz9k3aj4R9pIc65zEVMn85ZEua5ndeZLwcBfm0Aa6qg?=
 =?us-ascii?Q?/RhxsSgLeFpubHC+OiYrQldspAC4+FpkBt6Em3PyPNpXIy4KxaAMKwJmfuB5?=
 =?us-ascii?Q?h5tiXPW50CZlzvRuxwGft+qjyYV+LfkYHGLXGrGAbKj7CqMCaOTlnQUmIiK2?=
 =?us-ascii?Q?JWJNlm+94xkwXoajSAEfdR75XS4PxjF0jvAMjXB5w/YvO42fTacmqaCm4l+y?=
 =?us-ascii?Q?9tmxxaLqKYgooqdUnQRI663L9yku3i+tFo/KX5Fu9GgopMWxHJWLQMqmvTY4?=
 =?us-ascii?Q?JXIvJIH4Zfejnatedzkplpx4pkKseLf9v5ntVKpif4Dj2tlVf87X9iZqzErM?=
 =?us-ascii?Q?SPk13tZ7Zd39TX7Wqkd5C9xvdhVL4XGgX/YusSy3H2ptWc4EDjvEl+s+iwxe?=
 =?us-ascii?Q?soUyYGca4DmtFjI+hHvuBoOZn8G2RoPhkX3symGb1oHDxr80znP7+jtFewOX?=
 =?us-ascii?Q?Y1VKx/8ydNMKuhW+/7/WCvMGU/niAPGsFIUyHsILl3s0Fd7WakR5oLhtGqUZ?=
 =?us-ascii?Q?5+1exu6lR5Oo0WgEWTByfC5/WReiopmRHZ2W4f2BfrWBmPvlZ2zLSQJgkSaO?=
 =?us-ascii?Q?7Bf3CYX22GhjX/neRIzvwQHmBiKeRTG1AJ1hgNYBe84IlzA78nzdBf6OfgUv?=
 =?us-ascii?Q?O42ub76NwdFlLnouA3mfY5JM0UIt/dIxuoQGme4riJDyeJ9+ok+HZ+ccTb6u?=
 =?us-ascii?Q?J2fphvL3lx2T5IMT/0G34VduK/h1HQYWD7zhqU0zSCQMPeRdiCLpCXkiWzrI?=
 =?us-ascii?Q?uQ+qZwtWCvM7g04qHtdxsawfMJ9NKWoM513cGf9CokT4qyaetzSjMExwcg9x?=
 =?us-ascii?Q?1m4oF67F88qCi6JrL3ONdnZf6hpdd0HMuKpWmfbGferqYMQwgIqfgbTKdcVl?=
 =?us-ascii?Q?Tw0ERIJIa0LAVOtRwClaj2JQcPpRZuuC0wijXS4OMFbV5FvNFMMb1ycSA+xP?=
 =?us-ascii?Q?TCrmbuzTXhlP/439nzLhW57r0UbInRquSr9dSMlFBOM6oeHaj82/qvQXfV8x?=
 =?us-ascii?Q?7+6Z5JbVB/ga/yWaKgwkEype6hfhT6PFCZBT83cS3UR/M55iwWr9xkRoiXFh?=
 =?us-ascii?Q?enyHouT96cT3RtxOl7HPRBskqRrxYkLy5rFoYoqcFcw1kA=3D=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?jXwre44yKNjkn/hn8Iy5JLgbY2J73zin32L2y41w0mMIGFzhIfxgawsrgQL7?=
 =?us-ascii?Q?l8/baQD2GDUBVM06Zoy3LtUkk00BJIkkyoJjCREUlTFlD3ApOX3gUGndA11i?=
 =?us-ascii?Q?4WQJyO5orVRe97ALcvY6URPU8sIpHZ9KzFpUcTKyGOgIqvf6jh3uz9bV9OdY?=
 =?us-ascii?Q?OjESnJ16AQ39jMQqAvudmWrQ/rhhUzGPvGiYhJxIaj9LSe/Vsi0gd+i+RIeL?=
 =?us-ascii?Q?gft/IZ5rtMYc5gVSTncK8eWv00wn+keLNLvCeBQIOO83OQQNOafQntrS8ZVO?=
 =?us-ascii?Q?dPZsWU3RI7FY/WJ4OVk0Dd4G5JkEmog8QGHJEuYCXabkCrE5ZJHKW+FFGoaD?=
 =?us-ascii?Q?d6zkKR+Gwyah5JhYwCBGYQHTH8sNd50byfr804coqnO/AQGVW36o91tMWEtR?=
 =?us-ascii?Q?GKduaSzAbJek5zj7azLE4rzgolFChP3MgaovJUt4A7zp6x6Axub3rPZldcff?=
 =?us-ascii?Q?g8cPxLgK+NZtLprSw7R4AAm6KFSL6e9o1KrznlyDtselM9YZrjS5WaJZHY1o?=
 =?us-ascii?Q?6DzV7sSCjj1dfOasW9OIxcqTHWTMNI/55hYk/pCy4aKMeDmXfDPcSDgfgUs/?=
 =?us-ascii?Q?oMIvh1MDWA7pBQ/fYIMRp5jpwlj9+au+YtFH/8sPQbFV/wLXR2VSDk2mEd1Q?=
 =?us-ascii?Q?e+0sVFCo+QQLnEL/U2CFe+RoL55xMLDcYyo4LjsbPLeCU9+GcmrGu2HFQnEJ?=
 =?us-ascii?Q?/ZSjF6ej8DW7tHxShUjVFrV7q2llE/TzO0GUqQKgkeWszN4lmBOgHRnfWXqG?=
 =?us-ascii?Q?GomV9AJdzSJgvJKgEJ568AL1WrSZL3LbBzgsorBHanZ30oltaXuRmaxB6ldG?=
 =?us-ascii?Q?xM6yseKKsKmKN2CA4nLqhQ/UIVDwt8UNecvMAbTdqCBpzGqOrINCFbg+0COS?=
 =?us-ascii?Q?KtJfJ8pnrFrOJxzzG4I0OYL+6CPTcIe5Z6uxw6XqkGLTBlvo32cgPbtLZun8?=
 =?us-ascii?Q?VHx0WysAtKcpYfyq9YHtzYpNenFSVdABleloqxhIo4nnsPPTOdv7HVCE4wGP?=
 =?us-ascii?Q?Mg2metZz23MLwUkHkCV5V7mCbl2Lo5JnIqarLC2FammTSJ/zWyPZPK4ktU67?=
 =?us-ascii?Q?WOnugSJEQuOTvEmsXNqmo+S4zcvAuE7aDX4hX+OnkmzrpoSQmZts4lva1k3m?=
 =?us-ascii?Q?0GF9OaTc+SZKuojT0iyQaGfZDkD26ivYMBk0+S1r3KPvJ+7/idu6mRx2UwoT?=
 =?us-ascii?Q?r4ldJNwpR0y+8RJ6lxxeJDCuXhRZWHzJrTTYdvjePTLyyU8kSH+onuxT6zzy?=
 =?us-ascii?Q?VcdBo2JaYPhsbzpf6mvmd17jaCgRYgp6uCN7PHS5syfqcFP7k6+jFUY68tLX?=
 =?us-ascii?Q?Loquo91Roio99VFD8aoDFwt16G2NCxG14bqkYjiOg6GEmzzSE5ut+yFvVL8M?=
 =?us-ascii?Q?A4tlqM1aquF5QdLBB/zmtDvZmLxJL/JmCfvNwRZQai6LosfC873lMcLRaFW1?=
 =?us-ascii?Q?15DPyCzsoz7wiWHjogM4YsCqxbeHfRcOT9DZMxOP16TWfGOLj7NuOgvfWsXn?=
 =?us-ascii?Q?o5mPT52QnQjssbiPknLjjCxla+YsqYlmlxl+A6oYhAXc+ovPzZysTxzuUxdy?=
 =?us-ascii?Q?Bib063htyzpjMazY4aGCGcBGR8xpzEs3SAokidJDIV+cc3oaEle+hsgEAfQc?=
 =?us-ascii?Q?BA=3D=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7987bce2-38ba-465e-50eb-08dcb55fd5fd
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Aug 2024 15:03:59.9246
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XjACVdapR2c/4UzxZ+Y8O4BS1lvIVKD4ws6ynyAmBTvE/BlcSdXU2NvDMbIm5k88aywfH1bavDIkDDFwWxx6kQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR10MB5931
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 05 Aug 2024 15:04:07 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/16719

On 29.07.24 11:09, Schilling, Benjamin wrote:
> Hi all,
>=20
> what=E2=80=99s the status here? Anything I should change before it being =
merged?
>=20

Yeah, there were/are multiple issues:
 - missing [isar-cip-core] tag in subject made me miss this
 - you sent the patch as html - please don't, use git send-email or some
   suitable(!) email client (*)

Jan

(*) If you have Siemens-specific SMTP issues, drop me a note, there are
    solutions.

> =C2=A0
>=20
> Best regards
>=20
> Benjamin
>=20
> =C2=A0
>=20
> *Von: *cip-dev@lists.cip-project.org <cip-dev@lists.cip-project.org> im
> Auftrag von Benjamin Schilling via lists.cip-project.org
> <schilling.benjamin=3Dsiemens.com@lists.cip-project.org>
> *Datum: *Montag, 8. Juli 2024 um 21:17
> *An: *cip-dev@lists.cip-project.org <cip-dev@lists.cip-project.org>
> *Betreff: *[cip-dev] [PATCH] README.m-com-x86.md: Add hardware details
>=20
> From 4e6b957569e0a4dd617cc1f4fd716c769681f6dc Mon Sep 17 00:00:00 2001
>=20
> From: Benjamin Schilling <schilling.benjamin@siemens.com>
>=20
> Date: Mon, 8 Jul 2024 21:00:14 +0200
>=20
> Subject: [PATCH] README.m-com-x86.md: Add hardware details
>=20
> =C2=A0
>=20
> Signed-off-by: Benjamin Schilling <schilling.benjamin@siemens.com>
>=20
> ---
>=20
> doc/boards/README.m-com-x86.md | 131 ++++++++++++++++++++++++++++++++-
>=20
> 1 file changed, 130 insertions(+), 1 deletion(-)
>=20
> =C2=A0
>=20
> diff --git a/doc/boards/README.m-com-x86.md b/doc/boards/README.m-com-x86=
.md
>=20
> index cbd74ad..d677b76 100644
>=20
> --- a/doc/boards/README.m-com-x86.md
>=20
> +++ b/doc/boards/README.m-com-x86.md
>=20
> @@ -1,4 +1,73 @@
>=20
> -# ISAR CIP Core: Instructions for M-COM RT X86 V1
>=20
> +ISAR CIP Core: Instructions for the Siemens Mobility GmbH M-COM RT X86 V=
1
>=20
> +
>=20
> +## About the M-COM RT X86 V1
>=20
> +
>=20
> +The M-COM RT X86 V1 is an industrial grade PC.
>=20
> +It is designed to be installed on-board of trains and can be used for
> communication and processing purposes or as a security gateway.
>=20
> +
>=20
> +## Hardware Specifications
>=20
> +
>=20
> +- Intel Atom E3950 CPU
>=20
> +- 8GB DDR3 DRAM soldered, ECC
>=20
> +- Trusted Platform Module V2.0
>=20
> +- 3 Gigabit Ethernet ports (M12 X-coded)
>=20
> +- 1 USB 3.0 on front
>=20
> +- -40=C2=B0C to +70=C2=B0C, fanless
>=20
> +- EN 50155 compliant (railways)
>=20
> +- 16 GB eMMC storage
>=20
> +- Input voltage range: 24 - 110 V DC EN50155
>=20
> +
>=20
> +### Power Plug Pinout
>=20
> +
>=20
> +M12 B-coded Plug
>=20
> +
>=20
> +| Column 1 | Column 2=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |
>=20
> +| -------- | --------------------------- |
>=20
> +| 24-110V=C2=A0 | Edge triggered power on |
>=20
> +| GND=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | Not connected=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |
>=20
> +
>=20
> +#### Powering the device
>=20
> +
>=20
> +The device must be connected to a powersupply providing 24V to 110V
> output voltage at the "+" and "-" pins.
>=20
> +The "switch" pin is used for edge triggered power on.
>=20
> +It can be hardwired to the power supply 24V to 110V to trigger power on
> of the device.
>=20
> +
>=20
> +### LED Matrix:
>=20
> +
>=20
> +| Column 1=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | Column 2=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 | Column 3=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | Colu=
mn 4=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |
>=20
> +| -------------- | -------------- | -------------- | ------------- |
>=20
> +| Power STBY=C2=A0=C2=A0=C2=A0=C2=A0 | Power ON=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 | WD-Trigger=C2=A0=C2=A0=C2=A0=C2=A0 | Error 1=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 |
>=20
> +| ETH0 Link/Data | ETH1 Link/Data | ETH2 Link/Data | RS232/RS422=C2=A0=
=C2=A0 |
>=20
> +| Module1=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | Module1=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | F1=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | M.2 Used/Data |
>=20
> +
>=20
> +Power STBY (Yellow):
>=20
> +- Standby: on
>=20
> +- Powering down: flashing
>=20
> +
>=20
> +Power ON (Green):
>=20
> +- Operation: on
>=20
> +- Powering up: flashing
>=20
> +
>=20
> +WD-Trigger (Yellow):
>=20
> +- Trigger pulses: flashing per pulse
>=20
> +
>=20
> +Error 1 (Red):
>=20
> +- WD-Permanent-Reset: flashing 4 Hz
>=20
> +- WD-Disabled: flashing 2 Hz
>=20
> +
>=20
> +ETHx (Yellow/Green):
>=20
> +- Link: on
>=20
> +- Data transfer: flashing
>=20
> +
>=20
> +Module1 (Yellow/Green):
>=20
> +- Module-specific
>=20
> +
>=20
> +F1 (Yellow):
>=20
> +- Controlled via Software
>=20
> +
>=20
> +M.2 (Green):
>=20
> +- Module installed:on
>=20
> +- Data transfer: flashing
>=20
> =C2=A0## Build the CIP Core image
>=20
> @@ -100,3 +169,63 @@ After boot, check the dmesg for Secure Boot status
> like below:
>=20
> root@demo:~# dmesg | grep Secure
>=20
> [=C2=A0=C2=A0=C2=A0 0.008368] Secure boot enabled
>=20
> ```
>=20
> +
>=20
> +## Internal interfaces
>=20
> +
>=20
> +The M-COM contains an internal serial port that can be used to access
> the devices kernel console for debug purposes.
>=20
> +
>=20
> +To access it, the backside of the device has to be unscrewed.
>=20
> +Afterwards it can be connected using a Mini-USB cable.
>=20
> +Make sure to have the appropriate FTDI driver installed.
>=20
> +
>=20
> +## Software Interfaces
>=20
> +
>=20
> +The following chapter describes interfaces accessible from software leve=
l.
>=20
> +
>=20
> +### Controlling the watchdogs
>=20
> +
>=20
> +The M-COM RT x86 contains two watchdogs:
>=20
> +
>=20
> +- Custom Hardware Watchdog
>=20
> +- UEFI watchdog of efibootguard
>=20
> +
>=20
> +The UEFI watchdog is controlled via efibootguard variables.
>=20
> +It can be configured for both partition sets using `bg_setenv -p
> <partition number> -w <timeout in seconds>`.
>=20
> +To confirm the new watchdog configuration use `bg_setenv -c`.
>=20
> +To disable the watchdog set the timeout to 0.
>=20
> +The watchdog is fed via `/dev/wdog`.
>=20
> +
>=20
> +The custom watchdog is controlled via I2C.
>=20
> +The following scripts can be used to control it.
>=20
> +
>=20
> +Enable watchdog:
>=20
> +```bash
>=20
> +#!/bin/bash
>=20
> +
>=20
> +# i2cset <i2cbus> <chip-address> <data-address> <value> <mode>
>=20
> +
>=20
> +# i2cbus=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =3D 2
>=20
> +# chip-address =3D 0x3c
>=20
> +# data-address =3D 0x00 (Status Register)
>=20
> +# value =3D 0x8000
>=20
> +# mode =3D w
>=20
> +
>=20
> +# enable watchdog
>=20
> +i2cset -y 2 -m 0x8000 0x3c 0x00 0x8000 w
>=20
> +```
>=20
> +
>=20
> +Disable watchdog:
>=20
> +```bash
>=20
> +#!/bin/bash
>=20
> +
>=20
> +# i2cset <i2cbus> <chip-address> <data-address> <value> <mode>
>=20
> +
>=20
> +# i2cbus=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =3D 2
>=20
> +# chip-address =3D 0x3c
>=20
> +# data-address =3D 0x00 (Status Register)
>=20
> +# value =3D 0x0000
>=20
> +# mode =3D w
>=20
> +
>=20
> +# disable watchdog
>=20
> +i2cset -y 2 -m 0x8000 0x3c 0x00 0x0000 w
>=20
> +```
>=20
> \ No newline at end of file
>=20
> --=20
>=20
> 2.45.2
>=20
> =C2=A0
>=20

--=20
Siemens AG, Technology
Linux Expert Center


