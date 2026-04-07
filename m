Return-Path: <prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75E9CF3D5E1
	for <webhook@archiver.kernel.org>; Tue,  7 Apr 2026 10:58:35 +0000 (UTC)
Received: from relmlie6.idc.renesas.com (relmlie6.idc.renesas.com [210.160.252.172])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.78638.1775559492699210337
 for <cip-dev@lists.cip-project.org>;
 Tue, 07 Apr 2026 03:58:28 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: bp.renesas.com, ip: 210.160.252.172, mailfrom: prabhakar.mahadev-lad.rj@bp.renesas.com)
X-CSE-ConnectionGUID: etKPjMxSTOSFY8wP96j0rw==
X-CSE-MsgGUID: KmMgIkCaTMieZcOIFECKgg==
Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie6.idc.renesas.com with ESMTP; 07 Apr 2026 19:58:28 +0900
Received: from Ubuntu-22.. (unknown [10.24.0.188])
	by relmlir5.idc.renesas.com (Postfix) with ESMTP id 333A44007F40;
	Tue,  7 Apr 2026 19:58:26 +0900 (JST)
From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro.iwamatsu.x90@mail.toshiba>,
	Pavel Machek <pavel@nabladev.com>
Cc: Biju Das <biju.das.jz@bp.renesas.com>
Subject: [PATCH 6.12.y-cip 10/10] arm64: dts: renesas: r9a09g087m44-rzn2h-evk: Enable CANFD
Date: Tue,  7 Apr 2026 11:58:08 +0100
Message-ID: <20260407105808.15196-11-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260407105808.15196-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20260407105808.15196-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 07 Apr 2026 10:58:35 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/22631

commit 3e6c313f4f996ce73b80873b8172610003e90f35 upstream.

Enable CANFD channel 1, which is available on the CN35 connector.

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Link: https://patch.msgid.link/20251224175204.3400062-5-prabhakar.mahadev-lad.rj@bp.renesas.com
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
[PL: fixed merge conflict]
Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
 .../dts/renesas/r9a09g087m44-rzn2h-evk.dts    | 29 +++++++++++++++++++
 1 file changed, 29 insertions(+)

diff --git a/arch/arm64/boot/dts/renesas/r9a09g087m44-rzn2h-evk.dts b/arch/arm64/boot/dts/renesas/r9a09g087m44-rzn2h-evk.dts
index 4d709419d1961..06f1c14560da9 100644
--- a/arch/arm64/boot/dts/renesas/r9a09g087m44-rzn2h-evk.dts
+++ b/arch/arm64/boot/dts/renesas/r9a09g087m44-rzn2h-evk.dts
@@ -27,6 +27,13 @@
 #define SD0_EMMC       1
 #define SD0_SD		(!SD0_EMMC)
 
+/*
+ * To enable CANFD interface disable both eMMC and SD card on SDHI0 by
+ * setting SD0_EMMC and SD0_SD macros to 0 as pins P12_0 and P12_1
+ * will be used for CANFD interface.
+ */
+#define CANFD_ENABLE	(!SD0_EMMC && !SD0_SD)
+
 /*
  * P17_4 = SD1_CD; DSW5[3] = ON; DSW19[1] = OFF; DSW19[2] = ON
  * P08_6 = SD1_IOVS; DSW5[3] = ON
@@ -234,6 +241,18 @@ channel@e {
 	};
 };
 
+#if CANFD_ENABLE
+&canfd {
+	pinctrl-0 = <&can1_pins>;
+	pinctrl-names = "default";
+	status = "okay";
+
+	channel1 {
+		status = "okay";
+	};
+};
+#endif
+
 #if I2C0
 &i2c0 {
 	pinctrl-0 = <&i2c0_pins>;
@@ -270,6 +289,16 @@ &mdio2_phy {
 };
 
 &pinctrl {
+	/*
+	 * CAN1 Pin Configuration:
+	 *
+	 * DSW5[1] ON; DSW5[2] OFF - Use P12_0 and P12_1 for CAN1 interface.
+	 */
+	can1_pins: can1-pins {
+		pinmux = <RZT2H_PORT_PINMUX(12, 0, 0x19)>, /* CANRX1 */
+			 <RZT2H_PORT_PINMUX(12, 1, 0x19)>; /* CANTX1 */
+	};
+
 	/*
 	 * GMAC2 Pin Configuration:
 	 *
-- 
2.43.0


