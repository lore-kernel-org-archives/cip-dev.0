Return-Path: <prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03DD6C433FE
	for <webhook@archiver.kernel.org>; Mon, 10 Jan 2022 12:23:41 +0000 (UTC)
Received: from relmlie5.idc.renesas.com (relmlie5.idc.renesas.com
 [210.160.252.171])
 by mx.groups.io with SMTP id smtpd.web09.30862.1641817419552871493
 for <cip-dev@lists.cip-project.org>;
 Mon, 10 Jan 2022 04:23:39 -0800
Authentication-Results: mx.groups.io;
 dkim=missing;
 spf=pass (domain: bp.renesas.com, ip: 210.160.252.171,
 mailfrom: prabhakar.mahadev-lad.rj@bp.renesas.com)
X-IronPort-AV: E=Sophos;i="5.88,276,1635174000";
   d="scan'208";a="106011118"
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie5.idc.renesas.com with ESMTP; 10 Jan 2022 21:23:38 +0900
Received: from localhost.localdomain (unknown [10.226.36.204])
	by relmlir6.idc.renesas.com (Postfix) with ESMTP id B629C42AC9EE;
	Mon, 10 Jan 2022 21:23:37 +0900 (JST)
From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
Cc: Biju Das <biju.das.jz@bp.renesas.com>
Subject: [PATCH 5.10.y-cip 04/61] dt-bindings: net: renesas,etheravb: Drop
 "int_" prefix and "_n" suffix from interrupt names
Date: Mon, 10 Jan 2022 12:22:34 +0000
Message-Id: <20220110122331.24114-5-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220110122331.24114-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20220110122331.24114-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 10 Jan 2022 12:23:41 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/7369

From: Biju Das <biju.das.jz@bp.renesas.com>

commit b6c2052a90cece5e2887c6e6c59e985cb2546a60 upstream.

This patch updates interrupt-names with dropping "int_" prefix and
"_n" suffix.

Fixes: 1dbd981fcf2a ("dt-bindings: net: renesas,etheravb: Document Gigabit Ethernet IP")
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
Link: https://lore.kernel.org/r/20210815133926.22860-1-biju.das.jz@bp.renesas.com
Signed-off-by: Rob Herring <robh@kernel.org>
Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
 Documentation/devicetree/bindings/net/renesas,etheravb.yaml | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/net/renesas,etheravb.yaml b/Documentation/devicetree/bindings/net/renesas,etheravb.yaml
index ce4f816f0769..5237949cfabe 100644
--- a/Documentation/devicetree/bindings/net/renesas,etheravb.yaml
+++ b/Documentation/devicetree/bindings/net/renesas,etheravb.yaml
@@ -153,8 +153,8 @@ allOf:
           minItems: 1
           items:
             - const: mux
-            - const: int_fil_n
-            - const: int_arp_ns_n
+            - const: fil
+            - const: arp_ns
         rx-internal-delay-ps: false
     else:
       properties:
-- 
2.17.1


