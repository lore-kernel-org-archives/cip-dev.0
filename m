Return-Path: <prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47FC9E9A774
	for <webhook@archiver.kernel.org>; Tue, 24 Mar 2026 11:26:46 +0000 (UTC)
Received: from TYVP286CU001.outbound.protection.outlook.com (TYVP286CU001.outbound.protection.outlook.com [52.101.125.71])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.17598.1774351598070227126
 for <cip-dev@lists.cip-project.org>;
 Tue, 24 Mar 2026 04:26:38 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@bp.renesas.com header.s=selector1 header.b=UVdRooCs;
 spf=pass (domain: bp.renesas.com, ip: 52.101.125.71, mailfrom: prabhakar.mahadev-lad.rj@bp.renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gAFZpGEAGi2iaJr+guT70XGF/IuQ0FSoRw0G8Fz7ByVSw79dW2eniE6YsYGo9wU5znyJ7buvAKAlaztzLmvdK5+EhKSkRcxFA3YHxAVOWQ/wTkqXdV77hJB9Vx61ixJL+lbzLUbvw6SVulGXfmq43UpHaU/+ihHbRcdkFpKwPFCw5FrKsskQQW8YbxMBj2KQ1QXFZLzXf/DM14S42cJziTmQEvq/djpUDoaqzgJ1XwogjyXIJhjawPn4uB2Ykb688IhJ3t2dOJNBzPG6864Umy2XT0EStE8a4+OEdvAJiCBsEiQ8vwQdiDRlS1ixRxi5CiEGuRE5vTBqBDtGIUqdGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9vjMLJMKB7bdeHMpQg+WA/KrBNN0ZpULZrOrA742AGA=;
 b=IB8lnYQ6JahAHzq+Uvvso8O8VqVrwy7cORdSG+hYvtyz4fTLAxtxvTFMIUSL3BJAnZ/E69PsEoeJXMl8es6+6cc7y1/1uwMOvUqAdN/sDeyk4a17VX66MgFA4JmKTb8vc+bw4EfO+6beUqC8SH0IIv4v86PTh3JURa3eEh9DCZjwPogGYJGtz7dxf6v8Kx61Q9BUpJysuAo1UTN9oeAeJnhMN9ksx5EiqIfPlzZapaOUYSHt/rN4QuFVF6BlvEFbDFX2AwcNXJnQsNT0bkpXDVhTELUk2YhrDBVVVIWlPgO6w9P4VUXIh4yrK82PBPmgv8vmZ6cU0PmixkvG+bS1iw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9vjMLJMKB7bdeHMpQg+WA/KrBNN0ZpULZrOrA742AGA=;
 b=UVdRooCsqlDcj2PTL0kWG/tkIhcf9m5SqVW7NdpOVqso3tlkant6dS65nikhKbSQ4ygFNK7d5CrwFrUBYUkW2F18PteCancZE02fFLRtqIzO6HFBsfZvuYqxf6r07TboZn79qKX1EcSWLD1vs+B3zUr/2zTjeoZQQ8gmOIn/gzY=
Received: from OSCPR01MB14315.jpnprd01.prod.outlook.com (2603:1096:604:39f::5)
 by TY4PR01MB13994.jpnprd01.prod.outlook.com (2603:1096:405:207::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.31; Tue, 24 Mar
 2026 11:26:17 +0000
Received: from OSCPR01MB14315.jpnprd01.prod.outlook.com
 ([fe80::66f:fac9:2ef6:9796]) by OSCPR01MB14315.jpnprd01.prod.outlook.com
 ([fe80::66f:fac9:2ef6:9796%4]) with mapi id 15.20.9723.030; Tue, 24 Mar 2026
 11:26:35 +0000
From: Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: Pavel Machek <pavel@nabladev.com>
CC: "cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>, Nobuhiro
 Iwamatsu <nobuhiro.iwamatsu.x90@mail.toshiba>, Biju Das
	<biju.das.jz@bp.renesas.com>
Subject: RE: [PATCH 6.12.y-cip 28/35] net: pcs: rzn1-miic: Add per-SoC control
 for MIIC register unlock/lock
Thread-Topic: [PATCH 6.12.y-cip 28/35] net: pcs: rzn1-miic: Add per-SoC
 control for MIIC register unlock/lock
Thread-Index: AQHcu2+nwT0kOnKotEu3KwNuUeB967W9iuOw
Date: Tue, 24 Mar 2026 11:26:35 +0000
Message-ID: 
 <OSCPR01MB14315CDB4200A0F2794DCB909AA48A@OSCPR01MB14315.jpnprd01.prod.outlook.com>
References: <20260316145915.8580-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20260316145915.8580-29-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <acJXqPomd7I20YO7@duo.ucw.cz>
In-Reply-To: <acJXqPomd7I20YO7@duo.ucw.cz>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OSCPR01MB14315:EE_|TY4PR01MB13994:EE_
x-ms-office365-filtering-correlation-id: fe936096-aa39-4394-32c6-08de8998352d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: 
 BCL:0;ARA:13230040|1800799024|376014|366016|38070700021|56012099003|18002099003|22082099003;
x-microsoft-antispam-message-info: 
 2JyxR76Ru3vzvQTsseOQNf9UgVsPV8+XJd/DDBRNPHNiDlWNlzII/KWEnH9yt37LtSBFQh92HBLuupANmBP/47Te3ZQfbM9iddXiPTZpYsP9TL8e/7VILGf2PQYGnqGZDiZlwLQaavTrsJgH8cc0qZ9lCX3Tffh1fbamanhIY4nxZq2rEDD31bRglkz1SrPIUyvcieDtAxivHsuSuieT0eXQAKaz1S1mj2EeT3DV0LnnA7TkBLHALvbxlTFKLn04b4ZaEkjSP0UQnZnIqVZRAqpljE+4nVxtpefg8kn0jaFP4hAdYMMQWw7qYQOacdUL+/ocnd3sGZopmYAfrGDN3vFspJGh9S723BreyIL+68Aj1aNAhZJqVjSvvIY+IRiD37rx0a9Pex+2ZtpgxLb8a8BmFBBvzBwj3j5/qRrh7Ut3xR3QR2lv89hewKSCB9NzIkWVZyb78177hBns3Qnzl6XAOeWdYHyVi4LIfPzkUg+3S73ROT536pCcG7JzrxfzP4ryTK4W3jSQmr9F4QOZqYsIcaUGqhgjNzgTEIdQ4wiM5dIwpjJ0JpMipRcfqes3gEmJvNCQwEgTl7yumkq5ucFeSalLLL26IvpCFuzKUtLTbw/ZsLmcLChthQSQ+vzxEKMCI8dIx6hEeh/aB1PKy9+NzPMO2Esp3cFEQuIaq2OuKN6banUqnu0VR7Rec+vnx5fYuCQQUJuPrGOiyytteT5I7qXrhVrC2SW0Y+a3NqTWWEnvinIBpvb4tO85EA6RBPD3oOGq5gqTUKoqVwYkYofgpHOTH4X4zJyoTPqRagE=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OSCPR01MB14315.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(38070700021)(56012099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?us-ascii?Q?1+zBIQV5a9MuIEVHK/sKiTi98NVYhXbcVCColrgs8VPUESi4w4uBC4yrLj2O?=
 =?us-ascii?Q?yFH6DSDg1YvBlBI3hisA3QGQBz1CmylpA/9EW/ZPZPmiZs5f1xdXrwwpajxl?=
 =?us-ascii?Q?CIOxQ85ocOM2tVh6l8tNLZd0X47+8xa8vVY00PTu8Fm2hVYD0JnD16kM8ZNS?=
 =?us-ascii?Q?6Ak7YBHyIaNB9pljGLn0FumQgpITAzVQM15RwkO+wOiqn4nAYSTw4qWPm4fu?=
 =?us-ascii?Q?ScfAtTOweze9U8b4aHLcFemlVwmKbUPsNL3P0+ukgOx7O6l1n6VnujlR3NNh?=
 =?us-ascii?Q?Z2Xv/tJUjqRabsFZQpM5RnKWJHdfblRxPh5fOsJrYUBC5qHb/rOmmMQwKOz0?=
 =?us-ascii?Q?RaAKSCOQiILqkvU+gwDIPAu5mnT3fTLigE23CuGchOEgCDbgDEWllmJKDpDp?=
 =?us-ascii?Q?pUJtvMJgWea1+qe1EaekDDfB8rnWsILnHd0qXB2hTyQlrD/4nV2rXGxBjzs7?=
 =?us-ascii?Q?rVlKF9X/uS0paX2c9PImEwT3PFKuYFCIEb7kzYI74GDcanFhlziTaVcIU+Bq?=
 =?us-ascii?Q?W1Os0dRDsOu+0K+nROqNcN7cbETFHKrxhwDdJlXzAyF55ahAyJr8MeiZB283?=
 =?us-ascii?Q?bMDc2LEipMzXY0VzDEM6TVOIi8QinsQs1Te9LgddXL/Yh538MeRP71rsyqQQ?=
 =?us-ascii?Q?3n4NILol4+QYWoRBzMQD7GO5nLNiB1unSLrUSDkL+J1ciSGvJv5vfiwUmYLo?=
 =?us-ascii?Q?vq9OkcJu2ct0p+HQYDJxy7wsixkadQ53do5uSOqUzNuNT7xmxbamfWKwrReL?=
 =?us-ascii?Q?ykEE++Wg69zz4/A6g+dLoF1TnxpPX8w2cZxPYsfhhAi70NLaltLz7SkzlSqq?=
 =?us-ascii?Q?JUIV4FVzJDa15FzWkNTBZpxB5fJF4qy4v9ZZKBP7AyfMFXRBnkkLFZ68qhfa?=
 =?us-ascii?Q?rKQ2v+bi6baulQ5+WHI70RbOZ+aMg6Vx56EJJHXSpqWTND8v+7jmvd8mtqZp?=
 =?us-ascii?Q?yT0fFDilg5gPPseCv8dvZbDq7OpFZ40d7E9kKiCjv84PclEDLG07hawnfrWw?=
 =?us-ascii?Q?7PfxyfMvBXpnJ8p6ZWYsDFCNUbomEzRdA4cKUuQ6Xr+nj26exmJFlqA+4O23?=
 =?us-ascii?Q?ZY96kLpGYhXga935+24MjCJ4ZRpl7CF26Zt5ep3n1NDXan4aoDIEiOXlnY84?=
 =?us-ascii?Q?EuD2Bu3x/Va9CQnkxTvOzZxaCzcYjcvA61As8zZd7bpaceIVxYQ9uxB7mb8p?=
 =?us-ascii?Q?dHg5EC7z6SKj47EEVATuq4Q/sWRM4MD6Dp2n/HQRkWgDcsA+tRanF9VjVn1A?=
 =?us-ascii?Q?daakvIsNKrOOybB1un8V1XtEruUaPQVa9KwJfu5yLe5mwh73QIol613AwMVG?=
 =?us-ascii?Q?l2OWC2AmyAS5yCYJXC8wbcVWxmwjjehl1FRoWHE5IljCwgPGZ+cuWRQ/u7Ty?=
 =?us-ascii?Q?MBmhN86ohyuMUqqJdaJLzmZmRG8056KcI8tGC+qMkdJrzZQF4WpZXjWGdVVd?=
 =?us-ascii?Q?sLfKLWOj+eh2IpE8oCPbu2Q7MVKkY+mXmUmiPcLyHhAiEI7v5ZmGFvGCJlNS?=
 =?us-ascii?Q?JVIeaBgq5WbHzqRR40uu99Gg8/tt36TLCQYetsrOkq7icRObZz91cbyOzK+T?=
 =?us-ascii?Q?4yfft3xTQrpfmx+CSKXWxWqH1inB2kZvtpx7o2uvDQZECFwPDSc1r0+CtN3/?=
 =?us-ascii?Q?C9M/4TqzC4oGlvHyTqDd1I147awEc99sxf7pdX7HGlVatrC74iywMHsBvxAe?=
 =?us-ascii?Q?9YwezvnJWn+l3hRW/d2ysFkeLONq0IW/0vXEeN1F09EsViWlewib0degKPva?=
 =?us-ascii?Q?l2j5qjsZMBCDkK9KTxPdyBSa0FeFJqrP0TM8jwSWnUvkzLILPmE3?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OSCPR01MB14315.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fe936096-aa39-4394-32c6-08de8998352d
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Mar 2026 11:26:35.3260
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: jl1YxNtszqr7hJ+NthZVazonECrghLbeBNkrwaq4ixkrH9w6FCpdIDNrWP5Fssbcwth3dBlXmsGVoYDe63fq5dkJmctkx/ovf/nrIcMwdF+MDq8zs0DHzgIbEOdl6wij
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY4PR01MB13994
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 24 Mar 2026 11:26:46 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/22550

Hi Pavel,

Thank you for the review.

> -----Original Message-----
> From: Pavel Machek <pavel@nabladev.com>
> Sent: 24 March 2026 09:22
> To: Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>
> Cc: cip-dev@lists.cip-project.org; Nobuhiro Iwamatsu
> <nobuhiro.iwamatsu.x90@mail.toshiba>; Pavel Machek <pavel@nabladev.com>;
> Biju Das <biju.das.jz@bp.renesas.com>
> Subject: Re: [PATCH 6.12.y-cip 28/35] net: pcs: rzn1-miic: Add per-SoC
> control for MIIC register unlock/lock
>=20
> Hi!
>=20
> One more nitpick.
>=20
> > index 765d6ca4e4ca..d8ba1164c886 100644
> > --- a/drivers/net/pcs/pcs-rzn1-miic.c
> > +++ b/drivers/net/pcs/pcs-rzn1-miic.c
> > @@ -155,6 +155,9 @@ struct miic {
> >   * @sw_mode_mask: Switch mode mask
> >   * @reset_ids: Reset names array
> >   * @reset_count: Number of entries in the reset_ids array
> > + * @init_unlock_lock_regs: Flag to indicate if registers need to be
> > + unlocked
> > + *  before access.
> > + * @miic_write: Function pointer to write a value to a MIIC register
>=20
> I'd expect either all of sentences to have "." at the end, or none of
> them.
>=20
Agreed.

Cheers,
Prabhakar

