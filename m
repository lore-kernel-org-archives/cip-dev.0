Return-Path: <claudiu.beznea@tuxon.dev>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85DB7D65539
	for <webhook@archiver.kernel.org>; Wed, 17 Dec 2025 10:32:05 +0000 (UTC)
Received: from mail-ed1-f68.google.com (mail-ed1-f68.google.com [209.85.208.68])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.11302.1765967523107592409
 for <cip-dev@lists.cip-project.org>;
 Wed, 17 Dec 2025 02:32:03 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@tuxon.dev header.s=google header.b=Vi+Q92YU;
 spf=pass (domain: tuxon.dev, ip: 209.85.208.68, mailfrom: claudiu.beznea@tuxon.dev)
Received: by mail-ed1-f68.google.com with SMTP id 4fb4d7f45d1cf-64165cd689eso726642a12.0
        for <cip-dev@lists.cip-project.org>; Wed, 17 Dec 2025 02:32:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1765967521; x=1766572321; darn=lists.cip-project.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2R9GurKYbVeB/8LafeEx/1FAQx1LNAFb9JUiNzsNVDc=;
        b=Vi+Q92YUCPC+5TFsdjvqyWSMzggp3n4I6th8F0peO7gCaDhwwob819V9y6qkiYZ3u9
         AuwLXVSnFwXUy3wzI+yclqhiu3vEvISMmWhsENRuQqMIuD5GX6Bk9pagIJ7L7i1XJgBq
         oSRWj+2gZAbevVzFJFXCI53i3AUfx1jh4/jJMxVQ5uxtFG9tLZXLeX18sh5H3X0uelJd
         JEJ/j62ep/gloDDfxrtlQwXv4iWD5/28PL3b1oTH9yPaPhhBZC/INH3PWS/kGE9wmCrO
         9K1uvPFt3bqY6IgcjI8tZNLs4sQ0UJ2XwygcP3MSmZ0VLDp9/fDTG+oykzbZaivtiWs0
         y8PA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765967521; x=1766572321;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=2R9GurKYbVeB/8LafeEx/1FAQx1LNAFb9JUiNzsNVDc=;
        b=rM/Zp+ByanuUHwgxKOoCdFNLwH8+gHxuAHSbtH5oGLQaHNGairQ3aJLLJkqh7zBxIM
         rRW/6bcP9YLEqyViZTKSXDI5qxiBbtePbHk54Gs+/9EMnpOCxNyOMiZvvC5UwsrCzxSm
         pqalCfE32jzPEawhw00qaXCe1p7qrkRlzQNI/4OOaEcs2YHfFc+iXVBdS4/Hs+e605Tu
         qux4eA+m5faKdf10g06RI/xEM/fB/8hChHxml2P3An1SOyqZXDZvacrjWnYHRdHkYS/q
         CGA/NLg4RrQKyKi/ip8+SN2OCeOWyJyOLHwH9kfBu9JVa9H98RZ8yCKK+36+TVGYsaNe
         r13g==
X-Forwarded-Encrypted: i=1; AJvYcCVk+v0Rwh7qGmiNeTjaQZV9qUIYw2/NVSMXphvepOwiRX35/3vamZAQobVGgi2YO42H8Nr7scbz@lists.cip-project.org
X-Gm-Message-State: AOJu0Yycm2ghFLEWVUlraOM7Nba6M9bfBglbu5jY4cuHggAdKJWK03vY
	JfemnYVioxKQDn0LhXzufYvGQGEJ1tL0ZanQC7KeYrTK0QPEX87TOLBQQUWqAl+WbzI=
X-Gm-Gg: AY/fxX4vYgbsEeGLR+jgG/1YLaoozYmYrcNv12i2CLE0JHkL5+DGYgaxGdo0LPzuzmp
	BI8c/CGgMdiHo28gw8UyzsYmakU6dNvi8PO1qMNWq7+1OJce12IuuhjDf6E7gbAjoc4ZwgmUJ1r
	a8KOzyqsASZF1il4M92ysLXT3fvgycxc4a2hYXk5QdamT3Exc16axNWbU2d800YC62Ko1i2eQvr
	Nzx0JweflNyro3p/se8ms9mbhaDYRGvSnh+Zb2g6qB2f262suQ7WJW45aXi3Tplnd8hTFoyhgmc
	+vIsWJcnokpxGFfx22IsvGDg4JcyYg1j7FD2EC+KPuG5S2xMkmzhDaq78zl0a5AjEho6LAxzYh2
	MKfIwKOCI4+m7QoRXexi/GO2foFhxGlWc4tDBuX0prYD7R9hfnU+Bh+DaUc/AfFl1rqdLLAIgPV
	j2rXuo9pkw3xtdnDBfQZbNiy2Mc2ZseazX/BMUfokwD7yNH2oY28k=
