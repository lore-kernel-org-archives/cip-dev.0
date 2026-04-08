Return-Path: <ovidiu.panait.rb@renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 555BD105D9B3
	for <webhook@archiver.kernel.org>; Wed,  8 Apr 2026 09:40:02 +0000 (UTC)
Received: from relmlie6.idc.renesas.com (relmlie6.idc.renesas.com [210.160.252.172])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.102550.1775641196244975563
 for <cip-dev@lists.cip-project.org>;
 Wed, 08 Apr 2026 02:39:56 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: renesas.com, ip: 210.160.252.172, mailfrom: ovidiu.panait.rb@renesas.com)
X-CSE-ConnectionGUID: ag/sEnRjTF68etzPnE5Cfw==
X-CSE-MsgGUID: 2bkO65dCSIOSScaPF3xFiA==
Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie6.idc.renesas.com with ESMTP; 08 Apr 2026 18:39:55 +0900
Received: from vm01.adwin.renesas.com (unknown [10.226.92.8])
	by relmlir5.idc.renesas.com (Postfix) with ESMTP id 2503840116CF;
	Wed,  8 Apr 2026 18:39:53 +0900 (JST)
From: Ovidiu Panait <ovidiu.panait.rb@renesas.com>
To: cip-dev@lists.cip-project.org,
	pavel@nabladev.com,
	nobuhiro.iwamatsu.x90@mail.toshiba
Subject: [PATCH 6.1.y-cip 1/7] dt-bindings: thermal: r9a09g047-tsu: Document RZ/V2H TSU
Date: Wed,  8 Apr 2026 09:39:44 +0000
Message-ID: <20260408093951.66884-2-ovidiu.panait.rb@renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260408093951.66884-1-ovidiu.panait.rb@renesas.com>
References: <20260408093951.66884-1-ovidiu.panait.rb@renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 08 Apr 2026 09:40:02 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/22637

commit 30183a67a8a0e74adf92e2dc66b5674465d42025 upstream.

The Renesas RZ/V2H SoC includes a Thermal Sensor Unit (TSU) block designed
to measure the junction temperature. The device provides real-time
temperature measurements for thermal management, utilizing two dedicated
channels for temperature sensing.

The Renesas RZ/V2H SoC is using the same TSU IP found on the RZ/G3E SoC,
the only difference being that it has two channels instead of one.

Add new compatible string "renesas,r9a09g057-tsu" for RZ/V2H and use
"renesas,r9a09g047-tsu" as a fallback compatible to indicate hardware
compatibility with the RZ/G3E implementation.

Signed-off-by: Ovidiu Panait <ovidiu.panait.rb@renesas.com>
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Link: https://patch.msgid.link/20251020143107.13974-3-ovidiu.panait.rb@renesas.com
Signed-off-by: Ovidiu Panait <ovidiu.panait.rb@renesas.com>
---
 .../devicetree/bindings/thermal/renesas,r9a09g047-tsu.yaml  | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/thermal/renesas,r9a09g047-tsu.yaml b/Documentation/devicetree/bindings/thermal/renesas,r9a09g047-tsu.yaml
index 8d3f3c24f0f2..befdc8b7a082 100644
--- a/Documentation/devicetree/bindings/thermal/renesas,r9a09g047-tsu.yaml
+++ b/Documentation/devicetree/bindings/thermal/renesas,r9a09g047-tsu.yaml
@@ -16,7 +16,11 @@ description:
 
 properties:
   compatible:
-    const: renesas,r9a09g047-tsu
+    oneOf:
+      - const: renesas,r9a09g047-tsu # RZ/G3E
+      - items:
+          - const: renesas,r9a09g057-tsu # RZ/V2H
+          - const: renesas,r9a09g047-tsu # RZ/G3E
 
   reg:
     maxItems: 1
-- 
2.51.0


