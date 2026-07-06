Return-Path: <prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3AB66C43602
	for <webhook@archiver.kernel.org>; Mon,  6 Jul 2026 18:23:54 +0000 (UTC)
Received: from TYVP286CU001.outbound.protection.outlook.com (TYVP286CU001.outbound.protection.outlook.com [52.101.125.5])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.156748.1783362225941983809
 for <cip-dev@lists.cip-project.org>;
 Mon, 06 Jul 2026 11:23:46 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@bp.renesas.com header.s=selector1 header.b=japk358T;
 spf=pass (domain: bp.renesas.com, ip: 52.101.125.5, mailfrom: prabhakar.mahadev-lad.rj@bp.renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=F3jPEmCRLKRlLhZLKpVx2ZEkZuccqSLP8gk17vafXB1VZWZsbCcZIRQcmxA1xpUYl8BfCVf9uzjJN5E59WDWWooKgf7YwuUI1fmokY2sqD2kzhVoR/BtHcKZOZXWkPJ5xfnR7810FZmyCUQcVa4Ah6XBCMmZMa8NCtxv4bxi1roj5Vm+zsp1kmsfYkbp/GEjhmdeaU7qr8F3miATqs6+5BBKts/HbRT/BNp7KhYIwi48/EGqDFACkPou59RkMPuT8LeMSCA1faBeSAuVxCs6lvRWDEK3J7913JWIKj/ylLppHvzCzSXWo6xuSsSwIix0bfMlV1xDiSwf8baBrwT1vg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YzAEp25k+38cewLYL/yn5Tcbv+Y1X2PJBL8V4sTbGQM=;
 b=EIGijGEyF8lBomx59gccyT24iV+giycVFwncLwHe3rQPaQobOdgZpgibi7959ZcMk19uWPlGh2wyF9nIRzBWa5DZWjuYCWnwnhPbiKEo6XvJqnMLT38JVhtfg+uV3ZjBF6Q7v1dCUcNPJbNgl7xhfPUl1aAeT774ivqKlzaWt+SlOcWGhDPlYTob9GHi7DHbu8avXP73DDffpkx5QTVpcXph44mMuv71RiYckEMpLpKG2LvedkMz9v1kDu8PBXmSFq3dpfWEu6tGl6hMDBqViflf5oZjC+RqaUb1eTcVVvQXapnYWBqmY5p072aGuQUezp3p1I1XS4zmnR0gxNDCLQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 8.62.32.50) smtp.rcpttodomain=bp.renesas.com smtp.mailfrom=bp.renesas.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=bp.renesas.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YzAEp25k+38cewLYL/yn5Tcbv+Y1X2PJBL8V4sTbGQM=;
 b=japk358Tqhp5jCQPndJCxHOvr8niYz+iNRip2g8znMWsrYBrB81wUJVS3i/paun5QfJYJnnMjxteDmEYfYqAiT8uJmgdTRecFdSGd63NpwpGcCtEr8b/k0ewVlyMk8vicrgKge7jCFaDia0GDwp4SGR3Sp2V2XFlTSI0/JEpZ/w=
Received: from TYCP286CA0277.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:3c9::7)
 by TYWPR01MB9543.jpnprd01.prod.outlook.com (2603:1096:400:1a6::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.11; Mon, 6 Jul
 2026 18:23:42 +0000
Received: from TYO1EPF00005026.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:3c9:cafe::41) by TYCP286CA0277.outlook.office365.com
 (2603:1096:400:3c9::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.181.13 via Frontend Transport; Mon, 6
 Jul 2026 18:23:42 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 8.62.32.50)
 smtp.mailfrom=bp.renesas.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=bp.renesas.com;
Received-SPF: Pass (protection.outlook.com: domain of bp.renesas.com
 designates 8.62.32.50 as permitted sender) receiver=protection.outlook.com;
 client-ip=8.62.32.50; helo=ejcrelay004p.adwin.renesas.com; pr=E
