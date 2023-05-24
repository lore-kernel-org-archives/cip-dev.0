Return-Path: <biju.das.jz@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32E0FC7EE23
	for <webhook@archiver.kernel.org>; Wed, 24 May 2023 12:35:15 +0000 (UTC)
Received: from JPN01-OS0-obe.outbound.protection.outlook.com (JPN01-OS0-obe.outbound.protection.outlook.com [40.107.113.97])
 by mx.groups.io with SMTP id smtpd.web10.7554.1684931708878871247
 for <cip-dev@lists.cip-project.org>;
 Wed, 24 May 2023 05:35:09 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@bp.renesas.com header.s=selector1 header.b=ZTrcAJUt;
 spf=pass (domain: bp.renesas.com, ip: 40.107.113.97, mailfrom: biju.das.jz@bp.renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gjnsBl9kKH2VowUtYFFaqwvwSBMngxBz4lGpbM3ZWqpBQ28JefC2xM3K9VZ3MSGuXk/GMRUg/dZoOmnwMkGY95XnYPEqurZexr8H+e5rBt/Z6c59yEXPgvU2giGXirSklBxeEbxbh3Si0GO12qhINm0lUyY+AMFvM5gA0KnWF3Ep4FXd+WbqsgsT9oIFZqyuFJqCSr6QaV9gfxhJg3mZ4BAaH4RoaxybFvrVWuLxTee00mimOJG/x0Yn2twBwTlHup8LxnwCpMCD6ZIt4NEyF3lOWamur0XceV2aH3WMMllbgZ+fAfWtmpe9QgNhtsHeWiUPO5MzMPF9nGjNpvVEHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1j5mLPBV0/bzWi6yiAtkOYm5OAjaXlgFgSzAi26ilT8=;
 b=g/xTnd63EFZpiALVHwdGrTWewSzVHwD0BDhIeiT9dmXogyjTPQaWaLcMIebXAi9iVNQzL5aGudBFqQJJC+zG7XEYqogbG54oEEl58ySWhjvCstpVPUkPYsSAIcgdjopwItH3oOSaQh027RAE9MK+lI0q8x3Uu3u4oEUz49bKmVSfY5WJScfPRjgJIxRUpv3UHsxnedsCaHOdBV5Mk3Um5CI1XlhrEja8te9gTuAyCg/7l7fYoRjyN+4UQ/fXhMCctmpo4OPXRq9GNG6Auu5KBuAXGoXDNluLQ1MuOjOnEaUiAPXtSLQqfeGNBkAJ/85faIvqhOKXKa0O2c7Fdi/FgQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1j5mLPBV0/bzWi6yiAtkOYm5OAjaXlgFgSzAi26ilT8=;
 b=ZTrcAJUt2VKMnLP2XnEllHc5TZopujzdUuC8fbeKcZy2fy4O13L4iMn8/53OLoGzuIbSu2o/7n4hh3ZdWToZNJyX4gSYPOYmn8+zUhthwzCpEkMH1VefZp/D6rG4Ssi6yQsz7FnLsQHgpCUzGyVGFDmaFMz+pBf7URIBqjzVBqE=
Received: from OS0PR01MB5922.jpnprd01.prod.outlook.com (2603:1096:604:bb::5)
 by TY3PR01MB9683.jpnprd01.prod.outlook.com (2603:1096:400:22f::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6433.15; Wed, 24 May
 2023 12:35:04 +0000
Received: from OS0PR01MB5922.jpnprd01.prod.outlook.com
 ([fe80::bd0a:a38d:b4d2:5d2]) by OS0PR01MB5922.jpnprd01.prod.outlook.com
 ([fe80::bd0a:a38d:b4d2:5d2%6]) with mapi id 15.20.6433.016; Wed, 24 May 2023
 12:35:01 +0000
From: Biju Das <biju.das.jz@bp.renesas.com>
To: Pavel Machek <pavel@denx.de>
CC: "cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>, Nobuhiro
 Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>, Chris Paterson
	<Chris.Paterson2@renesas.com>, Fabrizio Castro
	<fabrizio.castro.jz@renesas.com>
Subject: RE: [PATCH 5.10.y-cip 19/23] i2c: Add Renesas RZ/V2M controller
Thread-Topic: [PATCH 5.10.y-cip 19/23] i2c: Add Renesas RZ/V2M controller
Thread-Index: AQHZiir4WQp2yUoxukuz3Z0GivFW7q9pFJ+AgABLp+A=
Date: Wed, 24 May 2023 12:35:01 +0000
Message-ID: 
 <OS0PR01MB592263700DAAA12435D45BC986419@OS0PR01MB5922.jpnprd01.prod.outlook.com>
References: <20230519082058.109760-1-biju.das.jz@bp.renesas.com>
 <20230519082058.109760-20-biju.das.jz@bp.renesas.com>
 <ZG3B469M6oPKqDIB@duo.ucw.cz>
In-Reply-To: <ZG3B469M6oPKqDIB@duo.ucw.cz>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OS0PR01MB5922:EE_|TY3PR01MB9683:EE_
x-ms-office365-filtering-correlation-id: 048e2d91-dfad-4094-049b-08db5c534b1a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 Z7RrkhUIUA1uwmGoW7AXgT/mApFUKusNOAqD1afW7CTK6HwC5J+mKUv3i5P5G8MIg4PLOH1L/WhDWMf+oTMFQeh5fr+gFGwH8Jl9jnwAZ0J90xun35F3UkjP7sqjAeA+jsQlMQWVXH0Gc4rj9tx0x/mQb3UUODwwz0YEcxpNV2V3S8/ENcK05vb7yZsG1z6OzURDXodE7aj4zz2ajVHgStTlUQLLxI/xRybFDpMA9RkL+/pSvp7xTFgTvl15h6k2snNjE1ZMJc0FoVMW3i37CeGQct4JpIDf10cElDZY9P+ktGB+M5oiPr2fK9EwHp4IMeY/1eWOUV/IA8viMoQHnjMPco1A7MDGh/pPfCM/pQeUjHjq7K/5rht+QfI/yuhDxgk8wMEqar/UCVjrohcgd7xJjIc9ejB7KElLdjuoo2ky9mJLgOcO5TMVwGQBDmspiTSflsyfcVJsyqk+lfeDhy8GWZDAmwO4Ah90c04zzjLFcUSJNuiwo3/Y7vkldSykJpZnS4Hz5QWlIgdf21V1HabeATzAa6ivE95k232Nvr1bKSOD1yvugNsRIlEVkzR8VKEljjYsRkNB/0e1MBsoP4YMw6IfknnD5QwMNey8ujK3YA37u7FhWqANCwoN9VG6
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS0PR01MB5922.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(396003)(346002)(366004)(39860400002)(376002)(451199021)(8936002)(8676002)(5660300002)(52536014)(83380400001)(107886003)(9686003)(6506007)(186003)(86362001)(122000001)(38100700002)(38070700005)(41300700001)(7696005)(55016003)(71200400001)(33656002)(6916009)(66946007)(66556008)(64756008)(66446008)(66476007)(76116006)(316002)(4326008)(478600001)(54906003)(2906002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?us-ascii?Q?QE9tsCbBlsOFmD77rewbkCJZPCaIaNDWdOuSH4LlzmthHsXhrlty76d+y3+P?=
 =?us-ascii?Q?lwCfnesDOJGHLHvScQGjy8TOgS2C/Cvv+a3BKNqTCfvr1+nV9DMQhlSrnCoS?=
 =?us-ascii?Q?O438P475TOgoaSErd1nwIHCI/EUI/MCjYQaYoW2NSsXx4O1Y4IUzfA/Kf879?=
 =?us-ascii?Q?R+xlNjUPbUhKi47172L+LqeEIxokR9GGOj5CiBfq5T9cT52sFmAJuEssOZIn?=
 =?us-ascii?Q?f/5c0tfPYNuhvf7/dSFKsH22SExvGWTMHYWMLyqJqIPdJAPSnMr5cCg3kDXh?=
 =?us-ascii?Q?L9UxCehEJtFGUXvMgocpNLDVptjZS73fw8aLCMHuGeHOYDQcdR0ZM+2mo8HR?=
 =?us-ascii?Q?NLpmONloYMmQ+5lwlXxOgIt/n/qNh9PbWOeiacj3w0oPwgXbpdqaCmWjBTsB?=
 =?us-ascii?Q?wKbh6MFSlDciZJSdRCblU6h2omu72f1o1RCji457XIBySbeDoCzZlGiqKw++?=
 =?us-ascii?Q?/IV5emhwt++p8MUAiBHbGyBKIsgYk+ISY7NF8D9pfwSYqe1DNIT2Y7BkBZxQ?=
 =?us-ascii?Q?EvPt/CxC6Dyp5fP+Hfh5UhUDbeAwWWH568zqjfmpVYYOMrHFSeUStqdKVOKb?=
 =?us-ascii?Q?ztijYKopTt4KU3j6nqKsmvHpadxG5LCVOh6UJRgKfBeXhVP8l94IyOioLWIY?=
 =?us-ascii?Q?hm5BIWLGnmxB4//BwY9xYAA+Qr1Aar2O3IazEwDyTzMQPlHPA1UHC4SyfZ6O?=
 =?us-ascii?Q?R8PTXMWaIOeIfUiNOXzlYnDxanf5x3OZA8RC0p1hLVVOE8ZhGsux/fMbQy9Z?=
 =?us-ascii?Q?+4wciN8joqBEwWcQocTXmBcptCAO5qrEK3T3vpRqxdrQPCJ2bOv4+srIDrmf?=
 =?us-ascii?Q?BmjCbolRoba1K/WCRPumW2WVVNwy/QzonXwSOpXLxu9ppQ+yq8kCxlfvzUiq?=
 =?us-ascii?Q?wVFdUY5miLAGRLU9LrEetTzP4oy+JR39V3Je0Mfaf7sS9R3R+d4sLUKE3ab0?=
 =?us-ascii?Q?GdygX77y38IJdzHVuAd1gqokNjRzZmU6gXilPLvYnySiWqJX4tlNtv4qm60+?=
 =?us-ascii?Q?RmsvqSZDtWQWZJKaCXPDm0jrCgxBaRCyRcGy5cmYz6tlVg5p/WSDdoM3C92e?=
 =?us-ascii?Q?Rwl1d4OUuxNT6Q8b4LuNl5DcaEuQJWfrIqVk/fVo+rPuPWk0/NRlNzvr8PqV?=
 =?us-ascii?Q?OdnwNz3dS7VySFmWNrD0n2MgUCaRR9hkOGNbctNkhj437ysjnvM+BK1WFGJ0?=
 =?us-ascii?Q?/I25eRmGrqOAoYAnen/qix3o2zEXzh4BtM/Iitq0v6Prp/JUQis9k1aXgUy7?=
 =?us-ascii?Q?qwYKsfpCyM64yCp/zMC05moe3SW3tDL3csaIctdR8Y3DrCNZAieLDfJRa0Ex?=
 =?us-ascii?Q?G/O1Cq6w2darl02U+dSw8e3Lwhofiz+utKBi1dlJZtrVg7iy2XEdPdvDkPtf?=
 =?us-ascii?Q?qhz+1JuxEnONLJ8ppFi94qZVg61bQvIisXvLz5PM4cFd8bY3WGtra2UYnxxK?=
 =?us-ascii?Q?TBaVq8oLoleKX1+HOtbZFuC97L/2K7MQc4KV1FeF3PG5hL3aJuh+Ue+LOylh?=
 =?us-ascii?Q?zvx5j6Lp9+Y8d8irUFaN+oKuWV3ai7JzzduDfICPXC+deClpxCzK79WiOx3b?=
 =?us-ascii?Q?FMXit7WEB1F8wO978Bc=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS0PR01MB5922.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 048e2d91-dfad-4094-049b-08db5c534b1a
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 May 2023 12:35:01.4914
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: f1pUvvNY4DmFPKCtmw2hWxSy8k4NtUduLDFILeLYpTDk9bmqpEwjYFSTnuS1YIiA2chap4M0dp9/RsajecdUNEoG9H54pYyWof+9CCr8ZRc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY3PR01MB9683
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 24 May 2023 12:35:15 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/11633

Hi Pavel,

Thanks for the feedback.

> Subject: Re: [PATCH 5.10.y-cip 19/23] i2c: Add Renesas RZ/V2M controller
>=20
> Hi!
>=20
> Minor details I noticed during review (they should not prevent merge):
>=20
> > commit e0ca796a151bd4de76efd71aade2b4805a95c93d upstream.
> >
> > Yet another i2c controller from Renesas that is found on the RZ/V2M
> > (r9a09g011) SoC. It can support only 100kHz and 400KHz operation.
>=20
> KHz should be kHz.

I agree.

>=20
> > +++ b/drivers/i2c/busses/Kconfig
> > @@ -961,6 +961,16 @@ config HAVE_S3C2410_I2C
> >  	  include I2C support for any machine, kindly select this in the
> >  	  respective Kconfig file.
> >
> > +config I2C_RZV2M
> > +	tristate "Renesas RZ/V2M adapter"
> > +	depends on ARCH_RENESAS || COMPILE_TEST
> > +	help
> > +	  If you say yes to this option, support will be included for the
> > +	  Renesas RZ/V2M  I2C interface.
>=20
> Double space ("  ").

OK, will fix this in mainline.

>=20
> > +#define bit_setl(addr, val)		writel(readl(addr) | (val),
> (addr))
> > +#define bit_clrl(addr, val)		writel(readl(addr) & ~(val),
> (addr))
>=20
> Normally we'd put macro names in all uppercase.

Yes, Will try converting to uppercase in mainline.

>=20
> > +static int rzv2m_i2c_probe(struct platform_device *pdev) {
> ...
> > +	pm_runtime_get_sync(dev);
> > +	rzv2m_i2c_init(priv);
> > +	pm_runtime_put(dev);
> > +
> > +	platform_set_drvdata(pdev, priv);
> > +
> > +	ret =3D i2c_add_numbered_adapter(adap);
> > +	if (ret < 0)
> > +		pm_runtime_disable(dev);
>=20
> Is it possible that bit_clrl(priv->base + IICB0CTL0, IICB0IICE); is
> missing before pm_runtime_disable?

You mean error case, I guess it is not required as it is just probe()??

As per hardware manual, When the IICB0CTL0.IICB0IICE bit =3D 0b, the SCLm, =
SDAm pins are
in a high impedance state.

Currently rzv2m_i2c_init() is setting IICB0CTL0.IICB0IICE bit to 1.

Cheers,
Biju

