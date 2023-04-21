Return-Path: <biju.das.jz@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C834C77B7F
	for <webhook@archiver.kernel.org>; Fri, 21 Apr 2023 07:18:10 +0000 (UTC)
Received: from relmlie5.idc.renesas.com (relmlie5.idc.renesas.com [210.160.252.171])
 by mx.groups.io with SMTP id smtpd.web11.6169.1682061470715228262
 for <cip-dev@lists.cip-project.org>;
 Fri, 21 Apr 2023 00:18:03 -0700
Authentication-Results: mx.groups.io;
 dkim=missing; spf=pass (domain: bp.renesas.com, ip: 210.160.252.171, mailfrom: biju.das.jz@bp.renesas.com)
X-IronPort-AV: E=Sophos;i="5.99,214,1677510000"; 
   d="scan'208";a="156786937"
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie5.idc.renesas.com with ESMTP; 21 Apr 2023 16:18:02 +0900
Received: from localhost.localdomain (unknown [10.226.93.14])
	by relmlir6.idc.renesas.com (Postfix) with ESMTP id B4E7F41AA3E8;
	Fri, 21 Apr 2023 16:18:00 +0900 (JST)
From: Biju Das <biju.das.jz@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
Cc: Chris Paterson <chris.paterson2@renesas.com>,
	Biju Das <biju.das.jz@bp.renesas.com>,
	Fabrizio Castro <fabrizio.castro.jz@renesas.com>
Subject: [PATCH 5.10.y-cip 12/33] dt-bindings: clock: renesas,rzg2l: Document RZ/V2M SoC
Date: Fri, 21 Apr 2023 08:17:08 +0100
Message-Id: <20230421071729.130347-13-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230421071729.130347-1-biju.das.jz@bp.renesas.com>
References: <20230421071729.130347-1-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 21 Apr 2023 07:18:10 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/11285

From: Phil Edworthy <phil.edworthy@renesas.com>

commit 4a526957e6368597dea08175a67f0e15569f3958 upstream.

Document the device tree binding for the Renesas RZ/V2M (r9a09g011) SoC.

Signed-off-by: Phil Edworthy <phil.edworthy@renesas.com>
Reviewed-by: Biju Das <biju.das.jz@bp.renesas.com>
Reviewed-by: Krzysztof Kozlowski <krzk@kernel.org>
Link: https://lore.kernel.org/r/20220503115557.53370-4-phil.edworthy@renesas.com
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
 .../bindings/clock/renesas,rzg2l-cpg.yaml           | 13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

diff --git a/Documentation/devicetree/bindings/clock/renesas,rzg2l-cpg.yaml b/Documentation/devicetree/bindings/clock/renesas,rzg2l-cpg.yaml
index 311a93590597..8880b834f264 100644
--- a/Documentation/devicetree/bindings/clock/renesas,rzg2l-cpg.yaml
+++ b/Documentation/devicetree/bindings/clock/renesas,rzg2l-cpg.yaml
@@ -4,14 +4,15 @@
 $id: "http://devicetree.org/schemas/clock/renesas,rzg2l-cpg.yaml#"
 $schema: "http://devicetree.org/meta-schemas/core.yaml#"
 
-title: Renesas RZ/{G2L,V2L} Clock Pulse Generator / Module Standby Mode
+title: Renesas RZ/{G2L,V2L,V2M} Clock Pulse Generator / Module Standby Mode
 
 maintainers:
   - Geert Uytterhoeven <geert+renesas@glider.be>
 
 description: |
   On Renesas RZ/{G2L,V2L}-alike SoC's, the CPG (Clock Pulse Generator) and Module
-  Standby Mode share the same register block.
+  Standby Mode share the same register block. On RZ/V2M, the functionality is
+  similar, but does not have Clock Monitor Registers.
 
   They provide the following functionalities:
     - The CPG block generates various core clocks,
@@ -26,6 +27,7 @@ properties:
       - renesas,r9a07g043-cpg # RZ/G2UL{Type-1,Type-2}
       - renesas,r9a07g044-cpg # RZ/G2{L,LC}
       - renesas,r9a07g054-cpg # RZ/V2L
+      - renesas,r9a09g011-cpg # RZ/V2M
 
   reg:
     maxItems: 1
@@ -43,9 +45,10 @@ properties:
     description: |
       - For CPG core clocks, the two clock specifier cells must be "CPG_CORE"
         and a core clock reference, as defined in
-        <dt-bindings/clock/r9a07g*-cpg.h>
+        <dt-bindings/clock/r9a0*-cpg.h>
       - For module clocks, the two clock specifier cells must be "CPG_MOD" and
-        a module number, as defined in the <dt-bindings/clock/r9a07g0*-cpg.h>.
+        a module number, as defined in the <dt-bindings/clock/r9a07g0*-cpg.h> or
+        <dt-bindings/clock/r9a09g011-cpg.h>.
     const: 2
 
   '#power-domain-cells':
@@ -59,7 +62,7 @@ properties:
   '#reset-cells':
     description:
       The single reset specifier cell must be the module number, as defined in
-      the <dt-bindings/clock/r9a07g0*-cpg.h>.
+      the <dt-bindings/clock/r9a07g0*-cpg.h> or <dt-bindings/clock/r9a09g011-cpg.h>.
     const: 1
 
 required:
-- 
2.25.1


