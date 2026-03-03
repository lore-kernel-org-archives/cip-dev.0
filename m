Return-Path: <tommaso.merciai.xr@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2942BEC047B
	for <webhook@archiver.kernel.org>; Tue,  3 Mar 2026 09:23:57 +0000 (UTC)
Received: from TY3P286CU002.outbound.protection.outlook.com (TY3P286CU002.outbound.protection.outlook.com [52.101.229.65])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.14399.1772529828187645212
 for <cip-dev@lists.cip-project.org>;
 Tue, 03 Mar 2026 01:23:48 -0800
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@bp.renesas.com header.s=selector1 header.b=RbseXlE1;
 spf=pass (domain: bp.renesas.com, ip: 52.101.229.65, mailfrom: tommaso.merciai.xr@bp.renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CsT99g8ClWeQylOZs2BRcQ6GjqLK5DwBJxyNuQ4pkgXQjPjS5KlbD7azq1+Y1zqcZORDVsD9sfyiZDLYKq+e91Le+J7NGRWshynCGEcP0pjvbqzFmBMiQkwtyYpSq9qqlhFfGma4yCPkMZ8tIaaB9+JFi8LWG6nFOJ3n2nPpPC3jN6Z5ri0MA71MZEMZgrWcw24hFUJI431IMCWlQj7CgEkGoFUKWzX++m+wozO82rzj1dWdTYBm+2I1rMmQK2npKNhnxD63MKxzKNBL9u1LiuL756EJma1UBM329SXQHDgmmvUkzpZb9mtUe+0lSIvsbtsKAoCBUmtXHSPzB2BwRA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Fo1lKHDcSHwJrnwpg7GqQ8t735Dc0/6zI0nVO0+R7X8=;
 b=nUzhs2MpGYhYJLtUSYkUV2bt0B4StBZNZa5W8Z0nrQJNBtVTBDzoLyiZMUkYjEc4Y5B2+2y8fw83BDP8Q0JTfu34yuirMCPkPm4+vMJGpBJY2cJiuWUfI5awPsUUdXos3xC7y75UH5ZLZlwvY1LExaP8k4Xy8piDkf8dilYNO8Xh2WPcJDU/BQ2Jgc8STou+nJO2t7bhhEImZpp1eqO4EcTq2MsvywxrrNYIXZLIVy+HLsW/H7tTCCG8VKm2dFgobrTfvJhqXuXTRrTMyT9v81IY9jhi+xobJ68OcYwxLPGDC8g9id1tX5IRQ6AJw6ZkJGWJRbW5CPfRXblqr61pnA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Fo1lKHDcSHwJrnwpg7GqQ8t735Dc0/6zI0nVO0+R7X8=;
 b=RbseXlE167p0qKPfFcnWXee0Jl8xKOoyranOLiDvb7aB8ggewWioJX2P6Py37f/rxABk2qECnqRNO/4Ae5Z75F/n+lj97PbHmLsj6aaTn1NuaZ3J69EkLLyQqRmsukl9vO/R6IEM/5LqLrjBrNa8eg+few5Yo1amaKxHLP/GWzU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
Received: from TYCPR01MB11947.jpnprd01.prod.outlook.com (2603:1096:400:3e1::6)
 by TYCPR01MB8342.jpnprd01.prod.outlook.com (2603:1096:400:15f::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.22; Tue, 3 Mar
 2026 09:23:45 +0000
Received: from TYCPR01MB11947.jpnprd01.prod.outlook.com
 ([fe80::33f1:f7cd:46be:e4d8]) by TYCPR01MB11947.jpnprd01.prod.outlook.com
 ([fe80::33f1:f7cd:46be:e4d8%5]) with mapi id 15.20.9654.022; Tue, 3 Mar 2026
 09:23:45 +0000
From: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@nabladev.com>
CC: Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	tomm.merciai@gmail.com
Subject: [PATCH 6.12.y-cip 7/7] i3c: renesas: Add suspend/resume support
Date: Tue,  3 Mar 2026 10:22:59 +0100
Message-ID: <20260303092259.13301-8-tommaso.merciai.xr@bp.renesas.com>
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
X-MS-Office365-Filtering-Correlation-Id: 324740e4-c5dd-403a-5aef-08de79069156
X-LD-Processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|366016|1800799024|376014|52116014|38350700014;
X-Microsoft-Antispam-Message-Info: 
	dpzD0J8fDCa4Y343YJcqFN6Y10ik5ISedLIvRaQrv85E4d32Gh/zutxj6HB4JBl12mbS/vGX2OLq26BPEaX7w0veDtIrjbULSORhEXBLIVk3OqfyYIFHiZH4kV7tIdKiGwED41whhVYD6MWjbvoOhzHpXFWXI7pHKs7k7tKBJ1AW7H7DeViQKLBNUF41Q+zj4Xnywian+kEFvC1lOjoM7qUPDC3LYmBnAGBKIG8iKoWZcpjK1D4tmzPLfcjjT1Anatww6HjyYqCOHlz3dy0+UEz5SeyvKqmOfcE8SRObTPtYdCGrI9PZf736egwQdTC4eWTyUYKfFWmRh0FWytNykD4fKuZaVIBAQ6Gxw1/RzqeAGELhFno2Uj6vWckecW0EkBoA97RsefzlfsFsqF8BDMzOVkPoozzdMtMjDMuqvLBWqx9JA+egnMFY7fJUq+idEZ33KWSaquyyZGLMdgwPdiPczuDctzVWB2/8l25M1dtoPGUHact5fsKpxHWhkLgo3hTWXhA5ESJHohfyRBzydhJh3k4tsQxTdQn97W52spSuPLIq1PGfaZCHRWwtxPXyjSkDLf7x1LziyoOnrVx6FXD8kE8sxLSTK74dg9V9ibh5QHWrOg4CgSCxLVoplfrSWl2wVRR0bFGF0Zh4pkoahWrC67ZQ6+2PG7SVPAylubqN+3CAQM27KVeNz9OxlsciVAnSpiXpN2WYISznY7dywFBy/ANZ8bAgF7PNTxmHg7LlRIqjx0HlZGbSnD4eaMpk
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYCPR01MB11947.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(52116014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?pPkBiJiXs1+cE0frId5UnsKjpbPLFXk4WewIAsdL+FNLecVVsfLxNpjp+hfH?=
 =?us-ascii?Q?61OxqA6WTMNyuEe5wRIoMZ+sg7/VZFLsbq3ey/2jNBolGUNGwxTOl+4H6Yhw?=
 =?us-ascii?Q?dwYWK6oq5K4m4IwvwPwbdUirzgw4o/nU2I4lKY/cMGorEIKmFE2crXVtxYb3?=
 =?us-ascii?Q?oQCaKbV4OEJn/1jOQAoRfhOmziKipWRKpoS1fFIQyq75//U3B7GoLA4kJLiy?=
 =?us-ascii?Q?Qjdo38l8L455N0yyXEmDVfMlCXUTGX7U73hDT2YBtiu40WuLuvTfmVZ9uXk1?=
 =?us-ascii?Q?M5V3inZBEiIT0yqd+IV4YxcSSLIbZcDsY5nCVWDp1HxpeQDCPbBDM61pFJTf?=
 =?us-ascii?Q?D2OsIXG1SPDOjH1koDHs001u5Eg/YqKsQdt6t2gz7SFSpII2FoRATYxr16CI?=
 =?us-ascii?Q?F9PwoDDqs1NPcv2/EOv3InhgA85/ZqiVDFPjhW6M+3sODr5Sbn7MOKXs5iGg?=
 =?us-ascii?Q?IkwWe6hpHzFqt8Bz/fgb6fJsk2ii1jjRrgeaX56XTUToJ5lgrvxgbWzENV/J?=
 =?us-ascii?Q?oxFENgIWCPDMNSdjsh9/Fge3dPfEfkknXqmVZNozXg5BPNRpt4IJ+iBu0aD0?=
 =?us-ascii?Q?1QiJiTQMionIdTRyNPcSDMMQ8Ti+GXAB5ulC4l6nTsBcLOWGQ2YTHG0eM74c?=
 =?us-ascii?Q?aafNK7WUsfnCXz94eakM7Q5O258UYMr1BwIBPxmCJTt7KlPyNYp+rjARzMjL?=
 =?us-ascii?Q?nCimaOibI63jO88UhadrkbHJiSgZ3zinxPjNGl6jIfCojfrBq5rcip1/STH2?=
 =?us-ascii?Q?ZZBmcwBzFyi6EmmljDbOBT+t3Z1462KVLlu4+jAO3aIveTFK0ZQccGgtPDXu?=
 =?us-ascii?Q?2Q+DIUNf1D/YgB/3TlQKgjH+BeDp8wJ7xu+3p+UGdFKhZRmo/IGQry6LZH3b?=
 =?us-ascii?Q?rArsNCXyhzi9SjotGrAic+WSFT/FTY8ufiKp7Uj/2oLHRd4D3dEw5vMBh2Xj?=
 =?us-ascii?Q?bDJWPhaKKS7+uakzRrjoNe3pFqyKTdPqZ9VRn41llychzFCUd5SiF4aZDf2B?=
 =?us-ascii?Q?1PVuVB3zSVx5zFVUUef0NK9+Kmb0MBUbv17Zd6fl68cA2EDYY8hc3IlEhmwM?=
 =?us-ascii?Q?Ah+XyIxwe2DjQZBOBT4JeCZqJzUdbX+BbC2imPN3HCWajnO3DYmSw0+YN0cj?=
 =?us-ascii?Q?UxF/fQVN0D8nqcag8tgwVezDzUguACgxqyOTZA6M3P2tOXxzqdDg8g86TAA5?=
 =?us-ascii?Q?TB+hElfAxKQrljktuuLtSWDP3ozy5/NXmrS5tH2wSXYRbB4LG0koT++A580+?=
 =?us-ascii?Q?1RiakrKE9Rk0Smv+K1O7qeRoLbJ+7t5FlDjICT65m+8p0azczUrKPCMKwXV1?=
 =?us-ascii?Q?VbC0VGVJICzo9Qimmyi7V0htk4mkxdtWEWB3VbbZd9rJ+PdZ+R2gI7ppfBwm?=
 =?us-ascii?Q?9Ke02i6UKjtB5B+E5bax9aNST3lNbhsGLfuK9XhCwK3hr5Ld7LjFnB0MkEPI?=
 =?us-ascii?Q?e4uiCpADJpCMr01TmzmBL7wH9v5EbJUYMgeUyapRrn0tf7jfZhzBVtFdq9uK?=
 =?us-ascii?Q?ZbAA511ftETa4lJuLSY/s24BuCfqPXbxi7c+0oGbstp9e4QgEcG15io2oY2M?=
 =?us-ascii?Q?gfbpCzdMft+Ax2AWUAt/QXBB16kCWcGqktCho4eGOQh1BIGE/Q6eYbsrBInY?=
 =?us-ascii?Q?Oz7yLrzodXHCXIfiD5sVJbXrOQBRGKMxDPmalM3s+OUrXfcPEHp7VwCNDm9y?=
 =?us-ascii?Q?UOTbUS2y57UFMm8OL/RiP92LznxHh6kIrQvzKIzzcco++UeX8AlD7w3AcO3f?=
 =?us-ascii?Q?RQHywt2UH+a50WElS9QwoXLYFxDq5t/PNMpsJL/xEnp7lo2pqSWa?=
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 324740e4-c5dd-403a-5aef-08de79069156
X-MS-Exchange-CrossTenant-AuthSource: TYCPR01MB11947.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Mar 2026 09:23:44.9478
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TsO3JKDddSnnmWL1u9aKxmtuBYf0HYJj/8lG8ybV5aMo7TvBlWi/fEwxy8QuArmAohitJie1y+R6wPNA9HlrQPB8j2qe5caa6+FjDWk/3n4y1k4UPWvCQx3zHrw6U11u
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCPR01MB8342
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 03 Mar 2026 09:23:57 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/22058

commit e7218986319b4e903dfb4642dcbd1087cf16aaec upstream.

The Renesas I3C controller does not retain its register state across system
suspend, requiring the driver to explicitly save and restore hardware
configuration.

Add suspend and resume NOIRQ callbacks to handle system sleep transitions.

During suspend, save the Device Address Table (DAT) entries, assert reset
lines, and disable all related clocks to allow the controller to enter a
low-power state.

On resume, re-enable clocks and reset lines in the proper order. Restore
the REFCKCTL register, master dynamic address, and all DAT entries, then
reinitialize the controller.

Store the REFCLK divider value, and the master dynamic address to restore
timing and addressing configuration after resume.

Reviewed-by: Frank Li <Frank.Li@nxp.com>
Signed-off-by: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
Link: https://patch.msgid.link/c469ef89e0156d37746a85bfc314232847d1185a.176=
7781092.git.tommaso.merciai.xr@bp.renesas.com
Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
Signed-off-by: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
---
 drivers/i3c/master/renesas-i3c.c | 89 ++++++++++++++++++++++++++++++++
 1 file changed, 89 insertions(+)

diff --git a/drivers/i3c/master/renesas-i3c.c b/drivers/i3c/master/renesas-=
i3c.c
index 09b2bc03a5bc..4c725653ae0c 100644
--- a/drivers/i3c/master/renesas-i3c.c
+++ b/drivers/i3c/master/renesas-i3c.c
@@ -256,16 +256,19 @@ struct renesas_i3c {
 	enum i3c_internal_state internal_state;
 	u16 maxdevs;
 	u32 free_pos;
+	u32 dyn_addr;
 	u32 i2c_STDBR;
 	u32 i3c_STDBR;
 	unsigned long rate;
 	u8 addrs[RENESAS_I3C_MAX_DEVS];
 	struct renesas_i3c_xferqueue xferqueue;
 	void __iomem *regs;
+	u32 *DATBASn;
 	struct clk_bulk_data *clks;
 	struct reset_control *presetn;
 	struct reset_control *tresetn;
 	u8 num_clks;
+	u8 refclk_div;
 };
=20
 struct renesas_i3c_i2c_dev_data {
@@ -609,6 +612,7 @@ static int renesas_i3c_bus_init(struct i3c_master_contr=
oller *m)
 					   EXTBR_EBRHP(pp_high_ticks));
=20
 	renesas_writel(i3c->regs, REFCKCTL, REFCKCTL_IREFCKS(cks));
+	i3c->refclk_div =3D cks;
=20
 	/* I3C hw init*/
 	renesas_i3c_hw_init(i3c);
@@ -617,6 +621,7 @@ static int renesas_i3c_bus_init(struct i3c_master_contr=
oller *m)
 	if (ret < 0)
 		return ret;
=20
+	i3c->dyn_addr =3D ret;
 	renesas_writel(i3c->regs, MSDVAD, MSDVAD_MDYAD(ret) | MSDVAD_MDYADV);
=20
 	memset(&info, 0, sizeof(info));
@@ -1363,6 +1368,12 @@ static int renesas_i3c_probe(struct platform_device =
*pdev)
 	i3c->maxdevs =3D RENESAS_I3C_MAX_DEVS;
 	i3c->free_pos =3D GENMASK(i3c->maxdevs - 1, 0);
=20
+	/* Allocate dynamic Device Address Table backup. */
+	i3c->DATBASn =3D devm_kzalloc(&pdev->dev, sizeof(u32) * i3c->maxdevs,
+				    GFP_KERNEL);
+	if (!i3c->DATBASn)
+		return -ENOMEM;
+
 	return i3c_master_register(&i3c->base, &pdev->dev, &renesas_i3c_ops, fals=
e);
 }
=20
@@ -1373,6 +1384,83 @@ static void renesas_i3c_remove(struct platform_devic=
e *pdev)
 	i3c_master_unregister(&i3c->base);
 }
=20
+static int renesas_i3c_suspend_noirq(struct device *dev)
+{
+	struct renesas_i3c *i3c =3D dev_get_drvdata(dev);
+	int i, ret;
+
+	i2c_mark_adapter_suspended(&i3c->base.i2c);
+
+	/* Store Device Address Table values. */
+	for (i =3D 0; i < i3c->maxdevs; i++)
+		i3c->DATBASn[i] =3D renesas_readl(i3c->regs, DATBAS(i));
+
+	ret =3D reset_control_assert(i3c->presetn);
+	if (ret)
+		goto err_mark_resumed;
+
+	ret =3D reset_control_assert(i3c->tresetn);
+	if (ret)
+		goto err_presetn;
+
+	clk_bulk_disable(i3c->num_clks, i3c->clks);
+
+	return 0;
+
+err_presetn:
+	reset_control_deassert(i3c->presetn);
+err_mark_resumed:
+	i2c_mark_adapter_resumed(&i3c->base.i2c);
+
+	return ret;
+}
+
+static int renesas_i3c_resume_noirq(struct device *dev)
+{
+	struct renesas_i3c *i3c =3D dev_get_drvdata(dev);
+	int i, ret;
+
+	ret =3D reset_control_deassert(i3c->presetn);
+	if (ret)
+		return ret;
+
+	ret =3D reset_control_deassert(i3c->tresetn);
+	if (ret)
+		goto err_presetn;
+
+	ret =3D clk_bulk_enable(i3c->num_clks, i3c->clks);
+	if (ret)
+		goto err_tresetn;
+
+	/* Re-store I3C registers value. */
+	renesas_writel(i3c->regs, REFCKCTL,
+		       REFCKCTL_IREFCKS(i3c->refclk_div));
+	renesas_writel(i3c->regs, MSDVAD, MSDVAD_MDYADV |
+		       MSDVAD_MDYAD(i3c->dyn_addr));
+
+	/* Restore Device Address Table values. */
+	for (i =3D 0; i < i3c->maxdevs; i++)
+		renesas_writel(i3c->regs, DATBAS(i), i3c->DATBASn[i]);
+
+	/* I3C hw init. */
+	renesas_i3c_hw_init(i3c);
+
+	i2c_mark_adapter_resumed(&i3c->base.i2c);
+
+	return 0;
+
+err_tresetn:
+	reset_control_assert(i3c->tresetn);
+err_presetn:
+	reset_control_assert(i3c->presetn);
+	return ret;
+}
+
+static const struct dev_pm_ops renesas_i3c_pm_ops =3D {
+	NOIRQ_SYSTEM_SLEEP_PM_OPS(renesas_i3c_suspend_noirq,
+				  renesas_i3c_resume_noirq)
+};
+
 static const struct of_device_id renesas_i3c_of_ids[] =3D {
 	{ .compatible =3D "renesas,r9a08g045-i3c" },
 	{ .compatible =3D "renesas,r9a09g047-i3c" },
@@ -1386,6 +1474,7 @@ static struct platform_driver renesas_i3c =3D {
 	.driver =3D {
 		.name =3D "renesas-i3c",
 		.of_match_table =3D renesas_i3c_of_ids,
+		.pm =3D pm_sleep_ptr(&renesas_i3c_pm_ops),
 	},
 };
 module_platform_driver(renesas_i3c);
--=20
2.43.0


