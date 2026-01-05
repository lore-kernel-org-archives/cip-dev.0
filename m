Return-Path: <prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B10F0C79F9A
	for <webhook@archiver.kernel.org>; Mon,  5 Jan 2026 14:10:51 +0000 (UTC)
Received: from TYVP286CU001.outbound.protection.outlook.com (TYVP286CU001.outbound.protection.outlook.com [52.101.125.71])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.64671.1767622249455061174
 for <cip-dev@lists.cip-project.org>;
 Mon, 05 Jan 2026 06:10:50 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@bp.renesas.com header.s=selector1 header.b=bzDTzFxX;
 spf=pass (domain: bp.renesas.com, ip: 52.101.125.71, mailfrom: prabhakar.mahadev-lad.rj@bp.renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jLLPXOEaBuBWwlkbGF6AwfNK4wASeFqzpRV3N531Qbmpq40A56UhB1cYfOhjOduBnnJt3hFs0hAllDxKiIsixPiKPGgheeWRKsXWhAQdntorRc2kFdAkaymMX8I3CZgPzKXCxoVTC71nwWFJxt4qqDEk0Gv/rwZew4uQkjwMZBcpnDfUVBxj03D1TZVCWFc+70AnDVqlc086EglQ7Qpe9PLB39eUEyz2OGFs1aVLTRA/yHuIuHG9jCd/pELe6tNbN28m5+Q/ZBwtC2ebo1l9wwX3AAzZtYYbUg2NfQCkZ64ddiTnWlyhjOXbu2ItJUxm6nPiSywEd4f7mdcr4/wiQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AwpunhIU7JsmPFlS0HTlwEjygDARJ0e/wkkIPZ0jr9w=;
 b=rLjhl1ZbRuti7sUlMmUc6wJEzMI6cUqwj/1cy3qV2AuGDckj9It9ToyGX3m6JKMjzq6MmVRcOygWoMGp9QPdosIJzmC1jlMWmGzpl1p2VHTMNxJMS5VGrWFD5+3ky9KpDTf0bg/FZtv6rg1Gej0OheDy4/e3p/+2Py508th6FWA/nMuWK4WLOt1beUO5QyFPI52b51w3jE19oyWeSFB0jdviRdB1IrnfRPBKqDqSDUfLqrd8LnowEMA0aQK+xQTwcvF5/vtH8mB7Q032NxdpX69wnQi4Ziw822ZEvIQc1tDLPW/BlI7BhCpvKVx4XeYE0xQFLWZ+ItWFeCmwKPjhhA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AwpunhIU7JsmPFlS0HTlwEjygDARJ0e/wkkIPZ0jr9w=;
 b=bzDTzFxXd1+51Q9n7fGN3J6st1lJy0qdYh0PIqeKPmlN7PFw8bTegrJxH8zHGhwb6kpdJLLezM/VTPEmLJGBSO3Rn0CzRBeN0Tm7zYubrLThK1CIeCDuAvb8+TjK+JkBKVPUCAjioq0JGXrm8TnY0Zbzm4FDWPs4pJxifSmHhgU=
Received: from OSZPR01MB7019.jpnprd01.prod.outlook.com (2603:1096:604:13c::8)
 by TYCPR01MB6717.jpnprd01.prod.outlook.com (2603:1096:400:9e::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.1; Mon, 5 Jan
 2026 14:10:45 +0000
Received: from OSZPR01MB7019.jpnprd01.prod.outlook.com
 ([fe80::8a27:ee0d:d7a4:9d10]) by OSZPR01MB7019.jpnprd01.prod.outlook.com
 ([fe80::8a27:ee0d:d7a4:9d10%2]) with mapi id 15.20.9499.001; Mon, 5 Jan 2026
 14:10:45 +0000
From: Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: Pavel Machek <pavel@nabladev.com>
CC: "cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>, Nobuhiro
 Iwamatsu <nobuhiro.iwamatsu.x90@mail.toshiba>, Biju Das
	<biju.das.jz@bp.renesas.com>
Subject: RE: [PATCH 6.12.y-cip 04/17] clk: renesas: cpg-mssr: Add module reset
 support for RZ/T2H
Thread-Topic: [PATCH 6.12.y-cip 04/17] clk: renesas: cpg-mssr: Add module
 reset support for RZ/T2H
Thread-Index: AQHcfjgD2Smj0CZ3DkCLj9O9GFHTlLVDnVwQ
Date: Mon, 5 Jan 2026 14:10:45 +0000
Message-ID: 
 <OSZPR01MB7019C155E0F339D26DC2AC56AA86A@OSZPR01MB7019.jpnprd01.prod.outlook.com>
References: <20251229223911.8663-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20251229223911.8663-5-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <aVujAQJSDn6WyORK@duo.ucw.cz>
In-Reply-To: <aVujAQJSDn6WyORK@duo.ucw.cz>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OSZPR01MB7019:EE_|TYCPR01MB6717:EE_
x-ms-office365-filtering-correlation-id: 36fc12ca-03c7-4002-569e-08de4c6437db
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|366016|1800799024|38070700021;
x-microsoft-antispam-message-info: 
 =?us-ascii?Q?ad6CCuIQ2s8XTA1xrFeZKYH28XfuRxaOgCzYLwvkyOWtVoKoWZylqsiwUvFK?=
 =?us-ascii?Q?piR0ptsVm8+GJvYPIPZcIRVRE7mOYhtuCrMs60KBIFVxfHl6qN3o8uCorr2/?=
 =?us-ascii?Q?C/hve6StkzIo2eSL2ZqwnLb47W9JPcPIfjQfe8DJleQ1rGdkgeBjoikT7uuH?=
 =?us-ascii?Q?6B8BYWtwm8174H3/O5zGJRSkJEjj7ujvsnt4CmGwZGgZmR1xXL/SNNvY9wJX?=
 =?us-ascii?Q?Hbr8NWKmIRdoYLqt6KCQPz+de1/Vp0xtipMDsThWd1DlH/smbboIV3RcP7+y?=
 =?us-ascii?Q?+dSIbfMRiDswiUDGCjQNlgXYvPLwcqDkrnGNYCjB9/81bvgMwS6D7T/13N+5?=
 =?us-ascii?Q?n7IZ1lGF4yuWd+Do+xqWBug3qCjesNpDmLD4zi+U7POBtcgYVKZZz5FD2gWf?=
 =?us-ascii?Q?1ja9Vo5iUt+SkLMIeV1o2N0J6ap+1rtTG1h9/JtGtElt/XlZysVuxvlPyVCL?=
 =?us-ascii?Q?V/G99ISSRypowL2OWB6SIxWrSuTM9K7sJzFajdlXUlKORjWgPiRGdCkE409O?=
 =?us-ascii?Q?gNuN+065xm/yZe6yjqadmg60bfJLW6nRNsF4KQ9tKK+Q/F+Wa690p5W/i3+t?=
 =?us-ascii?Q?qfbEpEIt0aXcXU/D2aDl6If3HPqIyYwMu/s3tEeNrJJ/DGRKlUrHjb+bepfu?=
 =?us-ascii?Q?3Vq6dQ3qTY4HM9p17L7pdO9+reL8Tnv8SXOHEVXulKbi2TmlzadLBmQdK1uP?=
 =?us-ascii?Q?gX/OSTtemoFsKvONB7QHwIxMz2JkSt8UO8bbIpVV18/t8Ton528Hyc7BciFz?=
 =?us-ascii?Q?qD1v+Vwqh78tXYdkK0a8LEzK1GR8GBu3RKJ/xY0nylL0ucEq1g4BE5MZT5u2?=
 =?us-ascii?Q?yk6Jr04sZkci/D95OF1OZnUwG/XpYh7ZITUNi45FGMLG1ZvPFVKU38h58Voj?=
 =?us-ascii?Q?v/nQkEoJ821JoS256psouXbtrVvGEUpxrqgsWif3c+JEBadNC7ouHtjXdtSr?=
 =?us-ascii?Q?dxt2Cp0WucYkeYTdlZ/xQFPghMR2vjNoSBNvJEvAR7ETVhS8k1EL3L96sEWX?=
 =?us-ascii?Q?ScJuG2nFrDpo9P2JkbLbZlicn0UuYX7GIWCZ5/s5nzMa+EIy+lScdMhoPuhd?=
 =?us-ascii?Q?0kxM4wZPjUG5RmcPUQ6vWNpO3qS1pVDSKlPd8fHGquHSDOkNEt9j4BBHzwpX?=
 =?us-ascii?Q?hbSPW06UejlJe+ou1P3J1f2IN8D+jS6Y1gG6MjQvQr5MFRtHBF1bMxnCGYAW?=
 =?us-ascii?Q?pFmD+qMVM40g3ZDWstRkSJWGjGt7K4glfxpOwHJkOGjyl1iinb3JFUQuU9e4?=
 =?us-ascii?Q?d4DVQMQY/OMFOA8EKGmq3Oos8Mj4PVLRrP1SYldxCmUVFijw+NuiFlAs7wTT?=
 =?us-ascii?Q?eYZxNoK+7tC5x9oP6ttHuhJSgdDRbyj8ymJKgUts3iOyT5JFA5TeaBQp0/Rw?=
 =?us-ascii?Q?I4v/Ms2EmDiA7+YRb2v0XR1otJ1GqC4gD3tcOuvKhUgPwOF4fRbCuXcyryQe?=
 =?us-ascii?Q?mDazdKpTL/9ffaPY6ewvNCZH3OTZmoej8dEn3re2MuRgjkmptiwJpMc6wkSd?=
 =?us-ascii?Q?qt2cGYADyYV3hpgJPyqBVVxnMryb1hAlAJqn?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OSZPR01MB7019.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?us-ascii?Q?Ww6CvcRVYBRF0f9y4gIkcU1/3p1s+mveW6UlAMTYXE3OnyVlcmyQt72UFhzL?=
 =?us-ascii?Q?f+oVsnFJEBMZsmBPOBUXzBFBktyDJQO8yxpNFsjWewmCH0Mo2dO6GE4ej5va?=
 =?us-ascii?Q?qjXIQTSyhWC3d2tdkYwjki0Kh9WR3/ssjNKd/ZJfZch2uIsK0OVNOtibM1T+?=
 =?us-ascii?Q?2qNkhr6MRh/gyesWUBzgKdswmsxYF5sem18sNAfTkqv2Ik71jJ0yLdYiAm6U?=
 =?us-ascii?Q?1D5hSHy7llwEb6YDim4IOPTKKu+vz+wSzFIfQ+5fO2qOGzSKrMLOG2qDa08W?=
 =?us-ascii?Q?Wbx7GQoU7ZwYz+akYq7cXMIc1WIkcde27wZF3gnrcn8cCd32QqJ4iT3yv4e4?=
 =?us-ascii?Q?EGeNOY2qQU2+VuCFcPcx7oAwAfe3dnLMMCij3qtX4KiKWljE59r2ZeO+6v52?=
 =?us-ascii?Q?5oHw/Ji46OzIRTIP32raD2hEKN8DGu1EUJurSr1T39d1ZnI4Jl0dQo/B+al3?=
 =?us-ascii?Q?YzBbKl82Famk6E837DC7I0iAYpA2Bo71xoM4Fh+ULPM/SbuLEgiihxs9DX+y?=
 =?us-ascii?Q?RIHCHaiP1eko6bTDbBJ9RaTZoKJH8jI2+J05AmbG9kOnxOQXApYcCV/ObI6l?=
 =?us-ascii?Q?NSQGNCRCTisd8qhxVq4qaXi1zOgS9gaSHNJDEgcxA4DLVkYqtAmIdaf2LkWA?=
 =?us-ascii?Q?kaF2SbmKDH+w5vdNtDz84KSk2xAK5JNgGYfoP3gRZlV5RDAXQ1rruKbaisyv?=
 =?us-ascii?Q?qveWADES1ACcfb9R/4gpspX1T22QAJ62i/CJStQBoBshZJfW/nrqDsRv10Sa?=
 =?us-ascii?Q?97qRbiwqXdeHOkXkEhnJaPP52/n5icVljmttndcQyLbo5E06bYYrhKcpeFhP?=
 =?us-ascii?Q?fvggiWzK3abbMFpFQvI2nCydLBwiTGpW4O/hyIyjknICQ9Buay2ECpZktrlf?=
 =?us-ascii?Q?xLY9c+Z12R7AcsPsrBq5K7IkBQIXqKNmV7Ml8OtmaOrfLiP2M5vFxd5+sAEA?=
 =?us-ascii?Q?rCyzqyyzt1sbzyucUmd8+1bw2g6X56Vuv1MTI5Pu7x8bYsTAADIOJt35bSCB?=
 =?us-ascii?Q?IQMIJAdbt39be8qc/et07UIwiLfujIeNbhLeOjTCe+svkXrKIvsCcCU6ZzWL?=
 =?us-ascii?Q?KhUQBCZ4+csvd1Gaq1lNxjyEKx/c7LNYkg19mbI5XCEJY05Egrs/YRG7LYjN?=
 =?us-ascii?Q?E8S717ecXBF1m6kV54Tlngx/fw1s5StdyRKo/4vQKYIhvw9UNbmUR/yA3Z2W?=
 =?us-ascii?Q?xXyHxEZHbN3U56nz1fyqaExqhD6bPGn+vRTCfVGEcig3wO4EoxOX47ybC6HD?=
 =?us-ascii?Q?JW0j2ISejBDybMWc/eC/x1c/a51pCDSMJjqqJsX+ujPVX1i23YhEqcP3G7my?=
 =?us-ascii?Q?XK86/3lykfwRwTm+2W4ppEHo71S0hUvnRAFh8nJjLa6JW3sKJiuR7U679QjJ?=
 =?us-ascii?Q?U6Vwg6K2jL50tHGhRgCEwPU5SuUCR/2NVPANWVBmLPn2th/65sK48A/y6sgb?=
 =?us-ascii?Q?xJJ0UEPTrMR2nGbvu2vSkwELLKl8RQebx8Jg5TE5fYdukBniBkmdRY1Uu4IH?=
 =?us-ascii?Q?/ywYqcwYWIxsiV9cx6oHYFdOyuuDw3p8vSh+RiHnsW3vnbGJnRSN3dK/aG31?=
 =?us-ascii?Q?1zHHXlAi4mxto1u8YwNki1JwN7k6uIVP2Qc67g0xC/uMl2MWrpgO08iBkXIV?=
 =?us-ascii?Q?/GHcCgxtvG5YcgPvIRZqjuai+WIN6fTfpPuwjiS6tAfV53M/b34ulA+a7/sT?=
 =?us-ascii?Q?IXgQcBoaywR6nGLP7xD2f2f+Q9udFdwODrcWJuSQR4oI3XHC/k+jmhj8FpEy?=
 =?us-ascii?Q?Qs/DYoNXPxB0iLrZBDgRVaMm/lC/nfFmrgLFHGDLmoWAMo05yzYd?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OSZPR01MB7019.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 36fc12ca-03c7-4002-569e-08de4c6437db
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Jan 2026 14:10:45.0700
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: nrR+InhiSFL8OrEC4bSWMUXCKwVowJMckQIjpLhl4NWLt/yoqWQTjk5aSAuhqxgVJhXogpl2N+BasJJIyJmHANGjmzZWWzaVACHsQd0pIBMhPzuYEamp6JwYYxD6Kq6Y
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCPR01MB6717
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 05 Jan 2026 14:10:51 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/21314

Hi Pavel,

Thank you for the review.

> Subject: Re: [PATCH 6.12.y-cip 04/17] clk: renesas: cpg-mssr: Add module
> reset support for RZ/T2H
>=20
> Hi!
>=20
> There's a cleanup possible, see below.
>=20
> > commit 3b37979dcbef0dc3fc1aaba75b21ff9a21799055 upstream.
> >
> > Add support for module reset handling on the RZ/T2H SoC. Unlike
> > earlier CPG/MSSR variants, RZ/T2H uses a unified set of Module Reset
> > Control Registers (MRCR) where both reset and deassert actions are
> > done via read-modify-write (RMW) to the same register.
>=20
> > diff --git a/drivers/clk/renesas/renesas-cpg-mssr.c
> > b/drivers/clk/renesas/renesas-cpg-mssr.c
> > index 9ea544d00634b..4d2d945b3f5e2 100644
> > --- a/drivers/clk/renesas/renesas-cpg-mssr.c
> > +++ b/drivers/clk/renesas/renesas-cpg-mssr.c
> > +	/*
> > +	 * For secure processing after release from a module reset, one must
> > +	 * perform multiple dummy reads of the same register.
> > +	 */
> > +	for (i =3D 0; !set && i < RZT2H_RESET_REG_READ_COUNT; i++)
> > +		readl(reg_addr);
> > +
> > +	/* Verify the operation */
> > +	val =3D readl(reg_addr);
> > +	if (set =3D=3D !(bitmask & val)) {
> > +		dev_err(priv->dev, "Reset register %u%02u operation failed\n",
> reg, bit);
> > +		spin_unlock_irqrestore(&priv->pub.rmw_lock, flags);
> > +		return -EIO;
> > +	}
> > +
> > +	spin_unlock_irqrestore(&priv->pub.rmw_lock, flags);
>=20
> "(set =3D=3D !(bitmask & val))" is only using local variables, so does no=
t
> need spinlock protection AFAICT.
>=20
> And dev_err really should not be run under spinlock.
>=20
> So I believe spin_unlock...() can be simply moved before the if() for tin=
y
> bit faster and cleaner code.
>=20
Agreed, I've now posted a patch [0] with this improvement.

[0] https://lore.kernel.org/all/20260105140625.2590685-1-prabhakar.mahadev-=
lad.rj@bp.renesas.com/


Cheers,
Prabhakar


