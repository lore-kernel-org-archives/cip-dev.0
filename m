Return-Path: <biju.das.jz@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58290C7EE23
	for <webhook@archiver.kernel.org>; Tue, 23 May 2023 14:06:20 +0000 (UTC)
Received: from JPN01-TYC-obe.outbound.protection.outlook.com (JPN01-TYC-obe.outbound.protection.outlook.com [40.107.114.105])
 by mx.groups.io with SMTP id smtpd.web11.23639.1684850772002689418
 for <cip-dev@lists.cip-project.org>;
 Tue, 23 May 2023 07:06:12 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@bp.renesas.com header.s=selector1 header.b=cYKgewic;
 spf=pass (domain: bp.renesas.com, ip: 40.107.114.105, mailfrom: biju.das.jz@bp.renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=e3eWjlih4n90bWk2hdFlGRK9bve6yL+FBrhc/u4Wd5sr5IvDCPpVfA1TM2Lfhu3PiAPmi88x0PGAZjhl+a9uHlEsu4nPRrbM0GqvpC266cC9Af6paJAYFORUqw6HiLf0aDIH4w6uKDXiAZmV7Z9FKz/ZQBOTsUaytGfI5Mb4sd4YF8qqLbXVUcTcwFjFwdCFdsrXXbj/yaO9VibhBKaiTgTEdQfJJerZWvoXPmt5OA7ydZeRSHKpd3dK/esoqk8h0Ohiacq17x1iUlF76oTJ4IKplvC7N7zDMCaWzyX7jw4dKZvoTYPelVSL4U2XUoMULtOmQenexlrKq3ldUvS0EQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OVMi9lJwX2ZpQH9sjivpudGJnykIRgyBm0btw7UvwwI=;
 b=jk0ogw6h1fdkfgh1bfx8fcBOnsCK5QIzXRTxUNDRbcgT/iC7S7XnLiAXLM/pYQEYzyey52tUajiOcWmzyorWt5Klwg9j/0WCmPzT7ozHM2QRI4Y1gebAVqpeJtQIRZrDfOzROojXa4/zcwBCdAq+unnQLWry/+XzqV+eSl5he2YVX86fhdDi9eJpacWk88RXzsD3AD6Yr8qVJYWwAKXOTe+FACdpG9uMzYzcF9+TbzzFSXGMLBWGdGMpm8qzUajpLP07ALl4qcT65W8Gr7B2GzUgab+ROM43Xgjq5ThmoLA9OUcT+zcLvJ1h3wjoD+z1QOUhog6PEclE548G7jl7cQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OVMi9lJwX2ZpQH9sjivpudGJnykIRgyBm0btw7UvwwI=;
 b=cYKgewic0GcH0rrVrMH6Rnui3YSPlHbwZ5/2j8gc9LFvfIk6MedmoGmwh4ivTtAFb6EeIjGdi2X0IpPqHOyugAKill0cbv+NK8FwbNwHuY2TDyov7PgfFsvLYoZDwTJk9Yz//NfqWhlHJRQJxW1zV5Ls6YCN0ceHM7B0Ju5QHqM=
Received: from OS0PR01MB5922.jpnprd01.prod.outlook.com (2603:1096:604:bb::5)
 by TYCPR01MB8325.jpnprd01.prod.outlook.com (2603:1096:400:15a::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.28; Tue, 23 May
 2023 14:06:08 +0000
Received: from OS0PR01MB5922.jpnprd01.prod.outlook.com
 ([fe80::bd0a:a38d:b4d2:5d2]) by OS0PR01MB5922.jpnprd01.prod.outlook.com
 ([fe80::bd0a:a38d:b4d2:5d2%6]) with mapi id 15.20.6433.013; Tue, 23 May 2023
 14:05:59 +0000
From: Biju Das <biju.das.jz@bp.renesas.com>
To: Pavel Machek <pavel@denx.de>
CC: "cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>, Nobuhiro
 Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>, Chris Paterson
	<Chris.Paterson2@renesas.com>, Fabrizio Castro
	<fabrizio.castro.jz@renesas.com>
Subject: RE: [PATCH 5.10.y-cip 14/23] PM: core: Add new *_PM_OPS macros,
 deprecate old ones
Thread-Topic: [PATCH 5.10.y-cip 14/23] PM: core: Add new *_PM_OPS macros,
 deprecate old ones
Thread-Index: AQHZiirvlCSFUDyQGUWjF9mQbrWi9q9iKc8AgAEX+CCABJxVgIAADALA
Date: Tue, 23 May 2023 14:05:59 +0000
Message-ID: 
 <OS0PR01MB5922E0B4751229CF74A545E886409@OS0PR01MB5922.jpnprd01.prod.outlook.com>
References: <20230519082058.109760-1-biju.das.jz@bp.renesas.com>
 <20230519082058.109760-15-biju.das.jz@bp.renesas.com>
 <ZGf0bB94Ugj2sQ36@duo.ucw.cz>
 <OS0PR01MB592279CFAE4F7FC03C7414E1867D9@OS0PR01MB5922.jpnprd01.prod.outlook.com>
 <ZGy9adIV+qjSXZBg@duo.ucw.cz>
In-Reply-To: <ZGy9adIV+qjSXZBg@duo.ucw.cz>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OS0PR01MB5922:EE_|TYCPR01MB8325:EE_
x-ms-office365-filtering-correlation-id: 15e281fd-05ea-4ff6-1e1d-08db5b96d5f2
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 NzmSyWxQ6lc9ndULvHZzlVXGYHftMMfSA1NiRw4SqzcYidRt0Qy78yt4Tzgh3NZoqQey16wiikrk1vMMFMB98QC6Sdy6T8V797dNsm3w7FLgN8N/Im0QdbrWRZjoKtR1gevFW5YoxSkGwUQgQiMyaCcqRnrDcu4oSm0zFQAoV7y+cmPJpLI2JBVFq3Yyuzf7VSYkgV0TXwXStqGckFBp/OSf/pjy81bnQ8LA07Wvjh5eXuub1x9LTZv6Gwvu0etDv90ID/mXqWgQli7Emfk5O65xBB7LaevaNMRQLzDlNUlwHPSoeasnrRE7IosT3Hibn7V/BGxjHiixpNoMDq1hhqu4TOpI5F8i7GM6ltQOBfivdab0lJLdteTiRNU+sZLcfxsJa9mIcpjWM0A+oUchmedLWQuYWAR3uA+WzF8XR7E68igRrPXY4ZfTmdV5cZvDOaVgIOWMwYm0E9iCUnW6t/uL+0U30DNxufNqg9BoLG/IrBjEzyehjK4fyBPShIAOJhLE5sAcnUW3NwmZccLVpdRMTPqjx6xkqBB4NRi70ns9fczbTmdaOqOOPX+Inm6aC2SevEf2Ju3K/ddNTXBJtlayA6Xu0Y/wi4MeLzT7E0ecPnkXzHcvLoLy17rSqGZg
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS0PR01MB5922.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(396003)(376002)(346002)(136003)(366004)(451199021)(107886003)(53546011)(122000001)(7696005)(9686003)(55016003)(38100700002)(71200400001)(6506007)(186003)(33656002)(52536014)(5660300002)(64756008)(6916009)(316002)(4326008)(76116006)(66446008)(66556008)(66476007)(66946007)(38070700005)(41300700001)(86362001)(83380400001)(8936002)(2906002)(8676002)(478600001)(54906003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?us-ascii?Q?bXjCiLJfaW+8rTZaF17Aqtkj7YtOz9UYNVyBxn7M0vllVOXVnA9KAQ0MMHZB?=
 =?us-ascii?Q?1r3lKchZk0G12u2y5pT40iHWjXhzJ5di42nl61KvnH34rSKF2YJRPeFvCWBW?=
 =?us-ascii?Q?5G3cgjf/ilApq679Znt6QSdwDaHrrjAmpRz9/WCylHAsEuZgNYM3hD1DPGxk?=
 =?us-ascii?Q?1mwaoPyuo8oPicSvyvweUwEkR70oBO1mjYh7N7ewZPBf5H90qW3KpU48hDzl?=
 =?us-ascii?Q?AuGvxtt5hbThUwLe1nvwGUWMLbGMXcdge6aYhrYz80cIqHDUTY9yNQkpIUmx?=
 =?us-ascii?Q?cr2hfkAd8M+kOJalXLmoLmnves78DCjmdDT0HYkPP7h/2EmxQkwu6kxV0A+R?=
 =?us-ascii?Q?Zwwl5QifjypaTrxPrHarSfS4+0ZUuBOTvqjY8y7O7hOyEFGPGwGzxmBVmEN7?=
 =?us-ascii?Q?h14hPDAF3pwkr0cHpmxpzVSmHu4AmK+dqWbKZ8LDQF3wFot44yyhCrL/W3kg?=
 =?us-ascii?Q?pOomD52V8zDSUh/jjTATVCdDci6fL9Mpyf6b/WLcYa+OIxg5aEMJ1GLrpA2V?=
 =?us-ascii?Q?3rVIdE0jIVYyEFy5BQ1Z+kcZO0tUb1LPoBk7nGSAnVIL83F5o5D/uqlMkCEP?=
 =?us-ascii?Q?K+6o02Nh0FH91yY/T1eWIWHS5NoF2+C4RLLHI/xSq1O73sH8kSbFVQs8m6hd?=
 =?us-ascii?Q?cVidoF1m1QBO6z2XHYhbgzmUMEfEcHDqQxT9cvz/1uaEX7tEHXqYQ0wwjrF2?=
 =?us-ascii?Q?ZQqPvCbszdHCdPvu8aBYvehajnl52CsxClYZUukVsEfkgsraa9koPUBu3Gi5?=
 =?us-ascii?Q?r/iPNXkLNjeZm7pHcWIBvn1JjaVD2/ZsModOUqrUqb+Lpqq6vaw/MZnPNraR?=
 =?us-ascii?Q?JNA0aAL114rqtEquFXI5IJAON3d0mgyV6oLFtrIVcHKD6lqwejF3CCF/XLez?=
 =?us-ascii?Q?KTmkWjLlyEF9kPZ03hbxXRQEFtZWKAi+a9QJcZm61eTUWJ1CQLu+p0iYWTiv?=
 =?us-ascii?Q?U+8RJUdine1z1LuNNrUN2/Zy5WOt2vb4qFpJNm3c/8hvMMqvxNEkFEDhKqX1?=
 =?us-ascii?Q?L4xPgnAyeOyXTCZ4gmBjph1TJ4w4YatRq8NBXeqvP0rUolB9Pea4v7glVJXO?=
 =?us-ascii?Q?UqDwe79X2JLU/cu215pEFgJgokgGKvRJBNaPOhvMouUhZfBo7Wz2mDBPKoB1?=
 =?us-ascii?Q?UtJkFDFv9mif7DfvxW6UgSYWvuH0Nv/zlUMFKxUN4+YeQ/6SNCKdu9wq2HEi?=
 =?us-ascii?Q?tUZK6jcqZ90MWKrCKNgUvvhk+jXIzpKaQje9CfXUlLOugF+oXIFudCuDPcwR?=
 =?us-ascii?Q?Dey/x8ox4ImIN1hXNILXBtBzRaE6u/SXtvUC1udRvBEVRfE23wxDONVPUsXL?=
 =?us-ascii?Q?kdDEjOfnVRk0umICGa1N69sWF/7+0XFGr6i2wbNafFdROIJqKRzx5J15Hr7+?=
 =?us-ascii?Q?19MuCsf38efwdJQVAa4vYu8EYrySSbCDXCvP9mf3UIdvEap5T2wagkMWqbJH?=
 =?us-ascii?Q?a/4UNExQV2stcqmMQnAN02G2j9yDGiuHBOtYxnG1oSUJoQpxvlZHI7yBIZoj?=
 =?us-ascii?Q?Sqi+rRiaZaAao7iheXNC1iUkN0A8Vuc6LWRqMa65az0BjZDBes+wJNJE0x6M?=
 =?us-ascii?Q?wtR5THIYUNQL5hEzd6s=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS0PR01MB5922.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 15e281fd-05ea-4ff6-1e1d-08db5b96d5f2
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 May 2023 14:05:59.5408
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ZMN6WeTPoTkutrqXS+RAC8+G7cGp+EodfFZrXBuuBxg0TH3Ss+bXRfQYygRRfMJdoFhCvkjkRGB8QZ1TNZt4Bb0yOzVIl0pAJqu69vpwkeM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCPR01MB8325
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 23 May 2023 14:06:20 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/11618

Hi Pavel,

Thanks for the feedback.

> -----Original Message-----
> From: Pavel Machek <pavel@denx.de>
> Sent: Tuesday, May 23, 2023 2:20 PM
> To: Biju Das <biju.das.jz@bp.renesas.com>
> Cc: Pavel Machek <pavel@denx.de>; cip-dev@lists.cip-project.org;
> Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>; Chris Paterson
> <Chris.Paterson2@renesas.com>; Fabrizio Castro
> <fabrizio.castro.jz@renesas.com>
> Subject: Re: [PATCH 5.10.y-cip 14/23] PM: core: Add new *_PM_OPS macros,
> deprecate old ones
>=20
> Hi!
>=20
> > > > The callbacks that are only useful with CONFIG_PM_SLEEP is
> > > > enabled, are now also wrapped with a new pm_sleep_ptr() macro,
> > > > which is inspired from pm_ptr(). This is needed for drivers that
> > > > use different callbacks for sleep and runtime PM, to handle the
> > > > case where CONFIG_PM is set and CONFIG_PM_SLEEP is not.
> > > >
> > > > This commit also deprecates the following macros:
> > > >
> > > > SIMPLE_DEV_PM_OPS()
> > > > UNIVERSAL_DEV_PM_OPS()
> > > >
> > > > And introduces the following macros:
> > > >
> > > > DEFINE_SIMPLE_DEV_PM_OPS()
> > > > DEFINE_UNIVERSAL_DEV_PM_OPS()
> > >
> > > Changing interfaces / deprecating macros is not good thing to do in
> > > -cip kernel. How sure are we this will not cause build failures or
> > > build warnings in unrelated piece of code?
> >
> > Please see the commit [1] carefully,
> >
> > Deprecated is just a comment and it is just single header file change
> > and There is no existing macros changed.
>=20
> I'll need to look at the commit more carefuly.
>=20
> However previous patch redefines pm_ptr macro, which may have
> implications elsewhere. And indeed
>=20
> commit 5ef11c56b2332613cacd5e7ac17cfb1a073b66ab
>     r8169: Avoid misuse of pm_ptr() macro
>=20
> is example of such effect, and we'd need to pick it up.

Oops missed it.

>=20
> I believe it would be less intrusive to make i2c driver work w/o core
> changes.

What is your suggestion for adding RZ/V2M driver support 5.10.y-cip?

Modify the original mainline driver by using the available PM macros in 5.1=
0.y-cip ?

Or

Port commit 5ef11c56b2332613cacd5e7ac17cfb1a073b66ab as well??

Cheers,
Biju

