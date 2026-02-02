Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D4CCE73164
	for <webhook@archiver.kernel.org>; Mon,  2 Feb 2026 12:57:57 +0000 (UTC)
Received: from mta-65-226.siemens.flowmailer.net (mta-65-226.siemens.flowmailer.net [185.136.65.226])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.51548.1770037072085842464
 for <cip-dev@lists.cip-project.org>;
 Mon, 02 Feb 2026 04:57:52 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=jan.kiszka@siemens.com header.s=fm2 header.b=B0Yy0Z3Y;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.65.226, mailfrom: fm-294854-20260202125749ab4fb141b700020794-olfge5@rts-flowmailer.siemens.com)
Received: by mta-65-226.siemens.flowmailer.net with ESMTPSA id 20260202125749ab4fb141b700020794
        for <cip-dev@lists.cip-project.org>;
        Mon, 02 Feb 2026 13:57:49 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm2;
 d=siemens.com; i=jan.kiszka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc;
 bh=zi0LzMP3mO34xfiy+m+Qla07VzTKYpt33pTLhnAxzD8=;
 b=B0Yy0Z3YAnba8vCRmLmZosHN7+Fni9hNqzTvYS8ftI3G7Hg7IkKdiyxYcc1VB+SaClOB4E
 IX3gsOwd8Pccy2D84FdlSqTgHxnV5A5wbek1e+VLJsdDmUMv6OGn1FmW8ISl0aBnctLYVrWV
 IzyrMf/qWKYAuOwOo+gJVx0ppCozB34Zos8/hSiQeVVufK2mL+H1OURSftuCqc6XyeLn8BFH
 4tQfz/I4d+0KdLg7WrF4w23JJspJfv9XbUnFo0GR9q+rPpN7/xdY4lj8zW+h/I1HMo7XLG+E
 J2aPN2uTwoD4MOrp/GE9GkPxkurM6aTqWDePTbOtRcbi5jUXGfrxbF7A==;
From: Jan Kiszka <jan.kiszka@siemens.com>
To: cip-dev@lists.cip-project.org
Cc: Sai Sree Kartheek Adivi <s-adivi@ti.com>
Subject: [isar-cip-core][PATCH 0/9] Add support for BeagleV-Fire
Date: Mon,  2 Feb 2026 13:57:39 +0100
Message-ID: <cover.1770037068.git.jan.kiszka@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-294854:519-21489:flowmailer
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 02 Feb 2026 12:57:57 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/21796

This enables support for the BeagleV-Fire in isar-cip-core, including
SWUpdate, only excluding secure boot so far.

Note that this comes with an update of our U-Boot version. I've tested
that on all but the TI AM62px (no hardware access) and would like ask
for support on that part.

Jan


CC: Sai Sree Kartheek Adivi <s-adivi@ti.com>

