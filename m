Return-Path: <biju.das.jz@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A07D9CA0EDC
	for <webhook@archiver.kernel.org>; Wed, 20 Aug 2025 08:47:50 +0000 (UTC)
Received: from relmlie5.idc.renesas.com (relmlie5.idc.renesas.com [210.160.252.171])
 by mx.groups.io with SMTP id smtpd.web11.15483.1755679656199304806
 for <cip-dev@lists.cip-project.org>;
 Wed, 20 Aug 2025 01:47:42 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: bp.renesas.com, ip: 210.160.252.171, mailfrom: biju.das.jz@bp.renesas.com)
X-CSE-ConnectionGUID: yME5pyfJSxqfnklsppxd1g==
X-CSE-MsgGUID: tYKALIahTe+uKyg0y4g16w==
Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie5.idc.renesas.com with ESMTP; 20 Aug 2025 17:47:42 +0900
Received: from localhost.localdomain (unknown [10.226.92.43])
	by relmlir5.idc.renesas.com (Postfix) with ESMTP id 5917340138ED;
	Wed, 20 Aug 2025 17:47:40 +0900 (JST)
From: Biju Das <biju.das.jz@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
Cc: Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH 6.12.y-cip 22/23] arm64: dts: renesas: r9a09g047: Add XSPI node
Date: Wed, 20 Aug 2025 09:46:08 +0100
Message-ID: <20250820084645.6988-23-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250820084645.6988-1-biju.das.jz@bp.renesas.com>
References: <20250820084645.6988-1-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 20 Aug 2025 08:47:50 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/19817

commit 348da7b1cf0c5a7f2081ff42e969baf0c84da4e7 upstream.

Add XSPI node to RZ/G3E ("R9A09G047") SoC DTSI.

Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Link: https://lore.kernel.org/20250508183109.137721-2-biju.das.jz@bp.renesas.com
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
 arch/arm64/boot/dts/renesas/r9a09g047.dtsi | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/arch/arm64/boot/dts/renesas/r9a09g047.dtsi b/arch/arm64/boot/dts/renesas/r9a09g047.dtsi
index 876f70fed433f..3d3aa371dad86 100644
--- a/arch/arm64/boot/dts/renesas/r9a09g047.dtsi
+++ b/arch/arm64/boot/dts/renesas/r9a09g047.dtsi
@@ -280,6 +280,27 @@ sys: system-controller@10430000 {
 			resets = <&cpg 0x30>;
 		};
 
+		xspi: spi@11030000 {
+			compatible = "renesas,r9a09g047-xspi";
+			reg = <0 0x11030000 0 0x10000>,
+			      <0 0x20000000 0 0x10000000>;
+			reg-names = "regs", "dirmap";
+			interrupts = <GIC_SPI 228 IRQ_TYPE_EDGE_RISING>,
+				     <GIC_SPI 229 IRQ_TYPE_EDGE_RISING>;
+			interrupt-names = "pulse", "err_pulse";
+			clocks = <&cpg CPG_MOD 0x9f>,
+				 <&cpg CPG_MOD 0xa0>,
+				 <&cpg CPG_CORE R9A09G047_SPI_CLK_SPI>,
+				 <&cpg CPG_MOD 0xa1>;
+			clock-names = "ahb", "axi", "spi", "spix2";
+			resets = <&cpg 0xa3>, <&cpg 0xa4>;
+			reset-names = "hresetn", "aresetn";
+			power-domains = <&cpg>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+			status = "disabled";
+		};
+
 		scif0: serial@11c01400 {
 			compatible = "renesas,scif-r9a09g047", "renesas,scif-r9a09g057";
 			reg = <0 0x11c01400 0 0x400>;
-- 
2.43.0


