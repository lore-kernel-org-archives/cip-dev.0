Return-Path: <biju.das.jz@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD525C2FC0E
	for <webhook@archiver.kernel.org>; Thu, 17 Aug 2023 11:33:38 +0000 (UTC)
Received: from JPN01-TYC-obe.outbound.protection.outlook.com (JPN01-TYC-obe.outbound.protection.outlook.com [40.107.114.94])
 by mx.groups.io with SMTP id smtpd.web10.185053.1692272016184887977
 for <cip-dev@lists.cip-project.org>;
 Thu, 17 Aug 2023 04:33:36 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@bp.renesas.com header.s=selector1 header.b=D0/TRqoJ;
 spf=pass (domain: bp.renesas.com, ip: 40.107.114.94, mailfrom: biju.das.jz@bp.renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=l/4XesorSmtkX94tXisfytaHC3P8vXWIbmHTq70suPV2dQn0g3DS/rsxPwAKmokxgIaqIg2RPr2RQ7jWLnQ7KD6HJiAZZy7pzRfQlMDnkJddQbnF0urUGDVla489ild7eWRJjTbqp0zkMKRSOSDyxv8jFWlTq0bnfa7fULjdyWOTahoFuuD8/hR+fqiO3edHwwcsla3cCQ8Qr4obeduTBzf73G3UWQoKonfSe74wz60K22opm9+Vp229RnQgU/W0rUDpaf0H4CTULZnxOXBy1JFtmd+urb3dHWpKtHu09/Qu3LufE2R9ALu9dT58obcO2dtGq/fe/VR0xb/+ZpQzJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YkZDFCq59NOAYqO0h9o/FqaUaoSmc7s01DGEKTS80zg=;
 b=RAXxhxRCKTfI/5OgYcXLsjHfKc9YguLQBAPqLsFFV2S2582cqIUO9yIwUgdC1yIxAM0Xd43cc9/MDZzM8ScL66sMrxplxe8Di7ebD4J2N1/gsZiNSW+mTSwTiLldQOby3o0ds7EoQ1yBRCkouoRpDfJwrAebi0ZQBp/9ETEjW5Vn/+boDXLLqcIqhwJ43+j2vZkI5PxyWPMm06RJcQiGx6s2Wvbb77pRQuTSTwDHzRb1eR8zv+MSBDiTYDUCw8AzwRo8ElAfinrlescdfqYfGRaC0GYNoHNP/hxuvuhBaA6I22wj/3up0gFWtiDhr57yuiz5AT2IrR4ngPMahoItzw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YkZDFCq59NOAYqO0h9o/FqaUaoSmc7s01DGEKTS80zg=;
 b=D0/TRqoJeONAqU+lZ6OzwDGnCopNrO8M3tq7Ix1u926QGEHBM14ETGqjPVaf9sKLY4AW9ji0LfRnMCkK5e37ct8t3WE8uPqvXf6ZqC+KHZxMXwY8TAOpILt9SqMxi5ybVah9PNxOT2mrBTZRfv+iATZvYQeRJY8pgmm+np9nTYk=
Received: from OS0PR01MB5922.jpnprd01.prod.outlook.com (2603:1096:604:bb::5)
 by OS3PR01MB8193.jpnprd01.prod.outlook.com (2603:1096:604:173::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6678.31; Thu, 17 Aug
 2023 11:33:31 +0000
Received: from OS0PR01MB5922.jpnprd01.prod.outlook.com
 ([fe80::2168:623e:e186:4cf0]) by OS0PR01MB5922.jpnprd01.prod.outlook.com
 ([fe80::2168:623e:e186:4cf0%6]) with mapi id 15.20.6678.031; Thu, 17 Aug 2023
 11:33:31 +0000
From: Biju Das <biju.das.jz@bp.renesas.com>
To: Pavel Machek <pavel@denx.de>
CC: "cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>, Nobuhiro
 Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>, Claudiu Beznea
	<claudiu.beznea.uj@bp.renesas.com>
Subject: RE: [PATCH 6.1.y-cip 09/13] rtc: isl1208: Add isl1208_set_xtoscb()
Thread-Topic: [PATCH 6.1.y-cip 09/13] rtc: isl1208: Add isl1208_set_xtoscb()
Thread-Index: AQHZ0E1+hJqibOmRw0iE2qbtZyZlRa/uV+KAgAADI8A=
Date: Thu, 17 Aug 2023 11:33:30 +0000
Message-ID: 
 <OS0PR01MB59228E95C12FD0624CB955C5861AA@OS0PR01MB5922.jpnprd01.prod.outlook.com>
References: <20230816142458.147476-1-biju.das.jz@bp.renesas.com>
 <20230816142458.147476-10-biju.das.jz@bp.renesas.com>
 <ZN4BgzG2xmzOzdFZ@duo.ucw.cz>
In-Reply-To: <ZN4BgzG2xmzOzdFZ@duo.ucw.cz>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OS0PR01MB5922:EE_|OS3PR01MB8193:EE_
x-ms-office365-filtering-correlation-id: f193ed0e-81cd-41dd-e8a8-08db9f15c881
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 +2zE0hxXi4CTyqb9o28tgt3CF7tttQv9LxDjU+rHGL9MmFQ0bFMlWQjm2WMaP5XSyqu1Hie/A3iV1v4edvoBknhhAPwBjswhZ85kW51B3uAnb6Y1qiJqHJguaKAIRyrcme/WHnbGq21rp1RaiA3etG0bMu4Ta58rh2rnhmsqnS1GlI9ft5W38C+rY2jcZCZgmKAoTkKuCL+eKncqoIa7JPTN/NdIP0GxC8lHdABjy2Z0MW112AJs08jyRzlelN059I2Inb0+6JyfUOlKRkzkXxwMFLVA5ESop7ZQS4T3v0foRmURdWzWRwssVhlXeMOvzA5N264Uno5ynIrRy/f9AgZdUqS4N0qhqpi9Ae/dPsxuFz7InSlBQBBWXsaaaGgFjti+DMIYuHalnS/t9GqwPTYKOFHjw7uSvDFYBkzFGd8txFVNDRkjYPbRRmUhZU6wK9Gxq+AXxkfkQITkkCSdIicMXAaqasld5ismm9k/HIq2JAoy6kS7vMcgtUI/8ftf7Ioo7h6ibVYrHmb697TcW6SS/W6/SWjqIf5QR6DlcypQWDRrXDNyTe8mduDlybXdUFehf3Z93jg8nCbirHlQbap4nzp+ArrCmsiKfIO24juWAINcjeLA8cpUlxuAfPHb
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS0PR01MB5922.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(366004)(396003)(346002)(136003)(39860400002)(451199024)(186009)(1800799009)(66556008)(66446008)(54906003)(64756008)(76116006)(66476007)(66946007)(5660300002)(55016003)(41300700001)(6916009)(2906002)(316002)(478600001)(8676002)(4326008)(52536014)(8936002)(38070700005)(71200400001)(7696005)(6506007)(9686003)(107886003)(83380400001)(122000001)(33656002)(86362001)(26005)(38100700002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?us-ascii?Q?1cZvJUWuRt+CQXf5/VDXexiEPdfCQlGoFhEfTGDUHEJ1di7GANTKJan4Okui?=
 =?us-ascii?Q?7hq3/FNKomfIspuvtCMUDXegs/vemxHO/NRN/qgSJTb3jCDizRyzBxaYfUtB?=
 =?us-ascii?Q?jS5iFzTPpv2SVB+SvSVbnwoCJzd5QoF+coqEZsHs/dQQ+ftUV6V7uZDQYHrG?=
 =?us-ascii?Q?G7eUTnYONCo/gEQk2All7pqAmVa0WTrOwZ3CXDfMJSrpUM5dJgQIJDfFFO4f?=
 =?us-ascii?Q?hriDBwbFRCeErH5spaA0/10cKsqQk/24JAauFViRR9ILTDnTYM/ArVd/UjYP?=
 =?us-ascii?Q?TssVv9G5nUErX5Pmypw200GzMik2XZddipSUhunAeRsyFV8B73XdlpWKOBrf?=
 =?us-ascii?Q?vD1dxORyehM5+Jor0NExmFOTXbYoEOX1LUv9J1md4B1PI1EHH/7PtGXF2Fm6?=
 =?us-ascii?Q?oS2Df4OQVSg5m0h1Lx9Y31hLP+ifDGrT27YjvEoVGqXUAwQL4IXDRuHm9qC9?=
 =?us-ascii?Q?wIWrP03vWMcBoeQAHnokaV8pqs3VQvUGKvwzja0rjGnzzT5k8FolTXIbPoke?=
 =?us-ascii?Q?pQlCBPkna6LPxb6t2oEfymrVYV58iJk5UvxFVzETl3KxXY7I0JG6cE+IlntN?=
 =?us-ascii?Q?Qj7ATI5rMWlMd+z+4TAC0FdoOegzZwWEp1CPcbgpvfGcjt/CFOjGmTYvn94y?=
 =?us-ascii?Q?Lt0QqZ55J7i0QvlW43aXab4PQHnXVmfBxprF0Fv9FAwyoQZf06wFOAt6FPBz?=
 =?us-ascii?Q?vtiy2Hu9kpmne7yWzk6AYmqOQhg1bzJd+CkJm+e9ixIgA4FQS8j24mP/E/Od?=
 =?us-ascii?Q?RCx3HR9TQiXZFVXXv/BVffapXwt/6J316cR1jMUn6tqr652KgdlIJ7VfcdLx?=
 =?us-ascii?Q?kiIBFMTp/uFkXKRY9ogkTlkhbKIcXxzBnSDgqcqH4TF5h6V9jSTOmQosL+3r?=
 =?us-ascii?Q?FUyw67/roZxunL/WISLmkMGLbazhSQBgwbL9syFbD/1UByYG98z26S64IN3Z?=
 =?us-ascii?Q?MOmew5tIIX3Y5kEU81XHDWxQxDF94BXoGYebtp3dkl0ox9DTJ7iw8jjwmqY9?=
 =?us-ascii?Q?U++Q4S6cXFcC2WXWzcGgYzTKk2z5vZc15q99asVM5VfQzS8bpWjxnsxB1xuW?=
 =?us-ascii?Q?W8/rTNSSfzmEWKpV4H/H5Mld5Pyh2O8ELHO41VCvSgWYmLDpjEBvi5vCnDut?=
 =?us-ascii?Q?cY70OhgIaJmSutF08Ck7fqRZsd9v3o5N+tFyvLPCHGU5mz+jG8sL+u/xJAnV?=
 =?us-ascii?Q?woOj672SoKsJZtdRXpLwBLgDHUtOvWSQrWWrpXLUQ9QgWUIEcOgDhi6chMFn?=
 =?us-ascii?Q?P/8QA4BaqN8BJun3JPcLtgXdqwUY7J/lSo5wfHmB4qWE3yFnoCngfFXJrHeI?=
 =?us-ascii?Q?xydoxOwUXTm9W3hqohfkXzcBQ1a7HCWAtfacij8wOMbzmiRbTB4iZ1EEGXQh?=
 =?us-ascii?Q?JjYDnAeWMbknV4xGXoqLoTe6gJbHkCmCbqN4fHqVicvDnPGP2AiQJJoRe12X?=
 =?us-ascii?Q?uOM73PqOUnOGJL3vYHNXeSqe5064MlaTTZRzf9Ng948ya/nWOpbBCUaMvqG7?=
 =?us-ascii?Q?tGxwD0X3BsBs7j4ph+uPdak7dvlAcMrVd7CuERrn7jJ24TL44VhqZsv1j2hs?=
 =?us-ascii?Q?pB2qLCJA2WoWK3PzdC8qZHbmMwef142Mq6BdAHtN?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS0PR01MB5922.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f193ed0e-81cd-41dd-e8a8-08db9f15c881
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Aug 2023 11:33:31.0127
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: cdZ/b5hL+GCLseOeldw5Sc5k/m+taK0cE+MWIp2z91BHcWFLx8kaihHCZ8+Nk6gTAV1EghgZ3ArZa86iTR7cwePK5C8+qML7sKVCZfB9IpM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS3PR01MB8193
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 17 Aug 2023 11:33:38 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/12763

Hi Pavel Machek,

Thanks for the feedback.

> Subject: Re: [PATCH 6.1.y-cip 09/13] rtc: isl1208: Add isl1208_set_xtoscb=
()
>=20
> Hi!
>=20
> > As per the HW manual, set the XTOSCB bit as follows:
> >
> > If using an external clock signal, set the XTOSCB bit as 1 to disable
> > the crystal oscillator.
> >
> > If using an external crystal, the XTOSCB bit needs to be set at 0 to
> > enable the crystal oscillator.
>=20
> > +++ b/drivers/rtc/rtc-isl1208.c
> > @@ -6,6 +6,7 @@
> > @@ -175,6 +176,20 @@ isl1208_i2c_validate_client(struct i2c_client
> *client)
> >  	return 0;
> >  }
> >
> > +static int isl1208_set_xtoscb(struct i2c_client *client, int sr, int
> > +xtosb_val) {
> > +	/* Do nothing if bit is already set to desired value */
> > +	if ((sr & ISL1208_REG_SR_XTOSCB) =3D=3D xtosb_val)
> > +		return 0;
>=20
> XTOSCB bit is not bit 0, but xtosb_val is either 0 or 1. If it is 1, test
> will never succeed. I don't think that's intended.

As mentioned in the comment, check is to avoid unnecessary
writing to I2C register if it is same value.

0 & 1 =3D=3D 0 -->skip
0 & 1 =3D=3D 1 -->write
1 & 1 =3D=3D 0 --> write
1 & 1 =3D=3D 1 -->skip

Is it expected result right?

Cheers,
Biju

>=20
> > +	if (xtosb_val)
> > +		sr |=3D ISL1208_REG_SR_XTOSCB;
> > +	else
> > +		sr &=3D ~ISL1208_REG_SR_XTOSCB;
> > +
> > +	return i2c_smbus_write_byte_data(client, ISL1208_REG_SR, sr);
>=20
> Best regards,
> 								Pavel
> --
> DENX Software Engineering GmbH,        Managing Director: Erika Unter
> HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

