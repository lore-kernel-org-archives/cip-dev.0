Return-Path: <tommaso.merciai.xr@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C776EC0476
	for <webhook@archiver.kernel.org>; Tue,  3 Mar 2026 09:23:47 +0000 (UTC)
Received: from TY3P286CU002.outbound.protection.outlook.com (TY3P286CU002.outbound.protection.outlook.com [52.101.229.55])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.14398.1772529821689641264
 for <cip-dev@lists.cip-project.org>;
 Tue, 03 Mar 2026 01:23:42 -0800
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@bp.renesas.com header.s=selector1 header.b=INnMdPt8;
 spf=pass (domain: bp.renesas.com, ip: 52.101.229.55, mailfrom: tommaso.merciai.xr@bp.renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dPEi/f+e5sLzWXkAmgljz1TJgK995qddlX4oqnTWOZe6cmlPCICLdV2qb0oYUGriQhKXdfMjB9H1xjzSkNY3ckAUUwm2hvibU/UgxsjuhK2M2UathzqWqlFG/09/NR6UvbMTaGd0+nIkxbbaJ146ceZd15sBjou3K0vazfZEWIUaRnTGY+PjkZLiAJibmP8FWIaigDzoLjDZizCFTBTnwZEQrRtT2gR87LOqmuO0+m+rnD+TjNNmCF0+y6NNxQDmdaj2Bin5lAjN8HE2FRP9qMkUkS7rHmxU3IP1/TeggvROe0CMtHqP3+rQeEVCiIU0Y52vNsKOD91lgz89fkOHmg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QIhUMvbzY57l1JzYOFCHwN3OTnbEAglq+KJE79frNtc=;
 b=orkReWlcMooFtXx7CWXO1ri7U1LvLxvjpiKDUYTertua+0+XwaAV3BHhViYASaY4U3lYHsZl05ql2fUkM3kyf3TFXP05S2DRM1opYLMTjAICn3PoF8ZAawfq80sd04kure5vQLDuqUEHLySa+//SbdgI34bjthQXBvb7CIEwBIDzjboLBmQxoiceQUjPC25gS89LOJou+KStDmV6Lxzqh1SxsIynK/1nkoW94DhF0GsEG7LfnrTGOsDstgbgdApfbK/pxAU1WZ4Vj7qCbHvoQ01QBiB9RfBlP0Ngh/yyvtAMR1yTlaYC5UiLQhrcU1KbsgqjM4sieAhG05EiGp01Tg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QIhUMvbzY57l1JzYOFCHwN3OTnbEAglq+KJE79frNtc=;
 b=INnMdPt86Cs+AbcleZuDAhBQ/59vbh/KLNGnhKm8B9d7ElUgjUJUuqqP3Y5SmgOQR9D4tninata93n5dueILN1eIYyMq2oAnFVgAd8WbA1hryfir+DFLeoxJtzs/+FRxplEw3u0/Ox22r9dBLRkk1fJ9CT6e2/3s9P8FbjEWNjQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
Received: from TYCPR01MB11947.jpnprd01.prod.outlook.com (2603:1096:400:3e1::6)
 by TYCPR01MB8342.jpnprd01.prod.outlook.com (2603:1096:400:15f::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.22; Tue, 3 Mar
 2026 09:23:36 +0000
Received: from TYCPR01MB11947.jpnprd01.prod.outlook.com
 ([fe80::33f1:f7cd:46be:e4d8]) by TYCPR01MB11947.jpnprd01.prod.outlook.com
 ([fe80::33f1:f7cd:46be:e4d8%5]) with mapi id 15.20.9654.022; Tue, 3 Mar 2026
 09:23:36 +0000
From: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@nabladev.com>
CC: Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	tomm.merciai@gmail.com
Subject: [PATCH 6.12.y-cip 4/7] i3c: renesas: Switch to clk_bulk API and store clocks in private data
Date: Tue,  3 Mar 2026 10:22:56 +0100
Message-ID: <20260303092259.13301-5-tommaso.merciai.xr@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260303092259.13301-1-tommaso.merciai.xr@bp.renesas.com>
References: <20260303092259.13301-1-tommaso.merciai.xr@bp.renesas.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: FR5P281CA0022.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f1::8) To TYCPR01MB11947.jpnprd01.prod.outlook.com
 (2603:1096:400:3e1::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYCPR01MB11947:EE_|TYCPR01MB8342:EE_
X-MS-Office365-Filtering-Correlation-Id: 516a019b-1a49-4ddf-9528-08de79068c42
X-LD-Processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|366016|1800799024|376014|52116014|38350700014;
X-Microsoft-Antispam-Message-Info: 
	KEzP6r6PXxHDg2iuxYBlk2EKa4dH3oX+yBHgrYjCXv5dLWSGQ3EO1TSZkmAfNYrFsYIJGXko17GIbopc/bwKmqUSeuhEsYVZvRl1hSfyg98tPl0Wawl29oxzsmhzNbd59ppVDYK59tkQRPXWN5v4ST0y4A6VIrYYewoNKjID7S5OErNjg4eeVyp7XlHvO0NOlPXlChjz5shho9edoxDzzmUeuuHkgv9yv2cy5dyNMh7ZwP8cpaG1F3Gjwyx23NmSfJIqj5XWCNbeH5or4vS5HmnS7jRzotAI6ErjkMcA9sVlo+5qYJ3X1Sm/Bd04lfVfl12aXkFVUnE9WQiAPYCCd9qlVUl2Mfa75yqNVV/wq0OKYzW4QAZIDvwbJhArofFM4/iz7VYtBqTlrnTYxh92eijnSSsjyUWAcmE+CBYfvuuT6cntl5RuhjjgruBhNkPWYWD/g2gXG9Yd+bav2DYJ9uE68e8stBHU0AbVC1MCQtJ0f2USQADoIv13O4xgm9MIYuKBKPjAqz35ESYsPVuBrtqkZErPQjPLc4IG6IWDlZtylxdtQvKwzC5GXUaRwIH0oZKkvP9+aewSBMfBL9X2oyXDPV752QCUQdi3wRaDuHFbvymE1v6djDkj/YnFDgwq65v2N3XT5YHvsGdM/wCCj1KQYxtpcSFC1DmAe1F59GgY5Q/mS6FQg7mTQYXEwAA02JEjSGG77oY3gsfQ1DBAdEpXfkEIMUG/n/6fT1yb76M=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYCPR01MB11947.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(52116014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?nWmSox86nYXRfrbA/Tf5/88L7wp3laoZbBMMI+dO+fAdSA9lRMbhQDwCy/14?=
 =?us-ascii?Q?bTGA4qOa3NR4Li+f0ZVovbPaL4ADbOElAAlEoyUkF7dRV/5b/3GPaNjbW1R8?=
 =?us-ascii?Q?3kg6vZUVfsVaozTDX5HCK1S0SxWWLpMNDwY2IDDvjWfQyCrPm0gjnA03mrTc?=
 =?us-ascii?Q?uQE9ckFJy3lf91mkISbV8vvyN2uSQTbfh6TjlN4H0T3mZi8ZGjZHi6lUh515?=
 =?us-ascii?Q?kP+yGcmx34d6Be0bm+QTE3uYDC452autP/qze162IDfemj8D7WkZLtm2gbot?=
 =?us-ascii?Q?JQSW0tK5F8Tc/tLyXDAtd/fsKKUs5+l3wg0r5ltd9Z5+ebG/+hZTCl1/08Ur?=
 =?us-ascii?Q?yRmW3Rl6s4Hzrsvdo+aLYpdxOVZ44zqNq7nKxs1MZjl0LGaHoTCBdZdMsdy1?=
 =?us-ascii?Q?Vcf7duxFlhKGc9U2t222L+uLVLJJKGy7PhdogkwNJi3aIEYloscBKYhsEABU?=
 =?us-ascii?Q?aoaY247SWYAX2susIbF8C5JsVSqj2Mx8cAVW8wFjEGD+UYm+DtBky7u/t9xr?=
 =?us-ascii?Q?OBWl6yoVczwkByg3s3n734ZoXLFij/7SKpe2o25A6kJVu+C/U8esSjeEMBmk?=
 =?us-ascii?Q?vGCFegT5PDLO+g/qhwKNlbAd8tmFfCpuNa6mrgRczywlILcBLNsDCtUuFxEB?=
 =?us-ascii?Q?8jabFIfzxsvO+qu340+Ld26TgrL/uk6/5uDXQngyD/7VE/LBAjVIsMKhuhfX?=
 =?us-ascii?Q?wHsmwH+CkhGk65wi1fYONGm8tkfupIcn2Tbtw6/PEkqGeNzqZaG6zGz8GBjX?=
 =?us-ascii?Q?Kl/21TwxZh7HC3o2zysYRNjrqjf8QqgBW3NWx6L6npvxDT4cpmgbhvqwN9cG?=
 =?us-ascii?Q?Yf8IUwP31WG5EQ2LDQrKufAxC4Re5uCf0fGF90lONHr19uL4ttap6HwTtgXf?=
 =?us-ascii?Q?gpEdGwwSGVuvg8lDLq2G4n2EKeis0s/cyZTTynd/ErRkmvh/QjL0D4+LMj51?=
 =?us-ascii?Q?qCvIprPOAoAzWt+tqrMCYtft3j+HF3SGD0GCRc9CKEZqVhrM8btFaKYjm/0F?=
 =?us-ascii?Q?WHf9oG/xbcSdrrtD1Ezy/al9/ezlY5D+OPNUnAi8cro8uUQ8LWENEkSM4J9d?=
 =?us-ascii?Q?NXh8qVgSfTzWtNxskagmSSXuAQmaPrb+8VZy7oz2DPhmqnlF9xGjpQ9xn4iy?=
 =?us-ascii?Q?EB5LceiyMhACit/9NWyjkzSo49HSLuq6HGVVzrVsGzBY7E/MEcO4gdjCch5n?=
 =?us-ascii?Q?pQKUIHaIx85MZn2AYmpa2wxj+1q9ppHph+566zstDrXQy72HpNPlnIt3u0DD?=
 =?us-ascii?Q?/deiWWWial4j+OHz3GjqVsD5Nlbsg97DFnaYMm7pF7Q4JF8BOITYZvOC1EPV?=
 =?us-ascii?Q?5AVB7O0PapucYeoC+dSMa9+50xZx7AjZvCJIE6pZHzqGpBJmpZo02QcP+1Tf?=
 =?us-ascii?Q?v5R91Zu1Ep6PuZnwJwhDujI5I4pkdtCQkLMhX2kLD1ryggAb6HE6n4LezeCC?=
 =?us-ascii?Q?fafa7IBCiH4XuJsFQuLuXm+oe6iz6B2/yoXDCseMxHI77AoewumGGuPa55e6?=
 =?us-ascii?Q?s0DvRyWbbUL1M0e9FIVBoG7h8Q/j/+PsCLoiOP0sPYNcD2u8M2Vcddg75wfw?=
 =?us-ascii?Q?a+6A3JcibCuxHfrioNcoiE2tM/qjTY1Dap9nWHfEeRcC7TH+e+BI6uC28Dsz?=
 =?us-ascii?Q?yaspokoKz5Lp9azZxi9nUm6Ko0lqKueVgOKZ0dYq8HeXfrpt6+hJeDXrJ/8R?=
 =?us-ascii?Q?Q51a2jKfLFDoio7gSjq3sU+y/0MaTOXX1tWiOx3TgbI993wzbWFlz1xNZov3?=
 =?us-ascii?Q?o8jQ0gQHRdoFv9XLUrCrrHzeXVtW+OMnKDhVy3MMg2EGwSex63Gg?=
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 516a019b-1a49-4ddf-9528-08de79068c42
X-MS-Exchange-CrossTenant-AuthSource: TYCPR01MB11947.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Mar 2026 09:23:36.6712
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: el0dCe/FNTnEV4DphSYOowNg/jZ5MmbFMn+pp0KfvKbHmogDy9eDthqK+Lly1hkr3vmAbtYk+RLietGgqY9/P1FXVX+SYqKRCo1lB+KzSRBckdnEvP8M4cetGKmy3E67
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCPR01MB8342
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 03 Mar 2026 09:23:47 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/22055

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
index 275f7b924288..496783331773 100644
--- a/drivers/i3c/master/renesas-i3c.c
+++ b/drivers/i3c/master/renesas-i3c.c
@@ -198,6 +198,8 @@
 #define RENESAS_I3C_MAX_DEVS	8
 #define I2C_INIT_MSG		-1
=20
+#define RENESAS_I3C_TCLK_IDX	1
+
 enum i3c_internal_state {
 	I3C_INTERNAL_STATE_DISABLED,
 	I3C_INTERNAL_STATE_CONTROLLER_IDLE,
@@ -259,7 +261,8 @@ struct renesas_i3c {
 	u8 addrs[RENESAS_I3C_MAX_DEVS];
 	struct renesas_i3c_xferqueue xferqueue;
 	void __iomem *regs;
-	struct clk *tclk;
+	struct clk_bulk_data *clks;
+	u8 num_clks;
 };
=20
 struct renesas_i3c_i2c_dev_data {
@@ -272,10 +275,6 @@ struct renesas_i3c_irq_desc {
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
@@ -489,7 +488,7 @@ static int renesas_i3c_bus_init(struct i3c_master_contr=
oller *m)
 	int od_high_ticks, od_low_ticks, i2c_total_ticks;
 	int ret;
=20
-	rate =3D clk_get_rate(i3c->tclk);
+	rate =3D clk_get_rate(i3c->clks[RENESAS_I3C_TCLK_IDX].clk);
 	if (!rate)
 		return -EINVAL;
=20
@@ -1302,13 +1301,8 @@ static int renesas_i3c_probe(struct platform_device =
*pdev)
 {
 	struct renesas_i3c *i3c;
 	struct reset_control *reset;
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
@@ -1317,19 +1311,12 @@ static int renesas_i3c_probe(struct platform_device=
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
 	reset =3D devm_reset_control_get_optional_exclusive_deasserted(&pdev->dev=
, "tresetn");
 	if (IS_ERR(reset))
@@ -1374,16 +1361,9 @@ static void renesas_i3c_remove(struct platform_devic=
e *pdev)
 	i3c_master_unregister(&i3c->base);
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


