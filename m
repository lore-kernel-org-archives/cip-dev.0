Return-Path: <claudiu.beznea@tuxon.dev>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B5F2C02191
	for <webhook@archiver.kernel.org>; Fri, 24 Jan 2025 09:01:01 +0000 (UTC)
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
 by mx.groups.io with SMTP id smtpd.web11.7443.1737709253240763094
 for <cip-dev@lists.cip-project.org>;
 Fri, 24 Jan 2025 01:00:53 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@tuxon.dev header.s=google header.b=Q7zlwg95;
 spf=pass (domain: tuxon.dev, ip: 209.85.218.41, mailfrom: claudiu.beznea@tuxon.dev)
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-aaeec07b705so365319966b.2
        for <cip-dev@lists.cip-project.org>; Fri, 24 Jan 2025 01:00:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1737709252; x=1738314052; darn=lists.cip-project.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kfz5U+16lj5ldQgxOF+0aFhyP67gyfkoyTfLfOK2g1s=;
        b=Q7zlwg95OVwNmFR9lozWbxDM2FF1LIkbHg6Hp5w+BEUTQnD/HzSvz4OJyf9C+BcrLg
         VWg/pLQgkjeVVHNcLj93em+rvukV/HpA1yVo3TZZohuCXRRpBbY8clV4gFrgb55jQUdI
         Lrrv3NYJmK+sQQVvP/fCDIW6qW0xtId93691CSV49MkRih7aU1kLPWGpkCNMkr28S+pa
         u9g7aATZijgojOpsJFOEwbIbWvA2ks5mXjGyhcf46YNj11RkFBWr1Z26zS4nwjSn3QmA
         Wy6ZNGeaq5E3nQwtx7IbRYM/9w3dT8vnUESIOtHYXr+x4xYWPtLOKEceJr6mA2oVegPc
         sbMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737709252; x=1738314052;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kfz5U+16lj5ldQgxOF+0aFhyP67gyfkoyTfLfOK2g1s=;
        b=P2nYeqrzHnZBJf/R7iVFcIOno2hrjqsiKx++nINZZTNqgYDJFiSxN8InJQmxnMNf7w
         yfxMrTjzCseZ6iC/p8HHLjxcmKfwKmWbcr2pna6lKPjA5N+R0WwHGWEW3G5KRZNZfjFW
         hykwSXrkZTguB2plitPXMlUy3BXYqdCxoC79PtAzHFHLYzE4vZs9Ig6HoHWIkxWXLfTo
         LJxhfPLY5JTY81+5I5JviooYoVckX6fzA4Us2rStXLSX9TvOfHiMsCKr+HvR9LscNj/p
         S2a5jcriLQ2fSplcqm+8IF2iAcwWzyF1liEB7TDNs0RSe6mYeVs8Yn82J8B810Sn4Eet
         rnRg==
X-Forwarded-Encrypted: i=1; AJvYcCUWqocs3qbGEwhf0+z5CS5b3c3InbpzXQOVtjIzE6CzVlt0G9RTGF3dEV4wYkf1QPcCejPtP4RL@lists.cip-project.org
X-Gm-Message-State: AOJu0YwjYc+j1q4ka74KsJwlyjrddg8iX8roAr2ABFXpScYvIbwltqCO
	IO4EARTKvstNhnQTSQBYW5Sex5AovhSwkC5R8cFHHYig0DVPafle+GL6AEmeDoc=
X-Gm-Gg: ASbGnctKhu/Lp+1Ye3G1ibUWvn4q8JEF+jU1hJARdCAYGUgHhpf8LJwRuFSP34srNrk
	S4JqZ4z7oeZqPjJnUofDb8mS1rpuyNFIVRRpXBxl9HZwE+JqjM62GQKJZlKi/BpB69Tn2Rg+l/Q
	6izxT0ePtritaxC+jDp/hdoh5YmXCgJu5CfeJaA6emSZ0f5fRQboNw3GobX1LpGB+SppFzWWFl+
	jzgtl5CfJ1xarWvhzQfTKvGlM62EpZF5j2TRQFGozoSrwsvgIXFtPozNrtiqn9ZU8qjWaGiszTt
	7z1zMDDqQjlzCF4DZt3hIqMRvktye06I8A==
X-Google-Smtp-Source: AGHT+IHRyWX+HllDM1aJl4/l3vTce9TdaM96KogkBiUoDcLHjRytaOCJBZNl4q8JusQPPKhG5z/cpA==
X-Received: by 2002:a17:906:4783:b0:aa6:3f93:fb99 with SMTP id a640c23a62f3a-ab38b3841e5mr2973081566b.36.1737709251579;
        Fri, 24 Jan 2025 01:00:51 -0800 (PST)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.35])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ab6760fbce4sm92200766b.127.2025.01.24.01.00.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Jan 2025 01:00:50 -0800 (PST)
From: Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To: nobuhiro1.iwamatsu@toshiba.co.jp,
	pavel@denx.de
Cc: claudiu.beznea@tuxon.dev,
	cip-dev@lists.cip-project.org
Subject: [PATCH v5.10.y-cip v2 06/16] dt-bindings: clock: renesas,r9a08g045-vbattb: Document VBATTB
Date: Fri, 24 Jan 2025 11:00:31 +0200
Message-ID: <20250124090041.1401132-7-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250124090041.1401132-1-claudiu.beznea.uj@bp.renesas.com>
References: <20250124090041.1401132-1-claudiu.beznea.uj@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 24 Jan 2025 09:01:01 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/17643

From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

