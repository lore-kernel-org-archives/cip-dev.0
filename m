Return-Path: <prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D646C88E4C
	for <webhook@archiver.kernel.org>; Fri, 11 Sep 2026 08:12:03 +0000 (UTC)
Received: from TY3P286CU002.outbound.protection.outlook.com (TY3P286CU002.outbound.protection.outlook.com [52.101.229.2])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.34553.1789114314549848701
 for <cip-dev@lists.cip-project.org>;
 Fri, 11 Sep 2026 01:11:54 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@bp.renesas.com header.s=selector1 header.b=l6xO02S6;
 spf=pass (domain: bp.renesas.com, ip: 52.101.229.2, mailfrom: prabhakar.mahadev-lad.rj@bp.renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=K+neV7kxBYfo2lmtXRlrtOhCZ6qN5u6lE/wR5Ltwf8qTZBmLPNVnIMSgInTkGsJk4R0k7m5NAIyB4tytEjIXj9eKcoiF3AfD604geASaWCBxFY4N1j9fcKLkwQglxKbFt4I4LwMsavAhlwwRWGVlWUflHNlCoUgao8V5gpJD4gXzDBjuJ2QSEBMdqhs9LquT1TunvujQzck71ExcWsQyM/2Y16VJouqS8sDpo0+A8kVr4bxp1jOT8F/Z7ObaFYsCKvGEsWvKfQzuIKP0GNY7T2IccVRJb0aptRs21GPM1wq0x301frqkOjb6VqeiejmtpdrHz8LbjukiLiUe3wLUEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fDmfOsjQQAXBnCUAyVm3Q0dA1yUr35FJNfFTE2KoEow=;
 b=KbtwFMd5f5YdKYIFug64bMak+W0t29jY83G8H/mZaBiaKtoK3wmsErojxXo3B4QYuLRViXSlsKGWN3FXrspNqDxOghIYRNZ6jmKwXMxG5Z7CoL2DBKADbo/cC31QTtljNbfxu69Jsq6s+eRvg+0ODoDw7NxJGGDtVe8mtdd2KsR9EnWNNk3/ORXSlJfEKKMf7m7pkRgM1K5FemDHppISgJ1mBkJzwQLhO4R+RwfVxtphBfIQrrissjNa8vyYLJzxQli5WZ+DSFDz7HL4bncfZUrX5O5kUuKxEbWHu3baZ7aeQ6sEYPkksFxOqAc0QvZpyu+zxdR29f4ayBR9/60PCw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 8.62.32.50) smtp.rcpttodomain=bp.renesas.com smtp.mailfrom=bp.renesas.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=bp.renesas.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fDmfOsjQQAXBnCUAyVm3Q0dA1yUr35FJNfFTE2KoEow=;
 b=l6xO02S69/ZM9s0QFfoXV0hNOzMybjmz8dErx+ASxe03hO6W2c43pjpVavHJnlszfC4cJwjXCjDMZR4AvvbO4dtoOebt6e1rBDS86yPA6Dvl5d5S2kZL6bBp5NhMeeIZwpUJNdQVAjtb2WZwrCyzybGpnyYu7ptUtgNAJxtJk1E=
Received: from OS7PR01CA0217.jpnprd01.prod.outlook.com (2603:1096:604:252::17)
 by TYRPR01MB15096.jpnprd01.prod.outlook.com (2603:1096:405:228::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.9; Fri, 11 Sep
 2026 08:11:50 +0000
Received: from OS3PEPF0000003E.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:604:252:cafe::ad) by OS7PR01CA0217.outlook.office365.com
 (2603:1096:604:252::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.406.9 via Frontend Transport; Fri, 11
 Sep 2026 08:11:48 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 8.62.32.50)
 smtp.mailfrom=bp.renesas.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=bp.renesas.com;
Received-SPF: Pass (protection.outlook.com: domain of bp.renesas.com
 designates 8.62.32.50 as permitted sender) receiver=protection.outlook.com;
 client-ip=8.62.32.50; helo=ejcrelay005p.adwin.renesas.com; pr=E
Received: from ejcrelay005p.adwin.renesas.com (8.62.32.50) by
 OS3PEPF0000003E.mail.protection.outlook.com (10.167.240.7) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.406.5
 via Frontend Transport; Fri, 11 Sep 2026 08:11:48 +0000
