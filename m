Return-Path: <prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7F4FC433EF
	for <webhook@archiver.kernel.org>; Mon, 31 Jan 2022 12:19:31 +0000 (UTC)
Received: from relmlie5.idc.renesas.com (relmlie5.idc.renesas.com
 [210.160.252.171])
 by mx.groups.io with SMTP id smtpd.web10.31578.1643631568680544584
 for <cip-dev@lists.cip-project.org>;
 Mon, 31 Jan 2022 04:19:31 -0800
Authentication-Results: mx.groups.io;
 dkim=missing;
 spf=pass (domain: bp.renesas.com, ip: 210.160.252.171,
 mailfrom: prabhakar.mahadev-lad.rj@bp.renesas.com)
X-IronPort-AV: E=Sophos;i="5.88,330,1635174000";
   d="scan'208";a="108231926"
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie5.idc.renesas.com with ESMTP; 31 Jan 2022 21:19:30 +0900
Received: from localhost.localdomain (unknown [10.226.36.204])
	by relmlir6.idc.renesas.com (Postfix) with ESMTP id BF7CA4347FE1;
	Mon, 31 Jan 2022 21:19:29 +0900 (JST)
From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
Cc: Biju Das <biju.das.jz@bp.renesas.com>
Subject: [PATCH 5.10.y-cip 19/27] arm64: dts: renesas: rzg2l-smarc-som: Enable
 serial NOR flash
Date: Mon, 31 Jan 2022 12:18:55 +0000
Message-Id: <20220131121903.8620-20-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220131121903.8620-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20220131121903.8620-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 31 Jan 2022 12:19:31 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/7540

commit c81bd70f47cef36f88074d119e6e49cf92707fdb upstream.

Enable mt25qu512a flash connected to QSPI0.

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Reviewed-by: Biju Das <biju.das.jz@bp.renesas.com>
Link: https://lore.kernel.org/r/20211121234906.9602-1-prabhakar.mahadev-lad.rj@bp.renesas.com
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
[PL: Manually applied the changes.]
Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
 .../boot/dts/renesas/rzg2l-smarc-som.dtsi     | 40 +++++++++++++++++++
 1 file changed, 40 insertions(+)

diff --git a/arch/arm64/boot/dts/renesas/rzg2l-smarc-som.dtsi b/arch/arm64/boot/dts/renesas/rzg2l-smarc-som.dtsi
index 1fd961066236..9804ca0fd528 100644
--- a/arch/arm64/boot/dts/renesas/rzg2l-smarc-som.dtsi
+++ b/arch/arm64/boot/dts/renesas/rzg2l-smarc-som.dtsi
@@ -129,4 +129,44 @@
 			 <RZG2L_PORT_PINMUX(35, 1, 1)>, /* ET1_RXD2 */
 			 <RZG2L_PORT_PINMUX(36, 0, 1)>; /* ET1_RXD3 */
 	};
+
+	qspi0_pins: qspi0 {
+		qspi0-data {
+			pins = "QSPI0_IO0", "QSPI0_IO1", "QSPI0_IO2", "QSPI0_IO3";
+			power-source = <1800>;
+		};
+
+		qspi0-ctrl {
+			pins = "QSPI0_SPCLK", "QSPI0_SSL", "QSPI_RESET#";
+			power-source = <1800>;
+		};
+	};
+};
+
+&sbc {
+	pinctrl-0 = <&qspi0_pins>;
+	pinctrl-names = "default";
+	status = "okay";
+
+	flash@0 {
+		compatible = "micron,mt25qu512a", "jedec,spi-nor";
+		reg = <0>;
+		m25p,fast-read;
+		spi-max-frequency = <50000000>;
+		spi-rx-bus-width = <4>;
+
+		partitions {
+			compatible = "fixed-partitions";
+			#address-cells = <1>;
+			#size-cells = <1>;
+
+			boot@0 {
+				reg = <0x00000000 0x2000000>;
+				read-only;
+			};
+			user@2000000 {
+				reg = <0x2000000 0x2000000>;
+			};
+		};
+	};
 };
-- 
2.17.1


