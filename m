Return-Path: <prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 595E6C64EC1
	for <webhook@archiver.kernel.org>; Thu, 21 Apr 2022 16:46:10 +0000 (UTC)
Received: from relmlie5.idc.renesas.com (relmlie5.idc.renesas.com
 [210.160.252.171])
 by mx.groups.io with SMTP id smtpd.web10.13624.1650490471262261243
 for <cip-dev@lists.cip-project.org>;
 Wed, 20 Apr 2022 14:34:34 -0700
Authentication-Results: mx.groups.io;
 dkim=missing;
 spf=pass (domain: bp.renesas.com, ip: 210.160.252.171,
 mailfrom: prabhakar.mahadev-lad.rj@bp.renesas.com)
X-IronPort-AV: E=Sophos;i="5.90,276,1643641200";
   d="scan'208";a="117482574"
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie5.idc.renesas.com with ESMTP; 21 Apr 2022 06:34:33 +0900
Received: from localhost.localdomain (unknown [10.226.36.204])
	by relmlir6.idc.renesas.com (Postfix) with ESMTP id 4B42D4108B69;
	Thu, 21 Apr 2022 06:34:32 +0900 (JST)
From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
Cc: Biju Das <biju.das.jz@bp.renesas.com>
Subject: [PATCH 5.10.y-cip 03/24] ASoC: dt-bindings: renesas,rz-ssi: Update
 slave dma channel configuration parameter
Date: Wed, 20 Apr 2022 22:34:03 +0100
Message-Id: <20220420213424.27837-4-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220420213424.27837-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20220420213424.27837-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 21 Apr 2022 16:46:10 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/8125

From: Biju Das <biju.das.jz@bp.renesas.com>

commit bed0b1c1e88a27b76c74584128cadebc6fa58622 upstream.

The DMAC on RZ/G2L has specific slave channel configuration
parameters for SSI.
This patch updates the dmas description and example node to include
the encoded slave channel configuration.

Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
Reviewed-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Link: https://lore.kernel.org/r/20210813091156.10700-3-biju.das.jz@bp.renesas.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
 .../bindings/sound/renesas,rz-ssi.yaml        | 22 +++++++++++++++++--
 1 file changed, 20 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/sound/renesas,rz-ssi.yaml b/Documentation/devicetree/bindings/sound/renesas,rz-ssi.yaml
index 471937cb8d05..414ff8035a4e 100644
--- a/Documentation/devicetree/bindings/sound/renesas,rz-ssi.yaml
+++ b/Documentation/devicetree/bindings/sound/renesas,rz-ssi.yaml
@@ -48,6 +48,24 @@ properties:
   dmas:
     minItems: 1
     maxItems: 2
+    description:
+      The first cell represents a phandle to dmac
+      The second cell specifies the encoded MID/RID values of the SSI port
+      connected to the DMA client and the slave channel configuration
+      parameters.
+      bits[0:9]   - Specifies MID/RID value of a SSI channel as below
+                    MID/RID value of SSI rx0 = 0x256
+                    MID/RID value of SSI tx0 = 0x255
+                    MID/RID value of SSI rx1 = 0x25a
+                    MID/RID value of SSI tx1 = 0x259
+                    MID/RID value of SSI rt2 = 0x25f
+                    MID/RID value of SSI rx3 = 0x262
+                    MID/RID value of SSI tx3 = 0x261
+      bit[10]     - HIEN = 1, Detects a request in response to the rising edge
+                    of the signal
+      bit[11]     - LVL = 0, Detects based on the edge
+      bits[12:14] - AM = 2, Bus cycle mode
+      bit[15]     - TM = 0, Single transfer mode
 
   dma-names:
     oneOf:
@@ -93,8 +111,8 @@ examples:
             clock-names = "ssi", "ssi_sfr", "audio_clk1", "audio_clk2";
             power-domains = <&cpg>;
             resets = <&cpg R9A07G044_SSI0_RST_M2_REG>;
-            dmas = <&dmac 0x255>,
-                   <&dmac 0x256>;
+            dmas = <&dmac 0x2655>,
+                   <&dmac 0x2656>;
             dma-names = "tx", "rx";
             #sound-dai-cells = <0>;
     };
-- 
2.17.1


