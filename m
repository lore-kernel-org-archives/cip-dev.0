Return-Path: <prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD4EFC433F5
	for <webhook@archiver.kernel.org>; Wed, 30 Mar 2022 18:55:39 +0000 (UTC)
Received: from relmlie6.idc.renesas.com (relmlie6.idc.renesas.com
 [210.160.252.172])
 by mx.groups.io with SMTP id smtpd.web10.2188.1648666538384202756
 for <cip-dev@lists.cip-project.org>;
 Wed, 30 Mar 2022 11:55:38 -0700
Authentication-Results: mx.groups.io;
 dkim=missing;
 spf=pass (domain: bp.renesas.com, ip: 210.160.252.172,
 mailfrom: prabhakar.mahadev-lad.rj@bp.renesas.com)
X-IronPort-AV: E=Sophos;i="5.90,223,1643641200";
   d="scan'208";a="116211145"
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie6.idc.renesas.com with ESMTP; 31 Mar 2022 03:55:37 +0900
Received: from localhost.localdomain (unknown [10.226.36.204])
	by relmlir6.idc.renesas.com (Postfix) with ESMTP id BFB7840D5446;
	Thu, 31 Mar 2022 03:55:36 +0900 (JST)
From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
Cc: Biju Das <biju.das.jz@bp.renesas.com>
Subject: [PATCH 5.10.y-cip 31/39] dt-bindings: Fix errors in 'if' schemas
Date: Wed, 30 Mar 2022 19:54:46 +0100
Message-Id: <20220330185454.10887-32-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220330185454.10887-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20220330185454.10887-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 30 Mar 2022 18:55:39 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/7882

From: Rob Herring <robh@kernel.org>

commit 9183908e70e913d2db052588172968da55d82af5 upstream.

Properties in if/then schemas weren't getting checked by the meta-schemas.
Enabling meta-schema checks finds several errors.

The use of an 'items' schema (as opposed to the list form) is wrong in
some cases as it applies to all entries. 'contains' is the correct schema
to use in the case of multiple entries.

Cc: Herbert Xu <herbert@gondor.apana.org.au>
Cc: "David S. Miller" <davem@davemloft.net>
Cc: Chen-Yu Tsai <wens@csie.org>
Cc: Eric Anholt <eric@anholt.net>
Cc: Florian Fainelli <f.fainelli@gmail.com>
Cc: Ray Jui <rjui@broadcom.com>
Cc: Scott Branden <sbranden@broadcom.com>
Cc: Pavel Machek <pavel@ucw.cz>
Cc: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Kishon Vijay Abraham I <kishon@ti.com>
Cc: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: Linus Walleij <linus.walleij@linaro.org>
Cc: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: linux-crypto@vger.kernel.org
Cc: dri-devel@lists.freedesktop.org
Cc: linux-leds@vger.kernel.org
Cc: linux-mmc@vger.kernel.org
Cc: linux-gpio@vger.kernel.org
Acked-by: Maxime Ripard <mripard@kernel.org>
Acked-By: Vinod Koul <vkoul@kernel.org>
Reviewed-by: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
Acked-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Rob Herring <robh@kernel.org>
Link: https://lore.kernel.org/r/20210202205544.24812-3-robh@kernel.org
[PL: Only applied changes to renesas,sdhi.yaml]
Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
 Documentation/devicetree/bindings/mmc/renesas,sdhi.yaml | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/mmc/renesas,sdhi.yaml b/Documentation/devicetree/bindings/mmc/renesas,sdhi.yaml
index 6bbf29b5c239..6c13703b31db 100644
--- a/Documentation/devicetree/bindings/mmc/renesas,sdhi.yaml
+++ b/Documentation/devicetree/bindings/mmc/renesas,sdhi.yaml
@@ -123,7 +123,7 @@ required:
 if:
   properties:
     compatible:
-      items:
+      contains:
         enum:
           - renesas,sdhi-r7s72100
           - renesas,sdhi-r7s9210
-- 
2.17.1


