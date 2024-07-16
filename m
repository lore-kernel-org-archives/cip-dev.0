Return-Path: <biju.das.jz@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE631C41513
	for <webhook@archiver.kernel.org>; Tue, 16 Jul 2024 07:57:37 +0000 (UTC)
Received: from relmlie6.idc.renesas.com (relmlie6.idc.renesas.com [210.160.252.172])
 by mx.groups.io with SMTP id smtpd.web11.5547.1721116624413327341
 for <cip-dev@lists.cip-project.org>;
 Tue, 16 Jul 2024 00:57:27 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: bp.renesas.com, ip: 210.160.252.172, mailfrom: biju.das.jz@bp.renesas.com)
X-IronPort-AV: E=Sophos;i="6.09,211,1716217200"; 
   d="scan'208";a="215421638"
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie6.idc.renesas.com with ESMTP; 16 Jul 2024 16:57:27 +0900
Received: from localhost.localdomain (unknown [10.226.92.125])
	by relmlir6.idc.renesas.com (Postfix) with ESMTP id 7F1BC41CF65A;
	Tue, 16 Jul 2024 16:57:25 +0900 (JST)
From: Biju Das <biju.das.jz@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
Cc: Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH 6.1.y-cip 18/23] dt-bindings: input: Convert da906{1,2,3} onkey to json-schema
Date: Tue, 16 Jul 2024 08:56:23 +0100
Message-ID: <20240716075641.32177-19-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240716075641.32177-1-biju.das.jz@bp.renesas.com>
References: <20240716075641.32177-1-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 16 Jul 2024 07:57:37 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/16518

commit e2fcaf4c067099a1ebcdb37903e630ad0f55ed2e upstream.

Convert the da906{1,2,3} onkey device tree binding documentation to
json-schema.

Update MAINTAINERS entries, description and onkey property by
referring to dlg,da9062-onkey binding file.

Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
Reviewed-by: Conor Dooley <conor.dooley@microchip.com>
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Acked-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Link: https://lore.kernel.org/r/20240131102656.3379-4-biju.das.jz@bp.renesas.com
Signed-off-by: Lee Jones <lee@kernel.org>
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
 .../bindings/input/da9062-onkey.txt           | 47 -------------------
 .../bindings/input/dlg,da9062-onkey.yaml      | 39 +++++++++++++++
 .../devicetree/bindings/mfd/da9062.txt        |  2 +-
 .../devicetree/bindings/mfd/dlg,da9063.yaml   | 15 +-----
 MAINTAINERS                                   |  2 +-
 5 files changed, 42 insertions(+), 63 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/input/da9062-onkey.txt
 create mode 100644 Documentation/devicetree/bindings/input/dlg,da9062-onkey.yaml

