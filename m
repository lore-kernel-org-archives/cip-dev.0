Return-Path: <prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0CE80C433EF
	for <webhook@archiver.kernel.org>; Wed, 22 Dec 2021 10:19:21 +0000 (UTC)
Received: from JPN01-OS0-obe.outbound.protection.outlook.com
 (JPN01-OS0-obe.outbound.protection.outlook.com [40.107.113.102])
 by mx.groups.io with SMTP id smtpd.web12.17600.1640168358596302723
 for <cip-dev@lists.cip-project.org>;
 Wed, 22 Dec 2021 02:19:20 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@bp.renesas.com header.s=selector1 header.b=VzoJW2KD;
 spf=pass (domain: bp.renesas.com, ip: 40.107.113.102,
 mailfrom: prabhakar.mahadev-lad.rj@bp.renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Z62/dGYTgsGuxhz4al2SAC2lGQVnoH/I3qSltp58kzYzqNToKY67B2Da5ZLnzBpn96fXW0iOhobTM7L2tEX/xrcrHrLbsbq9vHwCspRgC13ffuEFJSgRlNLG0jqVu2s80ycVQSwNSAVMxPlEwLyi6TIzf2PYYYEmy/anWXO820yPuTPs4CllgOiDo+6ozJCRpwvBv6payDOB2BeCqkrq4WbclliBmsmK2S8QJAasdmLvPMLqUKkuyEdq8A0EpOFBKnzve3d+kyn8RSR2AMdMitGN3OYQBVyWEq5jXePUFJoAuTAEPeC5cRzGHU4Y1TW3c7BYqrJVmpHGWk7PmXZsMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=anJT0xuz7+YpiZIHnR7ib+58ObKG8qwRu15igkcjBWM=;
 b=VSyncS1nSSHjApvslmDnlT1G1l2ebwnYSgT9LNBW1iiQ9eEq3OH8dSCyTI7H/oT38XzwS6Cy14k2FC+JsmzP4t6IjxAXDFow5WrBmB3/q5iqtd3KZ0iG80GKwaaqQuPn7RRwS0AQ5AnzVB8CJiQUEkTOhxfeIdq/sgDg9LZJXySxCpe700hhLCjn/nz20Ejm1vzuGLArYDB2C+e39G5foH3/rLpN5ZhrR2L2cdlb+x65/C0biTY0lIDccqoCziXyDuLWcJF69Oii0O0CgXHhduyeyf4J9W8n1opHCbwhhu56jcm6WRZJW3KrSvzCEKVOivZXUYhonHNjKGHkX0QgXg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=anJT0xuz7+YpiZIHnR7ib+58ObKG8qwRu15igkcjBWM=;
 b=VzoJW2KD2ayDB+e8RTjHj90QEs4oWJCOpeiejtz2pNw2bAjFyi+1uUE3gtyumvSUr1MeQmRYwYk+OngOTEzxA3g2FF99FyxCL9J7dXChiT1mlQbhn/l6BMxFzrbPrzVTMr4wO0X/4M+fcjSviw3SMVX26KssNNhO/QQgcuvUSXc=
Received: from OSZPR01MB7019.jpnprd01.prod.outlook.com (2603:1096:604:13c::8)
 by OSBPR01MB2917.jpnprd01.prod.outlook.com (2603:1096:604:17::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4801.15; Wed, 22 Dec
 2021 10:19:14 +0000
Received: from OSZPR01MB7019.jpnprd01.prod.outlook.com
 ([fe80::2182:43e9:3f29:1b3e]) by OSZPR01MB7019.jpnprd01.prod.outlook.com
 ([fe80::2182:43e9:3f29:1b3e%6]) with mapi id 15.20.4823.018; Wed, 22 Dec 2021
 10:19:14 +0000
From: Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: Pavel Machek <pavel@denx.de>
CC: "cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>, Nobuhiro
 Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>, Biju Das
	<biju.das.jz@bp.renesas.com>
Subject: RE: [PATCH 5.10.y-cip 00/22] RZ/G2L: Add support for pinctrl/dmac/iic
Thread-Topic: [PATCH 5.10.y-cip 00/22] RZ/G2L: Add support for
 pinctrl/dmac/iic
Thread-Index: AQHX9xuVFqj/VhVYTEuwQN1f3rV+i6w+S+Iw
Date: Wed, 22 Dec 2021 10:19:14 +0000
Message-ID: 
 <OSZPR01MB7019DBBEC18AC93480A7D503AA7D9@OSZPR01MB7019.jpnprd01.prod.outlook.com>
References: <20211220133139.21624-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20211222100628.GE15186@amd>
In-Reply-To: <20211222100628.GE15186@amd>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 66c79852-5363-4546-8c1e-08d9c53480e3
x-ms-traffictypediagnostic: OSBPR01MB2917:EE_
x-microsoft-antispam-prvs: 
 <OSBPR01MB291732DF1DEE93DA3885DD3EAA7D9@OSBPR01MB2917.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3513;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 xYXoe3HOEgXYCm5NAtkl30dMlH/A5MGibmGbkrWN4gBExCFeoJayzixNNOHcHFyJ9K9eVmKl3q4wymtb7s3KNLwuHmziKu7Kg0QMZF6Z8Q2QMsXGY5UtsJlOIvm90CxLITRCZ2uuOkyyVlB8TZKdPepkrtXrNXwHi+ktwLcUtIkW6rgzcEyAM2yOukbw9YsR4/etKbBMdt76p2wspJJLD7HucOZg/SNZyota+1c4yyxUrLnn+1s8WrNjW7p3sJwU6Eupx8p6pbFrrKdtgJbbElOpXazuLVY95pOp63aBhcHag2J3SDbDvJ6Jjxw5Wz+ClpZDWTpTFUFdSP2sU7f2L+aiOsKDmU7vjL9mp+/WaQpEQEwhfA58fzoPS0X3qvh2nwQ5aMH5zY6kRw3Zi1aVi0dkYbjsrMxKpnAAkwpPZorvLmVWSHXDriDY9LP9/vevOe7oGQrSwcr8If6DgL6BCYDlCYPve6a3Iwd31hOo2bJchGKsUHAIpkqbvOeW18q2zDl0mp2HCYH18nWXDCK1ML7jM5vK4P4CLj5ye2WCeMV4UGEtFRKE4yKVyV3z5MCN1hY3CKMR6c0XEckLQ9+jY/f4vEHYKGiBD4Xlon2dcmEDWjDTtaiK5yFLpfnUBrHUCxwQnuDfrIBRDXTeV0GX2pxni3eGq7xEOleqkOUpKBdOmdpWownbBbR/4vqFC4f9H1QXZZ10iTh5ihd/G2Z2jxpu2rn5vR69BDK5q9YhZaYefaUuzz3yAIw3gnKPG1Peo0sMrtnCt1XqHvBCWN4yLdacWXAauNbzuLYcjqm7wnuJjbSqzTzi0ZxojJT2O+JOMP+0CWfsRT2QV9+aLftukQ==
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OSZPR01MB7019.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(186003)(107886003)(7696005)(6916009)(54906003)(71200400001)(26005)(5660300002)(6506007)(316002)(55016003)(86362001)(8676002)(4326008)(8936002)(508600001)(9686003)(966005)(76116006)(66476007)(83380400001)(2906002)(38070700005)(66446008)(38100700002)(33656002)(52536014)(64756008)(66946007)(53546011)(66556008)(122000001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?us-ascii?Q?I+MoZyvdWUF0mmuw6e5AVYjr3xp7WgTFyTOHC2zoRSm7K8ODi4zrMpNa6atM?=
 =?us-ascii?Q?GWHogvDppeTEoVEvHNVF5SwvzSBfROgWTg9Izjakce6gt7wC3hPynBQnl2xk?=
 =?us-ascii?Q?eeF7KF5et+SGtdE+/mbEPXCmpZJEzKedIhYnUQBBVgNZ8bhxqCQsALsaOwaX?=
 =?us-ascii?Q?Tbmc05Qzm1qnkXlLE8r6Sw4qqSVNPsk2qxViZJJ8vPX5hCNrvwKkNk27zfp/?=
 =?us-ascii?Q?E0zgLRAlcbKXKnY7g4F4QXHO6MOoTqyUSfUK+GyFyT8S0EfkL4dNI8noVheR?=
 =?us-ascii?Q?AN/1iZMfdV6SY72TxcASyEkYMUSEKvS4Vpcf+P2Ep36dUOGBZZehdGmsUEPx?=
 =?us-ascii?Q?/8nt3lgBLKbAfazRgscdHv77iQwCJMt3v9ZpfxqApwslhpUHefhnf4a46XRv?=
 =?us-ascii?Q?J115IVba+Jh4VcJqGn5AuFl8P8NJvnu7vqwg8Oay40Bb6Uo4zFmHFiAuOCdn?=
 =?us-ascii?Q?GAzmrW6xHDjKO9dieY7tLlZirwOlAJAuN2XjeC49lIH7Ln9RhIDW5N9cOn7S?=
 =?us-ascii?Q?nOakweSmY7PbhN98/45KfNTsythZMcZM2/N86DK1iBKzSZdG69d2bVDG7/a+?=
 =?us-ascii?Q?jzLS8IQIBB4Tu6j/D6O7JYOXwg/qtg4+QrQTKaUqXki/fk3GArRhZCA0wbWS?=
 =?us-ascii?Q?4icg7+aPKEyoOqqottlBcJgj3Sg2MWZmT8M82Ffn/J3jvlSHHcROd1k4VH2J?=
 =?us-ascii?Q?WHhV9ar8U/hUViYjE1ckgfQPUDlzxcEXKBwSNFZ7Lq3v8rcyLqJFSLQTUpwG?=
 =?us-ascii?Q?zhsaMneUUnrsEoBcEVdef7yab7o4AKzkPtPsNyBalBTNAfDazVDGRJt4gvyl?=
 =?us-ascii?Q?e42CXUgQ7zOVviOSmwM2CxxCMR3PuoFOLdbw8gKukHzvnF2nRVnR9KNS/yRT?=
 =?us-ascii?Q?DucqCEurpWbpLmWq5IylVziQ1JimRPh1P8NgoDlOCpSfQvlTm8ISZHcgcZc1?=
 =?us-ascii?Q?p+0JaAaKKhFhSfPGF8mO+xyDW5wzhP7XiWwWX4sXeb+tp3sNXXTVVhYAJrRF?=
 =?us-ascii?Q?7IwvhfdHym+SMQX8v2Ny0XSXXYsx4TqN5jd4trHXBARnPVfURJ95D2+qrhTJ?=
 =?us-ascii?Q?4jO8LrAoVWv4XgjNkRyv+QsjpHqoLco/ktRKXybEhRQzUeQRt+Iy65wLx+q1?=
 =?us-ascii?Q?c7x+mziFGHTz6GM3+w9zkxmllUKylZaSUqf9tdMJHPNYJKSU6iYjoFd+kuzq?=
 =?us-ascii?Q?ucr18DlRBSRJwWS2rNLG8QejylWlLp5/PxFQvTNS91Y9HXX+P2iP1oJf1eE9?=
 =?us-ascii?Q?CU2yT9pOXekJcUUf80tdTLlUv/1UsG537rh4zs/YtKy3knz1Cn70usCbNWfD?=
 =?us-ascii?Q?zCvkLwefXYE1cwSY6HciXgaxKZ53E7T04j0QmOnDJrijTuCjCW8dtP14qnL9?=
 =?us-ascii?Q?GcMUGVRCRInCOqo4648G7ZkGSoilR4lVIKx2AOctSmCtAE41zNP6AThGBU1k?=
 =?us-ascii?Q?YCG8VLan/0pAZoLaJf9/0YYjRdWHYSLIdKJeKo7XMTwvewEKUr7BMQ2A+DnF?=
 =?us-ascii?Q?4gQDr0I7LnEmvkDxuCjchOUYxreNTmkHrNYe4oPLtJpbFOrwtiS706EiB3aM?=
 =?us-ascii?Q?sgpmvaLgrux7iL+ObneMzTM5/5rVtBY76q83rl1KZ/WV9NubwjIbgtfOORgi?=
 =?us-ascii?Q?H3l1v2fM0/ksD3YvupNxaVsKJZ1v53NFdzNdrjej7othY3rSJIuSUA9tVh8g?=
 =?us-ascii?Q?biumn20h4UG6LMKB46bGwUPWMp9IcH0mU58xrDQCaCy+pDua972OJoB/Rx85?=
 =?us-ascii?Q?iUXWP2uVsw=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OSZPR01MB7019.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 
 66c79852-5363-4546-8c1e-08d9c53480e3
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Dec 2021 10:19:14.0378
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 
 TTf4xqMf8XIiTY236Desr3KKdM7t9cnzSZ6vM1L2WMRsVNYmHEJ4Yd2nGvQm4mB/kdtRLi1cWx7gszRso/WTbKZ2X3TTvuaij/At9QzQuYfTOLChC1VCf9NyJBP7wYbL
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSBPR01MB2917
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 22 Dec 2021 10:19:21 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/7229

Hi Pavel,

> -----Original Message-----
> From: Pavel Machek <pavel@denx.de>
> Sent: 22 December 2021 10:06
> To: Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>
> Cc: cip-dev@lists.cip-project.org; Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@=
toshiba.co.jp>; Pavel Machek
> <pavel@denx.de>; Biju Das <biju.das.jz@bp.renesas.com>
> Subject: Re: [PATCH 5.10.y-cip 00/22] RZ/G2L: Add support for pinctrl/dma=
c/iic
>=20
> Hi!
>=20
> > This patch series adds Pinctrl/DMAC/IIC support for Renesas RZ/G2L SoC.
> >
> > All the patches have been cherry picked from v5.16-rc5.
> >
> > I have created a MR [0] for cip-kernel-config (for testing purpose),
> > which can later be merged once this patches have been merged.
>=20
> And these are various minor nits I noticed while reviewing the code.
>=20
Thank you for the review. Do you want me to collate the changes and submit =
or do you plan to submit them?

Cheers,
Prabhakar

> Best regards,
> 								Pavel
>=20
> diff --git a/Documentation/devicetree/bindings/pinctrl/renesas,rzg2l-pinc=
trl.yaml
> b/Documentation/devicetree/bindings/pinctrl/renesas,rzg2l-pinctrl.yaml
> index ef68dabcf4dc3..dacf43ed6d040 100644
> --- a/Documentation/devicetree/bindings/pinctrl/renesas,rzg2l-pinctrl.yam=
l
> +++ b/Documentation/devicetree/bindings/pinctrl/renesas,rzg2l-pinctrl.ya
> +++ ml
> @@ -4,14 +4,14 @@
>  $id: http://devicetree.org/schemas/pinctrl/renesas,rzg2l-pinctrl.yaml#
>  $schema: http://devicetree.org/meta-schemas/core.yaml#
>=20
> -title: Renesas RZ/G2L combined Pin and GPIO controller
> +title: Renesas RZ/G2L combined pin and GPIO controller
>=20
>  maintainers:
>    - Geert Uytterhoeven <geert+renesas@glider.be>
>    - Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
>=20
>  description:
> -  The Renesas SoCs of the RZ/G2L series feature a combined Pin and GPIO
> +  The Renesas SoCs of the RZ/G2L series feature a combined pin and GPIO
>    controller.
>    Pin multiplexing and GPIO configuration is performed on a per-pin basi=
s.
>    Each port features up to 8 pins, each of them configurable for GPIO fu=
nction diff --git
> a/drivers/dma/sh/rz-dmac.c b/drivers/dma/sh/rz-dmac.c index ee2872e7d64c6=
..6946dd0d0485d 100644
> --- a/drivers/dma/sh/rz-dmac.c
> +++ b/drivers/dma/sh/rz-dmac.c
> @@ -25,7 +25,7 @@
>  #include "../dmaengine.h"
>  #include "../virt-dma.h"
>=20
> -enum  rz_dmac_prep_type {
> +enum rz_dmac_prep_type {
>  	RZ_DMAC_DESC_MEMCPY,
>  	RZ_DMAC_DESC_SLAVE_SG,
>  };
> diff --git a/drivers/pinctrl/renesas/pinctrl-rzg2l.c b/drivers/pinctrl/re=
nesas/pinctrl-rzg2l.c
> index 20b2af889ca96..08d0bf139ba3a 100644
> --- a/drivers/pinctrl/renesas/pinctrl-rzg2l.c
> +++ b/drivers/pinctrl/renesas/pinctrl-rzg2l.c
> @@ -328,7 +328,7 @@ static int rzg2l_dt_subnode_to_map(struct pinctrl_dev=
 *pctldev,
>  		psel_val[i] =3D MUX_FUNC(value);
>  	}
>=20
> -	/* Register a single pin group listing all the pins we read from DT */
> +	/* Register a single pin group, listing all the pins we read from DT
> +*/
>  	gsel =3D pinctrl_generic_add_group(pctldev, np->name, pins, num_pinmux,=
 NULL);
>  	if (gsel < 0) {
>  		ret =3D gsel;
> @@ -612,7 +612,7 @@ static int rzg2l_pinctrl_pinconf_group_get(struct pin=
ctrl_dev *pctldev,
>  		if (ret)
>  			return ret;
>=20
> -		/* Check config matching between to pin  */
> +		/* Check config matching between the pins */
>  		if (i && prev_config !=3D *config)
>  			return -EOPNOTSUPP;
>=20
> @@ -886,7 +886,7 @@ static const u32 rzg2l_gpio_configs[] =3D {
>  	RZG2L_GPIO_PORT_PACK(5, 0x40, RZG2L_MPXED_PIN_FUNCS),  };
>=20
> -static  struct rzg2l_dedicated_configs rzg2l_dedicated_pins[] =3D {
> +static struct rzg2l_dedicated_configs rzg2l_dedicated_pins[] =3D {
>  	{ "NMI", RZG2L_SINGLE_PIN_PACK(0x1, 0,
>  	 (PIN_CFG_FILONOFF | PIN_CFG_FILNUM | PIN_CFG_FILCLKSEL)) },
>  	{ "TMS/SWDIO", RZG2L_SINGLE_PIN_PACK(0x2, 0, @@ -1109,7 +1109,7 @@ stat=
ic int
> rzg2l_pinctrl_probe(struct platform_device *pdev)
>  	pctrl->clk =3D devm_clk_get(pctrl->dev, NULL);
>  	if (IS_ERR(pctrl->clk)) {
>  		ret =3D PTR_ERR(pctrl->clk);
> -		dev_err(pctrl->dev, "failed to get GPIO clk : %i\n", ret);
> +		dev_err(pctrl->dev, "failed to get GPIO clk: %i\n", ret);
>  		return ret;
>  	}
>=20
> @@ -1127,7 +1127,7 @@ static int rzg2l_pinctrl_probe(struct platform_devi=
ce *pdev)
>  				       pctrl->clk);
>  	if (ret) {
>  		dev_err(pctrl->dev,
> -			"failed to register GPIO clk disable action, %i\n",
> +			"failed to register GPIO clk disable action: %i\n",
>  			ret);
>  		return ret;
>  	}
> @@ -1171,5 +1171,5 @@ static int __init rzg2l_pinctrl_init(void)  core_in=
itcall(rzg2l_pinctrl_init);
>=20
>  MODULE_AUTHOR("Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>")=
;
> -MODULE_DESCRIPTION("Pin and gpio controller driver for RZ/G2L family");
> +MODULE_DESCRIPTION("Pin and GPIO controller driver for RZ/G2L family");
>  MODULE_LICENSE("GPL v2");
>=20
>=20
> --
> DENX Software Engineering GmbH,      Managing Director: Wolfgang Denk
> HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

