Return-Path: <tommaso.merciai.xr@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17783EC0470
	for <webhook@archiver.kernel.org>; Tue,  3 Mar 2026 09:22:37 +0000 (UTC)
Received: from TY3P286CU002.outbound.protection.outlook.com (TY3P286CU002.outbound.protection.outlook.com [52.101.229.10])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.14378.1772529754382664367
 for <cip-dev@lists.cip-project.org>;
 Tue, 03 Mar 2026 01:22:36 -0800
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@bp.renesas.com header.s=selector1 header.b=pkItHDUV;
 spf=pass (domain: bp.renesas.com, ip: 52.101.229.10, mailfrom: tommaso.merciai.xr@bp.renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eV/c8b0vfF3WCp5WEmIYQenCAGt1MpGcAuGeWDOiM5adXA+OpgOHkQEcaoQQ2xHAlHFNfHlDMC6mZso1sX6REY1Wq7yF3V5IIkAm+id9kAoO/AqvjVCD0hix75YdsCwHYNXQZBcl2qtQjZ5qJcR/ct9Y1JGq7Ga4Um+ZHP3EKreHO2QEpcUCvf2TXBu0Br0L/WSSVzwnYeBvGYuH90iKWKghHjg/wG6tD5yF75Tb9lJw0aj/MQbpPOZys75Bcl0Ss1vHARV2SiD6izXYaQi97GaMxTWimRyaxQ2i9TOiBU+xjRVa2MhLIAX26BnewqgPoIorsLBXBlXG3YHVNPvFMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yN5mRmIQOLxZ//OmjQNzpP2T8ab6pW0eWmizhWk7BFg=;
 b=gRcJ44Buo4da5NrMcg7Ok6UWbfhUtSI3fVyS85HOwbR0rjT/8NN4CzrThf5nwO7JgtYEhXNw+Lqx+lZXLt6R0vjeUoPr2og+TGl1ryySK1TNoHI8DyMHzyKEjJXog058DsSPVFN0A7IAlPPT0vg3xlzVBqPTVngVL3PEp7a92mSsWKM2QihbXzarG0VzZ0o/x5DYxzfTiUT3M5OlE/2oRurKnZb+hkS/urq7ohYKtkmBE2xYZ9Kk2u+4lqCcOEGGw+HGTDhsD9sFj4Q8VggugPTWA8BFXcXrma+OTEQ1z1N6RL7uyDUDXQrMkZloQPvCvUCfgdhLwoa027qmWh6eog==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yN5mRmIQOLxZ//OmjQNzpP2T8ab6pW0eWmizhWk7BFg=;
 b=pkItHDUVCzOm5OW9BrHcBjHav65GcrbxA5ggUg6aVMuh1ZNHqWTMKlkiUHIHoMa994C+EwJlSzemhLDhC39IIMkZ7JkQmLWZpuRYpCfUWdh59zdCXARpDlh5PGVQsQ1qJ+hAM5GulUp7zr9OPVtku8+f52pqUV+5mOVjM1dFeL0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
Received: from TYCPR01MB11947.jpnprd01.prod.outlook.com (2603:1096:400:3e1::6)
 by TYCPR01MB8342.jpnprd01.prod.outlook.com (2603:1096:400:15f::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.22; Tue, 3 Mar
 2026 09:22:30 +0000
Received: from TYCPR01MB11947.jpnprd01.prod.outlook.com
 ([fe80::33f1:f7cd:46be:e4d8]) by TYCPR01MB11947.jpnprd01.prod.outlook.com
 ([fe80::33f1:f7cd:46be:e4d8%5]) with mapi id 15.20.9654.022; Tue, 3 Mar 2026
 09:22:30 +0000
From: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@nabladev.com>
CC: Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	tomm.merciai@gmail.com
Subject: [PATCH 6.1.y-cip 6/9] i3c: renesas: Switch to clk_bulk API and store clocks in private data
Date: Tue,  3 Mar 2026 10:21:37 +0100
Message-ID: <20260303092140.12732-7-tommaso.merciai.xr@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260303092140.12732-1-tommaso.merciai.xr@bp.renesas.com>
References: <20260303092140.12732-1-tommaso.merciai.xr@bp.renesas.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: FR0P281CA0088.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:1e::8) To TYCPR01MB11947.jpnprd01.prod.outlook.com
 (2603:1096:400:3e1::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYCPR01MB11947:EE_|TYCPR01MB8342:EE_
X-MS-Office365-Filtering-Correlation-Id: f1266cb8-9261-4dd0-9825-08de79066328
X-LD-Processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|366016|1800799024|376014|52116014|38350700014;
X-Microsoft-Antispam-Message-Info: 
	c0JI8Ck68TjtlFgWxy+/a9YFcYVKJJjIVayNIGHVeM7nGAbD7lXURwfRjb7/29TqUE0YxSkUb2f0A3CecRItSbZcwLyJn2iHm0ey96VE/91VgSYH64YTXetUe5/KpMQeC75pfIN186Ld0BmHpPfBdYZ2vilp83tA2YY5YCbSYP5062MPZyoR2Zz75Yqxr5h3/OsLeRA568nLnoyTWCDE8qlcQQXBUT45F45XG19I84zs6iLQDjS9bbvV+ho+JKdBBcWrGX7UQkvyrwqNf0etZrt1s5G7h4ic9p3Dy1PP0lSydO1sdZ2iJjj6tnmRbbJyu9ehUrO8m6TsNeQTi3xwgxlB9o74vNoO44lWagg8JSno3JCpHcyx340OkZgkx18KFsgdYJgPIdXv4cjstN/etdQOrKjuvBZW/Yvtah+k1WnLqD/V3cbHwxHuV9a2lXCoK46fj5SPfIhp+iFQsYD+qVZztmup1wLaCDopPPjGOObDbYCkwKNBTU9uVHAYyNNJAWEDSWVR93xzJ6JnoaApak6NR/xmhLKA/fDkWsyxpSGqLTxlxOexehWr2OqMd6bjodFXRrpYzyD9bXu9+9LlX2KTKubccJxSbuQpm6Ngzmlg+MavKa0Vw4eTjvo8SIx+xyY3+3W5jbNe8mR031QnG/s3tN3JITb/LcQ8Nzo+VacQmjdkwIbYcmqcnx9Y8SaEiWp/wY7OcPayYZQzpFgYbOIMJHGh/2AFV1iocAcpXLs=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYCPR01MB11947.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(52116014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?8ErxmEKoIL/hmC549kF+TBZG+vUCIuRjI7lFGT5yBN6jZaGYH+n+8GsIX/hA?=
 =?us-ascii?Q?q3PelpVMerjaUqLSyR90Y8dwyDIoW1rP9RpU9WB4lieiPf55x9+4lu/zu0bc?=
 =?us-ascii?Q?B36UaWs6oeWy/p8l5vbw4p5o+wNz/WM8lAiUV2KgeOcTKtp0K5E9X6fD2SoU?=
 =?us-ascii?Q?6pgvASbiQ3JmJOcbR4SMz3Jod/l7dZbGWGrVDQPJNNI3lkvk6s1ZBrFG+u9m?=
 =?us-ascii?Q?mce7DWXB2uM0meg0PR2PJhPWCHOGdO65HAvUH5L+EneryPgAtJw7vbbQCu48?=
 =?us-ascii?Q?erhJdn9/lSRenXHrRkMJOkZgN5TnOMnF/Y91wLJkB3jRcMkuAc737Lkcui6E?=
 =?us-ascii?Q?fIQt/pmTgfyk6HXiSXQfTARL20inx6Hqx3qioeLziHatkxAxq+sfTYWpC+DQ?=
 =?us-ascii?Q?P0jSkd4vYXmkAzsMXQAinoVYC/fxDAFfn0xW118LoAyLFno+bglI25CoGgS9?=
 =?us-ascii?Q?VedeWJgT4bwaQOfmVqxMWd6PJSmrN/RHAEApOO3RVmdP4f3mf2Oh5qi0qKG2?=
 =?us-ascii?Q?MxYS/psS5vwU3TMU0zjkaAJOuCQyIrMu9gNtq0HQMyMSkooYIvaFYJ2RlWjh?=
 =?us-ascii?Q?W1rw0FUDuRkEVHYDpGxDvoNPN+f27AxNH+hnNHvTg8qcyKEaVEwurjWwGdSO?=
 =?us-ascii?Q?wBgrSPrgvj+Nai3WsbITCQhtv66MrQSlu41+YAifXkDDY7eZ9Yx+kb7AN0ii?=
 =?us-ascii?Q?5PFUiruJvY3Yw+3wQRdH5arIkkgAt00XlJoS8jJ+MW/Ssez4cGJFUQr7ZD1E?=
 =?us-ascii?Q?FZ/uL4nuSgTcogYp3oQWNoLKwMJrxRVB0qznT5exutkcC4en7tnj9inNqrGi?=
 =?us-ascii?Q?NL0sq+gVRUfG6vdHZ5EZl7mSjWARKiOk/N7ItippWARuTnAD0SYupfwpAwrr?=
 =?us-ascii?Q?o0n2+mdG3gRtm1KGBCsOKp98TvQCO9lYqackpflgDWg654BUCebWDwrLdRcP?=
 =?us-ascii?Q?PRRBLH3pSlfn1eGUZuhRAscVzPFfPV2TmBU+BBNB+nl6UO5cgM6mb0oj2GcD?=
 =?us-ascii?Q?yPVX7RAQEXrnxoWQQdm5aP3L0IdRi0dKFPttuVH24pMC/B2HFofWaLDiUNBp?=
 =?us-ascii?Q?HhYhk+cmOPeGc+cEuB/5RqK0OGlBP/LR0LaIa81yg1y0n+jUThRzFtVbbo4Y?=
 =?us-ascii?Q?YVutbcI8qC4mBipq7kuEnczWQY6TbJakgIpAGA6aokX1E3ydsoZqbExqJUcZ?=
 =?us-ascii?Q?c8QiBuRj33UPljzcBqabFl1P4iHpoAKF85Uc+3Z4GyJUT87t6M/ji6fdIyxu?=
 =?us-ascii?Q?w6VGfZqVlKF2AfTwRW7W9L4zBsyVapjNaj27O01HCxNyGQSSpunZHa+OZ3Rv?=
 =?us-ascii?Q?KzFrPqwyVcn8VoiNObcuHXMtg/FN3lYcZLwj/0U/4Ym4YeY0MIpslOV1Jmwu?=
 =?us-ascii?Q?B1qye1Y/91gqsEpAyWfW/ZtGobrYoY7hOnT+TgzP7QWDDpl7vxHewx4UGZpK?=
 =?us-ascii?Q?69lfMX93PpXtKgDArx7Uob9cn8/vuCO2cpChyBGtwUE630E39du9V23W2Mmy?=
 =?us-ascii?Q?Ldy2vZ/XrpJy6UrqtU71OakC/xOOIVdhtH58FeSoPu9ZwHhykhq3DpbKMa2Q?=
 =?us-ascii?Q?kbWgfG+zbgznQMhq4KsNqyPVGKILG8++CwQ57bMIarrBZQVCWimRk3aFNV6S?=
 =?us-ascii?Q?Sik63vgwTDmoTHyymTAw3ceUxNacNQHPyHFX3q7IRtTDkp79r29LofZHQo7F?=
 =?us-ascii?Q?KUV3cUGa3Ffae6ym2b3yBv/jE4JAdt+9AGHp/iPKI65JdPrS6T4ySiopRXOr?=
 =?us-ascii?Q?3sxWJeoE/sTNXVE+vyW08a2isPcVTBI9SEXdN5+8+mjuvWXPaLOC?=
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f1266cb8-9261-4dd0-9825-08de79066328
X-MS-Exchange-CrossTenant-AuthSource: TYCPR01MB11947.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Mar 2026 09:22:27.8016
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2aewbGIFGyRU1xS/z1RV6Ek6oid6ziHhorfWPyVHrnlUoH3MuNJyE6jxhbClPfP8HB/I8PRYsnNitid/h5KSj6/8SxHLCB1Qc+4Jsa+LwqU2uRGqotoWS6ZyGs2CucAD
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCPR01MB8342
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 03 Mar 2026 09:22:37 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/22047

commit 579c7255922a3e0ba432eb608deb7d0fed896052 upstream.

Replace individual devm_clk_get_enabled() calls with the clk_bulk API
and store the clock handles in the driver's private data structure.

All clocks required by the controller are now acquired and enabled using
devm_clk_bulk_get_all_enabled(), removing the need for per-SoC clock
handling and the renesas_i3c_config data.
The TCLK is accessed via a fixed index in the bulk clock array.

Simplify the code and prepare the driver for upcoming suspend/resume
support.

No functional change intended.

Reviewed-by: Biju Das <biju.das.jz@bp.renesas.com>
Signed-off-by: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
Link: https://patch.msgid.link/1286f8600b542da55facf9920fed7c06b2b0e4d5.176=
7781092.git.tommaso.merciai.xr@bp.renesas.com
Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
Signed-off-by: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
---
 drivers/i3c/master/renesas-i3c.c | 46 +++++++++-----------------------
 1 file changed, 13 insertions(+), 33 deletions(-)

diff --git a/drivers/i3c/master/renesas-i3c.c b/drivers/i3c/master/renesas-=
i3c.c
index 040376903a98..b1efe19abd74 100644
--- a/drivers/i3c/master/renesas-i3c.c
+++ b/drivers/i3c/master/renesas-i3c.c
@@ -199,6 +199,8 @@
 #define RENESAS_I3C_MAX_DEVS	8
 #define I2C_INIT_MSG		-1
=20
+#define RENESAS_I3C_TCLK_IDX	1
+
 enum i3c_internal_state {
 	I3C_INTERNAL_STATE_DISABLED,
 	I3C_INTERNAL_STATE_CONTROLLER_IDLE,
@@ -260,9 +262,10 @@ struct renesas_i3c {
 	u8 addrs[RENESAS_I3C_MAX_DEVS];
 	struct renesas_i3c_xferqueue xferqueue;
 	void __iomem *regs;
-	struct clk *tclk;
 	struct reset_control *tresetn;
 	struct reset_control *presetn;
+	struct clk_bulk_data *clks;
+	u8 num_clks;
 };
=20
 struct renesas_i3c_i2c_dev_data {
@@ -275,10 +278,6 @@ struct renesas_i3c_irq_desc {
 	const char *desc;
 };
=20
-struct renesas_i3c_config {
-	unsigned int has_pclkrw:1;
-};
-
 static inline void renesas_i3c_reg_update(void __iomem *reg, u32 mask, u32=
 val)
 {
 	u32 data =3D readl(reg);
@@ -492,7 +491,7 @@ static int renesas_i3c_bus_init(struct i3c_master_contr=
oller *m)
 	int od_high_ticks, od_low_ticks, i2c_total_ticks;
 	int ret;
=20
-	rate =3D clk_get_rate(i3c->tclk);
+	rate =3D clk_get_rate(i3c->clks[RENESAS_I3C_TCLK_IDX].clk);
 	if (!rate)
 		return -EINVAL;
=20
@@ -1309,13 +1308,8 @@ static void renesas_i3c_reset_control_assert(void *d=
ata)
 static int renesas_i3c_probe(struct platform_device *pdev)
 {
 	struct renesas_i3c *i3c;
-	struct clk *clk;
-	const struct renesas_i3c_config *config =3D of_device_get_match_data(&pde=
v->dev);
 	int ret, i;
=20
-	if (!config)
-		return -ENODATA;
-
 	i3c =3D devm_kzalloc(&pdev->dev, sizeof(*i3c), GFP_KERNEL);
 	if (!i3c)
 		return -ENOMEM;
@@ -1324,19 +1318,12 @@ static int renesas_i3c_probe(struct platform_device=
 *pdev)
 	if (IS_ERR(i3c->regs))
 		return PTR_ERR(i3c->regs);
=20
-	clk =3D devm_clk_get_enabled(&pdev->dev, "pclk");
-	if (IS_ERR(clk))
-		return PTR_ERR(clk);
-
-	if (config->has_pclkrw) {
-		clk =3D devm_clk_get_enabled(&pdev->dev, "pclkrw");
-		if (IS_ERR(clk))
-			return PTR_ERR(clk);
-	}
-
-	i3c->tclk =3D devm_clk_get_enabled(&pdev->dev, "tclk");
-	if (IS_ERR(i3c->tclk))
-		return PTR_ERR(i3c->tclk);
+	ret =3D devm_clk_bulk_get_all_enabled(&pdev->dev, &i3c->clks);
+	if (ret <=3D RENESAS_I3C_TCLK_IDX)
+		return dev_err_probe(&pdev->dev, ret < 0 ? ret : -EINVAL,
+				     "Failed to get clocks (need > %d, got %d)\n",
+				     RENESAS_I3C_TCLK_IDX, ret);
+	i3c->num_clks =3D ret;
=20
 	i3c->tresetn =3D devm_reset_control_get_optional_exclusive(&pdev->dev, "t=
resetn");
 	if (IS_ERR(i3c->tresetn))
@@ -1401,16 +1388,9 @@ static int renesas_i3c_remove(struct platform_device=
 *pdev)
 	return 0;
 }
=20
-static const struct renesas_i3c_config empty_i3c_config =3D {
-};
-
-static const struct renesas_i3c_config r9a09g047_i3c_config =3D {
-	.has_pclkrw =3D 1,
-};
-
 static const struct of_device_id renesas_i3c_of_ids[] =3D {
-	{ .compatible =3D "renesas,r9a08g045-i3c", .data =3D &empty_i3c_config },
-	{ .compatible =3D "renesas,r9a09g047-i3c", .data =3D &r9a09g047_i3c_confi=
g },
+	{ .compatible =3D "renesas,r9a08g045-i3c" },
+	{ .compatible =3D "renesas,r9a09g047-i3c" },
 	{ /* sentinel */ },
 };
 MODULE_DEVICE_TABLE(of, renesas_i3c_of_ids);
--=20
2.43.0


