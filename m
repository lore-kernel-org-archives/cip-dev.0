Return-Path: <fabrizio.castro.jz@renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 574AEC30658
	for <webhook@archiver.kernel.org>; Mon,  3 Jul 2023 17:17:03 +0000 (UTC)
Received: from relmlie5.idc.renesas.com (relmlie5.idc.renesas.com [210.160.252.171])
 by mx.groups.io with SMTP id smtpd.web10.39279.1688404616547405615
 for <cip-dev@lists.cip-project.org>;
 Mon, 03 Jul 2023 10:16:56 -0700
Authentication-Results: mx.groups.io;
 dkim=missing; spf=pass (domain: renesas.com, ip: 210.160.252.171, mailfrom: fabrizio.castro.jz@renesas.com)
X-IronPort-AV: E=Sophos;i="6.01,178,1684767600"; 
   d="scan'208";a="166630697"
Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie5.idc.renesas.com with ESMTP; 04 Jul 2023 02:16:55 +0900
Received: from dev.ree.adwin.renesas.com (unknown [10.226.38.7])
	by relmlir5.idc.renesas.com (Postfix) with ESMTP id 09451400BBFE;
	Tue,  4 Jul 2023 02:16:52 +0900 (JST)
From: Fabrizio Castro <fabrizio.castro.jz@renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
Cc: Biju Das <biju.das@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	Chris Paterson <Chris.Paterson2@renesas.com>,
	Fabrizio Castro <fabrizio.castro.jz@renesas.com>
Subject: [PATCH 5.10.y-cip 1/5] dt-bindings: mmc: renesas,sdhi: Document RZ/V2M support
Date: Mon,  3 Jul 2023 18:16:45 +0100
Message-Id: <20230703171649.15862-2-fabrizio.castro.jz@renesas.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230703171649.15862-1-fabrizio.castro.jz@renesas.com>
References: <20230703171649.15862-1-fabrizio.castro.jz@renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 03 Jul 2023 17:17:03 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/12191

Commit c9dc89944b66abf9aa0ad57aa45e4edf030e2441 upstream.

Document support for the SD Card/MMC interface on the Renesas
RZ/V2M (a.k.a. r9a09g011) SoC.

Signed-off-by: Fabrizio Castro <fabrizio.castro.jz@renesas.com>
Acked-by: Rob Herring <robh@kernel.org>
Reviewed-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
Link: https://lore.kernel.org/r/20221213230129.549968-3-fabrizio.castro.jz@renesas.com
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
Signed-off-by: Fabrizio Castro <fabrizio.castro.jz@renesas.com>
---
 Documentation/devicetree/bindings/mmc/renesas,sdhi.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/mmc/renesas,sdhi.yaml b/Documentation/devicetree/bindings/mmc/renesas,sdhi.yaml
index 19c9f1850528..91aa9b84d23f 100644
--- a/Documentation/devicetree/bindings/mmc/renesas,sdhi.yaml
+++ b/Documentation/devicetree/bindings/mmc/renesas,sdhi.yaml
@@ -59,6 +59,7 @@ properties:
               - renesas,sdhi-r9a07g043 # RZ/G2UL
               - renesas,sdhi-r9a07g044 # RZ/G2{L,LC}
               - renesas,sdhi-r9a07g054 # RZ/V2L
+              - renesas,sdhi-r9a09g011 # RZ/V2M
           - const: renesas,rcar-gen3-sdhi # R-Car Gen3 or RZ/G2
 
   reg:
-- 
2.25.1


