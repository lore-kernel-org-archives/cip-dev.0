Return-Path: <biju.das.jz@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5EC32CA0EEB
	for <webhook@archiver.kernel.org>; Thu, 21 Aug 2025 13:54:02 +0000 (UTC)
Received: from TYVP286CU001.outbound.protection.outlook.com (TYVP286CU001.outbound.protection.outlook.com [52.101.125.20])
 by mx.groups.io with SMTP id smtpd.web11.10214.1755784440372428688
 for <cip-dev@lists.cip-project.org>;
 Thu, 21 Aug 2025 06:54:01 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@bp.renesas.com header.s=selector1 header.b=LP+Ekuie;
 spf=pass (domain: bp.renesas.com, ip: 52.101.125.20, mailfrom: biju.das.jz@bp.renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YnGkRQuOHhS3r7P+Sf2u5KGucPL0ZASivIex7r+Hzt2SON+x9Oq5LfTxVrir7bwIefQoYU5/+NdMLXfsJerk5egVRbf7k9Ke4QtPuAX9b8QkQUScEIXznaskf39IJcmtAadcPXQy6SZUPORhE6lPADtNtMwQrFHdZ10S4MctTsvhaXNwEJlvPouV2e90/jh8yEi+gCS5SUDZV80xMYRXABljJsoTuB6gUaR5VNaQFt6rCaejpyd+ewaHYjZ4LDQ3t/PzuEVScme7pdCIaNy3nF3aNUJeaPrc1a4kpsVk5q8+Wom2yvFsKDHr2swFhgqgR6WFuC8FAAeDSdlVp8zrAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5Y/A6PNy/3KdiFq6t95miGH92aAfiBx8sFloCOwTtRA=;
 b=Gqdx0xr4+xIogA1fNISbJDXCNIR5I7Jf3Dca2iM9YDPTrInhxe3nUN5Jss5O//7CZSIh/7AU9GIDvGzyz+AlWRASqTZtfT9kDcFXPx54msh83rLm+AlUogX9XH4wARzROwNCzI4jCOloph1oLVSDDCUfEAGtUEFgTOlBNnBB6K2jzjsD2PrShwSLEicqDNe8HkMnpsgg721a347zBTKsAwdohZ/BrdFN1FPoOSyplLJbTQfXGDYMmg9nWLwjJ+AnK2avNcoxDhWtJMAYbeD+rCALiFcX7zwDYUqJPxop6Ljb+AIiICNgwwVWmBVLw2YiPa3u7J2Z5kUtyqzF1gRW6A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5Y/A6PNy/3KdiFq6t95miGH92aAfiBx8sFloCOwTtRA=;
 b=LP+EkuieUfNo2p7hJyOSZSMKWf0V5hmlckRwPiVU5vU1aTDvXsfuoX3/bVKj8J3jgwMQqv/19tNwgCsp3r7U4BVNdMKC2wDs5I4hJM0x2Dft8w8xUHlSuCCX++k6m4NaQuTTi07WWn2FnIN8jOul4hs3DrEcIWNXaT5c0Kx3lAI=
Received: from TY3PR01MB11346.jpnprd01.prod.outlook.com (2603:1096:400:3d0::7)
 by OS0PR01MB6067.jpnprd01.prod.outlook.com (2603:1096:604:c9::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.15; Thu, 21 Aug
 2025 13:53:56 +0000
Received: from TY3PR01MB11346.jpnprd01.prod.outlook.com
 ([fe80::86ef:ca98:234d:60e1]) by TY3PR01MB11346.jpnprd01.prod.outlook.com
 ([fe80::86ef:ca98:234d:60e1%7]) with mapi id 15.20.9052.013; Thu, 21 Aug 2025
 13:53:56 +0000
From: Biju Das <biju.das.jz@bp.renesas.com>
To: Pavel Machek <pavel@denx.de>
CC: "cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>, Nobuhiro
 Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>, Prabhakar Mahadev Lad
	<prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: RE: [cip-dev] [PATCH 6.12.y-cip 18/23] memory: renesas-rpc-if: Add
 RZ/G3E xSPI support
Thread-Topic: [cip-dev] [PATCH 6.12.y-cip 18/23] memory: renesas-rpc-if: Add
 RZ/G3E xSPI support
Thread-Index: AQHcEa8T4LeK6itfoU2U89T5+h/5Z7Rs+COAgAAdaaCAAAmLAIAAA3pQ
Date: Thu, 21 Aug 2025 13:53:56 +0000
Message-ID: 
 <TY3PR01MB11346F51CC367C4EF81C149088632A@TY3PR01MB11346.jpnprd01.prod.outlook.com>
References: <20250820084645.6988-1-biju.das.jz@bp.renesas.com>
 <20250820084645.6988-19-biju.das.jz@bp.renesas.com>
 <aKcBPxrTxnIw8BgT@duo.ucw.cz>
 <TY3PR01MB11346EFFD9F8914171836AC9D8632A@TY3PR01MB11346.jpnprd01.prod.outlook.com>
 <aKch7HhlHu/Jp6ef@duo.ucw.cz>
In-Reply-To: <aKch7HhlHu/Jp6ef@duo.ucw.cz>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY3PR01MB11346:EE_|OS0PR01MB6067:EE_
x-ms-office365-filtering-correlation-id: 9a8d1de8-4640-41a3-efc3-08dde0ba2c06
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|376014|1800799024|38070700018;
x-microsoft-antispam-message-info: 
 =?us-ascii?Q?Zop/a53Zg2BTeJPGabzjCpGxu1jlhuqqK6BPQIuPQPAG7PHvZG/kQQJLbUxl?=
 =?us-ascii?Q?kexCu2UfXyk17KeT0xtdAByE7XRFTBGvDSIycwF/kd6z3Vy9mtGzUoL3RWRF?=
 =?us-ascii?Q?NBia4dadHbPqFczFocz5wPgstZvjmBQc2LCgxKkVqWF+lolUDlo02VZmGNrt?=
 =?us-ascii?Q?zlpRKGtrpoGDgwYU2OTnKDEmENiGrXGVWw/KJpfktLk5nOPcyhdXXDb8/S58?=
 =?us-ascii?Q?AAALWHBwANBR/BryEESPbzAecAe1QOExB9fchS2d9zpVTyjMaKBBu6lHFSjY?=
 =?us-ascii?Q?AnKsd/7zqFyVhcFMVCEg3WnVNSrWKxWnfJv0UU/Mc6FxXWiCY/m67+PkfYRT?=
 =?us-ascii?Q?f8wseLnFcsBXYaiMCmakQ/9WleF3FPfBJzseWZ6bX0IkrfiC0sePQZkNzP4x?=
 =?us-ascii?Q?yhUxJ6EuZeW0VGccS/Fy4LmDsTnVGf4i/AUnnfGYI70S4csyybgFztMx0III?=
 =?us-ascii?Q?vDNN2dgdRqTbP139QzmTZsdhurSm6X9uJdd0F+80GrEu2/zRjwqYfqlz/I6b?=
 =?us-ascii?Q?M/j3HFdcu0w560dupkWZmpcXrfklJCj8WlbgtdAKcRYW/cXlWpB2Rp2P+Js4?=
 =?us-ascii?Q?7m7REgt7WI0kCLaNFQUmoMiZkpLQigBEC6ybdWYzHai3CQW97UAxuT1w751r?=
 =?us-ascii?Q?ABMT4Uh0BVJg+u27uDuArvZ6XVFi6KiDh56SRQeFXWV4q1TtzzFCNBhlPGaV?=
 =?us-ascii?Q?6M3GiLp1IqtN1Oi2PXX7IXU8pY/9I2M5OLNbpb/6W5+m8We/UAYGa150PM4N?=
 =?us-ascii?Q?7PS+cE1Q26yWw1j2+gNvsy51EQO9ts630mjyb1gQxISw2B+m+V8xSHisKbia?=
 =?us-ascii?Q?tQjGyGajd2u9IPeIYOT4AC4JUto35UldDG+SuGHLK42XY7EBiD8C96Hm4C9E?=
 =?us-ascii?Q?SLzO6wW/GzZsXmIfvzkd3FSL5SCwDFtZf7zDhiAPI14iYvzt0KgmnKA1IyZT?=
 =?us-ascii?Q?Kgm1MGAdAokJUU/J+eGtvXE2Rf6aYgbNigqeWIh/V6QTbRSLeMJSLcursaza?=
 =?us-ascii?Q?TiYJd3bdbO+kVwPpoY7dsy8daFS0OZtdUZR5wOPmKc9Om4jg33zrh1mBtm8x?=
 =?us-ascii?Q?VgVq51FgKWC78iXxK9VsI6CCtxOdH16v+mIrRACU31igEhgLkj2tgJZg2Al3?=
 =?us-ascii?Q?NajR1Yy4yTK1mVagyla9kBlGJtrNTSw4vlRuhHUDNGzZsqz5tN2WTX8nlcWZ?=
 =?us-ascii?Q?htodU6PXjDkTVcl9cN8GOtq+UmwjVJ1PM3D9DAIPGN2OitfwD/R+rYrrtHIn?=
 =?us-ascii?Q?gYhzPg8CE6XTYWqwOmbdsnqOeWUPVeg/OHxCaQNfbrhxW61FX/cMZ3WKAzVv?=
 =?us-ascii?Q?KTqbAVg6P2c0bOaLiBG902cfWK8A3ClnLB2mc9OqaA8cbe1MHB16PEqLk7bN?=
 =?us-ascii?Q?xlw/NOLlDn0I3hXGhdD9eziAYl7eMTFxPPp2+3SLIDbkCyfDO6Prb/ISDp9E?=
 =?us-ascii?Q?LkXD48+IoPLZiDEvhge/6SU1koQhp+Yk+oxx4utwtMVb3jxlk1AlJIvVayxx?=
 =?us-ascii?Q?yTupBVLhpETuwxA=3D?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY3PR01MB11346.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?us-ascii?Q?U64BsERULyLQw8+QmJWq5t8ixEhcD8fFA7I2mn0Y628VB7pW0F0kVbkZo/tm?=
 =?us-ascii?Q?VQBSXEQtJYdYcRPWdyQnyuQRgkVsyCjmOCNsRG99q8RrnmKiXv4tnMvXhcuR?=
 =?us-ascii?Q?2ZjG7nTSCIDbw32enSq1DNHKo8OBv3GGG8ANevzi4fU9tXxZF9hAS7qRg/zf?=
 =?us-ascii?Q?FiD/VSOWphrN/opmJ2ZE4dpZYpYD2E9QnrVsjM5oT9f9HVY9AeWrGCbLjEFb?=
 =?us-ascii?Q?dsFCafJDhY2+cloNezU8uv9sW/hRXiWJ6G8L2Td2dq/RBmoDMIZ5P1u1g5zg?=
 =?us-ascii?Q?s5Zo6G4YQgJSMlK5Q4OnHJUQ/CArX7qsks13QRmI/H4oie5kpyQlPkdGt6ap?=
 =?us-ascii?Q?e/PYFQFwAJkJjKWegQvVT85GFeXMNJD8J55dxUv1kRZ8ZCUUwPHBr4QQdI5w?=
 =?us-ascii?Q?mPYIXudHsiSAv1xJG78HycJ6sBaNkO8efGTfTWkVWjCFItvWM7uBNl8N+hFH?=
 =?us-ascii?Q?/v0I6jiJ6AmuW5wp8kEVkowOpuD6yt3pTjNWKnlvYBTHFDRF2/ghvcyBM+qJ?=
 =?us-ascii?Q?25KBd9WVsBbAAWDMYDl1rlGr/5t8zbOM4o5kYGq6A8nyc9Dzo9NEcOMl1uk5?=
 =?us-ascii?Q?4CqJF1buF+jjg0xOalZuVsAwQTfiebv0QoQlua3O07wFImw5+PnaOS7NPKfY?=
 =?us-ascii?Q?lpaYhyIfXSvj0LeY32hpkhtlnGJpc+K5U5uk+uZHQXesKqtHCiq7XO2bQHDL?=
 =?us-ascii?Q?h6NOpqKuSz+Nr0zjK4o024TsDqFILk1NRBZxx8b+2ESrvl/lmlf82yZ+qre3?=
 =?us-ascii?Q?Z3vzCcCXWxVxSItVhYhnpAv85f62ZekzFzjAMQDBV84rO+/XcxN7VckEaUVl?=
 =?us-ascii?Q?AYe/WtDScvTGlY4L3eDQ632vLWF93hYz2gdG3xvXpA2ISfPqTTYf6nbYl8dm?=
 =?us-ascii?Q?kfYZc1gBC2OVrK/knSyuyXQbyJmRfCeeo1JYatRAeZDXYSbmkrgQpDTWUZZC?=
 =?us-ascii?Q?aWlavIPabpdigaeXfYrCyIlJf2j8hsWx/BoIttt8vVp9n0H4SpRysFSHWFc0?=
 =?us-ascii?Q?uEtZRMSBXxWUJ5vp8l/6XDPdz5O2AtmkeiNdDAUHNMByve8YUh8T7aKHd2Bi?=
 =?us-ascii?Q?lZgyofZcB5tm9jfGt6zVJy4+NgoFAQX6XNiD+CC+9ots3kY0MiQ8FWqS5pad?=
 =?us-ascii?Q?cNKyeXNIxVenyw194z++PxLMqeDS3z1/FT8m1kiqxTH2kpf1XdO+ZPiawmpV?=
 =?us-ascii?Q?9PZmO932x10fUfRh6piXusoL9Is6X+8XVPhSCDTFgulgrb0TYT9Ho6vwvhgj?=
 =?us-ascii?Q?Sb2B2q9dB7fz/K17RCOdZlPNR/A9xtEvzntj7tWDqJlFEaQ3iByIQz9ghyuG?=
 =?us-ascii?Q?KF8mtU0rG7ldQJuskymC6llIokNwrLnhf0UQdVg8glCh/9f0+RiNaT6Rrxbc?=
 =?us-ascii?Q?gYx4mUEUk88Pk5x2TySX26BoBbJcAZner5sETgPSMvgX6Woth837cSmGnsuL?=
 =?us-ascii?Q?Pnrrsgf+UdjHRQUywTFcIs8lpzcIQq1lz+97IUZ7INJNy/IvSbYUr2iMhk0+?=
 =?us-ascii?Q?gOnU2QXuf6SeMFp3GaGi79us7Vw4JkgwxIO1yuwMAl8uN0jlBCsx/feY+3sL?=
 =?us-ascii?Q?LP4T3hbPDvdYsXn1GsP1Q6+C26ZCK8CFauTXo9WzImWnurA2VkYuVTpZOw55?=
 =?us-ascii?Q?Rw=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY3PR01MB11346.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9a8d1de8-4640-41a3-efc3-08dde0ba2c06
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Aug 2025 13:53:56.3479
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: TPaIafC6g1YxkiHtqqAJjiJyCSxNmlsHITb/sGGnKwJGnNKUCTZUoNV4AnmTvqbqFlBMo07adPlg7gsEVtpfzassU8/p8EJk141uC/qg+v4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS0PR01MB6067
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 21 Aug 2025 13:54:02 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/19937

Hi Pavel,

> -----Original Message-----
> From: Pavel Machek <pavel@denx.de>
> Sent: 21 August 2025 14:41
> To: Biju Das <biju.das.jz@bp.renesas.com>
> Cc: cip-dev@lists.cip-project.org; Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@=
toshiba.co.jp>; Prabhakar
> Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>
> Subject: Re: [cip-dev] [PATCH 6.12.y-cip 18/23] memory: renesas-rpc-if: A=
dd RZ/G3E xSPI support
>=20
> On Thu 2025-08-21 13:08:33, Biju Das wrote:
> > Hi Pavel,
> >
> > > -----Original Message-----
> > > From: cip-dev@lists.cip-project.org <cip-dev@lists.cip-project.org>
> > > On Behalf Of Pavel Machek via lists.cip-project.org
> > > Subject: Re: [cip-dev] [PATCH 6.12.y-cip 18/23] memory:
> > > renesas-rpc-if: Add RZ/G3E xSPI support
> > >
> > > Hi!
> > >
> > > > commit 687cac9559d8e9277830bdfb68b57d7403695b1d upstream.
> > > >
> > > > Add support for RZ/G3E xSPI. Compared to RPC-IF, it can support
> > > > writes on memory-mapped area. Introduce struct rpcif_impl for
> > > > holding the function pointers and data to handle the differences
> > > > between xspi and rpc-if interface.
> > > >
> > > > Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
> > > > Link:
> > > > https://lore.kernel.org/r/20250424090000.136804-7-biju.das.jz@bp.r
> > > > enes
> > > > as.com
> > > > Signed-off-by: Krzysztof Kozlowski
> > > > <krzysztof.kozlowski@linaro.org>
> > > > [Biju: Squashed the commit 798dc3f19c9e
> > > > ("memory: renesas-rpc-if: Add missing static keyword")]
> > > > Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
> > > >
> > > >  #symbol 'rpcif_impl' was not declared. Should it be static?
> > > >  #symbol 'xspi_impl' was not declared. Should it be static?
> > >
> > > Not sure where these #symbol.. comments come from. They should not be=
 here.
> >
> > I agree. It is a mistake from my side while squashing the patches at la=
st minute.
> >
> > Do you want me to send a patch for fixing this or you can take care whi=
le applying.
>=20
> Problem exists in 6.1 series, too. I believe we can take care while apply=
ing, no need to resend.

Thank you.

Cheers,
Biju

