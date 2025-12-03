Return-Path: <ovidiu.panait.rb@renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CAE4BD15D94
	for <webhook@archiver.kernel.org>; Wed,  3 Dec 2025 15:38:07 +0000 (UTC)
Received: from relmlie5.idc.renesas.com (relmlie5.idc.renesas.com [210.160.252.171])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.18205.1764776281542836390
 for <cip-dev@lists.cip-project.org>;
 Wed, 03 Dec 2025 07:38:07 -0800
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: renesas.com, ip: 210.160.252.171, mailfrom: ovidiu.panait.rb@renesas.com)
X-CSE-ConnectionGUID: hYkWnKMKSualETvvnOnpDQ==
X-CSE-MsgGUID: ZcPk/PCTRCOkZSKgPJM/Tw==
Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie5.idc.renesas.com with ESMTP; 04 Dec 2025 00:38:06 +0900
Received: from vm01.adwin.renesas.com (unknown [10.226.93.82])
	by relmlir5.idc.renesas.com (Postfix) with ESMTP id 9B5DB401008C;
	Thu,  4 Dec 2025 00:38:05 +0900 (JST)
From: Ovidiu Panait <ovidiu.panait.rb@renesas.com>
To: cip-dev@lists.cip-project.org,
	pavel@denx.de,
	nobuhiro.iwamatsu.x90@mail.toshiba
Subject: [PATCH 6.1.y-cip 04/12] dt-bindings: soc: renesas: Document SYS for RZ/V2N SoC
Date: Wed,  3 Dec 2025 15:37:49 +0000
Message-ID: <20251203153757.32977-5-ovidiu.panait.rb@renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251203153757.32977-1-ovidiu.panait.rb@renesas.com>
References: <20251203153757.32977-1-ovidiu.panait.rb@renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 03 Dec 2025 15:38:07 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/20817

From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

commit dc7af24bd60bdced496d03473e67ce5eb51236a5 upstream.

Add the RZ/V2N (R9A09G056) variant to the existing RZ/V2H(P) System
Controller (SYS) binding, as both IPs are very similar.

However, they have different SoC IDs, and the RZ/V2N does not have
PCIE1 configuration registers, unlike the RZ/V2H(P) SYS IP. To handle
these differences, introduce a new compatible string
`renesas,r9a09g056-sys`.

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Acked-by: Rob Herring (Arm) <robh@kernel.org>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Link: https://lore.kernel.org/20250407191628.323613-4-prabhakar.mahadev-lad.rj@bp.renesas.com
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
[OP: used "enum" to match mainline code]
Signed-off-by: Ovidiu Panait <ovidiu.panait.rb@renesas.com>
---
 .../bindings/soc/renesas/renesas,r9a09g057-sys.yaml          | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/soc/renesas/renesas,r9a09g057-sys.yaml b/Documentation/devicetree/bindings/soc/renesas/renesas,r9a09g057-sys.yaml
index ebbf0c9109ce..8d91466170e5 100644
--- a/Documentation/devicetree/bindings/soc/renesas/renesas,r9a09g057-sys.yaml
+++ b/Documentation/devicetree/bindings/soc/renesas/renesas,r9a09g057-sys.yaml
@@ -22,7 +22,10 @@ description: |
 
 properties:
   compatible:
-    const: renesas,r9a09g057-sys
+    items:
+      - enum:
+          - renesas,r9a09g056-sys # RZ/V2N
+          - renesas,r9a09g057-sys # RZ/V2H
 
   reg:
     maxItems: 1
-- 
2.51.0


