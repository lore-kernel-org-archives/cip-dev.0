Return-Path: <quirin.gylstorff@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C56AC4321E
	for <webhook@archiver.kernel.org>; Fri, 12 Nov 2021 11:50:25 +0000 (UTC)
Received: from lizzard.sbs.de (lizzard.sbs.de [194.138.37.39])
 by mx.groups.io with SMTP id smtpd.web11.14652.1636717823604111544
 for <cip-dev@lists.cip-project.org>;
 Fri, 12 Nov 2021 03:50:24 -0800
Authentication-Results: mx.groups.io;
 dkim=missing;
 spf=pass (domain: siemens.com, ip: 194.138.37.39, mailfrom: quirin.gylstorff@siemens.com)
Received: from mail2.sbs.de (mail2.sbs.de [192.129.41.66])
	by lizzard.sbs.de (8.15.2/8.15.2) with ESMTPS id 1ACBoIbo028335
	(version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <cip-dev@lists.cip-project.org>; Fri, 12 Nov 2021 12:50:18 +0100
Received: from md2dvrtc.fritz.box ([167.87.35.150])
	by mail2.sbs.de (8.15.2/8.15.2) with ESMTP id 1ACBoHAf023845;
	Fri, 12 Nov 2021 12:50:18 +0100
From: "Q. Gylstorff" <Quirin.Gylstorff@siemens.com>
To: cip-dev@lists.cip-project.org, jan.kiszka@siemens.com
Subject: [cip-dev][isar-cip-core][RFC 0/8] Read-only root file system with
 dm-verity
Date: Fri, 12 Nov 2021 12:50:08 +0100
Message-Id: <20211112115017.401779-1-Quirin.Gylstorff@siemens.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 12 Nov 2021 11:50:25 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/6888

From: Quirin Gylstorff <quirin.gylstorff@siemens.com>

This patch series adds support for a read-only squashfs based root filesystem
wit SWUpdate support and secureboot.

The build is somewhat complex as we need the output of dm-verity to generate
the initramfs. The build is split in the following steps
1. We build the root file system
2. We generate a squashfs image - this can also be replace by another image format(e.g. ext4)
3. We build from the image the dm-verity partition and add it to the end of the image
4. We add the resulting verity environment to the initrd

We build the signed efi tool chain.

This series needs SWUpdate 2021.11. The necessary changes are currently backported.

Quirin Gylstorff (8):
  Add new class to create a squashfs based root file system
  Add classes for dm-verity based rootfs
  linux-cip-common: Add options necessary for dm-verity
  Create a initrd with support for dm-verity
  Create an read-only rootfs with dm-verity
  Create systemd mount units for a etc overlay
  Mount writable home partition
  swupdate: Backport patches from SWUpdate Master

 classes/squashfs-img.bbclass                  |  42 ++++
 classes/verity-img.bbclass                    |  73 +++++++
 classes/wic-verity-img.bbclass                |  23 +++
 kas/opt/verity.yml                            |  34 ++++
 .../etc-overlay-fs/etc-overlay-fs_0.1.bb      |  16 ++
 .../etc-overlay-fs/files/etc-hostname.service |  14 ++
 .../etc-overlay-fs/files/etc-sysusers.service |  14 ++
 recipes-core/etc-overlay-fs/files/etc.mount   |  13 ++
 .../files/overlay-parse-etc.service           |  12 ++
 recipes-core/etc-overlay-fs/files/postinst    |   6 +
 recipes-core/home-fs/files/home.mount         |  11 +
 recipes-core/home-fs/files/postinst           |   3 +
 recipes-core/home-fs/home-fs_0.1.bb           |  10 +
 .../images/cip-core-image-read-only.bb        |  26 +++
 .../0001-add-patches-for-dm-verity.patch      | 188 ++++++++++++++++++
 .../swupdate/swupdate_2021.04-1+debian-gbp.bb |   5 +
 recipes-core/tmp-fs/files/postinst            |   3 +
 recipes-core/tmp-fs/files/tmp.mount           |  11 +
 recipes-core/tmp-fs/tmp-fs_0.1.bb             |   9 +
 .../cip-core-initramfs/cip-core-initramfs.bb  |  16 ++
 .../files/verity.conf-hook                    |   1 +
 .../initramfs-verity-hook/files/verity.hook   |  23 +++
 .../initramfs-verity-hook/files/verity.script |  68 +++++++
 .../initramfs-verity-hook_0.1.bb              |  39 ++++
 recipes-kernel/linux/files/verity.cfg         |   5 +
 recipes-kernel/linux/linux-cip-common.inc     |   6 +
 wic/qemu-amd64-read-only.wks.in               |  15 ++
 27 files changed, 686 insertions(+)
 create mode 100644 classes/squashfs-img.bbclass
 create mode 100644 classes/verity-img.bbclass
 create mode 100644 classes/wic-verity-img.bbclass
 create mode 100644 kas/opt/verity.yml
 create mode 100644 recipes-core/etc-overlay-fs/etc-overlay-fs_0.1.bb
 create mode 100644 recipes-core/etc-overlay-fs/files/etc-hostname.service
 create mode 100644 recipes-core/etc-overlay-fs/files/etc-sysusers.service
 create mode 100644 recipes-core/etc-overlay-fs/files/etc.mount
 create mode 100644 recipes-core/etc-overlay-fs/files/overlay-parse-etc.service
 create mode 100755 recipes-core/etc-overlay-fs/files/postinst
 create mode 100644 recipes-core/home-fs/files/home.mount
 create mode 100755 recipes-core/home-fs/files/postinst
 create mode 100644 recipes-core/home-fs/home-fs_0.1.bb
 create mode 100644 recipes-core/images/cip-core-image-read-only.bb
 create mode 100644 recipes-core/swupdate/files/0001-add-patches-for-dm-verity.patch
 create mode 100755 recipes-core/tmp-fs/files/postinst
 create mode 100644 recipes-core/tmp-fs/files/tmp.mount
 create mode 100644 recipes-core/tmp-fs/tmp-fs_0.1.bb
 create mode 100644 recipes-initramfs/cip-core-initramfs/cip-core-initramfs.bb
 create mode 100644 recipes-initramfs/initramfs-verity-hook/files/verity.conf-hook
 create mode 100644 recipes-initramfs/initramfs-verity-hook/files/verity.hook
 create mode 100644 recipes-initramfs/initramfs-verity-hook/files/verity.script
 create mode 100644 recipes-initramfs/initramfs-verity-hook/initramfs-verity-hook_0.1.bb
 create mode 100644 recipes-kernel/linux/files/verity.cfg
 create mode 100644 wic/qemu-amd64-read-only.wks.in

-- 
2.30.2


