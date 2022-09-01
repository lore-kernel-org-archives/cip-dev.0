Return-Path: <biju.das.jz@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E926AECAAD1
	for <webhook@archiver.kernel.org>; Thu,  1 Sep 2022 08:01:51 +0000 (UTC)
Received: from relmlie5.idc.renesas.com (relmlie5.idc.renesas.com
 [210.160.252.171])
 by mx.groups.io with SMTP id smtpd.web12.9600.1662019306016221734
 for <cip-dev@lists.cip-project.org>;
 Thu, 01 Sep 2022 01:01:48 -0700
Authentication-Results: mx.groups.io;
 dkim=missing;
 spf=pass (domain: bp.renesas.com, ip: 210.160.252.171,
 mailfrom: biju.das.jz@bp.renesas.com)
X-IronPort-AV: E=Sophos;i="5.93,280,1654527600";
   d="scan'208";a="131322128"
Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie5.idc.renesas.com with ESMTP; 01 Sep 2022 17:01:48 +0900
Received: from localhost.localdomain (unknown [10.226.92.226])
	by relmlir5.idc.renesas.com (Postfix) with ESMTP id 0BD87400BBF1;
	Thu,  1 Sep 2022 17:01:45 +0900 (JST)
From: Biju Das <biju.das.jz@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
Cc: Chris Paterson <chris.paterson2@renesas.com>,
	Biju Das <biju.das.jz@bp.renesas.com>,
	Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH 5.10.y-cip 05/13] dt-bindings: phy: renesas,usb2-phy: Document
 RZ/G2UL phy bindings
Date: Thu,  1 Sep 2022 09:01:20 +0100
Message-Id: <20220901080128.2147891-6-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220901080128.2147891-1-biju.das.jz@bp.renesas.com>
References: <20220901080128.2147891-1-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 01 Sep 2022 08:01:51 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/9409

commit bc055a50a8594a634e09a7286601d0d2bd51c734 upstream.

Document USB phy bindings for RZ/G2UL SoC. RZ/G2UL USB phy is identical to
one found on the RZ/G2L SoC. No driver changes are required as generic
compatible string "renesas,rzg2l-usb2-phy" will be used as a fallback.

Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Link: https://lore.kernel.org/r/20220423134752.143090-1-biju.das.jz@bp.renesas.com
Signed-off-by: Vinod Koul <vkoul@kernel.org>
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
 Documentation/devicetree/bindings/phy/renesas,usb2-phy.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/phy/renesas,usb2-phy.yaml b/Documentation/devicetree/bindings/phy/renesas,usb2-phy.yaml
index 7c2ae65f3121..349c48fabb0a 100644
--- a/Documentation/devicetree/bindings/phy/renesas,usb2-phy.yaml
+++ b/Documentation/devicetree/bindings/phy/renesas,usb2-phy.yaml
@@ -32,6 +32,7 @@ properties:
 
       - items:
           - enum:
+              - renesas,usb2-phy-r9a07g043 # RZ/G2UL
               - renesas,usb2-phy-r9a07g044 # RZ/G2{L,LC}
               - renesas,usb2-phy-r9a07g054 # RZ/V2L
           - const: renesas,rzg2l-usb2-phy
-- 
2.25.1


