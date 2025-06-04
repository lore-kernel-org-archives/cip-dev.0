Return-Path: <claudiu.beznea@tuxon.dev>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 559A1C5B555
	for <webhook@archiver.kernel.org>; Wed,  4 Jun 2025 10:24:01 +0000 (UTC)
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
 by mx.groups.io with SMTP id smtpd.web10.13298.1749032635666686907
 for <cip-dev@lists.cip-project.org>;
 Wed, 04 Jun 2025 03:23:55 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@tuxon.dev header.s=google header.b=YGA8K1Fa;
 spf=pass (domain: tuxon.dev, ip: 209.85.218.46, mailfrom: claudiu.beznea@tuxon.dev)
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-ad1b94382b8so1163884766b.0
        for <cip-dev@lists.cip-project.org>; Wed, 04 Jun 2025 03:23:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1749032634; x=1749637434; darn=lists.cip-project.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AW+YG5MagSyUbrYKHOf88ivDuzMn4+EiYsgJ3UL2BSM=;
        b=YGA8K1FaQW3T/4d9Qmx9BmYnwUxUsvPVzIy2fOz+DM+TZsUNIuzj4vbeSHJGsQqIhE
         JJDg6SNlNKxYCa51StchtwMF0wwlmEf8WA+cNedn6UtVfQEA6g+AyVMqtyYKFTaWDgS1
         qtIwFIz9vZvJBJmGfpgQIiOJZkKEjeSjD2CCjijSQ/gFC75x/+FKzpDxGi6+cQ0Sj1x7
         7LE5oG2Xo0GnzfAbdaX3ApXflb3ZRNeYp16MbB4wLTTrqtbDZaaEZeh5xHMs+nrGcbYm
         BBet7VYPO1y1Q7mpLy4QpTpXOuGALMyj3+aRRKUjj1Xa5X6Hd9YPUgRMjT4CleP9aezc
         Vpzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749032634; x=1749637434;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AW+YG5MagSyUbrYKHOf88ivDuzMn4+EiYsgJ3UL2BSM=;
        b=nEvB4rmj+rHB3GXDEaNVercZrEW/GuWTUxkooPF88bKuu9TtipkRk4pmjFFpoEYVBQ
         Q4HzdZTn2Kj7y2AzVl9TVCIXxfrxwqrBYqOO/rLOvj0kse1bM8+ocDNlFxTqCib47oD2
         KA2VW19eacVltans3oNKk8o965ZZCw6DT94eRfm7oKxTAhG7sFVtRC+Ni4ZBHtVjYB6S
         i3NILNL4CSTF4XpvjzGErKLOU/8nTaWI+oL2XOQAKYIRcFi4HvcNZTmzM7QPtAK6pURM
         ZZwUpxwezI12ul4WzTxBVurd09acFWYULLav04dKMFHZWp7HLMB6AiZD8IbSLr5LGGjc
         gTIg==
X-Forwarded-Encrypted: i=1; AJvYcCXj7XEeCZ920mpmHBqF4MVWfBYKN9as91HKHxG1JSu3UdP+FRb2dh3DlCOXN8OOKi/SIDDxOqTc@lists.cip-project.org
X-Gm-Message-State: AOJu0YwXx3RQ0aQX5TIOmvmuarp8veMbR1AS/H2HEx1FL36N+YGR5ORy
	GNdFrQrOUjnxCbWHDpzv785eTfdC7P4QcgXS0Drbb17c8kg92OLFN8l4+XxopG6mMbrT6G3d/LD
	rwR4e
X-Gm-Gg: ASbGncvsKirsQXn6HeZFbPx2FAzJ+xoSlaBaeWMNTt4hL4fT1+8tr4dvu33K7cVJbaY
	6LdTdpkGrYMo9kR8XmreqyWs79l3G3M48868+J3jAmcEX1PgyqwodoGUPMvgRTZ7bZZerubp2nY
	PCaTJIRl4j/E99bii9lvlTuyO7tK33cp7aSF9aSc6bKFl8zFv6RA1cVAlk3mFEUkR+oPew5j0vL
	SZx72d7C7hilZigTbbTaLwvilrnWgUXk5Pu6svmMzO33uAXjVxQNvhffKJT8eUKrMgl21g3Z4On
	tgTe3SKVmKXkaqAdfkQaXroqvrQybW+4n7AJ0qamvYBCvJS5zdqAPbH0WvxYX2FDOUdo1GT0E+E
	6tCJA9V/GI1eQ4clKIDW2JBscP2Q=
X-Google-Smtp-Source: AGHT+IEPEQampN9bdnMvnW/3vITFFVwe2H5DoJQOMkZAox60HRL9cCu2f9V8IXDHckqN6gVtYUsdhA==
X-Received: by 2002:a17:906:ee85:b0:ad8:87a8:7a6c with SMTP id a640c23a62f3a-addf8cdbd3fmr203359466b.16.1749032633936;
        Wed, 04 Jun 2025 03:23:53 -0700 (PDT)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.126])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ada5d82e760sm1087375166b.52.2025.06.04.03.23.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Jun 2025 03:23:53 -0700 (PDT)
From: Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To: nobuhiro1.iwamatsu@toshiba.co.jp,
	pavel@denx.de
Cc: claudiu.beznea@tuxon.dev,
	cip-dev@lists.cip-project.org
Subject: [PATCH 6.1.y-cip v2 8/8] arm64: dts: renesas: r9a08g045s33-smarc-pmod: Add overlay for SCIF1
Date: Wed,  4 Jun 2025 13:23:41 +0300
Message-ID: <20250604102341.2524186-9-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250604102341.2524186-1-claudiu.beznea.uj@bp.renesas.com>
References: <20250604102341.2524186-1-claudiu.beznea.uj@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 04 Jun 2025 10:24:01 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/19009

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

Changes in v2:
- converted the overlay into a dtsi file and included it in the board dts
- updated the patch description to describe this


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


