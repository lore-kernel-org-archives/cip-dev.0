Return-Path: <biju.das.jz@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05F02C64991
	for <webhook@archiver.kernel.org>; Thu,  1 Sep 2022 08:02:02 +0000 (UTC)
Received: from relmlie6.idc.renesas.com (relmlie6.idc.renesas.com
 [210.160.252.172])
 by mx.groups.io with SMTP id smtpd.web11.9631.1662019311987705661
 for <cip-dev@lists.cip-project.org>;
 Thu, 01 Sep 2022 01:01:52 -0700
Authentication-Results: mx.groups.io;
 dkim=missing;
 spf=pass (domain: bp.renesas.com, ip: 210.160.252.172,
 mailfrom: biju.das.jz@bp.renesas.com)
X-IronPort-AV: E=Sophos;i="5.93,280,1654527600";
   d="scan'208";a="133337208"
Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie6.idc.renesas.com with ESMTP; 01 Sep 2022 17:01:51 +0900
Received: from localhost.localdomain (unknown [10.226.92.226])
	by relmlir5.idc.renesas.com (Postfix) with ESMTP id EEFB2400BBFB;
	Thu,  1 Sep 2022 17:01:48 +0900 (JST)
From: Biju Das <biju.das.jz@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
Cc: Chris Paterson <chris.paterson2@renesas.com>,
	Biju Das <biju.das.jz@bp.renesas.com>,
	Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH 5.10.y-cip 06/13] spi: dt-bindings: renesas,rspi: Document
 RZ/G2UL SoC
Date: Thu,  1 Sep 2022 09:01:21 +0100
Message-Id: <20220901080128.2147891-7-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220901080128.2147891-1-biju.das.jz@bp.renesas.com>
References: <20220901080128.2147891-1-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 01 Sep 2022 08:02:02 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/9410

commit dfc6597eb1e1604575c6e061e1a9be0048d17b2c upstream.

Add RSPI binding documentation for Renesas RZ/G2UL SoC.

RSPI block is identical to one found on RZ/A, so no driver changes are
required. The fallback compatible string "renesas,rspi-rz" will be used
on RZ/G2UL.

Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Link: https://lore.kernel.org/r/20220501082150.24662-1-biju.das.jz@bp.renesas.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
 Documentation/devicetree/bindings/spi/renesas,rspi.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/spi/renesas,rspi.yaml b/Documentation/devicetree/bindings/spi/renesas,rspi.yaml
index c1a716771edc..fd3580efc8be 100644
--- a/Documentation/devicetree/bindings/spi/renesas,rspi.yaml
+++ b/Documentation/devicetree/bindings/spi/renesas,rspi.yaml
@@ -21,6 +21,7 @@ properties:
           - enum:
               - renesas,rspi-r7s72100  # RZ/A1H
               - renesas,rspi-r7s9210   # RZ/A2
+              - renesas,r9a07g043-rspi # RZ/G2UL
               - renesas,r9a07g044-rspi # RZ/G2{L,LC}
               - renesas,r9a07g054-rspi # RZ/V2L
           - const: renesas,rspi-rz     # RZ/A and RZ/G2{L,LC}
@@ -122,6 +123,7 @@ allOf:
           contains:
             enum:
               - renesas,qspi
+              - renesas,r9a07g043-rspi
               - renesas,r9a07g044-rspi
               - renesas,r9a07g054-rspi
     then:
-- 
2.25.1


