From: biju.das@bp.renesas.com (Biju Das)
Date: Thu, 10 May 2018 16:08:13 +0100
Subject: [cip-dev] [PATCH 24/62] ARM: shmobile: defconfig: Enable SGTL5000
	audio codec
In-Reply-To: <1525964931-14960-1-git-send-email-biju.das@bp.renesas.com>
References: <1525964931-14960-1-git-send-email-biju.das@bp.renesas.com>
Message-ID: <1525964931-14960-25-git-send-email-biju.das@bp.renesas.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

The iWave RZ/G1M Q7 carrier board supports I2S audio codec "SGTL5000".

To increase hardware support enable the driver in the shmobile_defconfig
multiplatform configuration.

Signed-off-by: Biju Das <biju.das@bp.renesas.com>
Reviewed-by: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
(cherry picked from commit 66d7b080aade3be61f7b41de800215c85a8d3593)
Signed-off-by: Biju Das <biju.das@bp.renesas.com>
Reviewed-by: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
---
 arch/arm/configs/shmobile_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/configs/shmobile_defconfig b/arch/arm/configs/shmobile_defconfig
index dfbd2de..8b559ca 100644
--- a/arch/arm/configs/shmobile_defconfig
+++ b/arch/arm/configs/shmobile_defconfig
@@ -162,6 +162,7 @@ CONFIG_SND_SOC_SH4_FSI=y
 CONFIG_SND_SOC_RCAR=y
 CONFIG_SND_SOC_RSRC_CARD=y
 CONFIG_SND_SOC_AK4642=y
+CONFIG_SND_SOC_SGTL5000=y
 CONFIG_SND_SOC_WM8978=y
 CONFIG_USB=y
 CONFIG_USB_XHCI_HCD=y
-- 
2.7.4
