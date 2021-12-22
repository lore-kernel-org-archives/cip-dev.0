Return-Path: <prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2A47C433EF
	for <webhook@archiver.kernel.org>; Wed, 22 Dec 2021 23:37:27 +0000 (UTC)
Received: from JPN01-TYC-obe.outbound.protection.outlook.com
 (JPN01-TYC-obe.outbound.protection.outlook.com [40.107.114.93])
 by mx.groups.io with SMTP id smtpd.web09.26674.1640216245437313979
 for <cip-dev@lists.cip-project.org>;
 Wed, 22 Dec 2021 15:37:26 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@bp.renesas.com header.s=selector1 header.b=VvMuN7sF;
 spf=pass (domain: bp.renesas.com, ip: 40.107.114.93,
 mailfrom: prabhakar.mahadev-lad.rj@bp.renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dxQ4H1FhML4bXAX7PQl8FIOY3WQDLVUs4TKn24Au458s/LfhpSjr4lNEcqzgbJ6+RI7Tt7nFw2W1tmqBPfmXDwWmQTqQovgaHjZeSTlSW0zctSnGixPyZHvDIVDkUtfIQp5nGSyMmNF6vtsOqfEy1Fu6cOFSztAFocECr2auFmEXlvwvtEBBFNi2VjirZV/f8QruSZwqUVF2X8w4RNljdRfWbs+FG5A+vlpb4WGwyHWLVp0CrNs4eIcPXAuS1M1ZYvfbuYnj8/qNYe6Ljvwy8ABTB0OkOiLoZRfV95oWPAdLhop/U5AMmm7DmjXbgvif9spHihvrEhSgtcAmd4uDCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BJtUrGBRCrG9N58VC3x1LJz6YCdZDl+JUMlIeXNwK4A=;
 b=hTkefE66yJLEzzX7lN/6pkAyf23HVoTioU0trGiiAzOj9JrT7aZSwuQ6jaEWzZnSmXJFDONQNJK1NkaDVBNRAdbKGkyGfjiw+ESctbFx0XndCOtPSwK1biH+C7wlwNGCisETF+UWu7mkfGWUlP2bRZpRBH5b4rygIs1fQKM7FPXRHRJwUQ5mD2NnrDhW4E3bCf7YmepP0IYftLIyQwVPatYsCVGjWu9W6M6bFptTjGNpLKN1GqXu0sxd0FmA803U0vHXS9SvdEWehmswtnuW35nJDEXZhRPch7JDG9ByiV7wNjDuJ5YAXuqmHD6r/kh1Q1GtMNt/wKaE2MItrrQTbw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BJtUrGBRCrG9N58VC3x1LJz6YCdZDl+JUMlIeXNwK4A=;
 b=VvMuN7sFmEI80LWS4PWXCLzLKWn6VPooWlz1ED+eYCP4/LyN9cyJqu8z9D/QcnhxznolmUf+eamIVQWqQJwfpGxuqXZ8nvRRFiA7+bmExPWawXaAXUp95s1U+pNsG1NNxdrwIWqkzo2Z9fu667dOOPY3CBqOJ2559jsz/wZaia0=
Received: from OSZPR01MB7019.jpnprd01.prod.outlook.com (2603:1096:604:13c::8)
 by OSBPR01MB3607.jpnprd01.prod.outlook.com (2603:1096:604:43::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4823.19; Wed, 22 Dec
 2021 23:37:21 +0000
Received: from OSZPR01MB7019.jpnprd01.prod.outlook.com
 ([fe80::2182:43e9:3f29:1b3e]) by OSZPR01MB7019.jpnprd01.prod.outlook.com
 ([fe80::2182:43e9:3f29:1b3e%6]) with mapi id 15.20.4823.019; Wed, 22 Dec 2021
 23:37:20 +0000
From: Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: Pavel Machek <pavel@denx.de>
CC: "cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>, Nobuhiro
 Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>, Biju Das
	<biju.das.jz@bp.renesas.com>
Subject: RE: [PATCH 5.10.y-cip 15/21] can: rcar_canfd: Add support for RZ/G2L
 family
Thread-Topic: [PATCH 5.10.y-cip 15/21] can: rcar_canfd: Add support for RZ/G2L
 family
Thread-Index: AQHX94mUzk7tRvWCQUa44NcIyYtON6w/KcwA
Date: Wed, 22 Dec 2021 23:37:19 +0000
Message-ID: 
 <OSZPR01MB7019D83A9F1DFC14AD31114EAA7D9@OSZPR01MB7019.jpnprd01.prod.outlook.com>
References: <20211222134951.19432-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20211222134951.19432-16-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20211222231343.GA25345@amd>
In-Reply-To: <20211222231343.GA25345@amd>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: e39c004c-0920-43bf-b9ca-08d9c5a3ff31
x-ms-traffictypediagnostic: OSBPR01MB3607:EE_
x-microsoft-antispam-prvs: 
 <OSBPR01MB360701F8B51D65D4F16202B2AA7D9@OSBPR01MB3607.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4125;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 OlhEnVwyyS0ZADMd3fYLrQ+lbcCOavah+rl8DERef7ywZiA6+cbE4giuh+eYa0t600+sqp4ApJlt0DB7YqhAue0npbb/HYfyEBUHuHf0sH0LMoCJCdIATo6ZDq0X2nNNshiesJw6eCLsjbKR7JRG/7+zmi7ev1vj6PNw8ZAtYgg/8nILGsdFqXi9iBkBXe4gtkVTpDmHmrpUmS7XP9fkL32SqRXHj6MZMQXUlFLtqkRcF2TvWVoHYblJ8vGRaiWH7OKzToSU2vhqmnavNa/ZRWQui0WJJjRCKHlWUUG6VTsR2R9Ug80HQtvbKdlCrlEWDLf8s1HlpGuxDDk/BElPIVS2uc1ruY6Fcg3eoKuJFORfq4wxJrMSV8Yh1Xo1Y58r34bbXwQvBBYKYqFjgSl8MQ/c1BqAGK5yRq7Gs2eFefboo76CbJScfkN09/a8GO7bVPNLhiXrlxrgdOcqYauDPsKo9yus9+bkZYyYTbq4E5HitF+8TW5NLO3SxDGPggJPK2CL77lD4bxminHumD8tpS5X6dKKS+Im1deXRT7HWl0cN/dHaMQrrfYgfkbJ4PP98bxT05M0JW63RYyWvKBCPuJSo3WXDQoZgkpxJF+w0tNR4Mnehrv9wTKDcCQsmUvsTevTfTWpwUoFi1lLNOd4tlmNjLUtfqEy4jfURpBmwpEApRpY+9p1acjUDdZrCwyR/76fkvY/8HvLbSav2I6B3w==
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OSZPR01MB7019.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(66476007)(66556008)(66946007)(64756008)(76116006)(2906002)(52536014)(54906003)(316002)(86362001)(55016003)(5660300002)(38070700005)(66446008)(71200400001)(83380400001)(508600001)(6916009)(9686003)(186003)(8676002)(38100700002)(7696005)(4326008)(107886003)(26005)(6506007)(8936002)(122000001)(33656002)(53546011);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?us-ascii?Q?GQmHrv2Dfn8g9gcgQ7b9fN61Bazv7CJjhal8RKL2IrK0XKl6wT7gD0eOMehI?=
 =?us-ascii?Q?JFBqxDzCxF0DmA/HLUH36aHh2qDJQywyC4B7OxEsy/6HEBsCPACvizaQzG/g?=
 =?us-ascii?Q?spPFtmJah9w6qDLa4WmZYHt6be9EMRapVqurYQQOeYM4eX3EAEQ4l+U+zSYm?=
 =?us-ascii?Q?wYMinnRtXSB5gJWi60Af6SIV7K8ZpAynxUM18n066uKVsBr2j/QmqT8B14FJ?=
 =?us-ascii?Q?HjZRSM/1zCBmA4xqNDFsyLMmmWRBIB1yFa1dDz6zcF7U2PGdGTmTFpHdYK+W?=
 =?us-ascii?Q?MwS8j5cQ6GNTyFfyScyKJeMtISFMqcoqts6LBRB77YcEm9LhIFZ9WbdccJvl?=
 =?us-ascii?Q?HDeg7LyXFxHzr7HRZM1WwFHdLYOsx6ei2YUJFdh0qBSNi0R3EMtdgWyWGd8V?=
 =?us-ascii?Q?YVrnITB9ByATWtPMHjHts3Nu0tZPDZqkVSg6f97JqchZpCQQvwvhuGFPq0WC?=
 =?us-ascii?Q?tojLhnrY1/hjftL2lhIm5ZY6uXF8ydE7Fl2crZ+Kl4MDi/DN0AkixBw6ZjZh?=
 =?us-ascii?Q?h+xGadfC6MqZFx/JJc/EdJWN57WP+I/S91YuoAt1DI7rP2u4xs2YDJe97usA?=
 =?us-ascii?Q?+FzYwfD7r98LAK9+BuRw6kZIhVKmomoMl4D6wJyaCQVHCzxks3tkUgUxMMMP?=
 =?us-ascii?Q?ENzju6azeMl9MCSV9lkEl8IC/Uv/A51jSMriGLEr51Yz70HlSIP1Hj9Ds2O8?=
 =?us-ascii?Q?lQvK94N5luSfygqcC8Jf1fSzaKAnfqySpemU4e06L3yjgViCuD3UqaDtzNtb?=
 =?us-ascii?Q?uQYnh8qfU7x7DjzIoXt1X1cOvOzL3J913UOQ4K2XphyF9IBFa0A8hAhvQq0w?=
 =?us-ascii?Q?BF64d6tHwr8jQViYIajiVej9OuV4qc1U3NP0YOYWjcxknHVttPNQs5xKjEOF?=
 =?us-ascii?Q?frxUKpxjPivFx+6xM7s1jfNWTdAzNY7mKtq30tEqjdXis13/uu5YVfIHOaZj?=
 =?us-ascii?Q?DCVzWmU54PX5RTbzd5WbWNMWCHprbY/BIXIPndbyTCKmE3ffhTfkBM89nYNY?=
 =?us-ascii?Q?slIiEKb5fg6/R8cfjXBWxwulTqcJHEF1Knk1kl6vqZU/wR5rMC+62X8K9oMe?=
 =?us-ascii?Q?16RgjzXJOT6X5nSNu//ghszX5rkueG5/Z4Dd8SGfnAWnQ3a06WnZtKXyQTNf?=
 =?us-ascii?Q?V1O07Hj1aq0tasCSwF18v6/IY49PlFHR6opad18Brbv3wlSdNcZOjiE9K+8D?=
 =?us-ascii?Q?D7FZE9Cm4rygkw5OEAof3bBePqbeuwqOpyzzeansr9L6HDA0g9HFsCiIFnxL?=
 =?us-ascii?Q?WPHSRmIOlPtRreiMLf9lODRidt2RlB/6muYfyQAZ2misl04DJJxtg1MAV8ok?=
 =?us-ascii?Q?lqNA8DPpkEb3y7iHHJ10CPzMC16xEzdsKfl0BytDx4WR4Fw4o6e8m3eXjoTe?=
 =?us-ascii?Q?3ey6XhDlWpBfffRDw5Owv2S5th1I9BJVVlf0kqeMUCaeMH7h8ulbgO+dY/xe?=
 =?us-ascii?Q?kP/K6pxmkS5kWD2vGOhB6WGLkT/enW1l85l/kNTM2xukhtzoko+DHnflHtlH?=
 =?us-ascii?Q?st2hbk5M3dAZ8ntyOb8vQdbfa+VH6kbOc4xIV0Skztgfyf9w2FKK8Q9aqs0z?=
 =?us-ascii?Q?V+NQF5Xf7AWo7Cq6vZKveoHAaaC4H5hZs3cDa8k6xlprNNfPcNqQZ7V90m05?=
 =?us-ascii?Q?SI7CZJMkDyeb9bFEfKj/5tnvynTsCBLZYmS6gvJRi0hXV706lSEymYlZdfBu?=
 =?us-ascii?Q?WJVubGKnkAnVhygVlTs0T8zaZ4ozzzcMYoP/hM+il6suykXSKEe7qcaS+coN?=
 =?us-ascii?Q?Z3V4fE43PQ=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OSZPR01MB7019.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 
 e39c004c-0920-43bf-b9ca-08d9c5a3ff31
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Dec 2021 23:37:20.0019
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 
 e3W+9bEL/enZygfnmkmhVADELTcfXDvx3+M8xTWm1cCHxDhfaxRTt7cn0ZMy2Cl+CkXKgm5Fczw1jxdLPftIhT4yjkHrRaiyBjMk7kDLW75dmUcRd60GnkVGYgLgq3JF
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSBPR01MB3607
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 22 Dec 2021 23:37:27 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/7259

Hi Pavel,

Thank you for the review.

> -----Original Message-----
> From: Pavel Machek <pavel@denx.de>
> Sent: 22 December 2021 23:14
> To: Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>
> Cc: cip-dev@lists.cip-project.org; Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@=
toshiba.co.jp>; Pavel Machek
> <pavel@denx.de>; Biju Das <biju.das.jz@bp.renesas.com>
> Subject: Re: [PATCH 5.10.y-cip 15/21] can: rcar_canfd: Add support for RZ=
/G2L family
>=20
> Hi!
>=20
> > commit 76e9353a80e9e9ff65b362a6dd8545d84427ec30 upstream.
> >
> > CANFD block on RZ/G2L SoC is almost identical to one found on R-Car
> > Gen3 SoC's. On RZ/G2L SoC interrupt sources for each channel are split
> > into different sources and the IP doesn't divide (1/2) CANFD clock
> > within the IP.
> >
> > This patch adds compatible string for RZ/G2L family and splits the irq
> > handlers to accommodate both RZ/G2L and R-Car Gen3 SoC's.
>=20
>=20
> > +++ b/drivers/net/can/rcar/rcar_canfd.c
> > +
> > +static irqreturn_t rcar_canfd_global_err_interrupt(int irq, void
> > +*dev_id) {
> > +	struct rcar_canfd_global *gpriv =3D dev_id;
> > +	u32 ch;
> > +
> > +	for_each_set_bit(ch, &gpriv->channels_mask, RCANFD_NUM_CHANNELS)
> > +		rcar_canfd_handle_global_err(gpriv, ch);
> > +
> > +	return IRQ_HANDLED;
> > +}
> > +
>=20
> You are returning IRQ_HANDLED even when you do no handling. That probably=
 will not do harm as long as
> interrupts are not shared. Is that guaranteed to be true?
>=20
As of the current users of this driver interrupts are not shared.

> > @@ -1577,6 +1653,53 @@ static int rcar_canfd_channel_probe(struct rcar_=
canfd_global *gpriv, u32 ch,
> >  	priv->can.clock.freq =3D fcan_freq;
> >  	dev_info(&pdev->dev, "can_clk rate is %u\n", priv->can.clock.freq);
> >
> > +	if (gpriv->chip_id =3D=3D RENESAS_RZG2L) {
> > +		char *irq_name;
> > +		int err_irq;
> > +		int tx_irq;
> > +
> > +		err_irq =3D platform_get_irq_byname(pdev, ch =3D=3D 0 ? "ch0_err" : =
"ch1_err");
> > +		if (err_irq < 0) {
> > +			err =3D err_irq;
> > +			goto fail;
> > +		}
>=20
> This leaks ndev; it should free_candev(ndev); before returning, AFAICT.
>=20
Agreed, this needs a fix.

> > @@ -1670,6 +1811,19 @@ static int rcar_canfd_probe(struct platform_devi=
ce *pdev)
> >  	gpriv->pdev =3D pdev;
> >  	gpriv->channels_mask =3D channels_mask;
> >  	gpriv->fdmode =3D fdmode;
> > +	gpriv->chip_id =3D chip_id;
> > +
> > +	if (gpriv->chip_id =3D=3D RENESAS_RZG2L) {
> > +		gpriv->rstc1 =3D devm_reset_control_get_exclusive(&pdev->dev, "rstp_=
n");
> > +		if (IS_ERR(gpriv->rstc1))
> > +			return dev_err_probe(&pdev->dev, PTR_ERR(gpriv->rstc1),
> > +					     "failed to get rstp_n\n");
> > +
> > +		gpriv->rstc2 =3D devm_reset_control_get_exclusive(&pdev->dev, "rstc_=
n");
> > +		if (IS_ERR(gpriv->rstc2))
> > +			return dev_err_probe(&pdev->dev, PTR_ERR(gpriv->rstc2),
> > +					     "failed to get rstc_n\n");
> > +	}
> >
> >  	/* Peripheral clock */
> >  	gpriv->clkp =3D devm_clk_get(&pdev->dev, "fck");
>=20
> The code is correct but it mixes direct returns with "goto fail_dev", whi=
ch is just alias for return.
> I'd prefer just doing returns directly, but it really should not mix dire=
ct returns with goto return.
>=20
Agreed.

> > -	err =3D devm_request_irq(&pdev->dev, g_irq,
> > -			       rcar_canfd_global_interrupt, 0,
> > -			       "canfd.gbl", gpriv);
>=20
> Strange. New code variant no longer allocates canfd.gbl?
>=20
It does, its just that its renamed to "canfd.g_int".

> > +	err =3D reset_control_reset(gpriv->rstc1);
> > +	if (err)
> > +		goto fail_dev;
> > +	err =3D reset_control_reset(gpriv->rstc2);
> >  	if (err) {
> > -		dev_err(&pdev->dev, "devm_request_irq(%d) failed, error %d\n",
> > -			g_irq, err);
> > +		reset_control_assert(gpriv->rstc1);
> >  		goto fail_dev;
> >  	}
>=20
> I'd introduce new label here, so that you don't need to do reset_control_=
assert(gpriv->rstc1); at two
> different places... like below...
>=20
Thanks for the suggestion. Let me include this while I fix the leak.

Cheers,
Prabhakar

> Best regards,
>=20
> 								Pavel
>=20
> diff --git a/drivers/net/can/rcar/rcar_canfd.c b/drivers/net/can/rcar/rca=
r_canfd.c
> index 52629c6c19702..ce9b3a0032bf8 100644
> --- a/drivers/net/can/rcar/rcar_canfd.c
> +++ b/drivers/net/can/rcar/rcar_canfd.c
> @@ -1908,10 +1908,8 @@ static int rcar_canfd_probe(struct platform_device=
 *pdev)
>  	if (err)
>  		goto fail_dev;
>  	err =3D reset_control_reset(gpriv->rstc2);
> -	if (err) {
> -		reset_control_assert(gpriv->rstc1);
> -		goto fail_dev;
> -	}
> +	if (err)
> +		goto fail_reset1;
>=20
>  	/* Enable peripheral clock for register access */
>  	err =3D clk_prepare_enable(gpriv->clkp); @@ -1976,8 +1974,9 @@ static i=
nt rcar_canfd_probe(struct
> platform_device *pdev)
>  fail_clk:
>  	clk_disable_unprepare(gpriv->clkp);
>  fail_reset:
> -	reset_control_assert(gpriv->rstc1);
>  	reset_control_assert(gpriv->rstc2);
> +fail_reset1:
> +	reset_control_assert(gpriv->rstc1);
>  fail_dev:
>  	return err;
>  }
>=20
>=20
>=20
>=20
> --
> DENX Software Engineering GmbH,      Managing Director: Wolfgang Denk
> HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

