Return-Path: <ovidiu.panait.rb@renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8968DD1A602
	for <webhook@archiver.kernel.org>; Fri,  9 Jan 2026 12:16:37 +0000 (UTC)
Received: from relmlie6.idc.renesas.com (relmlie6.idc.renesas.com [210.160.252.172])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.8763.1767960987957835683
 for <cip-dev@lists.cip-project.org>;
 Fri, 09 Jan 2026 04:16:28 -0800
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: renesas.com, ip: 210.160.252.172, mailfrom: ovidiu.panait.rb@renesas.com)
X-CSE-ConnectionGUID: 22arCWJNRjKH+8wuJT+XFg==
X-CSE-MsgGUID: OT+NpuJGQ6OPa/XaAdS3FQ==
Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie6.idc.renesas.com with ESMTP; 09 Jan 2026 21:16:26 +0900
Received: from vm01.adwin.renesas.com (unknown [10.226.93.57])
	by relmlir5.idc.renesas.com (Postfix) with ESMTP id CC3AE401D73A;
	Fri,  9 Jan 2026 21:16:25 +0900 (JST)
From: Ovidiu Panait <ovidiu.panait.rb@renesas.com>
To: cip-dev@lists.cip-project.org,
	pavel@nabladev.com,
	nobuhiro.iwamatsu.x90@mail.toshiba
Subject: [PATCH 6.1.y-cip 1/8] dt-bindings: rtc: renesas,rz-rtca3: Add RZ/V2H support
Date: Fri,  9 Jan 2026 12:16:15 +0000
Message-ID: <20260109121622.46030-2-ovidiu.panait.rb@renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260109121622.46030-1-ovidiu.panait.rb@renesas.com>
References: <20260109121622.46030-1-ovidiu.panait.rb@renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 09 Jan 2026 12:16:37 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/21508

commit 4800046b56a5b240ab280f55165484a9dbdf7092 upstream.

The Renesas RZ/V2H RTC IP is based on the same RTCA3 IP as RZ/G3S
(r9a08g045), with the following differences:
- It lacks the time capture functionality
- The maximum supported periodic interrupt frequency is 128Hz instead
  of 256Hz
- It requires two reset lines instead of one

Add new compatible string "renesas,r9a09g057-rtca3" for RZ/V2H and update
the binding accordingly:
- Allow "resets" to contain one or two entries depending on the SoC.
- Add "reset-names" property, but make it required only for RZ/V2H.

Signed-off-by: Ovidiu Panait <ovidiu.panait.rb@renesas.com>
Acked-by: Conor Dooley <conor.dooley@microchip.com>
Link: https://patch.msgid.link/20251107210706.45044-2-ovidiu.panait.rb@renesas.com
Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
Signed-off-by: Ovidiu Panait <ovidiu.panait.rb@renesas.com>
---
 .../bindings/rtc/renesas,rz-rtca3.yaml        | 46 +++++++++++++++++--
 1 file changed, 41 insertions(+), 5 deletions(-)

diff --git a/Documentation/devicetree/bindings/rtc/renesas,rz-rtca3.yaml b/Documentation/devicetree/bindings/rtc/renesas,rz-rtca3.yaml
index e70eeb66aa64..ccb1638c35b9 100644
--- a/Documentation/devicetree/bindings/rtc/renesas,rz-rtca3.yaml
+++ b/Documentation/devicetree/bindings/rtc/renesas,rz-rtca3.yaml
@@ -9,14 +9,12 @@ title: Renesas RTCA-3 Real Time Clock
 maintainers:
   - Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
 
-allOf:
-  - $ref: rtc.yaml#
-
 properties:
   compatible:
     items:
       - enum:
           - renesas,r9a08g045-rtca3 # RZ/G3S
+          - renesas,r9a09g057-rtca3 # RZ/V2H
       - const: renesas,rz-rtca3
 
   reg:
@@ -48,8 +46,12 @@ properties:
     maxItems: 1
 
   resets:
-    items:
-      - description: VBATTB module reset
+    minItems: 1
+    maxItems: 2
+
+  reset-names:
+    minItems: 1
+    maxItems: 2
 
 required:
   - compatible
@@ -61,6 +63,39 @@ required:
   - power-domains
   - resets
 
+allOf:
+  - $ref: rtc.yaml#
+
+  - if:
+      properties:
+        compatible:
+          contains:
+            const: renesas,r9a08g045-rtca3
+    then:
+      properties:
+        resets:
+          items:
+            - description: VBATTB module reset
+        reset-names:
+          const: vbattb
+  - if:
+      properties:
+        compatible:
+          contains:
+            const: renesas,r9a09g057-rtca3
+    then:
+      properties:
+        resets:
+          items:
+            - description: RTC reset
+            - description: Reset for the RTEST registers
+        reset-names:
+          items:
+            - const: rtc
+            - const: rtest
+      required:
+        - reset-names
+
 additionalProperties: false
 
 examples:
@@ -81,4 +116,5 @@ examples:
         clock-names = "bus", "counter";
         power-domains = <&cpg>;
         resets = <&cpg R9A08G045_VBAT_BRESETN>;
+        reset-names = "vbattb";
     };
-- 
2.51.0


