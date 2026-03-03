Return-Path: <cosmin-gabriel.tanislav.xa@renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96DDCEDA6AB
	for <webhook@archiver.kernel.org>; Tue,  3 Mar 2026 16:54:50 +0000 (UTC)
Received: from relmlie6.idc.renesas.com (relmlie6.idc.renesas.com [210.160.252.172])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.23260.1772556884440938222
 for <cip-dev@lists.cip-project.org>;
 Tue, 03 Mar 2026 08:54:44 -0800
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: renesas.com, ip: 210.160.252.172, mailfrom: cosmin-gabriel.tanislav.xa@renesas.com)
X-CSE-ConnectionGUID: 8yPpBxCbTSutHQxHDqAa6w==
X-CSE-MsgGUID: LbdSlJu7QLum580KXxkPdA==
Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie6.idc.renesas.com with ESMTP; 04 Mar 2026 01:54:43 +0900
Received: from demon-pc.localdomain (unknown [10.226.93.13])
	by relmlir5.idc.renesas.com (Postfix) with ESMTP id 9FEC240031DC;
	Wed,  4 Mar 2026 01:54:42 +0900 (JST)
From: Cosmin Tanislav <cosmin-gabriel.tanislav.xa@renesas.com>
To: cip-dev@lists.cip-project.org,
	pavel@nabladev.com,
	nobuhiro.iwamatsu.x90@mail.toshiba
Subject: [PATCH 6.12.y-cip 02/11] dt-bindings: iio: adc: document RZ/T2H and RZ/N2H ADC
Date: Tue,  3 Mar 2026 18:53:42 +0200
Message-ID: <20260303165351.914437-3-cosmin-gabriel.tanislav.xa@renesas.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260303165351.914437-1-cosmin-gabriel.tanislav.xa@renesas.com>
References: <20260303165351.914437-1-cosmin-gabriel.tanislav.xa@renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 03 Mar 2026 16:54:50 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/22062

commit 4d8d58987cb57b3fe9721590888a99310a0e2cda upstream.

Document the A/D 12-Bit successive approximation converters found in the
Renesas RZ/T2H (R9A09G077) and RZ/N2H (R9A09G087) SoCs.

RZ/T2H has two ADCs with 4 channels and one with 6.
RZ/N2H has two ADCs with 4 channels and one with 15.

Signed-off-by: Cosmin Tanislav <cosmin-gabriel.tanislav.xa@renesas.com>
Acked-by: Conor Dooley <conor.dooley@microchip.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Signed-off-by: Cosmin Tanislav <cosmin-gabriel.tanislav.xa@renesas.com>
---
 .../iio/adc/renesas,r9a09g077-adc.yaml        | 135 ++++++++++++++++++
 MAINTAINERS                                   |   7 +
 2 files changed, 142 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/adc/renesas,r9a09g077-adc.yaml

