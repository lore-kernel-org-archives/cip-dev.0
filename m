Return-Path: <prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD9C9D1268F
	for <webhook@archiver.kernel.org>; Tue,  5 Nov 2024 11:35:38 +0000 (UTC)
Received: from OS0P286CU011.outbound.protection.outlook.com (OS0P286CU011.outbound.protection.outlook.com [52.101.228.6])
 by mx.groups.io with SMTP id smtpd.web11.15640.1730806529171129855
 for <cip-dev@lists.cip-project.org>;
 Tue, 05 Nov 2024 03:35:30 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@bp.renesas.com header.s=selector1 header.b=AWmLWLiP;
 spf=pass (domain: bp.renesas.com, ip: 52.101.228.6, mailfrom: prabhakar.mahadev-lad.rj@bp.renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QffGkcEpDmeGS7NjUte9+yO2OBQmts1WK8Vj/prn0l6/Usd5MW56DLngl9iyP/4Buhh0ljLoUkzdaNUf6XSY4fl5UUMnhq/bnIQghVeUhLvWRy0TvuW01Be3KBZwRG+pWzv0EwvRp0sfwMPnI+4rMyKlvDscy6+ki28QTf5W6y9ey4Q18wSuIqrMF27mEuButHZrdehOlXvqVbNC1MN6l/j28IYOcNrftyX/zy2RREGkPHYBWYutmbiKcw3vWOstN6Fe3sfIfmctdPwhES7q7VXMly3Qyz3v9OZxrcAU8qb2FPiIVPtxVtj1wUh0BWW7722QNIPd2yHKsfz4KqpGDA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Gi/eA+kqQ7PszJ1EuTCe/fEZ17UiyFvjgq1Vl5rvyCw=;
 b=iI+EpcJW/QWiTvsRPXfY+GYXYZMX67eepqcLm1eHueDrQUoQGl6dw/C5mHg3FUS1yGGMqKhLXLXvo7AWVcyb3jtUlyHoKMXEP/U52FE/XVcGu5+8NFtwk+30857UdTT8uxLOdVMTHOFCrqdqSk6wF0UVCwGsNkp6exSx77mC+4ajzghrbK16qGb/p72MUylaVCsydmsdyqpIb/0mC2/7BhKjzYkTf1pGwIkU9rGhZwI0N6ka9eziZlCne/BGdzFRJQWKsuPBDHntMUKxBC5ahGA5tWzErbtxVQn6x7MftKU0jtre2WYrHvZ0u3NQdSi7E9vuuJ6Ufnt8WO0f48tKTw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Gi/eA+kqQ7PszJ1EuTCe/fEZ17UiyFvjgq1Vl5rvyCw=;
 b=AWmLWLiPLNBg17KCThROo5PrqWvUivUpFW49YWUypRFSlufz4PeE3E1OS2zhQXLYHySzoMEjXa83bRVqpezBHhIZdNGcFiKzezOS3zFi4VMYr2nhTvUT8jwTKWLW7aKdGSOlikBAs84q/shfYk+xtScOW7KOkfIcMkKK3ZJUGrc=
Received: from OSZPR01MB7019.jpnprd01.prod.outlook.com (2603:1096:604:13c::8)
 by OSYPR01MB5446.jpnprd01.prod.outlook.com (2603:1096:604:88::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8114.31; Tue, 5 Nov
 2024 11:35:24 +0000
Received: from OSZPR01MB7019.jpnprd01.prod.outlook.com
 ([fe80::8a27:ee0d:d7a4:9d10]) by OSZPR01MB7019.jpnprd01.prod.outlook.com
 ([fe80::8a27:ee0d:d7a4:9d10%7]) with mapi id 15.20.8114.031; Tue, 5 Nov 2024
 11:35:24 +0000
From: Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: Pavel Machek <pavel@denx.de>
CC: "cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>, Nobuhiro
 Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>, Biju Das
	<biju.das.jz@bp.renesas.com>
Subject: RE: [PATCH v2 5.10.y-cip 10/28] media: platform: Add Renesas RZ/G2L
 MIPI CSI-2 receiver driver
Thread-Topic: [PATCH v2 5.10.y-cip 10/28] media: platform: Add Renesas RZ/G2L
 MIPI CSI-2 receiver driver
Thread-Index: AQHbL3W23WfEHtM5f0ebhGWQUdVNwrKojegg
Date: Tue, 5 Nov 2024 11:35:24 +0000
Message-ID: 
 <OSZPR01MB70197A019A251CC5F96274BEAA522@OSZPR01MB7019.jpnprd01.prod.outlook.com>
References: <20241101125746.33222-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20241101125746.33222-11-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <ZyoBIAONV1wUteVt@duo.ucw.cz>
In-Reply-To: <ZyoBIAONV1wUteVt@duo.ucw.cz>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OSZPR01MB7019:EE_|OSYPR01MB5446:EE_
x-ms-office365-filtering-correlation-id: 903b0296-8df3-4438-cf68-08dcfd8df084
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|376014|38070700018;
x-microsoft-antispam-message-info: 
 =?us-ascii?Q?AvDPbUx9jAAg5xDzbdCrhm4+mZEbaeX1XlPpN3u2RPheA4389K6iY0fTGI5m?=
 =?us-ascii?Q?1MBqWQX1NS//MXD3ulYAGrVft1WzTm7lHzToz8SaruEWGsECxiGyIDDuKF0S?=
 =?us-ascii?Q?xtgbYN9Se5AQHITO/1VzLmunbfExglGmjOaiEpPtK4bboI7C1IGSsgkJvYHp?=
 =?us-ascii?Q?lLarxyTYmfuXMR4o1Zgri/NizMvcCM2MWPBdRN7gvqWblS2uQf5rLtUGpyQB?=
 =?us-ascii?Q?k9DTmXD1kQqfyDeIbMwUaG7aflW3cX3dioe+/dp4n/Wg7Kc5x0KpWDhIjYWG?=
 =?us-ascii?Q?RjKuu/hnFG8Zz25teZcREpepj5Wlr7r4Aw7Tle3ffY14TJIP5VBZFs1VOF3j?=
 =?us-ascii?Q?o3T+fM+V/yYsFnYUekQmicqNpVnNl/VLr3PxBpXMtHA2nvgsAqFTn75hD8hi?=
 =?us-ascii?Q?mXpj3V6SDu1r1Bu8RfFmWnFkNiCKrjV2nP4RP+cyaHRgqLY60CCxDdlc+Q59?=
 =?us-ascii?Q?qFrqkyPUKhzU0xpe7mVhKloTtz2euyL2ZgGNjZhY/+JOF0oCrLSwac7HwLMv?=
 =?us-ascii?Q?ZDdQ/DAoG1gJmqmUav10I5FcbVl2RSnhZHcFuvsyTwXqQsM7O3UK6MZJVnhD?=
 =?us-ascii?Q?sK3oVqJ/ogMFAXNDmdE2LtYfr6/riep+jEyMAIQFXlHXOd9tm8icolH3GF/P?=
 =?us-ascii?Q?n4fZJKQo0riKL44RclHrqOtCEZCfJp0M6YiekvgAvyHoWjdtXynOlPO226fG?=
 =?us-ascii?Q?X8xaF/qdczHBfb+mVi0r9/N+VmiwYF599m6IDbG40ldlll2KQAKcb8WTyr0a?=
 =?us-ascii?Q?6y+C2s/4if+ODHCEgyJU09iTg7jYpwsYoX6KL04rUG6RLb5iwmg+QUXZWrH5?=
 =?us-ascii?Q?/zDPWzCqSp2gBuoJ9xvYkc93kjkHYQV3L40ia5/+b5M8dSHwQqPIpBuuRCjq?=
 =?us-ascii?Q?2fp88mGmqjOCM3g70H70RlRtlt62ZXJ1e9L+SkOHT5NdyUMEYp3anDp05Okn?=
 =?us-ascii?Q?w3np/vofwdAYfSOvPACAUCKvrPoWpMwle3qh/pXdFVw8uDjqQzmczryz02ZC?=
 =?us-ascii?Q?mebKkoprqjq5n3vxK9zk4oKCiAlh4Wp2eh8OYE6ds791L891vqRzC8PgQYcB?=
 =?us-ascii?Q?AQUdnHiUOBEeSNJFQH+49+LJ84KCGzNrkQ2bCgxGaXVhJY0QavkY2ksRs/rH?=
 =?us-ascii?Q?eVVWq3Kq8ajF3QOll5GTPPQjRBzbqzYME33sxDYI4vu4PDIEe8ob/cCaS0J2?=
 =?us-ascii?Q?WnC7MltK2x/YkXUp0OlS8f/VrQwM0C/cHssaVj4lhrawHUDSJpaQIRk5UuKa?=
 =?us-ascii?Q?2BVaJFHZ6T100Zb3qXkGTGUaUEXJpZlgv7+TzndzLpe4G9dqZkTpjqKBNjaY?=
 =?us-ascii?Q?FsGpfe+ipgxyqC+wV3XYrCGw04IFwJLiURruvxim2zWgAGM2wb15aqJ+6Bpm?=
 =?us-ascii?Q?3VMZ4nA=3D?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OSZPR01MB7019.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?us-ascii?Q?cixZSVgO7268BtSxIrN6pgRk3JHSJaLWIq0iPJjB+zmjW1Rf7iMJItrZHpy8?=
 =?us-ascii?Q?5trjmgzcKkQyTREjBqsSuG5i72m+3hm98sg5w+aM2JaOFs51p5UTaNMWnql1?=
 =?us-ascii?Q?c/W9z9xZg3Dp3H6azDPJxwxNasxgwCBNxl1jaiiJCQIoyxdsERZqPEvgD5zv?=
 =?us-ascii?Q?4P8VVTipFxmChrP92y+62AaVAqeN9dKIWorEl5B5QhmkddbmAdfhPHPyoFb9?=
 =?us-ascii?Q?MNl7PtKgN0v6GDHUMgerGE2glYAZzPbg7GwnqipI/ik+Vb+NrMWS7Kh7n3DJ?=
 =?us-ascii?Q?D+yGSYHFrqmHBOG5cbzUFUueTZ0gvVnJRVB0TwBQMyJIcbMciWVPp/nxQDmE?=
 =?us-ascii?Q?jsur7LcigNng6zN4vjWGMtEMq4KCJ2PpBaFRhvKXm/mtOVg7JRcFuq1+68Ra?=
 =?us-ascii?Q?/asWWK2lx4a5kZM9DFslSExxCTfeFHG5aEl18vcn2tc04IrCFvYE463+Jcq3?=
 =?us-ascii?Q?cVarcfdyaKeowXDZ5//ehXJEGPHwwbnljf6TR57110sDG+8rnpGzIU1fNlRI?=
 =?us-ascii?Q?o2/B5hpoXvnkBQopLOergnCU1nNEYoRsP3TVLr7WdGzE4rqFO6SS3FxSVKry?=
 =?us-ascii?Q?pQcjAugKKIYP/vtcRTBz3hgVLdDtjYgcMihJDTgkUNr2kMcGQHhwi0KZ/HBj?=
 =?us-ascii?Q?KsZ9bGQ17dQpGJHTuRKoulCLl6x4ovX51Rtf+XLSX0c8qyjTdeROk9zBEXWp?=
 =?us-ascii?Q?iT0jMA8BDP1TPc+OVhKRZm3oZZ9GdgRLuXwgMdVRQ+WKBmEQwkLD9QsUDIy+?=
 =?us-ascii?Q?+qZ67SH1fig7jJasZhlPFgcOWX9Pm7EcjojfMW3uQ0iLKFcIaefBmlNSr4jB?=
 =?us-ascii?Q?dDyQ/fmqLyTWmRzTV91Rehsf4p4q7rlJL8AA6xValhmTmIJYYNEgIKsuBn1v?=
 =?us-ascii?Q?UdZ0qQURVB1kObnhB08XEIWOYpg26LvofUOYHQ3/TQXbPVaMp+M9bDYV91zH?=
 =?us-ascii?Q?/NY/87eGUxX0QUoa7x1f4s1Dj4A9AObxM90QgV1N9TbnlWha02wnZNbqBaav?=
 =?us-ascii?Q?mic8pEMOl5dMgeDE1gwpKjQvaaIl7Rzwu/BlqmAiAoJQc0uwFPcDJTJtUCjL?=
 =?us-ascii?Q?F4bCol6RcKPUZglalofVoh5brZ/M+qvMNzaprgACo3ltMsP79/UuVRuFhY0s?=
 =?us-ascii?Q?bgDDViQQe3/mJyg2r77n044CwFEZc+Yk7+Mpcp4VA2ZS4ethSFyBx1evvUAC?=
 =?us-ascii?Q?vIUPonc1kFHahF1abv7HzrCZyYJn+CSZZlJkZ/geIoVtdd7Eg9t3qvEpqZkc?=
 =?us-ascii?Q?UZKLGCA++LM6qwALSn+NhgoBTGtP+KWkGMnIkSa+VlBtUZP5B2sCHrXcr/Vx?=
 =?us-ascii?Q?dLcQbie24ruXpEs00kSNMKLxR9tSUyAi7CA21y65TuBk9o40YBsD+q+CZgvo?=
 =?us-ascii?Q?pryJvjJvxj1B57qewfNI3U1MHynDyrc7e9guiUgGMK9vxiwT1a6GFxNrV9QJ?=
 =?us-ascii?Q?9GUF6sYzbVz98aZPxA4XjsPYGHiCu8rk4qLFb/OgjTKdo6y4Y13J9sHStIr3?=
 =?us-ascii?Q?7UZdDXprirEM7Pa9haQLuraASbqxFUrLaXHDBBOWKiikCcy4sum6MlmmvXaL?=
 =?us-ascii?Q?UjGKZ/dsK59Yz0KwEG4Pr0UY4U2Y6GFU1SuREFG5zrtvbOJ9FqpjK2EK+h9a?=
 =?us-ascii?Q?kNZJmKHu7bG+I1f3iLoYl6E=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OSZPR01MB7019.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 903b0296-8df3-4438-cf68-08dcfd8df084
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Nov 2024 11:35:24.6675
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Lf8ZZz4DW2d0o19IYzS3kokzFSuoPkYhwl9+JoKnyExQ2ETDXdPNvmAvlyr1QWK3BWV2PiTJGa0NopjQApRnl2Y07TEWBRB8Dhe9rGTlLlyV+QNL4awztY8EFNrrufIY
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSYPR01MB5446
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 05 Nov 2024 11:35:38 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/17174

Hi Pavel,

Thank you for the review.

> From: Pavel Machek <pavel@denx.de>
> Sent: 05 November 2024 11:27
> To: Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>
> Cc: cip-dev@lists.cip-project.org; Nobuhiro Iwamatsu
> <nobuhiro1.iwamatsu@toshiba.co.jp>; Pavel Machek <pavel@denx.de>; Biju Da=
s
> <biju.das.jz@bp.renesas.com>
> Subject: Re: [PATCH v2 5.10.y-cip 10/28] media: platform: Add Renesas
> RZ/G2L MIPI CSI-2 receiver driver
>=20
> Hi!
>=20
> > commit 51e8415e39a962db2a753940fca18e9710c24902 upstream.
> >
> > Add MIPI CSI-2 receiver driver for Renesas RZ/G2L. The MIPI
> > CSI-2 is part of the CRU module found on RZ/G2L family.
> >
> > Based on a patch in the BSP by Hien Huynh <hien.huynh.px@renesas.com>
>=20
> > +++ b/drivers/media/platform/renesas/rzg2l-cru/rzg2l-csi2.c
>=20
> > +static int rzg2l_csi2_notify_bound(struct v4l2_async_notifier
> *notifier,
> > +				   struct v4l2_subdev *subdev,
> > +				   struct v4l2_async_subdev *asd) {
> > +	struct rzg2l_csi2 *csi2 =3D notifier_to_csi2(notifier);
> > +
> > +	csi2->remote_source =3D subdev;
> > +
> > +	dev_dbg(csi2->dev, "Bound subdev: %s pad\n", subdev->name);
> > +
> > +	return media_create_pad_link(&subdev->entity, RZG2L_CSI2_SINK,
> > +				     &csi2->subdev.entity, 0,
> > +				     MEDIA_LNK_FL_ENABLED |
> > +				     MEDIA_LNK_FL_IMMUTABLE);
> > +}
> > +
> > +static void rzg2l_csi2_notify_unbind(struct v4l2_async_notifier
> *notifier,
> > +				     struct v4l2_subdev *subdev,
> > +				     struct v4l2_async_subdev *asd) {
> > +	struct rzg2l_csi2 *csi2 =3D notifier_to_csi2(notifier);
> > +
> > +	csi2->remote_source =3D NULL;
> > +
> > +	dev_dbg(csi2->dev, "Unbind subdev %s\n", subdev->name); }
>=20
> Are the dev_dbgs still needed?
>=20
Yes, as the probing of subdevices is async it is better to have dev_dbgs.

> > +static int rzg2l_csi2_parse_dt(struct rzg2l_csi2 *csi2) {
> > +	struct v4l2_fwnode_endpoint v4l2_ep =3D {
> > +		.bus_type =3D V4L2_MBUS_CSI2_DPHY
> > +	};
> > +	struct v4l2_async_subdev *asd;
> > +	struct fwnode_handle *fwnode;
> > +	struct fwnode_handle *ep;
> > +	int ret;
> > +
> > +	ep =3D fwnode_graph_get_endpoint_by_id(dev_fwnode(csi2->dev), 0, 0,
> 0);
> > +	if (!ep) {
> > +		dev_err(csi2->dev, "Not connected to subdevice\n");
> > +		return -EINVAL;
> > +	}
> > +
> > +	ret =3D v4l2_fwnode_endpoint_parse(ep, &v4l2_ep);
> > +	if (ret) {
> > +		dev_err(csi2->dev, "Could not parse v4l2 endpoint\n");
> > +		fwnode_handle_put(ep);
> > +		return -EINVAL;
> > +	}
>=20
> Would it be better to propagate error (return ret) here?
>=20
Agreed, I will fix this upstream and then backport.

Cheers,
Prabhakar

