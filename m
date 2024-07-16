Return-Path: <biju.das.jz@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BFDEEC41513
	for <webhook@archiver.kernel.org>; Tue, 16 Jul 2024 08:24:08 +0000 (UTC)
Received: from relmlie6.idc.renesas.com (relmlie6.idc.renesas.com [210.160.252.172])
 by mx.groups.io with SMTP id smtpd.web10.5938.1721118211284299661
 for <cip-dev@lists.cip-project.org>;
 Tue, 16 Jul 2024 01:24:00 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: bp.renesas.com, ip: 210.160.252.172, mailfrom: biju.das.jz@bp.renesas.com)
X-IronPort-AV: E=Sophos;i="6.09,211,1716217200"; 
   d="scan'208";a="215426083"
Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie6.idc.renesas.com with ESMTP; 16 Jul 2024 17:24:00 +0900
Received: from localhost.localdomain (unknown [10.226.92.125])
	by relmlir5.idc.renesas.com (Postfix) with ESMTP id 504944016D5E;
	Tue, 16 Jul 2024 17:23:58 +0900 (JST)
From: Biju Das <biju.das.jz@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
Cc: Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH 5.10.y-cip 27/31] dt-bindings: thermal: Convert da906{1,2} thermal to json-schema
Date: Tue, 16 Jul 2024 09:22:38 +0100
Message-ID: <20240716082255.56551-28-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240716082255.56551-1-biju.das.jz@bp.renesas.com>
References: <20240716082255.56551-1-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 16 Jul 2024 08:24:08 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/16553

commit fddee1e686de077c80ad9dd61f4a50fa1d8b6605 upstream.

Convert the da906{1,2} thermal device tree binding documentation to
json-schema.

Update MAINTAINERS entries and description by referring to
dlg,da9062-thermal.yaml binding file.

Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
Reviewed-by: Rob Herring <robh@kernel.org>
Link: https://lore.kernel.org/r/20240131102656.3379-5-biju.das.jz@bp.renesas.com
Signed-off-by: Lee Jones <lee@kernel.org>
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
 .../devicetree/bindings/mfd/da9062.txt        |  2 +-
 .../bindings/thermal/da9062-thermal.txt       | 36 -------------------
 .../bindings/thermal/dlg,da9062-thermal.yaml  | 35 ++++++++++++++++++
 MAINTAINERS                                   |  2 +-
 4 files changed, 37 insertions(+), 38 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/thermal/da9062-thermal.txt
 create mode 100644 Documentation/devicetree/bindings/thermal/dlg,da9062-thermal.yaml

diff --git a/Documentation/devicetree/bindings/mfd/da9062.txt b/Documentation/devicetree/bindings/mfd/da9062.txt
index a788a31587fa..4a5167c2d35f 100644
--- a/Documentation/devicetree/bindings/mfd/da9062.txt
+++ b/Documentation/devicetree/bindings/mfd/da9062.txt
@@ -87,7 +87,7 @@ Sub-nodes:
 
 - watchdog: See ../watchdog/dlg,da9062-watchdog.yaml
 
-- thermal : See ../thermal/da9062-thermal.txt
+- thermal : See ../thermal/dlg,da9062-thermal.yaml
 
 Example:
 
diff --git a/Documentation/devicetree/bindings/thermal/da9062-thermal.txt b/Documentation/devicetree/bindings/thermal/da9062-thermal.txt
deleted file mode 100644
index e241bb5a5584..000000000000
--- a/Documentation/devicetree/bindings/thermal/da9062-thermal.txt
+++ /dev/null
@@ -1,36 +0,0 @@
-* Dialog DA9062/61 TJUNC Thermal Module
-
-This module is part of the DA9061/DA9062. For more details about entire
-DA9062 and DA9061 chips see Documentation/devicetree/bindings/mfd/da9062.txt
-
-Junction temperature thermal module uses an interrupt signal to identify
-high THERMAL_TRIP_HOT temperatures for the PMIC device.
-
-Required properties:
-
-- compatible: should be one of the following valid compatible string lines:
-        "dlg,da9061-thermal", "dlg,da9062-thermal"
-        "dlg,da9062-thermal"
-
-Optional properties:
-
-- polling-delay-passive : Specify the polling period, measured in
-    milliseconds, between thermal zone device update checks.
-
-Example: DA9062
-
-	pmic0: da9062@58 {
-		thermal {
-			compatible = "dlg,da9062-thermal";
-			polling-delay-passive = <3000>;
-		};
-	};
-
-Example: DA9061 using a fall-back compatible for the DA9062 onkey driver
-
-	pmic0: da9061@58 {
-		thermal {
-			compatible = "dlg,da9061-thermal", "dlg,da9062-thermal";
-			polling-delay-passive = <3000>;
-		};
-	};
diff --git a/Documentation/devicetree/bindings/thermal/dlg,da9062-thermal.yaml b/Documentation/devicetree/bindings/thermal/dlg,da9062-thermal.yaml
new file mode 100644
index 000000000000..206635f74850
--- /dev/null
+++ b/Documentation/devicetree/bindings/thermal/dlg,da9062-thermal.yaml
@@ -0,0 +1,35 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/thermal/dlg,da9062-thermal.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Dialog DA9062/61 TJUNC Thermal Module
+
+maintainers:
+  - Biju Das <biju.das.jz@bp.renesas.com>
+
+description: |
+  This module is part of the DA9061/DA9062. For more details about entire
+  DA9062 and DA9061 chips see Documentation/devicetree/bindings/mfd/da9062.txt
+
+  Junction temperature thermal module uses an interrupt signal to identify
+  high THERMAL_TRIP_HOT temperatures for the PMIC device.
+
+properties:
+  compatible:
+    oneOf:
+      - const: dlg,da9062-thermal
+      - items:
+          - const: dlg,da9061-thermal
+          - const: dlg,da9062-thermal
+
+  polling-delay-passive:
+    description:
+      Specify the polling period, measured in milliseconds, between
+      thermal zone device update checks.
+
+required:
+  - compatible
+
+additionalProperties: false
diff --git a/MAINTAINERS b/MAINTAINERS
index 4146059a7144..4e2d9ed016ab 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -5127,7 +5127,7 @@ F:	Documentation/devicetree/bindings/mfd/da90*.yaml
 F:	Documentation/devicetree/bindings/regulator/da92*.txt
 F:	Documentation/devicetree/bindings/regulator/slg51000.txt
 F:	Documentation/devicetree/bindings/sound/da[79]*.txt
-F:	Documentation/devicetree/bindings/thermal/da90??-thermal.txt
+F:	Documentation/devicetree/bindings/thermal/dlg,da9062-thermal.yaml
 F:	Documentation/devicetree/bindings/watchdog/dlg,da9062-watchdog.yaml
 F:	Documentation/hwmon/da90??.rst
 F:	drivers/gpio/gpio-da90??.c
-- 
2.43.0


