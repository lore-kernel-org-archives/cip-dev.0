Return-Path: <biju.das.jz@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C4FFCD98C5
	for <webhook@archiver.kernel.org>; Sat, 13 Jun 2026 05:54:42 +0000 (UTC)
Received: from OS0P286CU011.outbound.protection.outlook.com (OS0P286CU011.outbound.protection.outlook.com [52.101.228.20])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.86466.1781330079023732491
 for <cip-dev@lists.cip-project.org>;
 Fri, 12 Jun 2026 22:54:39 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@bp.renesas.com header.s=selector1 header.b=isvKGSK3;
 spf=pass (domain: bp.renesas.com, ip: 52.101.228.20, mailfrom: biju.das.jz@bp.renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=X/7/6VyKBBUIGmg5rM89MWliR9Km5aOtdK6FAu/zbKWR6UFVJHx+KaY2mfOttFBb5iMGCIdScYelpbb5eN0R133oR8fdF1Z5Lk3EHlQJC72slXXGl9wScWC37jkRzA9bA941wZBVSI2KDUjVdYewmaSwK0IrVZtcJrdTnZAOWf45DKEuMn+2u1IY2mBkkGZy4N5pEg9BHohB32hhvVyf12TgKti8V8RlfAa/VOdamv6mGGO2ceYDwQMwe39jxdW6aXbZzFHb+/AGKRSVgHXG2S83ZA3acAVVEgTAuN7Dt0c4t8HzhtM5nT86Y6SawHL9/bfkpvP8sZlTZpvOenxclg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=m8kiasvl4mgjegTnIKdydCAhTDgcqnfk5v5i9YVZMwQ=;
 b=CofrABJlFigP1ZS/FXCkv1HQp8/iC7wdQ8Dpawma01xChs5olfBTGeir43Fhx4Z1clTrQaNUku+M4a7NLHSrfO/5LdVqHFrVS+mJmJ/+bxP56O445B9obYu+nXTzlGtSRvjFVINrv6WF6IGK7tB4qlwBbg5rawKXgs07wW1jo2ffX1yT9/4XBgnfAkL9vIszTEe5tgF5NxyMNqPkXB0d175QPmBHf/P9Zm5FQsm1+3Z+nH94xE+XCkZFODXJ/suyidPMV/3utD3uZFllUjO4AJ8YTiY9IkLfuBzqtD6OuIa4aDLekRKGVpUm6XLh/mnffW7ELxR0MmQw5RkjYraPuQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=m8kiasvl4mgjegTnIKdydCAhTDgcqnfk5v5i9YVZMwQ=;
 b=isvKGSK3DdU8uWumIohz/c1TTtI5UZESD5ErSUhqSWHLyp3MO/1mtXFSHv3QTjrJvKrZubfpF0TdhU92X43uNFXtEwa3FRvYdIrgQHODGEfnX3DODyU2xFKZT+LwCDMWAo0xc8wUrzF3aotjDD7BIup9sTgikqgKmPwIdKpFGZI=
Received: from TY3PR01MB11346.jpnprd01.prod.outlook.com (2603:1096:400:3d0::7)
 by OS7PR01MB14431.jpnprd01.prod.outlook.com (2603:1096:604:386::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.14; Sat, 13 Jun
 2026 05:54:33 +0000
Received: from TY3PR01MB11346.jpnprd01.prod.outlook.com
 ([fe80::87d1:4928:d55:97de]) by TY3PR01MB11346.jpnprd01.prod.outlook.com
 ([fe80::87d1:4928:d55:97de%4]) with mapi id 15.21.0113.014; Sat, 13 Jun 2026
 05:54:32 +0000
From: Biju Das <biju.das.jz@bp.renesas.com>
To: Claudiu.Beznea <claudiu.beznea@tuxon.dev>,
	"nobuhiro.iwamatsu.x90@mail.toshiba" <nobuhiro.iwamatsu.x90@mail.toshiba>,
	"pavel@nabladev.com" <pavel@nabladev.com>
CC: "cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>
Subject: RE: [cip-dev] [PATCH 6.1.y-cip 21/21] usb: renesas: Suppress binding
 attributes
Thread-Topic: [cip-dev] [PATCH 6.1.y-cip 21/21] usb: renesas: Suppress binding
 attributes
Thread-Index: AQHc+Y+haEmEo1k0l02s8bsIFTTJ97Y7+31Q
Date: Sat, 13 Jun 2026 05:54:32 +0000
Message-ID: 
 <TY3PR01MB113463A4C767A966DE71DE7CC86192@TY3PR01MB11346.jpnprd01.prod.outlook.com>
References: <20260611104532.2532863-1-claudiu.beznea@tuxon.dev>
 <20260611104532.2532863-22-claudiu.beznea@tuxon.dev>
In-Reply-To: <20260611104532.2532863-22-claudiu.beznea@tuxon.dev>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY3PR01MB11346:EE_|OS7PR01MB14431:EE_
x-ms-office365-filtering-correlation-id: f51fd0c8-c888-423e-554a-08dec9103dcf
x-ld-processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: 
 BCL:0;ARA:13230040|376014|23010399003|1800799024|366016|56012099006|11063799006|4143699003|22082099003|18002099003|38070700021;
x-microsoft-antispam-message-info: 
 gBK4tZULCZnktfYL2mVn7Uu1O1S1tz3AktNA1vwn/Tvyz4H6GCWvPpgSYGlVVywSurbR6y17sgotJDLXSpHBazmxYKN1zad/Op0R2O14JdaXxQ4V8qdHZjUvhYweK3SdY5m1CgwvfsYExBvGop6I62eL2LRLi8TD3OBz5yx03ihGWeMSf/YQiQcvHjEoTG/57Fx6yh+UF71w5GAh428SGmEn1iepNAE31QDd6JcF9v7udVvWueNTeEw0d8v1XbyT+zmV/G5JUtYbrRqow8FCQEi64BbqsAfcQrofbpB5vg7capAOs1XLjevwT4TdoRJlA/HUdpjtxqR4cjG3R8Bnr4Gv5iZAViaTB5mzUuEzDvPlf3txO6xqpMY5sIg02ZZjutwq/OpBNU616ZjZz9lVJz2oLgHjqNgdOyfmeHccbab0iyu2g+sCobWbCW4QGgsS5LICQ6ARytOWGHDkoN7H9j4nMzB+Xvrrgm7Fm6wyA7fXpk9du3zwfWJYmrgb7eoHQBQMTn2yQCK3MBlt2xLiGk8dgMguaFti0J95Uhl6CajIOofxRNsI+t/si/N79UlTLWBK3WSS0lr/23d+7Uf3zX3kiwdMgdBsux74d6XKLkWTrLQ1fxvvaWpNNbW05wBp+qogq+XZvAa2O/qA6yGTDgOYiZpDH7Qxho32zgaX6KyT5uK7Rn9n+hinku+vTDqkTnVxAoHSTRWrVKszhpn05vgoQ2HleXFpwKZ/ivGMEqFNq2A5VmCI4X3AB+N8uteS
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY3PR01MB11346.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(23010399003)(1800799024)(366016)(56012099006)(11063799006)(4143699003)(22082099003)(18002099003)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?us-ascii?Q?zo5KOWiLCy0w0pZdaNdDu8v7Drmg2Nnx/wJoVVZennUy0rFzTvHLx71i5USo?=
 =?us-ascii?Q?qFJVD7t9JK3ZEmXXLfeJ19316QNGir0XualLNcrJTZ7byQxnYetuxEXrrO3H?=
 =?us-ascii?Q?4B/wa9RUE7oOp1Ng7GfpYv48t7AWy6CSCugOxW715C5ebbe8UMlV97USEPvR?=
 =?us-ascii?Q?hXHdGP4g9qLt0al+mHWxP1trNVuu7+tTp8ayOkR5UG7pcY3WsRckQ89hX5dY?=
 =?us-ascii?Q?vpRFHZP6THZGRKujVHNU5f6mLys2LiHUcZroyBtwSwxcDohEboZRG2fb8Myc?=
 =?us-ascii?Q?vopg3ueYQk/S4XppG5fsvSSMrew47+t1ULzg+i5WgbLizCQ5CY8i3XdS5ofR?=
 =?us-ascii?Q?xXeQ9nz9OvtT2sDqKwkMTz4kfOUDQecrRsbi8FBVosaUu1u+j0VnnzAb5ldC?=
 =?us-ascii?Q?CI76x/wGHSmfDwajaKvQ2glnPfMFHA2VIQg81ADuNLi68qd6/L4idEV5Aw5e?=
 =?us-ascii?Q?fM6m0+6pYbWaGlSCluFiLMBdgbUNXRk1WzAvKgWxyoyIHu21mZM42rTYMT+o?=
 =?us-ascii?Q?8LT5i1wtwD2fd+vMm3t2+L+XYnWh9ok1MNuSMgYuUsZjuthWTPHhlpP6SME3?=
 =?us-ascii?Q?NZrKIU846/ny27fA51LJnNJ8mO0JQ8qLRgx900tmUw4hiXCnN6mbgHRW3bxE?=
 =?us-ascii?Q?zmzEjf1RBQBytfQfP98qkaZMDrCCc3A82urGyaXHYT6itWFxdErrwUfbQMyw?=
 =?us-ascii?Q?mAL81AgpSyAxkTG2C281OSCOV8BwcRuSY956l1bzrkUYca6bFwltaW6LJ15E?=
 =?us-ascii?Q?VU0P2AV4PzJdg/M9y6g8pJynrvZsacJ20QM4YYsXU50HJZq9U1zkZkMnkSll?=
 =?us-ascii?Q?8Sfuixl0dmNw9BMJktcnlrk/aOI3DOi0HBRvnVAQAcssZYD/+iVzBkQiFeGR?=
 =?us-ascii?Q?O22ICMt8o89d6AXnlfDci0XWPBXDwTG037vBjd5vMYSwIWl8xE80XXftkm3t?=
 =?us-ascii?Q?g5fzHHbDoVJNSFO5EGW4x+LYWFQ2a0YdpCTnjPiz14FrMO2DdurHsoKNp8Lb?=
 =?us-ascii?Q?K2OLSj2S42sgNRxWaiSw8GXFfFVlubIcO8MK+YBy/rnbqUAUMQ4JrAd+zRlB?=
 =?us-ascii?Q?RPbuZwiRDDhIl7d3rwfsewVPKOmv7ab4dKoATWWdatx0vgKTcp3ld76xZ/KD?=
 =?us-ascii?Q?Y2Oku4B6f3A1HlXIkZhVSnZRaY8x4+5nmwHqrTXFqNiX1D4AQKgrEg/tBrdG?=
 =?us-ascii?Q?u361wVDIMOyZ8nSvyza/IrNIfzPa7cmvlGk5kHj5rU++HKG2zZilFTp6GTTh?=
 =?us-ascii?Q?TSqzEz951t2ORx937uIFHfaj4VbjMAV7nD9G5A6JCPfZYML47/mrjN/jVLcB?=
 =?us-ascii?Q?4gtwaXD9JYm7z+ZYlkDJ6el8v5LUBNsXKd6PXoBwcKmO7y5kr2aSvN1tiu0M?=
 =?us-ascii?Q?QsZWjUEg1CrFvA5exgkzQm6Ol6FJJ2nfHIs0UadWb+Hkq6u5IGl3Zvbc3/g5?=
 =?us-ascii?Q?J2OBQDvgXXFexS0z0Pe+jvn7NaLESMbKTSad4l6/C3jvVNNkkz+hRmss5oPd?=
 =?us-ascii?Q?aU100BpNNAXT8tuurYkE6Uxyh8QaPyhNKzK0ZuUSmxS2e6z3jxFDc6XnYHxb?=
 =?us-ascii?Q?wYyojmHZLWxd1iSGBWVwdsQhXhGaOgQvzfiKutfATPFYMDIZW0Eb9j5r0WSR?=
 =?us-ascii?Q?5prZdAe+ZjFlayjJZ1r9VaGTN7K6X3CFADs6fwnDen/GdYRZ6yLdea4ar4Ix?=
 =?us-ascii?Q?z/Cbuovs6dTcH7Ga1cgWu9fHDP9dKCclSh/JIFKtApc7PWDDTXs9aFX5votX?=
 =?us-ascii?Q?tijALGp+3g=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY3PR01MB11346.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f51fd0c8-c888-423e-554a-08dec9103dcf
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Jun 2026 05:54:32.6300
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: uH8U0cpxty6vnrXQ5SnfZMFIWgj15Fi55MKTiEid/V45hm2vlkz5oITxrbVDK78FQ4RiN91XyN3s/dW3Do2HvjndXLuCUuMGZAStip1R+NY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS7PR01MB14431
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Sat, 13 Jun 2026 05:54:42 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/23132


Hi Claudiu,


> -----Original Message-----
> From: cip-dev@lists.cip-project.org <cip-dev@lists.cip-project.org> On Be=
half Of claudiu beznea via
> lists.cip-project.org
> Sent: 11 June 2026 11:46
> To: nobuhiro.iwamatsu.x90@mail.toshiba; pavel@nabladev.com
> Cc: cip-dev@lists.cip-project.org
> Subject: [cip-dev] [PATCH 6.1.y-cip 21/21] usb: renesas: Suppress binding=
 attributes
>=20
> From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
>=20
> In v6.1 CIP the drivers that are involved for the USB to work on the Rene=
sas RZ/G2L based devices are
> the following:
> - rzg2l_usbphy_ctrl
> - phy_rcar_gen3_usb2
> - ochi, echi, renesas_usbhs
>=20
> The drivers tree is as follows:
>=20
>         +-----------------------------------------------------------+
>         |                                                           |
>        \ /                                                          |
>         `                                                           |
> rzg2l_usbphy_ctrl <--> phy_rcar_gen3_usb2 <--+--> ohci <------------+
>                                              +--> ehci <------------+
>                                              +--> renesas_usbhs  <--+
>=20
> Where:
> - rzg2l_usbphy_ctrl provides reset signals to phy_rcar_gen3_usb2 and
>   OHCI, EHCI, renesas_usbhs drivers
> - phy_rcar_gen3_usb3_usb2 request reset signals from rzg2l_usbphy_ctrl
>   and provides PHYs to OHCI, EHCI, renesas_usbhs
> - OHCI, EHCI, renesas_usbhs drivers gets resets from rzg2l_usbphy_ctrl
>   driver and PHYs from phy_rcar_gen3_usb2
>=20
> In the current v6.1 CIP tree, unbinding any of the providers in the menti=
oned diagram does not force
> the unbinding of the consumers. In these scenarios, the consumers remain =
with stale resources.
> Subsequent operations that require resources from the providers will fail=
, either silently or loudly
> (crashes). Rebinding the previously unbound provider does not resolve the=
 issue either.

Not sure, have you tried with this patch[1]?

On mainline while adding RZ/G3L USB2.0 host support, I used to get WARN_ON =
for regulator enable count during
PHY unbind/bind and is fixed by[1]

PHY unbind releases regulator, PHYS to OHCI/EHCI, so I get USB disconnect

PHY bind acquire vbus regulator, PHYS to OHCI/EHCI, and I get USB connect

[1] https://lore.kernel.org/20260612143048.317907-10-biju.das.jz@bp.renesas=
.com/T/#u

Cheers,
Biju

>=20
> The only way the unbind/bind sequence works for the above-mentioned scena=
rio is to perform the unbind
> starting with the consumers and ending with the providers, and to perform=
 the bind starting with the
> providers and ending with the consumers.
>=20
> Suppress the binding attributes.
>=20
> Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
> ---
>  drivers/phy/renesas/phy-rcar-gen3-usb2.c | 1 +  drivers/reset/reset-rzg2=
l-usbphy-ctrl.c  | 1 +
>  2 files changed, 2 insertions(+)
>=20
> diff --git a/drivers/phy/renesas/phy-rcar-gen3-usb2.c b/drivers/phy/renes=
as/phy-rcar-gen3-usb2.c
> index 03d6183a385f..a67a9e688dca 100644
> --- a/drivers/phy/renesas/phy-rcar-gen3-usb2.c
> +++ b/drivers/phy/renesas/phy-rcar-gen3-usb2.c
> @@ -903,6 +903,7 @@ static struct platform_driver rcar_gen3_phy_usb2_driv=
er =3D {
>  		.name		=3D "phy_rcar_gen3_usb2",
>  		.of_match_table	=3D rcar_gen3_phy_usb2_match_table,
>  		.pm		=3D pm_ptr(&rcar_gen3_phy_usb2_pm_ops),
> +		.suppress_bind_attrs =3D true,
>  	},
>  	.probe	=3D rcar_gen3_phy_usb2_probe,
>  	.remove =3D rcar_gen3_phy_usb2_remove,
> diff --git a/drivers/reset/reset-rzg2l-usbphy-ctrl.c b/drivers/reset/rese=
t-rzg2l-usbphy-ctrl.c
> index 3f88550a6946..3af61bbe7f98 100644
> --- a/drivers/reset/reset-rzg2l-usbphy-ctrl.c
> +++ b/drivers/reset/reset-rzg2l-usbphy-ctrl.c
> @@ -343,6 +343,7 @@ static struct platform_driver rzg2l_usbphy_ctrl_drive=
r =3D {
>  		.name		=3D "rzg2l_usbphy_ctrl",
>  		.of_match_table	=3D rzg2l_usbphy_ctrl_match_table,
>  		.pm		=3D pm_ptr(&rzg2l_usbphy_ctrl_pm_ops),
> +		.suppress_bind_attrs =3D true,
>  	},
>  	.probe	=3D rzg2l_usbphy_ctrl_probe,
>  	.remove	=3D rzg2l_usbphy_ctrl_remove,
> --
> 2.43.0


