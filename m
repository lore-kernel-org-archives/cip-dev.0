Return-Path: <prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E81F7C44500
	for <webhook@archiver.kernel.org>; Fri,  3 Jul 2026 15:28:16 +0000 (UTC)
Received: from TY3P286CU002.outbound.protection.outlook.com (TY3P286CU002.outbound.protection.outlook.com [52.101.229.64])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.94846.1783092495874648551
 for <cip-dev@lists.cip-project.org>;
 Fri, 03 Jul 2026 08:28:16 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@bp.renesas.com header.s=selector1 header.b=gVdVw6qN;
 spf=pass (domain: bp.renesas.com, ip: 52.101.229.64, mailfrom: prabhakar.mahadev-lad.rj@bp.renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eM5dcNM7mWGfmZKcmkWkUZ59Y72Ja/eDW8PzYTTT7cfVq0Qgi8acxL3AWNdHMMa/8FDbIKc6OeI18A8qF/+06ZUFE221ik2lzmh4+/4H/wIl89/YUUma4bFJDnV6D6xN0XndLtKaY9PUEz4MNJo0oV9paAFeqTqXZqIs3cy5Q1qo8+vlYVjXC3DfOPvaMbzJn17pCzSbkpQIzeNJZwPyeAaUuKEIWAky25nTuG5BLZGN7svOx1n71VD1q3AHUexDqLin8xjkvzCS+btV5mtmk36DWhSKvaKIIXfyKw6KNHrxhLpXmgy3seNxc0/7wZqhNKZMp3CpI5pbUICbNYmyRA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=58ydU3xXCsaBYxGgCLkZFPsl9k8miPNAXBI2+TsqoC8=;
 b=JQRNIWtmAALEmDQEa/ygQizMeBagzE8icKEV9Xr5uKFTiM8C5BqBHYKk85y8EFL6ghbfbFZf32iJf+MA/PdjzJTLTKhAPPtfErdfoMVdaNSmy578tYos5Ir5C+j+bYnC/LDc0GhuNK3qeYj1MxLF7hBK9IOIn6fl+D2XcnXfQHRIOhSV5LwCJXWJMYm476osDNeqQKLvGAyJBQCjrEmrqM3+0tCtFR5RgvcdUT4/V2mHkArt36KN23d4KTFCxy0G6p2tt7TJMsnZdjHCMzowqgBDvTnrp4cydKB6yGHkv5KPDsKrgY4Q3JFWNJC3rKjgbD1/ohGB4pvGfZLOqr1Big==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 8.62.32.50) smtp.rcpttodomain=bp.renesas.com smtp.mailfrom=bp.renesas.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=bp.renesas.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=58ydU3xXCsaBYxGgCLkZFPsl9k8miPNAXBI2+TsqoC8=;
 b=gVdVw6qNGVHNfKFTo/fSvG6EpD9L7Lx5iL4vgcYQqw8cdtx+cGHpa61yOmEOa0y4xvpTum995esSYZab0rjBUHpVmyyIMajQOsqxPmwXwWhCHUNntkGkFyBrdz/j3zSeW/9qXrnL2oXOZCpoGrw6Jus4Mwk19Z2nWJ0O4t+YM2A=
Received: from TY4PR01CA0119.jpnprd01.prod.outlook.com (2603:1096:405:379::10)
 by TY4PR01MB15001.jpnprd01.prod.outlook.com (2603:1096:405:25d::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.8; Fri, 3 Jul 2026
 15:28:09 +0000
Received: from TYO1EPF00005024.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:379:cafe::58) by TY4PR01CA0119.outlook.office365.com
 (2603:1096:405:379::10) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.181.11 via Frontend Transport; Fri, 3
 Jul 2026 15:28:09 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 8.62.32.50)
 smtp.mailfrom=bp.renesas.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=bp.renesas.com;
Received-SPF: Pass (protection.outlook.com: domain of bp.renesas.com
 designates 8.62.32.50 as permitted sender) receiver=protection.outlook.com;
 client-ip=8.62.32.50; helo=ejcrelay004p.adwin.renesas.com; pr=E
Received: from ejcrelay004p.adwin.renesas.com (8.62.32.50) by
 TYO1EPF00005024.mail.protection.outlook.com (10.167.240.21) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.181.6
 via Frontend Transport; Fri, 3 Jul 2026 15:28:09 +0000
Received: from Ubuntu-22.. (ukr-5cg4053kvs.diasemi.com [10.24.0.5])
	by ejcrelay004p.adwin.renesas.com (Postfix) with ESMTP id C60A5300023C;
	Sat,  4 Jul 2026 00:28:07 +0900 (JST)
From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro.iwamatsu.x90@mail.toshiba>,
	Pavel Machek <pavel@nabladev.com>
