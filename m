Return-Path: <prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8DBCC433EF
	for <webhook@archiver.kernel.org>; Mon, 31 Jan 2022 12:19:39 +0000 (UTC)
Received: from relmlie6.idc.renesas.com (relmlie6.idc.renesas.com
 [210.160.252.172])
 by mx.groups.io with SMTP id smtpd.web12.31207.1643631563602998327
 for <cip-dev@lists.cip-project.org>;
 Mon, 31 Jan 2022 04:19:38 -0800
Authentication-Results: mx.groups.io;
 dkim=missing;
 spf=pass (domain: bp.renesas.com, ip: 210.160.252.172,
 mailfrom: prabhakar.mahadev-lad.rj@bp.renesas.com)
X-IronPort-AV: E=Sophos;i="5.88,330,1635174000";
   d="scan'208";a="108906326"
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie6.idc.renesas.com with ESMTP; 31 Jan 2022 21:19:38 +0900
Received: from localhost.localdomain (unknown [10.226.36.204])
	by relmlir6.idc.renesas.com (Postfix) with ESMTP id 8DF864347FCA;
	Mon, 31 Jan 2022 21:19:37 +0900 (JST)
From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
Cc: Biju Das <biju.das.jz@bp.renesas.com>
Subject: [PATCH 5.10.y-cip 25/27] arm64: dts: renesas: rzg2l-smarc: Enable
 SCIF2 on carrier board
Date: Mon, 31 Jan 2022 12:19:01 +0000
Message-Id: <20220131121903.8620-26-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220131121903.8620-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20220131121903.8620-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 31 Jan 2022 12:19:39 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/7546

commit 5a8aa63c9bca800e6049d90422abe5404227a703 upstream.

SCIF2 interface is available on PMOD1 connector (CN7) on carrier board,
This patch adds pinmux and scif2 node to carrier board dtsi file.

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Reviewed-by: Biju Das <biju.das.jz@bp.renesas.com>
Link: https://lore.kernel.org/r/20211103195600.23964-4-prabhakar.mahadev-lad.rj@bp.renesas.com
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
[PL: Manually applied the changes.]
Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
 arch/arm64/boot/dts/renesas/rzg2l-smarc.dtsi | 28 ++++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/arch/arm64/boot/dts/renesas/rzg2l-smarc.dtsi b/arch/arm64/boot/dts/renesas/rzg2l-smarc.dtsi
index a33594575fc4..70aca5d0306d 100644
--- a/arch/arm64/boot/dts/renesas/rzg2l-smarc.dtsi
+++ b/arch/arm64/boot/dts/renesas/rzg2l-smarc.dtsi
@@ -8,9 +8,13 @@
 #include <dt-bindings/gpio/gpio.h>
 #include <dt-bindings/pinctrl/rzg2l-pinctrl.h>
 
+/* comment the #define statement to disable SCIF2 (SER0) on PMOD1 (CN7) */
+#define PMOD1_SER0	1
+
 / {
 	aliases {
 		serial0 = &scif0;
+		serial1 = &scif2;
 		i2c0 = &i2c0;
 		i2c1 = &i2c1;
 		i2c3 = &i2c3;
@@ -138,6 +142,13 @@
 			 <RZG2L_PORT_PINMUX(38, 1, 1)>;	/* RxD */
 	};
 
+	scif2_pins: scif2 {
+		pinmux = <RZG2L_PORT_PINMUX(48, 0, 1)>, /* TxD */
+			 <RZG2L_PORT_PINMUX(48, 1, 1)>, /* RxD */
+			 <RZG2L_PORT_PINMUX(48, 3, 1)>, /* CTS# */
+			 <RZG2L_PORT_PINMUX(48, 4, 1)>; /* RTS# */
+	};
+
 	usb0_pins: usb0 {
 		pinmux = <RZG2L_PORT_PINMUX(4, 0, 1)>, /* VBUS */
 			 <RZG2L_PORT_PINMUX(5, 0, 1)>, /* OVC */
@@ -156,6 +167,23 @@
 	status = "okay";
 };
 
+/*
+ * To enable SCIF2 (SER0) on PMOD1 (CN7)
+ * SW1 should be at position 2->3 so that SER0_CTS# line is activated
+ * SW2 should be at position 2->3 so that SER0_TX line is activated
+ * SW3 should be at position 2->3 so that SER0_RX line is activated
+ * SW4 should be at position 2->3 so that SER0_RTS# line is activated
+ */
+#if PMOD1_SER0
+&scif2 {
+	pinctrl-0 = <&scif2_pins>;
+	pinctrl-names = "default";
+
+	uart-has-rtscts;
+	status = "okay";
+};
+#endif
+
 &usb2_phy0 {
 	pinctrl-0 = <&usb0_pins>;
 	pinctrl-names = "default";
-- 
2.17.1


