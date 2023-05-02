Return-Path: <quirin.gylstorff@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D464C7EE2C
	for <webhook@archiver.kernel.org>; Tue,  2 May 2023 15:38:08 +0000 (UTC)
Received: from mta-65-225.siemens.flowmailer.net (mta-65-225.siemens.flowmailer.net [185.136.65.225])
 by mx.groups.io with SMTP id smtpd.web11.1532.1683041883819691179
 for <cip-dev@lists.cip-project.org>;
 Tue, 02 May 2023 08:38:04 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=Quirin.Gylstorff@siemens.com header.s=fm1 header.b=Q6kjNkfv;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.65.225, mailfrom: fm-51332-2023050215380043506c549ff3505aa1-p5dim9@rts-flowmailer.siemens.com)
Received: by mta-65-225.siemens.flowmailer.net with ESMTPSA id 2023050215380043506c549ff3505aa1
        for <cip-dev@lists.cip-project.org>;
        Tue, 02 May 2023 17:38:01 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=Quirin.Gylstorff@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding;
 bh=yazYBTQHYLl+VQHLnMjylMisVnTlpIj2CY27p6ExuF0=;
 b=Q6kjNkfvLjaL9vO0SuvPfHoqCQqKT/k6bDraPP6OnJMIOxirK+LfPFvmEuZr67O9H/RHew
 qUXWjtZsqr9ks7SdaLaN3iHcHGzgKE4fCIAlAj139pSgf8janf4lxiTyCA5l+1OiQncTWzxs
 KaJghZqM6k11wNwA2fSIg2Dr1Qgak=;
From: Quirin Gylstorff <Quirin.Gylstorff@siemens.com>
To: cip-dev@lists.cip-project.org,
	jan.kiszka@siemens.com
Subject: [cip-dev][isar-cip-core][PATCH v4 0/7] Fixes for secure boot
Date: Tue,  2 May 2023 17:37:52 +0200
Message-Id: <20230502153759.1284906-1-Quirin.Gylstorff@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-51332:519-21489:flowmailer
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 02 May 2023 15:38:08 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/11382

From: Quirin Gylstorff <quirin.gylstorff@siemens.com>

This patchset fixes secure-boot and disk-encryption for Debian Buster
by adding the debian buster specific certificates and ajusting the
binaries and dependencies for clevis 16.

It also fixes the disk encryption for Debian bookworm by adding a
missing dependency to libcryptsetup-token-systemd-tpm2.


Changes v4:
 - Correct kas command line in README.tpm2.encryption.md
 - Fix build of ARM64 and ARM for buster with encryption
   This fixes only the build - currently arm64/arm with secure boot
   enabled on buster fails during boot with the following message:

   TFTP error: 'Access violation' (2)
   Not retrying...
   EFI Boot failed!

 - Update Linux kernel config

Changes v3:
 - Activate encryption for buster ci job
 - Adjust whitespaces
 - Address shellcheck findings

Changes v2:
 - use OVERRIDE and add missing space to linux-cip-common for
   encrypt-partitions with Debian buster

Quirin Gylstorff (7):
  secure-boot-secrets: Use distro specific snakeoil certs and keys
  initramfs-crypt-hook: Add support for buster
  linux: Add missing kernel option for LUKS2 encrpyted partitions on
    buster
  initramfs-crypt-hook: Add libcryptsetup-token-systemd-tpm2.so
  initramfs-crypt-hook/systemd: Address shellcheck findings
  .gitlabci: Enable encryption for on buster
  doc/README.tpm2.encryption: Correct kas option

 .gitlab-ci.yml                                |  1 +
 doc/README.tpm2.encryption.md                 |  2 +-
 .../secure-boot-secrets/files/bookworm        |  1 +
 .../files/{ => bullseye}/PkKek-1-snakeoil.key |  0
 .../files/{ => bullseye}/PkKek-1-snakeoil.pem |  0
 .../files/buster/PkKek-1-snakeoil.key         | 28 +++++++++++++++++++
 .../files/buster/PkKek-1-snakeoil.pem         | 19 +++++++++++++
 .../secure-boot-snakeoil_0.1.bb               |  4 +--
 .../files/encrypt_partition.clevis.hook       | 28 +++++++++++++++----
 .../files/encrypt_partition.clevis.script     |  3 +-
 .../files/encrypt_partition.systemd.hook      |  3 +-
 .../files/encrypt_partition.systemd.script    | 28 +++++++++----------
 .../initramfs-crypt-hook_0.1.bb               |  5 ++--
 recipes-kernel/linux/linux-cip-common.inc     |  2 +-
 14 files changed, 96 insertions(+), 28 deletions(-)
 create mode 120000 recipes-devtools/secure-boot-secrets/files/bookworm
 rename recipes-devtools/secure-boot-secrets/files/{ => bullseye}/PkKek-1-snakeoil.key (100%)
 rename recipes-devtools/secure-boot-secrets/files/{ => bullseye}/PkKek-1-snakeoil.pem (100%)
 create mode 100644 recipes-devtools/secure-boot-secrets/files/buster/PkKek-1-snakeoil.key
 create mode 100644 recipes-devtools/secure-boot-secrets/files/buster/PkKek-1-snakeoil.pem

-- 
2.39.2


