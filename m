From: fabrizio.castro@bp.renesas.com (Fabrizio Castro)
Date: Tue, 15 May 2018 12:19:55 +0100
Subject: [cip-dev] [PATCH 5/7] ARM: shmobile: defconfig: Enable CMA for DMA
In-Reply-To: <1526383197-5913-1-git-send-email-fabrizio.castro@bp.renesas.com>
References: <1526383197-5913-1-git-send-email-fabrizio.castro@bp.renesas.com>
Message-ID: <1526383197-5913-6-git-send-email-fabrizio.castro@bp.renesas.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

From: Niklas S?derlund <niklas.soderlund+renesas@ragnatech.se>

To be able to use VIN with larger frame sizes CMA memory are needed for
DMA. If this is not enabled trying to capture large frames can result in
errors such as:

rcar-vin e6ef0000.video: dma_alloc_coherent of size 8388608 failed

A CMA area of 64MB are needed for v4l2-compliance to pass on all formats
on the largest possible frame size of 2048x2048.

Signed-off-by: Niklas S?derlund <niklas.soderlund+renesas@ragnatech.se>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
(cherry picked from commit 77af670a7698bbc4dc9fd8bbd553b33bfb16b68a)
Signed-off-by: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
Reviewed-by: Biju Das <biju.das@bp.renesas.com>
---
 arch/arm/configs/shmobile_defconfig | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/arm/configs/shmobile_defconfig b/arch/arm/configs/shmobile_defconfig
index 30a3424..733b4f2 100644
--- a/arch/arm/configs/shmobile_defconfig
+++ b/arch/arm/configs/shmobile_defconfig
@@ -35,6 +35,7 @@ CONFIG_HAVE_ARM_ARCH_TIMER=y
 CONFIG_NR_CPUS=8
 CONFIG_AEABI=y
 CONFIG_HIGHMEM=y
+CONFIG_CMA=y
 CONFIG_ZBOOT_ROM_TEXT=0x0
 CONFIG_ZBOOT_ROM_BSS=0x0
 CONFIG_ARM_APPENDED_DTB=y
@@ -58,6 +59,8 @@ CONFIG_IP_PNP_DHCP=y
 CONFIG_UEVENT_HELPER_PATH="/sbin/hotplug"
 CONFIG_DEVTMPFS=y
 CONFIG_DEVTMPFS_MOUNT=y
+CONFIG_DMA_CMA=y
+CONFIG_CMA_SIZE_MBYTES=64
 CONFIG_SIMPLE_PM_BUS=y
 CONFIG_MTD=y
 CONFIG_MTD_BLOCK=y
-- 
2.7.4
