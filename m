Return-Path: <biju.das.jz@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1C2AC52D6F
	for <webhook@archiver.kernel.org>; Mon,  5 Aug 2024 16:44:48 +0000 (UTC)
Received: from relmlie5.idc.renesas.com (relmlie5.idc.renesas.com [210.160.252.171])
 by mx.groups.io with SMTP id smtpd.web10.12833.1722876276339708400
 for <cip-dev@lists.cip-project.org>;
 Mon, 05 Aug 2024 09:44:40 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: bp.renesas.com, ip: 210.160.252.171, mailfrom: biju.das.jz@bp.renesas.com)
X-IronPort-AV: E=Sophos;i="6.09,265,1716217200"; 
   d="scan'208";a="214739946"
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie5.idc.renesas.com with ESMTP; 06 Aug 2024 01:44:39 +0900
Received: from localhost.localdomain (unknown [10.226.92.197])
	by relmlir6.idc.renesas.com (Postfix) with ESMTP id 56AEF40213EE;
	Tue,  6 Aug 2024 01:44:38 +0900 (JST)
From: Biju Das <biju.das.jz@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
Cc: Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH 6.1.y-cip 26/30] arm64: dts: renesas: r9a07g043u: Add CSI and CRU nodes
Date: Mon,  5 Aug 2024 17:43:19 +0100
Message-ID: <20240805164342.211857-27-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240805164342.211857-1-biju.das.jz@bp.renesas.com>
References: <20240805164342.211857-1-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 05 Aug 2024 16:44:48 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/16748

commit 971c17f879352adc719ff215e0769f8e0a49d7c4 upstream.

Add CSI and CRU nodes r9a07g043 (RZ/G2UL) SoC DTSI.

Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Link: https://lore.kernel.org/r/20240126133116.121981-4-biju.das.jz@bp.renesas.com
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
 arch/arm64/boot/dts/renesas/r9a07g043u.dtsi | 69 +++++++++++++++++++++
 1 file changed, 69 insertions(+)

diff --git a/arch/arm64/boot/dts/renesas/r9a07g043u.dtsi b/arch/arm64/boot/dts/renesas/r9a07g043u.dtsi
index 427c0746f235..d1b6f5c63bbd 100644
--- a/arch/arm64/boot/dts/renesas/r9a07g043u.dtsi
+++ b/arch/arm64/boot/dts/renesas/r9a07g043u.dtsi
@@ -56,6 +56,75 @@ timer {
 &soc {
 	interrupt-parent = <&gic>;
 
+	cru: video@10830000 {
+		compatible = "renesas,r9a07g043-cru", "renesas,rzg2l-cru";
+		reg = <0 0x10830000 0 0x400>;
+		clocks = <&cpg CPG_MOD R9A07G043_CRU_VCLK>,
+			 <&cpg CPG_MOD R9A07G043_CRU_PCLK>,
+			 <&cpg CPG_MOD R9A07G043_CRU_ACLK>;
+		clock-names = "video", "apb", "axi";
+		interrupts = <SOC_PERIPHERAL_IRQ(167) IRQ_TYPE_LEVEL_HIGH>,
+			     <SOC_PERIPHERAL_IRQ(168) IRQ_TYPE_LEVEL_HIGH>,
+			     <SOC_PERIPHERAL_IRQ(169) IRQ_TYPE_LEVEL_HIGH>;
+		interrupt-names = "image_conv", "image_conv_err", "axi_mst_err";
+		resets = <&cpg R9A07G043_CRU_PRESETN>,
+			 <&cpg R9A07G043_CRU_ARESETN>;
+		reset-names = "presetn", "aresetn";
+		power-domains = <&cpg>;
+		status = "disabled";
+
+		ports {
+			#address-cells = <1>;
+			#size-cells = <0>;
+
+			port@1 {
+				#address-cells = <1>;
+				#size-cells = <0>;
+
+				reg = <1>;
+				crucsi2: endpoint@0 {
+					reg = <0>;
+					remote-endpoint = <&csi2cru>;
+				};
+			};
+		};
+	};
+
+	csi2: csi2@10830400 {
+		compatible = "renesas,r9a07g043-csi2", "renesas,rzg2l-csi2";
+		reg = <0 0x10830400 0 0xfc00>;
+		interrupts = <SOC_PERIPHERAL_IRQ(166) IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&cpg CPG_MOD R9A07G043_CRU_SYSCLK>,
+			 <&cpg CPG_MOD R9A07G043_CRU_VCLK>,
+			 <&cpg CPG_MOD R9A07G043_CRU_PCLK>;
+		clock-names = "system", "video", "apb";
+		resets = <&cpg R9A07G043_CRU_PRESETN>,
+			 <&cpg R9A07G043_CRU_CMN_RSTB>;
+		reset-names = "presetn", "cmn-rstb";
+		power-domains = <&cpg>;
+		status = "disabled";
+
+		ports {
+			#address-cells = <1>;
+			#size-cells = <0>;
+
+			port@0 {
+				reg = <0>;
+			};
+
+			port@1 {
+				#address-cells = <1>;
+				#size-cells = <0>;
+				reg = <1>;
+
+				csi2cru: endpoint@0 {
+					reg = <0>;
+					remote-endpoint = <&crucsi2>;
+				};
+			};
+		};
+	};
+
 	irqc: interrupt-controller@110a0000 {
 		compatible = "renesas,r9a07g043u-irqc",
 			     "renesas,rzg2l-irqc";
-- 
2.43.0


