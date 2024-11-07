Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B092D44D7B
	for <webhook@archiver.kernel.org>; Thu,  7 Nov 2024 10:58:14 +0000 (UTC)
Received: from mta-65-225.siemens.flowmailer.net (mta-65-225.siemens.flowmailer.net [185.136.65.225])
 by mx.groups.io with SMTP id smtpd.web11.69032.1730977083585086262
 for <cip-dev@lists.cip-project.org>;
 Thu, 07 Nov 2024 02:58:04 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=jan.kiszka@siemens.com header.s=fm1 header.b=DKS0uelP;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.65.225, mailfrom: fm-294854-202411071058005c43ce458f86b9a63e-npyit1@rts-flowmailer.siemens.com)
Received: by mta-65-225.siemens.flowmailer.net with ESMTPSA id 202411071058005c43ce458f86b9a63e
        for <cip-dev@lists.cip-project.org>;
        Thu, 07 Nov 2024 11:58:00 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=jan.kiszka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc;
 bh=WuXkh8jGeUNcf6FJHBuRyv0wxolR+rXORDbrB1V7Pmw=;
 b=DKS0uelPTtYdquLcObtTTWZxcG4/wqEiffq2cd2o5UbH827DBN03q5j3JSxX+sb9yxg/rX
 zvKN9YLNRdcrwr54s7PnX1k0tOIUmo0UPnbr3R24Orj0tCimZe9QmZwdTVr9JxP3MuyOHzcA
 mH09A0IK2708zciXNU+NLZ5rhH5JkEuKobC3KSb+Fyz4tTtM/PFEaFNT2I1v/fS5/k4oSH+t
 8Z85gZmq1vh+4brlDjl1umIY1ZHqIgQF67hmfFm6PvRdDU+c193IHDEZJ1DIYCVWkTQ4IeW8
 pyAOmf+eQbpfqcIm9uafNUDD46C8tFKzIsqSQxx9iGLPpJNV9AMmnx9A==;
From: Jan Kiszka <jan.kiszka@siemens.com>
To: cip-dev@lists.cip-project.org
Cc: Quirin Gylstorff <quirin.gylstorff@siemens.com>,
	Cedric Hombourger <cedric.hombourger@siemens.com>,
	Kazuhiro Hayashi <kazuhiro3.hayashi@toshiba.co.jp>
Subject: [isar-cip-core][PATCH 0/9] Enable early Debian trixie support, drop sid
Date: Thu,  7 Nov 2024 11:57:48 +0100
Message-ID: <cover.1730977077.git.jan.kiszka@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-294854:519-21489:flowmailer
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 07 Nov 2024 10:58:14 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/17204

The next Debian release is still some time into the future, probably around
mid of next year again, but it turned out that - at least for our RISC-V
testing - it already provides a viable target. However, quite a bit more
changes were need than the so far circulating first attempts.

This series now seems to work fine for all our architectures and with full
feature set. It specifically allows us to switch from snapshot-based sid to
latest trixie with our riscv64 build. If that may break again in the future
we could still freeze the package set once more until trixie is finally
released.

These are technical changes, no official commitments yet on the CIP support
strategy for this not-yet-released Debian version.

Jan

Jan Kiszka (9):
  Provide recipe to rebuild gnu-efi 3.0.18 for fixing armhf bug
  swupdate: Control self-building via boolean var
  swupdate-signer: Ensure compatibility also with latest openssl 3.3
  u-boot: Use efisebdb with trixie for generating the UEFI key database
  initramfs-crypt-hook: Make dependencies release-specific and add
    trixie support
  read-only-rootfs: Do not install tmp-fs with trixie anymore
  efibootguard: Use prebuilt python-shtab from trixie onward
  Add Debian trixie
  Replace sid with trixie

 .gitlab-ci.yml                                |  6 +-
 Kconfig                                       |  7 +-
 classes/delta-update.bbclass                  |  4 +-
 classes/read-only-rootfs.bbclass              |  5 +-
 conf/distro/cip-core-sid.conf                 | 20 ----
 conf/distro/cip-core-trixie.conf              | 16 ++++
 doc/README.swupdate.md                        | 16 ++--
 kas-cip.yml                                   |  2 +-
 kas/opt/sid.yml                               | 15 ---
 kas/opt/trixie.yml                            | 15 +++
 .../efibootguard/efibootguard_0.18-1+cip.bb   |  7 +-
 recipes-bsp/u-boot/files/rules.tmpl           |  8 +-
 recipes-bsp/u-boot/u-boot-common-2024.01.inc  |  5 +-
 recipes-core/images/swupdate.inc              | 10 +-
 .../0001-ARM32-Split-headers-and-code.patch   | 93 +++++++++++++++++++
 recipes-devtools/gnu-efi/gnu-efi_latest.bb    | 25 +++++
 .../secure-boot-secrets/files/sid             |  1 +
 .../{sid => trixie}/PkKek-1-snakeoil.key      |  0
 .../{sid => trixie}/PkKek-1-snakeoil.pem      |  0
 .../swupdate-certificates/files/trixie        |  1 +
 .../swupdate-signer/files/sign-swu-cms        |  9 +-
 ...ook_0.3.bb => initramfs-crypt-hook_0.4.bb} | 10 +-
 start-qemu.sh                                 |  6 +-
 23 files changed, 206 insertions(+), 75 deletions(-)
 delete mode 100644 conf/distro/cip-core-sid.conf
 create mode 100644 conf/distro/cip-core-trixie.conf
 delete mode 100644 kas/opt/sid.yml
 create mode 100644 kas/opt/trixie.yml
 create mode 100644 recipes-devtools/gnu-efi/files/0001-ARM32-Split-headers-and-code.patch
 create mode 100644 recipes-devtools/gnu-efi/gnu-efi_latest.bb
 create mode 120000 recipes-devtools/secure-boot-secrets/files/sid
 rename recipes-devtools/secure-boot-secrets/files/{sid => trixie}/PkKek-1-snakeoil.key (100%)
 rename recipes-devtools/secure-boot-secrets/files/{sid => trixie}/PkKek-1-snakeoil.pem (100%)
 create mode 120000 recipes-devtools/swupdate-certificates/files/trixie
 rename recipes-initramfs/initramfs-crypt-hook/{initramfs-crypt-hook_0.3.bb => initramfs-crypt-hook_0.4.bb} (89%)

-- 
2.43.0


