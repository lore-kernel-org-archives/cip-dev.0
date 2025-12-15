Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E117D5B171
	for <webhook@archiver.kernel.org>; Mon, 15 Dec 2025 06:26:42 +0000 (UTC)
Received: from mta-65-225.siemens.flowmailer.net (mta-65-225.siemens.flowmailer.net [185.136.65.225])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.42432.1765779992285270864
 for <cip-dev@lists.cip-project.org>;
 Sun, 14 Dec 2025 22:26:33 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=jan.kiszka@siemens.com header.s=fm2 header.b=M0i+5U7V;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.65.225, mailfrom: fm-294854-20251215062629fa85b8fd6000020729-wi1rrg@rts-flowmailer.siemens.com)
Received: by mta-65-225.siemens.flowmailer.net with ESMTPSA id 20251215062629fa85b8fd6000020729
        for <cip-dev@lists.cip-project.org>;
        Mon, 15 Dec 2025 07:26:29 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm2;
 d=siemens.com; i=jan.kiszka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding;
 bh=6t65BkWnjI1LJUV8ya011Xgfttx3XeqNRHb9vCbqK2I=;
 b=M0i+5U7VhpzYsD/eHmYbLJsQXKp54hA+ll8TSClXVPS+exTrsoXd0LLgpaW7sm9TkBxXk3
 44EU0RDXuJ/SVrESpj1GkGlUdYJ01dK8hTL/OYe1d+p/LKTTT8X9+A9s9OUzfdODWK1+tkve
 +z90m7XNRvbjAeeWwQFe85I6bKiYUgrXxKiZMXbgngltqAEqK33vnRGTRYuOPrWPyCBvHLHU
 sE5R21YBYsB8VjNYaugndxPh6Uf76cJZndfd9vofJ5jw6AeDyhC2ooa4m/Q/Cen54SumtBy2
 BcOyd8WPMTSSZDjkpwXgu50QcLkRPoYsB7cxwC7ju7KeaG+D1mBZs7Bw==;
From: Jan Kiszka <jan.kiszka@siemens.com>
To: cip-dev@lists.cip-project.org
Subject: [isar-cip-core][PATCH 0/4] Isar and kernel updates
Date: Mon, 15 Dec 2025 07:26:23 +0100
Message-ID: <cover.1765779987.git.jan.kiszka@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-294854:519-21489:flowmailer
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 15 Dec 2025 06:26:42 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/21028

Nothing spectacular, see patches.

Jan

Jan Kiszka (4):
  linux-cip: Update to 5.10.247-cip67 and 6.1.159-cip49
  swupdate: Drop redundant template class inheritance
  Update isar revision
  Migrate all classes to classes-recipe

 .../delta-update.bbclass                      |   0
 .../deploy-firmware.bbclass                   |   0
 .../efibootguard.bbclass                      |   0
 {classes => classes-recipe}/erofs.bbclass     |   0
 .../image_uuid.bbclass                        |   0
 {classes => classes-recipe}/qemu-emmc.bbclass |   0
 .../read-only-rootfs.bbclass                  |   0
 {classes => classes-recipe}/swupdate.bbclass  |   2 -
 {classes => classes-recipe}/verity.bbclass    |   0
 ...custom-built-image-name-to-standard-.patch | 134 ++++++++++++++++++
 ...ling-of-initrd-generation-if-there-i.patch |  39 -----
 ...revious-naming-scheme-in-INITRD_DEPL.patch |  32 -----
 kas-cip.yml                                   |   7 +-
 .../optee-os/optee-os-qemu-arm64_4.8.0.bb     |   3 +-
 .../optee-os-tadevkit-qemu-arm64_4.8.0.bb     |   3 +-
 .../optee-os/optee-os-tadevkit-ti-k3_4.8.0.bb |   3 +-
 recipes-bsp/optee-os/optee-os-ti-k3_4.8.0.bb  |   3 +-
 .../trusted-firmware-a-qemu-arm64_2.13.0.bb   |   3 +-
 .../trusted-firmware-a-ti-k3_2.13.bb          |   2 +-
 recipes-bsp/u-boot/u-boot-common-2025.07.inc  |   2 +-
 .../initramfs-abrootfs-hook_0.3.bb            |   2 +-
 .../initramfs-crypt-hook_0.10.bb              |   2 +-
 .../initramfs-erofs-hook_0.2.bb               |   2 +-
 .../initramfs-factory-reset-hook_0.2.bb       |   3 +-
 .../initramfs-overlay-hook_0.4.bb             |   2 +-
 .../initramfs-squashfs-hook_0.2.bb            |   2 +-
 .../initramfs-verity-hook_0.3.bb              |   2 +-
 recipes-kernel/linux/linux-cip-common.inc     |   3 +-
 ...6-cip66.bb => linux-cip_5.10.247-cip67.bb} |   2 +-
 ...57-cip48.bb => linux-cip_6.1.159-cip49.bb} |   2 +-
 30 files changed, 159 insertions(+), 96 deletions(-)
 rename {classes => classes-recipe}/delta-update.bbclass (100%)
 rename {classes => classes-recipe}/deploy-firmware.bbclass (100%)
 rename {classes => classes-recipe}/efibootguard.bbclass (100%)
 rename {classes => classes-recipe}/erofs.bbclass (100%)
 rename {classes => classes-recipe}/image_uuid.bbclass (100%)
 rename {classes => classes-recipe}/qemu-emmc.bbclass (100%)
 rename {classes => classes-recipe}/read-only-rootfs.bbclass (100%)
 rename {classes => classes-recipe}/swupdate.bbclass (99%)
 rename {classes => classes-recipe}/verity.bbclass (100%)
 create mode 100644 isar-patches/0001-initramfs-Align-custom-built-image-name-to-standard-.patch
 delete mode 100644 isar-patches/0001-rootfs-Fix-disabling-of-initrd-generation-if-there-i.patch
 delete mode 100644 isar-patches/0002-rootfs-Restore-previous-naming-scheme-in-INITRD_DEPL.patch
 rename recipes-kernel/linux/{linux-cip_5.10.246-cip66.bb => linux-cip_5.10.247-cip67.bb} (68%)
 rename recipes-kernel/linux/{linux-cip_6.1.157-cip48.bb => linux-cip_6.1.159-cip49.bb} (59%)

-- 
2.51.0


