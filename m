Return-Path: <prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A64CDC44527
	for <webhook@archiver.kernel.org>; Mon, 20 Jul 2026 10:01:37 +0000 (UTC)
Received: from TY3P286CU002.outbound.protection.outlook.com (TY3P286CU002.outbound.protection.outlook.com [52.101.229.63])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.5609.1784541693608221544
 for <cip-dev@lists.cip-project.org>;
 Mon, 20 Jul 2026 03:01:33 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@bp.renesas.com header.s=selector1 header.b=DvO5ZHS0;
 spf=pass (domain: bp.renesas.com, ip: 52.101.229.63, mailfrom: prabhakar.mahadev-lad.rj@bp.renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=StIV+wGO30R9IGSI/erhULHxnYDIuaHTYJH99lVZvsf9NQbDJqjx84LBDSEZxapwyLnHazqOst7bczxVNuCumoXkPI7ylOFYsAiTBnxe8w09c7U/x91PkOwdF3aJqicSf47OU2r1AaBcDI+OPoSnVwMXqEYYiTTzOL8RFuZg0QkkjXwj4CKhZl93wDdsD+T3yYTJj8UogVd+1ZOTydg/NBv7Qe0+LMYcmuicnahrP0GXGeJY9HJRI7QWFrPu9u1Mut/FO+GnKeANblivIjZKj2zNBWfhg74b106Vg9/4rZrc2Wyfh3EX60Y6xa0Q5r3U9/PCi6Gac60kii3Sa2lvhQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1UHYAlIXpFkZm45s2Ia7l2S0h/TGJ6ctSegZNu81Vb8=;
 b=qNjJVJGQH+K9CgSbCghtmlE52ePqLSWSG7JuWW1ka9fwksHG7en+QsXBhLWjA2pu50F4EXA4O7PbY591zBIPvpwyiw56zq8yEejLFhFEtAaxe17rbHWM19cSB3lg33DB+t3JHtXrNeTeP5zlBLMqW/AEMesDnlhDcWFSTHLneYRz7ww63vA6/U84wCuE4DWvxDIt+t9AiwFT0ue1bq9ELRc/6l9ukQaZqAkFGORFtmsQKTqyL7CZbKC/7hMtmQbfGZWVlJKrveHsOoPPbHWsOd7DIo1HNkd9XrJZQu35Oln0qG+rUy1hgspLm+bpEd1IsF4xggzv0IlEnL04toFQGQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1UHYAlIXpFkZm45s2Ia7l2S0h/TGJ6ctSegZNu81Vb8=;
 b=DvO5ZHS0I1qhnqSMBzyBPGh8SivwPbYviVh1++Xbk8VQbPhQxnnSRFto0p0oN14WtQVpbfnR8l7b1g/dLQrVuiN0GZ2TWubawoMmDCI8106TwgONbcaOgCi+igzUulvEV0jB1w0TNgwUKsI+xYPxKA0EtOvTUP52DQyHSmacEh8=
Received: from OSCPR01MB14315.jpnprd01.prod.outlook.com (2603:1096:604:39f::5)
 by TYYPR01MB6874.jpnprd01.prod.outlook.com (2603:1096:400:d1::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.16; Mon, 20 Jul
 2026 10:01:29 +0000
Received: from OSCPR01MB14315.jpnprd01.prod.outlook.com
 ([fe80::66f:fac9:2ef6:9796]) by OSCPR01MB14315.jpnprd01.prod.outlook.com
 ([fe80::66f:fac9:2ef6:9796%6]) with mapi id 15.21.0223.017; Mon, 20 Jul 2026
 10:01:29 +0000
From: Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: Pavel Machek <pavel@nabladev.com>
CC: "cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>, Nobuhiro
 Iwamatsu <nobuhiro.iwamatsu.x90@mail.toshiba>, Biju Das
	<biju.das.jz@bp.renesas.com>
Subject: RE: [PATCH 6.12.y-cip 8/8] arm64: dts: renesas: rzt2h-n2h-evk: Enable
 xSPI nodes
Thread-Topic: [PATCH 6.12.y-cip 8/8] arm64: dts: renesas: rzt2h-n2h-evk:
 Enable xSPI nodes
Thread-Index: AQHdFRD7mXI3UpTo8kGiSkew+oaea7Z2MwSQ
Date: Mon, 20 Jul 2026 10:01:29 +0000
Message-ID: 
 <OSCPR01MB14315B833DABE7EED4365047CAAC32@OSCPR01MB14315.jpnprd01.prod.outlook.com>
References: <20260706182328.5237-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20260706182328.5237-9-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <ali3iLuUt9176IX6@duo.ucw.cz>
In-Reply-To: <ali3iLuUt9176IX6@duo.ucw.cz>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OSCPR01MB14315:EE_|TYYPR01MB6874:EE_
x-ms-office365-filtering-correlation-id: cf9f7901-d614-4375-6251-08dee645de68
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: 
 BCL:0;ARA:13230040|1800799024|376014|23010399003|366016|18002099003|22082099003|38070700021|56012099006|4143699003|11063799006|10067099003;
x-microsoft-antispam-message-info: 
 H049GHDi/vi8LiHWAPVi7tZZop67QTzSL1zUMi7Z86WIM+86gS1sy+aGiH9aPipNhGh/XNNjR0zK1Lx6dX6gyLnXE+IqWuP7WVLkVyUAeMadDCbXWOFsOb6C8squDjivi4AQ6yOwXIQy+mfqOUpSJw3CWOx5/rUe3Qxz/OVhyLGLmOwHWkMv1lSM8cUu025HV8SmywhAE9UUfEDFg+32belTt/jKAwrYCiI3Bk/frTjjewXrS3wkss7J/K3j0SRwxYWShxjXCzVsnyyGqFZkOVYgytax6snCWA0Tg2uOYMll+Dy8+ASNC2rVzitMcaGh31Zv4ISWLVdlnglzOxY/KwTDenmixiOfTkkNwf0Y1AAKbOUbQMexw0DqqYW1bNWkvnp4yFOZYnNmVz/d6MmapAh3DXr1jqQbIYXuURH8MIT33KFQkhSEgUU7XK1qsvdFMM27PDj3pZe2tpw8c+502g98RMD0JpTwcPS03+lKYF8QSBYxEjtpataLnKmG2h+wSeBF7gchzAeBc3lNwJ2vkp3O7dRQumB03MxeYkML1UoJD0eZSyVG9DsWdOtv+VYU4Ge2QLxDcOG3TaE0MXFEEyhcZ5pwtx6Q98hYKHAOSnb1IkQoBXk+WJidSsHdMXOIPMu4a8GovtXTH1hHqavcqDoOK1wUxwUb70QlDCV0C4QQRbOkdO7gKUVJr34yy+8sz1Mb7OdsvfRQTm7Fvz6VbD/uPz4ck9u52FJIQamQ5m0=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OSCPR01MB14315.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(23010399003)(366016)(18002099003)(22082099003)(38070700021)(56012099006)(4143699003)(11063799006)(10067099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?us-ascii?Q?NC9RhYcMKW5H/16n+OPQfd6DEJD2wqnOAOBBWhGPov5sUaN3mYZd3eJG+Fc7?=
 =?us-ascii?Q?Mki265aTIqR41CmYn6HhGTnPDPtr4R8xDU0yrOOA/WFSRnZdil8AxzBMMOtY?=
 =?us-ascii?Q?B9Rb7Aujf1mgkd3rNCFxBZCEu3e/RgIcjfr8/Ks6R+jPQczZY+45BuKyT/Jw?=
 =?us-ascii?Q?FHMeykLa1nKrGNgpMnUAHoqQomdSKH6TxQC2FBlp7Gs8p4Lwdztf0CP/twZc?=
 =?us-ascii?Q?xb00UsDyyuqY1L6O+2pfvqei2cpb4dUdalpZb2s4MlmUDPbLU8zssH8jTJrR?=
 =?us-ascii?Q?bi5TMxscT+2i7/IGC1fj0zGCyb02swXuFDxMXybMUruHJzXXz02dOL7q9X5X?=
 =?us-ascii?Q?qUgSH9u8e7QvEgi+cx4wb5DlrzKU8hvKIt/B1vNHEe7SuRs70CSHgY33WT06?=
 =?us-ascii?Q?jf364SXx8C4BABL0CV4rLZgkf4Lss0gc96mU+7/ant4vHtorJTZCJ89wbE4o?=
 =?us-ascii?Q?zAnFtgVo/WRKR0vE6e7kVy4RngeqMR6MCd6XpU6xyQ7+RUvqFdYtoMD6RqhW?=
 =?us-ascii?Q?jySrUPOv6ng+dV4wY82VuGL80SBxJY+1pYbtKB4J5z40OF2pYV64N6rKGh9v?=
 =?us-ascii?Q?Kc+NaNo36U04HAjE6FykVUJ3dUCtmeBP2Ok4TCcXWkSx9lqWI7CP4liOfPma?=
 =?us-ascii?Q?pE2g05ZONGrYAzC3AqaWM+FpcXTsatvm/QnQb2aN0+wNIHp0Yl4zLA3+JmdI?=
 =?us-ascii?Q?FehHrcb00VGJFTY+6acGdUzhOAxVTbO7TWsCb2GYJCqAXSfxdgOKhAvFQWmA?=
 =?us-ascii?Q?qbAF7M4SQn9ikjamMCRJTLG24MOycDrd8G3O4r67tUXx8H9AimFRKz/6T/e0?=
 =?us-ascii?Q?ccNwDwt6LHRyKH6CtHA2PN2BeT6JvYMbdDjn9rvDSi3gufUTkWYUFVe1mLUx?=
 =?us-ascii?Q?iEyPe3WeYw9Fb3MXtpCeJnEGV44xM85FS/qoEqjZ5mqmxRwOxYJILrfcs6OX?=
 =?us-ascii?Q?tIphklP+M4IQN039+OAxq8vnYbroTHlJQvc4/Pxf3oCfMTUl2LDm8eW1bm7h?=
 =?us-ascii?Q?ufGMb5DkDCJEyWmamma0XgY4IasgXP4khy7E6g8Xmiu9SWpNfWPylXRZ9iqt?=
 =?us-ascii?Q?sxFYwEP3KH989JOax+Yo+/PQtd2qrECJR72+dE/kBR0QdE0oaY4C2+J/U+Fk?=
 =?us-ascii?Q?kWalrsmBHVTcrpyg9wyJy2TfAlcjHey1MexpWRO0Ltg79uc8Zsb5laZRYB/0?=
 =?us-ascii?Q?BL2ZFkRk3SfI/RCcfBfl08JTHzq1bjKW0OGRiVBWuS6tdW0boxlnQhZCKozM?=
 =?us-ascii?Q?dJqRCnTibgRSIjfvVJdK1VwclKrRrU0SS0Gnby6iVY9X57LV6inBnPO/Xy/e?=
 =?us-ascii?Q?S97YnYVXxz9BeIqLIK5DYcAjiJVWPlVMEE+PdF0vidn4k+wWSku8xBJMxZLu?=
 =?us-ascii?Q?vor/pAB0FpRZgM14JDkSmFPP8hu5Etd6hCsVxqqZ1Dshcuigx5MJoIC8yOer?=
 =?us-ascii?Q?gl1TneAaBBnAwGDwyUO+2HVY7L9kGsSGjwMJXV4wwdisZNhmxbZFwhpYVrQt?=
 =?us-ascii?Q?VnEY3RfM1WnLB+QsmPdYgU6m1gUvCWcwfW3jpSwMgp3NkVGu7xm6H30AJCQw?=
 =?us-ascii?Q?8cu8oZ9frWSM1O/akuklgo1mvvsDlckCgaRbae4G8KBc10PdLIhL+kPVUY44?=
 =?us-ascii?Q?wQRz3CgvYqPuKAjbSM9bg7ny/T8F3L5Ztw3J1Fsz21bySKZy/4hLYHILy+nG?=
 =?us-ascii?Q?bKVd/h5q86CTLemqrTAWgWj7LKMNRFmxtkv/Na9s5EreaYBU2X1dVsw/Je1N?=
 =?us-ascii?Q?u0Zl5u0eNWaz9PVennjH3mRfL/ylrD1m+UMiR7qmFAE7T7CQUsRO?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OSCPR01MB14315.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cf9f7901-d614-4375-6251-08dee645de68
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Jul 2026 10:01:29.1332
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: XiUEFY8O80jkrrPYa/1lh+eT6DhxcDQGoN6R59Hw6sVH4OaQ2K0siafTqcOH7GSNqn2EXAC1i59iUtcqQ2Swq9LJBTjsSF6tqnIRu5SMd8OOkkrrepPemaZTgGw28Gy2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYYPR01MB6874
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 20 Jul 2026 10:01:37 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/23677

Hi Pavel,

Thank you for the review.

> From: Pavel Machek <pavel@nabladev.com>
> Sent: 16 July 2026 11:51
> To: Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>
> Cc: cip-dev@lists.cip-project.org; Nobuhiro Iwamatsu
> <nobuhiro.iwamatsu.x90@mail.toshiba>; Pavel Machek <pavel@nabladev.com>;
> Biju Das <biju.das.jz@bp.renesas.com>
> Subject: Re: [PATCH 6.12.y-cip 8/8] arm64: dts: renesas: rzt2h-n2h-evk:
> Enable xSPI nodes
>=20
> Hi!
>=20
> > Configure the xSPI0 controller interface to 1-bit (x1) mode, even
> > though the connected MX25LW51245 octal flash device supports octal
> > mode.  Add a corresponding inline hardware comment detailing this
> > restriction;
>=20
> Thanks for the explanation and good comment.
>=20
> I guess even better solution would be to reset the flash when the board i=
s
> reset -- connecting flash reset line to rest of the system?
> But that's something for the hardware team.
>=20
It currently being investigated by the HW team.

Cheers,
Prabhakar

