Return-Path: <biju.das.jz@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75453C43334
	for <webhook@archiver.kernel.org>; Tue, 26 Jul 2022 09:20:42 +0000 (UTC)
Received: from JPN01-OS0-obe.outbound.protection.outlook.com
 (JPN01-OS0-obe.outbound.protection.outlook.com [40.107.113.133])
 by mx.groups.io with SMTP id smtpd.web10.4621.1658827237664740186
 for <cip-dev@lists.cip-project.org>;
 Tue, 26 Jul 2022 02:20:38 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@bp.renesas.com header.s=selector1 header.b=IWgkNOZl;
 spf=pass (domain: bp.renesas.com, ip: 40.107.113.133,
 mailfrom: biju.das.jz@bp.renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=D8PgrPe/ndxDBhMEC+NxnCWCTGEz70HC6v3xfClmFO/C3GIdUcNuUbEf96R4npLfPdBX4mQhs9xSfT7HbTl6h2gJ1B1RzP4MsLraJmXVU25uDW2ulCWzlPnv29egZDxR+qdl+IgeZLQC50L4pyNopF+onbOjNGv8p3y1OWko/wyO++AgyTNbv/6XChF9jdqfjOxIS+jLCzQfOom8GEyJdNHA+X06ildaKAwOENFdxC+fX7TbWWZdUuSQXTsjAcqSclO+twHE2KbIyXJJqKpgqbahC1VAWf29XyXaayrzn5UHQ2vLnRkNE4xa0/NnzQPr0QA3/4WJINki9+wpdmVe8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1MLIMljBtVYy+ciMn1mdz3XC/mrQKyLIfvnPtnqbo4o=;
 b=U9pkaHtYt9g6jJgFdxaqaAB2nCjNA7NGOJbAneYeS9CPmurRnc50NyBBaGDdSqVVMEzDctup6x0mXAOauCp62dUpNkHn1SiDgWxXiND7O5avcx/whSUTly5FoGsvhyVffXaiMupNLL8SIll/0RQ+Aruq6DNrB/w9sy6FQ6cCwfOdK8I1x0bIDC1r0gyxWEsyNOfZa0VkKcIg+/FgGa4u1KmVVk5I1xdT0bqwzdbyqUTbnMO69RKAqQi4m9+HRHxjRIUmrwGWDravRDL0xd8QRkg1Qb+m1qtm0cX8sQiRoYxNpX7k3R9x4HirOiaRpPw5eG7hGt5pPrB9QnBvXNLO2Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1MLIMljBtVYy+ciMn1mdz3XC/mrQKyLIfvnPtnqbo4o=;
 b=IWgkNOZlgK1vHjMWNa1vMQjiqT+WjIYkztrftmYSlIh+qUBaThfSaHgJEWHQsJ3uik4I95mkPPGb76UV0PS5rLfagGdwTiC88aF/2lQLERHzzzE8SgJitMDfLRxXZvrq3e++PPE/azXLhta8H5iaC+Qe/ySfEUTxZrP85D9Md80=
Received: from TYCPR01MB5933.jpnprd01.prod.outlook.com (2603:1096:400:47::11)
 by TYYPR01MB10512.jpnprd01.prod.outlook.com (2603:1096:400:2f6::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5458.19; Tue, 26 Jul
 2022 09:20:34 +0000
Received: from TYCPR01MB5933.jpnprd01.prod.outlook.com
 ([fe80::440d:b27b:6bbb:3d27]) by TYCPR01MB5933.jpnprd01.prod.outlook.com
 ([fe80::440d:b27b:6bbb:3d27%3]) with mapi id 15.20.5458.024; Tue, 26 Jul 2022
 09:20:33 +0000
From: Biju Das <biju.das.jz@bp.renesas.com>
To: Pavel Machek <pavel@denx.de>, "cip-dev@lists.cip-project.org"
	<cip-dev@lists.cip-project.org>
CC: Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>, Chris Paterson
	<Chris.Paterson2@renesas.com>, Prabhakar Mahadev Lad
	<prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: RE: [cip-dev] [PATCH 5.10.y-cip 24/24] arm64: dts: renesas:
 rzg2l-smarc: Move pinctrl definitions
Thread-Topic: [cip-dev] [PATCH 5.10.y-cip 24/24] arm64: dts: renesas:
 rzg2l-smarc: Move pinctrl definitions
Thread-Index: AQHYoGiZeBficqChSUeKMK5Sq2jTbK2QYFoA
Date: Tue, 26 Jul 2022 09:20:33 +0000
Message-ID: 
 <TYCPR01MB5933013757A576EECDA6DF8486949@TYCPR01MB5933.jpnprd01.prod.outlook.com>
References: <20220715072244.2298757-1-biju.das.jz@bp.renesas.com>
 <20220715072244.2298757-25-biju.das.jz@bp.renesas.com>
 <20220725205326.GA2302@duo.ucw.cz>
In-Reply-To: <20220725205326.GA2302@duo.ucw.cz>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 41aa4e02-3745-4f2f-26a5-08da6ee817f4
x-ms-traffictypediagnostic: TYYPR01MB10512:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 NQffwFzJGLvJrtLKylHy091Fyuh6lmFg4Ae5mBj8/SKYyDIgfd8vuwYs1DOdyt1kYHktHidEUATkU9c/l62eb+y3hZUOyvDh55/hSdgPdZP35vdBwyNHc4+W2HDwUS1hs1jy7ZOgkgtjv56k07UasLgW8c+l7OfLoCiYM12qriA5gad8nvvfQwb7LaM33ni+0vbpJPjv8aeWj6/zFrKEI0qB+NIBngUwrLEr7ev7tHK9c+vE5y5UjhYEXUr0Ol5nBNRZ5ybZO1hTaOADtg5dLOXLwK2oqwTygpwWqVJMi3MinXMJuDMM00bTYBm5q9cLNntujWT4vwMvKt3IhUB1Ut31Zq6Ou80g3Ba/d83ujEl7Wr/wJlPY58zsqZVavtQo6MFxJQArXwRbBuXfB1iYx9eYBnBWOtsU8+C4ggSf7LLLgOJPXmyZtiUhTzdaowP1Fh/aBJZIaIzuveERnGX9+PQG5hBSlbTztw/uksE9KJktTJ0aYqBqEpwDLFdqxhi0ACnt4YUx627wKuCVzucrP0CdwYgSM5T7TNoUgcbeL/8ZXj+yHYMgpq0phd6vLFaxRUGR3qBsAnsedrtp/BU8OsQCfOpmNxuqEw/406tA4dubRMsRxOrr51g5/yKFYEw+NePMMDwgnxO8MJokouDZvUTB+5Edtp4P49DVBw7DZKpiP+7hTNL4MzpflD7VyZ2pWXE8egK6wu9DQIfRlLdId5FFe+FSd+gHL/I1BIHmgZIzeQWMKx4j7O+fxuuH3uDlSfHFFss/n03K5l/camC5Fv4LJB/0ZwAD6akyTgLymjrCfD2tKnDZy0Hb7v0eJNn1
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYCPR01MB5933.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(346002)(136003)(366004)(376002)(396003)(39860400002)(122000001)(478600001)(110136005)(54906003)(33656002)(2906002)(8936002)(52536014)(38070700005)(66476007)(66946007)(66556008)(76116006)(66446008)(38100700002)(64756008)(186003)(5660300002)(4326008)(8676002)(55016003)(316002)(6506007)(26005)(7696005)(9686003)(41300700001)(107886003)(71200400001)(86362001)(83380400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?us-ascii?Q?YF42uo5zBeqz6PCZ7uMQUCsNxllbdx+inZujMETzMgpT1/qSV7WYF4b6gyGn?=
 =?us-ascii?Q?SE+tuq4irmNGGn/xhOLcxZL9GUgSXPu1MS0WYvwG/SbouzqGaDypF0Hhg44s?=
 =?us-ascii?Q?LjlJeiUGJlldNGcLXtHtsxLw7t8yvesypIfXCgLLG6RYUxpXALKHhYX2RSrT?=
 =?us-ascii?Q?PrVfQiGyuN01Xm5QRMFIRiETyf/WDcWuITCtRUcjo37qCNYN4ROtGCPihn5+?=
 =?us-ascii?Q?CpNaGPvxPISxnLnukkrCCTkDesBva4OH2zvtyGuCsNSRALzD8K4Ww43gQvSn?=
 =?us-ascii?Q?zom87ixi5wmeV6tZfQVAWvuFYE5roPa6cPvlxrUyGUJYireCCRO+PMjpGTZN?=
 =?us-ascii?Q?CgbeHrkoSpdpv9MOvUGQH6D1k3zu0TmroY3Uk2FuYaMnMVbhI9dJiehIV0AS?=
 =?us-ascii?Q?+SVpR3f38oEONd2+3RZVN85nWThF9rJC4ALp653558Dx9Jtkwu6PIJ66pgWl?=
 =?us-ascii?Q?HpuCUxvmKEOtpMEAuzEbfBkf/afJR7vImNFnTz50VZ8hTnLeDFQiI0U3lPnP?=
 =?us-ascii?Q?hKNGnjIsbI50OnG+Y96cfPcLtqbpkt2uUOY/4Q5cdb25jaBsHYm8uXy670KJ?=
 =?us-ascii?Q?MhOMf9iZoBuboGAcewTNP7d0uow40sAR7QpeqCTOfOyRhLKoSyQIB/tf+JCj?=
 =?us-ascii?Q?rODgCdwBIoEe2t0CK0dM5CeVesDO8pUsnz0tX3/sjUZox+b6jTWt/o/kvwxQ?=
 =?us-ascii?Q?skMF0aee46DyJznvl/vEKjNDJdaQJiqwBC2voPIk6ymoS4t6mWekfzTGtRrk?=
 =?us-ascii?Q?nRMa7KVWgEXSscXkcDQRZ8+j2ovM7/bIl3RzfK+CVTZRZhiZLnyWnytiu181?=
 =?us-ascii?Q?w0Boq8/BgZxqgJ2HfTQmu86MIe7nYs5n1M0uMxhfhdWEtowv+Bbi9x6xIZhc?=
 =?us-ascii?Q?SkVzICtlj2c3PK/vQx2SMfpjrhv9jNljEvRvfd1jZCHlAJm4ZAMBcltYGirH?=
 =?us-ascii?Q?tXr/dTVn2hlKaovkvxEfcbucvVrO7KA9KHfrWL+4smI+7SBUUcXNF8rTdggB?=
 =?us-ascii?Q?VsovwRk4vmSjoqbaQYMY1maJ/QoLHdUPL/VgTWxL90QTunITZRCb6oSZz6C+?=
 =?us-ascii?Q?NJ0de7C9xP9Dgwo2wm9nyguciEiCVwqtmZUhPvhP/dXdS+nrZh/QKVzavD8V?=
 =?us-ascii?Q?z4myLxmYq9roWpDbScYUNnjTJnApOWdBBMUJKnbLId1rN62zVFgaalqI8Wa2?=
 =?us-ascii?Q?cKkU0qzsn9QXQuMJXaz1leXdfIFUYUsM/tCRtKlDdirTYFE6iX/opLsa4QC6?=
 =?us-ascii?Q?K+Rid2HYWOdxtuPQy7f9S9AMitpxmyG2nvRZPaF6u4pjGBfpDy7r5kyuj5pn?=
 =?us-ascii?Q?YSdrLsrWSi6cQjW7USskXEunSezcC3L49J/FN1lRhfTMZdO+scfxVgT2Hs24?=
 =?us-ascii?Q?oLM33XwbwYPkfyReqIA/4f2lggLXcyULjHpXufLPpVA3SzbEx44QyXLd428w?=
 =?us-ascii?Q?yU3nAOPW95ckNvGB+TvHVVpWnk5nwqoH1qJihfvMsthSv/tKF7j3j4cH4yKg?=
 =?us-ascii?Q?OgPccUadsXV+oECY/mgWY1cOOANT3WxaCC/k1PWXBZugb5inFiw0rjzASpf0?=
 =?us-ascii?Q?JXFuRyXEropdfATjMr9z6pp42ZT3NLI6+Go8jiY/XVkDmWAkAokcLfjTffFn?=
 =?us-ascii?Q?nQ=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYCPR01MB5933.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 
 41aa4e02-3745-4f2f-26a5-08da6ee817f4
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Jul 2022 09:20:33.9066
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 
 /FnIxwQz7wrxOmWj6CiHAkcKjtVJz/tEg5IFmLDXd7gt8hhPZJibW51xiBAnc1Ao1d0tSEsQt1jtYNQfjBQ413C6zFEPxyVV8LGlsxX/lZY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYYPR01MB10512
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 26 Jul 2022 09:20:42 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/8926

Hi Pavel,

Thanks for the feedback.

> Subject: Re: [cip-dev] [PATCH 5.10.y-cip 24/24] arm64: dts: renesas:
> rzg2l-smarc: Move pinctrl definitions
>=20
> Hi!
> >
> > RZ/G2L and RZ/G2LC SMARC EVK use the same carrier board, but the pin
> > mappings between the RZ/G2L and the RZ/G2LC SMARC SoM are different.
> > Therefore we need to update the carrier board pin definitions based on
> > the corresponding SoM pin mapping.
> >
> > Move pinctrl definitions out of the RZ/G2L SMARC common file, so that
> > we can reuse the common file to support RZ/G2LC SMARC EVK.
> ...
>=20
> This really needs subsequent patches to be useful; plus, git complains
> about blank line at EOF. Anyway, I believe we can still take it.

Will send support for RZ/G2LC next week. Regarding blank line, Will fix it =
in mainline.

Cheers,
Biju


>=20
> > diff --git a/arch/arm64/boot/dts/renesas/rzg2l-smarc-pinfunction.dtsi
> > b/arch/arm64/boot/dts/renesas/rzg2l-smarc-pinfunction.dtsi
> > new file mode 100644
> > index 000000000000..71d83e447670
> > --- /dev/null
> > +++ b/arch/arm64/boot/dts/renesas/rzg2l-smarc-pinfunction.dtsi
> > +	};
> > +};
> > +
>=20
> Best regards,
> 								Pavel
> --
> DENX Software Engineering GmbH,      Managing Director: Wolfgang Denk
> HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

