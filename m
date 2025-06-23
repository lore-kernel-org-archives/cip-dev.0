Return-Path: <tommaso.merciai.xr@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7AF34C7EE2A
	for <webhook@archiver.kernel.org>; Mon, 23 Jun 2025 14:47:42 +0000 (UTC)
Received: from OS0P286CU010.outbound.protection.outlook.com (OS0P286CU010.outbound.protection.outlook.com [40.107.74.12])
 by mx.groups.io with SMTP id smtpd.web11.377.1750690058779558842
 for <cip-dev@lists.cip-project.org>;
 Mon, 23 Jun 2025 07:47:39 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@bp.renesas.com header.s=selector1 header.b=u7YqvClX;
 spf=pass (domain: bp.renesas.com, ip: 40.107.74.12, mailfrom: tommaso.merciai.xr@bp.renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fIdn6Nv5x1zVk8vz5M7EOqZY+SaJYVwCaOKzcuELOdlztGcYe2Cc5sIifyL4NAkBHvMocv7FuwBirLN91teq45VNAKYSJ6SB1d1QAL8E98D/2A93jKK2Cv0FeNivhEX5384yterp+SaOnvuvOpRaSQAyXHLWP9QCfd876DUV2W5J5N5lB2yZONiRr2u57eN5exhDAYbXWdELV/3clyAddq6wwmGSOHCP/P4wUjAHtFgY3FUtQoIsT/LUdVqyM87sRJRDPPqq1zigJCS8dEnlu65r5hGdmZpiqmAwqkqInaQQ4xTUrrZf5/5yqW5rB7uiDH2b7aUP7dqs+tTwhgE4/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8UkUixWk88H0q9i4aJ+2jJdMTuTI0uS2tTdwKZVB+l4=;
 b=mz/qyPALDH4iX6mpsywQfeliEJBJyVRk4l5qcnes1JBfIaMWl355hT5eB/TwmfDL7Nq/0PVhrbj2q80OPSlj0Xz28f4cmjUnt8ymUxZD0QH/VVMdmhVRLRZ1QJlqa9ZJg2I3/PRym4dQxgN4pANDXRqTObdsQ/KmHmXgpOoGW9i4dyq6672Fbc7CAVChx/snD887RHWMy4b5l7u0wyeclocsQ7R6iFY+F2f2gy4fCnB8y7OT3ZrH1edikWN6RPlWmY7EYS19/T57pR5o3GH2zhWTcFBiaMUY/wXYm9Uwah9nla1VAqToMPdBvT0vEPJiczLH18Oi1jYYPUACBCrcvw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8UkUixWk88H0q9i4aJ+2jJdMTuTI0uS2tTdwKZVB+l4=;
 b=u7YqvClXUOcW/SvvJKnJnwK28o5EYx8B84iuvxrS68YbzuDfGZkQbw56ctT8rK18r3x2/LIF+e0r/hAvDZHqCQIWFyDuCpf2m42Rw+DxJcG6A6P4cPpVPr1FD1nxK1nitOSNE7seOEi6aCf8QEOyT9Hohdbi0adaf+jl1flqZzY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
Received: from OS9PR01MB13950.jpnprd01.prod.outlook.com (2603:1096:604:35e::5)
 by OSCPR01MB16379.jpnprd01.prod.outlook.com (2603:1096:604:342::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.21; Mon, 23 Jun
 2025 14:47:37 +0000
Received: from OS9PR01MB13950.jpnprd01.prod.outlook.com
 ([fe80::244d:8815:7064:a9f3]) by OS9PR01MB13950.jpnprd01.prod.outlook.com
 ([fe80::244d:8815:7064:a9f3%6]) with mapi id 15.20.8857.026; Mon, 23 Jun 2025
 14:47:36 +0000
From: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
CC: Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	tomm.merciai@gmail.com
Subject: [PATCH 6.1.y-cip 11/17] mmc: renesas_sdhi: Add support for RZ/G3E SoC
Date: Mon, 23 Jun 2025 16:46:33 +0200
Message-ID: <20250623144639.2119707-12-tommaso.merciai.xr@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250623144639.2119707-1-tommaso.merciai.xr@bp.renesas.com>
References: <20250623144639.2119707-1-tommaso.merciai.xr@bp.renesas.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: FR3P281CA0066.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:4b::17) To OS9PR01MB13950.jpnprd01.prod.outlook.com
 (2603:1096:604:35e::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: OS9PR01MB13950:EE_|OSCPR01MB16379:EE_
X-MS-Office365-Filtering-Correlation-Id: 1f4c4482-aaa0-420e-1537-08ddb264e513
X-LD-Processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|1800799024|376014|366016|52116014|38350700014;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?bxZuPPisxLBqZxqo4uJk4eB7vZ/2ekcm1vS+ndWlsSmvbPERbJ9dc+hJKCHA?=
 =?us-ascii?Q?5cokG4owl1fvPuSXWMn7PC9UIERFowhjdtwiaFPVum6o4ZBEU97xejpv9TQV?=
 =?us-ascii?Q?anl7RaQIe1CImHGTd9LYZI5ImIeTF6M2FPWdWYCdcroM0vyayWEE0uTJVvn3?=
 =?us-ascii?Q?D37dmxgFR8l/+nr6ttO/yekzydcYnCgIHl6cS5Pz2cZcqcPhxkLGEqiGd7zI?=
 =?us-ascii?Q?tGaFC5VlQdRHNu089TMmI1Hwx2V2EMww8OE+vwXhpXgQZctLl3KVvdqiNhxm?=
 =?us-ascii?Q?CcfxwxMgnz5LsnLcZU7SrtW854h95eUXj6CNM6+XprjD3pM+3HiYZEXosldG?=
 =?us-ascii?Q?wDBMfRXNr/oJEbk7vQQOIqf3ZAGSD5V3cU4tnxVK5A+VdHk3z9cW9xpUQ5GM?=
 =?us-ascii?Q?m8fcuiRK+XtMXR6ORsuNquzBhEhyx8Gp1gOlJjoKidxxIH5FjVtbS61NxheH?=
 =?us-ascii?Q?9ESDsl8+C4fviIRTKPPMytYTG+XNgQG5qCZTxdKTvc1EYFoypaHc6oITSTgM?=
 =?us-ascii?Q?tku7NHjs4g1M7updAOER146ELs20fRQuPufUeUMwIt1yZI1hz3Idq5fZnhmG?=
 =?us-ascii?Q?JiHLU5FLuJjWR/VNd1kjUdLb/TW2e5W+1JqM6KPL4Ey/t4F4BSCXYHP7zMfJ?=
 =?us-ascii?Q?5nS8pWGNVTDTqqhI6j59kXb1b8uy3ZvFpxj/KqTfwlpL7sQd5JxRh7qeOdBD?=
 =?us-ascii?Q?kSttDvHpB5PPh/OgCXo3AOKXWcUzwFxssAYXRELsHNV/bzBpxXUryPMP1TSC?=
 =?us-ascii?Q?B1QG1buAN4qPNr7JbVj6XQHLgdfbn9ZyWOm3ZFsmPgmYjSbuPWMk/Wb7NxNQ?=
 =?us-ascii?Q?qenSGrnsIMBbcnSsl/liA7IkrIjhRb6U+nfkkhM85VUlhISYeJsTly/zJ5hP?=
 =?us-ascii?Q?XtqycOzKdLJ6zPSyNFsi38uGYZxRk+PSuFR9RC7c1+ahwHyQ8nWyVayPoT49?=
 =?us-ascii?Q?OXKhrO0R3DqhaouGk34AoNdRwy2xoX5rfEojSlBpDgPAdzZzd2Yw8A9Cp9rJ?=
 =?us-ascii?Q?RW24iYHviWvAuYOXfG+IJxTxp6ORn7PPMRy7KN8Wt1mGfcT5zSi+m7bbgO0e?=
 =?us-ascii?Q?wMoKHeTeRTy1CPeW5HZlCVjQyzM397tigOIkJjIxD2u39BGGUUlhzbztlJTE?=
 =?us-ascii?Q?rlERBqj41vWdVXJxWLfxN0K5UAIhG5rvHnxAtxaJFgdaWkTzjETRYYxAwlSV?=
 =?us-ascii?Q?L+KG9yaMxprIp0UMgkfVq5CYF84/uUpdcBTtFGl05ho/BuzP4CogkbWaICV4?=
 =?us-ascii?Q?mmADazR9S3TWNDPQCbd+RbS2EcDsTWtdSQeXSIS0oDQ6ES4UqANIxgiKhRWS?=
 =?us-ascii?Q?c4mHAmndNT5os+4/PRGQJYNKgNTlZT6vuSlWLXasoIA3akZchrKEjTRzoj75?=
 =?us-ascii?Q?cTU+j5uCQwPpyvV149Udo2p3McG6x/EgiEEoYf2DcyD/3P4pgLSHhyOEJrcf?=
 =?us-ascii?Q?VjlR+VsDwmUYYG2AnBJworLkcrIKjArhkCHAnCnI8sOQUgbCebLZUw=3D=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS9PR01MB13950.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(52116014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?zU3t8lmfOIjqskGKp/gLtaJUsTydjDPkdPOF+Vnft6OUBacea2K6Nber5wW8?=
 =?us-ascii?Q?tfYcBHc4eB62p7aJ5wwbYmUrS9J4tw/w6WJqg+h6aWMf8OqNFQUZqJLb0WiJ?=
 =?us-ascii?Q?JiYGbeuU3TQOaE1WYuPoqoojBHjjltmLzBVzQ/p1MhoNri7ziwRbSSpr9+IR?=
 =?us-ascii?Q?+GIVQZzCFNNh9Do8eus+0Te/LGQN6CCHDkYIvEUnd1u4PSLalBWd9MtBQxix?=
 =?us-ascii?Q?6WMMh7OI15JAlJAoiopbQp72gB/UXHj0++xlineo5S9J9ddWVWWuXJ4MD1Kr?=
 =?us-ascii?Q?yvMgMjb9bxdNJTFelDY2m8958EbSdXqnNQWnyA6LnDDWxXECqUX68pERuQIb?=
 =?us-ascii?Q?z24q/eeJJVHrlS6fvdceaGE47LtyxHWWT+FAWOib+Z56uPWJ5U5B2Vs0fq0R?=
 =?us-ascii?Q?baB7P4WHQtJMhZAqs2i+xRwflkp1oKS4miKIUfgOalTCK/6XGtr1TshQQI/l?=
 =?us-ascii?Q?nMwyUtWS50RTsbo5D0OOSCwOT2W4lM6stTYhN7qSbtim9Bo4rPGi4z51i49L?=
 =?us-ascii?Q?0BndiZoc6Oye6mstVWLkxtJP0+XKnvMDzW0yeIUvooy4x0I7BeE7aqDMUSUF?=
 =?us-ascii?Q?9kRTJX64Lf6lQryQzluR9gMiV4lwp1zOWjCc5QOZ6e+m/r82F4/ZimBxvf0f?=
 =?us-ascii?Q?mzA/oe7RNNicdgSIBfj342hxtR8YTmVtEYJ36+YGhLEYVPvVdttQl0QGCaxn?=
 =?us-ascii?Q?wGnDyP4cbBGo3XXpXuX/YahoYHKvEYMRYPcSMWoIh2hwj/S6mYD0pHi7RB6x?=
 =?us-ascii?Q?EG0ik5iuaW3j1EkPJ7gm0jLcuYC3cdwaz+a6gQm/drfiKpR44pO8K30aZyJD?=
 =?us-ascii?Q?/4u12BB9pvO6YlN7zWceHZ6xN5pNRzHaJSmfdn1QHCltGKGdrXcR1tEkAUAn?=
 =?us-ascii?Q?t9o7+ZHq7n49FXkKzRr5I7g4zg8VWAITFAbtcDynuPCpZAQTmywzOoJzeoP6?=
 =?us-ascii?Q?6sIXN8eYe/+6Jf0nIsaw5AxqhJWXHhgnDlCHHeSSb8hTGBS1U/s1CG8E2kDz?=
 =?us-ascii?Q?qy4SOHpuZOdy1lJ9Q2qk1/rRvPJH6IxDSJ9N601KctBut2Au2lyvxVidikb+?=
 =?us-ascii?Q?Qut15immuZv+qhJ+m1CSyRaa8VP0yKvHwiB3MC0KDWDhCaFZ8e+pHCCq6s43?=
 =?us-ascii?Q?PrGAWd2vt8R7Zgg+aOVZ1iIJ3WZyUG/zJ6I9zFxK29P+nYL+dsVVYzvl7Qy3?=
 =?us-ascii?Q?8/WSPpElKhaYfiOwtSqdm5mUWZqLlDyjWN3szC4EPfShcxLLkVG0U4sWHtzd?=
 =?us-ascii?Q?U/g5gaKRsXSRMz+kf9k8vcVsxl0C0J1tPPUThvKw75Wk8K5XkuT5kVB26gSl?=
 =?us-ascii?Q?k/x4Bo7yeSYmMjTk2cS24KQ3qpsrYshDH7SN+HJKZh/nzrxYUc69Mv/oeeS0?=
 =?us-ascii?Q?iqptdCw7yiLJhjmAu2q+n4l5K8bGEvMqZgLIrzbfsP01YiDWTruqwq/iQZKf?=
 =?us-ascii?Q?RKdVI168pzBxb+TCvlX1rz+rf5mlahZMbZrZ5JJf80axnfNXAkeZOlLB9KGQ?=
 =?us-ascii?Q?7hBql/3RRnQpGqCwRfic4R1egpKgGjMewGMMzB72KlbbN43Lo9wKCvrDhv+L?=
 =?us-ascii?Q?I3/O9ahHJUIWpbhLNhgCR4AQFJc+4RXRl1L+zhTPzB27eSjgtQbud3UMQNLP?=
 =?us-ascii?Q?oWwfvJF6hRiC1exVA3fA5gQ=3D?=
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1f4c4482-aaa0-420e-1537-08ddb264e513
X-MS-Exchange-CrossTenant-AuthSource: OS9PR01MB13950.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jun 2025 14:47:36.9151
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: j4VVFxc7HRwRgzdG3GB2Y6jKRB3qAusJD2pMV92PCQy27ZLULN4e1dm9sa3OA1nPquF8aamWqQw8uasOWUnWNlHiTWOwq+t8Co/Kjc0MJx+Z9U+/UvCQrEBh4SUhs1Nf
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSCPR01MB16379
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 23 Jun 2025 14:47:42 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/19198

From: Biju Das <biju.das.jz@bp.renesas.com>

commit fae80a99dc0320be854aa789cbe7ed0e1e574c61 upstream.

The SDHI/eMMC IPs in the RZ/G3E SoC are similar to those=C2=A0in R-Car Gen3=
.
However, the RZ/G3E SD0 channel has Voltage level control and PWEN pin
support via SD_STATUS register.

internal regulator support is added to control the voltage levels of
the SD pins via sd_iovs/sd_pwen bits in SD_STATUS register by populating
vqmmc-regulator child node.

SD1 and SD2 channels have gpio regulator support and internal regulator
support. Selection of the regulator is based on the regulator phandle.
Similar case for SD0 fixed voltage (eMMC) that uses fixed regulator and
SD0 non-fixed voltage (SD0) that uses internal regulator.

Reviewed-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
Link: https://lore.kernel.org/r/20250305092958.21865-3-biju.das.jz@bp.renes=
as.com
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
[tommaso: Squashed the commits ede057759b83("mmc: renesas_sdhi: fix
	  error code in renesas_sdhi_probe()") and
	  77183db6b8db("mmc: renesas_sdhi: disable clocks if registering
	  regulator failed") and
	  9078f01fec12("mmc: renesas_sdhi: add regulator dependency")]
Signed-off-by: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
---
 drivers/mmc/host/Kconfig             |   2 +-
 drivers/mmc/host/renesas_sdhi.h      |   2 +
 drivers/mmc/host/renesas_sdhi_core.c | 133 +++++++++++++++++++++++++++
 drivers/mmc/host/tmio_mmc.h          |  10 ++
 4 files changed, 146 insertions(+), 1 deletion(-)

diff --git a/drivers/mmc/host/Kconfig b/drivers/mmc/host/Kconfig
index 525a9ff39a54..eda621cdafa1 100644
--- a/drivers/mmc/host/Kconfig
+++ b/drivers/mmc/host/Kconfig
@@ -713,8 +713,8 @@ config MMC_TMIO
 config MMC_SDHI
 	tristate "Renesas SDHI SD/SDIO controller support"
 	depends on SUPERH || ARCH_RENESAS || COMPILE_TEST
+	depends on (RESET_CONTROLLER && REGULATOR) || !OF
 	select MMC_TMIO_CORE
-	select RESET_CONTROLLER if ARCH_RENESAS
 	help
 	  This provides support for the SDHI SD/SDIO controller found in
 	  Renesas SuperH, ARM and ARM64 based SoCs
diff --git a/drivers/mmc/host/renesas_sdhi.h b/drivers/mmc/host/renesas_sdh=
i.h
index 770850ee067f..517c21ea9751 100644
--- a/drivers/mmc/host/renesas_sdhi.h
+++ b/drivers/mmc/host/renesas_sdhi.h
@@ -93,6 +93,8 @@ struct renesas_sdhi {
 	unsigned int tap_set;
=20
 	struct reset_control *rstc;
+	struct tmio_mmc_host *host;
+	struct regulator_dev *rdev;
 };
=20
 #define host_to_priv(host) \
diff --git a/drivers/mmc/host/renesas_sdhi_core.c b/drivers/mmc/host/renesa=
s_sdhi_core.c
index 4052ef027647..cb089997e4bb 100644
--- a/drivers/mmc/host/renesas_sdhi_core.c
+++ b/drivers/mmc/host/renesas_sdhi_core.c
@@ -32,6 +32,8 @@
 #include <linux/platform_device.h>
 #include <linux/pm_domain.h>
 #include <linux/regulator/consumer.h>
+#include <linux/regulator/driver.h>
+#include <linux/regulator/of_regulator.h>
 #include <linux/reset.h>
 #include <linux/sh_dma.h>
 #include <linux/slab.h>
@@ -581,12 +583,24 @@ static void renesas_sdhi_reset(struct tmio_mmc_host *=
host, bool preserve)
=20
 	if (!preserve) {
 		if (priv->rstc) {
+			u32 sd_status;
+			/*
+			 * HW reset might have toggled the regulator state in
+			 * HW which regulator core might be unaware of so save
+			 * and restore the regulator state during HW reset.
+			 */
+			if (priv->rdev)
+				sd_status =3D sd_ctrl_read32(host, CTL_SD_STATUS);
+
 			reset_control_reset(priv->rstc);
 			/* Unknown why but without polling reset status, it will hang */
 			read_poll_timeout(reset_control_status, ret, ret =3D=3D 0, 1, 100,
 					  false, priv->rstc);
 			/* At least SDHI_VER_GEN2_SDR50 needs manual release of reset */
 			sd_ctrl_write16(host, CTL_RESET_SD, 0x0001);
+			if (priv->rdev)
+				sd_ctrl_write32(host, CTL_SD_STATUS, sd_status);
+
 			priv->needs_adjust_hs400 =3D false;
 			renesas_sdhi_set_clock(host, host->clk_cache);
 		} else if (priv->scc_ctl) {
@@ -901,6 +915,102 @@ static void renesas_sdhi_enable_dma(struct tmio_mmc_h=
ost *host, bool enable)
 	renesas_sdhi_sdbuf_width(host, enable ? width : 16);
 }
=20
+static const unsigned int renesas_sdhi_vqmmc_voltages[] =3D {
+	3300000, 1800000
+};
+
+static int renesas_sdhi_regulator_disable(struct regulator_dev *rdev)
+{
+	struct tmio_mmc_host *host =3D rdev_get_drvdata(rdev);
+	u32 sd_status;
+
+	sd_status =3D sd_ctrl_read32(host, CTL_SD_STATUS);
+	sd_status &=3D ~SD_STATUS_PWEN;
+	sd_ctrl_write32(host, CTL_SD_STATUS, sd_status);
+
+	return 0;
+}
+
+static int renesas_sdhi_regulator_enable(struct regulator_dev *rdev)
+{
+	struct tmio_mmc_host *host =3D rdev_get_drvdata(rdev);
+	u32 sd_status;
+
+	sd_status =3D sd_ctrl_read32(host, CTL_SD_STATUS);
+	sd_status |=3D SD_STATUS_PWEN;
+	sd_ctrl_write32(host, CTL_SD_STATUS, sd_status);
+
+	return 0;
+}
+
+static int renesas_sdhi_regulator_is_enabled(struct regulator_dev *rdev)
+{
+	struct tmio_mmc_host *host =3D rdev_get_drvdata(rdev);
+	u32 sd_status;
+
+	sd_status =3D sd_ctrl_read32(host, CTL_SD_STATUS);
+
+	return (sd_status & SD_STATUS_PWEN) ? 1 : 0;
+}
+
+static int renesas_sdhi_regulator_get_voltage(struct regulator_dev *rdev)
+{
+	struct tmio_mmc_host *host =3D rdev_get_drvdata(rdev);
+	u32 sd_status;
+
+	sd_status =3D sd_ctrl_read32(host, CTL_SD_STATUS);
+
+	return (sd_status & SD_STATUS_IOVS) ? 1800000 : 3300000;
+}
+
+static int renesas_sdhi_regulator_set_voltage(struct regulator_dev *rdev,
+					      int min_uV, int max_uV,
+					      unsigned int *selector)
+{
+	struct tmio_mmc_host *host =3D rdev_get_drvdata(rdev);
+	u32 sd_status;
+
+	sd_status =3D sd_ctrl_read32(host, CTL_SD_STATUS);
+	if (min_uV >=3D 1700000 && max_uV <=3D 1950000) {
+		sd_status |=3D SD_STATUS_IOVS;
+		*selector =3D 1;
+	} else {
+		sd_status &=3D ~SD_STATUS_IOVS;
+		*selector =3D 0;
+	}
+	sd_ctrl_write32(host, CTL_SD_STATUS, sd_status);
+
+	return 0;
+}
+
+static int renesas_sdhi_regulator_list_voltage(struct regulator_dev *rdev,
+					       unsigned int selector)
+{
+	if (selector >=3D ARRAY_SIZE(renesas_sdhi_vqmmc_voltages))
+		return -EINVAL;
+
+	return renesas_sdhi_vqmmc_voltages[selector];
+}
+
+static const struct regulator_ops renesas_sdhi_regulator_voltage_ops =3D {
+	.enable =3D renesas_sdhi_regulator_enable,
+	.disable =3D renesas_sdhi_regulator_disable,
+	.is_enabled =3D renesas_sdhi_regulator_is_enabled,
+	.list_voltage =3D renesas_sdhi_regulator_list_voltage,
+	.get_voltage =3D renesas_sdhi_regulator_get_voltage,
+	.set_voltage =3D renesas_sdhi_regulator_set_voltage,
+};
+
+static const struct regulator_desc renesas_sdhi_vqmmc_regulator =3D {
+	.name =3D "sdhi-vqmmc-regulator",
+	.of_match =3D of_match_ptr("vqmmc-regulator"),
+	.type =3D REGULATOR_VOLTAGE,
+	.owner =3D THIS_MODULE,
+	.ops =3D &renesas_sdhi_regulator_voltage_ops,
+	.volt_table =3D renesas_sdhi_vqmmc_voltages,
+	.n_voltages =3D ARRAY_SIZE(renesas_sdhi_vqmmc_voltages),
+};
+
 int renesas_sdhi_probe(struct platform_device *pdev,
 		       const struct tmio_mmc_dma_ops *dma_ops,
 		       const struct renesas_sdhi_of_data *of_data,
@@ -908,7 +1018,10 @@ int renesas_sdhi_probe(struct platform_device *pdev,
 {
 	struct tmio_mmc_data *mmd =3D pdev->dev.platform_data;
 	struct tmio_mmc_data *mmc_data;
+	struct regulator_config rcfg =3D { .dev =3D &pdev->dev, };
+	struct regulator_dev *rdev;
 	struct renesas_sdhi_dma *dma_priv;
+	struct device *dev =3D &pdev->dev;
 	struct tmio_mmc_host *host;
 	struct renesas_sdhi *priv;
 	int num_irqs, irq, ret, i;
@@ -967,6 +1080,8 @@ int renesas_sdhi_probe(struct platform_device *pdev,
 	if (IS_ERR(host))
 		return PTR_ERR(host);
=20
+	priv->host =3D host;
+
 	if (of_data) {
 		mmc_data->flags |=3D of_data->tmio_flags;
 		mmc_data->ocr_mask =3D of_data->tmio_ocr_mask;
@@ -1049,6 +1164,24 @@ int renesas_sdhi_probe(struct platform_device *pdev,
 	if (ret)
 		goto efree;
=20
+	rcfg.of_node =3D of_get_child_by_name(dev->of_node, "vqmmc-regulator");
+	if (!of_device_is_available(rcfg.of_node)) {
+		of_node_put(rcfg.of_node);
+		rcfg.of_node =3D NULL;
+	}
+
+	if (rcfg.of_node) {
+		rcfg.driver_data =3D priv->host;
+		rdev =3D devm_regulator_register(dev, &renesas_sdhi_vqmmc_regulator, &rc=
fg);
+		of_node_put(rcfg.of_node);
+		if (IS_ERR(rdev)) {
+			dev_err(dev, "regulator register failed err=3D%ld", PTR_ERR(rdev));
+			ret =3D PTR_ERR(rdev);
+			goto edisclk;
+		}
+		priv->rdev =3D rdev;
+	}
+
 	ver =3D sd_ctrl_read16(host, CTL_VERSION);
 	/* GEN2_SDR104 is first known SDHI to use 32bit block count */
 	if (ver < SDHI_VER_GEN2_SDR104 && mmc_data->max_blk_count > U16_MAX)
diff --git a/drivers/mmc/host/tmio_mmc.h b/drivers/mmc/host/tmio_mmc.h
index 873a06a179c8..86bf13fa8bde 100644
--- a/drivers/mmc/host/tmio_mmc.h
+++ b/drivers/mmc/host/tmio_mmc.h
@@ -43,6 +43,7 @@
 #define CTL_RESET_SD 0xe0
 #define CTL_VERSION 0xe2
 #define CTL_SDIF_MODE 0xe6 /* only known on R-Car 2+ */
+#define CTL_SD_STATUS 0xf2 /* only known on RZ/{G2L,G3E,V2H} */
=20
 /* Definitions for values the CTL_STOP_INTERNAL_ACTION register can take *=
/
 #define TMIO_STOP_STP		BIT(0)
@@ -102,6 +103,10 @@
 /* Definitions for values the CTL_SDIF_MODE register can take */
 #define SDIF_MODE_HS400		BIT(0) /* only known on R-Car 2+ */
=20
+/* Definitions for values the CTL_SD_STATUS register can take */
+#define SD_STATUS_PWEN		BIT(0) /* only known on RZ/{G3E,V2H} */
+#define SD_STATUS_IOVS		BIT(16) /* only known on RZ/{G3E,V2H} */
+
 /* Define some IRQ masks */
 /* This is the mask used at reset by the chip */
 #define TMIO_MASK_ALL           0x837f031d
@@ -242,6 +247,11 @@ static inline u32 sd_ctrl_read16_and_16_as_32(struct t=
mio_mmc_host *host,
 	       ioread16(host->ctl + ((addr + 2) << host->bus_shift)) << 16;
 }
=20
+static inline u32 sd_ctrl_read32(struct tmio_mmc_host *host, int addr)
+{
+	return ioread32(host->ctl + (addr << host->bus_shift));
+}
+
 static inline void sd_ctrl_read32_rep(struct tmio_mmc_host *host, int addr=
,
 				      u32 *buf, int count)
 {
--=20
2.43.0


