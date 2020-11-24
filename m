Return-Path: <SRS0=JMcL=E7=lists.cip-project.org=bounce+64572+5879+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DATE_IN_PAST_12_24,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3EF69C63798
	for <cip-dev@archiver.kernel.org>; Wed, 25 Nov 2020 13:48:22 +0000 (UTC)
Received: from mail02.groups.io (mail02.groups.io [66.175.222.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3CA122065D
	for <cip-dev@archiver.kernel.org>; Wed, 25 Nov 2020 13:48:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.cip-project.org header.i=@lists.cip-project.org header.b="xCorD7ba"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3CA122065D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+5879+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id 2eOoYY4521723x2t2nvX2RgR; Wed, 25 Nov 2020 05:48:20 -0800
X-Received: from APC01-HK2-obe.outbound.protection.outlook.com (APC01-HK2-obe.outbound.protection.outlook.com [40.107.130.132])
 by mx.groups.io with SMTP id smtpd.web10.866.1606240999633715197
 for <cip-dev@lists.cip-project.org>;
 Tue, 24 Nov 2020 10:03:20 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iydvQV+jQBzJgiGgKQKO5fNUCw6IB1sIE0jJ22aO+lwKB5kdw4I4IjjtHvo/8b6mfl8tyV61+CQSPbL6oubh1H4nt1mp4OiilgFiSW7xUKhYi03bi0B2Vt7NZjH7KXHEB7OFEPyuDoyUmVZoF4GXxP0YbYux03O9fG4OykhEw4/VQwPD1U2IcA+LjQw6h4yWQL6kgMkEBJKqCUFpa7NsbB0QJpIJN+I0hCvgikHUZJOwFeaeDeemclFDb883yGh6IFLhtrdPAeqm7nhWEiQbNhgjGj0iONLC7d9d0JAdTqdSuFsgSIr3KjA6uPjNK7+iIhcC4T1J7pckEmjREZm0kw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oy56IRsOF8GyGPk6dnl8AX6W+GL+a2mAMDox6hgCzvw=;
 b=FRfBit5ZthByp7XIp5MgqXRb1AC6IQYqvcGxg7jjkaJn1/H9hYHVD9ViwmMkp58fWKBuM52aYnD/gEMnZ8GyVifgD51ZMI0XzZnWPTlL/DvxJvGUKD+EZLDCDEZNIzvfHwrGcOzT4dLu25mLBDH3lmqSPce97PQllRhwDt070owXYpQyG3oqXJLZDUIrqQE4QJb4tqnoXbWIqaK4ghfFBlJr3I5pgHJGA4jUpAzsoGCM+RHYMwSapgb/mIcu2h/jKEDQ39VPYyDdFYtJhjo1txyIl4HA1OR6dOfU/9NtikDLi2zUun1H1LOUhDAzyK29VP1XD8HON9TATdGSwX4B2A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
X-Received: from TYBPR01MB5309.jpnprd01.prod.outlook.com
 (2603:1096:404:8025::15) by TY2PR01MB3178.jpnprd01.prod.outlook.com
 (2603:1096:404:7b::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3589.25; Tue, 24 Nov
 2020 18:03:15 +0000
X-Received: from TYBPR01MB5309.jpnprd01.prod.outlook.com
 ([fe80::5d23:de2f:4a70:97db]) by TYBPR01MB5309.jpnprd01.prod.outlook.com
 ([fe80::5d23:de2f:4a70:97db%3]) with mapi id 15.20.3589.030; Tue, 24 Nov 2020
 18:03:15 +0000
From: Biju Das <biju.das.jz@bp.renesas.com>
To: Pavel Machek <pavel@denx.de>
CC: "cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>, Nobuhiro
 Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>, Chris Paterson
	<Chris.Paterson2@renesas.com>, Prabhakar Mahadev Lad
	<prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: Re: [cip-dev] [PATCH] dt-bindings: PCI: rcar: Add device tree support for r8a7742
Thread-Topic: [PATCH] dt-bindings: PCI: rcar: Add device tree support for
 r8a7742
Thread-Index: AQHWwojthdOxDuNAf0aMz5oC//e2I6nXkakAgAAAObA=
Date: Tue, 24 Nov 2020 18:03:14 +0000
Message-ID: 
 <TYBPR01MB5309F702E453CCBB5987FB8186FB0@TYBPR01MB5309.jpnprd01.prod.outlook.com>
References: <20201124174036.14934-1-biju.das.jz@bp.renesas.com>
 <20201124175808.GA2713@duo.ucw.cz>
In-Reply-To: <20201124175808.GA2713@duo.ucw.cz>
Accept-Language: en-GB, en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [193.141.220.21]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 4f7ed582-0ce0-41bb-96cd-08d890a3370d
x-ms-traffictypediagnostic: TY2PR01MB3178:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: 
 <TY2PR01MB317807F9855C248AF89C704F86FB0@TY2PR01MB3178.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2733;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 
 LnZu+P+ZIwhcpGmUQ1zhqPqmS9By1ZTXlpIWGo/JK6WL19etOw0Q3bVpx1QlNQvbElqYMeKhyNQeZDVpDfFxQh64LclLwQ5yvbiVq0C2adKtlhTMTuMxhMVbUXZSTTiDlOKWvKCmvM0ClsrbCs4QsecuWNjU9CWnFwohhqSXghGVRcnw9lclW+2jq0qWPS3lgEiOG1ZFbDUDSGTl2Gqb1fLyIu2hQgEbIfePMxaJqHnG+dWTqz29YCFDEQ0WuSNemighU0QO/WAopGZWckdMDPkajL7EcxguAiz3BeDHO3mWLd1Ur14Jz7zQMmRkqsm0UBQfbeg8nKX3hhRKgpiC4PQI+FgflnR28/YBBu9hD8vKb2LQadqhO8iU9A2K7SSsBXdAmJn/qbyG4Hi/HhM1iHC9mXjlvpxo0kVMdcdUq9v1d/f2klz2XohWn2VQW6l74DMbUEsVzGMg2dfu31gJmw==
x-ms-exchange-antispam-messagedata: 
 =?us-ascii?Q?yahnEKaXW2W+EgsX1zD8MhQ/c7DZavmVzym7IZ5rnsnHzAhGpidiAr6bNs36?=
 =?us-ascii?Q?WGaBiGBjW1+oBlkml8neP3Qx/p8gmn8E42CAKz0hgsWMXfj/NTPP6pkwKoJB?=
 =?us-ascii?Q?WXOA25Tsm5QuN8N7nLpH37jM4B1KakVXSSCKiu/dcNyousbMWMghWECxmQuZ?=
 =?us-ascii?Q?BtYvoui4FbX+pNBiByi5C6K+U+fnwyAV5/duigMT0f8HCaR89t260oN3bHJ5?=
 =?us-ascii?Q?JC7Igrn6HhRb+lrdKmQIVyjNH5XEriYsgKzagmeeQfQXx3GsD4YYM2/txaGH?=
 =?us-ascii?Q?0N50IlS+SUZSjhCgImlpyPy82TRk6ESO5UgpUxdgK9qY5vzEhNNZPUllSmdG?=
 =?us-ascii?Q?GksiFDWuK1p/Glc/Ht9tijYNLBS4YQUvMrtvZFZ2RdsdnzlUqlFRGzwl6Bf6?=
 =?us-ascii?Q?SO/mCqcRSI1OQeU1SXcHWDOibdc7qTklspdJUBU1yZU8cK+KJpiM6k5WLOgs?=
 =?us-ascii?Q?8yB8Yh19ZCIX/uG5UAWaHpIOCvuEQj//BjWKsUt2DuQzFyX1w3rNkSuoCxiD?=
 =?us-ascii?Q?+gPshS8nXPui3NjPLxgUaVbGf8Dcm5F8PaY0NvfF6A+sBU9QBIg8UHzRgBrb?=
 =?us-ascii?Q?pHL+OPpR70DQ+rABvbXD4ROKFuzAXr8EQ6TCnzHSaS/WaK+c0xtRk1W40q6D?=
 =?us-ascii?Q?u3DJsMTHobaG06eQIu/MJyEDOxRLHiCONQHXdD3kI+LblxIn+RgJMilAVLYN?=
 =?us-ascii?Q?WcGa2iWXLT/W1HnvF+7tNIViTKBIp3QSsSGpNEBmwb63Wb1Pwy4txwdtlHbM?=
 =?us-ascii?Q?GhxDEjEv4GP/cRNJfMwx16zYQHLV50V2gCV7qDM8IR/bZEfj2H2kApH9z/pD?=
 =?us-ascii?Q?v08plrhwGSoDUGfhwVKFpaYN4jeeEnINDQCGGwfGrHgc9K2ZsoFjj70Kx7fQ?=
 =?us-ascii?Q?bvmRlztAddqbmlhZxtWDrd4he+R/xdOEHAmPawQ6WJacsPF8Oy9r55NHnek3?=
 =?us-ascii?Q?21wP+bZhKnqxEww3XyOh8LYV7OrKx4lpWoUU7l7L1+0=3D?=
MIME-Version: 1.0
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYBPR01MB5309.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4f7ed582-0ce0-41bb-96cd-08d890a3370d
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Nov 2020 18:03:14.9815
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: VhEQJ3bWXZFO7ybnW7lHf/nw2T9sIcy5FrPueWmOcPmT6NvIwGmi1AvB1E516LLWXATi0GXKyyuRvp7mkC4b/W7wGcgAkq1jJaDQ/4o/Bug=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY2PR01MB3178
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: 1SZkByUeMqJMPvZ2PwWoYFpRx4520388AA=
Content-Type: multipart/mixed; boundary="F8pNv4IdAV0uDedDcCvT"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1606312100;
 bh=Wcj3BcgTERqI/5F0RaLlDO3waLsLRaZnnbScSS2U8V8=;
 h=CC:Content-Type:Date:From:Reply-To:Subject:To;
 b=xCorD7ba8MoQ+gHx0jS5/SH1simcnfYYNHs1R6/9QFVsn5xKvtbZDhYEN0N+SmbfTY1
 MYDlps9nU+3xBxi71M0F8NP8scwS/snUD28suZpvFAAlLQ+wtsNwmZBN4WjHkuydPrAQw
 IdcBVG8KYgmWtYgt78d2l147NcRl1RQyKfU=

--F8pNv4IdAV0uDedDcCvT
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Hi Pavel,

Thanks for the feedback.

> -----Original Message-----
> From: Pavel Machek <pavel@denx.de>
> Sent: 24 November 2020 17:58
> To: Biju Das <biju.das.jz@bp.renesas.com>
> Cc: cip-dev@lists.cip-project.org; Nobuhiro Iwamatsu
> <nobuhiro1.iwamatsu@toshiba.co.jp>; Pavel Machek <pavel@denx.de>; Chris
> Paterson <Chris.Paterson2@renesas.com>; Prabhakar Mahadev Lad
> <prabhakar.mahadev-lad.rj@bp.renesas.com>
> Subject: Re: [PATCH] dt-bindings: PCI: rcar: Add device tree support for
> r8a7742
>=20
> Hi!
>=20
> > From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> >
> > commit d16d538ff49145b153976bd8e124116d369db266 upstream.
> >
> > Add support for r8a7742. The Renesas RZ/G1H (R8A7742) PCIe controller
> > is identical to the R-Car Gen2 family.
>=20
>=20
> Sure, we can apply this (I assume it is for 4.4)? But it will not really
> add any support, it just documents the binding... so I assume this should
> go into series with patches that actually change the dts (and probably
> tweak the drivers)?

We have already backported PCIEC[1] to Linux-4.4.y-cip. Only dt binding pat=
ch was pending.

[1] https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.git/commi=
t/arch/arm/boot/dts/r8a7742.dtsi?h=3Dlinux-4.4.y-cip&id=3Df7305b488be9e3048=
f0ee30bb7a83d6041728d7f

Regards,
Biju


> Best regards,
> 								Pavel
>=20
> > diff --git a/Documentation/devicetree/bindings/pci/rcar-pci.txt
> > b/Documentation/devicetree/bindings/pci/rcar-pci.txt
> > index bedfdc122543..8a3d8b5be515 100644
> > --- a/Documentation/devicetree/bindings/pci/rcar-pci.txt
> > +++ b/Documentation/devicetree/bindings/pci/rcar-pci.txt
> > @@ -1,7 +1,8 @@
> >  * Renesas R-Car PCIe interface
> >
> >  Required properties:
> > -compatible: "renesas,pcie-r8a7743" for the R8A7743 SoC;
> > +compatible: "renesas,pcie-r8a7742" for the R8A7742 SoC;
> > +	    "renesas,pcie-r8a7743" for the R8A7743 SoC;
> >  	    "renesas,pcie-r8a7779" for the R8A7779 SoC;
> >  	    "renesas,pcie-r8a7790" for the R8A7790 SoC;
> >  	    "renesas,pcie-r8a7791" for the R8A7791 SoC;
> > --
> > 2.17.1
> >
>=20
> --
> DENX Software Engineering GmbH,      Managing Director: Wolfgang Denk
> HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--F8pNv4IdAV0uDedDcCvT
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.
View/Reply Online (#5879): https://lists.cip-project.org/g/cip-dev/message=
/5879
Mute This Topic: https://lists.cip-project.org/mt/78482468/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-


--F8pNv4IdAV0uDedDcCvT--
