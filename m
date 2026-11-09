Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.131])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.10683.1794196753966011490
 for <cip-dev@lists.cip-project.org>;
 Sun, 08 Nov 2026 19:59:15 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=nobuhiro.iwamatsu.x90@mail.toshiba header.s=key2.smx header.b=rJBkwI9q;
 spf=pass (domain: mail.toshiba, ip: 210.130.202.131, mailfrom: nobuhiro.iwamatsu.x90@mail.toshiba)
DKIM-Signature: v=1;a=rsa-sha256;c=relaxed/simple;d=mail.toshiba;h=From:To:Cc:
	Subject:Date:Message-Id:In-Reply-To:References;i=
	nobuhiro.iwamatsu.x90@mail.toshiba;s=key2.smx;t=1794196749;x=1795406349;bh=OW
	TpNCCi0NWfMVkoYZjb4SJlYwdG32Pce/Ian1fDE1A=;b=rJBkwI9q47er0NtvRR7AS39tcQSZvFZN
	73cwdG2ReG1+/I/vMyCCA/Bd0e26jcRiInDZiqLFlBVsQsGHL0zZ0tkUadhiOv6Md3RLhokKyLeIf
	oFyYa/Hq3KDq1JbAIaj3ABk4+pHFGYors9bChG8T1veEpQvO/ovy/pkQGjzcStRrwxPerhwYvc1sL
	cBbyz7u2o9Oxj4syiXeOnwNp2J2bobSXZWnKe0+urrAZOqJqvzOz8vdpPA8mBk2waix5pmy7X8h/6
	AjZ8E6buFJjndMrpR339su1jo5n7tj5IbAk5hLztm+qGjyIrrLNFccMQBsthV3VqE74puM5GN0kyq
	KQ==;
Received: by mo-csw.securemx.jp (mx-mo-csw1120) id 6A93x9Si3094939; Mon, 9 Nov 2026 12:59:09 +0900
X-Iguazu-Qid: 2rWgYSPepmBVoN2BMX
X-Iguazu-QSIG: v=2; s=1; t=1794196749; q=2rWgYSPepmBVoN2BMX; m=7gGtSJodhLfYDEGNeE4McIVeAr6D/lVP6nQvBu5HW/c=
Received: from imx2-a.toshiba.co.jp (imx2-a.toshiba.co.jp [106.186.93.35])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	 id 4jNGHd02Vgz4vym; Mon,  9 Nov 2026 12:59:08 +0900 (JST)
From: Nobuhiro Iwamatsu <nobuhiro.iwamatsu.x90@mail.toshiba>
To: jan.kiszka@siemens.com
Cc: cip-dev@lists.cip-project.org,
        Nobuhiro Iwamatsu <nobuhiro.iwamatsu.x90@mail.toshiba>
Subject: [isar-cip-core][PATCH v2 1/4] u-boot: u-boot-common-2026.01: Add PV variable to the patch storage path
Date: Mon,  9 Nov 2026 12:58:45 +0900
X-TSB-HOP2: ON
Message-Id: <1794196728-1876-2-git-send-email-nobuhiro.iwamatsu.x90@mail.toshiba>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1794196728-1876-1-git-send-email-nobuhiro.iwamatsu.x90@mail.toshiba>
References: <1794196728-1876-1-git-send-email-nobuhiro.iwamatsu.x90@mail.toshiba>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by lin-tor-korg-lkml-alma10-1 with HTTPS for <cip-dev@lists.cip-project.org>; Mon, 09 Nov 2026 03:59:34 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/24672
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

To allow for the use of multiple versions, this sets the patch storage
location for the specified version to 'files/${PV}'.
And this moves patches to the 2026.01 directory.

Signed-off-by: Nobuhiro Iwamatsu <nobuhiro.iwamatsu.x90@mail.toshiba>
---

