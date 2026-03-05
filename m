Return-Path: <ovidiu.panait.rb@renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 390EFF3D317
	for <webhook@archiver.kernel.org>; Thu,  5 Mar 2026 15:37:40 +0000 (UTC)
Received: from relmlie5.idc.renesas.com (relmlie5.idc.renesas.com [210.160.252.171])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.47087.1772725050959639303
 for <cip-dev@lists.cip-project.org>;
 Thu, 05 Mar 2026 07:37:35 -0800
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: renesas.com, ip: 210.160.252.171, mailfrom: ovidiu.panait.rb@renesas.com)
X-CSE-ConnectionGUID: kx5hbLdTSvSY+M1bv1KxeQ==
X-CSE-MsgGUID: fuslVuw3SnGnSfnVmTVjSg==
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie5.idc.renesas.com with ESMTP; 06 Mar 2026 00:37:35 +0900
Received: from vm01.adwin.renesas.com (unknown [10.226.92.133])
	by relmlir6.idc.renesas.com (Postfix) with ESMTP id 11BB2400D12C;
	Fri,  6 Mar 2026 00:37:33 +0900 (JST)
From: Ovidiu Panait <ovidiu.panait.rb@renesas.com>
To: cip-dev@lists.cip-project.org,
	pavel@nabladev.com,
	nobuhiro.iwamatsu.x90@mail.toshiba
Subject: [PATCH 6.12.y-cip 4/8] dt-bindings: display: renesas,rzg2l-du: Add support for RZ/V2N SoC
Date: Thu,  5 Mar 2026 15:37:21 +0000
Message-ID: <20260305153725.19821-5-ovidiu.panait.rb@renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260305153725.19821-1-ovidiu.panait.rb@renesas.com>
References: <20260305153725.19821-1-ovidiu.panait.rb@renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 05 Mar 2026 15:37:40 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/22093

From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

commit e96a7dc6de5f6c2cac8cc919584c95ae52cf1f9a upstream.

Document support for the DU IP found on the Renesas RZ/V2N (R9A09G056) SoC.
The DU IP is functionally identical to that on the RZ/V2H(P) SoC, so no
driver changes are needed. The existing `renesas,r9a09g057-du` compatible
will be used as a fallback for the RZ/V2N SoC.

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Reviewed-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Acked-by: Conor Dooley <conor.dooley@microchip.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
Link: https://patch.msgid.link/20251023213350.681602-1-prabhakar.mahadev-lad.rj@bp.renesas.com
Signed-off-by: Ovidiu Panait <ovidiu.panait.rb@renesas.com>
---
 .../devicetree/bindings/display/renesas,rzg2l-du.yaml          | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Documentation/devicetree/bindings/display/renesas,rzg2l-du.yaml b/Documentation/devicetree/bindings/display/renesas,rzg2l-du.yaml
index 1e32d14b6edb..2cc66dcef870 100644
--- a/Documentation/devicetree/bindings/display/renesas,rzg2l-du.yaml
+++ b/Documentation/devicetree/bindings/display/renesas,rzg2l-du.yaml
@@ -25,6 +25,9 @@ properties:
           - enum:
               - renesas,r9a07g054-du    # RZ/V2L
           - const: renesas,r9a07g044-du # RZ/G2L fallback
+      - items:
+          - const: renesas,r9a09g056-du # RZ/V2N
+          - const: renesas,r9a09g057-du # RZ/V2H(P) fallback
 
   reg:
     maxItems: 1
-- 
2.34.1