X-Google-Smtp-Source: AGHT+IHDbH1PjMBl1tBvMHf/GP9WiAo7eP+XiwfLrLG+sldPlXXdElgqrMYpnI4kqvjeClqg1p8Ung==
X-Received: by 2002:a17:906:c146:b0:b73:1b97:5ddd with SMTP id a640c23a62f3a-b7d0218c961mr2248635566b.8.1765967521362;
        Wed, 17 Dec 2025 02:32:01 -0800 (PST)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.134])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-64b3f584800sm2050292a12.30.2025.12.17.02.32.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Dec 2025 02:32:00 -0800 (PST)
From: Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To: pavel@denx.de,
	nobuhiro.iwamatsu.x90@mail.toshiba
Cc: claudiu.beznea@tuxon.dev,
	cip-dev@lists.cip-project.org
Subject: [PATCH 5.10.y-cip 3/7] dt-bindings: thermal: r9a08g045-tsu: Document the TSU unit
Date: Wed, 17 Dec 2025 12:31:44 +0200
Message-ID: <20251217103149.4182935-4-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251217103149.4182935-1-claudiu.beznea.uj@bp.renesas.com>
References: <20251217103149.4182935-1-claudiu.beznea.uj@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 17 Dec 2025 10:32:05 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/21100

From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

commit a3152e5c742ca2557c5cd0e5a9e6ca6b9a92df93 upstream.

The Renesas RZ/G3S SoC includes a Thermal Sensor Unit (TSU) block designed
to measure the junction temperature. The temperature is measured using
the RZ/G3S ADC, with a dedicated ADC channel directly connected to the TSU.
Add documentation for it.

Reviewed-by: Rob Herring (Arm) <robh@kernel.org>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Tested-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
Link: https://lore.kernel.org/r/20250810122125.792966-2-claudiu.beznea.uj@bp.renesas.com
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
---
 .../thermal/renesas,r9a08g045-tsu.yaml        | 93 +++++++++++++++++++
 1 file changed, 93 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/thermal/renesas,r9a08g045-tsu.yaml

diff --git a/Documentation/devicetree/bindings/thermal/renesas,r9a08g045-tsu.yaml b/Documentation/devicetree/bindings/thermal/renesas,r9a08g045-tsu.yaml
new file mode 100644
index 000000000000..573e2b9d3752
--- /dev/null
+++ b/Documentation/devicetree/bindings/thermal/renesas,r9a08g045-tsu.yaml
@@ -0,0 +1,93 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/thermal/renesas,r9a08g045-tsu.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Renesas RZ/G3S Thermal Sensor Unit
+
+description:
+  The thermal sensor unit (TSU) measures the temperature(Tj) inside
+  the LSI.
+
+maintainers:
+  - Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
+
+$ref: thermal-sensor.yaml#
+
+properties:
+  compatible:
+    const: renesas,r9a08g045-tsu
+
+  reg:
+    maxItems: 1
+
+  clocks:
+    items:
+      - description: TSU module clock
+
+  power-domains:
+    maxItems: 1
+
+  resets:
+    items:
+      - description: TSU module reset
+
+  io-channels:
+    items:
+      - description: ADC channel which reports the TSU temperature
+
+  io-channel-names:
+    items:
+      - const: tsu
+
+  "#thermal-sensor-cells":
+    const: 0
+
+required:
+  - compatible
+  - reg
+  - clocks
+  - power-domains
+  - resets
+  - io-channels
+  - io-channel-names
+  - '#thermal-sensor-cells'
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/clock/r9a08g045-cpg.h>
+
+    tsu: thermal@10059000 {
+        compatible = "renesas,r9a08g045-tsu";
+        reg = <0x10059000 0x1000>;
+        clocks = <&cpg CPG_MOD R9A08G045_TSU_PCLK>;
+        resets = <&cpg R9A08G045_TSU_PRESETN>;
+        power-domains = <&cpg>;
+        #thermal-sensor-cells = <0>;
+        io-channels = <&adc 8>;
+        io-channel-names = "tsu";
+    };
+
+    thermal-zones {
+        cpu-thermal {
+            polling-delay-passive = <250>;
+            polling-delay = <1000>;
+            thermal-sensors = <&tsu>;
+
+            trips {
+                sensor_crit: sensor-crit {
+                    temperature = <125000>;
+                    hysteresis = <1000>;
+                    type = "critical";
+                };
+                target: trip-point {
+                    temperature = <100000>;
+                    hysteresis = <1000>;
+                    type = "passive";
+                };
+            };
+        };
+    };
-- 
2.43.0


