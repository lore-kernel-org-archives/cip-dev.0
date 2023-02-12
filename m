Return-Path: <ncaidin@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E58F6C636D3
	for <webhook@archiver.kernel.org>; Sun, 12 Feb 2023 22:54:13 +0000 (UTC)
Received: from mta-64-226.siemens.flowmailer.net (mta-64-226.siemens.flowmailer.net [185.136.64.226])
 by mx.groups.io with SMTP id smtpd.web11.7477.1676190510835088738
 for <cip-dev@lists.cip-project.org>;
 Sun, 12 Feb 2023 00:28:31 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=felix.moessbauer@siemens.com header.s=fm1 header.b=fedlJWjQ;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.64.226, mailfrom: fm-72506-202302120828283dd73735f5f3870846-zi67aw@rts-flowmailer.siemens.com)
Received: by mta-64-226.siemens.flowmailer.net with ESMTPSA id 202302120828283dd73735f5f3870846
        for <cip-dev@lists.cip-project.org>;
        Sun, 12 Feb 2023 09:28:28 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=felix.moessbauer@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=OfXHq/mn5YzILBo2750DpvFhLN6g54O0quepi0MgxR0=;
 b=fedlJWjQbzvHnFOgtxPMi6RrLwpw8eGAXWnoTitQ8vDKrsXiuop3UmIFh8mAt+b4NYZPrJ
 2e3ymTKiZQKgZRipqoTiNn7NQgvsX2VrR61mda2bnbf89E6TOrmRc8BC5QrZlf6oAALLKR0P
 GBTGVp+QPdxkTk5aEZZa28kmLgdLc=;
From: Felix Moessbauer <felix.moessbauer@siemens.com>
To: cip-dev@lists.cip-project.org
Cc: adriaan.schmidt@siemens.com,
	jan.kiszka@siemens.com,
	quirin.gylstorff@siemens.com,
	Felix Moessbauer <felix.moessbauer@siemens.com>
Subject: [isar-cip-core][PATCH v4 3/8] swu: directly image from squashfs rootfs
Date: Sun, 12 Feb 2023 08:27:53 +0000
Message-Id: <20230212082758.1166262-4-felix.moessbauer@siemens.com>
In-Reply-To: <20230212082758.1166262-1-felix.moessbauer@siemens.com>
References: <20230212082758.1166262-1-felix.moessbauer@siemens.com>
MIME-Version: 1.0
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-72506:519-21489:flowmailer
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Sun, 12 Feb 2023 22:54:13 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/10673

This patch reworks the generation of the swu file. Instead of using the
rootfs partition created by wic, we directly use the squashfs rootfs as
default. By that, we do not have to deploy the WIC partitions and also
always select the correct rootfs independent of the partition number.
This is especially relevant for embedded boards, where the first
partitions contain the u-boot-spl and firmware.

For use-cases with other fs formats (like verity), we support to
overwrite the SWU_ROOTFS_NAME and SWU_ROOTFS_TYPE.

Signed-off-by: Felix Moessbauer <felix.moessbauer@siemens.com>
---
 classes/swupdate.bbclass             | 8 +++++---
 kas/opt/ebg-secure-boot-snakeoil.yml | 1 +
 kas/opt/swupdate.yml                 | 1 +
 3 files changed, 7 insertions(+), 3 deletions(-)

diff --git a/classes/swupdate.bbclass b/classes/swupdate.bbclass
index 966f7c0..50a15e1 100644
--- a/classes/swupdate.bbclass
+++ b/classes/swupdate.bbclass
@@ -6,9 +6,12 @@
 # Authors:
 #  Christian Storm <christian.storm@siemens.com>
 #  Quirin Gylstorff <quirin.gylstorff@siemens.com>
+#  Felix Moessbauer <felix.moessbauer@siemens.com>
 #
 # SPDX-License-Identifier: MIT
-ROOTFS_PARTITION_NAME ?= "${IMAGE_FULLNAME}.wic.p4.gz"
+SWU_ROOTFS_TYPE ?= "squashfs"
+SWU_ROOTFS_NAME ?= "${IMAGE_FULLNAME}"
+ROOTFS_PARTITION_NAME ?= "${SWU_ROOTFS_NAME}.${SWU_ROOTFS_TYPE}.gz"
 
 SWU_IMAGE_FILE ?= "${DEPLOY_DIR_IMAGE}/${PN}-${DISTRO}-${MACHINE}.swu"
 SWU_DESCRIPTION_FILE ?= "sw-description"
@@ -19,8 +22,7 @@ SWU_SIGNATURE_TYPE ?= "rsa"
 
 BUILDCHROOT_IMAGE_FILE ?= "${PP_DEPLOY}/${@os.path.basename(d.getVar('SWU_IMAGE_FILE'))}"
 
-IMAGE_TYPEDEP:wic += "squashfs"
-IMAGE_TYPEDEP:swu = "wic"
+IMAGE_TYPEDEP:swu = "wic ${SWU_ROOTFS_TYPE}.gz"
 IMAGER_INSTALL:swu += "cpio ${@'openssl' if bb.utils.to_boolean(d.getVar('SWU_SIGNED')) else ''}"
 
 IMAGE_SRC_URI:swu = "file://${SWU_DESCRIPTION_FILE}.tmpl"
diff --git a/kas/opt/ebg-secure-boot-snakeoil.yml b/kas/opt/ebg-secure-boot-snakeoil.yml
index a182a67..8f2b7bb 100644
--- a/kas/opt/ebg-secure-boot-snakeoil.yml
+++ b/kas/opt/ebg-secure-boot-snakeoil.yml
@@ -19,6 +19,7 @@ local_conf_header:
     IMAGE_CLASSES += "verity"
     IMAGE_FSTYPES = "wic"
     IMAGE_TYPEDEP:wic += "verity"
+    SWU_ROOTFS_TYPE = "verity"
     WKS_FILE = "${MACHINE}-efibootguard-secureboot.wks.in"
     INITRAMFS_INSTALL:append = " initramfs-verity-hook"
     # abrootfs cannot be installed together with verity
diff --git a/kas/opt/swupdate.yml b/kas/opt/swupdate.yml
index 80cd86e..236b3c4 100644
--- a/kas/opt/swupdate.yml
+++ b/kas/opt/swupdate.yml
@@ -19,6 +19,7 @@ local_conf_header:
     CIP_IMAGE_OPTIONS:append = " swupdate.inc"
 
   wic-swu: |
+    IMAGE_TYPEDEP:wic += "squashfs"
     IMAGE_FSTYPES += "swu"
     WKS_FILE ?= "${MACHINE}-${SWUPDATE_BOOTLOADER}.wks.in"
     INITRAMFS_INSTALL:append = " initramfs-squashfs-hook"
-- 
2.34.1


