Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7CDF4C38A05
	for <webhook@archiver.kernel.org>; Fri, 22 Apr 2022 16:52:00 +0000 (UTC)
Received: from mta-64-227.siemens.flowmailer.net
 (mta-64-227.siemens.flowmailer.net [185.136.64.227])
 by mx.groups.io with SMTP id smtpd.web10.5730.1650613663510585330
 for <cip-dev@lists.cip-project.org>;
 Fri, 22 Apr 2022 00:47:44 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=jan.kiszka@siemens.com header.s=fm1 header.b=hOScwAVR;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.64.227,
 mailfrom: fm-294854-20220422074739af48e5530f15b4816f-xfsmmq@rts-flowmailer.siemens.com)
Received: by mta-64-227.siemens.flowmailer.net with ESMTPSA id
 20220422074739af48e5530f15b4816f
        for <cip-dev@lists.cip-project.org>;
        Fri, 22 Apr 2022 09:47:40 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=jan.kiszka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc;
 bh=RYalGYGoxeXcpQTVZCagh3ikuSCfYJrkJnO+jfBDME0=;
 b=hOScwAVRbFinrIzEngs+wPg9vm0X/16HVJa/itxnqHKrNuL1lm1xcRHzWmugK6/mubrLP/
 a/hR7Mv5McbksQVpwSXVWbMxcxlk4+Vyi3Q6z8Gq+hwkCyxKWe7xSnUcYTLMCBi7WVqynS98
 /K0cdOJfTEV6t2BB7DpY4aw4DvtVc=;
From: Jan Kiszka <jan.kiszka@siemens.com>
To: cip-dev@lists.cip-project.org
Cc: Quirin Gylstorff <quirin.gylstorff@siemens.com>,
	Christian Storm <christian.storm@siemens.com>
Subject: [isar-cip-core][PATCH v2 0/6] Fix read-only rootfs setup /wrt etc
 overlay - and more
Date: Fri, 22 Apr 2022 09:47:32 +0200
Message-Id: <cover.1650613658.git.jan.kiszka@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-294854:519-21489:flowmailer
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 22 Apr 2022 16:52:00 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/8176

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

Jan Kiszka (6):
  wic: Align kernel command line of qemu-amd64-efibootguard*
  initramfs-abrootfs-hook: Convert to an initramfs-class recipe
  Convert /etc overlay from systemd mount unit to initramfs hook
  customizations: Relocate /root under /home
  initramfs-verify-hook: Optimize probing of partitions
  secureboot: Prevent getting shell on panic

 classes/image_uuid.bbclass                    |  6 +--
 classes/secure-wic-swu-img.bbclass            |  4 --
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
 22 files changed, 138 insertions(+), 178 deletions(-)
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


