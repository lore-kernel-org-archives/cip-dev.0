From: jan.kiszka@siemens.com (Jan Kiszka)
Date: Tue, 2 Apr 2019 15:24:51 +0200
Subject: [cip-dev] [PATCH v2 4.19.y] ARM: dts: socfpga: Rename
 socfpga_cyclone5_de0_{sockit, nano_soc}
In-Reply-To: <a3b5f19e-00ba-fd0f-8ebe-bfa0c5782fe6@siemens.com>
References: <a3b5f19e-00ba-fd0f-8ebe-bfa0c5782fe6@siemens.com>
Message-ID: <756db9bb-1cef-0a6c-220d-35c387dd5a8a@siemens.com>
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

Sorry, missed to add the actual renaming hunk in v1.

 arch/arm/boot/dts/Makefile                                              | 2 +-
 ...ocfpga_cyclone5_de0_sockit.dts => socfpga_cyclone5_de0_nano_soc.dts} | 0
 2 files changed, 1 insertion(+), 1 deletion(-)
 rename arch/arm/boot/dts/{socfpga_cyclone5_de0_sockit.dts => socfpga_cyclone5_de0_nano_soc.dts} (100%)

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
diff --git a/arch/arm/boot/dts/socfpga_cyclone5_de0_sockit.dts b/arch/arm/boot/dts/socfpga_cyclone5_de0_nano_soc.dts
similarity index 100%
rename from arch/arm/boot/dts/socfpga_cyclone5_de0_sockit.dts
rename to arch/arm/boot/dts/socfpga_cyclone5_de0_nano_soc.dts
-- 
2.16.4
