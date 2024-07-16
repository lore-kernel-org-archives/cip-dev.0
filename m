Return-Path: <biju.das.jz@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFEA4C3DA61
	for <webhook@archiver.kernel.org>; Tue, 16 Jul 2024 08:23:58 +0000 (UTC)
Received: from relmlie6.idc.renesas.com (relmlie6.idc.renesas.com [210.160.252.172])
 by mx.groups.io with SMTP id smtpd.web10.5938.1721118211284299661
 for <cip-dev@lists.cip-project.org>;
 Tue, 16 Jul 2024 01:23:51 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: bp.renesas.com, ip: 210.160.252.172, mailfrom: biju.das.jz@bp.renesas.com)
X-IronPort-AV: E=Sophos;i="6.09,211,1716217200"; 
   d="scan'208";a="215426063"
Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie6.idc.renesas.com with ESMTP; 16 Jul 2024 17:23:50 +0900
Received: from localhost.localdomain (unknown [10.226.92.125])
	by relmlir5.idc.renesas.com (Postfix) with ESMTP id 4D0DD4016D5E;
	Tue, 16 Jul 2024 17:23:49 +0900 (JST)
From: Biju Das <biju.das.jz@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
Cc: Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH 5.10.y-cip 23/31] dt-bindings: watchdog: da9062-wdt: convert txt to yaml
Date: Tue, 16 Jul 2024 09:22:34 +0100
Message-ID: <20240716082255.56551-24-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240716082255.56551-1-biju.das.jz@bp.renesas.com>
References: <20240716082255.56551-1-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 16 Jul 2024 08:23:58 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/16549

From: Nik Bune <n2h9z4@gmail.com>

commit bd888a4377ae10303ba8c967dfccf2a1e4bbdcd1 upstream.

Convert txt file to yaml.
Add a mainterner block. Took a value from dlg,da9063 PMIC.

Signed-off-by: Nik Bune <n2h9z4@gmail.com>
Reviewed-by: Guenter Roeck <linux@roeck-us.net>
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Link: https://lore.kernel.org/r/20231014170434.159310-1-n2h9z4@gmail.com
Signed-off-by: Rob Herring <robh@kernel.org>
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
 .../bindings/watchdog/da9062-wdt.txt          | 28 -----------
 .../watchdog/dlg,da9062-watchdog.yaml         | 50 +++++++++++++++++++
 2 files changed, 50 insertions(+), 28 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/watchdog/da9062-wdt.txt
 create mode 100644 Documentation/devicetree/bindings/watchdog/dlg,da9062-watchdog.yaml

diff --git a/Documentation/devicetree/bindings/watchdog/da9062-wdt.txt b/Documentation/devicetree/bindings/watchdog/da9062-wdt.txt
deleted file mode 100644
index 950e4fba8dbc..000000000000
--- a/Documentation/devicetree/bindings/watchdog/da9062-wdt.txt
+++ /dev/null
@@ -1,28 +0,0 @@
-* Dialog Semiconductor DA9062/61 Watchdog Timer
-
-Required properties:
-
-- compatible: should be one of the following valid compatible string lines:
-	"dlg,da9061-watchdog", "dlg,da9062-watchdog"
-	"dlg,da9062-watchdog"
-
-Optional properties:
-- dlg,use-sw-pm: Add this property to disable the watchdog during suspend.
-	Only use this option if you can't use the watchdog automatic suspend
-	function during a suspend (see register CONTROL_B).
-
-Example: DA9062
-
-	pmic0: da9062@58 {
-		watchdog {
-			compatible = "dlg,da9062-watchdog";
-		};
-	};
-
-Example: DA9061 using a fall-back compatible for the DA9062 watchdog driver
-
-	pmic0: da9061@58 {
-		watchdog {
-			compatible = "dlg,da9061-watchdog", "dlg,da9062-watchdog";
-		};
-	};
diff --git a/Documentation/devicetree/bindings/watchdog/dlg,da9062-watchdog.yaml b/Documentation/devicetree/bindings/watchdog/dlg,da9062-watchdog.yaml
new file mode 100644
index 000000000000..f058628bb632
--- /dev/null
+++ b/Documentation/devicetree/bindings/watchdog/dlg,da9062-watchdog.yaml
@@ -0,0 +1,50 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/watchdog/dlg,da9062-watchdog.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Dialog Semiconductor DA9062/61 Watchdog Timer
+
+maintainers:
+  - Steve Twiss <stwiss.opensource@diasemi.com>
+
+allOf:
+  - $ref: watchdog.yaml#
+
+properties:
+  compatible:
+    enum: 
+      - dlg,da9061-watchdog
+      - dlg,da9062-watchdog
+
+  dlg,use-sw-pm:
+    type: boolean
+    description:
+      Add this property to disable the watchdog during suspend.
+      Only use this option if you can't use the watchdog automatic suspend
+      function during a suspend (see register CONTROL_B).
+  
+  dlg,wdt-sd:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    enum: [0, 1]
+    description:
+      Set what happens on watchdog timeout. If this bit is set the
+      watchdog timeout triggers SHUTDOWN, if cleared the watchdog triggers
+      POWERDOWN. Can be 0 or 1. Only use this option if you want to change the
+      default chip's OTP setting for WATCHDOG_SD bit. If this property is NOT
+      set the WATCHDOG_SD bit and on timeout watchdog behavior will match the
+      chip's OTP settings.
+
+required:
+  - compatible
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    watchdog {
+      compatible = "dlg,da9062-watchdog";
+      dlg,use-sw-pm;
+      dlg,wdt-sd = <1>;
+    };
-- 
2.43.0


