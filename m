Return-Path: <prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27258C369C2
	for <webhook@archiver.kernel.org>; Fri, 25 Apr 2025 12:15:29 +0000 (UTC)
Received: from relmlie6.idc.renesas.com (relmlie6.idc.renesas.com [210.160.252.172])
 by mx.groups.io with SMTP id smtpd.web11.5125.1745583308658722051
 for <cip-dev@lists.cip-project.org>;
 Fri, 25 Apr 2025 05:15:19 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: bp.renesas.com, ip: 210.160.252.172, mailfrom: prabhakar.mahadev-lad.rj@bp.renesas.com)
X-CSE-ConnectionGUID: ir9zJ5ACQSuBSY9efcZWeQ==
X-CSE-MsgGUID: 9Y4Hjm6PSw2BjzraYeCGig==
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie6.idc.renesas.com with ESMTP; 25 Apr 2025 21:15:18 +0900
Received: from Ubuntu-22.. (unknown [10.226.92.1])
	by relmlir6.idc.renesas.com (Postfix) with ESMTP id 34B7842D7EC8;
	Fri, 25 Apr 2025 21:15:16 +0900 (JST)
From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
Cc: Biju Das <biju.das.jz@bp.renesas.com>,
	Fabrizio Castro <fabrizio.castro.jz@renesas.com>
Subject: [PATCH 6.1.y-cip 14/21] dt-bindings: mmc: renesas,sdhi: Document RZ/G2L family compatibility
Date: Fri, 25 Apr 2025 13:14:38 +0100
Message-ID: <20250425121445.62818-15-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250425121445.62818-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20250425121445.62818-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 25 Apr 2025 12:15:29 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/18636

commit d640af49b65c6d260a5154dfb822e8371b502707 upstream.

- RZ/G2UL and RZ/Five ("r9a07g043")
- RZ/G2L(C) ("r9a07g044")
- RZ/V2L ("r9a07g054")
- RZ/G3S ("r9a08g045")
- RZ/V2M ("r9a09g011")

The SD/MMC Interface in the above listed SoCs is not identical to that of
R-Car Gen3. These SoCs have HS400 disabled and use fixed address mode.
Therefore, we need to apply fixed_addr_mode and hs400_disabled quirks.

Document 'renesas,rzg2l-sdhi' as a generic compatible string for the
above SoCs.

Also now use the 'renesas,rzg2l-sdhi' string in the if check for making
sure the required clocks are present.

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Link: https://lore.kernel.org/r/20240430145937.133643-3-prabhakar.mahadev-lad.rj@bp.renesas.com
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
[PL: manually applied the changes]
Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
 .../devicetree/bindings/mmc/renesas,sdhi.yaml | 19 +++++++++----------
 1 file changed, 9 insertions(+), 10 deletions(-)

diff --git a/Documentation/devicetree/bindings/mmc/renesas,sdhi.yaml b/Documentation/devicetree/bindings/mmc/renesas,sdhi.yaml
index 3b7f057bf294d..6b692a86900c7 100644
--- a/Documentation/devicetree/bindings/mmc/renesas,sdhi.yaml
+++ b/Documentation/devicetree/bindings/mmc/renesas,sdhi.yaml
@@ -51,17 +51,20 @@ properties:
               - renesas,sdhi-r8a77980  # R-Car V3H
               - renesas,sdhi-r8a77990  # R-Car E3
               - renesas,sdhi-r8a77995  # R-Car D3
-              - renesas,sdhi-r9a07g043 # RZ/G2UL and RZ/Five
-              - renesas,sdhi-r9a07g044 # RZ/G2{L,LC}
-              - renesas,sdhi-r9a07g054 # RZ/V2L
-              - renesas,sdhi-r9a08g045 # RZ/G3S
-              - renesas,sdhi-r9a09g011 # RZ/V2M
           - const: renesas,rcar-gen3-sdhi # R-Car Gen3 or RZ/G2
       - items:
           - enum:
               - renesas,sdhi-r8a779a0  # R-Car V3U
               - renesas,sdhi-r8a779f0  # R-Car S4-8
           - const: renesas,rcar-gen4-sdhi # R-Car Gen4
+      - items:
+          - enum:
+              - renesas,sdhi-r9a07g043 # RZ/G2UL and RZ/Five
+              - renesas,sdhi-r9a07g044 # RZ/G2{L,LC}
+              - renesas,sdhi-r9a07g054 # RZ/V2L
+              - renesas,sdhi-r9a08g045 # RZ/G3S
+              - renesas,sdhi-r9a09g011 # RZ/V2M
+          - const: renesas,rzg2l-sdhi
 
   reg:
     maxItems: 1
@@ -113,11 +116,7 @@ allOf:
       properties:
         compatible:
           contains:
-            enum:
-              - renesas,sdhi-r9a07g043
-              - renesas,sdhi-r9a07g044
-              - renesas,sdhi-r9a07g054
-              - renesas,sdhi-r9a08g045
+            const: renesas,rzg2l-sdhi
     then:
       properties:
         clocks:
-- 
2.43.0


