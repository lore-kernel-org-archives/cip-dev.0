Return-Path: <prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43471E9A76E
	for <webhook@archiver.kernel.org>; Tue, 24 Mar 2026 11:19:06 +0000 (UTC)
Received: from TY3P286CU002.outbound.protection.outlook.com (TY3P286CU002.outbound.protection.outlook.com [52.101.229.58])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.17500.1774351136269526665
 for <cip-dev@lists.cip-project.org>;
 Tue, 24 Mar 2026 04:18:56 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@bp.renesas.com header.s=selector1 header.b=cv29VjrE;
 spf=pass (domain: bp.renesas.com, ip: 52.101.229.58, mailfrom: prabhakar.mahadev-lad.rj@bp.renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kpMXzj4V9SSn3h9WpYpjQP/ZCvTZZhVQ704bcjuLp/pF5hnMtcsP2BKoodY1OrOvz6RvUkHKoXe5PRXhG4VSBUXnqHRnnjpK7z3J9SEE9mbt2Skye1sJCltc1hg+D9/Vydjhw9Umfelz47bddicZiP7BzLry7PInTr0u2lry3lap71eWo5yLqp+YEQPJ+EuzTf84+6BUQqME8vbM9LOdbl+oI1OCGUIij1UvQRiA+VBK2u6Kb8B4zOFXkkIi2lwmFW7gitCwU9CILpiJNiY4U2fnImxdE1aptfnByp7kpAFmNotmyK+/ZX/Nr8ct1Zi71uEcRlWXKqJXs41X5qCvqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eFkd8/R1d9PzJXIX36J/+SphqVQZH0RwNptYzkpT4ZE=;
 b=azeWRMnijdj8BW+sIwa1advzFFBlJo7WSmFhWZA0gJaglDWZzdL488wkiG4pjtnlGrYC8WaWA5wimoLG7Fy+ViWzsC17CLw+TmcuEy1hfxIUDBfcQc9lpzH3z7tAldvTU6lqso8mIa4Qd22iG9J4ZvTf/qVQVnRlsQ9Fid4XVRPgKHMJECZnWzUdGJMmYo/+3Goj2Dy/iZ4l53EpxS6QGObK0G46Clj5lUAf0NQHlXg90lwUvdxL5O6TaPU/Vqz6A6Q52W0OIzSOBC1OVV5+REvxVSe2ADEF4lfr/Mbowh1zoeCvnfgDmAsUhUyRnE1wATCPTPvyASl0aXWGxqoIuw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eFkd8/R1d9PzJXIX36J/+SphqVQZH0RwNptYzkpT4ZE=;
 b=cv29VjrEcopmU8dKB3mgypHaIUOSN+wmkybgyghrNPJgIyb8KO6Q4SSX0HHtbdkv7qRfk2S/x/+BZMj/PNHfmsAPlopMDbDbhs5c8lSLjZAls65fwCFhzdvPok1hSO5ayI03fQFz9GpjWfk129+6RMXD0WIUcUI09FDduChWHyk=
Received: from OSCPR01MB14315.jpnprd01.prod.outlook.com (2603:1096:604:39f::5)
 by OS3PR01MB8090.jpnprd01.prod.outlook.com (2603:1096:604:170::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.31; Tue, 24 Mar
 2026 11:18:52 +0000
Received: from OSCPR01MB14315.jpnprd01.prod.outlook.com
 ([fe80::66f:fac9:2ef6:9796]) by OSCPR01MB14315.jpnprd01.prod.outlook.com
 ([fe80::66f:fac9:2ef6:9796%4]) with mapi id 15.20.9723.030; Tue, 24 Mar 2026
 11:18:52 +0000
From: Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: "pavel@nabladev.com" <pavel@nabladev.com>
CC: "cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>, Nobuhiro
 Iwamatsu <nobuhiro.iwamatsu.x90@mail.toshiba>, Biju Das
	<biju.das.jz@bp.renesas.com>
Subject: RE: [cip-dev] [PATCH 6.12.y-cip 11/35] phy: renesas: rcar-gen3-usb2:
 Fix ID check logic with VBUS valid
Thread-Topic: [cip-dev] [PATCH 6.12.y-cip 11/35] phy: renesas: rcar-gen3-usb2:
 Fix ID check logic with VBUS valid
Thread-Index: AQHcu24QTBW4iC08z0eflhWMlRDdobW9iN+w
Date: Tue, 24 Mar 2026 11:18:52 +0000
Message-ID: 
 <OSCPR01MB14315F58FC5E8C2E4B7E428C2AA48A@OSCPR01MB14315.jpnprd01.prod.outlook.com>
References: <20260316145915.8580-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20260316145915.8580-12-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <acJVCOdlchLiSe5n@duo.ucw.cz>
In-Reply-To: <acJVCOdlchLiSe5n@duo.ucw.cz>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OSCPR01MB14315:EE_|OS3PR01MB8090:EE_
x-ms-office365-filtering-correlation-id: 54cc50b2-1542-4123-b37f-08de89972158
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: 
 BCL:0;ARA:13230040|376014|1800799024|366016|38070700021|56012099003|18002099003|22082099003;
x-microsoft-antispam-message-info: 
 GWYWZZvhgiEuuWE5BqtJqlpZTSKelsR6pDsDbfvI6c2wPwBYHr0P/KuxYD20K1VGfpd1qs0vsGUwlKSdUuIx9iKuVYmrxZCwt1sf8xrhcrGyfXlU5YTMX0vMuLRCVP0AoOsQ9nv4XHCTDyUqQZQjpViyPEhMehCQ1ORU3QcaV87iBcJbBTpVYUSwXDB/52UJyWqB5IhbgIMS492VhqQljMBag0pwaGEOmyax9OTWvCra4hj21UnfrAvb9IHnnoCbgSCTi3CP1LRGpSOvjNKWaslqLJ4P/utPIVjmVItWbV+wtGqgvfZDYaudxKMpgQdBl2c8Zn4D1KzK/NitrsnwmWR1SBvNeKgegHLuPSqsgJDrMalx92vmkxQe2JVigGP5vKYa/sI/AowcbtcAtJgK+7EuUhavf4cjx34YyCFVENFqphChMjTXIHLJJQ4601BV5EASxiAwE6gy0HdtStb0IZlJ/UJp8hhR12vW8eiPvMbNTmTirAAbMhO2iL2ov4mMdG9IzC7rSx+plZt7MdX/b3KovDLa8egtJ+lrtGutgAO6u9hAD+ngcKjcQMCOk0m9PrmlMUbxodO4jNaJ1pmdy3rnKZAq06JvlNcEVGTHtTnQepOPZbzIsJRKOhPBrUgXnV2v/ibxa7+GnPbjqr8ELmFrNkLD8pULCTExSScschsXWN6xngNdhxx31Dko500jyZ49hCUPIPsxt+WUeREyHCYFE8PvhOXGx11JOD1IBr+WvRXIdUmH/KORVZvemo2JyzggyjlaQcut83c6CxFb7waAB3YPCg6klhp9+JpZCas=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OSCPR01MB14315.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(38070700021)(56012099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?us-ascii?Q?hCL5KTAXXquj4bnldLQ6za6wAp0EBrCVaJIdafq1RUWQ0qTz+zmED3q0Qn42?=
 =?us-ascii?Q?imNQx8+e5xPj02vyNX/Y95YmYhbNc6xVFCwzII8loKa/dwvVMqaI2cpOOrYH?=
 =?us-ascii?Q?C90423CxLC+C2W4PcrN+Xw3p4n4D7jsN6GPSR/jSWUMXlWOFei6SFs1PRlwb?=
 =?us-ascii?Q?gwyktaa6b7owDCCUnBWZz2hAk0GlNvO0AS5bGHQWBzVOm3dg9ybjbO5MPSJY?=
 =?us-ascii?Q?ViOCR8wyd7vdav8eKvF+bHieAS5uS1TRX6cJaHEEsfHMF3LR9JY2v6qx+V4L?=
 =?us-ascii?Q?dC3JtCEiX4XhTUqbfCgt8JuGw3dryavPqLCe0IPgsPwbXdWU3syn1vVkAfmg?=
 =?us-ascii?Q?M9f8OO8Z/Vzlla6wggITDt297B4qIfeViSgBqPCvpHJWeVTF6Qf9GXTkHRAC?=
 =?us-ascii?Q?wpbJQ8lqeho/lafvRFZU5adOTZDmdB57QuelJ6sY/HjseSdw6Rw2PWZIgfDW?=
 =?us-ascii?Q?LS9NqH27RqTLr4i2ze0OR7sxhJM0EuFbpi907bVH0wzjoow7t7PGNRS4azi+?=
 =?us-ascii?Q?AC2/algpAsQfB5YugkbP/xeDaRze9DkgK/cC6DiG2JPCjqN+88LHALhxe57B?=
 =?us-ascii?Q?sqoogkMfLCYKupAzD3NzGvEFPsM5GYDh4k9y7rFXgVJkuY3kBU0+4HYCWIJz?=
 =?us-ascii?Q?+M3C7xHgFcFM1s4kfXPKjVNY3zE1HStYska1ZTm6hAPnhdJhf/FSRVfCuIqk?=
 =?us-ascii?Q?JOT7XnaQQMSPgrX3kLhR7fKmSj5ujLwZrNS5o90a30w9oESCg+IBQhlp3aET?=
 =?us-ascii?Q?1qp2BWXPzSLXJrdpPWQUIIn6majNB3etCB4IcTEtahkEaGteiglkO4f9AO1H?=
 =?us-ascii?Q?qjtKky9cK4qgwvDSLqWaLolxsAU+huP6h24jfZG5xSSPQAOiQu27JUCSQvGw?=
 =?us-ascii?Q?FVFYJpstIIYjpKcfUF01r1cvJStB54CLI/QCT43Y00PR8daMc+xZXyde8KU5?=
 =?us-ascii?Q?ZFlWbwLJFcWsVf5Sk3JNaT7ES7M+oL6ec0w3JV8mVG7Q3iuAFWrQtRfvDG+g?=
 =?us-ascii?Q?syQkjogqL4nmcOpCBzEwHw6eHQ+rgeJC2GgUJZWdGwUfezbOooxzny4L307c?=
 =?us-ascii?Q?Yi/mjI1MJmt874l/8LjEgoep8mjqJF6ZLBDOdO4q/hPaK88HIfcw8fXLuKYT?=
 =?us-ascii?Q?fyXHLW/IJ2F10KjVwXF8fPZy6/d59Er5WKazCxec4NeT1zeXE5Z2XnVXcZ8K?=
 =?us-ascii?Q?WZMh4tzSxUTQYIsgkWXolopiP+/mHAF2geW3O6peoXkAqItijNnri69qip7G?=
 =?us-ascii?Q?E9jxMNsGb2J0Qjp48i77xO2nwi5c08Uh5aeRWX4blpYimrX43MJUQrzjQwuo?=
 =?us-ascii?Q?Z0tQlGomQ1RpFPrZ90j617x4a2YUVolLMbaDdQR0RJCi6Ag+fnBVfE1qj3hS?=
 =?us-ascii?Q?V3DhfIpdB/baxXI8G+bElkQeM17kLGYAIY4Vj8KOSP+6R3l4BhJ8qHnslw8E?=
 =?us-ascii?Q?Zd+eiZmAxdpHn2dpImW8hzloEiSVy0iaLh9ljrR3f9cWkw6kuJAkmADqee8s?=
 =?us-ascii?Q?MThWQ+sE1fLbBoc2R87xQph8+WGarwkZeWA6VVJdtbyMagOORzb6u+3yPnTN?=
 =?us-ascii?Q?MVv3gQdWLYE8oRmU8J00w8EX3uwefa+9Ih/1oEV/QGvYRWTGSf4Bvk/k+LUn?=
 =?us-ascii?Q?YxjHlKGcUrFEby3cgSf/o+AT3EJmxm9w8s7Y033G3QRRdwus4RWR8jphIQIy?=
 =?us-ascii?Q?zsfC3TPWqylXUxUbkh5Y2RONSnEq/dKGjybOpiN88pMWmfeXXWCiYoZfN/qb?=
 =?us-ascii?Q?2uRXJLIwPAPn+u+nhhrbbJE2+Lifi7bH8VplXBEWslonViAcT2tv?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OSCPR01MB14315.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 54cc50b2-1542-4123-b37f-08de89972158
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Mar 2026 11:18:52.5395
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: npdHpUyN07v0fS0VQLx0KvVxnO3KF46BCUDmAXRhb88qk6QEYlwjMUEw48w0QsvxJo0iP2BbxsOHXe4R663i8oYK/m6HWRa228vCg9jpoeP41f/3K9H1as7qBH+77bTr
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS3PR01MB8090
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 24 Mar 2026 11:19:06 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/22546

Hi Pavel,

Thank you for the review.

> From: cip-dev@lists.cip-project.org <cip-dev@lists.cip-project.org> On
> Behalf Of Pavel Machek via lists.cip-project.org
> Sent: 24 March 2026 09:11
> To: Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>
> Cc: cip-dev@lists.cip-project.org; Nobuhiro Iwamatsu
> <nobuhiro.iwamatsu.x90@mail.toshiba>; Pavel Machek <pavel@nabladev.com>;
> Biju Das <biju.das.jz@bp.renesas.com>
> Subject: Re: [cip-dev] [PATCH 6.12.y-cip 11/35] phy: renesas: rcar-gen3-
> usb2: Fix ID check logic with VBUS valid
>=20
> Hi!
>=20
> > commit 356590cd61cf89e2420d5628e35b6e73c6b6a770 upstream.
> >
> > The existing ID detection logic returned false when both IDDIG and
> > VBUSVALID were set, which caused incorrect role determination in some
> > cases. The condition:
> >
> >     !(device && !vbus_valid)
> >
> > did not properly reflect the intended relationship between IDDIG and
> > VBUSVALID signals.
>=20
> Yes, well, original code was so obfuscated I was going to comment.
>=20
> > Update the logic to:
> >
> >     return vbus_valid ? device : !device;
> >
> > This ensures that when VBUS is valid, the role follows the IDDIG
> > value, and when VBUS is not valid, the role is inverted, matching the
> > expected OTG behavior.
>=20
> > +++ b/drivers/phy/renesas/phy-rcar-gen3-usb2.c
>=20
> > @@ -301,7 +301,7 @@ static bool rcar_gen3_check_id(struct rcar_gen3_cha=
n
> *ch)
> >  		device =3D !!(readl(ch->base + USB2_ADPCTRL) &
> USB2_ADPCTRL_IDDIG);
> >  		vbus_valid =3D !!(readl(ch->base + USB2_ADPCTRL) &
> > USB2_ADPCTRL_VBUSVALID);
> >
> > -		return !(device && !vbus_valid);
> > +		return vbus_valid ? device : !device;
> >  	}
>=20
> Could this simply be "return device =3D=3D vbus_valid"? That's both simpl=
er
> and easier to read: we are device only iff we the other side is providing
> power.
>
Agreed, it can be simplified.

Cheers,
Prabhakar

