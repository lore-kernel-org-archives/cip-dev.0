Return-Path: <biju.das.jz@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8261AD41D74
	for <webhook@archiver.kernel.org>; Mon, 15 Dec 2025 09:47:43 +0000 (UTC)
Received: from OS0P286CU011.outbound.protection.outlook.com (OS0P286CU011.outbound.protection.outlook.com [52.101.228.31])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.45011.1765792053535334307
 for <cip-dev@lists.cip-project.org>;
 Mon, 15 Dec 2025 01:47:33 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@bp.renesas.com header.s=selector1 header.b=S6eha0Vx;
 spf=pass (domain: bp.renesas.com, ip: 52.101.228.31, mailfrom: biju.das.jz@bp.renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lUHipctvyY3PLzdEsQvlPhbtUfUhC2j3re3hT/5J6GonxEuCOwbQhzkuLF//q1NG5+HfM6JgLtxxRMxMHZxc1WNqWf4luk9wLT4e1QWjAy2Tzmm8CPQ9kDcRBthkWIC4/2gShwqVULDl9DXG9fe3jgUlGQUBwSQYS35rBm6xn9Gq1pMM5pN3V5Oxtu2bEfHNNDLVtZHQr4zIOx3WHpadsHlVWz2qZSO2RWQNnH9dNCbWpTvh4GujF3MTu8WnWbvj5IFPql1jQkTGTWsydUmHBd5+fL/fGm6bRy40WoCP/Wd/4AYgewKSI4VcuAm0eBak41oyMp73ZqvrBq3xDTamPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jkSv2BhDe719c1/EH4GsuhkJbeDLjP2nTGmL5KlfDrM=;
 b=j9YBzOhMxPETc25S6lENpWjnOfKErtnsTjWPEMgfbqlSn2A3loI69feXWVe/rOAgr6TERaFlVZhPXcIkYul9MfJsRxsrz3zW3Y6JIYEHEt9CKpsOlFYhzFREdcZDS1Q2dt8Mz39YcxMGmkQNSo746daLJDpx+tTQhTojjqtXO+5zVNu762b+HiXn8/bd8p2JfA1nB61kCxI0A+M5alBmv3z3vSk4UOnH7ZX8hvz4LHa0hnydXngdPy3xoOwnUZ0EH+sjw0FbLTWvdHjIsRJnkOsI7qpLW5+hqxGCHAtlXAWvJbZpy+cRVszTSs0px7WrptCwWr4KMxypB1fPu+TXdg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jkSv2BhDe719c1/EH4GsuhkJbeDLjP2nTGmL5KlfDrM=;
 b=S6eha0VxM4O970T2k829PIoDuwxpF2WeI/TUF3hYZoHTDl//UtbcJR18MeUEn2CMbMsBPmqHauTM1y88zxwvQLi1u5S5rGbc+IkfYcgYGVESVM/fsqb/XtYwcv66FLXmpmwCkD9ZqY45KlOmSBTHXTqQOoJ/qtjgMd8GOy3pTxI=
Received: from TY3PR01MB11346.jpnprd01.prod.outlook.com (2603:1096:400:3d0::7)
 by OS7PR01MB11729.jpnprd01.prod.outlook.com (2603:1096:604:242::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9434.6; Mon, 15 Dec
 2025 09:47:30 +0000
Received: from TY3PR01MB11346.jpnprd01.prod.outlook.com
 ([fe80::86ef:ca98:234d:60e1]) by TY3PR01MB11346.jpnprd01.prod.outlook.com
 ([fe80::86ef:ca98:234d:60e1%6]) with mapi id 15.20.9434.001; Mon, 15 Dec 2025
 09:47:30 +0000
From: Biju Das <biju.das.jz@bp.renesas.com>
To: biju.das.au <biju.das.au@gmail.com>, "cip-dev@lists.cip-project.org"
	<cip-dev@lists.cip-project.org>, Pavel Machek <pavel@denx.de>
CC: Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	"nobuhiro.iwamatsu.x90@mail.toshiba" <nobuhiro.iwamatsu.x90@mail.toshiba>
Subject: RE: [PATCH 6.12.y-cip 2/3] mmc: renesas_sdhi: Enable 64-bit polling
 mode
Thread-Topic: [PATCH 6.12.y-cip 2/3] mmc: renesas_sdhi: Enable 64-bit polling
 mode
Thread-Index: AQHcbPN9KuF8dzt25EiA65j6zjW1CbUida2A
Date: Mon, 15 Dec 2025 09:47:30 +0000
Message-ID: 
 <TY3PR01MB11346B889098BDD040D5004A286ADA@TY3PR01MB11346.jpnprd01.prod.outlook.com>
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
x-ms-office365-filtering-correlation-id: 575700b3-789a-4239-33c9-08de3bbef711
x-ld-processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|366016|1800799024|38070700021;
x-microsoft-antispam-message-info: 
 =?us-ascii?Q?Jc7mbIZji4jRQVzXciskj2g4BDNvQ3JYZxLGdHCS3d/yACPo0dE7L9TKmMdG?=
 =?us-ascii?Q?e8CPakXbPPBBsFpi/lBSSG1sJbB26zoyiEEwDzNC2dShZ/BG8UE+GIuqp1nJ?=
 =?us-ascii?Q?p4fofYg/oYXQjzE5ixX8kTXfe99dBYcAvPz5NsthFFk0Cc9nL6Vg/83cpoHD?=
 =?us-ascii?Q?Z0IU9/Ef0p6XP1OfF8QF1XhDtjAXGNbdswhH99BRq0pjFypjwyPkMuz1lu8v?=
 =?us-ascii?Q?b8wJ+BJ3F2QKLAtwif/YzJqRD4iSXMNHZHYOPUP81GMpXwd8Bib2iz9k/BBc?=
 =?us-ascii?Q?0oZYrmosD5FYWs4cnDBaK57neYdQHzNtL2k8jIw7FaNzIDuBsPDgeSTKoX8w?=
 =?us-ascii?Q?NzjAAzFjIoQYQ+JaL/PYMNWV4wM80FDNBXV7Nk7W/7r4etrrcsAOiKMRM6Jc?=
 =?us-ascii?Q?r24Qqu9SWOcNWFi1GGsMCh89A418rcnvw3oPpMuvuxFSMYTZlg9Gw//7QLxH?=
 =?us-ascii?Q?lNI6sS0vTkNa20ot8ooc/s9katMLTENKiKEySrAtk/NyI7UZLrhYVlifQM6E?=
 =?us-ascii?Q?pcjLiDPcW+bvt4Q158YLU9sIw1c12RA3O+gPRVo5Sal9OlNASFyupI35Y9Ci?=
 =?us-ascii?Q?/moyQchurQopkbIg2f+PkRWUAKTprIRm0q7RqiHDZ/NdGIZ4MSRbEi1bO9vy?=
 =?us-ascii?Q?XVT9PrBjnqd+7hBfdKBR+K3YLHVc2+APWPJWkCrSJxFPDInHU3gpO4h1rYOQ?=
 =?us-ascii?Q?Ksry2DgJQCGPdm8m6iVRIcrYwDt1cXhB9QEoJJxisAVRPAdIN35YL6vbawmC?=
 =?us-ascii?Q?ocmF4ZZlXgfG1QMyO+ZjvPasJ+xTHCf0d3u8wmwjMVc0sEwhti1g/L7xGk7x?=
 =?us-ascii?Q?i/r47F9DW8+Qv4FfGsMcfaMdK8dvOjHASPzvxhcrZSyNbEZRun2SWcgBS/vb?=
 =?us-ascii?Q?dtYwnAn0b44QLnewyaJvx4y+liitCGHOtfDfduVFkALGJGksKno0eCxM6n95?=
 =?us-ascii?Q?NWrxopSzWZrAeB0sBo+86FyMkCLYiRtGNc60qWW2dPXd9Uemd7ckdEHEmgvx?=
 =?us-ascii?Q?0AdhVtaAEM5jjmUSIRd4T2NYvO7/f4PgNgzeccteAz7OCPN7Bq+qwrh1mpUa?=
 =?us-ascii?Q?GzIUXYMhE79+RfUpJBvx72G9U2FPfYyV3YIm0gz4gd8Rs6sV758psb7udmF9?=
 =?us-ascii?Q?wR+zDfPOsnVu4q48RNagj+8F9M6lJH/iBF6pCDuKR/lL4OmsENZVPYDhTUVN?=
 =?us-ascii?Q?ixhKR/6TVa0odqHiTm5RR3gxL1Ylkp4O7+GPh2IOY1PTHMdpCn/GOaVc49af?=
 =?us-ascii?Q?Zuh2VGvzcNM5dTf83/LiFag5CkYJcYtWlBcA/VBQaGpQTVp3bkBxjm0R28CB?=
 =?us-ascii?Q?gt6f7XZIY/mdOi/i2X/zBMHIGB8bgGWqpS10Jo19MxYAN9XZkytKVFlER19Y?=
 =?us-ascii?Q?dE+7Dmug8n0FSV3CNqn79sg4/G6Fl8fbuJ7yNJBx347gpkXN6DA2ULOa8qi1?=
 =?us-ascii?Q?N9EFhR/5RhrFjYlEGS5faoNPPksK32khBHAmCgdowMd3CfGxWXax6bFYjBFK?=
 =?us-ascii?Q?gdUO+RNdv9DRUHEroaVPwUy4rk/0FZs8dtGi?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY3PR01MB11346.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?us-ascii?Q?f7a1cL4kplCbGVkt1B21UkV1eBhhNMVTyMQ3PbzCyNBoAZ3H36PwkZ4V95/X?=
 =?us-ascii?Q?P90sFBwKChiEwVIHbg5GvUt+8sN5iAKCuHMez7nUXms8l37AzveE/6IMv+LW?=
 =?us-ascii?Q?hhlZr7NBX56l1yMS1SBGzwkR44J1lirrklg20I9JcIz1uJQmIiTRlY81SehK?=
 =?us-ascii?Q?aiH1/V/7wUPLmPKTtmCnjcplS4U2JrTAwytPCFum+xCXdbp//LJwhKI/87/k?=
 =?us-ascii?Q?p5n27LeCo1FKtsVpNbCVJtCCf0/ZDgPM8t4Enva34wXSkoIFt1hM+79cKJx0?=
 =?us-ascii?Q?7DVOssgEDqsVJvFC2q4uu5ix2GeMYvNyYnnVfFUOctiNlxo/x9zwvqYHtos1?=
 =?us-ascii?Q?fHVbrOQKFetfW5S5Wqgw6wudIq2X2fie4U0zzpRBhnZlPw4bBQ2Gs0q+sP4U?=
 =?us-ascii?Q?YD3eN7HjyxZcynlkFBUd2EuI4Yn6gFTypED0KyAZQ8p+F7k9Q9257r0/TQTC?=
 =?us-ascii?Q?rTj346xCLiRYOagCU+5OKbjX94FfMULlh29oqtSbu9RIr4orAiFa19ZdWHx5?=
 =?us-ascii?Q?9JSuSWMb0ikc7VFBlQNflXHDpfPHYHS9dSOJ9VPQggSJ0pPvcs9Bw7594zFX?=
 =?us-ascii?Q?lHWcHsZ44iUBhEjNag5LuqV086CVeT77LYdVvsc/pvfHY4NwESZdavt4OT7O?=
 =?us-ascii?Q?WD3MOFjhOc6WXjgglDrcQGH2KYFKBb6jGJy8aKc4FRD6uWPEoM8dfCcwhuzI?=
 =?us-ascii?Q?yt+Yo7jgzjTp6K6akElwaLy57Hxui3Yf61nFRdxQjOAmH/5tXSG9w6Ub3bo6?=
 =?us-ascii?Q?hzAIC4kynAJjOf+MhvmDvcT1IKqVSvE2LXaSrQ034SCvDLI5XNmUzqBPD7kT?=
 =?us-ascii?Q?8IVYQrElfjHt7IvnhslQCti4jRyhyTxl2wXI11G6rxZRxsihRT3U2uZpsQ0Z?=
 =?us-ascii?Q?w5CtTI/50NlVqh1yPKq0s7RoxMwnA3OISqIMxOFbcNnqX+ZDNaXE+7VO0U2h?=
 =?us-ascii?Q?j6ddURx2pBY16ZP4yLH7+aEmY+hs9YUItQunWaXjMoy0UUeQh233CiYimeAC?=
 =?us-ascii?Q?o69RPV4C80cZouTL+tEroebU2lvi/KDc3mYlDlDU/aHXWiZPqlptnoY5ykdj?=
 =?us-ascii?Q?ahLI/Ze9i6h50/SHIvu/6ZZu/uQ9n3E0DK83uL9V+t3H1r7LRwt6qzl2KHKQ?=
 =?us-ascii?Q?CHZ/mBKWEilnDMdgI5+a7xnmpTzOvZg0Nt9AVSoac5PJ5RKYl8CnQLgOxE1+?=
 =?us-ascii?Q?4jLGulVejF9LeAVN+O3KafXH+qCqKLleQb2/LIc/JydbuP2WXZWjSfb6SfvK?=
 =?us-ascii?Q?fBcW4aqY1kKNaYbcIYdVMIy0QPebMyd7kf4eux7aJZQNOXix9XzKP/FaX3Tk?=
 =?us-ascii?Q?dsbg6vfq0f5erUq5ZfBfGLHG59cR7YZ0pR2Dw2TOtckMpHMpnYpVLVXbxzUm?=
 =?us-ascii?Q?wqOgl40xFIpxMEwR/+PRXmxVl/FJ8KzfHvV20cQqQNrhEEtwX/dqunDkVFEl?=
 =?us-ascii?Q?dn5OqZlLHGK6R/tDLwVCHxPBx4X+MzFHE7z1Pt/B8nSlcJ0qoxobH0LxG6h8?=
 =?us-ascii?Q?I8bUsmYimkxiC+oJqzhDBcDm7VlWEqKa2PQZSRF1ZS6HkvthlzjLcny+Y9IC?=
 =?us-ascii?Q?OeZMByzbpAQJq8MeoFfQjzCJbMJ72ZpYR1Y5o6BLCE1P4NEJNvNul06Hv+Y6?=
 =?us-ascii?Q?SQ=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY3PR01MB11346.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 575700b3-789a-4239-33c9-08de3bbef711
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Dec 2025 09:47:30.7895
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: RDLCEddGfMBBaoFvHTyz15Gr0oTH4d66AvlqNDMF0xImBTA9MEmWJRyFPG9ZyKNFfLSwQJFWoUk1/xtYNhfna5m+xPTHANAwrOWXFjiy8JY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS7PR01MB11729
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 15 Dec 2025 09:47:43 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/21047

+cc nobuhiro.iwamatsu.x90@mail.toshiba

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


