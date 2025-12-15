Return-Path: <biju.das.jz@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82750D59D99
	for <webhook@archiver.kernel.org>; Mon, 15 Dec 2025 09:45:13 +0000 (UTC)
Received: from OS0P286CU010.outbound.protection.outlook.com (OS0P286CU010.outbound.protection.outlook.com [40.107.74.48])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.44954.1765791905032973910
 for <cip-dev@lists.cip-project.org>;
 Mon, 15 Dec 2025 01:45:06 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@bp.renesas.com header.s=selector1 header.b=JDpo8eYR;
 spf=pass (domain: bp.renesas.com, ip: 40.107.74.48, mailfrom: biju.das.jz@bp.renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OSG9L18/HZ0ElTARk9CUcOGKBp0U6w3huXglm5RpIUElgHX5F/io1aRPbc1oLglXMODvuYh9sPQ1wqe1hIUlgrMPZpibOgTedU2BBtMRy0Hcso0ekZ0BhWw6o+5EXEfze873vl+URzDxLYnb7vjHVHvEWaY/Wxjxzo+Y0lrc+YhQnpdpj3tD9UJD5qYXK0+r2lpLrQQrAww4oToP0z4GGmPofYwZH/FaMNVmhHTjMIR2waXYqOSeHaoZH8n+4RsAUIbdfRW48++ouiCOeeO1v7DfQXlBPmly1dtxdz+fuonrA+NIvqJeCRbG415zHjb0oyaHV9W0thwNuQ2+zRpDqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xjuWn3obCRO2i8zF2XSfHKJoGfqjbe4Bogr/dakjdeg=;
 b=GtpGByfvpajLUsItzuFEHsX1oBzgVlOJy7o+FbkRPosILa/ChcMRuiQTf2XoJVLgKmO6uTI0maIxN8P1Z0R4eO7/Dwj39F7sDSmbWNcd8d1ani/lMctEk6IevNZpooNBi2FC0+WDvq5LIW+NSQwQXNOz2Ie2mn1jqXEnkcn4n1xjfQs5EvCZndQ/FzA5KwRCgfa6Q+89lSKRBl33S8U9mTv4JtbqLptOxF+IMGDS30FJHIo+riWKkH6EiLA3A5cegi0WaT5YOa96gDeK9L3Y18CJhDPKLONuu5LLMzQEz4WY71iHJLCMbwkyYvTfL/lxKkbG+ray1yUvkqtIsfmgyw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xjuWn3obCRO2i8zF2XSfHKJoGfqjbe4Bogr/dakjdeg=;
 b=JDpo8eYRd3tQ3apzOrn4Yvf4sLQ6tc04aAZxOm//RUGDEMUbmuoL+yQZPGg7GtpDJJmBycR+ee0Y1WJW2yQp4Ie7OP0cK+olnQlOc9KJuHZzYBnCn0Tk1Q+0txZFkhi3leGc6hn99RQFRxjiGooUf4o1ZoSML0iL9wh2/7dOouI=
Received: from TY3PR01MB11346.jpnprd01.prod.outlook.com (2603:1096:400:3d0::7)
 by TY3PR01MB11283.jpnprd01.prod.outlook.com (2603:1096:400:36e::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9434.6; Mon, 15 Dec
 2025 09:44:59 +0000
Received: from TY3PR01MB11346.jpnprd01.prod.outlook.com
 ([fe80::86ef:ca98:234d:60e1]) by TY3PR01MB11346.jpnprd01.prod.outlook.com
 ([fe80::86ef:ca98:234d:60e1%6]) with mapi id 15.20.9434.001; Mon, 15 Dec 2025
 09:44:59 +0000
From: Biju Das <biju.das.jz@bp.renesas.com>
To: biju.das.au <biju.das.au@gmail.com>, "cip-dev@lists.cip-project.org"
	<cip-dev@lists.cip-project.org>, Pavel Machek <pavel@denx.de>
CC: Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: RE: [PATCH 6.1.y-cip 1/3] net: phy: micrel: Add PHY Auto/MDI/MDI-X
 set driver for KSZ9131
Thread-Topic: [PATCH 6.1.y-cip 1/3] net: phy: micrel: Add PHY Auto/MDI/MDI-X
 set driver for KSZ9131
Thread-Index: AQHcbPFhEwdy56RlmUa2wManHgl5hLUidQcA
Date: Mon, 15 Dec 2025 09:44:59 +0000
Message-ID: 
 <TY3PR01MB113467852BA05C19B25BC982386ADA@TY3PR01MB11346.jpnprd01.prod.outlook.com>
References: <20251214120122.3784-1-biju.das.jz@bp.renesas.com>
 <20251214120122.3784-2-biju.das.jz@bp.renesas.com>
In-Reply-To: <20251214120122.3784-2-biju.das.jz@bp.renesas.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY3PR01MB11346:EE_|TY3PR01MB11283:EE_
x-ms-office365-filtering-correlation-id: 915a4d22-d990-40b1-d606-08de3bbe9cfe
x-ld-processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|376014|1800799024|38070700021;
x-microsoft-antispam-message-info: 
 =?us-ascii?Q?rtaoReGpzofYK6BdKIjfOLVg+H3GqVNUP2iPBD78b35sVikJKVH3ZGWX/33E?=
 =?us-ascii?Q?1fFCmjTD7w9ME/7ABl5ZGAJiSm1LEf2zqtDoJBH/tfQra/ZwSdN7w7gdAKq8?=
 =?us-ascii?Q?YXaIvu3vlRRjo2TvFEPlv/Rs1ZGgbG84039VBvrxrFatl6x/PmEMqCDV13RN?=
 =?us-ascii?Q?gQq+8DEOJQuz2PyP+plNNrVjBMinplPkjDWKzNQJCyu5C0hocZBWXu3su0Wn?=
 =?us-ascii?Q?qDyHdoqkX/Enayzk+an3DYK9HJYiJ/e9K9m3BeTH/xjQ/Zugg2GKrPW6tIQr?=
 =?us-ascii?Q?kgIq8b0xB7Xa8/04Idm1nTxMjj/+aYU7tLDwC06BpR0oLZl+wSXLljxqZrAD?=
 =?us-ascii?Q?Gfxub5unG/xJCWBp4CjkWe01Z2n0EdcLq/cdbFdflrEw2rrQgDCBzz+Ttfal?=
 =?us-ascii?Q?/g61sk8Nl0C3Ku6RmAA7yQTPdhw0kO94oAKFbnTfRjopGf0LHk3BGWVsoWjs?=
 =?us-ascii?Q?0ivgAbJah8ecznZs04tKrhclMuljQMESwPSSPCQEYRQsvjL+QJi5IutkpyMj?=
 =?us-ascii?Q?ms1nksn3qf+M+wng2/9PibRL4qsqNxlVoM2WEk97EnQHnUH9UqH73owQ3hvC?=
 =?us-ascii?Q?mcGYR9lcnvdvMEbSHr7P7mE13VOjZuhmY6S4fUiiD+wBTNJ5O9EYBi2v+osY?=
 =?us-ascii?Q?iXMua+d2jSQjikHn9S05txm+YI1/us9Ynsd6UjSphiS794F5UsjimMnu147i?=
 =?us-ascii?Q?caJfOmk+2VDA3dpZwb+MWIJsWBzm1KV+P40+FxXs++sckUSafMScbmuQOHZn?=
 =?us-ascii?Q?iR+4npe46ua/mYvtEg8ULdr6FeEpmF9lyT0exem0yzdJb9v1qzWhRNPglqk9?=
 =?us-ascii?Q?uls7ZY1naDoQE8Unych6CisywCPlIuekicTAyAXe04OQuFT92bfqWYYyfgEH?=
 =?us-ascii?Q?ycvQWv3HnoSQjHpswvKaQgUmRqGiI2TIS6HAGC9N0nkV2CgVE4/E6HWaSu8M?=
 =?us-ascii?Q?oRVkFcgIouRnGSsOxuC2nmfgjI54yx8Ric50wrlUyJaaH21cnA6C7Lawqhd4?=
 =?us-ascii?Q?v0wlujl5mmF7rRb4l+QirWDIA7yRLJHBpPUt3b490kMk8ujr638xnaVN9pyP?=
 =?us-ascii?Q?SdcPE/qqGChMQ3IJyUnybnInqpR4Y5dZAd4IroofWiTcXkL38x8fxIUAcj+p?=
 =?us-ascii?Q?1TRckKqsNbifBzfvehV8HaUKHzjESl9OTKo4M6pkOInN3OeThDd6HXsWqZKb?=
 =?us-ascii?Q?VVv7eMyENbhikRcWZfmEo1ZXfvUYjmNp7A06KIIb27+KaND3AlY/kfvVHzDL?=
 =?us-ascii?Q?w09xBKT3GgkEKlUPOp0CCMBvrAuAjNcdId2N3V7fW87xVQ/WzUUjeSbO6lKF?=
 =?us-ascii?Q?7WwauJsSHbPZAjDmmAHRl15AZsXXATCXWFhkYFxmtL/prP0Udhp6m4MzflQp?=
 =?us-ascii?Q?rAk7a0Xt/ugCflGOjy9F2D+6AnYB3GVAaZAL9TN17tawCUAGpwpjP7l3NVfg?=
 =?us-ascii?Q?Zafpue8s8EAFmmQMCx/JaYaKD4B0aAvT+11d4tJP+hUaaz/LJAfqkCbCrfI/?=
 =?us-ascii?Q?SfO2piSEfmQqqnIXNMzAoDnW1iuuwNgVxPJI?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY3PR01MB11346.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?us-ascii?Q?gDxHl9AhVgGHI6ZNnd1raQp0XE8oSPMW2wVE/7I+oaH2QWTR+sIQbg23LENg?=
 =?us-ascii?Q?soP4DH6/uwIC9aRZ0z8r+c2A7qe7RPAHGgZfWAGyKG7ARJMQKVvq0BPMPY8x?=
 =?us-ascii?Q?j822tWrWmtK2Qkn/AkVFkbOt5PCuFkifYZLGOjlNHsi4QmbzHXqMT1tfbJLu?=
 =?us-ascii?Q?raUc+Lf5BT3OAdE+F++K2ObB0qcrn2n5mt100KJhAJ26DxU77a0ReMBaSA8k?=
 =?us-ascii?Q?J2+y8lG8eeHIcvCP+ZvpCVGWLu4V+cqvO+hPA2DPGAMLW2n2mdPImYhXGhde?=
 =?us-ascii?Q?XWbAqRU+QlHS6n769q6KbDDjtitoj68uPKBKqisWzni3vI9DKJ2roWO/ykrC?=
 =?us-ascii?Q?J/BoDUg6nMliuJ6XVg5dpd1NDnAQiz8eugTWGxoz2ph/91Q4fpuXNF5G1ZbA?=
 =?us-ascii?Q?a5C6tCNzqhXYAZtfmVB0jHNPP/Kq/olKwJq4xDOW7zF+vg9mnr/LH3rogIHE?=
 =?us-ascii?Q?MxvAKRXE6ayAZq7NiLGABn30CSGwz8xC038h+lPxnd1cpCp0Fk1S6Vi18BCB?=
 =?us-ascii?Q?HQB6vuUPvTDFpi/5GyRvWGQLgFT7rNqNdAm8BngdWsVojIXr3t1agG+TEb+a?=
 =?us-ascii?Q?FXG6ecDG6KZBpSe1aY/V1avRBwHTaaFXve7OGhbB/rZqqyVbFVd7og7QULs3?=
 =?us-ascii?Q?xBDG+BM6r88w5ccc08KIsB/tGVVIL2zagmvCxgmQm1T2sGCt1LvPnyH4fwd2?=
 =?us-ascii?Q?zKQeU2x37n0YuwsaqLXhL62SpNrImkY7bvN3fKfFI7IoAfyGQUfoA7EoprCn?=
 =?us-ascii?Q?9oK4Kvr6a4hCBEAPDZrjFOPXTaUnhXRlftyyWCb5vAD0jm9P0JdshXETMlSQ?=
 =?us-ascii?Q?5unEv6hsFop2DvDI1RvB8vFkk1W3++EtmA2930L+xSfLX6QfEip8iUDFb1dv?=
 =?us-ascii?Q?e6ZRP9Q7QT2tGZJiJCqgI2+rgV4ofEE/c7Jvd5lRrN8jRd/TwpXl+VlcGoEW?=
 =?us-ascii?Q?V9PaT22+u1YpuqsWk870S8tnvWeAkjn497M12uuZJiON40iUOY7yPtXwR8MI?=
 =?us-ascii?Q?hK9SOkoSorobVhG2uAwSumXgrpaQv+xFV7pLctAJVvGea44bOmSH0s/2SnaE?=
 =?us-ascii?Q?rXOiuflQmS5gPitd1AV8tbKPka2Yxfkdmu5BTrKXviXakrsNfyo8AqMGwgb6?=
 =?us-ascii?Q?Axu/hFaoBJpX5gLhzWUY4v1ARxgC2p5ezI8cLXh5GSpWisHWn8Rzy8ysokOM?=
 =?us-ascii?Q?s42Qg5kf9IhLgziIvh1kbQj6/fml1VN6xB8+4HEDbw0l5PlNz8OWP/x3a952?=
 =?us-ascii?Q?U1Vs998bpMP1jL8Hbq5/cjXrzphNBGrMq19XVod31omRKw0R3Hgwv2q33X2r?=
 =?us-ascii?Q?4PLAHv9HibFaxI6RPrzoXIqIUr9dhnqsPFkhtlv2mzkjEr0cVgg1oZ9h7Ubz?=
 =?us-ascii?Q?SOX5+KcNd3UWAUCy18Y3KQ2RtqZcS5KCSVACTIMS5Yhjma9Csco0yz2b1Eac?=
 =?us-ascii?Q?yXzvpNHpHcKxRmPZ/fPNvMG9sinXrQAZDIEE/bdZ/4JSi3e1myW0d3QruCCX?=
 =?us-ascii?Q?HC2sNFVM/xQ6bcgLy2f52wXnlE7dyMNQa8kbvDqs3DPm1SxF3I6AtYfAeZgn?=
 =?us-ascii?Q?qcDJEXtmA0wFpT7thBH3b99Hfm0X4Dl88LZ2Z8pS?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY3PR01MB11346.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 915a4d22-d990-40b1-d606-08de3bbe9cfe
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Dec 2025 09:44:59.6669
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: FFrBQx/Tw4iMEA94GTx/3DxbUV6l/0CAt2zFV6Qu9s2q7CN19mlgbFLTj04wwzR0eihS5CWXTuFZrhgaNNw0F/lpgkkSOuvY+Ec5G31XVKU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY3PR01MB11283
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 15 Dec 2025 09:45:13 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/21037

+cc=20
nobuhiro.iwamatsu.x90@mail.toshiba as Nobuhiro Iwamatsu <nobuhiro1.iwamatsu=
@toshiba.co.jp>
bouncing.

> -----Original Message-----
> From: Biju <biju.das.au@gmail.com>
> Sent: 14 December 2025 12:01
> To: cip-dev@lists.cip-project.org; Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@=
toshiba.co.jp>; Pavel Machek
> <pavel@denx.de>
> Cc: Biju Das <biju.das.jz@bp.renesas.com>; Prabhakar Mahadev Lad <prabhak=
ar.mahadev-
> lad.rj@bp.renesas.com>
> Subject: [PATCH 6.1.y-cip 1/3] net: phy: micrel: Add PHY Auto/MDI/MDI-X s=
et driver for KSZ9131
>=20
> From: Raju Lakkaraju <Raju.Lakkaraju@microchip.com>
>=20
> [ Upstream commit b64e6a8794d9d56f9713b6ceb9e3fdfc9c5f99af ]
>=20
> Add support for MDI-X status and configuration for KSZ9131 chips
>=20
> Signed-off-by: Raju Lakkaraju <Raju.Lakkaraju@microchip.com>
> Reviewed-by: Horatiu Vultur <horatiu.vultur@microchip.com>
> Reviewed-by: Andrew Lunn <andrew@lunn.ch>
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> [Biju:
>  squashed the commit 84383b5ef4cd21b4a67d ("net: phy: micrel: Fix the KSZ=
9131 MDI-X status issue")]
> Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
> ---
>  drivers/net/phy/micrel.c | 81 ++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 81 insertions(+)
>=20
> diff --git a/drivers/net/phy/micrel.c b/drivers/net/phy/micrel.c index b8=
d1c0d207c4..63392514c894
> 100644
> --- a/drivers/net/phy/micrel.c
> +++ b/drivers/net/phy/micrel.c
> @@ -1256,6 +1256,8 @@ static int ksz9131_config_init(struct phy_device *p=
hydev)
>  	const struct device *dev_walker;
>  	int ret;
>=20
> +	phydev->mdix_ctrl =3D ETH_TP_MDI_AUTO;
> +
>  	dev_walker =3D &phydev->mdio.dev;
>  	do {
>  		of_node =3D dev_walker->of_node;
> @@ -1302,6 +1304,83 @@ static int ksz9131_config_init(struct phy_device *=
phydev)
>  	return 0;
>  }
>=20
> +#define MII_KSZ9131_AUTO_MDIX		0x1C
> +#define MII_KSZ9131_AUTO_MDI_SET	BIT(7)
> +#define MII_KSZ9131_AUTO_MDIX_SWAP_OFF	BIT(6)
> +#define MII_KSZ9131_DIG_AXAN_STS	0x14
> +#define MII_KSZ9131_DIG_AXAN_STS_LINK_DET	BIT(14)
> +#define MII_KSZ9131_DIG_AXAN_STS_A_SELECT	BIT(12)
> +
> +static int ksz9131_mdix_update(struct phy_device *phydev) {
> +	int ret;
> +
> +	if (phydev->mdix_ctrl !=3D ETH_TP_MDI_AUTO) {
> +		phydev->mdix =3D phydev->mdix_ctrl;
> +	} else {
> +		ret =3D phy_read(phydev, MII_KSZ9131_DIG_AXAN_STS);
> +		if (ret < 0)
> +			return ret;
> +
> +		if (ret & MII_KSZ9131_DIG_AXAN_STS_LINK_DET) {
> +			if (ret & MII_KSZ9131_DIG_AXAN_STS_A_SELECT)
> +				phydev->mdix =3D ETH_TP_MDI;
> +			else
> +				phydev->mdix =3D ETH_TP_MDI_X;
> +		} else {
> +			phydev->mdix =3D ETH_TP_MDI_INVALID;
> +		}
> +	}
> +
> +	return 0;
> +}
> +
> +static int ksz9131_config_mdix(struct phy_device *phydev, u8 ctrl) {
> +	u16 val;
> +
> +	switch (ctrl) {
> +	case ETH_TP_MDI:
> +		val =3D MII_KSZ9131_AUTO_MDIX_SWAP_OFF |
> +		      MII_KSZ9131_AUTO_MDI_SET;
> +		break;
> +	case ETH_TP_MDI_X:
> +		val =3D MII_KSZ9131_AUTO_MDIX_SWAP_OFF;
> +		break;
> +	case ETH_TP_MDI_AUTO:
> +		val =3D 0;
> +		break;
> +	default:
> +		return 0;
> +	}
> +
> +	return phy_modify(phydev, MII_KSZ9131_AUTO_MDIX,
> +			  MII_KSZ9131_AUTO_MDIX_SWAP_OFF |
> +			  MII_KSZ9131_AUTO_MDI_SET, val);
> +}
> +
> +static int ksz9131_read_status(struct phy_device *phydev) {
> +	int ret;
> +
> +	ret =3D ksz9131_mdix_update(phydev);
> +	if (ret < 0)
> +		return ret;
> +
> +	return genphy_read_status(phydev);
> +}
> +
> +static int ksz9131_config_aneg(struct phy_device *phydev) {
> +	int ret;
> +
> +	ret =3D ksz9131_config_mdix(phydev, phydev->mdix_ctrl);
> +	if (ret)
> +		return ret;
> +
> +	return genphy_config_aneg(phydev);
> +}
> +
>  #define KSZ8873MLL_GLOBAL_CONTROL_4	0x06
>  #define KSZ8873MLL_GLOBAL_CONTROL_4_DUPLEX	BIT(6)
>  #define KSZ8873MLL_GLOBAL_CONTROL_4_SPEED	BIT(4)
> @@ -3336,6 +3415,8 @@ static struct phy_driver ksphy_driver[] =3D {
>  	.soft_reset	=3D genphy_soft_reset,
>  	.config_init	=3D ksz9131_config_init,
>  	.config_intr	=3D kszphy_config_intr,
> +	.config_aneg	=3D ksz9131_config_aneg,
> +	.read_status	=3D ksz9131_read_status,
>  	.handle_interrupt =3D kszphy_handle_interrupt,
>  	.get_sset_count =3D kszphy_get_sset_count,
>  	.get_strings	=3D kszphy_get_strings,
> --
> 2.43.0


