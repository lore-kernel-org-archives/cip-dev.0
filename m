Return-Path: <claudiu.beznea@tuxon.dev>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD12ED65548
	for <webhook@archiver.kernel.org>; Wed, 17 Dec 2025 10:32:35 +0000 (UTC)
Received: from mail-ej1-f65.google.com (mail-ej1-f65.google.com [209.85.218.65])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.11321.1765967548995522275
 for <cip-dev@lists.cip-project.org>;
 Wed, 17 Dec 2025 02:32:29 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@tuxon.dev header.s=google header.b=b+pPG116;
 spf=pass (domain: tuxon.dev, ip: 209.85.218.65, mailfrom: claudiu.beznea@tuxon.dev)
Received: by mail-ej1-f65.google.com with SMTP id a640c23a62f3a-b7277324054so905813066b.0
        for <cip-dev@lists.cip-project.org>; Wed, 17 Dec 2025 02:32:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1765967547; x=1766572347; darn=lists.cip-project.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2R9GurKYbVeB/8LafeEx/1FAQx1LNAFb9JUiNzsNVDc=;
        b=b+pPG116lwN73Xt2nNzvlZsgK0qgqmhOGynbxONhj2JKEVbQmdcmbL0JJRzRu+zhsK
         zBVn1VWxDk0iUG8taH/QLjbzGsF2tx/2ql8dewehT2CUPKkTVUM3podyLIE4TtwjXKfV
         XUz9Wa+PftGliuOHq8Zckk1uwoQROtTozVCMAZJaGeysoJF8vaXGM46VG8+grVjs4xXW
         8G93GObK2U0wINvrFXMn2zuZryl/M5F0j9oSGq/gy5Zoe6hYCdxc4Hk7Du7RxTxfQdnF
         1g+AZkfT0SzHq5Z9gYGBM9GcXCA7oFqrapnwOxKaiJltCMZr+y7q0LuBvxSwCFMFyLE3
         7hgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765967547; x=1766572347;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=2R9GurKYbVeB/8LafeEx/1FAQx1LNAFb9JUiNzsNVDc=;
        b=ZhHN0no6Z8I8C5Z/APQ9luQo0LSnVl1K3iX9KCY3u5w/TQxgR6BP+ONoYxM4kHzLD4
         LLAVkontML5Owl31r9WVYQsn8FlnVLTfHEU97AINPMe4htbsHgAzbNiV+D+ZIxC8JQ+o
         JHPeqJxHGQr5SxA6sFS9Dvy1eZkypqMC3jILB8FeptBp0LPNWP/vAkRfEcyQ3KkReZfk
         M8jqi9mtt3hmJwNLfVazRO76rWgCu930l48YRjoh+4Z+lY0KS1UlEgMgsicWcVbiH8ut
         tTqusewZVa7x71UwWe069uPFtnZv6tiZEM2gtNDvRqxJ1aPTvxbNwKo1Sd+SvmK3R/Y6
         XXRA==
X-Forwarded-Encrypted: i=1; AJvYcCWAAD5nO9rmQG1HDGWhGQPiTyCN7G86At8jyVsqqzrp11nKlgkxtOb9g6ng5EPNiy+nCeOPlnQU@lists.cip-project.org
X-Gm-Message-State: AOJu0Yy7r1JPl1TY4dNUig7yLuGrjHux+Z82UOnjDZm1dFLPz1FfDnqA
	VXBRF/WETabxfUDRWwwCsSet+RMPiDJzKSelp9YOJyhgVj4EOU1cGD9+cdTXSmdFmyA=
X-Gm-Gg: AY/fxX4KDbuuSxKucXO+9xRA48NelabZWPYdf2eI/YLzO0n2eJusvCTXG/yfDtVQ8Pt
	iZuSrNRTmGkE2Ndakbzd0YvvZI0SuvYtqNk4ZljZ7VvV/jimiUjvA9GEfn86nBFyDlVgY6T5cBU
	pv2NmjeWUDV27/WaP5nOdI5POFYznYOTECGWTqOEAfy9q1joNhSNzqSFtczl42cAT4y+ZIBQ2B4
	D/BI9VbkWgi28guUyv8OYrqmBzrztecbpneiICJbSAHoV6nyfYArddtLGllqzWGT2cmgFI5G9cq
	b36Jvi/hOR1d0/VwrLGN9MyfRlbD12Z/EtwiwDriC3poizD4klx9K6tRyfkGv026HBZP68gkVBY
	zQtAI0U0Ue/zLmwZoQnni95oKR9cV+DVNHdRexb4+pRq275X9cDRoAgPSzulOVA+qVOX5fVv+W3
	rqskqoi9qwTXG54DKZEutcQ0NB30cBpykkifM0Z/gl
X-Google-Smtp-Source: AGHT+IHxjVZBoLj7SkSvu7rlyGCQTwDro4k6lWKG8A1X5uC+rKja/CxrADe0FrrwUiIhSTw3n5c/wQ==
X-Received: by 2002:a17:906:f5a9:b0:b70:fd2f:6a46 with SMTP id a640c23a62f3a-b7d2361f366mr1871636766b.20.1765967547264;
        Wed, 17 Dec 2025 02:32:27 -0800 (PST)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.134])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b7cfa2e6edesm1955414166b.18.2025.12.17.02.32.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Dec 2025 02:32:26 -0800 (PST)
From: Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To: pavel@denx.de,
	nobuhiro.iwamatsu.x90@mail.toshiba
Cc: claudiu.beznea@tuxon.dev,
	cip-dev@lists.cip-project.org
Subject: [PATCH 6.12.y-cip 2/6] dt-bindings: thermal: r9a08g045-tsu: Document the TSU unit
Date: Wed, 17 Dec 2025 12:32:18 +0200
Message-ID: <20251217103222.4183089-3-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251217103222.4183089-1-claudiu.beznea.uj@bp.renesas.com>
References: <20251217103222.4183089-1-claudiu.beznea.uj@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 17 Dec 2025 10:32:35 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/21115

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


