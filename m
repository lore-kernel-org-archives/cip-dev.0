Return-Path: <prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25524E9A76E
	for <webhook@archiver.kernel.org>; Tue, 24 Mar 2026 11:23:36 +0000 (UTC)
Received: from OS0P286CU011.outbound.protection.outlook.com (OS0P286CU011.outbound.protection.outlook.com [52.101.228.55])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.17559.1774351412289518747
 for <cip-dev@lists.cip-project.org>;
 Tue, 24 Mar 2026 04:23:32 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@bp.renesas.com header.s=selector1 header.b=GEuZ8uJV;
 spf=pass (domain: bp.renesas.com, ip: 52.101.228.55, mailfrom: prabhakar.mahadev-lad.rj@bp.renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=C6RQqGfRaGE0vNxQY22VH2vI3joo3n2YsN9+mbYHAs950Z9oSs8fjA42ZSiAkTyzHgDfzGomtO3JIqy0vhNqa86Rzz9+K+v7FIlnt056vnqYVWnzogO7pLijEpQrl07zBjo6us/LfS/6L1J2bp+WQfj+coLqKlv6VQ273DSN6oEMPrpGta1ifltSQgdlOFrdbtN4hiZd5bHTz+PezAJcSW0/4mPVkpgqad0X0sC1gc5LggQY9Y+IUkEH96m0fwH9ZXnDPny4V2MyGzZEHSQxbw+c1w9MOWI9KYMyTZYJKR3KJvELXHLG6NBmb/ayit61ED6lqe7+offOzMxKuYsZeA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=25iuNGkOfwaaW2m3N/+uers7PBVRQYApFSIfVUIa9nE=;
 b=OkTS50y5ju4Zrp/1gIS2/MwMB1cRBMaTEVKGoaSyuLiZTu1rXEGTS9LTdZZIEGPFhZ5uW87DBpoEU/n4BXddCNgfT1GWfffI/mGy94yF+ut+cB/wbIXXbkgtFyin6tCnjtdrPLxLrSuMy5OlErKGQCZ7jK4Lyc+BvI3ASDco0jl48mq8tvDr6xpBgRYXZNtvpOJ2H0Bj/HZB+vvtkqtBgVSboK9+yxq3tVJFA34LmaWB9BbBU/mwhBeF/eTlZSyQrStLLcG+IE3RG3xjiZaZTwG8RDKUvsM7tVWm8wKJBRDxkNY4lJupRCyFA6Pur94xbJqxSIW7Wl8BOosU1o0Xiw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=25iuNGkOfwaaW2m3N/+uers7PBVRQYApFSIfVUIa9nE=;
 b=GEuZ8uJVSIVy3yhE5ZM137sWLTQkyEM8geTGZY1WuyAooCbMb7+WXnoK+Q8KFowgnfwnZ4270UECPV1/SLvdtQAv2IaJeAdQ2ftv69VKPPcpl545v3qIVYTRt5Ob5Xn/y9y7p3DP7bkumiZkVOmJxjK5IOSCzsBRtMgWzGhuJKM=
Received: from OSCPR01MB14315.jpnprd01.prod.outlook.com (2603:1096:604:39f::5)
 by TY4PR01MB13994.jpnprd01.prod.outlook.com (2603:1096:405:207::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.31; Tue, 24 Mar
 2026 11:23:09 +0000
Received: from OSCPR01MB14315.jpnprd01.prod.outlook.com
 ([fe80::66f:fac9:2ef6:9796]) by OSCPR01MB14315.jpnprd01.prod.outlook.com
 ([fe80::66f:fac9:2ef6:9796%4]) with mapi id 15.20.9723.030; Tue, 24 Mar 2026
 11:23:26 +0000
From: Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: Pavel Machek <pavel@nabladev.com>
CC: "cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>, Nobuhiro
 Iwamatsu <nobuhiro.iwamatsu.x90@mail.toshiba>, Biju Das
	<biju.das.jz@bp.renesas.com>
Subject: RE: [PATCH 6.12.y-cip 09/35] phy: renesas: rcar-gen3-usb2: Add
 support for RZ/T2H SoC
Thread-Topic: [PATCH 6.12.y-cip 09/35] phy: renesas: rcar-gen3-usb2: Add
 support for RZ/T2H SoC
Thread-Index: AQHcu26nkRhwKZdgt0WuRgaM9IfvtrW9iigw
Date: Tue, 24 Mar 2026 11:23:26 +0000
Message-ID: 
 <OSCPR01MB14315DE8E8AB843364604744FAA48A@OSCPR01MB14315.jpnprd01.prod.outlook.com>
References: <20260316145915.8580-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20260316145915.8580-10-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <acJV-Xq-2uq_JFMn@duo.ucw.cz>
In-Reply-To: <acJV-Xq-2uq_JFMn@duo.ucw.cz>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OSCPR01MB14315:EE_|TY4PR01MB13994:EE_
x-ms-office365-filtering-correlation-id: e795a190-81e7-4fbf-d263-08de8997c4e0
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: 
 BCL:0;ARA:13230040|1800799024|376014|366016|38070700021|56012099003|18002099003|22082099003;
x-microsoft-antispam-message-info: 
 Msxn1zYlGHcHbDvp1KZgdB370vncnl+FGkPptfwzWjaWpS12pLrrkqaUyfdmL5RGKJ0+kPIk6xp0SZo9QSgJ8zP24lnTO6evzsg29Z4HDh8aaOdhAr3/wBumpfCS7jBg1MFfx9kRUHh4TZ19WVviggQPawatcsWpaFEHKbvJVlK/BK4BWJDN9/1Tu5K9jHJxspl9GDOE9rkJooxGlPT3uLSLdojsIZcM34iFnZdGcP43HqiGQN9BAz64C3+1a8hkUUbJxw77ag3HqWpmFSbDRRDQPnhI9wNAeOphZ+thO/EbYyWMKpbGSNoOX8mkB0Ad/ny5T4jwKpXoxn0HKa32p8c2IAKeztrEcSN4CpRDddS84wSYAjv4Zi0M7U3v2PqwLIF38d6j6kbwPhHdBxerf0qT3DnF+0gnvVqLduqxbRZMUam7QvHsGwU0BB64Qcw3hQ5pLbtLmA289JaZjdU2+PQXiMr9qR32efSxPt4982KzuMyedyeKBAi9KybIrNL0Pt/+Zl+bFs5y8pOCBPAj1TcBwC9BnLYZks+7q0I+qY2kUGTX3pi9/tUb6sKPll5AInOXQ9jTteAdDRq3PggTxG5IBN1RjuhQozNrbX2nkrfIBfHIbnyxb5ZkSSJ/Zh+P0hFVKNeaTLvhIRDHKC0EKssdZYHpQXJ6X5XCFw9wcDPKZs/gHppq74kLuthtPottMHuVAnKvV2WvSWUFMx8A7wJtzqSdQiopIUA2zdf16woJ96oqucMVt3s3DH7VLJh4odwEvrwVKN0I82rV2yI19Lp0SvonN3RVhp+1nChM36Q=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OSCPR01MB14315.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(38070700021)(56012099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?us-ascii?Q?ITohgY+4CEqMGHODQ2QrCJ4RaLU/+FPuaoPL8KPVBziHHrDOxSSIp3SoYIRF?=
 =?us-ascii?Q?5vbQ/WdDt1/z64yv8n8b3qnB9sByS1QsnJEpMUHCPER1fha98IOML9a/DHgP?=
 =?us-ascii?Q?2iy13Cr+OJPnYQNuaBbhrZzwgSIUkVTVUv95IiIEt/i4i4CU11/Pl315r4Ex?=
 =?us-ascii?Q?j5BUl7w/OBWDSX8yt2xWP0pMIa6hRQFrv2zLDEC2446zSFYcpKdAH9LMxLqC?=
 =?us-ascii?Q?I1UF2oMSavbbDzQRJ8Lv1TKp8qWgLZAj25jYOzwgvnFaL9SIYNcB5G2pOR9V?=
 =?us-ascii?Q?ppd8DiGHNC10R3EyHonT5/xfvJP+peZV4TIDhS1KPWWJVrf2/mQJE4dLSEYd?=
 =?us-ascii?Q?21njh4kW125AKMK4AuICixqXqLAsS9LaYInX5FzWH1GS6IQ6M8yFzg7bL5nc?=
 =?us-ascii?Q?g5M6acmEEiobFxhFnXrtPuLR3OIzJ0luM/YNJy73+0oVOqvvbEXFOnH/wtvw?=
 =?us-ascii?Q?k2gc6w+J7Y7j0g1/Hylrg5P4Z5fTV3qEhuMfH+EDc/QCBSnJvtEZAELpT5FJ?=
 =?us-ascii?Q?mFMsBjqmr4g6CNxnZyMtVMNKteTCA90Jha1xUWO98eEgnCP2pNAK3Qs14pO+?=
 =?us-ascii?Q?LDXmoOgbFd6VXjruyz3oak4tEm9JY7g0rW/krL+is3g2i0rIlA/hyLHnzWi6?=
 =?us-ascii?Q?bqLn60W5mW2AOb/6Pe8ugwERzTxgnOBQ7YJVVuKfCSpxs3QtFXVgoeBgKabd?=
 =?us-ascii?Q?lIKOuJ+oLnSxzU8P4v0idYgGXM/zE4gT9rFavuaBCR9NAl4TAFJ2Y8r1HiUs?=
 =?us-ascii?Q?AQ3TqmpYT2yTyxRAxqjVe9T6j77KQr0iBkbJPpgSEKXSphS5Lsyfdlsc5dWF?=
 =?us-ascii?Q?7L6q2JthUy726pW02epmUB0UdfiP9XLiU2APvDPKmI/qcH8YTh2zCkK0/8UC?=
 =?us-ascii?Q?9h2ssb6hAaDlK5+sTzzgE58K2Yt6ClK8kmWxT3pjPmDI94IFXz41wmXJIjzz?=
 =?us-ascii?Q?894t2K0o4twnttDvWz/5GUA2vWx5SWnBd+QFV6lsTnNoWgicZKKk6GPpFdWZ?=
 =?us-ascii?Q?BYYIlfGZatW0VvTXF6WIaIY3N8wZUeHhwPOHnszjTs3dJQnNX3U9WFEdEiuZ?=
 =?us-ascii?Q?cT80l0NAFRfpNZdXltmrnEIvyIUwTxBcv6yN6lXrPHtbuc3fKRQfdGuPPpH5?=
 =?us-ascii?Q?YzqjDj8puqj1KptMcmDwNAvSdI0CPCGbyo78ykI3s6d3phnF65dyk+0KWCyU?=
 =?us-ascii?Q?brkHiSFrPIYB6y8oZps1vrJ68U3OO+2arWcGzBQD6lYD63K6s3hPVGOGDm2V?=
 =?us-ascii?Q?lz1++5PofnXwkBvLYKrPmrAnApbhT7MdNosczLc7OEdBJckcD/Ztm90dEPMy?=
 =?us-ascii?Q?7bsHO8Jw92/kx/gUbjTowJUosabfApij0JlfBP/sphma6a57Tv5ZpEC5jhnF?=
 =?us-ascii?Q?x0KpntVTfe0RMMrLeiPkZJjr0HfpaqAPw3aXEFwknHUTQSccU8/mJ91sKY2X?=
 =?us-ascii?Q?4EOd+EozzKjLSYKmsV/HdGGg5iuLHB08g2bgVHCmaKMNUGjVcx/ZKEycvol1?=
 =?us-ascii?Q?duXi+xhixOcUxZNnV6NjX2pnOhDWBRfZEt9yvfKVggwTgI0tkfNxBVRRNyMT?=
 =?us-ascii?Q?pR9cD0tZyu0Dr9QLlXV8il5ajQwnpOeDRTKjZASvUFzCQn6WqGcE721XpfdN?=
 =?us-ascii?Q?RakXkk4+ZKapRIyHfqT8gs/zwwkp1QVruOpZ0L7Rl7bCF0osjmEJnlk1Gsly?=
 =?us-ascii?Q?7Bpj53TtKlehKpBR0PXi1NErxO3em2Yxpq6wYY73mzApvq7XE1TwpHOXaUSC?=
 =?us-ascii?Q?fYbAMK8rdK/RakASiuYaBiGdxF72G9Yr/BMdweX02vLfR8rSa9/Q?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OSCPR01MB14315.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e795a190-81e7-4fbf-d263-08de8997c4e0
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Mar 2026 11:23:26.8792
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ECTtCDZlXaq1gBsRC0Vt7oYrvjpgdi02ERH3MeBxOY0Ggr7GKEdFBPrbdc12LFk+T/4m9fKb6MksC5XoKsA75ik8tK4s7+Nz4hvNnQR/vamCWPeAmWoTRun5EZ/06UH3
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY4PR01MB13994
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 24 Mar 2026 11:23:36 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/22547

Hi Pavel,

Thank you for the review.

> From: Pavel Machek <pavel@nabladev.com>
> Sent: 24 March 2026 09:15
> To: Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>
> Cc: cip-dev@lists.cip-project.org; Nobuhiro Iwamatsu
> <nobuhiro.iwamatsu.x90@mail.toshiba>; Pavel Machek <pavel@nabladev.com>;
> Biju Das <biju.das.jz@bp.renesas.com>
> Subject: Re: [PATCH 6.12.y-cip 09/35] phy: renesas: rcar-gen3-usb2: Add
> support for RZ/T2H SoC
>=20
> Hi!
>=20
> > +++ b/drivers/phy/renesas/phy-rcar-gen3-usb2.c
> > @@ -283,6 +294,16 @@ static void
> > rcar_gen3_init_from_a_peri_to_a_host(struct rcar_gen3_chan *ch)
> >
> >  static bool rcar_gen3_check_id(struct rcar_gen3_chan *ch)  {
> ...
> >  	if (!ch->uses_otg_pins)
> >  		return (ch->dr_mode =3D=3D USB_DR_MODE_HOST) ? false : true;
> >
>=20
> I see this is existing code, but I'd rather see "return ch->dr_mode !=3D
> USB_DR_MODE_HOST" here.
>
There is already a patch [0] for it upstream, I'll backport it.

=20
[0] https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/com=
mit/drivers/phy/renesas/phy-rcar-gen3-usb2.c?h=3Dnext-20260323&id=3De7ec351=
347b6325f872b9059453c9c9bf22c159c

Cheers,
Prabhakar

