Return-Path: <ovidiu.panait.rb@renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7487D15D96
	for <webhook@archiver.kernel.org>; Wed,  3 Dec 2025 15:38:17 +0000 (UTC)
Received: from relmlie5.idc.renesas.com (relmlie5.idc.renesas.com [210.160.252.171])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.18205.1764776281542836390
 for <cip-dev@lists.cip-project.org>;
 Wed, 03 Dec 2025 07:38:10 -0800
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: renesas.com, ip: 210.160.252.171, mailfrom: ovidiu.panait.rb@renesas.com)
X-CSE-ConnectionGUID: TR7kMISYSfuhjU7FIOHRww==
X-CSE-MsgGUID: nWP7zRNsSq2VodbgBO0g5w==
Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie5.idc.renesas.com with ESMTP; 04 Dec 2025 00:38:10 +0900
Received: from vm01.adwin.renesas.com (unknown [10.226.93.82])
	by relmlir5.idc.renesas.com (Postfix) with ESMTP id 25BB8401008C;
	Thu,  4 Dec 2025 00:38:08 +0900 (JST)
From: Ovidiu Panait <ovidiu.panait.rb@renesas.com>
To: cip-dev@lists.cip-project.org,
	pavel@denx.de,
	nobuhiro.iwamatsu.x90@mail.toshiba
Subject: [PATCH 6.1.y-cip 06/12] dt-bindings: serial: renesas: Document RZ/V2N SCIF
Date: Wed,  3 Dec 2025 15:37:51 +0000
Message-ID: <20251203153757.32977-7-ovidiu.panait.rb@renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251203153757.32977-1-ovidiu.panait.rb@renesas.com>
References: <20251203153757.32977-1-ovidiu.panait.rb@renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 03 Dec 2025 15:38:17 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/20819

From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

commit 5eb2d4b3e9a19f08e0ccbb81e0fbfa61de229345 upstream.

Document SCIF bindings for the Renesas RZ/V2N (a.k.a R9A09G056) SoC.
The SCIF interface in Renesas RZ/V2N is identical to the one available
in RZ/V2H(P), so `renesas,scif-r9a09g057` will be used as a fallback,
allowing reuse of the existing driver without modifications.

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Acked-by: "Rob Herring (Arm)" <robh@kernel.org>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Link: https://lore.kernel.org/r/20250716202923.163950-1-prabhakar.mahadev-lad.rj@bp.renesas.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Ovidiu Panait <ovidiu.panait.rb@renesas.com>
---
 Documentation/devicetree/bindings/serial/renesas,scif.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/serial/renesas,scif.yaml b/Documentation/devicetree/bindings/serial/renesas,scif.yaml
index 8fb7fcc99720..cc651fa7e946 100644
--- a/Documentation/devicetree/bindings/serial/renesas,scif.yaml
+++ b/Documentation/devicetree/bindings/serial/renesas,scif.yaml
@@ -83,6 +83,7 @@ properties:
       - items:
           - enum:
               - renesas,scif-r9a09g047      # RZ/G3E
+              - renesas,scif-r9a09g056      # RZ/V2N
           - const: renesas,scif-r9a09g057   # RZ/V2H fallback
 
   reg:
-- 
2.51.0


