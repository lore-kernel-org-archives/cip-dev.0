Return-Path: <quirin.gylstorff@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C79F0C7EE22
	for <webhook@archiver.kernel.org>; Tue, 25 Apr 2023 10:48:47 +0000 (UTC)
Received: from mta-64-227.siemens.flowmailer.net (mta-64-227.siemens.flowmailer.net [185.136.64.227])
 by mx.groups.io with SMTP id smtpd.web10.76327.1682419719749053037
 for <cip-dev@lists.cip-project.org>;
 Tue, 25 Apr 2023 03:48:41 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=Quirin.Gylstorff@siemens.com header.s=fm1 header.b=L56MDZjO;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.64.227, mailfrom: fm-51332-20230425104836fd32f8edd6fe5e74b5-q7jpr2@rts-flowmailer.siemens.com)
Received: by mta-64-227.siemens.flowmailer.net with ESMTPSA id 20230425104836fd32f8edd6fe5e74b5
        for <cip-dev@lists.cip-project.org>;
        Tue, 25 Apr 2023 12:48:37 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=Quirin.Gylstorff@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding;
 bh=f+3Ol9e1qnBxdfixGf8T+0QF9kJyeHQ4iN1PqiAp1r8=;
 b=L56MDZjOAyUlO0TETTUuDpjLCsmKZGfawtC9D5VP56fzA2bRLWiGeEJw2idfnDEVGYLyzg
 Sh9oL0lhkDZU0i0o51FynGdZGfk8fvL7uuX6wVSoTTZR9U5DRL+vORbKkWiwIf7etux5b9Th
 qO7UODxTBYOwkXOuxM+3X1MnRUxr4=;
From: Quirin Gylstorff <Quirin.Gylstorff@siemens.com>
To: cip-dev@lists.cip-project.org,
	jan.kiszka@siemens.com
Subject: [cip-dev][isar-cip-core][PATCH v3 0/6] Fixes for secure boot
Date: Tue, 25 Apr 2023 12:48:29 +0200
Message-Id: <20230425104835.655946-1-Quirin.Gylstorff@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-51332:519-21489:flowmailer
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 25 Apr 2023 10:48:47 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/11342

From: Quirin Gylstorff <quirin.gylstorff@siemens.com>

This patchset fixes secure-boot and disk-encryption for Debian Buster
by adding the debian buster specific certificates and ajusting the
binaries and dependencies for clevis 16.

It also fixes the disk encryption for Debian bookworm by adding a
missing dependency to libcryptsetup-token-systemd-tpm2.

Changes v3:
 - Activate encryption for buster ci job
 - Adjust whitespaces
 - Address shellcheck findings

Changes v2:
 - use OVERRIDE and add missing space to linux-cip-common for
   encrypt-partitions with Debian buster

Quirin Gylstorff (6):
  secure-boot-secrets: Use distro specific snakeoil certs and keys
  initramfs-crypt-hook: Add support for buster
  linux: Add missing kernel option for LUKS2 encrpyted partitions on
    buster
  initramfs-crypt-hook: Add libcryptsetup-token-systemd-tpm2.so
  initramfs-crypt-hook/systemd: Address shellcheck findings
  .gitlabci: Enable encryption for on buster

 .gitlab-ci.yml                                |  1 +
 .../files/bookworm/PkKek-1-snakeoil.key       | 28 +++++++++++++++++++
 .../files/{ => bookworm}/PkKek-1-snakeoil.pem |  0
 .../files/{ => bullseye}/PkKek-1-snakeoil.key |  0
 .../files/bullseye/PkKek-1-snakeoil.pem       | 21 ++++++++++++++
 .../files/buster/PkKek-1-snakeoil.key         | 28 +++++++++++++++++++
 .../files/buster/PkKek-1-snakeoil.pem         | 19 +++++++++++++
 .../secure-boot-snakeoil_0.1.bb               |  4 +--
 .../files/encrypt_partition.clevis.hook       | 28 +++++++++++++++----
 .../files/encrypt_partition.clevis.script     |  3 +-
 .../files/encrypt_partition.systemd.hook      |  3 +-
 .../files/encrypt_partition.systemd.script    | 28 +++++++++----------
 .../initramfs-crypt-hook_0.1.bb               |  5 ++--
 recipes-kernel/linux/files/buster-crypt.cfg   |  2 ++
 recipes-kernel/linux/linux-cip-common.inc     |  1 +
 15 files changed, 145 insertions(+), 26 deletions(-)
 create mode 100644 recipes-devtools/secure-boot-secrets/files/bookworm/PkKek-1-snakeoil.key
 rename recipes-devtools/secure-boot-secrets/files/{ => bookworm}/PkKek-1-snakeoil.pem (100%)
 rename recipes-devtools/secure-boot-secrets/files/{ => bullseye}/PkKek-1-snakeoil.key (100%)
 create mode 100644 recipes-devtools/secure-boot-secrets/files/bullseye/PkKek-1-snakeoil.pem
 create mode 100644 recipes-devtools/secure-boot-secrets/files/buster/PkKek-1-snakeoil.key
 create mode 100644 recipes-devtools/secure-boot-secrets/files/buster/PkKek-1-snakeoil.pem
 create mode 100644 recipes-kernel/linux/files/buster-crypt.cfg

-- 
2.39.2


