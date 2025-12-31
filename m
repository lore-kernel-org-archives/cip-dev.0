Return-Path: <biju.das.jz@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E467DEE6427
	for <webhook@archiver.kernel.org>; Wed, 31 Dec 2025 10:08:40 +0000 (UTC)
Received: from OS0P286CU011.outbound.protection.outlook.com (OS0P286CU011.outbound.protection.outlook.com [52.101.228.17])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.83044.1767175715346473956
 for <cip-dev@lists.cip-project.org>;
 Wed, 31 Dec 2025 02:08:35 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@bp.renesas.com header.s=selector1 header.b=EM0TD1Ke;
 spf=pass (domain: bp.renesas.com, ip: 52.101.228.17, mailfrom: biju.das.jz@bp.renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZVtqvn4yFFk1JeqB3isU9QFSl5XMMOREus3KU1/0b9g8wmTz6kfKMI0YhpINN5wEbBJLjo4lgpw/xZeBx69dbXPiJQpgy5DvbyWUpzGY6sKrTonmcvby1u67eszl6zp2LnktbMiA5Eg1UW/+pnnz1K5kKoMCWp7MsaCJEcjaL341g4YCy+/2MT8X98JJwdZGpYN8xD3By6bY+xmiZL5ixaATzru4NQX78GYfZGyowdW1vaxh9RaOEu3U2xgKYDIgMx0F2P3Ono9a7bGuxk+ev3InDu+R9sM2+e0dCmA/fPVzr2FCcuftUBpxclTIWUna4zVwceUc33S6k8tM7CTwVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=47YDU/lLd52qfNqAK85jQMU/YnI3yQeiwOPdzekCPhA=;
 b=dNVV5eDGTiRku3Wr3d0RtZKLeQSJCSs34wUpbzU0a3SgJabQkvzW9/mKufQ2xb03Z/AapDpEQgVEdzgZXGkGEfQK2FYuPoQxANjKdvYar44ASWvxjD99d4J+J4Bh30RIbcJ7sZp4AiS1Pdd65gbMsmWj2OAjB8d8rbZdY3s9NRlBgBLbqExGwwvMG9SIDzAghbtDnSrNtl0I4XAmrSlfkMZdKVH9AV6HfIbaHgc6k6wQ6/uAS17zC8plnATnCoOWcgyxhKGQZVtO8+Te0Z5anqSXWsikFOhty+L74s2pYf3tSGbjrNnSk8oNfXfEAZfaYtT2BMNUZkq/fbD1ZAUqJg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=47YDU/lLd52qfNqAK85jQMU/YnI3yQeiwOPdzekCPhA=;
 b=EM0TD1KeCXsUOMa8gb3l2qdWAMS+LYWpYBP/tIGzCqUPqGOlrMuQxrvStwgfXGBtg1bY4RcyARxYGzY3Vmb4xwtlNPDwLjtNAxej3amdBfF33o0Zp42JlL4cR1pKKjXfLt/DCYPcEfqHGSa/uGRNbYRkfZC2shxiB0WS4ETLdtE=
Received: from TY3PR01MB11346.jpnprd01.prod.outlook.com (2603:1096:400:3d0::7)
 by TYCPR01MB11578.jpnprd01.prod.outlook.com (2603:1096:400:37e::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9478.4; Wed, 31 Dec
 2025 10:08:31 +0000
Received: from TY3PR01MB11346.jpnprd01.prod.outlook.com
 ([fe80::86ef:ca98:234d:60e1]) by TY3PR01MB11346.jpnprd01.prod.outlook.com
 ([fe80::86ef:ca98:234d:60e1%6]) with mapi id 15.20.9478.004; Wed, 31 Dec 2025
 10:08:31 +0000
From: Biju Das <biju.das.jz@bp.renesas.com>
To: Pavel Machek <pavel@denx.de>, biju.das.au <biju.das.au@gmail.com>
CC: "cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>, Nobuhiro
 Iwamatsu <nobuhiro.iwamatsu.x90@mail.toshiba>, Prabhakar Mahadev Lad
	<prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: RE: [PATCH 6.1.y-cip 05/12] pinctrl: renesas: rzg2l: Fix ISEL restore
 on resume
Thread-Topic: [PATCH 6.1.y-cip 05/12] pinctrl: renesas: rzg2l: Fix ISEL
 restore on resume
Thread-Index: AQHccDOFcIoFQntpbUuGUocygXPiS7U5M4OAgAJmmRA=
Date: Wed, 31 Dec 2025 10:08:31 +0000
Message-ID: 
 <TY3PR01MB11346C0235E1FC8CC256A703086BDA@TY3PR01MB11346.jpnprd01.prod.outlook.com>
References: <20251218153219.228506-1-biju.das.jz@bp.renesas.com>
 <20251218153219.228506-6-biju.das.jz@bp.renesas.com>
 <aVLyS0dkGgaOhh0H@duo.ucw.cz>
In-Reply-To: <aVLyS0dkGgaOhh0H@duo.ucw.cz>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY3PR01MB11346:EE_|TYCPR01MB11578:EE_
x-ms-office365-filtering-correlation-id: 42a5b8f0-e0ec-4ffd-287d-08de48548cee
x-ld-processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|38070700021;
x-microsoft-antispam-message-info: 
 =?us-ascii?Q?DzdQhdWwimjNDep185+ohj/0mH/sK5D7IwF8Nd45mowBl8NX7k4SuDRyxCzz?=
 =?us-ascii?Q?Yd5oh1w+ji0sUxPX+3UvONtal1kUnpUqgnFAr1DsQXjv4B/FdMoX6Lu/4aeY?=
 =?us-ascii?Q?IEf25erw6D+2TSNSKNwhbwVo1pq8s91+xcE6YAwsGxEh0LOqKKYxfPcuM85n?=
 =?us-ascii?Q?Nf00T5V2QGU1NHXJI8gB4L/tYnordUerM+lIDPNqKV14q6Lebxo0nbg40wl9?=
 =?us-ascii?Q?g2oCpuw4kSSgQ51srgM7bCos/1kLZe9QAVJ77Qv5V6nwMRSyBC3y9/RMDamh?=
 =?us-ascii?Q?oGTILG1xFonT8FQoJ+ukAtnWp1RrgfuBNMqBGeDFt1FM1ZkW4d2gUPAf0GcA?=
 =?us-ascii?Q?CAfQ1EFD6Xb0yOeP3mYFKWVa51cn5Jo5U0OzCn2JLTbhGuqaFGtWl8wwGs5x?=
 =?us-ascii?Q?zr07WgU9Fk7R9u3hDCNCy9yKeisks3/RFnNemj27mNNmZ3+6194mVWHg662K?=
 =?us-ascii?Q?hCk+SssLCMNpA5vyd/cxM17weJ36AmzDT7ttfiqe+EKLqyVPlnCXLtizF+jA?=
 =?us-ascii?Q?Cq2eib1ZzRDbY+bshcE8OAJXis8jpv/Z6ye0bOTb5oLi3Tq4BLUGokhlwUih?=
 =?us-ascii?Q?QNfUmS0CW/xzskbTZxohp/Gb0eYgn8mP0rzCb/ZBTt04CX5y6+DDK9HVG1im?=
 =?us-ascii?Q?4DvRCZe0NSZJ5fz0r/iCgHdsPPHIP+F0KOWxkGTlic2ho9GHnr9KSpDy3KUW?=
 =?us-ascii?Q?EVhOx/kJdxFcVGLi8muLG5jVpnWMDwVHeBC/34lvco+8wkfFQjQDbVgPMyxr?=
 =?us-ascii?Q?B/MwoGiE+j3t206s3IrcJvEiPw6HsyitgNooeX5JR4HAA4Gf1OyHcny6qW88?=
 =?us-ascii?Q?2irkTcLJhrRlvnkEzXyOz+Au/tgqgGOo4Wyzcgs+mOPt+cOhhzPxvdpbmDBB?=
 =?us-ascii?Q?vBLT4/MgORHcS0PaoVDXMcE7GIyRtPkJdRXmDbXbKgfdKy60EDVsItujfYHp?=
 =?us-ascii?Q?qegIs7awIm1OEdsfIihhrZFgwKuql2LHC4lQ/LDc7O0EtGumphryqL9DslGI?=
 =?us-ascii?Q?GYW1x9QN5Gb+y5HFdQnvo3yzJYR1aZDuMN5bM0pOy05eIcjFWZqJV3xnCXAT?=
 =?us-ascii?Q?33xi04JNsEC6+9dSFUK6hhavFMpr7adW1daxUL+o0i1pBFuibGmkJB04h3E2?=
 =?us-ascii?Q?UGsM9A/fdUt/Zkqg6LyQav4MInl6N3FIgVzWfJzFPOesV8lVMCkIX2meQjpX?=
 =?us-ascii?Q?TXMNrGG1tHKrvdRkjpDn/AZ+pDtW0lx+i2U4DQXpPILWwMuasMleKRxQXWsG?=
 =?us-ascii?Q?I1x9pCrfK0yU3V4iY+C/0yJTo4SFza0blacgVd3dh93wNwaPtUIbSsXnREMb?=
 =?us-ascii?Q?WpXX2996cyzeuZDn6r21K1qJo9DtmU7xh3EsFP5ht/PeclsdsgaJkTcf90pQ?=
 =?us-ascii?Q?CuT79tsa8NKnXGAg1Sl1E2+iV4myFs85K8xVSLM2e9lmtGHOVAARsFzxJeX7?=
 =?us-ascii?Q?1BnwqLQph0wCmQ7E3DVYO4txoBq1EyIHpjXt1/9N66ZwjY9VxVRC110MaIri?=
 =?us-ascii?Q?r8LqI/bZZifwOX3n+cAfMgQAL6nSlHiQkuAG?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY3PR01MB11346.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?us-ascii?Q?KnXd5wf53OYRlXsOd0WI/tD717BUZX90obH2d39RglyvtGZ44mG94BOLLm+t?=
 =?us-ascii?Q?ONwq6cT9IMFVDA0pYPPDuC7+MuZ1jo0XY0aRoxyzWG/9Ezbm4DXQUFbOXa9s?=
 =?us-ascii?Q?rFBUs1FlF2ox9hnBU8TRbc81ECMSJxLO5AYZQMndYsgSPPvbed6GUQEGyHrK?=
 =?us-ascii?Q?JwirmsvxGeHtMcglyLsaf4RM4DBU9o3XNiduK7wvI/HVGlyhLeJDxgFC0u9o?=
 =?us-ascii?Q?eDPSHTpWL55IpMY1nHN3FuglsL9ttvOU4rzBSiPktJo58+8HSFs0x/rDg2q+?=
 =?us-ascii?Q?5lDCs2gncQiFqMOJM1YInQohRCrZWRlLwIg4lHPDlxMJeY1EVVQuf4Ay/72f?=
 =?us-ascii?Q?l9wIF2LkHRmzz7L22gs+lO7JsLEU36phWa71QzNOBz4oiPzEB4AUh0XyYpCe?=
 =?us-ascii?Q?ixcz/rRG36cjPgtSzAcPUFxGXRPAB91q0v/dB2DOsPgWlF+0FWiMlXDZWBMZ?=
 =?us-ascii?Q?Iiuu5tHknMHIhZDNU9G0wID188SQGJ3KJYOFOCTfDmo6BRexELPtcYJrrl3J?=
 =?us-ascii?Q?QAsl5VHgP+wSYZtz26ymSG1U5pFQghhLip3Ys2lzm8pqBMGabzsNYIZC2Ekx?=
 =?us-ascii?Q?YuW2aADqQKjl9XJKpiM1Q9Hh6wJwFTxp3CuLCce5Ufg3aJPhw29j2h9HqvmL?=
 =?us-ascii?Q?mhHl0nKqGxZBf9lQ2R3NCp9sC8xBCZPtRRYqJynkB2c4JF78GyxV74TpSYPn?=
 =?us-ascii?Q?5XqHfesi03qd4oPXkTX3YYGGyCryIF2eCidiafqVqWmRBRbNKzj3+/+JwQ+e?=
 =?us-ascii?Q?lwedeEUSWw40tLFXt76WZZ9RBlxYETsHoRbZXdfgmv0ycLNR+zZ3gp+FycmX?=
 =?us-ascii?Q?INqo+66csaHZOQZ68oK1njjXUEeice0v52UaUNNJvvjdGGMFhA1zKTSguCew?=
 =?us-ascii?Q?0aiFSsRBx71p+eJCK5HSuu5D6Ql7oKwUUjqe5qV6utJ1LF0F8+3BtSlVQkml?=
 =?us-ascii?Q?hI545ybrb7l4i39V9lRrPHLN5hnD895oYQzSx11LvK93ZzQ4usrmOPqGPTZj?=
 =?us-ascii?Q?c/VOLLsxpMLwVD7KBPWi6rR3x62Ce/OakDNzer0/NxKkKAsHypgOXsHeiwWC?=
 =?us-ascii?Q?ndCF5FM1V3FI2AoDmI8U2Lyq2fMI2xs2ZGShk1PWLaaiLm8C09lhRugxjHvG?=
 =?us-ascii?Q?CuNJhp+GtoUzPRmRohr0nytEJacHQaBoYrvBpBFJNkGJB71OJkYlqd8maDch?=
 =?us-ascii?Q?caxuYV1kuO7AxwfVo7mXLq39vSBwKK2hOkx4+K9ijOv+ONLDvodNXQSu+e9c?=
 =?us-ascii?Q?NHPeCXp2r1lOewWF6w2LJqrd05mvcJBWfveEKUQBqm0+VimTXJTZUNV7Xz0k?=
 =?us-ascii?Q?b+qxe1t3Wc077fj41Dw4UH3m4eZ7n/GHwOwPoWBuHijISKk5oCls4DMxrrxZ?=
 =?us-ascii?Q?B4zbR7rwWK5TLqVlYXcnQ+JvYiD3tWeP66ZLwHnJ0oSicgJpOH2+GToaF3C2?=
 =?us-ascii?Q?JHSuq+f5fyLz69Cif/7xPBw4jJ08L3pZT3r06S7adcSYTibihjwijHR3Y7wh?=
 =?us-ascii?Q?PVBcjeLt+YWy9ZfX0gC1E/Q3CkOXqJyb1I/gUz5UKHX4aExLaJj41VhR7D0H?=
 =?us-ascii?Q?YVt0cJRLp3dTC3OFNuZyvvq+NdR31TCtjow4sKp8iiyCTIePLYDikb1cVTXr?=
 =?us-ascii?Q?jyUq6a46NbhcyLCmxP0uEJAvg5CizbxvZEY3T+z2Zm4dl/b/QyVlUFSoDsLQ?=
 =?us-ascii?Q?xWqhVzsONbbfNTUwZraMolHGlzEbMW5CYYdThef76oM+C5QUDGtUhYNzMuzc?=
 =?us-ascii?Q?y/vUmDiFnQ=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY3PR01MB11346.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 42a5b8f0-e0ec-4ffd-287d-08de48548cee
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Dec 2025 10:08:31.1811
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: JlIAfDUYu/nlkmnOam9tqoB+O/VM+kBKgmTWS8vQQbHEpEfc3ExIjcZce0fsgrg+NkNN1ijpnllKplt90alDYTNFCsXgO0ojppQ4XkyKn4c=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCPR01MB11578
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 31 Dec 2025 10:08:40 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/21278

Hi Pavel,

> -----Original Message-----
> From: Pavel Machek <pavel@denx.de>
> Sent: 29 December 2025 21:28
> Subject: Re: [PATCH 6.1.y-cip 05/12] pinctrl: renesas: rzg2l: Fix ISEL re=
store on resume
>=20
> Hi!
>=20
> > From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
> >
>=20
> > As struct irq_chip::irq_enable needs now to lock to update the ISEL,
> > convert the struct rzg2l_pinctrl::lock to a raw spinlock and replace
> > the locking API calls with the raw variants. Otherwise the lockdep
> > reports invalid wait context when probing the adv7511 module on RZ/G2L:
>=20
> ....
>=20
> >
> > diff --git a/drivers/pinctrl/renesas/pinctrl-rzg2l.c
> > b/drivers/pinctrl/renesas/pinctrl-rzg2l.c
> > index c7d6914098f8..7b22921e6840 100644
> > --- a/drivers/pinctrl/renesas/pinctrl-rzg2l.c
> > +++ b/drivers/pinctrl/renesas/pinctrl-rzg2l.c
> > @@ -2460,15 +2467,25 @@ static void rzg2l_gpio_irq_disable(struct irq_d=
ata *d)
> >  	gpiochip_disable_irq(gc, hwirq);
> >  }
> >
> > -static void rzg2l_gpio_irq_enable(struct irq_data *d)
> > +static void __rzg2l_gpio_irq_enable(struct irq_data *d, bool lock)
> >  {
> >  	struct gpio_chip *gc =3D irq_data_get_irq_chip_data(d);
> > +	struct rzg2l_pinctrl *pctrl =3D container_of(gc, struct rzg2l_pinctrl=
,
> > +gpio_chip);
> >  	unsigned int hwirq =3D irqd_to_hwirq(d);
> >
> >  	gpiochip_enable_irq(gc, hwirq);
> > +	if (lock)
> > +		rzg2l_gpio_irq_endisable(pctrl, hwirq, true);
> > +	else
> > +		__rzg2l_gpio_irq_endisable(pctrl, hwirq, true);
> >  	irq_chip_enable_parent(d);
> >  }
> >
>=20
> Wow, conditional locking based on parameter. I'm not sure that's good ide=
a. Won't it cause problems
> with tools such as lockdep?

I believe it passed all tests.

>=20
> Having separate functions may be better here, even with the code duplicat=
ion.

OK, will post a patch to mainline and see their feedback.

Cheers,
Biju

