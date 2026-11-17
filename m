Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.15825.1794916030919583541
 for <cip-dev@lists.cip-project.org>;
 Tue, 17 Nov 2026 03:47:10 -0800
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: kernel.org, ip: 172.234.252.31, mailfrom: srs0=gktq=jg=tuxon.dev=claudiu.beznea@kernel.org)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id B362343CC8;
	Tue, 17 Nov 2026 11:47:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 893691F000C4;
	Tue, 17 Nov 2026 11:47:09 +0000 (UTC)
From: Claudiu Beznea <claudiu.beznea@tuxon.dev>
To: nobuhiro.iwamatsu.x90@mail.toshiba,
	pavel@nabladev.com
Cc: claudiu.beznea@tuxon.dev,
	cip-dev@lists.cip-project.org
Subject: [PATCH 5.10.y-cip 46/69] arm64: dts: renesas: rzg3s-smarc-som: Enable I3C
Date: Tue, 17 Nov 2026 13:45:30 +0200
Message-ID: <20261117114553.1484215-47-claudiu.beznea@tuxon.dev>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261117114553.1484215-1-claudiu.beznea@tuxon.dev>
References: <20261117114553.1484215-1-claudiu.beznea@tuxon.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by lin-tor-korg-lkml-alma10-1 with HTTPS for <cip-dev@lists.cip-project.org>; Tue, 17 Nov 2026 11:47:14 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/24887
Content-Type: text/plain; charset="utf-8"

From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

commit 7953f601285c559263fd082fed44d738f2fc0466 upstream.

The Renesas RZ/G3S SMARC SoM board has a connector for I3C interface.
Enable I3C.

Reviewed-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
Tested-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Link: https://patch.msgid.link/20260710113637.1328000-6-claudiu.beznea+re=
nesas@tuxon.dev
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
---
 .../boot/dts/renesas/rzg3s-smarc-som.dtsi      | 18 ++++++++++++++++++
 .../boot/dts/renesas/rzg3s-smarc-switches.h    |  4 ++++
 2 files changed, 22 insertions(+)

diff --git a/arch/arm64/boot/dts/renesas/rzg3s-smarc-som.dtsi b/arch/arm6=
4/boot/dts/renesas/rzg3s-smarc-som.dtsi
index e2a9b56df762..8bfaad700253 100644
--- a/arch/arm64/boot/dts/renesas/rzg3s-smarc-som.dtsi
+++ b/arch/arm64/boot/dts/renesas/rzg3s-smarc-som.dtsi
@@ -170,6 +170,14 @@ a0 80 30 30 9c
 	};
 };
=20
+&i3c {
+	pinctrl-names =3D "default";
+	pinctrl-0 =3D <&i3c_pins>;
+	i2c-scl-hz =3D <400000>;
+	i3c-scl-hz =3D <12500000>;
+	status =3D "okay";
+};
+
 &pcie_port0 {
 	clocks =3D <&versa3 5>;
 	clock-names =3D "ref";
@@ -301,6 +309,16 @@ mux {
 		};
 	};
=20
+	i3c_pins: i3c {
+		pins =3D "I3C_SDA", "I3C_SCL";
+#if SW_CONFIG4 =3D=3D SW_ON
+		power-source =3D <1200>;
+#else
+		power-source =3D <1800>;
+#endif
+		input-enable;
+	};
+
 	sdhi0_pins: sd0 {
 		data {
 			pins =3D "SD0_DATA0", "SD0_DATA1", "SD0_DATA2", "SD0_DATA3";
diff --git a/arch/arm64/boot/dts/renesas/rzg3s-smarc-switches.h b/arch/ar=
m64/boot/dts/renesas/rzg3s-smarc-switches.h
index bbf908a5322c..9cccc87da057 100644
--- a/arch/arm64/boot/dts/renesas/rzg3s-smarc-switches.h
+++ b/arch/arm64/boot/dts/renesas/rzg3s-smarc-switches.h
@@ -25,9 +25,13 @@
  * @SW_CONFIG3:
  *	SW_OFF - SD2 is connected to SoC
  *	SW_ON  - SCIF1, SSI0, IRQ0, IRQ1 connected to SoC
+ * @SW_CONFIG4:
+ *	SW_OFF - I3C voltage is 1.8V
+ *	SW_ON  - I3C voltage is 1.2V
  */
 #define SW_CONFIG2	SW_OFF
 #define SW_CONFIG3	SW_ON
+#define SW_CONFIG4	SW_OFF
=20
 /*
  * SW_OPT_MUX[x] switches' states:
--=20
2.43.0