Received: from ejcrelay004p.adwin.renesas.com (8.62.32.50) by
 TYO1EPF00005026.mail.protection.outlook.com (10.167.240.23) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.181.6
 via Frontend Transport; Mon, 6 Jul 2026 18:23:41 +0000
Received: from Ubuntu-22.. (ed-eng-lt-ism.diasemi.com [10.24.0.36])
	by ejcrelay004p.adwin.renesas.com (Postfix) with ESMTP id 83E6E3000152;
	Tue,  7 Jul 2026 03:23:40 +0900 (JST)
From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro.iwamatsu.x90@mail.toshiba>,
	Pavel Machek <pavel@nabladev.com>
CC: Biju Das <biju.das.jz@bp.renesas.com>
Subject: [PATCH 6.12.y-cip 6/8] arm64: dts: renesas: r9a09g077: Add xSPI nodes
Date: Mon,  6 Jul 2026 19:23:26 +0100
Message-ID: <20260706182328.5237-7-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260706182328.5237-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20260706182328.5237-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYO1EPF00005026:EE_|TYWPR01MB9543:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 29aaab1e-ef69-4f9a-b4cd-08dedb8bb526
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|36860700016|376014|1800799024|23010399003|82310400026|22082099003|18002099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info: 
	6WLN8kaqU8vG4QQOpWKOelj+KgmC2Wu6K0f0nnn/sMlLuIbueg4QgCCAp8QfHncY5sjWpJVHxXpd9bHTBwWV4EajHT8dRjSI4Zq++d4K5jn6b0qvvgx8PYSwnTGV7FVEvULBJgC5lR4DXTZcXlUgTNMDWDea2JwXXv7EYZOl1pFha0RMj198/mxHIb+ryOg2tealcYZ41gce4V0Nwidy+qaryDFxI9XZLoXPUXia2j0zZ6sfGJiADaEtmEpI9QNviEsmpHsLMM/24IvoJAqfFSMXWbIL+fLlLRW+pbd9sYSZtXUWKdLJeeJqd0Xc2w5/PdptRNtv7Mkr3RNsVbWeacQSXu7V+pbol0jw9+inOsSUsf2k3zXC+1JlcEcCVbqBtg/H3egM6nTZEWKT6odlZMN9rYRgXDR+Ju9VkWABcd3UfXZYzs7JaUb5nM4qfXPBusrGJuBqnSYZHPF/s207+sw8AGnN9dMy7nnP+fvtOO+2cfqxNfbpjX77ptQJjn+j58HgtK5YMFvCH9/FuRiD15SqRaMRN9OD7q+jmyYDTwKvHy+k90WcGvE7cDpwdGr3rfq+R5BR0eLeS8fWF81lnhhjPOBdBrdYv5aj7arH/z0aVe8xQIiPslh5uCcvr21eo8K9Q54yhNYLG+lXtl2OHzks/5DZvEdrV6ZzBlVI5X8=
X-Forefront-Antispam-Report: 
	CIP:8.62.32.50;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:ejcrelay004p.adwin.renesas.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700016)(376014)(1800799024)(23010399003)(82310400026)(22082099003)(18002099003)(56012099006)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	jYC2YgiAgm5ULVt3WEw4O87RWfFSjo87NNXulX/73/HTtJ2hNfC5SfZmFQXqRp3V/XXWci+5D+CCPiMENMrlKQWwatSaroRtN1JloCGvSVli1uUt75964MxLuAvJIzJx+Ofqq1xf5H1iAvI5O3oSVpL/86k2fIm8V2Dik0KkEfUHC7Vd88CBtSxtGeJtf6njMMzjf4ShO+ZZGpl+ptvznwLxJVTxoBoCi7J30ThbE4g/6p13jFKv6jHeNkgt+DQvKbhFX6qrFl3GIYpdwzh9clJtJU0xfu4Ct0gCfMHeSls8HcYJWF9ooh0sp10Y1e7L4hp9HbHZdXgHB/Xa5riDP+7fqisbhbf8VKS+GqzPpQ8dxFE9MUpQGIxAoLMnYMkFkhR/VLhPsEGAvCKfX9xdK7305K9pT8i95yYd8KYAnHY74JjSin1k+s4Y4s2eOzSH
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jul 2026 18:23:41.8835
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 29aaab1e-ef69-4f9a-b4cd-08dedb8bb526
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=53d82571-da19-47e4-9cb4-625a166a4a2a;Ip=[8.62.32.50];Helo=[ejcrelay004p.adwin.renesas.com]
X-MS-Exchange-CrossTenant-AuthSource: TYO1EPF00005026.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYWPR01MB9543
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 06 Jul 2026 18:23:54 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/23468

