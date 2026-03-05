Return-Path: <ovidiu.panait.rb@renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DC06F3D30B
	for <webhook@archiver.kernel.org>; Thu,  5 Mar 2026 15:36:39 +0000 (UTC)
Received: from relmlie6.idc.renesas.com (relmlie6.idc.renesas.com [210.160.252.172])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.47080.1772724990120566597
 for <cip-dev@lists.cip-project.org>;
 Thu, 05 Mar 2026 07:36:30 -0800
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: renesas.com, ip: 210.160.252.172, mailfrom: ovidiu.panait.rb@renesas.com)
X-CSE-ConnectionGUID: TtVGIsr5Qg6YpWNom1eOwQ==
X-CSE-MsgGUID: tktQZRnaRKODu6QYtWTnPg==
Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie6.idc.renesas.com with ESMTP; 06 Mar 2026 00:36:29 +0900
Received: from vm01.adwin.renesas.com (unknown [10.226.92.133])
	by relmlir5.idc.renesas.com (Postfix) with ESMTP id 1D46740138D9;
	Fri,  6 Mar 2026 00:36:27 +0900 (JST)
From: Ovidiu Panait <ovidiu.panait.rb@renesas.com>
To: cip-dev@lists.cip-project.org,
	pavel@nabladev.com,
	nobuhiro.iwamatsu.x90@mail.toshiba
Subject: [PATCH 6.1.y-cip 1/8] media: dt-bindings: media: renesas,fcp: Document RZ/V2N SoC
Date: Thu,  5 Mar 2026 15:36:17 +0000
Message-ID: <20260305153624.19793-2-ovidiu.panait.rb@renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260305153624.19793-1-ovidiu.panait.rb@renesas.com>
References: <20260305153624.19793-1-ovidiu.panait.rb@renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 05 Mar 2026 15:36:39 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/22081

From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

commit f42eddf44fbfc8c00b2ffb7779a8c11cf92d2b29 upstream.

The FCPVD block on the RZ/V2N SoC is identical to the one found on the
RZ/G2L SoC.

No driver changes are required, as `renesas,fcpv` will be used as a
fallback compatible string on the RZ/V2N SoC.

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Acked-by: Rob Herring (Arm) <robh@kernel.org>
Reviewed-by: Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>
Reviewed-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Link: https://lore.kernel.org/r/20250530154148.374663-2-prabhakar.mahadev-lad.rj@bp.renesas.com
Signed-off-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Signed-off-by: Hans Verkuil <hverkuil@xs4all.nl>
Signed-off-by: Ovidiu Panait <ovidiu.panait.rb@renesas.com>
---
 Documentation/devicetree/bindings/media/renesas,fcp.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/media/renesas,fcp.yaml b/Documentation/devicetree/bindings/media/renesas,fcp.yaml
index 5ed9427fb757..074be99ca004 100644
--- a/Documentation/devicetree/bindings/media/renesas,fcp.yaml
+++ b/Documentation/devicetree/bindings/media/renesas,fcp.yaml
@@ -30,6 +30,7 @@ properties:
               - renesas,r9a07g043u-fcpvd # RZ/G2UL
               - renesas,r9a07g044-fcpvd # RZ/G2{L,LC}
               - renesas,r9a07g054-fcpvd # RZ/V2L
+              - renesas,r9a09g056-fcpvd # RZ/V2N
               - renesas,r9a09g057-fcpvd # RZ/V2H(P)
           - const: renesas,fcpv         # Generic FCP for VSP fallback
 
-- 
2.34.1


