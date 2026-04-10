Return-Path: <cosmin-gabriel.tanislav.xa@renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D0A1F45A03
	for <webhook@archiver.kernel.org>; Fri, 10 Apr 2026 17:03:18 +0000 (UTC)
Received: from relmlie5.idc.renesas.com (relmlie5.idc.renesas.com [210.160.252.171])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.161295.1775840591878637041
 for <cip-dev@lists.cip-project.org>;
 Fri, 10 Apr 2026 10:03:12 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: renesas.com, ip: 210.160.252.171, mailfrom: cosmin-gabriel.tanislav.xa@renesas.com)
X-CSE-ConnectionGUID: ks30sHTvTvOMn+u9x55Dag==
X-CSE-MsgGUID: qKGKroTDTZeTvYgtSabX/w==
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie5.idc.renesas.com with ESMTP; 11 Apr 2026 02:03:11 +0900
Received: from demon-pc.localdomain (unknown [10.226.93.85])
	by relmlir6.idc.renesas.com (Postfix) with ESMTP id EE814402F558;
	Sat, 11 Apr 2026 02:03:09 +0900 (JST)
From: Cosmin Tanislav <cosmin-gabriel.tanislav.xa@renesas.com>
To: cip-dev@lists.cip-project.org,
	pavel@nabladev.com,
	nobuhiro.iwamatsu.x90@mail.toshiba
Subject: [PATCH 6.12.y-cip 05/11] dt-bindings: thermal: r9a09g047-tsu: document RZ/T2H and RZ/N2H
Date: Fri, 10 Apr 2026 20:02:09 +0300
Message-ID: <20260410170215.393698-6-cosmin-gabriel.tanislav.xa@renesas.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260410170215.393698-1-cosmin-gabriel.tanislav.xa@renesas.com>
References: <20260410170215.393698-1-cosmin-gabriel.tanislav.xa@renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 10 Apr 2026 17:03:18 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/22668

commit f41eaaa5f2c9fb4fc816e45e2061d80c0b927d39 upstream.

The Renesas RZ/T2H (R9A09G077) and RZ/N2H (R9A09G087) SoCs include a
Temperature Sensor Unit (TSU). The device provides real-time temperature
measurements for thermal management, utilizing a single dedicated
channel for temperature sensing.

Compared to the previously supported RZ/G3E, the RZ/T2H and RZ/N2H SoCs
do not have a reset for the TSU peripheral, and the OTP data is exposed
via ARM SMC, as opposed to a system register.

Acked-by: Conor Dooley <conor.dooley@microchip.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Cosmin Tanislav <cosmin-gabriel.tanislav.xa@renesas.com>
Link: https://patch.msgid.link/20260108195223.193531-5-cosmin-gabriel.tanislav.xa@renesas.com
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
[cosmin.tanislav: resolve merge conflict]
Signed-off-by: Cosmin Tanislav <cosmin-gabriel.tanislav.xa@renesas.com>
---
 .../thermal/renesas,r9a09g047-tsu.yaml        | 30 +++++++++++++++++--
 1 file changed, 27 insertions(+), 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/thermal/renesas,r9a09g047-tsu.yaml b/Documentation/devicetree/bindings/thermal/renesas,r9a09g047-tsu.yaml
index c959b9834620c..d560c58be4d6e 100644
--- a/Documentation/devicetree/bindings/thermal/renesas,r9a09g047-tsu.yaml
+++ b/Documentation/devicetree/bindings/thermal/renesas,r9a09g047-tsu.yaml
@@ -17,12 +17,17 @@ description:
 properties:
   compatible:
     oneOf:
-      - const: renesas,r9a09g047-tsu # RZ/G3E
+      - enum:
+          - renesas,r9a09g047-tsu # RZ/G3E
+          - renesas,r9a09g077-tsu # RZ/T2H
       - items:
           - enum:
               - renesas,r9a09g056-tsu # RZ/V2N
               - renesas,r9a09g057-tsu # RZ/V2H
           - const: renesas,r9a09g047-tsu # RZ/G3E
+      - items:
+          - const: renesas,r9a09g087-tsu # RZ/N2H
+          - const: renesas,r9a09g077-tsu # RZ/T2H
 
   reg:
     maxItems: 1
@@ -65,12 +70,31 @@ required:
   - compatible
   - reg
   - clocks
-  - resets
   - power-domains
   - interrupts
   - interrupt-names
   - "#thermal-sensor-cells"
-  - renesas,tsu-trim
+
+allOf:
+  - if:
+      properties:
+        compatible:
+          contains:
+            const: renesas,r9a09g047-tsu
+    then:
+      required:
+        - resets
+        - renesas,tsu-trim
+
+  - if:
+      properties:
+        compatible:
+          contains:
+            const: renesas,r9a09g077-tsu
+    then:
+      properties:
+        resets: false
+        renesas,tsu-trim: false
 
 additionalProperties: false
 
-- 
2.53.0


