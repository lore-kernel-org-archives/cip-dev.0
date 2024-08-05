Return-Path: <biju.das.jz@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC651C52D71
	for <webhook@archiver.kernel.org>; Mon,  5 Aug 2024 16:44:38 +0000 (UTC)
Received: from relmlie6.idc.renesas.com (relmlie6.idc.renesas.com [210.160.252.172])
 by mx.groups.io with SMTP id smtpd.web10.12824.1722876257681924282
 for <cip-dev@lists.cip-project.org>;
 Mon, 05 Aug 2024 09:44:34 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: bp.renesas.com, ip: 210.160.252.172, mailfrom: biju.das.jz@bp.renesas.com)
X-IronPort-AV: E=Sophos;i="6.09,265,1716217200"; 
   d="scan'208";a="218711350"
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie6.idc.renesas.com with ESMTP; 06 Aug 2024 01:44:33 +0900
Received: from localhost.localdomain (unknown [10.226.92.197])
	by relmlir6.idc.renesas.com (Postfix) with ESMTP id 2818F4021738;
	Tue,  6 Aug 2024 01:44:31 +0900 (JST)
From: Biju Das <biju.das.jz@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
Cc: Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH 6.1.y-cip 23/30] media: dt-bindings: renesas,rzg2l-cru: Document Renesas RZ/G2UL CRU block
Date: Mon,  5 Aug 2024 17:43:16 +0100
Message-ID: <20240805164342.211857-24-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240805164342.211857-1-biju.das.jz@bp.renesas.com>
References: <20240805164342.211857-1-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 05 Aug 2024 16:44:38 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/16745

commit 83138f8fb798627531be3b5627af4a6008a7bbd6 upstream.

Document the CRU IP found in Renesas RZ/G2UL SoC.

The CRU block on the RZ/G2UL SoC is identical to one found on the
RZ/G2L SoC, but it does not support parallel input.

Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
Acked-by: Conor Dooley <conor.dooley@microchip.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Link: https://lore.kernel.org/r/20240605154115.263447-3-biju.das.jz@bp.renesas.com
Signed-off-by: Rob Herring (Arm) <robh@kernel.org>
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
 .../bindings/media/renesas,rzg2l-cru.yaml     | 35 ++++++++++++++++---
 1 file changed, 31 insertions(+), 4 deletions(-)

diff --git a/Documentation/devicetree/bindings/media/renesas,rzg2l-cru.yaml b/Documentation/devicetree/bindings/media/renesas,rzg2l-cru.yaml
index 7dde7967c886..0aebdcaffaba 100644
--- a/Documentation/devicetree/bindings/media/renesas,rzg2l-cru.yaml
+++ b/Documentation/devicetree/bindings/media/renesas,rzg2l-cru.yaml
@@ -19,6 +19,7 @@ properties:
   compatible:
     items:
       - enum:
+          - renesas,r9a07g043-cru       # RZ/G2UL
           - renesas,r9a07g044-cru       # RZ/G2{L,LC}
           - renesas,r9a07g054-cru       # RZ/V2L
       - const: renesas,rzg2l-cru
@@ -87,10 +88,6 @@ properties:
           Input port node, describing the Image Processing module connected to the
           CSI-2 receiver.
 
-    required:
-      - port@0
-      - port@1
-
 required:
   - compatible
   - reg
@@ -102,6 +99,36 @@ required:
   - reset-names
   - power-domains
 
+allOf:
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - renesas,r9a07g044-cru
+              - renesas,r9a07g054-cru
+    then:
+      properties:
+        ports:
+          required:
+            - port@0
+            - port@1
+
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - renesas,r9a07g043-cru
+    then:
+      properties:
+        ports:
+          properties:
+            port@0: false
+
+          required:
+            - port@1
+
 additionalProperties: false
 
 examples:
-- 
2.43.0


