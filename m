Return-Path: <claudiu.beznea@tuxon.dev>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9702C0650F
	for <webhook@archiver.kernel.org>; Fri, 19 Apr 2024 08:18:58 +0000 (UTC)
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
 by mx.groups.io with SMTP id smtpd.web10.15324.1713514734443534846
 for <cip-dev@lists.cip-project.org>;
 Fri, 19 Apr 2024 01:18:54 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@tuxon.dev header.s=google header.b=C74+xV+3;
 spf=pass (domain: tuxon.dev, ip: 209.85.208.48, mailfrom: claudiu.beznea@tuxon.dev)
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-56e1baf0380so2217843a12.3
        for <cip-dev@lists.cip-project.org>; Fri, 19 Apr 2024 01:18:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1713514733; x=1714119533; darn=lists.cip-project.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+koA+k2fr7wHU+VjcT+5RsRvgBNR2RkwrPVHgPa2QP4=;
        b=C74+xV+308fq4nbdhiAF7WtXJeXH0Zci3QZG0FKwiDn1rKxnB6FUqP1EvjIqVZ+mxY
         3AEcgcxCuB6/Xt5Jcw1v18VosmgfJopG56T+ia2v4Fm+ow/Z2tlzxXil9ZmJn0HLr2sX
         tiL3ry3gcB9AA3gF4yEA9ZCHN1HieEWznaahdScE72VPnga3G/EasoCZ+TGIi7jpIObl
         pRwWZ4585xGuQ+geZyoRNt/Hq9TBQijJpVcVuElrpo5dP/84YFqq8xfq5rSf1XOhbsfL
         PId9fwe9yT+38/bsC4LinbU+NDJdS/bQvwXX3S6/yazkjClOAQig3EmHFGu7FEmH6Usc
         RDdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713514733; x=1714119533;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+koA+k2fr7wHU+VjcT+5RsRvgBNR2RkwrPVHgPa2QP4=;
        b=wMtipZDaploPPX35vvRrLtDYBuKXxD847tOgRRqCKYmWd9Qv/Ul+cNhquhZSh6QLEs
         AKEPhBr1thfEXWS+y1EZnamhI79SRA3LxuZYkLLWaap94GsJSYt9dOC7wg7684jDdTEa
         P4m0212JLsS9SPqoOf3wlPctTZJNWKobWPiGPMbpCJVinNd44hoXZ3EXRbaYL4hOs7Hb
         dJg+FNsZknyugpY1f3veNrf8d9PJzGDmYt1zgO5Wy56GnHrwfMbGEFnV2PJLSfjC19pn
         owHo2BR9YqyoDFVgkDqbdcD+Tl6evyNbL/b9GwzeodTgyZxNYui9qUYCilIuRCNZb/0K
         UiWw==
X-Gm-Message-State: AOJu0Ywj+M5vC98vgk2vqrnU2qFbpmLkYM838c9uMPMiJJxGQhzLb57v
	W50lTbuEPi4ViPLdNugUQZpxWUhoepzx27ynxvQ2HudE1kJFpBfcnhn8MBTswzo=
X-Google-Smtp-Source: AGHT+IEQTDcAV9R62Q2RJmpCpbsabr01SSFymhKY4QQDsQb9jG3N7vj+ZHN0IOjbdc0BJ81SAia18Q==
X-Received: by 2002:a17:907:1109:b0:a55:33a5:911c with SMTP id qu9-20020a170907110900b00a5533a5911cmr849952ejb.25.1713514732847;
        Fri, 19 Apr 2024 01:18:52 -0700 (PDT)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.185])
        by smtp.gmail.com with ESMTPSA id w23-20020a170907271700b00a556f2f18d6sm1816243ejk.57.2024.04.19.01.18.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Apr 2024 01:18:52 -0700 (PDT)
From: Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To: nobuhiro1.iwamatsu@toshiba.co.jp,
	pavel@denx.de
Cc: cip-dev@lists.cip-project.org,
	biju.das.jz@bp.renesas.com,
	prabhakar.mahadev-lad.rj@bp.renesas.com,
	claudiu.beznea@tuxon.dev
Subject: [PATCH 5.10.y-cip 45/53] arm64: dts: renesas: Add initial support for RZ/G3S SMARC SoM
Date: Fri, 19 Apr 2024 11:17:34 +0300
Message-Id: <20240419081742.3496709-46-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240419081742.3496709-1-claudiu.beznea.uj@bp.renesas.com>
References: <20240419081742.3496709-1-claudiu.beznea.uj@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 19 Apr 2024 08:18:58 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/15632

From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

commit adb4f0c5699c45d0034abde786e748250705a3b6 upstream.

Add initial support for the RZ/G3S SMARC SoM.  The following devices
available on the SoM are added to this initial device tree:
  - RZ/G3S SoC: Renesas R9A08G045S33GBG
  - Clock Generator (only 24MHz output): Renesas 5L35023B
  - 1GiB LPDDR4 SDRAM: Micron MT53D512M16D1DS-046
  - 64GB eMMC Flash (though SD ch0): Micron MTFC64GBCAQTC

SD channel 0 of RZ/G3S is connected to an uSD card interface and an
eMMC.  The selection b/w them is done through a hardware switch.  The DT
will select b/w uSD and eMMC through the SW_SD0_DEV_SEL build flag.

Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Link: https://lore.kernel.org/r/20230929053915.1530607-25-claudiu.beznea@bp.renesas.com
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
---
 .../boot/dts/renesas/rzg3s-smarc-som.dtsi     | 142 ++++++++++++++++++
 1 file changed, 142 insertions(+)
 create mode 100644 arch/arm64/boot/dts/renesas/rzg3s-smarc-som.dtsi

