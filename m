Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C549AC43219
	for <webhook@archiver.kernel.org>; Thu,  5 May 2022 16:43:38 +0000 (UTC)
Received: from mta-64-228.siemens.flowmailer.net
 (mta-64-228.siemens.flowmailer.net [185.136.64.228])
 by mx.groups.io with SMTP id smtpd.web12.13763.1651769014769415961
 for <cip-dev@lists.cip-project.org>;
 Thu, 05 May 2022 09:43:35 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=jan.kiszka@siemens.com header.s=fm1 header.b=SpzTOXxj;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.64.228,
 mailfrom: fm-294854-20220505164330f665da23cbe78b5fdf-pnv_jn@rts-flowmailer.siemens.com)
Received: by mta-64-228.siemens.flowmailer.net with ESMTPSA id
 20220505164330f665da23cbe78b5fdf
        for <cip-dev@lists.cip-project.org>;
        Thu, 05 May 2022 18:43:31 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=jan.kiszka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc;
 bh=u60ABZor/tYHZnwOxzx0DXVEvwhi6rGt36qaMgV9GSw=;
 b=SpzTOXxjIVo1S/L7shsX4QekFR3wzi/povyntR6t8GAWVqNjsXg3cWYWuuRAb9WOh2I6Mf
 ayPAcffdwXlS9dZhSItD1JyBF9LAMWeki0yAFTyiIKczPuGsRaFK43TaU16hmScAMnY6DcVa
 w1pFFoasbVfHE6/P9VYD/IIPHvg3E=;
From: Jan Kiszka <jan.kiszka@siemens.com>
To: cip-dev@lists.cip-project.org
Cc: Quirin Gylstorff <quirin.gylstorff@siemens.com>,
	Christian Storm <christian.storm@siemens.com>
Subject: [isar-cip-core][PATCH v2 00/13] Fixes and improvements for SWUpdate
 images, kernel/config update
Date: Thu,  5 May 2022 18:43:16 +0200
Message-Id: <cover.1651769009.git.jan.kiszka@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-294854:519-21489:flowmailer
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 05 May 2022 16:43:38 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/8259

Changes in v2:
- add plugin fix for empty command line case

Various update and enhancement I try to summarize here:
- qemu-arm64 enabling for SWUpdate/secure boot using the UEFI pattern
- update to EFI Boot Guard 0.11
- switch to unified kernel images built by EFI Boot Guard
- fix for verity setups with CONFIG_DM_VERITY=m
- improve error handling when mounting /etc overlay
- update to latest CIP kernels and cip-kernel-config

Jan

