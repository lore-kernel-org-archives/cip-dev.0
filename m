Return-Path: <biju.das.jz@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E185DC83F28
	for <webhook@archiver.kernel.org>; Mon, 14 Jul 2025 10:08:39 +0000 (UTC)
Received: from relmlie5.idc.renesas.com (relmlie5.idc.renesas.com [210.160.252.171])
 by mx.groups.io with SMTP id smtpd.web10.74854.1752487713503831357
 for <cip-dev@lists.cip-project.org>;
 Mon, 14 Jul 2025 03:08:39 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: bp.renesas.com, ip: 210.160.252.171, mailfrom: biju.das.jz@bp.renesas.com)
X-CSE-ConnectionGUID: 8usRwc4ASlOLygpHWmX/pg==
X-CSE-MsgGUID: VP0kaPHwRiisKT8OY00DeQ==
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie5.idc.renesas.com with ESMTP; 14 Jul 2025 19:08:39 +0900
Received: from localhost.localdomain (unknown [10.226.92.48])
	by relmlir6.idc.renesas.com (Postfix) with ESMTP id C538641D45A9;
	Mon, 14 Jul 2025 19:08:37 +0900 (JST)
From: Biju Das <biju.das.jz@bp.renesas.com>
To: Pavel Machek <pavel@denx.de>
Cc: nobuhiro1.iwamatsu@toshiba.co.jp,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	Biju Das <biju.das.jz@bp.renesas.com>,
	cip-dev@lists.cip-project.org
Subject: [PATCH 6.1.y-cip 16/57] dt-bindings: can: renesas,rcar-canfd: Document RZ/Five SoC
Date: Mon, 14 Jul 2025 11:06:57 +0100
Message-ID: <20250714100802.80035-17-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250714100802.80035-1-biju.das.jz@bp.renesas.com>
References: <20250714100802.80035-1-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 14 Jul 2025 10:08:39 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/19444

From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

commit 5237ff4e7d3d60e19c0625169361eb40cd435f6d upstream.

The CANFD block on the RZ/Five SoC is identical to one found on the
RZ/G2UL SoC. "renesas,r9a07g043-canfd" compatible string will be used
on the RZ/Five SoC so to make this clear, update the comment to include
RZ/Five SoC.

No driver changes are required as generic compatible string
"renesas,rzg2l-canfd" will be used as a fallback on RZ/Five SoC.

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Acked-by: Rob Herring <robh@kernel.org>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Link: https://lore.kernel.org/all/20221115123811.1182922-1-prabhakar.mahadev-lad.rj@bp.renesas.com
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
 .../devicetree/bindings/net/can/renesas,rcar-canfd.yaml         | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/net/can/renesas,rcar-canfd.yaml b/Documentation/devicetree/bindings/net/can/renesas,rcar-canfd.yaml
index 6f71fc96bc4e..8347053a96dc 100644
--- a/Documentation/devicetree/bindings/net/can/renesas,rcar-canfd.yaml
+++ b/Documentation/devicetree/bindings/net/can/renesas,rcar-canfd.yaml
@@ -33,7 +33,7 @@ properties:
 
       - items:
           - enum:
-              - renesas,r9a07g043-canfd    # RZ/G2UL
+              - renesas,r9a07g043-canfd    # RZ/G2UL and RZ/Five
               - renesas,r9a07g044-canfd    # RZ/G2{L,LC}
               - renesas,r9a07g054-canfd    # RZ/V2L
           - const: renesas,rzg2l-canfd     # RZ/G2L family
-- 
2.43.0


