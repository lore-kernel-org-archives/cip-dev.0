Return-Path: <claudiu.beznea@tuxon.dev>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83A8CC5AD49
	for <webhook@archiver.kernel.org>; Tue,  3 Jun 2025 09:20:27 +0000 (UTC)
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
 by mx.groups.io with SMTP id smtpd.web10.7006.1748942417888074144
 for <cip-dev@lists.cip-project.org>;
 Tue, 03 Jun 2025 02:20:18 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@tuxon.dev header.s=google header.b=pG504LW2;
 spf=pass (domain: tuxon.dev, ip: 209.85.208.46, mailfrom: claudiu.beznea@tuxon.dev)
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-60410a9c6dcso116498a12.1
        for <cip-dev@lists.cip-project.org>; Tue, 03 Jun 2025 02:20:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1748942416; x=1749547216; darn=lists.cip-project.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=s1pJ0g/rZ9ZSZxTDY447WDIFqB6vOTQlEBSZ4slNYJk=;
        b=pG504LW2q5MMfygpgOTsQHDpxsCCaJXhb1EDdVOK9jTXKzoqHRQjYgSBYX0H2W9oSQ
         lFufl5xAisAKMgUaDQfg3t1irTO/h2qt/S6uV1DpVihwHROXh9ghA9MAamBj6hhuJHbO
         UNw8ie7bzQfCB9RtvVOePjo4TMligzbm/zukwGHQ4wYH82wUbFnajpv44rJNY/oIE/Uo
         eP0oNFRtQTDLDPmT6iWtjDG9uulpaE+4KPIIXGA/eTbTR4jptFvK0DyGoNSu3LgoajXZ
         ZB3RAGqa1S2bM4rn5wLBEWXyDchGXj/CvZwQmNXDZcAgRxt4m5TpTUfaFfXk6s+DjNrP
         JWdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748942416; x=1749547216;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=s1pJ0g/rZ9ZSZxTDY447WDIFqB6vOTQlEBSZ4slNYJk=;
        b=USSGeZ9FOnuMm/sC+nmvhU2zJLkKffCxvSs0YbBEXBPSMNdC5m8XqEV5YS+gNnDD2N
         Mr+A3hA9Rp58xcRW0K9r/4tes+MGuX9VHOXsZLO1IL60EALZO3qo/HBW5cqE637wwUpl
         DCOhMS9W4rDtrQRTKAez7JYCZB72eDPUzt7My34pp2xtSz5j3ySGV4A2N9ZTmHRJCaTk
         LnBJGwzbQdvTvIxEmwE1l6S+0Mf2Aed6XpDecKNPK2svf8d+Kp8X7uxSHZ6Z6KVADG6H
         ulGNd8qSbjr+dnjWPY0GAS2mfj7lt0Car0GOwnGMdTSvHpMn1PWR5A9MAc8PYxEwgJAo
         1P9w==
X-Forwarded-Encrypted: i=1; AJvYcCXUyZ921UkgiAaJ4CvQ5lVteivAldhAptqBqDGUAFuTljumRHYzvMO0B7dVeCfAC7sTYnIpjdAC@lists.cip-project.org
X-Gm-Message-State: AOJu0Yx/nfPtEwgjRWS4vKOEBfo2XxIw5FVJhnsPSlBQ6FDiMWb/du+W
	ODGOV2kFZZqFtwZJIMoy/vH2GKh20YIAoxTdwZebEpDI0SIaDsf7AvMjR81Nzi+1mwY=
X-Gm-Gg: ASbGnctaJDpZPu0HBMJrlLK4zbNvSASJegq/Bid8gix6YAtA2k6PF9tBMuJF18Jlda0
	4G7dNRJoZkUFc7A/zpRZyqYfidQq+ZeGNFPev6fNyhpZhG+1IFSJmek8pyQ5p9/cR1+sYVcoqkr
	ZmEnxujlfYWyYYZuLFRFhM9ozyYGhSdbT2hWpMydsWPKtnjlJcv3lBr4iK99Vv4n1nRaJw501xU
	uyR2monPZquhAPmA+FhZewO8K4Ho7+s5wbrZ8lHQtAjU2NAp29JchsqD+StNgFiB1CXVvsDJUkt
	63Up5GCgFIlLRcfoIbD8JT8vAtT4Lou9wCtMyS/ibSTvxAfxk5deQcOgO1FNLmWU4wFcbh+VqnO
	8+51J/lN8PFG7GWEI
