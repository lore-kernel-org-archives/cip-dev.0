Return-Path: <yoshitake.kobayashi@toshiba.co.jp>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F52DC28B2F
	for <webhook@archiver.kernel.org>; Thu, 13 Mar 2025 01:33:26 +0000 (UTC)
Received: from OS0P286CU011.outbound.protection.outlook.com (OS0P286CU011.outbound.protection.outlook.com [52.101.228.8])
 by mx.groups.io with SMTP id smtpd.web11.34855.1741778798311750129
 for <cip-dev@lists.cip-project.org>;
 Wed, 12 Mar 2025 04:26:38 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@bp.renesas.com header.s=selector1 header.b=RgvFKZel;
 spf=pass (domain: bp.renesas.com, ip: 52.101.228.8, mailfrom: tommaso.merciai.xr@bp.renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bFPf+o8zzB1UApp0iLMd2TJfxwHOkWJEOBeXV5DcTrd9QSzVkcCITpRpc594cW4oMMoUDZQi8bkpoECa9+V9y9zr/42dj/38OsUHVFUeuVQPgJUTJBdTQ3LI9vhzLV8OsOmUPHR0nqvT6uuCChM3stz2k//9MKMwZ6Y1g1WSvFkiKV6l99PgDzb8/9xzpQFWyiykvYZb681DhsU7oMS2PwqpyC0fDSAxwUYPtlSLdwFtGnRjGkpbje3sYtX7mSHvlA9Pvr3aTAsxVSpG5s7RAh7VRk/38f1VVY0zko2fmUsjQ6nwprh0maLvqRQrQ6LE/EDCOs8nG/AA0wKMt2A5uw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ridfjyFWQMdCVBqqgF5/Fb/SQOTywn6GC6FoZ4RM4S4=;
 b=M9KbQ5KbD506PhRXCnGVrBIZIly/9i9BtZjVAtxgXd2Q5Dvlb2pbqKA0ZNtCtqibVyltFTnz0QQYR0MMqz5lZTjHjq/XSsNwYyEkxT+L+70k/6IJqHod/4wMScNLMJL3ldAt+IfcSB6HbDeKbJaiSrcVQvVY4slXJVbnTWgIy/p8WcsY0mEst3N8zcyw8/CDIuTjHyJkdcXknnmU6kQpshqF8N2El8Ougshi1QkXqJBQvfEBmyEIqEDRNGecO5sEi13k1yB+dTHiySxs2xLScpZhreyvJ1AnG41EDccpK38+Lw+Zy4cMY9RJLLc3rP4VOj/h143rmeoXMhyBttjVgA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ridfjyFWQMdCVBqqgF5/Fb/SQOTywn6GC6FoZ4RM4S4=;
 b=RgvFKZelcyv3eRvXd9x5eXCoc7SpNl8Z+A1FpyhSjwMzLsQUL4Z7BV68NztnEApkZr688wN+fhLTSetAI24XkYF78ALfcOCbm8bR8E8H7jPWCTbqnbUMyCOJg92JKFkmuO3z6dgE9lQF1zY0QoWabH3j8Kh59OYl6GA5zBiYQfo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
Received: from OS9PR01MB13950.jpnprd01.prod.outlook.com (2603:1096:604:35e::5)
 by OS9PR01MB13175.jpnprd01.prod.outlook.com (2603:1096:604:30b::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.27; Wed, 12 Mar
 2025 11:26:35 +0000
Received: from OS9PR01MB13950.jpnprd01.prod.outlook.com
 ([fe80::244d:8815:7064:a9f3]) by OS9PR01MB13950.jpnprd01.prod.outlook.com
 ([fe80::244d:8815:7064:a9f3%5]) with mapi id 15.20.8511.026; Wed, 12 Mar 2025
 11:26:35 +0000
From: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
CC: Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	tomm.merciai@gmail.com
Subject: [PATCH 6.1.y-cip 61/85] pinctrl: renesas: rzg2l: Update r9a09g057_variable_pin_cfg table
Date: Wed, 12 Mar 2025 12:22:38 +0100
Message-ID: <20250312112302.1605750-62-tommaso.merciai.xr@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250312112302.1605750-1-tommaso.merciai.xr@bp.renesas.com>
References: <20250312112302.1605750-1-tommaso.merciai.xr@bp.renesas.com>
X-ClientProxiedBy: FR4P281CA0246.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f5::15) To OS9PR01MB13950.jpnprd01.prod.outlook.com
 (2603:1096:604:35e::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: OS9PR01MB13950:EE_|OS9PR01MB13175:EE_
X-MS-Office365-Filtering-Correlation-Id: 601ccd71-33f4-4f5b-133c-08dd6158bf3a
X-LD-Processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|1800799024|366016|376014|52116014|38350700014;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?h+S7HgZRZpjfEUyd2oPrqX2NxSK4uWPOMmYfF4yghYrc2DUWNdCFIp2v0Djh?=
 =?us-ascii?Q?hr1cQO5p3uU4xDG9Rk/gXy3+pxFYndW0hAl7Bfo/AdVIi9o1bdmhswyjYBYV?=
 =?us-ascii?Q?ZOg1HQKEMlOWjBagvbpceSbA9qrxd1tLcHtvEktq1ScZ3pnwBBM+kpdt1pdp?=
 =?us-ascii?Q?SxIE1j3qqVbY6hk/vYzrz+n1nBa28tMdF7R9jTAU0rCqTBshtQby5cudZyUs?=
 =?us-ascii?Q?zKvtC4C3ONyA+QYo1qXCOObN8Ae2JleKRcfAsdk9OUXSgq0S3MSEQ/7Y8XvE?=
 =?us-ascii?Q?J2cvVhMJKgu0PgiOfmSv4vBmGjyNWI/Pu2+U1O+VQi8M8tyf4/NwXfGkG7+C?=
 =?us-ascii?Q?VsPymvnh/QZ7/jD4OBNddNQ7O9YsrzHeWD+bVkldzr+ZSMTI3nQ6Jn1h5H4G?=
 =?us-ascii?Q?5zY+ReptVz9fEgX59QcPrFtfJn2UWT3nOhx9e/70Jo6GYxYqgTJVCc8jpTxB?=
 =?us-ascii?Q?KdPp4QxlPDkYaVKvzEvnoWdsETg76PLSZzyv/u72sP3OIAJRGwPMFJkUC9JO?=
 =?us-ascii?Q?HUXDNkhTqBMq/orTkquY3w4gs7wXnSCY4Pbx+n7i+kGurmuN6Co6q5pRWu0J?=
 =?us-ascii?Q?OHakBlF+j5WygeTj/gRWR1F3yjqGPE54XKpIb8u6Vc9u6JMIW8uF6vRJ0+Ke?=
 =?us-ascii?Q?HriCymjbv5JiuEtCgw/5CcDSa2ypdmXSnJzwpGqFiEmMUotyTeyL0Cg/rjES?=
 =?us-ascii?Q?ElHWUgyllMjc8fwOFTvRc9P3N0AmSHS2J+gdgXgDVqckjvYrzWShtJlYTI89?=
 =?us-ascii?Q?tlnLZ2Zyx5kAOLWt+i8XOfiQZg8ddpMC//kx4Dyhke9U3FkpOnBS6R/dMK0Z?=
 =?us-ascii?Q?xBf8vFH3C3NOuLgHoXB/vNl/6f6yy0JpfVgkm3YvyFqcPpHAdUv3+tKyETtU?=
 =?us-ascii?Q?mSXaNK8M9Mi37iKb6BxNU8jNyWdPd+mfGgtbW+Q/tTcNDEwS3uQnz6lfJ4EP?=
 =?us-ascii?Q?3DTbhxBlSPGn/xTNUvXAkInEYPG9cKGnpcmWC9kbcIlOCB4DiOtKv+HrRtyI?=
 =?us-ascii?Q?s40u9BfeVPT2zIwBefSG84iQJs831jOK4jkNiQexOnMjVXBKJzHmzhlWOEjt?=
 =?us-ascii?Q?USZV8VouSBZGZsQGbWyohfjOlSs07Y3X/3yg0Lap4bcRqUe9qmlWZ+rh7bqK?=
 =?us-ascii?Q?UPQnEvUAtL6M+g/L/eV4ksnUuywlsauPWM7QB4SAusmOSpdjhaUNmy28t8Qx?=
 =?us-ascii?Q?T9aSOpQHOmFpyr/gSkNzQfTY427dxsn2yvRQz4irTnofqo0r7CN/GYs3GZ65?=
 =?us-ascii?Q?es49lKgDcvWGZqAVEql8hfJ8B4FVFELTtgaJ4Gi6p34AqV0S8X99n/ga8AHo?=
 =?us-ascii?Q?Z1u1cQV9t2Xuqoip+8lit4C7KpeceVPZL0PTTuWoEKRs1TTDWpRYk+9wVSLt?=
 =?us-ascii?Q?TMK+VvppbHSPUct9gk8mDxfuXXxwdpTAh5IAvirsoFyyADgK1btNwHl4GZnY?=
 =?us-ascii?Q?ZvFCu+yuz5K+4dNuAdQSkw+19A1xO8Zn?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS9PR01MB13950.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(52116014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?ypr62KpgQ73Lq1n8NviuKhT22+oAcvUf/zY/BGWGJjyrSsGai1yAe5JWBQPz?=
 =?us-ascii?Q?mOt+vhxK6So9N62Uj7Z2Snmo7eTDMkuuNJD8By9DnIsuUhH2GcuPn3GUqYRO?=
 =?us-ascii?Q?YZbKa9JapzlEIXd3FQSHCsS/dfyMpK5+C/lvmDdZAJT66Oc9dXfahGB3jaEV?=
 =?us-ascii?Q?0xpcXki0E8dOPSjRMCVbWvJvHyIeM1vgZBcDj8ESwEYBP44B+qb1ethsttu+?=
 =?us-ascii?Q?q/8XN1y8mhy+DR1yao/nxfkvEymM49TqDTByXCIdDkrQ9JiDj8a1YJbveRu5?=
 =?us-ascii?Q?i8xZmfXmUCLHKHOQw/HgCTQCb+5r27OZmPnTX7npFVwYLNHFFffCtnRBjHMK?=
 =?us-ascii?Q?OU2iKEn/xQiKmpYKeKrKtAhEqIRnnhmhdLFUxLNKYZVhGpd/awvlQodO2x4g?=
 =?us-ascii?Q?TVXEa38DbrtPKNRjZUGQDiLG25UgncvE0x8BfjQNDDIdOp+rxZr2wOii7pic?=
 =?us-ascii?Q?aa7uND9pULlh3cA8CF5QJephAWnerXFX0e3UvTND6TB9mJE6xTj8TtCcWQNE?=
 =?us-ascii?Q?wT67XZzr8WsPt2jD9GuOm688mRMic2U12ABg9El7HgIRDmT46U1hllM1+z0T?=
 =?us-ascii?Q?XvD7Pkisfw7hNMUvOGvLGl2AnM3WXwy03fma35/ZnS5BPpVx3yHC0rQRZKsO?=
 =?us-ascii?Q?G86KTOojiOGTi+5DqAuEofOD2d7xb7Bzlke25vPdIwnma9i+m62cM1eigYsV?=
 =?us-ascii?Q?HaCo1zDK2h574zipT5KHRSlZj1vZr2+MDnt+7rbHrJhsyL4SW2cP0KpJlCQA?=
 =?us-ascii?Q?tjpS7Sq6vMrLE7Wm2/2Nt8Iowxej5Gps7yr0pSK0lrtD/irsAQqdXJ01q9k8?=
 =?us-ascii?Q?t9g+uJtqkm4KMKr+7tHJLBWhsakl/AfyRXPn5OtEA8Z25oHbRPGsj+3F0mEX?=
 =?us-ascii?Q?MG2U+yHADBnwBZd16xgg8UWbNVJFGTzD4eVAFb2s3jCvBVHwgXiyaZ8nA88z?=
 =?us-ascii?Q?oHeCSxqouf1X/aR7ANgOtcfKCtw/ACN7tlO2aPBBUukMICN0zIAohIADFEAN?=
 =?us-ascii?Q?3cDu0qmu12Pbf6JZYHjoyrMsRudLtA3vBPrbAmZ0K7xYsJJ2ARd+WofV/6PW?=
 =?us-ascii?Q?6hfNREyitUxkiXBd688JY5ef9GycyDqYjmnBYVS8hqBIpbldpGZ+agNj9g4P?=
 =?us-ascii?Q?3TIZTzjmVzZobEQHg91rGLBQFA3wJxQcSdzPQjJulGkzmjcsUl6e47lVLVyI?=
 =?us-ascii?Q?sH2RCyo3w8xaVTcGj+sGce32BX31GHMXbROG7naHOedJo48Z5L4QrSut+Cgf?=
 =?us-ascii?Q?6aj4aHQc7TbVwVq+J4T0lqi7MdTMKTWcCE7hFObq+hQReDVIr6tNvtAIuqKt?=
 =?us-ascii?Q?trEV998r67bcaW3QCbkyAILPXnqYSriSoSklBgVzmGc5vbP2k8hImb2olUZS?=
 =?us-ascii?Q?FOoAjwLPSXtWT5bNp4S3bvihyKaxS5fADJ2O8PEaRPj1OoioWQLK5jCT/uaZ?=
 =?us-ascii?Q?wrgkZSTvK3mGkYbxFgjnsXm+vRkFujtHKPvF8tJwCqDaM7fHSXYSJfYQ3bqh?=
 =?us-ascii?Q?KOC2bClj7nARL5r1/Mf5O9qfRG64LhgaBAucTmO/v8AdmOMy8iuxdCcZRaNy?=
 =?us-ascii?Q?gPDJzLhJAUB83TRjscwQ+mn7kcWlX9ZN06k5oDEUAKrjGmEcElKEoK1WQlB2?=
 =?us-ascii?Q?MIt1vZImIETMnLXDJHpaqDw=3D?=
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 601ccd71-33f4-4f5b-133c-08dd6158bf3a
X-MS-Exchange-CrossTenant-AuthSource: OS9PR01MB13950.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Mar 2025 11:26:35.3021
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WGd538eAbhuE6UxBLA2+6N7B8ifWHazoxDGdE5GWTfm+l5Z9mvFJmSI68zBohI9lAB8hzgAD8aPyBIdKs8biaxOBrgGP3SQctM/LasVBDOP61LPbUhm3bKoAxBQm0bUW
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS9PR01MB13175
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 13 Mar 2025 01:33:26 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/18153

From: Biju Das <biju.das.jz@bp.renesas.com>

commit 0ce66380a7c7566c91d4a159751d5801280957c1 upstream.

Currently r9a09g057_variable_pin_cfg table uses port 11 instead of port PB
as mentioned in the hardware manual. Update the r9a09g057_variable_pin_cfg
table with alpha-numeric port names to match with the hardware manual.

Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Link: https://lore.kernel.org/20241216195325.164212-4-biju.das.jz@bp.renesa=
s.com
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 drivers/pinctrl/renesas/pinctrl-rzg2l.c | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/drivers/pinctrl/renesas/pinctrl-rzg2l.c b/drivers/pinctrl/rene=
sas/pinctrl-rzg2l.c
index 353f9b139413..045033fc84f2 100644
--- a/drivers/pinctrl/renesas/pinctrl-rzg2l.c
+++ b/drivers/pinctrl/renesas/pinctrl-rzg2l.c
@@ -25,6 +25,7 @@
 #include <linux/pinctrl/pinctrl.h>
 #include <linux/pinctrl/pinmux.h>
=20
+#include <dt-bindings/pinctrl/renesas,r9a09g057-pinctrl.h>
 #include <dt-bindings/pinctrl/rzg2l-pinctrl.h>
=20
 #include "../core.h"
@@ -381,12 +382,12 @@ static u64 rzg2l_pinctrl_get_variable_pin_cfg(struct =
rzg2l_pinctrl *pctrl,
 }
=20
 static const u64 r9a09g057_variable_pin_cfg[] =3D {
-	RZG2L_VARIABLE_PIN_CFG_PACK(11, 0, RZV2H_MPXED_PIN_FUNCS),
-	RZG2L_VARIABLE_PIN_CFG_PACK(11, 1, RZV2H_MPXED_PIN_FUNCS | PIN_CFG_IEN),
-	RZG2L_VARIABLE_PIN_CFG_PACK(11, 2, RZV2H_MPXED_PIN_FUNCS | PIN_CFG_IEN),
-	RZG2L_VARIABLE_PIN_CFG_PACK(11, 3, RZV2H_MPXED_PIN_FUNCS | PIN_CFG_IEN),
-	RZG2L_VARIABLE_PIN_CFG_PACK(11, 4, RZV2H_MPXED_PIN_FUNCS | PIN_CFG_IEN),
-	RZG2L_VARIABLE_PIN_CFG_PACK(11, 5, RZV2H_MPXED_PIN_FUNCS | PIN_CFG_IEN),
+	RZG2L_VARIABLE_PIN_CFG_PACK(RZV2H_PB, 0, RZV2H_MPXED_PIN_FUNCS),
+	RZG2L_VARIABLE_PIN_CFG_PACK(RZV2H_PB, 1, RZV2H_MPXED_PIN_FUNCS | PIN_CFG_=
IEN),
+	RZG2L_VARIABLE_PIN_CFG_PACK(RZV2H_PB, 2, RZV2H_MPXED_PIN_FUNCS | PIN_CFG_=
IEN),
+	RZG2L_VARIABLE_PIN_CFG_PACK(RZV2H_PB, 3, RZV2H_MPXED_PIN_FUNCS | PIN_CFG_=
IEN),
+	RZG2L_VARIABLE_PIN_CFG_PACK(RZV2H_PB, 4, RZV2H_MPXED_PIN_FUNCS | PIN_CFG_=
IEN),
+	RZG2L_VARIABLE_PIN_CFG_PACK(RZV2H_PB, 5, RZV2H_MPXED_PIN_FUNCS | PIN_CFG_=
IEN),
 };
=20
 #ifdef CONFIG_RISCV
--=20
2.43.0


