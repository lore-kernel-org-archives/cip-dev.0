Return-Path: <prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44162C2BB41
	for <webhook@archiver.kernel.org>; Tue, 16 Aug 2022 12:34:28 +0000 (UTC)
Received: from relmlie5.idc.renesas.com (relmlie5.idc.renesas.com
 [210.160.252.171])
 by mx.groups.io with SMTP id smtpd.web12.15008.1660653254165494760
 for <cip-dev@lists.cip-project.org>;
 Tue, 16 Aug 2022 05:34:21 -0700
Authentication-Results: mx.groups.io;
 dkim=missing;
 spf=pass (domain: bp.renesas.com, ip: 210.160.252.171,
 mailfrom: prabhakar.mahadev-lad.rj@bp.renesas.com)
X-IronPort-AV: E=Sophos;i="5.93,240,1654527600";
   d="scan'208";a="129665714"
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie5.idc.renesas.com with ESMTP; 16 Aug 2022 21:34:21 +0900
Received: from localhost.localdomain (unknown [10.226.36.204])
	by relmlir6.idc.renesas.com (Postfix) with ESMTP id BB534402D0A9;
	Tue, 16 Aug 2022 21:34:19 +0900 (JST)
From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
Cc: Biju Das <biju.das.jz@bp.renesas.com>
Subject: [PATCH 5.10.y-cip 06/31] dt-bindings: can: renesas,rcar-canfd: Make
 interrupt-names required
Date: Tue, 16 Aug 2022 13:33:41 +0100
Message-Id: <20220816123406.27553-7-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220816123406.27553-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20220816123406.27553-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 16 Aug 2022 12:34:28 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/9225

From: Geert Uytterhoeven <geert+renesas@glider.be>

commit 48b171dbf7b65c188b533c9e19dce88d028cc26a upstream.

The Renesas R-Car CAN FD Controller always uses two or more interrupts.
Make the interrupt-names properties a required property, to make it
easier to identify the individual interrupts.

Update the example accordingly.

Link: https://lore.kernel.org/all/a68e65955e0df4db60233d468f348203c2e7b940.1651512451.git.geert+renesas@glider.be
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
 .../devicetree/bindings/net/can/renesas,rcar-canfd.yaml        | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/net/can/renesas,rcar-canfd.yaml b/Documentation/devicetree/bindings/net/can/renesas,rcar-canfd.yaml
index 720130bda6a6..162a51a1232d 100644
--- a/Documentation/devicetree/bindings/net/can/renesas,rcar-canfd.yaml
+++ b/Documentation/devicetree/bindings/net/can/renesas,rcar-canfd.yaml
@@ -84,6 +84,7 @@ required:
   - compatible
   - reg
   - interrupts
+  - interrupt-names
   - clocks
   - clock-names
   - power-domains
@@ -132,7 +133,6 @@ then:
         - const: rstc_n
 
   required:
-    - interrupt-names
     - reset-names
 else:
   properties:
@@ -163,6 +163,7 @@ examples:
             reg = <0xe66c0000 0x8000>;
             interrupts = <GIC_SPI 29 IRQ_TYPE_LEVEL_HIGH>,
                          <GIC_SPI 30 IRQ_TYPE_LEVEL_HIGH>;
+            interrupt-names = "ch_int", "g_int";
             clocks = <&cpg CPG_MOD 914>,
                      <&cpg CPG_CORE R8A7795_CLK_CANFD>,
                      <&can_clk>;
-- 
2.17.1


