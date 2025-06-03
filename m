Return-Path: <claudiu.beznea@tuxon.dev>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4289BC61DB8
	for <webhook@archiver.kernel.org>; Tue,  3 Jun 2025 09:19:17 +0000 (UTC)
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
 by mx.groups.io with SMTP id smtpd.web10.6972.1748942355407416292
 for <cip-dev@lists.cip-project.org>;
 Tue, 03 Jun 2025 02:19:15 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@tuxon.dev header.s=google header.b=dW4BXWNo;
 spf=pass (domain: tuxon.dev, ip: 209.85.218.53, mailfrom: claudiu.beznea@tuxon.dev)
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-ad55d6aeb07so831320266b.0
        for <cip-dev@lists.cip-project.org>; Tue, 03 Jun 2025 02:19:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1748942354; x=1749547154; darn=lists.cip-project.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3ulf0cVULEVjd3FMNDXawEk2wi456eqZrTpHloMzMNE=;
        b=dW4BXWNojzvFHVC5RSnD+ltFGMvfKXM4K41SjjtW2vISrrrPRG5ijSlweGz34ahzLS
         hBP7MAYs4DqyVPypEsjQNDd6yCSFj7rChEXXSmrfZjYk8eJFdoyLsmbXtpFZ4MwSsfjV
         8AEJmqoIud+llWhaD2JZWZqebx4J7+DZ8DiChs67CrwNPXn/TRul9BHJWWkWeFBJCylk
         RdF9fR5i8Ti7twKcJHBX/Co2iYIHxb3FCdB+5y5J8nBjYPYT7RrjyuvquWmli6ImFXW7
         Eil2QdfjeX+AqlDidkgI9e9wkQUL8nyvB00APa54VVABJnN8NjQal0ldIs+49Ba4HBYz
         Vs/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748942354; x=1749547154;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3ulf0cVULEVjd3FMNDXawEk2wi456eqZrTpHloMzMNE=;
        b=fvip7A91yXwK43VID+DgUYBFAx25mQCYP42xPkfyExu+S91LQPIDy6X50TzNhH1HkA
         xbjWp7nubs/Bbgkf9KlKnfwD29efTlnOANogVkZ6qaaxbxjFimO2UjqCvVisHEnpVTu+
         4SD2O4YsovWdUL4ZVTxV4jM1H2MW7QT6BGbBt3718tjJLCmdOTvn333/X2YO8MSEfxzI
         xkeP1fNr4IKl02FzASTnWCaVKXNSJOanOJdAFg+/5XyvGuHUoBZZG+l0fZ1kSH+5zTQF
         O6z8gkfTnxa/YVnvcIz1Wm04r+95UA045LKmzl78fznFubbAE20klwBOoeCizcua+s7G
         u4tw==
X-Forwarded-Encrypted: i=1; AJvYcCU6j7tCRNhmxfif2fIsjJwNLtT7nLK7RlItlU1mIGq2eqfXsdTz7VzqRzCDiI6WyPiSnhlsRePL@lists.cip-project.org
X-Gm-Message-State: AOJu0YwYnNEyTB2fg4wCt1zjBIXnXTK/hjWD+NR2ifc1qY2n3nYpKcWK
	j2EmUEiuGITiYYLKM0YBCiPBXdlnIUz2o+3G38hQdwYxBvufWj1WFwC5MdqQdDdJt7Y2AFr1gMH
	A4zZg
X-Gm-Gg: ASbGncv68j+hB9XJ4s+xWqqy9+TEbrZyPZWN0tMLFbZ516udazpBtRkS8yMpmP41KJu
	RZPVuNt2Pld8VgjWOrvkLFsKWztjE1wxby72LHUB/G0a/+rSZbccI3kYl3OoilA7AIcoWbxVk33
	LxN26UCgIwkArepAEzkA9jd9Q5xXWqEEjy94rnkjqdn+Vh4PoTd1VZen5wYd1rOFEr4IK926bGv
	tuKj1r4s0rqCZoOB4pIcsNGCwADIEBSYiGPoR8Hmojbk751hHVKj/kGlgT28arvQoZ3TN/spLib
	lIJMYVEjNkyQsioC++GOxoLd/riPzZHmDG928HCZh9WOJ4qw0xZpdkn0TAZVHftmHCnFD3NHdfe
	L2A8CvA==
X-Google-Smtp-Source: AGHT+IFr28dBEo5osbzKjbMU0PJdprfMvev/Y+fBzrAgYdX4O5PCp/2VIGhQoZq4eCD99KSN3Ji9rQ==
X-Received: by 2002:a17:907:2da1:b0:adb:1b2b:fe20 with SMTP id a640c23a62f3a-adb36be2152mr1402071366b.34.1748942353773;
        Tue, 03 Jun 2025 02:19:13 -0700 (PDT)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.126])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ada5d7fecd2sm918093866b.36.2025.06.03.02.19.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Jun 2025 02:19:13 -0700 (PDT)
From: Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To: nobuhiro1.iwamatsu@toshiba.co.jp,
	pavel@denx.de
Cc: claudiu.beznea@tuxon.dev,
	cip-dev@lists.cip-project.org
Subject: [PATCH 5.10.y-cip 8/8] arm64: dts: renesas: r9a08g045s33-smarc-pmod: Add overlay for SCIF1
Date: Tue,  3 Jun 2025 12:19:03 +0300
Message-ID: <20250603091903.3917202-9-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250603091903.3917202-1-claudiu.beznea.uj@bp.renesas.com>
References: <20250603091903.3917202-1-claudiu.beznea.uj@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 03 Jun 2025 09:19:17 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/18973