commit f0b0d1658a23560efb9e0aef012898c5c59dc447 upstream.

Add device tree nodes for the two xSPI (Expanded SPI) controllers
integrated into the RZ/T2H (R9A09G077) SoC.

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Link: https://patch.msgid.link/20260526204045.3481604-2-prabhakar.mahadev-l=
ad.rj@bp.renesas.com
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
 arch/arm64/boot/dts/renesas/r9a09g077.dtsi | 40 ++++++++++++++++++++++
 1 file changed, 40 insertions(+)

diff --git a/arch/arm64/boot/dts/renesas/r9a09g077.dtsi b/arch/arm64/boot/d=
ts/renesas/r9a09g077.dtsi
index 3c6e6969026d..fd0b7e082721 100644
--- a/arch/arm64/boot/dts/renesas/r9a09g077.dtsi
+++ b/arch/arm64/boot/dts/renesas/r9a09g077.dtsi
@@ -877,6 +877,46 @@ mii_conv3: mii-conv@3 {
 			};
 		};
=20
+		xspi0: spi@801c0000 {
+			compatible =3D "renesas,r9a09g077-xspi",
+				     "renesas,r9a09g047-xspi";
+			reg =3D <0 0x801c0000 0 0x1000>,
+			      <0 0x40000000 0 0x10000000>;
+			reg-names =3D "regs", "dirmap";
+			interrupts =3D <GIC_SPI 654 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 655 IRQ_TYPE_LEVEL_HIGH>;
+			interrupt-names =3D "pulse", "err_pulse";
+			clocks =3D <&cpg CPG_MOD 4>,
+				 <&cpg CPG_CORE R9A09G077_XSPI_CLK0>;
+			clock-names =3D "ahb", "spi";
+			resets =3D <&cpg 4>;
+			reset-names =3D "hresetn";
+			power-domains =3D <&cpg>;
+			#address-cells =3D <1>;
+			#size-cells =3D <0>;
+			status =3D "disabled";
+		};
+
+		xspi1: spi@801c1000 {
+			compatible =3D "renesas,r9a09g077-xspi",
+				     "renesas,r9a09g047-xspi";
+			reg =3D <0 0x801c1000 0 0x1000>,
+			      <0 0x50000000 0 0x10000000>;
+			reg-names =3D "regs", "dirmap";
+			interrupts =3D <GIC_SPI 656 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 657 IRQ_TYPE_LEVEL_HIGH>;
+			interrupt-names =3D "pulse", "err_pulse";
+			clocks =3D <&cpg CPG_MOD 5>,
+				 <&cpg CPG_CORE R9A09G077_XSPI_CLK1>;
+			clock-names =3D "ahb", "spi";
+			resets =3D <&cpg 5>;
+			reset-names =3D "hresetn";
+			power-domains =3D <&cpg>;
+			#address-cells =3D <1>;
+			#size-cells =3D <0>;
+			status =3D "disabled";
+		};
+
 		cpg: clock-controller@80280000 {
 			compatible =3D "renesas,r9a09g077-cpg-mssr";
 			reg =3D <0 0x80280000 0 0x1000>,
--=20
2.43.0


