Return-Path: <prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39977C369C2
	for <webhook@archiver.kernel.org>; Fri, 25 Apr 2025 10:27:08 +0000 (UTC)
Received: from TY3P286CU002.outbound.protection.outlook.com (TY3P286CU002.outbound.protection.outlook.com [52.101.229.56])
 by mx.groups.io with SMTP id smtpd.web11.3698.1745576818906871581
 for <cip-dev@lists.cip-project.org>;
 Fri, 25 Apr 2025 03:26:59 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@bp.renesas.com header.s=selector1 header.b=SVDQUDue;
 spf=pass (domain: bp.renesas.com, ip: 52.101.229.56, mailfrom: prabhakar.mahadev-lad.rj@bp.renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WDZ2/FiP/SrBkTvtgOldizR2tvhlfjE6XrTzbl3+E1lO1QpnMWYW9wfdCPGE3mkDH6tUFs6uDgQuO5JPVYVayqqpWKLybQDCibFl6h4c/kf/aReK5zq1syQJwLQUeHyG2q1jSc09K0y+k/iWNmbzXKLSLqzBN9NMOuGW0m/gshC7ekEoeEzTkcMDATo/5BszlkrvW5GV2AC818Q5g3WBbzx8HQ8ir8OrFduwzkl7MrK3ILzv+C/EdULiLS7pWieEwmf3IClfxQbOjlBsUczPakqH4UwPh75wLWUNuBvEVh/CpU/b+4kOUQHbxJ/Oh9fFYd+045R5RE/cb7cL75mSJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2TAk6+b/Iqmq0ZZbh3UPd/CyDQR6qvvGANpHO2lwUmA=;
 b=ZeEGMopav+UPhUfmanw1nA3Oh9gepp/XSJLRwVCVbVlCNj5JE2bjxPSmQPEzj1AgndizDaD3Yu6LcdK5APb6PQYerX4CJJc/m3AjUyV6OrMm7QriXCjp9Yw7P1G0oW94oedCDCHWAYVCZmM+KKt8xhmyZKiGRX6iGpCI4REFwK0ttNuEvfXheuBtTfVQQY2nCq/l6RIKX6/pgM/AI1+JsM2QamhG1W5r4fJS9rLujX/c24zxTMRs8F1M4XOOX9SHNP5zQSQqTWTBChbYpCgI5yoRC21zsTUfMjhp4wMuVQVHdEHYyGa+6JmWU8xtDjMwASsM1X0knkFfN/qbJ/IbcA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2TAk6+b/Iqmq0ZZbh3UPd/CyDQR6qvvGANpHO2lwUmA=;
 b=SVDQUDueB3RmZoLasvmEAP4D1/3qCI0u69NDWDnU4imqwv4t3JYkvrO/SwgM43R5NIXhbPtTYxAj7NIuJiTVQR6LfoXFE+Rg7Ex8eD7jDu4LStyG0vHVEDxF99Nieenx+4rijxhdZdMuSQQ60rr/tcJk40al6s5dlsfDA/grjRA=
Received: from OSZPR01MB7019.jpnprd01.prod.outlook.com (2603:1096:604:13c::8)
 by OSRPR01MB11677.jpnprd01.prod.outlook.com (2603:1096:604:232::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8678.27; Fri, 25 Apr
 2025 10:26:49 +0000
Received: from OSZPR01MB7019.jpnprd01.prod.outlook.com
 ([fe80::8a27:ee0d:d7a4:9d10]) by OSZPR01MB7019.jpnprd01.prod.outlook.com
 ([fe80::8a27:ee0d:d7a4:9d10%7]) with mapi id 15.20.8678.025; Fri, 25 Apr 2025
 10:26:46 +0000
From: Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: Pavel Machek <pavel@denx.de>
CC: "cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>, Nobuhiro
 Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>, Biju Das
	<biju.das.jz@bp.renesas.com>, Fabrizio Castro
	<fabrizio.castro.jz@renesas.com>
Subject: RE: [cip-dev] [PATCH 6.1.y-cip 00/15] i2c: riic: miscellaneous code
 cleanup and improvements
Thread-Topic: [cip-dev] [PATCH 6.1.y-cip 00/15] i2c: riic: miscellaneous code
 cleanup and improvements
Thread-Index: AQHbtcxD0LKlt0gm60mc1qayRce80rO0LVNg
Date: Fri, 25 Apr 2025 10:26:46 +0000
Message-ID: 
 <OSZPR01MB7019F2AEEB05D4B49C04940BAA842@OSZPR01MB7019.jpnprd01.prod.outlook.com>
References: <20250425091057.33752-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <aAti7FKVCHFN4Tdu@duo.ucw.cz>
In-Reply-To: <aAti7FKVCHFN4Tdu@duo.ucw.cz>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OSZPR01MB7019:EE_|OSRPR01MB11677:EE_
x-ms-office365-filtering-correlation-id: 6a8ffafc-6f10-4c3b-ba70-08dd83e3ae5e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|38070700018;
x-microsoft-antispam-message-info: 
 =?us-ascii?Q?Je9M0WUsmxy9U/HqfVP2Max85V/3DbzakCTYQsLHttDmGJkFwJDyPNei0hrO?=
 =?us-ascii?Q?VybU8keVrePcVKUPIIQN6mmcXYRBrqsw3/NKoPM8syKo4UU1g3rdTVI9XB5t?=
 =?us-ascii?Q?4GJOmLaA3VeXRL7HMJPHYFlvNunuX2r33T0yC6+VRjnqtXlh0JYjOAxyYOy+?=
 =?us-ascii?Q?ji4sERPJ3DKubXSqHW7iM7KkCVO5aHzljno+IVJisJN+SoLlpmCXiTZd/zxs?=
 =?us-ascii?Q?TKtGiLYcWmshjWlVBUtPslMYSdq1guzMCGrYhC7wwBs5saCbJ9rM+YX0VxLq?=
 =?us-ascii?Q?6ay2Cc7TbsK6HgYMRDF6suOFjzwuC60bKYl1P6jgTi+kjdm1ttgkveJQz2oH?=
 =?us-ascii?Q?6VEqTGurGY7yAHZNb2LMedXX74ZTiYmaQ6rin3ExHrb8qUBG7/Myh0Ep/af3?=
 =?us-ascii?Q?MPYemkWviwxxQs0DFYyLvrTP7qvO6wGjE1NNzVMRdUDFcysEMbKrABJcue+M?=
 =?us-ascii?Q?qVtOdq9m0y5uEuuAubKM7dxRI4Z5cAPpjW04RR6d2JnS1T0tB5A44FD9AVfJ?=
 =?us-ascii?Q?7EYPX9teLewjb1wftFEjvu/d1GSgmrdsIqw/aRr0a23CFA+0MhpSB5kuXzSV?=
 =?us-ascii?Q?eKvewHYbjvzA1Aot2kX0BOqAMR41Y9R+m9OpSa5sIadLuEP48CZLGgdKRZlr?=
 =?us-ascii?Q?TFuW0GfPeEeGDETddOsdVu4P0kOMTu2DiVWeAILDO2uRQ+5ILOxH7jtry/sq?=
 =?us-ascii?Q?05Ui/lRR543CtN+fsnulBsCOGos60BKbbmIfIp+wEdqeeWl5dV4TJxrVIQCs?=
 =?us-ascii?Q?VvOWwk7A8qRiYHNA1bDS3tImX3m1TRurMRjauUDo6k4BV/em2/ejL3z6jTLU?=
 =?us-ascii?Q?F8n5D+T0NKaBUUYyzi97kEdqRTLY+Q4RMmydVfLl5dSvn00D3gRHGS6UObYl?=
 =?us-ascii?Q?XoJYJZogNsKILmUej6rbTNY7gC0GCEGZiJIMZafWX+gh9U9ZOzScZirknNJA?=
 =?us-ascii?Q?iUULz/enoKrI0mN4atzB909fTHVboQ9v20EYwGQBaN6kshjQGh6h2qWbZPI1?=
 =?us-ascii?Q?esqpaoAHHslxQC8RUpMVzzFqqaM0WXbDkjESGSR3WmQy0aYnaZoDCl4wcgmz?=
 =?us-ascii?Q?ZHx1jOuHMxfKOTDQswbNB5ORHpe8xl2rmmvcTAycr9IyIXcMENQ9y6ViuZA0?=
 =?us-ascii?Q?eqo49+tbYm8YWH2RRD5bh0vbK3GPjEb8v7EkkuicbGdRkDVTJvwI9IP0oXLr?=
 =?us-ascii?Q?x2coTXbw9sIDUvBNJEpS+4MEcB/Funk0JhVN99uFp7VJw/fLTCstEQ4eNTRz?=
 =?us-ascii?Q?tkmdroF/B8oUnS0kQpMM4vzhr/FN7y6lI/y9GhHXg0X3FCiIR+EjCB6h3vCu?=
 =?us-ascii?Q?ljUCFJtIq7SHnPj8W9MlS01zPSqpRnUqvM54MTHLF4dwaLcHSG3UIPzACfq9?=
 =?us-ascii?Q?KpuVkOfPGQAwbg2wOClaA8lP2rYAAI+Yb7BDTVRWEJKQ84kQszKnVipfsz9u?=
 =?us-ascii?Q?sdWuoTTAgt1C9v7EtIHZt+uKFMr0RDFZqMQctqc48qaRxDa3/4lM+g=3D=3D?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OSZPR01MB7019.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?us-ascii?Q?KN5NS8ly1ZsJEr8SyFLSmYjxBksaMB4XXd8Ufy/SLlZurb4u1cIEiGDGyGR3?=
 =?us-ascii?Q?kGJHIGj5taBSqp/y1bByLWj72VQNPJ9170CFqEqX2Zj3c4C4UqcuAocHIrBi?=
 =?us-ascii?Q?MtThXmeW9FpekfoHvallwRNxHwZO5I0rJ1RL0sjFJbsQ+Kz0Z+il41wvkIyW?=
 =?us-ascii?Q?mL9Bzabjz0h8mjmd7a4taSHF1y/8zRx8eSKycqTFDcwz2NUkaTtq0Wrhfpyz?=
 =?us-ascii?Q?aHEr6gEH3jYXivoHdYp8qsBgkEbd2D5d0xSbBFubFjpZwf70N4usWmOAsURi?=
 =?us-ascii?Q?dMymtAcUwMMhnXY7ZWsOpHeNgHrOnrZ5XEMgXmJO7talx3Tz5wIbDvYDvVM9?=
 =?us-ascii?Q?JA1MSEaP+R/gtJu7eqyTcPUyBxuiAvxzJiqe7KgAeWbyJUSCtphSaVu/63Nc?=
 =?us-ascii?Q?YNWvZxZuBG+wHRX95MXpfgkutTSe/2GLz2wJHXPNCtW3rdkzQlTTLF3puBjl?=
 =?us-ascii?Q?zpq2jupwNQdV+qYk0yOXnYMT/Qbn7OQ437Fj4hpAeATiEU/yfq50MxUSi2y6?=
 =?us-ascii?Q?9+lldCEDC6IDhS6I4ZaCDpCW7z0XRqA7STYHCa/sb8ETg/OKVauPUSf+hya/?=
 =?us-ascii?Q?HhSu1ZPRp6OdPT+y0zrJ3X44my1a7M9J8pM5G6mqOiAWX1sne+pboulvzaKN?=
 =?us-ascii?Q?dPUTDSg+/z8IiMGBVwzaiSZ4PKQHRfC7HhEwv7ObXgQwaBR08ZPfQ441Kzq3?=
 =?us-ascii?Q?6HWaSJVBA2Tm6l9CYyt5i54pMQVQPGbOoNTKUM39V61XKWyF71z/1OwqIxE6?=
 =?us-ascii?Q?zg3w9TcYgReIcfivbisfIqes2y4bS4Fcr4obBTJeJX+wt/BsskcrduaDDDKd?=
 =?us-ascii?Q?l6HXxDwg5rH/iR8Zpr7frhgc9rw5PR+7bB+LUgQZvnS6tdNl+v4S02AkWp2q?=
 =?us-ascii?Q?4Zwt+t58Fo1QhcRv3EAPge+KU2915iiwuYzTYAk2C3yfjbjCFPj7c/TL6ar6?=
 =?us-ascii?Q?lN7/gEGkJAJZc2CRsYr/jqNo0Nu6i9fTZcAMUHwUV7LnjtpVSfyL27uT/Uss?=
 =?us-ascii?Q?uAvqputbZQSrigML5TKd/3IOnHCuf6QcHyfzXoCp0y8DKtH2su8RIZtLNGwy?=
 =?us-ascii?Q?F4RssnSQ8R/DIBqoUvGPAQFDC/2tW37UE+VDeIe/eGhMsM2WY7pamiw+pug9?=
 =?us-ascii?Q?VZExeG8c591Q1mjpvXaaqd3pe6z0mrrLMmnZx11oqGzzymwyQjD25EXkZQh6?=
 =?us-ascii?Q?dkFRcVCnV4pTRbLzG/XfMA2x21WG0KPR3dF0F7Jyrf8Buxv1HXgal3T+kch7?=
 =?us-ascii?Q?HIUBJ0ocxoQsiPMbN5jHaDzeUIP3SzHH8MdzlHqjqmoHffZyq2W3uYXzuRx7?=
 =?us-ascii?Q?clcsyWLB5zp4lhqgY9qRLU3BgefAkElZF8+8O/Y42qbbsjHJmsHnEXFf8OKc?=
 =?us-ascii?Q?2/HmjD2Nn4r3l8+LR1gplmxrwbcXRf186KwYPf1FGpt7dGqMus3G4Q6hdQHe?=
 =?us-ascii?Q?l2LUcXkV/PaidVWX/YKZr2DG5W29L6a9XKA5LICoWpOxrRTb2xwtMPj09kTC?=
 =?us-ascii?Q?q6KnQT8kcULft1BCe+eeGzz6N0DU6gCiQZ2Y+bDTbaKegVKvOrLTnOYQiiuZ?=
 =?us-ascii?Q?2LqTIzqJO2m+xrui9SMnGV/PjknUcn9mvH3V5NgE+vg7C+HV5hTM/oZ7FS4R?=
 =?us-ascii?Q?GvMJzcvLL2cwdnbN63+QMqI=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OSZPR01MB7019.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6a8ffafc-6f10-4c3b-ba70-08dd83e3ae5e
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Apr 2025 10:26:46.2315
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ga/UYJkFeWjPDP0EFpGRJIpF5GtAbR+aNhxG1xVKDoYuE132ka1NUq1DvmWXcCN5p9ZIWNOeYQ+BaYx/lowdPDLoIskKv2Cy60qxUFmBlx+cGIquzXEEPklNgBQM/frv
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSRPR01MB11677
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 25 Apr 2025 10:27:08 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/18621

Hi,

> Subject: Re: [cip-dev] [PATCH 6.1.y-cip 00/15] i2c: riic: miscellaneous
> code cleanup and improvements
>=20
> Hi!
>=20
> > This patch series includes miscellaneous code cleanup and improvements
> > to RIIC driver used by Renesas RZ SoCs. Below are the features which
> > are backported:
> > - Runtime PM support
> > - Suspend/Resume support
> > - Fast Mode Plus
> >
> > Note,
> > - Patches 9-15 have been recently posted to 6.12-cip
> > - All the patches have been cherry-picked from v6.15-rc3.
>=20
> Thank you, these look good. I can apply them if they pass testing and
> there are no other comments.
>
Thanks Pavel, for the quick review.

Cheers,
Prabhakar