From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

commit cc018b98a9bf47c06bc985632a7ed9291decb965 upstream.

Add a DT overlay for SCIF1 (of the Renesas RZ/G3S SoC) routed through
the PMOD1_3A interface available on the Renesas RZ SMARC Carrier II
board.

Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Link: https://lore.kernel.org/20250120130936.1080069-5-claudiu.beznea.uj@bp.renesas.com
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
[claudiu.beznea:
 - converted overlay into a dtsi file and included it in
   rzg3s-smarc.dtsi
 - dropped the code from dts Makefile as the overaly is not compiled
   anymore]
Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
---
 .../dts/renesas/rz-smarc-pmod1-type-3a.dtsi   | 45 +++++++++++++++++++
 .../boot/dts/renesas/rzg3s-smarc-switches.h   |  8 ++++
 arch/arm64/boot/dts/renesas/rzg3s-smarc.dtsi  |  2 +
 3 files changed, 55 insertions(+)
 create mode 100644 arch/arm64/boot/dts/renesas/rz-smarc-pmod1-type-3a.dtsi

diff --git a/arch/arm64/boot/dts/renesas/rz-smarc-pmod1-type-3a.dtsi b/arch/arm64/boot/dts/renesas/rz-smarc-pmod1-type-3a.dtsi
new file mode 100644
index 000000000000..9cb987e09aa9
--- /dev/null
+++ b/arch/arm64/boot/dts/renesas/rz-smarc-pmod1-type-3a.dtsi
@@ -0,0 +1,45 @@
+// SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+/*
+ * Device Tree Source for the RZ/G3S SMARC Carrier II EVK PMOD parts
+ *
+ * Copyright (C) 2024 Renesas Electronics Corp.
+ *
+ *
+ * [Connection]
+ *
+ * SMARC Carrier II EVK
+ * +--------------------------------------------+
+ * |PMOD1_3A (PMOD1 PIN HEADER)			|
+ * |	SCIF1_CTS# (pin1)  (pin7)  PMOD1_GPIO10	|
+ * |	SCIF1_TXD  (pin2)  (pin8)  PMOD1_GPIO11	|
+ * |	SCIF1_RXD  (pin3)  (pin9)  PMOD1_GPIO12	|
+ * |	SCIF1_RTS# (pin4)  (pin10) PMOD1_GPIO13	|
+ * |	GND	   (pin5)  (pin11) GND		|
+ * |	PWR_PMOD1  (pin6)  (pin12) GND		|
+ * +--------------------------------------------+
+ *
+ * The following switches should be set as follows for SCIF1:
+ * - SW_CONFIG2:  ON
+ * - SW_OPT_MUX4: ON
+ */
+
+#include <dt-bindings/pinctrl/rzg2l-pinctrl.h>
+#include "rzg3s-smarc-switches.h"
+
+&pinctrl {
+	scif1_pins: scif1-pins {
+		pinmux = <RZG2L_PORT_PINMUX(14, 0, 1)>, /* TXD */
+			 <RZG2L_PORT_PINMUX(14, 1, 1)>, /* RXD */
+			 <RZG2L_PORT_PINMUX(16, 0, 1)>, /* CTS# */
+			 <RZG2L_PORT_PINMUX(16, 1, 1)>; /* RTS# */
+	};
+};
+
+#if SW_CONFIG3 == SW_ON && SW_OPT_MUX4 == SW_ON
+&scif1 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&scif1_pins>;
+	uart-has-rtscts;
+	status = "okay";
+};
+#endif
diff --git a/arch/arm64/boot/dts/renesas/rzg3s-smarc-switches.h b/arch/arm64/boot/dts/renesas/rzg3s-smarc-switches.h
index 5c27c043afef..bbf908a5322c 100644
--- a/arch/arm64/boot/dts/renesas/rzg3s-smarc-switches.h
+++ b/arch/arm64/boot/dts/renesas/rzg3s-smarc-switches.h
@@ -29,4 +29,12 @@
 #define SW_CONFIG2	SW_OFF
 #define SW_CONFIG3	SW_ON
 
+/*
+ * SW_OPT_MUX[x] switches' states:
+ * @SW_OPT_MUX4:
+ *	SW_OFF - The SMARC SER0 signals are routed to M.2 Key E UART
+ *	SW_ON  - The SMARC SER0 signals are routed to PMOD1
+ */
+#define SW_OPT_MUX4	SW_ON
+
 #endif /* __RZG3S_SMARC_SWITCHES_H__ */
diff --git a/arch/arm64/boot/dts/renesas/rzg3s-smarc.dtsi b/arch/arm64/boot/dts/renesas/rzg3s-smarc.dtsi
index 34adfbf2ec76..c8800c41b4e7 100644
--- a/arch/arm64/boot/dts/renesas/rzg3s-smarc.dtsi
+++ b/arch/arm64/boot/dts/renesas/rzg3s-smarc.dtsi
@@ -8,10 +8,12 @@
 #include <dt-bindings/gpio/gpio.h>
 #include <dt-bindings/input/input.h>
 #include <dt-bindings/pinctrl/rzg2l-pinctrl.h>
+#include "rz-smarc-pmod1-type-3a.dtsi"
 
 / {
 	aliases {
 		i2c0 = &i2c0;
+		serial0 = &scif1;
 		serial1 = &scif3;
 		serial3 = &scif0;
 		mmc1 = &sdhi1;
-- 
2.43.0


