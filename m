Return-Path: <cosmin-gabriel.tanislav.xa@renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3152FC5DF93
	for <webhook@archiver.kernel.org>; Fri, 21 Aug 2026 13:17:23 +0000 (UTC)
Received: from TYVP286CU001.outbound.protection.outlook.com (TYVP286CU001.outbound.protection.outlook.com [52.101.125.60])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.7171.1787318236178337288
 for <cip-dev@lists.cip-project.org>;
 Fri, 21 Aug 2026 06:17:17 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@renesas.com header.s=selector1 header.b=VN8/PAam;
 spf=pass (domain: renesas.com, ip: 52.101.125.60, mailfrom: cosmin-gabriel.tanislav.xa@renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gSGkIYwBwwOy/DNrIaZ0sVi20U893i9M2/HJmHhj+MusMpIlyP++uym6wa2LtGMnv0la5k8cyNwUpOzi+1UnXezLR1cbT6iwZXhmKSXiUvVpHCEQ4gD0LHvOZle2FSvBuobTYcw3LvRcdMhPBBtXPCZ/rwvqg9vb3+qLuYqZra5yUjBJsKaJ4imjcpeKe3TODjStWBt8pMQExU2OnRmteP0tEmkimdRt1yr9NrhowIXejJ57uJRcEl8GPW+n7Zb8Ew6NMIe08hLoEZCwSvxAiPyw0F902xfoTz9kRj7D+kBl2Y/8IFlj8h9R6mmJxpJDYQ18iH6QPm2iG1O/m9Xljw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yB/cZl2UfQnTctIBaeWeW+QQi5AXV7qO5rR+j0EQhU4=;
 b=Jr8sk8RVxcXNHljTfdnpcRIDOWt6aeQDPr5X4PzvvqU4MPhsxou8WG6qWPufYbLjbdrrmYV420gCdeNC5HJEsyS85UTYuUF2+VrQ/Y7SfN/CuR/jxkauAZP8reKc+Y5T5HAaNaT6yb+vDCICx5gluhNrmeA7OacyUlyAfOAOWpkJydViJDkgmRTzexI8IWisHXtrOuA0GN+HoSxdnNoJ+SAbovNwkNGw1vJH2mvwKVCN6fO1KWpT7Ot2YYbkAk7LagH1gqo8itdG/HF6A2TfyPJPxskfq/GvJcRlqHlzKobrEAkcHPWLzwAeyB1L/t4Izd7HqBtpbZPeRbUSwyz6xg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 8.62.32.50) smtp.rcpttodomain=lists.cip-project.org
 smtp.mailfrom=renesas.com; dmarc=pass (p=none sp=none pct=100) action=none
 header.from=renesas.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yB/cZl2UfQnTctIBaeWeW+QQi5AXV7qO5rR+j0EQhU4=;
 b=VN8/PAamsEJO+oEPCqResWBLedcmM7kriEbYJjuqceULFHZq6OLturSSvDeISXlxekzkWBr8o85VLwdjCbI7ni6LkGY69Ap1lHNl5LFFOTnb9d89tYOU0ZYXNt7RrUuVxpucrZxY/yQ+TGU5qcDB55Lc2rdmD2ymOsSJL6SWuSQ=
Received: from TYCP286CA0049.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:2b5::7)
 by TYYPR01MB12368.jpnprd01.prod.outlook.com (2603:1096:405:f4::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.11; Fri, 21 Aug
 2026 13:17:09 +0000
Received: from TY2PEPF00005623.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:2b5:cafe::62) by TYCP286CA0049.outlook.office365.com
 (2603:1096:400:2b5::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.339.11 via Frontend Transport; Fri,
 21 Aug 2026 13:17:09 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 8.62.32.50)
 smtp.mailfrom=renesas.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=renesas.com;
Received-SPF: Pass (protection.outlook.com: domain of renesas.com designates
 8.62.32.50 as permitted sender) receiver=protection.outlook.com;
 client-ip=8.62.32.50; helo=ejcrelay004p.adwin.renesas.com; pr=E