Jan Kiszka (9):
  Kconfig: Sort boards by architecture
  u-boot: Add U_BOOT_EXTRA_BUILDCMD to common rules.tmpl
  u-boot: Update to v2026.01
  Add hss-payload-generator recipe
  u-boot: Add recipe for BeagleV-Fire
  linux-cip: Update cip-kernel-config revision
  Add BeagleV-Fire board
  kas: Add BeagleV-Fire target
  ci: Add BeagleV-Fire build target

 .gitlab-ci.yml                                |   7 +
 Kconfig                                       |  26 +-
 conf/machine/beaglev-fire.conf                |  22 ++
 kas/board/beaglev-fire.yml                    |  12 +
 recipes-bsp/hss-payload-generator/files/rules |  22 ++
 .../hss-payload-generator_2025.07.bb          |  27 ++
 ...onvert-SYS_EARLY_PCI_INIT-to-Kconfig.patch |  37 --
 ...-mach-socfpga-Fix-non-Agilex-targets.patch |  97 -----
 ...KASLR-OPTEE-RNG-support-for-K3-devic.patch |  38 --
 ...ustom-CPU-implementation-for-PolarFi.patch | 153 ++++++++
 ...missing-SPL_LOAD_BLOCK-for-SYS_MMCSD.patch |  30 ++
 ...ot-generate-logo-when-cross-building.patch |  33 --
 ...arm-Select-CONFIG_SYS_EARLY_PCI_INIT.patch |  28 --
 ...SoC-level-options-to-the-CPU-Kconfig.patch |  83 +++++
 ...or-SYS_MMCSD_RAW_MODE_U_BOOT_USE_PA.patch} |  38 +-
 ...3-riscv-Add-support-for-BeagleV-Fire.patch | 346 ++++++++++++++++++
 ...ector-value-passed-to-mmc_load_imag.patch} |   6 +-
 .../files/0003-test-Fix-optee-unit-test.patch | 134 -------
 ...cfpga-Adjust-a-raw-sectors-for-MMC-l.patch |  16 +-
 ...onfigs-socfpga-Fix-de0_nano_soc-boot.patch |   4 +-
 ...6-configs-socfpga-Permit-EFI-booting.patch | 161 ++++----
 .../u-boot/files/beaglev-fire-config.yaml     |  17 +
 recipes-bsp/u-boot/files/rules.tmpl           |   1 +
 ...t-bbb_2025.07.bb => u-boot-bbb_2026.01.bb} |   0
 .../u-boot/u-boot-beaglev-fire_2026.01.bb     |  28 ++
 ...-2025.07.inc => u-boot-common-2026.01.inc} |  19 +-
 ...5.07.bb => u-boot-de0-nano-soc_2026.01.bb} |   0
 ...025.07.bb => u-boot-qemu-arm64_2026.01.bb} |   0
 ..._2025.07.bb => u-boot-qemu-arm_2026.01.bb} |   0
 ...5.07.bb => u-boot-qemu-riscv64_2026.01.bb} |   0
 ...5.07.bb => u-boot-ti-am62px-sk_2026.01.bb} |   1 -
 recipes-kernel/linux/cip-kernel-config.inc    |   2 +-
 wic/beaglev-fire-efibootguard.wks.in          |  20 +
 wic/beaglev-fire.wks                          |  14 +
 34 files changed, 924 insertions(+), 498 deletions(-)
 create mode 100644 conf/machine/beaglev-fire.conf
 create mode 100644 kas/board/beaglev-fire.yml
 create mode 100644 recipes-bsp/hss-payload-generator/files/rules
 create mode 100644 recipes-bsp/hss-payload-generator/hss-payload-generator_2025.07.bb
 delete mode 100644 recipes-bsp/u-boot/files/0001-Kconfig-Convert-SYS_EARLY_PCI_INIT-to-Kconfig.patch
 delete mode 100644 recipes-bsp/u-boot/files/0001-arch-arm-mach-socfpga-Fix-non-Agilex-targets.patch
 delete mode 100644 recipes-bsp/u-boot/files/0001-configs-KASLR-OPTEE-RNG-support-for-K3-devic.patch
 create mode 100644 recipes-bsp/u-boot/files/0001-riscv-create-a-custom-CPU-implementation-for-PolarFi.patch
 create mode 100644 recipes-bsp/u-boot/files/0001-spl-Kconfig-Add-missing-SPL_LOAD_BLOCK-for-SYS_MMCSD.patch
 delete mode 100644 recipes-bsp/u-boot/files/0001-tools-Do-not-generate-logo-when-cross-building.patch
 delete mode 100644 recipes-bsp/u-boot/files/0002-qemu_arm-Select-CONFIG_SYS_EARLY_PCI_INIT.patch
 create mode 100644 recipes-bsp/u-boot/files/0002-riscv-mpfs-move-SoC-level-options-to-the-CPU-Kconfig.patch
 rename recipes-bsp/u-boot/files/{0003-spl-mmc-Account-for-SYS_MMCSD_RAW_MODE_U_BOOT_USE_PA.patch => 0002-spl-mmc-Account-for-SYS_MMCSD_RAW_MODE_U_BOOT_USE_PA.patch} (67%)
 create mode 100644 recipes-bsp/u-boot/files/0003-riscv-Add-support-for-BeagleV-Fire.patch
 rename recipes-bsp/u-boot/files/{0002-spl-mmc-Respect-sector-value-passed-to-mmc_load_imag.patch => 0003-spl-mmc-Respect-sector-value-passed-to-mmc_load_imag.patch} (87%)
 delete mode 100644 recipes-bsp/u-boot/files/0003-test-Fix-optee-unit-test.patch
 create mode 100644 recipes-bsp/u-boot/files/beaglev-fire-config.yaml
 rename recipes-bsp/u-boot/{u-boot-bbb_2025.07.bb => u-boot-bbb_2026.01.bb} (100%)
 create mode 100644 recipes-bsp/u-boot/u-boot-beaglev-fire_2026.01.bb
 rename recipes-bsp/u-boot/{u-boot-common-2025.07.inc => u-boot-common-2026.01.inc} (76%)
 rename recipes-bsp/u-boot/{u-boot-de0-nano-soc_2025.07.bb => u-boot-de0-nano-soc_2026.01.bb} (100%)
 rename recipes-bsp/u-boot/{u-boot-qemu-arm64_2025.07.bb => u-boot-qemu-arm64_2026.01.bb} (100%)
 rename recipes-bsp/u-boot/{u-boot-qemu-arm_2025.07.bb => u-boot-qemu-arm_2026.01.bb} (100%)
 rename recipes-bsp/u-boot/{u-boot-qemu-riscv64_2025.07.bb => u-boot-qemu-riscv64_2026.01.bb} (100%)
 rename recipes-bsp/u-boot/{u-boot-ti-am62px-sk_2025.07.bb => u-boot-ti-am62px-sk_2026.01.bb} (98%)
 create mode 100644 wic/beaglev-fire-efibootguard.wks.in
 create mode 100644 wic/beaglev-fire.wks

-- 
2.51.0


