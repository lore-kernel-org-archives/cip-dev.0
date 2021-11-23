Return-Path: <quirin.gylstorff@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5954EC4167B
	for <webhook@archiver.kernel.org>; Tue, 23 Nov 2021 14:57:53 +0000 (UTC)
Received: from david.siemens.de (david.siemens.de [192.35.17.14])
 by mx.groups.io with SMTP id smtpd.web12.12314.1637679470971924855
 for <cip-dev@lists.cip-project.org>;
 Tue, 23 Nov 2021 06:57:51 -0800
Authentication-Results: mx.groups.io;
 dkim=missing;
 spf=pass (domain: siemens.com, ip: 192.35.17.14, mailfrom: quirin.gylstorff@siemens.com)
Received: from mail2.sbs.de (mail2.sbs.de [192.129.41.66])
	by david.siemens.de (8.15.2/8.15.2) with ESMTPS id 1ANEvmWq001041
	(version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <cip-dev@lists.cip-project.org>; Tue, 23 Nov 2021 15:57:48 +0100
Received: from md2dvrtc.fritz.box ([167.87.35.152])
	by mail2.sbs.de (8.15.2/8.15.2) with ESMTP id 1ANEvlct005894;
	Tue, 23 Nov 2021 15:57:48 +0100
From: "Q. Gylstorff" <Quirin.Gylstorff@siemens.com>
To: cip-dev@lists.cip-project.org, jan.kiszka@siemens.com,
        christian.storm@siemens.com
Subject: [cip-dev][isar-cip-core][RFC v3 0/9] Read-only root file system with
 dm-verity
Date: Tue, 23 Nov 2021 15:57:38 +0100
Message-Id: <20211123145747.101549-1-Quirin.Gylstorff@siemens.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 23 Nov 2021 14:57:53 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/6968

From: Quirin Gylstorff <quirin.gylstorff@siemens.com>

This patch series adds support for a read-only squashfs based root filesystem
wit SWUpdate support and secureboot.

The build is somewhat complex as we need the output of dm-verity to generate
the initramfs. The build is split in the following steps
1. Build the root file system
2. Generate a squashfs image - this can also be replace by another image format(e.g. ext4)
3. Build from the image the dm-verity partition and add it to the end of the image
4. Add the resulting verity environment to the initrd
5. Build the signed efi tool chain.

This series needs SWUpdate 2021.11. The necessary changes are currently backported.

Changes in V2:
 - rebase onto orgin/next
 - adapt Kconfig to new ebg-secure-boot-snakeoil.yml by deleting unnecessary options
 - Cleanup to support different file-systems for verity-img
   - tested with ext4 and squashfs
 - simplified kernel patching
   - prepend not necessary
   - added flag to enable/disable
 - whitespaces for readability
 - integrated into ebg-secure-boot-snakeoil
 - make behavior on corruption configurable during build time.
   - default is restart on corruption
 - add ISAR patch for correct permissions

Changes in V3:
 - Configurable size of /tmp
 - remove unnecessary overlay-parse-etc.service
 - convert etc-sysusers to drop in configuration of systemd-sysusers.service
 - extend commit messages


Quirin Gylstorff (9):
  Add new class to create a squashfs based root file system
  Add verity-img.bbclass for dm-verity based rootfs
  linux-cip-common: Add options necessary for dm-verity
  Create a initrd with support for dm-verity
  Create an read-only rootfs with dm-verity
  Create systemd mount units for a etc overlay
  Mount writable home partition
  kas: Patch isar for correct permissions in var and home
  swupdate: Backport patches from SWUpdate Master

 Kconfig                                       |   3 +-
 classes/secure-swupdate-img.bbclass           |  32 +++
 classes/squashfs-img.bbclass                  |  41 ++++
 classes/verity-img.bbclass                    |  73 +++++++
 kas-cip.yml                                   |   4 +
 kas/opt/ebg-secure-boot-base.yml              |   2 +
 kas/opt/ebg-secure-boot-snakeoil.yml          |  13 +-
 ...when-splitting-rootfs-folders-across.patch |  35 ++++
 .../etc-overlay-fs/etc-overlay-fs_0.1.bb      |  32 +++
 .../etc-overlay-fs/files/etc-hostname.service |  14 ++
 .../files/etc-sshd-regen-keys.conf            |   7 +
 .../etc-overlay-fs/files/etc-sysusers.conf    |   4 +
 recipes-core/etc-overlay-fs/files/etc.mount   |  13 ++
 recipes-core/etc-overlay-fs/files/postinst    |   4 +
 recipes-core/home-fs/files/home.mount         |  12 ++
 recipes-core/home-fs/files/postinst           |   3 +
 recipes-core/home-fs/home-fs_0.1.bb           |  20 ++
 .../images/cip-core-image-read-only.bb        |  22 ++
 ...an-patches-add-patches-for-dm-verity.patch | 191 ++++++++++++++++++
 .../swupdate/swupdate_2021.04-1+debian-gbp.bb |   5 +
 recipes-core/tmp-fs/files/postinst            |   3 +
 recipes-core/tmp-fs/files/tmp.mount.tmpl      |  11 +
 recipes-core/tmp-fs/tmp-fs_0.1.bb             |  26 +++
 .../cip-core-initramfs/cip-core-initramfs.bb  |  10 +-
 .../files/verity.conf-hook                    |   1 +
 .../initramfs-verity-hook/files/verity.hook   |  23 +++
 .../files/verity.script.tmpl                  |  68 +++++++
 .../initramfs-verity-hook_0.1.bb              |  51 +++++
 recipes-kernel/linux/files/verity.cfg         |   5 +
 recipes-kernel/linux/linux-cip-common.inc     |   4 +
 wic/qemu-amd64-efibootguard-secureboot.wks    |  11 -
 wic/qemu-amd64-efibootguard-secureboot.wks.in |  15 ++
 32 files changed, 739 insertions(+), 19 deletions(-)
 create mode 100644 classes/secure-swupdate-img.bbclass
 create mode 100644 classes/squashfs-img.bbclass
 create mode 100644 classes/verity-img.bbclass
 create mode 100644 patches/isar/0001-Fix-permissions-when-splitting-rootfs-folders-across.patch
 create mode 100644 recipes-core/etc-overlay-fs/etc-overlay-fs_0.1.bb
 create mode 100644 recipes-core/etc-overlay-fs/files/etc-hostname.service
 create mode 100644 recipes-core/etc-overlay-fs/files/etc-sshd-regen-keys.conf
 create mode 100644 recipes-core/etc-overlay-fs/files/etc-sysusers.conf
 create mode 100644 recipes-core/etc-overlay-fs/files/etc.mount
 create mode 100755 recipes-core/etc-overlay-fs/files/postinst
 create mode 100644 recipes-core/home-fs/files/home.mount
 create mode 100755 recipes-core/home-fs/files/postinst
 create mode 100644 recipes-core/home-fs/home-fs_0.1.bb
 create mode 100644 recipes-core/images/cip-core-image-read-only.bb
 create mode 100644 recipes-core/swupdate/files/0001-debian-patches-add-patches-for-dm-verity.patch
 create mode 100755 recipes-core/tmp-fs/files/postinst
 create mode 100644 recipes-core/tmp-fs/files/tmp.mount.tmpl
 create mode 100644 recipes-core/tmp-fs/tmp-fs_0.1.bb
 rename kas/opt/ebg-snakeoil-swu.yml => recipes-initramfs/cip-core-initramfs/cip-core-initramfs.bb (61%)
 create mode 100644 recipes-initramfs/initramfs-verity-hook/files/verity.conf-hook
 create mode 100644 recipes-initramfs/initramfs-verity-hook/files/verity.hook
 create mode 100644 recipes-initramfs/initramfs-verity-hook/files/verity.script.tmpl
 create mode 100644 recipes-initramfs/initramfs-verity-hook/initramfs-verity-hook_0.1.bb
 create mode 100644 recipes-kernel/linux/files/verity.cfg
 delete mode 100644 wic/qemu-amd64-efibootguard-secureboot.wks
 create mode 100644 wic/qemu-amd64-efibootguard-secureboot.wks.in

-- 
2.30.2


