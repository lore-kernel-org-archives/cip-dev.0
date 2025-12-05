Return-Path: <prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C539CD32D6E
	for <webhook@archiver.kernel.org>; Fri,  5 Dec 2025 14:33:31 +0000 (UTC)
Received: from relmlie5.idc.renesas.com (relmlie5.idc.renesas.com [210.160.252.171])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.7063.1764945182570660387
 for <cip-dev@lists.cip-project.org>;
 Fri, 05 Dec 2025 06:33:24 -0800
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: bp.renesas.com, ip: 210.160.252.171, mailfrom: prabhakar.mahadev-lad.rj@bp.renesas.com)
X-CSE-ConnectionGUID: V44ngjD1QVmuO6QIpbtXUw==
X-CSE-MsgGUID: BVaX43KcRheANFtLI5LviQ==
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie5.idc.renesas.com with ESMTP; 05 Dec 2025 23:33:23 +0900
Received: from Ubuntu-22.. (unknown [10.24.1.60])
	by relmlir6.idc.renesas.com (Postfix) with ESMTP id 8E3654179CE0;
	Fri,  5 Dec 2025 23:33:22 +0900 (JST)
From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
Cc: Biju Das <biju.das.jz@bp.renesas.com>
Subject: [PATCH 6.12.y-cip 13/38] dt-bindings: soc: renesas: Document RZ/N2H (R9A09G087) SoC
Date: Fri,  5 Dec 2025 14:32:33 +0000
Message-ID: <20251205143258.13748-14-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251205143258.13748-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20251205143258.13748-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 05 Dec 2025 14:33:31 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/20927

From: Paul Barker <paul.barker.ct@bp.renesas.com>

commit b59b3f68822eb52d1864d1bde92a932ff9bdf295 upstream.

Add RZ/N2H (R9A09G087), its variants, and the rzn2h-evk evaluation board
in documentation.

Signed-off-by: Paul Barker <paul.barker.ct@bp.renesas.com>
Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Acked-by: Conor Dooley <conor.dooley@microchip.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Link: https://lore.kernel.org/20250609203656.333138-2-prabhakar.mahadev-lad.rj@bp.renesas.com
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
 .../devicetree/bindings/soc/renesas/renesas.yaml       | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/Documentation/devicetree/bindings/soc/renesas/renesas.yaml b/Documentation/devicetree/bindings/soc/renesas/renesas.yaml
index 878498b18a4bd..35d405931d998 100644
--- a/Documentation/devicetree/bindings/soc/renesas/renesas.yaml
+++ b/Documentation/devicetree/bindings/soc/renesas/renesas.yaml
@@ -577,6 +577,16 @@ properties:
               - renesas,r9a09g077m44 # RZ/T2H with Quad Cortex-A55 + Dual Cortex-R52 - no security
           - const: renesas,r9a09g077
 
+      - description: RZ/N2H (R9A09G087)
+        items:
+          - enum:
+              - renesas,rzn2h-evk # RZ/N2H Evaluation Board (RTK9RZN2H0S00000BJ)
+          - enum:
+              - renesas,r9a09g087m04 # RZ/N2H with Single Cortex-A55 + Dual Cortex-R52 - no security
+              - renesas,r9a09g087m24 # RZ/N2H with Dual Cortex-A55 + Dual Cortex-R52 - no security
+              - renesas,r9a09g087m44 # RZ/N2H with Quad Cortex-A55 + Dual Cortex-R52 - no security
+          - const: renesas,r9a09g087
+
 additionalProperties: true
 
 ...
-- 
2.43.0


