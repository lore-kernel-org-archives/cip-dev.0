Return-Path: <biju.das.jz@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 828BC104BFFC
	for <webhook@archiver.kernel.org>; Wed, 11 Mar 2026 10:43:48 +0000 (UTC)
Received: from OS0P286CU011.outbound.protection.outlook.com (OS0P286CU011.outbound.protection.outlook.com [52.101.228.65])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.18233.1773225827287417072
 for <cip-dev@lists.cip-project.org>;
 Wed, 11 Mar 2026 03:43:48 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@bp.renesas.com header.s=selector1 header.b=bewI3VgK;
 spf=pass (domain: bp.renesas.com, ip: 52.101.228.65, mailfrom: biju.das.jz@bp.renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lpLURJSP5JhLOlQkzgakdJ0/mun3wPhABBnvGuFNKuVPnrHDypuma8zrKk5yPSLH0Mu6ZTu7GlSoI+DUoDoJEb4tzY4JVYrMRTWll4AL60BZZr4jl6egdPzzh6VCnCq7+o/tvKieIM1fSyUg3gCauW5rKa2xaanWFzWxY46shyllD6dJnN1YP3Pn9kKcVFEWPUHOJ9TGOh+fvzv1TdUW1ni/VEBJYpJFrbWsaDSrqN5yOQ3xXV9uYwtLs1fSlUnJTBR9mzyB4dLr8e+l4SXQnFgD1LxBww3W8dyVsrxvb9FKBIVNWQipnk1GIPg8AFFJ4DGF7jfmLORnyz3H0LPe3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EOctwqCH/mn+TJ7vlC5gokf8JsZ7kz+X+30fICOzhPY=;
 b=TdxWVg8iEdCG4Gyp64inTKcJOTePvaTAfiOAX9BigYzbvHm4l4RN5yW1+baodAZCllswYCg7LrPRjSgY9gYa9113VNpmsdJx2vsop6X+8o79p14RgCvN6muUOqKI6II23bMY74fNeVmOCiKxBDkJLpLJ9Qap+MEsmLmD0JCgk71x1qB1XNcCSKEzVB4PjJLn15nSAprPGhK9woIgLgaBVqSnV2K473UGtJFWaNjL6IgRbFADQaP6Tb3TqrR/dpVtNhZL8hY6r66j8BKkyQTLYP29C/koltURYllMwImaEj0ZkL8e8J0w5G35V8Kp0XJl0jzFvyRWqe5ffF3d12DKFg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EOctwqCH/mn+TJ7vlC5gokf8JsZ7kz+X+30fICOzhPY=;
 b=bewI3VgKenf/0SZTEe5j4s0GP699ZWtYPEJZctdmfhYoMTjkJixugL9wIt3EwzFKneCqozM2GcmHGZQ3Vp8Ca5QpGeEahTpmy8SdpL4Xbv7O6G+D2xJTi8ndEgn4TfiNqg90evqH/a5kNsPRYq6VTGO0ePOlkgycrYr96RzdaiA=
Received: from TY3PR01MB11346.jpnprd01.prod.outlook.com (2603:1096:400:3d0::7)
 by TYCPR01MB10382.jpnprd01.prod.outlook.com (2603:1096:400:242::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.11; Wed, 11 Mar
 2026 10:43:42 +0000
Received: from TY3PR01MB11346.jpnprd01.prod.outlook.com
 ([fe80::87d1:4928:d55:97de]) by TY3PR01MB11346.jpnprd01.prod.outlook.com
 ([fe80::87d1:4928:d55:97de%4]) with mapi id 15.20.9700.010; Wed, 11 Mar 2026
 10:43:42 +0000
From: Biju Das <biju.das.jz@bp.renesas.com>
To: Pavel Machek <pavel@nabladev.com>
CC: biju.das.au <biju.das.au@gmail.com>, "cip-dev@lists.cip-project.org"
	<cip-dev@lists.cip-project.org>, Nobuhiro Iwamatsu
	<nobuhiro.iwamatsu.x90@mail.toshiba>, Prabhakar Mahadev Lad
	<prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: RE: [PATCH 6.12.y-cip 10/29] serial: rsci: Add set_rtrg() callback
Thread-Topic: [PATCH 6.12.y-cip 10/29] serial: rsci: Add set_rtrg() callback
Thread-Index: AQHcr9CnN28eZKG0bUGyU31Q6/6sPrWn78uggAE2ugCAAADFgA==
Date: Wed, 11 Mar 2026 10:43:42 +0000
Message-ID: 
 <TY3PR01MB113464EBC2C99FED016101FA18647A@TY3PR01MB11346.jpnprd01.prod.outlook.com>
References: <20260309142549.987737-1-biju.das.jz@bp.renesas.com>
 <20260309142549.987737-11-biju.das.jz@bp.renesas.com>
 <TYCPR01MB113328C3D06959DBB94D6BC118646A@TYCPR01MB11332.jpnprd01.prod.outlook.com>
 <abFF8BSjpvnrXaaV@duo.ucw.cz>
In-Reply-To: <abFF8BSjpvnrXaaV@duo.ucw.cz>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY3PR01MB11346:EE_|TYCPR01MB10382:EE_
x-ms-office365-filtering-correlation-id: e0c17ded-950a-4a14-861f-08de7f5b1033
x-ld-processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: 
 BCL:0;ARA:13230040|1800799024|376014|366016|38070700021|56012099003|18002099003|22082099003;
x-microsoft-antispam-message-info: 
 yFhwIiRtARiZxY9v6mJRLj08c5rxX2hi56yretsWxZpaXZsHGHMAEu9sC3+Up6AmWz5PzqYrZbe3/CYBjY3TNBvGJemefmWXwpEYhurACKrRtCeOG17x9zIstHGpXcSKXZHWLqlf84H5WmJOKz+zaeft7XOLtRn/nQMbDIrLiYDQK1Wg9Y6G58g9884AD/PmAywLTRA3NvCJpTEGlsKf2BmvXUaMNAs97PwrjDU+prIAp0dQ4xv+J8k/ZBO+onoSUE4Sy2rmzJ6+uP0L9OQuJNfUADPeP+HgkEIqQCYA/l/3D3ou/k+iXyWS/mpkMmGcNOmV8097aUzQAj6W1u3inmHJ5aCsZIaWhiAAeJoDr60Fr3+uqVa9CDQ2qCSURJnm+58AJavY8yGWHHEjnmmsGDoRGiSTfeio1gknw9He0CvKauetHNDIQvwlKuOJASP/4Hnult5c3Up9EeHILE9cfZLhSsUN9TcjFydSOvorBx2MtfL9JDrOyZ8TAZZRXY9hmb8NKcYeXGdIy3hwsBHCInQJyXcymM5cVFv4e0siKPMUwu+EQQpYUp6iulcv2ojOora+e1AzNST3I0QMCw4/h2Bu6emaj+PoH+jSKIUhQKPA33yR9StUY47XRBIEt4hQaXCXNii8Ia/MiBBOkq3bZtnwHiIIxVhFSbeM4RHLyeIeBo8+Q/lvO5z2H5z1lF0q2FlTyQSrM+v4OPDOkeM14f51qTNN0KLN08w5Y9t+LGreKtaGzv9guu56gACKn9zIpOkqN5J3E9s8EoUBYIqq800uIMbDU7aZ1uwrWGM7ypo=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY3PR01MB11346.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(38070700021)(56012099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?us-ascii?Q?MzcP/g/qd6b740A0r/yO5xuS/7JIPn7/1xOPLMKE29QRnfF42oRMYKHIqdt4?=
 =?us-ascii?Q?VtgH5i0HoKpsSHqyC/arIkOpAEeOCnpm6Ojp4rzyUDsrSOB8pNypjmP+/L2u?=
 =?us-ascii?Q?tpFEqpY13nY2s+Neon9RwNMlD644gzpVnB5xIdBS405IDZJRSWULXYqKI9ze?=
 =?us-ascii?Q?Rvg+950flBFqupHG/gUf4nlfsuXs/K0zYCgkefOYSJhRZmuAni4FLMXU3mQY?=
 =?us-ascii?Q?z0KCHBKXb1CGHw8LiElwzMXYjspSN3egjSoLdHWe4dAoK4CnL9bW67t5Z4df?=
 =?us-ascii?Q?Ifb571+9kqLC/od1VW2mNp5VH5yv4bp5uqF0c71wkrooQxg4CskP8MSmtlj4?=
 =?us-ascii?Q?dbWn8VtM2T285ao5Bf1Cy7WdyDessrrL+zAmdxm5B3ASDGhsQ4EO3pp0bTfc?=
 =?us-ascii?Q?qA+1WhgWkyAH4gLC1X7UaILv1lp09B/O64FaEO2aGR7gJug5/rn3v3BMz8ul?=
 =?us-ascii?Q?0ZO0fkewcGqqoSCHRNHc2qQ5zbwe3Ct9IH4J85vv4VnrF+q/BSDXIgBTEQAl?=
 =?us-ascii?Q?V8+8k5heOFMUqpWqFc9xhrUqv0u8MVe3AACF0AOhczC8eq1gf6/bsMFptKgL?=
 =?us-ascii?Q?BcEuBO6Z6ywvRLkLZQyBNDaROHfLXjNf4SC1SY1IiE7xpVHobdEF5xflDrqn?=
 =?us-ascii?Q?KbHXWw/YY0LcwBp6uub5FIQGXJgdkD6qNi1u4wRj8MjWcbocDizzwk7SeMVe?=
 =?us-ascii?Q?Pyk5/cXJPQDYimVY7hoKA2gQrjo9/UQWxc2tuCWSJL1xMkZx//O6nTJ9Kp6l?=
 =?us-ascii?Q?VMJA+fs4jNrQ5xtbaypr86IxXsagHt2GSS6R79xaywvYBmdv+Nno0wyWY5A3?=
 =?us-ascii?Q?8aOfVZSwY6QPzGjfY2SyAWCU1h50crzZ+uiWmhfKXtecH45R2Xmj44xILb9i?=
 =?us-ascii?Q?ShyFNSU5OhH56tSY7agzNALtx3A+f2mgYDSoDPBENuPutcZxI97bmMnl078e?=
 =?us-ascii?Q?Vf9ZILfG4ZmU/VbLRRQr4TLizFidA3DzjrLWPY0GwdxBtDhPO59xuqly3bYG?=
 =?us-ascii?Q?qc6/TiWmkGB/8RKwO3dhXK5jXKJkIHpYA7Zsueg4hjarlE6a6U8oRQlwVHPd?=
 =?us-ascii?Q?HqHTTmKIolFK/VQMrUvs7ipo+7H6cHQdojNBzcc+OZxYb7vQ9iU03V2gcmI+?=
 =?us-ascii?Q?kLM0RKgv9E2ZPZMjQMGxq8jc9moWYU+yhaqfCtAhA9quhRjn5V4liSWkyHe1?=
 =?us-ascii?Q?R9pbQhW5A19lyoVwX4OLMDTiFemYy5RgzzbcdL8K1OOvfA0A51pN4P5LQluf?=
 =?us-ascii?Q?QW7z4JyKUESY63GMRu9yrVkc+FKT6ZPKodmAmCCprMXZLNgviIf5wRre2Fvy?=
 =?us-ascii?Q?vRd+cG04jayFh7dou/0AXru00R5j1U/I6nIVPZiRHD+3ROI7oGsxTlkb+n7/?=
 =?us-ascii?Q?eWceDgVu/JY3wVpfmtr+iiRFRmg7xuVKyLO2JNZd24vuXmFl0vfxq0iq+tRy?=
 =?us-ascii?Q?gCjUprXXK2pn+zT99v2Suj5sphu0ABoW7HA1C+BaA+4FpV50DFDXsUW66TyL?=
 =?us-ascii?Q?K79PEUaR4sUilYyBC7wo+RUbe6UAsoxbtQv35L2ECayz+M6UlWSbSCZQgBED?=
 =?us-ascii?Q?vPz4ud1yc6x7FCioSiHVg19x58h+c8Nuyev1M28AqO/qkPaBIOOJPzpdWS0W?=
 =?us-ascii?Q?CcTImRZXKBql3pDHvn8Qf48AmyeX4S/41WBOJSTCx81LjvKvf8vD90z5pC43?=
 =?us-ascii?Q?Q7d3Q/DU+kNudMXmOHwp1HnycBrbdgbcpVIUuh8S/flOHYnX11YLqei0wUQ5?=
 =?us-ascii?Q?93DXnNclgg=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY3PR01MB11346.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e0c17ded-950a-4a14-861f-08de7f5b1033
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Mar 2026 10:43:42.3362
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 4PhlTiZ652pcO8F0J2vorn11oOM5yLUr81R7vaZI2Mbdn8nvpEjtXtLQ7LO4NJUEfnqviFXtSH4wG5Y8qU3mv/REn+fmV7kaMjWcbZ6/jQY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCPR01MB10382
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 11 Mar 2026 10:43:48 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/22278

Hi Pavel,

Thanks for the feedback.

> -----Original Message-----
> From: Pavel Machek <pavel@nabladev.com>
> Sent: 11 March 2026 10:38
> Subject: Re: [PATCH 6.12.y-cip 10/29] serial: rsci: Add set_rtrg() callba=
ck
>=20
> Hi!
>=20
> > > +	fcr &=3D ~FCR_RTRG4_0;
> > > +	fcr |=3D field_prep(FCR_RTRG4_0, rx_trig);
> >
> > field_prep is not present on 6.12, later patch#29 convert it to
> > PREP_MODIFY
> >
> > I will send v2, squashing this patch with patch#29.
>=20
> Thank you.
>=20
> For the record, just noting the fact and keeping the patches would likely=
 be acceptable solution, too,
> as would be backporting
> field_prep() stuff.

OK, Noted. I believe backporting field_prep() is not trivial as it touches =
lot of vendor files.
One of our team member already tried.

Cheers,
Biju

