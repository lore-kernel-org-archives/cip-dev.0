Return-Path: <quirin.gylstorff@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 706B2C16B13
	for <webhook@archiver.kernel.org>; Mon, 22 Apr 2024 14:11:33 +0000 (UTC)
Received: from mta-64-228.siemens.flowmailer.net (mta-64-228.siemens.flowmailer.net [185.136.64.228])
 by mx.groups.io with SMTP id smtpd.web11.19554.1713795084841615664
 for <cip-dev@lists.cip-project.org>;
 Mon, 22 Apr 2024 07:11:25 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=Quirin.Gylstorff@siemens.com header.s=fm1 header.b=TMZxBto7;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.64.228, mailfrom: fm-51332-20240422141121be66fb90ad46c66a54-5oad8a@rts-flowmailer.siemens.com)
Received: by mta-64-228.siemens.flowmailer.net with ESMTPSA id 20240422141121be66fb90ad46c66a54
        for <cip-dev@lists.cip-project.org>;
        Mon, 22 Apr 2024 16:11:22 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=Quirin.Gylstorff@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding;
 bh=X/sotUJFvxwS5k7rAO9+dO+ZEDyGE2dmqCF3IgRlHK0=;
 b=TMZxBto72Lt0LPL0FC3aua6ATW5FiclseiNW/0NuP/oA8afXX4H4n0KUfUmfBsOhix4aOd
 CrHsngPSVdg0/xIdGg+0OxwBKMNK1wgNFLbEzSM0CFHL5umXOvR+5dHO+ZOWmMDd5OTtKuB0
 EnZtyWyHiPdnXNvp7Kh2CguqlMHJo=;
From: Quirin Gylstorff <Quirin.Gylstorff@siemens.com>
To: jan.kiszka@siemens.com,
	johnxw@amazon.com,
	cip-dev@lists.cip-project.org
Subject: [cip-dev][isar-cip-core][PATCH v2 0/7] Add option to encrypt the rootfs
Date: Mon, 22 Apr 2024 16:09:05 +0200
Message-ID: <20240422141120.577573-1-Quirin.Gylstorff@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-51332:519-21489:flowmailer
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 22 Apr 2024 14:11:33 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/15725

From: Quirin Gylstorff <quirin.gylstorff@siemens.com>

This adds the option to encrypt both root file system partions(systema
and systemb). The encrypted partition can be updated with SWUpdate.

Currently an update will lead to a reencryption of the update partition as
the underlying device(/dev/sdaX) is written instead of the device mapper
partition.

Changes v2:
 - Rewrite commit messages
 - Rename kas/opt/encrypt-partitions.yml to kas/opt/encrypt-data.yml
 - Rename kas/opt/encrypt-rootfs.yml to kas/opt/encrypt-all.yml
 - Fix assignment of CRYPT_PARTITIONS

Changes from https://lists.cip-project.org/g/cip-dev/message/15512:
 - add partition labels for a/b partitions
 - use a/b rootfs configuration instead seperate wks file


Quirin Gylstorff (7):
  wic/*: Add part-labels to system partition
  initramfs: allow empty mountpoint for crypt hooks
  initramfs-crypt: Only resize partition if ext* formatted
  fix: use luks2 to identify encrypted partition
  Rename encrypt-partitions to encrypt-data
  Kconfig: Add option to encrypt the rootfs
  README: Add rootfs encryption

 .gitlab-ci.yml                                |  2 +-
 Kconfig                                       | 22 ++++++++++++++++---
 doc/README.tpm2.encryption.md                 | 14 ++++++++++--
 kas/opt/encrypt-all.yml                       | 22 +++++++++++++++++++
 ...ncrypt-partitions.yml => encrypt-data.yml} |  0
 kas/opt/security.yml                          |  2 +-
 .../files/encrypt_partition.script            | 22 ++++++++++++++-----
 .../files/mount_crypt_partitions.script       |  4 +++-
 wic/bbb-efibootguard.wks.in                   |  4 ++--
 wic/hihope-rzg2m-efibootguard.wks.in          |  4 ++--
 wic/qemu-amd64-efibootguard-secureboot.wks.in |  4 ++--
 wic/qemu-arm64-efibootguard-secureboot.wks.in |  4 ++--
 wic/qemu-arm64-efibootguard.wks.in            |  4 ++--
 wic/qemu-riscv64-efibootguard.wks.in          |  4 ++--
 wic/x86-efibootguard.wks.in                   |  4 ++--
 15 files changed, 89 insertions(+), 27 deletions(-)
 create mode 100644 kas/opt/encrypt-all.yml
 rename kas/opt/{encrypt-partitions.yml => encrypt-data.yml} (100%)

-- 
2.43.0


