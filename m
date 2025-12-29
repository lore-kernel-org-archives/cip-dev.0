Return-Path: <prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E08ADE92FFA
	for <webhook@archiver.kernel.org>; Mon, 29 Dec 2025 22:39:45 +0000 (UTC)
Received: from relmlie5.idc.renesas.com (relmlie5.idc.renesas.com [210.160.252.171])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.53265.1767047973878245967
 for <cip-dev@lists.cip-project.org>;
 Mon, 29 Dec 2025 14:39:40 -0800
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: bp.renesas.com, ip: 210.160.252.171, mailfrom: prabhakar.mahadev-lad.rj@bp.renesas.com)
X-CSE-ConnectionGUID: W1NoXp+qRamStDQtlfdSsg==
X-CSE-MsgGUID: 6kPuWRjtS6eQCZi5RK39LA==
Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie5.idc.renesas.com with ESMTP; 30 Dec 2025 07:39:40 +0900
Received: from Ubuntu-22.. (unknown [10.24.0.160])
	by relmlir5.idc.renesas.com (Postfix) with ESMTP id 05F57400A0FF;
	Tue, 30 Dec 2025 07:39:38 +0900 (JST)
From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro.iwamatsu.x90@mail.toshiba>,
	Pavel Machek <pavel@denx.de>
Cc: Biju Das <biju.das.jz@bp.renesas.com>
Subject: [PATCH 6.12.y-cip 15/17] arm64: dts: renesas: r9a09g077m44-rzt2h-evk: Enable I2C0 and I2C1 support
Date: Mon, 29 Dec 2025 22:39:09 +0000
Message-ID: <20251229223911.8663-16-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251229223911.8663-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20251229223911.8663-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 29 Dec 2025 22:39:45 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/21273

commit 6f21672c42fc432d69d8fd51e5d8cea145d5be5b upstream.

Enable I2C0 and I2C1 on the RZ/T2H evaluation board.

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Link: https://lore.kernel.org/20250812200344.3253781-9-prabhakar.mahadev-lad.rj@bp.renesas.com
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
 .../dts/renesas/r9a09g077m44-rzt2h-evk.dts    | 36 +++++++++++++++++++
 .../dts/renesas/rzt2h-n2h-evk-common.dtsi     |  2 ++
 2 files changed, 38 insertions(+)

diff --git a/arch/arm64/boot/dts/renesas/r9a09g077m44-rzt2h-evk.dts b/arch/arm64/boot/dts/renesas/r9a09g077m44-rzt2h-evk.dts
index dd65eb2904058..6aeb5cacead32 100644
--- a/arch/arm64/boot/dts/renesas/r9a09g077m44-rzt2h-evk.dts
+++ b/arch/arm64/boot/dts/renesas/r9a09g077m44-rzt2h-evk.dts
@@ -7,6 +7,8 @@
 
 /dts-v1/;
 
+#include <dt-bindings/pinctrl/renesas,r9a09g077-pinctrl.h>
+
 #include "r9a09g077m44.dtsi"
 #include "rzt2h-n2h-evk-common.dtsi"
 
@@ -89,3 +91,37 @@ led-8 {
 		};
 	};
 };
+
+&i2c0 {
+	pinctrl-0 = <&i2c0_pins>;
+	pinctrl-names = "default";
+	clock-frequency = <400000>;
+	status = "okay";
+};
+
+&i2c1 {
+	pinctrl-0 = <&i2c1_pins>;
+	pinctrl-names = "default";
+	clock-frequency = <400000>;
+	status = "okay";
+};
+
+&pinctrl {
+	/*
+	 * I2C0 Pin Configuration:
+	 * ------------------------
+	 * Signal | Pin     | SW6
+	 * -------|---------|--------------
+	 * SCL    | P23_3   | 7: ON, 8: OFF
+	 * SDA    | P23_4   | 9: ON, 10: OFF
+	 */
+	i2c0_pins: i2c0-pins {
+		pinmux = <RZT2H_PORT_PINMUX(23, 3, 0x17)>,
+			 <RZT2H_PORT_PINMUX(23, 4, 0x17)>;
+	};
+
+	i2c1_pins: i2c1-pins {
+		pinmux = <RZT2H_PORT_PINMUX(5, 0, 0x17)>, /* SDA */
+			 <RZT2H_PORT_PINMUX(4, 7, 0x17)>; /* SCL */
+	};
+};
diff --git a/arch/arm64/boot/dts/renesas/rzt2h-n2h-evk-common.dtsi b/arch/arm64/boot/dts/renesas/rzt2h-n2h-evk-common.dtsi
index 245b70f1557fe..06300f8066853 100644
--- a/arch/arm64/boot/dts/renesas/rzt2h-n2h-evk-common.dtsi
+++ b/arch/arm64/boot/dts/renesas/rzt2h-n2h-evk-common.dtsi
@@ -11,6 +11,8 @@
 
 / {
 	aliases {
+		i2c0 = &i2c0;
+		i2c1 = &i2c1;
 		serial0 = &sci0;
 	};
 
-- 
2.43.0