v2:
  no update.

 ...ustom-CPU-implementation-for-PolarFi.patch |  0
 ...missing-SPL_LOAD_BLOCK-for-SYS_MMCSD.patch |  0
 ...ement-Fix-compilation-for-non-sandbo.patch |  0
 ...SoC-level-options-to-the-CPU-Kconfig.patch |  0
 ...for-SYS_MMCSD_RAW_MODE_U_BOOT_USE_PA.patch |  0
 ...-out-service-enumeration-and-binding.patch |  0
 ...3-riscv-Add-support-for-BeagleV-Fire.patch |  0
 ...sector-value-passed-to-mmc_load_imag.patch |  0
 ...-optee-Avoid-binding-a-service-twice.patch |  0
 ...cfpga-Adjust-a-raw-sectors-for-MMC-l.patch |  0
 ...pport-for-enumerating-services-that-.patch |  0
 ...onfigs-socfpga-Fix-de0_nano_soc-boot.patch |  0
 ...-warn-about-TEE_ERROR_STORAGE_NOT_AV.patch |  0
 ...6-configs-socfpga-Permit-EFI-booting.patch |  0
 ...to-optee-after-a-successful-mmc_init.patch |  0
 ...-MMC-Device-not-found-a-debug-output.patch |  0
 recipes-bsp/u-boot/u-boot-common-2026.01.inc  | 32 +++++++++----------
 17 files changed, 16 insertions(+), 16 deletions(-)
 rename recipes-bsp/u-boot/files/{ => 2026.01}/0001-riscv-create-a-custom-CPU-implementation-for-PolarFi.patch (100%)
 rename recipes-bsp/u-boot/files/{ => 2026.01}/0001-spl-Kconfig-Add-missing-SPL_LOAD_BLOCK-for-SYS_MMCSD.patch (100%)
 rename recipes-bsp/u-boot/files/{ => 2026.01}/0001-test-boot-measurement-Fix-compilation-for-non-sandbo.patch (100%)
 rename recipes-bsp/u-boot/files/{ => 2026.01}/0002-riscv-mpfs-move-SoC-level-options-to-the-CPU-Kconfig.patch (100%)
 rename recipes-bsp/u-boot/files/{ => 2026.01}/0002-spl-mmc-Account-for-SYS_MMCSD_RAW_MODE_U_BOOT_USE_PA.patch (100%)
 rename recipes-bsp/u-boot/files/{ => 2026.01}/0002-tee-optee-Factor-out-service-enumeration-and-binding.patch (100%)
 rename recipes-bsp/u-boot/files/{ => 2026.01}/0003-riscv-Add-support-for-BeagleV-Fire.patch (100%)
 rename recipes-bsp/u-boot/files/{ => 2026.01}/0003-spl-mmc-Respect-sector-value-passed-to-mmc_load_imag.patch (100%)
 rename recipes-bsp/u-boot/files/{ => 2026.01}/0003-tee-optee-Avoid-binding-a-service-twice.patch (100%)
 rename recipes-bsp/u-boot/files/{ => 2026.01}/0004-arch-arm-mach-socfpga-Adjust-a-raw-sectors-for-MMC-l.patch (100%)
 rename recipes-bsp/u-boot/files/{ => 2026.01}/0004-tee-optee-Add-support-for-enumerating-services-that-.patch (100%)
 rename recipes-bsp/u-boot/files/{ => 2026.01}/0005-configs-socfpga-Fix-de0_nano_soc-boot.patch (100%)
 rename recipes-bsp/u-boot/files/{ => 2026.01}/0005-tee-optee-Do-not-warn-about-TEE_ERROR_STORAGE_NOT_AV.patch (100%)
 rename recipes-bsp/u-boot/files/{ => 2026.01}/0006-configs-socfpga-Permit-EFI-booting.patch (100%)
 rename recipes-bsp/u-boot/files/{ => 2026.01}/0006-mmc-Call-back-to-optee-after-a-successful-mmc_init.patch (100%)
 rename recipes-bsp/u-boot/files/{ => 2026.01}/0007-mmc-Make-MMC-Device-not-found-a-debug-output.patch (100%)

