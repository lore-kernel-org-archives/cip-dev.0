Return-Path: <prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2AA40C4321E
	for <webhook@archiver.kernel.org>; Mon,  4 Apr 2022 14:43:48 +0000 (UTC)
Received: from JPN01-TYC-obe.outbound.protection.outlook.com
 (JPN01-TYC-obe.outbound.protection.outlook.com [40.107.114.128])
 by mx.groups.io with SMTP id smtpd.web12.3300.1648840763602203280
 for <cip-dev@lists.cip-project.org>;
 Fri, 01 Apr 2022 12:19:25 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@bp.renesas.com header.s=selector1 header.b=sBbrHKSy;
 spf=pass (domain: bp.renesas.com, ip: 40.107.114.128,
 mailfrom: prabhakar.mahadev-lad.rj@bp.renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HeHl/c8UrRlrUr3I06APNzKbjG01pYfZZr/RtnCwyaqFG8HgACNnTgPJTastMWc1Icb4AdapblYYXR4P/AcaooycZNY47+H+oGRNALV/wEoAWWo6QVlUo/apIDb9xFDtm/QAhV3BUhODcDmzio0TJ8S+ncaVgI8wmDPrLrNF0xKxryFq/B53w09qh9izZxgYLZtVSDuUo8hXdt0WOZz/QxMBl22i5F5nljy7CFkA0QysB10AxqcBkJcJcOg8PfrY3aBYa19Yrn+Ipp3Z82VTvvKCnn0FE8nx9W7PFYdSu0hUo0Xixp9LhCT48jXydLsAjdr9hkb2H5QmdsghUmSGAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=n0O2WndJjRdMTHkLvV/f5uYIWtvkAIECX0DE7U2gYlo=;
 b=HrrNInTw6noQysdz9XfW1ab3d5/hklI5xzs1jfjOtvAw6zhopQeWpMyiHp6Z2tlaIy6xapVS5QNRmAiItxbRFU5hOfJUfZzdXs1bdStfNkG8QwmDgdiqRiW+ycH3B1JqsOlz3Kghm1HjIl5IbNf6MjPvbeL+r0Zv9rn5t/lYnnoalqB103KVP0YRuVKQBLcfJsFzWMbw8pR5DKyAjnyqkxGaHYMbnhShRTupN/B1aM9/y0nkngzgr6J4GINSz8akhzNrZySxUAD8PXJZpGCW7i6xnIwVlxP10pc/heye3tcBfh0bg0IPXuy77kRG76qLly/4c1/MUELM7v/ByaxdiQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=n0O2WndJjRdMTHkLvV/f5uYIWtvkAIECX0DE7U2gYlo=;
 b=sBbrHKSyy9PHGYhljTI0n5tZ6W/KfuS1KyXcFESgnDvPEqO3LRj9eEWO3odTsKEIurgz3WGE7/0q/+CujznDdlV4y5QmXclCIEe1PFeCiseNzJo8f//acqjSNjQv+S6ZO0i9fssm7DbScI0AWgE5tCqevVOJQrvCnYH3cybXBZk=
Received: from TYYPR01MB7024.jpnprd01.prod.outlook.com (2603:1096:400:dc::9)
 by TYAPR01MB5040.jpnprd01.prod.outlook.com (2603:1096:404:12c::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5123.29; Fri, 1 Apr
 2022 19:19:19 +0000
Received: from TYYPR01MB7024.jpnprd01.prod.outlook.com
 ([fe80::9ad:c691:48a0:e92]) by TYYPR01MB7024.jpnprd01.prod.outlook.com
 ([fe80::9ad:c691:48a0:e92%9]) with mapi id 15.20.5123.028; Fri, 1 Apr 2022
 19:19:19 +0000
From: Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: Pavel Machek <pavel@denx.de>
CC: "cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>, Nobuhiro
 Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>, Biju Das
	<biju.das.jz@bp.renesas.com>
Subject: RE: [PATCH 5.10.y-cip 09/39] mmc: renesas_sdhi: sort includes
Thread-Topic: [PATCH 5.10.y-cip 09/39] mmc: renesas_sdhi: sort includes
Thread-Index: AQHYROgrN6fPOUwag0yEloJEr1oRkKzbcJ2g
Date: Fri, 1 Apr 2022 19:19:19 +0000
Message-ID: 
 <TYYPR01MB7024555736305E0FBC0908F5AAE09@TYYPR01MB7024.jpnprd01.prod.outlook.com>
References: <20220330185454.10887-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20220330185454.10887-10-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20220331101450.GB21513@amd>
In-Reply-To: <20220331101450.GB21513@amd>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: d133c9f9-56bc-47b7-2cb4-08da14148562
x-ms-traffictypediagnostic: TYAPR01MB5040:EE_
x-microsoft-antispam-prvs: 
 <TYAPR01MB504068943AEF37A14B60E0C6AAE09@TYAPR01MB5040.jpnprd01.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 /dMk3kyjOeIc6qkhThpAqvdLqXC6ok1ch51qAtGdDWZl0LkMIN4ouwj6EpQYtGl85PH4C/oagLCHovc3HbExk38hR0cSIj+5lZCmwipsu0g4vGpRFbtEuY+lTZJrpvyKNsW4Q9dOxgHZ4xbx/DC86Kc44ABhQ6GTh0Dr/lBr+a/PCj/3BL/QMSLCPQCXXSfGZxcZv1HDggQHBJftS4OX4heQeAZ24kKXFyW5k28O1FzVoqHtShOzvnjtnp/r6Ql4vym88dTXKL0i0Rd2DTH/dk8Tr3WYD8GcTwLluCN0iF4wZqUnxNVhvGe0WDpUndgb9Fh3atD6V1MVTugq4d+FPveDEsUQYLIBFkH0SFI9KnP8GyuLLNEuRc6yb8WmNCd7j3jk3Ydjg6Coe2c6s8cnOZQ+g2J2hpcNSD3R+ZPjt2HaS+zrwOGt3kAJP488QLxMPQCulBwBmk//3oXo/wWd0pVJ6yM4F5KOp0/y6bsjOXtbBi0rPIeRsS1UDcO+dJQsifmtNOdvy/l8V45oquej8Je14vMIEsQR09oIjbQzxz6liXhjNkrSNlkHhV64k+BJwvbJSrF2PLst3h9bC56Yis9bVP2J4i28AZNWM6qVVvOhR+sl0Stb67epsA3rdCUWnK2e96wLJRE+xYVL3E67BHpyoDUUZwNwpmICJpqT0v2A5IxNVz3mDR8SlzbelzjSk+YrA81BLf7uF9+tkjDmuA==
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYYPR01MB7024.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(107886003)(186003)(26005)(83380400001)(38070700005)(122000001)(38100700002)(86362001)(6916009)(316002)(2906002)(54906003)(55016003)(5660300002)(8936002)(52536014)(76116006)(66556008)(66476007)(66946007)(66446008)(4326008)(64756008)(8676002)(71200400001)(33656002)(6506007)(7696005)(9686003)(53546011)(508600001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?us-ascii?Q?V5hHRgAjMfjYozqSxLDA8MVx7dneoYxNxtioaiaKG5WXMZGWKXYHN8+p7Fm5?=
 =?us-ascii?Q?kvWX4VzTqoumeypFky3CI6C9joWaeLWgw1F9uAyQkUg1dszQSIm83gH22BWy?=
 =?us-ascii?Q?lb2nr1bzjIeB+sebW68+n9EPpV8DRcpkL3ipv9VEFMu2G6IwUjpgh++IlqP/?=
 =?us-ascii?Q?NCNXTB/rRDNnHptI0O4zrfeSGLpSm6Sj6NnU55MGZ9xa5OWCADhBZGEZhyVy?=
 =?us-ascii?Q?Ia4d9nwf7mwtupGqij7APaHlCkCZ3gJM77kq9OUaYPP3dbaos575c5lXT5N8?=
 =?us-ascii?Q?7czMTwqcAqeQ9oQnCKXdm6m/wa1n4J8ppwKMzaE/Ui2Qw/GX7owRogWidVvA?=
 =?us-ascii?Q?nZMaOoETARppSA8LY0mVDt+LI7DpcL6UL3K8ORNlK4a8ovqaF679f4hywgHp?=
 =?us-ascii?Q?1AIie4/QPouKvuaNj/eIwGvHe7rVrVWjbIiqovGMJXd0bZfX9HoxXyGaaRfp?=
 =?us-ascii?Q?qlpFzRmv8Sa5HUsOqhBKh2ChAa52KniM0A6uxf+x3weXsnD+nWuNvZHU45Pl?=
 =?us-ascii?Q?YYeC3EWoA+UXJu0lp1bLP0aM4zBZHxH0sxOerVz0fty8CCYqFXBjPW8J8/ek?=
 =?us-ascii?Q?xdFeiXJ/oBJngFVu03dyLkeqqA6DpXZaKDWQZA7e+Z3uhaZudtmGWBDCGrea?=
 =?us-ascii?Q?mF6/zYpoGmbTLL87cJ7bvB2ydn2UKrfpzgr3l9lA/vpp1oArw/JJFVXJgpSY?=
 =?us-ascii?Q?zMm7k6o4GOVYPyLqAfIFepMTajvZ4hNWEH+Cu/UScDuFTYB5w4vCQGtDJfwX?=
 =?us-ascii?Q?l4yyoPhjov1Ff/j5m8oLs7HUEeNcSY2tsDc47vly+iT9zHlxZHrJYHKlLU/5?=
 =?us-ascii?Q?/c06H4RSFWHWEuLAOszjTy68EbJqOOnA8gPNGzkPCZpXDayUk1uCV+/EkEX+?=
 =?us-ascii?Q?UoT+0dahbBSXduIgMnhT+wGOktZHvWTkQc4kC83NB4SnTdK3WURUFiuoYZEx?=
 =?us-ascii?Q?W/UexveEDXp4rxDBaQ6ROrGTIdpAgHGO/+OxsW38QD2WbUv06f+qfoyvig1v?=
 =?us-ascii?Q?BgQPNVo0b4Kwab3ieBzm8NMZeHliMqxlcWpwPP8CK4JNjWxIz1l2+SCZYSeq?=
 =?us-ascii?Q?zxEP02TQGK8IsSnqtfrvRrvhipHbCz3HEKSJ2YYxh2GDJv7F8ZLrQUQ2PlEd?=
 =?us-ascii?Q?E8x5saLghfeOLmHfpyzqKVy6rUgz5Oz7tLH/L8h+r9Pceh1FTl0KdJ1xcz/q?=
 =?us-ascii?Q?Y1tLNIFAjejCoHPrEdJ2o4h1lo4hJLWFb0PY8gjChK3puwZLToG5odcwqdza?=
 =?us-ascii?Q?qa/r9B3NYfLqgHRthfOuOWisCbB6WMu4YpiRsRinHkMBrNZl1W7sMaIgFIMi?=
 =?us-ascii?Q?q8uMtbZMwAtVH/uZSR7+ed+psSWbPs0LARksMfBudqW3EfFHjwgEkhk41g3r?=
 =?us-ascii?Q?Z03mEhE+Q+KmFgJsMyyvFgI3Ym5AMEw1txpq6BXBMtTTU6Se73MKZ3tR7Wcd?=
 =?us-ascii?Q?U++Z+Xf3oLHb2mL52/1yhTFJoealR0TrjZgX2PLXTQyWPHugsdv7uLQQNTBF?=
 =?us-ascii?Q?E86Lb7wI1vgPobZ7YclmisFaLMGsCA5ipsDHxEs5zkxseqqqb65CTNUS11jK?=
 =?us-ascii?Q?D5aoHuvr0Be9ePJRFSQPqUS7vIFedbM/8ZEYSbpqz+OEIZyQZQ6IFXcrLloR?=
 =?us-ascii?Q?dlLvlZeYEOa3eEaU+C9okwNZHtFOUfEhFX7w4vylpVgUUvp5Ssyq5XfqEnhJ?=
 =?us-ascii?Q?mynJBaR0EAdhyr7yhPS83CHRaKQLZXQ8Fuy6DQxTpIcKoz/nbIW3p0ZEY0My?=
 =?us-ascii?Q?NhFDtwHTZX/81spzL8iGRbMxTU1gtT1NeiP8eRLAtNWX86q12/i/?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYYPR01MB7024.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 
 d133c9f9-56bc-47b7-2cb4-08da14148562
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Apr 2022 19:19:19.5740
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 
 Xy8ErfVd1LOQlDwzuKnuhuFvTh//eflKIpojSnuzSeSYt9XLwnB9FHclzhTtnD76ukdPff4SWRxwgSiz4uQJQ3nZ5XPqO0LQdyptcyRrWSzUIk+cq+WAPAZIBD8bCBvG
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYAPR01MB5040
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 04 Apr 2022 14:43:48 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/7905

Hi Pavel,

Thank you for the review.

> -----Original Message-----
> From: Pavel Machek <pavel@denx.de>
> Sent: 31 March 2022 11:15
> To: Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>
> Cc: cip-dev@lists.cip-project.org; Nobuhiro Iwamatsu
> <nobuhiro1.iwamatsu@toshiba.co.jp>; Pavel Machek <pavel@denx.de>; Biju Da=
s
> <biju.das.jz@bp.renesas.com>
> Subject: Re: [PATCH 5.10.y-cip 09/39] mmc: renesas_sdhi: sort includes
>=20
> Hi!
>=20
> > From: Wolfram Sang <wsa+renesas@sang-engineering.com>
> >
> > commit ab07a1356043f07142ba351253904ef8c42ecd4f upstream.
> >
> > Better prevent double includes.
>=20
> > +++ b/drivers/mmc/host/renesas_sdhi_core.c
> > @@ -18,22 +18,22 @@
> >   *
> >   */
> >
> > -#include <linux/kernel.h>
> >  #include <linux/clk.h>
> > -#include <linux/slab.h>
> > -#include <linux/module.h>
> > -#include <linux/of_device.h>
> > -#include <linux/platform_device.h>
> > -#include <linux/pm_domain.h>
> > +#include <linux/delay.h>
> > +#include <linux/kernel.h>
> > +#include <linux/mfd/tmio.h>
> >  #include <linux/mmc/host.h>
> >  #include <linux/mmc/mmc.h>
> >  #include <linux/mmc/slot-gpio.h>
> > -#include <linux/mfd/tmio.h>
> > -#include <linux/sh_dma.h>
> > -#include <linux/delay.h>
> > +#include <linux/module.h>
> > +#include <linux/of_device.h>
> >  #include <linux/pinctrl/consumer.h>
> >  #include <linux/pinctrl/pinctrl-state.h>
> > +#include <linux/platform_device.h>
> > +#include <linux/pm_domain.h>
> >  #include <linux/regulator/consumer.h>
> > +#include <linux/sh_dma.h>
> > +#include <linux/slab.h>
> >  #include <linux/sys_soc.h>
> >
> >  #include "renesas_sdhi.h"
>=20
> In these cases we usually sort be include length, first ("reverse xmass
> tree").
>=20
My understating was most subsystems prefer alphabetical.

Cheers,
Prabhakar

> Best regards,
> 								Pavel
> --
> DENX Software Engineering GmbH,      Managing Director: Wolfgang Denk
> HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

