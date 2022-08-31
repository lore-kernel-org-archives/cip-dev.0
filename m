Return-Path: <biju.das.jz@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E815C3DA6B
	for <webhook@archiver.kernel.org>; Wed, 31 Aug 2022 16:37:57 +0000 (UTC)
Received: from relmlie5.idc.renesas.com (relmlie5.idc.renesas.com
 [210.160.252.171])
 by mx.groups.io with SMTP id smtpd.web09.1115.1661963874579244480
 for <cip-dev@lists.cip-project.org>;
 Wed, 31 Aug 2022 09:37:56 -0700
Authentication-Results: mx.groups.io;
 dkim=missing;
 spf=pass (domain: bp.renesas.com, ip: 210.160.252.171,
 mailfrom: biju.das.jz@bp.renesas.com)
X-IronPort-AV: E=Sophos;i="5.93,278,1654527600";
   d="scan'208";a="131239760"
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie5.idc.renesas.com with ESMTP; 01 Sep 2022 01:37:56 +0900
Received: from localhost.localdomain (unknown [10.226.92.133])
	by relmlir6.idc.renesas.com (Postfix) with ESMTP id 9F2D540213FF;
	Thu,  1 Sep 2022 01:37:53 +0900 (JST)
From: Biju Das <biju.das.jz@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
Cc: Chris Paterson <chris.paterson2@renesas.com>,
	Biju Das <biju.das.jz@bp.renesas.com>,
	Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH 5.10.y-cip 05/10] dt-bindings: pinctrl: renesas: Document
 RZ/G2UL pinctrl
Date: Wed, 31 Aug 2022 17:37:30 +0100
Message-Id: <20220831163735.2112470-6-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220831163735.2112470-1-biju.das.jz@bp.renesas.com>
References: <20220831163735.2112470-1-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 31 Aug 2022 16:37:57 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/9354

commit 74273035c7e486fa046ee7f80fbdb9c19169ef19 upstream.

Document Renesas RZ/G2UL pinctrl bindings. RZ/G2UL GPIO block is
almost identical to RZ/G2L and has lesser pins compared to RZ/G2L.

Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
Reviewed-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Acked-by: Rob Herring <robh@kernel.org>
Link: https://lore.kernel.org/r/20220315152717.20045-1-biju.das.jz@bp.renesas.com
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
 .../devicetree/bindings/pinctrl/renesas,rzg2l-pinctrl.yaml   | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/pinctrl/renesas,rzg2l-pinctrl.yaml b/Documentation/devicetree/bindings/pinctrl/renesas,rzg2l-pinctrl.yaml
index e4849a3680e0..6bc9c5ebbdb1 100644
--- a/Documentation/devicetree/bindings/pinctrl/renesas,rzg2l-pinctrl.yaml
+++ b/Documentation/devicetree/bindings/pinctrl/renesas,rzg2l-pinctrl.yaml
@@ -11,8 +11,8 @@ maintainers:
   - Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
 
 description:
-  The Renesas SoCs of the RZ/{G2L,V2L} series feature a combined Pin and GPIO
-  controller.
+  The Renesas SoCs of the RZ/{G2L,V2L} alike series feature a combined Pin and
+  GPIO controller.
   Pin multiplexing and GPIO configuration is performed on a per-pin basis.
   Each port features up to 8 pins, each of them configurable for GPIO function
   (port mode) or in alternate function mode.
@@ -23,6 +23,7 @@ properties:
     oneOf:
       - items:
           - enum:
+              - renesas,r9a07g043-pinctrl # RZ/G2UL{Type-1,Type-2}
               - renesas,r9a07g044-pinctrl # RZ/G2{L,LC}
 
       - items:
-- 
2.25.1


