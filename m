Return-Path: <prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 467F3C64E93
	for <webhook@archiver.kernel.org>; Mon,  4 Apr 2022 18:46:48 +0000 (UTC)
Received: from relmlie5.idc.renesas.com (relmlie5.idc.renesas.com
 [210.160.252.171])
 by mx.groups.io with SMTP id smtpd.web09.3568.1648842202850727941
 for <cip-dev@lists.cip-project.org>;
 Fri, 01 Apr 2022 12:43:35 -0700
Authentication-Results: mx.groups.io;
 dkim=missing;
 spf=pass (domain: bp.renesas.com, ip: 210.160.252.171,
 mailfrom: prabhakar.mahadev-lad.rj@bp.renesas.com)
X-IronPort-AV: E=Sophos;i="5.90,228,1643641200";
   d="scan'208";a="115453883"
Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie5.idc.renesas.com with ESMTP; 02 Apr 2022 04:43:35 +0900
Received: from localhost.localdomain (unknown [10.226.36.204])
	by relmlir5.idc.renesas.com (Postfix) with ESMTP id CFD2040061B8;
	Sat,  2 Apr 2022 04:43:33 +0900 (JST)
From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
Cc: Biju Das <biju.das.jz@bp.renesas.com>
Subject: [RESEND PATCH 5.10.y-cip 34/40] dt-bindings: mmc: renesas,sdhi: Fix
 dtbs-check warning
Date: Fri,  1 Apr 2022 20:42:28 +0100
Message-Id: <20220401194234.14057-35-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220401194234.14057-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20220401194234.14057-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 04 Apr 2022 18:46:48 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/7945

From: Biju Das <biju.das.jz@bp.renesas.com>

commit 4aba5dc71eae041aa1a9240de10ad2e30e9f32dd upstream.

Fix dtbs-check warning pinctrl-names:0:'default' was expected
for r8a77470-iwg23s-sbc.dts file.

Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
Reviewed-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Reviewed-by: Rob Herring <robh@kernel.org>
Link: https://lore.kernel.org/r/20210817090313.31858-2-biju.das.jz@bp.renesas.com
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
 .../devicetree/bindings/mmc/renesas,sdhi.yaml | 60 ++++++++++++-------
 1 file changed, 37 insertions(+), 23 deletions(-)

diff --git a/Documentation/devicetree/bindings/mmc/renesas,sdhi.yaml b/Documentation/devicetree/bindings/mmc/renesas,sdhi.yaml
index 21afaf9e7676..16050b29bc89 100644
--- a/Documentation/devicetree/bindings/mmc/renesas,sdhi.yaml
+++ b/Documentation/devicetree/bindings/mmc/renesas,sdhi.yaml
@@ -9,9 +9,6 @@ title: Renesas SDHI SD/MMC controller
 maintainers:
   - Wolfram Sang <wsa+renesas@sang-engineering.com>
 
-allOf:
-  - $ref: "mmc-controller.yaml"
-
 properties:
   compatible:
     oneOf:
@@ -103,14 +100,46 @@ properties:
   pinctrl-1:
     maxItems: 1
 
-  pinctrl-names:
-    minItems: 1
-    items:
-      - const: default
-      - const: state_uhs
+  pinctrl-names: true
 
   max-frequency: true
 
+allOf:
+  - $ref: "mmc-controller.yaml"
+
+  - if:
+      properties:
+        compatible:
+          contains:
+            const: renesas,sdhi-mmc-r8a77470
+    then:
+      properties:
+        pinctrl-names:
+          items:
+            - const: state_uhs
+    else:
+      properties:
+        pinctrl-names:
+          minItems: 1
+          items:
+            - const: default
+            - const: state_uhs
+
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - renesas,sdhi-r7s72100
+              - renesas,sdhi-r7s9210
+    then:
+      required:
+        - clock-names
+      description:
+        The internal card detection logic that exists in these controllers is
+        sectioned off to be run by a separate second clock source to allow
+        the main core clock to be turned off to save power.
+
 required:
   - compatible
   - reg
@@ -118,21 +147,6 @@ required:
   - clocks
   - power-domains
 
-if:
-  properties:
-    compatible:
-      contains:
-        enum:
-          - renesas,sdhi-r7s72100
-          - renesas,sdhi-r7s9210
-then:
-  required:
-    - clock-names
-  description:
-    The internal card detection logic that exists in these controllers is
-    sectioned off to be run by a separate second clock source to allow
-    the main core clock to be turned off to save power.
-
 unevaluatedProperties: false
 
 examples:
-- 
2.17.1


