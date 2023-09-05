Return-Path: <biju.das.jz@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E66FCA0FF8
	for <webhook@archiver.kernel.org>; Tue,  5 Sep 2023 16:07:53 +0000 (UTC)
Received: from relmlie5.idc.renesas.com (relmlie5.idc.renesas.com [210.160.252.171])
 by mx.groups.io with SMTP id smtpd.web10.25749.1693930062988095764
 for <cip-dev@lists.cip-project.org>;
 Tue, 05 Sep 2023 09:07:45 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: bp.renesas.com, ip: 210.160.252.171, mailfrom: biju.das.jz@bp.renesas.com)
X-IronPort-AV: E=Sophos;i="6.02,229,1688396400"; 
   d="scan'208";a="175102506"
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie5.idc.renesas.com with ESMTP; 06 Sep 2023 01:07:45 +0900
Received: from localhost.localdomain (unknown [10.226.92.194])
	by relmlir6.idc.renesas.com (Postfix) with ESMTP id 9B709401CC94;
	Wed,  6 Sep 2023 01:07:43 +0900 (JST)
From: Biju Das <biju.das.jz@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
Cc: Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH 6.1.y-cip 02/20] dt-bindings: display: bridge: renesas,rzg2l-mipi-dsi: Document RZ/V2L support
Date: Tue,  5 Sep 2023 17:07:19 +0100
Message-Id: <20230905160737.167877-3-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230905160737.167877-1-biju.das.jz@bp.renesas.com>
References: <20230905160737.167877-1-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 05 Sep 2023 16:07:53 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/12944

commit ae5a8dce3c86c1ea8e17910c3836b92a406f9ad8 upstream.

Document RZ/V2L DSI bindings. RZ/V2L MIPI DSI is identical to one found on
the RZ/G2L SoC. No driver changes are required as generic compatible
string "renesas,rzg2l-mipi-dsi" will be used as a fallback.

Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
Link: https://patchwork.freedesktop.org/patch/msgid/20221122195413.1882486-1-biju.das.jz@bp.renesas.com
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
 .../devicetree/bindings/display/bridge/renesas,dsi.yaml          | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/display/bridge/renesas,dsi.yaml b/Documentation/devicetree/bindings/display/bridge/renesas,dsi.yaml
index 131d5b63ec4f..e08c24633926 100644
--- a/Documentation/devicetree/bindings/display/bridge/renesas,dsi.yaml
+++ b/Documentation/devicetree/bindings/display/bridge/renesas,dsi.yaml
@@ -22,6 +22,7 @@ properties:
     items:
       - enum:
           - renesas,r9a07g044-mipi-dsi # RZ/G2{L,LC}
+          - renesas,r9a07g054-mipi-dsi # RZ/V2L
       - const: renesas,rzg2l-mipi-dsi
 
   reg:
-- 
2.25.1


