Return-Path: <tommaso.merciai.xr@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56EB2CA0EFF
	for <webhook@archiver.kernel.org>; Wed, 20 Aug 2025 16:10:14 +0000 (UTC)
Received: from OS0P286CU010.outbound.protection.outlook.com (OS0P286CU010.outbound.protection.outlook.com [40.107.74.25])
 by mx.groups.io with SMTP id smtpd.web10.1136.1755706213133469685
 for <cip-dev@lists.cip-project.org>;
 Wed, 20 Aug 2025 09:10:13 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@bp.renesas.com header.s=selector1 header.b=acSBI6Nu;
 spf=pass (domain: bp.renesas.com, ip: 40.107.74.25, mailfrom: tommaso.merciai.xr@bp.renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yPMVoqixhPgCCOZ0dsjvzf7+dBnGahnW0Q8afPnN+qHxdtn6menyNoYFWWiG5W4PHO1duAIT++4KZuU8zIHjHs1eljQnh5F68Df3NLJyiYTepARjacLWgAQwsrXHPHVn7xIz/kqp3C0O5omFUZwk80qRzE7mmko0RKzchV7lQ7qCM/SWh29JeiUVbCP8s52+KL/1BHATFplRR8kK4bRyRz+mD4XruhSKQBzWmBPfKvxiqJFEI9GNCVYqVGA4ZEkjcrNOYqnT6Pvx+KX05WKmnzRDkZZUlSUkzk72O0OpGEATodJD8NQ3whhb4L/33SDhSQup/FZMdtETAWoIHeI6KA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=82yRFDjnHnG/EOHozsuVDAfa+mBZgqeoIzdo6jWE7xU=;
 b=r/dXCAB466n0+tMqXQ5Xik9EwyvTd0qxnwUMjU6g/GRrEiYK4LZiNt5R4pihgICzeNasjHk2bXqtGbPGR9fiHt9+BH/pL440oQwn/s5dtouSd6ijSkpa8sEB9mmcAwNzEm5tKObSxkbQIBp6ZrcbEt3H4xYDfS71VvwBVqlm77EW/91XM4y9ynm03EPPS9Fxxr+KHDejCYgMbQvLZrk+eXhA+9g9o1ImSbg9sgHA+5l4R0Px3h70K4HauB+t/s3buLN//ymlK13tCQ04G29dFJRBjWCsufzbQEQqTvGJU1qmwkF6Z3m8L43Mh0hseXW9asYesb4BRJ6e7NCDsauHzQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=82yRFDjnHnG/EOHozsuVDAfa+mBZgqeoIzdo6jWE7xU=;
 b=acSBI6Nur3C5porEVDEQiAHSqZW405TEi3xhD2sVwTBp5GzPAU4Uw8qoz8Pqc7cwMOAKZfbeGsVjZwEaiietN7s/hx+q9TeocZvcmGTSjN1LL1wCnrbbAlkek7ttCv5bpq8neDv2dPP4CVPELfCRv3iJtYLaSQ7ujXFFakeTGwo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
Received: from TYCPR01MB11947.jpnprd01.prod.outlook.com (2603:1096:400:3e1::6)
 by TY3PR01MB9889.jpnprd01.prod.outlook.com (2603:1096:400:22b::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.24; Wed, 20 Aug
 2025 16:10:11 +0000
Received: from TYCPR01MB11947.jpnprd01.prod.outlook.com
 ([fe80::63d8:fff3:8390:8d31]) by TYCPR01MB11947.jpnprd01.prod.outlook.com
 ([fe80::63d8:fff3:8390:8d31%5]) with mapi id 15.20.9031.023; Wed, 20 Aug 2025
 16:10:11 +0000
From: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
CC: Biju Das <biju.das.jz@bp.renesas.com>,
	tomm.merciai@gmail.com
Subject: [PATCH 6.12.y-cip 43/55] media: rzg2l-cru: Add support for RZ/G3E SoC
Date: Wed, 20 Aug 2025 18:07:44 +0200
Message-ID: <20250820160758.801813-44-tommaso.merciai.xr@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250820160758.801813-1-tommaso.merciai.xr@bp.renesas.com>
References: <20250820160758.801813-1-tommaso.merciai.xr@bp.renesas.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: FR2P281CA0122.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9d::11) To TYCPR01MB11947.jpnprd01.prod.outlook.com
 (2603:1096:400:3e1::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYCPR01MB11947:EE_|TY3PR01MB9889:EE_
X-MS-Office365-Filtering-Correlation-Id: f337afd5-b027-4b95-93d1-08dde0040a06
X-LD-Processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|366016|1800799024|52116014|376014|38350700014;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?gfZwTPkJmkH1aEcq/s/QY1KFdAUBppj55OCOxcHgCnowipXIW8BofTsUR4Oj?=
 =?us-ascii?Q?OICWEWaEJJAYd3TOO3xWo4dBy82Dbx9dG8OVWKc0NK8z1RJ+5gja5pY/UAOa?=
 =?us-ascii?Q?LWQpWsCiRxW3E/vPICfyOioabDvCAAE/RQAplO/cWiraEemMPSxjqyhtBJgj?=
 =?us-ascii?Q?Oey99IJA/VS3CHOBmWOL+VGMheGwf8Zx0pVZNq+olalaFDrnA2PI8X4WDReo?=
 =?us-ascii?Q?alSNTdZ9nNt3egHtvxR+F8hjH1N86tZFUMzURRGRBQqB4he7tEnqRRab/1Gr?=
 =?us-ascii?Q?q9865BcmcrmxWGEt6CmaaoZlBpQQ3eOhkc1ykXWsgPuGbgxawwteaWg/Lw/y?=
 =?us-ascii?Q?3HKY9gFQyvLh1GcMKD0K2cl3Ev0uX54aNCd2PYi7AzuWLi1xsHJxatqQjvNt?=
 =?us-ascii?Q?8/JmaNlIspmjHDK/0AjzbY56DurqnVz6WNe15W/5RzY9oidPDHGfPq2vy6mc?=
 =?us-ascii?Q?+i9l/3PFgjTsFKZTsJAt5y/8AYolZ+Mmh8u+ovxzZoWzBpExoysBonaf8ih1?=
 =?us-ascii?Q?brRK9xLobMfiuGr//c008othOe80T9P8MGecB/xP2vV4lqhGbatmDPY7uqun?=
 =?us-ascii?Q?PeiBvGUuDdnHC+0Me7kVeCVXeEKOB0LavmlpSY3zzn0OnuIhkqoGr6sbGlTl?=
 =?us-ascii?Q?ntdx5B3VVtqWZFpYihNDuUfe30rRxHsg49NN2QO8LBms8n+Az88CYTF7KOcB?=
 =?us-ascii?Q?t9o+YQB+voEW+6u1QhtcZcobDEEsnIfhooRzYA8F8fCF+sH6gsMsY6hT6KFA?=
 =?us-ascii?Q?CeoMVvSF55vTnJJWrXIyGC/GLCRYxpL4F66qw7Lf7OvFrUnchfNcQEPW3oxk?=
 =?us-ascii?Q?EJ/nzrp3IYJTLBtEIN+5bMOHtduotEHpK6dCTsEusVbi97JTrPNsk/fAv/do?=
 =?us-ascii?Q?TF/VsLNR/bUPm0FW2ikoF3+aHj6J2cJJVVITVrXoCvodDOJpzDVIxSkqIk/4?=
 =?us-ascii?Q?SLyxQe4p97vTR0N8PtEtpvTHDDRsQh9o/7qySoplvA9JH185QuiCxSOFsPHQ?=
 =?us-ascii?Q?wy0QaQInxG4XcGcCnRIzHYWzGSfPBB4XUwQHwsJUW0SwmSexzMXiFVC1UzmZ?=
 =?us-ascii?Q?FYJZRuIuM4AqdTd9F0TUL3T+czDWhi/BG7imonCoAR67w7F39gUvC5cjtedf?=
 =?us-ascii?Q?dptSKIewYP8javfzPKjzLsvmGFHo6qpNqo2C2l2CH+aQ/HIiDbCbHXKhPB36?=
 =?us-ascii?Q?gKK972P7pJR335px+IrJIqLM/isfNKhwPdmGXAVEyjZAgJcWjvvNUlFZrTjD?=
 =?us-ascii?Q?d0VEt0vFbv3jWmgUGgzpXL9++EJu81oTW2YntxsjKhqlwlXX3FE9hF6NwQza?=
 =?us-ascii?Q?RTGYywtySwJH+SAeV00EswKbFLadMbnri3/55lEb1ey25TiuMTg6Xr/qq02X?=
 =?us-ascii?Q?9bcsuzf8pGbMQgWkczyDtJNFC8C5AkfOwRfmi8u64vxMw2p2+0CHCrKugyo0?=
 =?us-ascii?Q?iq3f1qIxwmY6JvfURflfhcV9bZa0ublV4352uwC+yuRzHeMZUqvGgSq99hyR?=
 =?us-ascii?Q?0X0Oel+HSdKYk5U=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYCPR01MB11947.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(52116014)(376014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?QlM7CUnmEKb8ahbzYdv+but+ssXz+ldciZPngqqUHJCeEfvKbXurYOxUAevM?=
 =?us-ascii?Q?KrFenyP6NwveRSQQghM1Dv0fInfth71DBip4qxWUS2i9tTz2WIbtXow/SupF?=
 =?us-ascii?Q?99d19ztydasBYIgVGVfoG812ojUk7QFmCsHEp76XdQ0LORyEEL98He4m+8ET?=
 =?us-ascii?Q?wJ5RLvJfh1aj1V6xsaeJUr3veolwYmn79ZSDNbQFTtj1bNMm608mTU5nt3ET?=
 =?us-ascii?Q?Uy75KsONKs+iXm2IkVtqhxLzYrBzWkAJygCm6i4sWyVcTozz+hQPpDEBDTAl?=
 =?us-ascii?Q?TQhntTzrgdHO08wXoUQhGbHxPAvH1kRC9KQVJQEEYPPSV6LlmJuksLhhsq0m?=
 =?us-ascii?Q?ucMUoBRLLFjrfnoZBbq+lgAsfGXO9/QfPr3jl+xjkd8FrDeAtZKzxzOfbnDg?=
 =?us-ascii?Q?w/vimw/cUtOQ8BjLqJjMeqaEQfG3BrzrcLXdQVjw6YXa8igL0beMAWu4uJmn?=
 =?us-ascii?Q?TDtXhNLh0grhkqOqiswJe8eqO/M+ez132gNg0e1jzg+Wb8xFMfIwDt8XZhJE?=
 =?us-ascii?Q?7USP8kENr9jXMx0mye/+cOj4XmAnsu/PSIUkSmgTAM1dZmX8H+gybvDlM/qP?=
 =?us-ascii?Q?xjetHNlMdnCVJ+G9ZKgEjUewQr3zn5lAS0gl9L49m7U04nMZwZQ+wK1rVjFY?=
 =?us-ascii?Q?YDhyKkCDFpep/hRF9y2/O7eitHsnDZ1W71YAoco6YD2njPobjGuZ2rdvBLuA?=
 =?us-ascii?Q?75RSKB3K4bn6v/9Z25bXTFL6Z7hDJDtOl6nHamb/n6oKeTEAACsb62q/aAiF?=
 =?us-ascii?Q?28mtziRZi9kj/3iccsTDcnAQmipwX++6qtBd3xHQwg4lvTOBcX01esM36SCC?=
 =?us-ascii?Q?W1keOs+uHVGz5A6/Gz5r+PWsSJSr3HjGl+hlzCEq/Wz9jYeww5WflycKpbu1?=
 =?us-ascii?Q?cHqmltD5Kt/s7gR3G6f3BvZ82/YqfIotHic52Ev1PfS/crk6st28M/wFlzS/?=
 =?us-ascii?Q?Bv8/2ZQdJPi6/OSzzbfNohmBqfrYtD9xKtkJNd4J+5ZJV4BQ2pM4GhBuHtr8?=
 =?us-ascii?Q?vla+9dz8E+VIiM8thqjk1xPFj6YWdca9FsCQZ6P4K0mm0Iqoqyf7s56yZAyV?=
 =?us-ascii?Q?FG/gtJf6Ajb5MUsVfnWpxqHAGQ9gxzJOgwJKGDlnGZJPXnlb/fB4QYKI3lBM?=
 =?us-ascii?Q?rQ6Vevl4bdGqijxvlBT8yG1pLYhqfA5xKlfKRTYlqssqR56WGZXB+VcqoGrh?=
 =?us-ascii?Q?D+2PpfS+fOVI24bYNhHFcjIy/bqmpOVHJ9/iJX+23RmmYejKsGaxcI9hyykb?=
 =?us-ascii?Q?CY9S7ZNRe7WzAdY+Mylk3Jv71K6ieUedexwyqxIlZ+qrjC3Zt9t2GHkkjvAz?=
 =?us-ascii?Q?DqEAzGLiLJwPhsXBv7CK2BHZzpkQf6Q83FuS5yQBQ1b7nViLXJyFhjsX3Don?=
 =?us-ascii?Q?YgNqDsdRjNemHkncbG0s8nWwTfi8Ae+nn1ZDouKXYDs64EsXFtmVVvYnso5U?=
 =?us-ascii?Q?N9oyPpYhPuZtQ+1QR4qbuSNJ2zJAmCEcabG5SpJ2WpJBLMdRHlTHlbs/M6Sn?=
 =?us-ascii?Q?HYhFG6yOjBgap4LbQwxL/bif7AJ7KuVEfa+l1E6dACSYJZAG+ZDo2nxl86sv?=
 =?us-ascii?Q?muhk2tIRchuGLLBaBq4QJPwRa+NgDe1rlCVhX2WOnOjzB5tpYTcTKJ6Rh19K?=
 =?us-ascii?Q?TuCfUIRt3EF9J/dZqNHF+7A=3D?=
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f337afd5-b027-4b95-93d1-08dde0040a06
X-MS-Exchange-CrossTenant-AuthSource: TYCPR01MB11947.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Aug 2025 16:10:11.0136
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Xy1UjllPQNcCLlmIjU5hRU78nAKMzCtcQ02pIjeEasAHJWPGRGV5BvNBK1rsLFaxLrRWv5N02Sa/z9sVCwy5btSpNWScuUWOy9AmFuV4b5DEPE4y+FFqUDtgjw8/Ki65
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY3PR01MB9889
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 20 Aug 2025 16:10:14 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/19924

From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

commit 1d1e564fce1bc361af1a1980a7f915a0475a008a upstream.

The CRU block on the Renesas RZ/G3E SoC is similar to the one found on
the Renesas RZ/G2L SoC, with the following differences:

- Additional registers rzg3e_cru_regs.
- A different irq handler rzg3e_cru_irq.
- A different rzg3e_cru_csi2_setup.
- A different max input width.
- Additional stride register.

Introduce rzg3e_cru_info struct to handle differences between RZ/G2L
and RZ/G3E and related RZ/G3E functions:

 - rzg3e_cru_enable_interrupts()
 - rzg3e_cru_enable_interrupts()
 - rz3e_fifo_empty()
 - rzg3e_cru_csi2_setup()
 - rzg3e_cru_get_current_slot()

Add then support for the RZ/G3E SoC CRU block with the new compatible
string "renesas,r9a09g047-cru".

Reviewed-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Signed-off-by: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
Link: https://lore.kernel.org/r/20250411170624.472257-18-tommaso.merciai.xr=
@bp.renesas.com
Signed-off-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Signed-off-by: Hans Verkuil <hverkuil@xs4all.nl>
[Tommaso: Squashed the commits e5dd01ea9610("media: renesas: rzg2l-cru:
	  Fix typo in rzg3e_fifo_empty name") and 095e5d400cbf("media:
	  rzg2l-cru: Fix typo in rzg2l_cru_of_id_table struct") and
	  9e6038904151("media: renesas: rzg2l-cru: Simplify FIFO empty
	  check")]
Signed-off-by: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>

media: renesas: rzg2l-cru: Simplify FIFO empty check

commit 8b7b5e1bfb72c52dd2cfd82cc14dc4e66c6b94a9 upstream.

Collapse FIFO empty helper into a single return statement by removing the
redundant `if (amnfifopntr_w =3D=3D amnfifopntr_r_y) return true;` path. Ma=
ke
`rzg2l_fifo_empty()` directly return `amnfifopntr_w =3D=3D amnfifopntr_r_y`
to improve readability without changing behavior.

Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
Closes: https://lore.kernel.org/all/aAtQThCibZCROETx@stanley.mountain/
Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Reviewed-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Reviewed-by: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
Tested-by: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
Link: https://lore.kernel.org/r/20250429091609.9947-2-prabhakar.mahadev-lad=
.rj@bp.renesas.com
Signed-off-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Signed-off-by: Hans Verkuil <hverkuil@xs4all.nl>
Signed-off-by: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
---
 .../platform/renesas/rzg2l-cru/rzg2l-core.c   |  60 ++++++-
 .../renesas/rzg2l-cru/rzg2l-cru-regs.h        |  25 +++
 .../platform/renesas/rzg2l-cru/rzg2l-cru.h    |  13 ++
 .../platform/renesas/rzg2l-cru/rzg2l-video.c  | 170 +++++++++++++++++-
 4 files changed, 263 insertions(+), 5 deletions(-)

diff --git a/drivers/media/platform/renesas/rzg2l-cru/rzg2l-core.c b/driver=
s/media/platform/renesas/rzg2l-cru/rzg2l-core.c
index 383b8eee22ba..ab8f76ccd9ba 100644
--- a/drivers/media/platform/renesas/rzg2l-cru/rzg2l-core.c
+++ b/drivers/media/platform/renesas/rzg2l-cru/rzg2l-core.c
@@ -318,6 +318,58 @@ static void rzg2l_cru_remove(struct platform_device *p=
dev)
 	rzg2l_cru_dma_unregister(cru);
 }
=20
+static const u16 rzg3e_cru_regs[] =3D {
+	[CRUnCTRL] =3D 0x0,
+	[CRUnIE] =3D 0x4,
+	[CRUnIE2] =3D 0x8,
+	[CRUnINTS] =3D 0xc,
+	[CRUnINTS2] =3D 0x10,
+	[CRUnRST] =3D 0x18,
+	[AMnMB1ADDRL] =3D 0x40,
+	[AMnMB1ADDRH] =3D 0x44,
+	[AMnMB2ADDRL] =3D 0x48,
+	[AMnMB2ADDRH] =3D 0x4c,
+	[AMnMB3ADDRL] =3D 0x50,
+	[AMnMB3ADDRH] =3D 0x54,
+	[AMnMB4ADDRL] =3D 0x58,
+	[AMnMB4ADDRH] =3D 0x5c,
+	[AMnMB5ADDRL] =3D 0x60,
+	[AMnMB5ADDRH] =3D 0x64,
+	[AMnMB6ADDRL] =3D 0x68,
+	[AMnMB6ADDRH] =3D 0x6c,
+	[AMnMB7ADDRL] =3D 0x70,
+	[AMnMB7ADDRH] =3D 0x74,
+	[AMnMB8ADDRL] =3D 0x78,
+	[AMnMB8ADDRH] =3D 0x7c,
+	[AMnMBVALID] =3D 0x88,
+	[AMnMADRSL] =3D 0x8c,
+	[AMnMADRSH] =3D 0x90,
+	[AMnAXIATTR] =3D 0xec,
+	[AMnFIFOPNTR] =3D 0xf8,
+	[AMnAXISTP] =3D 0x110,
+	[AMnAXISTPACK] =3D 0x114,
+	[AMnIS] =3D 0x128,
+	[ICnEN] =3D 0x1f0,
+	[ICnSVCNUM] =3D 0x1f8,
+	[ICnSVC] =3D 0x1fc,
+	[ICnIPMC_C0] =3D 0x200,
+	[ICnMS] =3D 0x2d8,
+	[ICnDMR] =3D 0x304,
+};
+
+static const struct rzg2l_cru_info rzg3e_cru_info =3D {
+	.max_width =3D 4095,
+	.max_height =3D 4095,
+	.image_conv =3D ICnIPMC_C0,
+	.has_stride =3D true,
+	.regs =3D rzg3e_cru_regs,
+	.irq_handler =3D rzg3e_cru_irq,
+	.enable_interrupts =3D rzg3e_cru_enable_interrupts,
+	.disable_interrupts =3D rzg3e_cru_disable_interrupts,
+	.fifo_empty =3D rzg3e_fifo_empty,
+	.csi_setup =3D rzg3e_cru_csi2_setup,
+};
+
 static const u16 rzg2l_cru_regs[] =3D {
 	[CRUnCTRL] =3D 0x0,
 	[CRUnIE] =3D 0x4,
@@ -351,7 +403,7 @@ static const u16 rzg2l_cru_regs[] =3D {
 	[ICnDMR] =3D 0x26c,
 };
=20
-static const struct rzg2l_cru_info rzgl2_cru_info =3D {
+static const struct rzg2l_cru_info rzg2l_cru_info =3D {
 	.max_width =3D 2800,
 	.max_height =3D 4095,
 	.image_conv =3D ICnMC,
@@ -364,9 +416,13 @@ static const struct rzg2l_cru_info rzgl2_cru_info =3D =
{
 };
=20
 static const struct of_device_id rzg2l_cru_of_id_table[] =3D {
+	{
+		.compatible =3D "renesas,r9a09g047-cru",
+		.data =3D &rzg3e_cru_info,
+	},
 	{
 		.compatible =3D "renesas,rzg2l-cru",
-		.data =3D &rzgl2_cru_info,
+		.data =3D &rzg2l_cru_info,
 	},
 	{ /* sentinel */ }
 };
diff --git a/drivers/media/platform/renesas/rzg2l-cru/rzg2l-cru-regs.h b/dr=
ivers/media/platform/renesas/rzg2l-cru/rzg2l-cru-regs.h
index fc0fd0c97c86..a5a57369ef0e 100644
--- a/drivers/media/platform/renesas/rzg2l-cru/rzg2l-cru-regs.h
+++ b/drivers/media/platform/renesas/rzg2l-cru/rzg2l-cru-regs.h
@@ -14,8 +14,13 @@
=20
 #define CRUnIE_EFE			BIT(17)
=20
+#define CRUnIE2_FSxE(x)			BIT(((x) * 3))
+#define CRUnIE2_FExE(x)			BIT(((x) * 3) + 1)
+
 #define CRUnINTS_SFS			BIT(16)
=20
+#define CRUnINTS2_FSxS(x)		BIT(((x) * 3))
+
 #define CRUnRST_VRESETN			BIT(0)
=20
 /* Memory Bank Base Address (Lower) Register for CRU Image Data */
@@ -32,7 +37,14 @@
 #define AMnAXIATTR_AXILEN		(0xf)
=20
 #define AMnFIFOPNTR_FIFOWPNTR		GENMASK(7, 0)
+#define AMnFIFOPNTR_FIFOWPNTR_B0	AMnFIFOPNTR_FIFOWPNTR
+#define AMnFIFOPNTR_FIFOWPNTR_B1	GENMASK(15, 8)
 #define AMnFIFOPNTR_FIFORPNTR_Y		GENMASK(23, 16)
+#define AMnFIFOPNTR_FIFORPNTR_B0	AMnFIFOPNTR_FIFORPNTR_Y
+#define AMnFIFOPNTR_FIFORPNTR_B1	GENMASK(31, 24)
+
+#define AMnIS_IS_MASK			GENMASK(14, 7)
+#define AMnIS_IS(x)			((x) << 7)
=20
 #define AMnAXISTP_AXI_STOP		BIT(0)
=20
@@ -40,6 +52,11 @@
=20
 #define ICnEN_ICEN			BIT(0)
=20
+#define ICnSVC_SVC0(x)			(x)
+#define ICnSVC_SVC1(x)			((x) << 4)
+#define ICnSVC_SVC2(x)			((x) << 8)
+#define ICnSVC_SVC3(x)			((x) << 12)
+
 #define ICnMC_CSCTHR			BIT(5)
 #define ICnMC_INF(x)			((x) << 16)
 #define ICnMC_VCSEL(x)			((x) << 22)
@@ -52,7 +69,9 @@
 enum rzg2l_cru_common_regs {
 	CRUnCTRL,	/* CRU Control */
 	CRUnIE,		/* CRU Interrupt Enable */
+	CRUnIE2,	/* CRU Interrupt Enable(2) */
 	CRUnINTS,	/* CRU Interrupt Status */
+	CRUnINTS2,	/* CRU Interrupt Status(2) */
 	CRUnRST,	/* CRU Reset */
 	AMnMB1ADDRL,	/* Bank 1 Address (Lower) for CRU Image Data */
 	AMnMB1ADDRH,	/* Bank 1 Address (Higher) for CRU Image Data */
@@ -72,12 +91,18 @@ enum rzg2l_cru_common_regs {
 	AMnMB8ADDRH,    /* Bank 8 Address (Higher) for CRU Image Data */
 	AMnMBVALID,	/* Memory Bank Enable for CRU Image Data */
 	AMnMBS,		/* Memory Bank Status for CRU Image Data */
+	AMnMADRSL,	/* VD Memory Address Lower Status Register */
+	AMnMADRSH,	/* VD Memory Address Higher Status Register */
 	AMnAXIATTR,	/* AXI Master Transfer Setting Register for CRU Image Data */
 	AMnFIFOPNTR,	/* AXI Master FIFO Pointer for CRU Image Data */
 	AMnAXISTP,	/* AXI Master Transfer Stop for CRU Image Data */
 	AMnAXISTPACK,	/* AXI Master Transfer Stop Status for CRU Image Data */
+	AMnIS,		/* Image Stride Setting Register */
 	ICnEN,		/* CRU Image Processing Enable */
+	ICnSVCNUM,	/* CRU SVC Number Register */
+	ICnSVC,		/* CRU VC Select Register */
 	ICnMC,		/* CRU Image Processing Main Control */
+	ICnIPMC_C0,	/* CRU Image Converter Main Control 0 */
 	ICnMS,		/* CRU Module Status */
 	ICnDMR,		/* CRU Data Output Mode */
 	RZG2L_CRU_MAX_REG,
diff --git a/drivers/media/platform/renesas/rzg2l-cru/rzg2l-cru.h b/drivers=
/media/platform/renesas/rzg2l-cru/rzg2l-cru.h
index ccaba5220f1c..56feda6e6207 100644
--- a/drivers/media/platform/renesas/rzg2l-cru/rzg2l-cru.h
+++ b/drivers/media/platform/renesas/rzg2l-cru/rzg2l-cru.h
@@ -85,6 +85,7 @@ struct rzg2l_cru_info {
 	unsigned int max_height;
 	u16 image_conv;
 	const u16 *regs;
+	bool has_stride;
 	irqreturn_t (*irq_handler)(int irq, void *data);
 	void (*enable_interrupts)(struct rzg2l_cru_dev *cru);
 	void (*disable_interrupts)(struct rzg2l_cru_dev *cru);
@@ -108,6 +109,8 @@ struct rzg2l_cru_info {
  * @vdev:		V4L2 video device associated with CRU
  * @v4l2_dev:		V4L2 device
  * @num_buf:		Holds the current number of buffers enabled
+ * @svc_channel:	SVC0/1/2/3 to use for RZ/G3E
+ * @buf_addr:		Memory addresses where current video data is written.
  * @notifier:		V4L2 asynchronous subdevs notifier
  *
  * @ip:			Image processing subdev info
@@ -144,6 +147,9 @@ struct rzg2l_cru_dev {
 	struct v4l2_device v4l2_dev;
 	u8 num_buf;
=20
+	u8 svc_channel;
+	dma_addr_t buf_addr[RZG2L_CRU_HW_BUFFER_DEFAULT];
+
 	struct v4l2_async_notifier notifier;
=20
 	struct rzg2l_cru_ip ip;
@@ -175,6 +181,7 @@ void rzg2l_cru_dma_unregister(struct rzg2l_cru_dev *cru=
);
 int rzg2l_cru_video_register(struct rzg2l_cru_dev *cru);
 void rzg2l_cru_video_unregister(struct rzg2l_cru_dev *cru);
 irqreturn_t rzg2l_cru_irq(int irq, void *data);
+irqreturn_t rzg3e_cru_irq(int irq, void *data);
=20
 const struct v4l2_format_info *rzg2l_cru_format_from_pixel(u32 format);
=20
@@ -188,10 +195,16 @@ const struct rzg2l_cru_ip_format *rzg2l_cru_ip_index_=
to_fmt(u32 index);
=20
 void rzg2l_cru_enable_interrupts(struct rzg2l_cru_dev *cru);
 void rzg2l_cru_disable_interrupts(struct rzg2l_cru_dev *cru);
+void rzg3e_cru_enable_interrupts(struct rzg2l_cru_dev *cru);
+void rzg3e_cru_disable_interrupts(struct rzg2l_cru_dev *cru);
=20
 bool rzg2l_fifo_empty(struct rzg2l_cru_dev *cru);
+bool rzg3e_fifo_empty(struct rzg2l_cru_dev *cru);
 void rzg2l_cru_csi2_setup(struct rzg2l_cru_dev *cru,
 			  const struct rzg2l_cru_ip_format *ip_fmt,
 			  u8 csi_vc);
+void rzg3e_cru_csi2_setup(struct rzg2l_cru_dev *cru,
+			  const struct rzg2l_cru_ip_format *ip_fmt,
+			  u8 csi_vc);
=20
 #endif
diff --git a/drivers/media/platform/renesas/rzg2l-cru/rzg2l-video.c b/drive=
rs/media/platform/renesas/rzg2l-cru/rzg2l-video.c
index 91ff4206d822..3bf43b8067d0 100644
--- a/drivers/media/platform/renesas/rzg2l-cru/rzg2l-video.c
+++ b/drivers/media/platform/renesas/rzg2l-cru/rzg2l-video.c
@@ -31,6 +31,9 @@
 #define RZG2L_CRU_DEFAULT_FIELD		V4L2_FIELD_NONE
 #define RZG2L_CRU_DEFAULT_COLORSPACE	V4L2_COLORSPACE_SRGB
=20
+#define RZG2L_CRU_STRIDE_MAX		32640
+#define RZG2L_CRU_STRIDE_ALIGN		128
+
 struct rzg2l_cru_buffer {
 	struct vb2_v4l2_buffer vb;
 	struct list_head list;
@@ -184,6 +187,8 @@ static void rzg2l_cru_set_slot_addr(struct rzg2l_cru_de=
v *cru,
 	/* Currently, we just use the buffer in 32 bits address */
 	rzg2l_cru_write(cru, AMnMBxADDRL(slot), addr);
 	rzg2l_cru_write(cru, AMnMBxADDRH(slot), 0);
+
+	cru->buf_addr[slot] =3D addr;
 }
=20
 /*
@@ -224,6 +229,7 @@ static void rzg2l_cru_fill_hw_slot(struct rzg2l_cru_dev=
 *cru, int slot)
=20
 static void rzg2l_cru_initialize_axi(struct rzg2l_cru_dev *cru)
 {
+	const struct rzg2l_cru_info *info =3D cru->info;
 	unsigned int slot;
 	u32 amnaxiattr;
=20
@@ -236,12 +242,39 @@ static void rzg2l_cru_initialize_axi(struct rzg2l_cru=
_dev *cru)
 	for (slot =3D 0; slot < cru->num_buf; slot++)
 		rzg2l_cru_fill_hw_slot(cru, slot);
=20
+	if (info->has_stride) {
+		u32 stride =3D cru->format.bytesperline;
+		u32 amnis;
+
+		stride /=3D RZG2L_CRU_STRIDE_ALIGN;
+		amnis =3D rzg2l_cru_read(cru, AMnIS) & ~AMnIS_IS_MASK;
+		rzg2l_cru_write(cru, AMnIS, amnis | AMnIS_IS(stride));
+	}
+
 	/* Set AXI burst max length to recommended setting */
 	amnaxiattr =3D rzg2l_cru_read(cru, AMnAXIATTR) & ~AMnAXIATTR_AXILEN_MASK;
 	amnaxiattr |=3D AMnAXIATTR_AXILEN;
 	rzg2l_cru_write(cru, AMnAXIATTR, amnaxiattr);
 }
=20
+void rzg3e_cru_csi2_setup(struct rzg2l_cru_dev *cru,
+			  const struct rzg2l_cru_ip_format *ip_fmt,
+			  u8 csi_vc)
+{
+	const struct rzg2l_cru_info *info =3D cru->info;
+	u32 icnmc =3D ICnMC_INF(ip_fmt->datatype);
+
+	icnmc |=3D rzg2l_cru_read(cru, info->image_conv) & ~ICnMC_INF_MASK;
+
+	/* Set virtual channel CSI2 */
+	icnmc |=3D ICnMC_VCSEL(csi_vc);
+
+	rzg2l_cru_write(cru, ICnSVCNUM, csi_vc);
+	rzg2l_cru_write(cru, ICnSVC, ICnSVC_SVC0(0) | ICnSVC_SVC1(1) |
+			ICnSVC_SVC2(2) | ICnSVC_SVC3(3));
+	rzg2l_cru_write(cru, info->image_conv, icnmc);
+}
+
 void rzg2l_cru_csi2_setup(struct rzg2l_cru_dev *cru,
 			  const struct rzg2l_cru_ip_format *ip_fmt,
 			  u8 csi_vc)
@@ -290,6 +323,19 @@ static int rzg2l_cru_initialize_image_conv(struct rzg2=
l_cru_dev *cru,
 	return 0;
 }
=20
+bool rzg3e_fifo_empty(struct rzg2l_cru_dev *cru)
+{
+	u32 amnfifopntr =3D rzg2l_cru_read(cru, AMnFIFOPNTR);
+
+	if ((((amnfifopntr & AMnFIFOPNTR_FIFORPNTR_B1) >> 24) =3D=3D
+	     ((amnfifopntr & AMnFIFOPNTR_FIFOWPNTR_B1) >> 8)) &&
+	    (((amnfifopntr & AMnFIFOPNTR_FIFORPNTR_B0) >> 16) =3D=3D
+	     (amnfifopntr & AMnFIFOPNTR_FIFOWPNTR_B0)))
+		return true;
+
+	return false;
+}
+
 bool rzg2l_fifo_empty(struct rzg2l_cru_dev *cru)
 {
 	u32 amnfifopntr, amnfifopntr_w, amnfifopntr_r_y;
@@ -299,8 +345,6 @@ bool rzg2l_fifo_empty(struct rzg2l_cru_dev *cru)
 	amnfifopntr_w =3D amnfifopntr & AMnFIFOPNTR_FIFOWPNTR;
 	amnfifopntr_r_y =3D
 		(amnfifopntr & AMnFIFOPNTR_FIFORPNTR_Y) >> 16;
-	if (amnfifopntr_w =3D=3D amnfifopntr_r_y)
-		return true;
=20
 	return amnfifopntr_w =3D=3D amnfifopntr_r_y;
 }
@@ -401,6 +445,20 @@ static int rzg2l_cru_get_virtual_channel(struct rzg2l_=
cru_dev *cru)
 	return fd.entry[0].bus.csi2.vc;
 }
=20
+void rzg3e_cru_enable_interrupts(struct rzg2l_cru_dev *cru)
+{
+	rzg2l_cru_write(cru, CRUnIE2, CRUnIE2_FSxE(cru->svc_channel));
+	rzg2l_cru_write(cru, CRUnIE2, CRUnIE2_FExE(cru->svc_channel));
+}
+
+void rzg3e_cru_disable_interrupts(struct rzg2l_cru_dev *cru)
+{
+	rzg2l_cru_write(cru, CRUnIE, 0);
+	rzg2l_cru_write(cru, CRUnIE2, 0);
+	rzg2l_cru_write(cru, CRUnINTS, rzg2l_cru_read(cru, CRUnINTS));
+	rzg2l_cru_write(cru, CRUnINTS2, rzg2l_cru_read(cru, CRUnINTS2));
+}
+
 void rzg2l_cru_enable_interrupts(struct rzg2l_cru_dev *cru)
 {
 	rzg2l_cru_write(cru, CRUnIE, CRUnIE_EFE);
@@ -423,6 +481,7 @@ int rzg2l_cru_start_image_processing(struct rzg2l_cru_d=
ev *cru)
 	if (ret < 0)
 		return ret;
 	csi_vc =3D ret;
+	cru->svc_channel =3D csi_vc;
=20
 	spin_lock_irqsave(&cru->qlock, flags);
=20
@@ -601,6 +660,104 @@ irqreturn_t rzg2l_cru_irq(int irq, void *data)
 	return IRQ_RETVAL(handled);
 }
=20
+static int rzg3e_cru_get_current_slot(struct rzg2l_cru_dev *cru)
+{
+	u64 amnmadrs;
+	int slot;
+
+	/*
+	 * When AMnMADRSL is read, AMnMADRSH of the higher-order
+	 * address also latches the address.
+	 *
+	 * AMnMADRSH must be read after AMnMADRSL has been read.
+	 */
+	amnmadrs =3D rzg2l_cru_read(cru, AMnMADRSL);
+	amnmadrs |=3D (u64)rzg2l_cru_read(cru, AMnMADRSH) << 32;
+
+	/* Ensure amnmadrs is within this buffer range */
+	for (slot =3D 0; slot < cru->num_buf; slot++) {
+		if (amnmadrs >=3D cru->buf_addr[slot] &&
+		    amnmadrs < cru->buf_addr[slot] + cru->format.sizeimage)
+			return slot;
+	}
+
+	dev_err(cru->dev, "Invalid MB address 0x%llx (out of range)\n", amnmadrs)=
;
+	return -EINVAL;
+}
+
+irqreturn_t rzg3e_cru_irq(int irq, void *data)
+{
+	struct rzg2l_cru_dev *cru =3D data;
+	u32 irq_status;
+	int slot;
+
+	scoped_guard(spinlock, &cru->qlock) {
+		irq_status =3D rzg2l_cru_read(cru, CRUnINTS2);
+		if (!irq_status)
+			return IRQ_NONE;
+
+		dev_dbg(cru->dev, "CRUnINTS2 0x%x\n", irq_status);
+
+		rzg2l_cru_write(cru, CRUnINTS2, rzg2l_cru_read(cru, CRUnINTS2));
+
+		/* Nothing to do if capture status is 'RZG2L_CRU_DMA_STOPPED' */
+		if (cru->state =3D=3D RZG2L_CRU_DMA_STOPPED) {
+			dev_dbg(cru->dev, "IRQ while state stopped\n");
+			return IRQ_HANDLED;
+		}
+
+		if (cru->state =3D=3D RZG2L_CRU_DMA_STOPPING) {
+			if (irq_status & CRUnINTS2_FSxS(0) ||
+			    irq_status & CRUnINTS2_FSxS(1) ||
+			    irq_status & CRUnINTS2_FSxS(2) ||
+			    irq_status & CRUnINTS2_FSxS(3))
+				dev_dbg(cru->dev, "IRQ while state stopping\n");
+			return IRQ_HANDLED;
+		}
+
+		slot =3D rzg3e_cru_get_current_slot(cru);
+		if (slot < 0)
+			return IRQ_HANDLED;
+
+		dev_dbg(cru->dev, "Current written slot: %d\n", slot);
+		cru->buf_addr[slot] =3D 0;
+
+		/*
+		 * To hand buffers back in a known order to userspace start
+		 * to capture first from slot 0.
+		 */
+		if (cru->state =3D=3D RZG2L_CRU_DMA_STARTING) {
+			if (slot !=3D 0) {
+				dev_dbg(cru->dev, "Starting sync slot: %d\n", slot);
+				return IRQ_HANDLED;
+			}
+			dev_dbg(cru->dev, "Capture start synced!\n");
+			cru->state =3D RZG2L_CRU_DMA_RUNNING;
+		}
+
+		/* Capture frame */
+		if (cru->queue_buf[slot]) {
+			struct vb2_v4l2_buffer *buf =3D cru->queue_buf[slot];
+
+			buf->field =3D cru->format.field;
+			buf->sequence =3D cru->sequence;
+			buf->vb2_buf.timestamp =3D ktime_get_ns();
+			vb2_buffer_done(&buf->vb2_buf, VB2_BUF_STATE_DONE);
+			cru->queue_buf[slot] =3D NULL;
+		} else {
+			/* Scratch buffer was used, dropping frame. */
+			dev_dbg(cru->dev, "Dropping frame %u\n", cru->sequence);
+		}
+
+		cru->sequence++;
+
+		/* Prepare for next frame */
+		rzg2l_cru_fill_hw_slot(cru, slot);
+	}
+
+	return IRQ_HANDLED;
+}
+
 static int rzg2l_cru_start_streaming_vq(struct vb2_queue *vq, unsigned int=
 count)
 {
 	struct rzg2l_cru_dev *cru =3D vb2_get_drv_priv(vq);
@@ -784,7 +941,14 @@ static void rzg2l_cru_format_align(struct rzg2l_cru_de=
v *cru,
 	v4l_bound_align_image(&pix->width, 320, info->max_width, 1,
 			      &pix->height, 240, info->max_height, 2, 0);
=20
-	pix->bytesperline =3D pix->width * fmt->bpp;
+	if (info->has_stride) {
+		u32 stride =3D clamp(pix->bytesperline, pix->width * fmt->bpp,
+				   RZG2L_CRU_STRIDE_MAX);
+		pix->bytesperline =3D round_up(stride, RZG2L_CRU_STRIDE_ALIGN);
+	} else {
+		pix->bytesperline =3D pix->width * fmt->bpp;
+	}
+
 	pix->sizeimage =3D pix->bytesperline * pix->height;
=20
 	dev_dbg(cru->dev, "Format %ux%u bpl: %u size: %u\n",
--=20
2.43.0


