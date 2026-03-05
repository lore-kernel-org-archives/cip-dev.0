Return-Path: <ovidiu.panait.rb@renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 225FBF3D315
	for <webhook@archiver.kernel.org>; Thu,  5 Mar 2026 15:37:40 +0000 (UTC)
Received: from relmlie5.idc.renesas.com (relmlie5.idc.renesas.com [210.160.252.171])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.47087.1772725050959639303
 for <cip-dev@lists.cip-project.org>;
 Thu, 05 Mar 2026 07:37:33 -0800
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: renesas.com, ip: 210.160.252.171, mailfrom: ovidiu.panait.rb@renesas.com)
X-CSE-ConnectionGUID: BceV+l07SuylYP0HWeQkIg==
X-CSE-MsgGUID: OxDmq4s/QT2Hq8VuoPjWoA==
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie5.idc.renesas.com with ESMTP; 06 Mar 2026 00:37:33 +0900
Received: from vm01.adwin.renesas.com (unknown [10.226.92.133])
	by relmlir6.idc.renesas.com (Postfix) with ESMTP id 4EC9D400D14F;
	Fri,  6 Mar 2026 00:37:32 +0900 (JST)
From: Ovidiu Panait <ovidiu.panait.rb@renesas.com>
To: cip-dev@lists.cip-project.org,
	pavel@nabladev.com,
	nobuhiro.iwamatsu.x90@mail.toshiba
Subject: [PATCH 6.12.y-cip 3/8] media: dt-bindings: media: renesas,vsp1: Document RZ/V2N SoC
Date: Thu,  5 Mar 2026 15:37:20 +0000
Message-ID: <20260305153725.19821-4-ovidiu.panait.rb@renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260305153725.19821-1-ovidiu.panait.rb@renesas.com>
References: <20260305153725.19821-1-ovidiu.panait.rb@renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 05 Mar 2026 15:37:40 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/22092

From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

commit 2632f288ab1180c42c9379893357b8b7744fbf92 upstream.

The VSPD block on the RZ/V2N SoC is identical to the one found on the
RZ/G2L SoC.

No driver changes are required, as `renesas,r9a07g044-vsp2` will be used
as a fallback compatible string on the RZ/V2N SoC.

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Reviewed-by: Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>
Reviewed-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Acked-by: Rob Herring (Arm) <robh@kernel.org>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Link: https://lore.kernel.org/r/20250530154148.374663-3-prabhakar.mahadev-lad.rj@bp.renesas.com
Signed-off-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Signed-off-by: Hans Verkuil <hverkuil@xs4all.nl>
Signed-off-by: Ovidiu Panait <ovidiu.panait.rb@renesas.com>
---
 Documentation/devicetree/bindings/media/renesas,vsp1.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/media/renesas,vsp1.yaml b/Documentation/devicetree/bindings/media/renesas,vsp1.yaml
index 9d03b972f522..722ae14718e0 100644
--- a/Documentation/devicetree/bindings/media/renesas,vsp1.yaml
+++ b/Documentation/devicetree/bindings/media/renesas,vsp1.yaml
@@ -25,6 +25,7 @@ properties:
           - enum:
               - renesas,r9a07g043u-vsp2   # RZ/G2UL
               - renesas,r9a07g054-vsp2    # RZ/V2L
+              - renesas,r9a09g056-vsp2    # RZ/V2N
               - renesas,r9a09g057-vsp2    # RZ/V2H(P)
           - const: renesas,r9a07g044-vsp2 # RZ/G2L fallback
 
-- 
2.34.1


