Return-Path: <biju.das.jz@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79721C3DA7E
	for <webhook@archiver.kernel.org>; Tue, 30 Jul 2024 12:34:40 +0000 (UTC)
Received: from TY3P286CU002.outbound.protection.outlook.com (TY3P286CU002.outbound.protection.outlook.com [52.101.229.31])
 by mx.groups.io with SMTP id smtpd.web10.16277.1722342879852569636
 for <cip-dev@lists.cip-project.org>;
 Tue, 30 Jul 2024 05:34:40 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@bp.renesas.com header.s=selector1 header.b=PB5kK4g0;
 spf=pass (domain: bp.renesas.com, ip: 52.101.229.31, mailfrom: biju.das.jz@bp.renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=R+kTLXXFOXxrh0aQhEeuzdZydwr+xq1BagYqEVcQZNPVxQLmbChwyz6rkVcBwlQGR8SH0OkCq05/kpjS9HjAWjvwLk108Z7olobX+wykuvrP5AXfi09DSo178BaCRmfEv5S7zPcecgosdkBTE9GRA6wRVvfTtiDRJBX2QYCyrepnBjAjMJTGJ9pk8szfFwpFeQR1DIgANtjw0Cx8Xgdb1vMXLG4g2aS7EwjlOrAI6vt2IO3+s5LXebGAvLcZEm7q6WBr3GQkEjOSb+pZklOtC16hljzACCLgE3I41wbKH4empErIvt3mmJzbeeMsCPbGd4/AFHOoRzFH/goAPBycXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qdAKV63fOwC1nK1AS3BOpVBm8OCS3hFBzIE3Xc+teeo=;
 b=p47FIW6ma4Y97K8vZuI0+LDqRPE5xj4h7FRz3pGmT7W9g6xVYS17qvrTEcnZMBbKgHghq/XLonAgwIYaAYkhT7szBvHQ5nZGdniXGm7d8n2OZFGV1zLahnds9E2VBmllJLjBdzMb3kAf/fQldZ4PJeWwJ8zw6xPRsHS/dMRRjVN69E/XgBT3AAXfhzVnNAo8kgaU2E/sQBqd4j5FFlU8CeFBgK5L8cPfThklkAjf9m8m5R6ahrqj7M/lfWnNP5Bh6pJjXmy43jenKEQ9fZ75/OQFp0YIdlrS9XctlU6D2qH+I5NGcAl1Gdlxim167wu7waBU8jZit2cGBS2QJ1IKlQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qdAKV63fOwC1nK1AS3BOpVBm8OCS3hFBzIE3Xc+teeo=;
 b=PB5kK4g00lV0n+IcCiQVgI8uhmtrR7QFN1N/W1hQED6eIhT+Ombn3GuARcfqvFSbE+qXktLHNuV5ygB0GEjw+eWqnAipOvAA89srV1c5OfLC7D3XDWABSCp5vyjIH5zXMMqnv3/jERN7J7jC5nmmTfHNzRJH+558N8CUHr/VZZk=
Received: from TY3PR01MB11346.jpnprd01.prod.outlook.com (2603:1096:400:3d0::7)
 by TYRPR01MB12431.jpnprd01.prod.outlook.com (2603:1096:405:103::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7807.28; Tue, 30 Jul
 2024 12:34:35 +0000
Received: from TY3PR01MB11346.jpnprd01.prod.outlook.com
 ([fe80::86ef:ca98:234d:60e1]) by TY3PR01MB11346.jpnprd01.prod.outlook.com
 ([fe80::86ef:ca98:234d:60e1%5]) with mapi id 15.20.7807.026; Tue, 30 Jul 2024
 12:34:35 +0000
From: Biju Das <biju.das.jz@bp.renesas.com>
To: Pavel Machek <pavel@denx.de>
CC: "cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>, Nobuhiro
 Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>, Prabhakar Mahadev Lad
	<prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: RE: [PATCH 5.10.y-cip 12/13] rtc: isl1208: Add a delay for clearing
 alarm
Thread-Topic: [PATCH 5.10.y-cip 12/13] rtc: isl1208: Add a delay for clearing
 alarm
Thread-Index: AQHa4cz2uvIqWLVwiUaClbk89YagirIPNPYAgAAAl3A=
Date: Tue, 30 Jul 2024 12:34:35 +0000
Message-ID: 
 <TY3PR01MB11346C167A9287BF0D358340F86B02@TY3PR01MB11346.jpnprd01.prod.outlook.com>
References: <20240729153504.510443-1-biju.das.jz@bp.renesas.com>
 <20240729153504.510443-13-biju.das.jz@bp.renesas.com>
 <Zqjc7hY7eEXVDTfX@duo.ucw.cz>
In-Reply-To: <Zqjc7hY7eEXVDTfX@duo.ucw.cz>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY3PR01MB11346:EE_|TYRPR01MB12431:EE_
x-ms-office365-filtering-correlation-id: f2d437d9-9194-48f1-6383-08dcb093f8b4
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info: 
 =?us-ascii?Q?RSLsYwNZuz40FmTEjDrxtQXNIjX/wmDBXco1nrHxfRs2i/JPfPcOtSzkgSnK?=
 =?us-ascii?Q?wIon+OqY+si677VUs5PLXRLEcXD4QMltm3CjG0wHAYIWaH1ZqlA9wiuUgQaS?=
 =?us-ascii?Q?FgNIf5abYtzHun91bynZgzVs4ciWPv9jxdyE5Q0qjrs0q9M6zu6AiJdsFGty?=
 =?us-ascii?Q?/hiuTuUJVOHncpfHLZS2kRucKG30/AdC5tQjRgUBBPd+ECJQTLqcLKSmG898?=
 =?us-ascii?Q?1JzSTMZ6UCNosawhXEJgg7kwrV7ZK2A6Z8V/MUm+XNM8meoxab/AC0upxgwj?=
 =?us-ascii?Q?rlGFzWIMdXyb79E3vzzOqecDKI8n0xuh8nqJmSiV8TKn4TaZwIvauTQb25IB?=
 =?us-ascii?Q?fwxgPClXi0U1FXVlrbC2Hi8CiLDInHgTCy1wNRwQSbtc5oe5tF3OHjGRzzu5?=
 =?us-ascii?Q?8q7Ly2xL7QExXVkqKsMSNqWopiCHx0pCqd4mV4+ulatJz7ACd9pb3nxS8AZ2?=
 =?us-ascii?Q?k4qgn1cOwAQElR8Kn0eUpLMPct/Rx77HXQKcyQ6PcY0ZWbiWG3ciIYjoCFxs?=
 =?us-ascii?Q?EcxilAS0E0zwR0+rpQsUoAMdTruspXCG22oXLc0A4g8oC9I5n6zsNnwLcazT?=
 =?us-ascii?Q?/I4G1KGaTZFsNGaDyBSWEQj2eg5SL4rUfjIqnPfEjcWi+fdq7SEJDxgpTlex?=
 =?us-ascii?Q?ffJH1zw2gmrhJLcd8inCsnhOSh36j79nSqwrOCyKBFuu5lAsYGr6m2VX165Q?=
 =?us-ascii?Q?UW264ONxlnF2Y62xCi5z5C6E38saKmnAzfawCP0D8RyicnvyzuTI9x7weXhS?=
 =?us-ascii?Q?y8QIMJM/jTuWZKD6sO966AqP02vR9tsx9oJuc9nv4B3DxhVTjEzQ1Mw7eEQU?=
 =?us-ascii?Q?2MXoT5wg/8/BcRp+9MR7ZgJ2j70ROXoyFixXaBJS3B+mUFBnRilpZMs4c01j?=
 =?us-ascii?Q?Byp5vLHCMSt8h5n3b0Ow0dkk94/Poue6NsfLqI9xj3RZ+Z6wi1dn7tcMpsqg?=
 =?us-ascii?Q?4kAM5Mim43/w9p4n7AEdYGj5ZTUxtfV5Z1tKT30yHQyLjzORI2TzHyZUj76i?=
 =?us-ascii?Q?W7bJ0fMKCJUcXGtjPutcel9yiI1KTdsvEX463rRYFMK5i3si7VOHOJjC1hUL?=
 =?us-ascii?Q?9A3HSTfxE4ZrKBGZT+yE3sSCuxP8udm4+fVDozF1JPJLDLVWEU21dQwId1o8?=
 =?us-ascii?Q?u2Pt2GIYg3FPNubdRcCpXCrrIzM7+6uvdOB30nzmyAyHSL7xFFnttNqNfiaA?=
 =?us-ascii?Q?4H//THRqe8gm2JlUhBBqK4/sSeSmB+dXvPtizaXaMmU6u4vrfzW+kqkqKToD?=
 =?us-ascii?Q?RUansN+GX2WLiRKqt29Lde47vL+41+KoBH8W0f8UEpWjxNRsq423eFFXdwLs?=
 =?us-ascii?Q?bKRoHzZnssXlyBAx0X93EJoGlGkKr1aFEHrsmmpsJ1Ii8B5lQENQD3DZflbR?=
 =?us-ascii?Q?53fj1fO7cAqx6t41J6xMlvC1WYLkl1CKhkmPpGNnXHgryvthIw=3D=3D?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY3PR01MB11346.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?us-ascii?Q?iU3cEELNCXf1sXuXa56fLYdhRgBN5F6DYLV+46ysbwzAc60bBTjSPEtFOoox?=
 =?us-ascii?Q?imdZR9iKjqzXjWedpujToLAF0MXGSvFvqA6MmrHWVl16s7/F6LVoX7JWkGJu?=
 =?us-ascii?Q?ew2+KJ/vUSsjutxEOL8PZgdJ7leGg/1CJxOnv8i9MhnnPp8G6Iidk+bGr8au?=
 =?us-ascii?Q?rFSz3tNjBHXzRjatD5NdqWxDsiOsw0oNQxI6UoCSV0F35ehaRXLNQCXPYeIg?=
 =?us-ascii?Q?/HAvp0c42ixKECBEPlbY+eCxmlE5y4dk+eG3grdDK4y03gaPkC0XKCBMk92R?=
 =?us-ascii?Q?Ihg0BzrIq9EYaKDjRjbn3lPgkcxAKPx4VK/VgFRACQhV24saBI591OjPGIRw?=
 =?us-ascii?Q?z63n5knl1GfB8JVGP05wxJe5d5UtnkwZaeQ76/cJ1k8lyC0cTZXr442erpZg?=
 =?us-ascii?Q?b5N8KEW6D+ud0lcJdL57v+dQFC64Vn3wxhcIfHJjzM0MfZv5tGEshL1rzYLl?=
 =?us-ascii?Q?c7Wm6Z5tTLKR2lXlrUnxcXYJvOVwQkQbdjoHwI+h3pAXX2DZK3j8Nh+wDrM9?=
 =?us-ascii?Q?qh5sI0g23f4soiCq6nC8Z8B40sZTromL/lsF+mOstHe2ZcelpdOUfDYnXChT?=
 =?us-ascii?Q?Z0NH+rAd7iF1JKBNay0UVsmDyHdBQkbVcmXsZ65tBHOi98E965FdufC+RnzR?=
 =?us-ascii?Q?JkYX54SmXcE/v0V7wBSaTgJhpYoU39WjdwYksnPIUaAmTz/jCMxOU6b2sTo+?=
 =?us-ascii?Q?YQEbII++E/10GkwT6oWewtAKwJwzNarri615ZXk6fSS9KFSvvGyFhDWhKy5O?=
 =?us-ascii?Q?lcv95SpOtytG1dn/LLQ8WvuSYPTUCvi4E0suP3wjd30Uknrs0jcJDLQa004q?=
 =?us-ascii?Q?/ZKmWUG7EL6iY21Zk4vcv1Y4sD8DOOSTHvXyDXlgJpvVaWel/NDSefp4CdGe?=
 =?us-ascii?Q?w0+mbEFY2uTtk3ZcqccL6sxPiXIVlHIh/f++PAFOevgLC14zdJ0vteUlfWyp?=
 =?us-ascii?Q?s+jneNm3NqIsYBO8kDRR31TLPKABXwid67vw7Sw+/CDQ+Mgb6K56v+2MZlfd?=
 =?us-ascii?Q?LLkNKqjxzbzYmbsFKWsPh2bG93v0SHeF2ZFCL2Jcgc34c1loMs3tAEInK39x?=
 =?us-ascii?Q?VtlT33RCOQl59EC9ycJPHx42yzaVbjnYv6t3GOEthIopCLXHtgxO4L4c0TT3?=
 =?us-ascii?Q?LZlImUBbYcsqPHFqbGZR5TocUIMsYtRXgZgn/KG3PEbODf5y45+CQt5gpwU1?=
 =?us-ascii?Q?r4cXtG4Fnr1wKsytiJCvZaLyk0Fp9TWc2Nd2FVuScpG4UOypbZyz4fKaeLoA?=
 =?us-ascii?Q?N+7OcG1lJB734V5jtUPeqmTgw1jwVUpMDe03moTL9ZikLumlhYP2MzFB9p8d?=
 =?us-ascii?Q?TmdqJa+93US9IL7zyVOXjNKLrrnBgfBErd4wCINRIhGG7h1aWDrS15qcnhY8?=
 =?us-ascii?Q?3f86tM3x6pCIp41Zek2EYoU8cK+D0AoMkl0sIKprtG6Xom4rQteIOeHsxDyp?=
 =?us-ascii?Q?m0sXXguTE6dwxMKjSyLVotXgTMlw1XRl3lCqxvhEHM7RhBrNE5z2Pp+SnN2F?=
 =?us-ascii?Q?ZBjRkVEZH1Hqmef8a65J/Lcg7yecMI7/EsnBqzx6a07wKrpQoJqueEdbWLVY?=
 =?us-ascii?Q?Uidmh7JtFqG1Y6HtCLSstibOzvFA0cdwlKR1te+ewtNk/ERA72oSttc90sGW?=
 =?us-ascii?Q?hQ=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY3PR01MB11346.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f2d437d9-9194-48f1-6383-08dcb093f8b4
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Jul 2024 12:34:35.8990
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: sevV/eT5Fbhy56P4lH3dwPRtur44/9eBPD0Zi8+zVJB/IO47GCxYWTWNd/sq72SmJW0MWS7chQ46aqxyI+f780IlKWw4N82mYb8rp4pT79o=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYRPR01MB12431
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 30 Jul 2024 12:34:40 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/16687

Hi Pavel Machek,

Thanks for the feedback.

> -----Original Message-----
> From: Pavel Machek <pavel@denx.de>
> Sent: Tuesday, July 30, 2024 1:31 PM
> Subject: Re: [PATCH 5.10.y-cip 12/13] rtc: isl1208: Add a delay for clear=
ing alarm
>=20
> Hi!
>=20
> > commit 0dbd610c426ed695eef5d26584259d96b6250c76 upstream.
> >
> > As per the latest HW manual[1], the INT# output is pulled low after
> > the alarm is triggered. After the INT# output is pulled low, it is low
> > for at least 250ms, even if the correct action is taken to clear it.
> > It is impossible to clear ALM if it is still active. The host must
> > wait for the RTC to progress past the alarm time plus the 250ms delay
> > before clearing ALM.
>=20
> > [1]https://www.renesas.com/us/en/document/dst/raa215300-datasheet?r=3D1=
5
> > 06351
>=20
> Ok, so this is kind of interesting. Yes, Renesas hw manual documents 250m=
s delay, but is that true for
> other chips? This seems to be generic driver.

I believe so, that is the reason there is a work around in interrupt handle=
r.

>=20
> > +++ b/drivers/rtc/rtc-isl1208.c
> > @@ -7,6 +7,7 @@
> >
> >  #include <linux/bcd.h>
> >  #include <linux/clk.h>
> > +#include <linux/delay.h>
> >  #include <linux/i2c.h>
> >  #include <linux/module.h>
> >  #include <linux/of_device.h>
> > @@ -628,6 +629,18 @@ isl1208_rtc_interrupt(int irq, void *data)
> >  	struct isl1208_state *isl1208 =3D i2c_get_clientdata(client);
> >  	int handled =3D 0, sr, err;
> >
> > +	if (!isl1208->config->has_tamper) {
> > +		/*
> > +		 * The INT# output is pulled low 250ms after the alarm is
> > +		 * triggered. After the INT# output is pulled low, it is low for
> > +		 * at least 250ms, even if the correct action is taken to clear
> > +		 * it. It is impossible to clear ALM if it is still active. The
> > +		 * host must wait for the RTC to progress past the alarm time
> > +		 * plus the 250ms delay before clearing ALM.
> > +		 */
> > +		msleep(250);
> > +	}
>=20
> Plus 250 msec in interrupt handler is strange. I guess this is i2c so you=
 can sleep, but... Plus I'd
> expect it to be conditional on we having the alarm interrupt?

It should be fine as it is threaded irq.

Cheers,
Biju

