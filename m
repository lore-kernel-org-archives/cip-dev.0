Return-Path: <biju.das.jz@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9EE1C3F6B0
	for <webhook@archiver.kernel.org>; Wed,  3 Aug 2022 16:54:09 +0000 (UTC)
Received: from relmlie5.idc.renesas.com (relmlie5.idc.renesas.com
 [210.160.252.171])
 by mx.groups.io with SMTP id smtpd.web08.152.1659545646492541407
 for <cip-dev@lists.cip-project.org>;
 Wed, 03 Aug 2022 09:54:07 -0700
Authentication-Results: mx.groups.io;
 dkim=missing;
 spf=pass (domain: bp.renesas.com, ip: 210.160.252.171,
 mailfrom: biju.das.jz@bp.renesas.com)
X-IronPort-AV: E=Sophos;i="5.93,214,1654527600";
   d="scan'208";a="128394719"
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie5.idc.renesas.com with ESMTP; 04 Aug 2022 01:54:07 +0900
Received: from localhost.localdomain (unknown [10.226.93.45])
	by relmlir6.idc.renesas.com (Postfix) with ESMTP id 20F5E40B10E9;
	Thu,  4 Aug 2022 01:54:04 +0900 (JST)
From: Biju Das <biju.das.jz@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
Cc: Chris Paterson <chris.paterson2@renesas.com>,
	Biju Das <biju.das.jz@bp.renesas.com>,
	Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH 5.10.y-cip 02/13] arm64: dts: renesas: rzg2lc-smarc: Use
 SW_SD0_DEV_SEL macro for eMMC/SDHI device selection
Date: Wed,  3 Aug 2022 17:53:47 +0100
Message-Id: <20220803165358.2156150-3-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220803165358.2156150-1-biju.das.jz@bp.renesas.com>
References: <20220803165358.2156150-1-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 03 Aug 2022 16:54:09 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/9072

commit 5c65ad12785205d5c57bd92e19d0296f93c19e33 upstream.

This patch replaces EMMC/SDHI macros with SW_SD0_DEV_SEL DIP-Switch
macro for eMMC/SDHI device selection.

Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
Link: https://lore.kernel.org/r/20220204143132.3608-1-biju.das.jz@bp.renesas.com
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
 arch/arm64/boot/dts/renesas/rzg2lc-smarc-som.dtsi | 14 ++------------
 arch/arm64/boot/dts/renesas/rzg2lc-smarc.dtsi     |  2 ++
 2 files changed, 4 insertions(+), 12 deletions(-)

diff --git a/arch/arm64/boot/dts/renesas/rzg2lc-smarc-som.dtsi b/arch/arm64/boot/dts/renesas/rzg2lc-smarc-som.dtsi
index 6ebda3724f2c..90cb7ec45751 100644
--- a/arch/arm64/boot/dts/renesas/rzg2lc-smarc-som.dtsi
+++ b/arch/arm64/boot/dts/renesas/rzg2lc-smarc-som.dtsi
@@ -8,16 +8,6 @@
 #include <dt-bindings/gpio/gpio.h>
 #include <dt-bindings/pinctrl/rzg2l-pinctrl.h>
 
-/* SW1[2] should be at OFF position to enable 64 GB eMMC */
-#define EMMC	1
-
-/*
- * To enable uSD card on CN3,
- * SW1[2] should be at ON position.
- * Disable eMMC by setting "#define EMMC	0" above.
- */
-#define SDHI	(!EMMC)
-
 / {
 	aliases {
 		ethernet0 = &eth0;
@@ -185,7 +175,7 @@ sd0_mux_uhs {
 	};
 };
 
-#if SDHI
+#if (!SW_SD0_DEV_SEL)
 &sdhi0 {
 	pinctrl-0 = <&sdhi0_pins>;
 	pinctrl-1 = <&sdhi0_pins_uhs>;
@@ -200,7 +190,7 @@ &sdhi0 {
 };
 #endif
 
-#if EMMC
+#if SW_SD0_DEV_SEL
 &sdhi0 {
 	pinctrl-0 = <&sdhi0_emmc_pins>;
 	pinctrl-1 = <&sdhi0_emmc_pins>;
diff --git a/arch/arm64/boot/dts/renesas/rzg2lc-smarc.dtsi b/arch/arm64/boot/dts/renesas/rzg2lc-smarc.dtsi
index 28f21c287ba3..df7631fe5fac 100644
--- a/arch/arm64/boot/dts/renesas/rzg2lc-smarc.dtsi
+++ b/arch/arm64/boot/dts/renesas/rzg2lc-smarc.dtsi
@@ -18,6 +18,8 @@
  * Please change below macros according to SW1 setting
  */
 
+#define SW_SD0_DEV_SEL	1
+
 #define SW_SCIF_CAN	0
 #if (SW_SCIF_CAN)
 /* Due to HW routing, SW_RSPI_CAN is always 0 when SW_SCIF_CAN is set to 1 */
-- 
2.25.1