Received: from ejcrelay004p.adwin.renesas.com (8.62.32.50) by
 TY2PEPF00005623.mail.protection.outlook.com (10.167.240.54) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.360.3
 via Frontend Transport; Fri, 21 Aug 2026 13:17:09 +0000
Received: from demon-pc.localdomain (DEU-5CG5050QD0.adwin.renesas.com [10.226.92.179])
	by ejcrelay004p.adwin.renesas.com (Postfix) with ESMTP id 519A93000374;
	Fri, 21 Aug 2026 22:17:08 +0900 (JST)
From: Cosmin Tanislav <cosmin-gabriel.tanislav.xa@renesas.com>
To: cip-dev@lists.cip-project.org,
	pavel@nabladev.com,
	nobuhiro.iwamatsu.x90@mail.toshiba
Subject: [PATCH 6.12.y-cip 13/18] arm64: dts: renesas: r9a09g077: Add ICU support
Date: Fri, 21 Aug 2026 16:15:49 +0300
Message-ID: <20260821131554.638741-14-cosmin-gabriel.tanislav.xa@renesas.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260821131554.638741-1-cosmin-gabriel.tanislav.xa@renesas.com>
References: <20260821131554.638741-1-cosmin-gabriel.tanislav.xa@renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY2PEPF00005623:EE_|TYYPR01MB12368:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: e3e9f441-a266-453f-ccdc-08deff86817b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|82310400026|376014|23010399003|1800799024|36860700016|13003099007|22082099003|18002099003|56012099006|11063799006|10067099003;
X-Microsoft-Antispam-Message-Info: 
	fZBXy4pQcJmdy8QbV+Awwbr/zcHMfPf+/ZVp/FJkXuV4agnqxWU1fFu7jxm3mZ0OwgYf/fKZO9FyRzY1iPHv4xkoNPm/m0tpSkg6eeWYSKaR5GNbXOFuiQbJvJwyGfNs7tnj9+yx7iImkBUqqO5OT11utBKfwT/c6Jpid8MRxvtn7zl/TAYKiFRdbS41Sjg1lrGZQyj9U2fhnUS+wFbqOwwAQrxE7yJ1sdaMzz09ku14ks9ezPR4iN2r/gL/AqvqNug14Bb1SIF+iwepMQexlhPOnu8hLwUGg7ouEv0/+AbF+/1L2En2rHNAmWTh4RdqCwqhS/z2c4AJuOgpOj6cAvylZ39u60RYVxvoD2ECUtlF2OJG6xaV3lmMihf95TeZouV5IhZQCtKuxgvTH4lvCE9RxPO0YIGWecU+KtixIxEnRuWvVXS5JZUE+2IzzIb+I5yoEVjaEMhobQ7WIESs0Sd9YbHBYOuP3EnPjlABf9abXN5dAGoqzVsX/IE/Zb5yBs1JG3CO3FetKb8xjWuHAXQsabViGTePovFtpcN2cmhSS+Tejsvi7zvuTvJL5ToqOT6xW09x2KkMMXeyvRw9QMDpZrBhI1bIT499bZhiUeOG8hugaUdSGnIDb/3c/ykLGcrLK8InHgZUMk9Gzmjg32xyc9dIAPvuxj4J8pvaRfc=
