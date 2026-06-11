Return-Path: <claudiu.beznea@tuxon.dev>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C748FCD98D8
	for <webhook@archiver.kernel.org>; Thu, 11 Jun 2026 10:47:29 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.42667.1781174847006630330
 for <cip-dev@lists.cip-project.org>;
 Thu, 11 Jun 2026 03:47:27 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: kernel.org, ip: 172.234.252.31, mailfrom: srs0=pbru=eh=tuxon.dev=claudiu.beznea@kernel.org)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id C96D64355C;
	Thu, 11 Jun 2026 10:47:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A1ED61F00893;
	Thu, 11 Jun 2026 10:47:25 +0000 (UTC)
From: Claudiu Beznea <claudiu.beznea@tuxon.dev>
To: nobuhiro.iwamatsu.x90@mail.toshiba,
	pavel@nabladev.com
Cc: cip-dev@lists.cip-project.org
Subject: [PATCH 6.12.y-cip 17/17] arm64: dts: renesas: rzg3s-smarc: Enable USB support
Date: Thu, 11 Jun 2026 13:46:56 +0300
Message-ID: <20260611104656.2533096-18-claudiu.beznea@tuxon.dev>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260611104656.2533096-1-claudiu.beznea@tuxon.dev>
References: <20260611104656.2533096-1-claudiu.beznea@tuxon.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 11 Jun 2026 10:47:29 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/23128

From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

commit 0926e6e69852a450dc2f6e3f8412ae58f773e29b upstream.

Enable USB support (host, device, USB PHYs).

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Tested-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Link: https://patch.msgid.link/20251023135810.1688415-8-claudiu.beznea.uj=
@bp.renesas.com
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
---
 arch/arm64/boot/dts/renesas/rzg3s-smarc.dtsi | 57 ++++++++++++++++++++
 1 file changed, 57 insertions(+)

diff --git a/arch/arm64/boot/dts/renesas/rzg3s-smarc.dtsi b/arch/arm64/bo=
ot/dts/renesas/rzg3s-smarc.dtsi
index d90f65a7d79b..071da86ed3dc 100644
--- a/arch/arm64/boot/dts/renesas/rzg3s-smarc.dtsi
+++ b/arch/arm64/boot/dts/renesas/rzg3s-smarc.dtsi
@@ -95,6 +95,20 @@ &audio_clk2 {
 	clock-frequency =3D <12288000>;
 };
=20
+&ehci0 {
+	dr_mode =3D "otg";
+	status =3D "okay";
+};
+
+&ehci1 {
+	status =3D "okay";
+};
+
+&hsusb {
+	dr_mode =3D "otg";
+	status =3D "okay";
+};
+
 &i2c0 {
 	status =3D "okay";
=20
@@ -128,6 +142,19 @@ &pcie {
 	status =3D "okay";
 };
=20
+&ohci0 {
+	dr_mode =3D "otg";
+	status =3D "okay";
+};
+
+&ohci1 {
+	status =3D "okay";
+};
+
+&phyrst {
+	status =3D "okay";
+};
+
 &pinctrl {
 	audio_clock_pins: audio-clock {
 		pins =3D "AUDIO_CLK1", "AUDIO_CLK2";
@@ -208,6 +235,23 @@ ssi3_pins: ssi3 {
 			 <RZG2L_PORT_PINMUX(18, 4, 8)>, /* TXD */
 			 <RZG2L_PORT_PINMUX(18, 5, 8)>; /* RXD */
 	};
+
+	usb0_pins: usb0 {
+		peri {
+			pinmux =3D <RZG2L_PORT_PINMUX(5, 0, 1)>, /* VBUS */
+				 <RZG2L_PORT_PINMUX(5, 2, 1)>; /* OVC */
+		};
+
+		otg {
+			pinmux =3D <RZG2L_PORT_PINMUX(5, 3, 1)>; /* OTG_ID */
+			bias-pull-up;
+		};
+	};
+
+	usb1_pins: usb1 {
+		pinmux =3D <RZG2L_PORT_PINMUX(5, 4, 5)>, /* OVC */
+			 <RZG2L_PORT_PINMUX(6, 0, 1)>; /* VBUS */
+	};
 };
=20
 &scif0 {
@@ -243,3 +287,16 @@ &ssi3 {
 	pinctrl-0 =3D <&ssi3_pins>, <&audio_clock_pins>;
 	status =3D "okay";
 };
+
+&usb2_phy0 {
+	pinctrl-0 =3D <&usb0_pins>;
+	pinctrl-names =3D "default";
+	vbus-supply =3D <&usb0_vbus_otg>;
+	status =3D "okay";
+};
+
+&usb2_phy1 {
+	pinctrl-0 =3D <&usb1_pins>;
+	pinctrl-names =3D "default";
+	status =3D "okay";
+};
--=20
2.43.0


