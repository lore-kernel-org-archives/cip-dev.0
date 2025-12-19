Return-Path: <quirin.gylstorff@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6443CD767D2
	for <webhook@archiver.kernel.org>; Fri, 19 Dec 2025 10:33:58 +0000 (UTC)
Received: from mta-65-226.siemens.flowmailer.net (mta-65-226.siemens.flowmailer.net [185.136.65.226])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.14211.1766140433331955003
 for <cip-dev@lists.cip-project.org>;
 Fri, 19 Dec 2025 02:33:54 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=Quirin.Gylstorff@siemens.com header.s=fm2 header.b=a0g/w/Je;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.65.226, mailfrom: fm-51332-20251219103350cd8cdc7ca8000207de-f2krm7@rts-flowmailer.siemens.com)
Received: by mta-65-226.siemens.flowmailer.net with ESMTPSA id 20251219103350cd8cdc7ca8000207de
        for <cip-dev@lists.cip-project.org>;
        Fri, 19 Dec 2025 11:33:51 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm2;
 d=siemens.com; i=Quirin.Gylstorff@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:References:In-Reply-To;
 bh=OlE8PKPETAnpgefIIrHIfVbDx62iJ9lKQnzGCJM3APU=;
 b=a0g/w/JefnGseyPMkYwxuTBGvtW6HcMb7B7xRxpqL52mfdgjIC7dyoppZwfiPWFsjwfV4j
 7FfzgIur/e80AsxqNdE2nujejD4xsAo5fjxsbRtBk1d1I4Y/7J+1QgG/0seh6wWV/w/VoL7F
 7PMoud/pCmC9QRZb+UEJIPw9YqKQ8X1kYwrhfPSzi8fNw04G3Eg3IXIjLui3PtVMNNd69HwA
 5yT7RJLU0FOIiGnluQK61MvhHcnov/KvablZY3EXugiYAzVfiSYpvEL9yIlqahMJYVyl1YiG
 p+zzJ2oQ26RWwQhZat+QN2P+pfQnYZSQ86x4hbneGvgLUDeQhiuIcs+w==;
From: Quirin Gylstorff <Quirin.Gylstorff@siemens.com>
To: jan.kiszka@siemens.com,
	clara.kowalsky@siemens.com,
	cip-dev@lists.cip-project.org,
	benedikt.niedermayr@siemens.com
Subject: [cip-dev][isar-cip-core][RFC 2/6] Move RO_ROOTFS Options to swupdate.inc
Date: Fri, 19 Dec 2025 11:31:22 +0100
Message-ID: <20251219103349.1227710-3-Quirin.Gylstorff@siemens.com>
In-Reply-To: <20251219103349.1227710-1-Quirin.Gylstorff@siemens.com>
References: <20251219103349.1227710-1-Quirin.Gylstorff@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-51332:519-21489:flowmailer
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 19 Dec 2025 10:33:58 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/21169

From: Quirin Gylstorff <quirin.gylstorff@siemens.com>

These defaults should always be set and there should not be
part of the kas option file.

Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
---
 kas/opt/swupdate.yml                                       | 5 -----
 recipes-core/images/swupdate.inc                           | 6 ++++++
 recipes-initramfs/cip-core-initramfs/cip-core-initramfs.bb | 2 ++
 3 files changed, 8 insertions(+), 5 deletions(-)

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
index 75be566..696ee7d 100644
--- a/recipes-core/images/swupdate.inc
+++ b/recipes-core/images/swupdate.inc
@@ -12,6 +12,12 @@
 inherit image_uuid
 inherit read-only-rootfs
 
+RO_ROOTFS_TYPE ??= "squashfs"
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


