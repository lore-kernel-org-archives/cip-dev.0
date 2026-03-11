Return-Path: <biju.das.au@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A1DE104BEC9
	for <webhook@archiver.kernel.org>; Wed, 11 Mar 2026 10:05:28 +0000 (UTC)
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.17665.1773223518228138805
 for <cip-dev@lists.cip-project.org>;
 Wed, 11 Mar 2026 03:05:18 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=mOeC3NXo;
 spf=pass (domain: gmail.com, ip: 209.85.221.44, mailfrom: biju.das.au@gmail.com)
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-439af7d77f0so9127088f8f.0
        for <cip-dev@lists.cip-project.org>; Wed, 11 Mar 2026 03:05:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773223516; x=1773828316; darn=lists.cip-project.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3hu3+e1qLnT1orQ0YAq0l8xS1biH/ES2IjhVBU+by34=;
        b=mOeC3NXolMPqIVCe+kKCa71tNlM4M3n11tOqpp3QVbjZpPvVhpiaA2NM+rgUPYtvdg
         S+3PAB84lWkr4sicQpxGI/Jl+EuMNPyt+rexnWyWCrOv3+oH+QqI5vg83LcNxOtqvXg0
         GfPwmv6cIX0dcwK9x+ijpFjCqlC3Y0SGWiBRYvs5tS7c/w+nSgvEo4FqAL/zMDxoZr5O
         nZ3vMT8lgSkAbZa/95U6FDe4nUqT2hI1SWevzGDsZipDXcwTKZT+DOTWowniDftXm7AK
         vyCU2qARU7ArwlhU/NqLocB+7foFCJTdPvRoTVRmWlkoeajxXa750WQa1yTohyYpDYvV
         CgLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773223516; x=1773828316;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=3hu3+e1qLnT1orQ0YAq0l8xS1biH/ES2IjhVBU+by34=;
        b=Jom7GfuaMkRVYu1dzu9J/qHJ5Yu5kn98e7xNt6cS0A8CxfTxWUhL3yW3tvx7In6MQg
         GyHqg0B77yUUtZf7AePHQ5Nj6RCw2eEzvwaRJ+m5qWm9/N2z+vr8HetJUHzwjJJwoIfq
         FEtyhonzxeuCzzPIfcMFubLJ+IqyyNkPWrG/cPrYLYmBs3m2aKHR9FkVp0OXhENDa+im
         QWXBPcwZ9W6pz2hPwOSO9VZVfkflg4yLR4awM7iZKSO7gkxYZRx5rExqS06km6EH5ezU
         1PyspTgRh38P61DsWsuFAZWH7oR8nixb4610RTSVpvPxkEAgb9BsGyN7Qc1n6g/HvzS9
         Hy1Q==
X-Gm-Message-State: AOJu0Yx3xd5kpa3YPZUAG2aV3S3klTAIK5i4XgJ3ghDz1novvFfrzQHv
	DVJ7aa8mXju6qXUGBjzwKJdSagbZ+A5bERQmCY44S/CcviFOYbrNq03xp5LCOg==
X-Gm-Gg: ATEYQzyjCxjVLaC952O13315myJGemGMd2EQQHmNE8BrlrTLeuKI+4CxEs3Xq4AiPrp
	O2CkWK+ucL89gehgSJ/BxMXUbBGEn+ZsnsM2xv+Ztxwl5eBq6yO/Q6XaDO59JSzcdKVG3o6PvDN
	Ympk7NJb62zg4EkicRj88HoxMNNjHGDwz2Z0e2A7LnSVqDJpRSzNRIakUjUYA+qTo9Mz91UIJIS
	ce5fZlXTREVsqNCvh09okxTMvg7GtxmBiUq0WBs5TTlT06s9mnh+TZngi9zeK5m/rlQazzSvxOJ
	Q2N3Y1BET1XcuckY3gF5jBxFPyQgpk0QznxNfYPIogBWM2Fdt6rbj+Advj0UotOOwSqdmnBu7eL
	DK4ntcTnHFUQjP7pWpjZMR401IFohX3T8ytl7ABxgEPKmeN9neIWFW2cLgyWxU00cgz3F1AmUzJ
	288/fCZIvUcNPDDwGQME6Kouk6S5CFlb8=
