Return-Path: <biju.das.jz@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D494CCF6D4C
	for <webhook@archiver.kernel.org>; Wed,  2 Oct 2024 17:04:42 +0000 (UTC)
Received: from relmlie5.idc.renesas.com (relmlie5.idc.renesas.com [210.160.252.171])
 by mx.groups.io with SMTP id smtpd.web10.1049.1727888664329825039
 for <cip-dev@lists.cip-project.org>;
 Wed, 02 Oct 2024 10:04:38 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: bp.renesas.com, ip: 210.160.252.171, mailfrom: biju.das.jz@bp.renesas.com)
X-IronPort-AV: E=Sophos;i="6.11,172,1725289200"; 
   d="scan'208";a="220602646"
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie5.idc.renesas.com with ESMTP; 03 Oct 2024 02:04:37 +0900
Received: from localhost.localdomain (unknown [10.226.92.106])
	by relmlir6.idc.renesas.com (Postfix) with ESMTP id C8F864024134;
	Thu,  3 Oct 2024 02:04:31 +0900 (JST)
From: Biju Das <biju.das.jz@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
Cc: Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH 6.1.y-cip 06/16] media: dt-bindings: media: renesas,vsp1: Document RZ/V2L VSPD bindings
Date: Wed,  2 Oct 2024 18:03:59 +0100
Message-ID: <20241002170417.655339-7-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241002170417.655339-1-biju.das.jz@bp.renesas.com>
References: <20241002170417.655339-1-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 02 Oct 2024 17:04:42 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/16954

commit b8c41ec1fb552a5e6c851887374e32233232302e upstream.

Document VSPD found in RZ/V2L SoC. The VSPD block is identical to RZ/G2L
SoC and therefore use RZ/G2L fallback to avoid any driver changes.

Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Hans Verkuil <hverkuil-cisco@xs4all.nl>
Signed-off-by: Mauro Carvalho Chehab <mchehab@kernel.org>
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
 .../devicetree/bindings/media/renesas,vsp1.yaml     | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/Documentation/devicetree/bindings/media/renesas,vsp1.yaml b/Documentation/devicetree/bindings/media/renesas,vsp1.yaml
index 7a8f32473852..3265e922647c 100644
--- a/Documentation/devicetree/bindings/media/renesas,vsp1.yaml
+++ b/Documentation/devicetree/bindings/media/renesas,vsp1.yaml
@@ -16,10 +16,15 @@ description:
 
 properties:
   compatible:
-    enum:
-      - renesas,r9a07g044-vsp2 # RZ/G2L
-      - renesas,vsp1 # R-Car Gen2 and RZ/G1
-      - renesas,vsp2 # R-Car Gen3 and RZ/G2
+    oneOf:
+      - enum:
+          - renesas,r9a07g044-vsp2 # RZ/G2L
+          - renesas,vsp1 # R-Car Gen2 and RZ/G1
+          - renesas,vsp2 # R-Car Gen3 and RZ/G2
+      - items:
+          - enum:
+              - renesas,r9a07g054-vsp2    # RZ/V2L
+          - const: renesas,r9a07g044-vsp2 # RZ/G2L fallback
 
   reg:
     maxItems: 1
-- 
2.43.0