X-Forefront-Antispam-Report: 
	CIP:8.62.32.50;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:ejcrelay004p.adwin.renesas.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(376014)(23010399003)(1800799024)(36860700016)(13003099007)(22082099003)(18002099003)(56012099006)(11063799006)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	xf1CEuZtT73XNm2vMiyVxOpuPDeSVIH+0gO6h++oSzdBwHySlQ2lyrE4Id4qxEYx5ghU5fii4wElFPYZBkX8kCeQs8ysGZZgLataRuQfrh9HPUPUDAQbukaWm+qjPWZBXcPwfD2SyNdMZjn4XXwbvYvHEmYPB4cn/lFcFetKFsb35mBPAy0CzYeOf/PNVFZ1zEQ6CIj1dHFbWZzcmrWmak5FFE1GXTpLyvstpxM9h2Ymi5FkzXHHqC2Cfo21LJq6OcbcHehFBJof4WHQwoeCJrPcRL5DRiF4fXItef2WUybezK9BYfygwBF/7iFNXHZ8OpumCQCch0RdWWi/kd1ZffUQpB/xZfn27tVBA/HWDCNialp5LogazQtulkhK1PB4CC2JkiSg3t4t6RFdu+pGB4AFwuqIx/999yAf5szOhiAD/fIX5ZiWn2mIAkLQlr6G
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Aug 2026 13:17:09.5751
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e3e9f441-a266-453f-ccdc-08deff86817b
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=53d82571-da19-47e4-9cb4-625a166a4a2a;Ip=[8.62.32.50];Helo=[ejcrelay004p.adwin.renesas.com]
X-MS-Exchange-CrossTenant-AuthSource: TY2PEPF00005623.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYYPR01MB12368
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 21 Aug 2026 13:17:23 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/23971

commit f060bbe2c32941acc4738cc27039246593f49a33 upstream.

The Renesas RZ/T2H (R9A09G077) SoC has an Interrupt Controller (ICU)
block that routes external interrupts to the GIC's SPIs, with the
ability of level-translation, and can also produce software and
aggregate error interrupts.

Add support for it.

Signed-off-by: Cosmin Tanislav <cosmin-gabriel.tanislav.xa@renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Link: https://patch.msgid.link/20251201112933.488801-4-cosmin-gabriel.tanis=
lav.xa@renesas.com
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Cosmin Tanislav <cosmin-gabriel.tanislav.xa@renesas.com>
---
 arch/arm64/boot/dts/renesas/r9a09g077.dtsi | 73 ++++++++++++++++++++++
 1 file changed, 73 insertions(+)

diff --git a/arch/arm64/boot/dts/renesas/r9a09g077.dtsi b/arch/arm64/boot/d=
ts/renesas/r9a09g077.dtsi
index fd0b7e082721..824e1a17050e 100644
--- a/arch/arm64/boot/dts/renesas/r9a09g077.dtsi
+++ b/arch/arm64/boot/dts/renesas/r9a09g077.dtsi
@@ -928,6 +928,79 @@ cpg: clock-controller@80280000 {
 			#power-domain-cells =3D <0>;
 		};
