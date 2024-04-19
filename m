Return-Path: <claudiu.beznea@tuxon.dev>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A63EEC04FFF
	for <webhook@archiver.kernel.org>; Fri, 19 Apr 2024 08:18:58 +0000 (UTC)
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
 by mx.groups.io with SMTP id smtpd.web11.15289.1713514733030165680
 for <cip-dev@lists.cip-project.org>;
 Fri, 19 Apr 2024 01:18:53 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@tuxon.dev header.s=google header.b=VP66ZMu7;
 spf=pass (domain: tuxon.dev, ip: 209.85.208.45, mailfrom: claudiu.beznea@tuxon.dev)
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-56fe7dc7f58so1709258a12.2
        for <cip-dev@lists.cip-project.org>; Fri, 19 Apr 2024 01:18:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1713514731; x=1714119531; darn=lists.cip-project.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+muwCvfIlB7IGLu1SoQTWCTLTV8MSzY7TwVUTGuGZiw=;
        b=VP66ZMu7GYMQU6FOljwbFv3I3rEjqJIF7ARcNvmyqqome2Z7/ZOYV29laasnD+r4uR
         ES2fz3qUMPXhOvoXH0/TMFGn1EirgkIQ6aMAfPgBtLB+QBiVThS7WhNiF/8ss03qIS/+
         urwBZhP0DSZQ81NLYBuRU/beVYVd4/KVo1Y/UDBcl28ySIye+KGbUDNwM8+N17Lfwbdn
         IfWFpBKC3HjYAbK11qsyFrHhNCFCKZXK7NOKtby47ZtlNrBph2Kup4ySlMQuiW+hbCxo
         D92FWWBEwwlccSMqK1fpXd7N5JoCvPT73ArmHnbyJA+WU6rM+gTJgR7n8UFYpUc/n2Tn
         z+YA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713514731; x=1714119531;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+muwCvfIlB7IGLu1SoQTWCTLTV8MSzY7TwVUTGuGZiw=;
        b=pOihtVGB4yMqoQu2YggGz5yfSToiXy9vVbnAEfNMhGyq4Cp72cxU0j9XqdewsLOH5r
         twk2aWcUuomR9+DwD4QH/4w+b+WzHIWJfQm2Uaq2V7EHEENeVL37OKw4yygmY2c63++L
         uNbKXM6ifL0pqsrC+DPArJSvjvKWStzSzLrvAYZXZOcLDu4QEyh92aQFom+tOzYzw+Th
         6KT9lufAhD7AsUa8LHwuw/XOSY1lkYlL8RwSDLp6Ty7aF8ZqxODy6hP2mtmGnUFTG/tB
         OmeJgv260A+118yBaoAmu1iu9RsX6DwPdVGIP/JqKs9Hc3RUiVOGCydv0vaQLNNxq3UI
         UQiA==
X-Gm-Message-State: AOJu0YzZ9IzDQ/zhZgsTzAAOb4H+8h6/DGHa/BJT4FqWEF4NplLVLPax
	D/xuEBEKRy2G6TGwmtOK1SuvLG/2OgZQmaoZbWZn3rJZvQmEzC4H19I2QcmlYQXw2zhIyGMxRAK
	1
X-Google-Smtp-Source: AGHT+IGUhtDHr1jU0g4InGka5hmGtH4QVWBhdqqm5GfV0+xcN9BfImQZb4/haR6qxZ2m4bYRNjYYGQ==
X-Received: by 2002:a17:906:fb9a:b0:a55:5faf:ab04 with SMTP id lr26-20020a170906fb9a00b00a555fafab04mr1112524ejb.44.1713514731347;
        Fri, 19 Apr 2024 01:18:51 -0700 (PDT)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.185])
        by smtp.gmail.com with ESMTPSA id w23-20020a170907271700b00a556f2f18d6sm1816243ejk.57.2024.04.19.01.18.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Apr 2024 01:18:50 -0700 (PDT)
From: Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To: nobuhiro1.iwamatsu@toshiba.co.jp,
	pavel@denx.de
