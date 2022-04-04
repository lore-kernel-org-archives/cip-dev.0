Return-Path: <prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90258C63705
	for <webhook@archiver.kernel.org>; Mon,  4 Apr 2022 18:46:46 +0000 (UTC)
Received: from relmlie5.idc.renesas.com (relmlie5.idc.renesas.com
 [210.160.252.171])
 by mx.groups.io with SMTP id smtpd.web09.34385.1649075759683192518
 for <cip-dev@lists.cip-project.org>;
 Mon, 04 Apr 2022 05:36:28 -0700
Authentication-Results: mx.groups.io;
 dkim=missing;
 spf=pass (domain: bp.renesas.com, ip: 210.160.252.171,
 mailfrom: prabhakar.mahadev-lad.rj@bp.renesas.com)
X-IronPort-AV: E=Sophos;i="5.90,234,1643641200";
   d="scan'208";a="115672035"
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie5.idc.renesas.com with ESMTP; 04 Apr 2022 21:36:28 +0900
Received: from localhost.localdomain (unknown [10.226.36.204])
	by relmlir6.idc.renesas.com (Postfix) with ESMTP id 552494226B03;
	Mon,  4 Apr 2022 21:36:27 +0900 (JST)
From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
Cc: Biju Das <biju.das.jz@bp.renesas.com>
Subject: [PATCH 5.10.y-cip 25/29] dt-bindings: thermal: Document Renesas
 RZ/G2L TSU
Date: Mon,  4 Apr 2022 13:35:49 +0100
Message-Id: <20220404123553.25851-26-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220404123553.25851-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20220404123553.25851-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 04 Apr 2022 18:46:46 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/7988

From: Biju Das <biju.das.jz@bp.renesas.com>

commit 9460347192add5644236d492f79ecab6d83504d4 upstream.

Document the Thermal Sensor Unit(TSU) in the RZ/G2L SoC.

Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
Reviewed-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Reviewed-by: Rob Herring <robh@kernel.org>
Link: https://lore.kernel.org/r/20211130155757.17837-2-biju.das.jz@bp.renesas.com
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
 .../bindings/thermal/rzg2l-thermal.yaml       | 76 +++++++++++++++++++
 1 file changed, 76 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/thermal/rzg2l-thermal.yaml

diff --git a/Documentation/devicetree/bindings/thermal/rzg2l-thermal.yaml b/Documentation/devicetree/bindings/thermal/rzg2l-thermal.yaml
new file mode 100644
index 000000000000..ccab9511a042
--- /dev/null
+++ b/Documentation/devicetree/bindings/thermal/rzg2l-thermal.yaml
@@ -0,0 +1,76 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/thermal/rzg2l-thermal.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Renesas RZ/G2L Thermal Sensor Unit
+
+description:
+  On RZ/G2L SoCs, the thermal sensor unit (TSU) measures the
+  temperature(Tj) inside the LSI.
+
+maintainers:
+  - Biju Das <biju.das.jz@bp.renesas.com>
+
+properties:
+  compatible:
+    items:
+      - enum:
+          - renesas,r9a07g044-tsu # RZ/G2{L,LC}
+      - const: renesas,rzg2l-tsu
+
+  reg:
+    maxItems: 1
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
+  "#thermal-sensor-cells":
+    const: 1
+
+required:
+  - compatible
+  - reg
+  - clocks
+  - power-domains
+  - resets
+  - "#thermal-sensor-cells"
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/clock/r9a07g044-cpg.h>
+
+    tsu: thermal@10059400 {
+            compatible = "renesas,r9a07g044-tsu",
+                         "renesas,rzg2l-tsu";
+            reg = <0x10059400 0x400>;
+            clocks = <&cpg CPG_MOD R9A07G044_TSU_PCLK>;
+            resets = <&cpg R9A07G044_TSU_PRESETN>;
+            power-domains = <&cpg>;
+            #thermal-sensor-cells = <1>;
+    };
+
+    thermal-zones {
+            cpu-thermal {
+                    polling-delay-passive = <250>;
+                    polling-delay = <1000>;
+                    thermal-sensors = <&tsu 0>;
+
+                    trips {
+                            sensor_crit: sensor-crit {
+                                    temperature = <125000>;
+                                    hysteresis = <1000>;
+                                    type = "critical";
+                            };
+                    };
+            };
+    };
-- 
2.17.1


