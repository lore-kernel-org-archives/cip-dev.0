Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F192EC27C4F
	for <webhook@archiver.kernel.org>; Fri, 21 Jun 2024 19:48:22 +0000 (UTC)
Received: from EUR03-AM7-obe.outbound.protection.outlook.com (EUR03-AM7-obe.outbound.protection.outlook.com [40.107.105.52])
 by mx.groups.io with SMTP id smtpd.web11.82753.1718999296447689790
 for <cip-dev@lists.cip-project.org>;
 Fri, 21 Jun 2024 12:48:16 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@siemens.com header.s=selector2 header.b=EanF2Oy5;
 spf=pass (domain: siemens.com, ip: 40.107.105.52, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZuZASFc4TwU5le3NoYOON0sg6LcD/Hf1nxEKlg9C21JEfdZX4Ec0JTG6Wbe5KQm3rHqvQNAEJd3gh7ob5n8mYp+aAqjQoItyHpCz3tO3TJqtiDp/ghW2GJIbCfm8fD3ThLTfsMJckIhptexc+xyrgKSgJuY5TupTFlIDu13aQoqfiH1GgTSH/UMuIusr8DPDai/VD3LeqHv9X2lNRCs/bgBbk8tck1933vZzI8iBqN9vSFzv01/681CzZ9yb1MQiEMJPXzuZ/TOoY5j/yNTwTCB8MM99L8k+gQGvr7wdMJAErti04r7OEriFYw1kNb659MI2MEDo507JZMkA9puLHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GWKt/hWlMF/mDKO3mzrNkvLR2VLu0CpWOzaX3NjwEeo=;
 b=HJlUyDflWGnJRoWhtoJqvxov1FdOURPHEzdxZa4p18XDroP1dX4jRJp6h1wWohHx8BJjJLKHBNrKbSLkCtNlFnZs0i+wWJ8m3YZoIVtDFD7zuTCyqauLrlQ1P+81Kr9qKdcvGm3sabj2xwX0gF4dlPSbPbS2Atp+6UmHAu5tWTBM+NPdNTBKIh63OCpaDrU3jJjeuH4EfzPde6M5mTnsHMs8hhUvqsfYNiQBFN5PTTla2wVEVKBoTihet07FCgMBWRP9vx0vdeMwSJhC94lkBi0pThF+GWCexrhqllviBjr7weoLPFaIlYzpRYfSeN52MrQ9K5jDukHHEtgdJMXSfw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GWKt/hWlMF/mDKO3mzrNkvLR2VLu0CpWOzaX3NjwEeo=;
 b=EanF2Oy5/aqmM98oJZJ1W+hVq7ufR9/FsInYyxVS1KEbbhFBdrJrbGQQwZQ2ZvG658Nejx2k4+IMrQkGliUWmhaAOik9zjn26N0jKTvoXUUR1fg7OgEy0tqkbf+Da7Gt+7MoytIFMh7K30nrDhfLiCvGI5QnioLIvMlS1CIeL/WGgIyBlsYDhI9lst7Xe9xdC8xmuY5AviX5oLzxKrAeksJTicop/Uz4/E+3xyLiU4D16STvjH6/B7vzSEm0dbPSns7vR1qiKxCLegTNH6HQm9K5/w60Tcj5oTbPON2B7sGTKfYf4ApsoVoyF2xcY9gJyZ/RbRopheuLmCTX2GsZkg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by PAWPR10MB7151.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:2ed::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.19; Fri, 21 Jun
 2024 19:48:13 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%7]) with mapi id 15.20.7698.020; Fri, 21 Jun 2024
 19:48:13 +0000
Message-ID: <9c2c2d42-142b-4afe-be63-7afadb7c6c9c@siemens.com>
Date: Fri, 21 Jun 2024 21:48:11 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [cip-dev][isar-cip-core][PATCH 1/2] doc: Add section howto
 generate the a efi auth file from snakeoil certs
To: Quirin Gylstorff <Quirin.Gylstorff@siemens.com>,
 cip-dev@lists.cip-project.org
References: <20240621105215.2233044-1-Quirin.Gylstorff@siemens.com>
 <20240621105215.2233044-2-Quirin.Gylstorff@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <20240621105215.2233044-2-Quirin.Gylstorff@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: FR3P281CA0173.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a0::15) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|PAWPR10MB7151:EE_
