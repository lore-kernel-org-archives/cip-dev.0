From: biju.das@bp.renesas.com (Biju Das)
Date: Tue, 16 Jul 2019 09:15:20 +0100
Subject: [cip-dev] [PATCH 4.4.y-cip 09/10] ARM: multi_v7_defconfig: Enable
	NXP pcf85363 rtc
In-Reply-To: <1563264921-42973-1-git-send-email-biju.das@bp.renesas.com>
References: <1563264921-42973-1-git-send-email-biju.das@bp.renesas.com>
Message-ID: <1563264921-42973-10-git-send-email-biju.das@bp.renesas.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

commit e5168ec09d993d2b64cd9ee8d4cff269e53538be upstream.

The iWave RZ/G1C SBC supports RTC (NXP pcf85263). To increase
hardware support enable the driver in the multi_v7_defconfig
multiplatform configuration.

Signed-off-by: Biju Das <biju.das@bp.renesas.com>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/configs/multi_v7_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/configs/multi_v7_defconfig b/arch/arm/configs/multi_v7_defconfig
index cfaf564..a3ba031 100644
--- a/arch/arm/configs/multi_v7_defconfig
+++ b/arch/arm/configs/multi_v7_defconfig
@@ -608,6 +608,7 @@ CONFIG_RTC_DRV_MAX77686=y
 CONFIG_RTC_DRV_RK808=m
 CONFIG_RTC_DRV_MAX77802=m
 CONFIG_RTC_DRV_RS5C372=m
+CONFIG_RTC_DRV_PCF85363=m
 CONFIG_RTC_DRV_BQ32K=m
 CONFIG_RTC_DRV_PALMAS=y
 CONFIG_RTC_DRV_ST_LPC=y
-- 
2.7.4
