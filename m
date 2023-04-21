Return-Path: <quirin.gylstorff@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0149C7618E
	for <webhook@archiver.kernel.org>; Fri, 21 Apr 2023 15:05:52 +0000 (UTC)
Received: from mta-65-225.siemens.flowmailer.net (mta-65-225.siemens.flowmailer.net [185.136.65.225])
 by mx.groups.io with SMTP id smtpd.web11.14929.1682089549968926724
 for <cip-dev@lists.cip-project.org>;
 Fri, 21 Apr 2023 08:05:50 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=Quirin.Gylstorff@siemens.com header.s=fm1 header.b=hsjmvs1Z;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.65.225, mailfrom: fm-51332-202304211505461cfb88da8180b2a8fa-tnlrfg@rts-flowmailer.siemens.com)
Received: by mta-65-225.siemens.flowmailer.net with ESMTPSA id 202304211505461cfb88da8180b2a8fa
        for <cip-dev@lists.cip-project.org>;
        Fri, 21 Apr 2023 17:05:46 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=Quirin.Gylstorff@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding;
 bh=LwM5pL+DC44bQjUBO/z/HjcNcnM5krx2uuR4hFVFa9A=;
 b=hsjmvs1Z73ebGMvVWiJAKH6tSq3LY5VA0Wji6n6s4UUWpAf5MXJOfqqUiBgn7oYnAfJape
 iHSZsLDZixwY4A7grcyW5vbBkIOU6EHYhDpV9R7HCM685ErYRdU1kN8nMMPYUmAiE5sPM4V4
 8Ymcl8bWsrUuI/mTZrZG+Xhkt5muY=;
From: Quirin Gylstorff <Quirin.Gylstorff@siemens.com>
To: jan.kiszka@siemens.com,
	cip-dev@lists.cip-project.org
Subject: [cip-dev][isar-cip-core][PATCH v2 0/4] Fixes for secure boot and
Date: Fri, 21 Apr 2023 17:05:41 +0200
Message-Id: <20230421150545.4073324-1-Quirin.Gylstorff@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-51332:519-21489:flowmailer
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 21 Apr 2023 15:05:52 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/11321

From: Quirin Gylstorff <quirin.gylstorff@siemens.com>

This patchset fixes secure-boot and disk-encryption for Debian Buster
by adding the debian buster specific certificates and ajusting the
binaries and dependencies for clevis 16.

It also fixes the disk encryption for Debian bookworm by adding a
missing dependency to libcryptsetup-token-systemd-tpm2 

Changes v2:
 - use OVERRIDE and add missing space to linux-cip-common for
   encrypt-partitions with Debian buster

Quirin Gylstorff (4):
  secure-boot-secrets: Use distro specific snakeoil certs and keys
  initramfs-crypt-hook: Add support for buster
  linux: Add missing kernel option for LUKS2 encrpyted partitions
  initramfs-crypt-hook: Add libcryptsetup-token-systemd-tpm2.so

 .../files/bookworm/PkKek-1-snakeoil.key       | 28 +++++++++++++++++++
 .../files/{ => bookworm}/PkKek-1-snakeoil.pem |  0
 .../files/{ => bullseye}/PkKek-1-snakeoil.key |  0
 .../files/bullseye/PkKek-1-snakeoil.pem       | 21 ++++++++++++++
 .../files/buster/PkKek-1-snakeoil.key         | 28 +++++++++++++++++++
 .../files/buster/PkKek-1-snakeoil.pem         | 19 +++++++++++++
 .../secure-boot-snakeoil_0.1.bb               |  4 +--
 .../files/encrypt_partition.clevis.hook       | 20 ++++++++++---
 .../files/encrypt_partition.clevis.script     |  3 +-
 .../files/encrypt_partition.systemd.hook      |  1 +
 .../initramfs-crypt-hook_0.1.bb               |  5 ++--
 recipes-kernel/linux/files/buster-crypt.cfg   |  2 ++
 recipes-kernel/linux/linux-cip-common.inc     |  1 +
 13 files changed, 123 insertions(+), 9 deletions(-)
 create mode 100644 recipes-devtools/secure-boot-secrets/files/bookworm/PkKek-1-snakeoil.key
 rename recipes-devtools/secure-boot-secrets/files/{ => bookworm}/PkKek-1-snakeoil.pem (100%)
 rename recipes-devtools/secure-boot-secrets/files/{ => bullseye}/PkKek-1-snakeoil.key (100%)
 create mode 100644 recipes-devtools/secure-boot-secrets/files/bullseye/PkKek-1-snakeoil.pem
 create mode 100644 recipes-devtools/secure-boot-secrets/files/buster/PkKek-1-snakeoil.key
 create mode 100644 recipes-devtools/secure-boot-secrets/files/buster/PkKek-1-snakeoil.pem
 create mode 100644 recipes-kernel/linux/files/buster-crypt.cfg

-- 
2.39.2


