Return-Path: <ovidiu.panait.rb@renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D041F419AA
	for <webhook@archiver.kernel.org>; Wed, 15 Apr 2026 13:19:34 +0000 (UTC)
Received: from relmlie5.idc.renesas.com (relmlie5.idc.renesas.com [210.160.252.171])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.18768.1776259166386192008
 for <cip-dev@lists.cip-project.org>;
 Wed, 15 Apr 2026 06:19:29 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: renesas.com, ip: 210.160.252.171, mailfrom: ovidiu.panait.rb@renesas.com)
X-CSE-ConnectionGUID: Zpota7fJRiuVyQwqyeq1KQ==
X-CSE-MsgGUID: +qIeH0YlQLmBOjb1b8emQg==
Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie5.idc.renesas.com with ESMTP; 15 Apr 2026 22:19:29 +0900
Received: from vm01.adwin.renesas.com (unknown [10.226.92.18])
	by relmlir5.idc.renesas.com (Postfix) with ESMTP id 0EBD5400A113;
	Wed, 15 Apr 2026 22:19:27 +0900 (JST)
From: Ovidiu Panait <ovidiu.panait.rb@renesas.com>
To: cip-dev@lists.cip-project.org,
	pavel@nabladev.com,
	nobuhiro.iwamatsu.x90@mail.toshiba
Subject: [PATCH 6.1.y-cip 4/8] spi: dt-bindings: renesas,rzv2h-rspi: Document RZ/V2N SoC support
Date: Wed, 15 Apr 2026 13:19:15 +0000
Message-ID: <20260415131919.95486-5-ovidiu.panait.rb@renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260415131919.95486-1-ovidiu.panait.rb@renesas.com>
References: <20260415131919.95486-1-ovidiu.panait.rb@renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 15 Apr 2026 13:19:34 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/22709

From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

commit 043cc033451530f81d7fe791dcc29874f6a147fd upstream.

Document the RSPI controller on the Renesas RZ/V2N SoC. The block is
compatible with the RSPI implementation found on the RZ/V2H(P) family.

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Link: https://patch.msgid.link/20251126131619.136605-1-prabhakar.mahadev-lad.rj@bp.renesas.com
Signed-off-by: Mark Brown <broonie@kernel.org>
[OP: added oneOf list, as T2H support is not present in 6.1.y-cip]
Signed-off-by: Ovidiu Panait <ovidiu.panait.rb@renesas.com>
---
 .../devicetree/bindings/spi/renesas,rzv2h-rspi.yaml         | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/spi/renesas,rzv2h-rspi.yaml b/Documentation/devicetree/bindings/spi/renesas,rzv2h-rspi.yaml
index ab27fefc3c3a..394438b3d680 100644
--- a/Documentation/devicetree/bindings/spi/renesas,rzv2h-rspi.yaml
+++ b/Documentation/devicetree/bindings/spi/renesas,rzv2h-rspi.yaml
@@ -14,7 +14,11 @@ allOf:
 
 properties:
   compatible:
-    const: renesas,r9a09g057-rspi # RZ/V2H(P)
+    oneOf:
+      - const: renesas,r9a09g057-rspi # RZ/V2H(P)
+      - items:
+          - const: renesas,r9a09g056-rspi # RZ/V2N
+          - const: renesas,r9a09g057-rspi
 
   reg:
     maxItems: 1
-- 
2.34.1


