Return-Path: <prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8E0AC88E50
	for <webhook@archiver.kernel.org>; Fri, 11 Sep 2026 08:11:53 +0000 (UTC)
Received: from TY3P286CU002.outbound.protection.outlook.com (TY3P286CU002.outbound.protection.outlook.com [52.101.229.28])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.34552.1789114311803423916
 for <cip-dev@lists.cip-project.org>;
 Fri, 11 Sep 2026 01:11:52 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@bp.renesas.com header.s=selector1 header.b=CWXEha8u;
 spf=pass (domain: bp.renesas.com, ip: 52.101.229.28, mailfrom: prabhakar.mahadev-lad.rj@bp.renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=slwlWjdjGQyaTqWJ30MCT2EqBWgRHFl3rtGwc9QMNanErsdGnSYsjbZBt4FKi1AvZANWVtTkIR/2UR0RDtUPZse89qrLfJOlZaloA/vXFhfkWgDEGvqg79GPsRgC56SRaO+0j7InL5ipVa28ZSkSbY8TklH8kcv6zCbJJbHi5qztStaMH2Cnv3bhDkLum55lQXXTa/PF6jBUg16ZAftWNfNeIEHB1auZdlBBcCN6mo0RbHKkqhT1iH/3V8gyItkcfrs/XXxAO/B2q6yilMdaKF1ayQ27Lbzz1qSEZcj9movxuQbPviQDETHIXgqlvLngAXbke9H8By0xA2JK31Ck0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pj/aC3Pkx/YT9tN//ruERi3mUEcAxWwkR7NpYQ2wswI=;
 b=RQfmaYuKMAkxuqlkEqEwrc8VdO6i32MsP17Zma2cSjlJvwPqFA+HQ7WQfWptqpscA2ONgjO26wuiORvAVOeWHDkSQnhuOnd8lRLa/dl9m18uO2uX2o0movGKIgIqcdb6ESQ5VN47oOoefF63noXEI973yBxJWxIwWNOBab8W4sD5BLwb3JRukw5sR4UEdD5mt6QaYMnewVrFO547Wf3Im2e4oG6VBpyde7tJrY0rXKCj6A0wmYyJuv3am9gf5RAeQGRA1EWVyH9fNiCXYjqPTU471PKgv8lm7CqHeP8P3BnNky71jNe4YYJhgODGhEhoX4JjYkmQuAsTQ1NAEfQVmg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 8.62.32.50) smtp.rcpttodomain=bp.renesas.com smtp.mailfrom=bp.renesas.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=bp.renesas.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pj/aC3Pkx/YT9tN//ruERi3mUEcAxWwkR7NpYQ2wswI=;
 b=CWXEha8ucXnoAr8L+vfQJqKFA4M4/Znnr0fsgiZYXM5gXGI+yL54m05qELp9aE8D5ARU8/fcHVJofrIXgqvUZ/wdJ6wazuDiNQYIk12pWe1fRaHNXuCYPjWDUcbm8Z78hhLYyIXjJtjIn9Nxrb6PxaRPn3ub17ydwWesOxZSD/w=
Received: from OS3P301CA0013.JPNP301.PROD.OUTLOOK.COM (2603:1096:604:21d::6)
 by OS7PR01MB11807.jpnprd01.prod.outlook.com (2603:1096:604:244::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.9; Fri, 11 Sep
 2026 08:11:46 +0000
Received: from OS1PEPF0000D20D.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:604:21d:cafe::53) by OS3P301CA0013.outlook.office365.com
 (2603:1096:604:21d::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.406.9 via Frontend Transport; Fri, 11
 Sep 2026 08:11:46 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 8.62.32.50)
 smtp.mailfrom=bp.renesas.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=bp.renesas.com;
Received-SPF: Pass (protection.outlook.com: domain of bp.renesas.com
 designates 8.62.32.50 as permitted sender) receiver=protection.outlook.com;
 client-ip=8.62.32.50; helo=ejcrelay005p.adwin.renesas.com; pr=E
Received: from ejcrelay005p.adwin.renesas.com (8.62.32.50) by
 OS1PEPF0000D20D.mail.protection.outlook.com (10.167.240.36) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.406.5
 via Frontend Transport; Fri, 11 Sep 2026 08:11:46 +0000
Received: from Ubuntu-22.. (gbr-5cg2238qm6.diasemi.com [10.24.0.235])
	by ejcrelay005p.adwin.renesas.com (Postfix) with ESMTP id 3771530002A8;
	Fri, 11 Sep 2026 17:11:44 +0900 (JST)
From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro.iwamatsu.x90@mail.toshiba>,
	Pavel Machek <pavel@nabladev.com>
