From: biju.das@bp.renesas.com (Biju Das)
Date: Tue, 16 Jul 2019 09:15:15 +0100
Subject: [cip-dev] [PATCH 4.4.y-cip 04/10] dt-bindings: rtc: pcf85363:
	Document pcf85263 real-time clock
In-Reply-To: <1563264921-42973-1-git-send-email-biju.das@bp.renesas.com>
References: <1563264921-42973-1-git-send-email-biju.das@bp.renesas.com>
Message-ID: <1563264921-42973-5-git-send-email-biju.das@bp.renesas.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

commit bae5e94bea188e652d798eeb4b92b88a355591f6 upstream.

The pcf85263 RTC is compatible with the pcf85363 RTC.

The difference between the pcf85263 and pcf85363 RTC is that the latter has
64 bytes more RAM. This renders them incompatible from a DT point of view.

Signed-off-by: Biju Das <biju.das@bp.renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Reviewed-by: Rob Herring <robh@kernel.org>
Reviewed-by: Simon Horman <horms+renesas@verge.net.au>
Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
---
 Documentation/devicetree/bindings/rtc/pcf85363.txt | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/rtc/pcf85363.txt b/Documentation/devicetree/bindings/rtc/pcf85363.txt
index 76fdabc..94adc1c 100644
--- a/Documentation/devicetree/bindings/rtc/pcf85363.txt
+++ b/Documentation/devicetree/bindings/rtc/pcf85363.txt
@@ -1,8 +1,8 @@
-NXP PCF85363 Real Time Clock
+NXP PCF85263/PCF85363 Real Time Clock
 ============================
 
 Required properties:
-- compatible: Should contain "nxp,pcf85363".
+- compatible: Should contain "nxp,pcf85263" or "nxp,pcf85363".
 - reg: I2C address for chip.
 
 Optional properties:
-- 
2.7.4
