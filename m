Return-Path: <ovidiu.panait.rb@renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FB54CFA747
	for <webhook@archiver.kernel.org>; Fri, 21 Nov 2025 08:07:04 +0000 (UTC)
Received: from relmlie5.idc.renesas.com (relmlie5.idc.renesas.com [210.160.252.171])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.7319.1763712417689384723
 for <cip-dev@lists.cip-project.org>;
 Fri, 21 Nov 2025 00:06:58 -0800
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: renesas.com, ip: 210.160.252.171, mailfrom: ovidiu.panait.rb@renesas.com)
X-CSE-ConnectionGUID: PyN/A3+cQgiCIp2ZryhEVQ==
X-CSE-MsgGUID: GEHPC57PQ2uXdU2C5GFaSw==
Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie5.idc.renesas.com with ESMTP; 21 Nov 2025 17:06:57 +0900
Received: from vm01.adwin.renesas.com (unknown [10.226.93.111])
	by relmlir5.idc.renesas.com (Postfix) with ESMTP id F1FAA437D117;
	Fri, 21 Nov 2025 17:06:55 +0900 (JST)
From: Ovidiu Panait <ovidiu.panait.rb@renesas.com>
To: cip-dev@lists.cip-project.org,
	pavel@denx.de,
	nobuhiro.iwamatsu.x90@mail.toshiba
Subject: [PATCH 6.1.y-cip 4/6] dt-bindings: memory: renesas,rzg3e-xspi: Document RZ/V2H(P) and RZ/V2N support
Date: Fri, 21 Nov 2025 08:06:45 +0000
Message-ID: <20251121080647.20592-5-ovidiu.panait.rb@renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251121080647.20592-1-ovidiu.panait.rb@renesas.com>
References: <20251121080647.20592-1-ovidiu.panait.rb@renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 21 Nov 2025 08:07:04 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/20665

From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

commit 93a7aedc4cc4476da54ea45f3ed5308aabafef75 upstream.

Document support for the Expanded Serial Peripheral Interface (xSPI)
controller found on the Renesas RZ/V2H(P) (R9A09G057) and RZ/V2N
(R9A09G056) SoCs.

The xSPI hardware block on these SoCs is functionally identical to the
one on the RZ/G3E (R9A09G047) SoC. Therefore, the existing driver can be
reused without modification by using `renesas,r9a09g047-xspi` as a
fallback compatible.

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Acked-by: Rob Herring (Arm) <robh@kernel.org>
Link: https://lore.kernel.org/r/20250624171605.469724-1-prabhakar.mahadev-lad.rj@bp.renesas.com
Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Signed-off-by: Ovidiu Panait <ovidiu.panait.rb@renesas.com>
---
 .../bindings/memory-controllers/renesas,rzg3e-xspi.yaml  | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/memory-controllers/renesas,rzg3e-xspi.yaml b/Documentation/devicetree/bindings/memory-controllers/renesas,rzg3e-xspi.yaml
index 2bfe63ec62dc..7a84f5bb7284 100644
--- a/Documentation/devicetree/bindings/memory-controllers/renesas,rzg3e-xspi.yaml
+++ b/Documentation/devicetree/bindings/memory-controllers/renesas,rzg3e-xspi.yaml
@@ -23,7 +23,14 @@ allOf:
 
 properties:
   compatible:
-    const: renesas,r9a09g047-xspi  # RZ/G3E
+    oneOf:
+      - const: renesas,r9a09g047-xspi  # RZ/G3E
+
+      - items:
+          - enum:
+              - renesas,r9a09g056-xspi  # RZ/V2N
+              - renesas,r9a09g057-xspi  # RZ/V2H(P)
+          - const: renesas,r9a09g047-xspi
 
   reg:
     items:
-- 
2.51.0


