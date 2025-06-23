Return-Path: <tommaso.merciai.xr@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78E87C77B7C
	for <webhook@archiver.kernel.org>; Mon, 23 Jun 2025 14:48:42 +0000 (UTC)
Received: from TY3P286CU002.outbound.protection.outlook.com (TY3P286CU002.outbound.protection.outlook.com [52.101.229.13])
 by mx.groups.io with SMTP id smtpd.web10.417.1750690118613011798
 for <cip-dev@lists.cip-project.org>;
 Mon, 23 Jun 2025 07:48:38 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@bp.renesas.com header.s=selector1 header.b=L8tGQJcJ;
 spf=pass (domain: bp.renesas.com, ip: 52.101.229.13, mailfrom: tommaso.merciai.xr@bp.renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BhQu8FFZvqCCLDuLQmSiR6WlvRT4Prqw6d5Rfc3mvn9j0kptVIXz4woEk9kDJ4S6OrzJNqsD0xv05/3NtNwPkEZLDA6aGMNC0ZVhugvf0ey1DgMncZwEKBVWtiDVaBfBmqMBj3JonYQmc35+N9ooRxdksJaxP4cBokyQm9RhYYusYtcO/O7C/Kh5t0Mm169acIvzbg3EjPhwbkDqPTgZSeb5tMSCATcNN4kwWflXGCGLoPLzNo3NKiF/AxaGF81K3aGNOmQ/JtNxEmCTFyQrEVTfk85qEeoWUYcmy7/tOKRw3pAE0FpL+pghahet6iW1GpLqVh2PEAf2M8fcWtar3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8zGN0Ufd44Gs9AdnwH9YsRZdojwrJwWZ3AOKuKTozDY=;
 b=RtGf09JOt3R0ItdL2CbdDpGq/uhW/Hb5yAv3bkbaAD4T9uc4jzdcjuZ8dj+KUSv25wpTOaRDwnNYMw8HBdMvBjfrjg0MYQxUvpA0YKA8rBQySWQ0+AzH9L0bcg65hqV0TZM09NpICf1LHoA0km3fCAjMBwAAwT4Bu9uOHpVeeOBhFZxrbJdPAZKtpbZpSrdl2jghrR2uNM9kItl5IcXr1PyobtXjDStyPfl9JArBXATudpLxF3Awwj3nkNaEDkbjNUVKvwr7JGbq1iB9spKGq76vwYdbi8SD88pNenRImXFQ06IdrK0hl9gZqkG1dpd8Q6ftxdu0hqTqBK5IBI3uCg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8zGN0Ufd44Gs9AdnwH9YsRZdojwrJwWZ3AOKuKTozDY=;
 b=L8tGQJcJWgbbuXfnQgccgjLHG+mn8OZ3EfKpP51ivaiUvQWwX6hMqDoIBoD1oggOdN/W/ySQUopmBsxD5oxODU9IjCdKJ0+H6d3DCnpkuibFQHgJQJ3Ou+0f5N0o+KSifla+DnLt/SO6L02ZI0PXEQGtAuKmYVHOIsUozoWlJvA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
Received: from OS9PR01MB13950.jpnprd01.prod.outlook.com (2603:1096:604:35e::5)
 by OSCPR01MB16379.jpnprd01.prod.outlook.com (2603:1096:604:342::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.21; Mon, 23 Jun
 2025 14:48:36 +0000
Received: from OS9PR01MB13950.jpnprd01.prod.outlook.com
 ([fe80::244d:8815:7064:a9f3]) by OS9PR01MB13950.jpnprd01.prod.outlook.com
 ([fe80::244d:8815:7064:a9f3%6]) with mapi id 15.20.8857.026; Mon, 23 Jun 2025
 14:48:36 +0000
From: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
CC: Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	tomm.merciai@gmail.com
Subject: [PATCH 6.12.y-cip 00/10] Add support for RZ/G3E SDHI
Date: Mon, 23 Jun 2025 16:48:07 +0200
Message-ID: <20250623144817.2119838-1-tommaso.merciai.xr@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: FR4P281CA0422.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:d1::16) To OS9PR01MB13950.jpnprd01.prod.outlook.com
 (2603:1096:604:35e::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: OS9PR01MB13950:EE_|OSCPR01MB16379:EE_
X-MS-Office365-Filtering-Correlation-Id: b4a6d95e-d6e6-4444-1091-08ddb26508b2
X-LD-Processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|1800799024|376014|366016|52116014|38350700014;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?GBeKn5diw+hFHxmeBaJGqGiIzdbLjBcalGC/tfhmOKgG+9dbd8+CFOClcpy2?=
 =?us-ascii?Q?V5dOovtnS3RIqblpnDKX3XXdXUWIWIQK9V/ounWOTYhBsvawX8abZiDoVTnA?=
 =?us-ascii?Q?ppboHwkFUztT4t98Ws0VfjicbjN/1yDOUNbOPseEMbRonLCIl5qNCnrwa/fh?=
 =?us-ascii?Q?+S3q55hduUB7x5W4kwjKx215ul6ATzsgR3U03eOL/VQ7dePgdBKqyAnRYIqf?=
 =?us-ascii?Q?veD5jPVysASd7YMbdYpthQSpiShp8JDoamBHHF74oBUT64+mHjR68RwBNer/?=
 =?us-ascii?Q?uj9d8C8wiLy5IbeGWvzR2H7QyiRyggm9SclyyDeyG/Wtt0QT12yUW0XkHW4W?=
 =?us-ascii?Q?IOU1MeqlEZJJYdeQGhhOQR3NOhtwgyoqXRoF4+OfBnFHegN7+8ezBjCzrjrl?=
 =?us-ascii?Q?yoSzxWI6/KqTGhJmzFx1VUqzxiHslNblJaE0LkXYdUkjRlopl8ukMgDYvGuG?=
 =?us-ascii?Q?zwLEgsiJKW6uar7gHuNsoZSncOLDDd8EMQMF8UAm+atpJ0J0IANnHpINdz6h?=
 =?us-ascii?Q?y/u8NEex5bEuQN1ofvzwBRLnhkF4GSA9UlWP+TI0jLzq8buwpiCll0VdkLyI?=
 =?us-ascii?Q?30tzYeeHwfEyw8Fv9NihgyBN/GaY+VAPFzRLZy6iBxtrmIW3Vm3NNR7Tfpw1?=
 =?us-ascii?Q?LcGWWGEjSkMSiiX4dw1HD+eU0odWcBD28lCKdJX9/RFqvCOQlktKwFD6eOsA?=
 =?us-ascii?Q?Xs7TL+j1myjp20bEKHdYK+wlsgtf7IJYf/Bi6rx43xQ0rMcIzgPUjoVaWoEZ?=
 =?us-ascii?Q?BzYI8qOMtKuV4kun6qxN4hXsHAIjppnQOBpZJziizEh9nYV5DiZFTLbGmq8l?=
 =?us-ascii?Q?rkyD+By731tbusMhN+28fVij/EEmcYyMxuNuOcqmKp9Aejq0J4482p0Kamjw?=
 =?us-ascii?Q?JOCYWprnnzYYB7Bx1fv2hyych8V4NrEc0wg0TSih5AQxGn5JxwUiul2OKDoj?=
 =?us-ascii?Q?cgVq/OKvCClLRAMqRWHFeUdzbP/MpUVa0rpTGW08i4XYYJBsNdvt6QqiyezK?=
 =?us-ascii?Q?Sag8HOnDMTF0uHrMT7n/YEbVpjzvg+uL2wLDice7Q0e6tVsYufjPLqrf9iKt?=
 =?us-ascii?Q?B5IfVJbxdWO5cXEK5BoIZ8FoZviAZUOYJzUr1XnHcT1B+wppMhjgK/JUPT5b?=
 =?us-ascii?Q?GBreupwD6aPDQ95kGXTgVDLQwzZfndN76F7ZdnaNantbFHgcS/0amcExlLDc?=
 =?us-ascii?Q?/Y0VwQZZBZSywY/jK5Cg09TLCpIRWax9nEEoRGclx0H4aXuL/k4+X9LTR0n+?=
 =?us-ascii?Q?9wSTsVG0bncGFXhilEq2uD7Oz972L9GnLprRrh8u/uF1+4wJxONSEeTYV1jv?=
 =?us-ascii?Q?auK76LBTGomR9dEUuiahBPGx8UkdazTha9Pv6yyc6LaldZOGYzTUJlkk0UTs?=
 =?us-ascii?Q?GBBLOarWLZHX3jHygss+/FUsr50zqn/IA5kVkmLG/KQfsR9RwecJcNKUTVuZ?=
 =?us-ascii?Q?Tf6N98R8cD4uV+uWJ1x1twovy9n79yv++fAtt0du+5N6D4EKPuIx02BCYn6k?=
 =?us-ascii?Q?NFDUgxguSr0GJxY=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS9PR01MB13950.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(52116014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?r+azdWrWD5rje55hKAwLcdGmjwCbCl3lfNOTG8F8V53OPte1f2rThJEB1p56?=
 =?us-ascii?Q?hHNGw+r9ARtebivMvgHQ3MNPNHR/zexoatQrhq9XZL9k3f5PR+yN3xpH8zCW?=
 =?us-ascii?Q?lZtqj4lVNtQPStAy7sjkcA7hHHrcJei0Jwr9ZmGUrabHCoL5lbPiGuyWv1pe?=
 =?us-ascii?Q?uYQf/C3jlZY96f9U7pG6eqIYH3UTxAwjXP2/AftfAV/2jRr8xa2iUUzyo2xa?=
 =?us-ascii?Q?E5yo/2VyJIDj+lRA99+DxrHb02Pacj9CN6SM9qeN1sY6N7CAxqwLgbhoMrei?=
 =?us-ascii?Q?/3A0AqnVebxZ4mLg+XY/cQjUW5/Q94e5jcz2RNg3JH9tqg7TCwuXgHjGH6VG?=
 =?us-ascii?Q?a8VKO7jOKrT+jE6lndpfthv32Cou/gvJk76x7J7rF4SiJQQ1PC2F00XVyr5i?=
 =?us-ascii?Q?+y95oKU6EJ8DcgBG4Z5P6o/8B6T+URhnQU/3Na75j/6RxJdgwD5oMdBjxehf?=
 =?us-ascii?Q?tzw9lQRmEwLHYB3oyFfiSRUQo+nrF8ot8vsR/dx4Tl164lw68FvO3emSTANc?=
 =?us-ascii?Q?XSdgI8njbZz1K9oCb1oRgqffpZoJhdLois3/vj4glXh2XdC9/dObHey3ztV5?=
 =?us-ascii?Q?jSa/vmj/GE5+pQlhzDoOEIBncqBJMpCTwOBV2JmGM4lYLKFFCM0MDUUS4zcU?=
 =?us-ascii?Q?c+AyAoo/I78W64/kN3nTYQpD65f1mi94nmSp/nuunlZ3aLYhEMZxkyjD5k0v?=
 =?us-ascii?Q?NtvbBgyEFd/zxJTozhmte2d4cL2K6PbvtB4EtCEwP5A2RejgP1EC02ikIlHE?=
 =?us-ascii?Q?oAeZou3Cjw9sIKqr9Oqp8YGp2OYegJRWhAAmYZJUw2TmKXT+3kP1aJDCC0em?=
 =?us-ascii?Q?hS9e3WObVFsIxxJZGcsx6lyzV7FNqaGBvKw5HXxzcsia7bm2A9v3wWj85PAh?=
 =?us-ascii?Q?h1ia0nAJZpjoiXTTlDfqY7jPtcAJY2YCA3Z0GKF2yF0oVzhPwAlABQ0bVl8x?=
 =?us-ascii?Q?6MSvYiaBtgdDdtaFDKjJOGBsyvNn70wIX2MRoIsmseRBYGNiiyV9npPuDa5I?=
 =?us-ascii?Q?BjfWEgwRdsJYJ3GYf0x29T2+K0Kwm3ogcGdVQ1QxA+ut1kFhVPlJB+YRQHiz?=
 =?us-ascii?Q?Wh5Rq+bnlyxiTx18D+2V+UpiayqRCFRx37OS4m9fiypsJaAUA/R9u/wMZ+xN?=
 =?us-ascii?Q?qjB8luB7iKSJIGzuX+fnrF5Sx+adBWFgWp2vx2IAMK970TZr0T52NKXkQpw1?=
 =?us-ascii?Q?IcEfxjPRqGVVDo3o/WFj3s4FgkUErH3B/yA+r64eUq1wlxmoz9y/NJYybxSO?=
 =?us-ascii?Q?CbWCdXtOhrFJiRs/gLb+c0mi2snMN5DOblI7tTo8rOw8/a3BroUejhPoE9pz?=
 =?us-ascii?Q?50BeztN4nBO5BUuNb0FRaR9Wt62CFSKgMNMs8WeVtYU2IHNEkKqsg+MHzUHD?=
 =?us-ascii?Q?gF6sFqzUi8P/w1LLXie0AA4CMso1RJV9Bh7V6sdK7iIDBd9pefE91jXBDYZU?=
 =?us-ascii?Q?LN2Aeq0V3S4QdrsG6L0boZO/ovkvaKIyKar2U7+MVT9NRzjoQfszS9rC5qrT?=
 =?us-ascii?Q?2d60WrBdGN3QCgnRdYpuSYmeW9gpHf473F74HQVrfWI7GPri3YKPUCRnbAi8?=
 =?us-ascii?Q?MPqv98qUhSDSHUxV1mxum9LbWb2keFxmaqc6zYPhOyeMJc95+LR+ZGoRycLe?=
 =?us-ascii?Q?jrVADY8lpq9+rtm4PvbQn9Y=3D?=
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b4a6d95e-d6e6-4444-1091-08ddb26508b2
X-MS-Exchange-CrossTenant-AuthSource: OS9PR01MB13950.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jun 2025 14:48:36.6581
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DuaxF3WeSnJrjsID7pdAeeNnFFJ+GtwxSZ6E4kUDil19f72aVfc5P9994QzEy+og1KhFQkuhTzhA3YMMJTyLuzSsr294Ez5U+Re3bEeqq9WlNjijWeNXGXT7EgA8hfoV
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSCPR01MB16379
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 23 Jun 2025 14:48:42 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/19205

Hi All,

This patch series aims to add SDHI support for the Renesas RZ/G3E SoCs
into the linux-6.12.y-cip kernel.

The SD/MMC block on the RZ/G3E ("R9A09G047") SoC is similar to that
of the RZ/V2H, but the SD0 channel has only dedicated pins, so we must
use SD_STATUS register to control voltage and power enable (internal
regulator).

For SD1 and SD2 channel we can either use gpio regulator or internal
regulator (using SD_STATUS register) for voltage switching.

This patchset applies on top of [1]

[1] https://patchwork.kernel.org/project/cip-dev/list/?series=3D974772

Thanks & Regards,
Tommaso

Biju Das (10):
  clk: renesas: r9a09g047: Add SDHI clocks/resets
  dt-bindings: mmc: renesas,sdhi: Document RZ/G3E support
  of: base: Add of_get_available_child_by_name()
  mmc: renesas_sdhi: Add support for RZ/G3E SoC
  mmc: renesas_sdhi: Use of_get_available_child_by_name()
  arm64: dts: renesas: r9a09g047: Add SDHI0-SDHI2 nodes
  arm64: dts: renesas: r9a09g057: Add support for enabling SDHI internal
    regulator
  arm64: dts: renesas: rzg3e-smarc-som: Enable SDHI{0,2}
  arm64: dts: renesas: rzg3e-smarc-som: Add support to enable SD on
    SDHI0
  arm64: dts: renesas: r9a09g047e57-smarc: Enable SDHI1

 .../devicetree/bindings/mmc/renesas,sdhi.yaml |  16 ++
 arch/arm64/boot/dts/renesas/r9a09g047.dtsi    |  60 +++++++
 .../boot/dts/renesas/r9a09g047e57-smarc.dts   |  49 ++++++
 arch/arm64/boot/dts/renesas/r9a09g057.dtsi    |  21 +++
 .../boot/dts/renesas/renesas-smarc2.dtsi      |  18 ++
 .../boot/dts/renesas/rzg3e-smarc-som.dtsi     | 154 ++++++++++++++++++
 drivers/clk/renesas/r9a09g047-cpg.c           |  31 ++++
 drivers/mmc/host/Kconfig                      |   2 +-
 drivers/mmc/host/renesas_sdhi.h               |   1 +
 drivers/mmc/host/renesas_sdhi_core.c          | 126 ++++++++++++++
 drivers/mmc/host/tmio_mmc.h                   |  10 ++
 drivers/of/base.c                             |  27 +++
 include/linux/of.h                            |   9 +
 13 files changed, 523 insertions(+), 1 deletion(-)

--=20
2.43.0