=20
+		icu: interrupt-controller@802a0000 {
+			compatible =3D "renesas,r9a09g077-icu";
+			reg =3D <0 0x802a0000 0 0x10000>,
+			      <0 0x812a0000 0 0x10000>;
+			#interrupt-cells =3D <2>;
+			#address-cells =3D <0>;
+			interrupt-controller;
+			interrupts =3D <GIC_SPI 0 IRQ_TYPE_EDGE_RISING>,
+				     <GIC_SPI 1 IRQ_TYPE_EDGE_RISING>,
+				     <GIC_SPI 2 IRQ_TYPE_EDGE_RISING>,
+				     <GIC_SPI 3 IRQ_TYPE_EDGE_RISING>,
+				     <GIC_SPI 4 IRQ_TYPE_EDGE_RISING>,
+				     <GIC_SPI 5 IRQ_TYPE_EDGE_RISING>,
+				     <GIC_SPI 6 IRQ_TYPE_EDGE_RISING>,
+				     <GIC_SPI 7 IRQ_TYPE_EDGE_RISING>,
+				     <GIC_SPI 8 IRQ_TYPE_EDGE_RISING>,
+				     <GIC_SPI 9 IRQ_TYPE_EDGE_RISING>,
+				     <GIC_SPI 10 IRQ_TYPE_EDGE_RISING>,
+				     <GIC_SPI 11 IRQ_TYPE_EDGE_RISING>,
+				     <GIC_SPI 12 IRQ_TYPE_EDGE_RISING>,
+				     <GIC_SPI 13 IRQ_TYPE_EDGE_RISING>,
+				     <GIC_SPI 14 IRQ_TYPE_EDGE_RISING>,
+				     <GIC_SPI 15 IRQ_TYPE_EDGE_RISING>,
+				     <GIC_SPI 16 IRQ_TYPE_EDGE_RISING>,
+				     <GIC_SPI 17 IRQ_TYPE_EDGE_RISING>,
+				     <GIC_SPI 18 IRQ_TYPE_EDGE_RISING>,
+				     <GIC_SPI 19 IRQ_TYPE_EDGE_RISING>,
+				     <GIC_SPI 20 IRQ_TYPE_EDGE_RISING>,
+				     <GIC_SPI 21 IRQ_TYPE_EDGE_RISING>,
+				     <GIC_SPI 22 IRQ_TYPE_EDGE_RISING>,
+				     <GIC_SPI 23 IRQ_TYPE_EDGE_RISING>,
+				     <GIC_SPI 24 IRQ_TYPE_EDGE_RISING>,
+				     <GIC_SPI 25 IRQ_TYPE_EDGE_RISING>,
+				     <GIC_SPI 26 IRQ_TYPE_EDGE_RISING>,
+				     <GIC_SPI 27 IRQ_TYPE_EDGE_RISING>,
+				     <GIC_SPI 28 IRQ_TYPE_EDGE_RISING>,
+				     <GIC_SPI 29 IRQ_TYPE_EDGE_RISING>,
+				     <GIC_SPI 30 IRQ_TYPE_EDGE_RISING>,
+				     <GIC_SPI 31 IRQ_TYPE_EDGE_RISING>,
+				     <GIC_SPI 406 IRQ_TYPE_EDGE_RISING>,
+				     <GIC_SPI 407 IRQ_TYPE_EDGE_RISING>,
+				     <GIC_SPI 408 IRQ_TYPE_EDGE_RISING>,
+				     <GIC_SPI 409 IRQ_TYPE_EDGE_RISING>,
+				     <GIC_SPI 410 IRQ_TYPE_EDGE_RISING>,
+				     <GIC_SPI 411 IRQ_TYPE_EDGE_RISING>,
+				     <GIC_SPI 412 IRQ_TYPE_EDGE_RISING>,
+				     <GIC_SPI 413 IRQ_TYPE_EDGE_RISING>,
+				     <GIC_SPI 414 IRQ_TYPE_EDGE_RISING>,
+				     <GIC_SPI 415 IRQ_TYPE_EDGE_RISING>,
+				     <GIC_SPI 416 IRQ_TYPE_EDGE_RISING>,
+				     <GIC_SPI 417 IRQ_TYPE_EDGE_RISING>,
+				     <GIC_SPI 418 IRQ_TYPE_EDGE_RISING>;
+			interrupt-names =3D "intcpu0", "intcpu1", "intcpu2",
+					  "intcpu3", "intcpu4", "intcpu5",
+					  "intcpu6", "intcpu7", "intcpu8",
+					  "intcpu9", "intcpu10", "intcpu11",
+					  "intcpu12", "intcpu13", "intcpu14",
+					  "intcpu15",
+					  "irq0", "irq1", "irq2", "irq3",
+					  "irq4", "irq5", "irq6", "irq7",
+					  "irq8", "irq9", "irq10", "irq11",
+					  "irq12", "irq13", "irq14", "irq15",
+					  "sei",
+					  "ca55-err0", "ca55-err1",
+					  "cr520-err0", "cr520-err1",
+					  "cr521-err0", "cr521-err1",
+					  "peri-err0", "peri-err1",
+					  "dsmif-err0", "dsmif-err1",
+					  "encif-err0", "encif-err1";
+			clocks =3D <&cpg CPG_CORE R9A09G077_CLK_PCLKM>;
+			power-domains =3D <&cpg>;
+		};
+
 		pinctrl: pinctrl@802c0000 {
 			compatible =3D "renesas,r9a09g077-pinctrl";
 			reg =3D <0 0x802c0000 0 0x10000>,
--=20
2.55.0


