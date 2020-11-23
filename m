Return-Path: <SRS0=q6hf=E5=lists.cip-project.org=bounce+64572+5836+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B3F6C2D0E4
	for <cip-dev@archiver.kernel.org>; Mon, 23 Nov 2020 23:12:38 +0000 (UTC)
Received: from mail02.groups.io (mail02.groups.io [66.175.222.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4F49420691
	for <cip-dev@archiver.kernel.org>; Mon, 23 Nov 2020 23:12:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.cip-project.org header.i=@lists.cip-project.org header.b="tdWDfNOT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4F49420691
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+5836+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id VY45YY4521723xEvvHeJkb1W; Mon, 23 Nov 2020 15:12:36 -0800
X-Received: from JPN01-TY1-obe.outbound.protection.outlook.com (JPN01-TY1-obe.outbound.protection.outlook.com [40.107.140.101])
 by mx.groups.io with SMTP id smtpd.web11.44383.1606173155901641027
 for <cip-dev@lists.cip-project.org>;
 Mon, 23 Nov 2020 15:12:36 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XdzsGbwyJMo830JcLt6VDeuV/qsM7ocBAY/tHbz6gBNe5ZDc/GZi0AhzMXuyj8WBLlvR+bjyDkfLcxQsPiafZfMr8J4K3ajlP6QxFL3tmwzaZutRRT34iLiasEer7IvXUTWPTgTf9fX6CVYBlyMo3AtO6Euurt0C0bxG+899+iqJl48+OHUPrzg7KFgNwU+IEjTnIVs8m6MONcoSSN/7bFbckJGEmWyqWhKSRMqchJGsNdlooJcq1DeT43gGuWXQXmKvZPh8w+q1kfUC3ioPj+/ejPO6CyZXflD/tl7OZBsY1fjoT3I4hOULOiRtaUH7WXfLAw9gTpdQqLMAbHoxwg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vL/ZxzX0lJatEWP/SP910gcl2LY27jkrnRMTIotcZ9c=;
 b=HXvqVvF7c8UFHU1C0H9DixmS07KZ6QhNdFXsQhovMVvgEBemrzIVqNx+oCNC53EPPihA50Ky+6ewc7CeAsS6ikLsV5QPiIBC4tiUZBFm6JKRdv2TQVLvvBJeiToy+Q1DsJkWvG+AdgkYfcDOnUNNQPXaRJM3J0r15HYPHG58AapxjpO7kEZdoD+eqg5auziK29lDcFVlV/K7VmkazK/novh9LX3owtwUNPzm/Qq1W49ACqYngARUVUoFichdrbEWmEjkh/7xrAQD1APJNGrVc0ebRBlx8/NwKO05Fk1zULZ/r09CTZXdfBsX316jYSqdxTQ4jsgn/WJKfmCcdXpxKw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
X-Received: from OSBPR01MB5048.jpnprd01.prod.outlook.com (2603:1096:604:38::10)
 by OSBPR01MB4343.jpnprd01.prod.outlook.com (2603:1096:604:72::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3589.20; Mon, 23 Nov
 2020 23:12:32 +0000
X-Received: from OSBPR01MB5048.jpnprd01.prod.outlook.com
 ([fe80::18f:c7ea:e9e4:db70]) by OSBPR01MB5048.jpnprd01.prod.outlook.com
 ([fe80::18f:c7ea:e9e4:db70%3]) with mapi id 15.20.3589.025; Mon, 23 Nov 2020
 23:12:32 +0000
From: "Lad Prabhakar" <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: Pavel Machek <pavel@denx.de>
CC: "cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>, Nobuhiro
 Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>, Biju Das
	<biju.das.jz@bp.renesas.com>
Subject: Re: [cip-dev] [PATCH 4.19.y-cip 7/7] spi: add Renesas RPC-IF driver
Thread-Topic: [PATCH 4.19.y-cip 7/7] spi: add Renesas RPC-IF driver
Thread-Index: AQHWwdIvF2YMUwWDbECVRI9bRHBji6nWV6vw
Date: Mon, 23 Nov 2020 23:12:32 +0000
Message-ID: 
 <OSBPR01MB504880810908024D5D691832AAFC0@OSBPR01MB5048.jpnprd01.prod.outlook.com>
References: <20201123120354.26413-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20201123120354.26413-8-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20201123195228.GE5619@amd>
In-Reply-To: <20201123195228.GE5619@amd>
Accept-Language: en-GB, en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [193.141.220.21]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 13d54226-e5bc-4cfd-a45a-08d8900541fc
x-ms-traffictypediagnostic: OSBPR01MB4343:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: 
 <OSBPR01MB4343CF7E7810782FC32C90FFAAFC0@OSBPR01MB4343.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 
 XzT4Oe1WW/d37G1Z1zwc35szzLVvKLKC1np7GsPc0QuijoKubEigKS96N2BU/UL8H+zroiZO267+Q9c1uMHo+dCkqQRh+8bVRgKapl2tmKjHff/aUo2um+n2bdeBdnffRTXmAvXCqSL8wsiCCwQ9rPGdTCCWRGox+2ohzZhiPi9truyYkW1APf5kgjWhx8SA9XRBjiXXvnoaajn00pqQLNQqKYQwcs8yrWGU5d24dxDW3KLxKpPf0kDVslpddIgYQuMevoc4ySkh0YjCU8sismQBMMuL/u2wicNb+HSMxM5PbLzSt6ARF4swjZ9OFOTLgCetCD2L2k4ZX3u94L8H2q8Lngy2v5RDW0i+umF0PulI5wDceQou9S9e00cttowdOjXRj+CfYXdx7mZoxeOWiQ==
x-ms-exchange-antispam-messagedata: 
 GYaIKphvxeAaMoMK5VlapVDBfyZEEvvHXJa36Ac86MIwRl5eYgh0Ljh2fser+7f0UIb5BaA/tDp+T47vvU4r4aDZAXDd3L02aFXvRIprc7E4OcnKIuzuB1U7eYOatQUmhvPG+Sj00WTF2xQtZu0WAaJcsJiHDs3s3U5FobBhY/4oGOd35JVxQyfhqVY1cO3k42W1DjnysOalZcIzplYUgZbHGqhbYp7qMtqqsMWpxHI6UUsAoRfJZTBIYelc9SN5FxDPCZB7abmWqTaDIqEFt5mV41ekvRC5mfXno1a4r3pXvr9gZ150miOBXzwA+fKhmmgmkHqqpkb2wZnlPRS/xX+MQJ/MhqCSR8OFj6uGAabNTMG9zru4eZsEyrmygZR4oAd6c3faGI5goB9cidWICbnOhO+4dHaDOgSj/qFuKBX1PS93mE9Z5VFKLqdRoAH6MAMneclmRNGk+JyJRhefY7Z754TUci1t3lVxzyAIRYbNp1RamkfiHrc9ofBzOTY/TD2yu6iYLrcJWobGkgiV5aLjfIV8HUqTm3syrDs3sCG8hlGV3IuF+NMo5BVwNHtiVyNouKF0QbsWqfeWaE3fO1atGsN8X62YeqHS4m3rk83E2ifYiwG0oq5H9ou6Mj2uEScsEbrx03qGIjQlhwqwXGLw5avtGLnsDbrJHaR1Fki62xICYszLqwY+j9NkCA9WtYN2MFOoLTeNdn/ROkpY3rVUL/u+uIXeV/wI/jKHh0e1upX34r/NHtndeK780Vrnco5OsWFPQEkDhHz1sXxsfsgHr6JPksjbp6jIueyuH6dFivdnzck05pFUuME31H5yxRUm2r9LKDseTCf+rUlwGjTsuMTqx136p1K3d+eIIfLdAOzK6gOSpqqJ4t2zvJohRmdK5LS03OxD172joQbHzg==
MIME-Version: 1.0
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OSBPR01MB5048.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 13d54226-e5bc-4cfd-a45a-08d8900541fc
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Nov 2020 23:12:32.8378
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 6kVOs7oPvhK6YXP5ey6RytoIrhe8Cv9eT08E0piyG8Klv4OTvbfTuO1IFousXKXUj2kS1Bntn6hFiNI7eWvRwUAPrnbErbe2K5TiWwW6x53CCHoF+FMxcAdjBwo/vXrA
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSBPR01MB4343
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: cvM02AMcRugIZ8tZitknCmS2x4520388AA=
Content-Type: multipart/mixed; boundary="jHDxidy2Uunh3FpbkHIa"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1606173156;
 bh=L5obuO67j3t0QjeICTA46Psw1O67jTR9Bery9B7rbZQ=;
 h=CC:Content-Type:Date:From:Reply-To:Subject:To;
 b=tdWDfNOTCjEwtCHdrnJubm491KEbJkDGjbdkWV0YMTMh9odNIF6n36r10yQm2/A3YjI
 Y/YYClwsTjAPF0MSjbm47CN2CXQ8C0WqV9HP+/TrcHeEnrxNVMLIlQseZI21/GjxaqfqM
 m7I5IGaaHty3xWP/jq/A8Ou2JMZ7cssJth8=

--jHDxidy2Uunh3FpbkHIa
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Hi Pavel,

Thank you for the review.

> -----Original Message-----
> From: Pavel Machek <pavel@denx.de>
> Sent: 23 November 2020 19:52
> To: Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>
> Cc: cip-dev@lists.cip-project.org; Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@=
toshiba.co.jp>; Pavel Machek
> <pavel@denx.de>; Biju Das <biju.das.jz@bp.renesas.com>
> Subject: Re: [PATCH 4.19.y-cip 7/7] spi: add Renesas RPC-IF driver
>=20
> Hi!
>=20
> > commit eb8d6d464a27850498dced21a8450e85d4a02009 upstream.
> >
> > Add the SPI driver for the Renesas RPC-IF.  It's the "front end" driver
> > using the "back end" APIs in the main driver to talk to the real hardwa=
re.
> > We only implement the 'spi-mem' interface -- there's no need to impleme=
nt
> > the usual SPI driver methods...
> >
> > Based on the original patch by Mason Yang <masonccyang@mxic.com.tw>.
> >
> > Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
> > Link: https://lore.kernel.org/r/1ece0e6c-71af-f0f1-709e-571f4b0b4853@co=
gentembedded.com
> > Signed-off-by: Mark Brown <broonie@kernel.org>
> > Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> > ---
> >  drivers/spi/Kconfig      |   6 ++
> >  drivers/spi/Makefile     |   1 +
> >  drivers/spi/spi-rpc-if.c | 216 +++++++++++++++++++++++++++++++++++++++
> >  3 files changed, 223 insertions(+)
> >  create mode 100644 drivers/spi/spi-rpc-if.c
> >
> > diff --git a/drivers/spi/Kconfig b/drivers/spi/Kconfig
> > index 0a7fd56c1ed9..461315967f96 100644
> > --- a/drivers/spi/Kconfig
> > +++ b/drivers/spi/Kconfig
> > @@ -514,6 +514,12 @@ config SPI_RB4XX
> >  	help
> >  	  SPI controller driver for the Mikrotik RB4xx series boards.
> >
> > +config SPI_RPCIF
> > +	tristate "Renesas RPC-IF SPI driver"
> > +	depends on RENESAS_RPCIF
> > +	help
> > +	  SPI driver for Renesas R-Car Gen3 RPC-IF.
>=20
> Few lines here explaining the acronyms etc. would be nice.
>=20
Will do.

> > +	error =3D spi_register_controller(ctlr);
> > +	if (error) {
> > +		dev_err(&pdev->dev, "spi_register_controller failed\n");
> > +		goto err_put_ctlr;
> > +	}
> > +	return 0;
> > +
> > +err_put_ctlr:
> > +	rpcif_disable_rpm(rpc);
> > +	spi_controller_put(ctlr);
> > +
> > +	return error;
> > +}
>=20
> With just one user of the error exit, I'd avoid the goto.
>=20
Agreed shall fix that.

> > +#ifdef CONFIG_PM_SLEEP
> > +static int rpcif_spi_suspend(struct device *dev)
> > +{
> > +	struct spi_controller *ctlr =3D dev_get_drvdata(dev);
> > +
> > +	return spi_controller_suspend(ctlr);
> > +}
> > +
> > +static int rpcif_spi_resume(struct device *dev)
> > +{
> > +	struct spi_controller *ctlr =3D dev_get_drvdata(dev);
> > +
> > +	return spi_controller_resume(ctlr);
> > +}
> > +
> > +static SIMPLE_DEV_PM_OPS(rpcif_spi_pm_ops, rpcif_spi_suspend, rpcif_sp=
i_resume);
> > +#define DEV_PM_OPS	(&rpcif_spi_pm_ops)
> > +#else
> > +#define DEV_PM_OPS	NULL
> > +#endif
> > +
> > +static struct platform_driver rpcif_spi_driver =3D {
> > +	.probe	=3D rpcif_spi_probe,
> > +	.remove	=3D rpcif_spi_remove,
> > +	.driver =3D {
> > +		.name	=3D "rpc-if-spi",
> > +		.pm	=3D DEV_PM_OPS,
> > +	},
> > +};
>=20
> Can you just add "__maybe_unused" annotation and avoid the ifdefs,
> like atmel-quadspi.c does?
>=20
Agreed will replace that.

Cheers,
Prabhakar

> Best regards,
> 								Pavel
> --
> DENX Software Engineering GmbH,      Managing Director: Wolfgang Denk
> HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--jHDxidy2Uunh3FpbkHIa
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.
View/Reply Online (#5836): https://lists.cip-project.org/g/cip-dev/message=
/5836
Mute This Topic: https://lists.cip-project.org/mt/78451549/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-


--jHDxidy2Uunh3FpbkHIa--
