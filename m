From: fabrizio.castro@bp.renesas.com (Fabrizio Castro)
Date: Mon, 19 Feb 2018 18:45:50 +0000
Subject: [cip-dev] [PATCH 2/3] ARM: shmobile: Enable BQ32000 rtc in
	shmobile_defconfig
In-Reply-To: <1519065951-9897-1-git-send-email-fabrizio.castro@bp.renesas.com>
References: <1519065951-9897-1-git-send-email-fabrizio.castro@bp.renesas.com>
Message-ID: <1519065951-9897-3-git-send-email-fabrizio.castro@bp.renesas.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

From: Biju Das <biju.das@bp.renesas.com>

The iWave RZ/G1M Q7 SOM supports RTC (TI BQ32000).
To increase hardware support enable the driver in the
shmobile_defconfig multiplatform configuration.

Signed-off-by: Biju Das <biju.das@bp.renesas.com>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
(cherry picked from commit 0736aad1290d61bc3668f20253e1e1997ad8b3c1)
Signed-off-by: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
---
 arch/arm/configs/shmobile_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/configs/shmobile_defconfig b/arch/arm/configs/shmobile_defconfig
index e8a2d0b..2e79332 100644
--- a/arch/arm/configs/shmobile_defconfig
+++ b/arch/arm/configs/shmobile_defconfig
@@ -178,6 +178,7 @@ CONFIG_LEDS_CLASS=y
 CONFIG_LEDS_GPIO=y
 CONFIG_RTC_CLASS=y
 CONFIG_RTC_DRV_RS5C372=y
+CONFIG_RTC_DRV_BQ32K=y
 CONFIG_RTC_DRV_S35390A=y
 CONFIG_RTC_DRV_RX8581=y
 CONFIG_DMADEVICES=y
-- 
2.7.4
