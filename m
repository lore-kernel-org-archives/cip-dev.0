Return-Path: <prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98820E92FE8
	for <webhook@archiver.kernel.org>; Mon, 29 Dec 2025 22:39:25 +0000 (UTC)
Received: from relmlie5.idc.renesas.com (relmlie5.idc.renesas.com [210.160.252.171])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.53290.1767047963322466955
 for <cip-dev@lists.cip-project.org>;
 Mon, 29 Dec 2025 14:39:24 -0800
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: bp.renesas.com, ip: 210.160.252.171, mailfrom: prabhakar.mahadev-lad.rj@bp.renesas.com)
X-CSE-ConnectionGUID: asl/++0WS6K+AJ3NcBB1lA==
X-CSE-MsgGUID: 63earsywRe+7JYJeT50OwQ==
Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie5.idc.renesas.com with ESMTP; 30 Dec 2025 07:39:24 +0900
Received: from Ubuntu-22.. (unknown [10.24.0.160])
	by relmlir5.idc.renesas.com (Postfix) with ESMTP id 3EF71400A0FF;
	Tue, 30 Dec 2025 07:39:23 +0900 (JST)
From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro.iwamatsu.x90@mail.toshiba>,
	Pavel Machek <pavel@denx.de>
Cc: Biju Das <biju.das.jz@bp.renesas.com>
Subject: [PATCH 6.12.y-cip 06/17] dt-bindings: i2c: renesas,riic: Move ref for i2c-controller.yaml to the end
Date: Mon, 29 Dec 2025 22:39:00 +0000
Message-ID: <20251229223911.8663-7-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251229223911.8663-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20251229223911.8663-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 29 Dec 2025 22:39:25 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/21264

commit be221173ee918dff2adaf0e23b03aeea44902d5e upstream.

In preparation for adding more validation checks, move the `$ref` for
'i2c-controller.yaml' to the end of the file. Also, relocate the
conditional check for 'resets' into the 'allOf' block.

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Acked-by: Conor Dooley <conor.dooley@microchip.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Andi Shyti <andi.shyti@kernel.org>
Link: https://lore.kernel.org/r/20250625104526.101004-2-prabhakar.mahadev-lad.rj@bp.renesas.com
Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
 .../devicetree/bindings/i2c/renesas,riic.yaml | 30 +++++++++----------
 1 file changed, 15 insertions(+), 15 deletions(-)

diff --git a/Documentation/devicetree/bindings/i2c/renesas,riic.yaml b/Documentation/devicetree/bindings/i2c/renesas,riic.yaml
index 1b7fed2326423..4038c6d4acfc6 100644
--- a/Documentation/devicetree/bindings/i2c/renesas,riic.yaml
+++ b/Documentation/devicetree/bindings/i2c/renesas,riic.yaml
@@ -10,9 +10,6 @@ maintainers:
   - Chris Brandt <chris.brandt@renesas.com>
   - Wolfram Sang <wsa+renesas@sang-engineering.com>
 
-allOf:
-  - $ref: /schemas/i2c/i2c-controller.yaml#
-
 properties:
   compatible:
     oneOf:
@@ -83,18 +80,21 @@ required:
   - '#address-cells'
   - '#size-cells'
 
-if:
-  properties:
-    compatible:
-      contains:
-        enum:
-          - renesas,riic-r9a07g043
-          - renesas,riic-r9a07g044
-          - renesas,riic-r9a07g054
-          - renesas,riic-r9a09g057
-then:
-  required:
-    - resets
+allOf:
+  - $ref: /schemas/i2c/i2c-controller.yaml#
+
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - renesas,riic-r9a07g043
+              - renesas,riic-r9a07g044
+              - renesas,riic-r9a07g054
+              - renesas,riic-r9a09g057
+    then:
+      required:
+        - resets
 
 unevaluatedProperties: false
 
-- 
2.43.0


