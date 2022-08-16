Return-Path: <prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63E16C28B2B
	for <webhook@archiver.kernel.org>; Tue, 16 Aug 2022 12:34:18 +0000 (UTC)
Received: from relmlie5.idc.renesas.com (relmlie5.idc.renesas.com
 [210.160.252.171])
 by mx.groups.io with SMTP id smtpd.web12.15008.1660653254165494760
 for <cip-dev@lists.cip-project.org>;
 Tue, 16 Aug 2022 05:34:14 -0700
Authentication-Results: mx.groups.io;
 dkim=missing;
 spf=pass (domain: bp.renesas.com, ip: 210.160.252.171,
 mailfrom: prabhakar.mahadev-lad.rj@bp.renesas.com)
X-IronPort-AV: E=Sophos;i="5.93,240,1654527600";
   d="scan'208";a="129665702"
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie5.idc.renesas.com with ESMTP; 16 Aug 2022 21:34:13 +0900
Received: from localhost.localdomain (unknown [10.226.36.204])
	by relmlir6.idc.renesas.com (Postfix) with ESMTP id 30619402D0A9;
	Tue, 16 Aug 2022 21:34:11 +0900 (JST)
From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
Cc: Biju Das <biju.das.jz@bp.renesas.com>
Subject: [PATCH 5.10.y-cip 02/31] spi: dt-bindings: renesas,rspi: Document
 RZ/V2L SoC
Date: Tue, 16 Aug 2022 13:33:37 +0100
Message-Id: <20220816123406.27553-3-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220816123406.27553-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20220816123406.27553-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 16 Aug 2022 12:34:18 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/9221

commit f16ed63e53c79070283d3c264de5309794272ae9 upstream.

Add RSPI binding documentation for Renesas RZ/V2L SoC.

RSPI block is identical to one found on RZ/A, so no driver changes are
required. The fallback compatible string "renesas,rspi-rz" will be used
on RZ/V2L.

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Reviewed-by: Biju Das <biju.das.jz@bp.renesas.com>
Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Link: https://lore.kernel.org/r/20220227225956.29570-1-prabhakar.mahadev-lad.rj@bp.renesas.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
 Documentation/devicetree/bindings/spi/renesas,rspi.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/spi/renesas,rspi.yaml b/Documentation/devicetree/bindings/spi/renesas,rspi.yaml
index 6940ad78377c..c1a716771edc 100644
--- a/Documentation/devicetree/bindings/spi/renesas,rspi.yaml
+++ b/Documentation/devicetree/bindings/spi/renesas,rspi.yaml
@@ -22,6 +22,7 @@ properties:
               - renesas,rspi-r7s72100  # RZ/A1H
               - renesas,rspi-r7s9210   # RZ/A2
               - renesas,r9a07g044-rspi # RZ/G2{L,LC}
+              - renesas,r9a07g054-rspi # RZ/V2L
           - const: renesas,rspi-rz     # RZ/A and RZ/G2{L,LC}
 
       - items:
@@ -122,6 +123,7 @@ allOf:
             enum:
               - renesas,qspi
               - renesas,r9a07g044-rspi
+              - renesas,r9a07g054-rspi
     then:
       required:
         - resets
-- 
2.17.1


