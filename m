Return-Path: <ovidiu.panait.rb@renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 913D8105D9B5
	for <webhook@archiver.kernel.org>; Wed,  8 Apr 2026 09:40:02 +0000 (UTC)
Received: from relmlie6.idc.renesas.com (relmlie6.idc.renesas.com [210.160.252.172])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.102550.1775641196244975563
 for <cip-dev@lists.cip-project.org>;
 Wed, 08 Apr 2026 02:39:57 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: renesas.com, ip: 210.160.252.172, mailfrom: ovidiu.panait.rb@renesas.com)
X-CSE-ConnectionGUID: hTm4tSyFSpmdoa2LwKxpcw==
X-CSE-MsgGUID: A/mydIiTTrCi0cRTc/qK5g==
Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie6.idc.renesas.com with ESMTP; 08 Apr 2026 18:39:56 +0900
Received: from vm01.adwin.renesas.com (unknown [10.226.92.8])
	by relmlir5.idc.renesas.com (Postfix) with ESMTP id CF6B540116C8;
	Wed,  8 Apr 2026 18:39:55 +0900 (JST)
From: Ovidiu Panait <ovidiu.panait.rb@renesas.com>
To: cip-dev@lists.cip-project.org,
	pavel@nabladev.com,
	nobuhiro.iwamatsu.x90@mail.toshiba
Subject: [PATCH 6.1.y-cip 2/7] dt-bindings: thermal: r9a09g047-tsu: Document RZ/V2N TSU
Date: Wed,  8 Apr 2026 09:39:45 +0000
Message-ID: <20260408093951.66884-3-ovidiu.panait.rb@renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260408093951.66884-1-ovidiu.panait.rb@renesas.com>
References: <20260408093951.66884-1-ovidiu.panait.rb@renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 08 Apr 2026 09:40:02 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/22638

commit 96b0bb4a2310302307bafe62edbc3455fae8b723 upstream.

The Renesas RZ/V2N SoC includes a Thermal Sensor Unit (TSU) block designed
to measure the junction temperature. The device provides real-time
temperature measurements for thermal management, utilizing two dedicated
channels for temperature sensing.

The Renesas RZ/V2N SoC is using the same TSU IP found on the RZ/G3E SoC,
the only difference being that it has two channels instead of one.

Add new compatible string "renesas,r9a09g056-tsu" for RZ/V2N and use
"renesas,r9a09g047-tsu" as a fallback compatible to indicate hardware
compatibility with the RZ/G3E implementation.

Signed-off-by: Ovidiu Panait <ovidiu.panait.rb@renesas.com>
Acked-by: Rob Herring (Arm) <robh@kernel.org>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Link: https://patch.msgid.link/20251209091115.8541-2-ovidiu.panait.rb@renesas.com
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
Signed-off-by: Ovidiu Panait <ovidiu.panait.rb@renesas.com>
---
 .../devicetree/bindings/thermal/renesas,r9a09g047-tsu.yaml    | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/thermal/renesas,r9a09g047-tsu.yaml b/Documentation/devicetree/bindings/thermal/renesas,r9a09g047-tsu.yaml
index befdc8b7a082..c959b9834620 100644
--- a/Documentation/devicetree/bindings/thermal/renesas,r9a09g047-tsu.yaml
+++ b/Documentation/devicetree/bindings/thermal/renesas,r9a09g047-tsu.yaml
@@ -19,7 +19,9 @@ properties:
     oneOf:
       - const: renesas,r9a09g047-tsu # RZ/G3E
       - items:
-          - const: renesas,r9a09g057-tsu # RZ/V2H
+          - enum:
+              - renesas,r9a09g056-tsu # RZ/V2N
+              - renesas,r9a09g057-tsu # RZ/V2H
           - const: renesas,r9a09g047-tsu # RZ/G3E
 
   reg:
-- 
2.51.0


