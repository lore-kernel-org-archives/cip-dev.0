Return-Path: <prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BCD84C43602
	for <webhook@archiver.kernel.org>; Fri,  3 Jul 2026 16:35:37 +0000 (UTC)
Received: from TYVP286CU001.outbound.protection.outlook.com (TYVP286CU001.outbound.protection.outlook.com [52.101.125.55])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.97048.1783096527814245992
 for <cip-dev@lists.cip-project.org>;
 Fri, 03 Jul 2026 09:35:28 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@bp.renesas.com header.s=selector1 header.b=cyAf4N//;
 spf=pass (domain: bp.renesas.com, ip: 52.101.125.55, mailfrom: prabhakar.mahadev-lad.rj@bp.renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AeCwdcwOMl0IVEJlNBcCLFwDqTb6wOPX7Lxjoeb70uJ6Ojpevz3Zh75VtAT1DUaz0O6vjv1xkC2WjfJ/AIGrM2cwbqGMSL1BmffKdmoprxxcB8IfkYc6PkDiGBXJFftONl69huQqsDtaRgP9XsyE5Z1FaqmmXyHHvah/N8wk55aPygJKiYrBBrIl6967GezLmItV59a495XEego6gV9rwcqm11v+YCWhEGvqicoNfgVmJXEEQQN6kN6AUkvmoYb2asdNBulUE+3vy9TCnLKqzLZFZAancfqXVUUc/Kax1LF4sSPd2KqVfNczl1mdGy8zKDKlvsVyPBJIuLcESlWlxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xbhX3+6Q2KxEXdXwwA3Eu6Wd0TnBD+7HD0bauVTOrG0=;
 b=EeiEOvLn2wSVQccnfTN8FM8p53T8KH5V8K/x5UVpynjsp53Lo4Z74uWN8+ixFuw6Ss/4c5dx6FQd/d07kop/f7MxQpp9rcqmMu5KlCf69zp8kmRomYXqe9m9Rdf5pgGSkK1yQuzVD6MTFsgIzalYX+y/HxIsyLE2XmAWbD5NqeneAgmIlt3sNo5GqoHRpe5y/nF3bOktXhqqsriMjKkb8YktnLWCNjOBrRk3iZRduuDCseQb07MuzJmvH+bAxRSPw4o+Uc00maRjVnP6twGgsKLpDFZAlVW4b4n0kMPocd0gC5oHYp7Kt4a+WUBu5nVfJyS0SqVqcahk0vXRXEdkRQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 8.62.32.50) smtp.rcpttodomain=bp.renesas.com smtp.mailfrom=bp.renesas.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=bp.renesas.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xbhX3+6Q2KxEXdXwwA3Eu6Wd0TnBD+7HD0bauVTOrG0=;
 b=cyAf4N//BNsmVV4uRjlXe+1lVzHQPDgMt9vGjabjuY8Y/7K6azmeOerus+n6agEeAef5kVipAmLpm6YFC0AhPgrBx6h/iXDmFpMBz5opt+IO5CQ42iyGwvjhYu3N89L81AMllyLbQ1bBkpsLCGACN5TfDQ4z7MQCDIiTjuAibjw=
Received: from OS7PR01CA0159.jpnprd01.prod.outlook.com (2603:1096:604:24d::15)
 by TYYPR01MB13021.jpnprd01.prod.outlook.com (2603:1096:405:1c5::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.8; Fri, 3 Jul 2026
 16:35:21 +0000
Received: from OS1PEPF0000D20D.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:604:24d:cafe::2d) by OS7PR01CA0159.outlook.office365.com
 (2603:1096:604:24d::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.181.11 via Frontend Transport; Fri, 3
 Jul 2026 16:35:21 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 8.62.32.50)
 smtp.mailfrom=bp.renesas.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=bp.renesas.com;
Received-SPF: Pass (protection.outlook.com: domain of bp.renesas.com
 designates 8.62.32.50 as permitted sender) receiver=protection.outlook.com;
 client-ip=8.62.32.50; helo=ejcrelay004p.adwin.renesas.com; pr=E
Received: from ejcrelay004p.adwin.renesas.com (8.62.32.50) by
 OS1PEPF0000D20D.mail.protection.outlook.com (10.167.240.36) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.181.6
 via Frontend Transport; Fri, 3 Jul 2026 16:35:21 +0000
Received: from Ubuntu-22.. (nld-5cg2234fz3.diasemi.com [10.24.0.5])
	by ejcrelay004p.adwin.renesas.com (Postfix) with ESMTP id CFDA73000293;
	Sat,  4 Jul 2026 01:35:19 +0900 (JST)
