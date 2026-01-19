Return-Path: <ovidiu.panait.rb@renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3333D489AD
	for <webhook@archiver.kernel.org>; Mon, 19 Jan 2026 12:52:00 +0000 (UTC)
Received: from relmlie5.idc.renesas.com (relmlie5.idc.renesas.com [210.160.252.171])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.34129.1768827113902196955
 for <cip-dev@lists.cip-project.org>;
 Mon, 19 Jan 2026 04:51:57 -0800
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: renesas.com, ip: 210.160.252.171, mailfrom: ovidiu.panait.rb@renesas.com)
X-CSE-ConnectionGUID: 9NRJWneKTlmG15+jY7fSKQ==
X-CSE-MsgGUID: FjpPcWQHRKma1hduDdQGYg==
Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie5.idc.renesas.com with ESMTP; 19 Jan 2026 21:51:56 +0900
Received: from vm01.adwin.renesas.com (unknown [10.226.92.25])
	by relmlir5.idc.renesas.com (Postfix) with ESMTP id 97194401BC13;
	Mon, 19 Jan 2026 21:51:55 +0900 (JST)
From: Ovidiu Panait <ovidiu.panait.rb@renesas.com>
To: cip-dev@lists.cip-project.org,
	pavel@nabladev.com,
	nobuhiro.iwamatsu.x90@mail.toshiba
Subject: [PATCH 6.12.y-cip 4/6] dt-bindings: phy: renesas,usb2-phy: Document RZ/V2N SoC support
Date: Mon, 19 Jan 2026 12:51:45 +0000
Message-ID: <20260119125147.32175-5-ovidiu.panait.rb@renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260119125147.32175-1-ovidiu.panait.rb@renesas.com>
References: <20260119125147.32175-1-ovidiu.panait.rb@renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 19 Jan 2026 12:52:00 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/21656

From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

commit 00399bbe02d2bb6fd8d6eb90573ec305616449f4 upstream.

Document support for the USB2.0 phy found on the Renesas RZ/V2N
(R9A09G056) SoC. The USB2.0 phy is functionally identical to that on the
RZ/V2H(P) SoC, so no driver changes are needed. The existing
`renesas,usb2-phy-r9a09g057` compatible will be used as a fallback
for the RZ/V2N SoC.

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Acked-by: Conor Dooley <conor.dooley@microchip.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Link: https://lore.kernel.org/r/20250528133858.168582-1-prabhakar.mahadev-lad.rj@bp.renesas.com
Signed-off-by: Vinod Koul <vkoul@kernel.org>
Signed-off-by: Ovidiu Panait <ovidiu.panait.rb@renesas.com>
---
 Documentation/devicetree/bindings/phy/renesas,usb2-phy.yaml | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/devicetree/bindings/phy/renesas,usb2-phy.yaml b/Documentation/devicetree/bindings/phy/renesas,usb2-phy.yaml
index 2822dce8d9f4..f45c5f039ae8 100644
--- a/Documentation/devicetree/bindings/phy/renesas,usb2-phy.yaml
+++ b/Documentation/devicetree/bindings/phy/renesas,usb2-phy.yaml
@@ -40,6 +40,10 @@ properties:
               - renesas,usb2-phy-r9a07g054 # RZ/V2L
           - const: renesas,rzg2l-usb2-phy
 
+      - items:
+          - const: renesas,usb2-phy-r9a09g056 # RZ/V2N
+          - const: renesas,usb2-phy-r9a09g057
+
   reg:
     maxItems: 1
 
-- 
2.51.0


