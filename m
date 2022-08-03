Return-Path: <biju.das.jz@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D71F5C19F28
	for <webhook@archiver.kernel.org>; Wed,  3 Aug 2022 07:16:31 +0000 (UTC)
Received: from JPN01-TYC-obe.outbound.protection.outlook.com
 (JPN01-TYC-obe.outbound.protection.outlook.com [40.107.114.134])
 by mx.groups.io with SMTP id smtpd.web11.5704.1659510984523916924
 for <cip-dev@lists.cip-project.org>;
 Wed, 03 Aug 2022 00:16:26 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@bp.renesas.com header.s=selector1 header.b=ng8bsy9/;
 spf=pass (domain: bp.renesas.com, ip: 40.107.114.134,
 mailfrom: biju.das.jz@bp.renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DNnQxYWW0TPgzCKEf+R9WferAhk62PmqAmkHMFM/k7XtprPCegkGbNg6uwWuvSyDM5GrjTo2v3dvIYn/MM7xgmwQva0eOMAqMv6SiXXeGQxuFxHpOskrFdyrz+djtADOrYFmowH4qNzNQNldNbyQEN//kmzEag0csaLWcXpD/VHaYRNsMEjJ7gGzQhRWhUcRV8tjaLuGQs+rMiPDa8kXO18/Ncde1h1Yf7OcvjIHGIuFYpZTQj6wV9pVI0MH/Wq6kcgTCmP6jYgL7JXIKv3czEKx8xHxZDVjexUehMAd4wS3tfzioYYM8F802XGjMWDEZQBXGkld6uJjH9fnrQqbGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=etknlWkVc4uCC+OgNY0qoscZpoC8ybED0xJfz8rc/po=;
 b=mCSPW6ZsBtH7XZCv+LKqnpfVqbz3u9AMqjvkA3hVaEcfr0l2/GRBaOLcuTVGxiK7nioVY9z16E5rWnxVfN0FsrPJD+mHROG8AjQK3HksYcS47Q74VRM4kpxdz7X8REdff/UHWZqGz7Og7q+jsXDemfMdaxzxoL7IXwIrFc0eNJjekwHhaMU2TF9m9rS6swqejOkJJZzfFzmPzEP+PydZ+A7UKWcJwTOUWrOSHIj/mbetWadvnRV1KDDyoALSNgKwE9VIg/gNxntxAyFbMfQHNpcFONFXmMOsunghB3uUE9v2MX/UfioI5rsniVl639CLe6snSR2Y8tFG8h1/Jw34uw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=etknlWkVc4uCC+OgNY0qoscZpoC8ybED0xJfz8rc/po=;
 b=ng8bsy9/enlmCc56muPIizLBkbbfM0I1+S6nyOpdOvt14GH911Ahc/nyjiGS4+RUc46IXsCXdxcU+6Skg6+Yr1yx4lshvPfXbt+dPfFHybl8Y95YiXvA0CRL64VU7TcU0CMErMWbJFJyuqKn1Zp1N1zgdRZ570I7+fgX4G3qcsA=
Received: from OS0PR01MB5922.jpnprd01.prod.outlook.com (2603:1096:604:bb::5)
 by TY2PR01MB4044.jpnprd01.prod.outlook.com (2603:1096:404:d7::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5482.14; Wed, 3 Aug
 2022 07:16:13 +0000
Received: from OS0PR01MB5922.jpnprd01.prod.outlook.com
 ([fe80::b046:d8a3:ac9c:75b5]) by OS0PR01MB5922.jpnprd01.prod.outlook.com
 ([fe80::b046:d8a3:ac9c:75b5%4]) with mapi id 15.20.5482.016; Wed, 3 Aug 2022
 07:16:13 +0000
From: Biju Das <biju.das.jz@bp.renesas.com>
To: Pavel Machek <pavel@denx.de>
CC: "nobuhiro1.iwamatsu@toshiba.co.jp" <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	"cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>
Subject: RE: [PATCH 5.10.y-cip 10/24] clk: renesas: rzg2l-cpg: Add support for
 RZ/V2L SoC
Thread-Topic: [PATCH 5.10.y-cip 10/24] clk: renesas: rzg2l-cpg: Add support
 for RZ/V2L SoC
Thread-Index: AQHYpmBPZ1XXsVb2WEa/+BOC48fIGa2b1DSAgADudqA=
Date: Wed, 3 Aug 2022 07:16:13 +0000
Message-ID: 
 <OS0PR01MB5922C7909AE27C0EE5B1514C869C9@OS0PR01MB5922.jpnprd01.prod.outlook.com>
References: <20220802110850.1496057-1-biju.das.jz@bp.renesas.com>
 <20220802110850.1496057-11-biju.das.jz@bp.renesas.com>
 <20220802165407.GB9523@duo.ucw.cz>
In-Reply-To: <20220802165407.GB9523@duo.ucw.cz>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 3a12e010-55fc-4c82-47d2-08da75200c5d
x-ms-traffictypediagnostic: TY2PR01MB4044:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 vfNuUt01FWMD6pQ2D5nWFtS2QLpjfimsq53jQ/BIempymZPWth0KJET57+htvthfADZvW0ur0LDCRn8uRSH65xqt9moGVls5rjGUlBm/grBFHJzsrna0iS5AP7I00xP+wfyNsia4zZXVe+36uKvwi9ih3dLdQO8sK9WuB0bKbBGDQmABHBQfv/+UiUI+0KnfCWOXtP8P6CfghLuCMvaKVOKsClncKG1CYNCElXX5kPk4JG3N6nVxeafv9ykeFHujEfghmdYhE+w0v5NcanBsdll2xM/rx9kYRJ6TNlWC0+XHVSDXx/iGGf2LDyS9A5LY2qA176Myjc23JrSxnksvZEiXQ5NCPHDnFV5m/zL9Q48hIrgGi62ElBZsQQloo5CjKSnw33TzsRmU7pTPBV0lMSINWaPPrSrJqvSKMW5LnHWnAfVdX/KcwadzCMH9A8dycat/+bxdQZfjp8YQyESi5SP8g2ECdcrXAVJMwyZZUC8XtdvFIHG/cbUIENxcerrRNXQESpcZBVm16+RByEPghiP3udFcyZVkTAs+yPVAJRqoXmznJVo1d6sxs5THSVFkY2bnO1w9pfEtd97NJ3+uriD/do5wQI76HuTvYhACHvkUrhEsX4elpQzTRF+nuV1kl711VufekR6o3roHaRmsRys1MoH6pOSALP+CH/VP9F1ee31ADDoTi5YCIA4xTAttmTq4R6Y03lmPur955SjcdsxZzQlRO536CI/iOSZvSakx07Apl9AMIgvHvuLk6A/o73VFga5txtzyh1lBKAIR0UibuicSdy2Cqf7v1pglP7gy7A9ic+1kUg/pqrLDMbIb
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS0PR01MB5922.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(366004)(136003)(39860400002)(396003)(376002)(346002)(9686003)(55016003)(38100700002)(122000001)(7696005)(6506007)(26005)(38070700005)(41300700001)(83380400001)(2906002)(6916009)(54906003)(5660300002)(4326008)(66446008)(8676002)(66556008)(8936002)(66946007)(71200400001)(316002)(66476007)(52536014)(33656002)(64756008)(76116006)(86362001)(186003)(478600001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?us-ascii?Q?XQ8Q7i45uzSBCtxBjdTLA9+DPAwVy8u+hRBCxKbu46aRk7rl9pnylR7qFq7D?=
 =?us-ascii?Q?h6xzCo/2llKYXj+RPgY0x4rJyyxgJvS50ACFwIkvpR5+UrkaiOaGHkckWyKd?=
 =?us-ascii?Q?KVkQIS6ngqMietSRmcS6EbHwpN1Dz4/z7A/LSKdwbeP9aZeLG3kWhJ/GcjM4?=
 =?us-ascii?Q?IqK0DQzBue+7IPxJS1wVRKd6CJ8P7Xfq05t4oJE1AM3n3XBdbE8M6YaQ0GAU?=
 =?us-ascii?Q?Bk6xgQLK9tOZf2sL2sB1KTAMzNbgvqqZY7OQ0xR1dtI1FQbe16EmhZezPoe+?=
 =?us-ascii?Q?QkLxMqDj83buXvDvF29KsWfn1yVQMiTbcKxRax2NeDgxy+7hSxiHyD4JW3gK?=
 =?us-ascii?Q?vWMDP8SMduNyCvmUZpC2UiWG6A5336ZiOkhtYNBXq3UsAKM+oRBcmb8eqq6o?=
 =?us-ascii?Q?YV8LxRkFUXgXgGFs+pyFcz1cpelBwad+SZoBNmd/TTTVAl75DMADbg9D3bTE?=
 =?us-ascii?Q?HBwV4UO4GbztwvFfswq/MDjqXW1cONsOEZ7izQpisTsySm5aEbsbNeVYhUVB?=
 =?us-ascii?Q?Rc+XD3AYsxKFs6GE5OB5Utt8I6osxuA1r/f4+/hmoHB/7LmaIG9QorUTUNEw?=
 =?us-ascii?Q?I1uYumiKWy26Q5WqFQlt9XMTbXVwFTWDwSWFfmIp1BT5h1q0W3GiB+m3wTuM?=
 =?us-ascii?Q?PgwO+EvCm9puzQ8B1IFpD0Vsf+gj3g0tKhAaHf9OZOTXCwTNi5H7U7D3t6wG?=
 =?us-ascii?Q?gH6zIhj+Pa+RLXhS+CNaeVIAybtsYEYMD1KzWP1JALrYEca7LOaONTjiGLjm?=
 =?us-ascii?Q?mFNMqovQPBkAISPYjEENIAeVNpW9VfpNdGaAu3q/6dGKoJLsAoCXeA3mktqS?=
 =?us-ascii?Q?CoaCisc8kA+xtKbbqxb5CBCSRRRXwR1ba67si+oAXOya3yrEPAaaF7jWl/9g?=
 =?us-ascii?Q?X9oy3zI3oUiVEGlOITIRnT8bTsYJjFzknjZpMnGmDy4IixliVpT0IRcG6nc2?=
 =?us-ascii?Q?rwG+rtcP2B0pMOizZKWBUCeWkt9L39J2/ua+fcXm0FjZ8125x2tX0MR5p2oH?=
 =?us-ascii?Q?M8tizlPMiTao9Hh2QwYM/TEHbK36T7P5U1fBwdJcmLM3URmCpR4k17Hqe3kI?=
 =?us-ascii?Q?u5r0/WzZDjYIKsiY33TIBeOdTxx5XYL8Q68YDfAKQff/GrIpbrnC6VOYCzKZ?=
 =?us-ascii?Q?qr1rrHMnne09jMV++8kgB/gEPkSEmIlOqjja2RKl24FZFY3PcKmmEtr/n/ui?=
 =?us-ascii?Q?0FFsDTw+RY/WwrAacekJJD7aaCc1iWAr0/jcbZLC1uIEEUAHxtlTGhiwUv9B?=
 =?us-ascii?Q?2liaZgIrlEMffHYd3mSUrAh6YG8L+ioV6NNrCPMeVNlcRYm2R9QW3fFJensQ?=
 =?us-ascii?Q?GeMzAb71UgSvP5LWy12f3kg8Rn/yB4lcjdKvHIL0HZ5zeMlTo+n0pHMYB7bt?=
 =?us-ascii?Q?BUrYZ72I3zjsz0aGEnGXTWvHGlf8hYgy46mA1bemRgOlAVishvSBIp4Vp0fJ?=
 =?us-ascii?Q?0THJseUsVWvJ7V8O9e0ptiu1mxhqFe88JrJG37IdohRYvwr/vTQkXKylMBuU?=
 =?us-ascii?Q?BoFD6rhMjoVrango/FrzbupFFXSOc/hQLmjS7vWvpvlmSd3BT1s1MLWH2ANe?=
 =?us-ascii?Q?YII388S8NuoOMzfuy3cXL5eWTcbSJypjiv0i0voO8xqEneUMHmI6GgZkFNjO?=
 =?us-ascii?Q?mg=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS0PR01MB5922.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 
 3a12e010-55fc-4c82-47d2-08da75200c5d
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Aug 2022 07:16:13.2564
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 
 eOBcPbA+WlFs+kzz9TCLdLnpvEbM1FxfuW6xTAXw0hp3TV4Hci67nu0GWTb2vtyxznLZdluK9cmE9DhI1lF9KphXN94v5ktHEILOcbII46k=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY2PR01MB4044
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 03 Aug 2022 07:16:31 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/9037

Hi Pavel,

Thanks for the feedback.

> Subject: Re: [PATCH 5.10.y-cip 10/24] clk: renesas: rzg2l-cpg: Add
> support for RZ/V2L SoC
>=20
> Hi!
>=20
> > commit a1bcf50a99dd1e40f0c6a963bd4f12547a89d4cd upstream.
> >
> > The clock structure for RZ/V2L is almost identical to the RZ/G2L SoC.
> > The only difference being that RZ/V2L has additional registers to
> > control clocks and resets for the DRP-AI block.
> >
> > Reuse r9a07g044-cpg.c, as the clock IDs and reset IDs are the same
> > between RZ/G2L and RZ/V2L, and add a separate r9a07g054_cpg_info to
> > take care of the DRP-AI clocks/resets.
>=20
> Ok, so this reuse is quite interesting.
>=20
>=20
> > +++ b/drivers/clk/renesas/Makefile
> > @@ -30,6 +30,7 @@ obj-$(CONFIG_CLK_R8A77995)		+=3D r8a77995-cpg-
> mssr.o
> >  obj-$(CONFIG_CLK_R8A779A0)		+=3D r8a779a0-cpg-mssr.o
> >  obj-$(CONFIG_CLK_R9A06G032)		+=3D r9a06g032-clocks.o
> >  obj-$(CONFIG_CLK_R9A07G044)		+=3D r9a07g044-cpg.o
> > +obj-$(CONFIG_CLK_R9A07G054)		+=3D r9a07g044-cpg.o
> >  obj-$(CONFIG_CLK_SH73A0)		+=3D clk-sh73a0.o
>=20
> They share the same source file, but the file will be different basen on
> config options.
>=20
> If you enable CONFIG_CLK_R9A07G044, you get g044 support but not g054
> support.
>=20
> If you enable CONFIG_CLK_R9A07G054, you get both g044 and g054 support,
> you can't disable g044.

This is not true, we can disable g044 still. see rzg2l_cpg.c, there is a gu=
ard
for CONFIG_CLK_R9A07G044.

In this case,We will get unused variable warning for r9a07g044_cpg_info.

>=20
> This is quite strange, but probably not a problem. For symmetry, I'd not
> mind conditional compilation of g044 parts;=20

OK, will send patch for adding guard for r9a07g044_cpg_info.

or perhaps even better get
> rid of condtional compilation of g045 parts -- I don't believe space
> savings are significant.

Yes true, still it saves some bytes.

Cheers,
Biju

>=20
>=20
> > index 46359afef0d4..bdfabb992a20 100644
> > --- a/drivers/clk/renesas/r9a07g044-cpg.c
> > +++ b/drivers/clk/renesas/r9a07g044-cpg.c
> > +
> > +#ifdef CONFIG_CLK_R9A07G054
> > +const struct rzg2l_cpg_info r9a07g054_cpg_info =3D {
> > +	/* Core Clocks */
> > +	.core_clks =3D core_clks.common,
> > +	.num_core_clks =3D ARRAY_SIZE(core_clks.common) +
> ARRAY_SIZE(core_clks.drp),
> > +	.last_dt_core_clk =3D LAST_DT_CORE_CLK,
> > +	.num_total_core_clks =3D MOD_CLK_BASE,
> > +
> > +	/* Critical Module Clocks */
> > +	.crit_mod_clks =3D r9a07g044_crit_mod_clks,
> > +	.num_crit_mod_clks =3D ARRAY_SIZE(r9a07g044_crit_mod_clks),
> > +
> > +	/* Module Clocks */
> > +	.mod_clks =3D mod_clks.common,
> > +	.num_mod_clks =3D ARRAY_SIZE(mod_clks.common) +
> ARRAY_SIZE(mod_clks.drp),
> > +	.num_hw_mod_clks =3D R9A07G054_STPAI_ACLK_DRP + 1,
> > +
> > +	/* Resets */
> > +	.resets =3D r9a07g044_resets,
> > +	.num_resets =3D R9A07G054_STPAI_ARESETN + 1, /* Last reset ID + 1 */
> >  };
> > +#endif
> > diff --git a/drivers/clk/renesas/rzg2l-cpg.c
> > b/drivers/clk/renesas/rzg2l-cpg.c index edd0abe34a37..486d0656c58a
> > 100644
> > --- a/drivers/clk/renesas/rzg2l-cpg.c
> > +++ b/drivers/clk/renesas/rzg2l-cpg.c
> > @@ -952,6 +952,12 @@ static const struct of_device_id
> rzg2l_cpg_match[] =3D {
> >  		.compatible =3D "renesas,r9a07g044-cpg",
> >  		.data =3D &r9a07g044_cpg_info,
> >  	},
> > +#endif
> > +#ifdef CONFIG_CLK_R9A07G054
> > +	{
> > +		.compatible =3D "renesas,r9a07g054-cpg",
> > +		.data =3D &r9a07g054_cpg_info,
> > +	},
> >  #endif
> >  	{ /* sentinel */ }
> >  };
> > diff --git a/drivers/clk/renesas/rzg2l-cpg.h
> > b/drivers/clk/renesas/rzg2l-cpg.h index 5729d102034b..ce657beaf160
> > 100644
> > --- a/drivers/clk/renesas/rzg2l-cpg.h
> > +++ b/drivers/clk/renesas/rzg2l-cpg.h
> > @@ -203,5 +203,6 @@ struct rzg2l_cpg_info {  };
> >
> >  extern const struct rzg2l_cpg_info r9a07g044_cpg_info;
> > +extern const struct rzg2l_cpg_info r9a07g054_cpg_info;
> >
> >  #endif
> > --
> > 2.25.1
> >
>=20
> --
> DENX Software Engineering GmbH,      Managing Director: Wolfgang Denk
> HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

