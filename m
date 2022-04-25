Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13B38C636C8
	for <webhook@archiver.kernel.org>; Mon, 25 Apr 2022 19:26:14 +0000 (UTC)
Received: from mta-65-225.siemens.flowmailer.net
 (mta-65-225.siemens.flowmailer.net [185.136.65.225])
 by mx.groups.io with SMTP id smtpd.web11.28122.1650887389131597805
 for <cip-dev@lists.cip-project.org>;
 Mon, 25 Apr 2022 04:49:50 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=jan.kiszka@siemens.com header.s=fm1 header.b=ZwSDElmg;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.65.225,
 mailfrom: fm-294854-202204251149454189ec7fd336b29394-t_jpkr@rts-flowmailer.siemens.com)
Received: by mta-65-225.siemens.flowmailer.net with ESMTPSA id
 202204251149454189ec7fd336b29394
        for <cip-dev@lists.cip-project.org>;
        Mon, 25 Apr 2022 13:49:45 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=jan.kiszka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc;
 bh=MlsPR0AFXrUBUIfXyKOjM294N82FMsGaQS509aYuds0=;
 b=ZwSDElmgshWKK/e5r0tx6mZkuQz1oaMUe8WqrnpdZw3eQOzTS8vXe7w+9yLrsnFdUGpHUN
 oxX7cVfH3D9BAz/F/3FL3YTVVgoiATKBNp5mnsmJcf9nLWy6gXuqlQMqB/468TtHONLYfOfb
 78SPJZIU9wC0v4GJAD+YSn9arSDoU=;
From: Jan Kiszka <jan.kiszka@siemens.com>
To: cip-dev@lists.cip-project.org
Cc: Quirin Gylstorff <quirin.gylstorff@siemens.com>,
	Christian Storm <christian.storm@siemens.com>
Subject: [isar-cip-core][PATCH v3 0/7] Fix read-only rootfs setup /wrt etc
 overlay - and more
Date: Mon, 25 Apr 2022 13:49:37 +0200
Message-Id: <cover.1650887383.git.jan.kiszka@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-294854:519-21489:flowmailer
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 25 Apr 2022 19:26:14 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/8196

Changes in v3:
 - create DEPLOY_DIR_IMAGE paths when needed in image-uuid and squashfs
   classes
 - drop not longer needed image_do_mounts from image-uuid

Changes in v2:
 - panic on /var mounting failure during overlay setup
 - panic-reboot on initramfs failures in secure mode
 - /root persistence
 - faster rootfs selection under dm-verity

This addresses the problem of current read-only rootfs + /etc overlay as
used for the SWUpdate setups.

Due to ordering issues in systemd startup between machine-id handling
vs. making /etc writable via the overlay, various things are broken down
the line, e.g. journal reporting. Reading [1], it appeared to be best to
move the overlay mounting into the initramfs. And this implementation
proves this to be right: simpler and working smoothly.

As a by-product, this also unifies the initramfs-abrootfs-hook, and
makes it simpler as well.

Furthermore, this plugs a hole in the secure boot process if the
initramfs fails (we got a shell then), makes /root persistent and
optimizes the rootfs selection via dm-verity.

Jan

[1] https://www.spinics.net/lists/systemd-devel/msg05670.html

Jan Kiszka (7):
  wic: Align kernel command line of qemu-amd64-efibootguard*
  initramfs-abrootfs-hook: Convert to an initramfs-class recipe
  squashfs-img: Make sure DEPLOY_DIR_IMAGE exists
  Convert /etc overlay from systemd mount unit to initramfs hook
  customizations: Relocate /root under /home
  initramfs-verify-hook: Optimize probing of partitions
  secureboot: Prevent getting shell on panic

 classes/image_uuid.bbclass                    | 11 +++--
 classes/secure-wic-swu-img.bbclass            |  4 --
 classes/squashfs-img.bbclass                  |  1 +
 classes/wic-swu-img.bbclass                   |  6 ++-
 kas/opt/ebg-secure-boot-snakeoil.yml          |  1 +
 kas/opt/ebg-swu.yml                           |  2 +-
 recipes-core/customizations/files/postinst    |  4 ++
 .../etc-overlay-fs/etc-overlay-fs_0.1.bb      | 32 -------------
 .../etc-overlay-fs/files/etc-hostname.service | 14 ------
 .../files/etc-sshd-regen-keys.conf            |  6 ---
 .../etc-overlay-fs/files/etc-sysusers.conf    |  4 --
 recipes-core/etc-overlay-fs/files/etc.mount   | 13 ------
 recipes-core/etc-overlay-fs/files/postinst    |  4 --
 .../cip-core-initramfs/cip-core-initramfs.bb  |  2 +-
 .../{initramfs.lsblk.hook => abrootfs.hook}   | 11 ++---
 .../files/abrootfs.script}                    | 46 +++++++++----------
 .../files/initramfs.image_uuid.hook           | 33 -------------
 .../initramfs-abrootfs-hook/files/postinst    |  6 ---
 .../initramfs-abrootfs-hook_0.1.bb            | 41 ++++++++++-------
 .../files/etc-overlay.script                  | 34 ++++++++++++++
 .../initramfs-etc-overlay-hook_0.1.bb         | 27 +++++++++++
 .../files/verity.script.tmpl                  | 18 ++++++--
 wic/qemu-amd64-efibootguard-secureboot.wks.in |  2 +-
 23 files changed, 142 insertions(+), 180 deletions(-)
 delete mode 100644 recipes-core/etc-overlay-fs/etc-overlay-fs_0.1.bb
 delete mode 100644 recipes-core/etc-overlay-fs/files/etc-hostname.service
 delete mode 100644 recipes-core/etc-overlay-fs/files/etc-sshd-regen-keys.conf
 delete mode 100644 recipes-core/etc-overlay-fs/files/etc-sysusers.conf
 delete mode 100644 recipes-core/etc-overlay-fs/files/etc.mount
 delete mode 100755 recipes-core/etc-overlay-fs/files/postinst
 rename recipes-initramfs/initramfs-abrootfs-hook/files/{initramfs.lsblk.hook => abrootfs.hook} (62%)
 copy recipes-initramfs/{initramfs-verity-hook/files/verity.script.tmpl => initramfs-abrootfs-hook/files/abrootfs.script} (53%)
 delete mode 100644 recipes-initramfs/initramfs-abrootfs-hook/files/initramfs.image_uuid.hook
 delete mode 100644 recipes-initramfs/initramfs-abrootfs-hook/files/postinst
 create mode 100644 recipes-initramfs/initramfs-etc-overlay-hook/files/etc-overlay.script
 create mode 100644 recipes-initramfs/initramfs-etc-overlay-hook/initramfs-etc-overlay-hook_0.1.bb

-- 
2.34.1


