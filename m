Return-Path: <biju.das.jz@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 357B7C7EE31
	for <webhook@archiver.kernel.org>; Thu,  1 Jun 2023 15:04:31 +0000 (UTC)
Received: from relmlie5.idc.renesas.com (relmlie5.idc.renesas.com [210.160.252.171])
 by mx.groups.io with SMTP id smtpd.web10.34567.1685631857448189436
 for <cip-dev@lists.cip-project.org>;
 Thu, 01 Jun 2023 08:04:22 -0700
Authentication-Results: mx.groups.io;
 dkim=missing; spf=pass (domain: bp.renesas.com, ip: 210.160.252.171, mailfrom: biju.das.jz@bp.renesas.com)
X-IronPort-AV: E=Sophos;i="6.00,210,1681138800"; 
   d="scan'208";a="161816451"
Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie5.idc.renesas.com with ESMTP; 02 Jun 2023 00:04:21 +0900
Received: from localhost.localdomain (unknown [10.226.93.19])
	by relmlir5.idc.renesas.com (Postfix) with ESMTP id B462B40078AA;
	Fri,  2 Jun 2023 00:04:19 +0900 (JST)
From: Biju Das <biju.das.jz@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
Cc: Chris Paterson <chris.paterson2@renesas.com>,
	Biju Das <biju.das.jz@bp.renesas.com>,
	Fabrizio Castro <fabrizio.castro.jz@renesas.com>
Subject: [PATCH 5.10.y-cip 03/19] dt-bindings: usb: renesas,usb-xhci: Document RZ/V2M support
Date: Thu,  1 Jun 2023 16:03:54 +0100
Message-Id: <20230601150410.124773-4-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230601150410.124773-1-biju.das.jz@bp.renesas.com>
References: <20230601150410.124773-1-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 01 Jun 2023 15:04:31 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/11733

commit e696d70f600abbe2b7fe81008bcb24d239a74672 upstream.

Document the RZ/V2M SoC bindings.
The RZ/V2M SoC is a little different to the R-Car implementations.
You can access the registers associated with the currently set DRD mode,
therefore as part of init, we have to set the DRD mode to host.

Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
Reviewed-by: Rob Herring <robh@kernel.org>
Link: https://lore.kernel.org/r/20230121145853.4792-2-biju.das.jz@bp.renesas.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
 .../bindings/usb/renesas,usb-xhci.yaml        | 43 ++++++++++++++++---
 1 file changed, 38 insertions(+), 5 deletions(-)

diff --git a/Documentation/devicetree/bindings/usb/renesas,usb-xhci.yaml b/Documentation/devicetree/bindings/usb/renesas,usb-xhci.yaml
index 0f078bd0a3e5..4eef22c6eff2 100644
--- a/Documentation/devicetree/bindings/usb/renesas,usb-xhci.yaml
+++ b/Documentation/devicetree/bindings/usb/renesas,usb-xhci.yaml
@@ -10,9 +10,6 @@ maintainers:
   - Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
   - Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
 
-allOf:
-  - $ref: "usb-hcd.yaml"
-
 properties:
   compatible:
     oneOf:
@@ -37,6 +34,11 @@ properties:
               - renesas,xhci-r8a77965 # R-Car M3-N
               - renesas,xhci-r8a77990 # R-Car E3
           - const: renesas,rcar-gen3-xhci # R-Car Gen3 and RZ/G2
+      - items:
+          - enum:
+              - renesas,r9a09g011-xhci # RZ/V2M
+              - renesas,r9a09g055-xhci # RZ/V2MA
+          - const: renesas,rzv2m-xhci  # RZ/{V2M, V2MA}
 
   reg:
     maxItems: 1
@@ -45,7 +47,16 @@ properties:
     maxItems: 1
 
   clocks:
-    maxItems: 1
+    minItems: 1
+    items:
+      - description: Main clock for host
+      - description: Register access clock
+
+  clock-names:
+    minItems: 1
+    items:
+      - const: axi
+      - const: reg
 
   phys:
     maxItems: 1
@@ -69,7 +80,29 @@ required:
   - power-domains
   - resets
 
-additionalProperties: false
+allOf:
+  - $ref: usb-xhci.yaml
+
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - renesas,rzv2m-xhci
+    then:
+      properties:
+        clocks:
+          minItems: 2
+        clock-names:
+          minItems: 2
+      required:
+        - clock-names
+    else:
+      properties:
+        clocks:
+          maxItems: 1
+
+unevaluatedProperties: false
 
 examples:
   - |
-- 
2.25.1