commit cdfd5daf90af8363fb1f58e08c829a775b2e2fc5 upstream.

The VBATTB IP of the Renesas RZ/G3S SoC controls the clock for RTC,
the tamper detector and a small general usage memory of 128B.

The VBATTB controller controls the clock for the RTC on the Renesas
RZ/G3S. The HW block diagram for the clock logic is as follows:

           +----------+ XC   `\
RTXIN  --->|          |----->| \       +----+  VBATTCLK
           | 32K clock|      |  |----->|gate|----------->
           | osc      | XBYP |  |      +----+
RTXOUT --->|          |----->| /
           +----------+      ,/

One could connect as input to this HW block either a crystal or
an external clock device. This is board specific.

After discussions w/ Stephen Boyd the clock tree associated with this
hardware block was exported in Linux as:

input-xtal
  xbyp
  xc
     mux
        vbattclk

where:
- input-xtal is the input clock (connected to RTXIN, RTXOUT pins)
- xc, xbyp are mux inputs
- mux is the internal mux
- vbattclk is the gate clock that feeds in the end the RTC

to allow selecting the input of the MUX though assigned-clock DT
properties, using the already existing clock drivers and avoid adding
other DT properties.

This allows select the input of the mux based on the type of the
connected input clock:
- if the 32768 crystal is connected as input for the VBATTB,
  the input of the mux should be xc
- if an external clock device is connected as input for the VBATTB the
  input of the mux should be xbyp

Add bindings for the VBATTB controller.

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Link: https://lore.kernel.org/20241101095720.2247815-2-claudiu.beznea.uj@bp.renesas.com
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Reviewed-by: Pavel Machek <pavel@denx.de>
Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
---
 .../clock/renesas,r9a08g045-vbattb.yaml       | 84 +++++++++++++++++++
 .../clock/renesas,r9a08g045-vbattb.h          | 13 +++
 2 files changed, 97 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/clock/renesas,r9a08g045-vbattb.yaml
 create mode 100644 include/dt-bindings/clock/renesas,r9a08g045-vbattb.h

diff --git a/Documentation/devicetree/bindings/clock/renesas,r9a08g045-vbattb.yaml b/Documentation/devicetree/bindings/clock/renesas,r9a08g045-vbattb.yaml
new file mode 100644
index 000000000000..3707e4118949
--- /dev/null
+++ b/Documentation/devicetree/bindings/clock/renesas,r9a08g045-vbattb.yaml
@@ -0,0 +1,84 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/clock/renesas,r9a08g045-vbattb.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Renesas Battery Backup Function (VBATTB)
+
+description:
+  Renesas VBATTB is an always on powered module (backed by battery) which
+  controls the RTC clock (VBATTCLK), tamper detection logic and a small
+  general usage memory (128B).
+
+maintainers:
+  - Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
+
+properties:
+  compatible:
+    const: renesas,r9a08g045-vbattb
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    items:
+      - description: tamper detector interrupt
+
+  clocks:
+    items:
+      - description: VBATTB module clock
+      - description: RTC input clock (crystal or external clock device)
+
+  clock-names:
+    items:
+      - const: bclk
+      - const: rtx
+
+  '#clock-cells':
+    const: 1
+
+  power-domains:
+    maxItems: 1
+
+  resets:
+    items:
+      - description: VBATTB module reset
+
+  quartz-load-femtofarads:
+    description: load capacitance of the on board crystal
+    enum: [ 4000, 7000, 9000, 12500 ]
+    default: 4000
+
+required:
+  - compatible
+  - reg
+  - interrupts
+  - clocks
+  - clock-names
+  - '#clock-cells'
+  - power-domains
+  - resets
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/clock/r9a08g045-cpg.h>
+    #include <dt-bindings/clock/renesas,r9a08g045-vbattb.h>
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+    #include <dt-bindings/interrupt-controller/irq.h>
+
+    clock-controller@1005c000 {
+        compatible = "renesas,r9a08g045-vbattb";
+        reg = <0x1005c000 0x1000>;
+        interrupts = <GIC_SPI 43 IRQ_TYPE_LEVEL_HIGH>;
+        clocks = <&cpg CPG_MOD R9A08G045_VBAT_BCLK>, <&vbattb_xtal>;
+        clock-names = "bclk", "rtx";
+        assigned-clocks = <&vbattb VBATTB_MUX>;
+        assigned-clock-parents = <&vbattb VBATTB_XC>;
+        #clock-cells = <1>;
+        power-domains = <&cpg>;
+        resets = <&cpg R9A08G045_VBAT_BRESETN>;
+        quartz-load-femtofarads = <12500>;
+    };
diff --git a/include/dt-bindings/clock/renesas,r9a08g045-vbattb.h b/include/dt-bindings/clock/renesas,r9a08g045-vbattb.h
new file mode 100644
index 000000000000..67774eafad06
--- /dev/null
+++ b/include/dt-bindings/clock/renesas,r9a08g045-vbattb.h
@@ -0,0 +1,13 @@
+/* SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+ *
+ * Copyright (C) 2024 Renesas Electronics Corp.
+ */
+#ifndef __DT_BINDINGS_CLOCK_R9A08G045_VBATTB_H__
+#define __DT_BINDINGS_CLOCK_R9A08G045_VBATTB_H__
+
+#define VBATTB_XC		0
+#define VBATTB_XBYP		1
+#define VBATTB_MUX		2
+#define VBATTB_VBATTCLK		3
+
+#endif /* __DT_BINDINGS_CLOCK_R9A08G045_VBATTB_H__ */
-- 
2.43.0