X-Received: by 2002:a05:6000:2302:b0:439:ab3d:1c27 with SMTP id ffacd0b85a97d-439f81f2500mr3846952f8f.2.1773223516376;
        Wed, 11 Mar 2026 03:05:16 -0700 (PDT)
Received: from biju.lan ([2a00:23c4:a758:8a01:38b7:8ca3:cb55:d344])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-439f81acc22sm5177153f8f.16.2026.03.11.03.05.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Mar 2026 03:05:16 -0700 (PDT)
From: Biju <biju.das.au@gmail.com>
X-Google-Original-From: Biju <biju.das.jz@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro.iwamatsu.x90@mail.toshiba>,
	Pavel Machek <pavel@nabladev.com>
Cc: Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH 6.12.y-cip v2 27/27] arm64: dts: renesas: r9a09g047e57-smarc: Enable rsci{2,4,9} nodes
Date: Wed, 11 Mar 2026 10:04:46 +0000
Message-ID: <20260311100458.162447-28-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260311100458.162447-1-biju.das.jz@bp.renesas.com>
References: <20260311100458.162447-1-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 11 Mar 2026 10:05:28 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/22273

From: Biju Das <biju.das.jz@bp.renesas.com>

[ Upstream commit 835666e7403c3ddc6f3122888d975464f8272efe ]

Enable device rsci{2,4,9} nodes for the RZ/G3E SMARC EVK.

Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Link: https://patch.msgid.link/20251129185203.380002-4-biju.das.jz@bp.renesas.com
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
 .../boot/dts/renesas/r9a09g047e57-smarc.dts   | 58 +++++++++++++++++++
 .../boot/dts/renesas/renesas-smarc2.dtsi      |  7 +++
 .../boot/dts/renesas/rzg3e-smarc-som.dtsi     |  4 ++
 3 files changed, 69 insertions(+)

diff --git a/arch/arm64/boot/dts/renesas/r9a09g047e57-smarc.dts b/arch/arm64/boot/dts/renesas/r9a09g047e57-smarc.dts
index a612c9784f1e..342b885006e9 100644
--- a/arch/arm64/boot/dts/renesas/r9a09g047e57-smarc.dts
+++ b/arch/arm64/boot/dts/renesas/r9a09g047e57-smarc.dts
@@ -12,6 +12,8 @@
 #define SW_GPIO9_CAN1_STB	0
 #define SW_LCD_EN		0
 #define SW_PDM_EN		0
+#define SW_SER0_PMOD		1
+#define SW_SER2_EN		1
 #define SW_SD0_DEV_SEL		0
 #define SW_SDIO_M2E		0
 
