From: jan.kiszka@siemens.com (Jan Kiszka)
Date: Mon, 10 Dec 2018 11:25:06 +0100
Subject: [cip-dev] [PATCH 4.4-cip v2] ARM: dts: socfpga: Rename
 socfpga_cyclone5_de0_{sockit, nano_soc}
Message-ID: <b9e891af-405c-57b4-ae67-d61b2d989f7a@siemens.com>
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

Changes in v2:
 - enhance upstream commit log with reason to adopt the patch

 arch/arm/boot/dts/Makefile                                              | 2 +-
 ...ocfpga_cyclone5_de0_sockit.dts => socfpga_cyclone5_de0_nano_soc.dts} | 0
 2 files changed, 1 insertion(+), 1 deletion(-)
 rename arch/arm/boot/dts/{socfpga_cyclone5_de0_sockit.dts => socfpga_cyclone5_de0_nano_soc.dts} (100%)

diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
index e0a0deaacd48..9871a7f0f92a 100644
--- a/arch/arm/boot/dts/Makefile
+++ b/arch/arm/boot/dts/Makefile
@@ -562,7 +562,7 @@ dtb-$(CONFIG_ARCH_SOCFPGA) += \
 	socfpga_arria5_socdk.dtb \
 	socfpga_arria10_socdk_sdmmc.dtb \
 	socfpga_cyclone5_socdk.dtb \
-	socfpga_cyclone5_de0_sockit.dtb \
+	socfpga_cyclone5_de0_nano_soc.dtb \
 	socfpga_cyclone5_sockit.dtb \
 	socfpga_cyclone5_socrates.dtb \
 	socfpga_vt.dtb
diff --git a/arch/arm/boot/dts/socfpga_cyclone5_de0_sockit.dts b/arch/arm/boot/dts/socfpga_cyclone5_de0_nano_soc.dts
similarity index 100%
rename from arch/arm/boot/dts/socfpga_cyclone5_de0_sockit.dts
rename to arch/arm/boot/dts/socfpga_cyclone5_de0_nano_soc.dts
-- 
2.16.4
