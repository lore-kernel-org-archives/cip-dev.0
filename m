Return-Path: <biju.das.jz@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82EFBD59D99
	for <webhook@archiver.kernel.org>; Mon, 15 Dec 2025 09:48:13 +0000 (UTC)
Received: from OS0P286CU010.outbound.protection.outlook.com (OS0P286CU010.outbound.protection.outlook.com [40.107.74.48])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.45025.1765792089214995550
 for <cip-dev@lists.cip-project.org>;
 Mon, 15 Dec 2025 01:48:09 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@bp.renesas.com header.s=selector1 header.b=C80c8Kv5;
 spf=pass (domain: bp.renesas.com, ip: 40.107.74.48, mailfrom: biju.das.jz@bp.renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OLrfYRGdv08iJXe4fWWenfeoJSlbfRN45GQ2/38IW+UnKsstQ7+HzMk2xjpoKoAAjC+vQTURa0Nsi4SWo50Q6pKYEpZmreBzA8ZzL9j6CsCv3ltGMYkzwESJisZPdZwHKabNfVnvkkCRyiE9BDOh7WihPS935BgDtxVNKJo51SD3bX0TkAt6q8xmJmgwxbFttoP48DfMSQ/TP10jVQgKPNlt3d3q6R74l0Td9Bontzv7ujlbZ2tP0INTH3a9lFTDjskcKsz3lgYK3AjclmUm8VzgDgkYAIpAPsIPpPkaFoq/qtT+J0VjeXcahceww6K5y2ctAefKxmXVk/60jjWy+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5CWYN0MWbtDVXO+9ixo8f07h6pfraSkDIRiQKx2AA/8=;
 b=SkvX95qbLHQFgF/AGmcRvX/0DoYBnLnzCHJm7BsGbymRYspyajVSreDj1EBiTsJQ93JuZlbRnbvTNp1FFpEU1mLczzb2aHsgU2yKQ9I8Tm5CG4QrwviFcqY8NmeXUiajnsYnBa1LJE2t6HTwGZ8yjlxK8P0GbzEN9c8zQCYlIoCbG5Slx3J2zTin6rKOhadaU+cy20hS4S5PZkzv1BEorahxwXTtgHc3dXBNQrrXMUW4WchlWENjDeepGgIW5aApsoyv+0NSY4GHtsxYzrhzLKHxSvYgIazvKMwm0OhexB5cg45u4IKfHsHWvfPf8c6JvCe+J6OVPXXyFY+wQcr99w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5CWYN0MWbtDVXO+9ixo8f07h6pfraSkDIRiQKx2AA/8=;
 b=C80c8Kv5/Zl0kXN2BoKh05ky692Z8PStuqV+j3/xzVAstbfL3U+R6oVUFiM1ujApgGcXFNaeJkNlBPBHjv3uRsCLcv9YM6x8cQsg9G/vV2JAiaKNqV2Hr+rjNLe1BEVe4jCx3z8wzWq4dMSZ/pOwO2vzpSQRK8C0l84No92UmP0=
Received: from TY3PR01MB11346.jpnprd01.prod.outlook.com (2603:1096:400:3d0::7)
 by TY3PR01MB11283.jpnprd01.prod.outlook.com (2603:1096:400:36e::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9434.6; Mon, 15 Dec
 2025 09:48:06 +0000
Received: from TY3PR01MB11346.jpnprd01.prod.outlook.com
 ([fe80::86ef:ca98:234d:60e1]) by TY3PR01MB11346.jpnprd01.prod.outlook.com
 ([fe80::86ef:ca98:234d:60e1%6]) with mapi id 15.20.9434.001; Mon, 15 Dec 2025
 09:48:06 +0000
From: Biju Das <biju.das.jz@bp.renesas.com>
To: biju.das.au <biju.das.au@gmail.com>, "cip-dev@lists.cip-project.org"
	<cip-dev@lists.cip-project.org>, Pavel Machek <pavel@denx.de>
CC: Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	"nobuhiro.iwamatsu.x90@mail.toshiba" <nobuhiro.iwamatsu.x90@mail.toshiba>
Subject: RE: [PATCH 6.12.y-cip 3/3] mmc: renesas_sdhi: Replace magic number
 '0xff' in renesas_sdhi_set_clock()
Thread-Topic: [PATCH 6.12.y-cip 3/3] mmc: renesas_sdhi: Replace magic number
 '0xff' in renesas_sdhi_set_clock()
Thread-Index: AQHcbPN9KsQL4uEXBUCZz9YAvT170LUiddng
Date: Mon, 15 Dec 2025 09:48:06 +0000
Message-ID: 
 <TY3PR01MB1134660570650E9ADAF6C75F886ADA@TY3PR01MB11346.jpnprd01.prod.outlook.com>
References: <20251214121627.4656-1-biju.das.jz@bp.renesas.com>
 <20251214121627.4656-4-biju.das.jz@bp.renesas.com>
In-Reply-To: <20251214121627.4656-4-biju.das.jz@bp.renesas.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY3PR01MB11346:EE_|TY3PR01MB11283:EE_
x-ms-office365-filtering-correlation-id: e0b9aa27-d62a-490a-0629-08de3bbf0c4b
x-ld-processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|376014|1800799024|38070700021;
x-microsoft-antispam-message-info: 
 =?us-ascii?Q?JqZmMrWorH/u671kdZESdrQ4fkM1VLk3DPwHc3LvpSvVrwhIJoWD5ynOZSP0?=
 =?us-ascii?Q?CcMM+7plbA9cEVh5sizID4YEM/+2OHBONfmUjAb9OWtmNgpTih7xt5Ji7hE3?=
 =?us-ascii?Q?WXodbQHOiNiEg9fxXgsmujp2vUDYM7o9+zCSUgwk5vzp8OjbyPhHootBrGIL?=
 =?us-ascii?Q?8kkZEV4vM1rD0jnCSJI3fOJ59CmnWcCCYqFqcpYm7AutFdDMFmotwnKAX6os?=
 =?us-ascii?Q?zcwiGg/9FsI4UhynQszuYow9JrIUMDP71zwB/hmPKAArePY0Bbw2i3itX+YE?=
 =?us-ascii?Q?GuGWpzUYLxvGb9LNxBHNdTny4xx7qE6OgmKobM5wsYeS0iaFyDjtDuZl131n?=
 =?us-ascii?Q?+2CI/HoWz78qsPU2g1cTPZI1qjM1yMiiYF2fgUOcJSmqXC7nr24oVqIr5L5K?=
 =?us-ascii?Q?ok805f22WFu8ZR+R6dLDFam00UzwX4EXJ1CnKZ0ATW6j9NGSPF2q4X5BPkKK?=
 =?us-ascii?Q?5w5HmXX8S7850WqlV+uT/8ha1x6VRpRAyHLAUz2nB9VaLgmpAtlM3OfdmBjU?=
 =?us-ascii?Q?bu/JjwKKC7q7yL2A7nqslkTfXFzfhXSHOByW7EObXEB8Y5s3BJN0VzYCNyKS?=
 =?us-ascii?Q?tY8nT0tKhhYALvMjFKfHgm+qa+bT2jsy+tFcc7U4kxSXZ16sY0+yakO13S4u?=
 =?us-ascii?Q?ZRzIiW50+2Yf4zlX+hokg4zeKCKClzekbulnYYq67Y5cjnYCUs6a+h9LvUr5?=
 =?us-ascii?Q?CpYutxmbe5nnsx92BE+RLOqAB61IcobRgeV2nLMQh45+63EHXsJh+gJhzJlt?=
 =?us-ascii?Q?+PXEZOmPaVBWJmpoiI5FzZOtFXrufLU0fD8G73EhE4mncTtbIzDldhmsu8Uf?=
 =?us-ascii?Q?75BfbCPG6BaEoCS2FZRWJ5mxXFMrFpkaP6XLrdg3TnNxkv/xFs5RKWGzB4cb?=
 =?us-ascii?Q?m9NPVk8/5KAQUh1TMO+T/etv2eyGZwXqQwFh1y+/4U1yNYbq2Z8m5sMkfdhG?=
 =?us-ascii?Q?wWIqU0AlAQB5zoxUczR4onH27o5XP4YP8OXE8NGYrd1Tfo0p0vMnEeCBQJXj?=
 =?us-ascii?Q?fxtBBeDpWzQ10gd9twKDWO/ZLJ4dgE9X8D6U2q9ho6JUpQy7iQGL2RrZnAc8?=
 =?us-ascii?Q?i7fYJfu2pvzvzePvnbyn7FFSRgKwRUjYam/MgO2iLgHsPE0z4BLkzc2hy0Yg?=
 =?us-ascii?Q?ty6D/PVLd3W/ALk3kBh7p5jebrM6xej+2KEjvRYOeR4YpDWKamdufBAAm8to?=
 =?us-ascii?Q?VfeeuqzHMsM5R+5sz9QgCHP+5xVqId+LBZeMn5DuWlFRdJIi7Suepbut055N?=
 =?us-ascii?Q?g5gnG0iHR0uBUFluX9iK/z0Ps8FtanLawAfvoDD5ietOC5ThuEMUmYXZEJAf?=
 =?us-ascii?Q?rdHYtkWcpsHz9eBgrnMu+Wo17+VjDOH52WNSllTJ0dCn5mEZ43GXj3rbhRqr?=
 =?us-ascii?Q?VyaFp0UeVJ/uD/NQgu3GbyAMvNhgIVP7cXgzm3GmVzBUIEfG1nHKTIMXN/YM?=
 =?us-ascii?Q?L7Ok7ZkB7bpps/NUYQvvNp8uTW3/qcKFKu2HqBifSugc2xmjLbd5Crce+gva?=
 =?us-ascii?Q?Wee3afXxzEzVDtCWx2S4AqJVmWN/L2Am31ta?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY3PR01MB11346.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?us-ascii?Q?/GW1rKTnczrGgv2dLL6dHE9Ndd93SzEQc35TUK/YEaYZXT+8wGuk3M9Pw6wK?=
 =?us-ascii?Q?PgB79P9JpcnroCOFl+9ReSMWG37hmSxufRBZMjzvIQrh4MNSsn09zaVbPLf/?=
 =?us-ascii?Q?2gABhJ2XMH6OnHELA3HTZetfWSWVIYcn6rMpO3CPKpdA3jHYFki0hhN9YOCQ?=
 =?us-ascii?Q?2W71Wgqn/2AA18SUa37T5O6JM4/mXfi7+6SV5SzMOncdv9GBHsC7gDG65zFs?=
 =?us-ascii?Q?7Mm2iljJExMf2dJ7WBLkXXXiFaw5fOQ6wb9frurrkNFSvIwz5PBBaIjGgiPO?=
 =?us-ascii?Q?0oIKTh52qqYtbp9kbVjII5ljviZKHVR3lnTVb9S0Fu8MHVTrECU+xE+Epovk?=
 =?us-ascii?Q?iRvvnthGEj7IbVG93ytGfk1puknBQDznvK4jO2nAwaYh7YOJiy2vCFeuZneS?=
 =?us-ascii?Q?d0ID+XsfetEmz5jK2HD5hGWXioQ6Dw01j/SSIWiX7n4mocdB5aSz6h22PR0C?=
 =?us-ascii?Q?+hntgna+gxwEzc9WanL8ududCmB6RlLxBGRVLI0lvnx+5R+HGvKKNoZmSxv8?=
 =?us-ascii?Q?mI9T/jz1ELRCC80OXMzNuBLL0Av5JJJdmFtKZqCxlUXFpKMplnay8ATa0Mj9?=
 =?us-ascii?Q?rlMG3u7Iq/nxDIpNMtqqGyMVgyAqSPDnLKnHDrCffmVzox5LSv5xWPLgJK1S?=
 =?us-ascii?Q?+V7thPGdcAsnkN22zqrqXW6H+jlCfk2JOOLyOmeuNvCzVRm0KMZTH6Ekicwy?=
 =?us-ascii?Q?css/e7c9ASF6iXZk5HOhSf0g7+TatadUx4QQeh1+bwOxuqK3xkWPdcPedFYC?=
 =?us-ascii?Q?VxmEAv7B2S67wdKfLu5WXQ76aH4Oivut51kk9/pdLVQ3ZYuxYSQiZeodT0IT?=
 =?us-ascii?Q?GSeWycLGmRmHR/G90UNZYyDOhnRmu4xIp9BZQkE93KciTqBTvZrd/1VaMAKp?=
 =?us-ascii?Q?7fG2yTucXk+AOmp3q0qsTz0fOKFvnFQ8surnGgpLkKgfC7pkgAPo+5GwVnMj?=
 =?us-ascii?Q?bsEDbX4HPSnrbEqIdJbgG0tj6hUNRsghGLK0SqJT7kjfITsqolJz4pRPPdDD?=
 =?us-ascii?Q?aRKZtmVaKPqNkslM6r9RgiqTNyuyC14YllA0pFRgvcwrz8h81kxvOqX8Y1or?=
 =?us-ascii?Q?yszGeQss082jnrInwUW4MsjwtFbxkYp7+uILIo85gP72UJLQqMdU43bAsB04?=
 =?us-ascii?Q?KEOWQApdMbqp+S9eEjR+Vi2ZqWcyEIeZVxlhxIncrXPbFBkpfpYe/ZC0f1/J?=
 =?us-ascii?Q?oXd4SCIGYeIrPKEB6yLNUp077YnXJALIpxaWQwJVfVsuIEklv766lPHR2X/D?=
 =?us-ascii?Q?sUJJGNNu4Z+K0IQ3T+tbvvcMcsJSumX/Fkhe2ywP9gfGaKSrwis5UqU0Gp1T?=
 =?us-ascii?Q?g41Z37lJ0B1maLURhpDGb5fYtlcKrXft1ZxqvtWBJlpygQ/YHQmboGihItuQ?=
 =?us-ascii?Q?t+PJZNeCDds9pAgncySROBuvN27IWZcLdLy6LQlB3E8JldDYNPPmboRrCFwr?=
 =?us-ascii?Q?gSu5+RtuzQJfeOOhV0vK74jrcs/Kz+2ikcrxUvcTdqBEG6V7kmzgN6K6f1oN?=
 =?us-ascii?Q?ReuDQdJ8LozqobhHSfiBeBpd7Jb37k2M41SKcpT0XLDEgFekfEnO4b3uAy8h?=
 =?us-ascii?Q?IpGWR9GD/X+3CAzrGvz4w3wZ8DFq/hIOQFgcwegc61zGzMER3E9hg7VXZ6ud?=
 =?us-ascii?Q?tA=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY3PR01MB11346.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e0b9aa27-d62a-490a-0629-08de3bbf0c4b
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Dec 2025 09:48:06.4087
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: N65GgJ5PYbWoRCdAECZDNAalkSy6bjtXc0+ZxTTyZecun5ioU/VNamaRT15v8m3yFyeipmFM5gt7Kk1KUSnrFClVJ52rGYWWhejYUfEGkM4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY3PR01MB11283
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 15 Dec 2025 09:48:13 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/21049


+cc
nobuhiro.iwamatsu.x90@mail.toshiba

> -----Original Message-----
> From: Biju <biju.das.au@gmail.com>
> Sent: 14 December 2025 12:16
> To: cip-dev@lists.cip-project.org; Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@=
toshiba.co.jp>; Pavel Machek
> <pavel@denx.de>
> Cc: Biju Das <biju.das.jz@bp.renesas.com>; Prabhakar Mahadev Lad <prabhak=
ar.mahadev-
> lad.rj@bp.renesas.com>
> Subject: [PATCH 6.12.y-cip 3/3] mmc: renesas_sdhi: Replace magic number '=
0xff' in
> renesas_sdhi_set_clock()
>=20
> From: Biju Das <biju.das.jz@bp.renesas.com>
>=20
> [ Upstream commit 5d0702dc9c2f6700140b7366dd9ec6c78cde3aa1 ]
>=20
> Replace the magic number '0xff' with CLK_CTL_DIV_MASK macro for finding a=
ctual clock in
> renesas_sdhi_set_clock().
>=20
> Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
> Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
> Link: https://lore.kernel.org/r/20250820104808.94562-1-biju.das.jz@bp.ren=
esas.com
> Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
> Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
> ---
>  drivers/mmc/host/renesas_sdhi_core.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/mmc/host/renesas_sdhi_core.c b/drivers/mmc/host/rene=
sas_sdhi_core.c
> index f123fcb8e01e..8b898d0229c8 100644
> --- a/drivers/mmc/host/renesas_sdhi_core.c
> +++ b/drivers/mmc/host/renesas_sdhi_core.c
> @@ -223,7 +223,7 @@ static void renesas_sdhi_set_clock(struct tmio_mmc_ho=
st *host,
>  	}
>=20
>  	clock =3D clk & CLK_CTL_DIV_MASK;
> -	if (clock !=3D 0xff)
> +	if (clock !=3D CLK_CTL_DIV_MASK)
>  		host->mmc->actual_clock /=3D (1 << (ffs(clock) + 1));
>=20
>  	sd_ctrl_write16(host, CTL_SD_CARD_CLK_CTL, clock);
> --
> 2.43.0


