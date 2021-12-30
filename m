Return-Path: <prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70182C433F5
	for <webhook@archiver.kernel.org>; Thu, 30 Dec 2021 13:39:44 +0000 (UTC)
Received: from JPN01-OS0-obe.outbound.protection.outlook.com
 (JPN01-OS0-obe.outbound.protection.outlook.com [40.107.113.101])
 by mx.groups.io with SMTP id smtpd.web10.64332.1640871582422794754
 for <cip-dev@lists.cip-project.org>;
 Thu, 30 Dec 2021 05:39:44 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@bp.renesas.com header.s=selector1 header.b=wsPaoyE4;
 spf=pass (domain: bp.renesas.com, ip: 40.107.113.101,
 mailfrom: prabhakar.mahadev-lad.rj@bp.renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=juug2XTQ15/fz7QjZU4g/hlIfPP/iYfK766z6/FO9u0CqW666EXTKY3nszVfosjdQTwkhd3a834EbM5kI0n8xU1pg28/o2hL8bj4H+bUpP/bDOdCxyPViEA36VXoy7X9wMFIbDuZ5gpQ+kjCBCcZtfF8PpLXyM3dLOfLOTqZcPXN4paAfZgxTaymF7RGXDgyMsOM48vl3cewfv/SJES5zWWjkiBYPYXVcNqgj6lgzkNW8As+44DccCblcbq7NlCr9lvG29egSx4tgOx6QFBiZratUyAQ1P5i0P6WBIQhqKI7acfQldkcMDhNqlGJpPQi5rfHf0uYlUL/IXbGVV9Jqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LTOBtpiwr2cktrsKTBYXpRpiZDWEG5I59xE3Uvgn/hE=;
 b=njb7Sdhq/AVs29jst2NWx4RGjuCys7tqhaztOfnffj8Yd5+bwVlz2OoEyDZZXU/TnDPMtW6LElcNQtv2nwQwR+IQuPrZXN8ILzP7MI/jVt6/6tYjRMFxrPbMSkmLvNNE7ui5xvrFEq7AiV1Pfm7/jQnIkJYGDJqMWg42MSobO78jMl7qjoSz+EYwItBA1fefr8/LRnBZt1fn5XMIW5qUwFIJYEaWiKhwMXBKshmxuVA/2iRcZH71+R2XKLXVE7STXFXhDiegRli9YlkDzx9CtwBKqNyBpHXRcaIqTEbnLe5CKjhB2mcqfRTFMYTVz/lfnzlvd5RwoWgXDllClzfFQQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LTOBtpiwr2cktrsKTBYXpRpiZDWEG5I59xE3Uvgn/hE=;
 b=wsPaoyE4MSjWnuwtYJBnj6TD9HIwvihpQXzNL7WKeA/zAGSdu5Ojci68z0c3ku6wrQzrKeu7uKOuY2wtwirsnxgvYqn46qp50aljbvHVVJN13UlZuqy5vaJQoHRGtB6wUnHDpINPciXbTumOvAyObsB5ou0owDoKk6ghBRym8us=
Received: from OSZPR01MB7019.jpnprd01.prod.outlook.com (2603:1096:604:13c::8)
 by OS3PR01MB6183.jpnprd01.prod.outlook.com (2603:1096:604:d8::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4844.14; Thu, 30 Dec
 2021 13:39:38 +0000
Received: from OSZPR01MB7019.jpnprd01.prod.outlook.com
 ([fe80::2182:43e9:3f29:1b3e]) by OSZPR01MB7019.jpnprd01.prod.outlook.com
 ([fe80::2182:43e9:3f29:1b3e%6]) with mapi id 15.20.4844.014; Thu, 30 Dec 2021
 13:39:38 +0000
From: Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: Pavel Machek <pavel@denx.de>
CC: "cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>, Nobuhiro
 Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>, Biju Das
	<biju.das.jz@bp.renesas.com>
Subject: RE: [PATCH 5.10.y-cip 10/31] iio: adc: Add driver for Renesas RZ/G2L
 A/D converter
Thread-Topic: [PATCH 5.10.y-cip 10/31] iio: adc: Add driver for Renesas RZ/G2L
 A/D converter
Thread-Index: AQHX/Wx8YxUDWMvRS0G952tx2/Q7QKxLCdYw
Date: Thu, 30 Dec 2021 13:39:38 +0000
Message-ID: 
 <OSZPR01MB70194EA45788EB30CB4D3AE0AA459@OSZPR01MB7019.jpnprd01.prod.outlook.com>
References: <20211229101530.22783-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20211229101530.22783-11-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20211230110035.GB9799@amd>
In-Reply-To: <20211230110035.GB9799@amd>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: c497986d-3b97-4ea5-07e4-08d9cb99d35d
x-ms-traffictypediagnostic: OS3PR01MB6183:EE_
x-microsoft-antispam-prvs: 
 <OS3PR01MB618302C377D0EF1B69F7B32BAA459@OS3PR01MB6183.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 o1pdLahf5uWd0vxafKtKu8gPEZwuFFRmVzKAFuPOFQSIVzKaFl9N1NdNzeB7XdgxUD4mfwvklwVwkDiVVjsRRBELpa4gVfDAeJeEgsvFh46T5KAAKGXeL62pko/kCbCq0HSMVIVTwuHBdvy4cwTYCpdXeIQWNpi5f3GusmNJkSzB69T5sYNs1CIvJBfG74DhiVLA0Zbc+xwfpHIBnKCM/TqkkoY0azh7NlweHye05lDLg+g/Q1UfQUAsgIvm+74AJ2d0w6/1rwSPNcTy8zC1CCRK1bahalefw2h1KI3lP5mXN0xiHnIAvlfWlbEtaIJ9Y29aGUyG2ghkSGbiY9D2p+SsUPW0NwMjPmGb/lY8T/Jx5K1o7WaHP6oyTgoFKpgSLXFoneVRHoFQRulwoiUtfH9DBetDJ8XSqoDJwHNRGyickoyqL3PNdeH7pfQHx/LeqU2KH6ztxMZkLZuubelyVT8Ct43k7JAHn0FG/ngyMV3OaMPyAO209AYq2dVpSW3ycqtf1a0ZN56otnOPlhVyhxYRXjL7BiMF0ZI2qvnmur6qyITC1a+xELIjYPqi+lFxUr1f5PGqt2fORdZAw1UizOQ4b2h8K5nQm/JUMrA51XRRhmywywlbj73U8ByjrDNXgE42euU0tqmxgBgFa9KXnNk4+Wb0X+vJBj9Jx5K+MyrqiKXBE2DYjAngPM3HY31ZKmQokOOfS4Vdis1kdThVmg==
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OSZPR01MB7019.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(8676002)(71200400001)(54906003)(26005)(33656002)(6506007)(53546011)(9686003)(5660300002)(2906002)(186003)(55016003)(122000001)(4326008)(38070700005)(7696005)(316002)(66446008)(76116006)(508600001)(86362001)(6916009)(83380400001)(52536014)(8936002)(107886003)(66946007)(66476007)(64756008)(66556008)(38100700002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?us-ascii?Q?TnBXmvQedxM/RjtuJ2mi3lUgMJMmUuijUIw/KdOZ4ehd0m7295tdySxegEdn?=
 =?us-ascii?Q?GEdlRn5ySF1+AILkjWdirbA2qTfsl0UP9trFHSrNTTjB/LOKx1JoG4bL9oyd?=
 =?us-ascii?Q?S9VUi1hvbyK849An6SRP5YbAA4VRb8Bhzdds7DqIE2mcxHlvXjdlTdDqsj/H?=
 =?us-ascii?Q?rjjvcev0a5OpHpKBsN6H/da4ffcufik+YeMYqi8SsoUAgQZO8yTWtY9B3HT+?=
 =?us-ascii?Q?yTNs8Ci3al5uSIHj7DZOrnviKTedCzQI9hmpqVIfKpw43G1C4CG5it/uRuzj?=
 =?us-ascii?Q?iN3Pm/pOxLYnC2KNNr7NyI4N2nf5ucMdY8vg4bZtOpS4QumYYOgNtVUohDWD?=
 =?us-ascii?Q?0QeKth6btSD3oHoIHxhfyhunRfEcPKoT6TjhPmn+o1b1ZQk4JncSIXdktxiu?=
 =?us-ascii?Q?9u79QhzDWcqIKjWSU4/tNbsjh89S1esLHzuLeepx8lE+SVVJtUg+GdrpMWAh?=
 =?us-ascii?Q?v4YKABW7fB1n73EC3bnW2Zy97n4GLLOsK3mc7OZDyxEtpwLtO1fA/T79FJql?=
 =?us-ascii?Q?zO064z5f4+VWaLtgQh3ZXkHZpNhCVkpCylzE7EUaMxcYZEROKX7HvC77LiJQ?=
 =?us-ascii?Q?6HDWNgvmp+8A7JJg1Qq3c6cWrfMDZ3MDIAByItKT4rGIq4YeWnEGcsUWwoA7?=
 =?us-ascii?Q?vIic/1tolb6mBLVOTnG8WVxA93eovH4VTDGLhISBdESnG/WCjjEawZGlUpE4?=
 =?us-ascii?Q?KYvxk1a0LquJAWIDKhHYljkHjWhV7PbplcY0ka4qAdIgJElA9ptkmabWyXmS?=
 =?us-ascii?Q?eBJvFIhpSal9g83PgLAm8OlvqXq+oC/lY8eoOeXSCGpi5KcEhiPUVogSQnzF?=
 =?us-ascii?Q?0zqCStf3YBxnut5ar4WeyL+UgSt6dBrMFOLS+uwaVhLaK1bnoziXYrj5k4FS?=
 =?us-ascii?Q?KJAMjQBSw5id06wSTY4yX6///68VVRszVpjQsdZYGOwB7FamdcCMDH2xXiYr?=
 =?us-ascii?Q?fYo7lyhgbArsiqPGxR6O6rALxhrGbAPdb3og/bXnwCm1c7vA1cgsNdoJFFrU?=
 =?us-ascii?Q?SycNayBwxft9W4F/7iPV0eJGfsMsEcTATRQgR3HjuFdYv/xZGx6OnbA3i4LN?=
 =?us-ascii?Q?QDBvZOmHkWXrvMbxlLoPu816t9mxzNUr5/slZScrqFAb6bMl0WifCO/Ta9ji?=
 =?us-ascii?Q?SrEw71n+R4qEtEI3M8AIeQJcBr0BmvE3W5ycAIN+n+6VqZYRf7LXo630Su7g?=
 =?us-ascii?Q?ce6eshfZ3CA/7fYmXTKe2/7jUvDU4mUEovxiaK6o+9LNYmJZDzd8AyqMfkxL?=
 =?us-ascii?Q?dz7VuPAsywsWHAqJNJgGoGg5GmdJagC4vmX9kK6cGWO9+CIYyeBDMBTjyAsh?=
 =?us-ascii?Q?Q4PBlr4eyUw2PcAJ87aqjra2VZxcgWBzW4CyN44dxBOaFBwYBgdh/RqX4rsi?=
 =?us-ascii?Q?Ws1uNQ66r8jtMWQ7DPRmOkAm+UdDQ51RwQex5XlwZAwCpvbrbAmkFOe9kvz/?=
 =?us-ascii?Q?/7BIRdU7mIn/v7002RSuImyRMyOCFirQ4emHlk1aC92g0MPbtcHN7hn8cyZk?=
 =?us-ascii?Q?KNCP4+ydkqos/Y8hKYGVp3Vg+CjsGHUvhEYz82o2rT1L1G292c5sT3aYAfnl?=
 =?us-ascii?Q?bntYn27xs1ORq0UzegL7EcGZmQhwh3sgDzwM7WjWwCsURe6NareuWD3e63sp?=
 =?us-ascii?Q?cF0gL+yvtD+2dEdeaWinPedba0AfaUafzZgFLXox7TiPvj9p991oulf7Rtia?=
 =?us-ascii?Q?sQtf21Vj2VPhvmJvipbtCHEfc3aGXXX1ygxtFjYhOi1BIoOcyntihjc2zhOi?=
 =?us-ascii?Q?w+CFtS1gOw=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OSZPR01MB7019.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 
 c497986d-3b97-4ea5-07e4-08d9cb99d35d
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Dec 2021 13:39:38.5066
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 
 ueQYGH3q2lt5+jEESA+zt6sMYVBf3GNXZCRtcOR2cHHuUOjQsRBc1qf5RK9lfVdTWfS0qEkZgFLuShsu5Wov51U4hyy7c3fMa7w5NGxWahSHUSMtOkVTk1ROdfTQKEdQ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS3PR01MB6183
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 30 Dec 2021 13:39:44 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/7316

Hi Pavel,

Thank you for the review.

> -----Original Message-----
> From: Pavel Machek <pavel@denx.de>
> Sent: 30 December 2021 11:01
> To: Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>
> Cc: cip-dev@lists.cip-project.org; Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@=
toshiba.co.jp>; Pavel Machek
> <pavel@denx.de>; Biju Das <biju.das.jz@bp.renesas.com>
> Subject: Re: [PATCH 5.10.y-cip 10/31] iio: adc: Add driver for Renesas RZ=
/G2L A/D converter
>=20
> Hi!
>=20
> > commit d484c21bacfa8bd2fa9fc26393ec59108f508c4c upstream.
> >
> > Add ADC driver support for Renesas RZ/G2L A/D converter in SW trigger
> > mode.
> >
> > A/D Converter block is a successive approximation analog-to-digital
> > converter with a 12-bit accuracy and supports a maximum of 8 input
> > channels.
> >
> > new file mode 100644
> > index 000000000000..919108d798ba
> > --- /dev/null
> > +++ b/drivers/iio/adc/rzg2l_adc.c
> ...
> > +
> > +#define RZG2L_ADSMP_DEFUALT_SAMPLING	0x578
> > +
>=20
> This should be "DEFAULT".
>=20
Agreed.

> > +	do {
> > +		usleep_range(100, 200);
> > +		reg =3D rzg2l_adc_readl(adc, RZG2L_ADM(0));
> > +		timeout--;
> > +		if (!timeout) {
> > +			pr_err("%s stopping ADC timed out\n", __func__);
> > +			break;
> > +		}
> > +	} while (((reg & RZG2L_ADM0_ADBSY) || (reg & RZG2L_ADM0_ADCE))); }
>=20
> I'd write this as (reg & (RZG2L_ADM0_ADBSY | RZG2L_ADM0_ADCE)). Note that=
 we wait, then check for
> timeout without using the register values. Which is strange and basically=
 makes timeout one tick
> lower. (But probably does not matter much).
>=20
Agreed.

> > +static void rzg2l_set_trigger(struct rzg2l_adc *adc) {
> > +	u32 reg;
> > +
> > +	/*
> > +	 * Setup ADM1 for SW trigger
> > +	 * EGA[13:12] - Set 00 to indicate hardware trigger is invalid
> > +	 * BS[4] - Enable 1-buffer mode
> > +	 * MS[1] - Enable Select mode
> > +	 * TRG[0] - Enable software trigger mode
> > +	 */
> > +	reg =3D rzg2l_adc_readl(adc, RZG2L_ADM(1));
> > +	reg &=3D ~RZG2L_ADM1_EGA_MASK;
> > +	reg &=3D ~RZG2L_ADM1_BS;
> > +	reg &=3D ~RZG2L_ADM1_TRG;
>=20
> reg &=3D ~(RZG2L_ADM1_EGA_MASK | RZG2L_ADM1_BS | ...) would be usual way =
to write this. You can use it
> in more than one place in the file.
>=20
Agreed.

Cheers,
Prabhakar


