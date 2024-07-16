Return-Path: <biju.das.jz@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CEFEFC3DA59
	for <webhook@archiver.kernel.org>; Tue, 16 Jul 2024 08:24:08 +0000 (UTC)
Received: from relmlie5.idc.renesas.com (relmlie5.idc.renesas.com [210.160.252.171])
 by mx.groups.io with SMTP id smtpd.web11.5837.1721118242888908646
 for <cip-dev@lists.cip-project.org>;
 Tue, 16 Jul 2024 01:24:07 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: bp.renesas.com, ip: 210.160.252.171, mailfrom: biju.das.jz@bp.renesas.com)
X-IronPort-AV: E=Sophos;i="6.09,211,1716217200"; 
   d="scan'208";a="211467788"
Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie5.idc.renesas.com with ESMTP; 16 Jul 2024 17:24:06 +0900
Received: from localhost.localdomain (unknown [10.226.92.125])
	by relmlir5.idc.renesas.com (Postfix) with ESMTP id 274774016D5E;
	Tue, 16 Jul 2024 17:24:04 +0900 (JST)
From: Biju Das <biju.das.jz@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
Cc: Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH 5.10.y-cip 30/31] arm64: dts: renesas: rzg2ul-smarc: Enable PMIC and built-in RTC, GPIO and ONKEY
Date: Tue, 16 Jul 2024 09:22:41 +0100
Message-ID: <20240716082255.56551-31-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240716082255.56551-1-biju.das.jz@bp.renesas.com>
References: <20240716082255.56551-1-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 16 Jul 2024 08:24:08 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/16556

commit 1aa24b0b4e6f65935418a50c3167adf954a04770 upstream.

Enable PMIC DA9062 and the built-in RTC, GPIO and ONKEY modules on the
RZ/{G2UL,Five} SMARC EVK development boards.

Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Link: https://lore.kernel.org/r/20240226194715.427597-2-biju.das.jz@bp.renesas.com
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
 arch/arm64/boot/dts/renesas/rzg2ul-smarc.dtsi | 58 +++++++++++++++++++
 1 file changed, 58 insertions(+)

diff --git a/arch/arm64/boot/dts/renesas/rzg2ul-smarc.dtsi b/arch/arm64/boot/dts/renesas/rzg2ul-smarc.dtsi
index 727e3268a15b..876eb9d60f76 100644
--- a/arch/arm64/boot/dts/renesas/rzg2ul-smarc.dtsi
+++ b/arch/arm64/boot/dts/renesas/rzg2ul-smarc.dtsi
@@ -5,6 +5,7 @@
  * Copyright (C) 2022 Renesas Electronics Corp.
  */
 
+#include <dt-bindings/gpio/gpio.h>
 #include "rzg2ul-smarc-pinfunction.dtsi"
 #include "rz-smarc-common.dtsi"
 
@@ -23,6 +24,63 @@ &cpu_dai {
 &i2c0 {
 	clock-frequency = <400000>;
 
+	da9062: pmic@58 {
+		compatible = "dlg,da9062";
+		reg = <0x58>;
+		gpio-controller;
+		#gpio-cells = <2>;
+
+		gpio {
+			compatible = "dlg,da9062-gpio";
+		};
+
+		onkey {
+			compatible = "dlg,da9062-onkey";
+		};
+
+		pmic-good-hog {
+			gpio-hog;
+			gpios = <4 GPIO_ACTIVE_HIGH>;
+			output-high;
+			line-name = "PMIC_PGOOD";
+		};
+
+		rtc {
+			compatible = "dlg,da9062-rtc";
+		};
+
+		sd0-pwr-sel-hog {
+			gpio-hog;
+			gpios = <1 GPIO_ACTIVE_HIGH>;
+			input;
+			line-name = "SD0_PWR_SEL";
+		};
+
+		sd1-pwr-sel-hog {
+			gpio-hog;
+			gpios = <2 GPIO_ACTIVE_HIGH>;
+			input;
+			line-name = "SD1_PWR_SEL";
+		};
+
+		sw-et0-en-hog {
+			gpio-hog;
+			gpios = <3 GPIO_ACTIVE_HIGH>;
+			input;
+			line-name = "SW_ET0_EN#";
+		};
+
+		thermal {
+			compatible = "dlg,da9062-thermal";
+			status = "disabled";
+		};
+
+		watchdog {
+			compatible = "dlg,da9062-watchdog";
+			status = "disabled";
+		};
+	};
+
 	versa3: clock-generator@68 {
 		compatible = "renesas,5p35023";
 		reg = <0x68>;
-- 
2.43.0


