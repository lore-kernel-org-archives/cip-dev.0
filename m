Return-Path: <biju.das.jz@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82BFCD59D99
	for <webhook@archiver.kernel.org>; Mon, 15 Dec 2025 09:47:13 +0000 (UTC)
Received: from OS0P286CU011.outbound.protection.outlook.com (OS0P286CU011.outbound.protection.outlook.com [52.101.228.34])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.44823.1765792027944112335
 for <cip-dev@lists.cip-project.org>;
 Mon, 15 Dec 2025 01:47:11 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@bp.renesas.com header.s=selector1 header.b=AvbqeqL1;
 spf=pass (domain: bp.renesas.com, ip: 52.101.228.34, mailfrom: biju.das.jz@bp.renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yEHl/dufGfQ7yqLIrAFLETFPeH0kz/lb7aFP5VeSHlY7qvjVNHmRijssrjsfjEoSvblhqsE3Mi4rEgcJCWM77rK4yLtKESAYRf5HYsdvsq1KQ4aknVP2/mWlNGrUnc6d/kcmX1I9RRoghbOPsSHGKpDrzdy1WHtI+R54x3Vpq2Ng8cfxa1sXAUxMTTm991gyxRW2g3klM0CGUH1DwaZvuosD4a/MoqCrSuwaO4/AdmSUmC/UQiY/13Zxl6RrOPF7bP5oWpsRRBoMZKHqUIye1PBLEnGA1GjVPrhOrUtnVp8t1Q+gerhEGg8yRFsmfJ2VkGDFGW55FsvI1xp09yCc4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZReDIYsxvhDwaFzxajzmzDp/wHFVr8FJ/DNBNycPxH4=;
 b=HJyGJmV/pxWOcxBaXaXgesf6OPZgyqFNa0LAEUby5i6LH6Pvo3pgrCekirWzqV0iOzN1bSH9bcnUOt2yBSUi9u9oeodCj7qgTD6penfvV8LqrIqHHNg7g1D4sVisIGO3rm50HzjiaWlOddnqSoJWhiOKfTeT3EgkKINTWQLtF96QJvDnvJmU6ro1FfKCsA2K5avMyK8qMCb2niejPzDyCf5VTR+5aatBVqCV68Yhichup8HNkrYJsmZVTeY25KhC6bKtO+1AJPShss7tAiXXl+oydp39zFhtehr7yLrEY78hVyqH2dDCAp5z4DGp7kS0GLfb4A0q4zYf5bx11HpF+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZReDIYsxvhDwaFzxajzmzDp/wHFVr8FJ/DNBNycPxH4=;
 b=AvbqeqL13mF5nAzBZn7orNrHhcvDfJYCDo5t4IOxpzmJJObQZ7JBDFec0X3kX6UwhtCu0kA8FXAMoL96/7ij4V+0QCOUJIWrqBs4OT+MvFvbhJ8SYPZiWSxb2IEcovP4qsbRTq8Y8NRdCFHfIoW0pkurkE+eqNjxM7Eq62qeJ2g=
Received: from TY3PR01MB11346.jpnprd01.prod.outlook.com (2603:1096:400:3d0::7)
 by OS7PR01MB11729.jpnprd01.prod.outlook.com (2603:1096:604:242::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9434.6; Mon, 15 Dec
 2025 09:47:04 +0000
Received: from TY3PR01MB11346.jpnprd01.prod.outlook.com
 ([fe80::86ef:ca98:234d:60e1]) by TY3PR01MB11346.jpnprd01.prod.outlook.com
 ([fe80::86ef:ca98:234d:60e1%6]) with mapi id 15.20.9434.001; Mon, 15 Dec 2025
 09:47:04 +0000
From: Biju Das <biju.das.jz@bp.renesas.com>
To: biju.das.au <biju.das.au@gmail.com>, "cip-dev@lists.cip-project.org"
	<cip-dev@lists.cip-project.org>, Nobuhiro Iwamatsu
	<nobuhiro1.iwamatsu@toshiba.co.jp>, Pavel Machek <pavel@denx.de>
CC: Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	"nobuhiro.iwamatsu.x90@mail.toshiba" <nobuhiro.iwamatsu.x90@mail.toshiba>
Subject: RE: [PATCH 6.12.y-cip 2/3] mmc: renesas_sdhi: Enable 64-bit polling
 mode
Thread-Topic: [PATCH 6.12.y-cip 2/3] mmc: renesas_sdhi: Enable 64-bit polling
 mode
Thread-Index: AQHcbPN9KuF8dzt25EiA65j6zjW1CbUidYjg
Date: Mon, 15 Dec 2025 09:47:04 +0000
Message-ID: 
 <TY3PR01MB1134636E2DCF652674BE35E4686ADA@TY3PR01MB11346.jpnprd01.prod.outlook.com>
References: <20251214121627.4656-1-biju.das.jz@bp.renesas.com>
 <20251214121627.4656-3-biju.das.jz@bp.renesas.com>
In-Reply-To: <20251214121627.4656-3-biju.das.jz@bp.renesas.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY3PR01MB11346:EE_|OS7PR01MB11729:EE_
x-ms-office365-filtering-correlation-id: c3bcb8cf-690a-421f-0240-08de3bbee767
x-ld-processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|366016|1800799024|38070700021;
x-microsoft-antispam-message-info: 
 =?us-ascii?Q?GE3Gz0WIf1mm4cxXfFjqsLfR9l6ri9vhnkgNi9QYHjRtv1Y62E8d73BEpaAf?=
 =?us-ascii?Q?XdmhA6iYRkbgj1mj91xGI1JbNKUa2OScs5CiO3BR+Iv2LQWcaT+43vBApgL+?=
 =?us-ascii?Q?kjL3AaMMeM0Wju/Zf+1wdTcVtP9ZcrqNQbzUk5tf2bkmZOkMGwwpO7qzqZmV?=
 =?us-ascii?Q?4kXD7MKEfV0WMRn6PoxSOx1aSCK7pvnyzRJ9ORDEb/aZKkVcbgV5hELVCb1t?=
 =?us-ascii?Q?cRYpoJ15oGaMUB884Q5KcOkghXKWphWH8BZjp/QqRTm2S0PQ/NzDIu5DTCT0?=
 =?us-ascii?Q?61MiOuYZHE7mjLWYoMU1x+K/1m+lne3t8edIu8qjOxPPBJ+LfXeYD+w59Dkf?=
 =?us-ascii?Q?yPIqr0P4GmJ3onXMyH6ptnPBKIwBwpmB57qmpd4F0pHKYaaJx2wjAaj021oq?=
 =?us-ascii?Q?VjOha185A3cVxwneGy4CheZfuf5L2TOdwXcFJlI7KqVJjW7fZp5jsljjSVCr?=
 =?us-ascii?Q?XU9Vgr9vOEUHwed6FXbBN2b04/WgS2BDQtMLA6FlPJsa+RmDVzxcWWAhuMxm?=
 =?us-ascii?Q?gQ/YPr2AIwuUj+FIOPyiGVWpCGwURK9ilSrJfkhmZZnk437T8xY4cM6B5eKo?=
 =?us-ascii?Q?7KXalGX4oOHpJCd+DgZtriR2e+kGpiycwDMQ36Lazd5EVkgKyJ7a/BECN7jW?=
 =?us-ascii?Q?xJQGay3x7ZJVhPLttwZFnu9fLgqXzzMXJ/jP4OHcbQss+He16mA0fTZp1O/i?=
 =?us-ascii?Q?udlOyro+7/exJIlMhZ3Izp14fw4UVzNhH22t3g4zL8lq988pu9wnT2t1+Akl?=
 =?us-ascii?Q?6NQMZPcZL+EILEn4f3qpZoGcyfztty9RJ/qZQ1XBTBEVvgc4WRR6NPUhiVUv?=
 =?us-ascii?Q?a2vtgWC9eoMHs7DdoDw4dd4KGA2WkcuAvazMWOxi5eBjPgZidYpBHyRaH2GB?=
 =?us-ascii?Q?JBB+JjnLiJ+5j8M+HL9ckOdTn65NriFSdul+G3RtE5PwuqgqqOTv5EjtqooX?=
 =?us-ascii?Q?t/bwRPs7i+QIeZFBP914u90aN2hodkQiuFktxMnOfZaS/1AH0MGaAkOFSgir?=
 =?us-ascii?Q?Sv7mMExNJ8WTFcKdMQ8TsxZ68HSbDQPhpIdS9BC+fCl5+yiFRLAclMwGg/E2?=
 =?us-ascii?Q?D+74lm4MI/v3qJfUf2TKTGl4vvFaXfiu8G6Cg1eC9IxKLQPVynTdTmAufATF?=
 =?us-ascii?Q?u/RmR9mlg106FMU59deusBcm/nhsgNGuQNSxhB2Xb/HUaDTRs9egqhzmfF6A?=
 =?us-ascii?Q?q7sanGHJq+xNSFi6qNqHiBN43L+y9GRNys2k9mJQi7mBKnLmQAE45EsIPOvo?=
 =?us-ascii?Q?BpZuVaTowiCDJsuv9OfzCdn63MSVUQqG9Sc5xH1I3V6q0DUzsu8xSL74DOG1?=
 =?us-ascii?Q?hvQZUE286BQlRcbg47yrVhpgx+fOcW18SeJnUJk/Gpk2IuaIg9EZ8Dk2R3Ar?=
 =?us-ascii?Q?A61mVX1uTqIZ8PXUm0ohXgrYpxLlpFlzMbyWlm6CwDhoZQDCWYKr3rbbGAGw?=
 =?us-ascii?Q?Xlp1bOVKOgZd5qMUEj0oV2PL85drd3HLznbi5nBhkTpBeGUqAW+lC7mt9wvx?=
 =?us-ascii?Q?Xmjqi5VRjhxr1NVqpzB3l6wynEbVjjzbEiYu?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY3PR01MB11346.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?us-ascii?Q?dk0oi1a3L5Xfv8JYTTQ4zKIab42quTMgMKwrSrSEwMAa5IqRSZe7W5RIzqjG?=
 =?us-ascii?Q?x4USmgzDDzzGxJbBqWYWArwtdVntcz/ab39mXRj0ZoFmsw0C1ZOewxRPrm2I?=
 =?us-ascii?Q?luGSCvJLhnCXVtA/6x8MrE1vzizqdKUKLfty5IM/kiZipH5yuYBOHHCl6fGC?=
 =?us-ascii?Q?S7M55oCjG/nYHO4xOA3x/Zv+83cYAYzL9/JzmSTatYudkWKaQSOo5s2KQqXY?=
 =?us-ascii?Q?mVi+56b6rpC2zuwDJXWnHSZuaX4uLHjjaJ5jLAq71R5qUN7GLqFrpgkZUOvq?=
 =?us-ascii?Q?YJ4QN47RQhFRV6iNN8o4PA7V8ii0dWfQr2ZfQMS2iXuSJssGOQKzNRxNwOXL?=
 =?us-ascii?Q?fBGRek43ICTCd0NOYFru0U3X2kMOJW5rac6okk23rmcMU7bixvU2aCKT7OkI?=
 =?us-ascii?Q?ApduBK8bJvsxh2KnK5bZ66OQXdSaG519KUMOBLWF9Nb6kbEAjvDFoYNSrrFC?=
 =?us-ascii?Q?tkSBlZekqk6hYg5UNHYhRDWmWsjD+GG/UFRzuvutzE7MabAeKGolZEG56ROh?=
 =?us-ascii?Q?x/AE6Unq1w2pAnSxgLnMcyUUQMd+IkhqAdwqFXBty8Q5wZ2k3aUtHHaaUtLg?=
 =?us-ascii?Q?XhIl5FmRgKYAO3zYaIoD/SwvED6HcUlB1+y3F7vAZEhxvdIyEyHY6DjIbMPt?=
 =?us-ascii?Q?EGmqbpxjW2bfIi1d1wEmMvcV19esCwYdDRD0cU6kep7EQkk7h8Gaa5cHbUoI?=
 =?us-ascii?Q?gH7sQIQwUQCbEfzmqZvckT5v1Hv1mVQCuAJbfYtp+dZNwQjEux+hJsJgtUw+?=
 =?us-ascii?Q?xtYKV1tF9Udo9R2yhFaZfiquHIM2bX9GysL7X4uajarw/9DwKcKNSxKLxAJg?=
 =?us-ascii?Q?F1f41hd0MBi1IJYNf+EQyzPm8UyxyDM7KLLNJds8cjaUDONUSKDC7k+VGSfj?=
 =?us-ascii?Q?DxauJQnhep6Scgr+bqbjzitFjPGUU+29g70gkez+YPL6Hl/Py8Rmv1SxDWMw?=
 =?us-ascii?Q?ZV804ohGzts7q25M95vcp/CfkUa/CglOc5kf+C1yctkSEvJr8HWdYy3/7bOY?=
 =?us-ascii?Q?gm7SEPVaRWoycHlBrL51sI+rtI38R4lKVCsYYjLummbEy77trzTLwOGqx2mb?=
 =?us-ascii?Q?qUONAv1BEpVMWxA3OPJ0uoasz5cL6Z7cGx+Ccc34q30GvSQl8lTHhhIkmmhn?=
 =?us-ascii?Q?fe9rUnb6t54BQyhtNYB34szID5x9vguqGcsSOp5K7YIzKq4i3Z4Ali9G30uO?=
 =?us-ascii?Q?ZVAK6BqZQAtV0x951eFfsvlFgadU3z3IYGb5n359kcFBbaqR0I0XBffgEkWg?=
 =?us-ascii?Q?R7CsV/V9PPRH92o2Yn3D1F+Ki0ixic9FUaWKXSZ/0HNepbI5bQmmxLvav2Bl?=
 =?us-ascii?Q?F5aKHrajYy187EHn64Lf6VzvOstIlLK6nXo97Ik1SYxxv35Y+XvuCIaDu8zR?=
 =?us-ascii?Q?CcGHZOnrGFFIiz8MVnN5eK50AnwPIDzvxWji4WeMmYiPoGae5ZmOKNt+8mZo?=
 =?us-ascii?Q?tF1TR0JztgM62lCuEiTlvSmqlZVVhwD8JcvK6u/h5CEgwJRFGK8w0Gna6cR/?=
 =?us-ascii?Q?C1l3C1PrQ8/o6eIKVCDC+x90pqrtQFWt4OW/s0mCIvriQV2WfPzrh4o2QgfC?=
 =?us-ascii?Q?beG6fSYjuYJ0e0fsYiBbjfBq7NJccjhl7gJPFE99plKfVshiuGhV03v0xtrW?=
 =?us-ascii?Q?0A=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY3PR01MB11346.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c3bcb8cf-690a-421f-0240-08de3bbee767
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Dec 2025 09:47:04.4936
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: eWmLEYhG9QzEkpL3pFSW580OTTrHvnUqocv5lkXK/4TqIz4WC0LvL5DOGYwz5cv/lZhQ98oQpsPDxiIBBLHs8aE1UN6MtbgGVVUt2yaBskc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS7PR01MB11729
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 15 Dec 2025 09:47:13 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/21046

+cc=20
nobuhiro.iwamatsu.x90@mail.toshiba as Nobuhiro Iwamatsu <nobuhiro1.iwamatsu=
@toshiba.co.jp>
bouncing.

> -----Original Message-----
> From: Biju <biju.das.au@gmail.com>
> Sent: 14 December 2025 12:16
> To: cip-dev@lists.cip-project.org; Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@=
toshiba.co.jp>; Pavel Machek
> <pavel@denx.de>
> Cc: Biju Das <biju.das.jz@bp.renesas.com>; Prabhakar Mahadev Lad <prabhak=
ar.mahadev-
> lad.rj@bp.renesas.com>
> Subject: [PATCH 6.12.y-cip 2/3] mmc: renesas_sdhi: Enable 64-bit polling =
mode
>=20
> From: Biju Das <biju.das.jz@bp.renesas.com>
>=20
> [ Upstream commit 709fe7aa5aaf8047b528561a0082db8a3a29010c ]
>=20
> Enable 64-bit polling mode for R-Car gen3 and RZ/G2L SoCs.
>=20
> Reviewed-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
> Tested-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
> Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
> Link: https://lore.kernel.org/r/20250730164618.233117-3-biju.das.jz@bp.re=
nesas.com
> Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
> Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
> ---
>  drivers/mmc/host/renesas_sdhi_internal_dmac.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/mmc/host/renesas_sdhi_internal_dmac.c
> b/drivers/mmc/host/renesas_sdhi_internal_dmac.c
> index 1dcaa050f264..5652979e09ed 100644
> --- a/drivers/mmc/host/renesas_sdhi_internal_dmac.c
> +++ b/drivers/mmc/host/renesas_sdhi_internal_dmac.c
> @@ -107,7 +107,8 @@ static const struct renesas_sdhi_of_data of_data_rza2=
 =3D {
>=20
>  static const struct renesas_sdhi_of_data of_data_rcar_gen3 =3D {
>  	.tmio_flags	=3D TMIO_MMC_HAS_IDLE_WAIT | TMIO_MMC_CLK_ACTUAL |
> -			  TMIO_MMC_HAVE_CBSY | TMIO_MMC_MIN_RCAR2,
> +			  TMIO_MMC_HAVE_CBSY | TMIO_MMC_MIN_RCAR2 |
> +			  TMIO_MMC_64BIT_DATA_PORT,
>  	.capabilities	=3D MMC_CAP_SD_HIGHSPEED | MMC_CAP_SDIO_IRQ |
>  			  MMC_CAP_CMD23 | MMC_CAP_WAIT_WHILE_BUSY,
>  	.capabilities2	=3D MMC_CAP2_NO_WRITE_PROTECT | MMC_CAP2_MERGE_CAPABLE,
> --
> 2.43.0


