Return-Path: <prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA61AC4332F
	for <webhook@archiver.kernel.org>; Mon, 10 Jan 2022 11:53:55 +0000 (UTC)
Received: from relmlie6.idc.renesas.com (relmlie6.idc.renesas.com
 [210.160.252.172])
 by mx.groups.io with SMTP id smtpd.web12.30350.1641815634920037812
 for <cip-dev@lists.cip-project.org>;
 Mon, 10 Jan 2022 03:53:55 -0800
Authentication-Results: mx.groups.io;
 dkim=missing;
 spf=pass (domain: bp.renesas.com, ip: 210.160.252.172,
 mailfrom: prabhakar.mahadev-lad.rj@bp.renesas.com)
X-IronPort-AV: E=Sophos;i="5.88,276,1635174000";
   d="scan'208";a="106552687"
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie6.idc.renesas.com with ESMTP; 10 Jan 2022 20:53:54 +0900
Received: from localhost.localdomain (unknown [10.226.36.204])
	by relmlir6.idc.renesas.com (Postfix) with ESMTP id 31C16429BEAD;
	Mon, 10 Jan 2022 20:53:53 +0900 (JST)
From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
Cc: Biju Das <biju.das.jz@bp.renesas.com>
Subject: [PATCH v2 5.10.y-cip 03/15] dt-bindings: iio: adc: Add binding
 documentation for Renesas RZ/G2L A/D converter
Date: Mon, 10 Jan 2022 11:53:36 +0000
Message-Id: <20220110115348.14297-4-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220110115348.14297-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20220110115348.14297-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 10 Jan 2022 11:53:55 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/7352

commit 08080963162740abdd8a35f6c3aad0e744f71627 upstream.

Add binding documentation for Renesas RZ/G2L A/D converter block.

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Reviewed-by: Biju Das <biju.das.jz@bp.renesas.com>
Reviewed-by: Rob Herring <robh@kernel.org>
Link: https://lore.kernel.org/r/20210804202118.25745-2-prabhakar.mahadev-lad.rj@bp.renesas.com
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
 .../bindings/iio/adc/renesas,rzg2l-adc.yaml   | 134 ++++++++++++++++++
 1 file changed, 134 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/adc/renesas,rzg2l-adc.yaml

diff --git a/Documentation/devicetree/bindings/iio/adc/renesas,rzg2l-adc.yaml b/Documentation/devicetree/bindings/iio/adc/renesas,rzg2l-adc.yaml
new file mode 100644
index 000000000000..c80201d6a716
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/adc/renesas,rzg2l-adc.yaml
@@ -0,0 +1,134 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/iio/adc/renesas,rzg2l-adc.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Renesas RZ/G2L ADC
+
+maintainers:
+  - Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
+
+description: |
+  A/D Converter block is a successive approximation analog-to-digital converter
+  with a 12-bit accuracy. Up to eight analog input channels can be selected.
+  Conversions can be performed in single or repeat mode. Result of the ADC is
+  stored in a 32-bit data register corresponding to each channel.
+
+properties:
+  compatible:
+    items:
+      - enum:
+          - renesas,r9a07g044-adc   # RZ/G2{L,LC}
+      - const: renesas,rzg2l-adc
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    maxItems: 1
+
+  clocks:
+    items:
+      - description: converter clock
+      - description: peripheral clock
+
+  clock-names:
+    items:
+      - const: adclk
+      - const: pclk
+
+  power-domains:
+    maxItems: 1
+
+  resets:
+    maxItems: 2
+
+  reset-names:
+    items:
+      - const: presetn
+      - const: adrst-n
+
+  '#address-cells':
+    const: 1
+
+  '#size-cells':
+    const: 0
+
+required:
+  - compatible
+  - reg
+  - interrupts
+  - clocks
+  - clock-names
+  - power-domains
+  - resets
+  - reset-names
+
+patternProperties:
+  "^channel@[0-7]$":
+    $ref: "adc.yaml"
+    type: object
+    description: |
+      Represents the external channels which are connected to the ADC.
+
+    properties:
+      reg:
+        description: |
+          The channel number. It can have up to 8 channels numbered from 0 to 7.
+        items:
+          - minimum: 0
+            maximum: 7
+
+    required:
+      - reg
+
+    additionalProperties: false
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/clock/r9a07g044-cpg.h>
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+
+    adc: adc@10059000 {
+      compatible = "renesas,r9a07g044-adc", "renesas,rzg2l-adc";
+      reg = <0x10059000 0x400>;
+      interrupts = <GIC_SPI 347 IRQ_TYPE_EDGE_RISING>;
+      clocks = <&cpg CPG_MOD R9A07G044_ADC_ADCLK>,
+               <&cpg CPG_MOD R9A07G044_ADC_PCLK>;
+      clock-names = "adclk", "pclk";
+      power-domains = <&cpg>;
+      resets = <&cpg R9A07G044_ADC_PRESETN>,
+               <&cpg R9A07G044_ADC_ADRST_N>;
+      reset-names = "presetn", "adrst-n";
+
+      #address-cells = <1>;
+      #size-cells = <0>;
+
+      channel@0 {
+        reg = <0>;
+      };
+      channel@1 {
+        reg = <1>;
+      };
+      channel@2 {
+        reg = <2>;
+      };
+      channel@3 {
+        reg = <3>;
+      };
+      channel@4 {
+        reg = <4>;
+      };
+      channel@5 {
+        reg = <5>;
+      };
+      channel@6 {
+        reg = <6>;
+      };
+      channel@7 {
+        reg = <7>;
+      };
+    };
-- 
2.17.1


