Return-Path: <prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71A29C433EF
	for <webhook@archiver.kernel.org>; Wed, 29 Dec 2021 10:15:58 +0000 (UTC)
Received: from relmlie5.idc.renesas.com (relmlie5.idc.renesas.com
 [210.160.252.171])
 by mx.groups.io with SMTP id smtpd.web12.49376.1640772940300083487
 for <cip-dev@lists.cip-project.org>;
 Wed, 29 Dec 2021 02:15:58 -0800
Authentication-Results: mx.groups.io;
 dkim=missing;
 spf=pass (domain: bp.renesas.com, ip: 210.160.252.171,
 mailfrom: prabhakar.mahadev-lad.rj@bp.renesas.com)
X-IronPort-AV: E=Sophos;i="5.88,244,1635174000";
   d="scan'208";a="105094702"
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie5.idc.renesas.com with ESMTP; 29 Dec 2021 19:15:57 +0900
Received: from localhost.localdomain (unknown [10.226.36.204])
	by relmlir6.idc.renesas.com (Postfix) with ESMTP id 9FDF3423D00D;
	Wed, 29 Dec 2021 19:15:56 +0900 (JST)
From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
Cc: Biju Das <biju.das.jz@bp.renesas.com>
Subject: [PATCH 5.10.y-cip 19/31] arm64: dts: renesas: rzg2l-smarc: Enable
 I2C{0,1,3} support
Date: Wed, 29 Dec 2021 10:15:18 +0000
Message-Id: <20211229101530.22783-20-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20211229101530.22783-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20211229101530.22783-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 29 Dec 2021 10:15:58 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/7296

From: Biju Das <biju.das.jz@bp.renesas.com>

commit 04637e2f73d1e77dc00aa046b4845af5fe7e7cef upstream.

Enable I2C{0,1,3} support on RZ/G2L SMARC EVK.

Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
Reviewed-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Link: https://lore.kernel.org/r/20210920182955.13445-3-biju.das.jz@bp.renesas.com
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
 arch/arm64/boot/dts/renesas/rzg2l-smarc.dtsi | 39 ++++++++++++++++++++
 1 file changed, 39 insertions(+)

diff --git a/arch/arm64/boot/dts/renesas/rzg2l-smarc.dtsi b/arch/arm64/boot/dts/renesas/rzg2l-smarc.dtsi
index 7ecd4a3f4175..8ecc5b45fc99 100644
--- a/arch/arm64/boot/dts/renesas/rzg2l-smarc.dtsi
+++ b/arch/arm64/boot/dts/renesas/rzg2l-smarc.dtsi
@@ -11,6 +11,9 @@
 / {
 	aliases {
 		serial0 = &scif0;
+		i2c0 = &i2c0;
+		i2c1 = &i2c1;
+		i2c3 = &i2c3;
 	};
 
 	chosen {
@@ -45,6 +48,27 @@
 	status = "okay";
 };
 
+&i2c0 {
+	pinctrl-0 = <&i2c0_pins>;
+	pinctrl-names = "default";
+
+	status = "okay";
+};
+
+&i2c1 {
+	pinctrl-0 = <&i2c1_pins>;
+	pinctrl-names = "default";
+
+	status = "okay";
+};
+
+&i2c3 {
+	pinctrl-0 = <&i2c3_pins>;
+	pinctrl-names = "default";
+
+	status = "okay";
+};
+
 &ohci0 {
 	dr_mode = "otg";
 	status = "okay";
@@ -59,6 +83,21 @@
 };
 
 &pinctrl {
+	i2c0_pins: i2c0 {
+		pins = "RIIC0_SDA", "RIIC0_SCL";
+		input-enable;
+	};
+
+	i2c1_pins: i2c1 {
+		pins = "RIIC1_SDA", "RIIC1_SCL";
+		input-enable;
+	};
+
+	i2c3_pins: i2c3 {
+		pinmux = <RZG2L_PORT_PINMUX(18, 0, 3)>, /* SDA */
+			 <RZG2L_PORT_PINMUX(18, 1, 3)>; /* SCL */
+	};
+
 	scif0_pins: scif0 {
 		pinmux = <RZG2L_PORT_PINMUX(38, 0, 1)>,	/* TxD */
 			 <RZG2L_PORT_PINMUX(38, 1, 1)>;	/* RxD */
-- 
2.17.1


