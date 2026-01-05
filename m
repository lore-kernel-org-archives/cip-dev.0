Return-Path: <prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5FF8C79F9C
	for <webhook@archiver.kernel.org>; Mon,  5 Jan 2026 14:12:11 +0000 (UTC)
Received: from TYVP286CU001.outbound.protection.outlook.com (TYVP286CU001.outbound.protection.outlook.com [52.101.125.46])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.64571.1767622327140483438
 for <cip-dev@lists.cip-project.org>;
 Mon, 05 Jan 2026 06:12:07 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@bp.renesas.com header.s=selector1 header.b=GjTpNk/7;
 spf=pass (domain: bp.renesas.com, ip: 52.101.125.46, mailfrom: prabhakar.mahadev-lad.rj@bp.renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RbiNxZWOF95Vpv6Wv9XPOttp7+yZcKfNYGHokTJxleRhwclIF3YcmE6YSoPp/kEBumpQblPRTgUsgmFihXfmidcagZJHxzPYmK6sRvEKr8YdHbH0mxXBZS259pJ15N9+R050zwNABvSDN7kQvG1uthI2Ihukh+GMCia/EPOYz2loLoWYSYHzgPTa9lIa8HiVXcOGHSkdMNpalRxhGlc+dbGT2XfBBzezJQQm8GUlGfi0GEH+mycUGciBdawd8ZTvjLG6J/gXt9rZgQvMWL82A2+r2SsUBdH59rntoujNHrwHJDMB83cD8x4qBb8wI95pQkMT6E8XdrH3N5AOHQfKIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cfK2fO3zn/LO5grBAYQq0UKAUOoZVzGsxkTBImFEz6c=;
 b=ieTVBS+08VKovn0VtwsFuONnyhQyiFp18VJAVCVyoAwuZys8CGlMdKTuBh1xAeQ6TdWZw2zwNFQyorOBrisZQvuCcMmr+LQ10X7BUzbbAIz/687V4aahtxYm9kFoNiML7IWDtlrIrmRojgrMH+ER15ztC9Avl4AxPrs8LTgSydhzkBZHNOS+vddd1Ot/kHnaOnUrao8S9SJGtK904a535/GIGRPHE+ms3pWhWjFGr4wY0WqHO9Jyc/30Toxk59ZmNr22lOayBhs82wCK4/y3ETh29hSHkADJUkAZZn1M/OdgeULqmui6XLs0y7YgafL0Rwm1sPGi51+LfUQCIWqKBA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cfK2fO3zn/LO5grBAYQq0UKAUOoZVzGsxkTBImFEz6c=;
 b=GjTpNk/7bvY5HXU/PToz7/0e49+939NgxvasPedLUnjOjvnCvXlKfRVXCKSwh53LYjvioim5ImrAOIwxQEd42y3mNSZHHytcf/jNH7KbuHVqtd3Wh6BEWrHlLFfNxjIO9o5sXlyYGSRj9Yzk9GJVoOp8NSi2SxF0Erov/BBoZxg=
Received: from OSZPR01MB7019.jpnprd01.prod.outlook.com (2603:1096:604:13c::8)
 by TYCPR01MB6717.jpnprd01.prod.outlook.com (2603:1096:400:9e::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.1; Mon, 5 Jan
 2026 14:12:04 +0000
Received: from OSZPR01MB7019.jpnprd01.prod.outlook.com
 ([fe80::8a27:ee0d:d7a4:9d10]) by OSZPR01MB7019.jpnprd01.prod.outlook.com
 ([fe80::8a27:ee0d:d7a4:9d10%2]) with mapi id 15.20.9499.001; Mon, 5 Jan 2026
 14:12:04 +0000
From: Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: Pavel Machek <pavel@nabladev.com>
CC: "cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>, Nobuhiro
 Iwamatsu <nobuhiro.iwamatsu.x90@mail.toshiba>, Biju Das
	<biju.das.jz@bp.renesas.com>
Subject: RE: [PATCH 6.12.y-cip 16/17] arm64: dts: renesas:
 r9a09g087m44-rzt2h-evk: Enable I2C0 and I2C1 support
Thread-Topic: [PATCH 6.12.y-cip 16/17] arm64: dts: renesas:
 r9a09g087m44-rzt2h-evk: Enable I2C0 and I2C1 support
Thread-Index: AQHcfjiYojAfuPqzY0et5OGOe5lembVDnckg
Date: Mon, 5 Jan 2026 14:12:04 +0000
Message-ID: 
 <OSZPR01MB70193CF80AFD37A90EDBD25CAA86A@OSZPR01MB7019.jpnprd01.prod.outlook.com>
References: <20251229223911.8663-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20251229223911.8663-17-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <aVuj+prm0lgQdFQz@duo.ucw.cz>
In-Reply-To: <aVuj+prm0lgQdFQz@duo.ucw.cz>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OSZPR01MB7019:EE_|TYCPR01MB6717:EE_
x-ms-office365-filtering-correlation-id: fc4ea8d4-9a40-4a8d-65f2-08de4c64675d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|366016|1800799024|38070700021;
x-microsoft-antispam-message-info: 
 =?us-ascii?Q?dct9I4wyA76o5AerV/aTYXkuCqz0++EuaGs2wekjloDCdFZPZS/Xw9MnamkV?=
 =?us-ascii?Q?GNfI31wfQE2Bdz4I7G3qYZI9yKbJMkkyI/gbXjLy1v/7F9nPoP0jScaWOsjT?=
 =?us-ascii?Q?9Kb6JzK1QZo4kjNwNbfyV1frqmALGkJc/EMtb+KHKuRw26/XKMIgqzA6Cq9t?=
 =?us-ascii?Q?enbC0cvhWxM0jIuBn5etCtUjumX7Qsns0b8lD1wMzfEoV3hKqQu2aDzpdPil?=
 =?us-ascii?Q?KIyqhziCC0O9SdApciE1/2jmVFlcGNNIeWwgBpJkAIbyFdAefEyGmseJJXrX?=
 =?us-ascii?Q?fX3AjtgCNs8OgYp6klBfp0rLlDvjaOPo7OJR+rBqXjgSz97IK4VWwOD/QIRL?=
 =?us-ascii?Q?rBdmXvZCVCwnYSUo7OVu7teYIVMXPnEgjJz14uk0BKMFkd2ltEpghg4KFDgl?=
 =?us-ascii?Q?UjE5/WeGBkGbvR17XUNLTbWxP7SXaAFyHZmHDNslOtE5NzGjx+8XmCzIEdAF?=
 =?us-ascii?Q?/fnbwGjffsV/icDhdrWvK84GJxaUdfnSBOLopbMz8DtibljCK7qrZrBRb/F8?=
 =?us-ascii?Q?lk1XOmEp+nlgk0L65me6bkwo0KhvXfLzYn9IpuKE79GsdnVAyQlDmq4uJWCR?=
 =?us-ascii?Q?48DUpeVbLWqjGuHHTFHhm3GZR7ugBsWJFydKPHk6cgGJL8r1fIvBjVtwERUv?=
 =?us-ascii?Q?hNCVEbAMc495NdxplfOMbbiBNKH2NsI9jy1Qvg9ZhQrcxX4K5nF2fIVx9AjN?=
 =?us-ascii?Q?2hVBNLXP84lrE/OUOMMPCULd2L7uNMTGLb/7UhwzD/WtXvfiN1LnKZNzxdjs?=
 =?us-ascii?Q?aJJu0cFobVYsYCUf7BOQuIg+PLDNw3Mzg8jCDq6hEdvyMxAro70/eLyTWADN?=
 =?us-ascii?Q?yUWB1CwRLZ9LvrmdvlZf4auWeBvW+iCotjvySv/Xf4kV9Gtf2TD9u/z6j3rF?=
 =?us-ascii?Q?zkO/jrXuRHIG+b7OGHX3nqeXWCpOnN+bpzNcGA+/Ldu2K3cGfMLKjz5JlZ7Z?=
 =?us-ascii?Q?UaCOoVsxgC1cYFls7jMom2i8qT/2dNOtNDJiQYc/2P0Fta9wSwtnGpo/ZtzW?=
 =?us-ascii?Q?KlDc645mCPm8ghASocrWtxu4HI4o6gmMLXBmLNnS7VWHBFBOeFceMzfQPit5?=
 =?us-ascii?Q?oCfV6Ew95hyWHQdNaaEwKUipj/6exh8w0V4CAGnDob+HtyiDqicWOnDO/U/j?=
 =?us-ascii?Q?efdM4mWrLk6t4NvWBIu7NeS1Fn6rGjND1SNF5x+vP5kvGDHTU6n6svRxlDeh?=
 =?us-ascii?Q?nX0CdsmHZqGDQk+blAoLRlwAHRxC9p72inz4azZhSLZJ5BvKWDUz+JmLsbPQ?=
 =?us-ascii?Q?uKO+tXuNjVpMYrLQVXOKpiFm4oUYDu50rK3Hlfiprw8TtuHdqR/Hoku6bRDR?=
 =?us-ascii?Q?wT3m68uK+xo44CzK9BGjUTXi5DFNfueisjlubzpCiQqNH6YaVqaGvUjXZN3H?=
 =?us-ascii?Q?ALTsDhWcMSnnGqBh9eRfgg76WkXlrhOB1LobZzKWOWm6Sj1FAUc+4n3T1/sc?=
 =?us-ascii?Q?5764sJqWp0+ZKtcLEGXOPFo4tIenjIfzVQarJsLc//0wa2e3yD8YgNB6MeTG?=
 =?us-ascii?Q?KvxoA44fRcLWefEjVbvq9AuoOifUPdLs8McV?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OSZPR01MB7019.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?us-ascii?Q?0FhhdwmkCkwieDllsGfzlQSqWtUA3SMfrhJaCrOIsoPoNmkj+VgIqT6Ou2Nr?=
 =?us-ascii?Q?jWm5l/lA9fLs7BbRvsgAYlaE5F6sJv/SkTO4DY1q8efokkkJkP3rygAQoIb2?=
 =?us-ascii?Q?pRRAV87q3tP2e1vfNdaPsEBIsi1adbEHdgVcc0jMLCdSXYOqN9pon7MzqyI1?=
 =?us-ascii?Q?F6ZFoyKSWbA5DVGaohbteIMGPS0G2H8kHwENehmQG2GDQWA4jVtGVd076Mhb?=
 =?us-ascii?Q?qCrkd7QvND0LgACTINrdV5feKgXKOb2+BSgRavlr3TTCv/xY7YLj2NvPiwAI?=
 =?us-ascii?Q?2/a1TBOLKQiEPfXBjtmabBSPS2XjcvJovShH6O3k9u5tNWGZNTZfPbqn3MV2?=
 =?us-ascii?Q?vo1jjOPYERiM8QvthRgNHOB5Zaw84QmXblZDDw0XSRSzmzQ7MEKqIBVCl83R?=
 =?us-ascii?Q?MjurT6Ui8Zz227zaWgWFyWbMlNj5AVNVYW+pVQwzOoWF0QQw1hurbKQ67KeW?=
 =?us-ascii?Q?CkSwTtq1z5StZ+Jv4N0kiDEX75Fz2mx4UbBIcUeV94e8+4fJKN2C73ycNA+0?=
 =?us-ascii?Q?y78CSaH180LJRyL96WQlfVoRQ2yel6GNdf1kunHu4cKX93YcOdI+ehrkRC1z?=
 =?us-ascii?Q?ljfYkMtjudTSPtUs9QRNTLAuhD7/OwdB1Xogykhls3YnQdq0RTLGviEyA7yi?=
 =?us-ascii?Q?f8aX/InZjXPdqA3SFW8EamGw21JZNbDwQwT7bdaLBz5BNvrajEwHIq2AQfhY?=
 =?us-ascii?Q?dbYL9d/K+X6mUC+scQFBGShlFATS3+fmVnhETGZUMRs+iOP+4LAD+caT3PQP?=
 =?us-ascii?Q?dOudz3KbjjV2dPFqPnSDwZjLz1LqwEqUT9hpKDe1RQv+qv50QHAscifSzLoj?=
 =?us-ascii?Q?fc+4g8El+d2WpfZYXE1iQa+8Dlo8L9f1AVzh/GTBjiH5dWUt27+7tZkPkr+r?=
 =?us-ascii?Q?v8StBuR3HRSuuL0JiyqILBoS35k+wAcXTUG+Kor0zO6gliq1nqMvdaCJE0yk?=
 =?us-ascii?Q?OnaebBk3vN+F6A383ha5cVgidMwZ6dG7o31cy1lvc5lwGt8rFjHQ9bsp3wK2?=
 =?us-ascii?Q?aNDiFNxlKU0LMBJb5998XsRDBQJL2q8dfALJZf/NeTQ/0jHLQFLsUxXjjZWp?=
 =?us-ascii?Q?uq9vyUKalx0F8fuAbhSN+dQh5nInXc6gmv6BFynyh6NXJqwzAG7+48CKz9kS?=
 =?us-ascii?Q?fBJvRQdDvGMZIrO2nhbYT2TNYY/UAiVG/jDIRq5PeMtZ0WfZjdLG0k2yIr4r?=
 =?us-ascii?Q?ZH5/9BKguj7MC4wnPdT4QSYnvCw8KxKqqFEW34+blu2VsqaLx6vWnTk3EkoG?=
 =?us-ascii?Q?akgGSuve4fKpBsgthNfoWSdpyQANYvjdjOM4XxVrAoYVwD3YF5ej0i5MnXqk?=
 =?us-ascii?Q?jD6VFpf9qwNehz5+t5or1NHziIv3K+6cTUFd9ctMhIjn379C3JYK6gIun924?=
 =?us-ascii?Q?bcjFYCAfVLEKkr5oB4xNSDa5RfiK2I+YxzxOnaDziTkI4KypjFk/2xbn6xyN?=
 =?us-ascii?Q?EyXpRyJc8UStiFlCAA/HGIUHxxDTKs2/NcALZ4DYMZXOzAYFlMg3WftN29ws?=
 =?us-ascii?Q?sEaWksu3w/24RU2b+ZZ1DkMH92i1sm9vpt5R5stKZnAUw2vDkHcIVQcfMlSa?=
 =?us-ascii?Q?4pVK4nZn7qZb8ENH2gOULYIyZZclUsriBELhrH5ktgYEX0TKzE55Ob1+4B+A?=
 =?us-ascii?Q?OpPSiV0wpSudEv1K3cfUewAW/ulrtmhmcLXViCc6rB95Rvv4RXWoiz/8/qqT?=
 =?us-ascii?Q?t9zY+8KwHDGuM59O7pVKPqmCXOyQeUExvF/yF1mI2h/47i85X2xt91EGwCAu?=
 =?us-ascii?Q?WkzUQiKVg5anOvslwriPUpbBiunw7JGDD9e/3M8t2YBjjR1Q4hfs?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OSZPR01MB7019.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fc4ea8d4-9a40-4a8d-65f2-08de4c64675d
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Jan 2026 14:12:04.7560
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Ptkzdgk+xwMs7YleYDwNcNUy9k2gixuQs2Yjfwv+l31VqK1d5SeioyR500xSZusbdU3DE/ut/VGNlrEYGA2qRwNXFQCpAQ/5yQpJUYxxZ+mP4OTeMHXYVF0X9LLiWcYq
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCPR01MB6717
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 05 Jan 2026 14:12:11 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/21315

Hi Pavel,

Thank you for the review.

> Subject: Re: [PATCH 6.12.y-cip 16/17] arm64: dts: renesas: r9a09g087m44-
> rzt2h-evk: Enable I2C0 and I2C1 support
>=20
> Hi!
>=20
> > commit fc14be9667ee06301c3fff578357c8d78749bb13 upstream.
> >
> > Enable I2C0 and I2C1 on the RZ/N2H evaluation board.
> >
> > Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> > Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
> > Link: https://lore.kernel.org/20250820200659.2048755-6-
> prabhakar.mahadev-lad.rj@bp.renesas.com
> > Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> > Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> > ---
> >  .../dts/renesas/r9a09g087m44-rzn2h-evk.dts    | 56 +++++++++++++++++++
> >  1 file changed, 56 insertions(+)
> >
> > diff --git a/arch/arm64/boot/dts/renesas/r9a09g087m44-rzn2h-evk.dts
> b/arch/arm64/boot/dts/renesas/r9a09g087m44-rzn2h-evk.dts
> > index fb2651c4c3383..a068661fc4429 100644
> > --- a/arch/arm64/boot/dts/renesas/r9a09g087m44-rzn2h-evk.dts
> > +++ b/arch/arm64/boot/dts/renesas/r9a09g087m44-rzn2h-evk.dts
> > @@ -10,6 +10,14 @@
> >  #include "r9a09g087m44.dtsi"
> >  #include "rzt2h-n2h-evk-common.dtsi"
> >
> > +/*
> > + * I2C0 and LED8/9 share the same pins use the below
> > + * macro to choose (and set approopriate DIP switches).
> > + */
>=20
> I believe this should be "pins; use" to be correct english.
>=20
Ok, I will update it while I touch this file for upstream.

Cheers,
Prabhakar

