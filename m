Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07BB3D31776
	for <webhook@archiver.kernel.org>; Tue,  5 Nov 2024 17:54:44 +0000 (UTC)
Received: from mta-64-225.siemens.flowmailer.net (mta-64-225.siemens.flowmailer.net [185.136.64.225])
 by mx.groups.io with SMTP id smtpd.web11.26507.1730829277278976270
 for <cip-dev@lists.cip-project.org>;
 Tue, 05 Nov 2024 09:54:38 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=jan.kiszka@siemens.com header.s=fm1 header.b=Vlf0eMlJ;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.64.225, mailfrom: fm-294854-20241105175433f8d956cca4ce3c10b2-em7mzx@rts-flowmailer.siemens.com)
Received: by mta-64-225.siemens.flowmailer.net with ESMTPSA id 20241105175433f8d956cca4ce3c10b2
        for <cip-dev@lists.cip-project.org>;
        Tue, 05 Nov 2024 18:54:34 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=jan.kiszka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding;
 bh=s8jnNoNnVYUqdVsFLvkzZMeb4NPi+wTae5/SHTLxZtU=;
 b=Vlf0eMlJV6OhL7kmyAyyWaaM5xXIFsgUCKU7wHOYcheQTbh1OzZ3028pulHVzzdViLs+OK
 wnQe8B9NX5RVy9QY7F08Zo5GlQAhwFBKhrupCVMIs1KVX6s+uLnRtQ5ybq5dR0ZjSsNHwofk
 PijbtqbG8qmC6Nyb0sA+7Uzyb83oOfSG19JalqsIYAzsb6Uu2aNo5BTvO40Nz24T3TR557bM
 G1kTBL7q3MmPyf/2svhZm+b/PmmzHbZJNfv94ynoessNIF3boCi4KpylCYG01DIptVEDa6zT
 A2PZ6zjfl2zAAOmKQClS4GlDWK21ZqmVB+SZ0k7yiHE9Eb2JCtQuvw4Q==;
From: Jan Kiszka <jan.kiszka@siemens.com>
To: cip-dev@lists.cip-project.org
Subject: [isar-cip-core][PATCH v2 0/6] Add support for EROFS
Date: Tue,  5 Nov 2024 18:54:27 +0100
Message-ID: <cover.1730829273.git.jan.kiszka@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-294854:519-21489:flowmailer
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 05 Nov 2024 17:54:44 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/17183

Changes in v2:
- update cip-kernel-config revision further to support non-x86 qemu targets

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


