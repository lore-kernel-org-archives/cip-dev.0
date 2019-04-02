From: jan.kiszka@siemens.com (Jan Kiszka)
Date: Tue, 2 Apr 2019 15:22:33 +0200
Subject: [cip-dev] [PATCH 4.19.y] ARM: dts: socfpga: Rename
 socfpga_cyclone5_de0_{sockit, nano_soc}
Message-ID: <a3b5f19e-00ba-fd0f-8ebe-bfa0c5782fe6@siemens.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

From: Marek Vasut <marex@denx.de>

Rename DT source for DE0 Nano SoC . The board name is really DE0-Nano-SoC
or Atlas SoC, and it is not to be confused with SoCkit board, which is a
different one. Rename the DT source file to match the board name and to
avoid this possible mixup with another different board.

Upstream commit 202eb5481421040e115526b75317b5ca72584806

This commit is needed because it aligns the device tree name of U-Boot
and kernel which helps distro boot procedures (fdtfile as set by U-Boot
will match the kernel-provided dtb).

Signed-off-by: Marek Vasut <marex@denx.de>
Cc: Dinh Nguyen <dinguyen@kernel.org>
Cc: Jan Kiszka <jan.kiszka@siemens.com>
Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---

This has been sent and merged to 4.4-cip already.

 arch/arm/boot/dts/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
index b5bd3de87c33..1036d396da83 100644
--- a/arch/arm/boot/dts/Makefile
+++ b/arch/arm/boot/dts/Makefile
@@ -892,7 +892,7 @@ dtb-$(CONFIG_ARCH_SOCFPGA) += \
 	socfpga_arria10_socdk_sdmmc.dtb \
 	socfpga_cyclone5_mcvevk.dtb \
 	socfpga_cyclone5_socdk.dtb \
-	socfpga_cyclone5_de0_sockit.dtb \
+	socfpga_cyclone5_de0_nano_soc.dtb \
 	socfpga_cyclone5_sockit.dtb \
 	socfpga_cyclone5_socrates.dtb \
 	socfpga_cyclone5_sodia.dtb \
-- 
2.16.4
