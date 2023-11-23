Return-Path: <biju.das.jz@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B48C2C5AD4C
	for <webhook@archiver.kernel.org>; Thu, 23 Nov 2023 18:29:09 +0000 (UTC)
Received: from relmlie6.idc.renesas.com (relmlie6.idc.renesas.com [210.160.252.172])
 by mx.groups.io with SMTP id smtpd.web10.101407.1700764141415025609
 for <cip-dev@lists.cip-project.org>;
 Thu, 23 Nov 2023 10:29:02 -0800
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: bp.renesas.com, ip: 210.160.252.172, mailfrom: biju.das.jz@bp.renesas.com)
X-IronPort-AV: E=Sophos;i="6.04,222,1695654000"; 
   d="scan'208";a="187858427"
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie6.idc.renesas.com with ESMTP; 24 Nov 2023 03:29:01 +0900
Received: from localhost.localdomain (unknown [10.226.92.37])
	by relmlir6.idc.renesas.com (Postfix) with ESMTP id 9C1B640555FC;
	Fri, 24 Nov 2023 03:28:59 +0900 (JST)
From: Biju Das <biju.das.jz@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
Cc: Biju Das <biju.das.jz@bp.renesas.com>,
	Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Subject: [PATCH 6.1.y-cip v2 01/12] dt-bindings: clock: Add Renesas versa3 clock generator bindings
Date: Thu, 23 Nov 2023 18:28:43 +0000
Message-Id: <20231123182854.422379-2-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231123182854.422379-1-biju.das.jz@bp.renesas.com>
References: <20231123182854.422379-1-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 23 Nov 2023 18:29:09 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/13674

commit a03d23f860eb438c7da88f934448e6caa0f92851 upstream.

Document Renesas versa3 clock generator(5P35023) bindings.

The 5P35023 is a VersaClock programmable clock generator and
is designed for low-power, consumer, and high-performance PCI
Express applications. The 5P35023 device is a three PLL
architecture design, and each PLL is individually programmable
and allowing for up to 6 unique frequency outputs.

Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Link: https://lore.kernel.org/r/20230705171000.85786-2-biju.das.jz@bp.renesas.com
Signed-off-by: Stephen Boyd <sboyd@kernel.org>
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
 .../bindings/clock/renesas,5p35023.yaml       | 86 +++++++++++++++++++
 1 file changed, 86 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/clock/renesas,5p35023.yaml

diff --git a/Documentation/devicetree/bindings/clock/renesas,5p35023.yaml b/Documentation/devicetree/bindings/clock/renesas,5p35023.yaml
new file mode 100644
index 000000000000..839648e753d4
--- /dev/null
+++ b/Documentation/devicetree/bindings/clock/renesas,5p35023.yaml
@@ -0,0 +1,86 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/clock/renesas,5p35023.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Renesas 5p35023 VersaClock 3 programmable I2C clock generator
+
+maintainers:
+  - Biju Das <biju.das.jz@bp.renesas.com>
+
+description: |
+  The 5P35023 is a VersaClock programmable clock generator and
+  is designed for low-power, consumer, and high-performance PCI
+  express applications. The 5P35023 device is a three PLL
+  architecture design, and each PLL is individually programmable
+  and allowing for up to 6 unique frequency outputs.
+
+  An internal OTP memory allows the user to store the configuration
+  in the device. After power up, the user can change the device register
+  settings through the I2C interface when I2C mode is selected.
+
+  The driver can read a full register map from the DT, and will use that
+  register map to initialize the attached part (via I2C) when the system
+  boots. Any configuration not supported by the common clock framework
+  must be done via the full register map, including optimized settings.
+
+  Link to datasheet:
+  https://www.renesas.com/us/en/products/clocks-timing/clock-generation/programmable-clocks/5p35023-versaclock-3s-programmable-clock-generator
+
+properties:
+  compatible:
+    enum:
+      - renesas,5p35023
+
+  reg:
+    maxItems: 1
+
+  '#clock-cells':
+    const: 1
+
+  clocks:
+    maxItems: 1
+
+  renesas,settings:
+    description: Optional, complete register map of the device.
+      Optimized settings for the device must be provided in full
+      and are written during initialization.
+    $ref: /schemas/types.yaml#/definitions/uint8-array
+    maxItems: 37
+
+required:
+  - compatible
+  - reg
+  - '#clock-cells'
+  - clocks
+
+additionalProperties: false
+
+examples:
+  - |
+    i2c {
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        versa3: clock-generator@68 {
+            compatible = "renesas,5p35023";
+            reg = <0x68>;
+            #clock-cells = <1>;
+
+            clocks = <&x1_x2>;
+
+            renesas,settings = [
+                80 00 11 19 4c 02 23 7f 83 19 08 a9 5f 25 24 bf
+                00 14 7a e1 00 00 00 00 01 55 59 bb 3f 30 90 b6
+                80 b0 45 c4 95
+            ];
+
+            assigned-clocks = <&versa3 0>, <&versa3 1>,
+                              <&versa3 2>, <&versa3 3>,
+                              <&versa3 4>, <&versa3 5>;
+            assigned-clock-rates = <12288000>, <25000000>,
+                                   <12000000>, <11289600>,
+                                   <11289600>, <24000000>;
+        };
+    };
-- 
2.25.1


