Return-Path: <ovidiu.panait.rb@renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9995FCCF2FF
	for <webhook@archiver.kernel.org>; Mon, 19 Jan 2026 12:51:20 +0000 (UTC)
Received: from relmlie5.idc.renesas.com (relmlie5.idc.renesas.com [210.160.252.171])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.34490.1768827069824294245
 for <cip-dev@lists.cip-project.org>;
 Mon, 19 Jan 2026 04:51:10 -0800
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: renesas.com, ip: 210.160.252.171, mailfrom: ovidiu.panait.rb@renesas.com)
X-CSE-ConnectionGUID: QkfAZYcVTlKfSX0NcUjbww==
X-CSE-MsgGUID: 0z5TYUD8Quu3nnXlfFfZWA==
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie5.idc.renesas.com with ESMTP; 19 Jan 2026 21:51:10 +0900
Received: from vm01.adwin.renesas.com (unknown [10.226.92.25])
	by relmlir6.idc.renesas.com (Postfix) with ESMTP id 5B997413151D;
	Mon, 19 Jan 2026 21:51:09 +0900 (JST)
From: Ovidiu Panait <ovidiu.panait.rb@renesas.com>
To: cip-dev@lists.cip-project.org,
	pavel@nabladev.com,
	nobuhiro.iwamatsu.x90@mail.toshiba
Subject: [PATCH 6.1.y-cip 2/6] dt-bindings: reset: renesas,rzv2h-usb2phy: Document RZ/V2N SoC support
Date: Mon, 19 Jan 2026 12:51:00 +0000
Message-ID: <20260119125104.32147-3-ovidiu.panait.rb@renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260119125104.32147-1-ovidiu.panait.rb@renesas.com>
References: <20260119125104.32147-1-ovidiu.panait.rb@renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 19 Jan 2026 12:51:20 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/21647

From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

commit fd4a06a2e1661893c5353f8b01bf6ae44cbe094d upstream.

Document support for the USB2PHY reset controller found on the Renesas
RZ/V2N (R9A09G056) SoC. The reset controller IP is functionally identical
to that on the RZ/V2H(P) SoC, so no driver changes are needed. The existing
`renesas,r9a09g057-usb2phy-reset` compatible will be used as a fallback
for the RZ/V2N SoC.

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Acked-by: Conor Dooley <conor.dooley@microchip.com>
Link: https://lore.kernel.org/r/20250528133031.167647-1-prabhakar.mahadev-lad.rj@bp.renesas.com
Signed-off-by: Philipp Zabel <p.zabel@pengutronix.de>
Signed-off-by: Ovidiu Panait <ovidiu.panait.rb@renesas.com>
---
 .../bindings/reset/renesas,rzv2h-usb2phy-reset.yaml        | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/reset/renesas,rzv2h-usb2phy-reset.yaml b/Documentation/devicetree/bindings/reset/renesas,rzv2h-usb2phy-reset.yaml
index c79f61c2373b..c1b800a10b53 100644
--- a/Documentation/devicetree/bindings/reset/renesas,rzv2h-usb2phy-reset.yaml
+++ b/Documentation/devicetree/bindings/reset/renesas,rzv2h-usb2phy-reset.yaml
@@ -15,7 +15,12 @@ description:
 
 properties:
   compatible:
-    const: renesas,r9a09g057-usb2phy-reset     # RZ/V2H(P)
+    oneOf:
+      - items:
+          - const: renesas,r9a09g056-usb2phy-reset # RZ/V2N
+          - const: renesas,r9a09g057-usb2phy-reset
+
+      - const: renesas,r9a09g057-usb2phy-reset # RZ/V2H(P)
 
   reg:
     maxItems: 1
-- 
2.51.0


