Received: from TY3P286CU002.outbound.protection.outlook.com (TY3P286CU002.outbound.protection.outlook.com [52.101.229.42])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.11807.1793624549268316509
 for <cip-dev@lists.cip-project.org>;
 Mon, 02 Nov 2026 05:02:29 -0800
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@bp.renesas.com header.s=selector1 header.b=AIWUzOjO;
 spf=pass (domain: bp.renesas.com, ip: 52.101.229.42, mailfrom: prabhakar.mahadev-lad.rj@bp.renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pu8dWWk/GHyM5UPJX6SB8VYU6iicjQmmPMbog6duJ3uake8/GY19ewCmBcJfwjVm7PAtMvCncU4io5Z28FpcWJwiKuQtc+lQ9rIyjGnlqv8PkMNJo6m1tGO9p/Ink6MoY6+HX7EpGWqRoUNZ4jAWFN0ubwQCAIOUdi6jcDW4NRwn9UXCfpRXLBjoafhMR6/5akBigiKKsxDwAR+4D8LQhor5cr/Bn6vrmikXvF8EitZivwuPZhy2gg1dLDQNEUVvCPI5LdYF0zyVsH+njTMR6nKDPBGr/vfoA9bVbI/cvb1lwnlpK8UJ2vIc2rKtGAcAcjkGrBGukjNh0xERdT7EwA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fT9uYFJrXI3zuyfp6wej1qQXVh7YiBna6eZbIo0JER8=;
 b=BF/2hXspTIBDGUBtTbhDZEUw5HPlrblUilUVVo7MXq69WCYdxddU7NQVczM4wodYjeQOTeBPjBTo3X7Q3IpsSpHOQLq5oHvvP1Hm30IeqW+MP0RhzeTiAYHLKq219BR2mHrR8PXaps1zHVRynl7tKiYGYNH55elZeVXNKJATQ+9nI+MHGir8CoteWJROv3WvsINrjM+aEvgWuO9oguZPf2MTVi/dB5Li8DCZcdmokHb521GnSstaJPHg+HG6HkHI5hdLjdAbp/gCm3pX89IkjtKgF8UAe/MJsxf4eaa4srVyd5Hsp+B6wGbhORxOwkwSWjNQhIH8hDwXLi1cRLBR0Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 8.62.32.50) smtp.rcpttodomain=bp.renesas.com smtp.mailfrom=bp.renesas.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=bp.renesas.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fT9uYFJrXI3zuyfp6wej1qQXVh7YiBna6eZbIo0JER8=;
 b=AIWUzOjOp+UWiS4gN8F8JYk+Ag+WKFr7NDqSmFwE85naeiIdfSFryn2gplOpaopAqWfRZXXnjRuvU8/lJ2uEOs1Z72sRV/y3nWYk5e/ZN4mGQDSvFoW2r7D4Lg6HOl7ucv23O2R5japIt1C1vGNvlTmI7qB+78u6KpoCdlQ0S44=
Received: from TYCP301CA0058.JPNP301.PROD.OUTLOOK.COM (2603:1096:400:384::7)
 by TYYPR01MB7999.jpnprd01.prod.outlook.com (2603:1096:400:f8::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.12; Mon, 2 Nov
 2026 13:02:25 +0000
Received: from TY1PEPF00046B4D.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:384:cafe::63) by TYCP301CA0058.outlook.office365.com
 (2603:1096:400:384::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.569.12 via Frontend Transport; Mon, 2
 Nov 2026 13:02:25 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 8.62.32.50) smtp.mailfrom=bp.renesas.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=bp.renesas.com;
Received-SPF: Pass (protection.outlook.com: domain of bp.renesas.com
 designates 8.62.32.50 as permitted sender) receiver=protection.outlook.com;
 client-ip=8.62.32.50; helo=ejcrelay004p.adwin.renesas.com; pr=E
