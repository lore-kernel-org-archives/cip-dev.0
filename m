Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.15819.1794916024790141533
 for <cip-dev@lists.cip-project.org>;
 Tue, 17 Nov 2026 03:47:04 -0800
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: kernel.org, ip: 172.234.252.31, mailfrom: srs0=gktq=jg=tuxon.dev=claudiu.beznea@kernel.org)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 9450B415CD;
	Tue, 17 Nov 2026 11:47:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 680361F000C4;
	Tue, 17 Nov 2026 11:47:03 +0000 (UTC)
From: Claudiu Beznea <claudiu.beznea@tuxon.dev>
To: nobuhiro.iwamatsu.x90@mail.toshiba,
	pavel@nabladev.com
Cc: claudiu.beznea@tuxon.dev,
	cip-dev@lists.cip-project.org
Subject: [PATCH 5.10.y-cip 42/69] arm64: dts: renesas: r9a08g045: Add I3C node
Date: Tue, 17 Nov 2026 13:45:26 +0200
Message-ID: <20261117114553.1484215-43-claudiu.beznea@tuxon.dev>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261117114553.1484215-1-claudiu.beznea@tuxon.dev>
References: <20261117114553.1484215-1-claudiu.beznea@tuxon.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by lin-tor-korg-lkml-alma10-1 with HTTPS for <cip-dev@lists.cip-project.org>; Tue, 17 Nov 2026 11:47:14 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/24883
Content-Type: text/plain; charset="utf-8"

From: Quynh Nguyen <quynh.nguyen.xb@renesas.com>

commit cd09e96fbac54fa962750c8cecea4d3d5e7e72ae upstream.

Add the I3C node to RZ/G3S SoC DTSI.

Signed-off-by: Quynh Nguyen <quynh.nguyen.xb@renesas.com>
[wsa: adapted to upstream driver, moved bus frequencies to board file]
Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
Reviewed-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Link: https://lore.kernel.org/20250807151434.5241-7-wsa+renesas@sang-engi=
neering.com
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
[claudiu.beznea: fixed conflict b/w TSU and I3C nodes by keeping them
 both]
Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
---
 arch/arm64/boot/dts/renesas/r9a08g045.dtsi | 36 ++++++++++++++++++++++
 1 file changed, 36 insertions(+)

diff --git a/arch/arm64/boot/dts/renesas/r9a08g045.dtsi b/arch/arm64/boot=
/dts/renesas/r9a08g045.dtsi
index c386d92499e1..18457dc19cd7 100644
--- a/arch/arm64/boot/dts/renesas/r9a08g045.dtsi
+++ b/arch/arm64/boot/dts/renesas/r9a08g045.dtsi
@@ -282,6 +282,42 @@ tsu: thermal@10059000 {
 			io-channel-names =3D "tsu";
 		};
=20
+		i3c: i3c@1005b000 {
+			compatible =3D "renesas,r9a08g045-i3c";
+			reg =3D <0 0x1005b000 0 0x1000>;
+			clocks =3D <&cpg CPG_MOD R9A08G045_I3C_PCLK>,
+				 <&cpg CPG_MOD R9A08G045_I3C_TCLK>;
+			clock-names =3D "pclk", "tclk";
+			interrupts =3D <GIC_SPI 289 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 290 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 293 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 294 IRQ_TYPE_EDGE_RISING>,
+				     <GIC_SPI 295 IRQ_TYPE_EDGE_RISING>,
+				     <GIC_SPI 296 IRQ_TYPE_EDGE_RISING>,
+				     <GIC_SPI 297 IRQ_TYPE_EDGE_RISING>,
+				     <GIC_SPI 298 IRQ_TYPE_EDGE_RISING>,
+				     <GIC_SPI 299 IRQ_TYPE_EDGE_RISING>,
+				     <GIC_SPI 304 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 305 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 307 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 308 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 309 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 310 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 311 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 306 IRQ_TYPE_LEVEL_HIGH>;
+			interrupt-names =3D "ierr", "terr", "abort", "resp",
+					  "cmd", "ibi", "rx", "tx", "rcv",
+					  "st", "sp", "tend", "nack", "al",
+					  "tmo", "wu", "exit";
+			resets =3D <&cpg R9A08G045_I3C_PRESETN>,
+				 <&cpg R9A08G045_I3C_TRESETN>;
+			reset-names =3D "presetn", "tresetn";
+			power-domains =3D <&cpg>;
+			#address-cells =3D <3>;
+			#size-cells =3D <0>;
+			status =3D "disabled";
+		};
+
 		vbattb: clock-controller@1005c000 {
 			compatible =3D "renesas,r9a08g045-vbattb";
 			reg =3D <0 0x1005c000 0 0x1000>;
--=20
2.43.0

