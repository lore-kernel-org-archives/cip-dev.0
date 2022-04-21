Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C57B2C83039
	for <webhook@archiver.kernel.org>; Thu, 21 Apr 2022 16:46:12 +0000 (UTC)
Received: from mta-65-225.siemens.flowmailer.net
 (mta-65-225.siemens.flowmailer.net [185.136.65.225])
 by mx.groups.io with SMTP id smtpd.web10.20272.1650541967604504930
 for <cip-dev@lists.cip-project.org>;
 Thu, 21 Apr 2022 04:52:48 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=jan.kiszka@siemens.com header.s=fm1 header.b=iy6NUEDt;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.65.225,
 mailfrom: fm-294854-2022042111524457a765168c6f35807e-m_1kf2@rts-flowmailer.siemens.com)
Received: by mta-65-225.siemens.flowmailer.net with ESMTPSA id
 2022042111524457a765168c6f35807e
        for <cip-dev@lists.cip-project.org>;
        Thu, 21 Apr 2022 13:52:44 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=jan.kiszka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc;
 bh=aUEJ8DmeZdSwDeD48ifTYltP/tLEUCbHWu2IxtsLAgk=;
 b=iy6NUEDt0DQutWLn6tlGgDpZ7oI1dH/jCDeePpjN2Q+WDVDNdWDwzRNv7Db82PCjb0+f9W
 NxhX9LqlMOTwUUz2JgpTT2y30Q/sqkk+pBARmnZbSSu7TL6u/ysCY8e6+kB8Te6WrZ0Rd7kI
 KOeB3ei1lXEAmFDNWMTWUatfUnUMg=;
From: Jan Kiszka <jan.kiszka@siemens.com>
To: cip-dev@lists.cip-project.org
Cc: Quirin Gylstorff <quirin.gylstorff@siemens.com>,
	Christian Storm <christian.storm@siemens.com>
Subject: [isar-cip-core][PATCH 0/3] Fix read-only rootfs setup /wrt etc
 overlay
Date: Thu, 21 Apr 2022 13:52:40 +0200
Message-Id: <cover.1650541963.git.jan.kiszka@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-294854:519-21489:flowmailer
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 21 Apr 2022 16:46:12 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/8168

This addresses the problem of current read-only rootfs + /etc overlay as
used for the SWUpdate setups.

Due to ordering issues in systemd startup between machine-id handling
vs. making /etc writable via the overlay, various things are broken down
the line, e.g. journal reporting. Reading [1], it appeared to be best to
move the overlay mounting into the initramfs. And this implementation
proves this to be right: simpler and working smoothly.

As a by-product, this also unifies the initramfs-abrootfs-hook, and
makes it simpler as well.

Jan

[1] https://www.spinics.net/lists/systemd-devel/msg05670.html

Jan Kiszka (3):
  wic: Align kernel command line of qemu-amd64-efibootguard*
  initramfs-abrootfs-hook: Convert to an initramfs-class recipe
  Convert /etc overlay from systemd mount unit to initramfs hook

 classes/image_uuid.bbclass                    |  6 +-
 classes/secure-wic-swu-img.bbclass            |  4 --
 classes/wic-swu-img.bbclass                   |  6 +-
 kas/opt/ebg-secure-boot-snakeoil.yml          |  1 +
 kas/opt/ebg-swu.yml                           |  2 +-
 .../etc-overlay-fs/etc-overlay-fs_0.1.bb      | 32 ---------
 .../etc-overlay-fs/files/etc-hostname.service | 14 ----
 .../files/etc-sshd-regen-keys.conf            |  6 --
 .../etc-overlay-fs/files/etc-sysusers.conf    |  4 --
 recipes-core/etc-overlay-fs/files/etc.mount   | 13 ----
 recipes-core/etc-overlay-fs/files/postinst    |  4 --
 .../cip-core-initramfs/cip-core-initramfs.bb  |  2 +-
 .../{initramfs.lsblk.hook => abrootfs.hook}   | 11 +---
 .../files/abrootfs.script                     | 66 +++++++++++++++++++
 .../files/initramfs.image_uuid.hook           | 33 ----------
 .../initramfs-abrootfs-hook/files/postinst    |  6 --
 .../initramfs-abrootfs-hook_0.1.bb            | 41 +++++++-----
 .../files/etc-overlay.script                  | 24 +++++++
 .../initramfs-etc-overlay-hook_0.1.bb         | 27 ++++++++
 wic/qemu-amd64-efibootguard-secureboot.wks.in |  2 +-
 20 files changed, 156 insertions(+), 148 deletions(-)
 delete mode 100644 recipes-core/etc-overlay-fs/etc-overlay-fs_0.1.bb
 delete mode 100644 recipes-core/etc-overlay-fs/files/etc-hostname.service
 delete mode 100644 recipes-core/etc-overlay-fs/files/etc-sshd-regen-keys.conf
 delete mode 100644 recipes-core/etc-overlay-fs/files/etc-sysusers.conf
 delete mode 100644 recipes-core/etc-overlay-fs/files/etc.mount
 delete mode 100755 recipes-core/etc-overlay-fs/files/postinst
 rename recipes-initramfs/initramfs-abrootfs-hook/files/{initramfs.lsblk.hook => abrootfs.hook} (62%)
 create mode 100644 recipes-initramfs/initramfs-abrootfs-hook/files/abrootfs.script
 delete mode 100644 recipes-initramfs/initramfs-abrootfs-hook/files/initramfs.image_uuid.hook
 delete mode 100644 recipes-initramfs/initramfs-abrootfs-hook/files/postinst
 create mode 100644 recipes-initramfs/initramfs-etc-overlay-hook/files/etc-overlay.script
 create mode 100644 recipes-initramfs/initramfs-etc-overlay-hook/initramfs-etc-overlay-hook_0.1.bb

-- 
2.34.1


