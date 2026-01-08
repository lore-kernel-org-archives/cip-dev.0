Return-Path: <quirin.gylstorff@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9DFAD1D475
	for <webhook@archiver.kernel.org>; Thu,  8 Jan 2026 15:17:02 +0000 (UTC)
Received: from mta-64-225.siemens.flowmailer.net (mta-64-225.siemens.flowmailer.net [185.136.64.225])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.8641.1767885418129901656
 for <cip-dev@lists.cip-project.org>;
 Thu, 08 Jan 2026 07:16:58 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=Quirin.Gylstorff@siemens.com header.s=fm1 header.b=HDauwhMz;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.64.225, mailfrom: fm-51332-202601081516552beb551cde000207e3-heufkz@rts-flowmailer.siemens.com)
Received: by mta-64-225.siemens.flowmailer.net with ESMTPSA id 202601081516552beb551cde000207e3
        for <cip-dev@lists.cip-project.org>;
        Thu, 08 Jan 2026 16:16:56 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=Quirin.Gylstorff@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:References:In-Reply-To;
 bh=Uni2WI9twlmXAObsQumBr44gEfExDTyydkbNOkFjZtM=;
 b=HDauwhMzKqRjsIvINUbJiZbIPCAdAVO4RFQfeUhYkx7ZQBAujhdrR0T3IUeBTWXTLhOl7g
 XD6ByL4Go5f45kcdQ4FiGImp397oh0Kqxe21tOkqCWXGV8Yek2HyHw6HMxG4TeJX0UCEC+UV
 pjpk8/s86ZqriIatvmbOcqhWOf9e0YO08XrMDPqZUau9eVAYft40L7wFZ2ng+FrUpHL/jbyo
 A0eBnvjjC2lLOOnbGPMjHJWHgP7lV+qvRzbxzBZYgmYUjySzmSxdmm5x+CwwVDx3D9UKiDJD
 LLFALMwwWSpFQjdwSXKeOWV27CMf2MrOmgt3VeC/0VjFlUFcUTmpalXQ==;
From: Quirin Gylstorff <Quirin.Gylstorff@siemens.com>
To: jan.kiszka@siemens.com,
	clara.kowalsky@siemens.com,
	benedikt.niedermayr@siemens.com,
	cip-dev@lists.cip-project.org
Subject: [cip-dev][isar-cip-core][PATCH v3 2/7] Move RO_ROOTFS Options to swupdate.inc
Date: Thu,  8 Jan 2026 16:16:09 +0100
Message-ID: <20260108151650.124306-3-Quirin.Gylstorff@siemens.com>
In-Reply-To: <20260108151650.124306-1-Quirin.Gylstorff@siemens.com>
References: <20260108151650.124306-1-Quirin.Gylstorff@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-51332:519-21489:flowmailer
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 08 Jan 2026 15:17:02 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/21483

From: Quirin Gylstorff <quirin.gylstorff@siemens.com>

These defaults should always be set and there should not be
part of the kas option file.

Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
---
 kas/opt/swupdate.yml                             |  5 -----
 recipes-core/images/swupdate.inc                 | 16 +++++++++++++++-
 .../cip-core-initramfs/cip-core-initramfs.bb     |  2 ++
 3 files changed, 17 insertions(+), 6 deletions(-)

diff --git a/kas/opt/swupdate.yml b/kas/opt/swupdate.yml
index d633cc9..c5b7c61 100644
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
index 75be566..b2fe4ac 100644
--- a/recipes-core/images/swupdate.inc
+++ b/recipes-core/images/swupdate.inc
@@ -1,7 +1,7 @@
 #
 # CIP Core, generic profile
 #
-# Copyright (c) Siemens AG, 2023-2025
+# Copyright (c) Siemens AG, 2023-2026
 #
 # Authors:
 #  Quirin Gylstorff <quirin.gylstorff@siemens.com>
@@ -12,6 +12,20 @@
 inherit image_uuid
 inherit read-only-rootfs
 
+SWUPDATE_BOOTLOADER ??= "efibootguard"
+python __anonymous() {
+    bootloader = d.getVar("SWUPDATE_BOOTLOADER")
+    if not bootloader in ["efibootguard"]:
+        bb.error(f"swupdate: SWUPDATE_BOOTLOADER set to incompatible value: '{bootloader}'")
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
index 50238fe..b686185 100644
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


