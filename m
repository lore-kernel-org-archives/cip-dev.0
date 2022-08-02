Return-Path: <biju.das.jz@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDEFEC3F6B0
	for <webhook@archiver.kernel.org>; Tue,  2 Aug 2022 11:09:21 +0000 (UTC)
Received: from relmlie5.idc.renesas.com (relmlie5.idc.renesas.com
 [210.160.252.171])
 by mx.groups.io with SMTP id smtpd.web10.4772.1659438549641555982
 for <cip-dev@lists.cip-project.org>;
 Tue, 02 Aug 2022 04:09:13 -0700
Authentication-Results: mx.groups.io;
 dkim=missing;
 spf=pass (domain: bp.renesas.com, ip: 210.160.252.171,
 mailfrom: biju.das.jz@bp.renesas.com)
X-IronPort-AV: E=Sophos;i="5.93,210,1654527600";
   d="scan'208";a="128236753"
Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie5.idc.renesas.com with ESMTP; 02 Aug 2022 20:09:13 +0900
Received: from localhost.localdomain (unknown [10.226.92.246])
	by relmlir5.idc.renesas.com (Postfix) with ESMTP id B2ADD4004934;
	Tue,  2 Aug 2022 20:09:11 +0900 (JST)
From: Biju Das <biju.das.jz@bp.renesas.com>
To: Pavel Machek <pavel@denx.de>
Cc: nobuhiro1.iwamatsu@toshiba.co.jp,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	Biju Das <biju.das.jz@bp.renesas.com>,
	cip-dev@lists.cip-project.org
Subject: [PATCH 5.10.y-cip 09/24] dt-bindings: clock: renesas: Document RZ/V2L
 SoC
Date: Tue,  2 Aug 2022 12:08:35 +0100
Message-Id: <20220802110850.1496057-10-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220802110850.1496057-1-biju.das.jz@bp.renesas.com>
References: <20220802110850.1496057-1-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 02 Aug 2022 11:09:21 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/9006

commit 678eb67513a963e5ce00a4ed6a07a5722bd1267e upstream.

Document the device tree binding for the Renesas RZ/V2L SoC.

Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Acked-by: Rob Herring <robh@kernel.org>
Link: https://lore.kernel.org/r/20220110134659.30424-5-prabhakar.mahadev-lad.rj@bp.renesas.com
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
 .../bindings/clock/renesas,rzg2l-cpg.yaml          | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/Documentation/devicetree/bindings/clock/renesas,rzg2l-cpg.yaml b/Documentation/devicetree/bindings/clock/renesas,rzg2l-cpg.yaml
index 30b2e3d0d25d..bd3af8fc616b 100644
--- a/Documentation/devicetree/bindings/clock/renesas,rzg2l-cpg.yaml
+++ b/Documentation/devicetree/bindings/clock/renesas,rzg2l-cpg.yaml
@@ -4,13 +4,13 @@
 $id: "http://devicetree.org/schemas/clock/renesas,rzg2l-cpg.yaml#"
 $schema: "http://devicetree.org/meta-schemas/core.yaml#"
 
-title: Renesas RZ/G2L Clock Pulse Generator / Module Standby Mode
+title: Renesas RZ/{G2L,V2L} Clock Pulse Generator / Module Standby Mode
 
 maintainers:
   - Geert Uytterhoeven <geert+renesas@glider.be>
 
 description: |
-  On Renesas RZ/G2L SoC, the CPG (Clock Pulse Generator) and Module
+  On Renesas RZ/{G2L,V2L} SoC, the CPG (Clock Pulse Generator) and Module
   Standby Mode share the same register block.
 
   They provide the following functionalities:
@@ -22,7 +22,9 @@ description: |
 
 properties:
   compatible:
-    const: renesas,r9a07g044-cpg  # RZ/G2{L,LC}
+    enum:
+      - renesas,r9a07g044-cpg  # RZ/G2{L,LC}
+      - renesas,r9a07g054-cpg  # RZ/V2L
 
   reg:
     maxItems: 1
@@ -40,9 +42,9 @@ properties:
     description: |
       - For CPG core clocks, the two clock specifier cells must be "CPG_CORE"
         and a core clock reference, as defined in
-        <dt-bindings/clock/r9a07g044-cpg.h>
+        <dt-bindings/clock/r9a07g*-cpg.h>
       - For module clocks, the two clock specifier cells must be "CPG_MOD" and
-        a module number, as defined in the <dt-bindings/clock/r9a07g044-cpg.h>.
+        a module number, as defined in the <dt-bindings/clock/r9a07g0*-cpg.h>.
     const: 2
 
   '#power-domain-cells':
@@ -56,7 +58,7 @@ properties:
   '#reset-cells':
     description:
       The single reset specifier cell must be the module number, as defined in
-      the <dt-bindings/clock/r9a07g044-cpg.h>.
+      the <dt-bindings/clock/r9a07g0*-cpg.h>.
     const: 1
 
 required:
-- 
2.25.1


