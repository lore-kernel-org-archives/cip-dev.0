Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51F4FCCF9FD
	for <webhook@archiver.kernel.org>; Mon, 27 Oct 2025 07:22:02 +0000 (UTC)
Received: from mta-64-226.siemens.flowmailer.net (mta-64-226.siemens.flowmailer.net [185.136.64.226])
 by mx.groups.io with SMTP id smtpd.web11.26395.1761549712339687039
 for <cip-dev@lists.cip-project.org>;
 Mon, 27 Oct 2025 00:21:53 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=jan.kiszka@siemens.com header.s=fm2 header.b=L6KVkAQR;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.64.226, mailfrom: fm-294854-20251027072149e92b53cfd3000207da-zc4ucv@rts-flowmailer.siemens.com)
Received: by mta-64-226.siemens.flowmailer.net with ESMTPSA id 20251027072149e92b53cfd3000207da
        for <cip-dev@lists.cip-project.org>;
        Mon, 27 Oct 2025 08:21:49 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm2;
 d=siemens.com; i=jan.kiszka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding;
 bh=+Xws0Yk7ClpC9RY3K9sW/OY2phBkQnoOFl2Cqj3++cs=;
 b=L6KVkAQRCp2VT4TRa7sAlnCA/CW1rv/sSXz9lHS8c1m8Tv9LDpAuTHDQQBDcBMHGawsvzC
 GGffuvgBAnk9LO7Ob5u98WDagL2VKz3vQltBS7JlJaojMjEW+zZ1hFuit+MdufQMsTKA4ca1
 XCfWGYLfFmDJrm5RPMwIvtYXAZjX/DC8sCzR6cgdS/IwwoinKobpzWW3d50KbRAZnM5sB0tC
 pZgMm1KMnThgBoEjJ7uTAyQyZcqRELLCA1N1QBxULNSGR9vw4xbPD9KHS6vV66BauXWDpsMQ
 4cfejWSuhNbGhTBGvKhXgbxqZ1qlMXb2DceHJELDWXdeL6Vh3X8a1NUQ==;
From: Jan Kiszka <jan.kiszka@siemens.com>
To: cip-dev@lists.cip-project.org
Subject: [isar-cip-core][PATCH 00/19] Enable RPMB-base firmware stack with OP-TEE/fTPM/StMM for QEMU ARM64
Date: Mon, 27 Oct 2025 08:21:29 +0100
Message-ID: <cover.1761549708.git.jan.kiszka@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-294854:519-21489:flowmailer
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 27 Oct 2025 07:22:02 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/20230

While waiting for [1] to be merged into QEMU upstream, already enable
the qemu-arm64 target to make use of the RPMB emulation. We keep this
optional, though, not only because of its dependency on special QEMU at
this stage. We still need to support discrete TPM emulation for older
kernels.

Debugging the stack has revealed several issues. Most of them are fixed
now, but one is still under discussion [2]. This series addresses it by
disabling the hardware random number generator of the TPM for all CIP
kernels.

Jan

[1] https://patchwork.kernel.org/project/qemu-devel/list/?series=1012864
[2] https://lore.kernel.org/lkml/bbc41534-a2d9-42dc-ac8a-ff8a0b4fd41f@siemens.com/

