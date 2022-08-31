Return-Path: <biju.das.jz@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74264ECAAD3
	for <webhook@archiver.kernel.org>; Wed, 31 Aug 2022 16:38:07 +0000 (UTC)
Received: from relmlie6.idc.renesas.com (relmlie6.idc.renesas.com
 [210.160.252.172])
 by mx.groups.io with SMTP id smtpd.web12.1115.1661963881384981563
 for <cip-dev@lists.cip-project.org>;
 Wed, 31 Aug 2022 09:38:01 -0700
Authentication-Results: mx.groups.io;
 dkim=missing;
 spf=pass (domain: bp.renesas.com, ip: 210.160.252.172,
 mailfrom: biju.das.jz@bp.renesas.com)
X-IronPort-AV: E=Sophos;i="5.93,278,1654527600";
   d="scan'208";a="133250208"
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie6.idc.renesas.com with ESMTP; 01 Sep 2022 01:37:59 +0900
Received: from localhost.localdomain (unknown [10.226.92.133])
	by relmlir6.idc.renesas.com (Postfix) with ESMTP id BA6E2402172B;
	Thu,  1 Sep 2022 01:37:56 +0900 (JST)
From: Biju Das <biju.das.jz@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
Cc: Chris Paterson <chris.paterson2@renesas.com>,
	Biju Das <biju.das.jz@bp.renesas.com>,
	Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH 5.10.y-cip 06/10] dt-bindings: serial: renesas,scif: Document
 RZ/G2UL SoC
Date: Wed, 31 Aug 2022 17:37:31 +0100
Message-Id: <20220831163735.2112470-7-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220831163735.2112470-1-biju.das.jz@bp.renesas.com>
References: <20220831163735.2112470-1-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 31 Aug 2022 16:38:07 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/9355

commit ed265bc955cfa46490d07db0bf5de985b31367da upstream.

Add SCIF binding documentation for Renesas RZ/G2UL SoC. SCIF block on
RZ/G2UL is identical to one found on the RZ/G2L SoC. No driver changes
are required as RZ/G2L compatible string "renesas,scif-r9a07g044" will
be used as a fallback.

Whilst dropped the comments after RZ/G2{L,LC} fallback as to
avoid updating the comment over and over again when a new IP
is added

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
Link: https://lore.kernel.org/r/20220207142213.19552-2-biju.das.jz@bp.renesas.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
 Documentation/devicetree/bindings/serial/renesas,scif.yaml | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/serial/renesas,scif.yaml b/Documentation/devicetree/bindings/serial/renesas,scif.yaml
index d1fd82aac212..05e037031d78 100644
--- a/Documentation/devicetree/bindings/serial/renesas,scif.yaml
+++ b/Documentation/devicetree/bindings/serial/renesas,scif.yaml
@@ -70,8 +70,9 @@ properties:
 
       - items:
           - enum:
+              - renesas,scif-r9a07g043      # RZ/G2UL
               - renesas,scif-r9a07g054      # RZ/V2L
-          - const: renesas,scif-r9a07g044   # RZ/G2{L,LC} fallback for RZ/V2L
+          - const: renesas,scif-r9a07g044   # RZ/G2{L,LC} fallback
 
   reg:
     maxItems: 1
-- 
2.25.1