CC: Biju Das <biju.das.jz@bp.renesas.com>
Subject: [PATCH 6.12.y-cip 1/4] clk: renesas: r9a09g056: Add PCIe clocks and reset
Date: Fri,  3 Jul 2026 16:28:00 +0100
Message-ID: <20260703152803.29302-2-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260703152803.29302-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20260703152803.29302-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYO1EPF00005024:EE_|TY4PR01MB15001:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 3586a375-de15-490c-105b-08ded917b037
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|1800799024|82310400026|23010399003|36860700016|376014|22082099003|18002099003|11063799006|56012099006|13003099007;
X-Microsoft-Antispam-Message-Info: 
	0Xtk7VRLajgZi/+Y2sggECUMkrOZzbpa/6EXHmEzEm8B91UuVzqAIGT2eQbgW0+zohj0oqGEWpIrEN1On0NsMYqvt1YiWAPgsoaWF5+yZwuu2FDbWeLXN5eYBeu5Ujcl0PqqSNDuSrHX8r/f75Lka0kWhS7t62fHTK/iRK7Kl1PQzrxIvcvxeWYQHMeqvNBhqqcroJiCF/bkNPcz2vSacAsLQZfqM0rgaLm+XYGHk9kQMFSGVF8Kt0gCWYad6FxkQU6KwUFqYnBQpBctxsKSWLGamDfp4O5421vDM/TQHb7UQtKLko/dZRY9UXazPBxMVRyCtMdXxSDTmtb0wupWMKF4boY+GhPzlbylzAyeJiYwOX/Vx+nDDoqxdPdE4dMCNKyUf1vPn1gr1puqiGpRJYMVWfWcxz0a6Rn2B0yn8Pa//81CrKkIyE0aEqoauLfwx/p5d3NQyp120/zhpfD0KDB1/6pJIpH1QCqKTNN470MJRSuLVmGuY/Lfp9j0vEe7k0BpFmHbJ12jNs2hd7hUaDFKgGLK6hiHufUg0ClSZvdjVCu60607uPYyZWJ9hmvCXzBDIaGhW4ztKVWyiSvjQupz8l5wM4aHDaoYOBFq5UEFneVOZGy2s8qP+Xt0aRg/m/yoogbJ1UTYSYU2EXjkgxdIGAWO36QLau4V1zCimVc=
X-Forefront-Antispam-Report: 
	CIP:8.62.32.50;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:ejcrelay004p.adwin.renesas.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(23010399003)(36860700016)(376014)(22082099003)(18002099003)(11063799006)(56012099006)(13003099007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	f5/qNWk7dpAx2qBuf/RaIxPYTWRtEY+0t0cQFT7P7+YiqY0pfQISeayIlWsABdvVM7xjbQYUTBaztIlp9Tlmyokw0Q9/Zo0BJrZZvfanTccL/DO390HrnCKqW8IRwKRaEr+ujLo1eAJyz5yssRslF7qtKNVDKl+pwp738NQMo0nIWiAyDVaIn3ixb+aqP2WajMUbScnJDkKXS3+AT31vtGP6117bNANjWv9HLQUeVFsSrXNbQqFp2u5d9MUlAuhNpyXCalGggomm7z9QfHPPx94zHcLRVdbc+Ca69fubPCE8DGdk3XeBXzrp/0LKVqvKGbai8iTK5L12FkL7AXAcSR51wwrvnkM1XMNDOHyiQIdgxMPRfuByLJqVUwRR9NfTYdpZVzVI5oSgh+bOA7BnuyxL2xUAgyNceoNdDC+apsBfiBA5h/oO8qVYE3arjeO2
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jul 2026 15:28:09.6559
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3586a375-de15-490c-105b-08ded917b037
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=53d82571-da19-47e4-9cb4-625a166a4a2a;Ip=[8.62.32.50];Helo=[ejcrelay004p.adwin.renesas.com]
X-MS-Exchange-CrossTenant-AuthSource: TYO1EPF00005024.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY4PR01MB15001
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 03 Jul 2026 15:28:16 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/23444

commit a7719b2d04c42b527741ecce68e29113e42a10bb upstream.

Add clocks and reset entries for the PCIe controller.

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Reviewed-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Link: https://patch.msgid.link/20260312111521.115392-2-prabhakar.mahadev-la=
d.rj@bp.renesas.com
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
[PL: manually applied the changes]
Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
 drivers/clk/renesas/r9a09g056-cpg.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/clk/renesas/r9a09g056-cpg.c b/drivers/clk/renesas/r9a0=
9g056-cpg.c
index 8c0203eaeaeb..197f3392c6ed 100644
--- a/drivers/clk/renesas/r9a09g056-cpg.c
+++ b/drivers/clk/renesas/r9a09g056-cpg.c
@@ -376,6 +376,10 @@ static const struct rzv2h_mod_clk r9a09g056_mod_clks[]=
 __initconst =3D {
 						BUS_MSTOP(8, BIT(6))),
 	DEF_MOD("gbeth_1_aclk_i",		CLK_PLLDTY_DIV8, 12, 3, 6, 3,
 						BUS_MSTOP(8, BIT(6))),
+	DEF_MOD("pcie_0_aclk",			CLK_PLLDTY_ACPU_DIV2, 12, 4, 6, 4,
+						BUS_MSTOP(1, BIT(15))),
+	DEF_MOD("pcie_0_clk_pmu",		CLK_PLLDTY_ACPU_DIV2, 12, 5, 6, 5,
+						BUS_MSTOP(1, BIT(15))),
 	DEF_MOD("dsi_0_pclk",			CLK_PLLDTY_DIV16, 14, 8, 7, 8,
 						BUS_MSTOP(9, BIT(14) | BIT(15))),
 	DEF_MOD("dsi_0_aclk",			CLK_PLLDTY_ACPU_DIV2, 14, 9, 7, 9,
@@ -455,6 +459,7 @@ static const struct rzv2h_reset r9a09g056_resets[] __in=
itconst =3D {
 	DEF_RST(10, 15, 5, 0),		/* USB2_0_PRESETN */
 	DEF_RST(11, 0, 5, 1),		/* GBETH_0_ARESETN_I */
 	DEF_RST(11, 1, 5, 2),		/* GBETH_1_ARESETN_I */
+	DEF_RST(11, 2, 5, 3),		/* PCIE_0_ARESETN */
 	DEF_RST(13, 7, 6, 8),		/* DSI_0_PRESETN */
 	DEF_RST(13, 8, 6, 9),		/* DSI_0_ARESETN */
 	DEF_RST(13, 12, 6, 13),		/* LCDC_0_RESET_N */
--=20
2.43.0


