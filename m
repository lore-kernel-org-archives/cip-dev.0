Return-Path: <ovidiu.panait.rb@renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86B97D2A005
	for <webhook@archiver.kernel.org>; Wed, 14 Jan 2026 12:53:34 +0000 (UTC)
Received: from relmlie5.idc.renesas.com (relmlie5.idc.renesas.com [210.160.252.171])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.9224.1768395211508826985
 for <cip-dev@lists.cip-project.org>;
 Wed, 14 Jan 2026 04:53:31 -0800
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: renesas.com, ip: 210.160.252.171, mailfrom: ovidiu.panait.rb@renesas.com)
X-CSE-ConnectionGUID: tL1BgmkQQF61mFHC18IBHg==
X-CSE-MsgGUID: t/UDIgjwQgm/Z5lTdwoGOA==
Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie5.idc.renesas.com with ESMTP; 14 Jan 2026 21:53:30 +0900
Received: from vm01.adwin.renesas.com (unknown [10.226.92.8])
	by relmlir5.idc.renesas.com (Postfix) with ESMTP id 588C240029CF;
	Wed, 14 Jan 2026 21:53:29 +0900 (JST)
From: Ovidiu Panait <ovidiu.panait.rb@renesas.com>
To: cip-dev@lists.cip-project.org,
	pavel@nabladev.com,
	nobuhiro.iwamatsu.x90@mail.toshiba
Subject: [PATCH 6.1.y-cip 2/4] dt-bindings: i2c: renesas,riic: Document RZ/V2N (R9A09G056) support
Date: Wed, 14 Jan 2026 12:53:22 +0000
Message-ID: <20260114125324.8630-3-ovidiu.panait.rb@renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260114125324.8630-1-ovidiu.panait.rb@renesas.com>
References: <20260114125324.8630-1-ovidiu.panait.rb@renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 14 Jan 2026 12:53:34 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/21549

From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

commit 8b284979f7fb2f1acfd88a6b96c8863c410eb27f upstream.

Document support for the I2C Bus Interface (RIIC) found on the Renesas
RZ/V2N (R9A09G056) SoC. The RIIC IP is identical to that on RZ/V2H(P),
so `renesas,riic-r9a09g057` will be used as a fallback compatible,
enabling reuse of the existing driver without changes.

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Reviewed-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Link: https://lore.kernel.org/r/20250501203310.140137-1-prabhakar.mahadev-lad.rj@bp.renesas.com
Signed-off-by: Andi Shyti <andi.shyti@kernel.org>
Signed-off-by: Ovidiu Panait <ovidiu.panait.rb@renesas.com>
---
 Documentation/devicetree/bindings/i2c/renesas,riic.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/i2c/renesas,riic.yaml b/Documentation/devicetree/bindings/i2c/renesas,riic.yaml
index 7656c6d8ded1..50a55a61d0fc 100644
--- a/Documentation/devicetree/bindings/i2c/renesas,riic.yaml
+++ b/Documentation/devicetree/bindings/i2c/renesas,riic.yaml
@@ -29,6 +29,7 @@ properties:
           - enum:
               - renesas,riic-r9a08g045   # RZ/G3S
               - renesas,riic-r9a09g047   # RZ/G3E
+              - renesas,riic-r9a09g056   # RZ/V2N
           - const: renesas,riic-r9a09g057   # RZ/V2H(P)
 
       - const: renesas,riic-r9a09g057   # RZ/V2H(P)
-- 
2.51.0