X-MS-Office365-Filtering-Correlation-Id: 2d6d1a1c-f1c5-4de5-969d-08dc922b15f6
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230037|1800799021|366013|376011;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?qxGNx06vbf3PseZbzcOpuRghB9pvaswNb93QpsT5XPvjlgRnbVlxOF8OtPPU?=
 =?us-ascii?Q?rmLVyHMequUq73YbggbyPJYX2IJZjf7gSG+oQyvYVHf80nzws7cewYcfMsVT?=
 =?us-ascii?Q?WpgrjjQ6PbE7S+2EXIhPbCk1AyNcbqRSTsHSDu1yIE4Szqlbn/sgDuUyaxqp?=
 =?us-ascii?Q?mY60rv3FJ643zrduweZ4E4U/grsSVXbjAEf4Hlmr4ENQXD4IMgYZIqdmuCjk?=
 =?us-ascii?Q?ruYOZEaHj5AfcxOSx27NEh4knFM0fVx/SSxDlhN0UHhqi6Sv+yPWnCwpWt9C?=
 =?us-ascii?Q?G7hX9XTBg+SibQOPyut0jid43xiNKFaVwwKUC5fNwjKyFIEs7vDvvrp6Yq5r?=
 =?us-ascii?Q?26dU1woMPE/OEgIvBk6FEDBICBg4n4cX2Rlfv2PeDq7XN/37aIEFSjIPEYyF?=
 =?us-ascii?Q?8ejQ8drlFGbr3eufO+/rD1Hxl2b1Tg5HhskPtnVFh85T+c8s2um+YjgOKm5q?=
 =?us-ascii?Q?P+Z2lXIe6htC5GCl0Y/w64M+pxma0e45kjbBK9p3dbZqvmo2+kzEWbWwhB20?=
 =?us-ascii?Q?y533oz8JqMWZmWVVGARWID0SaCqUj3CBbrzIQKaQoayA8i2Yke+D6UzVtQUH?=
 =?us-ascii?Q?19DGUfnbHRxv3MW1PrfADjuLh7UXvR3EnDhrjCfXiRQnEiY+SZ6wv8r27kPO?=
 =?us-ascii?Q?xizgPPuWpOZ/v+lWDVkUENazYyvY/l7tdFVjDNZUiT9tydEiyM6pZpxA4yNn?=
 =?us-ascii?Q?m65SvpaEu8AQLeLMMyAwUmQRPWe526rqAyonOmWePqu/vusBffUCZ1MRvbLB?=
 =?us-ascii?Q?iBrhlcTeiKyGf1c4k3/j3Gdn1B7mtwftauHp9V5Qxdeo3SHFg01HcsosN/Y7?=
 =?us-ascii?Q?FNMGeBLR1HA9aMBLj/unmQ0x5GlWtStacwdU65m5fh2aQR5dPtLMDlkEk1KD?=
 =?us-ascii?Q?20lEZd11gY5JrOh7or6kEhjMLor5C70bM6l1Vpl2U2Xo2za79/rq6nBC9how?=
 =?us-ascii?Q?xovSsGfqZVA5iyWvxXkNYqVvuR+QRjw4lcX5rriIpnED/EmCGYy8/6WUaC5P?=
 =?us-ascii?Q?6I9ye+VtVG6nsronXZrTzQwjLm+xk+t3rUrTJHb8312z0QXWnR9W9QpXwQPl?=
 =?us-ascii?Q?d+iRL7MhiH0RSy72hd4wuLgfbRP6UOaLF3CCmCiGCLM9OzPnsOdsoPwHNuYq?=
 =?us-ascii?Q?qOMc63gZEBa36JVR8ddGrvWOtakJcImJkwVKX9H8NGprF0vQam2mlJfRsF2N?=
 =?us-ascii?Q?QxepFGfrAaYbkRXqmleiQABSSnh9bbId+nskgwxUTlFjvmv5Bs3Lf0f+DkSA?=
 =?us-ascii?Q?0AUngzdZ4/UEDG9JxdL26swdPXqs7dkaC89DZsqJQt3oBQv9FVgGyXxAPmKx?=
 =?us-ascii?Q?dN0ZEc9TyDLgcsAXXkAu9PvV?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230037)(1800799021)(366013)(376011);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?DasrQZOgg3iMmipXMkS4D0Ff1ptZVh0aka3vvluhU6iwpNFfyyAC7SM0xsek?=
 =?us-ascii?Q?KstZHmQAerA/a3n7frUxdspb2mdGRaspTUjnhprd7iCr0C/JkGlGg/g6iloD?=
 =?us-ascii?Q?SfYgDS5JAH8G2Dcfmp1iMwYTLpByCX5II+XfBkC2J7us4n1dd5JkXJkAWKD+?=
 =?us-ascii?Q?Z118zKZsfpyBCvhY2LL5ynylh33Va5TejT4ZzCkF0+FT/nmoc9cyQJjtc5sf?=
 =?us-ascii?Q?/yAKgRTr3yzPC45OKlMr7MKSluMxRzZHtph4aEgR+StLj7NoHQzp7G7Yi/N2?=
 =?us-ascii?Q?Il1kq3SAr7IYFrcPZe095i73q0aMmzF5VzX/fHAFVwMGem5DP3Pk5auQOQhk?=
 =?us-ascii?Q?p9+XuDkxNdnO3SY/DWidr5J6fGZINChddn6D442DwoiZN4ewoeo5v6N8DE4P?=
 =?us-ascii?Q?98xuCRl1c0WfvwLzq3hvcZVxpqAkowx/eSLuORabyzgbYQZy774ig1/dpZ8v?=
 =?us-ascii?Q?UQJF6qAni5eKIce59X6igD7sg5Dq2LWZVbz8J/OUZz7NF/htZ60veBFnM5C3?=
 =?us-ascii?Q?WHvfO63Mc5mXvnxWgZMU9UDhlqnkb1GKsXWjlDiT4bREo8mXt/TQ1U+DxdfF?=
 =?us-ascii?Q?uPZYrHaZ1C/E25Gy9u/WH1Chef+jci7+SxXLdU9fnqDBR6HY36lWdKPzejWq?=
 =?us-ascii?Q?Ulhmnosozm3yJN+ntd/KUDdWxMTzm89SqwxIw6LkhPJRXJkw5GbaNkS5GlHZ?=
 =?us-ascii?Q?b/sq3IYDpWjJuaOO29orwth7TORYb0rnGl7wEj1cHWDCFY3FPuPUj8SS0Iub?=
 =?us-ascii?Q?olOusbn00HnQ9eB2fFTN4cMVB7XfwzGocuU29rql05Ar18U/G9wFs9YByi/5?=
 =?us-ascii?Q?RDyGfzdl80lvcdDwQPDt7lOHjoDqejrqIptbB2aChMOeueollXh3O8+J+cx1?=
 =?us-ascii?Q?G5NLqNuNymmJ/OI9Sim9OZw86dlWbWV5wFUS+JjDjitJs5366tXEFXwldyaz?=
 =?us-ascii?Q?P8Ugis/buQfsqa94wyVs8ClLgkX1ICZDVIrvKOKQGRQjOes45H03VkD5dXR2?=
 =?us-ascii?Q?jBDc7FXcc3LfcAvzVEwE7z/17bDFVcX0wlj218uHghS47hXqNz2dLgEM847v?=
 =?us-ascii?Q?XV1gOGshNUTLswPiDWFLSTaaCotuGXf0MyYFeFZZOOtpV4M9s0wty4Oy6Zp0?=
 =?us-ascii?Q?aPzhOikWt2/EI4FSYnCQqx0yfVPeWepF0GRMG1iZdUSXDbVxB6b6z67BpCpA?=
 =?us-ascii?Q?NGjVBXG2yh+CSMPvMVtgQFMo7yauqeWYFpvBRVd514FqJmYsaiUNzusPKOlk?=
 =?us-ascii?Q?zs28flH8VlDx88Bbn6mJJD/BanfzeKSEbylg3JaHEup8LnTI4SA/IWReWddM?=
 =?us-ascii?Q?eEjyAa4hp6F6EU2lwkTDRTg4i91T2n0eV1uVfBYKWGxaT2/K6nJpPxBYkJx/?=
 =?us-ascii?Q?PwLce2bt1Qmt9xXz22rI8CT7H/kG9YkdyPO04s7lOPozuiR3exFpKzTdc0xC?=
 =?us-ascii?Q?pXP0yuSTl7+yd4XgLTxh3Zn6JYIRHSX6NoJUjylfSC44AdU8bffppJH7lyvf?=
 =?us-ascii?Q?v53RZyPs1mfcgiDGedIJjDiAifhCRz1hgFU2r0fMmPa4ASkUzIbsOqF1M7IW?=
 =?us-ascii?Q?QhOluQbgo+NdGrH87FeZAPW/jJiEcvdEumyQvHO430qEhv9Mel1ZVBy9Kqi+?=
 =?us-ascii?Q?ng=3D=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2d6d1a1c-f1c5-4de5-969d-08dc922b15f6
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jun 2024 19:48:13.0455
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: f+25kV0h40+1ZQRv4VTfJdC9Sk/Jn8z/Ik3wrKni6zKRt6KXqGJ5RpbSubeIqrqNLi3bVcvpBdZvXnuWFWGVrA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAWPR10MB7151
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 21 Jun 2024 19:48:22 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/16318

