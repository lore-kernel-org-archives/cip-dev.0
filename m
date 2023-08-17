Return-Path: <biju.das.jz@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F9B1C2FC29
	for <webhook@archiver.kernel.org>; Thu, 17 Aug 2023 13:43:59 +0000 (UTC)
Received: from JPN01-OS0-obe.outbound.protection.outlook.com (JPN01-OS0-obe.outbound.protection.outlook.com [40.107.113.92])
 by mx.groups.io with SMTP id smtpd.web10.187905.1692279835967924655
 for <cip-dev@lists.cip-project.org>;
 Thu, 17 Aug 2023 06:43:56 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@bp.renesas.com header.s=selector1 header.b=LTvPpDQW;
 spf=pass (domain: bp.renesas.com, ip: 40.107.113.92, mailfrom: biju.das.jz@bp.renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VYfN6BGtWsLZay537R8835Ae7zkro52/Frh+btfPL5ZfNJk0p0yWt/kE6tuaPOjtg16SduOf3FhStJmj2s/dMcBf7yZVz9f3alOojnvqJZDfLlf1IiXDC+/QZmsUfBhZJ71yrvNVnC4C6QZFPj3UDYGCIf4DCCHvrDpUBzAWY23OTFu26nTCkcG47syn9v2Rez2hQITeqovqz3G7m6ebImlNtHBNLCm0UHJjL0R0xQiOAvjayL+MdOKiBM+dX4k5CJL79B8y2pIG9fycuyV6WBn7pInqzO9/fc5mQBkXnC6IoK4rnz5gPoWkOcD6NyIYKVL+CMlvDtTDcZ8QkTXKuw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HaLs6ioRYkG54H48C4v6G6jVbf1AUDL99WREjv2tPv4=;
 b=KqHJMuTKfxoWzHPWCQXk75SV4whZtjjo5i4WYorWca8GCj6DHCSBSpdcsOfhlsiMbzaKdKVSwpl3PWoHgEyAD/E+J6wvRLzInKWMJXdN+abrLRrjH+UNjJ334qmoDLgRHHgfNBDHjBrwzsT9F9cFoC5RFq9qDQs4Hot+TghC0vRODMfVwkYebHqz/5U1F8PHrLttWG8rnsCHEi9U5tbD1YdGurE5Ldccr7yayuMMKF+ZLnDNzmOK/iAxvle/bXiBLjd12DuPqFQsS6udhGkH95KavERnijz8dadezXU4kafimhYXLJ4RTa0RdBhy7vyRt9RtknHsGeugMDh0YdPJrA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HaLs6ioRYkG54H48C4v6G6jVbf1AUDL99WREjv2tPv4=;
 b=LTvPpDQW5d7YJKFGRt8cHy1GYg4o5Ma5pGInUlS0Q2ZiuIErXic1B79c/cXoVQudfzFsGc5///3uXqlsLuHS59y0u6IZQ+08vycaUK7XI8zFndvNlO1x/SP8bVDFvzorYULSNB+b4pwN8AQlirFnN31DlpxTL05/wCloX10Zbzw=
Received: from OS0PR01MB5922.jpnprd01.prod.outlook.com (2603:1096:604:bb::5)
 by TY3PR01MB10318.jpnprd01.prod.outlook.com (2603:1096:400:1dd::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6678.31; Thu, 17 Aug
 2023 13:43:51 +0000
Received: from OS0PR01MB5922.jpnprd01.prod.outlook.com
 ([fe80::2168:623e:e186:4cf0]) by OS0PR01MB5922.jpnprd01.prod.outlook.com
 ([fe80::2168:623e:e186:4cf0%6]) with mapi id 15.20.6678.031; Thu, 17 Aug 2023
 13:43:51 +0000
From: Biju Das <biju.das.jz@bp.renesas.com>
To: Pavel Machek <pavel@denx.de>
CC: "cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>, Nobuhiro
 Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>, Claudiu Beznea
	<claudiu.beznea.uj@bp.renesas.com>
Subject: RE: [PATCH 6.1.y-cip 09/13] rtc: isl1208: Add isl1208_set_xtoscb()
Thread-Topic: [PATCH 6.1.y-cip 09/13] rtc: isl1208: Add isl1208_set_xtoscb()
Thread-Index: AQHZ0E1+hJqibOmRw0iE2qbtZyZlRa/uV+KAgAADI8CAACFxAIAABEag
Date: Thu, 17 Aug 2023 13:43:51 +0000
Message-ID: 
 <OS0PR01MB5922AD80200B261AEC48F30C861AA@OS0PR01MB5922.jpnprd01.prod.outlook.com>
References: <20230816142458.147476-1-biju.das.jz@bp.renesas.com>
 <20230816142458.147476-10-biju.das.jz@bp.renesas.com>
 <ZN4BgzG2xmzOzdFZ@duo.ucw.cz>
 <OS0PR01MB59228E95C12FD0624CB955C5861AA@OS0PR01MB5922.jpnprd01.prod.outlook.com>
 <ZN4gMm5Nmng8SDrN@duo.ucw.cz>
In-Reply-To: <ZN4gMm5Nmng8SDrN@duo.ucw.cz>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OS0PR01MB5922:EE_|TY3PR01MB10318:EE_
x-ms-office365-filtering-correlation-id: 94df203d-4582-4c1a-0784-08db9f27fdad
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 R/6QvczBsfLEoTa2Cvv7vSCzolpAHZoQo7txdZGCnASc4l//0WV4JBsfHPWnb/QZhl/alqwj/YD7UEQWLRieMp60EsRDaghOb0r6n4Yf4V3myxfjQ0WcNur0wYM5xNpppuFyXAbrpOCjUXcImC1nk6UE5znEcJrbwrlEyU/anB6CNXPKOxWHBRMtPtPOF5Src7jczSLjBbe7Pa73OrbQExESUmoyDj14vG/cIPpBBEkbdHWXB4HpMphbOLhl0eVz3WLifDabmkNA+SEAjpPJK9vgp7WqSYRpw3f9n90BPupWeLqH3TX/+vKXTAzVEuox6p1CDqsabpJ8hsO13IvIyoWM3lP66GmJ3iIp+5tEYzqDdAcFnsaXjOZMm4jBT7WDI54rc7xfgOdU6DRbOqSOCrJ4bV9hPKS0ZCrddfP2KJ/eDuPIVEvZf2tEUzQjMKiGF+Z0XUnQQB8c4Q/7n9wzbZJVf3mUvYIAqdhGh154HBCL+C5jLHCceoekjbi04a/QAV9IJerhaVNw0RyuQBXqzQKObFVznnht18FbZ2pPCFpDx1ndknPB8OzCakV4EJnq59bjz0ijzWpu0pxL8fIqdYSRbtHqr7sOnsWzCetIsTm+9Qjhx3bbzRliToyEvq2b
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS0PR01MB5922.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(396003)(346002)(136003)(366004)(39860400002)(1800799009)(451199024)(186009)(71200400001)(7696005)(6506007)(9686003)(83380400001)(26005)(122000001)(33656002)(86362001)(38100700002)(38070700005)(107886003)(55016003)(316002)(6916009)(2906002)(41300700001)(54906003)(66946007)(64756008)(66556008)(76116006)(66476007)(66446008)(5660300002)(52536014)(8936002)(8676002)(4326008)(478600001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?us-ascii?Q?dgponMtv5wahHnXFxUwlkTL5c7TEKZLozb6seTnsCaDgl3umcZbLBiiuNmRM?=
 =?us-ascii?Q?4VxdVUQJWVNaHnyqGv6HqJgI2gG7B4UJr3fAP+GbOBFfVBjmRzzgB5C1+bxS?=
 =?us-ascii?Q?V7bPr/YjGprah0+Eq7LOecupVQ1CjyjrXk6BlKUOEDeW2cY5uyn0lcTaRW+X?=
 =?us-ascii?Q?wUvXSsWBAsn9lTVt8Q8X19O2XQL+x/Wa941mOc4+Q4T2oBBg5LCLpW7+rWGK?=
 =?us-ascii?Q?vaJl2W8dEoeFa3wRV95sU/mMCgsDlDdQMA+DOS34dAPdnsN4h0KKY3nwNGHP?=
 =?us-ascii?Q?ufmFelW6LyXeOZGnL2+Q9y2ghdSv9De4gziiqHJBKE8RBdOb0EJ1O5eGXJ/d?=
 =?us-ascii?Q?3XA5WvMRG522drHViupFUvgLv+xJHckxsQ6e+wlVuow0ri9XVSpgGDYPUZnA?=
 =?us-ascii?Q?l0mj+mZBcTfWOfs3LTCagKsWVW21wm9Xmmu1qjuwOMcGdCtZ6vG719f6j0tH?=
 =?us-ascii?Q?Z5OqlJN2/DlQl40ebjyFuA8LFFCOTqB1Fuy9LQjM8XEPa+hnyjJO2fiYIzix?=
 =?us-ascii?Q?YuqKQ4VslzljdWx8mNk2fl0ECL7b8LArHAkjd1U+7nYMPqI+X/9OUmidXAjd?=
 =?us-ascii?Q?wZqIHyOGKzspdPRjF5nmUWqVPqZhrpTXCUhbWISMR5IsjQljxR60sJUCYzWy?=
 =?us-ascii?Q?mU2DwfUnWuJPFdDHcGkpZ87R/q8cRqFCR4ROIRGGdadQNPJdMAg0z21VE3PE?=
 =?us-ascii?Q?TzjvJj+Z7spHQ6qrX/tgc7dk83lfOBVHO1Pgilfi7p+wCilmfRujNIaUIark?=
 =?us-ascii?Q?x5qMkeB26NpB5bBePF5paQ3rv8fFEgkiiy13qQV0y//4aLV1Ts40nPNFUYlT?=
 =?us-ascii?Q?P2xJNxSekOCKm+/56P0zx9SKhnWRIi1+dFWR4E5G9/72GkFxpSY8BebDR/0/?=
 =?us-ascii?Q?5hexDOkdGSaYyRPmHoCkQJcfIjYsbGcP3j+4dpc+dENaQY/5wjo5Wtwh0t5b?=
 =?us-ascii?Q?32xArJ8DSmzAq9Gf/SRWj2S1cyF/h4IhqKTOPg2BTkijvig+SbP3bYIM4S0F?=
 =?us-ascii?Q?1xm6m+58o8M7dL4wxR+3FuKTwvonhTVDi9YVaLwPn5XqLPGDww/KeCJMZurr?=
 =?us-ascii?Q?h9hVBuQatuej9aK2UwqsDJQHynXPjaZze3k4PXj0+djjARQiOFgENa5c6F7H?=
 =?us-ascii?Q?21fb7QXFGPRnCWDHTAPrpEElthoJsF6u1VQ9hBx7APoOfbsNGRQPX6ouWcJZ?=
 =?us-ascii?Q?52HRrRUqkntXP3h8ylp5ZQxmoG/et+CQV6TlCj81F22oEcYCOkGPl6rAA2CW?=
 =?us-ascii?Q?QMKzdqovTrKKqeLu6FQnROi5nF8Ggs3yRP8Dgvy5bADA4G+EuIAJiVL18z3U?=
 =?us-ascii?Q?kXvcdcxsnbKxipreFdkc0LdjYFuhOUJiyAzGqkNFEQM+B2T78UpuLDPWXkcE?=
 =?us-ascii?Q?n/fQS47FDdsDP0f+l5dACHUx7odCDOdBmuo0oV0oQtkC1uwhnhxRG2ExEqeS?=
 =?us-ascii?Q?GdsLlqDLa+h3yK8edRKE2HDTVimnzge/lVZ1aw4oq8gZqtJnXNVixeWZh1YB?=
 =?us-ascii?Q?gRsL0lFK67Lw8DJy/juRR1Va4O3qzpPXb8QzYsYXiVLBaw6UQV0NNyg0+UVJ?=
 =?us-ascii?Q?VvqUr5hbYeOjASCzWb+7QyQhauaF/5bEZBBBwUWD?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS0PR01MB5922.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 94df203d-4582-4c1a-0784-08db9f27fdad
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Aug 2023 13:43:51.1359
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: EVYo/TouDOumUJVP/Kte9IYM5KiwyvcC/VCsRSNr9H5NtKf7kT4rkRgLFMwxQU16OTHNNz6efUy9z1stYiGkz2/Foy5/SgUWxCz/w71M3fI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY3PR01MB10318
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 17 Aug 2023 13:43:59 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/12767

Hi Pavel,

Thanks for the feedback.

> Subject: Re: [PATCH 6.1.y-cip 09/13] rtc: isl1208: Add isl1208_set_xtoscb=
()
>=20
> Hi!
>=20
> > > > If using an external crystal, the XTOSCB bit needs to be set at 0
> > > > to enable the crystal oscillator.
> > >
> > > > +++ b/drivers/rtc/rtc-isl1208.c
> > > > @@ -6,6 +6,7 @@
> > > > @@ -175,6 +176,20 @@ isl1208_i2c_validate_client(struct i2c_client
> > > *client)
> > > >  	return 0;
> > > >  }
> > > >
> > > > +static int isl1208_set_xtoscb(struct i2c_client *client, int sr,
> > > > +int
> > > > +xtosb_val) {
> > > > +	/* Do nothing if bit is already set to desired value */
> > > > +	if ((sr & ISL1208_REG_SR_XTOSCB) =3D=3D xtosb_val)
> > > > +		return 0;
> > >
> > > XTOSCB bit is not bit 0, but xtosb_val is either 0 or 1. If it is 1,
> > > test will never succeed. I don't think that's intended.
> >
> > As mentioned in the comment, check is to avoid unnecessary writing to
> > I2C register if it is same value.
> >
> > 0 & 1 =3D=3D 0 -->skip
> > 0 & 1 =3D=3D 1 -->write
> > 1 & 1 =3D=3D 0 --> write
> > 1 & 1 =3D=3D 1 -->skip
> >
> > Is it expected result right?
>=20
> As far as I can see, you'll get
>=20
> #define ISL1208_REG_SR_XTOSCB  (1<<6)
>=20
> xtosb_val =3D 1;
>=20
>   64 & 64 =3D=3D 1
>   64 =3D=3D 1
>   false --> write
>=20
> when you should be skipping.

You are correct.

I need to do double negation to fix this.

	/* Do nothing if bit is already set to desired value */
	if (!!(sr & ISL1208_REG_SR_XTOSCB) =3D=3D xtosb_val)
		return 0;

Cheers,
Biju

