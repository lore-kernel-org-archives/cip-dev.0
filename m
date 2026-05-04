Return-Path: <ovidiu.panait.rb@renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3DE23FF885A
	for <webhook@archiver.kernel.org>; Mon,  4 May 2026 06:48:13 +0000 (UTC)
Received: from relmlie5.idc.renesas.com (relmlie5.idc.renesas.com [210.160.252.171])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.9352.1777877289148751744
 for <cip-dev@lists.cip-project.org>;
 Sun, 03 May 2026 23:48:12 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: renesas.com, ip: 210.160.252.171, mailfrom: ovidiu.panait.rb@renesas.com)
X-CSE-ConnectionGUID: 92blmZdTQGSGa9U22mpuLQ==
X-CSE-MsgGUID: /ai6/8blQIqiQCrTG4izJQ==
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie5.idc.renesas.com with ESMTP; 04 May 2026 15:48:11 +0900
Received: from vm01.adwin.renesas.com (unknown [10.226.92.25])
	by relmlir6.idc.renesas.com (Postfix) with ESMTP id 7062B412435C;
	Mon,  4 May 2026 15:48:10 +0900 (JST)
From: Ovidiu Panait <ovidiu.panait.rb@renesas.com>
To: cip-dev@lists.cip-project.org,
	pavel@nabladev.com,
	nobuhiro.iwamatsu.x90@mail.toshiba
Subject: [PATCH 6.1.y-cip 3/9] dt-bindings: phy: renesas,rzg3e-usb3-phy: Add RZ/V2H(P) and RZ/V2N support
Date: Mon,  4 May 2026 06:47:57 +0000
Message-ID: <20260504064804.7021-4-ovidiu.panait.rb@renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260504064804.7021-1-ovidiu.panait.rb@renesas.com>
References: <20260504064804.7021-1-ovidiu.panait.rb@renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 04 May 2026 06:48:13 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/22840

From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

commit 8a203b0571d0a28e227dff7ab81e64cd7aa18e17 upstream.

Add compatibles for the USB3.0 PHY used in the RZ/V2H(P) and RZ/V2N SoCs.
These SoCs integrate the same USB3 PHY IP block as the RZ/G3E, so the
RZ/G3E compatible is used as a fallback for both.

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Acked-by: Krzysztof Kozlowski <krzk@kernel.org>
Link: https://patch.msgid.link/20251222161846.152952-1-prabhakar.mahadev-lad.rj@bp.renesas.com
Signed-off-by: Vinod Koul <vkoul@kernel.org>
Signed-off-by: Ovidiu Panait <ovidiu.panait.rb@renesas.com>
---
 .../devicetree/bindings/phy/renesas,rzg3e-usb3-phy.yaml  | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/phy/renesas,rzg3e-usb3-phy.yaml b/Documentation/devicetree/bindings/phy/renesas,rzg3e-usb3-phy.yaml
index b86dc7a291a4..6d97e038a927 100644
--- a/Documentation/devicetree/bindings/phy/renesas,rzg3e-usb3-phy.yaml
+++ b/Documentation/devicetree/bindings/phy/renesas,rzg3e-usb3-phy.yaml
@@ -11,7 +11,14 @@ maintainers:
 
 properties:
   compatible:
-    const: renesas,r9a09g047-usb3-phy
+    oneOf:
+      - const: renesas,r9a09g047-usb3-phy # RZ/G3E
+
+      - items:
+          - enum:
+              - renesas,r9a09g056-usb3-phy # RZ/V2N
+              - renesas,r9a09g057-usb3-phy # RZ/V2H(P)
+          - const: renesas,r9a09g047-usb3-phy
 
   reg:
     maxItems: 1
-- 
2.34.1


