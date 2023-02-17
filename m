Return-Path: <quirin.gylstorff@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3645C677F1
	for <webhook@archiver.kernel.org>; Fri, 17 Feb 2023 13:05:53 +0000 (UTC)
Received: from mta-64-227.siemens.flowmailer.net (mta-64-227.siemens.flowmailer.net [185.136.64.227])
 by mx.groups.io with SMTP id smtpd.web10.5859.1676639144713494941
 for <cip-dev@lists.cip-project.org>;
 Fri, 17 Feb 2023 05:05:46 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=Quirin.Gylstorff@siemens.com header.s=fm1 header.b=Q3ZS8uZa;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.64.227, mailfrom: fm-51332-202302171305421de9d3ace879daf2af-s18edi@rts-flowmailer.siemens.com)
Received: by mta-64-227.siemens.flowmailer.net with ESMTPSA id 202302171305421de9d3ace879daf2af
        for <cip-dev@lists.cip-project.org>;
        Fri, 17 Feb 2023 14:05:42 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=Quirin.Gylstorff@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding;
 bh=YsfcMBGWTWaD2C0jUfZCwM4hoyFDORPGNTUYXk91t90=;
 b=Q3ZS8uZaU4UGd1kxEG4uAs949bLCe/HPBM6jK0EhWsfJVsfPvLZhiiAOYYpanNM4o+jtaw
 U9/EO4Jb7/JQ5hebqfoLquZJbP+RG0ZbRsIjc63A78L2ujy7RaGuv3FMFvo2WCDIIAMTOTui
 NjJii1Iu40aAZtCYZRTkhjnd2ejSk=;
From: Quirin Gylstorff <Quirin.Gylstorff@siemens.com>
To: cip-dev@lists.cip-project.org,
	christian.storm@siemens.com,
	jan.kiszka@siemens.com
Subject: [cip-dev][isar-cip-core][RFC v2 0/7] Encrypt Partition in initramfs
Date: Fri, 17 Feb 2023 14:05:33 +0100
Message-Id: <20230217130540.509910-1-Quirin.Gylstorff@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-51332:519-21489:flowmailer
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 17 Feb 2023 13:05:53 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/10717

From: Quirin Gylstorff <quirin.gylstorff@siemens.com>

This encrypts a partition with LUKS and uses the TPM2 to unlock the partition during
boot.

Adapt start-qemu to support tpm2.

Changes v2:
 - rewrite for multiple partition
 - add rencrypt for populated partitions
 - encrypt /var and /home

Quirin Gylstorff (7):
  linux-cip: update kernel configuration for tpm2 support
  use bullseye backports for systemd-cryptenroll
  start-qemu: If swtpm is available create a tpm2 device
  Add initramfs hook to encrypt a partition
  overlay: add prerequisite 'encrypt_partition'
  KConfig: add tpm option
  .gitlabci: Add ci build

 .gitlab-ci.yml                                |  13 ++
 Kconfig                                       |   8 ++
 conf/distro/debian-bullseye-backports.list    |   1 +
 .../preferences.bullseye-backports.tpm.conf   |   3 +
 kas/opt/tpm.yml                               |  20 +++
 .../files/encrypt_partition.env.tmpl          |   2 +
 .../files/encrypt_partition.hook              |  49 +++++++
 .../files/encrypt_partition.script            | 135 ++++++++++++++++++
 .../initramfs-crypt-hook_0.1.bb               |  37 +++++
 .../initramfs-overlay-hook/files/overlay.hook |   1 +
 .../files/overlay.script.tmpl                 |  12 +-
 recipes-kernel/linux/linux-cip-common.inc     |   2 +-
 start-qemu.sh                                 |  23 ++-
 wic/x86-efibootguard.wks.in                   |   4 +-
 14 files changed, 297 insertions(+), 13 deletions(-)
 create mode 100644 conf/distro/debian-bullseye-backports.list
 create mode 100644 conf/distro/preferences.bullseye-backports.tpm.conf
 create mode 100644 kas/opt/tpm.yml
 create mode 100644 recipes-initramfs/initramfs-crypt-hook/files/encrypt_partition.env.tmpl
 create mode 100644 recipes-initramfs/initramfs-crypt-hook/files/encrypt_partition.hook
 create mode 100644 recipes-initramfs/initramfs-crypt-hook/files/encrypt_partition.script
 create mode 100644 recipes-initramfs/initramfs-crypt-hook/initramfs-crypt-hook_0.1.bb

-- 
2.39.1


