Return-Path: <prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6CB7F506FB
	for <webhook@archiver.kernel.org>; Mon, 16 Mar 2026 14:59:45 +0000 (UTC)
Received: from relmlie5.idc.renesas.com (relmlie5.idc.renesas.com [210.160.252.171])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.52440.1773673159009042004
 for <cip-dev@lists.cip-project.org>;
 Mon, 16 Mar 2026 07:59:42 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: bp.renesas.com, ip: 210.160.252.171, mailfrom: prabhakar.mahadev-lad.rj@bp.renesas.com)
X-CSE-ConnectionGUID: rTCoi9mnSxCm9m5CZ1Y5Lg==
X-CSE-MsgGUID: Ga1gYuznRvWDcnfcczgCKQ==
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie5.idc.renesas.com with ESMTP; 16 Mar 2026 23:59:42 +0900
Received: from Ubuntu-22.. (unknown [10.24.0.53])
	by relmlir6.idc.renesas.com (Postfix) with ESMTP id 07ABE41B781C;
	Mon, 16 Mar 2026 23:59:40 +0900 (JST)
From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro.iwamatsu.x90@mail.toshiba>,
	Pavel Machek <pavel@nabladev.com>
Cc: Biju Das <biju.das.jz@bp.renesas.com>
Subject: [PATCH 6.12.y-cip 14/35] arm64: dts: renesas: r9a09g077: Add USB2.0 support
Date: Mon, 16 Mar 2026 14:58:51 +0000
Message-ID: <20260316145915.8580-15-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260316145915.8580-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20260316145915.8580-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 16 Mar 2026 14:59:45 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/22406

commit a777631037d0f5e55d50e59e5f2179381eb91fbb upstream.

Add EHCI, OHCI, PHY and HSUSB nodes to RZ/T2H (R9A09G077) SoC DTSI.

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Link: https://lore.kernel.org/20250821161946.1096033-5-prabhakar.mahadev-lad.rj@bp.renesas.com
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
[PL: resolve merge conflict]
Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
 arch/arm64/boot/dts/renesas/r9a09g077.dtsi | 47 ++++++++++++++++++++++
 1 file changed, 47 insertions(+)

diff --git a/arch/arm64/boot/dts/renesas/r9a09g077.dtsi b/arch/arm64/boot/dts/renesas/r9a09g077.dtsi
index 2c9bff718cbc..2f5625c34539 100644
--- a/arch/arm64/boot/dts/renesas/r9a09g077.dtsi
+++ b/arch/arm64/boot/dts/renesas/r9a09g077.dtsi
@@ -437,6 +437,53 @@ adc2: adc@80008000 {
 			status = "disabled";
 		};
 
+		ohci: usb@92040000 {
+			compatible = "generic-ohci";
+			reg = <0 0x92040000 0 0x100>;
+			interrupts = <GIC_SPI 586 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&cpg CPG_MOD 408>;
+			phys = <&usb2_phy 1>;
+			phy-names = "usb";
+			power-domains = <&cpg>;
+			status = "disabled";
+		};
+
+		ehci: usb@92040100 {
+			compatible = "generic-ehci";
+			reg = <0 0x92040100 0 0x100>;
+			interrupts = <GIC_SPI 586 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&cpg CPG_MOD 408>;
+			phys = <&usb2_phy 2>;
+			phy-names = "usb";
+			companion = <&ohci>;
+			power-domains = <&cpg>;
+			status = "disabled";
+		};
+
+		usb2_phy: usb-phy@92040200 {
+			compatible = "renesas,usb2-phy-r9a09g077";
+			reg = <0 0x92040200 0 0x700>;
+			interrupts = <GIC_SPI 586 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&cpg CPG_MOD 408>,
+				 <&cpg CPG_CORE R9A09G077_USB_CLK>;
+			#phy-cells = <1>;
+			power-domains = <&cpg>;
+			status = "disabled";
+		};
+
+		hsusb: usb@92041000 {
+			compatible = "renesas,usbhs-r9a09g077";
+			reg = <0 0x92041000 0 0x1000>;
+			interrupts = <GIC_SPI 587 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 588 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 589 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&cpg CPG_MOD 408>;
+			phys = <&usb2_phy 3>;
+			phy-names = "usb";
+			power-domains = <&cpg>;
+			status = "disabled";
+		};
+
 		sdhi0: mmc@92080000  {
 			compatible = "renesas,sdhi-r9a09g077",
 				     "renesas,sdhi-r9a09g057";
-- 
2.43.0