X-Google-Smtp-Source: AGHT+IF6w9SoUSnpZPTbgN0+2t+uvNDFeawy+SW33YcMuGUku4niHLq1Yfa/Ra1Tm2yJ22d2/LGMDw==
X-Received: by 2002:a17:907:3e13:b0:ad5:78ca:2126 with SMTP id a640c23a62f3a-adb3243e11bmr1669261366b.59.1748942416150;
        Tue, 03 Jun 2025 02:20:16 -0700 (PDT)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.126])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-adb2e220548sm817017266b.109.2025.06.03.02.20.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Jun 2025 02:20:15 -0700 (PDT)
From: Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To: nobuhiro1.iwamatsu@toshiba.co.jp,
	pavel@denx.de
Cc: claudiu.beznea@tuxon.dev,
	cip-dev@lists.cip-project.org
Subject: [PATCH 6.12.y-cip 7/7] arm64: dts: renesas: r9a08g045s33-smarc-pmod: Add overlay for SCIF1
Date: Tue,  3 Jun 2025 12:20:05 +0300
Message-ID: <20250603092005.3917850-8-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250603092005.3917850-1-claudiu.beznea.uj@bp.renesas.com>
References: <20250603092005.3917850-1-claudiu.beznea.uj@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 03 Jun 2025 09:20:27 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/18990

From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

commit cc018b98a9bf47c06bc985632a7ed9291decb965 upstream.

Add a DT overlay for SCIF1 (of the Renesas RZ/G3S SoC) routed through
the PMOD1_3A interface available on the Renesas RZ SMARC Carrier II
board.

Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Link: https://lore.kernel.org/20250120130936.1080069-5-claudiu.beznea.uj@bp.renesas.com
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
---
 arch/arm64/boot/dts/renesas/Makefile          |  3 ++
 .../r9a08g045s33-smarc-pmod1-type-3a.dtso     | 48 +++++++++++++++++++
 .../boot/dts/renesas/rzg3s-smarc-switches.h   |  8 ++++
 arch/arm64/boot/dts/renesas/rzg3s-smarc.dtsi  |  1 +
 4 files changed, 60 insertions(+)
 create mode 100644 arch/arm64/boot/dts/renesas/r9a08g045s33-smarc-pmod1-type-3a.dtso

diff --git a/arch/arm64/boot/dts/renesas/Makefile b/arch/arm64/boot/dts/renesas/Makefile
index bf5b49f47ce8..7959f62a8e26 100644
--- a/arch/arm64/boot/dts/renesas/Makefile
+++ b/arch/arm64/boot/dts/renesas/Makefile
@@ -137,6 +137,9 @@ r9a07g054l2-smarc-cru-csi-ov5645-dtbs := r9a07g054l2-smarc.dtb r9a07g054l2-smarc
 dtb-$(CONFIG_ARCH_R9A07G054) += r9a07g054l2-smarc-cru-csi-ov5645.dtb
 
 dtb-$(CONFIG_ARCH_R9A08G045) += r9a08g045s33-smarc.dtb
+dtb-$(CONFIG_ARCH_R9A08G045) += r9a08g045s33-smarc-pmod1-type-3a.dtbo
+r9a08g045s33-smarc-pmod1-type-3a-dtbs := r9a08g045s33-smarc.dtb r9a08g045s33-smarc-pmod1-type-3a.dtbo
+dtb-$(CONFIG_ARCH_R9A08G045) += r9a08g045s33-smarc-pmod1-type-3a.dtb
 
 dtb-$(CONFIG_ARCH_R9A09G011) += r9a09g011-v2mevk2.dtb
 
diff --git a/arch/arm64/boot/dts/renesas/r9a08g045s33-smarc-pmod1-type-3a.dtso b/arch/arm64/boot/dts/renesas/r9a08g045s33-smarc-pmod1-type-3a.dtso
new file mode 100644
index 000000000000..4a81e3a3c8bd
--- /dev/null
+++ b/arch/arm64/boot/dts/renesas/r9a08g045s33-smarc-pmod1-type-3a.dtso
@@ -0,0 +1,48 @@
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
+/dts-v1/;
+/plugin/;
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
index 34adfbf2ec76..db05c28a8f6c 100644
--- a/arch/arm64/boot/dts/renesas/rzg3s-smarc.dtsi
+++ b/arch/arm64/boot/dts/renesas/rzg3s-smarc.dtsi
@@ -12,6 +12,7 @@
 / {
 	aliases {
 		i2c0 = &i2c0;
+		serial0 = &scif1;
 		serial1 = &scif3;
 		serial3 = &scif0;
 		mmc1 = &sdhi1;
-- 
2.43.0


