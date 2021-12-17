Return-Path: <prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF01AC433F5
	for <webhook@archiver.kernel.org>; Fri, 17 Dec 2021 11:03:48 +0000 (UTC)
Received: from JPN01-OS0-obe.outbound.protection.outlook.com
 (JPN01-OS0-obe.outbound.protection.outlook.com [40.107.113.114])
 by mx.groups.io with SMTP id smtpd.web09.4934.1639739026360661016
 for <cip-dev@lists.cip-project.org>;
 Fri, 17 Dec 2021 03:03:48 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@bp.renesas.com header.s=selector1 header.b=wZG2I7Hh;
 spf=pass (domain: bp.renesas.com, ip: 40.107.113.114,
 mailfrom: prabhakar.mahadev-lad.rj@bp.renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=c5IO1/fdCpQCLvNa1kw/F396hjE/xJrA9h5g2vY5yZezEW2yGvHf069xGUY05DvQ9lnp7sCeK5Mqk8jEw6rGWdWeD5zAMU57kq1MkumsahuRtC/SdPPhk46f9cnG+CQnre6mSjXr7YhLwv7RJ+mypV/lbyEfyg9Xd2D8eZ9PY8WpevrDyOmnPnrzAnZf/fBIK/GRi6tn3QH7eWqnYbsh2+cCgVWKRSv7JCa45T/b+Fwbnq+5k0M94/FS3srXltJn8c0sdjTHvjjuOxhbaLczrZrFusLXvf+0Vw66dN49CEWwgEjJsRvsbmqfbH382lpyZ3J3K58ZrJyf/yK9roOS7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+M23txZMNSHfLwiurIC1Jk848q+aiEXR32X05OozMLs=;
 b=XRRXBUACTX6PV+51oD1LVp/rSXSg6q492FjFwQuZFPQqXorwOt7mf/YdMgUaLb0d2bz9pKkGzd7Xk7JEIUwVWcGPgxk9wl4qvlljopESUcCRGr+jXQB9SVUll1P/VN35dvcDcxySx69Rc6D4SvCPs4NZva12xRGp5wkZr78JRLUuh03hBYPSY281qdQukU8ttndiJqSg1ZK8QVNBsTE9xUwoLfuKsiFOdlBG8Vm4MHxjQOz+gIlFPrI7GI6TGx3Wvy78nJvvjCtzV60BzDRuCNjk76kCo2AFrY1y+25BT0gIF8p1lJw6KMTHq69A3XjN0zPlpg+J4ZeJ5ibh9MR8hg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+M23txZMNSHfLwiurIC1Jk848q+aiEXR32X05OozMLs=;
 b=wZG2I7HhWOSLkl9p0MVba53yeCm7IWmZBBINhJglBY8ljT3z0wCmt+0gT7GIVGPY8CMFtArXEOnsysHGbphj7JKR2yyXKLMkHTtdpnn9R+WTTpGyUeh1gsSqVqFWvPURPMT3zGQUNNc7YIRii55g3+tqN0wsmF056HOqS9jSoNU=
Received: from OSZPR01MB7019.jpnprd01.prod.outlook.com (2603:1096:604:13c::8)
 by OS3PR01MB6676.jpnprd01.prod.outlook.com (2603:1096:604:10e::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4801.14; Fri, 17 Dec
 2021 11:03:41 +0000
Received: from OSZPR01MB7019.jpnprd01.prod.outlook.com
 ([fe80::2182:43e9:3f29:1b3e]) by OSZPR01MB7019.jpnprd01.prod.outlook.com
 ([fe80::2182:43e9:3f29:1b3e%4]) with mapi id 15.20.4801.015; Fri, 17 Dec 2021
 11:03:41 +0000
From: Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: Pavel Machek <pavel@denx.de>
CC: "cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>, Nobuhiro
 Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>, Biju Das
	<biju.das.jz@bp.renesas.com>
Subject: RE: [PATCH 5.10.y-cip 05/24] clk: renesas: Add CPG core wrapper for
 RZ/G2L SoC
Thread-Topic: [PATCH 5.10.y-cip 05/24] clk: renesas: Add CPG core wrapper for
 RZ/G2L SoC
Thread-Index: AQHX8y5j5u8adbs5hUSh1cLubMvW8Kw2g1oA
Date: Fri, 17 Dec 2021 11:03:41 +0000
Message-ID: 
 <OSZPR01MB70195AD3B203E760B3A8F0FFAA789@OSZPR01MB7019.jpnprd01.prod.outlook.com>
References: <20211216125446.15451-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20211216125446.15451-6-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20211217101053.GA17079@amd>
In-Reply-To: <20211217101053.GA17079@amd>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 5c076e14-bb3f-4a2e-47e8-08d9c14ce2d7
x-ms-traffictypediagnostic: OS3PR01MB6676:EE_
x-microsoft-antispam-prvs: 
 <OS3PR01MB66763DC3CA5B995CFAB07771AA789@OS3PR01MB6676.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3383;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 /uqYBZJt+4AeqfiheU1yl2rzME8t6XEFt2fo7wbrOvUIOfGorw8LQPRAOHqOejRi+KBSwbu5mgoEVjSqwedNksAtWW+qkUQYTWZPxNtKPFJe8WowL+L1tvTJjmkNvvIJaMCH5n0q65i+YGBEqRdOonEIU2+Jjz+goSpJcljowunIIYAxXCr7ses7m7Y0568YiIwGERIUZ/46wAAOmZp2Ri0suELqUeS6eBskMAG8BzZRFDfaxuPJ6akT5EqgS8pdBpy84CuZWSv4QXTqkbReHx0Ex2OI6tlm/Sh2jJXdXx52YBM8zVnHOPCjX3Ubs2dGNmZthSgxyl8ZzqNUmmIHlKiSDnkBRL0gKqE/VjHlmz8O/08smMStF0tYgnzlsubUOYqlf/KBVM9wm0/LpD7RJ2UR2QkcH85ZiwHFRu8LuZdjOO3exkgJvkv9EOIspeZJQWGPZ26GyvmjFAOaEFeGAPqKWF5AT+pJ77GM17YozKr4AGr3zcBUo3zP0vvvnSGf3WgjGPxrK1iTj07hm9oazzlNH6tS/+5g67K0SndYXOCvSrBRiPosYdbppBaXSteopvrjNkhLeeyJvUR0hmDw8ma9t33gEQhv113/xZ9XOluaqqwFV45bYbrbBVfoKQ+0TI4RFfnqEEabgZMsy4fs3oJL5jMrxUeDVbrc9yRB3Xua4vObIrRPc+WHxu3JKdcoEOBhiMLzAKaQL7/CGProjDjigoU2Q6ZSwt8rMGouUArfBZuYPJCati/rTHRAWQFiGLCLb5833a+aayjFk/rOXd48ZuEd4WIxVrhIE4ScFzE=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OSZPR01MB7019.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(122000001)(186003)(8676002)(9686003)(52536014)(38100700002)(53546011)(6506007)(71200400001)(26005)(86362001)(83380400001)(4326008)(33656002)(8936002)(966005)(508600001)(107886003)(55016003)(54906003)(38070700005)(2906002)(66556008)(66446008)(66476007)(5660300002)(64756008)(76116006)(7696005)(6916009)(316002)(66946007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?us-ascii?Q?xNprGNRreX/ew1mCXekw2917hRWwcuMx5qTV9mHKu5RAKhMJHp29MjgMzAbd?=
 =?us-ascii?Q?+aWYgaBXcIJoldevpy0jid+EpFBSwLRUPxJOPERCJ7CFH480Rm2LexfxW0sR?=
 =?us-ascii?Q?BczRkseqHXhMPiEG7D4etw6F3SZyJm5YlPmo9Cbv2KKfOfQHL8nLP29B7SOT?=
 =?us-ascii?Q?ilQUih9EDQ4jdiGnPbDMTIiKTghjdRiHEGVJ5b5WaKxlU62YgZj0T0NyMXIr?=
 =?us-ascii?Q?ifDEFQUVOgqJlN1d31v3ZY4JO0e7w3hUYAjvwLzK1V6VLcLg8WbCQVBzWEau?=
 =?us-ascii?Q?ycg2fapueh2fd4NfUvj42Cl/nqlCktnnGooMjrHXKMJw5iUCyKXbY8EFT+vm?=
 =?us-ascii?Q?mQQipcUJuHfRxO+7fKQW0w3p1zb1bl/ntFM6Nxrlhb8TPOOkSfZGxlvlKdAw?=
 =?us-ascii?Q?XmWS1ovt6gUvBWogtbDlLVKE5NsnYakWi5WGZOK0r9ZMdmu64qClZXXwu4uo?=
 =?us-ascii?Q?llXGRhng+UrQHY7HFoGphkpn4GM967FPmdA0meDS3gknrR/oQnC+oma8S1eF?=
 =?us-ascii?Q?viJWZXlMqNSKMKVlRPKuu89HSgRayqnkXIBatKBcuNRmGwoe9Jgb9Zq5BAbJ?=
 =?us-ascii?Q?zpXhyDNhsLRiSjiPVXY66Wu4TwEteXFBcg9kskBJ62VLF3LuqUDfuqYNe5jD?=
 =?us-ascii?Q?0DHe1NxqouAb4lKp/0dZVwkX2P9juYG1ZGx8OyWoQFs0dzNiEDwFzcvvWcXi?=
 =?us-ascii?Q?499EZhfo9c8OG5qYTdLAR92UdUaiu8aGa2xlDM1yU7L86/yMw1srdWpIIvad?=
 =?us-ascii?Q?A1NCXAIWyiHv08iJ/qimArszgwb+70TSKgTVknGdi8EMLNeVqA3rjMzuX/B2?=
 =?us-ascii?Q?8AlYMxU7ZN3yCBceL/iQ13AD9CZ9wofWH2KSv7a8PeVsbYRYue+yZNbNg9bo?=
 =?us-ascii?Q?9FqEUzF71GhqD5rsn35T7KA4r4KO7KtsXpVjEXciZuLyocGiahpI6zIeX+M5?=
 =?us-ascii?Q?NAHEtFBnZRbPTmSfx7D75btStStynz67I3wN/ucfW2zwUIG1Jxg1nsZ7WBH1?=
 =?us-ascii?Q?hjYoKSxPLTHvmgJObbsu5nq93HrdJyye5lOT/Yx+IvCQhj3eNpy5TbLamVyy?=
 =?us-ascii?Q?6wP4Mr78cWOd2qHD/bqMXRMrmrQxPJkdpr4TxcnCVz70Za3O4M3iV2VcCCZf?=
 =?us-ascii?Q?YUS1ngR5MlqLqJGeq/8Sweu8V254Xn56hCTFMuYdmAlDKf2kuVH6cp2h91yo?=
 =?us-ascii?Q?2lfNSk6bGuiScXxwQUQCJHKpZLo6eInePF2Fk0L8q9gv8Pe2PLpdPsiprSpR?=
 =?us-ascii?Q?SOhWC/Gx201SIgFylv2teb3h76drPztIywFo5msN78iqa7dns/196s8hL15Z?=
 =?us-ascii?Q?VHkVO0zQ4OWR/8mHL4LKhU7WGzXUWMw0vg3hdHbfovsJO+Hxbluh2Ady/++m?=
 =?us-ascii?Q?3uk2rXZD1n/7tPgX4sh2/CMMOE93mDt+ehQBaG9AbmPBCe8hoREjGWSLGFgh?=
 =?us-ascii?Q?ho+1g/6RPqIOXcTFSCYLmK/wDU9x1Put7dcuLSiG28CIT0RXId0CVj0YC5LN?=
 =?us-ascii?Q?ZWBP1HpGRlriOecMycpcXH1aDveiyQfiGbjuf73EZLKqDV0QNoyHvMltm602?=
 =?us-ascii?Q?Yu2bm3EfAKA+BOzgdzM2q3QRUECY9DIhcl10b+hlHPgBbWIMgZCeR6gRkD8k?=
 =?us-ascii?Q?Y69hcm6uAPKjgnY31BPI3Wio9l9ct5p6AD+kiOh24vtezOIHyPOIiZk/aLKG?=
 =?us-ascii?Q?ulV2RaRkMHD3YTUE/Fa0xlat1Btg9pcJl8qHITOth6yprTp5rK/pecn9h3g1?=
 =?us-ascii?Q?rCUho90Tvw=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OSZPR01MB7019.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 
 5c076e14-bb3f-4a2e-47e8-08d9c14ce2d7
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Dec 2021 11:03:41.5820
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 
 t6YsmgELm4WeBVry+sghL1oqFovYZqDiEsnzIykEbDZnq9z70m/I+o0cTaYJZLh0UbyCyq+l3Yp4GWOdoCxneTCTHwryzZ/RNLEFT4V3c4RT/U/531ItnpUPWuLQ+0/A
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS3PR01MB6676
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 17 Dec 2021 11:03:48 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/7174

Hi Pavel,

Thank you for the review.

> -----Original Message-----
> From: Pavel Machek <pavel@denx.de>
> Sent: 17 December 2021 10:11
> To: Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>
> Cc: cip-dev@lists.cip-project.org; Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@=
toshiba.co.jp>; Pavel Machek
> <pavel@denx.de>; Biju Das <biju.das.jz@bp.renesas.com>
> Subject: Re: [PATCH 5.10.y-cip 05/24] clk: renesas: Add CPG core wrapper =
for RZ/G2L SoC
>=20
> Hi!
>=20
> > commit ef3c613ccd68a78727b817c3dacf4a68d1ffc67f upstream.
> >
> > Add CPG core wrapper for RZ/G2L family.
> >
> > Based on a patch in the BSP by Binh Nguyen
> > <binh.nguyen.jz@renesas.com>.
>=20
> Some comments below.
>=20
> > +static struct clk * __init
> > +rzg2l_cpg_pll_clk_register(const struct cpg_core_clk *core,
> ...
> > +	pll_clk =3D devm_kzalloc(dev, sizeof(*pll_clk), GFP_KERNEL);
> > +	if (!pll_clk) {
> > +		clk =3D ERR_PTR(-ENOMEM);
> > +		return NULL;
> > +	}
>=20
> I believe this wanted to return clk? But I'd recommend just directly retu=
rning the ERR_PTR().
>=20
The later patches do return ERR_PTR(-ENOMEM);

> > +static struct clk
> > +*rzg2l_cpg_clk_src_twocell_get(struct of_phandle_args *clkspec,
> > +			       void *data)
> ...
> > +	if (IS_ERR(clk))
> > +		dev_err(dev, "Cannot get %s clock %u: %ld", type, clkidx,
> > +			PTR_ERR(clk));
>=20
> Is "\n" missing?
>=20
Will fix that upstream.

> > +static void __init
> > +rzg2l_cpg_register_mod_clk(const struct rzg2l_mod_clk *mod,
> > +			   const struct rzg2l_cpg_info *info,
> > +			   struct rzg2l_cpg_priv *priv)
> > +{
> > +	struct mstp_clock *clock =3D NULL;
> ...
> > +	parent =3D priv->clks[mod->parent];
> > +	if (IS_ERR(parent)) {
> > +		clk =3D parent;
> > +		goto fail;
> > +	}
> > +
> > +	clock =3D devm_kzalloc(dev, sizeof(*clock), GFP_KERNEL);
> > +	if (!clock) {
> > +		clk =3D ERR_PTR(-ENOMEM);
> > +		goto fail;
> > +	}
> ...
> > +fail:
> > +	dev_err(dev, "Failed to register %s clock %s: %ld\n", "module",
> > +		mod->name, PTR_ERR(clk));
> > +	kfree(clock);
>=20
> Should this be devm_kfree? (And is devm_kfree(NULL) ok?)
>=20
Agreed will fix that upstream and backport later. Yes devm_kfree(NULL) is O=
K see [0]

> > +static bool rzg2l_cpg_is_pm_clk(const struct of_phandle_args
> > +*clkspec) {
> > +	if (clkspec->args_count !=3D 2)
> > +		return false;
> > +
> > +	switch (clkspec->args[0]) {
> > +	case CPG_MOD:
> > +		return true;
> > +
> > +	default:
> > +		return false;
> > +	}
> > +}
>=20
> "return clkspec->args[0] =3D=3D CPG_MOD" would be simpler way to say this=
.
>=20
Agreed.

> > +static int __init rzg2l_cpg_probe(struct platform_device *pdev) {
> ...
> > +	error =3D rzg2l_cpg_reset_controller_register(priv);
> > +	if (error)
> > +		return error;
> > +
> > +	return 0;
> > +}
>=20
> You can just return error unconditionally.
>=20
Agreed.

> > +static const struct of_device_id rzg2l_cpg_match[] =3D {
> > +	{ /* sentinel */ }
> > +};
>=20
> It matches nothing? Aha, id is added in next patch.
>=20
> > +/**
> > + * Definitions of CPG Core Clocks
> > + *
> > + * These include:
> > + *   - Clock outputs exported to DT
> > + *   - External input clocks
> > + *   - Internal CPG clocks
> > + */
>=20
> This is not kerneldoc -> should not be marked with /**.
>=20
Agreed.

[0] https://elixir.bootlin.com/linux/v5.16-rc5/source/drivers/base/devres.c=
#L1053

Cheers,
Prabhakar

> Best regards,
> 								Pavel
> --
> DENX Software Engineering GmbH,      Managing Director: Wolfgang Denk
> HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

