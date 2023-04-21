Return-Path: <quirin.gylstorff@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 874E6C7618E
	for <webhook@archiver.kernel.org>; Fri, 21 Apr 2023 14:23:42 +0000 (UTC)
Received: from mta-64-226.siemens.flowmailer.net (mta-64-226.siemens.flowmailer.net [185.136.64.226])
 by mx.groups.io with SMTP id smtpd.web11.13238.1682087017894009870
 for <cip-dev@lists.cip-project.org>;
 Fri, 21 Apr 2023 07:23:39 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=Quirin.Gylstorff@siemens.com header.s=fm1 header.b=Wm297jW5;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.64.226, mailfrom: fm-51332-2023042114233408459b1efb2d21206a-49ilqe@rts-flowmailer.siemens.com)
Received: by mta-64-226.siemens.flowmailer.net with ESMTPSA id 2023042114233408459b1efb2d21206a
        for <cip-dev@lists.cip-project.org>;
        Fri, 21 Apr 2023 16:23:35 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=Quirin.Gylstorff@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding;
 bh=+vjms/ZkeUneYbsNHXa0W+KNeyzMTYEMlpN5mJwsldQ=;
 b=Wm297jW5i+fvR43jERZ9B5/pajO7UKEWPv62fjttKEqfkAE6l7TJe0+yS+SE53TD2I5nVE
 iiH7j2Vd/85d8758l5JBQ/JHsVKuX22pBdjfk2pQWtSivgA0OZl19Z2BitPZizYPYbkCDgyS
 Xosgt73atV98QoeXJPo2NPDBHTMLo=;
From: Quirin Gylstorff <Quirin.Gylstorff@siemens.com>
To: jan.kiszka@siemens.com,
	cip-dev@lists.cip-project.org
Subject: [cip-dev][isar-cip-core][PATCH 0/4] Fixes for secure boot and
Date: Fri, 21 Apr 2023 16:23:29 +0200
Message-Id: <20230421142333.3906250-1-Quirin.Gylstorff@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-51332:519-21489:flowmailer
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 21 Apr 2023 14:23:42 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/11320

From: Quirin Gylstorff <quirin.gylstorff@siemens.com>

This patchset fixes secure-boot and disk-encryption for Debian Buster
by adding the debian buster specific certificates and ajusting the
binaries and dependencies for clevis 16.

It also fixes the disk encryption for Debian bookworm by adding a
missing dependency to libcryptsetup-token-systemd-tpm2 

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


