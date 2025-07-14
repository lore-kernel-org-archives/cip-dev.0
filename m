Return-Path: <biju.das.jz@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13506C83F1A
	for <webhook@archiver.kernel.org>; Mon, 14 Jul 2025 10:18:11 +0000 (UTC)
Received: from relmlie5.idc.renesas.com (relmlie5.idc.renesas.com [210.160.252.171])
 by mx.groups.io with SMTP id smtpd.web11.74932.1752488286995287365
 for <cip-dev@lists.cip-project.org>;
 Mon, 14 Jul 2025 03:18:07 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: bp.renesas.com, ip: 210.160.252.171, mailfrom: biju.das.jz@bp.renesas.com)
X-CSE-ConnectionGUID: F0P938SJRrGCeHiNdIR4Jg==
X-CSE-MsgGUID: V49Ik3p4TieDL0oQ1/VTFQ==
Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie5.idc.renesas.com with ESMTP; 14 Jul 2025 19:18:06 +0900
Received: from localhost.localdomain (unknown [10.226.92.48])
	by relmlir5.idc.renesas.com (Postfix) with ESMTP id DE774400E4E4;
	Mon, 14 Jul 2025 19:18:04 +0900 (JST)
From: Biju Das <biju.das.jz@bp.renesas.com>
To: Pavel Machek <pavel@denx.de>
Cc: nobuhiro1.iwamatsu@toshiba.co.jp,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	Biju Das <biju.das.jz@bp.renesas.com>,
	cip-dev@lists.cip-project.org
Subject: [PATCH 6.12.y-cip 35/36] arm64: dts: renesas: r9a09g047e57-smarc: Enable CANFD
Date: Mon, 14 Jul 2025 11:16:35 +0100
Message-ID: <20250714101650.80381-36-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250714101650.80381-1-biju.das.jz@bp.renesas.com>
References: <20250714101650.80381-1-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 14 Jul 2025 10:18:11 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/19521

commit f2858ea240d35ed35dc87108cf8b06685e89a421 upstream.

Enable CANFD on the RZ/G3E SMARC EVK platform.

Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Link: https://lore.kernel.org/20250320164121.193857-3-biju.das.jz@bp.renesas.com
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
 .../boot/dts/renesas/r9a09g047e57-smarc.dts   | 31 +++++++++++++++++++
 .../boot/dts/renesas/renesas-smarc2.dtsi      |  4 +++
 .../boot/dts/renesas/rzg3e-smarc-som.dtsi     | 14 +++++++--
 3 files changed, 46 insertions(+), 3 deletions(-)

diff --git a/arch/arm64/boot/dts/renesas/r9a09g047e57-smarc.dts b/arch/arm64/boot/dts/renesas/r9a09g047e57-smarc.dts
index 5d7983812c701..7e1daaabce8a9 100644
--- a/arch/arm64/boot/dts/renesas/r9a09g047e57-smarc.dts
+++ b/arch/arm64/boot/dts/renesas/r9a09g047e57-smarc.dts
@@ -8,6 +8,8 @@
 /dts-v1/;
 
 /* Switch selection settings */
+#define SW_LCD_EN		0
+#define SW_PDM_EN		0
 #define SW_SD0_DEV_SEL		0
 #define SW_SDIO_M2E		0
 
@@ -33,7 +35,36 @@ vqmmc_sd1_pvdd: regulator-vqmmc-sd1-pvdd {
 	};
 };
 
+&canfd {
+	pinctrl-0 = <&canfd_pins>;
+	pinctrl-names = "default";
+
+#if (!SW_PDM_EN)
+	channel1 {
+		status = "okay";
+	};
+#endif
+
+#if (!SW_LCD_EN)
+	channel4 {
+		status = "okay";
+	};
+#endif
+};
+
 &pinctrl {
+	canfd_pins: canfd {
+		can1_pins: can1 {
+			pinmux = <RZG3E_PORT_PINMUX(L, 2, 3)>, /* RX */
+				 <RZG3E_PORT_PINMUX(L, 3, 3)>; /* TX */
+		};
+
+		can4_pins: can4 {
+			pinmux = <RZG3E_PORT_PINMUX(5, 2, 3)>, /* RX */
+				 <RZG3E_PORT_PINMUX(5, 3, 3)>; /* TX */
+		};
+	};
+
 	scif_pins: scif {
 		pins = "SCIF_TXD", "SCIF_RXD";
 		renesas,output-impedance = <1>;
diff --git a/arch/arm64/boot/dts/renesas/renesas-smarc2.dtsi b/arch/arm64/boot/dts/renesas/renesas-smarc2.dtsi
index fd82df8adc1ec..1d3a844174b37 100644
--- a/arch/arm64/boot/dts/renesas/renesas-smarc2.dtsi
+++ b/arch/arm64/boot/dts/renesas/renesas-smarc2.dtsi
@@ -29,6 +29,10 @@ aliases {
 	};
 };
 
+&canfd {
+	status = "okay";
+};
+
 &scif0 {
 	status = "okay";
 };
diff --git a/arch/arm64/boot/dts/renesas/rzg3e-smarc-som.dtsi b/arch/arm64/boot/dts/renesas/rzg3e-smarc-som.dtsi
index 051a43a7e2f0e..e9327cf9077f2 100644
--- a/arch/arm64/boot/dts/renesas/rzg3e-smarc-som.dtsi
+++ b/arch/arm64/boot/dts/renesas/rzg3e-smarc-som.dtsi
@@ -6,12 +6,20 @@
  */
 
 /*
- * Please set the switch position SYS.1 on the SoM and the corresponding macro
- * SW_SD0_DEV_SEL on the board DTS:
+ * Please set the below switch position on the SoM and the corresponding macro
+ * on the board DTS:
  *
- * SW_SD0_DEV_SEL:
+ * Switch position SYS.1, Macro SW_SD0_DEV_SEL:
  *      0 - SD0 is connected to eMMC (default)
  *      1 - SD0 is connected to uSD0 card
+ *
+ * Switch position SYS.5, Macro SW_LCD_EN:
+ *      0 - Select Misc. Signals routing
+ *      1 - Select LCD
+ *
+ * Switch position BOOT.6, Macro SW_PDM_EN:
+ *      0 - Select CAN routing
+ *      1 - Select PDM
  */
 
 / {
-- 
2.43.0


