Return-Path: <prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4E6CD32D6E
	for <webhook@archiver.kernel.org>; Fri,  5 Dec 2025 14:33:21 +0000 (UTC)
Received: from relmlie5.idc.renesas.com (relmlie5.idc.renesas.com [210.160.252.171])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.7063.1764945182570660387
 for <cip-dev@lists.cip-project.org>;
 Fri, 05 Dec 2025 06:33:20 -0800
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: bp.renesas.com, ip: 210.160.252.171, mailfrom: prabhakar.mahadev-lad.rj@bp.renesas.com)
X-CSE-ConnectionGUID: TQPF8QJbS1S5Pogi4+uaug==
X-CSE-MsgGUID: AoH3fRa4QfSzYGM0VGNd3w==
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie5.idc.renesas.com with ESMTP; 05 Dec 2025 23:33:20 +0900
Received: from Ubuntu-22.. (unknown [10.24.1.60])
	by relmlir6.idc.renesas.com (Postfix) with ESMTP id 173B64179CE0;
	Fri,  5 Dec 2025 23:33:18 +0900 (JST)
From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
Cc: Biju Das <biju.das.jz@bp.renesas.com>
Subject: [PATCH 6.12.y-cip 11/38] dt-bindings: soc: renesas: Sort SoC entries based on part number
Date: Fri,  5 Dec 2025 14:32:31 +0000
Message-ID: <20251205143258.13748-12-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251205143258.13748-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20251205143258.13748-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 05 Dec 2025 14:33:21 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/20925

`renesas.yaml` maintains its SoC definitions in ascending part number
order. This ordering was unintentionally broken when backporting support
for the RZ/G3E SoC in commit c06b797739f2 ("dt-bindings: soc: renesas:
Document Renesas RZ/G3E SoC variants"), which placed the new entry out
of sequence.

Restore the correct ordering by re-sorting the SoC block so that it
follows the established part-number progression. This keeps the binding
consistent with upstream structure and avoids future placement errors.

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
 .../bindings/soc/renesas/renesas.yaml         | 34 +++++++++----------
 1 file changed, 17 insertions(+), 17 deletions(-)

diff --git a/Documentation/devicetree/bindings/soc/renesas/renesas.yaml b/Documentation/devicetree/bindings/soc/renesas/renesas.yaml
index 467bf01bc12d7..d05e8b1585894 100644
--- a/Documentation/devicetree/bindings/soc/renesas/renesas.yaml
+++ b/Documentation/devicetree/bindings/soc/renesas/renesas.yaml
@@ -525,6 +525,23 @@ properties:
               - renesas,rzv2mevk2   # RZ/V2M Eval Board v2.0
           - const: renesas,r9a09g011
 
+      - description: RZ/G3E (R9A09G047)
+        items:
+          - enum:
+              - renesas,smarc2-evk # RZ SMARC Carrier-II EVK
+          - enum:
+              - renesas,rzg3e-smarcm # RZ/G3E SMARC Module (SoM)
+          - enum:
+              - renesas,r9a09g047e27 # Dual Cortex-A55 + Cortex-M33 (15mm BGA)
+              - renesas,r9a09g047e28 # Dual Cortex-A55 + Cortex-M33 (21mm BGA)
+              - renesas,r9a09g047e37 # Dual Cortex-A55 + Cortex-M33 + Ethos-U55 (15mm BGA)
+              - renesas,r9a09g047e38 # Dual Cortex-A55 + Cortex-M33 + Ethos-U55 (21mm BGA)
+              - renesas,r9a09g047e47 # Quad Cortex-A55 + Cortex-M33 (15mm BGA)
+              - renesas,r9a09g047e48 # Quad Cortex-A55 + Cortex-M33 (21mm BGA)
+              - renesas,r9a09g047e57 # Quad Cortex-A55 + Cortex-M33 + Ethos-U55 (15mm BGA)
+              - renesas,r9a09g047e58 # Quad Cortex-A55 + Cortex-M33 + Ethos-U55 (21mm BGA)
+          - const: renesas,r9a09g047
+
       - description: RZ/V2N (R9A09G056)
         items:
           - enum:
@@ -550,23 +567,6 @@ properties:
               - renesas,r9a09g057h44 # RZ/V2HP with Mali-G31 + Mali-C55 support
           - const: renesas,r9a09g057
 
-      - description: RZ/G3E (R9A09G047)
-        items:
-          - enum:
-              - renesas,smarc2-evk # RZ SMARC Carrier-II EVK
-          - enum:
-              - renesas,rzg3e-smarcm # RZ/G3E SMARC Module (SoM)
-          - enum:
-              - renesas,r9a09g047e27 # Dual Cortex-A55 + Cortex-M33 (15mm BGA)
-              - renesas,r9a09g047e28 # Dual Cortex-A55 + Cortex-M33 (21mm BGA)
-              - renesas,r9a09g047e37 # Dual Cortex-A55 + Cortex-M33 + Ethos-U55 (15mm BGA)
-              - renesas,r9a09g047e38 # Dual Cortex-A55 + Cortex-M33 + Ethos-U55 (21mm BGA)
-              - renesas,r9a09g047e47 # Quad Cortex-A55 + Cortex-M33 (15mm BGA)
-              - renesas,r9a09g047e48 # Quad Cortex-A55 + Cortex-M33 (21mm BGA)
-              - renesas,r9a09g047e57 # Quad Cortex-A55 + Cortex-M33 + Ethos-U55 (15mm BGA)
-              - renesas,r9a09g047e58 # Quad Cortex-A55 + Cortex-M33 + Ethos-U55 (21mm BGA)
-          - const: renesas,r9a09g047
-
 additionalProperties: true
 
 ...
-- 
2.43.0


