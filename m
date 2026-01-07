Return-Path: <quirin.gylstorff@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C286CFD633
	for <webhook@archiver.kernel.org>; Wed,  7 Jan 2026 13:27:25 +0000 (UTC)
Received: from mta-65-226.siemens.flowmailer.net (mta-65-226.siemens.flowmailer.net [185.136.65.226])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.5705.1767792443621321420
 for <cip-dev@lists.cip-project.org>;
 Wed, 07 Jan 2026 05:27:25 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=Quirin.Gylstorff@siemens.com header.s=fm1 header.b=R78zi6lM;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.65.226, mailfrom: fm-51332-20260107132717bd86947b4800020735-j5wgt_@rts-flowmailer.siemens.com)
Received: by mta-65-226.siemens.flowmailer.net with ESMTPSA id 20260107132717bd86947b4800020735
        for <cip-dev@lists.cip-project.org>;
        Wed, 07 Jan 2026 14:27:21 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=Quirin.Gylstorff@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:References:In-Reply-To;
 bh=zj0bddlAKSZHDdiUK70o9KENr83rhYS1jFcKtXoo18c=;
 b=R78zi6lMOhohq6ulyDSFapukbolWEORldLDvsrr2QSiKuAJ3BZG4+e2zSW3mYOeWReAzXW
 wb5qQyVIJNhm1eqUIWIvHlVJHObLD0AeicOzJCEanREc8HR7oYe6Jo/7bOdIGnwxYlNfMwp2
 hZ7MJ7fitltEL4XA0CNkVVxVxZmBQj52onoOTpwYc8uJmGDdwq9YjngPvyLQFIUuk0cSfIjF
 lsKKC3NRLXYF+Q2YFi0gZF5wMvW4Rk5v8gG44OkiAKuxx90J0yCUZrIZyv8wCq6cr/zrKnY7
 x0dybSt+A1M3vsrOIm14mb0JcM5FlLlOmnqz+I0Dtfwpjx3Qc/yr+uBg==;
From: Quirin Gylstorff <Quirin.Gylstorff@siemens.com>
To: jan.kiszka@siemens.com,
	clara.kowalsky@siemens.com,
	cip-dev@lists.cip-project.org,
	benedikt.niedermayr@siemens.com
Subject: [cip-dev][isar-cip-core][PATCH v2 2/7] Move RO_ROOTFS Options to swupdate.inc
Date: Wed,  7 Jan 2026 14:26:25 +0100
Message-ID: <20260107132707.733180-3-Quirin.Gylstorff@siemens.com>
In-Reply-To: <20260107132707.733180-1-Quirin.Gylstorff@siemens.com>
References: <20260107132707.733180-1-Quirin.Gylstorff@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-51332:519-21489:flowmailer
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 07 Jan 2026 13:27:25 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/21408

From: Quirin Gylstorff <quirin.gylstorff@siemens.com>

These defaults should always be set and there should not be
part of the kas option file.

Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
---
 kas/opt/swupdate.yml                               |  5 -----
 recipes-core/images/swupdate.inc                   | 14 ++++++++++++++
 .../cip-core-initramfs/cip-core-initramfs.bb       |  2 ++
 3 files changed, 16 insertions(+), 5 deletions(-)

diff --git a/kas/opt/swupdate.yml b/kas/opt/swupdate.yml
index f1f3f77..4a128f1 100644
--- a/kas/opt/swupdate.yml
+++ b/kas/opt/swupdate.yml
@@ -20,11 +20,6 @@ local_conf_header:
     OVERRIDES .= ":swupdate"
 
   wic-swu: |
-    RO_ROOTFS_TYPE ??= "squashfs"
-    IMAGE_TYPEDEP:wic += "${RO_ROOTFS_TYPE}"
-    IMAGE_FSTYPES:append = " swu"
-    # input is already compressed
-    SWU_COMPRESSION_TYPE = ""
     WKS_FILE ?= "${MACHINE}-${SWUPDATE_BOOTLOADER}.wks.in"
     ABROOTFS_PART_UUID_A ?= "fedcba98-7654-3210-cafe-5e0710000001"
     ABROOTFS_PART_UUID_B ?= "fedcba98-7654-3210-cafe-5e0710000002"
diff --git a/recipes-core/images/swupdate.inc b/recipes-core/images/swupdate.inc
index 75be566..fa35458 100644
--- a/recipes-core/images/swupdate.inc
+++ b/recipes-core/images/swupdate.inc
@@ -12,6 +12,20 @@
 inherit image_uuid
 inherit read-only-rootfs
 
+SWUPDATE_BOOTLOADER ??= "efibootguard"
+python __anonymous() {
+    bootloader = d.getVar("SWUPDATE_BOOTLOADER") or "None"
+    if not bootloader in ["efibootguard"]:
+        bb.error("swupdate: SWUPDATE_BOOTLOADER set to incompatible value: " + bootloader)
+}
+
+include recipes-core/images/swupdate-${SWUPDATE_BOOTLOADER}.inc
+
+IMAGE_TYPEDEP:wic += "${RO_ROOTFS_TYPE}"
+IMAGE_FSTYPES:append = " swu"
+# input is already compressed
+SWU_COMPRESSION_TYPE = ""
+
 # read-only rootfs with /home and /var
 # as separate partitions is used
 # /boot is excluded as an unified kernel image
diff --git a/recipes-initramfs/cip-core-initramfs/cip-core-initramfs.bb b/recipes-initramfs/cip-core-initramfs/cip-core-initramfs.bb
index 9d53394..076f14a 100644
--- a/recipes-initramfs/cip-core-initramfs/cip-core-initramfs.bb
+++ b/recipes-initramfs/cip-core-initramfs/cip-core-initramfs.bb
@@ -11,6 +11,8 @@
 
 inherit initramfs
 
+RO_ROOTFS_TYPE ??= "squashfs"
+
 INITRAMFS_INSTALL += " \
     initramfs-overlay-hook \
     "
-- 
2.51.2


