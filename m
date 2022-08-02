Return-Path: <biju.das.jz@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C03C0C19F2B
	for <webhook@archiver.kernel.org>; Tue,  2 Aug 2022 11:09:51 +0000 (UTC)
Received: from relmlie5.idc.renesas.com (relmlie5.idc.renesas.com
 [210.160.252.171])
 by mx.groups.io with SMTP id smtpd.web08.4809.1659438581066216777
 for <cip-dev@lists.cip-project.org>;
 Tue, 02 Aug 2022 04:09:45 -0700
Authentication-Results: mx.groups.io;
 dkim=missing;
 spf=pass (domain: bp.renesas.com, ip: 210.160.252.171,
 mailfrom: biju.das.jz@bp.renesas.com)
X-IronPort-AV: E=Sophos;i="5.93,210,1654527600";
   d="scan'208";a="128236817"
Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie5.idc.renesas.com with ESMTP; 02 Aug 2022 20:09:45 +0900
Received: from localhost.localdomain (unknown [10.226.92.246])
	by relmlir5.idc.renesas.com (Postfix) with ESMTP id 63F98400D4CE;
	Tue,  2 Aug 2022 20:09:43 +0900 (JST)
From: Biju Das <biju.das.jz@bp.renesas.com>
To: Pavel Machek <pavel@denx.de>
Cc: nobuhiro1.iwamatsu@toshiba.co.jp,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	Biju Das <biju.das.jz@bp.renesas.com>,
	cip-dev@lists.cip-project.org
Subject: [PATCH 5.10.y-cip 23/24] arm64: dts: renesas: rzg2lc-smarc: Add
 macros for DIP-Switch settings
Date: Tue,  2 Aug 2022 12:08:49 +0100
Message-Id: <20220802110850.1496057-24-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220802110850.1496057-1-biju.das.jz@bp.renesas.com>
References: <20220802110850.1496057-1-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 02 Aug 2022 11:09:51 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/9020

commit 2ed3b5d9540b246d7a1ec98971914ee810b40086 upstream.

RZ/G2LC SoM uses DIP-SWitch SW1 for various pin multiplexing functions.

This patch describes DIP-SWitch SW1 settings on SoM and adds the
corresponding macros for enabling pinmux functionality on RZ/G2LC
SMARC EVK.

Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
Reviewed-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Link: https://lore.kernel.org/r/20220203170636.7747-3-biju.das.jz@bp.renesas.com
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
 .../boot/dts/renesas/r9a07g044c2-smarc.dts    |  4 +--
 arch/arm64/boot/dts/renesas/rzg2lc-smarc.dtsi | 36 +++++++++++++++++++
 2 files changed, 37 insertions(+), 3 deletions(-)
 create mode 100644 arch/arm64/boot/dts/renesas/rzg2lc-smarc.dtsi

diff --git a/arch/arm64/boot/dts/renesas/r9a07g044c2-smarc.dts b/arch/arm64/boot/dts/renesas/r9a07g044c2-smarc.dts
index af84fd6c8a81..50abdabc374a 100644
--- a/arch/arm64/boot/dts/renesas/r9a07g044c2-smarc.dts
+++ b/arch/arm64/boot/dts/renesas/r9a07g044c2-smarc.dts
@@ -7,9 +7,7 @@
 
 /dts-v1/;
 #include "r9a07g044c2.dtsi"
-#include "rzg2lc-smarc-som.dtsi"
-#include "rzg2lc-smarc-pinfunction.dtsi"
-#include "rz-smarc-common.dtsi"
+#include "rzg2lc-smarc.dtsi"
 
 / {
 	model = "Renesas SMARC EVK based on r9a07g044c2";
diff --git a/arch/arm64/boot/dts/renesas/rzg2lc-smarc.dtsi b/arch/arm64/boot/dts/renesas/rzg2lc-smarc.dtsi
new file mode 100644
index 000000000000..ca5ca7ce6692
--- /dev/null
+++ b/arch/arm64/boot/dts/renesas/rzg2lc-smarc.dtsi
@@ -0,0 +1,36 @@
+// SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+/*
+ * Device Tree Source for the RZ/G2LC SMARC EVK parts
+ *
+ * Copyright (C) 2022 Renesas Electronics Corp.
+ */
+
+#include <dt-bindings/gpio/gpio.h>
+#include <dt-bindings/pinctrl/rzg2l-pinctrl.h>
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
+#define SW_SCIF_CAN	0
+#if (SW_SCIF_CAN)
+/* Due to HW routing, SW_RSPI_CAN is always 0 when SW_SCIF_CAN is set to 1 */
+#define SW_RSPI_CAN	0
+#else
+/* Please set SW_RSPI_CAN. Default value is 1 */
+#define SW_RSPI_CAN	1
+#endif
+
+#if (SW_SCIF_CAN & SW_RSPI_CAN)
+#error "Can not set 1 to both SW_SCIF_CAN and SW_RSPI_CAN due to HW routing"
+#endif
+
+#include "rzg2lc-smarc-som.dtsi"
+#include "rzg2lc-smarc-pinfunction.dtsi"
+#include "rz-smarc-common.dtsi"
-- 
2.25.1


