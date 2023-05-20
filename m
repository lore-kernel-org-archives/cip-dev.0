Return-Path: <biju.das.jz@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3984C77B7A
	for <webhook@archiver.kernel.org>; Sat, 20 May 2023 15:01:04 +0000 (UTC)
Received: from JPN01-OS0-obe.outbound.protection.outlook.com (JPN01-OS0-obe.outbound.protection.outlook.com [40.107.113.106])
 by mx.groups.io with SMTP id smtpd.web10.12264.1684594861476683538
 for <cip-dev@lists.cip-project.org>;
 Sat, 20 May 2023 08:01:02 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@bp.renesas.com header.s=selector1 header.b=D8TYP7Js;
 spf=pass (domain: bp.renesas.com, ip: 40.107.113.106, mailfrom: biju.das.jz@bp.renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OMtjAhUQfm/Dp9mSWOp4T2BBukTtDKiPE9P3ac90QjQIoEEM8ejyLYaX40GSZKhs9gVXNHI71g+2yf1rbHuetKQwjtAxafwumkykTEad48xmsTfIeljS/KnmAUz0ajEw8pYYyj+HUYHzQjmxd1FIeltWT5M0MEegJyvRIisEA4O1WAzoGNAI89QBqOPQK9FYyq7xr9jIl9eWTKfI0CiFZPBi+fBmbj5OU6PDlAJ5Q4a4WyUVk4SlxnqlbdqYsowRPD/lmPaTh6XHxkk4WV2fMLgFC1aL7wfY1etIQ5af6ikAwM/GCevP0bpjv0jcaqoGDkKUj+0fk+GcxArBvjgsMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MpF3+0fKIEvWcEokUx4H2WcxwoaSrtupHvkSV6OhVb0=;
 b=Wg5rVF9Orm8QwkevLS3c1tZlja5nWG/Izekgf0KEfEv4fzxXc/C/+GsrFjeCDp4g+/xPDHSRI/AU1wsL2zlFYNeTgrnpZnxWi+roBKLrMXPygZ4kFx/lOk4jZdpyvr3Nb5+94rDdmp814OioWUDYXRaiTTP1Va3YRVzC/nTY3z1eaffCPTcavpOHu9M/evdvJ5/k+LWqEOyL/D7ckvBu7YNDYeD/ll9yt389RnGDloZZ/SIofSdmpz9f/t269EG229UyMyRyvRUfNI5QC3yGn0OK0YLe1Jt9J40s2SSi9tQcnmaYh0ssmDqO2me4SiEx4AQOiHJViT7c0MxdSsQjOg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MpF3+0fKIEvWcEokUx4H2WcxwoaSrtupHvkSV6OhVb0=;
 b=D8TYP7JsGEMiBIb11K9bJjNQcX73nDWSzo9JDnIRoBfFcdR6bv39OdQ7r7Xjp9Q+e1rjQOI7+tI5sj/CQ46BMzY+quAcaoSTSroIRwwflEK15xSACLeq9GWLgHxltjkGuQhr6BXSm0owGJBJBSRHWfhmPqvwZJoD93l6k+UVmc8=
Received: from OS0PR01MB5922.jpnprd01.prod.outlook.com (2603:1096:604:bb::5)
 by TYWPR01MB8605.jpnprd01.prod.outlook.com (2603:1096:400:13e::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.21; Sat, 20 May
 2023 15:00:57 +0000
Received: from OS0PR01MB5922.jpnprd01.prod.outlook.com
 ([fe80::bd0a:a38d:b4d2:5d2]) by OS0PR01MB5922.jpnprd01.prod.outlook.com
 ([fe80::bd0a:a38d:b4d2:5d2%6]) with mapi id 15.20.6411.025; Sat, 20 May 2023
 15:00:53 +0000
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
Thread-Index: AQHZiirvlCSFUDyQGUWjF9mQbrWi9q9iKc8AgAEX+CA=
Date: Sat, 20 May 2023 15:00:53 +0000
Message-ID: 
 <OS0PR01MB592279CFAE4F7FC03C7414E1867D9@OS0PR01MB5922.jpnprd01.prod.outlook.com>
References: <20230519082058.109760-1-biju.das.jz@bp.renesas.com>
 <20230519082058.109760-15-biju.das.jz@bp.renesas.com>
 <ZGf0bB94Ugj2sQ36@duo.ucw.cz>
In-Reply-To: <ZGf0bB94Ugj2sQ36@duo.ucw.cz>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OS0PR01MB5922:EE_|TYWPR01MB8605:EE_
x-ms-office365-filtering-correlation-id: 7df77d04-05d8-42dc-5c66-08db59430204
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 n+5NUhnF4OqS+5Tmh3Gb57Vz2FQlvYYRlh6YNdI+wYUnEBl8tKMUalEyg6Dno84HBSQPIFpy5EG1fI2BA6OBn3LXD+HVeEfKtNvtG8iVZdViWi2zedxH/dbjiWhXx7wClXOzwbBNL9ZoDUmQ4yCa1QYyx6wxaYvBdTrIU1XBr62GFgIf+8g+FpjTYQ7REhLJZ2AH6FwoiLrH34sAx42A/cmMY+jmP9lNMOKjrX/kTjYzD/3zPYcUxJYof7vMzuzOUv1UOAK0/kJAf+dwQO34zOkT0ZmLoMDSa7TBhQ5BJZR0C2xtiCvitI64rGGwOi6p1njae+B3P126eC/sYfXxw8s9lBhAKQawRlLZBcdK5S3qrwX50+Ws3m1bTrDuZys2JbeuYvjrokKfBZTIB0rXDtptNMJearYIbgZ31HGJMFd3LRNrEuXKycCDtJEq2mjnRuRe/mKOyGHHLQF7Vz0d4Txtv+3GCMZ3BnH847ae4xjWrkHyCbOuV/T8nIViUyGP7UHqjzXMfZs6VT4L7gOpEumsUMMsNz/6A+yFDVh2LDGMsNHdXdfoW0DdQbS3t5MvNs4ItGeGjiMVduUsD8bOoKRJwBf2swkI9kbVOzlxPq0=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS0PR01MB5922.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(366004)(376002)(396003)(136003)(346002)(451199021)(9686003)(55016003)(5660300002)(6506007)(107886003)(8936002)(26005)(8676002)(86362001)(33656002)(83380400001)(2906002)(71200400001)(52536014)(7696005)(478600001)(66476007)(316002)(64756008)(4326008)(76116006)(186003)(66556008)(66446008)(6916009)(54906003)(66946007)(38070700005)(966005)(38100700002)(41300700001)(122000001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?us-ascii?Q?0SVep9MYBlsSddujIz7vrV9gbQ3Ne/iixDbC0zb9f3AFqBTwlZioMZ/D+V//?=
 =?us-ascii?Q?ScFbY6N7YYPeEqZLtKIO4ItXodIowvB35+Fg9QT61/2Xo/jpLbabdj0bysgw?=
 =?us-ascii?Q?+iDwfSR50OBEy4RSAEdPbgRZu7p/kfMY3gqrYq7boy0KIwCt+E7pjNHiHzBb?=
 =?us-ascii?Q?GQ85UbIl1y6YKkE9vDtN49QKxKePpqPlx72mcJsLH9iO01ZjxJDhJijJTeT5?=
 =?us-ascii?Q?rxmgF+zLWna1VMQyJx+tfHgaCyZklTXLjms0tp4U4OBSpEQFy+NWtLcJo2zu?=
 =?us-ascii?Q?JGIxr8v69UWUGtoE0+am5i8ZAsBmRxL6Hwn8lJDIJyO27N3vkccbHWeUicEI?=
 =?us-ascii?Q?HBvc6PtOdjQZYFm0dcCkdyYM0yQL4KwZs4JyaFkwQF2OmH4TK120+BL3gM4/?=
 =?us-ascii?Q?un8F5qqqO4eg+rgQKNZy21ks65MgCg0f5ZCc+WcfN2pw6tQL5jgHsESBOY6O?=
 =?us-ascii?Q?e2mEVxr2QY/xVvy+GrUqp3+ylC/i6ENIbP6/GijWm1tVbdKlSaJUdWb6bNbc?=
 =?us-ascii?Q?4VhMOlxdPOXhXYhuVVh+ke58FUohdJaJ2mZ+aEE7ckAMeVwoNHm4pgz4dTo9?=
 =?us-ascii?Q?fqhJ4agsFlEhT4qL6QkuN4e80HNFRORoo+nJHpJ0Ul/f7e2RdpGVGzRF+CWG?=
 =?us-ascii?Q?5Fq6MDucSDL4KuGTK9frfsSnukmAuARvzBrChh/rNNvumnmMiiQuCqKzIR5Y?=
 =?us-ascii?Q?6JyynzMR6ZlLba6T3RDmi2iPykUB0/747uKL/sk2EoSlzikL28WY5CgdAAGV?=
 =?us-ascii?Q?wcijxM8Ggik4eehUwpDqP/PWxHZVbEhr/SzLeDdprFVhg/P3tDGzjXIsYU8A?=
 =?us-ascii?Q?XfYpwWVV5W/guNzmLZ2ULp2MbhcqnbdrlRLbDza2tT/55A1kXEi+BJ+8antL?=
 =?us-ascii?Q?QpJOSse6n+DD9BL1YWB4O3upG/ILuRw+zVHdMhx+RTdMD6gv2wBfhZ9ClgCL?=
 =?us-ascii?Q?BsR4Skxeaw2F3rOFKUHaCpjRYjLpRtqFmEzQIjMJOA0idX0CMRFaHj05KqtH?=
 =?us-ascii?Q?O/rj+J+OXU5yY7qp186mqNQnuohj2aLmxWsTPmYAecNTsdpeCI4lKmr0AvRC?=
 =?us-ascii?Q?BZnI1MvK+Sp3i7rE0JlvAz2It89Vbb2KNlC2LIA7he6E3r5MTBThV+C6CBPh?=
 =?us-ascii?Q?vu16ny6fnHggmhx7Q+FEB13f9C3olRpB9oiSajhAQGPWvRX5N0RZwHb/u1Ir?=
 =?us-ascii?Q?NAkO0oYhIBUcBn1DJyPIN4NBL6NRcAB3al5X+nkomY0PuxarhMjJaSWGAQoH?=
 =?us-ascii?Q?sIaXuyIbvYCK6X/KHTyiCulJCdTmikmkUmz9pLNRq0BCpPkqGBCNoBbK70Dy?=
 =?us-ascii?Q?jN937quraAWq30ZQfnkUGOXc+XE0w2Zqkrif7oIUKusyt0tRhhlhN8uIc8r0?=
 =?us-ascii?Q?7wz1RvWKIGh02kzXvzDMAPeCRA8ZxEGIlLohItTDElhY/M6dE1KdfiLhKwSj?=
 =?us-ascii?Q?QG3T09ppa0uOwrLeTaeMGBdr/q0hlqtrfC5IsBI72/iQ6SQ+Azeyg/jb4rNR?=
 =?us-ascii?Q?zmZLgx48CBRFiejLCCDXRm/yt5y/GK17zmmLw8nOkYRPktsADFc//Ukag0BJ?=
 =?us-ascii?Q?99zgum9/b38z+XbGPNBx7CB2qAHi77nNZPS2Zs5l?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS0PR01MB5922.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7df77d04-05d8-42dc-5c66-08db59430204
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 May 2023 15:00:53.4219
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 7UN6cEsqqFnKNhSKvcXqB4pUgrf1aqnsp1L93qDeW+6hz5F9K2Rh/9vyf3HnF2a6Ia7bvrwf7iecisit4PNYNDa9dvhkMXEMArqnkqtKWe4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYWPR01MB8605
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Sat, 20 May 2023 15:01:04 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/11572

Hi Pavel,

> Subject: Re: [PATCH 5.10.y-cip 14/23] PM: core: Add new *_PM_OPS macros,
> deprecate old ones
>=20
> Hi!
>=20
> I'll have comments on 19/, but this one is kind of important:
>=20
> > From: Paul Cercueil <paul@crapouillou.net>
> >
> > commit 1a3c7bb088266fa2db017be299f91f1c1894c857 upstream.
> >
> > This commit introduces the following macros:
> >
> > SYSTEM_SLEEP_PM_OPS()
> > LATE_SYSTEM_SLEEP_PM_OPS()
> > NOIRQ_SYSTEM_SLEEP_PM_OPS()
> > RUNTIME_PM_OPS()
> >
> > These new macros are very similar to their SET_*_PM_OPS() equivalent.
> > They however differ in the fact that the callbacks they set will
> > always be seen as referenced by the compiler. This means that the
> > callback functions don't need to be wrapped with a #ifdef CONFIG_PM
> > guard, or tagged with __maybe_unused, to prevent the compiler from
> > complaining about unused static symbols. The compiler will then simply
> > evaluate at compile time whether or not these symbols are dead code.
> >
> > The callbacks that are only useful with CONFIG_PM_SLEEP is enabled,
> > are now also wrapped with a new pm_sleep_ptr() macro, which is
> > inspired from pm_ptr(). This is needed for drivers that use different
> > callbacks for sleep and runtime PM, to handle the case where CONFIG_PM
> > is set and CONFIG_PM_SLEEP is not.
> >
> > This commit also deprecates the following macros:
> >
> > SIMPLE_DEV_PM_OPS()
> > UNIVERSAL_DEV_PM_OPS()
> >
> > And introduces the following macros:
> >
> > DEFINE_SIMPLE_DEV_PM_OPS()
> > DEFINE_UNIVERSAL_DEV_PM_OPS()
>=20
> Changing interfaces / deprecating macros is not good thing to do in -cip
> kernel. How sure are we this will not cause build failures or build
> warnings in unrelated piece of code?

Please see the commit [1] carefully,

Deprecated is just a comment and it is just single header file change and
There is no existing macros changed.

Please let me know, if I am missing anything.

[1] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/comm=
it/include/linux/pm.h?h=3Dv6.4-rc2&id=3D1a3c7bb088266fa2db017be299f91f1c189=
4c857=20


Cheers,
Biju

