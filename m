Return-Path: <prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54C8FC2BB41
	for <webhook@archiver.kernel.org>; Tue, 16 Aug 2022 12:34:18 +0000 (UTC)
Received: from relmlie5.idc.renesas.com (relmlie5.idc.renesas.com
 [210.160.252.171])
 by mx.groups.io with SMTP id smtpd.web10.14834.1660653252524513079
 for <cip-dev@lists.cip-project.org>;
 Tue, 16 Aug 2022 05:34:12 -0700
Authentication-Results: mx.groups.io;
 dkim=missing;
 spf=pass (domain: bp.renesas.com, ip: 210.160.252.171,
 mailfrom: prabhakar.mahadev-lad.rj@bp.renesas.com)
X-IronPort-AV: E=Sophos;i="5.93,240,1654527600";
   d="scan'208";a="129665696"
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie5.idc.renesas.com with ESMTP; 16 Aug 2022 21:34:11 +0900
Received: from localhost.localdomain (unknown [10.226.36.204])
	by relmlir6.idc.renesas.com (Postfix) with ESMTP id 48B36402D0A4;
	Tue, 16 Aug 2022 21:34:10 +0900 (JST)
From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
Cc: Biju Das <biju.das.jz@bp.renesas.com>
Subject: [PATCH 5.10.y-cip 01/31] ASoC: dt-bindings: renesas,rz-ssi: Document
 RZ/V2L SoC
Date: Tue, 16 Aug 2022 13:33:36 +0100
Message-Id: <20220816123406.27553-2-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220816123406.27553-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20220816123406.27553-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 16 Aug 2022 12:34:18 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/9219

commit 032959d880fd99a790607cf59cf6c00b77a32cef upstream.

Document RZ/V2L SSI bindings. RZ/V2L SSI is identical to one found
on the RZ/G2L SoC. No driver changes are required as generic compatible
string "renesas,rz-ssi" will be used as a fallback.

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Reviewed-by: Biju Das <biju.das.jz@bp.renesas.com>
Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Link: https://lore.kernel.org/r/20220227225633.28829-1-prabhakar.mahadev-lad.rj@bp.renesas.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
 Documentation/devicetree/bindings/sound/renesas,rz-ssi.yaml | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/sound/renesas,rz-ssi.yaml b/Documentation/devicetree/bindings/sound/renesas,rz-ssi.yaml
index 414ff8035a4e..7e8d252f7bca 100644
--- a/Documentation/devicetree/bindings/sound/renesas,rz-ssi.yaml
+++ b/Documentation/devicetree/bindings/sound/renesas,rz-ssi.yaml
@@ -4,7 +4,7 @@
 $id: http://devicetree.org/schemas/sound/renesas,rz-ssi.yaml#
 $schema: http://devicetree.org/meta-schemas/core.yaml#
 
-title: Renesas RZ/G2L ASoC Sound Serial Interface (SSIF-2)
+title: Renesas RZ/{G2L,V2L} ASoC Sound Serial Interface (SSIF-2)
 
 maintainers:
   - Biju Das <biju.das.jz@bp.renesas.com>
@@ -14,6 +14,7 @@ properties:
     items:
       - enum:
           - renesas,r9a07g044-ssi  # RZ/G2{L,LC}
+          - renesas,r9a07g054-ssi  # RZ/V2L
       - const: renesas,rz-ssi
 
   reg:
-- 
2.17.1


