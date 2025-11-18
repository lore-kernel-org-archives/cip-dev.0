Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9A7CCED24D
	for <webhook@archiver.kernel.org>; Tue, 18 Nov 2025 06:09:17 +0000 (UTC)
Received: from mta-64-226.siemens.flowmailer.net (mta-64-226.siemens.flowmailer.net [185.136.64.226])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.6479.1763446149162924405
 for <cip-dev@lists.cip-project.org>;
 Mon, 17 Nov 2025 22:09:10 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=jan.kiszka@siemens.com header.s=fm1 header.b=SOY7GTa3;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.64.226, mailfrom: fm-294854-202511180609051400c59c720002078a-q8ik6b@rts-flowmailer.siemens.com)
Received: by mta-64-226.siemens.flowmailer.net with ESMTPSA id 202511180609051400c59c720002078a
        for <cip-dev@lists.cip-project.org>;
        Tue, 18 Nov 2025 07:09:06 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=jan.kiszka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding;
 bh=ckywE0kgxeYiDIDMwdJdANRqonxDuhRbfMBG9tHqZf0=;
 b=SOY7GTa33iKR1MvrirGDIGX9C5CnenFE1gGiHBkblU2MKgnY2boRfXFjpSiRzpqgG025qj
 oOd3serSEw/2wSdeM3twO/ynuzNzXDl1ttiLftpLTYW2Z26SAZuFf37XPrwAqkCZUAehatIy
 QF5X0UyzzW9SJlNvjy1zUXZYw0jikcwNTJgdgjSXo6uoSG9es8wc6AE8Eip4VQUy5Tn4krtN
 aUvYMdYpIFn/T7MkW8JTsT799vlpfDzKdchyzhPFWvBrBX3QudO5U1FyY79NgRp7C12f61SQ
 0W3OpxWDXZw0gHG1S/MKpmDEIAInfrGOt8WHtyHG1bFDdV/RJeNS1sCQ==;
From: Jan Kiszka <jan.kiszka@siemens.com>
To: cip-dev@lists.cip-project.org
Subject: [isar-cip-core][PATCH 0/4] Add DE0-Nano-SoC reference board
Date: Tue, 18 Nov 2025 07:09:00 +0100
Message-ID: <cover.1763446144.git.jan.kiszka@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-294854:519-21489:flowmailer
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 18 Nov 2025 06:09:17 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/20608

We have this target in kernel testing but we were lacking the rather
simple integration into isar-cip-core for image testing. Thanks to its
support to load also the firmware from SD card, it would have been easy
to get our EFI-based boot enabled - if upstream U-Boot didn't regress.
All addressed towards upstream and packaged with this series.

Jan

Jan Kiszka (4):
  u-boot: Add recipe for DE0-Nano-SoC
  Add DE0-Nano-SoC machine
  kas: Hook up DE0-Nano-SoC board
  ci: Add DE0-Nano-SoC board

 .gitlab-ci.yml                                |   7 +
 Kconfig                                       |   8 +-
 conf/machine/de0-nano-soc.conf                |  19 ++
 kas/board/de0-nano-soc.yml                    |  15 ++
 ...-mach-socfpga-Fix-non-Agilex-targets.patch |  97 ++++++++
 ...sector-value-passed-to-mmc_load_imag.patch |  39 +++
 ...for-SYS_MMCSD_RAW_MODE_U_BOOT_USE_PA.patch |  90 +++++++
 ...cfpga-Adjust-a-raw-sectors-for-MMC-l.patch |  44 ++++
 ...onfigs-socfpga-Fix-de0_nano_soc-boot.patch |  31 +++
 ...6-configs-socfpga-Permit-EFI-booting.patch | 229 ++++++++++++++++++
 recipes-bsp/u-boot/u-boot-common-2025.07.inc  |   6 +
 .../u-boot/u-boot-de0-nano-soc_2025.07.bb     |  26 ++
 .../plugins/source/de0-nano-soc-firmware.py   |  31 +++
 wic/de0-nano-soc-efibootguard.wks.in          |  20 ++
 wic/de0-nano-soc.wks                          |  14 ++
 15 files changed, 675 insertions(+), 1 deletion(-)
 create mode 100644 conf/machine/de0-nano-soc.conf
 create mode 100644 kas/board/de0-nano-soc.yml
 create mode 100644 recipes-bsp/u-boot/files/0001-arch-arm-mach-socfpga-Fix-non-Agilex-targets.patch
 create mode 100644 recipes-bsp/u-boot/files/0002-spl-mmc-Respect-sector-value-passed-to-mmc_load_imag.patch
 create mode 100644 recipes-bsp/u-boot/files/0003-spl-mmc-Account-for-SYS_MMCSD_RAW_MODE_U_BOOT_USE_PA.patch
 create mode 100644 recipes-bsp/u-boot/files/0004-arch-arm-mach-socfpga-Adjust-a-raw-sectors-for-MMC-l.patch
 create mode 100644 recipes-bsp/u-boot/files/0005-configs-socfpga-Fix-de0_nano_soc-boot.patch
 create mode 100644 recipes-bsp/u-boot/files/0006-configs-socfpga-Permit-EFI-booting.patch
 create mode 100644 recipes-bsp/u-boot/u-boot-de0-nano-soc_2025.07.bb
 create mode 100644 scripts/lib/wic/plugins/source/de0-nano-soc-firmware.py
 create mode 100644 wic/de0-nano-soc-efibootguard.wks.in
 create mode 100644 wic/de0-nano-soc.wks

-- 
2.51.0


