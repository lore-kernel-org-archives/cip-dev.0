Return-Path: <biju.das.jz@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B7FFCEB2E2
	for <webhook@archiver.kernel.org>; Wed,  2 Oct 2024 17:07:53 +0000 (UTC)
Received: from relmlie6.idc.renesas.com (relmlie6.idc.renesas.com [210.160.252.172])
 by mx.groups.io with SMTP id smtpd.web11.1143.1727888860684620014
 for <cip-dev@lists.cip-project.org>;
 Wed, 02 Oct 2024 10:07:45 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: bp.renesas.com, ip: 210.160.252.172, mailfrom: biju.das.jz@bp.renesas.com)
X-IronPort-AV: E=Sophos;i="6.11,172,1725289200"; 
   d="scan'208";a="224579771"
Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie6.idc.renesas.com with ESMTP; 03 Oct 2024 02:07:44 +0900
Received: from localhost.localdomain (unknown [10.226.92.106])
	by relmlir5.idc.renesas.com (Postfix) with ESMTP id 0C7A040071FC;
	Thu,  3 Oct 2024 02:07:33 +0900 (JST)
From: Biju Das <biju.das.jz@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
Cc: Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH 5.10.y-cip 09/15] dt-bindings: display: renesas,rzg2l-du: Document RZ/G2UL DU bindings
Date: Wed,  2 Oct 2024 18:06:58 +0100
Message-ID: <20241002170712.655449-10-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241002170712.655449-1-biju.das.jz@bp.renesas.com>
References: <20241002170712.655449-1-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 02 Oct 2024 17:07:53 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/16975

commit 2ef7cb1cea7d56348c8f3d43bf1b891ddd468bb2 upstream.

Document DU found in RZ/G2UL SoC. The DU block is identical to RZ/G2L
SoC, but has only DPI interface.

While at it, add missing required property port@1 for RZ/G2L and RZ/V2L
SoCs. Currently there is no user for the DPI interface and hence there
won't be any ABI breakage for adding port@1 as required property for
RZ/G2L and RZ/V2L SoCs.

Acked-by: Conor Dooley <conor.dooley@microchip.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
Reviewed-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
Link: https://patchwork.freedesktop.org/patch/msgid/20240822162320.5084-2-biju.das.jz@bp.renesas.com
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
 .../bindings/display/renesas,rzg2l-du.yaml    | 32 +++++++++++++++++--
 1 file changed, 29 insertions(+), 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/display/renesas,rzg2l-du.yaml b/Documentation/devicetree/bindings/display/renesas,rzg2l-du.yaml
index 08e5b9478051..95e3d5e74b87 100644
--- a/Documentation/devicetree/bindings/display/renesas,rzg2l-du.yaml
+++ b/Documentation/devicetree/bindings/display/renesas,rzg2l-du.yaml
@@ -18,6 +18,7 @@ properties:
   compatible:
     oneOf:
       - enum:
+          - renesas,r9a07g043u-du # RZ/G2UL
           - renesas,r9a07g044-du # RZ/G2{L,LC}
       - items:
           - enum:
@@ -60,9 +61,6 @@ properties:
         $ref: /schemas/graph.yaml#/properties/port
         unevaluatedProperties: false
 
-    required:
-      - port@0
-
     unevaluatedProperties: false
 
   renesas,vsps:
@@ -88,6 +86,34 @@ required:
 
 additionalProperties: false
 
+allOf:
+  - if:
+      properties:
+        compatible:
+          contains:
+            const: renesas,r9a07g043u-du
+    then:
+      properties:
+        ports:
+          properties:
+            port@0:
+              description: DPI
+
+          required:
+            - port@0
+    else:
+      properties:
+        ports:
+          properties:
+            port@0:
+              description: DSI
+            port@1:
+              description: DPI
+
+          required:
+            - port@0
+            - port@1
+
 examples:
   # RZ/G2L DU
   - |
-- 
2.43.0


