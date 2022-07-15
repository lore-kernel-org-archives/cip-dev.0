Return-Path: <biju.das.jz@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39384C43334
	for <webhook@archiver.kernel.org>; Fri, 15 Jul 2022 07:46:34 +0000 (UTC)
Received: from JPN01-TYC-obe.outbound.protection.outlook.com
 (JPN01-TYC-obe.outbound.protection.outlook.com [40.107.114.100])
 by mx.groups.io with SMTP id smtpd.web12.3851.1657871190365193840
 for <cip-dev@lists.cip-project.org>;
 Fri, 15 Jul 2022 00:46:31 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@bp.renesas.com header.s=selector1 header.b=GceoBSzV;
 spf=pass (domain: bp.renesas.com, ip: 40.107.114.100,
 mailfrom: biju.das.jz@bp.renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WCLvK7xoSyMbaWi4wf4laykAiiTnLz56knwYkSXYZX4tfoHz95xLKHEO9bCmSbwvitIH4aS7uDX0zvH4bkfNF/6vNmS95VUWLePA086sK9b91UjECLT1ChiZozmJevNzM6F6mW9CitubChYPEahIXbk+dKvIgkWb0DOqYw41Cvar0FsDzJN8b/cjHw0YDjMH9NNocJY8E2u8zwp2yWnBgr6FLEH4vKi19dMOvzBqQdMK6BBpwc5/M/ee0apZDyrYmF3/kLd1h4lWuchOHWeaP0EV6ptH0KFa6Rx8JDUFhBeoZOG+YBn30KB7uYH8oLeX1p0JY6dQbQQFvt7YqIzE+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zxVNGGUcl8NtNQ4nQpMQs3zFaFvuUOpi9sf43fDd65E=;
 b=dZK4V7Krkt5/9VQaNk85URwbjjMo/DmarMnL5X+lRNnXop7/+wdtybfslIdbw+YtAC8lSotyzUJyUGziTS5D3StUqj9pvFX2MiSKxklFC4euO97qh07l8nR3K2vHagKRhwlu3al+gzQf/ccSM24zexu8CqpYXsHqCApUv+t5eu9yYehEso/8D8TThFwM+eHoCVo+/S8Z8J/llAB9lZ4aUywr5u5Ytj4eZhFEkK0g9F16I+eTlIAmhEtaWxFlQzNIhofCxw891xlbBQTk3TjC36RxPa1tvmJI4sjAdyYAKAi6yloN6M6HG1OLjG84lc7tX3XFM7H8XYow3/KXWHcSXg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zxVNGGUcl8NtNQ4nQpMQs3zFaFvuUOpi9sf43fDd65E=;
 b=GceoBSzVGab3vZztd/S/rCTTfcsg+CYeF97+STrmgabVudmIF3JPM2WRsi2Bm0OidICqc3jQwVUVcLu85RL5lGw/jaKtrVDRn/7PlNgp+iQ95Rv7xDEUeZmgUJ9KRRctXq1rBeR6yUaPuR4gi0gJj9seWYdcLEvWYuCQuHPwNag=
Received: from OS0PR01MB5922.jpnprd01.prod.outlook.com (2603:1096:604:bb::5)
 by OS3PR01MB10090.jpnprd01.prod.outlook.com (2603:1096:604:1e6::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5438.12; Fri, 15 Jul
 2022 07:46:26 +0000
Received: from OS0PR01MB5922.jpnprd01.prod.outlook.com
 ([fe80::b046:d8a3:ac9c:75b5]) by OS0PR01MB5922.jpnprd01.prod.outlook.com
 ([fe80::b046:d8a3:ac9c:75b5%4]) with mapi id 15.20.5438.014; Fri, 15 Jul 2022
 07:46:26 +0000
From: Biju Das <biju.das.jz@bp.renesas.com>
To: "cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>, Nobuhiro
 Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>, Pavel Machek <pavel@denx.de>
CC: Chris Paterson <Chris.Paterson2@renesas.com>, Prabhakar Mahadev Lad
	<prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: RE: [PATCH RESEND 5.10.y-cip 00/13] Add thermal driver and watchdog
 driver enhancements
Thread-Topic: [PATCH RESEND 5.10.y-cip 00/13] Add thermal driver and watchdog
 driver enhancements
Thread-Index: AQHYmB3/Qkt3iQlYlUaJrsjm5xCJha1/DNLg
Date: Fri, 15 Jul 2022 07:46:26 +0000
Message-ID: 
 <OS0PR01MB5922A0492B7405B2D6F409C8868B9@OS0PR01MB5922.jpnprd01.prod.outlook.com>
References: <20220715073916.2321319-1-biju.das.jz@bp.renesas.com>
In-Reply-To: <20220715073916.2321319-1-biju.das.jz@bp.renesas.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 6618c964-a8a8-4f73-5790-08da66361f08
x-ms-traffictypediagnostic: OS3PR01MB10090:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 xc34BGKIeUx7W0z59lHkLkDo8B1fhBVfsGOMDhtYgyHHTK9E8bd1D7oBraVVn+e9nTwYc5LrPWlSh4YwKfydY57dYHJdHHjVyHfAaZJ4JCM4cHgQOgFoDugMvC51MxDG4OtIN+h4qqzkF4Q3kk/4ZKr1Lt82InFLB11dDtoND2+7I7nGfx4MQU/a7gyIi/lUnXKp8SZARThlnXr8e0ax5oczx5p8LFEvFCG2ZZ8BFdmv+0fpHc2PjJGxeGt1Y1mJK1I6xqHbBp7NmXgNMU32/a31W7E2pglmniVeBysp9Ow208cqc86RbMRdVgY5QSRlMBvh8iohEja0bJYRRTJ/BE4+NGwtRULE54JsQ2Z30A9e138b9PY1bu2y/rLWp7nGjsuCsI0U4kBPxWclbutEMLPvmQS3bh+VazE1POoVl9EGTd7k5U+8ApZ5ZnkLCOj+oHH+RWlwBvlRL26wUFerJEeljQD8Lz1XYCSoQ4GWkDeabkOHOI7u11BeMjwblLx64qH2jZI3J6rQ83ArPFYqOyI83s4RVq117Valvw9TQjoNK0kDu0JDSxUWZtQhknx/lY7rlduOOYXMKqWt/VLP54K2JdwuRzr3KqUwhHoIjSI0kRIyZ5IReGpH4XmvSFoQ+QALPMzX/l/Oa/51e7RctBWz4N15oXSwNhAZSi9c3R5+xnFL4zAtEWVXARPJTemgttymYjsx/jwMwFgYESrFKxW7jfmWtgMNVDRMJmM0f6fS7+ugwVXHic9hA8O9L86ycLXEPpk25gLo9BV2wL84rd0/w8PjFxPaQZbj9Sd5kgoiDtMT/lxg04TqoYQo0zrAt5NbvGCzVFV0ytQ1OIZUDVaJa6Zl/9hp/bO9fNCb28xAAxKvahAFC2MMPj1mP74KZb1gMxcQyG5kABOGlQAX6A==
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS0PR01MB5922.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(396003)(136003)(376002)(39860400002)(366004)(346002)(52536014)(83380400001)(55016003)(38070700005)(122000001)(86362001)(33656002)(8936002)(7696005)(5660300002)(38100700002)(478600001)(53546011)(71200400001)(966005)(54906003)(9686003)(6506007)(316002)(110136005)(41300700001)(66556008)(66946007)(4326008)(66476007)(26005)(8676002)(186003)(76116006)(2906002)(107886003)(66446008)(64756008);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?us-ascii?Q?eO8tR0QZ3uOs7j5md1A/VYNWJwAi0q+JYOzkGuxnS6Cf7Q3wIt/YT570w9O3?=
 =?us-ascii?Q?ibEA6szJsAztcgjK975jcHVRMu+vHLaCsM5ROu8e5kMM58d2zap50cdQCTjv?=
 =?us-ascii?Q?J2KTWCkksJlLiMiVZ1UNeGn2nJBhC/8WzvibG0JcZdY3X21F/P9Rbm6TF8S2?=
 =?us-ascii?Q?izC5SmXHI5b3SWZ3Pm91UcoadZiB7rLg5yltsVsAHDJpwHvAjn0bn7HJ882i?=
 =?us-ascii?Q?KXFKn+RyaPGOJSGIVhVymioPz1/70UfmFWcPBSnykKK7E0gfPzbcfFKGcqjh?=
 =?us-ascii?Q?5vkEZsTef9s5LWFdWYg7ufkgrN2R6IAXRufd6At2PylAZVF+weVqR3KnNcHs?=
 =?us-ascii?Q?x7PAam5VkI5Tr1TE6K0XD3eFQJvW/EpdfYEks812k1AcMy7i/ghsd8VUgvSt?=
 =?us-ascii?Q?h+tpyCWxrcegHapXE39m6Jz2u0bpdnPAnwCkjVXAoCmWILQvHsFmPyg5h5M9?=
 =?us-ascii?Q?BO1hxSdOSWg2/+QYpS5pZtzqzlo+CyE1RuQAZr4ryx43rGFd/4CaBOjMGhQe?=
 =?us-ascii?Q?19l3hlosGFZOfvrD7m6oPYG7DDyZGsto7Y6N0MsObjOHpY5EIKSsEuZuc2gX?=
 =?us-ascii?Q?Qlk6Cs1tcTrA3prSK0Zws5jaMbVw7iBhLynj667lQF0fKgHpH47q70FkCG00?=
 =?us-ascii?Q?yGqYX+Gxq2241yAqJ8DJ5KH3ClhZ+O4HvPQZ4vfEm5FqP9LLa9txpgUpnh3G?=
 =?us-ascii?Q?/UpyezJt9HCCHPk9i77jblb9DkZjX5tmPT/xfCohvYd+mxT5HmHh4WnLsg3b?=
 =?us-ascii?Q?RGjB0KBfblBAKJaUubJ1tHwl3NMDs+9ipSK4bWFunsNSpipDf6AwFZMf1Ldr?=
 =?us-ascii?Q?5b3Dg9dKbApTsnWEEy3Cz5Ps778snoztThDL646WtQcSUdKWGrYaFAEA1zZ7?=
 =?us-ascii?Q?76smZwJREicLcIkl6ciH2Y5xO684n18NC7FBJGP7RuKIe4D5HNc11JeROWnM?=
 =?us-ascii?Q?Y7jRN9msihfWK6ycZqVLdZXapYjqXiMdPVRdMmde5GClW1ETwrhUXA18qVbm?=
 =?us-ascii?Q?/PUM8eAw4bRZffpTib5QO4fcT+yVkIxI2Oox4Jrc4Q1bi3QC44AKKXuCaRHD?=
 =?us-ascii?Q?cl7kXUClOTABv+qX3W31YsF+0v/YXz54GsZXSJgE1r+1wasIAfwt6Cw+B8SC?=
 =?us-ascii?Q?QytvBCPqW0dITispu/y+ms0kCMkt08EQUPWz7Q/SeMFL2zVDJyXQ3TKU4uLY?=
 =?us-ascii?Q?RAwn9ZYhI2/HzJb1d6jpeRj5mod8ZHeQ5sQkTXF8hzib5iP1uac6PbnT/j+B?=
 =?us-ascii?Q?o2HAIyrUshK2gHHyB1I1mlaw6MbhyGYVaSYuOEjHD9IyUj776z0GSRMHEwyA?=
 =?us-ascii?Q?DAU3hSLz4RZKt667syeAfesdejEq5a1uhhyjci2j/cL2gVLGR9n/HhmuCNG8?=
 =?us-ascii?Q?UEPpK+yzLJuuZJAs1GTM/3GQhbL5R4P4uMtaMOvitteeh8cJlXlIi+m80MVF?=
 =?us-ascii?Q?d8iVip3LxzYzo5cyHSfw5V48wi3O4CqXR2ASMwo1TyLcysbgZLwzXWpxIgw0?=
 =?us-ascii?Q?GuZi4ZC63OsKk5+SdFdif6qdowOjdCipvBCEJ8kcVFUnM1Br97/xDduK1wN1?=
 =?us-ascii?Q?sORtKHzQZwuABn1vWL3vcfksJBS0EbNx4aI3OD57yX5MN6htwocLK1+oEsF/?=
 =?us-ascii?Q?EA=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS0PR01MB5922.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 
 6618c964-a8a8-4f73-5790-08da66361f08
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Jul 2022 07:46:26.0628
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 
 7Q8lnPBe4T7pcZqQrmG78IitM9l7r7kCY0cYigrWTS8tbpew6yDIn2540jf8gcxpJUCOQ6l0grsisdG6wDHHIwzuH5rc4ZsXPNvMj2uv33o=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS3PR01MB10090
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 15 Jul 2022 07:46:34 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/8825

Hi All,

I can see patch#2 and #3 of the series landed in [1], but it is not showing=
 up in [2] and [3]. Any thoughts on this issue?


[1] https://lists.cip-project.org/g/cip-dev/topics

[2] https://patchwork.kernel.org/project/cip-dev/list/?series=3D659971

[3] https://lore.kernel.org/cip-dev/20220715073916.2321319-1-biju.das.jz@bp=
.renesas.com/T/#t

Cheers,
Biju

> -----Original Message-----
> From: Biju Das <biju.das.jz@bp.renesas.com>
> Sent: 15 July 2022 08:39
> To: cip-dev@lists.cip-project.org; Nobuhiro Iwamatsu
> <nobuhiro1.iwamatsu@toshiba.co.jp>; Pavel Machek <pavel@denx.de>
> Cc: Chris Paterson <Chris.Paterson2@renesas.com>; Biju Das
> <biju.das.jz@bp.renesas.com>; Prabhakar Mahadev Lad <prabhakar.mahadev-
> lad.rj@bp.renesas.com>
> Subject: [PATCH RESEND 5.10.y-cip 00/13] Add thermal driver and watchdog
> driver enhancements
>=20
> This patch series aims to add thermal driver support and watchdog driver
> enhancments for RZ/G2L platform.
>=20
> Resending this patch series as patchwork is not showing
> patch#2 and #3 of the earlier series.
>=20
> Andy Shevchenko (2):
>   kernel.h: split out mathematical helpers
>   units: Add SI metric prefix definitions
>=20
> Biju Das (10):
>   thermal/drivers: Add TSU driver for RZ/G2L
>   thermal/drivers/rz2gl: Add error check for reset_control_deassert()
>   thermal/drivers/rz2gl: Fix OTP Calibration Register values
>   watchdog: rzg2l_wdt: Fix 32bit overflow issue
>   watchdog: rzg2l_wdt: Fix Runtime PM usage
>   watchdog: rzg2l_wdt: Fix 'BUG: Invalid wait context'
>   watchdog: rzg2l_wdt: Fix reset control imbalance
>   watchdog: rzg2l_wdt: Add error check for reset_control_deassert
>   watchdog: rzg2l_wdt: Use force reset for WDT reset
>   watchdog: rzg2l_wdt: Add set_timeout callback
>=20
> Geert Uytterhoeven (1):
>   arm64: defconfig: Enable additional support for Renesas platforms
>=20
>  arch/arm64/configs/defconfig    |   4 +
>  drivers/thermal/Kconfig         |   9 ++
>  drivers/thermal/Makefile        |   1 +
>  drivers/thermal/rzg2l_thermal.c | 248 ++++++++++++++++++++++++++++++++
>  drivers/watchdog/rzg2l_wdt.c    |  83 ++++++-----
>  fs/nfs/callback_proc.c          |   5 +
>  include/linux/bitops.h          |  11 +-
>  include/linux/dcache.h          |   1 +
>  include/linux/iommu-helper.h    |   4 +-
>  include/linux/kernel.h          | 173 +---------------------
>  include/linux/math.h            | 177 +++++++++++++++++++++++
>  include/linux/rcu_node_tree.h   |   2 +
>  include/linux/units.h           |  22 ++-
>  lib/errname.c                   |   1 +
>  lib/errseq.c                    |   1 +
>  lib/find_bit.c                  |   3 +-
>  lib/math/div64.c                |   4 +-
>  lib/math/int_pow.c              |   2 +-
>  lib/math/int_sqrt.c             |   3 +-
>  lib/math/reciprocal_div.c       |   9 +-
>  20 files changed, 544 insertions(+), 219 deletions(-)  create mode
> 100644 drivers/thermal/rzg2l_thermal.c  create mode 100644
> include/linux/math.h
>=20
> --
> 2.25.1


