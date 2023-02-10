Return-Path: <ncaidin@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65702C05027
	for <webhook@archiver.kernel.org>; Fri, 10 Feb 2023 12:07:45 +0000 (UTC)
Received: from mta-65-226.siemens.flowmailer.net (mta-65-226.siemens.flowmailer.net [185.136.65.226])
 by mx.groups.io with SMTP id smtpd.web10.6212.1676001963633088123
 for <cip-dev@lists.cip-project.org>;
 Thu, 09 Feb 2023 20:06:04 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=felix.moessbauer@siemens.com header.s=fm1 header.b=NwTwKRpL;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.65.226, mailfrom: fm-72506-202302100406012eb9b6d0bf5eb81d69-0wzxd6@rts-flowmailer.siemens.com)
Received: by mta-65-226.siemens.flowmailer.net with ESMTPSA id 202302100406012eb9b6d0bf5eb81d69
        for <cip-dev@lists.cip-project.org>;
        Fri, 10 Feb 2023 05:06:01 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=felix.moessbauer@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=GuQswzVeKMR5wOgbRT9+zPj//Qu91gbW/10jGQEYTXg=;
 b=NwTwKRpL5JQewycofiGZQdTt9IxKCi2oTj0uoy2dQ0h0qalQrRl7Zp739rZgVA2Vp/aN0i
 Ah0o+/JZ0wHYnld2bJf7A1qh4tNW70Wqwby+uiAgIJOLKVBS9qXCAv0FK1BX1Dd7wjvM8GUA
 Wfew72VCWrMBu6DYlIRxfyFKB1cV0=;
From: Felix Moessbauer <felix.moessbauer@siemens.com>
To: cip-dev@lists.cip-project.org
Cc: adriaan.schmidt@siemens.com,
	jan.kiszka@siemens.com,
	quirin.gylstorff@siemens.com,
	Felix Moessbauer <felix.moessbauer@siemens.com>
Subject: [isar-cip-core][PATCH 3/5] swu: directly image from squashfs rootfs
Date: Fri, 10 Feb 2023 04:05:30 +0000
Message-Id: <20230210040532.239406-4-felix.moessbauer@siemens.com>
In-Reply-To: <20230210040532.239406-1-felix.moessbauer@siemens.com>
References: <20230210040532.239406-1-felix.moessbauer@siemens.com>
MIME-Version: 1.0
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-72506:519-21489:flowmailer
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 10 Feb 2023 12:07:45 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/10653

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
 classes/swupdate.bbclass             | 7 +++++--
 kas/opt/ebg-secure-boot-snakeoil.yml | 1 +
 2 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/classes/swupdate.bbclass b/classes/swupdate.bbclass
index 2e32729..217be94 100644
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
@@ -19,7 +22,7 @@ SWU_SIGNATURE_TYPE ?= "rsa"
 
 BUILDCHROOT_IMAGE_FILE ?= "${PP_DEPLOY}/${@os.path.basename(d.getVar('SWU_IMAGE_FILE'))}"
 
-IMAGE_TYPEDEP:wic += "squashfs"
+IMAGE_TYPEDEP:wic += "${SWU_ROOTFS_TYPE}"
 IMAGE_TYPEDEP:swu = "wic"
 IMAGER_INSTALL:swu += "cpio ${@'openssl' if bb.utils.to_boolean(d.getVar('SWU_SIGNED')) else ''}"
 
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
-- 
2.34.1


