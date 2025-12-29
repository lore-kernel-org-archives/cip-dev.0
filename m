Return-Path: <prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B952DE92FEE
	for <webhook@archiver.kernel.org>; Mon, 29 Dec 2025 22:39:35 +0000 (UTC)
Received: from relmlie6.idc.renesas.com (relmlie6.idc.renesas.com [210.160.252.172])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.53287.1767047956505708700
 for <cip-dev@lists.cip-project.org>;
 Mon, 29 Dec 2025 14:39:26 -0800
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: bp.renesas.com, ip: 210.160.252.172, mailfrom: prabhakar.mahadev-lad.rj@bp.renesas.com)
X-CSE-ConnectionGUID: EarXQajtRn+ePDe7rxim0A==
X-CSE-MsgGUID: 0pPxWIRpQ6mgR/3MVCZg8A==
Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie6.idc.renesas.com with ESMTP; 30 Dec 2025 07:39:26 +0900
Received: from Ubuntu-22.. (unknown [10.24.0.160])
	by relmlir5.idc.renesas.com (Postfix) with ESMTP id 05A104005037;
	Tue, 30 Dec 2025 07:39:24 +0900 (JST)
From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro.iwamatsu.x90@mail.toshiba>,
	Pavel Machek <pavel@denx.de>
Cc: Biju Das <biju.das.jz@bp.renesas.com>
Subject: [PATCH 6.12.y-cip 07/17] dt-bindings: i2c: renesas,riic: Document RZ/T2H and RZ/N2H support
Date: Mon, 29 Dec 2025 22:39:01 +0000
Message-ID: <20251229223911.8663-8-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251229223911.8663-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20251229223911.8663-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 29 Dec 2025 22:39:35 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/21265

commit 13aa792c10ada4f8870da5ba0fb51e478eb5a45e upstream.

Document support for the I2C Bus Interface (RIIC) found on the Renesas
RZ/T2H (R9A09G077) and RZ/N2H (R9A09G087) SoCs.

The RIIC IP on these parts is similar to that on RZ/V2H(P) but supports
only four interrupts (including a combined error/event), lacks FM+ mode,
and does not require reset. Introduce a new compatible string
`renesas,riic-r9a09g077` for RZ/T2H and use it as a fallback for RZ/N2H.

Unlike earlier SoCs that use eight distinct interrupts, the RZ/T2H uses
only four. Update the binding schema to reflect this interrupt layout
and skip the `resets` property check, as it is not required on these SoCs.

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Acked-by: Conor Dooley <conor.dooley@microchip.com>
Reviewed-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Andi Shyti <andi.shyti@kernel.org>
Link: https://lore.kernel.org/r/20250625104526.101004-3-prabhakar.mahadev-lad.rj@bp.renesas.com
Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
 .../devicetree/bindings/i2c/renesas,riic.yaml | 75 ++++++++++++++-----
 1 file changed, 56 insertions(+), 19 deletions(-)

diff --git a/Documentation/devicetree/bindings/i2c/renesas,riic.yaml b/Documentation/devicetree/bindings/i2c/renesas,riic.yaml
index 4038c6d4acfc6..207cb2eb25c87 100644
--- a/Documentation/devicetree/bindings/i2c/renesas,riic.yaml
+++ b/Documentation/devicetree/bindings/i2c/renesas,riic.yaml
@@ -28,32 +28,50 @@ properties:
               - renesas,riic-r9a09g047   # RZ/G3E
           - const: renesas,riic-r9a09g057   # RZ/V2H(P)
 
-      - const: renesas,riic-r9a09g057   # RZ/V2H(P)
+      - enum:
+          - renesas,riic-r9a09g057   # RZ/V2H(P)
+          - renesas,riic-r9a09g077   # RZ/T2H
+
+      - items:
+          - const: renesas,riic-r9a09g087  # RZ/N2H
+          - const: renesas,riic-r9a09g077  # RZ/T2H
 
   reg:
     maxItems: 1
 
   interrupts:
-    items:
-      - description: Transmit End Interrupt
-      - description: Receive Data Full Interrupt
-      - description: Transmit Data Empty Interrupt
-      - description: Stop Condition Detection Interrupt
-      - description: Start Condition Detection Interrupt
-      - description: NACK Reception Interrupt
-      - description: Arbitration-Lost Interrupt
-      - description: Timeout Interrupt
+    oneOf:
+      - items:
+          - description: Transmit End Interrupt
+          - description: Receive Data Full Interrupt
+          - description: Transmit Data Empty Interrupt
+          - description: Stop Condition Detection Interrupt
+          - description: Start Condition Detection Interrupt
+          - description: NACK Reception Interrupt
+          - description: Arbitration-Lost Interrupt
+          - description: Timeout Interrupt
+      - items:
+          - description: Transfer Error Or Event Generation
+          - description: Receive Data Full Interrupt
+          - description: Transmit Data Empty Interrupt
+          - description: Transmit End Interrupt
 
   interrupt-names:
-    items:
-      - const: tei
-      - const: ri
-      - const: ti
-      - const: spi
-      - const: sti
-      - const: naki
-      - const: ali
-      - const: tmoi
+    oneOf:
+      - items:
+          - const: tei
+          - const: ri
+          - const: ti
+          - const: spi
+          - const: sti
+          - const: naki
+          - const: ali
+          - const: tmoi
+      - items:
+          - const: eei
+          - const: rxi
+          - const: txi
+          - const: tei
 
   clock-frequency:
     description:
@@ -83,6 +101,25 @@ required:
 allOf:
   - $ref: /schemas/i2c/i2c-controller.yaml#
 
+  - if:
+      properties:
+        compatible:
+          contains:
+            const: renesas,riic-r9a09g077
+    then:
+      properties:
+        interrupts:
+          maxItems: 4
+        interrupt-names:
+          maxItems: 4
+        resets: false
+    else:
+      properties:
+        interrupts:
+          minItems: 8
+        interrupt-names:
+          minItems: 8
+
   - if:
       properties:
         compatible:
-- 
2.43.0