Received: from Ubuntu-22.. (gbr-5cg2238qm6.diasemi.com [10.24.0.235])
	by ejcrelay005p.adwin.renesas.com (Postfix) with ESMTP id DABA630002A7;
	Fri, 11 Sep 2026 17:11:46 +0900 (JST)
From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro.iwamatsu.x90@mail.toshiba>,
	Pavel Machek <pavel@nabladev.com>
CC: Biju Das <biju.das.jz@bp.renesas.com>
Subject: [PATCH 6.12.y-cip 8/8] arm64: dts: renesas: r9a09g087: Add DMAC support
Date: Fri, 11 Sep 2026 09:11:32 +0100
Message-ID: <20260911081132.11879-9-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260911081132.11879-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20260911081132.11879-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: OS3PEPF0000003E:EE_|TYRPR01MB15096:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 62950d13-d5a2-4064-c953-08df0fdc53c8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|36860700016|1800799024|23010399003|376014|82310400026|11063799006|56012099006|22082099003|10067099003|18002099003;
X-Microsoft-Antispam-Message-Info: 
	Z+E6oSWEaIWnqFEZkMvI3+tREuWKrn0NQ2/qfPFDUmGukCEWZQV+BMrVRXuYQrppRt05Ev2jzAjOr9tFb0ev9DhVPmAhX5aOSPtM4MQz5r7eSRboheiIdr6pJCGktGNmLZZg0Xjf/O6GlTRQA2VO2shTSi9X+S9SjTV6/nDC+VvE58Q1xPzZJ1MPWOTdtXL2iyihqp3lcIIjI9hNartiDywAQM3ki/BBcuJfVsqOPSWa1rKClyNOyKWiTlCNFrr9WE3eIiK8uEGQT+BWlmlQGRTriRn2pyx0jPSrLMj5wc5Xcre4quLyANhy9H+aXjEji2eTUwhVBDVfuO5/bZjbxx9aH0WJqszJAlXLkwxiUsygkXt/1nT7Vta/VjGdmQuVwjrtz9hWevFTSe2sY5iPfw3rSvZW150DJaCh+u4hL0P7GLAXwEpPup+hbdWistq/+SZniL3xwDoXjlmjAaXcAR2+IgBsH9bEG7Svj2hoVaiYzPBLv1d0cJWxfCeJ9BWjcicZDVVdpI4a4K6kp0oAJG4tIt57Om0eElQbAgjnmXgHT4naS8RmCVx4AZt+wlOJD3qPtQuDrDq3enk4eyXEFikGnHSyKj8tFHtWuDMGyL33QtIxatCL7wTmEkiZQDlEViLWpv7qGXAz4NzO9MEizjVr63wCRXybmeyy/M6qkAI=