Received: from ejcrelay004p.adwin.renesas.com (8.62.32.50) by
 TY1PEPF00046B4D.mail.protection.outlook.com (10.167.253.37) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.592.5
 via Frontend Transport; Mon, 2 Nov 2026 13:02:25 +0000
Received: from Ubuntu-22.. (ed-eng-lt-dbi.diasemi.com [10.24.1.66])
	by ejcrelay004p.adwin.renesas.com (Postfix) with ESMTP id D3F833000230;
	Mon,  2 Nov 2026 22:02:23 +0900 (JST)
From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro.iwamatsu.x90@mail.toshiba>,
	Pavel Machek <pavel@nabladev.com>
CC: Biju Das <biju.das.jz@bp.renesas.com>
Subject: [PATCH 6.12.y-cip 5/7] clk: renesas: r9a09g057: Add PCIe clocks and reset
Date: Mon,  2 Nov 2026 13:02:10 +0000
Message-ID: <20261102130212.8115-6-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261102130212.8115-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20261102130212.8115-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Return-Path: prabhakar.mahadev-lad.rj@bp.renesas.com
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY1PEPF00046B4D:EE_|TYYPR01MB7999:EE_
X-MS-Office365-Filtering-Correlation-Id: d1de133d-e6ea-40d8-da5d-08df38e18aa4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|82310400026|1800799024|376014|23010399003|36860700016|18002099003|22082099003|56012099006|10067099003|13003099007|261009223027099003|261021121427099003|11063799006|261026121527099003;
X-Microsoft-Antispam-Message-Info: chOzpxmpkVfFAfZMXB3/Ipr4mq5epcLdJgx+QEYgt/I55ncs1+hi2TMRW1/O+jyWCy1q7KRegBqtR0WvEwSmG+Q6WrAZLTGwXL9XaY7tYV6Rp9aIFzlyvSHeydHRGJfqAm2wLuTU64/rkUBSwN73OX/miUkFsHE1QM3VC/dJsEeYGIZAXiPeG5OHv+7qk5Y+w6BBunQAL0cPt4pDDpM28eXpfkWJ91okWhD8c0EKvwUDzmRkrBlSLz8s+TSyB/pK7uO/4JUOnYzSYnmcnnXVWfzY2JUY6GsCAD1afMSDTXCxR+NlpmrS687cBvKSXBeatAq9ZT/+XDTLrWiSli6pjf1T8/W15EO5kMATlQDsMQQKdI8S/QngkHi9HSLVNELoooG9r4dBXtB+BQPt/VDUB47WqOGPVxg2x1Qi74wddQKajWhFWH6+FDq6Q9tNN9YAXuJcYwOsuSMtTZZDjGabtnVfqrpDL9i+R0yVlP9F5t2U5x/+4pbuTuzDnWmwZ4Kw9t3FEGCMJ1zoKDJOS0d0OgUExqMOSGigg/yhUuqV5y9fMc9sDIaQIZBDn1HlpKsrqyXX+/kPhcPdbFzMOWya7vsqEp1XwSbg3FtamI9TuxxxLJrgD0gdsKiQI8S3vZtBO8BV2yLLU9sk8uhFqN//+A==
X-Forefront-Antispam-Report: CIP:8.62.32.50;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:ejcrelay004p.adwin.renesas.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(376014)(23010399003)(36860700016)(18002099003)(22082099003)(56012099006)(10067099003)(13003099007)(261009223027099003)(261021121427099003)(11063799006)(261026121527099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: M1zU1EECkLwBL+DXiFZ23Al0odgf8cEet69WbLRcHOQPNVPugQ9vtzbobIkYFoo2o4ObZlvpWSTovMa+WGjTVRALgONRKMtfjn8lKC5OM4A1LsR9WOPg4DIL0uoQTmHwxgOrtBb+x1L3IcdsuJ1ANtyakjcRwIutrrw9Nr4eyA2WR+F9J6Sw9Cxg426ssiRVeVnkJRNNXRxwjOxJcHhXaXcTH1DdTxM+0ioLaryeZDcFIB4BuWyYzc5OEA4PQ+5MjjDx4ClNYIORr0gZxTCtlLGqkgVAJAPVg8A+C2oRFRxL3eXnqw+QhxFUAjDET6nFT8rcN1fryRNq9aCvfXbnO3kr63WuVFqPrfxRopPPQYymjkMwOUu6UNc/m/BRJSDr3qmL9Vo3CD+oZcQOU4sPL19pYkqvkuF1SaAlqtz2yCKMAR0bKm1eSJmgU7Z/JxWH
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Nov 2026 13:02:25.4250
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d1de133d-e6ea-40d8-da5d-08df38e18aa4
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=53d82571-da19-47e4-9cb4-625a166a4a2a;Ip=[8.62.32.50];Helo=[ejcrelay004p.adwin.renesas.com]
X-MS-Exchange-CrossTenant-AuthSource: TY1PEPF00046B4D.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYYPR01MB7999
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by lin-tor-korg-lkml-alma10-1 with HTTPS for <cip-dev@lists.cip-project.org>; Mon, 02 Nov 2026 13:02:33 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/24614
Content-Type: text/plain; charset="utf-8"

commit c45d9bebf8b4ce4e50900723efa5b733e27684bd upstream.

Add clocks and reset entries for the PCIe controller.

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Reviewed-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Link: https://patch.msgid.link/20260312111521.115392-3-prabhakar.mahadev-la=
d.rj@bp.renesas.com
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
 drivers/clk/renesas/r9a09g057-cpg.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/clk/renesas/r9a09g057-cpg.c b/drivers/clk/renesas/r9a0=
9g057-cpg.c
index f5715947e8459..95b1d047dc094 100644
--- a/drivers/clk/renesas/r9a09g057-cpg.c
+++ b/drivers/clk/renesas/r9a09g057-cpg.c
@@ -407,6 +407,10 @@ static const struct rzv2h_mod_clk r9a09g057_mod_clks[]=
 __initconst =3D {
 						BUS_MSTOP(8, BIT(6))),
 	DEF_MOD("gbeth_1_aclk_i",		CLK_PLLDTY_DIV8, 12, 3, 6, 3,
 						BUS_MSTOP(8, BIT(6))),
+	DEF_MOD("pcie_0_aclk",			CLK_PLLDTY_ACPU_DIV2, 12, 4, 6, 4,
+						BUS_MSTOP(1, BIT(13) | BIT(15))),
+	DEF_MOD("pcie_0_clk_pmu",		CLK_PLLDTY_ACPU_DIV2, 12, 5, 6, 5,
+						BUS_MSTOP(1, BIT(13) | BIT(15))),
 	DEF_MOD("cru_0_aclk",			CLK_PLLDTY_ACPU_DIV2, 13, 2, 6, 18,
 						BUS_MSTOP(9, BIT(4))),
 	DEF_MOD_NO_PM("cru_0_vclk",		CLK_PLLVDO_CRU0, 13, 3, 6, 19,
@@ -514,6 +518,7 @@ static const struct rzv2h_reset r9a09g057_resets[] __in=
itconst =3D {
 	DEF_RST(10, 15, 5, 0),		/* USB2_0_PRESETN */
 	DEF_RST(11, 0, 5, 1),		/* GBETH_0_ARESETN_I */
 	DEF_RST(11, 1, 5, 2),		/* GBETH_1_ARESETN_I */
+	DEF_RST(11, 2, 5, 3),		/* PCIE_0_ARESETN */
 	DEF_RST(12, 5, 5, 22),		/* CRU_0_PRESETN */
 	DEF_RST(12, 6, 5, 23),		/* CRU_0_ARESETN */
 	DEF_RST(12, 7, 5, 24),		/* CRU_0_S_RESETN */
--=20
2.43.0