CC: Biju Das <biju.das.jz@bp.renesas.com>
Subject: [PATCH 6.12.y-cip 7/8] arm64: dts: renesas: r9a09g077: Add DMAC support
Date: Fri, 11 Sep 2026 09:11:31 +0100
Message-ID: <20260911081132.11879-8-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260911081132.11879-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20260911081132.11879-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: OS1PEPF0000D20D:EE_|OS7PR01MB11807:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: aeb39f78-99e4-4bf5-704b-08df0fdc52c8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|82310400026|1800799024|23010399003|36860700016|376014|22082099003|18002099003|56012099006|10067099003|11063799006;
X-Microsoft-Antispam-Message-Info: 
	BD4N0+UFZXn1ldNIBC+4bAuDhSjzjgLAWc2jW7XCEYZnWg+2wUKSTBsDLoyD/ee5WSHiYwVoyy4zBK8NUpVPp0mwy8zwg9jY+TH3q+RImULGianEzhpW5t622/eT/H5k0A5tzSswQopJfJXZMugG8Jiuwf95OrLSJBdlXaijHqKbfN4k7hblCIvhGLSsdagF+X83vHwuggnXFFpnjHvtJcOpp/6n8HjDEbrzkIze+yhgaYxwwBfAAYuwlWJlXaEOndWAIh6LMXnwBgUoCYIqzHoxFV2GwJJKpo+10Kx8+MA3MxssYM+YxJxCg86UZTwvTOLL1CjMdmCGlOlB4pECv3rrzwSaZhMMyyHYt23kRVr3A1qGQng4xx98deWhGDtmOuy4UQ47upUw/uqyLHR7H4kmUHaSyt1qabAMA4fx/Xko0cf4MPz2TIWUpm7mmxbipdN+VyDf9eix04DvUNMKWZAMO4cp65tBsFyDzAaiaoGQDFhAwR4oTP6bgN7qH2QhnMsGqTTcKcMWFMjbN8uUZrzYCJLT5qLclQyOAgSsOmC9yNb+8mTfrQL7SgjuHMQysPIy7ArnLull/jdxBDeX77GEKB8u+eFcQsMb1IbJgymBPDWu5hW4NR/z2+jFOZESoh+xmRC2/ov48yjmkayE2mZJn7kFoiCi5n08BaI6Yp8=
X-Forefront-Antispam-Report: 
	CIP:8.62.32.50;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:ejcrelay005p.adwin.renesas.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(23010399003)(36860700016)(376014)(22082099003)(18002099003)(56012099006)(10067099003)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	zGm7Ydsh+lZUxtUucJJJUQbbxPaTRFCOq8OOxaFbeoTKH+nu8v+nlZqQEJVYwXY5BEsK7EkcxyCsvH//KBGMfxeBjBMiIEJYrYrXj79+9vDsKl8vJ5spx5aW0Rl3XXpn4s/Qpm2PMIMaZNuvzl5v5iwqNaJwdrmd04EB+cgAJ7nuEISKl/rxe/V4Bwj4Qlu/7toZiUXcOJe07hX3XZ1sHuGkQ+mH8lX2jCLVfFfgHm/cUKUI8BLeQRK20oFU/w5WbQlRK+chY9Bxmo9ONqW8+R/0cl1ITXW5ZJ4O1s5vnA7gYr3XMXyBFXlT+upCOlq5DOIjdrZypW5FbSDUolxxhZEjveh/oWsFx2br224eNh1ghpcyfIAAx8Bd4YQS5whE1ZAGjDUbURLJAHy9UXO8Z0eyTXNTqbJIpAlwlWAJSD27SjWe2hSdojbJHGpQEa4k
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Sep 2026 08:11:46.5348
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: aeb39f78-99e4-4bf5-704b-08df0fdc52c8
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=53d82571-da19-47e4-9cb4-625a166a4a2a;Ip=[8.62.32.50];Helo=[ejcrelay005p.adwin.renesas.com]
X-MS-Exchange-CrossTenant-AuthSource: OS1PEPF0000D20D.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS7PR01MB11807
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 11 Sep 2026 08:11:53 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/24124

From: Cosmin Tanislav <cosmin-gabriel.tanislav.xa@renesas.com>

commit 50f51092bff57a143906a428056ff103fa75ef21 upstream.

The Renesas RZ/T2H (R9A09G077) SoC has three instances of the DMAC IP.

Add support for them.

Signed-off-by: Cosmin Tanislav <cosmin-gabriel.tanislav.xa@renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Link: https://patch.msgid.link/20251205151254.2970669-6-cosmin-gabriel.tani=
slav.xa@renesas.com
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
 arch/arm64/boot/dts/renesas/r9a09g077.dtsi | 90 ++++++++++++++++++++++
 1 file changed, 90 insertions(+)

diff --git a/arch/arm64/boot/dts/renesas/r9a09g077.dtsi b/arch/arm64/boot/d=
ts/renesas/r9a09g077.dtsi
index 00a1ef6ac7df7..0cc16bac5dbb2 100644
--- a/arch/arm64/boot/dts/renesas/r9a09g077.dtsi
+++ b/arch/arm64/boot/dts/renesas/r9a09g077.dtsi
@@ -402,6 +402,96 @@ i2c2: i2c@81008000 {
 			status =3D "disabled";
 		};
=20
+		dmac0: dma-controller@800c0000 {
+			compatible =3D "renesas,r9a09g077-dmac";
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
+			clocks =3D <&cpg CPG_CORE R9A09G077_CLK_PCLKH>;
+			power-domains =3D <&cpg>;
+			#dma-cells =3D <1>;
+			dma-channels =3D <16>;
+			renesas,icu =3D <&icu 0>;
+		};
+
+		dmac1: dma-controller@800c1000 {
+			compatible =3D "renesas,r9a09g077-dmac";
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
+			clocks =3D <&cpg CPG_CORE R9A09G077_CLK_PCLKH>;
+			power-domains =3D <&cpg>;
+			#dma-cells =3D <1>;
+			dma-channels =3D <16>;
+			renesas,icu =3D <&icu 1>;
+		};
+
+		dmac2: dma-controller@800c2000 {
+			compatible =3D "renesas,r9a09g077-dmac";
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
+			clocks =3D <&cpg CPG_CORE R9A09G077_CLK_PCLKH>;
+			power-domains =3D <&cpg>;
+			#dma-cells =3D <1>;
+			dma-channels =3D <16>;
+			renesas,icu =3D <&icu 2>;
+		};
+
 		gmac0: ethernet@80100000 {
 			compatible =3D "renesas,r9a09g077-gbeth", "snps,dwmac-5.20";
 			reg =3D <0 0x80100000 0 0x10000>;
--=20
2.43.0


