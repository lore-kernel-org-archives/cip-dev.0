Return-Path: <biju.das.jz@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34EAAC7EE2F
	for <webhook@archiver.kernel.org>; Thu,  1 Jun 2023 15:04:31 +0000 (UTC)
Received: from relmlie6.idc.renesas.com (relmlie6.idc.renesas.com [210.160.252.172])
 by mx.groups.io with SMTP id smtpd.web11.34984.1685631867442791752
 for <cip-dev@lists.cip-project.org>;
 Thu, 01 Jun 2023 08:04:27 -0700
Authentication-Results: mx.groups.io;
 dkim=missing; spf=pass (domain: bp.renesas.com, ip: 210.160.252.172, mailfrom: biju.das.jz@bp.renesas.com)
X-IronPort-AV: E=Sophos;i="6.00,210,1681138800"; 
   d="scan'208";a="165350503"
Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie6.idc.renesas.com with ESMTP; 02 Jun 2023 00:04:26 +0900
Received: from localhost.localdomain (unknown [10.226.93.19])
	by relmlir5.idc.renesas.com (Postfix) with ESMTP id B4C5E4011405;
	Fri,  2 Jun 2023 00:04:24 +0900 (JST)
From: Biju Das <biju.das.jz@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
Cc: Chris Paterson <chris.paterson2@renesas.com>,
	Biju Das <biju.das.jz@bp.renesas.com>,
	Fabrizio Castro <fabrizio.castro.jz@renesas.com>
Subject: [PATCH 5.10.y-cip 05/19] dt-bindings: usb: renesas,usb3-peri: Update reset, clock-name and interrupts properties
Date: Thu,  1 Jun 2023 16:03:56 +0100
Message-Id: <20230601150410.124773-6-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230601150410.124773-1-biju.das.jz@bp.renesas.com>
References: <20230601150410.124773-1-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 01 Jun 2023 15:04:31 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/11735

commit 29218d6ce4da741f8a1a86974999e8790683c23b upstream.

On RZ/V2M, USB3DRD module manages the drd_reset. Moreover, the interrupts
drd, gpi and bc are part of USB3DRD block. This patch removes
drd_reset and the interrupts drd, bc and gpi from usb3_peri bindings.
After this, there is only one reset and interrupts and therefore
removing reset-names and interrupt-names as well.

Whilst, Update the clock-name "aclk"->"axi" to make it consistent with
DRD and host blocks.

There is any harm in making such a change as, no users of
renesas,r9a09g011-usb3-peri yet in kernel release.

Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
Reviewed-by: Rob Herring <robh@kernel.org>
Link: https://lore.kernel.org/r/20230121145853.4792-3-biju.das.jz@bp.renesas.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
 .../bindings/usb/renesas,usb3-peri.yaml       | 39 ++-----------------
 1 file changed, 3 insertions(+), 36 deletions(-)

diff --git a/Documentation/devicetree/bindings/usb/renesas,usb3-peri.yaml b/Documentation/devicetree/bindings/usb/renesas,usb3-peri.yaml
index 7a84f5922340..fbbbc3de3ec0 100644
--- a/Documentation/devicetree/bindings/usb/renesas,usb3-peri.yaml
+++ b/Documentation/devicetree/bindings/usb/renesas,usb3-peri.yaml
@@ -34,20 +34,7 @@ properties:
     maxItems: 1
 
   interrupts:
-    minItems: 1
-    items:
-      - description: Combined interrupt for DMA, SYS and ERR
-      - description: Dual Role Device (DRD)
-      - description: Battery Charging
-      - description: Global Purpose Input
-
-  interrupt-names:
-    minItems: 1
-    items:
-      - const: all_p
-      - const: drd
-      - const: bc
-      - const: gpi
+    maxItems: 1
 
   clocks:
     minItems: 1
@@ -58,7 +45,7 @@ properties:
   clock-names:
     minItems: 1
     items:
-      - const: aclk
+      - const: axi
       - const: reg
 
   phys:
@@ -71,15 +58,7 @@ properties:
     maxItems: 1
 
   resets:
-    minItems: 1
-    items:
-      - description: Peripheral reset
-      - description: DRD reset
-
-  reset-names:
-    items:
-      - const: aresetn_p
-      - const: drd_reset
+    maxItems: 1
 
   usb-role-switch:
     $ref: /schemas/types.yaml#/definitions/flag
@@ -126,25 +105,13 @@ allOf:
           minItems: 2
         clock-names:
           minItems: 2
-        interrupts:
-          minItems: 4
-        interrupt-names:
-          minItems: 4
-        resets:
-          minItems: 2
       required:
         - clock-names
-        - interrupt-names
         - resets
-        - reset-names
     else:
       properties:
         clocks:
           maxItems: 1
-        interrupts:
-          maxItems: 1
-        resets:
-          maxItems: 1
 
 additionalProperties: false
 
-- 
2.25.1