From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro.iwamatsu.x90@mail.toshiba>,
	Pavel Machek <pavel@nabladev.com>
CC: Biju Das <biju.das.jz@bp.renesas.com>
Subject: [PATCH 6.1.y-cip 1/4] clk: renesas: r9a09g056: Add PCIe clocks and reset
Date: Fri,  3 Jul 2026 17:35:12 +0100
Message-ID: <20260703163515.35831-2-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260703163515.35831-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20260703163515.35831-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: OS1PEPF0000D20D:EE_|TYYPR01MB13021:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 0375838c-a814-49a2-22c8-08ded9211389
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|1800799024|36860700016|376014|23010399003|82310400026|22082099003|18002099003|13003099007|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info: 
	rfkItffzXIhiTh1zUpk5npbYZEfhXU/CTBaDNXu9/jzwvxuksbfBBYmZ3f8Q4GumrFoeC336S6vpzdflG2CZiOzH8jDzJMnDZZfANu4jcpXv3nY2Z6PiRkYRg9XrxzUkw1Tzt6bcpXoVze+F1mnGmgywL1LjRlsUEJjiuaWy23V0SA+NhUqx5HePUQWDZGWb6SH11jmNu3D0zDkgUhxngAtgY26utvPW6Lltctw2j/ekvpAyZxQPNGJYtQEmndQquHS8eUycLk2UI9krA5hlbCwzX9Mgdf6fp6W/o/L0I47WssTvkSqJdeSO5OgqkVybVNcnJlJKrwaXLFoA+zsYUzkBn2xeaOi3YMn9nYn5kYFFgkiejzsFOZjL8MyHqaESACxQOas9u/D4MAYr71H5JK9fg1CgQiJ24mahctR/0jZztqhgwkH61tm989Ai436ZIjqoOVKIx95MKyU+Ayowl86zPUpmoNHrryHHGfhInSzdglMS9ht27Dv8k/wvN+8IePxJoPEjezfvi4Bg9/Ckz7ympHcxCbI5C9RgwkKvZlwEFcRMoSR/OAlSsZ/BtI9ApDF2NXcMy6ylbQasdTJuCMRBjsh0TCa9T0deBNYakaZf+BUnprCAgzXkdV85heB2kPA2PbQnHMfLoFMUwnPz6tiFjl4pz4CtGpLveCH1sRE=
X-Forefront-Antispam-Report: 
	CIP:8.62.32.50;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:ejcrelay004p.adwin.renesas.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(36860700016)(376014)(23010399003)(82310400026)(22082099003)(18002099003)(13003099007)(11063799006)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	pRSUX6WXwwKEpBC1rGCiEvntFwGFeEQK/PVQFPm//pEFolur7lPqohq/1M7ak9/Q0fl+53/WWlwxZe323yz90Nsl50blT6ZwvC238kOzitr+TIr7z2vZmNhm/jMnpdtv4xqfuvpk0Omus7WH6XnULkNQ1Z1ZBtzXnOT4bsYjPuk5oleXFQpv7WOGi9BCXkt/lQLh+ViS2Dssx22CSBbU5kKiSfV/0Rj0IY4/wU9SF2K6THuBjrgc0C+WteKlBxOGmYhA0+l5r0aEib/xe+ToCrq7pw2kFb+cECiCN/W0Cb4UGbqHlo0VC7y7NHhEbdmJr1JmVnB32QNhKApuK+ZqO4/XCHi3yKpHhTpGhaDGvBAbVChGSN0dNjdFJaM6WLn3H3fynKxD3JCqSuhgAuwm2eWJ8SM3edlEeSW0OC5LgspEdA4JpuU4RE8h4PnZgVrc
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jul 2026 16:35:21.7455
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0375838c-a814-49a2-22c8-08ded9211389
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=53d82571-da19-47e4-9cb4-625a166a4a2a;Ip=[8.62.32.50];Helo=[ejcrelay004p.adwin.renesas.com]
X-MS-Exchange-CrossTenant-AuthSource: OS1PEPF0000D20D.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYYPR01MB13021
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 03 Jul 2026 16:35:37 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/23449

commit a7719b2d04c42b527741ecce68e29113e42a10bb upstream.

Add clocks and reset entries for the PCIe controller.

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Reviewed-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Link: https://patch.msgid.link/20260312111521.115392-2-prabhakar.mahadev-la=
d.rj@bp.renesas.com
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
[PL: manually applied the changes due to conflicts]
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


