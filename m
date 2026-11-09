Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.152])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.10681.1794196753574117977
 for <cip-dev@lists.cip-project.org>;
 Sun, 08 Nov 2026 19:59:15 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=nobuhiro.iwamatsu.x90@mail.toshiba header.s=key2.smx header.b=W12CT+Fa;
 spf=pass (domain: mail.toshiba, ip: 210.130.202.152, mailfrom: nobuhiro.iwamatsu.x90@mail.toshiba)
DKIM-Signature: v=1;a=rsa-sha256;c=relaxed/simple;d=mail.toshiba;h=From:To:Cc:
	Subject:Date:Message-Id;i=nobuhiro.iwamatsu.x90@mail.toshiba;s=key2.smx;t=
	1794196749;x=1795406349;bh=jGvYw3yRM4n4emP5E312Z8iWITeVEAhQ4439O1O3EXc=;b=W12
	CT+Fa81G7taj1Yyz4l5FIwKDGfLHJ3K9+1KFZS4+wSn/Kcim+ycqIZOGIOPw6FexCP0jWQ0ewnnzM
	vDY9wIdYIDlCDUDbc86Pl+2pkttAmBeysuq/xrxLl1cKPWaE7hGsGI8MdkxqMstkK1rATqSynqLLv
	jDCgshe5bZ3s1/rRlbIAz6A3Ez4nPR8SO+JGu4FmkX2rXS9kskvFg7bBrrhen98XmU6HpgVHCJ+cd
	UHLDMEUywHro7xcWGnrq9agbygz9oQP1qqITsY/ytOAvrGWQ24Qnw+yxUTGEkJ2h/WVVtU2pVg7vB
	2JXvg0h7XVJiCb6LD+Fjpu3Y1xf85Tg==;
Received: by mo-csw.securemx.jp (mx-mo-csw1802) id 6A93x8DX2030877; Mon, 9 Nov 2026 12:59:09 +0900
X-Iguazu-Qid: 2yAaXyEeU24dXj5zJn
X-Iguazu-QSIG: v=2; s=1; t=1794196748; q=2yAaXyEeU24dXj5zJn; m=3xq/OVklmcTlJsAq+ItmPvSooHysaBTtcJ06FzTbHAw=
Received: from imx2-a.toshiba.co.jp (imx2-a.toshiba.co.jp [106.186.93.35])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	 id 4jNGHc06QGzyPQ; Mon,  9 Nov 2026 12:59:07 +0900 (JST)
From: Nobuhiro Iwamatsu <nobuhiro.iwamatsu.x90@mail.toshiba>
To: jan.kiszka@siemens.com
Cc: cip-dev@lists.cip-project.org,
        Nobuhiro Iwamatsu <nobuhiro.iwamatsu.x90@mail.toshiba>
Subject: [isar-cip-core][PATCH v2 0/4] Fix build images for buster
Date: Mon,  9 Nov 2026 12:58:44 +0900
X-TSB-HOP2: ON
Message-Id: <1794196728-1876-1-git-send-email-nobuhiro.iwamatsu.x90@mail.toshiba>
X-Mailer: git-send-email 2.7.4
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by lin-tor-korg-lkml-alma10-1 with HTTPS for <cip-dev@lists.cip-project.org>; Mon, 09 Nov 2026 03:59:34 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/24674
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

This patch series fixes U-Boot build errors for images targeting buster.
The build errors occur because the version of GCC provided in 'buster' is 
incompatible with the requirements of U-Boot 2026.01.
This change adds U-Boot 2025.07 again. And when building 'buster'
images for the BBB or de0-nano-soc, version 2025.07 will be used.

v2:
  Fixed commit message. Change from 'revert' to 'add'.
  Removed unnecessary patches from the U-Boot for BBB and DE0-Nano-SoC.
  Removed the recipe for QEMU.

