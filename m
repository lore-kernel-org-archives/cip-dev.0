Return-Path: <biju.das.jz@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 247C0C7EE2C
	for <webhook@archiver.kernel.org>; Wed, 24 May 2023 12:49:55 +0000 (UTC)
Received: from relmlie6.idc.renesas.com (relmlie6.idc.renesas.com [210.160.252.172])
 by mx.groups.io with SMTP id smtpd.web10.7861.1684932583108467280
 for <cip-dev@lists.cip-project.org>;
 Wed, 24 May 2023 05:49:49 -0700
Authentication-Results: mx.groups.io;
 dkim=missing; spf=pass (domain: bp.renesas.com, ip: 210.160.252.172, mailfrom: biju.das.jz@bp.renesas.com)
X-IronPort-AV: E=Sophos;i="6.00,189,1681138800"; 
   d="scan'208";a="164171368"
Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie6.idc.renesas.com with ESMTP; 24 May 2023 21:49:48 +0900
Received: from localhost.localdomain (unknown [10.226.93.65])
	by relmlir5.idc.renesas.com (Postfix) with ESMTP id F39DF4000AA0;
	Wed, 24 May 2023 21:49:46 +0900 (JST)
From: Biju Das <biju.das.jz@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
Cc: Chris Paterson <chris.paterson2@renesas.com>,
	Biju Das <biju.das.jz@bp.renesas.com>,
	Fabrizio Castro <fabrizio.castro.jz@renesas.com>
Subject: [PATCH 5.10.y-cip v2 03/10] dt-bindings: i2c: Document RZ/V2M I2C controller
Date: Wed, 24 May 2023 13:49:30 +0100
Message-Id: <20230524124937.160355-4-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230524124937.160355-1-biju.das.jz@bp.renesas.com>
References: <20230524124937.160355-1-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 24 May 2023 12:49:55 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/11637

From: Phil Edworthy <phil.edworthy@renesas.com>

commit ba7a4d15e2c40f8fa37b38e4379e70019227dba0 upstream.

Document Renesas RZ/V2M (r9a09g011) I2C controller bindings.

Signed-off-by: Phil Edworthy <phil.edworthy@renesas.com>
Reviewed-by: Biju Das <biju.das.jz@bp.renesas.com>
Reviewed-by: Rob Herring <robh@kernel.org>
Signed-off-by: Wolfram Sang <wsa@kernel.org>
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
 .../bindings/i2c/renesas,rzv2m.yaml           | 80 +++++++++++++++++++
 1 file changed, 80 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/i2c/renesas,rzv2m.yaml

diff --git a/Documentation/devicetree/bindings/i2c/renesas,rzv2m.yaml b/Documentation/devicetree/bindings/i2c/renesas,rzv2m.yaml
new file mode 100644
index 000000000000..c46378efc123
--- /dev/null
+++ b/Documentation/devicetree/bindings/i2c/renesas,rzv2m.yaml
@@ -0,0 +1,80 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/i2c/renesas,rzv2m.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Renesas RZ/V2M I2C Bus Interface
+
+maintainers:
+  - Phil Edworthy <phil.edworthy@renesas.com>
+
+allOf:
+  - $ref: /schemas/i2c/i2c-controller.yaml#
+
+properties:
+  compatible:
+    items:
+      - enum:
+          - renesas,i2c-r9a09g011  # RZ/V2M
+      - const: renesas,rzv2m-i2c
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    items:
+      - description: Data transmission/reception interrupt
+      - description: Status interrupt
+
+  interrupt-names:
+    items:
+      - const: tia
+      - const: tis
+
+  clock-frequency:
+    default: 100000
+    enum: [ 100000, 400000 ]
+    description:
+      Desired I2C bus clock frequency in Hz.
+
+  clocks:
+    maxItems: 1
+
+  power-domains:
+    maxItems: 1
+
+  resets:
+    maxItems: 1
+
+required:
+  - compatible
+  - reg
+  - interrupts
+  - interrupt-names
+  - clocks
+  - power-domains
+  - resets
+  - '#address-cells'
+  - '#size-cells'
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/clock/r9a09g011-cpg.h>
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+
+    i2c0: i2c@a4030000 {
+        compatible = "renesas,i2c-r9a09g011", "renesas,rzv2m-i2c";
+        reg = <0xa4030000 0x80>;
+        interrupts = <GIC_SPI 232 IRQ_TYPE_EDGE_RISING>,
+                     <GIC_SPI 236 IRQ_TYPE_EDGE_RISING>;
+        interrupt-names = "tia", "tis";
+        clocks = <&cpg CPG_MOD R9A09G011_IIC_PCLK0>;
+        resets = <&cpg R9A09G011_IIC_GPA_PRESETN>;
+        power-domains = <&cpg>;
+        clock-frequency = <100000>;
+        #address-cells = <1>;
+        #size-cells = <0>;
+    };
-- 
2.25.1


