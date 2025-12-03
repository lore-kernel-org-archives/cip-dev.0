Return-Path: <ovidiu.panait.rb@renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DCD8DD15D9F
	for <webhook@archiver.kernel.org>; Wed,  3 Dec 2025 15:41:07 +0000 (UTC)
Received: from relmlie6.idc.renesas.com (relmlie6.idc.renesas.com [210.160.252.172])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.18297.1764776463748732008
 for <cip-dev@lists.cip-project.org>;
 Wed, 03 Dec 2025 07:41:04 -0800
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: renesas.com, ip: 210.160.252.172, mailfrom: ovidiu.panait.rb@renesas.com)
X-CSE-ConnectionGUID: 1LIrV0aiQR+fXVaJ/xT4GQ==
X-CSE-MsgGUID: 4ObF91ZyRMSgJ+5BKMnffg==
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie6.idc.renesas.com with ESMTP; 04 Dec 2025 00:41:03 +0900
Received: from vm01.adwin.renesas.com (unknown [10.226.93.82])
	by relmlir6.idc.renesas.com (Postfix) with ESMTP id 0AEA3400CD06;
	Thu,  4 Dec 2025 00:41:01 +0900 (JST)
From: Ovidiu Panait <ovidiu.panait.rb@renesas.com>
To: cip-dev@lists.cip-project.org,
	pavel@denx.de,
	nobuhiro.iwamatsu.x90@mail.toshiba
Subject: [PATCH 6.12.y-cip 01/11] dt-bindings: soc: renesas: Document Renesas RZ/V2N SoC variants and EVK
Date: Wed,  3 Dec 2025 15:40:48 +0000
Message-ID: <20251203154058.33022-2-ovidiu.panait.rb@renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251203154058.33022-1-ovidiu.panait.rb@renesas.com>
References: <20251203154058.33022-1-ovidiu.panait.rb@renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 03 Dec 2025 15:41:07 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/20827

From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

commit abc43c0f3c3eaa7470004e4e8a190a57c612a686 upstream.

Document the Renesas RZ/V2N (R9A09G056) SoC variants, distinguishing
between configurations with and without specific hardware features such
as GPU, ISP, and cryptographic extensions. Also, document the
"renesas,rzv2n-evk" compatible string for the RZ/V2N EVK board.

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Link: https://lore.kernel.org/20250407191628.323613-2-prabhakar.mahadev-lad.rj@bp.renesas.com
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Ovidiu Panait <ovidiu.panait.rb@renesas.com>
---
 .../devicetree/bindings/soc/renesas/renesas.yaml  | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/Documentation/devicetree/bindings/soc/renesas/renesas.yaml b/Documentation/devicetree/bindings/soc/renesas/renesas.yaml
index 8e47f36bf4fd..467bf01bc12d 100644
--- a/Documentation/devicetree/bindings/soc/renesas/renesas.yaml
+++ b/Documentation/devicetree/bindings/soc/renesas/renesas.yaml
@@ -525,6 +525,21 @@ properties:
               - renesas,rzv2mevk2   # RZ/V2M Eval Board v2.0
           - const: renesas,r9a09g011
 
+      - description: RZ/V2N (R9A09G056)
+        items:
+          - enum:
+              - renesas,rzv2n-evk # RZ/V2N EVK (RTK0EF0186C03000BJ)
+          - enum:
+              - renesas,r9a09g056n41 # RZ/V2N
+              - renesas,r9a09g056n42 # RZ/V2N with Mali-G31 support
+              - renesas,r9a09g056n43 # RZ/V2N with Mali-C55 support
+              - renesas,r9a09g056n44 # RZ/V2N with Mali-G31 + Mali-C55 support
+              - renesas,r9a09g056n45 # RZ/V2N with cryptographic extension support
+              - renesas,r9a09g056n46 # RZ/V2N with Mali-G31 + cryptographic extension support
+              - renesas,r9a09g056n47 # RZ/V2N with Mali-C55 + cryptographic extension support
+              - renesas,r9a09g056n48 # RZ/V2N with Mali-G31 + Mali-C55 + cryptographic extension support
+          - const: renesas,r9a09g056
+
       - description: RZ/V2H(P) (R9A09G057)
         items:
           - enum:
-- 
2.51.0


