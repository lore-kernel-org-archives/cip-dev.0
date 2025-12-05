Return-Path: <prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0E60D32D70
	for <webhook@archiver.kernel.org>; Fri,  5 Dec 2025 14:33:31 +0000 (UTC)
Received: from relmlie5.idc.renesas.com (relmlie5.idc.renesas.com [210.160.252.171])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.7063.1764945182570660387
 for <cip-dev@lists.cip-project.org>;
 Fri, 05 Dec 2025 06:33:31 -0800
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: bp.renesas.com, ip: 210.160.252.171, mailfrom: prabhakar.mahadev-lad.rj@bp.renesas.com)
X-CSE-ConnectionGUID: LgJyIi0UTxaPyqszMgTwlQ==
X-CSE-MsgGUID: S7jom68dSt2JawZVbm6W5w==
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie5.idc.renesas.com with ESMTP; 05 Dec 2025 23:33:30 +0900
Received: from Ubuntu-22.. (unknown [10.24.1.60])
	by relmlir6.idc.renesas.com (Postfix) with ESMTP id 880484179B99;
	Fri,  5 Dec 2025 23:33:29 +0900 (JST)
From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
Cc: Biju Das <biju.das.jz@bp.renesas.com>
Subject: [PATCH 6.12.y-cip 17/38] dt-bindings: clock: renesas,cpg-mssr: Document RZ/T2H support
Date: Fri,  5 Dec 2025 14:32:37 +0000
Message-ID: <20251205143258.13748-18-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251205143258.13748-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20251205143258.13748-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 05 Dec 2025 14:33:31 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/20931

From: Thierry Bultel <thierry.bultel.yh@bp.renesas.com>

commit 4e591b890afa0cbc3479f3b88fa7dc1d28972761 upstream.

Document RZ/T2H (a.k.a. r9a09g077) cpg-mssr (Clock Pulse Generator)
binding.

Reviewed-by: "Rob Herring (Arm)" <robh@kernel.org>
Signed-off-by: Thierry Bultel <thierry.bultel.yh@bp.renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Link: https://lore.kernel.org/20250515141828.43444-3-thierry.bultel.yh@bp.renesas.com
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
 .../bindings/clock/renesas,cpg-mssr.yaml      | 46 ++++++++++++++-----
 .../clock/renesas,r9a09g077-cpg-mssr.h        | 27 +++++++++++
 2 files changed, 62 insertions(+), 11 deletions(-)
 create mode 100644 include/dt-bindings/clock/renesas,r9a09g077-cpg-mssr.h

diff --git a/Documentation/devicetree/bindings/clock/renesas,cpg-mssr.yaml b/Documentation/devicetree/bindings/clock/renesas,cpg-mssr.yaml
index 77ce3615c65ac..708ab6bd7d448 100644
--- a/Documentation/devicetree/bindings/clock/renesas,cpg-mssr.yaml
+++ b/Documentation/devicetree/bindings/clock/renesas,cpg-mssr.yaml
@@ -52,9 +52,15 @@ properties:
       - renesas,r8a779f0-cpg-mssr # R-Car S4-8
       - renesas,r8a779g0-cpg-mssr # R-Car V4H
       - renesas,r8a779h0-cpg-mssr # R-Car V4M
+      - renesas,r9a09g077-cpg-mssr # RZ/T2H
 
   reg:
-    maxItems: 1
+    minItems: 1
+    items:
+      - description: base address of register block 0
+      - description: base address of register block 1
+    description: base addresses of clock controller. Some controllers
+      (like r9a09g077) use two blocks instead of a single one.
 
   clocks:
     minItems: 1
@@ -92,16 +98,6 @@ properties:
       the datasheet.
     const: 1
 
-if:
-  not:
-    properties:
-      compatible:
-        items:
-          enum:
-            - renesas,r7s9210-cpg-mssr
-then:
-  required:
-    - '#reset-cells'
 
 required:
   - compatible
@@ -111,6 +107,34 @@ required:
   - '#clock-cells'
   - '#power-domain-cells'
 
+allOf:
+  - if:
+      properties:
+        compatible:
+          contains:
+            const: renesas,r9a09g077-cpg-mssr
+    then:
+      properties:
+        reg:
+          minItems: 2
+        clock-names:
+          items:
+            - const: extal
+    else:
+      properties:
+        reg:
+          maxItems: 1
+  - if:
+      not:
+        properties:
+          compatible:
+            items:
+              enum:
+                - renesas,r7s9210-cpg-mssr
+    then:
+      required:
+        - '#reset-cells'
+
 additionalProperties: false
 
 examples:
diff --git a/include/dt-bindings/clock/renesas,r9a09g077-cpg-mssr.h b/include/dt-bindings/clock/renesas,r9a09g077-cpg-mssr.h
new file mode 100644
index 0000000000000..1b22fe88dec7a
--- /dev/null
+++ b/include/dt-bindings/clock/renesas,r9a09g077-cpg-mssr.h
@@ -0,0 +1,27 @@
+/* SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+ *
+ * Copyright (C) 2025 Renesas Electronics Corp.
+ */
+
+#ifndef __DT_BINDINGS_CLOCK_RENESAS_R9A09G077_CPG_H__
+#define __DT_BINDINGS_CLOCK_RENESAS_R9A09G077_CPG_H__
+
+#include <dt-bindings/clock/renesas-cpg-mssr.h>
+
+/* R9A09G077 CPG Core Clocks */
+#define R9A09G077_CLK_CA55C0		0
+#define R9A09G077_CLK_CA55C1		1
+#define R9A09G077_CLK_CA55C2		2
+#define R9A09G077_CLK_CA55C3		3
+#define R9A09G077_CLK_CA55S		4
+#define R9A09G077_CLK_CR52_CPU0		5
+#define R9A09G077_CLK_CR52_CPU1		6
+#define R9A09G077_CLK_CKIO		7
+#define R9A09G077_CLK_PCLKAH		8
+#define R9A09G077_CLK_PCLKAM		9
+#define R9A09G077_CLK_PCLKAL		10
+#define R9A09G077_CLK_PCLKGPTL		11
+#define R9A09G077_CLK_PCLKH		12
+#define R9A09G077_CLK_PCLKM		13
+
+#endif /* __DT_BINDINGS_CLOCK_RENESAS_R9A09G077_CPG_H__ */
-- 
2.43.0


