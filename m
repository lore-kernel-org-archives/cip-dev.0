Return-Path: <quirin.gylstorff@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD60BC67861
	for <webhook@archiver.kernel.org>; Tue,  9 Apr 2024 13:06:50 +0000 (UTC)
Received: from mta-64-226.siemens.flowmailer.net (mta-64-226.siemens.flowmailer.net [185.136.64.226])
 by mx.groups.io with SMTP id smtpd.web11.136238.1712668002562720833
 for <cip-dev@lists.cip-project.org>;
 Tue, 09 Apr 2024 06:06:43 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=Quirin.Gylstorff@siemens.com header.s=fm1 header.b=dd4Zq8wc;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.64.226, mailfrom: fm-51332-202404091306391a2438efa0d4df752d-cwgld4@rts-flowmailer.siemens.com)
Received: by mta-64-226.siemens.flowmailer.net with ESMTPSA id 202404091306391a2438efa0d4df752d
        for <cip-dev@lists.cip-project.org>;
        Tue, 09 Apr 2024 15:06:40 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=Quirin.Gylstorff@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding;
 bh=AP/N/IEFfCoOJYR6BdrZXBuoo14CfqCTKDJGRVYWcKw=;
 b=dd4Zq8wcIRYg1ZaH5hmJAY1Ap7USsMZSgncSvI0gYlrV0qKtRnNGxdSiuoN34goUY57gkF
 egjW7JhtLo2Sk8n6xhQy6mwRHxF1AimYPLoe3osp/ZTzwpFA+B8jj7hx2sSvI13MRuzvA8I6
 j+KvIFegiIoSidXU/zLIC8AG/HOXA=;
From: Quirin Gylstorff <Quirin.Gylstorff@siemens.com>
To: jan.kiszka@siemens.com,
	cip-dev@lists.cip-project.org,
	johnxw@amazon.com
Subject: [cip-dev][isar-cip-core][PATCH v3 00/15] Rework disk encryption
Date: Tue,  9 Apr 2024 15:05:17 +0200
Message-ID: <20240409130638.559398-1-Quirin.Gylstorff@siemens.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-51332:519-21489:flowmailer
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 09 Apr 2024 13:06:50 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/15512

From: Quirin Gylstorff <quirin.gylstorff@siemens.com>

This patchset is a cleanup of the initramfs-crypt-hook:
 - Aligns the systemd and clevis implementation
 - consolidate script in a main, clevis and systemd part
 - split clevis hook for readability
 - Adds some checks for TPM parameter
 - Remove the dependency in the overlay
 - Adds an example to encrypt the rootfs
 - Add readme to switch from clevis based encryption to systemd

Changes v3:
 - Add Kconfig entry for encrypted rootfs
 - Adapt start-qemu.sh for a encrypted rootfs
 - Add the missing initramfs-hook for the encrypted rootfs example

Changes v2:
 - fix typos in commit messages
 - some fixes for Debian buster
 - split clevis hook for readability
 - consolidate script in a main, clevis and systemd part
 - Add readme to switch from clevis based encryption to systemd
 - Increase version of the hook
 - The disk encryption now sets the root mount if necessary

Quirin Gylstorff (15):
  initramfs-crypt-hook: Allow switching between clevis and systemd
  initramfs-crypt-hook: Align systemd encryption and clevis encryption
  initramfs-crypt-hook: move the mounting of encrypted disks in a
    seperate function
  initramfs-crypt-hook: Check if the TPM device fulfills the given
    requirements
  initramfs-crypt-hook: add flag to make encryption optional
  initramfs-crypt-hook: add e2fsck to avoid resize error
  initramfs-crypt-hook: split encryption and mounting
  initramfs-crypt-hook: Add check if root is part of the mountpoints
  initramfs-crypt-hook: split hook in multiple files
  initramfs-crypt-hook: Consolidate clevis and systemd scripts
  initramfs-crypt-hook: Increase version
  README.tpm2.encryption: Add section to switch from clevis to systemd
  Add example to encrypt the rootfs
  Kconfig: Add option to encrypt the rootfs
  start-qemu.sh: Support encrypted rootfs

 Kconfig                                       |  14 ++
 doc/README.tpm2.encryption.md                 |  20 +++
 kas/opt/encrypt_rootfs.yml                    |  25 +++
 ...pt_partition.clevis.bullseye_or_later.hook |  34 ++++
 .../encrypt_partition.clevis.buster.hook      |  30 ++++
 .../files/encrypt_partition.clevis.hook       |  20 +--
 .../files/encrypt_partition.clevis.script     | 157 +++--------------
 .../files/encrypt_partition.env.tmpl          |   4 +-
 .../files/encrypt_partition.script            | 164 ++++++++++++++++++
 .../files/encrypt_partition.systemd.hook      |   5 +-
 .../files/encrypt_partition.systemd.script    | 152 +++-------------
 .../files/mount_crypt_partitions.script       |  61 +++++++
 ...ook_0.1.bb => initramfs-crypt-hook_0.2.bb} |  49 +++++-
 .../files/overlay.script.tmpl                 |   2 +-
 start-qemu.sh                                 |   7 +-
 wic/x86_64-encryption.wks.in                  |  16 ++
 16 files changed, 463 insertions(+), 297 deletions(-)
 create mode 100644 kas/opt/encrypt_rootfs.yml
 create mode 100755 recipes-initramfs/initramfs-crypt-hook/files/encrypt_partition.clevis.bullseye_or_later.hook
 create mode 100755 recipes-initramfs/initramfs-crypt-hook/files/encrypt_partition.clevis.buster.hook
 create mode 100644 recipes-initramfs/initramfs-crypt-hook/files/encrypt_partition.script
 create mode 100644 recipes-initramfs/initramfs-crypt-hook/files/mount_crypt_partitions.script
 rename recipes-initramfs/initramfs-crypt-hook/{initramfs-crypt-hook_0.1.bb => initramfs-crypt-hook_0.2.bb} (54%)
 create mode 100644 wic/x86_64-encryption.wks.in

-- 
2.43.0


