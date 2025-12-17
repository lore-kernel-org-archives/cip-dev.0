Return-Path: <claudiu.beznea@tuxon.dev>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A92B3D65543
	for <webhook@archiver.kernel.org>; Wed, 17 Dec 2025 10:32:25 +0000 (UTC)
Received: from mail-ej1-f66.google.com (mail-ej1-f66.google.com [209.85.218.66])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.11761.1765967537831694717
 for <cip-dev@lists.cip-project.org>;
 Wed, 17 Dec 2025 02:32:18 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@tuxon.dev header.s=google header.b=GO2316RZ;
 spf=pass (domain: tuxon.dev, ip: 209.85.218.66, mailfrom: claudiu.beznea@tuxon.dev)
Received: by mail-ej1-f66.google.com with SMTP id a640c23a62f3a-b734fcbf1e3so1120791866b.3
        for <cip-dev@lists.cip-project.org>; Wed, 17 Dec 2025 02:32:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1765967536; x=1766572336; darn=lists.cip-project.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2R9GurKYbVeB/8LafeEx/1FAQx1LNAFb9JUiNzsNVDc=;
        b=GO2316RZw+v3delgePkOPFS3DtqJl7zBYYuIzFcWTRXyhgxHyDhk75pwgZ7URJzrKr
         tIq7XDodaoSNr/ZazzqzIcr9tK4SlscTlOsf6n+psTCaQHGb3BtWQS5s/xwRcBZZmM/z
         qyFG35sZNPlBCyCED8zCN4muoSbHp5Td1l9BvNenR60paq3YrDN8mzpPAncQ1vhJDYXi
         GMAm9J6P3puuIMybN7qGW9y3v6xxJBuez40U3IeSAHnjA+FCVPdAT1J/90ikyWcLFfOe
         PQoPqHqcJOywbzqwsJpoEbsS0RBjYhi1SgPBQDzvF5NTyiP4UhjxvsEcgn4O087jqX2J
         Fmlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765967536; x=1766572336;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=2R9GurKYbVeB/8LafeEx/1FAQx1LNAFb9JUiNzsNVDc=;
        b=StZ1jIo36HwVXGEnMpF6KuEeeucpvc8MqLudKgsvNKufNcYqqbaWSUSIK6tNM2JYQu
         J98BfGu6Ff4iNOhuKCAn+JOPhPcxqBEEANuyEEpxVBTYwh3ihz5hxupeRXb885jmY8LR
         4r/EiksFEq81AD0U9z9CrsupEP2lvxcok5ZMA0PL+E2EE/aiP6DKcXSoXflQYkhNYqR6
         AOBQ8SCT80L/bHGjB0VMOcUELdPcRVSruFVweBTv5vfa1UNW9gIQQvEjCwitSLIpNBED
         D2vWeJPwr/lhzHwaVO+ZP0CXuihcZLqvy71nQjNhHsHDHPLSP8TrBrfyzRzCDGheWFGD
         awRQ==
X-Forwarded-Encrypted: i=1; AJvYcCUU9hcNzE/wmuKjY+qyfCx1fV7lBQL6p9Jhe0XYnMeETXerDX+pKV8LvI0pdRq6ArEEkSXqiL57@lists.cip-project.org
X-Gm-Message-State: AOJu0YxLfRAcuTBJZjpLOCZqbVJm0D3XElQaUQ0JilWOSJg1abKZ+/RU
	HbLw9Bxa1dSB57Pw+OgpYr58UjMMWOZq7jXGJ6R7sVashvA3m/6molGQkankVUggd00=
X-Gm-Gg: AY/fxX6OIBDF97QwLWREZvQlsRC/ijqIlv1LnSMSUM9dsJEEeJrF5YcDbf2xUkJx4rL
	jwlvG+JmkByn3HhlAKbMOXcCGIhWYDsNMBmt4rUefwNqEWcHPkgX71hm1GU1RzZVsh6jFOCrkfh
	9rBhOPEozeukfVEYqRZ5Fa/m7mnW3F5g9aXWBuoasi//WcqgOBQo00EdaqkCVhhk36lt0qDp5vj
	jUpBdi10jdKMbjB3Gqm61LHyHKmaen34ekqvkT44wes5oUMVUfGb2ksC2AiUF2osK1TByQBsdRQ
	pG7aXVppA6hq8hIORlVC2P/vcj6K0Qj+Y8h++xNNbOxvjKhgiseufkk3RdhbG0K+rvUVtQVqQDe
	B366LCxHkYSx2wy1yftPTXv3ki8nsA1BTbw88kxN3CdkGWBmpcbjZDpRoOLXw+bfdL0fdPSe+vv
	JbgJxiDwyKXoNXbvLmm37F+YeDwo+4HsNHcSe+ksiu
X-Google-Smtp-Source: AGHT+IGMAkjdaf8GHF/+OCFyOupwjrnqZQD3bRKhQMTLa2IWNJxL4655oR+ZARN/bKs0Et+0VJ7wQQ==
X-Received: by 2002:a17:906:c113:b0:b73:9be1:33ec with SMTP id a640c23a62f3a-b7d236193aamr1683915466b.9.1765967536156;
        Wed, 17 Dec 2025 02:32:16 -0800 (PST)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.134])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b7cfa29eb76sm1930249166b.12.2025.12.17.02.32.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Dec 2025 02:32:15 -0800 (PST)
From: Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To: pavel@denx.de,
	nobuhiro.iwamatsu.x90@mail.toshiba
Cc: claudiu.beznea@tuxon.dev,
	cip-dev@lists.cip-project.org
Subject: [PATCH 6.1.y-cip 3/7] dt-bindings: thermal: r9a08g045-tsu: Document the TSU unit
Date: Wed, 17 Dec 2025 12:32:06 +0200
Message-ID: <20251217103210.4183025-4-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251217103210.4183025-1-claudiu.beznea.uj@bp.renesas.com>
References: <20251217103210.4183025-1-claudiu.beznea.uj@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 17 Dec 2025 10:32:25 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/21108

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


