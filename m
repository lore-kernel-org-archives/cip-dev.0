Return-Path: <prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4364F506F9
	for <webhook@archiver.kernel.org>; Mon, 16 Mar 2026 14:59:45 +0000 (UTC)
Received: from relmlie5.idc.renesas.com (relmlie5.idc.renesas.com [210.160.252.171])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.52440.1773673159009042004
 for <cip-dev@lists.cip-project.org>;
 Mon, 16 Mar 2026 07:59:39 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: bp.renesas.com, ip: 210.160.252.171, mailfrom: prabhakar.mahadev-lad.rj@bp.renesas.com)
X-CSE-ConnectionGUID: FrSmyKuKQ6yRpqN94DvNxw==
X-CSE-MsgGUID: 78yLnC9hSouvICGdiw7veg==
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie5.idc.renesas.com with ESMTP; 16 Mar 2026 23:59:38 +0900
Received: from Ubuntu-22.. (unknown [10.24.0.53])
	by relmlir6.idc.renesas.com (Postfix) with ESMTP id 8D63941B781C;
	Mon, 16 Mar 2026 23:59:37 +0900 (JST)
From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro.iwamatsu.x90@mail.toshiba>,
	Pavel Machek <pavel@nabladev.com>
Cc: Biju Das <biju.das.jz@bp.renesas.com>
Subject: [PATCH 6.12.y-cip 12/35] dt-bindings: usb: renesas,usbhs: Add RZ/T2H and RZ/N2H support
Date: Mon, 16 Mar 2026 14:58:49 +0000
Message-ID: <20260316145915.8580-13-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260316145915.8580-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20260316145915.8580-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 16 Mar 2026 14:59:45 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/22404

commit e58ebd14a5f15eccf3dd45edf4bc900b346096bf upstream.

Document the USBHS controller for the Renesas RZ/T2H (r9a09g077) and
RZ/N2H (r9a09g087) SoCs. While the USBHS block is similar to the one found
on the RZ/G2L SoC, it differs slightly in terms of interrupt configuration,
clock/reset requirements, and register bit definitions. Due to these
differences, a new compatible string `renesas,usbhs-r9a09g077` is
introduced for the RZ/T2H SoC.

The USBHS controller on the RZ/N2H (r9a09g087) SoC is identical to that on
the RZ/T2H, so it uses the `renesas,usbhs-r9a09g077` compatible string as
a fallback.

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Acked-by: Conor Dooley <conor.dooley@microchip.com>
Link: https://lore.kernel.org/r/20250805114730.2491238-2-prabhakar.mahadev-lad.rj@bp.renesas.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
 .../bindings/usb/renesas,usbhs.yaml           | 28 +++++++++++++++++--
 1 file changed, 25 insertions(+), 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/usb/renesas,usbhs.yaml b/Documentation/devicetree/bindings/usb/renesas,usbhs.yaml
index 533b40f8aaae..4ad5362987b1 100644
--- a/Documentation/devicetree/bindings/usb/renesas,usbhs.yaml
+++ b/Documentation/devicetree/bindings/usb/renesas,usbhs.yaml
@@ -58,6 +58,12 @@ properties:
               - renesas,usbhs-r8a77995 # R-Car D3
           - const: renesas,rcar-gen3-usbhs
 
+      - const: renesas,usbhs-r9a09g077 # RZ/T2H
+
+      - items:
+          - const: renesas,usbhs-r9a09g087 # RZ/N2H
+          - const: renesas,usbhs-r9a09g077 # RZ/T2H
+
   reg:
     maxItems: 1
 
@@ -136,9 +142,25 @@ allOf:
       required:
         - resets
     else:
-      properties:
-        interrupts:
-          maxItems: 1
+      if:
+        properties:
+          compatible:
+            contains:
+              const: renesas,usbhs-r9a09g077
+      then:
+        properties:
+          resets: false
+          clocks:
+            maxItems: 1
+          interrupts:
+            items:
+              - description: USB function interrupt USB_FI
+              - description: USB function DMA0 transmit completion interrupt USB_FDMA0
+              - description: USB function DMA1 transmit completion interrupt USB_FDMA1
+      else:
+        properties:
+          interrupts:
+            maxItems: 1
 
 additionalProperties: false
 
-- 
2.43.0