Jan Kiszka (13):
  initramfs-etc-overlay-hook: Improve error reporting of script
  initramfs-etc-overlay-hook: Install overlay module
  initramfs-abrootfs-hook: Remove obsolete patch
  Rework secure boot key handling and signing recipes
  linux-cip: Update cip-kernel-config for QEMU and ipc227e
  linux-cip: Update to 4.19.239-cip72 and 5.10.112-cip6
  efibootguard: Update to 0.11 release
  efibootguard: Fix empty command line case
  efibootguard: Use new unified kernel image generation
  efibootguard: Add support for embedding DTBs into unified kernel
    images
  u-boot-qemu-arm64: Add recipe for customized version based on 2022.04
  Enable SWUpdate with and w/o secure boot for QEMU arm64
  start-qemu.sh: Add support for SWUpdate and secure boot mode to arm64

 Kconfig                                       |   6 +-
 conf/machine/qemu-arm64.conf                  |   3 +
 doc/README.secureboot.md                      |  22 ++--
 kas/opt/ebg-secure-boot-snakeoil.yml          |  10 +-
 kas/opt/efibootguard.yml                      |   6 +-
 ...bootguard_0.10.bb => efibootguard_0.11.bb} |   4 +-
 ...efile-Drop-nostdinc-for-EFI-binaries.patch |  28 +++++
 .../0001-configure-Fix-aarch64-EFI-arch.patch |  28 -----
 .../efibootguard/files/debian/control.tmpl    |   2 +-
 .../files/debian/efibootguard.install         |   3 +-
 ...-rtc_mktime-and-mktime64-Y2038-ready.patch | 107 ++++++++++++++++++
 recipes-bsp/u-boot/files/rules                |  40 +++++++
 recipes-bsp/u-boot/files/secure-boot.cfg      |   6 +
 .../u-boot/u-boot-qemu-arm64_2022.04.bb       |  50 ++++++++
 .../ebg-secure-boot-secrets_0.1.bb            |  51 ---------
 .../ebg-secure-boot-secrets/files/README.md   |   1 -
 .../files/control.tmpl                        |  12 --
 .../files/sign_secure_image.sh.tmpl           |  22 ----
 .../ebg-secure-boot-signer_0.1.bb             |  26 +++++
 .../files/sign_secure_image.sh                |  33 ++++++
 .../ebg-secure-boot-snakeoil_0.1.bb           |  34 ------
 .../files/control.tmpl                        |  12 --
 .../files/sign_secure_image.sh                |  36 ------
 .../files/PkKek-1-snakeoil.key                |  27 +++++
 .../files/PkKek-1-snakeoil.pem                |  21 ++++
 .../secure-boot-key_0.1.bb                    |  14 +++
 .../secure-boot-secrets.inc                   |  34 ++++++
 .../secure-boot-snakeoil_0.1.bb               |  17 +++
 .../files/debian-local-patch                  | 103 -----------------
 .../files/etc-overlay.hook                    |  25 ++++
 .../files/etc-overlay.script                  |   4 +-
 .../initramfs-etc-overlay-hook_0.1.bb         |   3 +
 recipes-kernel/linux/linux-cip-common.inc     |   2 +-
 ...5-cip70.bb => linux-cip_4.19.239-cip72.bb} |   2 +-
 ...106-cip4.bb => linux-cip_5.10.112-cip6.bb} |   2 +-
 .../wic/plugins/source/efibootguard-boot.py   |  44 ++++---
 start-qemu.sh                                 |  67 +++++++----
 wic/qemu-arm64-efibootguard-secureboot.wks.in |  15 +++
 wic/qemu-arm64-efibootguard.wks.in            |  13 +++
 39 files changed, 559 insertions(+), 376 deletions(-)
 rename recipes-bsp/efibootguard/{efibootguard_0.10.bb => efibootguard_0.11.bb} (90%)
 create mode 100644 recipes-bsp/efibootguard/files/0001-Makefile-Drop-nostdinc-for-EFI-binaries.patch
 delete mode 100644 recipes-bsp/efibootguard/files/0001-configure-Fix-aarch64-EFI-arch.patch
 create mode 100644 recipes-bsp/u-boot/files/0001-lib-date-Make-rtc_mktime-and-mktime64-Y2038-ready.patch
 create mode 100755 recipes-bsp/u-boot/files/rules
 create mode 100644 recipes-bsp/u-boot/files/secure-boot.cfg
 create mode 100644 recipes-bsp/u-boot/u-boot-qemu-arm64_2022.04.bb
 delete mode 100644 recipes-devtools/ebg-secure-boot-secrets/ebg-secure-boot-secrets_0.1.bb
 delete mode 100644 recipes-devtools/ebg-secure-boot-secrets/files/README.md
 delete mode 100644 recipes-devtools/ebg-secure-boot-secrets/files/control.tmpl
 delete mode 100644 recipes-devtools/ebg-secure-boot-secrets/files/sign_secure_image.sh.tmpl
 create mode 100644 recipes-devtools/ebg-secure-boot-signer/ebg-secure-boot-signer_0.1.bb
 create mode 100644 recipes-devtools/ebg-secure-boot-signer/files/sign_secure_image.sh
 delete mode 100644 recipes-devtools/ebg-secure-boot-snakeoil/ebg-secure-boot-snakeoil_0.1.bb
 delete mode 100644 recipes-devtools/ebg-secure-boot-snakeoil/files/control.tmpl
 delete mode 100644 recipes-devtools/ebg-secure-boot-snakeoil/files/sign_secure_image.sh
 create mode 100644 recipes-devtools/secure-boot-secrets/files/PkKek-1-snakeoil.key
 create mode 100644 recipes-devtools/secure-boot-secrets/files/PkKek-1-snakeoil.pem
 create mode 100644 recipes-devtools/secure-boot-secrets/secure-boot-key_0.1.bb
 create mode 100644 recipes-devtools/secure-boot-secrets/secure-boot-secrets.inc
 create mode 100644 recipes-devtools/secure-boot-secrets/secure-boot-snakeoil_0.1.bb
 delete mode 100644 recipes-initramfs/initramfs-abrootfs-hook/files/debian-local-patch
 create mode 100644 recipes-initramfs/initramfs-etc-overlay-hook/files/etc-overlay.hook
 rename recipes-kernel/linux/{linux-cip_4.19.235-cip70.bb => linux-cip_4.19.239-cip72.bb} (72%)
 rename recipes-kernel/linux/{linux-cip_5.10.106-cip4.bb => linux-cip_5.10.112-cip6.bb} (72%)
 create mode 100644 wic/qemu-arm64-efibootguard-secureboot.wks.in
 create mode 100644 wic/qemu-arm64-efibootguard.wks.in

-- 
2.34.1


