Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF7D1C02197
	for <webhook@archiver.kernel.org>; Thu, 30 Jan 2025 09:39:28 +0000 (UTC)
Received: from mta-64-227.siemens.flowmailer.net (mta-64-227.siemens.flowmailer.net [185.136.64.227])
 by mx.groups.io with SMTP id smtpd.web10.12048.1738229960992057745
 for <cip-dev@lists.cip-project.org>;
 Thu, 30 Jan 2025 01:39:22 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=jan.kiszka@siemens.com header.s=fm2 header.b=FVUMU+DN;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.64.227, mailfrom: fm-294854-202501300939187cebfbb551f549eea9-ui1lt1@rts-flowmailer.siemens.com)
Received: by mta-64-227.siemens.flowmailer.net with ESMTPSA id 202501300939187cebfbb551f549eea9
        for <cip-dev@lists.cip-project.org>;
        Thu, 30 Jan 2025 10:39:18 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm2;
 d=siemens.com; i=jan.kiszka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc;
 bh=KfpE2h7M+oZZ1d/Hy7AYCQQSndgDXanf6/MRVibpiI8=;
 b=FVUMU+DNOwqMkEdJBPgc9bAkl0WBsVtaJ9rNWkXzl2zTAAtHB9f1XY5ihCsqGBQF9GdRmw
 LgBS7x3btKIxivPSfqaoJeYM31BRlGXo02t8pvfjf0aaqeZazWlHee9dV7U4LZsXtjoWT92X
 7hZ2XFfWxUq/y+XIxqCEd94sfkQ7//9jRX6N0mUKiSzjK7dbfobDXE7dCPdoVMoZ1YbVGZPY
 rBmAY521pLoDk6jZCp98OB43sweKKUFurJ3oeGLHZiRhR1YF6IkO9S+qfn8JiCQgUZ+hkUk0
 L97XkA7YbdzGJRg21OcCVWQi6PHdAniDCLgvPXJM6fqX5amSDwB+FGXQ==;
From: Jan Kiszka <jan.kiszka@siemens.com>
To: cip-dev@lists.cip-project.org
Cc: Christian Storm <christian.storm@siemens.com>,
	Quirin Gylstorff <quirin.gylstorff@siemens.com>,
	Felix Moessbauer <felix.moessbauer@siemens.com>
Subject: [isar-cip-core][RFC][PATCH 00/10] Provide A/B snapshot support for persistent /var
Date: Thu, 30 Jan 2025 10:39:07 +0100
Message-ID: <cover.1738229957.git.jan.kiszka@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-294854:519-21489:flowmailer
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 30 Jan 2025 09:39:28 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/17703

This is a first attempt to provide a pattern and reusable recipes for
saving and rolling back the persistent data during A/B updates. The
obvious approach is using a filesystem that supports snapshots and
linking those to the rootfs revision that is being booted. As first
implementation, we are using btrfs. While the current implementation is
built around btrfs, the concept should not. It may even work with
device mapper snapshots.

That said, the devil is always in the details. And even this "simple",
btrfs-only implementation took some rounds to find a logic that neither
piles up obsolete snapshots or deletes them prematurely. Still, careful
review is highly welcome, specifically of patch 3.

As we are currently having split /var and /home partitions, this does
not cover anything in home directories. However, this will automatically
change when [1] is addressed.

Jan

[1] https://gitlab.com/cip-project/cip-core/isar-cip-core/-/issues/123

Jan Kiszka (10):
  initramfs-crypt-hook: Add support for btrfs
  initramfs-crypt-hook: Bump revision
  initramfs: Add hook for managing /var in A/B fashion
  initramfs-overlay-hook: Optimize variable initialization
  initramfs-overlay-hook: Tune the parameter documentation
  initramfs-overlay-hook: Add awareness for abvar hook
  initramfs-overlay-hook: Bump revision
  swupdate: Make var filesystem type configurable for update images
  swupdate: Activate abvar initramfs hook when VAR_FS_TYPE is set to
    btrfs
  Enable A/B snapshot for /var on x86 and qemu-arm64

 classes/swupdate.bbclass                      |  1 +
 conf/machine/qemu-amd64.conf                  |  5 +-
 conf/machine/qemu-arm64.conf                  |  5 +-
 conf/machine/x86-uefi.conf                    |  5 +-
 kas/opt/ebg-swu.yml                           |  6 +-
 kas/opt/swupdate.yml                          |  1 +
 .../cip-core-initramfs/cip-core-initramfs.bb  |  3 +-
 .../files/local-bottom.tmpl                   | 86 +++++++++++++++++++
 .../initramfs-abvar-hook_0.1.bb               | 31 +++++++
 .../files/local-top-complete                  |  7 ++
 ...ook_0.5.bb => initramfs-crypt-hook_0.6.bb} |  6 ++
 .../files/local-bottom.tmpl                   | 10 ++-
 ...k_0.2.bb => initramfs-overlay-hook_0.3.bb} |  8 +-
 wic/bbb-efibootguard.wks.in                   |  2 +-
 wic/hihope-rzg2m-efibootguard.wks.in          |  2 +-
 wic/qemu-arm64-efibootguard-secureboot.wks.in |  2 +-
 wic/qemu-arm64-efibootguard.wks.in            |  2 +-
 wic/qemu-riscv64-efibootguard.wks.in          |  2 +-
 wic/x86-uefi-efibootguard-secureboot.wks.in   |  2 +-
 wic/x86-uefi-efibootguard.wks.in              |  2 +-
 20 files changed, 168 insertions(+), 20 deletions(-)
 create mode 100644 recipes-initramfs/initramfs-abvar-hook/files/local-bottom.tmpl
 create mode 100644 recipes-initramfs/initramfs-abvar-hook/initramfs-abvar-hook_0.1.bb
 rename recipes-initramfs/initramfs-crypt-hook/{initramfs-crypt-hook_0.5.bb => initramfs-crypt-hook_0.6.bb} (93%)
 rename recipes-initramfs/initramfs-overlay-hook/{initramfs-overlay-hook_0.2.bb => initramfs-overlay-hook_0.3.bb} (87%)

-- 
2.43.0


