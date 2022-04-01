Return-Path: <prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56DF2C64ECC
	for <webhook@archiver.kernel.org>; Mon,  4 Apr 2022 18:46:49 +0000 (UTC)
Received: from relmlie5.idc.renesas.com (relmlie5.idc.renesas.com
 [210.160.252.171])
 by mx.groups.io with SMTP id smtpd.web09.3568.1648842202850727941
 for <cip-dev@lists.cip-project.org>;
 Fri, 01 Apr 2022 12:43:39 -0700
Authentication-Results: mx.groups.io;
 dkim=missing;
 spf=pass (domain: bp.renesas.com, ip: 210.160.252.171,
 mailfrom: prabhakar.mahadev-lad.rj@bp.renesas.com)
X-IronPort-AV: E=Sophos;i="5.90,228,1643641200";
   d="scan'208";a="115453886"
Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie5.idc.renesas.com with ESMTP; 02 Apr 2022 04:43:39 +0900
Received: from localhost.localdomain (unknown [10.226.36.204])
	by relmlir5.idc.renesas.com (Postfix) with ESMTP id 0878C40061B8;
	Sat,  2 Apr 2022 04:43:37 +0900 (JST)
From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
Cc: Biju Das <biju.das.jz@bp.renesas.com>
Subject: [RESEND PATCH 5.10.y-cip 36/40] dt-bindings: mmc: renesas,sdhi: Add
 optional SDnH clock
Date: Fri,  1 Apr 2022 20:42:30 +0100
Message-Id: <20220401194234.14057-37-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220401194234.14057-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20220401194234.14057-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 04 Apr 2022 18:46:49 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/7947

From: Wolfram Sang <wsa+renesas@sang-engineering.com>

commit e051025efac3929ca7e3e2f2c8860d3447366ebc upstream.

This only applies to R-Car Gen2 and later generations, so we need to
distinguish.

Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
Acked-by: Ulf Hansson <ulf.hansson@linaro.org>
Link: https://lore.kernel.org/r/20211115160600.4455-1-wsa+renesas@sang-engineering.com
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
 .../devicetree/bindings/mmc/renesas,sdhi.yaml | 38 ++++++++++++++-----
 1 file changed, 29 insertions(+), 9 deletions(-)

diff --git a/Documentation/devicetree/bindings/mmc/renesas,sdhi.yaml b/Documentation/devicetree/bindings/mmc/renesas,sdhi.yaml
index 77b1bb907497..c20ee9e5b8e8 100644
--- a/Documentation/devicetree/bindings/mmc/renesas,sdhi.yaml
+++ b/Documentation/devicetree/bindings/mmc/renesas,sdhi.yaml
@@ -128,15 +128,35 @@ allOf:
         - clock-names
         - resets
     else:
-      properties:
-        clocks:
-          minItems: 1
-          maxItems: 2
-        clock-names:
-          minItems: 1
-          items:
-            - const: core
-            - const: cd
+      if:
+        properties:
+          compatible:
+            contains:
+              enum:
+                - renesas,rcar-gen2-sdhi
+                - renesas,rcar-gen3-sdhi
+      then:
+        properties:
+          clocks:
+            minItems: 1
+            maxItems: 3
+          clock-names:
+            minItems: 1
+            uniqueItems: true
+            items:
+              - const: core
+              - enum: [ clkh, cd ]
+              - const: cd
+      else:
+        properties:
+          clocks:
+            minItems: 1
+            maxItems: 2
+          clock-names:
+            minItems: 1
+            items:
+              - const: core
+              - const: cd
 
   - if:
       properties:
-- 
2.17.1


