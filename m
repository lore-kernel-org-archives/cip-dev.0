Return-Path: <biju.das.jz@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF7B7105F7AC
	for <webhook@archiver.kernel.org>; Fri, 13 Mar 2026 13:22:52 +0000 (UTC)
Received: from TYVP286CU001.outbound.protection.outlook.com (TYVP286CU001.outbound.protection.outlook.com [52.101.125.67])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.15662.1773408160070704075
 for <cip-dev@lists.cip-project.org>;
 Fri, 13 Mar 2026 06:22:41 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@bp.renesas.com header.s=selector1 header.b=Vf90Bz+l;
 spf=pass (domain: bp.renesas.com, ip: 52.101.125.67, mailfrom: biju.das.jz@bp.renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aCcCzwplfuQUHfvLhZTGbmfhNsvjVU2DlQeGoJkXwf1jKVwjSQk2P8mo5iwMSrGUbW/V3r+lwBoCsdPzJVnu8XTlrXu+BfKFw0oBEFPHSn+00paqWcWD12I7lqB/yvRTlIayXZ93P0T44iBharckbbNdNBkrysNRs8D/D22Q1tMljJjiVmQl8BLTYUwK7qSifNgZzQlEoFB5iWcSw/fHEmiC5mMKZMu3s6N+8S2Bb7dwrv7Aj01n05NXnD+Iircx2Zoo6d/DiCDugCl9L4qDzKL8WHCNSwmDjuDBTcSbEXiOTiY6Mv+KemTwU04oluJZGARWyfH5SunKqNHh+myOCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dVWKj9+najaM5bgW5jr3Qpm+cnMjuRSK8eC1YAdpGyY=;
 b=kkcfdBncVcvKAVYIuBbjcMyi6rEoAz0FLCroSfR3yH6DFg2lGaS/tLlwczIRv+gWMhv7QJywkkyAXax5QgYh1zcBPKVwyEfP8xxzP90QKhh+XoB3EW2kk+E6CjJtlHgfTu8F3VvgEN5G/Vn6dvOPgXeHMRu3vBZg59pOKOZdnlFgHNFIZK5Jkd/5bz4LSRkmVT/0mg7ch177dNOnehR/j2tYvobsSok/ZLdxuVomZpQohTA1O/8reOTb3lCKZd2piHKtt1GjewCRO8tfdGYfnkGWCDDdFPnk5fiY96Ns3fYpoh1l4aELbJhDCQkpPRFJx5EfcU6WZDCYw+RsSs5b5Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dVWKj9+najaM5bgW5jr3Qpm+cnMjuRSK8eC1YAdpGyY=;
 b=Vf90Bz+lt7frzIYwwtXsZL3lZzQzwz0jOv+2GPrmu2NGe8APB/NR60VPSa+8p7ZYqaD26L8GUjfNmQdCSPjsojdIIAtNinbGQe2uO8Mjt15Rt0MYl3aXXjKTV+rNi4UENKyDyGUEa6QCzZq66DikKGvtd3Fp4/PJnbPLPhSUlR8=
Received: from TY3PR01MB11346.jpnprd01.prod.outlook.com (2603:1096:400:3d0::7)
 by TYRPR01MB13979.jpnprd01.prod.outlook.com (2603:1096:405:21a::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.16; Fri, 13 Mar
 2026 13:22:24 +0000
Received: from TY3PR01MB11346.jpnprd01.prod.outlook.com
 ([fe80::87d1:4928:d55:97de]) by TY3PR01MB11346.jpnprd01.prod.outlook.com
 ([fe80::87d1:4928:d55:97de%4]) with mapi id 15.20.9700.015; Fri, 13 Mar 2026
 13:22:29 +0000
From: Biju Das <biju.das.jz@bp.renesas.com>
To: Pavel Machek <pavel@nabladev.com>, biju.das.au <biju.das.au@gmail.com>
CC: "cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>, Nobuhiro
 Iwamatsu <nobuhiro.iwamatsu.x90@mail.toshiba>, Prabhakar Mahadev Lad
	<prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: RE: [PATCH 6.12.y-cip v2 24/27] serial: sh-sci: Add support for
 RZ/G3E RSCI
Thread-Topic: [PATCH 6.12.y-cip v2 24/27] serial: sh-sci: Add support for
 RZ/G3E RSCI
Thread-Index: AQHcsT6Tw3rbpklbTUGXh9kctJR/17WsSN6AgAAtCSA=
Date: Fri, 13 Mar 2026 13:22:29 +0000
Message-ID: 
 <TY3PR01MB11346D1BBB7A9B415E5407BC58645A@TY3PR01MB11346.jpnprd01.prod.outlook.com>
References: <20260311100458.162447-1-biju.das.jz@bp.renesas.com>
 <20260311100458.162447-25-biju.das.jz@bp.renesas.com>
 <abPpZULsXhRmXTX9@duo.ucw.cz>
In-Reply-To: <abPpZULsXhRmXTX9@duo.ucw.cz>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY3PR01MB11346:EE_|TYRPR01MB13979:EE_
x-ms-office365-filtering-correlation-id: c04827e2-e9e0-4645-8b1c-08de810393b3
x-ld-processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: 
 BCL:0;ARA:13230040|366016|376014|1800799024|18002099003|22082099003|56012099003|38070700021;
x-microsoft-antispam-message-info: 
 eocOb8eAUv248idk3ORTqbi2qTRDsWHpNhjOlvYWWCJnxjQZePx/l/d87Kw01oQ1UwSsdOZT8aPWLBPmz/S8gKD3JDy7b6QkjN5kTpTpbeCkH0LtXECFOSy4Wccjyy4nOK+jhX1gUwAgMyuybWwf5mr/TEhH8F7Cs3NAlSB46czVRuNyy/Sw5guyw8pcTatPhhQNq49EVe5zzFSOzS56O8AuJZkIHohGkY9oYydNl9wPcBfF4oNbv4ihm4ClyeDxZ1i80aXx0sURK/vHQBqrgrKfc/gt/DgyFys3IPgZAd/CRauQgviOW3pJbTW9FUuZT0HYHqSlhHeJ/WAuJwM+n4JubEFj/FviB2xhZXAs+tq8LkcbqzWjqMDkdqXXy4rxIJTQFnHq1W9lWkIUgmpXbATQMI48SxG+fM4mG5u6mXfwWHQ2V4BLxzmSAzxZ60/E4NQr0toqCX9Q5JLBAMX2J6QPqsTL3MSNpjun3RXR7KQZUxNsNdF1qaSA1Q2+ZYlJ1Iwnk0aLzpzpeDTgw6UICZmdi2qHlgxo+qZNAoh8CIz+xCHPQn37imMxoRW57ZLuYcROR7iEO7kdSAjsSQ7SAMqkvog77lqMJ790EmDkWZQkAYdcej6cGvhs8SqIQcjd/gGA92HNySHBTShwgRegEIGxbl6dTRPdgP+5mzXZEZlaKKPSy/SOTMXitGZVClw6pAq0QBz0vWMnVpczRmBubitISck4v/YWMlZRY8Pda6PmfZ7JNu5Kk0XbH0CaL5rteZyTS1jfB2m/+eWt5vahUPHaoBiZ95DxGlZwRDM+gxc=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY3PR01MB11346.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(18002099003)(22082099003)(56012099003)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?us-ascii?Q?mFbA54neVwlQWmNVnG+8R3mKW7CRz64Mjm/R679/+cMjfrBr3OKRESMidw9m?=
 =?us-ascii?Q?u9UZ2WQpThUefL3qiI58hsKC4JKI3ZJo90otDkZVlSQ1d7tL9SVdRu3w4FUl?=
 =?us-ascii?Q?AvdQh0+U9sgtdYdwu9kSrjMSu0vidnJzcKLQIR7grt5rxWuxSg6y22Gy0FkP?=
 =?us-ascii?Q?iu8PyrgndxBDOL2Ygw+KwdBkD3JiLXXn/p7TS0jyWEBy2V2wfinFDZJ+M3fU?=
 =?us-ascii?Q?h9joRMBQZlv6yY8ZJUFZYVjqIgOvV120V2jtgQx9M4tcA2iWZSgIAyYNWa4V?=
 =?us-ascii?Q?7lNLVdLgLbeanl5rKXBIXGKbPBaw4cLFk0+ngPZFPzSmq7zIJtkY5fMbkR7S?=
 =?us-ascii?Q?azlcY8gz/62Of7Ja+9PUj/TDj/CnV54MNQmiX0vGUiKtLfrwJRT9gWPonhQR?=
 =?us-ascii?Q?hBZb2t/onqj6gW6VjRDYb0i2eeApg4Og5/Obm7lit+GM/uB8AT5P8cfNF7ZV?=
 =?us-ascii?Q?IkP3CiJYxd1IwUko1sHuLqhMRwBFLAiKdxxwuKbFE2jRIzByb8LNdA8zVkmJ?=
 =?us-ascii?Q?yRrbRyiVawq5JJAXnU4ojyVsLkC7gxlrtghwNMrsJ/HRVckqG2PpFUPCPyNb?=
 =?us-ascii?Q?pYeH9i8othuE/w25F4uYnn1+GmWuQinobE2o4H2UX1ZIU/5yoFdaeVADJp6b?=
 =?us-ascii?Q?JEhy4WSho+02YaFPxUhYQ8ms+a0xvxNmytXGaU/YLWid0g8RVw4CVNV6pMju?=
 =?us-ascii?Q?gOHi/5hyHPYSbx4aXJ9oy1yCy2WzjIL9ijQhStHRIiiNzadckEDQyeo/GHcj?=
 =?us-ascii?Q?QbcamskVbgBXOBJ0rQTtEzMgetFkB9oQ8UqwEInmw+2HrePvjNbfN2phZtnY?=
 =?us-ascii?Q?NP8RVV4UPkflxyZWSSRTLRNz8ka0wSW00jisUvL8Mdpq+7OojP/dqg+l2teH?=
 =?us-ascii?Q?d3hStAPYdXZzriEqoXz1B+hjQ0hXvR5IkM3f1MupQRJiVgCEQ9/ASo3ZgmpH?=
 =?us-ascii?Q?k/z2qSSWEKbeyf+IqpIPznn89T0pXRfaoGrSj+V3MuBKBVVTFpR1tEAvyYyb?=
 =?us-ascii?Q?breYljiuPCf44woJ5rrxRpRAhZVGanaSAw5PN6dNBToj5i6jPSMM8FF1dNyM?=
 =?us-ascii?Q?sCzhRRqHASobbG1ds/BLmTlF6uga2i//jXXrrqo7dfP2Q+8fyWlj6uQuqscV?=
 =?us-ascii?Q?qYS8zjQkQkffGfuul5503PRySRJjKkQRTF9Jr0FDUL0+3ao5WsVd+lbropvM?=
 =?us-ascii?Q?luLsfYq97A91epccqwSU/FnvmB+r6hx1Ku2/o6XwDBJ0ngmRf+L83VUBk6CG?=
 =?us-ascii?Q?Be0bGFCb2zNmj6RYmXjo9aYgaIPQsHkLcq1kgc5ARr9FhBWVbXsSyJO/8Z8D?=
 =?us-ascii?Q?0SP0cMxzjre7FalcPTjuR7VuR5htlKiADfowAoB4YEVVMyRjr346dlE1OVT8?=
 =?us-ascii?Q?ZRD7O7LVjT68s+xmtIdWc4J/IvssV8WWrOqnaeV3F8Amk4nl/7NjrAXeSm5H?=
 =?us-ascii?Q?fZPnI+vZDuG/W7OpdDjWuULmJWPWhMd23MNWLOAk1OWNYEqULnHulDCP6IXP?=
 =?us-ascii?Q?e+qiBOQ4ohDvGN7/AgsIglhOvbjn3C5CxyH4MrlOO/hYK88TY0BvpxsBVygz?=
 =?us-ascii?Q?ymafBjgku3tXOISWaZxImlcy3M/uIbPawbQKHyyBofBtbnKg1bE6c+cWQd6b?=
 =?us-ascii?Q?dyzmIZ1zMM/WFL8eas5NJ5oia3lPHmwVuZsBi8PFeTRbGYwd9bpcEVeaLuD3?=
 =?us-ascii?Q?YsNYRWah3xIEZMLk6NmYiNb4x+Fj9FswkVg0Wwiug9EZ1Vh11OwhTGb/tOMA?=
 =?us-ascii?Q?BMM2OdKStA=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY3PR01MB11346.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c04827e2-e9e0-4645-8b1c-08de810393b3
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Mar 2026 13:22:29.5722
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: K+SqQXoIpViQsjVGXIoQwkCpEfzJ8eliq9AJVpAEgGW3bDrhLXmwpzJbdUBQoEjCyEbLo4pW8SioDcc/KMmAdSs6Ygr17jnGjxj9ZBNgO1Q=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYRPR01MB13979
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 13 Mar 2026 13:22:52 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/22374

Hi Pavel,

Thanks for the feedback.

> -----Original Message-----
> From: Pavel Machek <pavel@nabladev.com>
> Sent: 13 March 2026 10:40
> Subject: Re: [PATCH 6.12.y-cip v2 24/27] serial: sh-sci: Add support for =
RZ/G3E RSCI
>=20
> Hi!
>=20
> > Add support for RZ/G3E RSCI. RSCI IP found on the RZ/G3E SoC is
> > similar to RZ/T2H, but it has a 32-stage FIFO. It has 6 clocks(5
> > module clocks
> > + 1 external clock) instead of 3 clocks(2 module clocks + 1 external
> > clock) on T2H, has 6 irqs compared to 4 on RZ/T2H and has multiple rese=
ts.
> > Add support for the hardware flow control.
>=20
>=20
> > +	baud =3D uart_get_baud_rate(port, termios, old, 0, max_freq);
> > +	if (!baud)
> > +		goto done;
> > +
> > +	/* Divided Functional Clock using standard Bit Rate Register */
> > +	err =3D sci_scbrr_calc(s, baud, &brr1, &srr1, &cks1);
> > +	if (abs(err) < abs(min_err)) {
> > +		best_clk =3D SCI_FCK;
> > +		ccr0_val =3D 0;
> > +		min_err =3D err;
> > +		brr =3D brr1;
> > +		cks =3D cks1;
> > +	}
> > +
> > +done:
> > +	if (best_clk >=3D 0)
>=20
> I'm not sure if "done" is best label here, and probably avoiding the goto=
 would be best.

I agree. I will send a patch to avoid goto in mainline.

Cheers,
Biju

