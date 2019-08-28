From: biju.das@bp.renesas.com (Biju Das)
Date: Wed, 28 Aug 2019 09:48:28 +0100
Subject: [cip-dev] [PATCH 4.4.y-cip 10/17] ARM: shmobile: Enable
	PHY_RCAR_GEN3_USB2 in shmobile_defconfig
In-Reply-To: <1566982115-11148-1-git-send-email-biju.das@bp.renesas.com>
References: <1566982115-11148-1-git-send-email-biju.das@bp.renesas.com>
Message-ID: <1566982115-11148-11-git-send-email-biju.das@bp.renesas.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

commit 0cd4f4f10245d1d9616e00245093f46acd198141 upstream.

Enable PHY_RCAR_GEN3_USB2 in shmobile_defconfig so that boards
based on RZ/G1C SoC design can use the corresponding driver.

Signed-off-by: Biju Das <biju.das@bp.renesas.com>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/configs/shmobile_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/configs/shmobile_defconfig b/arch/arm/configs/shmobile_defconfig
index 4074631..b1dd3037 100644
--- a/arch/arm/configs/shmobile_defconfig
+++ b/arch/arm/configs/shmobile_defconfig
@@ -204,6 +204,7 @@ CONFIG_PWM_RCAR=y
 CONFIG_PWM_RENESAS_TPU=y
 CONFIG_GENERIC_PHY=y
 CONFIG_PHY_RCAR_GEN2=y
+CONFIG_PHY_RCAR_GEN3_USB2=y
 # CONFIG_DNOTIFY is not set
 CONFIG_MSDOS_FS=y
 CONFIG_VFAT_FS=y
-- 
2.7.4
