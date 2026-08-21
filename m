Return-Path: <cosmin-gabriel.tanislav.xa@renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A44C9C5DF93
	for <webhook@archiver.kernel.org>; Fri, 21 Aug 2026 13:17:02 +0000 (UTC)
Received: from TYVP286CU001.outbound.protection.outlook.com (TYVP286CU001.outbound.protection.outlook.com [52.101.125.42])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.7123.1787318216774026748
 for <cip-dev@lists.cip-project.org>;
 Fri, 21 Aug 2026 06:16:57 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@renesas.com header.s=selector1 header.b=clsgzPAG;
 spf=pass (domain: renesas.com, ip: 52.101.125.42, mailfrom: cosmin-gabriel.tanislav.xa@renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BHqzTaPsoMcCtLwoat9d5szvz94125+6+eHuBs1YskaraMulYy25ZI/6CNB8x1V6IEZdmVL5AA7kE8OjIYXAHscVAj1NjJM7kDUdaoNC/2k3IFCwXu7E9ra6EaIUdT4+SSVBFsVaGDNIxutpAqsrPWBNdJUX7VzVMwSAkjrqpDsJCEw0qFiEUDFTREha9D/GD582j9mVkHeQrNnwqMWAvOiKWA0tidFlrSAKza7Oo1tdgjeVWBHjQId1u4k69vEC2qRzQ74yQK0JlgDv3QmXQfcbkKKrtKzXc8XCiP3HDeQmKEJgvWGOSI6h+d8fA1++6gBJ4wBE7hGjq1w4ZcF0nA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=s6t7m3UdBynfbjJcDBYMhsn4/ZXZMr2wZyiyga0fvVM=;
 b=sKAMkahdLSmrUdbzO+jx9UDDJwqeJvltXnfajPRnDtVH/sc4+CNGbW0rZa44In/nV+POvOa5RRcY8gAj7BnKTUMMBbKan3cfaweQx/a5f5p6IHaUcApKRkndZahF4yLFvjLcmv67RtzqUfkRzZSnrn/GavbPIpzhFqMHVe2QzgjhuAPY1ayK2unmkf2J+uojPNZF9AdjsXTSxn9VUx2CmHDlEz5kCLGM/jduae76SdTXgHP97srhYTilkYSUAtqPXg+srE7taegOMMjQpBPNBaCrGSjYvoLNs5DEmfu8uheDS15PrJ9nHh/FRVEnyLP08V27eN0oREwIiBN04f1xbg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 8.62.32.50) smtp.rcpttodomain=lists.cip-project.org
 smtp.mailfrom=renesas.com; dmarc=pass (p=none sp=none pct=100) action=none
 header.from=renesas.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=s6t7m3UdBynfbjJcDBYMhsn4/ZXZMr2wZyiyga0fvVM=;
 b=clsgzPAGWd0nVcuouB0uIDKd1S35paL3XbvWPw97AGzsjGP2KElWGABtzPu3nAT0/e9SMPOOl/hfVz79DfmMfRifaGV3lytrfBV1w5D/pZVDZnIOp6pqkq890guJkxyjWAyN4Nn86E1kncwuxEcMq2fs4SJZcxFJIvZvMjGfPkg=
Received: from OS0PR01CA0029.jpnprd01.prod.outlook.com (2603:1096:604:25::16)
 by OS3PR01MB10343.jpnprd01.prod.outlook.com (2603:1096:604:1fb::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.10; Fri, 21 Aug
 2026 13:16:50 +0000
Received: from OS1PEPF0000D20E.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:604:25:cafe::5b) by OS0PR01CA0029.outlook.office365.com
 (2603:1096:604:25::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.339.11 via Frontend Transport; Fri,
 21 Aug 2026 13:16:50 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 8.62.32.50)
 smtp.mailfrom=renesas.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=renesas.com;
Received-SPF: Pass (protection.outlook.com: domain of renesas.com designates
 8.62.32.50 as permitted sender) receiver=protection.outlook.com;
 client-ip=8.62.32.50; helo=ejcrelay004p.adwin.renesas.com; pr=E
Received: from ejcrelay004p.adwin.renesas.com (8.62.32.50) by
 OS1PEPF0000D20E.mail.protection.outlook.com (10.167.240.37) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.360.3
 via Frontend Transport; Fri, 21 Aug 2026 13:16:48 +0000
Received: from demon-pc.localdomain (DEU-5CG5050QD0.adwin.renesas.com [10.226.92.179])
	by ejcrelay004p.adwin.renesas.com (Postfix) with ESMTP id A6B48300037C;
	Fri, 21 Aug 2026 22:16:47 +0900 (JST)
