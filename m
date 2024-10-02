Return-Path: <biju.das.jz@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04BA1CF6D57
	for <webhook@archiver.kernel.org>; Wed,  2 Oct 2024 17:07:43 +0000 (UTC)
Received: from relmlie6.idc.renesas.com (relmlie6.idc.renesas.com [210.160.252.172])
 by mx.groups.io with SMTP id smtpd.web11.1143.1727888860684620014
 for <cip-dev@lists.cip-project.org>;
 Wed, 02 Oct 2024 10:07:40 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: bp.renesas.com, ip: 210.160.252.172, mailfrom: biju.das.jz@bp.renesas.com)
X-IronPort-AV: E=Sophos;i="6.11,172,1725289200"; 
   d="scan'208";a="224579767"
Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie6.idc.renesas.com with ESMTP; 03 Oct 2024 02:07:40 +0900
Received: from localhost.localdomain (unknown [10.226.92.106])
	by relmlir5.idc.renesas.com (Postfix) with ESMTP id AAEE740065CF;
	Thu,  3 Oct 2024 02:07:29 +0900 (JST)
From: Biju Das <biju.das.jz@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
Cc: Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH 5.10.y-cip 07/15] media: dt-bindings: media: renesas,fcp: Document RZ/{G2L,V2L} FCPVD bindings
Date: Wed,  2 Oct 2024 18:06:56 +0100
Message-ID: <20241002170712.655449-8-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241002170712.655449-1-biju.das.jz@bp.renesas.com>
References: <20241002170712.655449-1-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 02 Oct 2024 17:07:43 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/16973

commit 81442e3e6c0f7de9df64addc53d49079b8045b05 upstream.

Document FCPVD found in RZ/G2L alike SoCs. FCPVD block is similar to
FCP for VSP found on R-Car SoC's . It has 3 clocks compared to 1
clock on fcpv. Introduce new compatibles renesas,r9a07g044-fcpvd
for RZ/G2{L,LC} and renesas,r9a07g054-fcpvd for RZ/V2L to handle this
difference.

The 3 clocks are shared between du, vspd and fcpvd. No driver changes
are required as generic compatible string "renesas,fcpv" will be used
as a fallback.

Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
Reviewed-by: Rob Herring <robh@kernel.org>
Signed-off-by: Hans Verkuil <hverkuil-cisco@xs4all.nl>
Signed-off-by: Mauro Carvalho Chehab <mchehab@kernel.org>
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
 .../bindings/media/renesas,fcp.yaml           | 45 ++++++++++++++++---
 1 file changed, 40 insertions(+), 5 deletions(-)

diff --git a/Documentation/devicetree/bindings/media/renesas,fcp.yaml b/Documentation/devicetree/bindings/media/renesas,fcp.yaml
index 43f2fed8cd33..c6abe719881b 100644
--- a/Documentation/devicetree/bindings/media/renesas,fcp.yaml
+++ b/Documentation/devicetree/bindings/media/renesas,fcp.yaml
@@ -21,15 +21,22 @@ description: |
 
 properties:
   compatible:
-    enum:
-      - renesas,fcpv # FCP for VSP
-      - renesas,fcpf # FCP for FDP
+    oneOf:
+      - enum:
+          - renesas,fcpv # FCP for VSP
+          - renesas,fcpf # FCP for FDP
+      - items:
+          - enum:
+              - renesas,r9a07g044-fcpvd # RZ/G2{L,LC}
+              - renesas,r9a07g054-fcpvd # RZ/V2L
+          - const: renesas,fcpv         # Generic FCP for VSP fallback
 
   reg:
     maxItems: 1
 
-  clocks:
-    maxItems: 1
+  clocks: true
+
+  clock-names: true
 
   iommus:
     maxItems: 1
@@ -49,6 +56,34 @@ required:
 
 additionalProperties: false
 
+allOf:
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - renesas,r9a07g044-fcpvd
+              - renesas,r9a07g054-fcpvd
+    then:
+      properties:
+        clocks:
+          items:
+            - description: Main clock
+            - description: Register access clock
+            - description: Video clock
+        clock-names:
+          items:
+            - const: aclk
+            - const: pclk
+            - const: vclk
+      required:
+        - clock-names
+    else:
+      properties:
+        clocks:
+          maxItems: 1
+        clock-names: false
+
 examples:
   # R8A7795 (R-Car H3) FCP for VSP-D1
   - |
-- 
2.43.0


