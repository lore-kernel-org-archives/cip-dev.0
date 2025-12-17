Return-Path: <biju.das.jz@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C542D64083
	for <webhook@archiver.kernel.org>; Wed, 17 Dec 2025 07:04:34 +0000 (UTC)
Received: from OS0P286CU010.outbound.protection.outlook.com (OS0P286CU010.outbound.protection.outlook.com [40.107.74.55])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.9146.1765955071428793234
 for <cip-dev@lists.cip-project.org>;
 Tue, 16 Dec 2025 23:04:32 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@bp.renesas.com header.s=selector1 header.b=LCYp+HDm;
 spf=pass (domain: bp.renesas.com, ip: 40.107.74.55, mailfrom: biju.das.jz@bp.renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=C3WfACQ3BzWGPpQzTwwuo+mH++EsUNX575NxUviL81oGz44ptZEzg2Rgb8PBusefVwBsLuHbL1FLzY7YH4TB9Ye+DsVfK3oHAEU0rnL0v9gPEsPL8b04gpjaBQahqoRURvhR+HQ03Zs/CC23hwMYZiOu04JMbNt12oTzOhdRX0cBtglzA0HwyjJ/VyC2BLjfj4S8b3rVUnjac6uYrOvhCKWd7XyBP09dwWCE3hZg5zjiYw8l6hVO4p4k/3BB1dnFLVnTFtHmDMptRUEobHOBKzzMc8LNvULhJkFhXqjZl0bLytclt2IQfbLr2HHaKZBc/BU53ugQ+99agvJKUbeAWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WjNTIe3MKm2QZGPeHiE2OBp8/K+kHnxcn4H4sfSrlc4=;
 b=vfq7TDLs3hgvY7l5HFELfnewoUZFPiAusRK4k7ocWiID/QNI8W13WaCrmYPkIUq+6XAQTd+hHVWpX4ZqsD8efdONUej1EkEGjFzNLuzsnynW16TgLGp+0ToA7ZUm4hsEnpRGNgiASaaE2r1qzPeC+c24pX0e8mPWbKwJNhowgFPN4U2xapF6tc5Tx3SxR+yLfVkyOLgfl/67W47t8EVZNEUkLVfVKlMo+EUfr5EAz6u4++BjHfcroGVXdzRcoULtE9Yji3tiXONVrQIKEgPH+lDkYVtNYmLcWzbfqI1ICN5MBoYxk7S1EinbfZ4/UXRWU1tykkZBJVIYucBmJyq1Ig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WjNTIe3MKm2QZGPeHiE2OBp8/K+kHnxcn4H4sfSrlc4=;
 b=LCYp+HDmTq5v2392z5B+IdTsYE8oMUzAiFq1WONkIF3TYlJouunzshiijqGxJ/82FA1JW9/cxkmXSsPkOWl/U3NLCpWv74Ljm+KP5tKDaVwNj7o46Y+YHpkSHcBl4oS5Ky0GgJAVlTk2/cxNw7SV8ozfnesGGrRpx19rKMttsmE=
Received: from TY3PR01MB11346.jpnprd01.prod.outlook.com (2603:1096:400:3d0::7)
 by TY3PR01MB11075.jpnprd01.prod.outlook.com (2603:1096:400:3ae::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9434.6; Wed, 17 Dec
 2025 07:04:25 +0000
Received: from TY3PR01MB11346.jpnprd01.prod.outlook.com
 ([fe80::86ef:ca98:234d:60e1]) by TY3PR01MB11346.jpnprd01.prod.outlook.com
 ([fe80::86ef:ca98:234d:60e1%6]) with mapi id 15.20.9434.001; Wed, 17 Dec 2025
 07:04:25 +0000
From: Biju Das <biju.das.jz@bp.renesas.com>
To: biju.das.au <biju.das.au@gmail.com>, Pavel Machek <pavel@denx.de>,
	Nobuhiro Iwamatsu <nobuhiro.iwamatsu.x90@mail.toshiba>
CC: Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	"cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>
Subject: RE: [PATCH 6.1.y-cip] net: stmmac: dwmac-renesas-gbeth: Add .init()
 callback
Thread-Topic: [PATCH 6.1.y-cip] net: stmmac: dwmac-renesas-gbeth: Add .init()
 callback
Thread-Index: AQHcbyLtDmWrq4MzoUiD5y8lvBCts7UlaFXw
Date: Wed, 17 Dec 2025 07:04:25 +0000
Message-ID: 
 <TY3PR01MB11346707A32A20B7204257E8886ABA@TY3PR01MB11346.jpnprd01.prod.outlook.com>
References: <20251217070100.3680-1-biju.das.jz@bp.renesas.com>
In-Reply-To: <20251217070100.3680-1-biju.das.jz@bp.renesas.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY3PR01MB11346:EE_|TY3PR01MB11075:EE_
x-ms-office365-filtering-correlation-id: 9b9a6d31-197e-4326-ba31-08de3d3a832b
x-ld-processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|376014|366016|38070700021;
x-microsoft-antispam-message-info: 
 =?us-ascii?Q?w05xMrfVM6gcD58iBo5MVXDsG9kdPv8uGIgVLHit3vA4A8QqSWAcoPkIVMmP?=
 =?us-ascii?Q?zGp6KmqnbnqJ0AO/yFvdp7yrVFhr1dcX5QcZTrL6KjAXefJkf/gPdB8ObTxb?=
 =?us-ascii?Q?pUdiZ3RXRZ05KW/4K3s2epgrJZkP7pkpUVlQAx2R/H09RU4MofRkB8r41r67?=
 =?us-ascii?Q?UC1az0reosCT7B8O2cOfgz3TelHd5ouIh8lMZRIcwIJKOfekIvH9hPSOEG0v?=
 =?us-ascii?Q?UojJQPc9f/Sp48w7Wrig7cZiB/aUb7HPUeXqtp3fGA7Imys/FgQMwI32nWuP?=
 =?us-ascii?Q?PppigIFVHpXgJbabQ1VhBvkig/Uvj5MLYOhSoy+6xT1/wJDsM4aszMbIRr9y?=
 =?us-ascii?Q?lfQxlaBHQMaR5+wehHiR7vdQKA5lD6TwLbRnAMLaNhvSlNiIDliQntY8d2go?=
 =?us-ascii?Q?cfFhTk4V8/sSQiCxH89hg8N8KSxBkDqfogb2zxPTuXtKHjsxRSeSy0/QmP0u?=
 =?us-ascii?Q?92kaMuRUdMjkvozizQJr7R1frYfS6ttrn21YgHDHn66Yq0k6typ2SJFf/8PR?=
 =?us-ascii?Q?Jb61EQnoWGzaVD8tchrhJxUMMAYNxnWVyYoc7cX1QF2hLmRFG8Yi2NmvVQbl?=
 =?us-ascii?Q?CYbZWK5Rr3flfkd12cBFz7Jg33fNoZe6FOh/lFY85Rxb5kxzzmPpi1XSLRBg?=
 =?us-ascii?Q?npw/hVwR+Yw0W724QaQIRmy+NAp2r94EfI4Fv5pmsSRPDEDpta4hCsD+rWRl?=
 =?us-ascii?Q?EiI90GgfPtYOoRKE025AAZEqmxYr64WMD+RoMaKBS7zXfOCZnVIIfaY1iX2D?=
 =?us-ascii?Q?D1qvlkHPlEnk1fWYHkax1+41vitAxwshJhPv7+zQtqZ66EzTbSbigT+0sHrs?=
 =?us-ascii?Q?k9tXjoZUP9bbq+RCz2C2eOa7P64J7W0oJDaxK3M2SK18T7fbp6lP2R+KtESe?=
 =?us-ascii?Q?aMTKz0qu6fhlTBEf/UvLJnO+jC8RaO0d7oXjH5It4uYEl6TF6owZ/sBbanCU?=
 =?us-ascii?Q?xaxuWYadY6Qa9ic8SUFMhKk1qNVcF3AmoPSk50vpmo0yFpoBnxcnDHkeAnVL?=
 =?us-ascii?Q?BHQt6Y295HTCrc34lZY5PuvDqyDtZfd4xpNZRrojUq1wnZKd44OPmnVmB14u?=
 =?us-ascii?Q?IMyiylc5CJ4xPH33y5xBW429j5+Z5qn7I1ukBO6gwcPbYaPhGASD3xZq9u1e?=
 =?us-ascii?Q?g8M0A0lXB+PjNGTcOqqRbwRFMS9VGicRArM0jB9mppzLYS4I7CgrnC3mTFu8?=
 =?us-ascii?Q?3kOITpn0OqhpKmqKq4Ma5y/PfJJ53nzRlPv4fRxJ38Kq1vPBncVwWPJ6Ow/+?=
 =?us-ascii?Q?5r19Rsc9YpBMqvX8bK+yh4DqvxEM4+L9uG0vGlbYa67o6+Chsx+aZfzR1Z3U?=
 =?us-ascii?Q?DIDL9DOLBV/PkWKg9b/uOCm1p7c5GAtZ/cEXuR3ZoRrdFXEDMS0+zEKxQWSw?=
 =?us-ascii?Q?Ip9Y0vZPO07rYyfKNGpx13juIJq7tBSl/pqClEbUdwgMZyamZerHMpzGipfD?=
 =?us-ascii?Q?CWJl+DC+KlQLu+m9Ttn2Kkn8xMPY/JFDfhwNeVhP+l9o7ugHBGRojeih2sXz?=
 =?us-ascii?Q?LdC6YkFPrtu4pRtPZSfEnnW2JVARdYOAHd2Y?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY3PR01MB11346.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?us-ascii?Q?6I4pp2eF2yrTEsD9BcucGi42jP6nIZTR+XWMasFLu9j/vSOZyUhdeY1DxdUM?=
 =?us-ascii?Q?CYiix0KQbEKofvIynx6mdKzuWiCuWQKQyvbwLD78DZ619YD8Jklf/QcHiM+k?=
 =?us-ascii?Q?z8f/pNZNpPUGf++rAy7L9nln2FJSChTac/+8wOVFazqwg+b96hZw3vJoRmcm?=
 =?us-ascii?Q?qwujsJlOvNs5h9as6SUEMAted9G68GAdJuGir1GyaRXZUoR7jqF76Vlky54H?=
 =?us-ascii?Q?lJ2pML2cecftlzbRYqwAnohJiasORpuFj5dWmdhw2ATrbeE9gTxt+9PP/s1R?=
 =?us-ascii?Q?RRP+QiQLcsY/ZZkH5jvLIP5sIfQVl07JfxWQc6ym3sX1RJ82afDMVDvV0ZCn?=
 =?us-ascii?Q?wYxgDwPJjHAuG20/DteHvipPelTCMq0/F6qildqEjW/0XF1p960Hs/vwk6rn?=
 =?us-ascii?Q?3mgWGQByREqUNOcLrEdN/iaSHk9r+6v39hAD42VNyEoVR+1Sez3usF5goBj9?=
 =?us-ascii?Q?6BbLuk0USizde6i8VJPTsIDMauYOzWzWYvTOjbCm/lOdUxXpL1817qzUBpyl?=
 =?us-ascii?Q?sGHT7IiH+Iws+QPjYS8TJSgxzMHJ6smTznJAGNWg517O0N1DK6k3wykOrhJq?=
 =?us-ascii?Q?Eat95bLkbPvpVjsUfipulYPC9ARk2uojvv7NaV4s+8p0cQ6XTbJQgtznWzDd?=
 =?us-ascii?Q?/4B+JtSohiM0pXNKQigxHSvVUUEn/sqZvU5Cs5ZSz/DiCK7ieCpa4b1hmID+?=
 =?us-ascii?Q?m3nsrCJem8GGEx8LExZEZ9AetsK9/bXHx1Q69J+g3gB4xMzHFLBHENa2eAA+?=
 =?us-ascii?Q?K9r3k1zNL2LpTuDfhvpcQpyknxy+Is+TY8TQazOXeTN1senwCNysOCCTfqrR?=
 =?us-ascii?Q?WxnY/IYXecwmiOLM0tQ0Fm6jKOSGWJMjD+6IiJUccbl+e3zhXZWwBAU5UUQm?=
 =?us-ascii?Q?gHjwIwTwYFQpwLOw0cilEAvkM5A+2mAyotMcguBdlffMQcNAMWDx5BAXCv5a?=
 =?us-ascii?Q?RM7pEoJ3uIajZqRaYVBNfG4zFNsWymR6ONYMBBwqkMrNIaTi0ITLNRLuZN75?=
 =?us-ascii?Q?DP/5ZJalAUimyeJ/iO4Yd3apLeGvmye7V1oPdL5I7tk6DRQT4B5o347Dl3Sm?=
 =?us-ascii?Q?Mgz52/IYnyoHXh9eQkhxaKRyGx/udb5dTEQsEVkU7VCWLKVQOmdkS6A0cPNh?=
 =?us-ascii?Q?0OO2L6z6fId1nFRpDXUo++dLfv8LCP5/kvY/43+YQG61kTdUAX56oAfmf1qx?=
 =?us-ascii?Q?Db6yScdeK+E9C+riA/WQBV5PLZVcbvyC0/kviFnmDo9c/n82VtK/HFjZbqvt?=
 =?us-ascii?Q?mABrEzC+syoWw8ish+3X42UD8Zaf9opl9VmH9aLcR5s6+9eUyW3m4mUETNl+?=
 =?us-ascii?Q?D9Zepfn6HlZVb6Jw74BGdDyF07ZKKy/ltSJprLceWo4WbjVEAeTn6o8Zipoc?=
 =?us-ascii?Q?AoEZ1GCWm2GEPgvtR/oWJJ3nwFVCA1AKdDq0Ad1Rfhysr4Fqz5+zOCqNdgio?=
 =?us-ascii?Q?bgtizrVn7sui5RaqPJAhE9q2hFNiMGeaO/au+mCz4uMDfRtX6y8e5mgj1uIF?=
 =?us-ascii?Q?3ebb+LEU25TkT/VaD4YaTonyrIztneRPUNlCFkle+NAXqDKGgq6sHEgPft3l?=
 =?us-ascii?Q?swcrq3way/NY4o7+CGFWi+Niwl4XTelettwZQnJQuRMLxXXhppXYtg71ZHRB?=
 =?us-ascii?Q?9g=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY3PR01MB11346.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9b9a6d31-197e-4326-ba31-08de3d3a832b
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Dec 2025 07:04:25.0924
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: R6lIHBTP9Yg8BFE2IN23tqYpp0bvV8ctGoVIUTs9rATqvqM4jSO8OuGbYKQSElicTHKkikEd5EdM8vsvmwfQyxli1nDT1GGu7i+dq3WovnI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY3PR01MB11075
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 17 Dec 2025 07:04:34 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/21095

+Cc

Nobuhiro Iwamatsu <nobuhiro.iwamatsu.x90@mail.toshiba>

> -----Original Message-----
> From: Biju <biju.das.au@gmail.com>
> Sent: 17 December 2025 07:01
> To: Pavel Machek <pavel@denx.de>
> Cc: nobuhiro1.iwamatsu@toshiba.co.jp; Prabhakar Mahadev Lad <prabhakar.ma=
hadev-lad.rj@bp.renesas.com>;
> Biju Das <biju.das.jz@bp.renesas.com>; cip-dev@lists.cip-project.org
> Subject: [PATCH 6.1.y-cip] net: stmmac: dwmac-renesas-gbeth: Add .init() =
callback
>=20
> From: Biju Das <biju.das.jz@bp.renesas.com>
>=20
> Currently clock usage counter imbalance occurs as .exit() is called durin=
g
> suspend() and there is no corresponding .init() during resume().
>=20
> Add .init() callback to support balanced calls across suspend/resume cycl=
e. While at it, avoid code
> duplication by reusing renesas_gbeth_init() in renesas_gbeth_probe().
>=20
> Fixes: 709bdc1cafe2 ("net: stmmac: Add DWMAC glue layer for Renesas GBETH=
")
> Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
> ---
>  .../stmicro/stmmac/dwmac-renesas-gbeth.c      | 37 ++++++++++++++-----
>  1 file changed, 27 insertions(+), 10 deletions(-)
>=20
> diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-renesas-gbeth.c
> b/drivers/net/ethernet/stmicro/stmmac/dwmac-renesas-gbeth.c
> index 42cba9dd967c..5c591c7215bb 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/dwmac-renesas-gbeth.c
> +++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-renesas-gbeth.c
> @@ -31,6 +31,28 @@ static const char *const renesas_gbeth_clks[] =3D {
>  	"tx", "tx-180", "rx", "rx-180",
>  };
>=20
> +static int renesas_gbeth_init(struct platform_device *pdev, void *priv)
> +{
> +	struct plat_stmmacenet_data *plat_dat;
> +	struct renesas_gbeth *gbeth =3D priv;
> +	int ret;
> +
> +	plat_dat =3D gbeth->plat_dat;
> +
> +	ret =3D reset_control_deassert(gbeth->rstc);
> +	if (ret) {
> +		dev_err(gbeth->dev, "Reset deassert failed\n");
> +		return ret;
> +	}
> +
> +	ret =3D clk_bulk_prepare_enable(plat_dat->num_clks,
> +				      plat_dat->clks);
> +	if (ret)
> +		reset_control_assert(gbeth->rstc);
> +
> +	return ret;
> +}
> +
>  static void renesas_gbeth_exit(struct platform_device *pdev, void *priv)=
  {
>  	struct plat_stmmacenet_data *plat_dat; @@ -91,22 +113,17 @@ static int
> renesas_gbeth_probe(struct platform_device *pdev)
>  	if (IS_ERR(gbeth->rstc))
>  		return PTR_ERR(gbeth->rstc);
>=20
> -	err =3D reset_control_deassert(gbeth->rstc);
> -	if (err)
> -		return dev_err_probe(dev, err, "Reset deassert failed\n");
> -
> -	err =3D clk_bulk_prepare_enable(plat_dat->num_clks, plat_dat->clks);
> -	if (err) {
> -		reset_control_assert(gbeth->rstc);
> -		return dev_err_probe(dev, err, "Failed to enable clocks\n");
> -	}
> -
>  	gbeth->dev =3D dev;
>  	gbeth->plat_dat =3D plat_dat;
>  	plat_dat->bsp_priv =3D gbeth;
>  	plat_dat->set_clk_tx_rate =3D stmmac_set_clk_tx_rate;
> +	plat_dat->init =3D renesas_gbeth_init;
>  	plat_dat->exit =3D renesas_gbeth_exit;
>=20
> +	err =3D renesas_gbeth_init(pdev, gbeth);
> +	if (err)
> +		return err;
> +
>  	err =3D stmmac_dvr_probe(dev, plat_dat, &stmmac_res);
>  	if (err)
>  		renesas_gbeth_exit(pdev, gbeth);
> --
> 2.43.0


