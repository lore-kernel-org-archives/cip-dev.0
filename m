Return-Path: <biju.das.jz@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD04CC27C79
	for <webhook@archiver.kernel.org>; Fri, 14 Jun 2024 10:19:08 +0000 (UTC)
Received: from relmlie6.idc.renesas.com (relmlie6.idc.renesas.com [210.160.252.172])
 by mx.groups.io with SMTP id smtpd.web11.8374.1718360341318683626
 for <cip-dev@lists.cip-project.org>;
 Fri, 14 Jun 2024 03:19:01 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: bp.renesas.com, ip: 210.160.252.172, mailfrom: biju.das.jz@bp.renesas.com)
X-IronPort-AV: E=Sophos;i="6.08,237,1712588400"; 
   d="scan'208";a="211896721"
Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie6.idc.renesas.com with ESMTP; 14 Jun 2024 19:19:00 +0900
Received: from localhost.localdomain (unknown [10.226.92.95])
	by relmlir5.idc.renesas.com (Postfix) with ESMTP id EA221401C57A;
	Fri, 14 Jun 2024 19:18:58 +0900 (JST)
From: Biju Das <biju.das.jz@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
Cc: Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH 6.1.y-cip 5/8] arm64: dts: renesas: r9a07g044: Add DU node
Date: Fri, 14 Jun 2024 11:18:42 +0100
Message-Id: <20240614101845.40656-6-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240614101845.40656-1-biju.das.jz@bp.renesas.com>
References: <20240614101845.40656-1-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 14 Jun 2024 10:19:08 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/16253

commit 4b15a38590f66da7e238a919242b69a235a261ec upstream.

Add DU node to RZ/G2L SoC DTSI.

Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Link: https://lore.kernel.org/r/20240222132117.137729-2-biju.das.jz@bp.renesas.com
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
 arch/arm64/boot/dts/renesas/r9a07g044.dtsi | 27 ++++++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/arch/arm64/boot/dts/renesas/r9a07g044.dtsi b/arch/arm64/boot/dts/renesas/r9a07g044.dtsi
index 52958dbfa950..6e57bbb25c83 100644
--- a/arch/arm64/boot/dts/renesas/r9a07g044.dtsi
+++ b/arch/arm64/boot/dts/renesas/r9a07g044.dtsi
@@ -741,6 +741,33 @@ fcpvd: fcp@10880000 {
 			resets = <&cpg R9A07G044_LCDC_RESET_N>;
 		};
 
+		du: display@10890000 {
+			compatible = "renesas,r9a07g044-du";
+			reg = <0 0x10890000 0 0x10000>;
+			interrupts = <GIC_SPI 152 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&cpg CPG_MOD R9A07G044_LCDC_CLK_A>,
+				 <&cpg CPG_MOD R9A07G044_LCDC_CLK_P>,
+				 <&cpg CPG_MOD R9A07G044_LCDC_CLK_D>;
+			clock-names = "aclk", "pclk", "vclk";
+			power-domains = <&cpg>;
+			resets = <&cpg R9A07G044_LCDC_RESET_N>;
+			renesas,vsps = <&vspd 0>;
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
+					reg = <1>;
+				};
+			};
+		};
+
 		cpg: clock-controller@11010000 {
 			compatible = "renesas,r9a07g044-cpg";
 			reg = <0 0x11010000 0 0x10000>;
-- 
2.25.1


