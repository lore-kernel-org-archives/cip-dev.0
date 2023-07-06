Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0736FEB64DD
	for <webhook@archiver.kernel.org>; Thu,  6 Jul 2023 08:04:39 +0000 (UTC)
Received: from mta-65-227.siemens.flowmailer.net (mta-65-227.siemens.flowmailer.net [185.136.65.227])
 by mx.groups.io with SMTP id smtpd.web10.16608.1688630672827081983
 for <cip-dev@lists.cip-project.org>;
 Thu, 06 Jul 2023 01:04:33 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=jan.kiszka@siemens.com header.s=fm1 header.b=Znuk5Bcc;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.65.227, mailfrom: fm-294854-20230706080429c5a0647cef89d92681-_teyvd@rts-flowmailer.siemens.com)
Received: by mta-65-227.siemens.flowmailer.net with ESMTPSA id 20230706080429c5a0647cef89d92681
        for <cip-dev@lists.cip-project.org>;
        Thu, 06 Jul 2023 10:04:30 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=jan.kiszka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=mFOnYt+ByGBhyHEOIsSF9pJseMh3qBxUzEKY4lP8Br4=;
 b=Znuk5BcclZ0HA7CVrPgr0UtUYqsT7hKlLKWgtGKn+GlxudNcN2WFEYQn6iZB2Qx+SmctZB
 cjQ/8knKzZXxUv+EsDwPrVcUccRR9tXd9CRfz+6WiFP9eFp8sx0tO+sLkHfVqgzyVpzLSWJy
 5IMPSvZLHAU+RgGTnU1Q3Qw7GLeUg=;
From: Jan Kiszka <jan.kiszka@siemens.com>
To: cip-dev@lists.cip-project.org
Cc: Quirin Gylstorff <quirin.gylstorff@siemens.com>
Subject: [isar-cip-core][PATCH 3/3] x86: Harden watchdog settings
Date: Thu,  6 Jul 2023 10:04:28 +0200
Message-Id: <47f5c4c4904d2759cee134f4cd150c1c38fa8cf2.1688630668.git.jan.kiszka@siemens.com>
In-Reply-To: <cover.1688630668.git.jan.kiszka@siemens.com>
References: <cover.1688630668.git.jan.kiszka@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-294854:519-21489:flowmailer
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 06 Jul 2023 08:04:39 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/12257

From: Jan Kiszka <jan.kiszka@siemens.com>

These ensure that the watchdog is only starting to be services by
systemd, not yet by the kernel itself right after probing. This is
needed in order to catch lock-ups in the initramfs userspace.

While at it, turn the iTCO - where used - into no-way-out mode, making
things even more robust.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 wic/qemu-amd64-efibootguard-secureboot.wks.in | 2 +-
 wic/x86-efibootguard.wks.in                   | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/wic/qemu-amd64-efibootguard-secureboot.wks.in b/wic/qemu-amd64-efibootguard-secureboot.wks.in
index 5c411161..12fa45f0 100644
--- a/wic/qemu-amd64-efibootguard-secureboot.wks.in
+++ b/wic/qemu-amd64-efibootguard-secureboot.wks.in
@@ -7,4 +7,4 @@ part --source empty --align 1024 --fixed-size 1G --uuid "${ABROOTFS_PART_UUID_B}
 part /home --source rootfs --rootfs-dir=${IMAGE_ROOTFS}/home --fstype=ext4 --label home --align 1024 --size 1G
 part /var  --source rootfs --rootfs-dir=${IMAGE_ROOTFS}/var  --fstype=ext4 --label var  --align 1024 --size 2G
 
-bootloader --ptable gpt --append="console=tty0 console=ttyS0,115200 rootwait earlyprintk panic=5"
+bootloader --ptable gpt --append="console=tty0 console=ttyS0,115200 rootwait earlyprintk watchdog.handle_boot_enabled=0 iTCO_wdt.nowayout=1 panic=5"
diff --git a/wic/x86-efibootguard.wks.in b/wic/x86-efibootguard.wks.in
index 24b43873..38ad4117 100644
--- a/wic/x86-efibootguard.wks.in
+++ b/wic/x86-efibootguard.wks.in
@@ -11,4 +11,4 @@ part --source empty --align 1024 --fixed-size 1G --uuid "${ABROOTFS_PART_UUID_B}
 part /home --source rootfs --rootfs-dir=${IMAGE_ROOTFS}/home --fstype=ext4 --label home --align 1024  --size 1G --extra-space=100M 
 part /var --source rootfs --rootfs-dir=${IMAGE_ROOTFS}/var --fstype=ext4 --label var --align 1024  --size 2G --extra-space=100M
 
-bootloader --ptable gpt --append="console=tty0 console=ttyS0,115200 rootwait earlyprintk"
+bootloader --ptable gpt --append="console=tty0 console=ttyS0,115200 rootwait earlyprintk watchdog.handle_boot_enabled=0 iTCO_wdt.nowayout=1 "
-- 
2.35.3


