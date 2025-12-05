Return-Path: <prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87D9BD2F7F8
	for <webhook@archiver.kernel.org>; Fri,  5 Dec 2025 14:33:11 +0000 (UTC)
Received: from relmlie6.idc.renesas.com (relmlie6.idc.renesas.com [210.160.252.172])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.6916.1764945183459164227
 for <cip-dev@lists.cip-project.org>;
 Fri, 05 Dec 2025 06:33:08 -0800
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: bp.renesas.com, ip: 210.160.252.172, mailfrom: prabhakar.mahadev-lad.rj@bp.renesas.com)
X-CSE-ConnectionGUID: 9x0z6nYMRTe3WuJRyrCTZA==
X-CSE-MsgGUID: RnzMA85nRC2H+TghIh6H+g==
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie6.idc.renesas.com with ESMTP; 05 Dec 2025 23:33:07 +0900
Received: from Ubuntu-22.. (unknown [10.24.1.60])
	by relmlir6.idc.renesas.com (Postfix) with ESMTP id 8ED1B4179CE0;
	Fri,  5 Dec 2025 23:33:06 +0900 (JST)
From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
Cc: Biju Das <biju.das.jz@bp.renesas.com>
Subject: [PATCH 6.12.y-cip 04/38] dt-bindings: serial: renesas,rsci: Document RZ/N2H support
Date: Fri,  5 Dec 2025 14:32:24 +0000
Message-ID: <20251205143258.13748-5-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251205143258.13748-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20251205143258.13748-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 05 Dec 2025 14:33:11 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/20918

commit 7dfd023dc7a9050554b28a16a31b8b06f76bb862 upstream.

Add documentation for the serial communication interface (RSCI) found on
the Renesas RZ/N2H (R9A09G087) SoC. The RSCI IP on this SoC is identical
to that on the RZ/T2H (R9A09G077) SoC. Therefore, "renesas,r9a09g077-rsci"
is used as a fallback compatible string for RZ/N2H.

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Acked-by: Conor Dooley <conor.dooley@microchip.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Link: https://lore.kernel.org/r/20250609192344.293317-1-prabhakar.mahadev-lad.rj@bp.renesas.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
 .../devicetree/bindings/serial/renesas,rsci.yaml          | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/serial/renesas,rsci.yaml b/Documentation/devicetree/bindings/serial/renesas,rsci.yaml
index 548225e509e51..f50d8e02f4764 100644
--- a/Documentation/devicetree/bindings/serial/renesas,rsci.yaml
+++ b/Documentation/devicetree/bindings/serial/renesas,rsci.yaml
@@ -15,7 +15,13 @@ allOf:
 
 properties:
   compatible:
-    const: renesas,r9a09g077-rsci      # RZ/T2H
+    oneOf:
+      - items:
+          - const: renesas,r9a09g087-rsci # RZ/N2H
+          - const: renesas,r9a09g077-rsci # RZ/T2H
+
+      - items:
+          - const: renesas,r9a09g077-rsci # RZ/T2H
 
   reg:
     maxItems: 1
-- 
2.43.0


