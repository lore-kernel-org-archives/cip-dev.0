Return-Path: <quirin.gylstorff@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25A40CD1285
	for <webhook@archiver.kernel.org>; Fri, 22 Mar 2024 10:06:20 +0000 (UTC)
Received: from mta-64-228.siemens.flowmailer.net (mta-64-228.siemens.flowmailer.net [185.136.64.228])
 by mx.groups.io with SMTP id smtpd.web11.9594.1711101968928122286
 for <cip-dev@lists.cip-project.org>;
 Fri, 22 Mar 2024 03:06:09 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=Quirin.Gylstorff@siemens.com header.s=fm1 header.b=RRgmqNSQ;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.64.228, mailfrom: fm-51332-202403221006064c11c90233dff34cc3-9nzdy3@rts-flowmailer.siemens.com)
Received: by mta-64-228.siemens.flowmailer.net with ESMTPSA id 202403221006064c11c90233dff34cc3
        for <cip-dev@lists.cip-project.org>;
        Fri, 22 Mar 2024 11:06:06 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=Quirin.Gylstorff@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding;
 bh=yOJo14qHQc7sHu+tqIAKWchZXA/opboRTacJcEinxzs=;
 b=RRgmqNSQPmtR7XmOBfogTh0rtkwnybXjeDe0hQneVaduYrt7xk0QV19wv2TGjhHnmOV5pe
 X6pZFI86hK5u9LY48D6WFkCbGj6VdCGji2XKl8lHOKAdhUv3eRrwsW0T8uKVkoYAKvuR+ekU
 k++JmgwHY9MxiSgOg+dSr5UVdB9hw=;
From: Quirin Gylstorff <Quirin.Gylstorff@siemens.com>
To: jan.kiszka@siemens.com,
	cip-dev@lists.cip-project.org,
	johnxw@amazon.com
Subject: [cip-dev][isar-cip-core][PATCH v2 00/13] Rework disk encryption
Date: Fri, 22 Mar 2024 11:05:10 +0100
Message-ID: <20240322100605.4129226-1-Quirin.Gylstorff@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-51332:519-21489:flowmailer
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 22 Mar 2024 10:06:20 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/15402

From: Quirin Gylstorff <quirin.gylstorff@siemens.com>

MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

This patchset is a cleanup of the initramfs-crypt-hook:
 - Aligns the systemd and clevis implementation
 - consolidate script in a main, clevis and systemd part
 - split clevis hook for readability
 - Adds some checks for TPM parameter
 - Remove the dependency in the overlay
 - Adds an example to encrypt the rootfs
 - Add readme to switch from clevis based encryption to systemd


Changes v2:
 - fix typos in commit messages
 - some fixes for Debian buster
 - split clevis hook for readability
 - consolidate script in a main, clevis and systemd part
 - Add readme to switch from clevis based encryption to systemd
 - Increase version of the hook
 - The disk encryption now sets the root mount if necessary


Quirin Gylstorff (13):
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

 doc/README.tpm2.encryption.md                 |  20 +++
 kas/opt/encrypt_rootfs.yml                    |  24 +++
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
 wic/x86_64-encryption.wks.in                  |  16 ++
 14 files changed, 442 insertions(+), 296 deletions(-)
 create mode 100644 kas/opt/encrypt_rootfs.yml
 create mode 100755 recipes-initramfs/initramfs-crypt-hook/files/encrypt_partition.clevis.bullseye_or_later.hook
 create mode 100755 recipes-initramfs/initramfs-crypt-hook/files/encrypt_partition.clevis.buster.hook
 create mode 100644 recipes-initramfs/initramfs-crypt-hook/files/encrypt_partition.script
 create mode 100644 recipes-initramfs/initramfs-crypt-hook/files/mount_crypt_partitions.script
 rename recipes-initramfs/initramfs-crypt-hook/{initramfs-crypt-hook_0.1.bb => initramfs-crypt-hook_0.2.bb} (54%)
 create mode 100644 wic/x86_64-encryption.wks.in

-- 
2.43.0


