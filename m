Return-Path: <prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9A8CD1269B
	for <webhook@archiver.kernel.org>; Tue,  5 Nov 2024 12:22:28 +0000 (UTC)
Received: from TYVP286CU001.outbound.protection.outlook.com (TYVP286CU001.outbound.protection.outlook.com [52.101.125.62])
 by mx.groups.io with SMTP id smtpd.web11.16563.1730809346890039718
 for <cip-dev@lists.cip-project.org>;
 Tue, 05 Nov 2024 04:22:27 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@bp.renesas.com header.s=selector1 header.b=eiqUWchY;
 spf=pass (domain: bp.renesas.com, ip: 52.101.125.62, mailfrom: prabhakar.mahadev-lad.rj@bp.renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cBKX0RX/08O0eBN1u3FpSe9k/iAfuNLf2/8FG1TwU6iQ7YudVWJkU9DKL7c1wMRKajFxlWW/8mYf92RT+gnuaHsLYN0Q+15hWcsWLhE/bzl5Y4BXaP469plzaDRwcvThOT1K8UBOTS0NpaKRvbMoaDWV9i6DOSn0cfpUJzYOgzmx+dRv97/lk5BKoU8jR69ZiWD5U6mGDRmCRYepjp8aNSvhLbtMMEl2GWfd1k+iPS1CkuOTD5gv7Ki5NItcKihd68LHN0yZsJ5ciww+VZosLlA7g55S7EapGX3OKcIaL+ob8ukJka6XwUpSwOhqD6oifVqI8jBxDynsAS7G00d+VA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RF8keD2obBSFxLd1UGibDiKv/Jvgb3xSGmz1oSoZekk=;
 b=RnRris4W0/7FlQULvWNth3V2ZWhqqhZTmTPwSAyrmYZRuvxbRidNiY4VSw9SE5jJdO1nK1dWG/XXOoZZ0Xinon6EbG3ysWNV1qcuiSe4oibwamPjWPv5qlQAqVAPeqf8XEHl7tIBtSNdbPmsg7FWAtfoubAqNkhvV/pqt6B4RD6Z3INjD6mIxuOPozMVz+rlBMez5bpydKTTFVIS2tvNRAJjT0aMwHSCo2U/NdrlTilotUbU1M0x29N31qWFQ9IiaS5N2XG24931AnPt7oYc2aizJb26o+CmDIFQBMPD9+iY7h+a82H/4+C7BrjBFl5oHocUnORrh782nnGxtGQT7w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RF8keD2obBSFxLd1UGibDiKv/Jvgb3xSGmz1oSoZekk=;
 b=eiqUWchYuz/wIYuRt0vz7eIUREjsoTbUwTRjChZc4JRhwaE4mTICzroph4kuwfb87yaEt2veK2cvASnVq5AWgRNd+88d8AZrL7JbpQsC3IZWa9sGGpF5QIJUQMmWO9t6kaavxNNlJbnK3o42pVeHy33/yReP/eX/NqrBuRXQzII=
Received: from OSZPR01MB7019.jpnprd01.prod.outlook.com (2603:1096:604:13c::8)
 by TYCPR01MB8868.jpnprd01.prod.outlook.com (2603:1096:400:18f::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8114.31; Tue, 5 Nov
 2024 12:22:21 +0000
Received: from OSZPR01MB7019.jpnprd01.prod.outlook.com
 ([fe80::8a27:ee0d:d7a4:9d10]) by OSZPR01MB7019.jpnprd01.prod.outlook.com
 ([fe80::8a27:ee0d:d7a4:9d10%7]) with mapi id 15.20.8114.031; Tue, 5 Nov 2024
 12:22:21 +0000
From: Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: Pavel Machek <pavel@denx.de>
CC: "cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>, Nobuhiro
 Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>, Biju Das
	<biju.das.jz@bp.renesas.com>
Subject: RE: [PATCH v2 5.10.y-cip 11/28] media: platform: Add Renesas RZ/G2L
 CRU driver
Thread-Topic: [PATCH v2 5.10.y-cip 11/28] media: platform: Add Renesas RZ/G2L
 CRU driver
Thread-Index: AQHbL3Zv7ncxLLxG30OJN8zkQyOAPrKomz0w
Date: Tue, 5 Nov 2024 12:22:21 +0000
Message-ID: 
 <OSZPR01MB7019EE3CDE21CF7E4E3A14F5AA522@OSZPR01MB7019.jpnprd01.prod.outlook.com>
References: <20241101125746.33222-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20241101125746.33222-12-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <ZyoCV4ZzNVrcO3rg@duo.ucw.cz>
In-Reply-To: <ZyoCV4ZzNVrcO3rg@duo.ucw.cz>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OSZPR01MB7019:EE_|TYCPR01MB8868:EE_
x-ms-office365-filtering-correlation-id: 9fea8a93-c646-450e-84a6-08dcfd947f8b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|38070700018;
x-microsoft-antispam-message-info: 
 =?us-ascii?Q?6DCb0Or1Yd6DHcWMO3SDqArweC35H8FwVYfYncSMAezraCmBgNCYhRhp/k2O?=
 =?us-ascii?Q?OhCBq36IN3kCmzLABXkKmXiX5PUDEFIGGWCQgcv62SU8eOerAqmWYLmgDEZA?=
 =?us-ascii?Q?mpP8MT5Xuyc19q4wynh51dQOvMj8tZ6xfifSYovPyU/zkBMtjo+xzVkB+Ogh?=
 =?us-ascii?Q?Q96gB5ceX/VTYY+/ryWNtSgVhaBsG7vijHnPdLnPgzFVX7D05+5uPpg6G7Z8?=
 =?us-ascii?Q?J0KIBfp+qu/0n/t1kAxIkoYovJSaxGX9k3Sa6dZdeuEBHlR2vYL22//3Qogj?=
 =?us-ascii?Q?KjP+FqD6THIGujLOM6uOdwAHAa1GXY0IvcAvQ8aHQy6CqzwTnOdk0vDXcBko?=
 =?us-ascii?Q?3t+FllNzzS+uxphLotFwEH3ts+ElHTO5VU9mSCughhoLSEbOVlV8DgxfMR8k?=
 =?us-ascii?Q?6bXZog5wGEbS4h8M87pQxQ463Ob7ZFE2JS55aPlJYTJur0FA94fB19sjLRMc?=
 =?us-ascii?Q?vqwiPwK1MjU1fSUrFWKCFAL3YoTwVRAJf6phb7ZRol+gcvCKJ9Ofv+6B0/Bh?=
 =?us-ascii?Q?DIQ95KI2a6wEUHYAFfFqHPq3DPmZBzJESnK+nFf48+G6ud4xCdWcD0zN7v/+?=
 =?us-ascii?Q?tNwnMEAV6z/y4PxE8HvdmEXf8hzQ01zihY9LI7OHvhITl/hfHlYwVgeBKdvp?=
 =?us-ascii?Q?zNYAu2GLQiOSi4snZkTKdo+N3b1KtNc/DiV4l5eIbp27fxohYWxsxI0NN9o3?=
 =?us-ascii?Q?hbbAh1PtBNLytD3fWdVAy3r3hwrrCdv122/JGbXZ8+JjTRUf2SydW8rDWaiy?=
 =?us-ascii?Q?8vuxx/n2RO+xDpzLKgtEyc8aCdUY1Q3Tokm+ykCyW21tgy2dBK42qvB+4bcM?=
 =?us-ascii?Q?xF2GDwXKe8i53icwnKy2rcadFkdNOoENWrAMgBIKJeS/8J3S0T6ZQoPSjZ5e?=
 =?us-ascii?Q?8VbeGhPysU3VzceMqlQt+DueN+ET4kz6hQ9KGCqAqPbQzs9bCu2n0CRoOvCS?=
 =?us-ascii?Q?qbHFxjm1td7uwpdM72+d82/9k1HJpA2q1gS3/L+AihpAFH8yEmjMj3JO+MF9?=
 =?us-ascii?Q?g13mJSSfbqlXIB2gbTSBDB6NvHIx96/r1Dt+9UV771qS7pB6ab2woWifdsLE?=
 =?us-ascii?Q?9v0xyh1G4+BDVwyu3zdWAqTjrUOUS/r9ffl/Fg9DKUgGEn14qxwcbAiV5biu?=
 =?us-ascii?Q?EdKbCNOG7vlyzcN6GX7vCPphh0fulO/ZVRBbJlC3ZkNbj2Tc2pwAQ1rszpF4?=
 =?us-ascii?Q?2rliEYnOxXQlOcEEf7zwthd3UCnbnSsnLnJmSD+RPGuBQ7Q0xmFhRaCy4qxS?=
 =?us-ascii?Q?sqZmMjK59UjU1gpQcDvd0udhUV/MNC73uQ6e9uaSUKZV7RmBgLWxgaZTxqZk?=
 =?us-ascii?Q?NM6I6DXuuU/nWcC0B/Z4fiYpkivvoCacJOIjG03L4XR2KOqFIIhKSmQCvnjc?=
 =?us-ascii?Q?xt6bl8o=3D?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OSZPR01MB7019.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?us-ascii?Q?jp9xwgP0m6qIJVpx2wU+IuOq52Q0fpmAWunv67LrP1+y7LYaI/QRtEx80GnH?=
 =?us-ascii?Q?hxNfJazBVgOCgix6xTFbSfpmHJb1v2OtPgeL/WJW/gNcizA4BlGDfiwcA5rp?=
 =?us-ascii?Q?VyGKsMb/oA+aM03PHYEnOefitfbXKLM5noEtfr/MQL3/jXRixM+1fKENrsPB?=
 =?us-ascii?Q?cu5S51VRcCGYAgpQKXu6avPACaIDuLgHpVY6zVIluDStVVLzbcLumaHV7/gK?=
 =?us-ascii?Q?fdXhR5YNtTy8DdsxKjIlEkHaINkMDNRI4LU33ZlxPGvv7XFdyhHThtZTmhD+?=
 =?us-ascii?Q?UrYTs/70+vgsOAGNhn2VvjAKcyZBjWUvHn04X+88AW1sQ109NhFE4F01vfpu?=
 =?us-ascii?Q?HF2pJ4BSQ4cU3zmx+TT11Rsaep8mx3LE9OBPtTz2nqzaiciIV/dqN/kt1Phu?=
 =?us-ascii?Q?S66LMu/936YnEHoCCuuoXa02Lsg0uh0WEpCn+JnTuQD7fXozMtP4sgwVpW7l?=
 =?us-ascii?Q?FohiGHdWR7kf/zRQ1ZVQiit1sFcpGTfaRJzf1O/ctcRmSGe8G/6zgPKl5gY5?=
 =?us-ascii?Q?p7yceqs1218vV5lGIHNYr+cb9HPUA+JNHynizC0Pxa4UZM4p2K7iy0cBxvDg?=
 =?us-ascii?Q?nC4koh4k+DACDi7eaR8LKPpEUGIgJGrEYM9YHLD1Lqr8r0fMSSCPuFvaugLq?=
 =?us-ascii?Q?r6h4mYtBtXJk4fRAaeoSuII5yyLLyw5tXYfuHpdHvU7xWTagCBqbzdek+vdK?=
 =?us-ascii?Q?JQIFot1T8HRXjhwhAXKiXmmS4wSOS83Sb98HzDHWi0SVyXNKvJqX2lnr+Yyd?=
 =?us-ascii?Q?oIEWNPTxgXqt+qWLvGbLDJuyqZL92leT6olXiOupNcCGkPD3AyOVvecc3osd?=
 =?us-ascii?Q?zY7joxCaFQbR1fn8FyAEN5ZHmB8RaTWaezkfyf80AYsOb+Js0aK19eT0Hso+?=
 =?us-ascii?Q?WLYw2fLxlyZOLEYmpG5XsSb0G+a/+jZFSfes82rlavD+SB8VFtdgIGMj4uUG?=
 =?us-ascii?Q?b5RwIZ9xtpnA0IXxbkratEjNNtKVjw440spzET5qc1A2D62qEDOItZCHd/Dl?=
 =?us-ascii?Q?m5tK9rc+Laoyo8ZRt2MDJXr93WuNN3Xztw/1/1vN5mDnV35dOzoaM4frPTni?=
 =?us-ascii?Q?BNgnyxOnlDJBgUs/htK4IRvKEDuGR6z79P2LZ4sO3Zc81uaT7V9KMh/Dw7jT?=
 =?us-ascii?Q?tNmx1b9UBULXdEIx5fxswqwD/4rCoi83mS5hdnFyiDpluE/AvcS/Kg5XZ3Q+?=
 =?us-ascii?Q?lKWwghljN81Nl8xMUcGr52QHo5GKVQogJ70Y1BW0/43gAVRG/k0SlaP67aBc?=
 =?us-ascii?Q?orGWKThwyRE0+ffVKc9YEUNbWVIvWpXf/HbYAYkb2711uTKb9rbWczUGoyjI?=
 =?us-ascii?Q?0ZZeJ5jkuv3DqkoMGwdb/Rb/j47Czid9uw8kutPoL7Kp2eqPPD6Ip+wsfjJ8?=
 =?us-ascii?Q?7YY7dhSmUVbU7Oa5DYsDCvFzK4JWoU6K+HiFK7N1/PdiROPSO326qLfx0gKg?=
 =?us-ascii?Q?AbE91N/rVt+p6LgdGlCTOAQSuBdNaIFdhiT1hjtolDmXI1LolHvmo4ekgmX2?=
 =?us-ascii?Q?A7C1PNkrGYPPldbsNnS4GX2jY738N8pewArjXXhvs7gxKuXbfIAM+1AwFKAt?=
 =?us-ascii?Q?rXVGPYCbTnQ5nnTZ+R9812S+CTwgYkkFS2QtkEYgWugSucJ9yGfbUfqVtz1X?=
 =?us-ascii?Q?5sU/aT2HKr2YYFG4vEp6NY0=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OSZPR01MB7019.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9fea8a93-c646-450e-84a6-08dcfd947f8b
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Nov 2024 12:22:21.6211
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 9L5jMxlSBO0/iWGmn2evdOW7wZIxdXxA9RMuWu8jDQtcP1n3RWiHFfO9VD5UClKRAM1kr2TrJ61cH0FC6ojhA1J/rdehhy9ONOAHC8/m7HedJDjSy2APxsUpGIkn1mzJ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCPR01MB8868
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 05 Nov 2024 12:22:28 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/17175

Hi Pavel,

Thank you for the review.

> From: Pavel Machek <pavel@denx.de>
> Sent: 05 November 2024 11:33
> To: Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>
> Cc: cip-dev@lists.cip-project.org; Nobuhiro Iwamatsu
> <nobuhiro1.iwamatsu@toshiba.co.jp>; Pavel Machek <pavel@denx.de>; Biju Da=
s
> <biju.das.jz@bp.renesas.com>
> Subject: Re: [PATCH v2 5.10.y-cip 11/28] media: platform: Add Renesas
> RZ/G2L CRU driver
>=20
> Hi!
>=20
> > commit 07fc05bd0a797dcc34620869933993e1cbf56b98 upstream.
> >
> > Add v4l driver for Renesas RZ/G2L Camera data Receiving Unit.
> >
> > Based on a patch in the BSP by Hien Huynh <hien.huynh.px@renesas.com>
>=20
> > +/**
> > + * struct rzg2l_cru_dev - Renesas CRU device structure
> > + * @dev:		(OF) device
> > + * @base:		device I/O register space remapped to virtual
> memory
> > + * @info:		info about CRU instance
> > + *
> ...
> > + * @num_buf:		Holds the current number of buffers enabled
> > + * @ip:			Image processing subdev info
>=20
> Holds-> holds, Image->image, for consistency with the rest.
>=20
Agreed, I will update it while I'm making significant changes to the driver=
 upstream.

> > +void rzg2l_cru_stop_image_processing(struct rzg2l_cru_dev *cru) {
> > +	u32 amnfifopntr, amnfifopntr_w, amnfifopntr_r_y;
> > +	unsigned int retries =3D 0;
> > +	unsigned long flags;
> > +	u32 icnms;
> > +
> > +	spin_lock_irqsave(&cru->qlock, flags);
> > +
> > +	/* Disable and clear the interrupt */
> > +	rzg2l_cru_write(cru, CRUnIE, 0);
> > +	rzg2l_cru_write(cru, CRUnINTS, 0x001F0F0F);
> ...
> > +	/* Wait until the FIFO becomes empty */
> > +	for (retries =3D 5; retries > 0; retries--) {
> > +		amnfifopntr =3D rzg2l_cru_read(cru, AMnFIFOPNTR);
> > +
> > +		amnfifopntr_w =3D amnfifopntr & AMnFIFOPNTR_FIFOWPNTR;
> > +		amnfifopntr_r_y =3D
> > +			(amnfifopntr & AMnFIFOPNTR_FIFORPNTR_Y) >> 16;
> > +		if (amnfifopntr_w =3D=3D amnfifopntr_r_y)
> > +			break;
> > +
> > +		usleep_range(10, 20);
>=20
> We are running with interrupts disabled here, we should use udelay(), not
> sleep.
>=20
Agreed.

> > +	}
> > +
> > +	/* Notify that FIFO is not empty here */
> > +	if (!retries)
> > +		dev_err(cru->dev, "Failed to empty FIFO\n");
> > +
> > +	/* Stop AXI bus */
> > +	rzg2l_cru_write(cru, AMnAXISTP, AMnAXISTP_AXI_STOP);
> > +
> > +	/* Wait until the AXI bus stop */
> > +	for (retries =3D 5; retries > 0; retries--) {
> > +		if (rzg2l_cru_read(cru, AMnAXISTPACK) &
> > +			AMnAXISTPACK_AXI_STOP_ACK)
> > +			break;
> > +
> > +		usleep_range(10, 20);
>=20
> Same here.
>=20
Agreed.

> > +static int rzg2l_cru_open(struct file *file) {
> > +	struct rzg2l_cru_dev *cru =3D video_drvdata(file);
> > +	int ret;
> > +
> > +	ret =3D mutex_lock_interruptible(&cru->lock);
> > +	if (ret)
> > +		return ret;
> > +
> > +	file->private_data =3D cru;
> > +	ret =3D v4l2_fh_open(file);
> > +	if (ret)
> > +		goto err_unlock;
> > +
> > +	mutex_unlock(&cru->lock);
> > +
> > +	return 0;
> > +
> > +err_unlock:
> > +	mutex_unlock(&cru->lock);
> > +
> > +	return ret;
> > +}
>=20
> This can be simplified. You already have "ret =3D 0" in the normal path, =
so
> this can be deleted:
>=20
Agreed.

Cheers,
Prabhakar

