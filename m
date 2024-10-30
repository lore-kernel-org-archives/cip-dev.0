Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70AAFD5CC9C
	for <webhook@archiver.kernel.org>; Wed, 30 Oct 2024 11:52:02 +0000 (UTC)
Received: from mta-64-228.siemens.flowmailer.net (mta-64-228.siemens.flowmailer.net [185.136.64.228])
 by mx.groups.io with SMTP id smtpd.web10.13032.1730289112422704657
 for <cip-dev@lists.cip-project.org>;
 Wed, 30 Oct 2024 04:51:53 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=jan.kiszka@siemens.com header.s=fm1 header.b=VacUNv+U;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.64.228, mailfrom: fm-294854-20241030115148a862aae77949f691c7-zhkkjx@rts-flowmailer.siemens.com)
Received: by mta-64-228.siemens.flowmailer.net with ESMTPSA id 20241030115148a862aae77949f691c7
        for <cip-dev@lists.cip-project.org>;
        Wed, 30 Oct 2024 12:51:49 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=jan.kiszka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding;
 bh=VEen+36pz/WTZGBADxULGaFa5dTqlSho25V3DAtbq30=;
 b=VacUNv+UJPtmERFHh9glM3BqaWz1bfO8Tf501rT5ULEG3MFUIOGGCX0i7G8Je76KjFdyns
 kAjRVQj28FLy1yZs1fFAtn12UKDUtGlLsrbyJJM67XjEAYcA/cB271G7WNozcpNlznrS9Saa
 UyIl7j/uxZJiQXpnXni00C/wfD17apxZxOVHSFj5aeCFEQ92m+wQz6Vmn+Q6LPZVsQwFUd0S
 T+gFsf+KYtcUKRMtLa8i/4v/cOSuFoJ3jXPunF8XphCCl/HSMi2ZaEgnBbdkxl5uP6gnKNuC
 IOlybOWtpABomKuEV1eQaBDoQoEgRIjWmTOxWN2ImIcn7kPG3o0vDaWw==;
From: Jan Kiszka <jan.kiszka@siemens.com>
To: cip-dev@lists.cip-project.org
Subject: [isar-cip-core][PATCH 0/6] Add support for EROFS
Date: Wed, 30 Oct 2024 12:51:41 +0100
Message-ID: <cover.1730289107.git.jan.kiszka@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-294854:519-21489:flowmailer
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 30 Oct 2024 11:52:02 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/17119

EROFS is a read-only file system that can act as alternative to squashfs
that we so far use for our A/B OTA update setups. It can perform faster
during runtime but may come with larger storage demand. See [1] for some
comparison.

We just enabled support for it in our 6.1 defconfigs, and this series now
enable CIP core to switch from squashfs to EROFS when requested.

Jan

[1] https://sigma-star.at/blog/2022/07/squashfs-erofs

Jan Kiszka (6):
  Make the read-only rootfs type configurable
  initramfs-crypt-hook: Prepare for EROFS as alternative
  Add initramfs-erofs-hook
  Introduce class for generating EROFS images
  linux-cip: Update cip-kernel-config revision
  kas: Add option for selecting read-only rootfs type

 Kconfig                                       | 16 +++++++++
 classes/erofs.bbclass                         | 34 +++++++++++++++++++
 classes/swupdate.bbclass                      |  3 +-
 classes/verity.bbclass                        |  2 +-
 conf/distro/cip-core-common.inc               |  4 ++-
 conf/layer.conf                               |  2 +-
 kas/opt/erofs.yml                             | 16 +++++++++
 kas/opt/swupdate.yml                          |  8 ++---
 .../files/encrypt_partition.script            |  2 +-
 ...ook_0.2.bb => initramfs-crypt-hook_0.3.bb} |  0
 .../initramfs-erofs-hook/files/erofs.hook     | 25 ++++++++++++++
 .../initramfs-erofs-hook_0.1.bb               | 24 +++++++++++++
 recipes-kernel/linux/cip-kernel-config.inc    |  2 +-
 wic/bbb-efibootguard.wks.in                   |  2 +-
 wic/hihope-rzg2m-efibootguard.wks.in          |  2 +-
 wic/qemu-arm64-efibootguard.wks.in            |  2 +-
 wic/qemu-riscv64-efibootguard.wks.in          |  2 +-
 wic/x86-uefi-efibootguard.wks.in              |  2 +-
 18 files changed, 133 insertions(+), 15 deletions(-)
 create mode 100644 classes/erofs.bbclass
 create mode 100644 kas/opt/erofs.yml
 rename recipes-initramfs/initramfs-crypt-hook/{initramfs-crypt-hook_0.2.bb => initramfs-crypt-hook_0.3.bb} (100%)
 create mode 100644 recipes-initramfs/initramfs-erofs-hook/files/erofs.hook
 create mode 100644 recipes-initramfs/initramfs-erofs-hook/initramfs-erofs-hook_0.1.bb

-- 
2.43.0


