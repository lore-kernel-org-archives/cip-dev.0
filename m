Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.134])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.2272.1793956079347342759
 for <cip-dev@lists.cip-project.org>;
 Fri, 06 Nov 2026 01:08:00 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=nobuhiro.iwamatsu.x90@mail.toshiba header.s=key2.smx header.b=b4nr0AsP;
 spf=pass (domain: mail.toshiba, ip: 210.130.202.134, mailfrom: nobuhiro.iwamatsu.x90@mail.toshiba)
DKIM-Signature: v=1;a=rsa-sha256;c=relaxed/simple;d=mail.toshiba;h=From:To:Cc:
	Subject:Date:Message-Id;i=nobuhiro.iwamatsu.x90@mail.toshiba;s=key2.smx;t=
	1793956076;x=1795165676;bh=wH+zYgkLopC++Ktz9mWjrfN8U6wol1sfzyS5j9ej7sQ=;b=b4n
	r0AsPT/doYC817S7SPJsI0CYyUUWiNYJypp+K7xtSs4+9pcacXE0EI6CTUgbULuJYzeEMpOPRIf9a
	Ft68NWUMx/S8lGVMDYXx5/AKk7C6snN3lS1tHI4H2OUlzTOKJA4L3fszqU3DM/hTKGx8hvLDoqKVr
	/xVp3blbzGL+Y7jbLBG9UgYOIsJxhSGbzWqEn7IdxYYhJPXgQ6StQcxLas9dCcz25Fx7bZ3RyAhfZ
	Lgd8/ZqK66+M/g/vC6+KJ5tQugs3ktSaL9zZXxdIzpCoM2xcSRmZFyl5UtyrQFSXhScgxmWc2pcKP
	mKL8QJ+XpIeumozkg44w2t/GQrqldCA==;
Received: by mo-csw.securemx.jp (mx-mo-csw1800) id 6A697ubP2713409; Fri, 6 Nov 2026 18:07:56 +0900
X-Iguazu-Qid: 2yAb07c3D7uAFP4MRI
X-Iguazu-QSIG: v=2; s=1; t=1793956076; q=2yAb07c3D7uAFP4MRI; m=+slI6/sSWjgXZhxJp3Hh4hq0xVoPxaTfRjGgjMnNZDc=
Received: from imx12-a.toshiba.co.jp (unknown [38.106.60.135])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	 id 4jLYHJ1nY6z1xnh; Fri,  6 Nov 2026 18:07:55 +0900 (JST)
From: Nobuhiro Iwamatsu <nobuhiro.iwamatsu.x90@mail.toshiba>
To: jan.kiszka@siemens.com
Cc: cip-dev@lists.cip-project.org,
        Nobuhiro Iwamatsu <nobuhiro.iwamatsu.x90@mail.toshiba>
Subject: [isar-cip-core][RFC PATCH 0/4] Fix build images for buster
Date: Fri,  6 Nov 2026 18:07:41 +0900
X-TSB-HOP2: ON
Message-Id: <1793956065-3316-1-git-send-email-nobuhiro.iwamatsu.x90@mail.toshiba>
X-Mailer: git-send-email 2.7.4
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by lin-tor-korg-lkml-alma10-1 with HTTPS for <cip-dev@lists.cip-project.org>; Fri, 06 Nov 2026 09:08:02 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/24657
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

This patch series fixes U-Boot build errors for images targeting buster.
The build errors occur because the version of GCC provided in 'buster' is 
incompatible with the requirements of U-Boot 2026.01.
This change reverts U-Boot to version 2025.07. And when building 'buster'
images for the BBB or de0-nano-soc, version 2025.07 will be used.

Nobuhiro Iwamatsu (4):
  u-boot: u-boot-common-2026.01: Add PV variable to the patch storage
    path
  u-boot: Revert 2025.07
  conf: de0-nano-soc: Set U-Boot version for 'buster' to 2025.07
  conf: bbb: Set U-Boot version for 'buster' to 2025.07

 conf/machine/bbb.conf                         |   2 +
 conf/machine/de0-nano-soc.conf                |   2 +
 ...onvert-SYS_EARLY_PCI_INIT-to-Kconfig.patch |  37 +++
 ...-mach-socfpga-Fix-non-Agilex-targets.patch |  97 ++++++++
 ...KASLR-OPTEE-RNG-support-for-K3-devic.patch |  38 +++
 ...ot-generate-logo-when-cross-building.patch |  33 +++
 ...arm-Select-CONFIG_SYS_EARLY_PCI_INIT.patch |  28 +++
 ...sector-value-passed-to-mmc_load_imag.patch |  39 +++
 ...for-SYS_MMCSD_RAW_MODE_U_BOOT_USE_PA.patch |  90 +++++++
 .../0003-test-Fix-optee-unit-test.patch       | 134 ++++++++++
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
 recipes-bsp/u-boot/u-boot-common-2025.07.inc  |  71 ++++++
 recipes-bsp/u-boot/u-boot-common-2026.01.inc  |  32 +--
 .../u-boot/u-boot-de0-nano-soc_2025.07.bb     |  26 ++
 .../u-boot/u-boot-qemu-arm64_2025.07.bb       |  17 ++
 recipes-bsp/u-boot/u-boot-qemu-arm_2025.07.bb |  17 ++
 .../u-boot/u-boot-qemu-riscv64_2025.07.bb     |  20 ++
 .../u-boot/u-boot-ti-am62px-sk_2025.07.bb     |  64 +++++
 37 files changed, 1062 insertions(+), 16 deletions(-)
 create mode 100644 recipes-bsp/u-boot/files/2025.07/0001-Kconfig-Convert-SYS_EARLY_PCI_INIT-to-Kconfig.patch
 create mode 100644 recipes-bsp/u-boot/files/2025.07/0001-arch-arm-mach-socfpga-Fix-non-Agilex-targets.patch
 create mode 100644 recipes-bsp/u-boot/files/2025.07/0001-configs-KASLR-OPTEE-RNG-support-for-K3-devic.patch
 create mode 100644 recipes-bsp/u-boot/files/2025.07/0001-tools-Do-not-generate-logo-when-cross-building.patch
 create mode 100644 recipes-bsp/u-boot/files/2025.07/0002-qemu_arm-Select-CONFIG_SYS_EARLY_PCI_INIT.patch
 create mode 100644 recipes-bsp/u-boot/files/2025.07/0002-spl-mmc-Respect-sector-value-passed-to-mmc_load_imag.patch
 create mode 100644 recipes-bsp/u-boot/files/2025.07/0003-spl-mmc-Account-for-SYS_MMCSD_RAW_MODE_U_BOOT_USE_PA.patch
 create mode 100644 recipes-bsp/u-boot/files/2025.07/0003-test-Fix-optee-unit-test.patch
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
 create mode 100644 recipes-bsp/u-boot/u-boot-qemu-arm64_2025.07.bb
 create mode 100644 recipes-bsp/u-boot/u-boot-qemu-arm_2025.07.bb
 create mode 100644 recipes-bsp/u-boot/u-boot-qemu-riscv64_2025.07.bb
 create mode 100644 recipes-bsp/u-boot/u-boot-ti-am62px-sk_2025.07.bb

-- 
2.55.0


