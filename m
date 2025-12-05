Return-Path: <prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 555D8D32D8D
	for <webhook@archiver.kernel.org>; Fri,  5 Dec 2025 14:34:12 +0000 (UTC)
Received: from relmlie5.idc.renesas.com (relmlie5.idc.renesas.com [210.160.252.171])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.6944.1764945237663626403
 for <cip-dev@lists.cip-project.org>;
 Fri, 05 Dec 2025 06:34:06 -0800
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: bp.renesas.com, ip: 210.160.252.171, mailfrom: prabhakar.mahadev-lad.rj@bp.renesas.com)
X-CSE-ConnectionGUID: XaGwcPhVQ4qXED/LwBlSmw==
X-CSE-MsgGUID: P+dxaMzbT2KoFAXHT8TGJw==
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie5.idc.renesas.com with ESMTP; 05 Dec 2025 23:34:05 +0900
Received: from Ubuntu-22.. (unknown [10.24.1.60])
	by relmlir6.idc.renesas.com (Postfix) with ESMTP id 8CF1D417C326;
	Fri,  5 Dec 2025 23:34:04 +0900 (JST)
From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
Cc: Biju Das <biju.das.jz@bp.renesas.com>
Subject: [PATCH 6.12.y-cip 37/38] arm64: dts: renesas: r9a09g087m44-rzn2h-evk: Add user LEDs
Date: Fri,  5 Dec 2025 14:32:57 +0000
Message-ID: <20251205143258.13748-38-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251205143258.13748-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20251205143258.13748-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 05 Dec 2025 14:34:12 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/20951

commit 23cb8eb3286d7f2df646eaf7cbcb63b0f1f2ee45 upstream.

Add USER LED3-LED11, which are available on RZ/N2H EVK.

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Link: https://lore.kernel.org/20250820200659.2048755-4-prabhakar.mahadev-lad.rj@bp.renesas.com
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
 .../dts/renesas/r9a09g087m44-rzn2h-evk.dts    | 91 +++++++++++++++++++
 1 file changed, 91 insertions(+)

diff --git a/arch/arm64/boot/dts/renesas/r9a09g087m44-rzn2h-evk.dts b/arch/arm64/boot/dts/renesas/r9a09g087m44-rzn2h-evk.dts
index d6ba14a26f031..fb2651c4c3383 100644
--- a/arch/arm64/boot/dts/renesas/r9a09g087m44-rzn2h-evk.dts
+++ b/arch/arm64/boot/dts/renesas/r9a09g087m44-rzn2h-evk.dts
@@ -13,4 +13,95 @@
 / {
 	model = "Renesas RZ/N2H EVK Board based on r9a09g087m44";
 	compatible = "renesas,rzn2h-evk", "renesas,r9a09g087m44", "renesas,r9a09g087";
+
+	leds {
+		compatible = "gpio-leds";
+
+		led-3 {
+			/* DSW18-7: ON, DSW18-8: OFF */
+			gpios = <&pinctrl RZT2H_GPIO(31, 6) GPIO_ACTIVE_HIGH>;
+			color = <LED_COLOR_ID_GREEN>;
+			function = LED_FUNCTION_DEBUG;
+			function-enumerator = <4>;
+		};
+
+		led-4 {
+			/* DSW18-9: ON, DSW18-10: OFF */
+			gpios = <&pinctrl RZT2H_GPIO(18, 1) GPIO_ACTIVE_HIGH>;
+			color = <LED_COLOR_ID_RED>;
+			function = LED_FUNCTION_DEBUG;
+			function-enumerator = <5>;
+		};
+
+		led-5 {
+			/* DSW18-1: ON, DSW18-2: OFF */
+			gpios = <&pinctrl RZT2H_GPIO(22, 7) GPIO_ACTIVE_HIGH>;
+			color = <LED_COLOR_ID_GREEN>;
+			function = LED_FUNCTION_DEBUG;
+			function-enumerator = <6>;
+		};
+
+		led-6 {
+			/* DSW18-3: ON, DSW18-4: OFF */
+			gpios = <&pinctrl RZT2H_GPIO(23, 0) GPIO_ACTIVE_HIGH>;
+			color = <LED_COLOR_ID_GREEN>;
+			function = LED_FUNCTION_DEBUG;
+			function-enumerator = <7>;
+		};
+
+		led-7 {
+			/*
+			 * DSW18-5: ON, DSW18-6: OFF
+			 * DSW19-3: OFF, DSW19-4: ON
+			 */
+			gpios = <&pinctrl RZT2H_GPIO(14, 3) GPIO_ACTIVE_HIGH>;
+			color = <LED_COLOR_ID_GREEN>;
+			function = LED_FUNCTION_DEBUG;
+			function-enumerator = <8>;
+		};
+
+		led-8 {
+			/*
+			 * USER_LED0
+			 * DSW15-8: OFF, DSW15-9: OFF, DSW15-10: ON
+			 */
+			gpios = <&pinctrl RZT2H_GPIO(14, 6) GPIO_ACTIVE_HIGH>;
+			color = <LED_COLOR_ID_GREEN>;
+			function = LED_FUNCTION_DEBUG;
+			function-enumerator = <0>;
+		};
+
+		led-9 {
+			/*
+			 * USER_LED1
+			 * DSW15-5: OFF, DSW15-6: ON
+			 */
+			gpios = <&pinctrl RZT2H_GPIO(14, 7) GPIO_ACTIVE_HIGH>;
+			color = <LED_COLOR_ID_GREEN>;
+			function = LED_FUNCTION_DEBUG;
+			function-enumerator = <1>;
+		};
+
+		led-10 {
+			/*
+			 * USER_LED2
+			 * DSW17-3: OFF, DSW17-4: ON
+			 */
+			gpios = <&pinctrl RZT2H_GPIO(2, 7) GPIO_ACTIVE_HIGH>;
+			color = <LED_COLOR_ID_YELLOW>;
+			function = LED_FUNCTION_DEBUG;
+			function-enumerator = <2>;
+		};
+
+		led-11 {
+			/*
+			 * USER_LED3
+			 * DSW17-1: OFF, DSW17-2: ON
+			 */
+			gpios = <&pinctrl RZT2H_GPIO(3, 0) GPIO_ACTIVE_HIGH>;
+			color = <LED_COLOR_ID_RED>;
+			function = LED_FUNCTION_DEBUG;
+			function-enumerator = <3>;
+		};
+	};
 };
-- 
2.43.0


