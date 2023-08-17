Return-Path: <biju.das.jz@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8CC8C27C7A
	for <webhook@archiver.kernel.org>; Thu, 17 Aug 2023 11:25:28 +0000 (UTC)
Received: from JPN01-OS0-obe.outbound.protection.outlook.com (JPN01-OS0-obe.outbound.protection.outlook.com [40.107.113.111])
 by mx.groups.io with SMTP id smtpd.web10.184917.1692271519345981192
 for <cip-dev@lists.cip-project.org>;
 Thu, 17 Aug 2023 04:25:19 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@bp.renesas.com header.s=selector1 header.b=Ma9FG8/c;
 spf=pass (domain: bp.renesas.com, ip: 40.107.113.111, mailfrom: biju.das.jz@bp.renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eWn5y8m0gYyF7V34fq4nxdceQ2CA9d98KTOQ7ZjY8iLjg3f1WOuWWZKSDiB1Brf6J6YHk6WvduXgkZi6u65MVq0gKH/S2+TiCeM6r/xaR6UrYSzkeoSZWR106ymdIPlolu++xNLiNl4XDZeWMqbGX48gEs57kBXZ3jDWFVVopM+tATZ55c4lDz3PBtWv35JCIYSKXcs3DnZPqTK5TgQj+FlvjgDTsWOKm1sBfPklIqudsFdtGQ8z99j7UorGveGLdX9IW0uA3uXbsbiZUVhFj8I0w+eNtWeJRUJiXac2zWGfoj622nx9TD+czfEiOiVzP8P66rSN16DvuYOesNsTug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4kKOd6h1Y844AJAskivyqJBgSrWh0DHVAUGUzwfWgD4=;
 b=a7eVPP/ddNibz5XV7GHBBLJWymLsnvEpAlYj40W4/rxFlw3liBMSB2CSaAyRZpy2n+wnqmmrDt4hjspa0lfgqvZ2T8S9PLvaB3sQnkLwQjDFJS2gL7lSWWYnIM5BoC0P6B6abzXmnmYKtjb3Ht5ff5BK/Rt6vQxiVq8/Kw6k8LcMGtZHk+esXf9o/s7EhzIsGKTfVBTV9G6XnmOhpLcedktieOBtVJo8ZuaOtndLbNRBmKIDOq94lYhDk4APa7owFSupfoxZ3uUzFxj5eKYsODH+AjKgIv5Jo/1yP8AM+3UNTs9KRPiQIx3OxILkU9NWg9S+RUxJ5fYZBaAnJPg9pg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4kKOd6h1Y844AJAskivyqJBgSrWh0DHVAUGUzwfWgD4=;
 b=Ma9FG8/cviT4OJjtWfwRwc04M2onrJQCrqkT43tPEJnIWkB44JIk2wFeLXS7yAxNHlXyubI6mCzeFrqRPUnJCdlHV2Uwj0j2uasEuxt5EivpWD3p7l2D6ri0oaXyLE+kgl2qnRX4yW5xfZEn8kpSdAixVTAekgq3Q9n5tpaaKOI=
Received: from OS0PR01MB5922.jpnprd01.prod.outlook.com (2603:1096:604:bb::5)
 by TYAPR01MB5787.jpnprd01.prod.outlook.com (2603:1096:404:8056::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6678.31; Thu, 17 Aug
 2023 11:25:17 +0000
Received: from OS0PR01MB5922.jpnprd01.prod.outlook.com
 ([fe80::2168:623e:e186:4cf0]) by OS0PR01MB5922.jpnprd01.prod.outlook.com
 ([fe80::2168:623e:e186:4cf0%6]) with mapi id 15.20.6678.031; Thu, 17 Aug 2023
 11:25:17 +0000
From: Biju Das <biju.das.jz@bp.renesas.com>
To: Pavel Machek <pavel@denx.de>
CC: "cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>, Nobuhiro
 Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>, Claudiu Beznea
	<claudiu.beznea.uj@bp.renesas.com>
Subject: RE: [PATCH 6.1.y-cip 07/13] rtc: isl1208: Make similar I2C and
 DT-based matching table
Thread-Topic: [PATCH 6.1.y-cip 07/13] rtc: isl1208: Make similar I2C and
 DT-based matching table
Thread-Index: AQHZ0E18pMD29IvHc0iGNdbStrLOt6/uVpyAgAADUuA=
Date: Thu, 17 Aug 2023 11:25:17 +0000
Message-ID: 
 <OS0PR01MB5922D24949EE819918555CA9861AA@OS0PR01MB5922.jpnprd01.prod.outlook.com>
References: <20230816142458.147476-1-biju.das.jz@bp.renesas.com>
 <20230816142458.147476-8-biju.das.jz@bp.renesas.com>
 <ZN4AcXTOMBfKBtt3@duo.ucw.cz>
In-Reply-To: <ZN4AcXTOMBfKBtt3@duo.ucw.cz>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OS0PR01MB5922:EE_|TYAPR01MB5787:EE_
x-ms-office365-filtering-correlation-id: 3876631d-b17b-4bed-008a-08db9f14a23a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 Spb+jTLRHr4mCB+I6p7PLa1JzwPBgE5edd7ezQc5iAlbKzLW7QXE21i12m1BL2kHPMhBH3ZItpeXcF7POAkCPIizFXVXl7nOw3JAnRQsBVyEizjFGQNbaqubLKeGl+qD0Tahh05PHCdeLaGipwTYq8wt0P7U9Ayon1e2u4sKwcT5k0Sb0KdBxZsbqU4SWLOW3RNxR+ncnS7dXFZVLYZCqLN7g6h30mvIdP3dtQtZPUHCGJXGvQPLuSNaooXBJXtYL6MHsfalyh4wozfFEVzHY/J8hA3YLS2OocP+D6tQxxjGzm5AV/aA2hkeUeaKlsiHUpXQ0TzjjhCWHIjHt4tZ3ZJs0TV14LNkXjuwn82ohmn8+gZB3suZyu51pftT2Y003jGQuC+T38uaz8MFMF21cr6cQmhTi38qiPhNo0gnsGIwNgIF2xHu1A+vIZgbHf1IEEkpV6+FVccfvYn6gdvifZ0qUHPJzkdF4k8QzDWQzNgVV3Yd2AikiL/jktlmrAd8ZevMGHNuUdviEtzz1E+2bBJcTQpHtJXC+OPQaF7dVkZz2DoSHBc8thTTk1zPAEu3fJLdVc6U+GrDbEZjvBOHDRf8TXsFZG1uke4bIBDgrZhVTguQ2Mj9zcWUBqFS30JK
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS0PR01MB5922.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(136003)(346002)(396003)(366004)(376002)(1800799009)(451199024)(186009)(71200400001)(6506007)(9686003)(7696005)(26005)(86362001)(122000001)(33656002)(38100700002)(38070700005)(107886003)(55016003)(2906002)(316002)(6916009)(41300700001)(54906003)(64756008)(66946007)(66556008)(76116006)(66476007)(66446008)(5660300002)(8676002)(52536014)(4326008)(8936002)(478600001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?us-ascii?Q?HwHS2LJDjwlcJBPfaT4hOSu+zUs3QzfjE0bxU8WS5pzRf8vkLDBdpQ4CdY7I?=
 =?us-ascii?Q?yNQKPGMFdu0rzfjUpBXEbVAXEu7EZ0kN/GLBPHpIV1Kjdmy0XSIAxxDWsh9x?=
 =?us-ascii?Q?ZCu6UEbl8gKl8fUqEVj4gzoKPWOqrdCjpopi59NDCWdTv+kqWqc8O8szSetG?=
 =?us-ascii?Q?ldb+4x7Tlc5ZTtF8ADX8zX+2mUC77rjZq+Dl+wVo4QLLkl6dGRbUyDPuSNHT?=
 =?us-ascii?Q?n7XEJmaeiSPnBZg9CYmfdCdr36oRbYoHIlMqRpddcGXAf1s0a0R5j/dUaLvS?=
 =?us-ascii?Q?RI6pWdyOAdmBsnw8fML+RxSH9PG4rNs7gFxI9wCCDPoAbCbzlvn1mtnAtm3Z?=
 =?us-ascii?Q?h/RCbXROIRiKNjZtDg1E3IntDf2jyq8vLbiu87aPc7evmhB12AcH4Tc5lEBo?=
 =?us-ascii?Q?ZMz9+JUjcc9q42qhIsnFBs47d6uTJRC633RgUaq7lP044MjWFlvbydLdsIRc?=
 =?us-ascii?Q?xzu1+6MgqxVLgpu9gA+8kFIrAkvllWNpQ4/8TsSWSlrFomw0YzRYiF6nVohh?=
 =?us-ascii?Q?fyhIPSAwLh9CIwjogmhkolOt7UYuxVKfWA+riedPZm8+947EIkfWBvkXLu4u?=
 =?us-ascii?Q?ybVYy1RLJcAAaQ2BBTG5nSv8T7Py10VEX/SquawXqFutU5iYP79Okm1vLu1C?=
 =?us-ascii?Q?z0wf79fBPMU2nPXIvpj61uOa1oDAjH0jHONK7r8p8Cg4t5SfRU74LUEwC0C0?=
 =?us-ascii?Q?OfjFB2ud6jx1wkBjZLUSeJJ7CjJ+cm9wGALWXFr6t9dRZxk4VkjtOL2kLmd4?=
 =?us-ascii?Q?h2iqxiOqaX8tAaDysHkOSQkGTzSIfEnqdJqnmQm7TFOV6BXHzG11ddV8UOaO?=
 =?us-ascii?Q?RprOvY9vuGRv+MoNwnT9klLLg09NopH8Uur5OOecPfGveEc8TlIsA+4OO1s4?=
 =?us-ascii?Q?7TrCF6NF6WCcDVtZ7oigWVV1ORy3RCfWMwoiYtyfzN2wYjcZrlbXuHY3EK4C?=
 =?us-ascii?Q?/kCLMY4pBMVyybTUopgKZXz/n+RJdaHSef0vVGDzcwbuQSZ8S6qUFm9f0iY0?=
 =?us-ascii?Q?6pUpffTaWY7NAJLWWiuhknfunx5I4KZoacLnv2ZXV6mJQLiOoOVz72r8AYLr?=
 =?us-ascii?Q?6Na6gSPcv2eQP0BSFw6c2rKvMP74ErpcpI/7wnmYBWirsP2i8un43oMleuWT?=
 =?us-ascii?Q?XIs7VXwLME+6sUt9FXwlr733HwVRCRfWsaXcv42SL5POEBVk6MNzSe3urrEv?=
 =?us-ascii?Q?ccpHL6WNB480S6PFf+esfZYUTXNozo1ohT774kG1Ase5sUSJvbWFkRVUf5Bz?=
 =?us-ascii?Q?9U+/bZ+bipE6Mp4GUgMXWRCav2orNWEtTIxEPAXvr0SbHgpDIpYjeHlOmIFY?=
 =?us-ascii?Q?3hmbsl6+wZ60LEs/x8EK4O9jzwvX2L9t5ioFHPmlAVLC1wT9MwmuXrO1TGwr?=
 =?us-ascii?Q?TqeF4ZwpxOKoBIqxdtv02THJjVAmu0D1n49713LA64pVmnb9sMdOTu4Rjl8i?=
 =?us-ascii?Q?vn6xUko7QVPrdDBNkUpkwF04He7i+Vs3Z8Pa4GW26x5ihLZmZTEUJyCydCpX?=
 =?us-ascii?Q?VLRSZgRq794elonzTJIRDuS7k5yDocI5ghqyCLx7W/o5LHQL+gOR+Ig0xFZo?=
 =?us-ascii?Q?Ovz2JhX72xEzr0IGI5+ewXquXIl2QeQpxpmRETX/?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS0PR01MB5922.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3876631d-b17b-4bed-008a-08db9f14a23a
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Aug 2023 11:25:17.2919
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: XA8be4QzQsS1lbz2S8LJxdbcrIHAf93dIJzd9dL3tjEMXWLtXaXzmyml+yMAWIdvrD6OQ6fcGygFeVgZGxJhUhQBvaaoHNHAXcqvnaS+n5k=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYAPR01MB5787
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 17 Aug 2023 11:25:28 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/12762

Hi Pavel Machek,

Thanks for the feedback.

> Subject: Re: [PATCH 6.1.y-cip 07/13] rtc: isl1208: Make similar I2C and D=
T-
> based matching table
>=20
> Hi!
>=20
> > commit fbc06a53561c64ec6d7f9a1b3bc04597de4cbb2d upstream.
> >
>=20
> > +++ b/drivers/rtc/rtc-isl1208.c
> > @@ -90,10 +90,10 @@ static const struct isl1208_config {  };
> >
> >  static const struct i2c_device_id isl1208_id[] =3D {
> > -	{ "isl1208", TYPE_ISL1208 },
> > -	{ "isl1209", TYPE_ISL1209 },
> > -	{ "isl1218", TYPE_ISL1218 },
> > -	{ "isl1219", TYPE_ISL1219 },
> > +	{ "isl1208", .driver_data =3D
> (kernel_ulong_t)&isl1208_configs[TYPE_ISL1208] },
> > +	{ "isl1209", .driver_data =3D
> (kernel_ulong_t)&isl1208_configs[TYPE_ISL1209] },
> > +	{ "isl1218", .driver_data =3D
> (kernel_ulong_t)&isl1208_configs[TYPE_ISL1218] },
> > +	{ "isl1219", .driver_data =3D
> > +(kernel_ulong_t)&isl1208_configs[TYPE_ISL1219] },
>=20
> I'd expect to see "(unsigned long)" here.

Because driver_data is kernel_ulong_t. See below

struct i2c_device_id {
	char name[I2C_NAME_SIZE];
	kernel_ulong_t driver_data;	/* Data private to the driver */
};

Cheers,
Biju


