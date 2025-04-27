Return-Path: <prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2A17C369D1
	for <webhook@archiver.kernel.org>; Sun, 27 Apr 2025 18:51:10 +0000 (UTC)
Received: from TYVP286CU001.outbound.protection.outlook.com (TYVP286CU001.outbound.protection.outlook.com [52.101.125.11])
 by mx.groups.io with SMTP id smtpd.web11.31697.1745779861611693638
 for <cip-dev@lists.cip-project.org>;
 Sun, 27 Apr 2025 11:51:02 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@bp.renesas.com header.s=selector1 header.b=AEGtVUhV;
 spf=pass (domain: bp.renesas.com, ip: 52.101.125.11, mailfrom: prabhakar.mahadev-lad.rj@bp.renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=khc4fa5IBov1XPs3lJn/YHFPt/AI6ft33u+T+6wP7DA8jNscCXz6tGXb5cs1GhrhpWCn5NzTPsFBlcazgBBWT1Sj4ielaKd4AFgY46eXA+3PYwE3tnGtZJcmRKOdCEXxPV0+ToDg1ise55wKDMFFBaVSJVnrDT6yTs7by62RsLScsStJrFLNV1znrc8KN+pJ0zdQeQ3cIWLTM+4kr0wackNNhZux42vHAbRlrFAptrGDzQ1ne+9zLaCapqo5S1NZ16rNhxH70Jgocr4ESy2rzzQtu3dcBvCQ3Ya1rJj/xDVV7M6oVvEdOdvFHM/+IB/+iVXJ7f0ElovduWNuK1xZvg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=N54nWh0acyyS8ZjauDf7D5MwXh6ba6MTAgXLocVSOy0=;
 b=RjVIctQJ4oatwYLSkO7munKguHxyEQrjyZn9TW03WpcGu6yzaw87wzlB1pXyO0ZJHHmA/7uz3ewTDYth+qrIaeYDn0BKQrxgxLMz1T0oYroZK1MS82UQyuDRN5hgHQbvGP0d2yGGxvnEGUmsg697iKZmWb9pJ3xdzJDz3Vfn1ALhg7tnHxSqwPlqtO37UnJq8Ru4zghmIuXyd8ePlmhEVbm165k9efpQixQdogWb/eet/rSoIpiqXjiYx5Kk8yzRaJhSVY1beYUkgcllZKRypaHrL3bvrkhIAfDf5o9Hc8Hs16mXlqIy6sbMeK/5P8WzbOcZDq2iAHVcXeVRbYV9ZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=N54nWh0acyyS8ZjauDf7D5MwXh6ba6MTAgXLocVSOy0=;
 b=AEGtVUhV+9ESbHWXGFqddw89ht7+5mEyCERGf3W8e0KnpEj1urzLbmWe6Y+fs+yYuAYNYVVv6ezStknv99YGg2PkbDHxTlM/7ksd9KfoXdC7NaDKgRY6+6/eZAkw1Ms9EhOWLqZ7KxgM3kYRepjnfnpz8T4FQdHEI/BtnyxYZsE=
Received: from OSZPR01MB7019.jpnprd01.prod.outlook.com (2603:1096:604:13c::8)
 by TYYPR01MB12384.jpnprd01.prod.outlook.com (2603:1096:405:fb::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8678.31; Sun, 27 Apr
 2025 18:50:52 +0000
Received: from OSZPR01MB7019.jpnprd01.prod.outlook.com
 ([fe80::8a27:ee0d:d7a4:9d10]) by OSZPR01MB7019.jpnprd01.prod.outlook.com
 ([fe80::8a27:ee0d:d7a4:9d10%7]) with mapi id 15.20.8678.028; Sun, 27 Apr 2025
 18:50:47 +0000
From: Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: "pavel@denx.de" <pavel@denx.de>
CC: "cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>, Nobuhiro
 Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>, Biju Das
	<biju.das.jz@bp.renesas.com>, Fabrizio Castro
	<fabrizio.castro.jz@renesas.com>
Subject: RE: [cip-dev] [PATCH 6.1.y-cip 00/21] Add SYSC/MMC/GTM driver support
 for Renesas RZ/V2H(P) SoC
Thread-Topic: [cip-dev] [PATCH 6.1.y-cip 00/21] Add SYSC/MMC/GTM driver
 support for Renesas RZ/V2H(P) SoC
Thread-Index: AQHbt1BghlBV9h6mCEuPJszcEpO3a7O325Hg
Date: Sun, 27 Apr 2025 18:50:47 +0000
Message-ID: 
 <OSZPR01MB7019AA26BC7B8FEDB9EC661BAA862@OSZPR01MB7019.jpnprd01.prod.outlook.com>
References: <20250425121445.62818-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <aA3uEsY33BwuBPLG@duo.ucw.cz>
In-Reply-To: <aA3uEsY33BwuBPLG@duo.ucw.cz>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OSZPR01MB7019:EE_|TYYPR01MB12384:EE_
x-ms-office365-filtering-correlation-id: 289b5b0d-ef25-4dc2-8b13-08dd85bc6c34
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|376014|366016|38070700018;
x-microsoft-antispam-message-info: 
 =?us-ascii?Q?cgq/QnJrUECAqlG/q5UP1u+5qhy47zG2zYMCh1yNIx73WtV3ME3ZAVnWGptO?=
 =?us-ascii?Q?W3HGf9Ijd6HTNB4sMsKvM7Jjh6iir7l5bJPXuXpb4CxFuCtkwR3az0mu+1wl?=
 =?us-ascii?Q?TflfCSgO6bsDxEUVLI/xatpZqD5j0QxQGhEs+kZAQlBn6JY5z5gnL6AgZN+0?=
 =?us-ascii?Q?6gTDo0m7HRuZYoHj0Ke1dHwQdLh5J77l+MBsDNuk77XhB/HVFYcDvXf/qn9c?=
 =?us-ascii?Q?FlJ+DqeqtJmSO6hiOUs+QfTzBanxXmYS0478slJB1K/sAFKKHtIj55d6y1ux?=
 =?us-ascii?Q?ffS3Jroxfdf8T/gCrG8XStFflCgDztuWYCUyINkkau7imtp7UtkiNb2kvl5F?=
 =?us-ascii?Q?CeOmqbFrHnHqkyg3GNsyN0PR+GiqfroI6v1387fCtic3k5BRCR4gD3Ixyz3o?=
 =?us-ascii?Q?KWH8RWMBRmcu59MDb6wsOHYJtjp3C3c6zFvcJBUDZl5LewgpGXDkuZFt9L9f?=
 =?us-ascii?Q?71r89GfWpZ5cPDpMVssDPjXKHic0JM9AKLx6Omyd+EdGX7tyASeXjU5OYhOr?=
 =?us-ascii?Q?IMgpL6UUm3pua97YawRa0dYP09QMUgTykL6lO/84DqB6HAX2SJaVIHYjRqdg?=
 =?us-ascii?Q?OH0QUEirHCxPi30zsl65kiSsHsrLDXOvT0y4x8x+2dhancOsgzHAynM8Afqs?=
 =?us-ascii?Q?LhnQhsIXxktBaWJsWdTwF2EEtjnQKI22AsFF/j9tdK0uKyQfJRlJU/sqae+u?=
 =?us-ascii?Q?AbNKHLhB5jl2aM9PL1JQnxSASgRNJCa7lJ91lujmGhb1xzw75xSe87yaSF7P?=
 =?us-ascii?Q?IX4o1728GPY2vuDq3T/iaD9hIZTDf2rPcOW0lqOypZOBKVkOKcEcgaqrn77a?=
 =?us-ascii?Q?BwZEET1IeGxfPzSz0cX8hzFLW8TQJ3bLEoUXJrX9ra03xqb2bbthOYmb2MpH?=
 =?us-ascii?Q?3p10a8rLhqH0bUxLU6baKnJj3KuGY5G1150pydRFu2YiI9zbPR5rCcH9m3lX?=
 =?us-ascii?Q?HROys4zg0QDabQwdWEBn9NxVWrxOqhc9BPPfVAfMYTS9OKPX0QjV5KyNjlU1?=
 =?us-ascii?Q?nFlG4nG+e7zqVl34bmMmR11MZUb62Ua0cvQh7Bh0PHrHDRgw3mXn0ofvJS9m?=
 =?us-ascii?Q?gcgIdwIwpdLZonelyoaELvQCLHM/r4IDQF7zJV/+rBtuWLlL68XFKozaInBO?=
 =?us-ascii?Q?Fv4GXR0MOt1c7Qgy1kNe4zg25kJrt662ScIQZRkb+PhMItiisbylYwYk3ssS?=
 =?us-ascii?Q?beSUoDJHFqJsdX5oJ2xFbmKUi/wNkovI4wrLOpZELJFe2NE8aBmpIEb8jEnU?=
 =?us-ascii?Q?4zOxjr4si4QL6bu5aUaf+TT4p4z7B+6dHNtEEu6RRfeQrhyIw+pRW/6ZttQ2?=
 =?us-ascii?Q?SbmVnxAuY/YsP1JtijhuvMiUlw5dR5Yrlj1f4JvtjwN9fOanFoLK0Hh9Kwm7?=
 =?us-ascii?Q?hxF2rN3WKUijDIQ7DkArxz+0njQAVHL2OxAEBhYEoX90hRP6HhXRxQBy5cIQ?=
 =?us-ascii?Q?NhTQbbvOTq9U/mq5AHxJWPPTdLP8znFKCqaIfnSWHZ39hP2ONy6aoQ=3D=3D?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OSZPR01MB7019.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?us-ascii?Q?0J4mX1Mm/thKRJnn6wesXwvkcYDR3bUym+BwG5LkmdyNOPMqr5nHq0JSJWxR?=
 =?us-ascii?Q?h6D4mfTPzwZ2lVBdlsfcD7Fn1MmkpetacfwCIYM8+/SV49ShkhukXo37QGzG?=
 =?us-ascii?Q?1bj8UuK5c07FBHQ/tzzDUTApT32sTY1FbkazCtVlRXzpn/7zcz8SIfxd/da7?=
 =?us-ascii?Q?n/5mor739A3oHJebQdVSU0BrJ9/YjH6QqJLCNK8BmUKC4tuFRLqU6TelAHqV?=
 =?us-ascii?Q?0sA7Xx81G5/2fehuYrKGI7/3PdhV5E1Y87NweM0pZjXXb3VzJLt4dQRD8w37?=
 =?us-ascii?Q?Gb7zIpwwcUANU1XwN0v0I2QEVpFCPS7m8Doa/TkYlDnIPaHvDL6cyPjOVdaY?=
 =?us-ascii?Q?+2WsUu5c7Q4g3IiKd7K8fgphFwC0dBGgcLoSLAmaIC857pDQDNVb6JWwJRL6?=
 =?us-ascii?Q?1fUmWRA1d9z4kjn2QenpFMo5uJUGBkIdOlWXGiKoKgham6rR9ktYT3Fk1SSy?=
 =?us-ascii?Q?QZotneo3AffwcSmRC/pWYOtGL+pwb6U/a+Rbj6yotX19UKp6az9fHs5erCnK?=
 =?us-ascii?Q?iYR7EoI0lYVaWqEV7kc0KSCG88RMTF5a1NVJ4CF6gR7jcWsrry+3gBUikqqE?=
 =?us-ascii?Q?odifOsDffk1IxQ5s8y5ZT5U1TNgw6krD5KZxS0EcW1J8f8qGDf/OV/7Fi3iH?=
 =?us-ascii?Q?+uMs1o7LlgO/hLWHxGbuuWO7Pb+Cpjx4sgGWnq1lQPRPOsw1tL0lZLr7rCDM?=
 =?us-ascii?Q?3vprO23Y1u+lxMx7F2GdfXMxtHV7YAEgFSQH/LZYsj/g2kc+Gkl196sjqHUD?=
 =?us-ascii?Q?Y/WOBYuG57DalpSSmZ3NTmvYHDuP1ddrTT/Wj+fzxMV5HS5nYFnCB7F13Ggz?=
 =?us-ascii?Q?4XLOstbcDhww6o/NQsi0GTvat+/O0NLRYZ5SeQzj4zYVRPS7YLYU3uNVL5gB?=
 =?us-ascii?Q?2V+I+ysROPHUbW4xL1W3s8TMefaKckwIxae2b7fiyVb1dPqj9DpyB8kDy2yT?=
 =?us-ascii?Q?J7KnaZMYpfw9/rlQFIbAo6B6jPw31Xs/aJiHvWEZtG1bhSxG6vaYZ5W3sdmc?=
 =?us-ascii?Q?rE2N3HJmchk7B9YLyQ09PQoAsJ5ixpumginiKesfIBe9xU7AtSePt4kDUHen?=
 =?us-ascii?Q?g6ZW9mJVjYrvojYknkmKzPHmcfxwX7r7wu+WN5IbCFizKUbtvUaZQD0JUMWa?=
 =?us-ascii?Q?VfjOj8jJq+2qgWMcoDt8c/n7FA8NVw3QHQDpcmaffdI06OolWBpqz5Y4eWK3?=
 =?us-ascii?Q?NDNbWdGFLbHQ4UtHdmLDzxsGAiAQ5ufBC06IkC9CZP1Hiu4mwOq3aS+9iwB8?=
 =?us-ascii?Q?t3v8bYPKAjob2olSxb7MUB0ml6UFDpTBy/tUuKCbOWfPp2NSxFKEuC5SZ9IZ?=
 =?us-ascii?Q?zSJmgjII+FIvh7UPR5cailz9om9NP0f/XBV8NdDYRdCgEK40VPYnVMx4Wnwh?=
 =?us-ascii?Q?fB9JJytvfhXTW4QQpwNq91NAp+cneOEvSllV7Lf1rghj8zagHfd9PwToMVoM?=
 =?us-ascii?Q?z2OgEiUlfIvXuUG1vvRBXdJbz2Bg24PeidraJBC0lY6S7E0D5xuiHM6wyoWg?=
 =?us-ascii?Q?5MZl53oImGhdYfcF3sP2YeUYgr1eu/rs39PZ6dGvyQRmClyOqlAKdqQ8MDHL?=
 =?us-ascii?Q?tW5UcpEsGyEZbqvvFnediMYBVxpeOGdbD2mkZ+1nFn/f5CAkgUv8WQvQ+Wbw?=
 =?us-ascii?Q?4B6LiK9NRqiLDJ/WFySiGkw=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OSZPR01MB7019.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 289b5b0d-ef25-4dc2-8b13-08dd85bc6c34
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Apr 2025 18:50:47.1997
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: OIuQ5Jpgv1EokMfS6h/BikKMVuYGRNaxr0rtAuaNfl9tq3xneNhzPOA5onHhgZADNPeVCpI53UorsACEB0bo9utM2ZKBBn2O6gCGxTglRhkaujFYt4fkxIXFf7giRq0P
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYYPR01MB12384
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Sun, 27 Apr 2025 18:51:10 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/18650

Hi Pavel,

> -----Original Message-----
> From: cip-dev@lists.cip-project.org <cip-dev@lists.cip-project.org> On
> Behalf Of Pavel Machek via lists.cip-project.org
> Sent: 27 April 2025 09:43
> To: Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>
> Cc: cip-dev@lists.cip-project.org; Nobuhiro Iwamatsu
> <nobuhiro1.iwamatsu@toshiba.co.jp>; Biju Das <biju.das.jz@bp.renesas.com>=
;
> Fabrizio Castro <fabrizio.castro.jz@renesas.com>
> Subject: Re: [cip-dev] [PATCH 6.1.y-cip 00/21] Add SYSC/MMC/GTM driver
> support for Renesas RZ/V2H(P) SoC
>=20
> Hi!
>=20
> > This patch series aims to add below driver support to Renesas
> > RZ/V2H(P) SoC:
> > - eMMC/SDHI
> > - GTM
> > - SYSC
>=20
> Thanks, applied.
>=20
Thanks.

> AFAICT we are now up-to-date with Renesas patches. It may be worth
> testing, and if we forgot to apply something, let us know.
>
I have bunch of patches which add initial support for RZ/V2H(P) EVK, which =
I will
send shortly.

Cheers,
Prabhakar

