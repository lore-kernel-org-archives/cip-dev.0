Return-Path: <biju.das.jz@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE448EB8FA5
	for <webhook@archiver.kernel.org>; Wed,  6 Sep 2023 05:40:29 +0000 (UTC)
Received: from JPN01-TYC-obe.outbound.protection.outlook.com (JPN01-TYC-obe.outbound.protection.outlook.com [40.107.114.94])
 by mx.groups.io with SMTP id smtpd.web10.2208.1693978825360293938
 for <cip-dev@lists.cip-project.org>;
 Tue, 05 Sep 2023 22:40:26 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@bp.renesas.com header.s=selector1 header.b=V31XEDzq;
 spf=pass (domain: bp.renesas.com, ip: 40.107.114.94, mailfrom: biju.das.jz@bp.renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Pj1z91X6x5f9JZ5wfzYV8Q/8bjFnIuGbWgW387F3vTLvcLUMZDHcVvFkDZjMN4/TyaI3ZwBv3yjG74Jbb7VFFyI8lJkhm6IPU+ym+HodkxkX72ni5uvNTJcuqHsXmfkxIgXGEkxacIiTa90FF/vGhaWTT/hCkDBIC+iuaV4pdOmRGdVUDAoWjLacrWdAcnaOmUQW7+bDjFY+aH1GE+Pk7Z15VqGEmPbsEQhIcE26WmqSrN6RXsGdXrHRRu+sT1p8aZe2y5EvA3b5cfRBgy+XUTh66o0UCJroFhFoOepljogw6e2bLOM80VwnWFB7yAGEFdSfLDvy4fzeBug6Undi8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6m6LPyP677m0Nxk8syUjsM8xySugOBdTDQGLpwYZ7C4=;
 b=S/KkKVmanygoT5ms/wRU5YL6wdlV10qm5JIJ4R9uoBtV7Xyf5fKaKJn1A4D5oI3loVVp33WTxflATHqpylV92lM85OxlijJvJzPGcyyW6kgfoqyh++C9oHdDr4Pc0cBgZ7CM3Ngh0YLmJbNeDFsOmNua4fAHwxf1ltpFcZG/BFIf7qs3tulbYN3xPdQ5olGfQeKvy8t8k4qvIZWGJYDt8Me2Xn93aiHH79qDrVIgm9+xB/0gsEhM5S0XtWx8JHZjFGZFjxDlN92ImM5UdNM8ZBf+EZOkzSPbrW5oaWpasimBZ1brLmhfRemDZPlcU8t6agVVfZuEjCtDG/exKU+cEQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6m6LPyP677m0Nxk8syUjsM8xySugOBdTDQGLpwYZ7C4=;
 b=V31XEDzqXkPq1pgWVirB+wN0dEAIKHdULu7KrqlAkrxccz1lanJDGapM+DDskMl7kD0nZHHoXU69xDvujyqzvza8mAyV9U4OducgUY/I37nquByd25HawSiU4zr9I7eq+kkFtK1HmyXV7lkCGJnuBp2nMJIkMIwWH5x4QhzL5uA=
Received: from OS0PR01MB5922.jpnprd01.prod.outlook.com (2603:1096:604:bb::5)
 by TY3PR01MB9779.jpnprd01.prod.outlook.com (2603:1096:400:22c::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.34; Wed, 6 Sep
 2023 05:40:21 +0000
Received: from OS0PR01MB5922.jpnprd01.prod.outlook.com
 ([fe80::9d23:32f5:9325:3706]) by OS0PR01MB5922.jpnprd01.prod.outlook.com
 ([fe80::9d23:32f5:9325:3706%5]) with mapi id 15.20.6745.034; Wed, 6 Sep 2023
 05:40:21 +0000
From: Biju Das <biju.das.jz@bp.renesas.com>
To: "nobuhiro1.iwamatsu@toshiba.co.jp" <nobuhiro1.iwamatsu@toshiba.co.jp>,
	"cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>,
	"pavel@denx.de" <pavel@denx.de>
CC: Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: RE: [PATCH 6.1.y-cip 15/20] drm: renesas: Add RZ/G2L DU Support
Thread-Topic: [PATCH 6.1.y-cip 15/20] drm: renesas: Add RZ/G2L DU Support
Thread-Index: AQHZ4BMv5Fc/iAMDH06bLvV9yOIBErAM8KeAgABWBmA=
Date: Wed, 6 Sep 2023 05:40:21 +0000
Message-ID: 
 <OS0PR01MB5922BAC5CF846A96B38D00FA86EFA@OS0PR01MB5922.jpnprd01.prod.outlook.com>
References: <20230905160737.167877-1-biju.das.jz@bp.renesas.com>
 <20230905160737.167877-16-biju.das.jz@bp.renesas.com>
 <TYWPR01MB942095E6CB6A4BE1B9A5A87C92EFA@TYWPR01MB9420.jpnprd01.prod.outlook.com>
In-Reply-To: 
 <TYWPR01MB942095E6CB6A4BE1B9A5A87C92EFA@TYWPR01MB9420.jpnprd01.prod.outlook.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OS0PR01MB5922:EE_|TY3PR01MB9779:EE_
x-ms-office365-filtering-correlation-id: 8a1b71bd-f24a-4a81-818e-08dbae9bc294
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 GLW/F/nmeQQq1YT90N1urKe67p3ZtTXlciFeXEuJ065VbhdhyfD0OCvOCpIt17K4VcXVuFfkULxcsaEv0DFYCFm6m5e2YHPoeav3BX8cZ4LY7O/JHzLp3NjS6IWtfFnKeINJeV297EjjBHrkKfv1yvnhJrNjLgjtj8C6KNkXmY0b523RORx2CfPPK7EXp/ggATDRVDEqr3NMm66QTHH5UqmaSZGb353YlqbCwFTDvMOuQpCJrM1Jjiy4q5OwrM5X5vpmfmOFp617YNvZnIkeBzU9jSwINqNJ0+tu/1WU3ClDsRH+93xA2bGFzqeiB2VZ4SC1Arw9Z3eAd3ocMqK0v71PJc1mNK9Mt1otJ3PPqYjSKUpjqBRz5lVHxm/YnUWNXgf9wjBQruaiHrQjUTbFSAtn4vjI108phwxZyOm0kZggilPk+5LWRJ73sn4gu2UjXd7Rd51RJp4TasEyQ42aAutFZzaLapbtz3ou9Uf/n58dXZY47btwW4J2syrdw3Am0De5BZ4rkXYJ8jaPmePj2SFir4rr651pcYCbiXJn0XXwp1TlBjVkwV9haHh2m760hF+04Zpy0GxCXQzY2DdQ+ZCKqJ0GgX8iZTi/Z62zsFbICT2lkz7glnMYJeAl3rF/PJQUtnOIQDDky95RJbhYNA==
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS0PR01MB5922.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(39860400002)(136003)(346002)(396003)(366004)(1800799009)(186009)(451199024)(55016003)(2906002)(83380400001)(110136005)(66556008)(6506007)(122000001)(316002)(64756008)(66946007)(966005)(66476007)(76116006)(5660300002)(71200400001)(107886003)(478600001)(66446008)(52536014)(26005)(9686003)(41300700001)(7696005)(4326008)(8676002)(8936002)(33656002)(38070700005)(38100700002)(86362001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?us-ascii?Q?aenCsaSkD2cBTvJT1gIAYg3YLNcrKqocnhQMXsnzBN/VnL9Wu8fVv34iahAp?=
 =?us-ascii?Q?C7o+JeA4t679I64ljoA8Hbo1FDVVR/bejl1CgEW376kEnvmoSnixABNH/l7j?=
 =?us-ascii?Q?rILYu8eBjOS8hUQeTACctHK/EM+JjtNlTDQ6sahLWQqRukCN+X/2AmxVvbVQ?=
 =?us-ascii?Q?GxyMjhsMc+t/MzulW/Ehi3HjhpUDAmPyvaCmSwjKqv2THIuIkd4YjZ9wR/QN?=
 =?us-ascii?Q?r8Um7ERcQQrstBSWPb7edboTdBV+e6Cn/p9A9o3yvsisMIeAVTI+PditYNIa?=
 =?us-ascii?Q?DS0oDeTjfBkEEmncP6qF2ULWbwBiZLNSZ1mQapuYaQDhLnBSDGtHDIt1ppfV?=
 =?us-ascii?Q?oLHLX8klXnG4ZZDKgwbG35/P2TMoKpOZYWO9YJdQMJiQMLNZWFrDHMs+3pAr?=
 =?us-ascii?Q?wOZmrapF3zSDv3FYSlQSf+sS9soWHAFXIIz8h1mmcPubBF+RFFKgF4fK3IaP?=
 =?us-ascii?Q?B0/jrM61HECOBKXcXGlvloTWhdy53QEH6ji3g3p7J+unn+0nlcw8PqpGjSdi?=
 =?us-ascii?Q?XN6cubmeLHDrQ/1Csij4j1ux5RB8Bu/yffD4jWb1TWdBY0RftUcoDmXpfyiU?=
 =?us-ascii?Q?06MBS8UrNIVDs1EUKCN6uzK54+yeNBJTt6WPiwtjx3vhSE1FOC1M1ClYXKRJ?=
 =?us-ascii?Q?GbBY94hyPQni24ND5DXQJjtzFF42bBh9YBic4y0HJtog6pBFgAuvwSA3zaDa?=
 =?us-ascii?Q?GetjBP+Vr9mVpUR3PMPembY/e8CUoXFuQcZIymepumYwaa34Uk+J2T7OMsTj?=
 =?us-ascii?Q?uLrfay1KwkyvFBS2I4Vr4TUfy9l3lh2xNkVu9fRRpDJKU4qCSbXYSmZxy1+s?=
 =?us-ascii?Q?TjUdlqXRlpqyoDoROpKbzJpkqsmOWFnChQZV6uOw4CFUgc/VFX9fOL8oNbKV?=
 =?us-ascii?Q?PKxERpKCmI6J9JMJuCWy5keUVyMDEtIIDzTb+j6VfXfY1tGPiYs/BimCaz22?=
 =?us-ascii?Q?sMVExEhi0iLFamM8HERemfoNFNa6zsnE2kSPnZI6kDQdR/3HFBTDpq3qb/Sp?=
 =?us-ascii?Q?tTxDc+HSO0zZRAJkksWCVYUvDMEz6ThqSeUIYVLmFiqOgycor1QccqeTFwUz?=
 =?us-ascii?Q?hbkv3fAqa6QslKEzMFmMOvIMVyKtnbQLKdVaX+T81OwMos/L+3hzizSekjiT?=
 =?us-ascii?Q?JXAIh2gk2W4Nc3ymqGrhg5SFlCSFMaqQdBkYRvPoAavJrRcUlEuWlVHPliN+?=
 =?us-ascii?Q?kf2Y6IObEKcZcuIXWjAIREc/kuaaqvnX/N1KN0e5K4BspEOSsYUZjnQCLsnI?=
 =?us-ascii?Q?oxPZ3otHdfJER+G0nqEndSg+Y732x6b1ec8EuYdINAsO9X2m2mjdccQrBYNy?=
 =?us-ascii?Q?HTZAlU4lli0MNHqzLoY7zbBbnOgLh/C5cpOMx8M2TulMhFONkOuHaZBiAo/+?=
 =?us-ascii?Q?ErXahCMQoo1giVilnIpwAKuVWwO9iBGc7A3Xkbf9BjZc0bCPTkqEYiV/sajI?=
 =?us-ascii?Q?BUSjKV6Xz+BNKU/+KhuFY0C3IuKVlCeGOzVbn1IPweykOWcW3/hhH7wvzs0E?=
 =?us-ascii?Q?FMCXjv2pno3gfngjk/k1h2RK+qEywFCTkE0f1y0cKVjo9Uyghm6Hk/IOdBVR?=
 =?us-ascii?Q?s8ihfPN9oLihrhhwPY6eatKTWbhGarQIJFUlcBpd8VJ42FyXiC+XOxBkKW8h?=
 =?us-ascii?Q?XA=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS0PR01MB5922.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8a1b71bd-f24a-4a81-818e-08dbae9bc294
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Sep 2023 05:40:21.0219
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: wyrqq8IBFilOQPpL4FFEWabtldTOHJUCUp5EWKYM129/9QIm0DrWLKs7IqMErw+zETeUIglNzC3ReeF0GP4KT39EwzB05R8zraNWd4jd0IE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY3PR01MB9779
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 06 Sep 2023 05:40:29 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/12974

Hi Nobuhiro-San,

> Subject: RE: [PATCH 6.1.y-cip 15/20] drm: renesas: Add RZ/G2L DU Support
>=20
> Hi,
>=20
> > Subject: [PATCH 6.1.y-cip 15/20] drm: renesas: Add RZ/G2L DU Support
> >
> > The LCD controller is composed of Frame Compression Processor (FCPVD),
> > Video Signal Processor (VSPD), and Display Unit (DU).
> >
> > It has DPI/DSI interfaces and supports a maximum resolution of 1080p
> > along with 2 RPFs to support the blending of two picture layers and
> > raster operations (ROPs).
> >
> > The DU module is connected to VSPD. Add RZ/G2L DU support for RZ/G2L
> > alike SoCs.
> >
> > Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
>=20
> You forgot to add the original commit ID and Signed-off.
> And I could not find this patch in upstream tree. Probably any patch afte=
r
> this one has the same problem.

As mentioned in the cover letter, the last 6 patches are in review state in=
 mainline [1] and [2]. I have added just here for testing purpose.

I have tested GFX[3] + DSI + VSP + FCP functionalities with this patch seri=
es.

[1] https://patchwork.kernel.org/project/linux-renesas-soc/patch/2023070409=
0447.27420-4-biju.das.jz@bp.renesas.com/

[2] https://patchwork.kernel.org/project/linux-renesas-soc/list/?series=3D7=
42810

[3] https://renesas.info/wiki/RZ-G/Panfrost_for_RZG2L

Cheers,
Biju

>=20
> > ---
> >  drivers/gpu/drm/Kconfig                  |   2 +
> >  drivers/gpu/drm/Makefile                 |   1 +
> >  drivers/gpu/drm/rz-du/Kconfig            |  12 +
> >  drivers/gpu/drm/rz-du/Makefile           |   8 +
> >  drivers/gpu/drm/rz-du/rzg2l_du_crtc.c    | 599
> > +++++++++++++++++++
> >  drivers/gpu/drm/rz-du/rzg2l_du_crtc.h    |  92 +++
> >  drivers/gpu/drm/rz-du/rzg2l_du_drv.c     | 185 ++++++
> >  drivers/gpu/drm/rz-du/rzg2l_du_drv.h     |  84 +++
> >  drivers/gpu/drm/rz-du/rzg2l_du_encoder.c | 109 ++++
> > drivers/gpu/drm/rz-du/rzg2l_du_encoder.h |  32 +
> >  drivers/gpu/drm/rz-du/rzg2l_du_kms.c     | 711
> > +++++++++++++++++++++++
> >  drivers/gpu/drm/rz-du/rzg2l_du_kms.h     |  43 ++
> >  drivers/gpu/drm/rz-du/rzg2l_du_regs.h    |  67 +++
> >  drivers/gpu/drm/rz-du/rzg2l_du_vsp.c     | 469 +++++++++++++++
> >  drivers/gpu/drm/rz-du/rzg2l_du_vsp.h     |  97 ++++
> >  15 files changed, 2511 insertions(+)
> >  create mode 100644 drivers/gpu/drm/rz-du/Kconfig  create mode 100644
> > drivers/gpu/drm/rz-du/Makefile  create mode 100644
> > drivers/gpu/drm/rz-du/rzg2l_du_crtc.c
> >  create mode 100644 drivers/gpu/drm/rz-du/rzg2l_du_crtc.h
> >  create mode 100644 drivers/gpu/drm/rz-du/rzg2l_du_drv.c
> >  create mode 100644 drivers/gpu/drm/rz-du/rzg2l_du_drv.h
> >  create mode 100644 drivers/gpu/drm/rz-du/rzg2l_du_encoder.c
> >  create mode 100644 drivers/gpu/drm/rz-du/rzg2l_du_encoder.h
> >  create mode 100644 drivers/gpu/drm/rz-du/rzg2l_du_kms.c
> >  create mode 100644 drivers/gpu/drm/rz-du/rzg2l_du_kms.h
> >  create mode 100644 drivers/gpu/drm/rz-du/rzg2l_du_regs.h
> >  create mode 100644 drivers/gpu/drm/rz-du/rzg2l_du_vsp.c
> >  create mode 100644 drivers/gpu/drm/rz-du/rzg2l_du_vsp.h
> >
>=20
> <snip>
>=20
> > --
> > + * Initialization
> > + */
> > +
> > +int rzg2l_du_crtc_create(struct rzg2l_du_device *rcdu) {
> > +	struct rzg2l_du_crtc *rcrtc =3D &rcdu->crtcs[0];
> > +	struct drm_crtc *crtc =3D &rcrtc->crtc;
> > +	struct drm_plane *primary;
> > +	int ret;
> > +
> > +	rcrtc->rstc =3D devm_reset_control_get_shared(rcdu->dev, NULL);
> > +	if (IS_ERR(rcrtc->rstc)) {
> > +		dev_err(rcdu->dev, "can't get cpg reset\n");
> > +		return PTR_ERR(rcrtc->rstc);
> > +	}
> > +
> > +	rcrtc->rzg2l_clocks.aclk =3D devm_clk_get(rcdu->dev, "aclk");
> > +	if (IS_ERR(rcrtc->rzg2l_clocks.aclk)) {
> > +		dev_err(rcdu->dev, "no axi clock for DU\n");
> > +		return PTR_ERR(rcrtc->rzg2l_clocks.aclk);
> > +	}
> > +
> > +	rcrtc->rzg2l_clocks.pclk =3D devm_clk_get(rcdu->dev, "pclk");
> > +	if (IS_ERR(rcrtc->rzg2l_clocks.pclk)) {
> > +		dev_err(rcdu->dev, "no peripheral clock for DU\n");
> > +		return PTR_ERR(rcrtc->rzg2l_clocks.pclk);
> > +	}
> > +
> > +	rcrtc->rzg2l_clocks.dclk =3D devm_clk_get(rcdu->dev, "vclk");
> > +	if (IS_ERR(rcrtc->rzg2l_clocks.dclk)) {
> > +		dev_err(rcdu->dev, "no video clock for DU\n");
> > +		return PTR_ERR(rcrtc->rzg2l_clocks.dclk);
> > +	}
> > +
> > +	init_waitqueue_head(&rcrtc->flip_wait);
> > +	rcrtc->dev =3D rcdu;
> > +
> > +	primary =3D &rcrtc->vsp->planes[rcrtc->vsp_pipe].plane;
> > +
> > +	ret =3D drm_crtc_init_with_planes(&rcdu->ddev, crtc, primary, NULL,
> > +					&crtc_funcs_rz, NULL);
> > +	if (ret < 0)
> > +		return ret;
> > +
> > +	drm_crtc_helper_add(crtc, &crtc_helper_funcs);
> > +
> > +	rzg2l_du_crtc_crc_init(rcrtc);
>=20
> Will this work correctly if rzg2l_du_crtc_crc_init fails?
> It looks like the error in rzg2l_du_crtc_crc_init cannot be caught.
>=20
> > +
> > +	return 0;
> > +}
>=20
>=20
> Best regards,
>   Nobuhiro


