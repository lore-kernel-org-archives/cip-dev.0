Return-Path: <biju.das.jz@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61F2BCCA489
	for <webhook@archiver.kernel.org>; Tue, 26 Jul 2022 09:16:52 +0000 (UTC)
Received: from JPN01-TYC-obe.outbound.protection.outlook.com
 (JPN01-TYC-obe.outbound.protection.outlook.com [40.107.114.123])
 by mx.groups.io with SMTP id smtpd.web08.4591.1658827009722957265
 for <cip-dev@lists.cip-project.org>;
 Tue, 26 Jul 2022 02:16:50 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@bp.renesas.com header.s=selector1 header.b=iteWsg4A;
 spf=pass (domain: bp.renesas.com, ip: 40.107.114.123,
 mailfrom: biju.das.jz@bp.renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=V9smq+U4yiQblqP5aBPsyBalkJx09EJG/kjfjEHQd+cwcySxdNf6wPcWCaVrZJnb1uoDv/ITwmw1WATFsSggaLxZ+GmTzdOsI+uf/pBFvsOAfmcOkIbO5ejJ2Ccd/sn2OaQpUm5tE/8Ph3EpFXzMutuVIFr79G4xBapo3ys9OSqXcyK95/0ZTS7DDxYUu39eU/DnCw4j1Z4bBwvXx/vLWnagoRxD6vMbJxCdhZXMkLFdx3CP39Q6s0JnhFcg0cv7HL8RaelHBgqJgZwnTw47N6Hj666FyWBSm8o4nTJG1cUwoslCnANmc51oSAe9D5J5NyAWOTe+phB8u0jb1VMPpA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xabZvYYw7mstfPFE6MgtTfI5a81Sh/0ifI+nad+cAmc=;
 b=NRzf2IXLiJADXW0HFCEkq5blwYwdT3gTTMEvezfwbt5IjXVTs/cKF4CxT4NoFcxbtQW3DMWcb+MdprUUvIq3hI1P3IzBeWmPFXMymIoK53hxs+jcGNBPjqwhkqTZAlyZE+kLTIyQPmpPInIBmX9x8Hd7djZ4V42XplvQ45lLyzW/xNcebJtUVPBHIdDNsaEfGLSXPP8YqP+49uGq4a5gBILdCu67qIW8MKFvZjwolPWbHGKzhPfhDBJSNyYjC5z1KeoVnAu2SPATXNVkRQw16ftKJST62v25WgIkEq6v54+wvYr7F/B5Fp9a3nEBKwsbxvDOdQ//7F8y6zIAZzrH/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xabZvYYw7mstfPFE6MgtTfI5a81Sh/0ifI+nad+cAmc=;
 b=iteWsg4Aqbjrq63ybXtTtjPfC9veYqmOFJo3oDojY5oSwEzZe10ep6d13KuuL59hEwUv9oflt6F4YyQchwudyRpDa+qcNH0AOYQGnAOno5jRkPL9THvGusxujf38e5KEsEE7Rqg6EUmUUcTtEPBPCpq5saDICj1FOHUR//jH2z0=
Received: from TYCPR01MB5933.jpnprd01.prod.outlook.com (2603:1096:400:47::11)
 by OSAPR01MB3602.jpnprd01.prod.outlook.com (2603:1096:604:32::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5458.19; Tue, 26 Jul
 2022 09:16:45 +0000
Received: from TYCPR01MB5933.jpnprd01.prod.outlook.com
 ([fe80::440d:b27b:6bbb:3d27]) by TYCPR01MB5933.jpnprd01.prod.outlook.com
 ([fe80::440d:b27b:6bbb:3d27%3]) with mapi id 15.20.5458.024; Tue, 26 Jul 2022
 09:16:45 +0000
From: Biju Das <biju.das.jz@bp.renesas.com>
To: Pavel Machek <pavel@denx.de>
CC: "cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>, Nobuhiro
 Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>, Chris Paterson
	<Chris.Paterson2@renesas.com>, Prabhakar Mahadev Lad
	<prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: RE: [PATCH 5.10.y-cip 01/24] soc: renesas: Consolidate product
 register handling
Thread-Topic: [PATCH 5.10.y-cip 01/24] soc: renesas: Consolidate product
 register handling
Thread-Index: AQHYoGoU0wiVILblFEK1Bd3ta47QX62QXxPw
Date: Tue, 26 Jul 2022 09:16:45 +0000
Message-ID: 
 <TYCPR01MB59336390A6E4B6A182150E0586949@TYCPR01MB5933.jpnprd01.prod.outlook.com>
References: <20220715072244.2298757-1-biju.das.jz@bp.renesas.com>
 <20220715072244.2298757-2-biju.das.jz@bp.renesas.com>
 <20220725210403.GC2302@duo.ucw.cz>
In-Reply-To: <20220725210403.GC2302@duo.ucw.cz>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: e3b0360b-8e54-4ba5-fb0e-08da6ee78fa7
x-ms-traffictypediagnostic: OSAPR01MB3602:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 fj6C9rxXZ/+INHXcJBtF9Gphx8hl1XdqAltNAuanLAMiGcZNGZby5jItXJCBklzfCIVn918q329zro3aL/dhVzRgmimLmGPLeSOZCT/lm1WI2B9Yz+0NYDLGonEYKwa7gl7GOG2O/M0uTkWRFQSJZfnHFPeFXNDmpjEtO+lrnU4lxorAifxcEWwCbTa1wF3lPwnTvlBXureNLw+kTQgiuUNk7TnRa5cur9KRnJC7oZuW4ifLL1aaIz008PTTUT/a4y6gwwpJlzb7eYsCvWGxue8pm+dS4pVWqednABVbM1srOEK1B2K+efzK/miU4H5CtLnZqm0Now/ijur9RKn8yQFCku/0va1vfzKsZ3uAnyiIF1uKMR6IOZXZhyGzSXjd5jkkj7yeK3G/v5SVq8lYLC2tHADTQV5BN7qE26PPa9d5w7BCV8z7jSalh4n8lY/2hmR01ev54+pezfkehIpkoTiP6SHZ1yHIPWXadxnC544mIs2Io5C+WBGH96qib9EVNtJ34h2lqYe2CUHD3gUfKhNa/phqoyFE1z5casJau/6lILgiEVo2Ub+h7paBHSvAdkx3MKx4+Rns4Bl6Rs/f3Fact5hI+pLHYColbGPoVx2+R6kD/UyfTrO0yUlGXtfzIbi9Uw3FNwmQhz8wVnyyRB/6kSaCvQunXaCnwLc7fRfS9h4zZH9a/Kube4VV3x6dQc/xNzCqtFMeHBnR8VSAk6DPM1dDj+hsefqIvy5CCEPFq8pdHuXCW1ib7LObMLaiyAH2oMu78xoVcpsR99iEb61QUBTfQV7vLt8PVEzaZO8wuniDTAAXKWEP5wW8EMe3
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYCPR01MB5933.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(39860400002)(396003)(366004)(136003)(376002)(346002)(107886003)(186003)(38070700005)(2906002)(6506007)(7696005)(86362001)(33656002)(41300700001)(26005)(9686003)(38100700002)(122000001)(8676002)(5660300002)(55016003)(71200400001)(4326008)(76116006)(66946007)(66446008)(66476007)(66556008)(64756008)(8936002)(52536014)(478600001)(54906003)(6916009)(316002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?us-ascii?Q?etUTomPAqKIjbv8Buf4ojuWc2kcEScAB3gA6zGTC2lR0wGOmBGEsxJ05Qav5?=
 =?us-ascii?Q?HnQ/jBD7n6LJUBwXa87oEx+PhezmcKOePT6v+FYbg5QgEmFBeJ9Yl6h5+I7I?=
 =?us-ascii?Q?MeJWNW649suHd9BLbDaMvdLkyMkBeQjktLmqSs+bC6KPvSCwfGyFISeGK8qe?=
 =?us-ascii?Q?ytNmSANY2Tw7jsENspn0wi4qzUcXortZ/u3Tq1BmieIeBXmkaWUC6z2AmgWl?=
 =?us-ascii?Q?VoFL9q0blLqmLx8NWWhDU3FCrgjH57kv988bX6zUkJLz+Yf38VWZLybfTSNi?=
 =?us-ascii?Q?K6iJ7ayfzMHb3vMNM6jfGQ+TpXIH8ILuKVbPyQUPS7ih8sGooGCSQY62RtEI?=
 =?us-ascii?Q?s05Kt73k8xNfOHSHvtjUe9PnHVA+gxDdEAgRgI5QVwFp5bKh0UyQs7HwjsFM?=
 =?us-ascii?Q?n7Qknp4tPFm5C8ScKSbiKUmNWC+59ymC0BGEl6L839LGpHFkUg2x+uCQ2pWv?=
 =?us-ascii?Q?xKQf9+PI3okva4GStXgC6/zjuRKzHzLRowqCtfgFwYiItR4bFUX1vf4CnJW7?=
 =?us-ascii?Q?rLgbyXmt5rkdIHKeOlntYMWT4vNCPD9dn7w9mgvaBE1B3PVsbKTpQBoCI9xC?=
 =?us-ascii?Q?TvQyaJ9T4Mn6TqDnHNfv8HOGq6TdQLvJsIS7RoHRf6r6ao30GrZ+8/8imtXa?=
 =?us-ascii?Q?tO9BQowqHwi9rN9RBGbWFrNSnVbwXm344mrhGUyzl2GWU6uq5m7Q5bl4MCY7?=
 =?us-ascii?Q?mWMrN5nELYDhCNRuqprv1UuNL0KXfiZDy404bO0yiUK/ETL/K+8Y2YfHwod4?=
 =?us-ascii?Q?gc0xsBGiGwvlIxtxU7rACwhzkBj3u+5c/VEKPEbK51JamEWocBqth/IFbK4B?=
 =?us-ascii?Q?5gc+cpQkNXkImNPAkxJSuHIJtpA83w0xQYt7yOjemFSw1c6Ep2FvzLGNxpXC?=
 =?us-ascii?Q?yV1NnET6KFdT9yGzv0a0hg6MP+4agn9Xx/8q5Ylwv2oX5R47y3A7995UEePN?=
 =?us-ascii?Q?LEDR93ckbK/j0Y9xuld49yEXHmSxCTD8O0fws0W5Y+qKgND+yjqQiFe/IdUQ?=
 =?us-ascii?Q?DZn+VxGOx6m/noH9PYTJbNKRjf71olkLkZ04oAzfF7qnsth2MRTdhj78Zlvr?=
 =?us-ascii?Q?mLIg0C8qhHYYkNN3KKP5xAoY9/x5aT/tS5w5ZMkkpBrjQ0bcyiheg5gEru3O?=
 =?us-ascii?Q?dVq4vi/lymJvDYufGQaaLg6XFGfeSqjnBn1AvPqjDWqsOJJ7h0xm+yaNQSRq?=
 =?us-ascii?Q?s+ld35fEw759NGGEB7p83YOAY1ANaQz/fD3AukCSS5DkKgzYlwnFlk8UKSlU?=
 =?us-ascii?Q?JvIUMlBZGfkn5t9HvMFkNu9DyNicD9mrPcQ+PJFlJIYGq6jFS68GqQLGhfb5?=
 =?us-ascii?Q?0NV9G1B5EBPWjLgg9wD15j6weV7WkRLMYEsRa931HdWKkro0y1TqoGoEWLrS?=
 =?us-ascii?Q?NMs1+fqFFCN+PNd/XaAKvTNDNYIDeJ+z4U+olg5wFxQ1IfbhgryCXwjXuLwq?=
 =?us-ascii?Q?BAXXu0yRSxCE9NQHyRJTuftWvv2+gbudR6qHwxRLQ0+QtmsNUhE/Wjm1Siu4?=
 =?us-ascii?Q?cxFSTYFEdU/o4eI6SGtwUEQfWGWZWelh3qzGzvuAN+5hYyUOL3fBOdDqxrVt?=
 =?us-ascii?Q?A35Ezxvn/RE2jBnLRovxwcl1vIfVT4NWl8MrghnlfaJEKhlSuhb1Iylk1ZLJ?=
 =?us-ascii?Q?KA=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYCPR01MB5933.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 
 e3b0360b-8e54-4ba5-fb0e-08da6ee78fa7
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Jul 2022 09:16:45.2841
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 
 YwyH1gCbglw0g9Tnx/ghmkdrleoPfAbmogq5OOtpy4JogYlUbW3MTQGohjnvQjeEcbON4jJGcHpTcvHfydW0ps9dqfNAXpGKr360OSgXYsc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSAPR01MB3602
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 26 Jul 2022 09:16:52 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/8925

Hi Pavel,

Thanks for the feedback.

> Subject: Re: [PATCH 5.10.y-cip 01/24] soc: renesas: Consolidate product
> register handling
>=20
> Hi!
>=20
> > From: Geert Uytterhoeven <geert+renesas@glider.be>
> >
> > commit 05b22caa7490e4f4c94bbde33c61cf72d187b8f7 upstream.
> >
> > Currently renesas_soc_init() scans the whole device tree up to three
> > times, to find a device node describing a product register.
> > Furthermore, the product register handling for the different variants
> > is very similar, with the major difference being the location of the
> > product bitfield inside the product register.
> >
> > Reduce scanning to a single pass using
> > of_find_matching_node_and_match() instead.  Switch to a common
> > handling of product registers, by storing the intrinsics of each
> > product register type in the data field of the corresponding match
> entry.
> >
> ...
>=20
> > +static const struct of_device_id renesas_ids[] __initconst =3D {
> > +	{ .compatible =3D "renesas,bsid",			.data =3D &id_bsid },
> > +	{ .compatible =3D "renesas,r9a07g044-sysc",	.data =3D &id_rzg2l },
> > +	{ .compatible =3D "renesas,prr",			.data =3D &id_prr },
> > +	{ /* sentinel */ }
> > +};
> > +
>=20
>=20
> >  	match =3D of_match_node(renesas_socs, of_root);
> >  	if (!match)
> >  		return -ENODEV;
> >
> > +	soc_id =3D strchr(match->compatible, ',') + 1;
> >  	soc =3D match->data;
> >  	family =3D soc->family;
> >
>=20
> This is quite tricky code. ',' will always be in the compatible with the
> current table, but if this ever changes, it will crash. I would not mind
> something like.

I agree it is tricky. But we will never be going to change {vendor},{soc_id=
}
format for the renesas SoC's in mainline.

Cheers,
Biju

