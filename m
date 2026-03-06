Return-Path: <cosmin-gabriel.tanislav.xa@renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91D3AFCC075
	for <webhook@archiver.kernel.org>; Fri,  6 Mar 2026 20:44:19 +0000 (UTC)
Received: from TY3P286CU002.outbound.protection.outlook.com (TY3P286CU002.outbound.protection.outlook.com [52.101.229.27])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.4349.1772829855150570274
 for <cip-dev@lists.cip-project.org>;
 Fri, 06 Mar 2026 12:44:16 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@renesas.com header.s=selector1 header.b=SkQtJ8FG;
 spf=pass (domain: renesas.com, ip: 52.101.229.27, mailfrom: cosmin-gabriel.tanislav.xa@renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OOgwXpHjGbyM3D6BggSS7ljS9Kkli1ZBydQ/SkPHnfG+l4Sf9b3uIBfQItrVmd+WbLdQyIicONobv06kVjlApg8Y0IH6SrbaPNjvY9g1UyOZgHOKHLlvcN0kB0EVORrAx/pqSp1Tguhfeco7J/VRWAwtIVQmXkqErvc5OuVeEN3mmqD5yVbZznV1eBzUL0KFLxXwMlILa4KNPgjUWQ1Rggkp6MKXhSTeDJDazuUzE3k2sG8YgvKdpJdL0Gd/g6Qq2DErOWgxTVcIVFwRhYNFRVW5nIKuDmntN7oJ8QzQscQxDl9FkQlt7n8nZF+HenRpESMcC0kKNQHkTvS6eVP0Nw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=y157ECwwIfFNjtlBOvfJ5dml/4l1C2toOCsmgTeMzTU=;
 b=lxhIm6SM/6BO9FncM5OLx8S+8m9b6r1iT0yprdcWbCENEL+Nbh28r3fJn/25L5azN5UtS+XkVHWXoLF5wmZN5xj/rA1J5AnD4HqF+ChIj36RTlvYBAkG1Q+QVqKbWEJD6Y0i6v55abStdJQMON3tAIOxqDiy/NshI2gQ6lRA1Zt3P7ZS5Gq/GaGZSvJoIDcXxtha6L2AYOm8tJUwdrqPmxCcgtCCQbJIFujgiD++yNRyQVmiq4Ele12K//mTyUATkaHw4eLLIClUTeeo7iHTnjAFFoThsfK4k9/lAwTpdPPQtxtM8cplGKcVV5gKd0rGfP1WUvBTs0MBc2Q4gT/9Sw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=y157ECwwIfFNjtlBOvfJ5dml/4l1C2toOCsmgTeMzTU=;
 b=SkQtJ8FGzoS2llRdZxqhmJRmzeRPMFG3xtEi4NLjI/e68HFzAld1vHghW1tgs+ai6t/gVeNWCjM6jcMqjhxzPAyH4TQ9B1ZBWqQKjhL4lGCqQlTEHOi8UHjvlHcwH9sIiDcGi4gNPmqyS9ve4ylu510oLTF5DbKE53OWNF0sDE4=
Received: from TYRPR01MB15619.jpnprd01.prod.outlook.com
 (2603:1096:405:29b::10) by TYRPR01MB15823.jpnprd01.prod.outlook.com
 (2603:1096:405:2cb::5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9678.20; Fri, 6 Mar
 2026 20:44:10 +0000
Received: from TYRPR01MB15619.jpnprd01.prod.outlook.com
 ([fe80::a68f:5c9:9de8:4fa4]) by TYRPR01MB15619.jpnprd01.prod.outlook.com
 ([fe80::a68f:5c9:9de8:4fa4%5]) with mapi id 15.20.9678.017; Fri, 6 Mar 2026
 20:44:09 +0000
From: Cosmin-Gabriel Tanislav <cosmin-gabriel.tanislav.xa@renesas.com>
To: Cosmin-Gabriel Tanislav <cosmin-gabriel.tanislav.xa@renesas.com>,
	"cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>,
	"pavel@nabladev.com" <pavel@nabladev.com>,
	"nobuhiro.iwamatsu.x90@mail.toshiba" <nobuhiro.iwamatsu.x90@mail.toshiba>
Subject: RE: [cip-dev] [PATCH 6.12.y-cip 00/17] Add RSPI support for RZ/T2H
 and RZ/N2H
Thread-Topic: [cip-dev] [PATCH 6.12.y-cip 00/17] Add RSPI support for RZ/T2H
 and RZ/N2H
Thread-Index: AQHcrYq0SPyPaqomcEmiM2IminkmbbWhu8GwgAA8LsA=
Date: Fri, 6 Mar 2026 20:44:09 +0000
Message-ID: 
 <TYRPR01MB15619E9C77E34DCA26D435F27857AA@TYRPR01MB15619.jpnprd01.prod.outlook.com>
References: <189A4F21D47A489D.1967085@lists.cip-project.org>
 <189A4F82C44CF084.971272@lists.cip-project.org>
In-Reply-To: <189A4F82C44CF084.971272@lists.cip-project.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYRPR01MB15619:EE_|TYRPR01MB15823:EE_
x-ms-office365-filtering-correlation-id: 3ce34859-e620-49ac-0d57-08de7bc11e3b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: 
 BCL:0;ARA:13230040|376014|1800799024|366016|38070700021|7053199007;
x-microsoft-antispam-message-info: 
 JL9TIuBTcVwckkhR5ZJ3ukxyDF0ed7HWbEITOiasaNIbBdM/Yt5OLXA1IWgMaoPcXgH+UY0wScxAQh3eBfbAk7SyCMscRyB3P3RjvlFoL6ybwc0edHXrYitbN2a3npMLjfQdQswl1iPEqR2X6HkwkRaUWbI4b8ffpizgq/2o4/Smdy35YFBA4KU0bpgq8f0gTRrrDQqxNavELRyvzwHV8Z7bjZa99zASsmtJ0SlbjcoUsBcESzPb82h/a++/o4RoOKjsmyLkduhjHhmfzHmUX9aV6EeJrmAy7DMj9cPy08NbjdxiAQzdh+MpEB+reYA+Tf1CbogyHSplBeAaAFW2KJj9uzTC8pG4rPTBga2r/MkpHWpdJ8NxDN/9iQrx79k9xfp/9M9IsCs/2E7vaGDjvMOPh72LhCOqyC/GpOd3sSPjl1WgjcKDWFrgOsNZGzbMfFrM49ScA3DCi7oBSVuwS+XNuMDhFhNDwH2UMKS6QhsOBqGKkLb5F6oR0URXiRB7finPfqTocLFJzKERv/6lwz/kqYETZUNuIpGFlal6fXqFXxJTVeS1y6tXYuczyXEE/4INMtI7MuSSaCQpELizCDAxksKZ6v+5DAN5poZ3+1kzNvJakN2ydBbfkeidAtgyDO/o3J0SjKe6Rw7sXv0JZ0mozn0HTnqipApol+p4fa+8dWHM+mAZyGWND10qBmDi82Cj7u/gJ6GxGP6cyXXOpjDFm6e+RHNpQVZSxDQ+ZuthWOt+x3KXlyUDHBVzNL23KDrwMOgoCjrh+WY0rEcmrGBxHS7g9Ddz1BaYh8OXyBw=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYRPR01MB15619.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(38070700021)(7053199007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?us-ascii?Q?E/UFwX/7yljLJDeSI57IE2Wgn1h8PUhJhVPZVRfWQGkFlYJMVKwaph/5/QD1?=
 =?us-ascii?Q?Ky2CTeDCKk0Zd4ITD5WrshRkokG4jm7NACJ6RsHZ7pZ3CNowu5sXQ+t3nu4r?=
 =?us-ascii?Q?S6F0K5+gdBJ97PAkvtBNb0FCTjzLZJ52Lpbd3QNQLBegYEVX9nHQb4OfvQak?=
 =?us-ascii?Q?McTDwZHFohVcGdRFwELhPer3FXdhR9aSvbn2DVqX39a1HK3rzid/U7QgqXKH?=
 =?us-ascii?Q?98kl8C3EpYC2iqJqtTc+wOqmXoSdCLmNciOxVScMjxvObL5WHPKxqgMRj1gy?=
 =?us-ascii?Q?5jHYoNbIyYXKPkhojzNwWdu5EfsrKVLJ/mEIhYqsW+7/wlo1ut+HeI8USsYS?=
 =?us-ascii?Q?RU5zl6andC9EU4sS1NNRmxiggRSfSOu2qIBdv7CTSv2o826XaXcA4ZDtl0xB?=
 =?us-ascii?Q?lH5aK/KG3nD9wY9vvCSii7JCu2T+4DVS5kBHQKnyPne2QKJKiF8VcPM1Nj3D?=
 =?us-ascii?Q?VurQrtD9NNBH7Nisod8PZbeckQBBfXKNb6lhnsJml4iX2Eg9S+v3U8lZnUCw?=
 =?us-ascii?Q?zOWo7ZrAty0To1zt6Ekwve/+wmwRFwXd00iRouxnUu1LwSz2+W6mgYZQyQMV?=
 =?us-ascii?Q?tmGR2YEKP7e4p/YtlQN9LSho64VwifvY8sKyngh9kmfpB+UhvzaUYcR2k4mA?=
 =?us-ascii?Q?CFYu3KJOkicCerob/k5r8bhCSvC/QdeXt28/eMr3PRyke+ZUdMA+Gd9gFsv1?=
 =?us-ascii?Q?y6Rvnd5k4ogJ7EqChbtkOIp3sNUX5fam72kmiG9iDDnPkzs0UE0RvFA1jVvS?=
 =?us-ascii?Q?4p0ZvwpXMs8qe3ZaTzeTO/PLMwMrq52qsXtOmlQVWB4nrPU9B80o+88S7Ygf?=
 =?us-ascii?Q?HspyZLYoAFab2ZF++fgMi8O7vzRaK9pr6daLaFcjeZVTgNKV+1gClgUI3GFs?=
 =?us-ascii?Q?07T34+wAQelmFvOohEEZwvVdhOPSEqg83cO9cEKhc8E3PiBRlB6LZN39TSpa?=
 =?us-ascii?Q?1gpgqZF7ysozni8jaBxMfJQPnzwDPJ5nFY9UelZkagQRA1BO4MSWet3tX2kW?=
 =?us-ascii?Q?raBeiKTv0P4hwJZAso642Zm1DillNwIXaIDTJOfgPZE0liT8AY5rOMpz5jhv?=
 =?us-ascii?Q?EF2uXWaRLN11cLsXNBiWZ78IiLrPN/S68wuA0O1hIp/FCCMi1nr+5uQQQ6Im?=
 =?us-ascii?Q?MJhfrDCOrnie71Ec20HB3cAoUcDVCF5IqH5TZRJvmDZPmO0+ui42HLh+K4Xs?=
 =?us-ascii?Q?itQW3GHH9C2wDDrW4LdqVmRfDU/CnCTJFkfGMxIVPpIRdJViSZG9HJizGugn?=
 =?us-ascii?Q?HTRLOpl9C9pd3FkOXlp4L0xdeH3P4D7Q6EDTaSL13BwjvFyUpEEK+XQ2yvpd?=
 =?us-ascii?Q?dHemI3Pj1Aw6FhUCCsg7+yqDD7ejlxY5Y/e9fvqMZWWeH9DpRIa/BcRX1WG9?=
 =?us-ascii?Q?hRaOBD6x1v3uL9ddNA7LmtSGddgn1xBFjiyWSuVt0/EHGuCShSowjZVycD35?=
 =?us-ascii?Q?YsH/fCs9O4gLlHEXV5GBfaR7MrHVhr8VucJvCo49t+QSIZr0WlK4I2sv7sk9?=
 =?us-ascii?Q?F+GIIh0rYDKyTDkpyZzynFR1m/STLNt/s5d9oXJBVKIICAgVeTybDy+ZTgWA?=
 =?us-ascii?Q?HAOzX95DUFU9NoKSvuC62lAucaA1+T6Z/FgsaenaDF6UsIG+cH3soBQBxJ+x?=
 =?us-ascii?Q?9ATug8+Fve785Z6vsvTjyvQ7N4uvMmt+dg/h9KZCvjAfLsOEVdQXUpEL2bIB?=
 =?us-ascii?Q?E8XV0W50k8RoQrVFqUlPmbaq5YULUn4V4GIphMEyJAnTywpG3BIiAnUdhHAP?=
 =?us-ascii?Q?FCxpLn7sbpbKXF9fEmEZuuThgRdjye1f61YXwTZerkHRGru+UzzS?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYRPR01MB15619.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3ce34859-e620-49ac-0d57-08de7bc11e3b
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Mar 2026 20:44:09.9259
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 43Oe0y5qUH/qvjOrY/P3WDBop0icT1Z5gYvN1snK1x7zQJ+LHeA60bqPlA+sVns4zbvLtvvNn8KGELcgz4ATw54Y4xBWin560c/g/3LzM1qNf3nIb5EPP9gLJIufyIT4
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYRPR01MB15823
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 06 Mar 2026 20:44:19 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/22144

> From: cip-dev@lists.cip-project.org <cip-dev@lists.cip-project.org> On Be=
half Of Cosmin Tanislav via
> lists.cip-project.org
> Sent: Friday, March 6, 2026 7:07 PM
>
> Please disregard this series.
>
> I forgot internal Reviewed-by tags on the patches.
>
> I will send V2 without them.
>
> > From: cip-dev@lists.cip-project.org <cip-dev@lists.cip-project.org> On =
Behalf Of Cosmin Tanislav via
> > lists.cip-project.org
> > Sent: Friday, March 6, 2026 6:59 PM
> >
> > This series adds RSPI support for the Renesas RZ/T2H (R9A09G077) and
> > RZ/N2H (R9A09G087) SoCs.
> >
> > RZ/T2H and RZ/N2H support is implemented as part of the RZ/V2H RSPI
> > driver, and, as such, the RZ/V2H RSPI driver had to be backported.
> >
> > Patches were cherry-picked from upstream kernel.
> >
> > This series applies on top of my previously submitted series [1] (to
> > avoid a conflict in drivers/clk/renesas/r9a09g077-cpg.c mainly).
> >

It has been brought to my attention that even trivial conflict resolution
should be mentioned in the commit message, as they deviate from the
original patch. This is the case for patches 04/17, 16/17, 17/17, where
context was different because other commits have not been backported yet,
and manual intervention was needed to resolve the conflicts.

I will send a V3 next week adding those details in the commit messages.

> > [1]:
> >
> https://patchwork.kernel.org/project/cip
> &data=3D05%7C02%7Ccosmin-
> gabriel.tanislav.xa%40renesas.com%7C663a662433b2499430de08de7ba2d29b%7C53=
d82571da1947e49cb4625a166a4a2
> a%7C0%7C0%7C639084136409764188%7CUnknown%7CTWFpbGZsb3d8eyJFbXB0eU1hcGkiOn=
RydWUsIlYiOiIwLjAuMDAwMCIsIlA
> iOiJXaW4zMiIsIkFOIjoiTWFpbCIsIldUIjoyfQ%3D%3D%7C0%7C%7C%7C&sdata=3Dd8ZhHR=
YjrF87gYDwhxPXK0Pqy3GHT7MGz3frs
> ammwP0%3D&reserved=3D0
> > -dev%2Fcover%2F20260303165351.914437-1-cosmin-
> > gabriel.tanislav.xa%40renesas.com%2F&data=3D05%7C02%7Ccosmin-
> >
> gabriel.tanislav.xa%40renesas.com%7C6f945845bba64a25ade008de7ba1d46e%7C53=
d82571da1947e49cb4625a166a4a2
> >
> a%7C0%7C0%7C639084132155199464%7CUnknown%7CTWFpbGZsb3d8eyJFbXB0eU1hcGkiOn=
RydWUsIlYiOiIwLjAuMDAwMCIsIlA
> >
> iOiJXaW4zMiIsIkFOIjoiTWFpbCIsIldUIjoyfQ%3D%3D%7C0%7C%7C%7C&sdata=3DrtUD1q=
73VhE%2FdD%2B1XBvLJaYzI2MoNIG%2
> > FQLdoJK4JUZU%3D&reserved=3D0
> >
> > Cosmin Tanislav (14):
> >   clk: renesas: r9a09g077: Add SPI module clocks
> >   spi: rzv2h-rspi: make resets optional
> >   spi: rzv2h-rspi: make FIFO size chip-specific
> >   spi: rzv2h-rspi: make clocks chip-specific
> >   spi: rzv2h-rspi: move register writes out of rzv2h_rspi_setup_clock()
> >   spi: rzv2h-rspi: avoid recomputing transfer frequency
> >   spi: rzv2h-rspi: make transfer clock rate finding chip-specific
> >   spi: rzv2h-rspi: add support for using PCLK for transfer clock
> >   spi: rzv2h-rspi: add support for variable transfer clock
> >   spi: rzv2h-rspi: add support for loopback mode
> >   spi: rzv2h-rspi: add support for RZ/T2H and RZ/N2H
> >   spi: dt-bindings: renesas,rzv2h-rspi: document RZ/T2H and RZ/N2H
> >   arm64: dts: renesas: r9a09g077: Add SPI nodes
> >   arm64: dts: renesas: r9a09g087: Add SPI nodes
> >
> > Fabrizio Castro (3):
> >   spi: dt-bindings: Document the RZ/V2H(P) RSPI
> >   spi: Add driver for the RZ/V2H(P) RSPI IP
> >   arm64: defconfig: Enable the RZ/V2H(P) RSPI driver
> >
> >  .../bindings/spi/renesas,rzv2h-rspi.yaml      | 138 ++++
> >  arch/arm64/boot/dts/renesas/r9a09g077.dtsi    |  72 ++
> >  arch/arm64/boot/dts/renesas/r9a09g087.dtsi    |  72 ++
> >  arch/arm64/configs/defconfig                  |   1 +
> >  drivers/clk/renesas/r9a09g077-cpg.c           |  22 +-
> >  drivers/spi/Kconfig                           |   8 +
> >  drivers/spi/Makefile                          |   1 +
> >  drivers/spi/spi-rzv2h-rspi.c                  | 687 ++++++++++++++++++
> >  8 files changed, 1000 insertions(+), 1 deletion(-)
> >  create mode 100644 Documentation/devicetree/bindings/spi/renesas,rzv2h=
-rspi.yaml
> >  create mode 100644 drivers/spi/spi-rzv2h-rspi.c
> >
> > --
> > 2.53.0