From: Cosmin Tanislav <cosmin-gabriel.tanislav.xa@renesas.com>
To: cip-dev@lists.cip-project.org,
	pavel@nabladev.com,
	nobuhiro.iwamatsu.x90@mail.toshiba
Subject: [PATCH 6.12.y-cip 01/18] clk: renesas: cpg-mssr: Simplify pointer math in cpg_rzt2h_mstp_read()
Date: Fri, 21 Aug 2026 16:15:37 +0300
Message-ID: <20260821131554.638741-2-cosmin-gabriel.tanislav.xa@renesas.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260821131554.638741-1-cosmin-gabriel.tanislav.xa@renesas.com>
References: <20260821131554.638741-1-cosmin-gabriel.tanislav.xa@renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: OS1PEPF0000D20E:EE_|OS3PR01MB10343:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 91e45ee3-126c-46f5-0c3b-08deff867536
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|1800799024|36860700016|376014|23010399003|82310400026|22082099003|18002099003|13003099007|11063799006|56012099006|10067099003;
X-Microsoft-Antispam-Message-Info: 
	xW1LscFrgI0B8s2Sr5Mu/ClnuyVJbPUZ1H2lWvTu5T3icfFObyDoVXGTMgFvzC8Yn6W+VENc8oXLB+9LUqSWT9V9i5dHwDvLKij0w+j4a7y8U0W0X15Vnmht4+siNI/FVOIaXkSr5krEDkceIRW9fM326uOcrWM1Wg5papQIPPC4jZCKUYtn1Hm0dAz3S0dm3zitP15+Pt+d/orDJ9XQDWJn6m2ypSYK1fKKtIG1/FqsctrKP7a27uaOL89EySafymjqYc7MSbTaw0RaT7Y+PIvUOUDBmlZYWL2kxJjrrKQdIguE65deHvYmGOc/ppDDnKSA4YQV6/wdxScxMXGMU2tsooRoOGWlo+URYKR89ThKEhuUvVJzVEZHxHxTBTIwFV3nUM8TcDhBpIr9I2wkZPG2Lg1HE2495RaZ+5ZRtdQV5UZDbpt6cGnK3z4aOuUyMvrs+SmBv+cK65dmdgwb53IHfxEKWk2wzciP4QG4Nxb5XfeJPK0utYVKSUeh3mYljw8gkGAuIkJB4isL7W7sCtbgTOwMvbzwY3EmMQIM55u7GeWpJR2Z0GFjWabIDiT96Z/SPRWv2IL89xo4M5BFgAMY3IPkAgruIXD9saMHiKiz5l67Jxh3nIPE+TOagEPXJvVqdq2XvSbzQyLwBra0Zpw1gQ77ijSI10ZLxMs5pyE=
X-Forefront-Antispam-Report: 
	CIP:8.62.32.50;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:ejcrelay004p.adwin.renesas.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(36860700016)(376014)(23010399003)(82310400026)(22082099003)(18002099003)(13003099007)(11063799006)(56012099006)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	is+3euG2JFy79GrQzgr0I9i5yksj9AlLdA4e5U5bRqms41gvTkKG1AfA2YvT0m9wVSJoZnnMNz1fHSkyhOYwUe28Il6nOmOHrbLrQ/UEubMKbk0v2fbOPTERE4wNr6apqsImAa+jF7jvR6TpTp/VVyY/9L1VuJMTh1UYqp0vc8joMeEAguyYeM+bIsp56jCgfbBmqneuwsIGw2+5Ehl8M9Xc+40KEAVHcbFlVDnycvlMQFMOMtuySkPlGeAeVYu3iaeFmLX5zgf7+dQtl+n39qZAoZlotrKKyKj08qKgZKO/S2V1OAOqh8MeBbg+Hkft3qybwHtUx1jpyF5+oDnAURvth9/RAKRHqYDCW/avtoIGZlB+RHkEg0yTvRuJyY0xZzVBaRJSd1kpsNN3k+9Id4zolw2KWJK+0Mevde5Qx3oLJZSNk3gWLmtTEl8W4Pte
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Aug 2026 13:16:48.9744
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 91e45ee3-126c-46f5-0c3b-08deff867536
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=53d82571-da19-47e4-9cb4-625a166a4a2a;Ip=[8.62.32.50];Helo=[ejcrelay004p.adwin.renesas.com]
X-MS-Exchange-CrossTenant-AuthSource: OS1PEPF0000D20E.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS3PR01MB10343
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 21 Aug 2026 13:17:02 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/23958

