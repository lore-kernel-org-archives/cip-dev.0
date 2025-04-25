Return-Path: <prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27293C369D1
	for <webhook@archiver.kernel.org>; Fri, 25 Apr 2025 12:15:29 +0000 (UTC)
Received: from relmlie5.idc.renesas.com (relmlie5.idc.renesas.com [210.160.252.171])
 by mx.groups.io with SMTP id smtpd.web11.5130.1745583323721116342
 for <cip-dev@lists.cip-project.org>;
 Fri, 25 Apr 2025 05:15:25 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: bp.renesas.com, ip: 210.160.252.171, mailfrom: prabhakar.mahadev-lad.rj@bp.renesas.com)
X-CSE-ConnectionGUID: dzA1BWPGRqqA/mwEZPK6hA==
X-CSE-MsgGUID: v3YWZ8HPReOujLdLa152Ug==
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie5.idc.renesas.com with ESMTP; 25 Apr 2025 21:15:25 +0900
Received: from Ubuntu-22.. (unknown [10.226.92.1])
	by relmlir6.idc.renesas.com (Postfix) with ESMTP id B70D342D7EFB;
	Fri, 25 Apr 2025 21:15:23 +0900 (JST)
From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
Cc: Biju Das <biju.das.jz@bp.renesas.com>,
	Fabrizio Castro <fabrizio.castro.jz@renesas.com>
Subject: [PATCH 6.1.y-cip 17/21] dt-bindings: mmc: renesas,sdhi: Remove duplicate compatible and add clock checks
Date: Fri, 25 Apr 2025 13:14:41 +0100
Message-ID: <20250425121445.62818-18-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250425121445.62818-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20250425121445.62818-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 25 Apr 2025 12:15:29 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/18639

commit fcd56ecaadc88b26fefebf3fb6a1787ac1d059e2 upstream.

Remove the duplicate compatible entry `renesas,sdhi-r9a09g057` and add a
restriction for clocks and clock-names for the RZ/V2H(P) SoC, which has
four clocks similar to the RZ/G2L SoC.

Reported-by: Geert Uytterhoeven <geert@linux-m68k.org>
Fixes: 32842af74abc ("dt-bindings: mmc: renesas,sdhi: Document RZ/V2H(P) support")
Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Link: https://lore.kernel.org/r/20240805211257.61099-1-prabhakar.mahadev-lad.rj@bp.renesas.com
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
 Documentation/devicetree/bindings/mmc/renesas,sdhi.yaml | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/mmc/renesas,sdhi.yaml b/Documentation/devicetree/bindings/mmc/renesas,sdhi.yaml
index a2f9ce57e98e4..653832d4f32bb 100644
--- a/Documentation/devicetree/bindings/mmc/renesas,sdhi.yaml
+++ b/Documentation/devicetree/bindings/mmc/renesas,sdhi.yaml
@@ -65,7 +65,6 @@ properties:
               - renesas,sdhi-r9a07g054 # RZ/V2L
               - renesas,sdhi-r9a08g045 # RZ/G3S
               - renesas,sdhi-r9a09g011 # RZ/V2M
-              - renesas,sdhi-r9a09g057 # RZ/V2H(P)
           - const: renesas,rzg2l-sdhi
 
   reg:
@@ -118,7 +117,9 @@ allOf:
       properties:
         compatible:
           contains:
-            const: renesas,rzg2l-sdhi
+            enum:
+              - renesas,sdhi-r9a09g057
+              - renesas,rzg2l-sdhi
     then:
       properties:
         clocks:
-- 
2.43.0


