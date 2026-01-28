Return-Path: <ovidiu.panait.rb@renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 866CED3F076
	for <webhook@archiver.kernel.org>; Wed, 28 Jan 2026 14:46:03 +0000 (UTC)
Received: from OS0P286CU011.outbound.protection.outlook.com (OS0P286CU011.outbound.protection.outlook.com [52.101.228.13])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.14579.1769611558259019156
 for <cip-dev@lists.cip-project.org>;
 Wed, 28 Jan 2026 06:45:58 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@renesas.com header.s=selector1 header.b=i1ZRrxvL;
 spf=pass (domain: renesas.com, ip: 52.101.228.13, mailfrom: ovidiu.panait.rb@renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Q2usH1x0XThMkuFwp26hS7UgY/xYipmdLl03qaKFRVEgXzsJ+q9H/ZgI3BGPMO24pIllMNPpxoZHCkr25UJuKKuHZlVkW3UREQw8OkMJy1wQKfPbcaQRCb2HJJdgkAabXtCEr8WS8fbVACqdyEd1e6dxnQojT2cYjZxlqBqopSYa2gV8Bd8FWrtILmioUFD7J9VFLDLFxLHZojLmm25KnV25J+aO36j9NjcEzm1zJ20PzVOZKM33SD7UlNlscvGdVadOIC6r4u1QhvZm5enocMhk7+/4umpKogwlJqv+qFWGF546x3vAoPwnRGgrXKvZdL5EzEGcD53UM2UI1x4wvw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+0SKn18usp0PxWwEsYxgK4dgAVgh5Fh30Iagliel1sI=;
 b=i2Kr3P/m50C3NomM/51FVAWqwQe7NHR0EelO01Vyv8/2jiqK5VXLbyHUEj8rm/PXAy/nEtDNmSjdlgY/iqVQcT/TzkCoEbWfKCPrO16Y+7DRWhPAdX0ljz421wHQV09zfw61UEKcBPEG4B5/gX22Yk/H9JBeAjMDbdH2I2lzzIYgXQLCoCfqer6Pjc/3/te/u2I1sxJx60rY7b6UpE9Q3JjAhO05qca2DOoQXGiH+ZaPv0MQVt9OOhR6KywGv2516QGXJ9QpY7D/UlGyzy9w2BTW8tbbPLfozYEZn74OR+Y9851VZjRCSaRVeJOVUlueINz31S0wWRLdEEDBqCjqvQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+0SKn18usp0PxWwEsYxgK4dgAVgh5Fh30Iagliel1sI=;
 b=i1ZRrxvLWYWn992d02hMIw3BnjebACYOal1o/9cQsHQ9Kw+aTt5EKUCrKwjFCJMOAPegQu24g34LdXC0pTtvt6I0QKyroQxPDj5TLUE+ZuywepQRW12xt1c5XKeX+RiU0eu99AGOc1i5Q7VoiePhsl8Vi9G/jUvCBBIgVbF1vpk=
Received: from TY7P301MB1984.JPNP301.PROD.OUTLOOK.COM (2603:1096:405:38d::6)
 by TY1P301MB0105.JPNP301.PROD.OUTLOOK.COM (2603:1096:400:2e6::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.8; Wed, 28 Jan
 2026 14:45:53 +0000
Received: from TY7P301MB1984.JPNP301.PROD.OUTLOOK.COM
 ([fe80::961:aeb3:eb77:bd7d]) by TY7P301MB1984.JPNP301.PROD.OUTLOOK.COM
 ([fe80::961:aeb3:eb77:bd7d%4]) with mapi id 15.20.9564.001; Wed, 28 Jan 2026
 14:45:53 +0000
From: Ovidiu Panait <ovidiu.panait.rb@renesas.com>
To: Pavel Machek <pavel@nabladev.com>
CC: "cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>,
	"nobuhiro.iwamatsu.x90@mail.toshiba" <nobuhiro.iwamatsu.x90@mail.toshiba>
Subject: RE: [cip-dev] [PATCH 6.1.y-cip] thermal/drivers/renesas/rzg3s: Fix
 inverted reset logic in devm cleanup
Thread-Topic: [cip-dev] [PATCH 6.1.y-cip] thermal/drivers/renesas/rzg3s: Fix
 inverted reset logic in devm cleanup
Thread-Index: AQHckGGUXBUEXPrds0y2MT821y2RMbVnqF8Q
Date: Wed, 28 Jan 2026 14:45:53 +0000
Message-ID: 
 <TY7P301MB19846F4567485E366FC20509D391A@TY7P301MB1984.JPNP301.PROD.OUTLOOK.COM>
References: <20260128125840.6801-1-ovidiu.panait.rb@renesas.com>
 <aXobun68mrXuVr45@duo.ucw.cz>
In-Reply-To: <aXobun68mrXuVr45@duo.ucw.cz>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY7P301MB1984:EE_|TY1P301MB0105:EE_
x-ms-office365-filtering-correlation-id: 4601f0fc-1a44-4fc7-0df1-08de5e7bf011
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: 
 BCL:0;ARA:13230040|1800799024|366016|376014|7053199007|38070700021;
x-microsoft-antispam-message-info: 
 =?us-ascii?Q?VxpuX3UClXXaaBAQCxXYT/xBRCUBzoCmuII5UJ8Sjaw+ij6rcbWfB4XsD++f?=
 =?us-ascii?Q?senXw8oQq5HMknRdjhx9T4B+Iiw2UP0Dzcdz+snBim3D9OUzSfj+nYCIBEI9?=
 =?us-ascii?Q?vmTzvw9Anx864QwjCo+fDzI1dlr+S/LXIMazVeJQfC+GAhhu5pKHpaCFQ12S?=
 =?us-ascii?Q?ZUMIhGPzrOHurqWEnOMPp+m2WQysZut2WOw1Od3PPXYtFMVkedYc0bJFdRyi?=
 =?us-ascii?Q?j96XQ4zJ9iN/EAVd69ADQ3lVVhlWVPyrlICcgvWm0zfA0QT5skkhanvayZtd?=
 =?us-ascii?Q?cTvSdT47epAQvwZEmxeP1yVMvMihrdpp273N+0uqthjT/gu1Dz8t5+NgzGjJ?=
 =?us-ascii?Q?FDVfBiCHQ8+Ot1cBMAJ5VpQsayBvDQ9G1uSyRQaKzczPOPGrERp1gEGvk2OM?=
 =?us-ascii?Q?gsiHnVwYdvM3z4VGDyF6MLxg7cL5Wb3a1iu20La3MAhdor9uH7LcoAKjdAQa?=
 =?us-ascii?Q?XuVxZxwL1ZHkfaehK2J4xtWV+U/5BIqc9DjGBYRNfH4bKt+eTnOzpbcaq1Op?=
 =?us-ascii?Q?UBno+ZjyMfAa0c3D1MWi+I+HIqZWyYLiABtgNYJRjkqYK1lo4K5mWjmh18+v?=
 =?us-ascii?Q?XDz7RbOrKyEqKz47xcOZq/sMqMa2B3N95V965X+LEto/NAKGpHEA1inWE/F8?=
 =?us-ascii?Q?bZQ2JM9S6uYC78s7zoBbjs9SoAMl6oqIoYcLiLQmCmm/mwtMx55HpBQ/xxmC?=
 =?us-ascii?Q?fYbB1fkRCauKgqYrg2FcFgr4liTgLj09sEKV9rO+Zp17+5oj09pH81nTJ8Jx?=
 =?us-ascii?Q?Rs5evtJ9EpS9rHIn2bV4GFGJMHZ908X5tQxrp4x3T/UcXSUNSQvHs/5LWOh3?=
 =?us-ascii?Q?/3lagVNHf2Df46IDEvuXXTimSlLKeD/47mtShNA9dsj3VSaKUi4LnyB8kaqO?=
 =?us-ascii?Q?V2H9RU37gnZL1PZA7Uzv+yj2hxiLUOpxVLAX7ZFbIcqgo7S9D34hQOgiJsF5?=
 =?us-ascii?Q?FI0rGfFivz5Xh38M6KwPgYe7VXUlfukYQ8ak4cBFvjZ1Iq6kiM0wy9u/B8wV?=
 =?us-ascii?Q?pYrzyjRM+akcBSNkDRQmQCY7a7SFq5nV93tZZjAuY3Z+8HNn4Xwh7Xg6KavU?=
 =?us-ascii?Q?G/MfrvMpSfD6+TEHIWqSveUwUI1jHzQsxTTFmcVFW+FsN5OKl/+lF0o2YesS?=
 =?us-ascii?Q?EBf3NaRkBWi0UR0qELIu95urqOcolYROi22kLkVVL5assO8MXedTBSU8Psoh?=
 =?us-ascii?Q?6mXagfVl3Qmk7+HXzzBcjgAdl1BS/dmJ3o6MAeQecWBGcQiuvHYZXhMwxi+Z?=
 =?us-ascii?Q?7YvitfOAKqJwIJYXSqsXVqwrouwc8ZXo9izbdrTjXU3D3roRtadhE6G3g5Xm?=
 =?us-ascii?Q?FHoOtsNw8BtR29Z/ZgMIaKLIrlmBnqh9gnNnhwA0Kq18lzW4EWuPGM7hieh9?=
 =?us-ascii?Q?IwkQFdeo4zj9edIVmocdaCSnxKNONnt2KzNebplRB8uAI6yQtZiPD+wEXAyf?=
 =?us-ascii?Q?+MyFdQt53H53muYg5GGHLt2BeEILAdFULjbvpQPmOLIp5MDflmMHCeNEve7z?=
 =?us-ascii?Q?i4bomSsjSMy4JOqAq9wMUeNsu0Iw1mRX5UEV2bwzJ/1t4VxN1qcy21bFJTc8?=
 =?us-ascii?Q?lurSRrFdKHQr4944MuMDMvxfAE/70DoOgiFBq7BW2G7nk7XwdclZrGVGu5Xf?=
 =?us-ascii?Q?rr+t5lOrZmlXZfLy9RzKp/8=3D?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7P301MB1984.JPNP301.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7053199007)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?us-ascii?Q?O/QpZwEGlBVdURe9H5AVzJOpaGwIfGohx68Sx3WgNppYhJIaVIAYtNKW5Vqc?=
 =?us-ascii?Q?fzducVMeUWtw5z8iLdZzpqjbLUJPSMZ2oNTdtRj6pj89NYDfZDrMaxEp7Os3?=
 =?us-ascii?Q?zvAfSnV/qDvo1YsCqE4e0QgbU6+TGksSJYFTWk1yLNOCt5vSicZkSNFI4gXM?=
 =?us-ascii?Q?SPPcU15N3mj7A5Qjrzl7UDksLB3x5qKaNfiz+waNwK1uJdqlAICbF5Y/havA?=
 =?us-ascii?Q?IdY0h07ecuwFm5+jwFgbLdb9/TKhKbRQB3nSVximK7aIoIiua637u+ghymJ1?=
 =?us-ascii?Q?5O9SyyR0ZAfzYlmvtqEMEn7Bmz8BtKd3ITt2Ysad0DplBDrlT46w9fxqfMIK?=
 =?us-ascii?Q?oe91CuzgGWYbW92pEgLAUGM1TMeLYQx7O7V0cA0t3xtaHAVwuWHjJOBM3DeY?=
 =?us-ascii?Q?op13fF28VUOOPiEdvVgN5m1/JyGS8xK6SRg6dBZJNvRfcwT6DiKnlr6hZDOI?=
 =?us-ascii?Q?PvteeBRbaoresIlED5wOEcooUyQjS5QDWOp/Bh2YRsby/nRsSRwzBnaU/lMi?=
 =?us-ascii?Q?Xb+sPqpIKNowgO2CgCx+tK/dA1bkVrAcEtLzxV1ftbaayO7aoZ7dxmMCWY4+?=
 =?us-ascii?Q?Y6zgi0V6HniozgYFohcsy0xvYsR4YdCX0R7DUD0MsDHeErVpgLMgDzqFKTnq?=
 =?us-ascii?Q?zMISzTW46OgvNQT8QbncYg3xPDI0/lWyWac2la3V2HbOXpJu+03JIVKyYvBX?=
 =?us-ascii?Q?STG8KDf5g6Jz16VjzZKsQLDY/FWzzU97XK1QXtovKIw7XaHqWX1phZDjSKbE?=
 =?us-ascii?Q?Rjh5CiLXcHY/onKf1KcmDI9MGYaam9BaOTb2s92hldG/oJWKFv2FlM0Bd7PH?=
 =?us-ascii?Q?Jeq6NvwX9VXinOg5aMD/E6pT/lvgF0tWuPuQm0KoqyVlCEriviacE2wbOMUm?=
 =?us-ascii?Q?OKIP4qX4i5BHS24M4YQnia3omIZZCS+jLhzVO88CcB+AxtU85Fcaue9+X7/i?=
 =?us-ascii?Q?PgxyRWlDnHndUU7RzgQoiU8On7SRdBj6im4auyJ1Wrta6/CfJ2JAzHs5E3qo?=
 =?us-ascii?Q?NmhmBbvzcdHN1p5y/m3eFMJUQhT+QzAA9sa9hHDfXhm6YmjGiuoyMjGYS+XX?=
 =?us-ascii?Q?Y+VPtl3i+5wrYfM2dC303mcMSASPLveJwHWJLknKKW4I3oL/ZNJuqdNivPgG?=
 =?us-ascii?Q?yaApjtCxFvbgWiWDBf7vqu/D8jABUoJ/Of3Lo+XDmybZAvuaHKK+2mioc4w6?=
 =?us-ascii?Q?l6W+TgHXFS3Fj/NTwFNZcn3zubOGhZ+W7ZTN07VJ5FdFzssfHKTBBqMm4sp8?=
 =?us-ascii?Q?5FQkQmo/lpq5l+ZzExyjqJ4aB1hbQdgpoHT4SV6YrpvhBWGOOJYdqHriKk/W?=
 =?us-ascii?Q?yEcZefrhXSmZYLU+EwKSYEuCdHOpJ9S28eiXNDsaTbGE1ZVM6D+mmXB3I0vd?=
 =?us-ascii?Q?1DYdfeh4JJzAog6OP7xcofun3td5nePisfQ5AK+eFOJpDDyG9PxrxMW1TZde?=
 =?us-ascii?Q?ZNkCWKn22n4etPrUEIYCZdvlaWU7v25OLKCvIrPK1/9J0RksJ1vG+Cuvknwa?=
 =?us-ascii?Q?nodkMtEUOCA+PwswFJ8bWE4xPAbLWU28f87af5YXsU71d8BYNJ0+BzIoz/wq?=
 =?us-ascii?Q?Bk7TNyjSgQlRKSqg/T5R2hczimuMBWr6IYzNZHb/LopYihLi8p83Gz5OqIxr?=
 =?us-ascii?Q?gpTjO+0XpmdeyneBh9E3dydqMigPQjQlrTShtc/wJ6XZcQlkLHH0ym0aWcUj?=
 =?us-ascii?Q?EheLhq47LgOmoef3EvsSY0OHbxm9NDBP8icaYeLHHfNCk6NV4utKDWopwCNU?=
 =?us-ascii?Q?VGnkx7is8AB7EBLlXixarNuH7C+y4YE=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY7P301MB1984.JPNP301.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 4601f0fc-1a44-4fc7-0df1-08de5e7bf011
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Jan 2026 14:45:53.4468
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: G0hDATEEIgQU792xwiqUBEeGb9+szNAbpRFV69rwgkY3dl+B+Pf9OUF5OyKjl3seEylIMpSPAOW+48J2xTUG9MReK/m0Mmnfdzx3trJGs8U=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY1P301MB0105
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 28 Jan 2026 14:46:03 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/21766

Hi Pavel,

> -----Original Message-----
> From: Pavel Machek <pavel@nabladev.com>
> Sent: Wednesday, January 28, 2026 4:23 PM
> To: Ovidiu Panait <ovidiu.panait.rb@renesas.com>
> Cc: cip-dev@lists.cip-project.org; pavel@nabladev.com;
> nobuhiro.iwamatsu.x90@mail.toshiba
> Subject: Re: [cip-dev] [PATCH 6.1.y-cip] thermal/drivers/renesas/rzg3s:
> Fix inverted reset logic in devm cleanup
>=20
> Hi!
>=20
> > The devm reset callback that should undo the reset_control_deassert()
> done
> > during probe is incorrectly calling reset_control_deassert() again,
> > instead of reset_control_assert().
> >
> > Fix this by calling reset_control_assert() and rename the callback
> > function accordingly.
>=20
> Quick note here what if there is upstream equivalent or why not would
> be nice.
>=20
> I have my guesses, but...
>=20

This fixes an issue introduced by the 6.1-cip backport-specific bits,
so there is no upstream equivalent for this patch.

Should I send v2 to include this info?

Ovidiu

> Thanks and best regards,
> 								Pavel
> --
> In cooperation with Nabla.

