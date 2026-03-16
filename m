Return-Path: <prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9AD84F506F5
	for <webhook@archiver.kernel.org>; Mon, 16 Mar 2026 14:59:35 +0000 (UTC)
Received: from relmlie6.idc.renesas.com (relmlie6.idc.renesas.com [210.160.252.172])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.52441.1773673162325782965
 for <cip-dev@lists.cip-project.org>;
 Mon, 16 Mar 2026 07:59:28 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: bp.renesas.com, ip: 210.160.252.172, mailfrom: prabhakar.mahadev-lad.rj@bp.renesas.com)
X-CSE-ConnectionGUID: ldyBm0kaSA6uakpz7Vmp6Q==
X-CSE-MsgGUID: WUzYBuQcR/iRmJsrzJjaYw==
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie6.idc.renesas.com with ESMTP; 16 Mar 2026 23:59:28 +0900
Received: from Ubuntu-22.. (unknown [10.24.0.53])
	by relmlir6.idc.renesas.com (Postfix) with ESMTP id 30C5C41B781A;
	Mon, 16 Mar 2026 23:59:26 +0900 (JST)
From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro.iwamatsu.x90@mail.toshiba>,
	Pavel Machek <pavel@nabladev.com>
Cc: Biju Das <biju.das.jz@bp.renesas.com>
Subject: [PATCH 6.12.y-cip 06/35] dt-bindings: phy: renesas,usb2-phy: Add RZ/T2H and RZ/N2H support
Date: Mon, 16 Mar 2026 14:58:43 +0000
Message-ID: <20260316145915.8580-7-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260316145915.8580-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20260316145915.8580-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 16 Mar 2026 14:59:35 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/22398

commit ab9c8aeb2d208381a7c948ea2f753cbe8a451502 upstream.

Document the USB2 PHY controller for the Renesas RZ/T2H (r9a09g077) and
RZ/N2H (r9a09g087) SoCs. These SoCs share the same PHY block, which is
similar to the one on RZ/G2L but differs in clocks, resets, and register
bits. To account for these differences, a new compatible string
`renesas,usb2-phy-r9a09g077` is introduced.

The RZ/N2H SoC uses the same PHY as RZ/T2H, so it reuses the RZ/T2H
compatible string as a fallback.

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Acked-by: Conor Dooley <conor.dooley@microchip.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Link: https://lore.kernel.org/r/20250808215209.3692744-2-prabhakar.mahadev-lad.rj@bp.renesas.com
Signed-off-by: Vinod Koul <vkoul@kernel.org>
Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
 .../bindings/phy/renesas,usb2-phy.yaml          | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/Documentation/devicetree/bindings/phy/renesas,usb2-phy.yaml b/Documentation/devicetree/bindings/phy/renesas,usb2-phy.yaml
index f45c5f039ae8..179cb4bfc424 100644
--- a/Documentation/devicetree/bindings/phy/renesas,usb2-phy.yaml
+++ b/Documentation/devicetree/bindings/phy/renesas,usb2-phy.yaml
@@ -44,6 +44,12 @@ properties:
           - const: renesas,usb2-phy-r9a09g056 # RZ/V2N
           - const: renesas,usb2-phy-r9a09g057
 
+      - const: renesas,usb2-phy-r9a09g077 # RZ/T2H
+
+      - items:
+          - const: renesas,usb2-phy-r9a09g087 # RZ/N2H
+          - const: renesas,usb2-phy-r9a09g077
+
   reg:
     maxItems: 1
 
@@ -120,6 +126,17 @@ allOf:
       required:
         - resets
 
+  - if:
+      properties:
+        compatible:
+          contains:
+            const: renesas,usb2-phy-r9a09g077
+    then:
+      properties:
+        clocks:
+          minItems: 2
+        resets: false
+
 additionalProperties: false
 
 examples:
-- 
2.43.0


