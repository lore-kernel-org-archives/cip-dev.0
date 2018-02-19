From: fabrizio.castro@bp.renesas.com (Fabrizio Castro)
Date: Mon, 19 Feb 2018 18:45:51 +0000
Subject: [cip-dev] [PATCH 3/3] ARM: multi_v7_defconfig: Enable BQ32000 RTC
	driver
In-Reply-To: <1519065951-9897-1-git-send-email-fabrizio.castro@bp.renesas.com>
References: <1519065951-9897-1-git-send-email-fabrizio.castro@bp.renesas.com>
Message-ID: <1519065951-9897-4-git-send-email-fabrizio.castro@bp.renesas.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

From: Biju Das <biju.das@bp.renesas.com>

The iWave RZ/G1M Q7 SOM supports RTC (TI BQ32000).
To increase hardware support enable the driver in the
multi_v7_defconfig multiplatform configuration.

Signed-off-by: Biju Das <biju.das@bp.renesas.com>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
(cherry picked from commit 545dc83ed09b5c04f663b766a92cbc8bb02c5f15)
Signed-off-by: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
---
 arch/arm/configs/multi_v7_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/configs/multi_v7_defconfig b/arch/arm/configs/multi_v7_defconfig
index f1ba3fb..ba520f6 100644
--- a/arch/arm/configs/multi_v7_defconfig
+++ b/arch/arm/configs/multi_v7_defconfig
@@ -607,6 +607,7 @@ CONFIG_RTC_DRV_MAX77686=y
 CONFIG_RTC_DRV_RK808=m
 CONFIG_RTC_DRV_MAX77802=m
 CONFIG_RTC_DRV_RS5C372=m
+CONFIG_RTC_DRV_BQ32K=m
 CONFIG_RTC_DRV_PALMAS=y
 CONFIG_RTC_DRV_ST_LPC=y
 CONFIG_RTC_DRV_TWL4030=y
-- 
2.7.4
