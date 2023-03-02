Return-Path: <ncaidin@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5163DC7EE32
	for <webhook@archiver.kernel.org>; Thu,  2 Mar 2023 15:30:50 +0000 (UTC)
Received: from mta-65-225.siemens.flowmailer.net (mta-65-225.siemens.flowmailer.net [185.136.65.225])
 by mx.groups.io with SMTP id smtpd.web10.18825.1677770839975886577
 for <cip-dev@lists.cip-project.org>;
 Thu, 02 Mar 2023 07:27:20 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=felix.moessbauer@siemens.com header.s=fm1 header.b=ltL2vAp9;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.65.225, mailfrom: fm-72506-2023030215271663175485abfa589691-bm8_vk@rts-flowmailer.siemens.com)
Received: by mta-65-225.siemens.flowmailer.net with ESMTPSA id 2023030215271663175485abfa589691
        for <cip-dev@lists.cip-project.org>;
        Thu, 02 Mar 2023 16:27:16 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=felix.moessbauer@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc;
 bh=5P21x6V4AD3KyfNnQk9x82EUUS2htK6ZCkCBeiwXLoY=;
 b=ltL2vAp9ZjfYCCsu3WTOx1BrmDOyYnG2H7AZNbes9e9Y5zliBoWg+dEcl8xjnEqf9GPICT
 NX8kPUuD7pf93/c/i++cGKKNFqZYOq+QzSOKrzzh/tP56b+r8PcbVftnFvWi9eV4VbsJzWf9
 YI8G+1bjwBdNAZ6A8Frthw0X85bqs=;
From: Felix Moessbauer <felix.moessbauer@siemens.com>
To: cip-dev@lists.cip-project.org
Cc: daniel.bovensiepen@siemens.com,
	jan.kiszka@siemens.com,
	quirin.gylstorff@siemens.com,
	Felix Moessbauer <felix.moessbauer@siemens.com>
Subject: [isar-cip-core][PATCH v3 0/9] Add swupdate support for riscv64
Date: Thu,  2 Mar 2023 15:26:50 +0000
Message-Id: <20230302152659.2096307-1-felix.moessbauer@siemens.com>
MIME-Version: 1.0
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-72506:519-21489:flowmailer
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 02 Mar 2023 15:30:50 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/10875

Changes since v2:

The v2 adds the required infrastructure to test the swupdate support
in qemu-riscv64. This includes the following additions:

- update of cip kernel config for qemu-riscv64 machine (for non swu case)
- refactoring of u-boot deploy logic as preparation for next patches
- u-boot + opensbi firmware for qemu
- addition of linux 6.1 mainline kernel to support EFI boot of riscv64
  in qemu
- extension of start-qemu script to boot riscv64 with swupdate support

Changes since v1:

- rebased onto next
- ebg: fix changelog version (no <orig-version>)
- add swupdate support for qemu-riscv64

Please note: The EBG support in cip-core needs a major rework to be in
sync with the upstream debian package names. Currently, sid cannot be
updated to a more recent revision, as this breaks the build (multiple
packages with different names provide the same binary).

Best regards,
Felix Moessbauer
Siemens AG

Felix Moessbauer (9):
  fix efibootguard for riscv64
  update cip-kernel-config
  refactor(u-boot): deploy via sstate-cache
  wic(ebg): add support for riscv64
  add opensbi with u-boot payload for riscv64
  enhance qemu-riscv64 machine to be testable
  add linux 6.1 mainline kernel
  add swupdate support for qemu-riscv64
  start-qemu: add support for swupdate on RISC-V

 Kconfig                                       |  6 +-
 conf/machine/qemu-riscv64.conf                |  9 +-
 kas/opt/6.1-mainline.yml                      | 18 ++++
 kas/opt/ebg-swu.yml                           |  1 +
 recipes-bsp/efibootguard/efibootguard_0.13.bb |  3 +
 ...01-add-machine-type-name-for-riscv64.patch | 39 ++++++++
 recipes-bsp/opensbi/files/qemu-riscv64-rules  | 12 +++
 .../opensbi/opensbi-qemu-riscv64_1.2.bb       |  8 ++
 recipes-bsp/opensbi/opensbi.inc               | 45 ++++++++++
 ...iscv-Fix-build-against-binutils-2.38.patch | 55 ++++++++++++
 ...upport-building-double-float-modules.patch | 89 +++++++++++++++++++
 recipes-bsp/u-boot/u-boot-qemu-common.inc     | 14 ++-
 .../u-boot/u-boot-qemu-riscv64_2022.07.bb     | 23 +++++
 recipes-kernel/linux/files/squashfs.cfg       |  1 +
 recipes-kernel/linux/linux-cip-common.inc     |  2 +-
 recipes-kernel/linux/linux-mainline_6.1.bb    | 18 ++++
 .../wic/plugins/source/efibootguard-boot.py   |  6 +-
 .../wic/plugins/source/efibootguard-efi.py    |  6 +-
 start-qemu.sh                                 |  8 ++
 wic/qemu-riscv64-efibootguard.wks.in          | 13 +++
 20 files changed, 367 insertions(+), 9 deletions(-)
 create mode 100644 kas/opt/6.1-mainline.yml
 create mode 100644 recipes-bsp/efibootguard/files/0001-add-machine-type-name-for-riscv64.patch
 create mode 100644 recipes-bsp/opensbi/files/qemu-riscv64-rules
 create mode 100644 recipes-bsp/opensbi/opensbi-qemu-riscv64_1.2.bb
 create mode 100644 recipes-bsp/opensbi/opensbi.inc
 create mode 100644 recipes-bsp/u-boot/files/riscv64/0001-riscv-Fix-build-against-binutils-2.38.patch
 create mode 100644 recipes-bsp/u-boot/files/riscv64/0002-riscv-support-building-double-float-modules.patch
 create mode 100644 recipes-bsp/u-boot/u-boot-qemu-riscv64_2022.07.bb
 create mode 100644 recipes-kernel/linux/files/squashfs.cfg
 create mode 100644 recipes-kernel/linux/linux-mainline_6.1.bb
 create mode 100644 wic/qemu-riscv64-efibootguard.wks.in

-- 
2.34.1


