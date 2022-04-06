Return-Path: <prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9181DC352A7
	for <webhook@archiver.kernel.org>; Wed,  6 Apr 2022 16:33:19 +0000 (UTC)
Received: from JPN01-TYC-obe.outbound.protection.outlook.com
 (JPN01-TYC-obe.outbound.protection.outlook.com [40.107.114.93])
 by mx.groups.io with SMTP id smtpd.web09.6333.1649235296102243660
 for <cip-dev@lists.cip-project.org>;
 Wed, 06 Apr 2022 01:54:57 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@bp.renesas.com header.s=selector1 header.b=DD5wVMmK;
 spf=pass (domain: bp.renesas.com, ip: 40.107.114.93,
 mailfrom: prabhakar.mahadev-lad.rj@bp.renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BkYmbFZNPx+gly9eHDjykG39fgSrxIjqD93qfTDUIa4lya1M2Ofc5R6RygcVtIJddB6/xB0IZbNnoVuAMhxPqjCg0uqtzGhYzWO+uZWATL718mUxKMXgkzgP4UzNqbuBXLpyzQrUqeqqTA3zpHlHwAWdHMUd+XrrXHGk9YzEwqOSNjFDYnqtI1JN+vGplAHRJtoqwyNOlBTQKMQp6FfIsY36X+PcXtVMDzQmBr+kblEhDTSbwuS7MJnC3Shv/B72hGWVkuu5ZwtT7GX/6FUxM0MDdOTUqklieT59idQASAdb0X0/Nx/yDmSYv4PuXVByB+/xfisUq4nqiD6BdrSKBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9iUhAD4QlSUbXvoe3Z3qUvGr79+MNmuDscXFeDLbDJk=;
 b=DWSzTPqTzREH2VJWBF98hQhiGTFhdjYg+ovD7H+AGtw9pRExiU9H/jn5us7E16GnuegPRW24t+bpsSXOqhf4dDZKwf7+pWAZo0Z4edOcPZe7ckco03FaeC+MQEp7opH1la9uJxqi0qmYA3G3CVZbbgNJ/vqtHKoV+jbwUSnulSDWMWgYNMv6Q/6GWL0lZV/QDe4wU9yEvbTecGRQTRhjAn9yy/kNVEyt3kRoVShR/hNsX5r/8pfgE5nE8vRlvoBZoJnteBXRRH6oGWGq+3x0n/ITNqRgxuYG+OBzDhKn49wRSdiecae41SIDEQvXQBNdWSwLZ8eKCqIKvNBe2FYEaQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9iUhAD4QlSUbXvoe3Z3qUvGr79+MNmuDscXFeDLbDJk=;
 b=DD5wVMmKSK3NJNzffsyxq50RZOxsvpRBdk3etxFMxF6pc1420Ns5GaQmExnzeRV3nhIFBC7le0vW1/i7f2Ama/qZw428SQQga68Z3VSMsYmPO595UL+Wi5maZ+KB9Dgb1Ym3uMzRfx3iOwk181a71pSmv/6tnKZTs2FFxXdtKEY=
Received: from OSZPR01MB7019.jpnprd01.prod.outlook.com (2603:1096:604:13c::8)
 by TYAPR01MB4926.jpnprd01.prod.outlook.com (2603:1096:404:12a::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5123.31; Wed, 6 Apr
 2022 08:54:51 +0000
Received: from OSZPR01MB7019.jpnprd01.prod.outlook.com
 ([fe80::9dda:1c9e:4a15:bddf]) by OSZPR01MB7019.jpnprd01.prod.outlook.com
 ([fe80::9dda:1c9e:4a15:bddf%5]) with mapi id 15.20.5123.031; Wed, 6 Apr 2022
 08:54:51 +0000
From: Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: Pavel Machek <pavel@denx.de>
CC: "cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>, Nobuhiro
 Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>, Biju Das
	<biju.das.jz@bp.renesas.com>
Subject: RE: [PATCH 5.10.y-cip 23/29] clk: renesas: r9a07g044: Rename
 CLK_PLL3_DIV4 macro
Thread-Topic: [PATCH 5.10.y-cip 23/29] clk: renesas: r9a07g044: Rename
 CLK_PLL3_DIV4 macro
Thread-Index: AQHYSR+LfeA15jyktkKIUlOxIb6k06zilS0Q
Date: Wed, 6 Apr 2022 08:54:51 +0000
Message-ID: 
 <OSZPR01MB70199F6D20E27C53D2F44D2AAAE79@OSZPR01MB7019.jpnprd01.prod.outlook.com>
References: <20220404123553.25851-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20220404123553.25851-24-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20220405190118.GB27445@duo.ucw.cz>
In-Reply-To: <20220405190118.GB27445@duo.ucw.cz>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 80c1941d-4b17-4c82-e78e-08da17ab1ca5
x-ms-traffictypediagnostic: TYAPR01MB4926:EE_
x-microsoft-antispam-prvs: 
 <TYAPR01MB492662527AC909EC627CE9B6AAE79@TYAPR01MB4926.jpnprd01.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 5oFqE7XlUrpQUMMveIoWSb7eOpjnPmH5jCM2493ckpO4+OV7rVHclEx4IgEo96+8sWzuyV53XVPafQaJ0DWiVltwcrEe0JdsCJAGFLNKA3Ox0lSOKs496e71FrxQC1E2QYvC0v6MegmOhYLOHo6i7DPQxPBT8WTzIY+tGln5ERcglNvarF70JFYSfw2Gxo/M+h+qD+OHAlBw17+uACEUpVlsDiF0W+hXGxbRseYL+QQCxGif3O5ax/xlWJtqwwotF2n9KkAJUmgVGu8SsNXcMvdtik92TseBhtjKx4TIgRtc9AXBTgzp/erRva+FZ22tHvWPMNnn31Dw2GqjoqyDh7bODeoliAB3eTM9pCGSx+Q6K5vyUA+pgncO8Z9SdxbK2Ts9dkd2S2ToYNLMeJYXR6FBflKS402eURHs0F2W+mAArh79FrVE9E4KutBbOvlcqJCAlFnO7Cm/zr+pfFBQo/2C9Q2de1q/JhEETwHl+wCRPbDdHfic8CWyeT79Z+6f3hzy9HjbyvBcc2rcfwz+WgTHG4FqCmMeTwX5fZi27+amcLJ9MYPWBpScgwyeUeHppDxreyVLQ56VvHoMZ+MbgfmDn2PDYmaM7H0MF2BBqqVQCdauTlcAAhiGl6DTXeo0eNjncI3Yw26x1QjrPSGmFOliQYGBwB1wFkQ58p3HxwcLHNOlgSfgF2Ndb7nKO4xFJTandhhaSqFsf3Q2rGFQrQ==
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OSZPR01MB7019.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(6506007)(7696005)(8936002)(2906002)(33656002)(53546011)(52536014)(9686003)(86362001)(5660300002)(122000001)(38100700002)(83380400001)(38070700005)(66446008)(508600001)(55016003)(54906003)(64756008)(26005)(66476007)(6916009)(8676002)(186003)(316002)(107886003)(4326008)(66556008)(66946007)(76116006)(71200400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?us-ascii?Q?gjCdr8y/x46gjm+lptNtOQSjgSBLMMhHGFrwxxaDKY320noBZn39GYtS5qPr?=
 =?us-ascii?Q?xjpPPSk4hA49BmaL1pKJYJcti16MWYx2iXIP+nKfVbSAnH8t1XlcQYmzCv3I?=
 =?us-ascii?Q?ova+vmM0buozA+qW2Du6Qq3FpfSvsfccHwKufKKAkt7VL+/7GQRACE9jAhXE?=
 =?us-ascii?Q?/KYXF6ih1qTi+FlN/yDWzSq3rJR7HkBU+xjmgpoElGUJidAuQd+1hzVy5Nmw?=
 =?us-ascii?Q?irtkcf8dNZ9vZ4uCPMON1CbGRopx0eKAghfyYQZZh3uGh1+i3J/5RUogr0CF?=
 =?us-ascii?Q?+/6Z1msRsCV5nWM5Whtg24hKlIPyPQsMGv1YNXRD3p3gn1gwPhYxDQFKnBBP?=
 =?us-ascii?Q?+4yFTs72pIJm1GXDb9h4KOCYI5wDHig4vp4sGCumK7K1Hi3AFeoJgiNgsVoc?=
 =?us-ascii?Q?5VSuwwNFd4vFihzkQnPLIn4vCHBUwLKzIXoLJVw9eg2p+ikd3w02BcjCExu7?=
 =?us-ascii?Q?Fh9n9IK4lGWgV9UYAz0gqNdKEwcrqqy/Gre8VQfmdVJrFiJTp63cfctL9GgN?=
 =?us-ascii?Q?iO7GTS4cgg5lFRVG2VD7cfYsyPLzRTArk0IWJCuYt+RgsWyLaKPZh05ZBxR5?=
 =?us-ascii?Q?NJYt3DEgBhHSYkyuC25uyfOO0NcoO0kBuC8246SwPfnYtjNY8c8Lhxu1l1Bv?=
 =?us-ascii?Q?5YRJwGNdXyV9a5QAexrTO0Jo2DhQaWph5lm5A8Jaql7Hy6fBYLGgLiRoOo6U?=
 =?us-ascii?Q?ul/y/3ve9CMtWyrv9r4t06bb7oz2L0/vCuGb2DJKZXXqt6Vm/73iOJ8JpKT/?=
 =?us-ascii?Q?K5HAGFuGeN7Krjv/ld880j4UP7zGbAI09K3FIiTsTATCIeTmMNPIZkfP5MQF?=
 =?us-ascii?Q?zJLFdjHRXjN/WvG7hhoDdm9okYjm2ZRydwCjiwRdlfC+xIQ/1S791xS8/nDx?=
 =?us-ascii?Q?Zlzwbo748z5Fnqx13RqvgBzLQkjAtWbag5P9dnMo6ZT7cvptUl+awuPBmUSU?=
 =?us-ascii?Q?vYlqXqejHnl1fnM8OzVn/lHceuxXHPfTU6/hKHtBJcg95wGE0VlInV9RwbaT?=
 =?us-ascii?Q?fe7i8dmd9MqgUiUHa3fJoEJE599DhSynCSUcMVl1BNzYAu9LADI6OQHTOkFP?=
 =?us-ascii?Q?HTqye2+4SbRz1eKXFA9M5lN/efUj7RxgnTlt9L22I/f4T3c+lxJv48uoUJSM?=
 =?us-ascii?Q?PhXVEQVgW7QkTsdVgi66UcsJiSeUANaq5rEGwSAFMR/vIOACOjxEtpfj+dCB?=
 =?us-ascii?Q?Bx7fu8PsmDHVPfmVXTYpboczuWA1kizEq6FAheSt87VyARCbE232xm7Yf1J+?=
 =?us-ascii?Q?LFpzyFuZAjMCJ0Uxxqs85uzl/GlMK959EAzs1oE5rDKMOmFhYD6V8R2y/7Y1?=
 =?us-ascii?Q?hs1UXmHtumz4Wq8uYId3xvapQRv2bUWJoc9qsygTt67u8ePi4x/P/FVH9x+s?=
 =?us-ascii?Q?ezyPQpGGTd3E8xQIeZblo5dPXiwOVQ4x2yDV6NObLg86dlt346nz50k4h08y?=
 =?us-ascii?Q?8eZrhaOspUv5A+tzSPce1G3CA1AombJKP8Yy+mlgJ7+F5EvcL6s8yKDfHoAa?=
 =?us-ascii?Q?0OaUhIv66KtpMO6s+7C/AYF2dQ0dzevWhSqv8IXOwwLGgpA8v6iXCxHfBy0q?=
 =?us-ascii?Q?Rxms/BzFIcgZfpetWo0Pmb2tsYA6/BVz5uen4hk2m/HzWuoTgvSJ+L0+vaCT?=
 =?us-ascii?Q?PBt9ThVdNk7+qlm1H9NRGTnuvE2OagKtl6VaXGWc2InqnvOCIPXDZ04BnefS?=
 =?us-ascii?Q?om+lUBWXiCykN7XWRzEepEyMm2rzrEYl47kKX2ELtA9nAJKYakhrncZTPcsp?=
 =?us-ascii?Q?ec7IVExN9MEqlG0ZTYCwd7bCvhvxSqa040Ac1mtoj0PHIsAZzt1+?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OSZPR01MB7019.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 
 80c1941d-4b17-4c82-e78e-08da17ab1ca5
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Apr 2022 08:54:51.3202
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 
 HvA9/mjjBukQZugXtzHrvvkg7505VavcT9bAtmEYdRYa4ek4LvnvWUV6Kd9cjf+Ll0od/1t3K4KVf9PuHNamTbQtuUkiBwPSwNOTtvjcHxgG1bY04OMOald17Axe2Yv2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYAPR01MB4926
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 06 Apr 2022 16:33:19 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/8013

Hi Pavel,

Thank you for the review.

> -----Original Message-----
> From: Pavel Machek <pavel@denx.de>
> Sent: 05 April 2022 20:01
> To: Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>
> Cc: cip-dev@lists.cip-project.org; Nobuhiro Iwamatsu
> <nobuhiro1.iwamatsu@toshiba.co.jp>; Pavel Machek <pavel@denx.de>; Biju Da=
s
> <biju.das.jz@bp.renesas.com>
> Subject: Re: [PATCH 5.10.y-cip 23/29] clk: renesas: r9a07g044: Rename
> CLK_PLL3_DIV4 macro
>=20
> Hi!
>=20
> > Rename the macro CLK_PLL3_DIV4->CLK_PLL3_DIV2_2 to match the clock
> > tree mentioned in the hardware manual(Rev.1.00 Sep, 2021).
>=20
> Changelog says rename,
>=20
> > @@ -106,9 +106,9 @@ static const struct cpg_core_clk
> r9a07g044_core_clks[] __initconst =3D {
> >  	DEF_FIXED(".pll2_div2_10", CLK_PLL2_DIV2_10, CLK_PLL2_DIV2, 1, 10),
> >
> >  	DEF_FIXED(".pll3_div2", CLK_PLL3_DIV2, CLK_PLL3, 1, 2),
> > +	DEF_FIXED(".pll3_div2_2", CLK_PLL3_DIV2_2, CLK_PLL3_DIV2, 1, 2),
> >  	DEF_FIXED(".pll3_div2_4", CLK_PLL3_DIV2_4, CLK_PLL3_DIV2, 1, 4),
> >  	DEF_FIXED(".pll3_div2_4_2", CLK_PLL3_DIV2_4_2, CLK_PLL3_DIV2_4, 1,
> 2),
> > -	DEF_FIXED(".pll3_div4", CLK_PLL3_DIV4, CLK_PLL3, 1, 4),
> >  	DEF_MUX(".sel_pll3_3", CLK_SEL_PLL3_3, SEL_PLL3_3,
> >  		sel_pll3_3, ARRAY_SIZE(sel_pll3_3), 0, CLK_MUX_READ_ONLY),
> >  	DEF_DIV("divpl3c", CLK_DIV_PLL3_C, CLK_SEL_PLL3_3,
>=20
> but macro arguments are changed, so I want to make sure it was intended.
>=20
thanks for the eagle eye, yes the change was intended.

Cheers,
Prabhakar

> Best regards,
> 								Pavel
> --
> DENX Software Engineering GmbH,      Managing Director: Wolfgang Denk
> HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