X-Forefront-Antispam-Report: 
	CIP:8.62.32.50;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:ejcrelay005p.adwin.renesas.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700016)(1800799024)(23010399003)(376014)(82310400026)(11063799006)(56012099006)(22082099003)(10067099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	UwXPYLBHpVelSEqUhhBr1u+tGQ/L2DdRP/Wlhpyg6AVZO0VhyqZstvawrvCzzgJ6e9KiNpCN3pLAPLIsQV274B4s9ntIu1b73QnHzGsdSqAxJK7nUhO9iCl9FGBTKRmJ5uqB5sOsH+cn6ZJtQpHkPs4OnvazP/tU5MoC2dCN4etwf5yrHcRLlnay6h5sAKXiC043Mt5oztn21Hwiy/8WkKKv51KdGh9N5AOQjdnyspnignGWHlwQlp4lf4IpxMMsnMWL7EKPDTpcj6NR1efSERr9YV5DVDw9yaWPJ6Pzvkwp+IeExQvzRcRz3Hl+zyuZzG9n1wLVys60W9BTzNI7ZHRlGaS1qQYnDD5GTPbGAbQbtlkeFXOP0oM/KdmDpZjIJVlpSs0/FI7l3v3TpL2d67ETh4hfhhynskVg33mh4byUbCUwxNs5doSdAAbsvEGG
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Sep 2026 08:11:48.2145
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 62950d13-d5a2-4064-c953-08df0fdc53c8
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=53d82571-da19-47e4-9cb4-625a166a4a2a;Ip=[8.62.32.50];Helo=[ejcrelay005p.adwin.renesas.com]
X-MS-Exchange-CrossTenant-AuthSource: OS3PEPF0000003E.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYRPR01MB15096
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 11 Sep 2026 08:12:03 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/24125

From: Cosmin Tanislav <cosmin-gabriel.tanislav.xa@renesas.com>

commit 57a0c2d36c646a64c117de534b787abe0a0b8bcf upstream.

The Renesas RZ/N2H (R9A09G087) SoC has three instances of the DMAC IP.

Add support for them.

Signed-off-by: Cosmin Tanislav <cosmin-gabriel.tanislav.xa@renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Link: https://patch.msgid.link/20251205151254.2970669-7-cosmin-gabriel.tani=
slav.xa@renesas.com
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
 arch/arm64/boot/dts/renesas/r9a09g087.dtsi | 90 ++++++++++++++++++++++
 1 file changed, 90 insertions(+)

diff --git a/arch/arm64/boot/dts/renesas/r9a09g087.dtsi b/arch/arm64/boot/d=
ts/renesas/r9a09g087.dtsi
index eb405ae6f03e3..82167083bb158 100644
--- a/arch/arm64/boot/dts/renesas/r9a09g087.dtsi
+++ b/arch/arm64/boot/dts/renesas/r9a09g087.dtsi
@@ -402,6 +402,96 @@ i2c2: i2c@81008000 {
 			status =3D "disabled";
 		};
=20
+		dmac0: dma-controller@800c0000 {
+			compatible =3D "renesas,r9a09g087-dmac", "renesas,r9a09g077-dmac";
+			reg =3D <0 0x800c0000 0 0x1000>;
+			interrupts =3D <GIC_SPI 32 IRQ_TYPE_EDGE_RISING>,
+				     <GIC_SPI 33 IRQ_TYPE_EDGE_RISING>,
+				     <GIC_SPI 34 IRQ_TYPE_EDGE_RISING>,
+				     <GIC_SPI 35 IRQ_TYPE_EDGE_RISING>,
+				     <GIC_SPI 36 IRQ_TYPE_EDGE_RISING>,
+				     <GIC_SPI 37 IRQ_TYPE_EDGE_RISING>,
+				     <GIC_SPI 38 IRQ_TYPE_EDGE_RISING>,
+				     <GIC_SPI 39 IRQ_TYPE_EDGE_RISING>,
+				     <GIC_SPI 40 IRQ_TYPE_EDGE_RISING>,
+				     <GIC_SPI 41 IRQ_TYPE_EDGE_RISING>,
+				     <GIC_SPI 42 IRQ_TYPE_EDGE_RISING>,
+				     <GIC_SPI 43 IRQ_TYPE_EDGE_RISING>,
+				     <GIC_SPI 44 IRQ_TYPE_EDGE_RISING>,
+				     <GIC_SPI 45 IRQ_TYPE_EDGE_RISING>,
+				     <GIC_SPI 46 IRQ_TYPE_EDGE_RISING>,
+				     <GIC_SPI 47 IRQ_TYPE_EDGE_RISING>;
+			interrupt-names =3D "ch0", "ch1", "ch2", "ch3",
+					  "ch4", "ch5", "ch6", "ch7",
+					  "ch8", "ch9", "ch10", "ch11",
+					  "ch12", "ch13", "ch14", "ch15";
+			clocks =3D <&cpg CPG_CORE R9A09G087_CLK_PCLKH>;
+			power-domains =3D <&cpg>;
+			#dma-cells =3D <1>;
+			dma-channels =3D <16>;
+			renesas,icu =3D <&icu 0>;
+		};
+
+		dmac1: dma-controller@800c1000 {
+			compatible =3D "renesas,r9a09g087-dmac", "renesas,r9a09g077-dmac";
+			reg =3D <0 0x800c1000 0 0x1000>;
+			interrupts =3D <GIC_SPI 48 IRQ_TYPE_EDGE_RISING>,
+				     <GIC_SPI 49 IRQ_TYPE_EDGE_RISING>,
+				     <GIC_SPI 50 IRQ_TYPE_EDGE_RISING>,
+				     <GIC_SPI 51 IRQ_TYPE_EDGE_RISING>,
+				     <GIC_SPI 52 IRQ_TYPE_EDGE_RISING>,
+				     <GIC_SPI 53 IRQ_TYPE_EDGE_RISING>,
+				     <GIC_SPI 54 IRQ_TYPE_EDGE_RISING>,
+				     <GIC_SPI 55 IRQ_TYPE_EDGE_RISING>,
+				     <GIC_SPI 56 IRQ_TYPE_EDGE_RISING>,
+				     <GIC_SPI 57 IRQ_TYPE_EDGE_RISING>,
+				     <GIC_SPI 58 IRQ_TYPE_EDGE_RISING>,
+				     <GIC_SPI 59 IRQ_TYPE_EDGE_RISING>,
+				     <GIC_SPI 60 IRQ_TYPE_EDGE_RISING>,
+				     <GIC_SPI 61 IRQ_TYPE_EDGE_RISING>,
+				     <GIC_SPI 62 IRQ_TYPE_EDGE_RISING>,
+				     <GIC_SPI 63 IRQ_TYPE_EDGE_RISING>;
+			interrupt-names =3D "ch0", "ch1", "ch2", "ch3",
+					  "ch4", "ch5", "ch6", "ch7",
+					  "ch8", "ch9", "ch10", "ch11",
+					  "ch12", "ch13", "ch14", "ch15";
+			clocks =3D <&cpg CPG_CORE R9A09G087_CLK_PCLKH>;
+			power-domains =3D <&cpg>;
+			#dma-cells =3D <1>;
+			dma-channels =3D <16>;
+			renesas,icu =3D <&icu 1>;
+		};
+
+		dmac2: dma-controller@800c2000 {
+			compatible =3D "renesas,r9a09g087-dmac", "renesas,r9a09g077-dmac";
+			reg =3D <0 0x800c2000 0 0x1000>;
+			interrupts =3D <GIC_SPI 64 IRQ_TYPE_EDGE_RISING>,
+				     <GIC_SPI 65 IRQ_TYPE_EDGE_RISING>,
+				     <GIC_SPI 66 IRQ_TYPE_EDGE_RISING>,
+				     <GIC_SPI 67 IRQ_TYPE_EDGE_RISING>,
+				     <GIC_SPI 68 IRQ_TYPE_EDGE_RISING>,
+				     <GIC_SPI 69 IRQ_TYPE_EDGE_RISING>,
+				     <GIC_SPI 70 IRQ_TYPE_EDGE_RISING>,
+				     <GIC_SPI 71 IRQ_TYPE_EDGE_RISING>,
+				     <GIC_SPI 72 IRQ_TYPE_EDGE_RISING>,
+				     <GIC_SPI 73 IRQ_TYPE_EDGE_RISING>,
+				     <GIC_SPI 74 IRQ_TYPE_EDGE_RISING>,
+				     <GIC_SPI 75 IRQ_TYPE_EDGE_RISING>,
+				     <GIC_SPI 76 IRQ_TYPE_EDGE_RISING>,
+				     <GIC_SPI 77 IRQ_TYPE_EDGE_RISING>,
+				     <GIC_SPI 78 IRQ_TYPE_EDGE_RISING>,
+				     <GIC_SPI 79 IRQ_TYPE_EDGE_RISING>;
+			interrupt-names =3D "ch0", "ch1", "ch2", "ch3",
+					  "ch4", "ch5", "ch6", "ch7",
+					  "ch8", "ch9", "ch10", "ch11",
+					  "ch12", "ch13", "ch14", "ch15";
+			clocks =3D <&cpg CPG_CORE R9A09G087_CLK_PCLKH>;
+			power-domains =3D <&cpg>;
+			#dma-cells =3D <1>;
+			dma-channels =3D <16>;
+			renesas,icu =3D <&icu 2>;
+		};
+
 		gmac0: ethernet@80100000 {
 			compatible =3D "renesas,r9a09g087-gbeth", "renesas,r9a09g077-gbeth",
 				     "snps,dwmac-5.20";
--=20
2.43.0


