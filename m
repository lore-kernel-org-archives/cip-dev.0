Return-Path: <ovidiu.panait.rb@renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16EDAF41816
	for <webhook@archiver.kernel.org>; Tue, 10 Mar 2026 16:01:01 +0000 (UTC)
Received: from relmlie5.idc.renesas.com (relmlie5.idc.renesas.com [210.160.252.171])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.43710.1773158455808667489
 for <cip-dev@lists.cip-project.org>;
 Tue, 10 Mar 2026 09:00:56 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: renesas.com, ip: 210.160.252.171, mailfrom: ovidiu.panait.rb@renesas.com)
X-CSE-ConnectionGUID: QLUo7cKHR+SUH6eGpoBwSw==
X-CSE-MsgGUID: 4Lt0d1L6TVO5gh9wKJ86XQ==
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie5.idc.renesas.com with ESMTP; 11 Mar 2026 01:00:55 +0900
Received: from vm01.adwin.renesas.com (unknown [10.226.92.14])
	by relmlir6.idc.renesas.com (Postfix) with ESMTP id CB6604019133;
	Wed, 11 Mar 2026 01:00:53 +0900 (JST)
From: Ovidiu Panait <ovidiu.panait.rb@renesas.com>
To: cip-dev@lists.cip-project.org,
	pavel@nabladev.com,
	nobuhiro.iwamatsu.x90@mail.toshiba
Subject: [PATCH 6.12.y-cip 1/5] dt-bindings: interrupt-controller: renesas,rzv2h-icu: Document RZ/V2N SoC
Date: Tue, 10 Mar 2026 16:00:46 +0000
Message-ID: <20260310160050.40977-2-ovidiu.panait.rb@renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260310160050.40977-1-ovidiu.panait.rb@renesas.com>
References: <20260310160050.40977-1-ovidiu.panait.rb@renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 10 Mar 2026 16:01:01 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/22236

From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

commit c71869c61d7cf2070421cdcc4dd64c4c860df49d upstream.

Document the Interrupt Control Unit (ICU) used on the Renesas RZ/V2N SoC.

Although the ICU closely matches the design found on the RZ/V2H(P) family,
it differs in its register layout, particularly in the reduced set of
ECCRAM related registers. These variations require a distinct compatible
string so that software can correctly match and handle the RZ/V2N
implementation.

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Acked-by: Conor Dooley <conor.dooley@microchip.com>
Link: https://patch.msgid.link/20251127162447.320971-2-prabhakar.mahadev-lad.rj@bp.renesas.com
Signed-off-by: Ovidiu Panait <ovidiu.panait.rb@renesas.com>
---
 .../bindings/interrupt-controller/renesas,rzv2h-icu.yaml         | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/interrupt-controller/renesas,rzv2h-icu.yaml b/Documentation/devicetree/bindings/interrupt-controller/renesas,rzv2h-icu.yaml
index 3f99c8645767..cb244b8f5e1c 100644
--- a/Documentation/devicetree/bindings/interrupt-controller/renesas,rzv2h-icu.yaml
+++ b/Documentation/devicetree/bindings/interrupt-controller/renesas,rzv2h-icu.yaml
@@ -22,6 +22,7 @@ properties:
   compatible:
     enum:
       - renesas,r9a09g047-icu # RZ/G3E
+      - renesas,r9a09g056-icu # RZ/V2N
       - renesas,r9a09g057-icu # RZ/V2H(P)
 
   '#interrupt-cells':
-- 
2.51.0


