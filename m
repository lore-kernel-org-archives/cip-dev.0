Return-Path: <ovidiu.panait.rb@renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98B0DF3D30A
	for <webhook@archiver.kernel.org>; Thu,  5 Mar 2026 15:36:39 +0000 (UTC)
Received: from relmlie5.idc.renesas.com (relmlie5.idc.renesas.com [210.160.252.171])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.47078.1772724989045585994
 for <cip-dev@lists.cip-project.org>;
 Thu, 05 Mar 2026 07:36:31 -0800
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: renesas.com, ip: 210.160.252.171, mailfrom: ovidiu.panait.rb@renesas.com)
X-CSE-ConnectionGUID: nx4pJutCTWOUVREsRlmn7g==
X-CSE-MsgGUID: xjF2jmBsR22XHhOnTIuRIQ==
Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie5.idc.renesas.com with ESMTP; 06 Mar 2026 00:36:31 +0900
Received: from vm01.adwin.renesas.com (unknown [10.226.92.133])
	by relmlir5.idc.renesas.com (Postfix) with ESMTP id DD9B340172F3;
	Fri,  6 Mar 2026 00:36:29 +0900 (JST)
From: Ovidiu Panait <ovidiu.panait.rb@renesas.com>
To: cip-dev@lists.cip-project.org,
	pavel@nabladev.com,
	nobuhiro.iwamatsu.x90@mail.toshiba
Subject: [PATCH 6.1.y-cip 2/8] media: dt-bindings: media: renesas,fcp: Allow three clocks for RZ/V2N SoC
Date: Thu,  5 Mar 2026 15:36:18 +0000
Message-ID: <20260305153624.19793-3-ovidiu.panait.rb@renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260305153624.19793-1-ovidiu.panait.rb@renesas.com>
References: <20260305153624.19793-1-ovidiu.panait.rb@renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 05 Mar 2026 15:36:39 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/22082

From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

commit ae8694393e13f563209fad681e5bc1b99d558646 upstream.

Update the FCP DT schema to permit three clock inputs for the RZ/V2N SoC.
The FCP block on this SoC requires three separate clocks, unlike other
variants which use only one.

Fixes: f42eddf44fbf ("media: dt-bindings: media: renesas,fcp: Document RZ/V2N SoC")
Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Reviewed-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Acked-by: Conor Dooley <conor.dooley@microchip.com>
Link: https://patch.msgid.link/20251103194554.54313-1-prabhakar.mahadev-lad.rj@bp.renesas.com
Signed-off-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Signed-off-by: Hans Verkuil <hverkuil+cisco@kernel.org>
Signed-off-by: Ovidiu Panait <ovidiu.panait.rb@renesas.com>
---
 Documentation/devicetree/bindings/media/renesas,fcp.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/media/renesas,fcp.yaml b/Documentation/devicetree/bindings/media/renesas,fcp.yaml
index 074be99ca004..947c5d00088e 100644
--- a/Documentation/devicetree/bindings/media/renesas,fcp.yaml
+++ b/Documentation/devicetree/bindings/media/renesas,fcp.yaml
@@ -68,6 +68,7 @@ allOf:
               - renesas,r9a07g043u-fcpvd
               - renesas,r9a07g044-fcpvd
               - renesas,r9a07g054-fcpvd
+              - renesas,r9a09g056-fcpvd
               - renesas,r9a09g057-fcpvd
     then:
       properties:
-- 
2.34.1


