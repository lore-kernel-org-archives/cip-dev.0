Return-Path: <quirin.gylstorff@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C63EC54EED
	for <webhook@archiver.kernel.org>; Mon, 30 Jan 2023 15:02:18 +0000 (UTC)
Received: from mta-65-225.siemens.flowmailer.net (mta-65-225.siemens.flowmailer.net [185.136.65.225])
 by mx.groups.io with SMTP id smtpd.web11.43312.1675090928984575442
 for <cip-dev@lists.cip-project.org>;
 Mon, 30 Jan 2023 07:02:10 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=Quirin.Gylstorff@siemens.com header.s=fm1 header.b=izUNTG/O;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.65.225, mailfrom: fm-51332-202301301502067fcb900a97e5f2a33d-jx_xeb@rts-flowmailer.siemens.com)
Received: by mta-65-225.siemens.flowmailer.net with ESMTPSA id 202301301502067fcb900a97e5f2a33d
        for <cip-dev@lists.cip-project.org>;
        Mon, 30 Jan 2023 16:02:06 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=Quirin.Gylstorff@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding;
 bh=TZGl20L8qpeHv9rT1oVMr5PvASekHL7bsmXJteCvuC4=;
 b=izUNTG/OQNMtYnem8G3Sw3rPnJV8VDutau9NLLwN4PCle9GBhsNri8/l7jnLbDSuydGB9v
 KmEYaxdP0+QPVyx3pj/dylTxCjoWKwNKSmMBeDRFWEY9t3bF+if2vtTIo8fTYgANHIlTH04T
 +Fbgl/5fb4AdrpJltfYkcc8e+H8rY=;
From: Quirin Gylstorff <Quirin.Gylstorff@siemens.com>
To: cip-dev@lists.cip-project.org,
	jan.kiszka@siemens.com,
	christian.storm@siemens.com
Subject: [cip-dev][isar-cip-core][RFC 0/5] Encrypt Partition in initramfs
Date: Mon, 30 Jan 2023 16:01:59 +0100
Message-Id: <20230130150204.697758-1-Quirin.Gylstorff@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-51332:519-21489:flowmailer
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 30 Jan 2023 15:02:18 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/10509

From: Quirin Gylstorff <quirin.gylstorff@siemens.com>

This encrypts a partition with LUKS and uses the TPM2 to unlock the partition during
boot.

Adapt start-qemu to support tpm2.

Quirin Gylstorff (5):
  add tpm.cfg to the kernel
  use bullseye backports for systemd-cryptenroll
  wic/x86-efibootguard: add partition to encrypted
  start-qemu: If swtpm is available create a tpm2 device
  Add initramfs hook to encrypt a partition

 conf/distro/debian-bullseye-backports.list    |  1 +
 .../preferences.bullseye-backports.tpm.conf   |  3 +
 kas/opt/tpm.yml                               | 20 ++++
 .../files/create_crypt_partition.script       | 96 +++++++++++++++++++
 .../files/crypt-partition.env.tmpl            |  1 +
 .../initramfs-crypt-hook/files/crypt.hook     | 42 ++++++++
 .../initramfs-crypt-hook_0.1.bb               | 37 +++++++
 recipes-kernel/linux/files/tpm.cfg            | 13 +++
 recipes-kernel/linux/linux-cip-common.inc     |  2 +
 start-qemu.sh                                 | 23 ++++-
 wic/qemu-amd64-efibootguard-secureboot.wks.in |  1 +
 wic/x86-efibootguard.wks.in                   |  1 +
 12 files changed, 235 insertions(+), 5 deletions(-)
 create mode 100644 conf/distro/debian-bullseye-backports.list
 create mode 100644 conf/distro/preferences.bullseye-backports.tpm.conf
 create mode 100644 kas/opt/tpm.yml
 create mode 100644 recipes-initramfs/initramfs-crypt-hook/files/create_crypt_partition.script
 create mode 100644 recipes-initramfs/initramfs-crypt-hook/files/crypt-partition.env.tmpl
 create mode 100644 recipes-initramfs/initramfs-crypt-hook/files/crypt.hook
 create mode 100644 recipes-initramfs/initramfs-crypt-hook/initramfs-crypt-hook_0.1.bb
 create mode 100644 recipes-kernel/linux/files/tpm.cfg

-- 
2.39.0


