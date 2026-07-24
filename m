Return-Path: <biju.das.jz@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 769ECC531FA
	for <webhook@archiver.kernel.org>; Fri, 24 Jul 2026 11:26:08 +0000 (UTC)
Received: from TYVP286CU001.outbound.protection.outlook.com (TYVP286CU001.outbound.protection.outlook.com [52.101.125.35])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.16829.1784890756485921615
 for <cip-dev@lists.cip-project.org>;
 Fri, 24 Jul 2026 03:59:16 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@bp.renesas.com header.s=selector1 header.b=fbC8QWp1;
 spf=pass (domain: bp.renesas.com, ip: 52.101.125.35, mailfrom: biju.das.jz@bp.renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=seJQUKGyQVGpxaGmdtJ3y5O7h7YjtB2wCc9SgJxDkPnJ6mY2XWFH7r9qBWEx6zbg/QrFf1CFh0UC5qSg58Uz6Cmp31rWhuvPPmWj2TWVEsQnRc8dfSoQfxSz9AblCFQVZMu5ZO6rbyy5TZf+OwGo1w8zwypdAZMoqpUXZmNZcZMvx5QmSjJdQcN3dNelykdNCD1H2s5lPN6vR9Om2XYVUHBfMy9ksC+yJumh8u4lOokj852OOk8ckDFDmwb7EyrqOORs4hUKofKsL1MWhEOfIWSpTsDIKS37IiEnzExMqIhbjxza+qZd9/AG3q/9uTsc0m5+0gGmIhjgUnYqhrZF9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Y1B7VZQpOP3VUkqspyGR6GVY3Qo8d5kUboLPSQZGcX0=;
 b=Jv7saxILwYCtuExp8sZ/fWccYZTP9d1eg/y94/oY+50dOzdtXgw9QVGPMZuVSE703dzlZvkUCczQBN5U6MaYSXSUe312PdtoHq2XMwxPZhmTG5h66v41Dz0P+8NilxX8r3sIV1tvU5KcLUIpGEEi+d+1teLAEOVPH/ryXxfvFPBDwUses9AkV42OgAFqrZuirsTj4cRETOTHfRLP6uNtR9O1ZSyKUtsmN7eb1ohruUf/tReyIPYujL5rdiZoc3HOeOTLuYugxLmm2/KYaNlC98q+3w+omkRJAuCa6hbpfCbKJSDEYQcVCGXBj5+voOHvNEXldkT0gUjr05U5ujRzVA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Y1B7VZQpOP3VUkqspyGR6GVY3Qo8d5kUboLPSQZGcX0=;
 b=fbC8QWp1LNipu1IXl/EHqPTDujNBcM+e/JYoTo0CKxY45l8HYFn/bKGGSmlRZvfGwdJGVVFecC21BYZtt10xIkPDlX3hcYgyO7nZ+GEjSj5/VSJBNV/9EuXt55Jez1jmwtmdZhIHO3QFZcDl5H4UQ/wPRwtI1lWa9dnqJeo9LG8=
Received: from TYCPR01MB11332.jpnprd01.prod.outlook.com (2603:1096:400:3c0::7)
 by TYWPR01MB10003.jpnprd01.prod.outlook.com (2603:1096:400:1e3::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.11; Fri, 24 Jul
 2026 10:59:13 +0000
Received: from TYCPR01MB11332.jpnprd01.prod.outlook.com
 ([fe80::2511:10cd:e497:4d97]) by TYCPR01MB11332.jpnprd01.prod.outlook.com
 ([fe80::2511:10cd:e497:4d97%6]) with mapi id 15.21.0245.010; Fri, 24 Jul 2026
 10:59:13 +0000
From: Biju Das <biju.das.jz@bp.renesas.com>
To: "pavel@nabladev.com" <pavel@nabladev.com>, biju.das.au
	<biju.das.au@gmail.com>
CC: "cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>, Nobuhiro
 Iwamatsu <nobuhiro.iwamatsu.x90@mail.toshiba>, Prabhakar Mahadev Lad
	<prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: RE: [cip-dev] [PATCH 6.12.y-cip 15/23] pinctrl: renesas: rzg2l: Add
 support for clone channel control
Thread-Topic: [cip-dev] [PATCH 6.12.y-cip 15/23] pinctrl: renesas: rzg2l: Add
 support for clone channel control
Thread-Index: AQHdCtsMv4KWHgG7NEmXjyEy2bS277ZuciMAgA4usyA=
Date: Fri, 24 Jul 2026 10:59:13 +0000
Message-ID: 
 <TYCPR01MB11332696CD6BBD5417BC4EC0786CF2@TYCPR01MB11332.jpnprd01.prod.outlook.com>
References: <20260703105923.251255-1-biju.das.jz@bp.renesas.com>
 <20260703105923.251255-16-biju.das.jz@bp.renesas.com>
 <aldfilAzZmb1ww7K@duo.ucw.cz>
In-Reply-To: <aldfilAzZmb1ww7K@duo.ucw.cz>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYCPR01MB11332:EE_|TYWPR01MB10003:EE_
x-ms-office365-filtering-correlation-id: f5f23725-6504-4995-0f98-08dee9729908
x-ld-processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: 
 BCL:0;ARA:13230040|23010399003|366016|1800799024|376014|38070700021|10067099003|11063799006|56012099006|4143699003|18002099003|22082099003;
x-microsoft-antispam-message-info: 
 2+OxJ1x762a85aeDwEQ+IRHbt7eu6Pi0JI5jUgn6P+eykJSr7LHEQQVwQUEc0xYtyhZxEEebIQ6FzLlwNb3B6mBnMg8y/ce8FjMlgdARH0KsN0Js4iEZcIiio5OTmenUvK2UWbEXYiPGWFr4g1633AP0+lZPkEyqPN+2GMT3i/XSlnBydybw/+Dh+5jEWcOsq0pPnCpF5LTCe+bvVpzSm8Z3Y/ftL9wA5gIKNXRsaXPcm+0GXAyzej4PWI4/BCMDheF+IfRbsMtvaZdkZ6Qeibu53E5ueulNynangs5j7hUxQY+g3Sfih8hNcTBDAq00e0z4WjqOm+wHbgZyrgZDxdfYHv/Iu1MQqKneR/0fq5n0UogXXNLPsigcbw10I5wbIBVwqkJFg7HXlCpN0me9AEWPZ7G3HDB3fyZUjzJDlw37AyT/dJq4I6EXBl9ZjSLcqsnqCBpO3hHkQ/F13zprHlb9NQBa1LtJBkF4LHsG+1tdCoog763cE8yitzAgW4qOtF9U3jMdr5u2gUfU6M6OovN53ZW2WAhVG4ASVZ+rP/1AFSkGsJ6L3SW3nsMCbtlJyMJmt/0hSSs1er7DJJlQlZeeir+ou6lmuIQVu86rqWV5YAn9QD10qKBq2NdbrMrzcUnZhHOUGro/N1MvCSUpbDYUIkOq15YY8IPW2pR/F3M=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYCPR01MB11332.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(366016)(1800799024)(376014)(38070700021)(10067099003)(11063799006)(56012099006)(4143699003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?us-ascii?Q?j9jwi1KgdxASx/PpZEyVYiU+mojVD0OUnYtQk+kpO4i424gcdjU0D6KhsFGY?=
 =?us-ascii?Q?begl6xMVXD1y4LhDUysztTBv3IDSVgbNR6CGo7i7Du5ohU0hxUDOXPlmKNee?=
 =?us-ascii?Q?zK5xOtgETPz89tuHnaRE6rfjVmbono9vbhmn/hHetYu2Q81FiArNuwd6baTh?=
 =?us-ascii?Q?TaVlgJJx0zb3ubY46JB8U/Hlp1sqrd+F55vxWPqTiNxzFxnRQ/f8u8pb2BqT?=
 =?us-ascii?Q?8oNUa/m9YbBlYVp4uGSG3L2vYxwuYMBGdFR4Vzuv/G9NMveUAmbiJGJofSah?=
 =?us-ascii?Q?22jN/xPLkNIeXWe2jmCTREMJZAPVcLOADJ2GUXnmvQkg93Q92hmZF0QolToQ?=
 =?us-ascii?Q?DqXJvYnzy7Q3PNNP2DnNHl8G6U/jCEOlSDHkICDw4qB6OzrR6QsR+LoPRxXO?=
 =?us-ascii?Q?5O9GGhDIe7X9ap/t0lUv8KbfglROqqcLWgDNqqVm6Kz8vnRzRTU7SfAYlAP/?=
 =?us-ascii?Q?eCxb0v1Rjhnnq/6a+1OZsqGRtvcRqBbZAZaYxaMN/RsA3B/pAO7N1KPoQLHY?=
 =?us-ascii?Q?Ca1ktU3u32LnlX46FT8qNgqoUR/QvxaPZ22huqQVEOjDDbvZeyI2OojQueRI?=
 =?us-ascii?Q?8dnmw7oFGV2+aVeYcNfav6galm3R2t4ZmZXcSk/jyYPMQqhffHZIOFucaZ3w?=
 =?us-ascii?Q?KYpVZjO1OdP6cxPepBuP3KCGpNi4CPCFVlMq5wesdOUoWtbc7jgeKJ/Deq8W?=
 =?us-ascii?Q?OybubxaBMJC7j/SZsM2Rnmazed1q9vqANB9GrjoKwhYic8N1hlbAOb5S9K/x?=
 =?us-ascii?Q?dm3NY3j9KsQ0Wk/jXM9YIstwEqIqaOMhOZoiShzkRHz7/GZeZionbJAl7OXR?=
 =?us-ascii?Q?qPqbHSi2Z2g23mdGmWON1Uk0e/1z6omVbwOxoc57fV8cl2USkXQpHQ34LFpS?=
 =?us-ascii?Q?0GDZ8CYCUD5TS7KRfAb7HJ+jULIhDseESNE2gewO3dLJY2mYPWu5ZxoccZfp?=
 =?us-ascii?Q?ks0UTeWn2S7EAHVEKP9OLcKC2v1gaoN5LBC94dDMHuDKY0g7Krze0krtNQch?=
 =?us-ascii?Q?EoIaAoz3aCs2yTTWIgPfzapp+uPehEMtWxX1b0G68LJ4ZNL1Ut9pdfCRosXY?=
 =?us-ascii?Q?mx/n31HYGlPtNEWsi+NtZ5w7zM2oKbMHfqJB7jiVHrsIdRMLVD17zuiRKIWx?=
 =?us-ascii?Q?zgb5T/r+0SXqI5lliu85I10vGgL5sdfMJUADJZBvmMDT6QH7FACiJMYCsizY?=
 =?us-ascii?Q?5nhuALsWP0A9rXb/pu7/YtcE6N5QRzjhXOWMipM3OPgcWZIkRo/N+5D6jd61?=
 =?us-ascii?Q?pAM+gpTaLXWFfEU4JI+Z93pCNlyivXu9FNc0UzMu2P1OzTuMZE1o3u+/KnGD?=
 =?us-ascii?Q?v+wfOyicLFpDJrERePeiKQ7MUp9BMdSaVVtlgEW4fIJG0lKHfoMLHvrF3Xrp?=
 =?us-ascii?Q?Cpzup8JBrnlDQrg+1tsQKiHg4Cciz23QdoKbfMqh5jssddWg0bNjZk3gi/zq?=
 =?us-ascii?Q?2g4/V3JArWP7WnQNu4SxZcGAd+2PyGsFpk4deIq6u+muMpcI0ABr66qXneak?=
 =?us-ascii?Q?Sj4rbaMm44aXwYjE3fOZ8J8QbBX+ZcbbcvgrXxb/weJ3mcxznVmLAnKmgo84?=
 =?us-ascii?Q?Yb9XT9yWlkUZ5wwOJAIVMTE97baRrKYDUdjlotZ0UoV88VNZ6DFKazun4q5h?=
 =?us-ascii?Q?kMrB3Y0fNrRK4ptp6VEm9Zdvn8AILDuvMjVCARIwNuVzKFjEsCULXaNhtKdI?=
 =?us-ascii?Q?73KbsdUaCFLhQ3vf79+cXY0iOJCywb7R4nMPFHbWBmRKZpNoOKdeOI0byHSp?=
 =?us-ascii?Q?Xi5/OI1zeg=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYCPR01MB11332.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f5f23725-6504-4995-0f98-08dee9729908
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Jul 2026 10:59:13.5648
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 24PG/A1ke7lO2KEkLLRbx8ng3iNbVu5/AUyHtdfgr0Z/RPWDO+Opnn768oolQDZZozeyT/undAn2BpbRZ4hAaIpT3CZ0Gk/ci14CLK2Clyw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYWPR01MB10003
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 24 Jul 2026 11:26:08 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/23735

Hi Pavel,

Thanks for the feedback.

> -----Original Message-----
> From: cip-dev@lists.cip-project.org <cip-dev@lists.cip-project.org> On Be=
half Of Pavel Machek via
> lists.cip-project.org
> Sent: 15 July 2026 11:23
> Subject: Re: [cip-dev] [PATCH 6.12.y-cip 15/23] pinctrl: renesas: rzg2l: =
Add support for clone channel
> control
>=20
> Hi!
> > The RZ/G3L SoC has some IP such as I2C ch{2,3},SCIF ch{3,4,5}, RSPI
> > ch{1,2} and RSCI ch{1,2,3} need to control the clone channel for
> > proper operation. As per the RZ/G3L hardware manual, the clone channel
> > setting is to be done before the mux setting.
> >
> > Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
> > Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
> > Link:
> > https://patch.msgid.link/20260430093422.74812-8-biju.das.jz@bp.renesas
> > .com
> > Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> > Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
>=20
> ...
>=20
> > +++ b/drivers/pinctrl/renesas/pinctrl-rzg2l.c
> > @@ -352,6 +368,7 @@ struct rzg2l_pinctrl_pin_settings {
> >   * @smt: SMT registers cache
> >   * @sr: SR registers cache
> >   * @nod: NOD registers cache
> > + * @clone: Clone register cache
> >   * @sd_ch: SD_CH registers cache
>=20
> I notice clone is very different from the other fields (being value, not =
pointer), yet is documented in
> exactly the same way as other field. That should probably be improved.

I agree this to be fixed in mainline with "Clone register value".

Cheers,
Biju

>=20
> >   * @eth_poc: ET_POC registers cache
> >   * @other_poc: OTHER_POC register cache @@ -369,6 +386,7 @@ struct
> > rzg2l_pinctrl_reg_cache {
> >  	u32	*smt[2];
> >  	u32	*sr[2];
> >  	u32	*nod[2];
> > +	u32	clone;
> >  	u8	sd_ch[2];
> >  	u8	eth_poc[2];
> >  	u8	oen;
> > @@ -387,6 +405,8 @@ struct rzg2l_pinctrl {
> >
> >  	struct clk			*clk;
> >
> > +	struct regmap			*syscon;
> > +
> >  	struct gpio_chip		gpio_chip;
> >  	struct pinctrl_gpio_range	gpio_range;
> >  	DECLARE_BITMAP(tint_slot, RZG2L_TINT_MAX_INTERRUPT);
>=20
> Best regards,
> 								Pavel

