Return-Path: <biju.das.jz@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 991F6CA0EF8
	for <webhook@archiver.kernel.org>; Wed, 20 Aug 2025 08:47:50 +0000 (UTC)
Received: from relmlie5.idc.renesas.com (relmlie5.idc.renesas.com [210.160.252.171])
 by mx.groups.io with SMTP id smtpd.web11.15483.1755679656199304806
 for <cip-dev@lists.cip-project.org>;
 Wed, 20 Aug 2025 01:47:44 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: bp.renesas.com, ip: 210.160.252.171, mailfrom: biju.das.jz@bp.renesas.com)
X-CSE-ConnectionGUID: AGUgwKguQLuuHHF9xGT+zQ==
X-CSE-MsgGUID: 6fzw0wpkTmG2AkzEHwvmKw==
Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie5.idc.renesas.com with ESMTP; 20 Aug 2025 17:47:44 +0900
Received: from localhost.localdomain (unknown [10.226.92.43])
	by relmlir5.idc.renesas.com (Postfix) with ESMTP id 76AB340138ED;
	Wed, 20 Aug 2025 17:47:42 +0900 (JST)
From: Biju Das <biju.das.jz@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
Cc: Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH 6.12.y-cip 23/23] arm64: dts: renesas: rzg3e-smarc-som: Enable serial NOR FLASH
Date: Wed, 20 Aug 2025 09:46:09 +0100
Message-ID: <20250820084645.6988-24-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250820084645.6988-1-biju.das.jz@bp.renesas.com>
References: <20250820084645.6988-1-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 20 Aug 2025 08:47:50 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/19818

commit 0712fcaebd76a74a022e5ce105ebe96fa8627961 upstream.

Enable Renesas AT25QL128A FLASH connected to XSPI.

Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Link: https://lore.kernel.org/20250508183109.137721-3-biju.das.jz@bp.renesas.com
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
 .../boot/dts/renesas/rzg3e-smarc-som.dtsi     | 46 +++++++++++++++++++
 1 file changed, 46 insertions(+)

diff --git a/arch/arm64/boot/dts/renesas/rzg3e-smarc-som.dtsi b/arch/arm64/boot/dts/renesas/rzg3e-smarc-som.dtsi
index ecea29a76b144..f99a09d04ddd4 100644
--- a/arch/arm64/boot/dts/renesas/rzg3e-smarc-som.dtsi
+++ b/arch/arm64/boot/dts/renesas/rzg3e-smarc-som.dtsi
@@ -182,6 +182,15 @@ sd2-pwen {
 			pinmux = <RZG3E_PORT_PINMUX(K, 2, 1)>; /* SD2PWEN */
 		};
 	};
+
+	xspi_pins: xspi0 {
+		pinmux = <RZG3E_PORT_PINMUX(M, 0, 0)>, /* XSPI0_IO0 */
+			 <RZG3E_PORT_PINMUX(M, 1, 0)>, /* XSPI0_IO1 */
+			 <RZG3E_PORT_PINMUX(M, 2, 0)>, /* XSPI0_IO2 */
+			 <RZG3E_PORT_PINMUX(M, 3, 0)>, /* XSPI0_IO3 */
+			 <RZG3E_PORT_PINMUX(L, 0, 0)>, /* XSPI0_CKP */
+			 <RZG3E_PORT_PINMUX(L, 1, 0)>; /* XSPI0_CS0 */
+	};
 };
 
 &qextal_clk {
@@ -245,3 +254,40 @@ &sdhi2_vqmmc {
 &wdt1 {
 	status = "okay";
 };
+
+&xspi {
+	pinctrl-0 = <&xspi_pins>;
+	pinctrl-names = "default";
+	status = "okay";
+
+	flash@0 {
+		compatible = "jedec,spi-nor";
+		reg = <0>;
+		vcc-supply = <&reg_1p8v>;
+		m25p,fast-read;
+		spi-max-frequency = <50000000>;
+		spi-tx-bus-width = <4>;
+		spi-rx-bus-width = <4>;
+
+		partitions {
+			compatible = "fixed-partitions";
+			#address-cells = <1>;
+			#size-cells = <1>;
+
+			partition@0 {
+				label = "bl2";
+				reg = <0x00000000 0x00060000>;
+			};
+
+			partition@60000 {
+				label = "fip";
+				reg = <0x00060000 0x007a0000>;
+			};
+
+			partition@800000 {
+				label = "user";
+				reg = <0x800000 0x800000>;
+			};
+		};
+	};
+};
-- 
2.43.0