Cc: cip-dev@lists.cip-project.org,
	biju.das.jz@bp.renesas.com,
	prabhakar.mahadev-lad.rj@bp.renesas.com,
	claudiu.beznea@tuxon.dev
Subject: [PATCH 5.10.y-cip 44/53] arm64: dts: renesas: Add initial DTSI for RZ/G3S SoC
Date: Fri, 19 Apr 2024 11:17:33 +0300
Message-Id: <20240419081742.3496709-45-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240419081742.3496709-1-claudiu.beznea.uj@bp.renesas.com>
References: <20240419081742.3496709-1-claudiu.beznea.uj@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 19 Apr 2024 08:18:58 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/15631

From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

commit e20396d65b959a65be84e0eda3c106360114b7ae upstream.

Add the initial DTSI for the RZ/G3S SoC.
The files in this commit have the following meaning:
  - r9a08g045.dtsi:    RZ/G3S family SoC common parts
  - r9a08g045s33.dtsi: RZ/G3S R0A08G045S33 SoC specific parts

Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Link: https://lore.kernel.org/r/20230929053915.1530607-23-claudiu.beznea@bp.renesas.com
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
---
 arch/arm64/boot/dts/renesas/r9a08g045.dtsi    | 139 ++++++++++++++++++
 arch/arm64/boot/dts/renesas/r9a08g045s33.dtsi |  14 ++
 2 files changed, 153 insertions(+)
 create mode 100644 arch/arm64/boot/dts/renesas/r9a08g045.dtsi
 create mode 100644 arch/arm64/boot/dts/renesas/r9a08g045s33.dtsi

