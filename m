Return-Path: <prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F317DC369BD
	for <webhook@archiver.kernel.org>; Wed, 16 Apr 2025 10:56:03 +0000 (UTC)
Received: from OS0P286CU010.outbound.protection.outlook.com (OS0P286CU010.outbound.protection.outlook.com [40.107.74.9])
 by mx.groups.io with SMTP id smtpd.web10.16289.1744800962456982609
 for <cip-dev@lists.cip-project.org>;
 Wed, 16 Apr 2025 03:56:03 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@bp.renesas.com header.s=selector1 header.b=Bh+KGBf5;
 spf=pass (domain: bp.renesas.com, ip: 40.107.74.9, mailfrom: prabhakar.mahadev-lad.rj@bp.renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZAAfBqlchxOs3+GDm/MVkXUhvNRcVxlxHNMnsOwSrv0P8HEddVcY1iyGw+HHOvQ4JnjFEUlbWpvhIr8I8fAV2izf3TBUP9FAZ2d3xQiLs1a0PvwegExhE73hpOSQeDENKOBSXkHS2yj+ykcMh0gueiajHuLWauoAJ2X9RozUdOL8cV8mi2ASJKFlXZibWO9hi8Rt2HE+uGQDnTA6zjxtqrX44iUZLQSRTSN1WTzUQWgW/WL1c+dS2yAdr1rjJJ+k7nIwjQPQBTILeHdEHveJ/zDCFqbrVIAZkjmqvj8wbzYTyxXG5hRaWIPjTWKXzjCfySZsmg0+5DabJZsk0o6yrw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sdyf3qqx2n3Fwc2R2VQD39NYhcZt5VfkwC5OJVpoYP4=;
 b=Xr8DMsogmofrcCaWSF+5/uHokaJLy7vQn7GAaCrvblDzGUe+LoL6aymG32/EIY3tQ/mTG6zBg+MYtDdDTZylva8g8K5Ws4O7RMZsAof1vG7rcDYJ06gdjy+faJAgX2nnqtcaC3lONl96xt1PjWexAAXMXLGNzmnl7nog0phtqCv2QnhlI05+aPXbT49FujPWbwmjOK2aZ7SU3dZv0JCS2+wgRAURqAFy6S79M6a4/Tj7Fz0joxlNVyzTReEseIIkOH72OyEMl5wI+HrTeyzHeDqCsIzHU3WkJ29LMgy2MWLWrDU6ZShRkVlSgnXJaZ52XW8lK2X84NtyOqmA0M9PYQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sdyf3qqx2n3Fwc2R2VQD39NYhcZt5VfkwC5OJVpoYP4=;
 b=Bh+KGBf53gAp7iwTaai7OYlWeuyjL0Op54vHVN2ES7R2wM5jk/rlzt96Hqk+O4KsUwjQZ00IPgMy7Ihhvct0QZctF/iGqtyjG/L30HuvoTimN86KMdeyXrmt6OL7S+4fRSZaIzFV/pmsugUMFEDl25hJkd33n5/x+p0A5zUVbB0=
Received: from TYYPR01MB7024.jpnprd01.prod.outlook.com (2603:1096:400:dc::9)
 by OSOPR01MB12411.jpnprd01.prod.outlook.com (2603:1096:604:2dd::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8632.34; Wed, 16 Apr
 2025 10:55:53 +0000
Received: from TYYPR01MB7024.jpnprd01.prod.outlook.com
 ([fe80::39ac:b8e5:61e:8037]) by TYYPR01MB7024.jpnprd01.prod.outlook.com
 ([fe80::39ac:b8e5:61e:8037%6]) with mapi id 15.20.8632.030; Wed, 16 Apr 2025
 10:55:47 +0000
From: Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>, Pavel Machek
	<pavel@denx.de>
CC: Biju Das <biju.das.jz@bp.renesas.com>, Prabhakar Mahadev Lad
	<prabhakar.mahadev-lad.rj@bp.renesas.com>, "cip-dev@lists.cip-project.org"
	<cip-dev@lists.cip-project.org>
Subject: RE: [cip-dev] [PATCH 4.4.y-cip] ARM: shmobile: smp: Enforce
 shmobile_smp_* alignment
Thread-Topic: [cip-dev] [PATCH 4.4.y-cip] ARM: shmobile: smp: Enforce
 shmobile_smp_* alignment
Thread-Index: AQHbpUgQJ4XZlFPttEOjVvE3iV3PDLOmMT4Q
Date: Wed, 16 Apr 2025 10:55:47 +0000
Message-ID: 
 <TYYPR01MB7024C8C39B7B1226B7924447AABD2@TYYPR01MB7024.jpnprd01.prod.outlook.com>
References: <1833151A32081021.4816@lists.cip-project.org>
In-Reply-To: <1833151A32081021.4816@lists.cip-project.org>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYYPR01MB7024:EE_|OSOPR01MB12411:EE_
x-ms-office365-filtering-correlation-id: ece89534-232a-4aef-89f9-08dd7cd53e71
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info: 
 =?us-ascii?Q?s8LP61mHx1nT66KUNP80eIcRVwPt5J0Ck2Kek2CbmLgPiECfodMY6sO07sLe?=
 =?us-ascii?Q?8fv43aSfkU5D5yvKmr6U+YRX3n6pVI9oybfJIyPlvxjj35UTwaNMgGPocJ7K?=
 =?us-ascii?Q?Z7LREkIU9hJawZY+TAfP/QUfdudseuj1IUCEOM8lgXmpns6+WfXtDn7PctNB?=
 =?us-ascii?Q?lWL8U+Koydcr4PAszopmZxchoqPx7Vc55AYwkudOwEPKxFHYeZLeZsQ8h4W/?=
 =?us-ascii?Q?sqJE5CiAEN1vdscSmMO7aMf0wbkj70KedodZ8vlpJ5Lp0AcQEbucZK7GBEeK?=
 =?us-ascii?Q?G0K9kP7+lycTP77Eh2zyzLI0oik0o1D34WBcm7ECNnWyiATC45OaadFdPpCP?=
 =?us-ascii?Q?c7bX1TeP63Zab5V5+1m9pfGiKoXQkbsArxlh3xcPUcpHqBayisWBFVHQog01?=
 =?us-ascii?Q?UuOVCbmwrLbuDk+vH5s7yb1Hps3PvIqbw+wbU4wWFwwurZ6Pgg4/RyV65dOb?=
 =?us-ascii?Q?MISdUy2s4x47m04saI20u0M/mGLtQi1NEiijcnwrO8mJFEYn7t4wKS1v/SE5?=
 =?us-ascii?Q?JpqGeakJIPhSBwBXHaZnCk9HQEUTt9TkDQUsxS7++RYMpbVdSAAmOzmXsHDA?=
 =?us-ascii?Q?Uoxop9gUPbVfZ47SZNsVP9S7jeI5Uzk/QUqq4X7xaTWapQ0s3y5VmqqxphiF?=
 =?us-ascii?Q?tP2PvmYw5OcrcuMAte5eIr3p+6XNbP147/uBRYsZQZNXttprmQtnA9+RBtB3?=
 =?us-ascii?Q?hlgfi18zQe1LV3GdChmDQ4ek/O1+w6lV6L1TRwt6E5viZcsJeo6Lr8FQmd3z?=
 =?us-ascii?Q?42na/aaDBrCMmc/rZ8+FD36bcS6P+Z/PMQWV7uQUwTJghLmxxixyRoA95HHq?=
 =?us-ascii?Q?60jw2bhqbiw2GAzadn4lMfbujJjDaGhvZKHW6/105w4EXQjWRLqqPFd0TJCW?=
 =?us-ascii?Q?fq5AFU0aUfLrD5M1K0sfR0WdSKeyKwe9Ixo+0NV7kkQxyG3j36tUfuNxOGa0?=
 =?us-ascii?Q?RNSfvcYG/jmxQz+lX/jbmg6zQGfuRJAm8BhQ9zglMaxDGOvrjW19NIPOyRvw?=
 =?us-ascii?Q?mCs7RTA9BRo6ETOaH102Ix8ceriZ0EBlysViY30lj1YWKnD6iNqnMjWyTPpR?=
 =?us-ascii?Q?z6LW1gRtf4PSaW9vAf7FGrMEgX577Y4sw7RRi7/5OdVXO/S5r97g0ETTipm4?=
 =?us-ascii?Q?jfVmFeVfmEokjc9UrM6BrExBaneOlP0A3KidwBb0H2yGuHNftlc6B3+8RmTM?=
 =?us-ascii?Q?npCyolyn52Cd49KW1ClKO39zFxsb/AOY3zcJG1doQi+LEQuhNTyjZqAiS1VZ?=
 =?us-ascii?Q?LC7uhMwuTg/r00HlvBNSMWmrQrA2cL1Y4bFpaGvyK4q5uoIMDIOkTLLjQ8E7?=
 =?us-ascii?Q?CsMbV8OI/4btCf9lQJfMcH979Hk98f2oJ2gRAzrnW2KsKtBVzOb1vWx9motI?=
 =?us-ascii?Q?XaUHWHFALi2NwvOFUBcpDpFkjhUurIGhRMF1Cv841Z/sfq89gm8ZzlOe8kmk?=
 =?us-ascii?Q?NkZ643OW0ZWf3qiZHDV9O4PvzvL1/vqsL1zPdD8+fC0WtXGuu6DX5fLqjP1W?=
 =?us-ascii?Q?zpMEelG9DG1AEio=3D?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYYPR01MB7024.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?us-ascii?Q?K0WzD21kESFKSRmea4G3vvRfxkyMX2AB5apU7eAGedneT5MwxIBw9E1ZZQWT?=
 =?us-ascii?Q?ah4hrBPhp652fj8227AZwCDO4TedSf9xv+hOHH7JMhK5hle6d7YBFq9clAlm?=
 =?us-ascii?Q?oj5qVVNptVyozrZUzzvl6nUDbmCbEM4NLHZEB14TM77AEVqo+0uDp0449Pp4?=
 =?us-ascii?Q?hEqeJvDIvjDhHy9eLtA3dbcS1iAextYpu38fr9qisVm1i5L8VYJfiRqKtqLo?=
 =?us-ascii?Q?iH6QKN2k4IJ+gpSm7oGME3ZZGb8fhMs6pOexFio3JUTSk8kJzYXfCYLrHibC?=
 =?us-ascii?Q?5SRkyQ8A32S07jC8BX1R0OlHy1DzSYJWOdoCsOPl5my1NZiSs9T0xOVOpjwz?=
 =?us-ascii?Q?UVmt7vwQclbFmiW9tWLUr5P+ie6VJKrpb16jNpd7SNOkv/Uz215i6TOA9tIH?=
 =?us-ascii?Q?zhVpqRK45gatEkhVnFj4DsG9t3b2mcG57PRfknkckSxPWjuR4fbARfNMKEh+?=
 =?us-ascii?Q?r1lR8V/p9W+i4TaHo6XHlEWDbDlcMa2KjpHs0gFUV9wl0MhK7eRFQeFTc7bm?=
 =?us-ascii?Q?drahVQ1bH4uu9zHqnmC84tq2tLmSc41P0A1u5QurhrzSJiiMonyVNK9xi24+?=
 =?us-ascii?Q?JBZlDTxTMjvA9tkic4JwE5bDRrygXUbtQrHwKrNstGQ/TNQSKiJuALJ8kN0w?=
 =?us-ascii?Q?UwuzHMxguA7LjQhropkMpsZga17pmQlkuLeZeFMAYfLgz7izE5pqmtAWZ7Y7?=
 =?us-ascii?Q?exgC/2iaiUstlFtBkmXJWJyvsn6yD0CedOE2QJQoCsj59FaRBAW2yUwuYD3a?=
 =?us-ascii?Q?LvdmgkKMUs2rTcMMX6C7ydbwCQ+m5XMTVk8c9N3v6llgOtLKSDRyI2yYQWXD?=
 =?us-ascii?Q?vXmTwD6zOSRu5fUAcVPG2jszQWO4nm3lcLAENLvLweHOgGKR53HYcQaWW9S/?=
 =?us-ascii?Q?x7lRwnpIpQUu7BxJPBrVR8mP/LNjfvEUTvZdImu14ElFmj0innXDSBydIxVf?=
 =?us-ascii?Q?n9J2uivy3u8ZvngiGDmoS1JyiGFD3PERayrhY6A7Lnx54ii9ik7hu7bKe333?=
 =?us-ascii?Q?TJi0cVImmefisP8V7/YsBItYL/956C+ELiDblRhuZXdZbU2PlAHUUc5jTqn3?=
 =?us-ascii?Q?nv32Iv64p1HqjF1CiESNYFtC95+rbHV9omOjcl8D6hgBi47tyM2iPgtO8JnH?=
 =?us-ascii?Q?Ei8lYP/b6ebf1+mDOfDiyHXAi1qgaQr32BqYphlJOgNQqtMim1jc3aewsVuZ?=
 =?us-ascii?Q?yc5mmktqepglOb5lBhTVENf02OoVaDlcMU67nU4VOu/QaL4Y5BJVoxNA/bqp?=
 =?us-ascii?Q?GU1htHQPTOuKjJCVDwabT4s0wH83MOcHEUv33jBxfTMSy20nxohJK0GwdhX3?=
 =?us-ascii?Q?sdOYWkterKudOL403+mw8qVAC93RB3hL9DTqGAiSU+w4NRhdl6GbkkaFKsdR?=
 =?us-ascii?Q?NzG8VfsvqSEg6Zx49AL5iPFXiCF+UE6UPEK5eYb1gqiNpEeW2x+qDHXeIx75?=
 =?us-ascii?Q?nYvFUA6nTWAElMCaiqqjkdny6brXkdQFIA5glpAsDbjoxOJTR16PwBwcRV9x?=
 =?us-ascii?Q?Szjd9+R+rKoOfiGTSLDgAvYySwrRXzmD4y/YGVwcOLWvT1C9K+aQVEEW2k8j?=
 =?us-ascii?Q?bGx5HbBhQi466r3CnZfaP48shiq+UbvEsvR1zCHp9DiCsQ8yjsVZco0ZjMI0?=
 =?us-ascii?Q?FF5UzNMtQDd1ElN+BXFtFvE=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYYPR01MB7024.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ece89534-232a-4aef-89f9-08dd7cd53e71
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Apr 2025 10:55:47.3507
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: dlym/TSp75pj5DNnVE6hTkEKHcJFNVQdVvuwBC+8cy6Fu7jrxlDWm4uN3GrTrJZ/XIdup33Wud7+TFJNne3ZlfjYjFgPt1pIkVe0KFc13sXwJzPnECxb0RYsmIs79lQH
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSOPR01MB12411
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 16 Apr 2025 10:56:03 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/18509

Hi All,

> From: cip-dev@lists.cip-project.org <cip-dev@lists.cip-project.org> On
> Behalf Of Lad Prabhakar via lists.cip-project.org
> Sent: 04 April 2025 10:58
> To: cip-dev@lists.cip-project.org; Nobuhiro Iwamatsu
> <nobuhiro1.iwamatsu@toshiba.co.jp>; Pavel Machek <pavel@denx.de>
> Cc: Biju Das <biju.das.jz@bp.renesas.com>
> Subject: [cip-dev] [PATCH 4.4.y-cip] ARM: shmobile: smp: Enforce
> shmobile_smp_* alignment
>=20
> From: Geert Uytterhoeven <geert+renesas@glider.be>
>=20
> commit 379c590113ce46f605439d4887996c60ab8820cc upstream.
>=20
> When the addresses of the shmobile_smp_mpidr, shmobile_smp_fn, and
> shmobile_smp_arg variables are not multiples of 4 bytes, secondary CPU
> bring-up fails:
>=20
>     smp: Bringing up secondary CPUs ...
>     CPU1: failed to come online
>     CPU2: failed to come online
>     CPU3: failed to come online
>     smp: Brought up 1 node, 1 CPU
>=20
> Fix this by adding the missing alignment directive.
>=20
> Fixes: 4e960f52fce16a3b ("ARM: shmobile: Move shmobile_smp_{mpidr, fn,
> arg}[] from .text to .bss")
> Closes: https://lore.kernel.org/r/CAMuHMdU=3DQR-JLgEHKWpsr6SbaZRc-
> Hz9r91JfpP8c3n2G-OjqA@mail.gmail.com
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> Tested-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> Link:
> https://lore.kernel.org/c499234d559a0d95ad9472883e46077311051cd8.17416122=
0
> 8.git.geert+renesas@glider.be
> Cc: stable@vger.kernel.org
> Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> ---
> Hi All,
>=20
> Note:
> - This issue has been replicated on 4.4-cip with older compilers and
> CONFIG_CC_OPTIMIZE_FOR_PERFORMANCE enabled.
> - The offending commit 4e960f52fce16a3b is not present in v4.4 release so
> this patch wont be backported into 4.4-cip by stable hence just sending
> this for 4.4-cip only. Please note this patch has been cherry-picked v6.1=
4
> release.
>
Gentle ping for review.

Cheers,
Prabhakar

