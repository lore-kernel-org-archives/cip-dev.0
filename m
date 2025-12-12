Return-Path: <prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4C1CD59D82
	for <webhook@archiver.kernel.org>; Fri, 12 Dec 2025 18:10:36 +0000 (UTC)
Received: from OS0P286CU010.outbound.protection.outlook.com (OS0P286CU010.outbound.protection.outlook.com [40.107.74.1])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.263.1765563030938838345
 for <cip-dev@lists.cip-project.org>;
 Fri, 12 Dec 2025 10:10:31 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@bp.renesas.com header.s=selector1 header.b=LGy71+Ei;
 spf=pass (domain: bp.renesas.com, ip: 40.107.74.1, mailfrom: prabhakar.mahadev-lad.rj@bp.renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CgJpaq5D9XrQ1AruglfA6aTQP3jclfZFOnZSiAy3feQdMQ86eSGWqo/uTXpF8XQoNJ+230E2fK0XhKkwPnsMXOYeDC62derCZqOlyEP59CBFAxnB4pPT0px/DhwBhfB7GKXZ6R0BNtkwqaxeWwtYS8wCFQ2kurEYMvNMwPs0MFT7s4Pvci4wHJ8YXJMG0mKt/n9yZvZ/N87oPcwWqKDLePX8PzB31t7LlENX/0jU1jJWZQZu7Plih/wQZButqyuKfVn5ME7sA+tqlLPVbEdZZuGVVhW9KmES2LXdigfaznwEop6oNCWbGnCkC1ac9Gr179c3aWjh15gbdURd2n/CYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Fv2A3YgcIQIHi2RLVcom3hjA8MMLVq1BTej9Ak3+KM4=;
 b=a9zwWVRL3NE6p/D6j/g/rPn/klUqJ9yAVyUXeJIYBtWYZTUdwPl+aINBhe0TEjFfjLdg67PdwPYgcf6lQEIcAYO8hI3o/ktcobtOXWrRTCuhkMkj4k3eE4L0LNeGdicVFrxgRk1GrzdfnsdtECywLHT3EGVT9t+Bg4FWujCyWEfFRl1U8DpBPeTjgcMoTad98iEA0PthGQ523gN2TKzvT5GPS/yn69YIFqrQT5k9d3YJAndqPFrY9HM7I4an+xBlCPQcP0rM8+U37xzql6fEMJ7YDdk7iSZvS6e6/uwtTcWfgqdPHvK/4ok8Lx0emO+Bb54WUpohp49pddLWOykn6g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Fv2A3YgcIQIHi2RLVcom3hjA8MMLVq1BTej9Ak3+KM4=;
 b=LGy71+EiCF9YorG1EP0wx2GuVkWQG/aMw+l78PuwVEMLpCkTttCfChrYEF5vt7Dz2xMXJWs1o4qQhy7CoYLEmid7Ne9c9lPYvjaoulqVLlg1Vq58OzzOmNPhr0eTHdFPXok+LoDqzrkpuIKcm1HUHwAhqqxjrFuT/y4yrJvvyUg=
Received: from OSZPR01MB7019.jpnprd01.prod.outlook.com (2603:1096:604:13c::8)
 by TYYPR01MB14116.jpnprd01.prod.outlook.com (2603:1096:405:212::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9412.10; Fri, 12 Dec
 2025 18:10:27 +0000
Received: from OSZPR01MB7019.jpnprd01.prod.outlook.com
 ([fe80::8a27:ee0d:d7a4:9d10]) by OSZPR01MB7019.jpnprd01.prod.outlook.com
 ([fe80::8a27:ee0d:d7a4:9d10%2]) with mapi id 15.20.9412.011; Fri, 12 Dec 2025
 18:10:27 +0000
From: Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: Pavel Machek <pavel@denx.de>
CC: "cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>, Nobuhiro
 Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>, Biju Das
	<biju.das.jz@bp.renesas.com>
Subject: RE: [PATCH 6.12.y-cip 25/38] pinctrl: renesas: Add support for RZ/T2H
Thread-Topic: [PATCH 6.12.y-cip 25/38] pinctrl: renesas: Add support for
 RZ/T2H
Thread-Index: AQHca2dUbkEBtQ9r4kaewXG5WARxc7UeThvA
Date: Fri, 12 Dec 2025 18:10:27 +0000
Message-ID: 
 <OSZPR01MB70191FDEA97E687779EEB5BFAAAEA@OSZPR01MB7019.jpnprd01.prod.outlook.com>
References: <20251205143258.13748-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20251205143258.13748-26-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <aTwR71CtNKZxBrRj@duo.ucw.cz>
In-Reply-To: <aTwR71CtNKZxBrRj@duo.ucw.cz>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OSZPR01MB7019:EE_|TYYPR01MB14116:EE_
x-ms-office365-filtering-correlation-id: 739018f3-ca22-4982-5d78-08de39a9ba92
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|38070700021;
x-microsoft-antispam-message-info: 
 =?us-ascii?Q?NBcY9Nlxn+Smz52tWIvnETns7v8M//fkXrYXhnKy90wYT3xFv+7eDpVO7LFo?=
 =?us-ascii?Q?CMCJXUkMVRiz162ixvIysdbbpprvqZxAR3McXeZvzU9RPG+YfwVlBcwv53Gg?=
 =?us-ascii?Q?pjKd1NK7Px73TvuMLVsLvALlDlsWBCxvxuNvIRn9DwBzUdRQIZ1uEV7Pl4DZ?=
 =?us-ascii?Q?FULLIJGeHt7JPtc8EjMlrKg4zifMnib65mIyCgx6DM/QGes+uVyaiSFTuGaX?=
 =?us-ascii?Q?Xt2v9H96KTtJpW3Al7SbREM2XH/VF+Y7aPAS7WzOzbfKq/Ftfmn+2ZdrDb5P?=
 =?us-ascii?Q?BFNVlPBvtoyF1/ZaVq6j9/cO+SLLTNUyQbdzeoHat+idcXytBPOkBMOlTZ4d?=
 =?us-ascii?Q?v2eHMufrWfx/qonbkAOi2gpdmeN4+XjKi5wAB99gp//puV8Rs+tVZ3thslfx?=
 =?us-ascii?Q?zqoNHxQmTmhKjXkc116bp58+P0dTGYdzX3nu+6QLgvxsCyLHLDOF0yzeezUO?=
 =?us-ascii?Q?A6oI4wm7mEjXrvBme0voFpBlQRrK1SElN5YLPbq4m/ifAn+6ITWjetHiuvuh?=
 =?us-ascii?Q?LSxf5o8vQwY5OMsyI0SsxS7lfg0aP/ub7GyApoiTY936h9q6hf4+0YI57B5C?=
 =?us-ascii?Q?d/J8BCCFV4+LVEvbHmJEBMK1v4xxeu7CEeZMDU0V1DdIttlTePJ2Pqo4Anup?=
 =?us-ascii?Q?deZTsrvCZbg9iwCNC3ErqBl+evmGDCOb+Yrm7n+e709jdpEALfsgSOScJJVo?=
 =?us-ascii?Q?kMufc8KRZy/Od486Nu5r25XKSrlf6iYC+bSFdPotb0FSa3yVVaqqLa+jNPjR?=
 =?us-ascii?Q?pfIlv/gA5lZbDcphLFpQYoIQAdNM69NMMVcprmeVhPdlIlZWPPkKWdHVOanH?=
 =?us-ascii?Q?2cdlcFCEvLj+Vk2i1Z6yoOosNjncUC/1GEM/d4zXs1pkj3XnZSaPClXMJCPY?=
 =?us-ascii?Q?ZLBuk1ZehKS2/UvM/xv2ldlUWnCASfqHKrAAfEUutnIJR55Oj3gUAlr0a92B?=
 =?us-ascii?Q?qTs4BgY/q7evhZm88ZXR6zHBOln69hoZQRugi4+OPauTjW9ucOe8Ie1yY3jp?=
 =?us-ascii?Q?DfOjxGeU05vh2otrwEL/AKWv13APGdMoWNllJoQOO/613LIBnG4EQeF3RAKU?=
 =?us-ascii?Q?r8CSHLsxdYeUPKB1rQnbkriaUFqmfc/JilauHPJQ7KVbYZlb21UA0/Ssp9Pg?=
 =?us-ascii?Q?b0PbLunB5gEv4vKNJxO76J2GiOzAOEbJwnU4PPaYoFM8yczEJ02qBnxFM5aG?=
 =?us-ascii?Q?OMdfT8MBOEaKpnGLjx34G7lrHtdCYhhPZ3SRdAYj+C+6cFRoMLY8kxxPXx/N?=
 =?us-ascii?Q?5WPH0mXg+XedlbeISmrURmBUmg651D0i+eOY2yBf1wUj0mNcT6d0F2xMcyxb?=
 =?us-ascii?Q?SGmb5OYl+Z9Zrm3/XEEkcP9pjvF+TpO6NlMnNKmUBLLthxfaDPs6lb573i92?=
 =?us-ascii?Q?aVTYqQZEa3NTchcrKjYrybxzaYj4uqusPIUpYJf9HgTffYardo6sO352qisf?=
 =?us-ascii?Q?h2T0R0BOFLge9eyybVCktSKBvwm0LHouizNG+jWS/Z+hyhwc+SCCjVG8IrkX?=
 =?us-ascii?Q?tshMzCbwe/YGu7vOJcVTijYpugKuYzlEgk5e?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OSZPR01MB7019.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?us-ascii?Q?TM9qpd2CIo+hJ/sfTgqlzRbx6Jmi9tIvWeA1svjC5a6mV9UnIvbaGsD5hDde?=
 =?us-ascii?Q?0MIZlNydDWWheQFEwQ4JipWgm1UuDshy5dDEg3CJTKhEtJJZMonrwVPkXifd?=
 =?us-ascii?Q?w74IpwLZ1hfkyC3+FJC40oZwflL7zbPlxjDIafA8PZWRF3sYyemjUPE7H0OB?=
 =?us-ascii?Q?TgcIun4TpkwiwitYN0B6cWD1jXT0PJ3GCc0e/yqUDzCrndA+d35giPZL8Br3?=
 =?us-ascii?Q?9BpBm5t+daqZT1RuF3Jbr2EWFlQ1+uMp3MbVgNDZg3fQ2eHtuaRT95Rf5Yaa?=
 =?us-ascii?Q?CkuMKohCgc0jC5b2UYEJ40xjHnwRVWz/yGxNRihJAIY7CO7n1dQrzueik9RC?=
 =?us-ascii?Q?kuv9nNw3+V8uOmAU7/auhmGpCdwVq4VoCUNzXmNQYpS/B3zNb+r+UhwfpTnm?=
 =?us-ascii?Q?waxaz2cz4dBBdo9i+p03xRZTf8ByfVoI6T6pkp977SC/+ea0XM4jmmbeIbc6?=
 =?us-ascii?Q?ZHzrmWEnTY2KPA6MhGIeYXhD9InbhMEVbYHNNV1mw8e7zHkxQ5hkJyurprts?=
 =?us-ascii?Q?BzlWS/zKPJ6fF/+EWlBIfKhFb8hxoBL/bbMWZJcLvY0DrAstS9l6K84Z31Ft?=
 =?us-ascii?Q?gn9G0tDXz3owWuo7Cnspbv1bzRD2rGDI9QHz3ItwQXlL25471geRUG7aqdQk?=
 =?us-ascii?Q?7R6crLvQdc0iNI81wLM6zgDPyHMdBAyrdyyzVonioCbBBP6b2Omvt5pB9vSf?=
 =?us-ascii?Q?UaL/ZAwdqb5Ovb5MCT/2gCQP6milR3Nggi5K2rYzEaxfmZUNXrj5Zc9H8VvV?=
 =?us-ascii?Q?QF2uOlFFhr8pDI0YeSK/lYXttv7nk3zs4uWhiUqMTLQGTC5ZrrQKmYWfV2F/?=
 =?us-ascii?Q?tkmnm+kMgtedG7IqPJVH3LQSNWoPtyoGQYpkWmINa0XetCdZHCJ/WWwHLN2w?=
 =?us-ascii?Q?aawnRGwZNqx1lmigbgfjCL7iWT9YCyKoNU7qKf+1hsxypiDgsm9oozffM8R9?=
 =?us-ascii?Q?pbVsyZPBD1YNBPo5+K2CZHNTp0ioMsLzQJU5Rxb6pleZD0//XR8FG1Q8BkAO?=
 =?us-ascii?Q?Atg9hdTvWFMkRYKNfEgUPU5oDCh66EGmCcYd9loedT4h8kqr+4y7ZINBgP/t?=
 =?us-ascii?Q?HSJLI0CK7v685ildp5GE8wZetYVnHsWHo562dGUI94rRPb7eercPTqL0sbag?=
 =?us-ascii?Q?fa+2XvuFCII87OmZ00r7HvoI4zACODcE3p6JHdnNXvZ6PY/RBtyAiOrI3TTp?=
 =?us-ascii?Q?apWKAlnmakoFEZjEC0ytjn/ZIOorL4ei05UjSXC0Fc2pLeCu7VYjhPfufsIr?=
 =?us-ascii?Q?Xez/EKXZ2n80sKXsCAe4mnsi5W3c1LBKSR6h/slMF70ZwDOnZXC7riFTLAZd?=
 =?us-ascii?Q?BY2f9cc05R4nSN/W6ZPpzbLk/KvSO7svuq6zmHT088WBmj6ZiT5LplRvHnPo?=
 =?us-ascii?Q?JjAbR7vElFPK5XW2zv6fq3fHERxoWxaCZkQdKGVRB4mONhxFNxSzKtYOAUuL?=
 =?us-ascii?Q?YiWXsmGKYBnCc4T0TGCsxbGNeWFP7hb80s0wUlasnpZ9e4FlQclS0TgposB/?=
 =?us-ascii?Q?3aWN58s5e7E0bJs3hXl6VrB3Xj/LEdjEqBvP8KVBWvuhj7wY0Hs70P7ZESLQ?=
 =?us-ascii?Q?N70KR0XTIjykl+c14JvXTCrQip5DfW+bcWOHprMnUHKgGGNGxcoURondCNGz?=
 =?us-ascii?Q?8swL7h9z/XL4GnuTCEM5m6U=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OSZPR01MB7019.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 739018f3-ca22-4982-5d78-08de39a9ba92
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Dec 2025 18:10:27.5459
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: k5z2pnD8NstS0U9t4lbBj7I7wvUxiU9eZAr8AUIWcyvAAh2Mpb36lHVzxIAU9g3qE7C2w6fkNVdgUwxY4MRui7dtU3hUfe2M6WhEjE/TeumzdgcvSCs+6K4H+I1j/SKk
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYYPR01MB14116
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 12 Dec 2025 18:10:36 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/20992

Hi Pavel,

Thank you for the review.

> Subject: Re: [PATCH 6.12.y-cip 25/38] pinctrl: renesas: Add support for
> RZ/T2H
>=20
> Hi!
>=20
> > From: Thierry Bultel <thierry.bultel.yh@bp.renesas.com>
> >
> > commit 34d4d093077a5c60d452a2f42d0c1a08e55b8614 upstream.
> >
> > Add a pin control and GPIO driver for the Renesas RZ/T2H (R9A09G077)
> > SoC.
>=20
>=20
> > +static int rzt2h_gpio_register(struct rzt2h_pinctrl *pctrl) {
> ...> +	ret =3D devm_gpiochip_add_data(dev, chip, pctrl);
> > +	if (ret)
> > +		return dev_err_probe(dev, ret, "gpiochip registration
> failed\n");
> > +
> > +	return ret;
> > +}
>=20
> This is strange way of saying "return 0".
>=20
Agreed, I will fix it in upstream if there is a change in this code path.

Cheers,
Prabhakar

