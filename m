Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07F9FC02199
	for <webhook@archiver.kernel.org>; Thu, 30 Jan 2025 09:39:29 +0000 (UTC)
Received: from mta-64-226.siemens.flowmailer.net (mta-64-226.siemens.flowmailer.net [185.136.64.226])
 by mx.groups.io with SMTP id smtpd.web11.12049.1738229961768308809
 for <cip-dev@lists.cip-project.org>;
 Thu, 30 Jan 2025 01:39:22 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=jan.kiszka@siemens.com header.s=fm2 header.b=HzfiBzGK;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.64.226, mailfrom: fm-294854-20250130093919cfd370f285de64d22f-ln76rd@rts-flowmailer.siemens.com)
Received: by mta-64-226.siemens.flowmailer.net with ESMTPSA id 20250130093919cfd370f285de64d22f
        for <cip-dev@lists.cip-project.org>;
        Thu, 30 Jan 2025 10:39:19 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm2;
 d=siemens.com; i=jan.kiszka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=EsKDZ+6UtI7F5jvcL+L8z2VMvxDGZhRUWl0gu2OCWjc=;
 b=HzfiBzGKgpIgvdIIYguhp1/qzbtS0KGO9Xi8P/s9grL6qGH4Wg8ieC32iZ76YB3A8ErrTp
 HzA8nFr5ovDjzhsoxeQZFSov1qQQBRUqWF0XZI74M6Ddc7hsrHjHXgB+BIWrbVx33YM26LWe
 gH35MQPa4LsNQ80Yg/H0PdWwDRQKABXTjHNJFIScrty71S2jfrncivB4dBBMdfjWWseDr7lY
 jpRxNUXQVlvYhSBqC5zdUg5swzMzN0WBYcqXFpdC5p7QQeEn8lp4+tIOUm4mQmlIQNVpNfyz
 rRewVgfi3nUVmC6yncLwMIiMAfO3EvJkyLsH9wTO2+uPgDJOPAevgjhA==;
From: Jan Kiszka <jan.kiszka@siemens.com>
To: cip-dev@lists.cip-project.org
Cc: Christian Storm <christian.storm@siemens.com>,
	Quirin Gylstorff <quirin.gylstorff@siemens.com>,
	Felix Moessbauer <felix.moessbauer@siemens.com>
Subject: [isar-cip-core][RFC][PATCH 09/10] swupdate: Activate abvar initramfs hook when VAR_FS_TYPE is set to btrfs
Date: Thu, 30 Jan 2025 10:39:16 +0100
Message-ID: <869582b7defc0b44faac3ef9cab05234f737d54e.1738229957.git.jan.kiszka@siemens.com>
In-Reply-To: <cover.1738229957.git.jan.kiszka@siemens.com>
References: <cover.1738229957.git.jan.kiszka@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-294854:519-21489:flowmailer
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 30 Jan 2025 09:39:29 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/17705

From: Jan Kiszka <jan.kiszka@siemens.com>

This enables to control whether an swupdate target image uses A/B
snapshots for /var by setting VAR_FS_TYPE to btrfs. While we will switch
many of our own targets soon, not all are compatible or tested yet and
some downstream users may want to continue without snapshots.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 kas/opt/ebg-swu.yml                                        | 6 +++++-
 recipes-initramfs/cip-core-initramfs/cip-core-initramfs.bb | 3 ++-
 2 files changed, 7 insertions(+), 2 deletions(-)

diff --git a/kas/opt/ebg-swu.yml b/kas/opt/ebg-swu.yml
index 61a8eeef..9084cea1 100644
--- a/kas/opt/ebg-swu.yml
+++ b/kas/opt/ebg-swu.yml
@@ -1,7 +1,7 @@
 #
 # CIP Core, generic profile
 #
-# Copyright (c) Siemens AG, 2021-2022
+# Copyright (c) Siemens AG, 2021-2025
 #
 # Authors:
 #  Quirin Gylstorff <quirin.gylstorff@siemens.com>
@@ -33,3 +33,7 @@ local_conf_header:
     IMAGER_BUILD_DEPS:append:qemu-arm64 = " u-boot-qemu-arm64"
     IMAGER_BUILD_DEPS:append:qemu-arm = " u-boot-qemu-arm"
     IMAGER_BUILD_DEPS:append:qemu-riscv64 = " opensbi-qemu-riscv64"
+  ab-persistency: |
+    OVERRIDES .= "${@':abvar' if d.getVar('VAR_FS_TYPE') == 'btrfs' else ''}"
+    CRYPT_BTRFS_SUPPORT:abvar = "1"
+    IMAGE_PREINSTALL:append:abvar = " btrfs-progs"
diff --git a/recipes-initramfs/cip-core-initramfs/cip-core-initramfs.bb b/recipes-initramfs/cip-core-initramfs/cip-core-initramfs.bb
index 0e4cf743..e6eb34c6 100644
--- a/recipes-initramfs/cip-core-initramfs/cip-core-initramfs.bb
+++ b/recipes-initramfs/cip-core-initramfs/cip-core-initramfs.bb
@@ -1,7 +1,7 @@
 #
 # CIP Core, generic profile
 #
-# Copyright (c) Siemens AG, 2021 - 2023
+# Copyright (c) Siemens AG, 2021 - 2025
 #
 # Authors:
 #  Quirin Gylstorff <quirin.gylstorff@siemens.com>
@@ -15,4 +15,5 @@ INITRAMFS_INSTALL += " \
     initramfs-overlay-hook \
     "
 
+INITRAMFS_INSTALL:append:abvar = " initramfs-abvar-hook"
 INITRAMFS_INSTALL:append:encrypt-partitions = " initramfs-crypt-hook"
-- 
2.43.0


