From: biju.das@bp.renesas.com (Biju Das)
Date: Mon, 15 Jul 2019 15:17:22 +0100
Subject: [cip-dev] [PATCH 4.19.y-cip 3/6] dt-bindings: rtc: add rx8571
	compatible
In-Reply-To: <1563200245-30331-1-git-send-email-biju.das@bp.renesas.com>
References: <1563200245-30331-1-git-send-email-biju.das@bp.renesas.com>
Message-ID: <1563200245-30331-4-git-send-email-biju.das@bp.renesas.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

commit 57e883b576dc056f59a5612713b679432db36bfa upstream.

The Epson rx8571 is compatible with the Epson rx8581 RTC.

The difference between the rx8571 and rx8581 RTC is that the former has
16 bytes more RAM. This renders them incompatible from a DT point of view.

Signed-off-by: Biju Das <biju.das@bp.renesas.com>
Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
Signed-off-by: Biju Das <biju.das@bp.renesas.com>
[Backported to 4.19-cip]
---
 Documentation/devicetree/bindings/trivial-devices.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/trivial-devices.txt b/Documentation/devicetree/bindings/trivial-devices.txt
index 763a280..8a7e937 100644
--- a/Documentation/devicetree/bindings/trivial-devices.txt
+++ b/Documentation/devicetree/bindings/trivial-devices.txt
@@ -52,6 +52,7 @@ dlg,da9063		DA9063: system PMIC for quad-core application processors
 domintech,dmard09	DMARD09: 3-axis Accelerometer
 domintech,dmard10	DMARD10: 3-axis Accelerometer
 epson,rx8010		I2C-BUS INTERFACE REAL TIME CLOCK MODULE
+epson,rx8571		I2C-BUS INTERFACE REAL TIME CLOCK MODULE with Battery Backed RAM
 epson,rx8581		I2C-BUS INTERFACE REAL TIME CLOCK MODULE
 emmicro,em3027		EM Microelectronic EM3027 Real-time Clock
 fsl,mag3110		MAG3110: Xtrinsic High Accuracy, 3D Magnetometer
-- 
2.7.4
