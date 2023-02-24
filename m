Return-Path: <quirin.gylstorff@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C89DC7EE2D
	for <webhook@archiver.kernel.org>; Fri, 24 Feb 2023 16:28:41 +0000 (UTC)
Received: from mta-64-225.siemens.flowmailer.net (mta-64-225.siemens.flowmailer.net [185.136.64.225])
 by mx.groups.io with SMTP id smtpd.web10.22331.1677256116408340396
 for <cip-dev@lists.cip-project.org>;
 Fri, 24 Feb 2023 08:28:37 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=Quirin.Gylstorff@siemens.com header.s=fm1 header.b=SOHpidOI;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.64.225, mailfrom: fm-51332-202302241628335271b3789b24fd96bd-zj7nif@rts-flowmailer.siemens.com)
Received: by mta-64-225.siemens.flowmailer.net with ESMTPSA id 202302241628335271b3789b24fd96bd
        for <cip-dev@lists.cip-project.org>;
        Fri, 24 Feb 2023 17:28:33 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=Quirin.Gylstorff@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding;
 bh=jrQz9uxiyDgvKp91tdLfgvRolwBGNWwsKFxrOYjp37U=;
 b=SOHpidOI/HVL22gtpvlwlrekYzwaePWHyWpcLTuNFv/1lKsHw6HR7yz88PACRRKQds0ft0
 PUAD21eMTk8JU/V8ieLnSrOOCW9h0idd3LEF9qOhLK6O04koK90cIe8ub07yO2RBtDdiC+OR
 YAmAmMyBHgt/C3tgKdeKOTIIS3iCA=;
From: Quirin Gylstorff <Quirin.Gylstorff@siemens.com>
To: cip-dev@lists.cip-project.org,
	christian.storm@siemens.com,
	jan.kiszka@siemens.com
Subject: [cip-dev][isar-cip-core][PATCH v3 0/8] Encrypt Partition in initramfs
Date: Fri, 24 Feb 2023 17:28:24 +0100
Message-Id: <20230224162832.327030-1-Quirin.Gylstorff@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-51332:519-21489:flowmailer
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 24 Feb 2023 16:28:41 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/10814

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

Quirin Gylstorff (8):
  linux-cip: update kernel configuration for tpm2 support
  use bullseye backports for systemd-cryptenroll
  KConfig: add tpm option
  start-qemu.sh: Create a tpm2 device
  Add initramfs hook to encrypt a partition
  overlay: add prerequisite 'encrypt_partition'
  .gitlabci: Add ci build
  Add README for encrypted partitions

 .gitlab-ci.yml                                |  13 ++
 Kconfig                                       |   8 +
 conf/distro/debian-bullseye-backports.list    |   1 +
 .../preferences.bullseye-backports.tpm.conf   |  40 +++++
 doc/README.tpm2.encryption.md                 |  39 +++++
 kas/opt/tpm.yml                               |  20 +++
 .../files/encrypt_partition.env.tmpl          |   2 +
 .../files/encrypt_partition.hook              |  53 +++++++
 .../files/encrypt_partition.script            | 145 ++++++++++++++++++
 .../initramfs-crypt-hook_0.1.bb               |  40 +++++
 .../initramfs-overlay-hook/files/overlay.hook |   1 +
 .../files/overlay.script.tmpl                 |  12 +-
 recipes-kernel/linux/linux-cip-common.inc     |   2 +-
 start-qemu.sh                                 |  27 +++-
 wic/x86-efibootguard.wks.in                   |   5 +-
 15 files changed, 395 insertions(+), 13 deletions(-)
 create mode 100644 conf/distro/debian-bullseye-backports.list
 create mode 100644 conf/distro/preferences.bullseye-backports.tpm.conf
 create mode 100644 doc/README.tpm2.encryption.md
 create mode 100644 kas/opt/tpm.yml
 create mode 100644 recipes-initramfs/initramfs-crypt-hook/files/encrypt_partition.env.tmpl
 create mode 100644 recipes-initramfs/initramfs-crypt-hook/files/encrypt_partition.hook
 create mode 100644 recipes-initramfs/initramfs-crypt-hook/files/encrypt_partition.script
 create mode 100644 recipes-initramfs/initramfs-crypt-hook/initramfs-crypt-hook_0.1.bb

-- 
2.39.1


