Return-Path: <quirin.gylstorff@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2CAFC74A4B
	for <webhook@archiver.kernel.org>; Thu,  9 Mar 2023 08:53:29 +0000 (UTC)
Received: from mta-64-225.siemens.flowmailer.net (mta-64-225.siemens.flowmailer.net [185.136.64.225])
 by mx.groups.io with SMTP id smtpd.web11.8812.1678352005483458855
 for <cip-dev@lists.cip-project.org>;
 Thu, 09 Mar 2023 00:53:26 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=Quirin.Gylstorff@siemens.com header.s=fm1 header.b=msdVbDoi;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.64.225, mailfrom: fm-51332-202303090853225fb906302aab32ff12-x0tgod@rts-flowmailer.siemens.com)
Received: by mta-64-225.siemens.flowmailer.net with ESMTPSA id 202303090853225fb906302aab32ff12
        for <cip-dev@lists.cip-project.org>;
        Thu, 09 Mar 2023 09:53:22 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=Quirin.Gylstorff@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding;
 bh=pDscFc3+mY7AiINLSNH0Ggg0mPDIiDSjgX46Hu97zFg=;
 b=msdVbDoiD6xk7FQInB527djAaBdbQB5WSe6gFnAL/X1hNJwCFs1lzj2V9n9rxeRBQ3JMtH
 NlYHbt+/WKZlcT/oJB5EPKWJKAGCYgu1sEHM693KY839Q8mjppM4icNEZLb0gHgzLeowCV0M
 R1yj2cTYKV+Zi7rcX+mK8dDRmnw1Q=;
From: Quirin Gylstorff <Quirin.Gylstorff@siemens.com>
To: cip-dev@lists.cip-project.org,
	christian.storm@siemens.com,
	jan.kiszka@siemens.com
Subject: [cip-dev][isar-cip-core][PATCH v5 0/6] Encrypt Partition in initramfs
Date: Thu,  9 Mar 2023 09:53:15 +0100
Message-Id: <20230309085321.17167-1-Quirin.Gylstorff@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-51332:519-21489:flowmailer
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 09 Mar 2023 08:53:29 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/10956

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

Changes v5:
 - rebase on origin/next
 - rename kas/opt/tpm.yml to kas/opt/encrypt-partitions.yml
 - Kconfig change help text and option name from IMAGE_TPM_ENCRYPTION
to IMAGE_DATA_ENCRYPTION
 

Quirin Gylstorff (6):
  KConfig: add option to encrypt data partitions
  start-qemu.sh: Create a tpm2 device
  Add initramfs hook to encrypt a partition
  overlay: add prerequisite 'encrypt_partition'
  .gitlabci: Add ci build
  Add README for encrypted partitions

 .gitlab-ci.yml                                |  13 ++
 Kconfig                                       |  10 ++
 doc/README.tpm2.encryption.md                 |  55 +++++++
 kas/opt/encrypt-partitions.yml                |   3 +-
 .../cip-core-initramfs/cip-core-initramfs.bb  |   2 +
 .../files/encrypt_partition.env.tmpl          |   2 +
 .../files/encrypt_partition.hook              |  53 +++++++
 .../files/encrypt_partition.script            | 145 ++++++++++++++++++
 .../initramfs-crypt-hook_0.1.bb               |  40 +++++
 .../initramfs-overlay-hook/files/overlay.hook |   1 +
 .../files/overlay.script.tmpl                 |  12 +-
 .../initramfs-overlay-hook_0.1.bb             |   2 +-
 start-qemu.sh                                 |  27 +++-
 wic/x86-efibootguard.wks.in                   |   5 +-
 14 files changed, 356 insertions(+), 14 deletions(-)
 create mode 100644 doc/README.tpm2.encryption.md
 create mode 100644 recipes-initramfs/initramfs-crypt-hook/files/encrypt_partition.env.tmpl
 create mode 100644 recipes-initramfs/initramfs-crypt-hook/files/encrypt_partition.hook
 create mode 100644 recipes-initramfs/initramfs-crypt-hook/files/encrypt_partition.script
 create mode 100644 recipes-initramfs/initramfs-crypt-hook/initramfs-crypt-hook_0.1.bb

-- 
2.39.2