commit 21c1d66a1672573c1934734570bd3b05a301af9e upstream.

Private state is available in all places where cpg_rzt2h_mstp_read() is
called, remove the extra pointer math used to find it from clk_hw.

While at it, put these statements on a single line as they do not exceed
the 80 columns limit.

Signed-off-by: Cosmin Tanislav <cosmin-gabriel.tanislav.xa@renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Link: https://patch.msgid.link/20251127145654.3253992-2-cosmin-gabriel.tani=
slav.xa@renesas.com
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Cosmin Tanislav <cosmin-gabriel.tanislav.xa@renesas.com>
---
 drivers/clk/renesas/renesas-cpg-mssr.c | 20 ++++++--------------
 1 file changed, 6 insertions(+), 14 deletions(-)

diff --git a/drivers/clk/renesas/renesas-cpg-mssr.c b/drivers/clk/renesas/r=
enesas-cpg-mssr.c
index ab4a1263b9fb..fee13c0bc095 100644
--- a/drivers/clk/renesas/renesas-cpg-mssr.c
+++ b/drivers/clk/renesas/renesas-cpg-mssr.c
@@ -237,20 +237,16 @@ struct mstp_clock {
=20
 #define to_mstp_clock(_hw) container_of(_hw, struct mstp_clock, hw)
=20
-static u32 cpg_rzt2h_mstp_read(struct clk_hw *hw, u16 offset)
+static u32 cpg_rzt2h_mstp_read(struct cpg_mssr_priv *priv, u16 offset)
 {
-	struct mstp_clock *clock =3D to_mstp_clock(hw);
-	struct cpg_mssr_priv *priv =3D clock->priv;
 	void __iomem *base =3D
 		RZT2H_MSTPCR_BLOCK(offset) ? priv->pub.base1 : priv->pub.base0;
=20
 	return readl(base + RZT2H_MSTPCR_OFFSET(offset));
 }
=20
-static void cpg_rzt2h_mstp_write(struct clk_hw *hw, u16 offset, u32 value)
+static void cpg_rzt2h_mstp_write(struct cpg_mssr_priv *priv, u16 offset, u=
32 value)
 {
-	struct mstp_clock *clock =3D to_mstp_clock(hw);
-	struct cpg_mssr_priv *priv =3D clock->priv;
 	void __iomem *base =3D
 		RZT2H_MSTPCR_BLOCK(offset) ? priv->pub.base1 : priv->pub.base0;
=20
@@ -286,17 +282,14 @@ static int cpg_mstp_clock_endisable(struct clk_hw *hw=
, bool enable)
 		barrier_data(priv->pub.base0 + priv->control_regs[reg]);
=20
 	} else if (priv->reg_layout =3D=3D CLK_REG_LAYOUT_RZ_T2H) {
-		value =3D cpg_rzt2h_mstp_read(hw,
-					    priv->control_regs[reg]);
+		value =3D cpg_rzt2h_mstp_read(priv, priv->control_regs[reg]);
=20
 		if (enable)
 			value &=3D ~bitmask;
 		else
 			value |=3D bitmask;
=20
-		cpg_rzt2h_mstp_write(hw,
-				     priv->control_regs[reg],
-				     value);
+		cpg_rzt2h_mstp_write(priv, priv->control_regs[reg], value);
 	} else {
 		value =3D readl(priv->pub.base0 + priv->control_regs[reg]);
 		if (enable)
@@ -318,7 +311,7 @@ static int cpg_mstp_clock_endisable(struct clk_hw *hw, =
bool enable)
 		 * the IP at least seven times. Instead of memory-mapping the IP
 		 * register, we simply add a delay after the read operation.
 		 */
-		cpg_rzt2h_mstp_read(hw, priv->control_regs[reg]);
+		cpg_rzt2h_mstp_read(priv, priv->control_regs[reg]);
 		udelay(10);
 		return 0;
 	}
@@ -352,8 +345,7 @@ static int cpg_mstp_clock_is_enabled(struct clk_hw *hw)
 	if (priv->reg_layout =3D=3D CLK_REG_LAYOUT_RZ_A)
 		value =3D readb(priv->pub.base0 + priv->control_regs[reg]);
 	else if (priv->reg_layout =3D=3D CLK_REG_LAYOUT_RZ_T2H)
-		value =3D cpg_rzt2h_mstp_read(hw,
-					    priv->control_regs[reg]);
+		value =3D cpg_rzt2h_mstp_read(priv, priv->control_regs[reg]);
 	else
 		value =3D readl(priv->pub.base0 + priv->status_regs[reg]);
=20
--=20
2.55.0