On 21.06.24 12:12, Quirin Gylstorff wrote:
> From: Quirin Gylstorff <quirin.gylstorff@siemens.com>
>=20
> This allows to test a physical target with the snakeoil keys.
>=20
> Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
> ---
>  doc/README.secureboot.md | 20 +++++++++++++++++---
>  1 file changed, 17 insertions(+), 3 deletions(-)
>=20
> diff --git a/doc/README.secureboot.md b/doc/README.secureboot.md
> index 509de97..c5371ea 100644
> --- a/doc/README.secureboot.md
> +++ b/doc/README.secureboot.md
> @@ -47,8 +47,7 @@ Supply the script name and path to wic by adding
> =20
>  #### secure-boot-snakeoil
> =20
> -This package uses the snakeoil key and certificate from the ovmf package=
(0.0~20200229-2)
> -backported from Debian bullseye for signing the image.
> +This package uses the snakeoil key and certificate from the ovmf package=
from Debian bullseye or later for signing the image.
> =20
>  #### secure-boot-key
> =20
> @@ -284,7 +283,7 @@ sda              8:0    0     6G  0 disk
>  =E2=94=9C=E2=94=80sda1           8:1    0  16.1M  0 part
>  =E2=94=9C=E2=94=80sda2           8:2    0    32M  0 part
>  =E2=94=9C=E2=94=80sda3           8:3    0    32M  0 part
> -=E2=94=9C=E2=94=80sda4           8:4    0     1G  0 part
> +=E2=94=9C=E2=94=80sda4           8:4    0     1G  0 party
>  =E2=94=9C=E2=94=80sda5           8:5    0     1G  0 part
>  =E2=94=82 =E2=94=94=E2=94=80verityroot 252:0    0 110.9M  1 crypt /
>  =E2=94=9C=E2=94=80sda6           8:6    0   1.3G  0 part  /home
> @@ -295,6 +294,18 @@ sda              8:0    0     6G  0 disk
> =20
>  Secureboot for a generic UEFI x86 target works similar to the QEMU targe=
t,
>  except the enrollment of the secure boot keys.
> +### Generate keys from Debian snakeoil keys
> +
> +For testing the snakeoil keys from OVMF package can be used to convert t=
he certitificate
> +into a efi authority file use the following commands:
> +```bash
> +cert-to-efi-sig-list recipes-devtools/secure-boot-secrets/files/bookworm=
/PkKek-1-snakeoil.pem PK.esl
> +sign-efi-sig-list -k recipes-devtools/secure-boot-secrets/files/bookworm=
/PkKek-1-snakeoil.key -c recipes-devtools/secure-boot-secrets/files/bookwor=
m/PkKek-1-snakeoil.pem PK PK.esl PK.auth
> +```
> +
> +#### Prerequisites
> + The package `efitools` needs to be installed.
> +
> =20
>  ### Secure boot key enrollment
> =20
> @@ -316,6 +327,9 @@ Use the recipes [secure-boot-key](###secure-boot-key)=
 to provided the keys
>  to the signing script contained in
>  [ebg-secure-boot-signer](###ebg-secure-boot-signer).
> =20
> +
> +
> +
>  ### [ebg-secure-boot-signer](./recipes-devtools/ebg-secure-boot-signer/e=
bg-secure-boot-signer_0.2.bb)
> =20
>  During building a efibootguard based wic image the scripts contained in

Massaged and applied to next, thanks.

Jan

--=20
Siemens AG, Technology
Linux Expert Center


