Return-Path: <biju.das.jz@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96CA0CA0FF8
	for <webhook@archiver.kernel.org>; Tue,  5 Sep 2023 16:08:13 +0000 (UTC)
Received: from relmlie6.idc.renesas.com (relmlie6.idc.renesas.com [210.160.252.172])
 by mx.groups.io with SMTP id smtpd.web10.25755.1693930073342141470
 for <cip-dev@lists.cip-project.org>;
 Tue, 05 Sep 2023 09:08:07 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: bp.renesas.com, ip: 210.160.252.172, mailfrom: biju.das.jz@bp.renesas.com)
X-IronPort-AV: E=Sophos;i="6.02,229,1688396400"; 
   d="scan'208";a="178810989"
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie6.idc.renesas.com with ESMTP; 06 Sep 2023 01:08:06 +0900
Received: from localhost.localdomain (unknown [10.226.92.194])
	by relmlir6.idc.renesas.com (Postfix) with ESMTP id E27A0401D174;
	Wed,  6 Sep 2023 01:08:04 +0900 (JST)
From: Biju Das <biju.das.jz@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
Cc: Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH 6.1.y-cip 11/20] arm64: dts: renesas: r9a07g054: Add DSI node
Date: Tue,  5 Sep 2023 17:07:28 +0100
Message-Id: <20230905160737.167877-12-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230905160737.167877-1-biju.das.jz@bp.renesas.com>
References: <20230905160737.167877-1-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 05 Sep 2023 16:08:13 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/12953

commit 33de13da4e2df73daeb38f94f2771a5ae031947d upstream.

Add DSI node to RZ/V2L SoC DTSI.

Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Link: https://lore.kernel.org/r/20230411100346.299768-7-biju.das.jz@bp.renesas.com
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
 arch/arm64/boot/dts/renesas/r9a07g054.dtsi | 28 ++++++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/arch/arm64/boot/dts/renesas/r9a07g054.dtsi b/arch/arm64/boot/dts/renesas/r9a07g054.dtsi
index 205299641b6d..43ef79322803 100644
--- a/arch/arm64/boot/dts/renesas/r9a07g054.dtsi
+++ b/arch/arm64/boot/dts/renesas/r9a07g054.dtsi
@@ -693,6 +693,34 @@ sbc: spi@10060000 {
 			status = "disabled";
 		};
 
+		dsi: dsi@10850000 {
+			compatible = "renesas,r9a07g054-mipi-dsi",
+				     "renesas,rzg2l-mipi-dsi";
+			reg = <0 0x10850000 0 0x20000>;
+			interrupts = <GIC_SPI 142 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 143 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 144 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 145 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 146 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 147 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 148 IRQ_TYPE_LEVEL_HIGH>;
+			interrupt-names = "seq0", "seq1", "vin1", "rcv",
+					  "ferr", "ppi", "debug";
+			clocks = <&cpg CPG_MOD R9A07G054_MIPI_DSI_PLLCLK>,
+				 <&cpg CPG_MOD R9A07G054_MIPI_DSI_SYSCLK>,
+				 <&cpg CPG_MOD R9A07G054_MIPI_DSI_ACLK>,
+				 <&cpg CPG_MOD R9A07G054_MIPI_DSI_PCLK>,
+				 <&cpg CPG_MOD R9A07G054_MIPI_DSI_VCLK>,
+				 <&cpg CPG_MOD R9A07G054_MIPI_DSI_LPCLK>;
+			clock-names = "pllclk", "sysclk", "aclk", "pclk", "vclk", "lpclk";
+			resets = <&cpg R9A07G054_MIPI_DSI_CMN_RSTB>,
+				 <&cpg R9A07G054_MIPI_DSI_ARESET_N>,
+				 <&cpg R9A07G054_MIPI_DSI_PRESET_N>;
+			reset-names = "rst", "arst", "prst";
+			power-domains = <&cpg>;
+			status = "disabled";
+		};
+
 		vspd: vsp@10870000 {
 			compatible = "renesas,r9a07g054-vsp2",
 				     "renesas,r9a07g044-vsp2";
-- 
2.25.1


