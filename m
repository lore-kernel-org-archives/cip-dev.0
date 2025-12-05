Return-Path: <prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4FC23D32D80
	for <webhook@archiver.kernel.org>; Fri,  5 Dec 2025 14:34:12 +0000 (UTC)
Received: from relmlie5.idc.renesas.com (relmlie5.idc.renesas.com [210.160.252.171])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.6944.1764945237663626403
 for <cip-dev@lists.cip-project.org>;
 Fri, 05 Dec 2025 06:34:04 -0800
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: bp.renesas.com, ip: 210.160.252.171, mailfrom: prabhakar.mahadev-lad.rj@bp.renesas.com)
X-CSE-ConnectionGUID: GogewcLMSmmiJUg2XD7dkQ==
X-CSE-MsgGUID: dRfSfDb9TJmI6ReauIjHAA==
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie5.idc.renesas.com with ESMTP; 05 Dec 2025 23:34:04 +0900
Received: from Ubuntu-22.. (unknown [10.24.1.60])
	by relmlir6.idc.renesas.com (Postfix) with ESMTP id CB8F8417EAD9;
	Fri,  5 Dec 2025 23:34:02 +0900 (JST)
From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
Cc: Biju Das <biju.das.jz@bp.renesas.com>
Subject: [PATCH 6.12.y-cip 36/38] arm64: dts: renesas: r9a09g077m44-rzt2h-evk: Add user LEDs
Date: Fri,  5 Dec 2025 14:32:56 +0000
Message-ID: <20251205143258.13748-37-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251205143258.13748-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20251205143258.13748-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 05 Dec 2025 14:34:12 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/20950

commit 77aae5255c6d2ef4981f7fcedf35333466abcb06 upstream.

Add USER LED0-LED8, which are available on RZ/T2H EVK.

In addition, move the header file inclusion into the common
rzt2h-n2h-evk-common.dtsi, so that both RZ/T2H and RZ/N2H EVK DTS/I
files share the same set of bindings.  This avoids duplication and keeps
the board files consistent.

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Link: https://lore.kernel.org/20250820200659.2048755-3-prabhakar.mahadev-lad.rj@bp.renesas.com
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
 .../dts/renesas/r9a09g077m44-rzt2h-evk.dts    | 75 +++++++++++++++++++
 .../dts/renesas/rzt2h-n2h-evk-common.dtsi     |  4 +
 2 files changed, 79 insertions(+)

diff --git a/arch/arm64/boot/dts/renesas/r9a09g077m44-rzt2h-evk.dts b/arch/arm64/boot/dts/renesas/r9a09g077m44-rzt2h-evk.dts
index 486584fefeadf..dd65eb2904058 100644
--- a/arch/arm64/boot/dts/renesas/r9a09g077m44-rzt2h-evk.dts
+++ b/arch/arm64/boot/dts/renesas/r9a09g077m44-rzt2h-evk.dts
@@ -13,4 +13,79 @@
 / {
 	model = "Renesas RZ/T2H EVK Board based on r9a09g077m44";
 	compatible = "renesas,rzt2h-evk", "renesas,r9a09g077m44", "renesas,r9a09g077";
+
+	leds {
+		compatible = "gpio-leds";
+
+		led-0 {
+			/* SW8-9: ON, SW8-10: OFF */
+			gpios = <&pinctrl RZT2H_GPIO(23, 1) GPIO_ACTIVE_HIGH>;
+			color = <LED_COLOR_ID_GREEN>;
+			function = LED_FUNCTION_DEBUG;
+			function-enumerator = <0>;
+		};
+
+		led-1 {
+			/* SW5-1: OFF, SW5-2: ON */
+			gpios = <&pinctrl RZT2H_GPIO(32, 2) GPIO_ACTIVE_HIGH>;
+			color = <LED_COLOR_ID_GREEN>;
+			function = LED_FUNCTION_DEBUG;
+			function-enumerator = <1>;
+		};
+
+		led-2 {
+			gpios = <&pinctrl RZT2H_GPIO(6, 7) GPIO_ACTIVE_HIGH>;
+			color = <LED_COLOR_ID_YELLOW>;
+			function = LED_FUNCTION_DEBUG;
+			function-enumerator = <2>;
+		};
+
+		led-3 {
+			/* SW2-3: OFF */
+			gpios = <&pinctrl RZT2H_GPIO(8, 5) GPIO_ACTIVE_HIGH>;
+			color = <LED_COLOR_ID_RED>;
+			function = LED_FUNCTION_DEBUG;
+			function-enumerator = <3>;
+		};
+
+		led-4 {
+			/* SW8-3: ON, SW8-4: OFF */
+			gpios = <&pinctrl RZT2H_GPIO(18, 0) GPIO_ACTIVE_HIGH>;
+			color = <LED_COLOR_ID_GREEN>;
+			function = LED_FUNCTION_DEBUG;
+			function-enumerator = <4>;
+		};
+
+		led-5 {
+			/* SW8-1: ON, SW8-2: OFF */
+			gpios = <&pinctrl RZT2H_GPIO(18, 1) GPIO_ACTIVE_HIGH>;
+			color = <LED_COLOR_ID_RED>;
+			function = LED_FUNCTION_DEBUG;
+			function-enumerator = <5>;
+		};
+
+		led-6 {
+			/* SW5-9: OFF, SW5-10: ON */
+			gpios = <&pinctrl RZT2H_GPIO(22, 7) GPIO_ACTIVE_HIGH>;
+			color = <LED_COLOR_ID_GREEN>;
+			function = LED_FUNCTION_DEBUG;
+			function-enumerator = <6>;
+		};
+
+		led-7 {
+			/* SW5-7: OFF, SW5-8: ON */
+			gpios = <&pinctrl RZT2H_GPIO(23, 0) GPIO_ACTIVE_HIGH>;
+			color = <LED_COLOR_ID_GREEN>;
+			function = LED_FUNCTION_DEBUG;
+			function-enumerator = <7>;
+		};
+
+		led-8 {
+			/* SW7-5: OFF, SW7-6: ON */
+			gpios = <&pinctrl RZT2H_GPIO(23, 5) GPIO_ACTIVE_HIGH>;
+			color = <LED_COLOR_ID_GREEN>;
+			function = LED_FUNCTION_DEBUG;
+			function-enumerator = <8>;
+		};
+	};
 };
diff --git a/arch/arm64/boot/dts/renesas/rzt2h-n2h-evk-common.dtsi b/arch/arm64/boot/dts/renesas/rzt2h-n2h-evk-common.dtsi
index 5f17996bcd6bc..66d97059c47c9 100644
--- a/arch/arm64/boot/dts/renesas/rzt2h-n2h-evk-common.dtsi
+++ b/arch/arm64/boot/dts/renesas/rzt2h-n2h-evk-common.dtsi
@@ -5,6 +5,10 @@
  * Copyright (C) 2025 Renesas Electronics Corp.
  */
 
+#include <dt-bindings/gpio/gpio.h>
+#include <dt-bindings/leds/common.h>
+#include <dt-bindings/pinctrl/renesas,r9a09g077-pinctrl.h>
+
 / {
 	aliases {
 		serial0 = &sci0;
-- 
2.43.0


