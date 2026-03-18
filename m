Return-Path: <biju.das.jz@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23135103E162
	for <webhook@archiver.kernel.org>; Wed, 18 Mar 2026 10:58:34 +0000 (UTC)
Received: from TYVP286CU001.outbound.protection.outlook.com (TYVP286CU001.outbound.protection.outlook.com [52.101.125.43])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.11436.1773831505648347482
 for <cip-dev@lists.cip-project.org>;
 Wed, 18 Mar 2026 03:58:26 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@bp.renesas.com header.s=selector1 header.b=MXQ2gaD7;
 spf=pass (domain: bp.renesas.com, ip: 52.101.125.43, mailfrom: biju.das.jz@bp.renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NYcZj3Mo54J/hHvZiaMdLXpmhX8iAyfGyBLFu7tdgNPoQ7qh3m7Sznok3bXjWDP2oT42SIMIWqgdbbiEYoQ6xMG/vqG7oEDaMsQ5eV1SjPiU0LcKenSJy9Uuhs/Q9nyJQyiKjew701x6OKl2p6W37YH88DRUtQ4O+mm6z30HwaHb9MaB4wbldull3qlXbulo3QzO1q2TepINQ6cdQq+G8gKL2ocvKIwI2zcHnAX2kpqj06GHSkJAsk5rIe0iBiVyA9nBPefZU+DW/pUBimELfaEbNgYQ9Z7ZIWToIPUUYMbdCa+LAi0pVQ+/CzMUMPzwsfLDVBPr1dcQMlxRa6u+rA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=X5dBrwxBySlM0seh+Y1wZEv70mZ35oR51OtrQFs+X0Y=;
 b=yy4HoKyE2wjS5ktLpzmlwe7nSjlZBorPSi/V7nhbJhJ6Tt+olHb9w00LYQW4mQBnldPmSfRzuxOUwpt21LmDHWzp/PeF7ex4n9Ok2UD0/gf2uyaNRQRQPB0pe3L36IASrabyMTBn8fexzRSggIWLp6d98lMRWGVmr3uuc9gctTHlNvO261+6fMs8ddNIo62U1TYs3EUdB6JpF2zecd/3F00L4kfkVBxSe7lT60H70u7rGVWXQYD5SMlTXZMsgFX4600i3iUW6nep8qPFmbRk8XMhQuREMtT+Qwrag5oAROX7bOWhGcwWO/WpWY+VFSygPrMuwcQlT1stswpe9Cpf8w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=X5dBrwxBySlM0seh+Y1wZEv70mZ35oR51OtrQFs+X0Y=;
 b=MXQ2gaD7gYrMAZ2GvIE219CxIZagKFF3skPbkeQlOggj6YESyG1rrpuVCsm5PBpewKqzlwvpouuMkcbRTzQbvydILAKlMrzAiIcMaSD9c/MnAm1tOGm7mJosx2fJLy6rr6071sDFf2mmwuEWEyfBdMwZ5Ok3wTLnMj49IUonWPs=
Received: from TY3PR01MB11346.jpnprd01.prod.outlook.com (2603:1096:400:3d0::7)
 by TYWPR01MB10361.jpnprd01.prod.outlook.com (2603:1096:400:249::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.19; Wed, 18 Mar
 2026 10:58:19 +0000
Received: from TY3PR01MB11346.jpnprd01.prod.outlook.com
 ([fe80::87d1:4928:d55:97de]) by TY3PR01MB11346.jpnprd01.prod.outlook.com
 ([fe80::87d1:4928:d55:97de%4]) with mapi id 15.20.9723.018; Wed, 18 Mar 2026
 10:58:19 +0000
From: Biju Das <biju.das.jz@bp.renesas.com>
To: Pavel Machek <pavel@nabladev.com>, biju.das.au <biju.das.au@gmail.com>
CC: "cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>, Nobuhiro
 Iwamatsu <nobuhiro.iwamatsu.x90@mail.toshiba>, Prabhakar Mahadev Lad
	<prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: RE: [PATCH 6.12.y-cip 08/11] phy: renesas: Add Renesas RZ/G3E USB3.0
 PHY driver
Thread-Topic: [PATCH 6.12.y-cip 08/11] phy: renesas: Add Renesas RZ/G3E USB3.0
 PHY driver
Thread-Index: AQHcsjXcGpt0TznDaE+mbD604wn5u7W0GC8AgAAOYNA=
Date: Wed, 18 Mar 2026 10:58:19 +0000
Message-ID: 
 <TY3PR01MB11346605B8CE0CA6550416168864EA@TY3PR01MB11346.jpnprd01.prod.outlook.com>
References: <20260312153522.1131675-1-biju.das.jz@bp.renesas.com>
 <20260312153522.1131675-9-biju.das.jz@bp.renesas.com>
 <abp4KprlYyU+jMPu@duo.ucw.cz>
In-Reply-To: <abp4KprlYyU+jMPu@duo.ucw.cz>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY3PR01MB11346:EE_|TYWPR01MB10361:EE_
x-ms-office365-filtering-correlation-id: eb422336-d145-4ef1-725f-08de84dd43c2
x-ld-processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: 
 BCL:0;ARA:13230040|366016|376014|1800799024|38070700021|18002099003|56012099003|22082099003;
x-microsoft-antispam-message-info: 
 b0NnHjy5uGI7mIrXn+LeGKbYxucw9MMDm+NdiZEwOOVt2iuk+gtg2CT96LNWj2c9BEaebjV5g4wqfOtfDOdl8La332wdw6OSU6NBjfoxaE4khVTboxbPoNG5JIVmyUB1hamsfkR+5lwhIrzD+tKOv/xdvIErI9B5fiUelgf07ZPi6Zdg8x7d9NkZd6K1ZsawcNL/ZVCvOQ0LM4Z65XlENR+J/DstTK+P8lYgMuvBK/2bH8iEuzgnLJbi2yRsMubHZ0RT99RSoZJ5Du9V9iG+SftD9XPo10n2Ha7axTtWhGXCS6G6Eh94nGQ0OwgViZSC4sJ5/fViQ/ZFqhzI12fUWo5Xp6v6/x5kqwpWGMUL7GY78/FlzlJGQJsBHASLvATqDQiSLXd+6uHMPcWzj1qfq03HbvhQ7TD9cD7ADGkyAM2z2+nfHAQuKdqMK4XHNxw7PRXFSPrxCYvE8YDCbcIO3vtnhCoExyykW9mhP0jFj0M50vbo2F4EdVU9EQxmTZWZfpm08nWXPtXyFZA2XPgEaraP4fBRFbvNsijHZBQCKmSXpVozK9E9M8jGIE9iy8DIUDK66D1G6eACylSDV/BVNvMxOIGqJ5KJ9yD55zMDs2NItrmnkIdQ5KXKGLSO5y/oZK6VatJeGU+XdkrZl9NtGhVtgvskkyixA8UnGxMklAAugm5wtjYZPKqp2NC/ir/jDbfDImppGRqZW1koDnd5QJft4o8PEp6k8kUAlrqf84LsrW9+n85JPlsWXTOKVFZp7scpBHATrD2iBumWg4QVg2md4sGy+iYPcXUPBg4HHzs=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY3PR01MB11346.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(38070700021)(18002099003)(56012099003)(22082099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?us-ascii?Q?vzdl4eT2WQfFpbonCF5BBI0vAc5F639VghwiLNKMHoV1yd0Bgl62JEoAGFqG?=
 =?us-ascii?Q?ldaPav687GT2xMsR3a/5d4Nvq7VITNMb9TA4Age+Cu9oHH1UbmztksDZhhrY?=
 =?us-ascii?Q?OAj3Oqwq2zgepQ54LQSD/ikUoNzw2pYyunijwIL4ouuu2hWVPV1DRG1KInnG?=
 =?us-ascii?Q?Rav1Y3TsJEXZBmzLxxpfmPo8oVqNQwS9NaVaEbgGlL7bQTsQogFT5qJKHTuv?=
 =?us-ascii?Q?+Au7Lh7j63aILBTjyYlpCWU1lmQrLKC4S73qUwe1Z7pktI9bDsdSScO+NdvY?=
 =?us-ascii?Q?XZZVlWeeAKFy4+9BgoXLNKYvzytGLtxNVJbojth85k1TDoHu5P+HW4r46KAE?=
 =?us-ascii?Q?fYJrgF/crfHAju6pfPeRpvYB4ypQ59Kg16rGIzZ0YuF8fpIDujPNvKYpX5+P?=
 =?us-ascii?Q?QVLDGgLaK1ykkvkwHYWHIXl6vxHsi2eesiwu02HYwpT5kvbWc3XUURL2TRo1?=
 =?us-ascii?Q?yOrnWuUbAYAXLHqDah7dvRWRoi9hBLWXUACCa/czeTcolFHXmExzcQ03hMDs?=
 =?us-ascii?Q?CXzwdrGoye5MAdTQmfow1/0zaVR2F7KE/aUbHJn1BUA1jcfTev9PqXUk73M3?=
 =?us-ascii?Q?LV372c7vIdv9iG2bkxyP5Rm2+6ofRr1DNY0Uz14UAeN2pOXesPXF5aTmIhwN?=
 =?us-ascii?Q?eUJuAetBUnjkMxGIdR5ebypZ7SriKZLtt6GUyxpelxqag5A6AUD2UoOO+FSA?=
 =?us-ascii?Q?uOg9xgr9aJYl6ycoDYr1oNoQGEsWQxr3/XekmiRAMHFzQhvKgPiXtDRqBe79?=
 =?us-ascii?Q?9nkT5FHLSrGIpGwNpE7q3h6Xu2pIGA1ABo3pJkzI+ZhG4SDORYLb7Mtsi+Tj?=
 =?us-ascii?Q?zSildOp4fhqlxeZZ/JCIkPupwc6Wc7Sy5efr05rLgmUTZLoBSO25dGupmhlK?=
 =?us-ascii?Q?NGyj8Fs5WMW8qZ62AS2Uv1aW9MLlhIVQUv0OVCCNWxJCcHM0mWpjC+16XmGs?=
 =?us-ascii?Q?WMov0QGf3d20BkwtcwB1lJLD36391g6CJ0BUAZ5o2Skm0ohwhmu8XqtjYIPH?=
 =?us-ascii?Q?QB9TYtWqrlfZpZB/pViztV5KUh4waKVBWocvf9SW3J+ZvCZ8qiJD/jtdAkJB?=
 =?us-ascii?Q?mulFOpHP7v7OUY1E1hTEWmkTRQKwN/YP055WwG7Xd35ekhAxayvRMILZowRq?=
 =?us-ascii?Q?i2WVqnJTX8NbVy8TuDoXBU/0DdJmAIH1A9RyCBX3g1fUmE2i1UN0OfVaxiB1?=
 =?us-ascii?Q?esJjvDUZ8ovAEUNwqkal76pFeMaWodNChMOQI0rbviZ1yRNP69t6LHDVICgC?=
 =?us-ascii?Q?dE4Rvyw7cmfjRd8WQOuST+7dPlDX9/3TcJMbyO6tPBSP3l7/crgnSDZK2uhB?=
 =?us-ascii?Q?zMD2k5YdhYNg1qIYSoe+f3d8Sxx+0TROUXzqO7dQlHJfxgkbSfT5xc51DWCk?=
 =?us-ascii?Q?FYXoKc8pDxowfvoiQioGr+Yk+Dn2sZg+9x49lSKOzSHl6iU5F57IKAayGLwi?=
 =?us-ascii?Q?iF3a77pocAYyeFdvWNz3U+8isYgUxsogMIEw33lfZmxy3LCAn+1+iliGUupK?=
 =?us-ascii?Q?ycU8sw9oMcogHwmcb7Q4V4gvA4G1n6pvaRFOfhKePJl1l6Qa+e/vdvm6NGVB?=
 =?us-ascii?Q?CGCpyZdJgmM1XR4Nn2p64p56VM/+eHRdGnvRzaVaVY3zXfwbUXrPS+Z1JvRJ?=
 =?us-ascii?Q?CFlrL5VBpe1WjrT24xr1oe/aZ0W2HGGapPa2J4Mjh81Cn/+22cMLfxVd9iz0?=
 =?us-ascii?Q?qfXqJ9KHsBmhze06HR4RlVkocO3UC67QKG0tDMe3Q+qCl85A4p64EO9lXrjo?=
 =?us-ascii?Q?64rXy9AOvA=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY3PR01MB11346.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eb422336-d145-4ef1-725f-08de84dd43c2
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Mar 2026 10:58:19.2312
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: eqq5UeCCpFtkjdSigdZLCAY+up5Y3Feg6enJkk0rBJ+VnsNMfJ1OGSfXkQWxY2bIMcyT9Kin36NMTGWcJtEKlGGFN/b9CcKunVLGm/rdwWs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYWPR01MB10361
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 18 Mar 2026 10:58:34 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/22500

Hi Pavel,

Thanks for the feedback

> -----Original Message-----
> From: Pavel Machek <pavel@nabladev.com>
> Sent: 18 March 2026 10:02
> To: biju.das.au <biju.das.au@gmail.com>
> Cc: cip-dev@lists.cip-project.org; Nobuhiro Iwamatsu <nobuhiro.iwamatsu.x=
90@mail.toshiba>; Pavel
> Machek <pavel@nabladev.com>; Biju Das <biju.das.jz@bp.renesas.com>; Prabh=
akar Mahadev Lad
> <prabhakar.mahadev-lad.rj@bp.renesas.com>
> Subject: Re: [PATCH 6.12.y-cip 08/11] phy: renesas: Add Renesas RZ/G3E US=
B3.0 PHY driver
>=20
> Hi!
>=20
> > Add Renesas RZ/G3E USB3.0 PHY driver. This module is connected between
> > USB3 Host and PHY module. The main functions of this module are:
> >  1) Reset control
> >  2) Control of PHY input pins
> >  3) Monitoring of PHY output pins
>=20
> > +++ b/drivers/phy/renesas/Kconfig
> > @@ -40,3 +40,10 @@ config PHY_RCAR_GEN3_USB3
> >  	select GENERIC_PHY
> >  	help
> >  	  Support for USB 3.0 PHY found on Renesas R-Car generation 3 SoCs.
> > +
> > +config PHY_RZ_G3E_USB3
> > +	tristate "Renesas RZ/G3E USB 3.0 PHY driver"
> > +	depends on ARCH_RENESAS || COMPILE_TEST
> > +	select GENERIC_PHY
> > +	help
> > +	  Support for USB 3.0 PHY found on Renesas RZ/G3E SoCs.
>=20
> We usually have notice about module name here.

Only few modules in PHY subsystem have this. Majority of the drivers won't =
use it.

$ fgrep -r "module will be" drivers/phy/
drivers/phy/allwinner/Kconfig:	  MIPI-DSI support. If M is selected, the mo=
dule will be
drivers/phy/apple/Kconfig:	  If M is selected the module will be called 'ph=
y-apple-atc'.
drivers/phy/starfive/Kconfig:	  system. If M is selected, the module will b=
e called
drivers/phy/starfive/Kconfig:	  system. If M is selected, the module will b=
e called
drivers/phy/starfive/Kconfig:	  If M is selected, the module will be called
drivers/phy/starfive/Kconfig:	  If M is selected, the module will be called
drivers/phy/mediatek/Kconfig:	  module will be called phy-mtk-mipi-csi-0-5.
drivers/phy/cadence/Kconfig:	  system. If M is selected, the module will be=
 called

>=20
> > +++ b/drivers/phy/renesas/phy-rzg3e-usb3.c
>=20
> > +MODULE_AUTHOR("biju.das.jz@bp.renesas.com>");
>=20
> This should include real name and "<".

OK will update as

MODULE_AUTHOR("Biju Das <biju.das.jz@bp.renesas.com>");

Cheers,
Biju

