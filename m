Return-Path: <prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA551C433FE
	for <webhook@archiver.kernel.org>; Mon, 10 Jan 2022 12:23:37 +0000 (UTC)
Received: from relmlie5.idc.renesas.com (relmlie5.idc.renesas.com
 [210.160.252.171])
 by mx.groups.io with SMTP id smtpd.web08.30707.1641817416869262390
 for <cip-dev@lists.cip-project.org>;
 Mon, 10 Jan 2022 04:23:37 -0800
Authentication-Results: mx.groups.io;
 dkim=missing;
 spf=pass (domain: bp.renesas.com, ip: 210.160.252.171,
 mailfrom: prabhakar.mahadev-lad.rj@bp.renesas.com)
X-IronPort-AV: E=Sophos;i="5.88,276,1635174000";
   d="scan'208";a="106011113"
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie5.idc.renesas.com with ESMTP; 10 Jan 2022 21:23:36 +0900
Received: from localhost.localdomain (unknown [10.226.36.204])
	by relmlir6.idc.renesas.com (Postfix) with ESMTP id 2CD4142AC9F0;
	Mon, 10 Jan 2022 21:23:35 +0900 (JST)
From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
Cc: Biju Das <biju.das.jz@bp.renesas.com>
Subject: [PATCH 5.10.y-cip 02/61] dt-bindings: net: renesas,etheravb: Fix
 optional second clock name
Date: Mon, 10 Jan 2022 12:22:32 +0000
Message-Id: <20220110122331.24114-3-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220110122331.24114-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20220110122331.24114-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 10 Jan 2022 12:23:37 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/7367

From: Geert Uytterhoeven <geert+renesas@glider.be>

commit 6799e3f281e962628be531e8331bacd05b866134 upstream.

If the optional "clock-names" property is present, but the optional TXC
reference clock is not, "make dtbs_check" complains:

    ethernet@e6800000: clock-names: ['fck'] is too short

Fix this by declaring that a single clock name is valid.
While at it, drop the superfluous upper limit on the number of clocks,
as it is implied by the list of descriptions.

Fixes: 6f43735b6da64bd4 ("dt-bindings: net: renesas,etheravb: Add additional clocks")
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Link: https://lore.kernel.org/r/b3d91c9f70a15792ad19c87e4ea35fc876600fae.1620118901.git.geert+renesas@glider.be
Signed-off-by: Rob Herring <robh@kernel.org>
Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
 Documentation/devicetree/bindings/net/renesas,etheravb.yaml | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/net/renesas,etheravb.yaml b/Documentation/devicetree/bindings/net/renesas,etheravb.yaml
index 7b32363ad8b4..8d1f467c95ba 100644
--- a/Documentation/devicetree/bindings/net/renesas,etheravb.yaml
+++ b/Documentation/devicetree/bindings/net/renesas,etheravb.yaml
@@ -50,12 +50,12 @@ properties:
 
   clocks:
     minItems: 1
-    maxItems: 2
     items:
       - description: AVB functional clock
       - description: Optional TXC reference clock
 
   clock-names:
+    minItems: 1
     items:
       - const: fck
       - const: refclk
-- 
2.17.1


