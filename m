Return-Path: <quirin.gylstorff@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FED7CFD62A
	for <webhook@archiver.kernel.org>; Wed,  7 Jan 2026 13:27:25 +0000 (UTC)
Received: from mta-64-226.siemens.flowmailer.net (mta-64-226.siemens.flowmailer.net [185.136.64.226])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.5704.1767792443621110828
 for <cip-dev@lists.cip-project.org>;
 Wed, 07 Jan 2026 05:27:25 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=Quirin.Gylstorff@siemens.com header.s=fm1 header.b=MTiWNy5W;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.64.226, mailfrom: fm-51332-20260107132716dad4710d23000207ac-21nt48@rts-flowmailer.siemens.com)
Received: by mta-64-226.siemens.flowmailer.net with ESMTPSA id 20260107132716dad4710d23000207ac
        for <cip-dev@lists.cip-project.org>;
        Wed, 07 Jan 2026 14:27:21 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=Quirin.Gylstorff@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:References:In-Reply-To;
 bh=rqAkDcgmVpeFbkUQcGO7F4wbURFsVhnKE+z09Um1Qp8=;
 b=MTiWNy5WiE6IaIUwwUPahfDy0E0Ub6j27LxvEf72O/FH14ZPhaLZURZ1qd6R6UdYjYenqb
 rD+TCYPmEkebYv5fPv3y4C6kQEBPLXvM5rwJ21Aps7TnIBS21wPsxsDhZUIcGHsplzagNCkr
 2X+yVHoGRfdG61LiUjhMDO+e5Im9Zi43d7pgcdDqYlzfG7xHqrSabAP7nzos6pTZ7IRqmKYa
 3hnBPfKGKBNSUR4vdF5DdPIQZOf4wqHcLuYvDXl+ZGWjjiBqgkjd2raQAguG67oypzA5wl13
 B9fNHMbFop6rnZXtQB1hSD98Zl2CBMzND8vov5QLozmwDmx7RW3cT8hg==;
From: Quirin Gylstorff <Quirin.Gylstorff@siemens.com>
To: jan.kiszka@siemens.com,
	clara.kowalsky@siemens.com,
	cip-dev@lists.cip-project.org,
	benedikt.niedermayr@siemens.com
Subject: [cip-dev][isar-cip-core][PATCH v2 1/7] kas: move initramfs-tool specific recipes to cip-core-initramfs
Date: Wed,  7 Jan 2026 14:26:24 +0100
Message-ID: <20260107132707.733180-2-Quirin.Gylstorff@siemens.com>
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
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/21409

From: Quirin Gylstorff <quirin.gylstorff@siemens.com>

This avoids errors during the build of a dracut based initrd

Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
---
 kas/opt/ebg-secure-boot-snakeoil.yml                       | 3 ---
 kas/opt/ebg-swu.yml                                        | 2 --
 kas/opt/swupdate.yml                                       | 1 -
 recipes-initramfs/cip-core-initramfs/cip-core-initramfs.bb | 5 +++++
 4 files changed, 5 insertions(+), 6 deletions(-)

diff --git a/kas/opt/ebg-secure-boot-snakeoil.yml b/kas/opt/ebg-secure-boot-snakeoil.yml
index 7d8ce65..776e2a3 100644
--- a/kas/opt/ebg-secure-boot-snakeoil.yml
+++ b/kas/opt/ebg-secure-boot-snakeoil.yml
@@ -20,9 +20,6 @@ local_conf_header:
     IMAGE_TYPEDEP:wic += "verity"
     SWU_ROOTFS_TYPE = "verity"
     WKS_FILE = "${MACHINE}-efibootguard-secureboot.wks.in"
-    INITRAMFS_INSTALL:append = " initramfs-verity-hook"
-    # abrootfs cannot be installed together with verity
-    INITRAMFS_INSTALL:remove = "initramfs-abrootfs-hook"
 
   secure-boot: |
     IMAGER_BUILD_DEPS += "ebg-secure-boot-signer"
diff --git a/kas/opt/ebg-swu.yml b/kas/opt/ebg-swu.yml
index ce64670..9b8a0e8 100644
--- a/kas/opt/ebg-swu.yml
+++ b/kas/opt/ebg-swu.yml
@@ -21,8 +21,6 @@ local_conf_header:
     IMAGE_INSTALL:remove = "u-boot-script"
   ebg_swu_image_options: |
     CIP_IMAGE_OPTIONS:append = " recipes-core/images/efibootguard.inc"
-  initramfs: |
-    INITRAMFS_INSTALL:append = " initramfs-abrootfs-hook"
   firmware-binaries: |
     # Add ovmf binaries for qemu
     CIP_IMAGE_OPTIONS:append:qemu-amd64 = " recipes-core/images/deploy-ovmf.inc"
diff --git a/kas/opt/swupdate.yml b/kas/opt/swupdate.yml
index 38dc390..f1f3f77 100644
--- a/kas/opt/swupdate.yml
+++ b/kas/opt/swupdate.yml
@@ -26,7 +26,6 @@ local_conf_header:
     # input is already compressed
     SWU_COMPRESSION_TYPE = ""
     WKS_FILE ?= "${MACHINE}-${SWUPDATE_BOOTLOADER}.wks.in"
-    INITRAMFS_INSTALL:append = " initramfs-${RO_ROOTFS_TYPE}-hook"
     ABROOTFS_PART_UUID_A ?= "fedcba98-7654-3210-cafe-5e0710000001"
     ABROOTFS_PART_UUID_B ?= "fedcba98-7654-3210-cafe-5e0710000002"
     PREFERRED_PROVIDER_swupdate-certificates-key ??= "swupdate-certificates-key-snakeoil"
diff --git a/recipes-initramfs/cip-core-initramfs/cip-core-initramfs.bb b/recipes-initramfs/cip-core-initramfs/cip-core-initramfs.bb
index c54a489..9d53394 100644
--- a/recipes-initramfs/cip-core-initramfs/cip-core-initramfs.bb
+++ b/recipes-initramfs/cip-core-initramfs/cip-core-initramfs.bb
@@ -18,3 +18,8 @@ INITRAMFS_INSTALL += " \
 INITRAMFS_INSTALL:append:encrypt-partitions = " initramfs-crypt-hook"
 INITRAMFS_INSTALL:append:factory-reset = " initramfs-factory-reset-hook"
 INITRAMFS_INSTALL:append:ftpm-stmm = " initramfs-tee-ftpm-hook"
+INITRAMFS_INSTALL:append:swupdate = " initramfs-abrootfs-hook"
+INITRAMFS_INSTALL:append:swupdate = " initramfs-${RO_ROOTFS_TYPE}-hook"
+INITRAMFS_INSTALL:append:secureboot = " initramfs-verity-hook"
+# abrootfs cannot be installed together with verity
+INITRAMFS_INSTALL:remove:secureboot = "initramfs-abrootfs-hook"
-- 
2.51.2


