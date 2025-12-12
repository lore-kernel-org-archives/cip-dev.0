Return-Path: <ovidiu.panait.rb@renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 559D4D59F4A
	for <webhook@archiver.kernel.org>; Fri, 12 Dec 2025 21:39:04 +0000 (UTC)
Received: from relmlie5.idc.renesas.com (relmlie5.idc.renesas.com [210.160.252.171])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.4864.1765575536648134352
 for <cip-dev@lists.cip-project.org>;
 Fri, 12 Dec 2025 13:38:56 -0800
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: renesas.com, ip: 210.160.252.171, mailfrom: ovidiu.panait.rb@renesas.com)
X-CSE-ConnectionGUID: 4GXoxL7VRwCqBwtVM+Xdrw==
X-CSE-MsgGUID: u/V2rbgRRxO4G+7ovWgLkw==
Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie5.idc.renesas.com with ESMTP; 13 Dec 2025 06:38:55 +0900
Received: from vm01.adwin.renesas.com (unknown [10.226.93.53])
	by relmlir5.idc.renesas.com (Postfix) with ESMTP id B8B85475F1E5;
	Sat, 13 Dec 2025 06:38:54 +0900 (JST)
From: Ovidiu Panait <ovidiu.panait.rb@renesas.com>
To: cip-dev@lists.cip-project.org,
	pavel@denx.de,
	nobuhiro.iwamatsu.x90@mail.toshiba
Subject: [PATCH 6.12.y-cip 1/4] dt-bindings: watchdog: renesas,wdt: Document RZ/V2N (R9A09G056) support
Date: Fri, 12 Dec 2025 21:38:40 +0000
Message-ID: <20251212213843.24018-2-ovidiu.panait.rb@renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251212213843.24018-1-ovidiu.panait.rb@renesas.com>
References: <20251212213843.24018-1-ovidiu.panait.rb@renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 12 Dec 2025 21:39:04 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/21000

From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

commit f55937e42c9951b615e291d9b7e6337747804463 upstream.

Document support for the watchdog IP found on the Renesas RZ/V2N
(R9A09G056) SoC. The watchdog IP is identical to that on RZ/V2H(P),
so `renesas,r9a09g057-wdt` will be used as a fallback compatible,
enabling reuse of the existing driver without changes.

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Acked-by: Conor Dooley <conor.dooley@microchip.com>
Reviewed-by: Guenter Roeck <linux@roeck-us.net>
Link: https://lore.kernel.org/r/20250502120054.47323-1-prabhakar.mahadev-lad.rj@bp.renesas.com
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
Signed-off-by: Wim Van Sebroeck <wim@linux-watchdog.org>
Signed-off-by: Ovidiu Panait <ovidiu.panait.rb@renesas.com>
---
 Documentation/devicetree/bindings/watchdog/renesas,wdt.yaml | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/watchdog/renesas,wdt.yaml b/Documentation/devicetree/bindings/watchdog/renesas,wdt.yaml
index 3e0a8747a357..78874b90c88c 100644
--- a/Documentation/devicetree/bindings/watchdog/renesas,wdt.yaml
+++ b/Documentation/devicetree/bindings/watchdog/renesas,wdt.yaml
@@ -76,7 +76,9 @@ properties:
           - const: renesas,rcar-gen4-wdt # R-Car Gen4
 
       - items:
-          - const: renesas,r9a09g047-wdt # RZ/G3E
+          - enum:
+              - renesas,r9a09g047-wdt # RZ/G3E
+              - renesas,r9a09g056-wdt # RZ/V2N
           - const: renesas,r9a09g057-wdt # RZ/V2H(P)
 
       - const: renesas,r9a09g057-wdt       # RZ/V2H(P)
-- 
2.51.0


