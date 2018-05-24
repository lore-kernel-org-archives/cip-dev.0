From: biju.das@bp.renesas.com (Biju Das)
Date: Thu, 24 May 2018 17:05:10 +0100
Subject: [cip-dev] [RFC PATCH 7/7] ARM: shmobile: defconfig: Enable missing
	support based on DTSes
In-Reply-To: <1527177910-65275-1-git-send-email-biju.das@bp.renesas.com>
References: <1527177910-65275-1-git-send-email-biju.das@bp.renesas.com>
Message-ID: <1527177910-65275-8-git-send-email-biju.das@bp.renesas.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

From: Geert Uytterhoeven <geert+renesas@glider.be>

Enable all missing support, extracted from the various Renesas ARM DTSes
using linux-config-from-dt.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
(cherry picked from commit 6161cc147277e7537d73a45d732a7112997c20f6)
(enabled only USB-DMAC apart from previously enabled CAN and
 CAN_RCAR)
Signed-off-by: Biju Das <biju.das@bp.renesas.com>
---
 arch/arm/configs/shmobile_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/configs/shmobile_defconfig b/arch/arm/configs/shmobile_defconfig
index 31d7ccc..69b95f5 100644
--- a/arch/arm/configs/shmobile_defconfig
+++ b/arch/arm/configs/shmobile_defconfig
@@ -189,6 +189,7 @@ CONFIG_RTC_DRV_RX8581=y
 CONFIG_DMADEVICES=y
 CONFIG_SH_DMAE=y
 CONFIG_RCAR_DMAC=y
+CONFIG_RENESAS_USB_DMAC=y
 # CONFIG_IOMMU_SUPPORT is not set
 CONFIG_IIO=y
 CONFIG_AK8975=y
-- 
2.7.4
