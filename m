Return-Path: <biju.das.jz@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07F15ECAAD1
	for <webhook@archiver.kernel.org>; Thu,  1 Sep 2022 08:02:22 +0000 (UTC)
Received: from relmlie5.idc.renesas.com (relmlie5.idc.renesas.com
 [210.160.252.171])
 by mx.groups.io with SMTP id smtpd.web11.9633.1662019324823500464
 for <cip-dev@lists.cip-project.org>;
 Thu, 01 Sep 2022 01:02:13 -0700
Authentication-Results: mx.groups.io;
 dkim=missing;
 spf=pass (domain: bp.renesas.com, ip: 210.160.252.171,
 mailfrom: biju.das.jz@bp.renesas.com)
X-IronPort-AV: E=Sophos;i="5.93,280,1654527600";
   d="scan'208";a="131322191"
Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie5.idc.renesas.com with ESMTP; 01 Sep 2022 17:02:12 +0900
Received: from localhost.localdomain (unknown [10.226.92.226])
	by relmlir5.idc.renesas.com (Postfix) with ESMTP id 3464840083EF;
	Thu,  1 Sep 2022 17:02:09 +0900 (JST)
From: Biju Das <biju.das.jz@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
Cc: Chris Paterson <chris.paterson2@renesas.com>,
	Biju Das <biju.das.jz@bp.renesas.com>,
	Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH 5.10.y-cip 13/13] dt-bindings: reset:
 renesas,rzg2l-usbphy-ctrl: Document RZ/G2UL USBPHY Control bindings
Date: Thu,  1 Sep 2022 09:01:28 +0100
Message-Id: <20220901080128.2147891-14-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220901080128.2147891-1-biju.das.jz@bp.renesas.com>
References: <20220901080128.2147891-1-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 01 Sep 2022 08:02:22 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/9417

commit 9c68d4e621ebfc166f672fa7afe14591f91d144c upstream.

Add device tree binding document for RZ/G2UL USBPHY Control Device.
RZ/G2UL USBPHY Control Device is identical to one found on the RZ/G2L SoC.
No driver changes are required as generic compatible string
"renesas,rzg2l-usbphy-ctrl" will be used as a fallback.

Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Signed-off-by: Philipp Zabel <p.zabel@pengutronix.de>
Link: https://lore.kernel.org/r/20220423134601.141975-1-biju.das.jz@bp.renesas.com
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
 .../devicetree/bindings/reset/renesas,rzg2l-usbphy-ctrl.yaml     | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/reset/renesas,rzg2l-usbphy-ctrl.yaml b/Documentation/devicetree/bindings/reset/renesas,rzg2l-usbphy-ctrl.yaml
index 86c2569ced97..731b8ce01525 100644
--- a/Documentation/devicetree/bindings/reset/renesas,rzg2l-usbphy-ctrl.yaml
+++ b/Documentation/devicetree/bindings/reset/renesas,rzg2l-usbphy-ctrl.yaml
@@ -17,6 +17,7 @@ properties:
   compatible:
     items:
       - enum:
+          - renesas,r9a07g043-usbphy-ctrl # RZ/G2UL
           - renesas,r9a07g044-usbphy-ctrl # RZ/G2{L,LC}
           - renesas,r9a07g054-usbphy-ctrl # RZ/V2L
       - const: renesas,rzg2l-usbphy-ctrl
-- 
2.25.1


