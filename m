Return-Path: <biju.das.jz@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96207C04A6A
	for <webhook@archiver.kernel.org>; Wed, 16 Aug 2023 14:20:29 +0000 (UTC)
Received: from relmlie6.idc.renesas.com (relmlie6.idc.renesas.com [210.160.252.172])
 by mx.groups.io with SMTP id smtpd.web10.162031.1692195624402310477
 for <cip-dev@lists.cip-project.org>;
 Wed, 16 Aug 2023 07:20:24 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: bp.renesas.com, ip: 210.160.252.172, mailfrom: biju.das.jz@bp.renesas.com)
X-IronPort-AV: E=Sophos;i="6.01,177,1684767600"; 
   d="scan'208";a="176787646"
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie6.idc.renesas.com with ESMTP; 16 Aug 2023 23:20:23 +0900
Received: from localhost.localdomain (unknown [10.226.92.162])
	by relmlir6.idc.renesas.com (Postfix) with ESMTP id EBE904210C24;
	Wed, 16 Aug 2023 23:20:21 +0900 (JST)
From: Biju Das <biju.das.jz@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
Cc: Biju Das <biju.das.jz@bp.renesas.com>,
	Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Subject: [PATCH 5.10.y-cip 01/31] regulator: dt-bindings: Add Renesas RAA215300 PMIC bindings
Date: Wed, 16 Aug 2023 15:19:47 +0100
Message-Id: <20230816142017.147173-2-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230816142017.147173-1-biju.das.jz@bp.renesas.com>
References: <20230816142017.147173-1-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 16 Aug 2023 14:20:29 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/12683

commit fff8f6b0723159f09eb2c067e626fb96402c0e53 upstream.

Document Renesas RAA215300 PMIC bindings.

The RAA215300 is a high Performance 9-Channel PMIC supporting DDR
Memory, with Built-In Charger and RTC.

It supports DDR3, DDR3L, DDR4, and LPDDR4 memory power requirements.
The internally compensated regulators, built-in Real-Time Clock (RTC),
32kHz crystal oscillator, and coin cell battery charger provide a
highly integrated, small footprint power solution ideal for
System-On-Module (SOM) applications. A spread spectrum feature
provides an ease-of-use solution for noise-sensitive audio or RF
applications.

Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
Reviewed-by: Conor Dooley <conor.dooley@microchip.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Link: https://lore.kernel.org/r/Message-Id: <20230623140948.384762-2-biju.das.jz@bp.renesas.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
 .../bindings/regulator/renesas,raa215300.yaml | 85 +++++++++++++++++++
 1 file changed, 85 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/regulator/renesas,raa215300.yaml

diff --git a/Documentation/devicetree/bindings/regulator/renesas,raa215300.yaml b/Documentation/devicetree/bindings/regulator/renesas,raa215300.yaml
new file mode 100644
index 000000000000..97cff71d2967
--- /dev/null
+++ b/Documentation/devicetree/bindings/regulator/renesas,raa215300.yaml
@@ -0,0 +1,85 @@
+# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/regulator/renesas,raa215300.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Renesas RAA215300 Power Management Integrated Circuit (PMIC)
+
+maintainers:
+  - Biju Das <biju.das.jz@bp.renesas.com>
+
+description: |
+  The RAA215300 is a high-performance, low-cost 9-channel PMIC designed for
+  32-bit and 64-bit MCU and MPU applications. It supports DDR3, DDR3L, DDR4,
+  and LPDDR4 memory power requirements. The internally compensated regulators,
+  built-in Real-Time Clock (RTC), 32kHz crystal oscillator, and coin cell
+  battery charger provide a highly integrated, small footprint power solution
+  ideal for System-On-Module (SOM) applications. A spread spectrum feature
+  provides an ease-of-use solution for noise-sensitive audio or RF applications.
+
+  This device exposes two devices via I2C. One for the integrated RTC IP, and
+  one for everything else.
+
+  Link to datasheet:
+  https://www.renesas.com/in/en/products/power-power-management/multi-channel-power-management-ics-pmics/ssdsoc-power-management-ics-pmic-and-pmus/raa215300-high-performance-9-channel-pmic-supporting-ddr-memory-built-charger-and-rtc
+
+properties:
+  compatible:
+    enum:
+      - renesas,raa215300
+
+  reg:
+    maxItems: 2
+
+  reg-names:
+    items:
+      - const: main
+      - const: rtc
+
+  interrupts:
+    maxItems: 1
+
+  clocks:
+    description: |
+      The clocks are optional. The RTC is disabled, if no clocks are
+      provided(either xin or clkin).
+    maxItems: 1
+
+  clock-names:
+    description: |
+      Use xin, if connected to an external crystal.
+      Use clkin, if connected to an external clock signal.
+    enum:
+      - xin
+      - clkin
+
+required:
+  - compatible
+  - reg
+  - reg-names
+
+additionalProperties: false
+
+examples:
+  - |
+    /* 32.768kHz crystal */
+    x2: x2-clock {
+        compatible = "fixed-clock";
+        #clock-cells = <0>;
+        clock-frequency = <32768>;
+    };
+
+    i2c {
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        raa215300: pmic@12 {
+            compatible = "renesas,raa215300";
+            reg = <0x12>, <0x6f>;
+            reg-names = "main", "rtc";
+
+            clocks = <&x2>;
+            clock-names = "xin";
+        };
+    };
-- 
2.25.1


