Return-Path: <ovidiu.panait.rb@renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A153F506E0
	for <webhook@archiver.kernel.org>; Mon, 16 Mar 2026 14:34:54 +0000 (UTC)
Received: from relmlie6.idc.renesas.com (relmlie6.idc.renesas.com [210.160.252.172])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.52105.1773671687639567650
 for <cip-dev@lists.cip-project.org>;
 Mon, 16 Mar 2026 07:34:47 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: renesas.com, ip: 210.160.252.172, mailfrom: ovidiu.panait.rb@renesas.com)
X-CSE-ConnectionGUID: tWdEP075Sz+3jDKEvDYyNw==
X-CSE-MsgGUID: 8cAefIQNSk2zy1uBRL/V9Q==
Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie6.idc.renesas.com with ESMTP; 16 Mar 2026 23:34:46 +0900
Received: from vm01.adwin.renesas.com (unknown [10.226.92.8])
	by relmlir5.idc.renesas.com (Postfix) with ESMTP id 8B1724006196;
	Mon, 16 Mar 2026 23:34:45 +0900 (JST)
From: Ovidiu Panait <ovidiu.panait.rb@renesas.com>
To: cip-dev@lists.cip-project.org,
	pavel@nabladev.com,
	nobuhiro.iwamatsu.x90@mail.toshiba
Subject: [PATCH 6.12.y-cip 1/3] dt-bindings: dma: rz-dmac: Document RZ/V2N SoC support
Date: Mon, 16 Mar 2026 14:34:40 +0000
Message-ID: <20260316143442.76659-2-ovidiu.panait.rb@renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260316143442.76659-1-ovidiu.panait.rb@renesas.com>
References: <20260316143442.76659-1-ovidiu.panait.rb@renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 16 Mar 2026 14:34:54 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/22389

From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

commit f94163e950c9568fe2d2d88317d9602ce021e646 upstream.

Document the DMA controller on the Renesas RZ/V2N SoC, which is
architecturally identical to the DMAC found on the RZ/V2H(P) SoC.

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Link: https://patch.msgid.link/20251125212621.267397-1-prabhakar.mahadev-lad.rj@bp.renesas.com
Signed-off-by: Vinod Koul <vkoul@kernel.org>
Signed-off-by: Ovidiu Panait <ovidiu.panait.rb@renesas.com>
---
 Documentation/devicetree/bindings/dma/renesas,rz-dmac.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/dma/renesas,rz-dmac.yaml b/Documentation/devicetree/bindings/dma/renesas,rz-dmac.yaml
index a43b6f29a688..bc1c7f64d68d 100644
--- a/Documentation/devicetree/bindings/dma/renesas,rz-dmac.yaml
+++ b/Documentation/devicetree/bindings/dma/renesas,rz-dmac.yaml
@@ -23,6 +23,7 @@ properties:
       - items:
           - enum:
               - renesas,r9a09g047-dmac # RZ/G3E
+              - renesas,r9a09g056-dmac # RZ/V2N
           - const: renesas,r9a09g057-dmac
 
       - const: renesas,r9a09g057-dmac # RZ/V2H(P)
-- 
2.34.1


