Return-Path: <biju.das.jz@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0FEBEC001DC
	for <webhook@archiver.kernel.org>; Tue, 18 Jul 2023 14:11:40 +0000 (UTC)
Received: from relmlie6.idc.renesas.com (relmlie6.idc.renesas.com [210.160.252.172])
 by mx.groups.io with SMTP id smtpd.web11.8578.1689689493732484416
 for <cip-dev@lists.cip-project.org>;
 Tue, 18 Jul 2023 07:11:35 -0700
Authentication-Results: mx.groups.io;
 dkim=missing; spf=pass (domain: bp.renesas.com, ip: 210.160.252.172, mailfrom: biju.das.jz@bp.renesas.com)
X-IronPort-AV: E=Sophos;i="6.01,214,1684767600"; 
   d="scan'208";a="173413952"
Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie6.idc.renesas.com with ESMTP; 18 Jul 2023 23:11:35 +0900
Received: from localhost.localdomain (unknown [10.226.92.137])
	by relmlir5.idc.renesas.com (Postfix) with ESMTP id 704534007F26;
	Tue, 18 Jul 2023 23:11:33 +0900 (JST)
From: Biju Das <biju.das.jz@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
Cc: Biju Das <biju.das.jz@bp.renesas.com>,
	Fabrizio Castro <fabrizio.castro.jz@renesas.com>
Subject: [PATCH 6.1.y-cip 1/6] arm64: dts: renesas: rzg2lc-smarc: Include SoM DTSI into board DTS
Date: Tue, 18 Jul 2023 15:11:24 +0100
Message-Id: <20230718141129.119809-2-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230718141129.119809-1-biju.das.jz@bp.renesas.com>
References: <20230718141129.119809-1-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 18 Jul 2023 14:11:40 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/12392

From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

commit 29df86bbbad007eb1863c9d31473122c87c3e771 upstream.

Move including the rzg2lc-smarc-som.dtsi from the carrier board
rzg2lc-smarc.dtsi to the actual RZ/G2LC SMARC EVK board dts
r9a07g044c2-smarc.dts. Also move the SW1 related macros along with
PMOD1_SER0 to board dts so that we have all the configuration options
in the same file.

This patch is to keep consistency with other SMARC EVKs (RZ/G2L, RZ/G2UL)
and it makes sense not include the SoM into the carrier board as we might
in future have a different carrier board with the same SoM.

Suggested-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Link: https://lore.kernel.org/r/20220919092130.93074-1-prabhakar.mahadev-lad.rj@bp.renesas.com
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
 .../boot/dts/renesas/r9a07g044c2-smarc.dts    | 30 +++++++++++++++++++
 arch/arm64/boot/dts/renesas/rzg2lc-smarc.dtsi | 28 -----------------
 2 files changed, 30 insertions(+), 28 deletions(-)

diff --git a/arch/arm64/boot/dts/renesas/r9a07g044c2-smarc.dts b/arch/arm64/boot/dts/renesas/r9a07g044c2-smarc.dts
index fc34058002e2..f67a6f125d9c 100644
--- a/arch/arm64/boot/dts/renesas/r9a07g044c2-smarc.dts
+++ b/arch/arm64/boot/dts/renesas/r9a07g044c2-smarc.dts
@@ -6,7 +6,37 @@
  */
 
 /dts-v1/;
+
+/*
+ * DIP-Switch SW1 setting on SoM
+ * 1 : High; 0: Low
+ * SW1-2 : SW_SD0_DEV_SEL	(1: eMMC; 0: uSD)
+ * SW1-3 : SW_SCIF_CAN		(1: CAN1; 0: SCIF1)
+ * SW1-4 : SW_RSPI_CAN		(1: CAN1; 0: RSPI1)
+ * SW1-5 : SW_I2S0_I2S1		(1: I2S2 (HDMI audio); 0: I2S0)
+ * Please change below macros according to SW1 setting
+ */
+
+#define SW_SD0_DEV_SEL	1
+
+#define SW_SCIF_CAN	0
+#if (SW_SCIF_CAN)
+/* Due to HW routing, SW_RSPI_CAN is always 0 when SW_SCIF_CAN is set to 1 */
+#define SW_RSPI_CAN	0
+#else
+/* Please set SW_RSPI_CAN. Default value is 1 */
+#define SW_RSPI_CAN	1
+#endif
+
+#if (SW_SCIF_CAN && SW_RSPI_CAN)
+#error "Can not set 1 to both SW_SCIF_CAN and SW_RSPI_CAN due to HW routing"
+#endif
+
+/* comment the #define statement to disable SCIF1 (SER0) on PMOD1 (CN7) */
+#define PMOD1_SER0	1
+
 #include "r9a07g044c2.dtsi"
+#include "rzg2lc-smarc-som.dtsi"
 #include "rzg2lc-smarc.dtsi"
 
 / {
diff --git a/arch/arm64/boot/dts/renesas/rzg2lc-smarc.dtsi b/arch/arm64/boot/dts/renesas/rzg2lc-smarc.dtsi
index 6be25a8a28db..b6bd27196d88 100644
--- a/arch/arm64/boot/dts/renesas/rzg2lc-smarc.dtsi
+++ b/arch/arm64/boot/dts/renesas/rzg2lc-smarc.dtsi
@@ -8,37 +8,9 @@
 #include <dt-bindings/gpio/gpio.h>
 #include <dt-bindings/pinctrl/rzg2l-pinctrl.h>
 
-/*
- * DIP-Switch SW1 setting on SoM
- * 1 : High; 0: Low
- * SW1-2 : SW_SD0_DEV_SEL	(1: eMMC; 0: uSD)
- * SW1-3 : SW_SCIF_CAN		(1: CAN1; 0: SCIF1)
- * SW1-4 : SW_RSPI_CAN		(1: CAN1; 0: RSPI1)
- * SW1-5 : SW_I2S0_I2S1		(1: I2S2 (HDMI audio); 0: I2S0)
- * Please change below macros according to SW1 setting
- */
-
-#define SW_SD0_DEV_SEL	1
-
-#define SW_SCIF_CAN	0
-#if (SW_SCIF_CAN)
-/* Due to HW routing, SW_RSPI_CAN is always 0 when SW_SCIF_CAN is set to 1 */
-#define SW_RSPI_CAN	0
-#else
-/* Please set SW_RSPI_CAN. Default value is 1 */
-#define SW_RSPI_CAN	1
-#endif
-
-#if (SW_SCIF_CAN && SW_RSPI_CAN)
-#error "Can not set 1 to both SW_SCIF_CAN and SW_RSPI_CAN due to HW routing"
-#endif
-
-#include "rzg2lc-smarc-som.dtsi"
 #include "rzg2lc-smarc-pinfunction.dtsi"
 #include "rz-smarc-common.dtsi"
 
-/* comment the #define statement to disable SCIF1 (SER0) on PMOD1 (CN7) */
-#define PMOD1_SER0	1
 
 / {
 	aliases {
-- 
2.25.1


