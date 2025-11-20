Return-Path: <ovidiu.panait.rb@renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2BDA9CF9C51
	for <webhook@archiver.kernel.org>; Thu, 20 Nov 2025 16:57:47 +0000 (UTC)
Received: from relmlie6.idc.renesas.com (relmlie6.idc.renesas.com [210.160.252.172])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.1333.1763657858995004721
 for <cip-dev@lists.cip-project.org>;
 Thu, 20 Nov 2025 08:57:39 -0800
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: renesas.com, ip: 210.160.252.172, mailfrom: ovidiu.panait.rb@renesas.com)
X-CSE-ConnectionGUID: W3kvGvS8RPqcCyMy1Sjqmw==
X-CSE-MsgGUID: 0AfjHqQtSJuR6izkF+TR/Q==
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie6.idc.renesas.com with ESMTP; 21 Nov 2025 01:57:38 +0900
Received: from vm01.adwin.renesas.com (unknown [10.226.93.111])
	by relmlir6.idc.renesas.com (Postfix) with ESMTP id F00EE405D4C7;
	Fri, 21 Nov 2025 01:57:36 +0900 (JST)
From: Ovidiu Panait <ovidiu.panait.rb@renesas.com>
To: cip-dev@lists.cip-project.org,
	pavel@denx.de,
	nobuhiro1.iwamatsu@toshiba.co.jp
Subject: [PATCH 6.1.y-cip 5/9] dt-bindings: phy: renesas,usb2-phy: Document RZ/V2H(P) SoC
Date: Thu, 20 Nov 2025 16:57:22 +0000
Message-ID: <20251120165726.18296-6-ovidiu.panait.rb@renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251120165726.18296-1-ovidiu.panait.rb@renesas.com>
References: <20251120165726.18296-1-ovidiu.panait.rb@renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 20 Nov 2025 16:57:47 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/20642

From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

commit 9c4fbefc962dd13694b4a5051f432ed435c92220 upstream.

Document USB2.0 phy bindings for RZ/V2H(P) ("R9A09gG57") SoC.

RZ/V2H(P) USB2.0 phy is similar to one found on the RZ/G2L SoC, but it
needs additional configuration to be done as compared RZ/G2L USB2.0 phy.
To handle this difference a SoC specific compat string is added for
RZ/V2H(P) SoC.

Like the RZ/G2L SoC, the RZ/V2H(P) USB2.0 PHY requires the `resets`
property and has two clocks.

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Acked-by: Rob Herring (Arm) <robh@kernel.org>
Link: https://lore.kernel.org/r/20250414145729.343133-3-prabhakar.mahadev-lad.rj@bp.renesas.com
Signed-off-by: Vinod Koul <vkoul@kernel.org>
Signed-off-by: Ovidiu Panait <ovidiu.panait.rb@renesas.com>
---
 .../devicetree/bindings/phy/renesas,usb2-phy.yaml         | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/phy/renesas,usb2-phy.yaml b/Documentation/devicetree/bindings/phy/renesas,usb2-phy.yaml
index af9ed41c00c5..131314066e3a 100644
--- a/Documentation/devicetree/bindings/phy/renesas,usb2-phy.yaml
+++ b/Documentation/devicetree/bindings/phy/renesas,usb2-phy.yaml
@@ -13,7 +13,9 @@ properties:
   compatible:
     oneOf:
       - items:
-          - const: renesas,usb2-phy-r8a77470 # RZ/G1C
+          - enum:
+              - renesas,usb2-phy-r8a77470 # RZ/G1C
+              - renesas,usb2-phy-r9a09g057 # RZ/V2H(P)
 
       - items:
           - enum:
@@ -103,7 +105,9 @@ allOf:
       properties:
         compatible:
           contains:
-            const: renesas,rzg2l-usb2-phy
+            enum:
+              - renesas,usb2-phy-r9a09g057
+              - renesas,rzg2l-usb2-phy
     then:
       properties:
         clocks:
-- 
2.51.0


