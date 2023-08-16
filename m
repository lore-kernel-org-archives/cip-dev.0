Return-Path: <biju.das.jz@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F81BC41513
	for <webhook@archiver.kernel.org>; Wed, 16 Aug 2023 14:21:19 +0000 (UTC)
Received: from relmlie6.idc.renesas.com (relmlie6.idc.renesas.com [210.160.252.172])
 by mx.groups.io with SMTP id smtpd.web11.161767.1692195674774557236
 for <cip-dev@lists.cip-project.org>;
 Wed, 16 Aug 2023 07:21:16 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: bp.renesas.com, ip: 210.160.252.172, mailfrom: biju.das.jz@bp.renesas.com)
X-IronPort-AV: E=Sophos;i="6.01,177,1684767600"; 
   d="scan'208";a="176787712"
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie6.idc.renesas.com with ESMTP; 16 Aug 2023 23:21:16 +0900
Received: from localhost.localdomain (unknown [10.226.92.162])
	by relmlir6.idc.renesas.com (Postfix) with ESMTP id CBA4A4210C30;
	Wed, 16 Aug 2023 23:21:14 +0900 (JST)
From: Biju Das <biju.das.jz@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
Cc: Biju Das <biju.das.jz@bp.renesas.com>,
	Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Subject: [PATCH 5.10.y-cip 23/31] dt-bindings: rtc: isil,isl1208: Document clock and clock-names properties
Date: Wed, 16 Aug 2023 15:20:09 +0100
Message-Id: <20230816142017.147173-24-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230816142017.147173-1-biju.das.jz@bp.renesas.com>
References: <20230816142017.147173-1-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 16 Aug 2023 14:21:19 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/12705

commit 138f352556d791d7e0ca3ac9a4f4815123af8c82 upstream.

As per the HW manual, XTOSCB bit setting is as follows

If using an external clock signal, set the XTOSCB bit as 1 to
disable the crystal oscillator.

If using an external crystal, the XTOSCB bit needs to be set at 0
to enable the crystal oscillator.

Document clock and clock-names properties.

Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
Reviewed-by: Conor Dooley <conor.dooley@microchip.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Link: https://lore.kernel.org/r/20230623140948.384762-6-biju.das.jz@bp.renesas.com
Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
 .../devicetree/bindings/rtc/isil,isl1208.yaml         | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/Documentation/devicetree/bindings/rtc/isil,isl1208.yaml b/Documentation/devicetree/bindings/rtc/isil,isl1208.yaml
index 565965147ce6..11f7378d4997 100644
--- a/Documentation/devicetree/bindings/rtc/isil,isl1208.yaml
+++ b/Documentation/devicetree/bindings/rtc/isil,isl1208.yaml
@@ -25,6 +25,17 @@ properties:
   reg:
     maxItems: 1
 
+  clocks:
+    maxItems: 1
+
+  clock-names:
+    description: |
+      Use xin, if connected to an external crystal.
+      Use clkin, if connected to an external clock signal.
+    enum:
+      - xin
+      - clkin
+
   interrupts:
     minItems: 1
     maxItems: 2
-- 
2.25.1