diff --git a/Documentation/devicetree/bindings/iio/adc/renesas,r9a09g077-adc.yaml b/Documentation/devicetree/bindings/iio/adc/renesas,r9a09g077-adc.yaml
new file mode 100644
index 000000000000..dc0206b28231
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/adc/renesas,r9a09g077-adc.yaml
@@ -0,0 +1,135 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/iio/adc/renesas,r9a09g077-adc.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Renesas RZ/T2H / RZ/N2H ADC12
+
+maintainers:
+  - Cosmin Tanislav <cosmin-gabriel.tanislav.xa@renesas.com>
+
+description: |
+  A/D Converter block is a successive approximation analog-to-digital converter
+  with a 12-bit accuracy. Up to 16 analog input channels can be selected.
+  Conversions can be performed in single or continuous mode. Result of the ADC
+  is stored in a 16-bit data register corresponding to each channel.
+
+properties:
+  compatible:
+    oneOf:
+      - items:
+          - const: renesas,r9a09g087-adc # RZ/N2H
+          - const: renesas,r9a09g077-adc # RZ/T2H
+      - items:
+          - const: renesas,r9a09g077-adc # RZ/T2H
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    items:
+      - description: A/D scan end interrupt
+      - description: A/D scan end interrupt for Group B
+      - description: A/D scan end interrupt for Group C
+      - description: Window A compare match
+      - description: Window B compare match
+      - description: Compare match
+      - description: Compare mismatch
+
+  interrupt-names:
+    items:
+      - const: adi
+      - const: gbadi
+      - const: gcadi
+      - const: cmpai
+      - const: cmpbi
+      - const: wcmpm
+      - const: wcmpum
+
+  clocks:
+    items:
+      - description: Converter clock
+      - description: Peripheral clock
+
+  clock-names:
+    items:
+      - const: adclk
+      - const: pclk
+
+  power-domains:
+    maxItems: 1
+
+  '#address-cells':
+    const: 1
+
+  '#size-cells':
+    const: 0
+
+  "#io-channel-cells":
+    const: 1
+
+patternProperties:
+  "^channel@[0-9a-f]$":
+    $ref: adc.yaml
+    type: object
+    description: The external channels which are connected to the ADC.
+
+    properties:
+      reg:
+        description: The channel number.
+        maximum: 15
+
+    required:
+      - reg
+
+    additionalProperties: false
+
+required:
+  - compatible
+  - reg
+  - interrupts
+  - clocks
+  - clock-names
+  - power-domains
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/clock/renesas,r9a09g077-cpg-mssr.h>
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+
+    adc@80008000 {
+      compatible = "renesas,r9a09g077-adc";
+      reg = <0x80008000 0x400>;
+      interrupts = <GIC_SPI 708 IRQ_TYPE_EDGE_RISING>,
+                   <GIC_SPI 709 IRQ_TYPE_EDGE_RISING>,
+                   <GIC_SPI 710 IRQ_TYPE_EDGE_RISING>,
+                   <GIC_SPI 711 IRQ_TYPE_LEVEL_HIGH>,
+                   <GIC_SPI 712 IRQ_TYPE_LEVEL_HIGH>,
+                   <GIC_SPI 855 IRQ_TYPE_EDGE_RISING>,
+                   <GIC_SPI 856 IRQ_TYPE_EDGE_RISING>;
+      interrupt-names = "adi", "gbadi", "gcadi",
+                        "cmpai", "cmpbi", "wcmpm", "wcmpum";
+      clocks = <&cpg CPG_CORE R9A09G077_CLK_PCLKL>,
+               <&cpg CPG_MOD 225>;
+      clock-names = "adclk", "pclk";
+      power-domains = <&cpg>;
+      #address-cells = <1>;
+      #size-cells = <0>;
+      #io-channel-cells = <1>;
+
+      channel@0 {
+        reg = <0x0>;
+      };
+      channel@1 {
+        reg = <0x1>;
+      };
+      channel@2 {
+        reg = <0x2>;
+      };
+      channel@3 {
+        reg = <0x3>;
+      };
+    };
diff --git a/MAINTAINERS b/MAINTAINERS
index 50f44b9d6e8d..ec00eee33131 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -19686,6 +19686,13 @@ S:	Supported
 F:	Documentation/devicetree/bindings/timer/renesas,rz-mtu3.yaml
 F:	drivers/counter/rz-mtu3-cnt.c
 
+RENESAS RZ/T2H / RZ/N2H A/D DRIVER
+M:	Cosmin Tanislav <cosmin-gabriel.tanislav.xa@renesas.com>
+L:	linux-iio@vger.kernel.org
+L:	linux-renesas-soc@vger.kernel.org
+S:	Supported
+F:	Documentation/devicetree/bindings/iio/adc/renesas,r9a09g077-adc.yaml
+
 RENESAS RTCA-3 RTC DRIVER
 M:	Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
 L:	linux-rtc@vger.kernel.org
-- 
2.53.0


