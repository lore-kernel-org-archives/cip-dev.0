Return-Path: <biju.das.jz@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E90DC3F6B0
	for <webhook@archiver.kernel.org>; Wed,  3 Aug 2022 16:54:19 +0000 (UTC)
Received: from relmlie6.idc.renesas.com (relmlie6.idc.renesas.com
 [210.160.252.172])
 by mx.groups.io with SMTP id smtpd.web12.169.1659545650200364617
 for <cip-dev@lists.cip-project.org>;
 Wed, 03 Aug 2022 09:54:17 -0700
Authentication-Results: mx.groups.io;
 dkim=missing;
 spf=pass (domain: bp.renesas.com, ip: 210.160.252.172,
 mailfrom: biju.das.jz@bp.renesas.com)
X-IronPort-AV: E=Sophos;i="5.93,214,1654527600";
   d="scan'208";a="130216134"
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie6.idc.renesas.com with ESMTP; 04 Aug 2022 01:54:17 +0900
Received: from localhost.localdomain (unknown [10.226.93.45])
	by relmlir6.idc.renesas.com (Postfix) with ESMTP id 39BC340B100C;
	Thu,  4 Aug 2022 01:54:14 +0900 (JST)
From: Biju Das <biju.das.jz@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
Cc: Chris Paterson <chris.paterson2@renesas.com>,
	Biju Das <biju.das.jz@bp.renesas.com>,
	Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH 5.10.y-cip 06/13] arm64: dts: renesas:
 rzg2lc-smarc-pinfunction: Sort the nodes
Date: Wed,  3 Aug 2022 17:53:51 +0100
Message-Id: <20220803165358.2156150-7-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220803165358.2156150-1-biju.das.jz@bp.renesas.com>
References: <20220803165358.2156150-1-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 03 Aug 2022 16:54:19 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/9076

commit a2b642d89e4beeddbfbd7be6108db2b7aaef78b6 upstream.

Sort the pinctrl nodes alphabetically.

Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
Reviewed-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Link: https://lore.kernel.org/r/20220303164155.7706-2-biju.das.jz@bp.renesas.com
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
 .../dts/renesas/rzg2lc-smarc-pinfunction.dtsi | 24 +++++++++----------
 1 file changed, 12 insertions(+), 12 deletions(-)

diff --git a/arch/arm64/boot/dts/renesas/rzg2lc-smarc-pinfunction.dtsi b/arch/arm64/boot/dts/renesas/rzg2lc-smarc-pinfunction.dtsi
index 5f5ec21e655c..53759c3ddecb 100644
--- a/arch/arm64/boot/dts/renesas/rzg2lc-smarc-pinfunction.dtsi
+++ b/arch/arm64/boot/dts/renesas/rzg2lc-smarc-pinfunction.dtsi
@@ -12,11 +12,6 @@ &pinctrl {
 	pinctrl-0 = <&sound_clk_pins>;
 	pinctrl-names = "default";
 
-	scif0_pins: scif0 {
-		pinmux = <RZG2L_PORT_PINMUX(38, 0, 1)>,	/* TxD */
-			 <RZG2L_PORT_PINMUX(38, 1, 1)>;	/* RxD */
-	};
-
 #if SW_SCIF_CAN
 	/* SW8 should be at position 2->1 */
 	can1_pins: can1 {
@@ -25,13 +20,6 @@ can1_pins: can1 {
 	};
 #endif
 
-	scif1_pins: scif1 {
-		pinmux = <RZG2L_PORT_PINMUX(40, 0, 1)>, /* TxD */
-			 <RZG2L_PORT_PINMUX(40, 1, 1)>, /* RxD */
-			 <RZG2L_PORT_PINMUX(41, 0, 1)>, /* CTS# */
-			 <RZG2L_PORT_PINMUX(41, 1, 1)>; /* RTS# */
-	};
-
 #if SW_RSPI_CAN
 	/* SW8 should be at position 2->3 so that GPIO9_CAN1_STB line is activated */
 	can1-stb-hog {
@@ -47,6 +35,18 @@ can1_pins: can1 {
 	};
 #endif
 
+	scif0_pins: scif0 {
+		pinmux = <RZG2L_PORT_PINMUX(38, 0, 1)>,	/* TxD */
+			 <RZG2L_PORT_PINMUX(38, 1, 1)>;	/* RxD */
+	};
+
+	scif1_pins: scif1 {
+		pinmux = <RZG2L_PORT_PINMUX(40, 0, 1)>, /* TxD */
+			 <RZG2L_PORT_PINMUX(40, 1, 1)>, /* RxD */
+			 <RZG2L_PORT_PINMUX(41, 0, 1)>, /* CTS# */
+			 <RZG2L_PORT_PINMUX(41, 1, 1)>; /* RTS# */
+	};
+
 	sd1-pwr-en-hog {
 		gpio-hog;
 		gpios = <RZG2L_GPIO(39, 2) GPIO_ACTIVE_HIGH>;
-- 
2.25.1