Nobuhiro Iwamatsu (4):
  u-boot: u-boot-common-2026.01: Add PV variable to the patch storage
    path
  u-boot: Add support 2025.07
  conf: de0-nano-soc: Set U-Boot version for 'buster' to 2025.07
  conf: bbb: Set U-Boot version for 'buster' to 2025.07

 conf/machine/bbb.conf                         |   2 +
 conf/machine/de0-nano-soc.conf                |   2 +
 ...-mach-socfpga-Fix-non-Agilex-targets.patch |  97 ++++++++
 ...ot-generate-logo-when-cross-building.patch |  33 +++
 ...sector-value-passed-to-mmc_load_imag.patch |  39 +++
 ...for-SYS_MMCSD_RAW_MODE_U_BOOT_USE_PA.patch |  90 +++++++
 ...cfpga-Adjust-a-raw-sectors-for-MMC-l.patch |  44 ++++
 ...onfigs-socfpga-Fix-de0_nano_soc-boot.patch |  31 +++
 ...6-configs-socfpga-Permit-EFI-booting.patch | 229 ++++++++++++++++++
 ...ustom-CPU-implementation-for-PolarFi.patch |   0
 ...missing-SPL_LOAD_BLOCK-for-SYS_MMCSD.patch |   0
 ...ement-Fix-compilation-for-non-sandbo.patch |   0
 ...SoC-level-options-to-the-CPU-Kconfig.patch |   0
 ...for-SYS_MMCSD_RAW_MODE_U_BOOT_USE_PA.patch |   0
 ...-out-service-enumeration-and-binding.patch |   0
 ...3-riscv-Add-support-for-BeagleV-Fire.patch |   0
 ...sector-value-passed-to-mmc_load_imag.patch |   0
 ...-optee-Avoid-binding-a-service-twice.patch |   0
 ...cfpga-Adjust-a-raw-sectors-for-MMC-l.patch |   0
 ...pport-for-enumerating-services-that-.patch |   0
 ...onfigs-socfpga-Fix-de0_nano_soc-boot.patch |   0
 ...-warn-about-TEE_ERROR_STORAGE_NOT_AV.patch |   0
 ...6-configs-socfpga-Permit-EFI-booting.patch |   0
 ...to-optee-after-a-successful-mmc_init.patch |   0
 ...-MMC-Device-not-found-a-debug-output.patch |   0
 recipes-bsp/u-boot/u-boot-bbb_2025.07.bb      |  27 +++
 recipes-bsp/u-boot/u-boot-common-2025.07.inc  |  68 ++++++
 recipes-bsp/u-boot/u-boot-common-2026.01.inc  |  32 +--
 .../u-boot/u-boot-de0-nano-soc_2025.07.bb     |  26 ++
 29 files changed, 704 insertions(+), 16 deletions(-)
 create mode 100644 recipes-bsp/u-boot/files/2025.07/0001-arch-arm-mach-socfpga-Fix-non-Agilex-targets.patch
 create mode 100644 recipes-bsp/u-boot/files/2025.07/0001-tools-Do-not-generate-logo-when-cross-building.patch
 create mode 100644 recipes-bsp/u-boot/files/2025.07/0002-spl-mmc-Respect-sector-value-passed-to-mmc_load_imag.patch
 create mode 100644 recipes-bsp/u-boot/files/2025.07/0003-spl-mmc-Account-for-SYS_MMCSD_RAW_MODE_U_BOOT_USE_PA.patch
 create mode 100644 recipes-bsp/u-boot/files/2025.07/0004-arch-arm-mach-socfpga-Adjust-a-raw-sectors-for-MMC-l.patch
 create mode 100644 recipes-bsp/u-boot/files/2025.07/0005-configs-socfpga-Fix-de0_nano_soc-boot.patch
 create mode 100644 recipes-bsp/u-boot/files/2025.07/0006-configs-socfpga-Permit-EFI-booting.patch
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
 create mode 100644 recipes-bsp/u-boot/u-boot-bbb_2025.07.bb
 create mode 100644 recipes-bsp/u-boot/u-boot-common-2025.07.inc
 create mode 100644 recipes-bsp/u-boot/u-boot-de0-nano-soc_2025.07.bb

-- 
2.55.0


