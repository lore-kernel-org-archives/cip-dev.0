Return-Path: <chris.paterson2@renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E89C8C433F5
	for <webhook@archiver.kernel.org>; Thu, 17 Mar 2022 10:30:27 +0000 (UTC)
Received: from JPN01-OS0-obe.outbound.protection.outlook.com
 (JPN01-OS0-obe.outbound.protection.outlook.com [40.107.113.122])
 by mx.groups.io with SMTP id smtpd.web09.8693.1647513026124414556
 for <cip-dev@lists.cip-project.org>;
 Thu, 17 Mar 2022 03:30:27 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@renesas.com header.s=selector1 header.b=T1FBWLNj;
 spf=pass (domain: renesas.com, ip: 40.107.113.122,
 mailfrom: chris.paterson2@renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CFDU4IdxepRZC+uuu9kyrqdJQEYGhlHeXDRysE/+MFbjWIpeepb288rQzNa3As/minTO7LGCdLkD0hZRRvmGTNMNbSfSw1RK9B8l9mWUgkFqYitUpUZCNrA3orOxsH6p3Rap9MoCGp1Ln6LjyBUzO9hEVQFJFUnFb27qTi3eGp4xpg8qqM7Vz5djIVCNwTdkJUb2KZuVVKrj36cC5ooQ+xDDlKNEaJcbQkuQ32OdFIgsUD7/CRVGPoCsQ0efkFj0mrXUMrP8qs8zrQ2BNx1CfueCqsMBE0ki3s8CKOf1ZEe4Wx+n+dXzdCt0Snrsg/anJYpQ262LGox3OHGTVZDbGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EVchGOMKla1c8Ac4TGKR1iaSuxNNL+hMtCGg5pn/Qls=;
 b=iwzM3P1WCW9JonZRU8pG19iaCNpKZYMzhUtaJ5LRFkkKrOgYpGzPHpmwfBpNgmFtQG6tiGAbY4ENFw94usN1tWYH7Fo7U7umf92IfmAqsvGErxjcRtADStbVy5Cz2Ym09nAiKUoJ9EqK1O3B9XNW60BFxjNHvvQitO06vVm/nIoiwaKPc6TkdV9FIesRfoQq3auSXxIWvg9OakcNPKv335DDcQIpKmbHOcyz/NjrthN1yZiaHrkV1RNMj9KLocMrBmE4hk0KkEA8IQ3erC3TYxba4SK5krpw25A3aEBng2bRDRqCPc/MAmz2Pz5egJEsx9ule3tVJL+toD1P9aKiGQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EVchGOMKla1c8Ac4TGKR1iaSuxNNL+hMtCGg5pn/Qls=;
 b=T1FBWLNjuxdxB6BF2HFWu5rbTc5upkvsSwR3vPlyK8Jo/a8pb5Htke0KmzQjF+n95io/wIyHj4w/qAajpT/go5OHcF7uUlFIm95W4MKkJFISamP48iMo3YlYFtR8kEZOuNq1Il504ouxgnUQ2dsufFPMvpf54ZuBN3xunY508zc=
Received: from OSZPR01MB6877.jpnprd01.prod.outlook.com (2603:1096:604:130::9)
 by OSYPR01MB5493.jpnprd01.prod.outlook.com (2603:1096:604:8b::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5081.14; Thu, 17 Mar
 2022 10:30:22 +0000
Received: from OSZPR01MB6877.jpnprd01.prod.outlook.com
 ([fe80::f4c0:b88d:ffb5:bbff]) by OSZPR01MB6877.jpnprd01.prod.outlook.com
 ([fe80::f4c0:b88d:ffb5:bbff%8]) with mapi id 15.20.5081.017; Thu, 17 Mar 2022
 10:30:22 +0000
From: Chris Paterson <Chris.Paterson2@renesas.com>
To: Pavel Machek <pavel@denx.de>, "cip-dev@lists.cip-project.org"
	<cip-dev@lists.cip-project.org>, "nobuhiro1.iwamatsu@toshiba.co.jp"
	<nobuhiro1.iwamatsu@toshiba.co.jp>, "masami.ichikawa@miraclelinux.com"
	<masami.ichikawa@miraclelinux.com>
Subject: RE: Disabling XEN in our configs (used by QEMU and Renesas)
Thread-Topic: Disabling XEN in our configs (used by QEMU and Renesas)
Thread-Index: AQHYOeWBE95N4xJNJE6tgWDni3CDS6zDXy7g
Date: Thu, 17 Mar 2022 10:30:22 +0000
Message-ID: 
 <OSZPR01MB68773AEA2AD1802F51FC6223B7129@OSZPR01MB6877.jpnprd01.prod.outlook.com>
References: <20220317095803.GA2237@amd>
In-Reply-To: <20220317095803.GA2237@amd>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=renesas.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 81c8af71-da6e-4fc5-8f5b-08da0801245b
x-ms-traffictypediagnostic: OSYPR01MB5493:EE_
x-microsoft-antispam-prvs: 
 <OSYPR01MB5493C4560D8BE170A5D65202B7129@OSYPR01MB5493.jpnprd01.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 HYwcyN5FLW9/jZgPPs+b/QpI26uuJyEnwZJ86w1so/82B0ez01aiuFYK1ERGPJjR/etEdp+FggB5G1wDv1aF4Rs30lHUCq/hYk4NBQVxxuQ2BZ1JdKWWofgp4+h7iMYfXedUMKvyQUy2kpY/MAllU+CG4KVjqkjGKojLaIYbflf1mUcOIDm07pysP0Ov2cp3BFOmVSLnC9QB1hRnyLi+CYhPX3SoxYlOnDc8K7gpsSC/Qsjj56Ef9AJu+vmTUmISmTizJ3foB1rGLl3f24ZdrdqNBqS61J/uOL57NDhEK2fjXQUtQquG5gT6UTFbRSa7UId5mh0vz6Mzae97G+L4Jnw/PrTRMwawpxFdYaatxMQXAfZpIf9bZ4VkxSFYRQ02oVH30SrWgyKzPQR5Cv921gqJmmx7GLGirFadMI9jP590qTzVqfSyHQJXIwENdVS0dWjKhWMIzFDW4As5wIfYK+a6Y/16mSwSVUIWAwd/D8MuaIcwdePs/GvQhScmeZXTk74Zjbrfv68gV88oEja+t3wjl2754VGiWKnPV33Q7mxEhV6d/lXsxygrks1PVAuQB1W2cFwnbOcV76uPc3tkuCzYGppDrXbGVPAU8d/DUW33B5dyEwNjczwDewY6eQYOYnXlVmcNOkXZPEU3KPVxSCUyOZ+fwRjO/iq4q6h5lhQVEmt/50Xo/oooYcOEVEiFmkFUPxS2XgEAMTVUkmubA291MN5SKSyWj2cAZGa3AirFo2lqwhn1ephhtkhMKWRVVXfYKaedV3n511Qb1NpFPzOuFC+obr/UKRDBB9Ilvdo=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OSZPR01MB6877.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(52536014)(83380400001)(33656002)(86362001)(64756008)(66446008)(66946007)(66476007)(71200400001)(76116006)(66556008)(966005)(8936002)(8676002)(5660300002)(508600001)(38100700002)(122000001)(55016003)(7696005)(6506007)(38070700005)(186003)(26005)(2906002)(316002)(9686003)(110136005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?Windows-1252?Q?KGiui8aivxJ4AgHK6TkXKrE/t5qNg3La7j8iU9UhtJH9gHU2bMzzlcU5?=
 =?Windows-1252?Q?Ujm5sQS/c510vJ5h4mvD3BVaYK5PI1u32aaU8x3vcPF/XJkJTzUoQGy5?=
 =?Windows-1252?Q?mx0XxNuEn5BQwhnAxW35fGhhiLOyx6gjHWY9K0LmoeSvR/BVcJ/AoIjR?=
 =?Windows-1252?Q?dtGkG8Ii2boaLgNfQHkr4AK7pNJRJBDMtP1rhCvpiBL/oGTEoFCcC0uN?=
 =?Windows-1252?Q?JWObuv3qxgTeH1FrDJNUQahB9j5mtE8gnPhC2232IMMI9/O81TKavMOc?=
 =?Windows-1252?Q?cnVJpFM8kZ2uY7xDWocF36kTY+2oJkhJU40YeQ5gsPtHSaOhRJYa98IF?=
 =?Windows-1252?Q?OmQ3VL+wElMlUfTooCZeS94UhQABqEVUU0cCdT7569M2afdXiyr8fYwx?=
 =?Windows-1252?Q?Y67/ALL9fpMC7QIH0ho2x6viUJQ4+9PT+RMNXxniTSVCbXX5X/mCQ9pU?=
 =?Windows-1252?Q?a4/OJN9S9K0im+9st3b4U5cW7hPX4jYK7lrFdnVpo44tzhFOlVuaCG/W?=
 =?Windows-1252?Q?2L+NUJ3AJ0kvC+T08O7Og8bsBTsea9GQC5zqEzgpE5PiMErbiajJ87t7?=
 =?Windows-1252?Q?DuSBrpitrLa4wpmGulpW88wCaxcSzGbIdMB+5aA5HoGb2L1CYLbQgyFa?=
 =?Windows-1252?Q?Ghg1vJcFbfLrB18nY+wKhftCDis02AihHwzMfdDn1jrv4QRhsLMwiSJf?=
 =?Windows-1252?Q?72cwHl/uiv/ld/Da+ayBGHDYzMxSwnfdfffYoqYAJgqXpqJs2PIWc2J2?=
 =?Windows-1252?Q?4Uzad8s9lU4aRY87m3fV+AnSP3nPxZkB+DXb2B47knjx7b1iZ5qFmm0P?=
 =?Windows-1252?Q?KouBISsrpwGe+dA4pk/q852aQn2LfX8zOtZcONDNodO+kpNBQfqxcFm4?=
 =?Windows-1252?Q?GW6wwB+Qz910fDNNei+eY3TiOUuuU9C2SVQrz1zd7R4AGGbXvRtgB6ii?=
 =?Windows-1252?Q?yjmpqWvqycmAWM1eDqWheOPxtz2IH1wDlCOznweRI+4Pqx8c3ZJX3vaP?=
 =?Windows-1252?Q?FtGmZKDiZLkRh7fS4F8aAf5qGWa3M7y5MSF6cPX/qPu0CCm5pSlqncNE?=
 =?Windows-1252?Q?j56Apb9OQdkX45ro2jSODyLQwaB+5HKyO+aggnhr9VxUgOsIx1tulUgC?=
 =?Windows-1252?Q?6ezJHvG3uYvPgSoqNYLUwNE3hZ/t7PqBBN17Oh2HCxx/3lDsw/davAkU?=
 =?Windows-1252?Q?ew3uiSb6aKwBhYH28f6QaWuFnfca7OoKr9UBe/QENSAnm+bjpjapYZtH?=
 =?Windows-1252?Q?QD260Gbo99jAQvWRgguBic1dFXuSaT6FJjbXUtLLC2vK32LOPpDQBg8z?=
 =?Windows-1252?Q?eIj5jgK+840RJUVkj4XwL97q2CQvigE/C0bmV9+3pQ/VexnpEmmEXI7y?=
 =?Windows-1252?Q?MpsHYt7EK7cvQnSe8tG+bKSYmV8mP2buHC7uSujTypXbyeR3uSnQ5EkV?=
 =?Windows-1252?Q?xB6dpXYbwo8CqCj7Y0Y1/QZzQTBRi4SUrHnYkdbl+cWDXsCHX0TYveSm?=
 =?Windows-1252?Q?4mbbQIHkG7y99Duotl4wh/QLQHm7B/IKWMjNOirjNEB9yL9I9f15zdNl?=
 =?Windows-1252?Q?BZC3Uow8YQPyBus7udITaRYczr5l5SDI2sle3w=3D=3D?=
Content-Type: text/plain; charset="Windows-1252"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OSZPR01MB6877.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 
 81c8af71-da6e-4fc5-8f5b-08da0801245b
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Mar 2022 10:30:22.3379
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 
 2/sRy8gd8+3X7KbKW+WerYE14ar+iQcsOplyh2VJZ90lFtJ/vhhGdGV3WRwWCMxtqbzRDyyMW8wFD0QTe2PDwlYQN5Dg0oKf0Ulsjc51/Y0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSYPR01MB5493
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 17 Mar 2022 10:30:27 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/7776

Hello Pavel,

> From: Pavel Machek <pavel@denx.de>
> Sent: 17 March 2022 09:58
>=20
> Hi!
>=20
> There is bunch of XEN security fixes in the pipeline:
>=20
> CVE-2022-23036, CVE-2022-23037, CVE-2022-23038, CVE-2022-23039,
> CVE-2022-23040 : Xen: fix race conditions, resulting in potential data
> leaks, data corruption, DoS by malicious backends
>=20
> CVE-2022-23041: Xen: fix race conditions, resulting in potential data
> leaks, data corruption, DoS by malicious backends
>=20
> CVE-2022-23042: Xen: fix race conditions, resulting in potential data
> leaks, data corruption, DoS by malicious backends
>=20
> There's a bunch of patches fixing those, but backporting them to 4.4
> would not be exactly easy. Our scripts show XEN as being used, but I
> suspect that's a mistake.
>=20
> Reneasas, can you confirm if you are using XEN in your arm64 products?

The renesas_defconfig is largely copied from the upstream arm64 defconfig, =
and upstream renesas_defconfig [0] used for development.
As both of the above have CONFIG_XEN=3Dy, we do in CIP's copy as well.

[0] https://git.kernel.org/pub/scm/linux/kernel/git/geert/renesas-devel.git=
/tree/arch/arm64/configs/renesas_defconfig

I will check internally to see if there are any known users for XEN, but be=
ar in mind we are an SoC vendor not a system integrator, so we don=92t have=
 direct knowledge of all end users/uses.

> If not, it would be good to disable it in the configs.

Makes sense.

Kind regards, Chris

>=20
> Could we disable XEN in qemu configs? I don't believe it makes much
> sense.
>=20
> ./4.19.y-cip/arm64/qemu_arm64_defconfig:CONFIG_XEN=3Dy
> ./4.19.y-cip/arm64/qemu_arm64_defconfig:CONFIG_XEN_GNTDEV=3Dy
> ./4.19.y-
> cip/arm64/qemu_arm64_defconfig:CONFIG_XEN_GRANT_DEV_ALLOC=3Dy
> ./4.19.y-cip/arm64/renesas_defconfig:CONFIG_XEN=3Dy
> ./5.10.y-cip/arm64/qemu_arm64_defconfig:CONFIG_XEN=3Dy
> ./5.10.y-cip/arm64/qemu_arm64_defconfig:CONFIG_XEN_GNTDEV=3Dy
> ./5.10.y-
> cip/arm64/qemu_arm64_defconfig:CONFIG_XEN_GRANT_DEV_ALLOC=3Dy
> ./5.10.y-cip/arm64/renesas_defconfig:CONFIG_XEN=3Dy
> ./4.19.y-cip-rt/arm64/renesas-rt_defconfig:CONFIG_XEN=3Dy
> ./5.10.y-cip-rt/arm64/renesas-rt_defconfig:CONFIG_XEN=3Dy
>=20
> Best regards,
> 								Pavel
> --
> DENX Software Engineering GmbH,      Managing Director: Wolfgang Denk
> HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