diff --git a/arch/arm64/boot/dts/renesas/rzg3s-smarc-som.dtsi b/arch/arm64/boot/dts/renesas/rzg3s-smarc-som.dtsi
new file mode 100644
index 000000000000..185ca8289a35
--- /dev/null
+++ b/arch/arm64/boot/dts/renesas/rzg3s-smarc-som.dtsi
@@ -0,0 +1,142 @@
+// SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+/*
+ * Device Tree Source for the R9A08G045S33 SMARC Carrier-II's SoM board.
+ *
+ * Copyright (C) 2023 Renesas Electronics Corp.
+ */
+
+#include <dt-bindings/gpio/gpio.h>
+#include <dt-bindings/pinctrl/rzg2l-pinctrl.h>
+
+/*
+ * Signals of SW_CONFIG switches:
+ * @SW_SD0_DEV_SEL:
+ *	0 - SD0 is connected to eMMC
+ *	1 - SD0 is connected to uSD0 card
+ */
+#define SW_SD0_DEV_SEL	1
+
+/ {
+	compatible = "renesas,rzg3s-smarcm", "renesas,r9a08g045s33", "renesas,r9a08g045";
+
+	aliases {
+		mmc0 = &sdhi0;
+	};
+
+	chosen {
+		bootargs = "ignore_loglevel";
+		stdout-path = "serial0:115200n8";
+	};
+
+	memory@48000000 {
+		device-type = "memory";
+		/* First 128MB is reserved for secure area. */
+		reg = <0x0 0x48000000 0x0 0x38000000>;
+	};
+
+	vcc_sdhi0: regulator0 {
+		compatible = "regulator-fixed";
+		regulator-name = "SDHI0 Vcc";
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+		gpios = <&pinctrl RZG2L_GPIO(2, 1) GPIO_ACTIVE_HIGH>;
+		enable-active-high;
+	};
+
+#if SW_SD0_DEV_SEL
+	vccq_sdhi0: regulator1 {
+		compatible = "regulator-gpio";
+		regulator-name = "SDHI0 VccQ";
+		regulator-min-microvolt = <1800000>;
+		regulator-max-microvolt = <3300000>;
+		gpios = <&pinctrl RZG2L_GPIO(2, 2) GPIO_ACTIVE_HIGH>;
+		gpios-states = <1>;
+		states = <3300000 1>, <1800000 0>;
+	};
+#else
+	reg_1p8v: regulator1 {
+		compatible = "regulator-fixed";
+		regulator-name = "fixed-1.8V";
+		regulator-min-microvolt = <1800000>;
+		regulator-max-microvolt = <1800000>;
+		regulator-boot-on;
+		regulator-always-on;
+	};
+#endif
+};
+
+&extal_clk {
+	clock-frequency = <24000000>;
+};
+
+#if SW_SD0_DEV_SEL
+/* SD0 slot */
+&sdhi0 {
+	pinctrl-0 = <&sdhi0_pins>;
+	pinctrl-1 = <&sdhi0_uhs_pins>;
+	pinctrl-names = "default", "state_uhs";
+	vmmc-supply = <&vcc_sdhi0>;
+	vqmmc-supply = <&vccq_sdhi0>;
+	bus-width = <4>;
+	sd-uhs-sdr50;
+	sd-uhs-sdr104;
+	max-frequency = <125000000>;
+	status = "okay";
+};
+#else
+/* eMMC */
+&sdhi0 {
+	pinctrl-0 = <&sdhi0_emmc_pins>;
+	pinctrl-1 = <&sdhi0_emmc_pins>;
+	pinctrl-names = "default", "state_uhs";
+	vmmc-supply = <&vcc_sdhi0>;
+	vqmmc-supply = <&reg_1p8v>;
+	bus-width = <8>;
+	mmc-hs200-1_8v;
+	non-removable;
+	fixed-emmc-driver-type = <1>;
+	max-frequency = <125000000>;
+	status = "okay";
+};
+#endif
+
+&pinctrl {
+	sdhi0_pins: sd0 {
+		data {
+			pins = "SD0_DATA0", "SD0_DATA1", "SD0_DATA2", "SD0_DATA3";
+			power-source = <3300>;
+		};
+
+		ctrl {
+			pins = "SD0_CLK", "SD0_CMD";
+			power-source = <3300>;
+		};
+
+		cd {
+			pinmux = <RZG2L_PORT_PINMUX(0, 0, 1)>; /* SD0_CD */
+		};
+	};
+
+	sdhi0_uhs_pins: sd0-uhs {
+		data {
+			pins = "SD0_DATA0", "SD0_DATA1", "SD0_DATA2", "SD0_DATA3";
+			power-source = <1800>;
+		};
+
+		ctrl {
+			pins = "SD0_CLK", "SD0_CMD";
+			power-source = <1800>;
+		};
+
+		cd {
+			pinmux = <RZG2L_PORT_PINMUX(0, 0, 1)>; /* SD0_CD */
+		};
+	};
+
+	sdhi0_emmc_pins: sd0-emmc {
+		pins = "SD0_DATA0", "SD0_DATA1", "SD0_DATA2", "SD0_DATA3",
+		       "SD0_DATA4", "SD0_DATA5", "SD0_DATA6", "SD0_DATA7",
+		       "SD0_CLK", "SD0_CMD", "SD0_RST#";
+		power-source = <1800>;
+	};
+};
-- 
2.39.2


