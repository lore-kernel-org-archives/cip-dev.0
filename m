Return-Path: <prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56CEBE6B277
	for <webhook@archiver.kernel.org>; Fri,  1 Nov 2024 12:58:55 +0000 (UTC)
Received: from relmlie5.idc.renesas.com (relmlie5.idc.renesas.com [210.160.252.171])
 by mx.groups.io with SMTP id smtpd.web11.36928.1730465925329956404
 for <cip-dev@lists.cip-project.org>;
 Fri, 01 Nov 2024 05:58:46 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: bp.renesas.com, ip: 210.160.252.171, mailfrom: prabhakar.mahadev-lad.rj@bp.renesas.com)
X-IronPort-AV: E=Sophos;i="6.11,249,1725289200"; 
   d="scan'208";a="223655356"
Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie5.idc.renesas.com with ESMTP; 01 Nov 2024 21:58:44 +0900
Received: from Ubuntu-22.. (unknown [10.226.92.182])
	by relmlir5.idc.renesas.com (Postfix) with ESMTP id B9A184009F99;
	Fri,  1 Nov 2024 21:58:37 +0900 (JST)
From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
Cc: Biju Das <biju.das.jz@bp.renesas.com>
Subject: [PATCH v2 5.10.y-cip 26/28] arm64: dts: renesas: r9a07g054: Add CSI and CRU nodes
Date: Fri,  1 Nov 2024 12:57:44 +0000
Message-ID: <20241101125746.33222-27-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241101125746.33222-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20241101125746.33222-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 01 Nov 2024 12:58:55 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/17161

commit a3c95a54727a81a4f3bd65b05c2e8542b2821ec3 upstream.

Add CSI and CRU nodes to r9a07g054 (RZ/V2L) SoC DTSI.

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Link: https://lore.kernel.org/r/20230412185608.64628-2-prabhakar.mahadev-lad.rj@bp.renesas.com
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
 arch/arm64/boot/dts/renesas/r9a07g054.dtsi | 79 ++++++++++++++++++++++
 1 file changed, 79 insertions(+)

diff --git a/arch/arm64/boot/dts/renesas/r9a07g054.dtsi b/arch/arm64/boot/dts/renesas/r9a07g054.dtsi
index a5c3a68c1e011..4417135c51342 100644
--- a/arch/arm64/boot/dts/renesas/r9a07g054.dtsi
+++ b/arch/arm64/boot/dts/renesas/r9a07g054.dtsi
@@ -692,6 +692,85 @@ sbc: spi@10060000 {
 			status = "disabled";
 		};
 
+		cru: video@10830000 {
+			compatible = "renesas,r9a07g054-cru", "renesas,rzg2l-cru";
+			reg = <0 0x10830000 0 0x400>;
+			clocks = <&cpg CPG_MOD R9A07G054_CRU_VCLK>,
+				 <&cpg CPG_MOD R9A07G054_CRU_PCLK>,
+				 <&cpg CPG_MOD R9A07G054_CRU_ACLK>;
+			clock-names = "video", "apb", "axi";
+			interrupts = <GIC_SPI 167 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 168 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 169 IRQ_TYPE_LEVEL_HIGH>;
+			interrupt-names = "image_conv", "image_conv_err", "axi_mst_err";
+			resets = <&cpg R9A07G054_CRU_PRESETN>,
+				 <&cpg R9A07G054_CRU_ARESETN>;
+			reset-names = "presetn", "aresetn";
+			power-domains = <&cpg>;
+			status = "disabled";
+
+			ports {
+				#address-cells = <1>;
+				#size-cells = <0>;
+
+				port@0 {
+					#address-cells = <1>;
+					#size-cells = <0>;
+
+					reg = <0>;
+					cruparallel: endpoint@0 {
+						reg = <0>;
+					};
+				};
+
+				port@1 {
+					#address-cells = <1>;
+					#size-cells = <0>;
+
+					reg = <1>;
+					crucsi2: endpoint@0 {
+						reg = <0>;
+						remote-endpoint = <&csi2cru>;
+					};
+				};
+			};
+		};
+
+		csi2: csi2@10830400 {
+			compatible = "renesas,r9a07g054-csi2", "renesas,rzg2l-csi2";
+			reg = <0 0x10830400 0 0xfc00>;
+			interrupts = <GIC_SPI 166 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&cpg CPG_MOD R9A07G054_CRU_SYSCLK>,
+				 <&cpg CPG_MOD R9A07G054_CRU_VCLK>,
+				 <&cpg CPG_MOD R9A07G054_CRU_PCLK>;
+			clock-names = "system", "video", "apb";
+			resets = <&cpg R9A07G054_CRU_PRESETN>,
+				 <&cpg R9A07G054_CRU_CMN_RSTB>;
+			reset-names = "presetn", "cmn-rstb";
+			power-domains = <&cpg>;
+			status = "disabled";
+
+			ports {
+				#address-cells = <1>;
+				#size-cells = <0>;
+
+				port@0 {
+					reg = <0>;
+				};
+
+				port@1 {
+					#address-cells = <1>;
+					#size-cells = <0>;
+					reg = <1>;
+
+					csi2cru: endpoint@0 {
+						reg = <0>;
+						remote-endpoint = <&crucsi2>;
+					};
+				};
+			};
+		};
+
 		dsi: dsi@10850000 {
 			compatible = "renesas,r9a07g054-mipi-dsi",
 				     "renesas,rzg2l-mipi-dsi";
-- 
2.43.0


