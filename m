Return-Path: <tommaso.merciai.xr@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12885EC0472
	for <webhook@archiver.kernel.org>; Tue,  3 Mar 2026 09:22:47 +0000 (UTC)
Received: from OS0P286CU011.outbound.protection.outlook.com (OS0P286CU011.outbound.protection.outlook.com [52.101.228.65])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.14381.1772529761997111597
 for <cip-dev@lists.cip-project.org>;
 Tue, 03 Mar 2026 01:22:45 -0800
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@bp.renesas.com header.s=selector1 header.b=suK3z5c8;
 spf=pass (domain: bp.renesas.com, ip: 52.101.228.65, mailfrom: tommaso.merciai.xr@bp.renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OonBHI9MUYUcNNce0MBSzeQODSQ0dfKLVeueVPldN00mzcf9ZWUyMxD+SEBzRCkTT23lyHI6CYkt61M0RDTa3XFP7CEpjdoh06sVhJrJWuAjTy++11/xC2QGZMnkw/0Rvu8nzOusdnpWTq0TiZYFmX956FNz95DuB5zjW8LkfB7wi2fp5nFggk1nxiigv//S1Pts8LzmK0hBXc4zQ+ITOAHhhu4n0ghxeXSjSe9CILTdC3hmcFWlp/dk4U/QtP0TQ8b63uN1naiahsZwWZxgb7eaGecU3kR0ZIQXsWtp2SGuIQk8y9wqaG3CT7B0COqvrgATdsTav08pUaGw6ysTwA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ro2fIEEfrCJEu0XedkpJUuu8KDj4dCqF3YMuxKsi6to=;
 b=Li6hm4PvSTyWbMFirOkLPeMq5qOEzLtq6t531D6EheizDNMxfHPkaLqJT1g6RiW+KI8If0huqiBBXfO5VWC4blceh9XWgUSdG+v0a26K8uooQaZpK4Q1G3W0btDLAKMPtfp5GhfgXHESvgAyhspQeDtYQ/DG3UJbxWwrGRpZAogQFPe1mzJViBV0ZiR/tjD3Sa+CSqmL1z5UBvsdatHWNbOKq71aOGqgBHLwW4HbgITOaKxcKzarWUJnKeQLeHt93mTQXg49M7qlb8Eo5IAwferKMvdQ0PSewPXHWgrCKAqKZZgSUfRrq3fwJx3T8wo7rIetbulxlDYgVpI5q6/YgA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ro2fIEEfrCJEu0XedkpJUuu8KDj4dCqF3YMuxKsi6to=;
 b=suK3z5c8XT8gDfyPRa/YkhPoWDZDLIBU8a176rFWtGD/t/NCTEsyxGcRTKw+Ka/w5UYQQ9I3Imyk/cqRzcbYYPZ5lwKGjI+0LIFwNyjFjZHaKw0fwEqD4ETMgUHXE7hQ7sl2TW8sBSUTIdzA6EN3kTC/xnHEox5fTVIIk0vt/x0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
Received: from TYCPR01MB11947.jpnprd01.prod.outlook.com (2603:1096:400:3e1::6)
 by TYCPR01MB8342.jpnprd01.prod.outlook.com (2603:1096:400:15f::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.22; Tue, 3 Mar
 2026 09:22:38 +0000
Received: from TYCPR01MB11947.jpnprd01.prod.outlook.com
 ([fe80::33f1:f7cd:46be:e4d8]) by TYCPR01MB11947.jpnprd01.prod.outlook.com
 ([fe80::33f1:f7cd:46be:e4d8%5]) with mapi id 15.20.9654.022; Tue, 3 Mar 2026
 09:22:38 +0000
From: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@nabladev.com>
CC: Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	tomm.merciai@gmail.com
Subject: [PATCH 6.1.y-cip 9/9] i3c: renesas: Add suspend/resume support
Date: Tue,  3 Mar 2026 10:21:40 +0100
Message-ID: <20260303092140.12732-10-tommaso.merciai.xr@bp.renesas.com>
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
X-MS-Office365-Filtering-Correlation-Id: 34c9c2fb-4a9e-404c-9131-08de790668de
X-LD-Processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|366016|1800799024|376014|52116014|38350700014;
X-Microsoft-Antispam-Message-Info: 
	7UfUdCGeKwHzRQckqFTuHAQVY99qRuKjx101oYS9WoNGtlSJ8APkDCPu6e6w13iTs77S38gVKaXiyFLrkb6lI3h0jNBbbLXsGjDKb1ZK0Da2Ygw+jxB8EfDUeVCrutiwGonEPRdlJLXzCWALjhLiJuaWea9B0cm1CDgPsQ3+LUSCM9pCLMROm/j4LAEaOKboqjJ8lXiLoELXiNPmp4gz+3KJpDvil5x1E0GbMpiyvBUJDLFbSO7NjxKkBmRNqFHak/JTrHReJIqAegBV6dsyzEu46zgXLazc4bl9XdQa/lg4fvgBLPiPuq58pCZWO++BQo6fv/IVLrjCDGOmASH1vzIaOnIe/lxzq7XUOWvGEcjkEBsyB+sS3qO18riMsctgd3+I9SMlkXe7a3OYFBNCOj/mkbpCR/0X6Y5WD9pNsCgKMtGywS0eNBtyDBCA+TQnYMAltfPS+V9MzP4fwsBunINUns9mVbV/duWtmozBqSAiVxtErvtxSmPIzljLbNDQ73mYU24CODUxbM0fdPEC8kRRdaLM9EHo1vxWRj0p1JVLLEI8spEPBge1DR4OoM5j6OR4e52mdj5PUN3ggBtSSmsr3OVXX9JeXXGDzlgwgAhFc1RSqaOkrW0DnZ2HRvC9NBPSQAMEugiKd5DlhkzAPwTYKI8kXi839csQnszAjg/srigKO9bPOP8wv69lxRxTPnoRMfK4mdyAFgn2l4y5cat2cziMpdmR9mKbt07HUhdokPUdjuZxGjHBDB6L6R0x
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYCPR01MB11947.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(52116014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?W3QoGbtvP9076A0aWy8OQuYlqDv+cV2sGMdZ+ha7/FY+fvfJJvLw/P/uNb+s?=
 =?us-ascii?Q?Uww3XPRjO8596IVMQrNLdinvbfxSv0/9ZbO0wjqUfsoLz7nqXS+B57TApyiv?=
 =?us-ascii?Q?12fPEELEKAN6a8Ug5rMlpjzqgWLDNGSfVOpRm/yGkWxVO01k7UKzy53ylXJJ?=
 =?us-ascii?Q?+Kyt5YXNm9GcfvOxfPtaSiPG6c/q0WwK20xsBN6rVQS3g6hDNx5Dn0nCS7zl?=
 =?us-ascii?Q?X9rsJ4MNW4uMRDhyEOBOLORTJ6kxne02fWeuN1YToNdYr8uUCa3sbYHuwdac?=
 =?us-ascii?Q?Qg3HvmZEyTT5LsSUwY1Zetjmi+xmMGAUNOyy+F8w0KA1AGGsoclbtdCBfqzK?=
 =?us-ascii?Q?dy5bgG1HVGaZywS/o7OnxofxbiYyG6Xdub1PAZ3AVyIOgpV7aKUVuBr3wP7Y?=
 =?us-ascii?Q?x1aSKOI4RtXQWHhOwyo9rOa7psPsxs5qk2YqodO3t0c4jStRJdzB/eJHrnOt?=
 =?us-ascii?Q?pEU3/HTNa36RvuxlblLFFyIRzuXVYGgA0QB61PPHiwUMuOViUSyXjpGQDePT?=
 =?us-ascii?Q?nta1+Xk8QNTYaiiGdfTESsa/fT+cbcpNh1GijfGylHET75K+dxie4/RUTsF0?=
 =?us-ascii?Q?sWuFUEyWTK3Xi+zJZ7bcavakQNp8TlaH2nojfcZl/Mu1LDPaFrH/ZPdaLhfR?=
 =?us-ascii?Q?w6I/6BvYBRo47PFCzjIxxzRwU1f2PEiV8HBKH+32NtRpnEDNsB8x//vfcvz6?=
 =?us-ascii?Q?XDGvbJ8lflAxCA0xBsqcC04Bh5xu6F9kgwecaQHd/YBOpQ5qui6TO9J9W/ML?=
 =?us-ascii?Q?tGtOecCxfoTohPxLOjiK/LGxePsj4pbrU3ObyZDE0kl458F2m8oU28ZbNDge?=
 =?us-ascii?Q?JhQ+kh7OM+H9rtO+Opgs3gCNsWo1xfUUdJjRoIZ+a+Q+5PsFBP1wpiIsg2Je?=
 =?us-ascii?Q?2xs8OYa4uxn6zo384lYoNZrx+wkM0iLeqbS7/nIa9w+NsHSrrLd39wqaIx/L?=
 =?us-ascii?Q?DQGgCflRxKMPdFbiZaWWf6HrNEprKcXBaweXTbrKZJ6YTGaqJ+fKMKwXfGRo?=
 =?us-ascii?Q?lhZhBB22+iJKIeQjGDRyQihKW7gXbU8bm+uirlRw0AdupMZDcTSXhTdklOhU?=
 =?us-ascii?Q?55Ej8cnNmXUvGTnc5HmQXmgWYgK4JWwWDXn5lRu2E/xOmYEZpSQ9oxa9qxOr?=
 =?us-ascii?Q?opiTPaQ2JvTrAErX58mTYKSpTvjR9n+BfiKqW/VOEyf5tkOq2JcGBVuE+7mZ?=
 =?us-ascii?Q?z8yngRzuhr8c8+D14cDRfELh4Jhrw6EukEPlaL8IR3/qRMDZOgZ0wmElphKP?=
 =?us-ascii?Q?3XaV8FFA/YQH5ydfE4liZsQdLGJT0yBwbK3ZFfbWMkk+q0W1oJ/Yaa14alPT?=
 =?us-ascii?Q?ZjE9aCY3fITlkQMwF8JS2ta2jprQgpeIVXcBs00l6tGddqJVSd2ddJtfTT1V?=
 =?us-ascii?Q?bmYOjT3nWyHfvME8+UJxeK3SOEJJvzYXIkfAKxKE9QMjea2Ju9i6HyT6Gp7k?=
 =?us-ascii?Q?g+yHc8KGYYLX5oqYURLgoYdEcwjYyZfjLy1qhlQG5YiPgnaGob1b6VY3kZPy?=
 =?us-ascii?Q?0JgdFQZ8KCeS61trvQXipeZzxnHiPcowWCx3Z5VIUS7EpOTpjpTl/i6GiBzU?=
 =?us-ascii?Q?hEPMc/3qthOOphD2bsm6ndX2W3m94Lrq+BGPBcD3QwBp6HzJ58hwg5/+pJ3c?=
 =?us-ascii?Q?OCRkue3c4FYjX8M1dDmVStPj02rAgzLfkkoxxdKC6hbz1hXXqUJMFRTCPo4K?=
 =?us-ascii?Q?HNeF/ASNS0DMWH02VUY40qUe24ctbF1uqFxiyCXCgx3OBQbi2es9PnWJ73lU?=
 =?us-ascii?Q?fy4ayPm1crabTkNF8GdIPxfbCetLUNj2lZZdXW0xhEQCCSoM3KMP?=
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 34c9c2fb-4a9e-404c-9131-08de790668de
X-MS-Exchange-CrossTenant-AuthSource: TYCPR01MB11947.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Mar 2026 09:22:37.3592
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QU6cZIAhSpHp+59hZZ5LI+p7filgmalhYStYKkB1BMuCbdxMn+Kot3618cu6JOHEbiYgOr8276bPWgLABanVCVCQvicwprenj6NGwbA+kir7MB6JSi5hGsEVREY3amVf
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCPR01MB8342
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 03 Mar 2026 09:22:47 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/22050

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
[tm: Moved presetn and tresetn into the renesas_i3c struct to prevent
 incorrect padding, aligned with upstream work]
Signed-off-by: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
---
 drivers/i3c/master/renesas-i3c.c | 93 +++++++++++++++++++++++++++++++-
 1 file changed, 91 insertions(+), 2 deletions(-)

diff --git a/drivers/i3c/master/renesas-i3c.c b/drivers/i3c/master/renesas-=
i3c.c
index c244df4f2fa2..2086a3ff016e 100644
--- a/drivers/i3c/master/renesas-i3c.c
+++ b/drivers/i3c/master/renesas-i3c.c
@@ -257,16 +257,19 @@ struct renesas_i3c {
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
-	struct reset_control *tresetn;
-	struct reset_control *presetn;
+	u32 *DATBASn;
 	struct clk_bulk_data *clks;
+	struct reset_control *presetn;
+	struct reset_control *tresetn;
 	u8 num_clks;
+	u8 refclk_div;
 };
=20
 struct renesas_i3c_i2c_dev_data {
@@ -610,6 +613,7 @@ static int renesas_i3c_bus_init(struct i3c_master_contr=
oller *m)
 					   EXTBR_EBRHP(pp_high_ticks));
=20
 	renesas_writel(i3c->regs, REFCKCTL, REFCKCTL_IREFCKS(cks));
+	i3c->refclk_div =3D cks;
=20
 	/* I3C hw init*/
 	renesas_i3c_hw_init(i3c);
@@ -618,6 +622,7 @@ static int renesas_i3c_bus_init(struct i3c_master_contr=
oller *m)
 	if (ret < 0)
 		return ret;
=20
+	i3c->dyn_addr =3D ret;
 	renesas_writel(i3c->regs, MSDVAD, MSDVAD_MDYAD(ret) | MSDVAD_MDYADV);
=20
 	memset(&info, 0, sizeof(info));
@@ -1387,6 +1392,12 @@ static int renesas_i3c_probe(struct platform_device =
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
@@ -1399,6 +1410,83 @@ static int renesas_i3c_remove(struct platform_device=
 *pdev)
 	return 0;
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
@@ -1412,6 +1500,7 @@ static struct platform_driver renesas_i3c =3D {
 	.driver =3D {
 		.name =3D "renesas-i3c",
 		.of_match_table =3D renesas_i3c_of_ids,
+		.pm =3D pm_sleep_ptr(&renesas_i3c_pm_ops),
 	},
 };
 module_platform_driver(renesas_i3c);
--=20
2.43.0