@@ -37,6 +39,9 @@ / {
 
 	aliases {
 		i2c0 = &i2c0;
+		serial0 = &rsci4;
+		serial1 = &rsci9;
+		serial2 = &rsci2;
 		serial3 = &scif0;
 		mmc1 = &sdhi1;
 	};
@@ -140,6 +145,28 @@ nmi_pins: nmi {
 		input-schmitt-enable;
 	};
 
+	rsci2_pins: rsci2 {
+		pinmux = <RZG3E_PORT_PINMUX(1, 0, 1)>, /* RXD2 */
+			 <RZG3E_PORT_PINMUX(1, 1, 1)>, /* TXD2 */
+			 <RZG3E_PORT_PINMUX(1, 2, 6)>, /* CTS2N */
+			 <RZG3E_PORT_PINMUX(1, 3, 1)>; /* RTS2N */
+		bias-pull-up;
+	};
+
+	rsci4_pins: rsci4 {
+		pinmux = <RZG3E_PORT_PINMUX(7, 6, 5)>, /* RXD4 */
+			 <RZG3E_PORT_PINMUX(7, 7, 5)>, /* TXD4 */
+			 <RZG3E_PORT_PINMUX(8, 0, 6)>, /* CTS4N */
+			 <RZG3E_PORT_PINMUX(8, 1, 5)>; /* RTS4N */
+		bias-pull-up;
+	};
+
+	rsci9_pins: rsci9 {
+		pinmux = <RZG3E_PORT_PINMUX(8, 2, 5)>, /* RXD9 */
+			 <RZG3E_PORT_PINMUX(8, 3, 5)>; /* TXD9 */
+		bias-pull-up;
+	};
+
 	scif_pins: scif {
 		pins = "SCIF_TXD", "SCIF_RXD";
 		renesas,output-impedance = <1>;
@@ -171,6 +198,37 @@ sd1-data {
 	};
 };
 
+#if SW_SER0_PMOD && SW_SER2_EN
+&rsci2 {
+	pinctrl-0 = <&rsci2_pins>;
+	pinctrl-names = "default";
+
+	uart-has-rtscts;
+
+	status = "okay";
+};
+#endif
+
+#if (!SW_LCD_EN) && (SW_SER0_PMOD)
+&rsci4 {
+	pinctrl-0 = <&rsci4_pins>;
+	pinctrl-names = "default";
+
+	uart-has-rtscts;
+
+	status = "okay";
+};
+#endif
+
+#if (!SW_LCD_EN)
+&rsci9 {
+	pinctrl-0 = <&rsci9_pins>;
+	pinctrl-names = "default";
+
+	status = "okay";
+};
+#endif
+
 &scif0 {
 	pinctrl-0 = <&scif_pins>;
 	pinctrl-names = "default";
diff --git a/arch/arm64/boot/dts/renesas/renesas-smarc2.dtsi b/arch/arm64/boot/dts/renesas/renesas-smarc2.dtsi
index a296c2c1c7ab..69c0101ff7f5 100644
--- a/arch/arm64/boot/dts/renesas/renesas-smarc2.dtsi
+++ b/arch/arm64/boot/dts/renesas/renesas-smarc2.dtsi
@@ -13,6 +13,13 @@
  *     0 - SMARC SDIO signal is connected to uSD1
  *     1 - SMARC SDIO signal is connected to M.2 Key E connector
  *
+ * Please set the switch position SW_OPT_MUX.4 on the carrier board and the
+ * corresponding macro SW_SER0_PMOD on the board DTS:
+ *
+ * SW_SER0_PMOD:
+ *     0 - SER0 signals connect to M.2 Key-E, SER2 signals are unconnected
+ *     1 - SER0 signals connect to PMOD, SER2 signals connect to M.2 Key-E
+ *
  * Please set the switch position SW_GPIO_CAN_PMOD on the carrier board and the
  * corresponding macro SW_GPIO8_CAN0_STB/SW_GPIO8_CAN0_STB on the board DTS:
  *
diff --git a/arch/arm64/boot/dts/renesas/rzg3e-smarc-som.dtsi b/arch/arm64/boot/dts/renesas/rzg3e-smarc-som.dtsi
index f05b9fec05f0..3b571c096752 100644
--- a/arch/arm64/boot/dts/renesas/rzg3e-smarc-som.dtsi
+++ b/arch/arm64/boot/dts/renesas/rzg3e-smarc-som.dtsi
@@ -13,6 +13,10 @@
  *      0 - SD0 is connected to eMMC (default)
  *      1 - SD0 is connected to uSD0 card
  *
+ * Switch position SYS.4, Macro SW_SER2_EN:
+ *      0 - Select Module DSI connector(GPIO)
+ *      1 - Select SER2
+ *
  * Switch position SYS.5, Macro SW_LCD_EN:
  *      0 - Select Misc. Signals routing
  *      1 - Select LCD
-- 
2.43.0