diff --git a/recipes-bsp/u-boot/files/0001-riscv-create-a-custom-CPU-implementation-for-PolarFi.patch b/recipes-bsp/u-boot/files/2026.01/0001-riscv-create-a-custom-CPU-implementation-for-PolarFi.patch
similarity index 100%
rename from recipes-bsp/u-boot/files/0001-riscv-create-a-custom-CPU-implementation-for-PolarFi.patch
rename to recipes-bsp/u-boot/files/2026.01/0001-riscv-create-a-custom-CPU-implementation-for-PolarFi.patch
diff --git a/recipes-bsp/u-boot/files/0001-spl-Kconfig-Add-missing-SPL_LOAD_BLOCK-for-SYS_MMCSD.patch b/recipes-bsp/u-boot/files/2026.01/0001-spl-Kconfig-Add-missing-SPL_LOAD_BLOCK-for-SYS_MMCSD.patch
similarity index 100%
rename from recipes-bsp/u-boot/files/0001-spl-Kconfig-Add-missing-SPL_LOAD_BLOCK-for-SYS_MMCSD.patch
rename to recipes-bsp/u-boot/files/2026.01/0001-spl-Kconfig-Add-missing-SPL_LOAD_BLOCK-for-SYS_MMCSD.patch
diff --git a/recipes-bsp/u-boot/files/0001-test-boot-measurement-Fix-compilation-for-non-sandbo.patch b/recipes-bsp/u-boot/files/2026.01/0001-test-boot-measurement-Fix-compilation-for-non-sandbo.patch
similarity index 100%
rename from recipes-bsp/u-boot/files/0001-test-boot-measurement-Fix-compilation-for-non-sandbo.patch
rename to recipes-bsp/u-boot/files/2026.01/0001-test-boot-measurement-Fix-compilation-for-non-sandbo.patch
diff --git a/recipes-bsp/u-boot/files/0002-riscv-mpfs-move-SoC-level-options-to-the-CPU-Kconfig.patch b/recipes-bsp/u-boot/files/2026.01/0002-riscv-mpfs-move-SoC-level-options-to-the-CPU-Kconfig.patch
similarity index 100%
rename from recipes-bsp/u-boot/files/0002-riscv-mpfs-move-SoC-level-options-to-the-CPU-Kconfig.patch
rename to recipes-bsp/u-boot/files/2026.01/0002-riscv-mpfs-move-SoC-level-options-to-the-CPU-Kconfig.patch
diff --git a/recipes-bsp/u-boot/files/0002-spl-mmc-Account-for-SYS_MMCSD_RAW_MODE_U_BOOT_USE_PA.patch b/recipes-bsp/u-boot/files/2026.01/0002-spl-mmc-Account-for-SYS_MMCSD_RAW_MODE_U_BOOT_USE_PA.patch
similarity index 100%
rename from recipes-bsp/u-boot/files/0002-spl-mmc-Account-for-SYS_MMCSD_RAW_MODE_U_BOOT_USE_PA.patch
rename to recipes-bsp/u-boot/files/2026.01/0002-spl-mmc-Account-for-SYS_MMCSD_RAW_MODE_U_BOOT_USE_PA.patch
diff --git a/recipes-bsp/u-boot/files/0002-tee-optee-Factor-out-service-enumeration-and-binding.patch b/recipes-bsp/u-boot/files/2026.01/0002-tee-optee-Factor-out-service-enumeration-and-binding.patch
similarity index 100%
rename from recipes-bsp/u-boot/files/0002-tee-optee-Factor-out-service-enumeration-and-binding.patch
rename to recipes-bsp/u-boot/files/2026.01/0002-tee-optee-Factor-out-service-enumeration-and-binding.patch
diff --git a/recipes-bsp/u-boot/files/0003-riscv-Add-support-for-BeagleV-Fire.patch b/recipes-bsp/u-boot/files/2026.01/0003-riscv-Add-support-for-BeagleV-Fire.patch
similarity index 100%
rename from recipes-bsp/u-boot/files/0003-riscv-Add-support-for-BeagleV-Fire.patch
rename to recipes-bsp/u-boot/files/2026.01/0003-riscv-Add-support-for-BeagleV-Fire.patch
diff --git a/recipes-bsp/u-boot/files/0003-spl-mmc-Respect-sector-value-passed-to-mmc_load_imag.patch b/recipes-bsp/u-boot/files/2026.01/0003-spl-mmc-Respect-sector-value-passed-to-mmc_load_imag.patch
similarity index 100%
rename from recipes-bsp/u-boot/files/0003-spl-mmc-Respect-sector-value-passed-to-mmc_load_imag.patch
rename to recipes-bsp/u-boot/files/2026.01/0003-spl-mmc-Respect-sector-value-passed-to-mmc_load_imag.patch
diff --git a/recipes-bsp/u-boot/files/0003-tee-optee-Avoid-binding-a-service-twice.patch b/recipes-bsp/u-boot/files/2026.01/0003-tee-optee-Avoid-binding-a-service-twice.patch
similarity index 100%
rename from recipes-bsp/u-boot/files/0003-tee-optee-Avoid-binding-a-service-twice.patch
rename to recipes-bsp/u-boot/files/2026.01/0003-tee-optee-Avoid-binding-a-service-twice.patch
diff --git a/recipes-bsp/u-boot/files/0004-arch-arm-mach-socfpga-Adjust-a-raw-sectors-for-MMC-l.patch b/recipes-bsp/u-boot/files/2026.01/0004-arch-arm-mach-socfpga-Adjust-a-raw-sectors-for-MMC-l.patch
similarity index 100%
rename from recipes-bsp/u-boot/files/0004-arch-arm-mach-socfpga-Adjust-a-raw-sectors-for-MMC-l.patch
rename to recipes-bsp/u-boot/files/2026.01/0004-arch-arm-mach-socfpga-Adjust-a-raw-sectors-for-MMC-l.patch
diff --git a/recipes-bsp/u-boot/files/0004-tee-optee-Add-support-for-enumerating-services-that-.patch b/recipes-bsp/u-boot/files/2026.01/0004-tee-optee-Add-support-for-enumerating-services-that-.patch
similarity index 100%
rename from recipes-bsp/u-boot/files/0004-tee-optee-Add-support-for-enumerating-services-that-.patch
rename to recipes-bsp/u-boot/files/2026.01/0004-tee-optee-Add-support-for-enumerating-services-that-.patch
diff --git a/recipes-bsp/u-boot/files/0005-configs-socfpga-Fix-de0_nano_soc-boot.patch b/recipes-bsp/u-boot/files/2026.01/0005-configs-socfpga-Fix-de0_nano_soc-boot.patch
similarity index 100%
rename from recipes-bsp/u-boot/files/0005-configs-socfpga-Fix-de0_nano_soc-boot.patch
rename to recipes-bsp/u-boot/files/2026.01/0005-configs-socfpga-Fix-de0_nano_soc-boot.patch
diff --git a/recipes-bsp/u-boot/files/0005-tee-optee-Do-not-warn-about-TEE_ERROR_STORAGE_NOT_AV.patch b/recipes-bsp/u-boot/files/2026.01/0005-tee-optee-Do-not-warn-about-TEE_ERROR_STORAGE_NOT_AV.patch
similarity index 100%
rename from recipes-bsp/u-boot/files/0005-tee-optee-Do-not-warn-about-TEE_ERROR_STORAGE_NOT_AV.patch
rename to recipes-bsp/u-boot/files/2026.01/0005-tee-optee-Do-not-warn-about-TEE_ERROR_STORAGE_NOT_AV.patch
diff --git a/recipes-bsp/u-boot/files/0006-configs-socfpga-Permit-EFI-booting.patch b/recipes-bsp/u-boot/files/2026.01/0006-configs-socfpga-Permit-EFI-booting.patch
similarity index 100%
rename from recipes-bsp/u-boot/files/0006-configs-socfpga-Permit-EFI-booting.patch
rename to recipes-bsp/u-boot/files/2026.01/0006-configs-socfpga-Permit-EFI-booting.patch
diff --git a/recipes-bsp/u-boot/files/0006-mmc-Call-back-to-optee-after-a-successful-mmc_init.patch b/recipes-bsp/u-boot/files/2026.01/0006-mmc-Call-back-to-optee-after-a-successful-mmc_init.patch
similarity index 100%
rename from recipes-bsp/u-boot/files/0006-mmc-Call-back-to-optee-after-a-successful-mmc_init.patch
rename to recipes-bsp/u-boot/files/2026.01/0006-mmc-Call-back-to-optee-after-a-successful-mmc_init.patch
diff --git a/recipes-bsp/u-boot/files/0007-mmc-Make-MMC-Device-not-found-a-debug-output.patch b/recipes-bsp/u-boot/files/2026.01/0007-mmc-Make-MMC-Device-not-found-a-debug-output.patch
similarity index 100%
rename from recipes-bsp/u-boot/files/0007-mmc-Make-MMC-Device-not-found-a-debug-output.patch
rename to recipes-bsp/u-boot/files/2026.01/0007-mmc-Make-MMC-Device-not-found-a-debug-output.patch
diff --git a/recipes-bsp/u-boot/u-boot-common-2026.01.inc b/recipes-bsp/u-boot/u-boot-common-2026.01.inc
index 60dffe0..49594b3 100644
--- a/recipes-bsp/u-boot/u-boot-common-2026.01.inc
+++ b/recipes-bsp/u-boot/u-boot-common-2026.01.inc
@@ -17,22 +17,22 @@ FILESPATH:append := ":${FILE_DIRNAME}/files"
 
 SRC_URI += " \
     https://git.u-boot-project.org/u-boot/u-boot/-/archive/v${PV}/u-boot-v${PV}.tar.bz2 \
-    file://0001-spl-Kconfig-Add-missing-SPL_LOAD_BLOCK-for-SYS_MMCSD.patch \
-    file://0002-spl-mmc-Account-for-SYS_MMCSD_RAW_MODE_U_BOOT_USE_PA.patch \
-    file://0003-spl-mmc-Respect-sector-value-passed-to-mmc_load_imag.patch \
-    file://0004-arch-arm-mach-socfpga-Adjust-a-raw-sectors-for-MMC-l.patch \
-    file://0005-configs-socfpga-Fix-de0_nano_soc-boot.patch \
-    file://0006-configs-socfpga-Permit-EFI-booting.patch \
-    file://0001-riscv-create-a-custom-CPU-implementation-for-PolarFi.patch \
-    file://0002-riscv-mpfs-move-SoC-level-options-to-the-CPU-Kconfig.patch \
-    file://0003-riscv-Add-support-for-BeagleV-Fire.patch \
-    file://0001-test-boot-measurement-Fix-compilation-for-non-sandbo.patch \
-    file://0002-tee-optee-Factor-out-service-enumeration-and-binding.patch \
-    file://0003-tee-optee-Avoid-binding-a-service-twice.patch \
-    file://0004-tee-optee-Add-support-for-enumerating-services-that-.patch \
-    file://0005-tee-optee-Do-not-warn-about-TEE_ERROR_STORAGE_NOT_AV.patch \
-    file://0006-mmc-Call-back-to-optee-after-a-successful-mmc_init.patch \
-    file://0007-mmc-Make-MMC-Device-not-found-a-debug-output.patch \
+    file://${PV}/0001-spl-Kconfig-Add-missing-SPL_LOAD_BLOCK-for-SYS_MMCSD.patch \
+    file://${PV}/0002-spl-mmc-Account-for-SYS_MMCSD_RAW_MODE_U_BOOT_USE_PA.patch \
+    file://${PV}/0003-spl-mmc-Respect-sector-value-passed-to-mmc_load_imag.patch \
+    file://${PV}/0004-arch-arm-mach-socfpga-Adjust-a-raw-sectors-for-MMC-l.patch \
+    file://${PV}/0005-configs-socfpga-Fix-de0_nano_soc-boot.patch \
+    file://${PV}/0006-configs-socfpga-Permit-EFI-booting.patch \
+    file://${PV}/0001-riscv-create-a-custom-CPU-implementation-for-PolarFi.patch \
+    file://${PV}/0002-riscv-mpfs-move-SoC-level-options-to-the-CPU-Kconfig.patch \
+    file://${PV}/0003-riscv-Add-support-for-BeagleV-Fire.patch \
+    file://${PV}/0001-test-boot-measurement-Fix-compilation-for-non-sandbo.patch \
+    file://${PV}/0002-tee-optee-Factor-out-service-enumeration-and-binding.patch \
+    file://${PV}/0003-tee-optee-Avoid-binding-a-service-twice.patch \
+    file://${PV}/0004-tee-optee-Add-support-for-enumerating-services-that-.patch \
+    file://${PV}/0005-tee-optee-Do-not-warn-about-TEE_ERROR_STORAGE_NOT_AV.patch \
+    file://${PV}/0006-mmc-Call-back-to-optee-after-a-successful-mmc_init.patch \
+    file://${PV}/0007-mmc-Make-MMC-Device-not-found-a-debug-output.patch \
     file://rules.tmpl;subdir=debian"
 SRC_URI[sha256sum] = "536c2204bb875236dcba41f5a5802090039a4b7a704dd284fcb9640e66a84a8a"
 
-- 
2.55.0