Jan Kiszka (19):
  linux-cip: Update cip-kernel-config revision
  Update isar revision
  qemu-arm64: Add recipe for optee-ftpm
  qemu-arm64: Add optee-os 4.8.0
  qemu-arm64: Add recipe for TF-A
  u-boot: Add patch to fix sporadic build failures
  u-boot: Relocate or drop secure boot unrelated config switches
  u-boot-qemu: Add patches and config switch needed for eMMC boot
  u-boot: Prepare for different build dependency without built-in UEFI
    keys
  u-boot: Add optional support for fTPM/StMM
  cip-core-initramfs: Add initramfs-tee-ftpm-hook when needed
  Add class to generate eMMC image for QEMU
  qemu-arm64: Switch firmware provider to TF-A in fTPM/StMM mode
  customizations: Install efitools in secure boot mode
  kas: Add option for fTPM/StMM firmware mode
  start-qemu: Indention fixes
  start-qemu: Factor out -drive parameter in UEFI boot mode
  start-qemu: Add support for qemu-arm64 fTPM/StMM mode
  linux-cip: Disable CONFIG_HW_RANDOM_TPM in QEMU

 Kconfig                                       |  19 +++
 classes/qemu-emmc.bbclass                     |  43 ++++++
 conf/distro/cip-core-common.inc               |   2 +
 conf/layer.conf                               |   5 +-
 conf/machine/qemu-arm64.conf                  |   4 +-
 kas-cip.yml                                   |   2 +-
 kas/opt/ebg-swu.yml                           |   6 +-
 kas/opt/ftpm-stmm.yml                         |  16 +++
 ...ftpm-qemu-arm64_4.8+v1.62r1-48-ge9fc7b8.bb |  30 ++++
 .../optee-os/optee-os-qemu-arm64_4.8.0.bb     |  13 ++
 .../optee-os/optee-os-qemu-arm64_4.8.0.inc    |  18 +++
 recipes-bsp/optee-os/optee-os-qemu.inc        |  44 ++++++
 .../optee-os-tadevkit-qemu-arm64_4.8.0.bb     |  15 ++
 .../trusted-firmware-a-qemu-arm64_2.13.0.bb   |  40 ++++++
 ...onvert-SYS_EARLY_PCI_INIT-to-Kconfig.patch |  37 +++++
 ...ot-generate-logo-when-cross-building.patch |  33 +++++
 ...arm-Select-CONFIG_SYS_EARLY_PCI_INIT.patch |  28 ++++
 .../files/0003-test-Fix-optee-unit-test.patch | 134 ++++++++++++++++++
 recipes-bsp/u-boot/files/ftpm-stmm.cfg        |   5 +
 recipes-bsp/u-boot/files/qemu-extra.cfg       |   9 ++
 recipes-bsp/u-boot/files/secure-boot.cfg      |   6 +-
 recipes-bsp/u-boot/u-boot-common-2025.07.inc  |  30 +++-
 recipes-bsp/u-boot/u-boot-qemu-common.inc     |  14 +-
 recipes-core/customizations/customizations.bb |   4 +-
 .../cip-core-initramfs/cip-core-initramfs.bb  |   1 +
 recipes-kernel/linux/cip-kernel-config.inc    |   5 +-
 recipes-kernel/linux/files/no-tpm-hwrng.cfg   |   2 +
 start-qemu.sh                                 |  70 +++++----
 28 files changed, 587 insertions(+), 48 deletions(-)
 create mode 100644 classes/qemu-emmc.bbclass
 create mode 100644 kas/opt/ftpm-stmm.yml
 create mode 100644 recipes-bsp/optee-ftpm/optee-ftpm-qemu-arm64_4.8+v1.62r1-48-ge9fc7b8.bb
 create mode 100644 recipes-bsp/optee-os/optee-os-qemu-arm64_4.8.0.bb
 create mode 100644 recipes-bsp/optee-os/optee-os-qemu-arm64_4.8.0.inc
 create mode 100644 recipes-bsp/optee-os/optee-os-qemu.inc
 create mode 100644 recipes-bsp/optee-os/optee-os-tadevkit-qemu-arm64_4.8.0.bb
 create mode 100644 recipes-bsp/trusted-firmware-a/trusted-firmware-a-qemu-arm64_2.13.0.bb
 create mode 100644 recipes-bsp/u-boot/files/0001-Kconfig-Convert-SYS_EARLY_PCI_INIT-to-Kconfig.patch
 create mode 100644 recipes-bsp/u-boot/files/0001-tools-Do-not-generate-logo-when-cross-building.patch
 create mode 100644 recipes-bsp/u-boot/files/0002-qemu_arm-Select-CONFIG_SYS_EARLY_PCI_INIT.patch
 create mode 100644 recipes-bsp/u-boot/files/0003-test-Fix-optee-unit-test.patch
 create mode 100644 recipes-bsp/u-boot/files/ftpm-stmm.cfg
 create mode 100644 recipes-bsp/u-boot/files/qemu-extra.cfg
 create mode 100644 recipes-kernel/linux/files/no-tpm-hwrng.cfg

-- 
2.51.0


