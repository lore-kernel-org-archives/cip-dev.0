Return-Path: <quirin.gylstorff@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44173C6FD1B
	for <webhook@archiver.kernel.org>; Mon,  6 Mar 2023 12:39:34 +0000 (UTC)
Received: from mta-64-226.siemens.flowmailer.net (mta-64-226.siemens.flowmailer.net [185.136.64.226])
 by mx.groups.io with SMTP id smtpd.web10.32031.1678106370750532338
 for <cip-dev@lists.cip-project.org>;
 Mon, 06 Mar 2023 04:39:31 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=Quirin.Gylstorff@siemens.com header.s=fm1 header.b=QhloTBUf;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.64.226, mailfrom: fm-51332-20230306123927febe0bba18f726db08-eminah@rts-flowmailer.siemens.com)
Received: by mta-64-226.siemens.flowmailer.net with ESMTPSA id 20230306123927febe0bba18f726db08
        for <cip-dev@lists.cip-project.org>;
        Mon, 06 Mar 2023 13:39:28 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=Quirin.Gylstorff@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding;
 bh=lF0zbAv1KlQrnSeDJJkhGI2BQlDtmi06k1iZMBA1iuI=;
 b=QhloTBUfjnviAfK3qBeUq9+1QeoDgrQejWBYiQC1i1zbnBuWZVkO0ektjBw/9MZ0/Mi532
 RQ2sPxxM/V3JavrQoJEKIh9Xoy/TYyElJKio5rlOWt6AGkDFn/YRSG/Uj/WIQmUMbNFk51qi
 7fcExP8aKx9C8j633TLRG0jAAoyes=;
From: Quirin Gylstorff <Quirin.Gylstorff@siemens.com>
To: cip-dev@lists.cip-project.org,
	christian.storm@siemens.com,
	jan.kiszka@siemens.com
Subject: [cip-dev][isar-cip-core][PATCH v4 0/7] Encrypt Partition in initramfs
Date: Mon,  6 Mar 2023 13:39:19 +0100
Message-Id: <20230306123926.243471-1-Quirin.Gylstorff@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-51332:519-21489:flowmailer
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 06 Mar 2023 12:39:34 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/10936

From: Quirin Gylstorff <quirin.gylstorff@siemens.com>

This encrypts a partition with LUKS and uses the TPM2 to unlock the partition during
boot. 

Adapt start-qemu to support tpm2.

The implementation uses systemd-cryptenroll to add the TPM protected
passphrase to the LUKS header. systemd-cryptenroll was added with systemd version > 248.

The following table shows the support of systemd-cryptenroll in Debian
release.

| Debian version | systemd-cryptenroll suppported |
| Buster(10)     | No                             |
| Bullseye(11)   | with backports                 |
| Bookworm(12)   | yes                            |

I am currently testing a adaptation for Debian 11 (Bullseye) with 
clevis instead of systemd-cryptenroll. If clevis works I will sent a
additional patch.

Changes v2:
 - rewrite for multiple partition
 - add rencrypt for populated partitions
 - encrypt /var and /home

Changes v3:
 - remove additional partition crypt_data
 - add Readme
 - fix KConfig
 - only systemd is from backports
 - start-qemu now checks .config.yaml for TPM2 support
 - correct whitespaces

Changes v4:
 - whitespaces
 - README add requirements for systemd 248
 - Kconfig add help information
 - adapt commit message of patch 4 (add information about extra-space)

Quirin Gylstorff (7):
  use bullseye backports for systemd-cryptenroll
  KConfig: add tpm option
  start-qemu.sh: Create a tpm2 device
  Add initramfs hook to encrypt a partition
  overlay: add prerequisite 'encrypt_partition'
  .gitlabci: Add ci build
  Add README for encrypted partitions

 .gitlab-ci.yml                                |  13 ++
 Kconfig                                       |  11 ++
 conf/distro/debian-bullseye-backports.list    |   1 +
 .../preferences.bullseye-backports.tpm.conf   |   4 +
 doc/README.tpm2.encryption.md                 |  55 +++++++
 kas/opt/tpm.yml                               |  20 +++
 .../files/encrypt_partition.env.tmpl          |   2 +
 .../files/encrypt_partition.hook              |  53 +++++++
 .../files/encrypt_partition.script            | 145 ++++++++++++++++++
 .../initramfs-crypt-hook_0.1.bb               |  40 +++++
 .../initramfs-overlay-hook/files/overlay.hook |   1 +
 .../files/overlay.script.tmpl                 |  12 +-
 .../initramfs-overlay-hook_0.1.bb             |   2 +-
 start-qemu.sh                                 |  27 +++-
 wic/x86-efibootguard.wks.in                   |   5 +-
 15 files changed, 378 insertions(+), 13 deletions(-)
 create mode 100644 conf/distro/debian-bullseye-backports.list
 create mode 100644 conf/distro/preferences.bullseye-backports.tpm.conf
 create mode 100644 doc/README.tpm2.encryption.md
 create mode 100644 kas/opt/tpm.yml
 create mode 100644 recipes-initramfs/initramfs-crypt-hook/files/encrypt_partition.env.tmpl
 create mode 100644 recipes-initramfs/initramfs-crypt-hook/files/encrypt_partition.hook
 create mode 100644 recipes-initramfs/initramfs-crypt-hook/files/encrypt_partition.script
 create mode 100644 recipes-initramfs/initramfs-crypt-hook/initramfs-crypt-hook_0.1.bb

-- 
2.39.2


