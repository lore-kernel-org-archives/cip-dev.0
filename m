Return-Path: <prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE25DC433F5
	for <webhook@archiver.kernel.org>; Wed, 30 Mar 2022 18:55:45 +0000 (UTC)
Received: from relmlie6.idc.renesas.com (relmlie6.idc.renesas.com
 [210.160.252.172])
 by mx.groups.io with SMTP id smtpd.web10.2188.1648666538384202756
 for <cip-dev@lists.cip-project.org>;
 Wed, 30 Mar 2022 11:55:44 -0700
Authentication-Results: mx.groups.io;
 dkim=missing;
 spf=pass (domain: bp.renesas.com, ip: 210.160.252.172,
 mailfrom: prabhakar.mahadev-lad.rj@bp.renesas.com)
X-IronPort-AV: E=Sophos;i="5.90,223,1643641200";
   d="scan'208";a="116211155"
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie6.idc.renesas.com with ESMTP; 31 Mar 2022 03:55:44 +0900
Received: from localhost.localdomain (unknown [10.226.36.204])
	by relmlir6.idc.renesas.com (Postfix) with ESMTP id 3AB9340D4D0B;
	Thu, 31 Mar 2022 03:55:43 +0900 (JST)
From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
Cc: Biju Das <biju.das.jz@bp.renesas.com>
Subject: [PATCH 5.10.y-cip 36/39] dt-bindings: mmc: renesas,sdhi: Rename
 RZ/G2L clocks
Date: Wed, 30 Mar 2022 19:54:51 +0100
Message-Id: <20220330185454.10887-37-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220330185454.10887-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20220330185454.10887-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 30 Mar 2022 18:55:45 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/7887

From: Biju Das <biju.das.jz@bp.renesas.com>

commit 217c7d1840b5377543eff84fe28409d0bd4d3433 upstream.

Rename the below RZ/G2L clocks to match with the clock names used in
R-Car Gen2 and later generations.

 imclk->core
 clk_hs->clkh
 imclk2->cd

This changes will avoid using fallback for RZ/G2L high speed clock,
if "clkh" is not used in device tree and also the code changes in
driver related to this clocks.

Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
Reviewed-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
Acked-by: Ulf Hansson <ulf.hansson@linaro.org>
Link: https://lore.kernel.org/r/20211122103905.14439-2-biju.das.jz@bp.renesas.com
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
 .../devicetree/bindings/mmc/renesas,sdhi.yaml          | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/Documentation/devicetree/bindings/mmc/renesas,sdhi.yaml b/Documentation/devicetree/bindings/mmc/renesas,sdhi.yaml
index c20ee9e5b8e8..3aeff9036628 100644
--- a/Documentation/devicetree/bindings/mmc/renesas,sdhi.yaml
+++ b/Documentation/devicetree/bindings/mmc/renesas,sdhi.yaml
@@ -112,17 +112,17 @@ allOf:
         clocks:
           items:
             - description: IMCLK, SDHI channel main clock1.
+            - description: CLK_HS, SDHI channel High speed clock which operates
+                           4 times that of SDHI channel main clock1.
             - description: IMCLK2, SDHI channel main clock2. When this clock is
                            turned off, external SD card detection cannot be
                            detected.
-            - description: CLK_HS, SDHI channel High speed clock which operates
-                           4 times that of SDHI channel main clock1.
             - description: ACLK, SDHI channel bus clock.
         clock-names:
           items:
-            - const: imclk
-            - const: imclk2
-            - const: clk_hs
+            - const: core
+            - const: clkh
+            - const: cd
             - const: aclk
       required:
         - clock-names
-- 
2.17.1