diff --git a/Documentation/devicetree/bindings/input/da9062-onkey.txt b/Documentation/devicetree/bindings/input/da9062-onkey.txt
deleted file mode 100644
index e5eef59a93dc..000000000000
--- a/Documentation/devicetree/bindings/input/da9062-onkey.txt
+++ /dev/null
@@ -1,47 +0,0 @@
-* Dialog DA9061/62/63 OnKey Module
-
-This module is part of the DA9061/DA9062/DA9063. For more details about entire
-DA9062 and DA9061 chips see Documentation/devicetree/bindings/mfd/da9062.txt
-For DA9063 see Documentation/devicetree/bindings/mfd/dlg,da9063.yaml
-
-This module provides the KEY_POWER event.
-
-Required properties:
-
-- compatible: should be one of the following valid compatible string lines:
-	"dlg,da9061-onkey", "dlg,da9062-onkey"
-	"dlg,da9062-onkey"
-	"dlg,da9063-onkey"
-
-Optional properties:
-
-- dlg,disable-key-power : Disable power-down using a long key-press. If this
-    entry exists the OnKey driver will remove support for the KEY_POWER key
-    press when triggered using a long press of the OnKey.
-
-Example: DA9063
-
-	pmic0: da9063@58 {
-		onkey {
-			compatible = "dlg,da9063-onkey";
-			dlg,disable-key-power;
-		};
-	};
-
-Example: DA9062
-
-	pmic0: da9062@58 {
-		onkey {
-			compatible = "dlg,da9062-onkey";
-			dlg,disable-key-power;
-		};
-	};
-
-Example: DA9061 using a fall-back compatible for the DA9062 onkey driver
-
-	pmic0: da9061@58 {
-		onkey {
-			compatible = "dlg,da9061-onkey", "dlg,da9062-onkey";
-			dlg,disable-key-power;
-		};
-	};
diff --git a/Documentation/devicetree/bindings/input/dlg,da9062-onkey.yaml b/Documentation/devicetree/bindings/input/dlg,da9062-onkey.yaml
new file mode 100644
index 000000000000..757a522c102c
--- /dev/null
+++ b/Documentation/devicetree/bindings/input/dlg,da9062-onkey.yaml
@@ -0,0 +1,39 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/input/dlg,da9062-onkey.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Dialog DA9061/62/63 OnKey Module
+
+maintainers:
+  - Biju Das <biju.das.jz@bp.renesas.com>
+
+description: |
+  This module is part of the DA9061/DA9062/DA9063. For more details about entire
+  DA9062 and DA9061 chips see Documentation/devicetree/bindings/mfd/da9062.txt
+  For DA9063 see Documentation/devicetree/bindings/mfd/dlg,da9063.yaml
+
+  This module provides the KEY_POWER event.
+
+properties:
+  compatible:
+    oneOf:
+      - enum:
+          - dlg,da9062-onkey
+          - dlg,da9063-onkey
+      - items:
+          - const: dlg,da9061-onkey
+          - const: dlg,da9062-onkey
+
+  dlg,disable-key-power:
+    type: boolean
+    description:
+      Disable power-down using a long key-press. If this entry exists
+      the OnKey driver will remove support for the KEY_POWER key press
+      when triggered using a long press of the OnKey.
+
+required:
+  - compatible
+
+additionalProperties: false
diff --git a/Documentation/devicetree/bindings/mfd/da9062.txt b/Documentation/devicetree/bindings/mfd/da9062.txt
index 056a6cb761e2..a788a31587fa 100644
--- a/Documentation/devicetree/bindings/mfd/da9062.txt
+++ b/Documentation/devicetree/bindings/mfd/da9062.txt
@@ -83,7 +83,7 @@ Sub-nodes:
   with the DA9062. There are currently no entries in this binding, however
   compatible = "dlg,da9062-rtc" should be added if a node is created.
 
-- onkey : See ../input/da9062-onkey.txt
+- onkey : See ../input/dlg,da9062-onkey.yaml
 
 - watchdog: See ../watchdog/dlg,da9062-watchdog.yaml
 
diff --git a/Documentation/devicetree/bindings/mfd/dlg,da9063.yaml b/Documentation/devicetree/bindings/mfd/dlg,da9063.yaml
index 871b84caeebe..c647341fe177 100644
--- a/Documentation/devicetree/bindings/mfd/dlg,da9063.yaml
+++ b/Documentation/devicetree/bindings/mfd/dlg,da9063.yaml
@@ -39,20 +39,7 @@ properties:
         const: dlg,da9063-rtc
 
   onkey:
-    type: object
-    $ref: /schemas/input/input.yaml#
-    unevaluatedProperties: false
-    properties:
-      compatible:
-        const: dlg,da9063-onkey
-
-      dlg,disable-key-power:
-        type: boolean
-        description: |
-          Disable power-down using a long key-press.
-          If this entry does not exist then by default the key-press triggered
-          power down is enabled and the OnKey will support both KEY_POWER and
-          KEY_SLEEP.
+    $ref: /schemas/input/dlg,da9062-onkey.yaml
 
   regulators:
     type: object
diff --git a/MAINTAINERS b/MAINTAINERS
index b1d298bd1cb5..7bdcc8ee7d11 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -6046,8 +6046,8 @@ DIALOG SEMICONDUCTOR DRIVERS
 M:	Support Opensource <support.opensource@diasemi.com>
 S:	Supported
 W:	http://www.dialog-semiconductor.com/products
-F:	Documentation/devicetree/bindings/input/da90??-onkey.txt
 F:	Documentation/devicetree/bindings/input/dlg,da72??.txt
+F:	Documentation/devicetree/bindings/input/dlg,da9062-onkey.yaml
 F:	Documentation/devicetree/bindings/mfd/da90*.txt
 F:	Documentation/devicetree/bindings/mfd/da90*.yaml
 F:	Documentation/devicetree/bindings/regulator/dlg,da9*.yaml
-- 
2.43.0