diff --git a/arch/arm64/boot/dts/renesas/r9a08g045.dtsi b/arch/arm64/boot/dts/renesas/r9a08g045.dtsi
new file mode 100644
index 000000000000..7971e44a5a0a
--- /dev/null
+++ b/arch/arm64/boot/dts/renesas/r9a08g045.dtsi
@@ -0,0 +1,139 @@
+// SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+/*
+ * Device Tree Source for the RZ/G3S SoC
+ *
+ * Copyright (C) 2023 Renesas Electronics Corp.
+ */
+
+#include <dt-bindings/interrupt-controller/arm-gic.h>
+#include <dt-bindings/clock/r9a08g045-cpg.h>
+
+/ {
+	compatible = "renesas,r9a08g045";
+	#address-cells = <2>;
+	#size-cells = <2>;
+
+	cpus {
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		cpu0: cpu@0 {
+			compatible = "arm,cortex-a55";
+			reg = <0>;
+			device_type = "cpu";
+			#cooling-cells = <2>;
+			next-level-cache = <&L3_CA55>;
+			enable-method = "psci";
+			clocks = <&cpg CPG_CORE R9A08G045_CLK_I>;
+		};
+
+		L3_CA55: cache-controller-0 {
+			compatible = "cache";
+			cache-unified;
+			cache-size = <0x40000>;
+		};
+	};
+
+	extal_clk: extal-clk {
+		compatible = "fixed-clock";
+		#clock-cells = <0>;
+		/* This value must be overridden by the board. */
+		clock-frequency = <0>;
+	};
+
+	soc: soc {
+		compatible = "simple-bus";
+		interrupt-parent = <&gic>;
+		#address-cells = <2>;
+		#size-cells = <2>;
+		ranges;
+
+		scif0: serial@1004b800 {
+			compatible = "renesas,scif-r9a08g045", "renesas,scif-r9a07g044";
+			reg = <0 0x1004b800 0 0x400>;
+			interrupts = <GIC_SPI 320 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 322 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 323 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 321 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 324 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 324 IRQ_TYPE_LEVEL_HIGH>;
+			interrupt-names = "eri", "rxi", "txi",
+					  "bri", "dri", "tei";
+			clocks = <&cpg CPG_MOD R9A08G045_SCIF0_CLK_PCK>;
+			clock-names = "fck";
+			power-domains = <&cpg>;
+			resets = <&cpg R9A08G045_SCIF0_RST_SYSTEM_N>;
+			status = "disabled";
+		};
+
+		cpg: clock-controller@11010000 {
+			compatible = "renesas,r9a08g045-cpg";
+			reg = <0 0x11010000 0 0x10000>;
+			clocks = <&extal_clk>;
+			clock-names = "extal";
+			#clock-cells = <2>;
+			#reset-cells = <1>;
+			#power-domain-cells = <0>;
+		};
+
+		sysc: system-controller@11020000 {
+			compatible = "renesas,r9a08g045-sysc";
+			reg = <0 0x11020000 0 0x10000>;
+			interrupts = <GIC_SPI 39 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 40 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 41 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 42 IRQ_TYPE_LEVEL_HIGH>;
+			interrupt-names = "lpm_int", "ca55stbydone_int",
+					  "cm33stbyr_int", "ca55_deny";
+			status = "disabled";
+		};
+
+		pinctrl: pinctrl@11030000 {
+			compatible = "renesas,r9a08g045-pinctrl";
+			reg = <0 0x11030000 0 0x10000>;
+			gpio-controller;
+			#gpio-cells = <2>;
+			interrupt-controller;
+			#interrupt-cells = <2>;
+			gpio-ranges = <&pinctrl 0 0 152>;
+			clocks = <&cpg CPG_MOD R9A08G045_GPIO_HCLK>;
+			power-domains = <&cpg>;
+			resets = <&cpg R9A08G045_GPIO_RSTN>,
+				 <&cpg R9A08G045_GPIO_PORT_RESETN>,
+				 <&cpg R9A08G045_GPIO_SPARE_RESETN>;
+		};
+
+		sdhi0: mmc@11c00000  {
+			compatible = "renesas,sdhi-r9a08g045", "renesas,rcar-gen3-sdhi";
+			reg = <0x0 0x11c00000 0 0x10000>;
+			interrupts = <GIC_SPI 88 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 89 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&cpg CPG_MOD R9A08G045_SDHI0_IMCLK>,
+				 <&cpg CPG_MOD R9A08G045_SDHI0_CLK_HS>,
+				 <&cpg CPG_MOD R9A08G045_SDHI0_IMCLK2>,
+				 <&cpg CPG_MOD R9A08G045_SDHI0_ACLK>;
+			clock-names = "core", "clkh", "cd", "aclk";
+			resets = <&cpg R9A08G045_SDHI0_IXRST>;
+			power-domains = <&cpg>;
+			status = "disabled";
+		};
+
+		gic: interrupt-controller@12400000 {
+			compatible = "arm,gic-v3";
+			#interrupt-cells = <3>;
+			#address-cells = <0>;
+			interrupt-controller;
+			reg = <0x0 0x12400000 0 0x40000>,
+			      <0x0 0x12440000 0 0x60000>;
+			interrupts = <GIC_PPI 9 IRQ_TYPE_LEVEL_LOW>;
+		};
+	};
+
+	timer {
+		compatible = "arm,armv8-timer";
+		interrupts-extended = <&gic GIC_PPI 13 IRQ_TYPE_LEVEL_LOW>,
+				      <&gic GIC_PPI 14 IRQ_TYPE_LEVEL_LOW>,
+				      <&gic GIC_PPI 11 IRQ_TYPE_LEVEL_LOW>,
+				      <&gic GIC_PPI 10 IRQ_TYPE_LEVEL_LOW>;
+	};
+};
diff --git a/arch/arm64/boot/dts/renesas/r9a08g045s33.dtsi b/arch/arm64/boot/dts/renesas/r9a08g045s33.dtsi
new file mode 100644
index 000000000000..3351f26c7a2a
--- /dev/null
+++ b/arch/arm64/boot/dts/renesas/r9a08g045s33.dtsi
@@ -0,0 +1,14 @@
+// SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+/*
+ * Device Tree Source for the RZ/G3S R9A08G045S33 SoC specific part
+ *
+ * Copyright (C) 2023 Renesas Electronics Corp.
+ */
+
+/dts-v1/;
+
+#include "r9a08g045.dtsi"
+
+/ {
+	compatible = "renesas,r9a08g045s33", "renesas,r9a08g045";
+};
-- 
2.39.2


