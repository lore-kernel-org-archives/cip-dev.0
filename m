Return-Path: <claudiu.beznea@tuxon.dev>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4BCEDC61CE5
	for <webhook@archiver.kernel.org>; Tue,  3 Jun 2025 09:19:57 +0000 (UTC)
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
 by mx.groups.io with SMTP id smtpd.web10.6986.1748942392784069190
 for <cip-dev@lists.cip-project.org>;
 Tue, 03 Jun 2025 02:19:53 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@tuxon.dev header.s=google header.b=dAVz/oVa;
 spf=pass (domain: tuxon.dev, ip: 209.85.208.46, mailfrom: claudiu.beznea@tuxon.dev)
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-5efe8d9ebdfso10460859a12.3
        for <cip-dev@lists.cip-project.org>; Tue, 03 Jun 2025 02:19:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1748942391; x=1749547191; darn=lists.cip-project.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9fVwxChXwKy84IX+ghy9D7bw6UlgG1hhd5z/TEWYaiE=;
        b=dAVz/oVax3SmehQbXmzCDq3p9p6cLEO6o9BmT7dAUmyu8nGi/QXSfF+UQAYnnkCo4J
         lt4z1sF3wlCEMTfckrWkMLrPeh87b5mn8ASza2McpiskfqZtZYeG9SJoAN9sWEGvqbcL
         Ygc35ctDdP+FsszZrcLZrDz9AxNwD8uJoaCUdPOu24QgjEEtRP4hkHacbE562wKT0Kvz
         to4AttfhMs1kZLn0kjayFBatNLCY85zrP85uxzrWUj2anJBCCoHaGT4YUApEauf8Vp3S
         XlhMUN8qK4i9B2ApOWXCOU4c8jUrOQBqrzJ0hUHoIfMRux/GUXL92QNT008pI8d5GEFd
         5YKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748942391; x=1749547191;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9fVwxChXwKy84IX+ghy9D7bw6UlgG1hhd5z/TEWYaiE=;
        b=qt9ebJvjbn1xP0t+9uHXfCwfVQikjw2lBSDcTQnfLt4/VpodgLce/WIkLSu412gtFh
         NuG9bPOIKuDQ7wDz+rKH+sCXvXRxgMBG5fpdvEsuXJjEHfqLO3BeTOLqsDzXy1EUl1vc
         oR759j9ufCOU/8jR9kKQLHfLfzh6+/BXcgtThqxjjh/YBsUyA/bABec8Iqx+q+NbkxiW
         1/8VOZeBmzj3wYhxblt1LcaiPJWFiVsHzxubBJnh4p54P9AIUdPc3R5PbAtYZV5h/euW
         lzUF2pJT8YddFlwbr3F0BnV0nHKNqu7m6CnqgRU9CjSCydGCF8CGdl0ZNVRgwbLK2jSO
         OH4g==
X-Forwarded-Encrypted: i=1; AJvYcCVHGa/Y8Hojeb8Dw6qdzbWVK5S1dJizlaGoAEeY7HL3lJhdghoBgeMfzwn9D4nGELm19aEOjsE/@lists.cip-project.org
X-Gm-Message-State: AOJu0YwGo0ziTPd5gaUmugjhK15MGGx1IeWbq4ZJNrA1kiHojPnQryEl
	ZzGChGuTlTs6/hyIfXgO5ue+Yksi3JKle0uBEUbVBrdW71g5zzEEQZ32jSl7EtrFD+A=
X-Gm-Gg: ASbGnctXFxdayJyx6Cd6970/Ola7zh68e2PMFXQn38gfsvrx5ww4ZbaJEZeAAt5RDKE
	zYXhd1MXLy/Prn/OwjrWWkFKG23XMxwYQf7RNdz8yk8yMYhg/9lRtfJo5bcdBzRc9TVTGnzrX0s
	uXrFvRGew+i9vSCeXl9/0IXAL0oS/6HTgR9MPmj78BWZRmB6YviHBXfRyco9CLqbzNS2+/2Zkww
	yCRlXBe7yr2at3JdedGQQH4ArwoQsd132H+go/cA0dHNI6rqOML/Fi+XEYPD4ErYbBxn6vSKb+l
	NMnAfSXoDMv2bFH+zk5sf9alfbTp95gLrIpbSDPX86pRce/171NUS6EpjXhi/NX/KiqAye64b7D
	eINHYuw==
X-Google-Smtp-Source: AGHT+IEWoIej1oeVoh8JH705GlN9li4kpxdMuHRvddTFjm83IrsPuHcvmMnNV0HXoEydIYCbKBXg7A==
X-Received: by 2002:a05:6402:3494:b0:5fb:ad3c:d0c0 with SMTP id 4fb4d7f45d1cf-6057c1a7b63mr13433110a12.1.1748942391180;
        Tue, 03 Jun 2025 02:19:51 -0700 (PDT)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.126])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-60566c5c5casm7301944a12.25.2025.06.03.02.19.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Jun 2025 02:19:50 -0700 (PDT)
From: Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To: nobuhiro1.iwamatsu@toshiba.co.jp,
	pavel@denx.de
Cc: claudiu.beznea@tuxon.dev,
	cip-dev@lists.cip-project.org
Subject: [PATCH 6.1.y-cip 8/8] arm64: dts: renesas: r9a08g045s33-smarc-pmod: Add overlay for SCIF1
Date: Tue,  3 Jun 2025 12:19:40 +0300
Message-ID: <20250603091940.3917581-9-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250603091940.3917581-1-claudiu.beznea.uj@bp.renesas.com>
References: <20250603091940.3917581-1-claudiu.beznea.uj@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 03 Jun 2025 09:19:57 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/18982

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
index c978bbe7c5b3..44d10ae78149 100644
--- a/arch/arm64/boot/dts/renesas/Makefile
+++ b/arch/arm64/boot/dts/renesas/Makefile
@@ -86,6 +86,9 @@ dtb-$(CONFIG_ARCH_R9A07G044) += r9a07g044l2-smarc.dtb
 dtb-$(CONFIG_ARCH_R9A07G054) += r9a07g054l2-smarc.dtb
 
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


