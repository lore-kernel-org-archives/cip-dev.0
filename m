Return-Path: <biju.das.jz@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D40BC10DC3
	for <webhook@archiver.kernel.org>; Thu,  7 Dec 2023 14:25:28 +0000 (UTC)
Received: from relmlie6.idc.renesas.com (relmlie6.idc.renesas.com [210.160.252.172])
 by mx.groups.io with SMTP id smtpd.web11.85049.1701959121278922354
 for <cip-dev@lists.cip-project.org>;
 Thu, 07 Dec 2023 06:25:21 -0800
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: bp.renesas.com, ip: 210.160.252.172, mailfrom: biju.das.jz@bp.renesas.com)
X-IronPort-AV: E=Sophos;i="6.04,256,1695654000"; 
   d="scan'208";a="189546038"
Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie6.idc.renesas.com with ESMTP; 07 Dec 2023 23:25:20 +0900
Received: from localhost.localdomain (unknown [10.226.93.153])
	by relmlir5.idc.renesas.com (Postfix) with ESMTP id 19A4140104D1;
	Thu,  7 Dec 2023 23:25:18 +0900 (JST)
From: Biju Das <biju.das.jz@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
Cc: Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH 5.10.y-cip 07/25] dt-bindings: display: bridge: renesas,rzg2l-mipi-dsi: Document RZ/V2L support
Date: Thu,  7 Dec 2023 14:24:44 +0000
Message-Id: <20231207142502.401651-8-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231207142502.401651-1-biju.das.jz@bp.renesas.com>
References: <20231207142502.401651-1-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 07 Dec 2023 14:25:28 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/13880

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


