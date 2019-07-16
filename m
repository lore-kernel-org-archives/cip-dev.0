From: biju.das@bp.renesas.com (Biju Das)
Date: Tue, 16 Jul 2019 09:15:19 +0100
Subject: [cip-dev] [PATCH 4.4.y-cip 08/10] ARM: shmobile: Enable NXP
	pcf85363 rtc in shmobile_defconfig
In-Reply-To: <1563264921-42973-1-git-send-email-biju.das@bp.renesas.com>
References: <1563264921-42973-1-git-send-email-biju.das@bp.renesas.com>
Message-ID: <1563264921-42973-9-git-send-email-biju.das@bp.renesas.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

commit 71e3039dd7c377118608321d6c1f2ecb35da4c17 upstream.

The iWave RZ/G1C SBC supports RTC (NXP pcf85263). To increase hardware
support enable the driver in the shmobile_defconfig multiplatform
configuration.

Signed-off-by: Biju Das <biju.das@bp.renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/configs/shmobile_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/configs/shmobile_defconfig b/arch/arm/configs/shmobile_defconfig
index 4770cd8..4074631 100644
--- a/arch/arm/configs/shmobile_defconfig
+++ b/arch/arm/configs/shmobile_defconfig
@@ -188,6 +188,7 @@ CONFIG_LEDS_CLASS=y
 CONFIG_LEDS_GPIO=y
 CONFIG_RTC_CLASS=y
 CONFIG_RTC_DRV_RS5C372=y
+CONFIG_RTC_DRV_PCF85363=y
 CONFIG_RTC_DRV_BQ32K=y
 CONFIG_RTC_DRV_S35390A=y
 CONFIG_RTC_DRV_RX8581=y
-- 
2.7.4
