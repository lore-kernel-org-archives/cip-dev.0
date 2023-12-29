Return-Path: <quirin.gylstorff@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78439C46CD3
	for <webhook@archiver.kernel.org>; Fri, 29 Dec 2023 12:31:26 +0000 (UTC)
Received: from mta-65-226.siemens.flowmailer.net (mta-65-226.siemens.flowmailer.net [185.136.65.226])
 by mx.groups.io with SMTP id smtpd.web10.145902.1703853079325226472
 for <cip-dev@lists.cip-project.org>;
 Fri, 29 Dec 2023 04:31:19 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=Quirin.Gylstorff@siemens.com header.s=fm1 header.b=hXWg09BK;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.65.226, mailfrom: fm-51332-20231229123116abb5ee574515380dc0-fetfwh@rts-flowmailer.siemens.com)
Received: by mta-65-226.siemens.flowmailer.net with ESMTPSA id 20231229123116abb5ee574515380dc0
        for <cip-dev@lists.cip-project.org>;
        Fri, 29 Dec 2023 13:31:17 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=Quirin.Gylstorff@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:References:In-Reply-To;
 bh=5Ck8bLWRwsiXEYgeXqX6i/eKzbq5fQTsHfuVwGCwgyY=;
 b=hXWg09BKrpe8QncaSB9ld7oPpyV5Csz/u8UtOm/K4PIy82mVuy+Sj2TRHSJSLgThZ/34aL
 OOkAt8bjhZKr3kSz3mbMzqBs+LwlA6c57cR2zrsIIebulR5AbvywAgu2C+Yl6b6Ok5dU15s9
 N4Fcpn2ubNQWWooEUA9MK9TMssaXA=;
From: Quirin Gylstorff <Quirin.Gylstorff@siemens.com>
To: felix.moessbauer@siemens.com,
	jan.kiszka@siemens.com,
	cip-dev@lists.cip-project.org
Subject: [cip-dev][isar-cip-core][RFC v3 5/5] images/swupdate.inc: Add variables to generate the sw-description
Date: Fri, 29 Dec 2023 13:30:43 +0100
Message-ID: <20231229123111.400555-6-Quirin.Gylstorff@siemens.com>
In-Reply-To: <20231229123111.400555-1-Quirin.Gylstorff@siemens.com>
References: <20231229123111.400555-1-Quirin.Gylstorff@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-51332:519-21489:flowmailer
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 29 Dec 2023 12:31:26 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/14221

From: Quirin Gylstorff <quirin.gylstorff@siemens.com>

This done for all distributions except Debian buster.

Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
---
 recipes-core/images/swupdate.inc | 27 +++++++++++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/recipes-core/images/swupdate.inc b/recipes-core/images/swupdate.inc
index 4983f7c..388faad 100644
--- a/recipes-core/images/swupdate.inc
+++ b/recipes-core/images/swupdate.inc
@@ -11,6 +11,33 @@
 
 inherit image_uuid
 inherit read-only-rootfs
+inherit ${@'' if d.getVar('BASE_DISTRO_CODENAME') == 'buster' else 'sw-description-generator'}
+
+SWU_IMAGES += "rootfs"
+SWU_IMAGE_rootfs[filename] = "${SWU_ROOTFS_PARTITION_NAME}"
+SWU_IMAGE_rootfs[device] = "C:BOOT0:linux.efi->${ABROOTFS_PART_UUID_A},C:BOOT1:linux.efi->${ABROOTFS_PART_UUID_B}"
+SWU_IMAGE_rootfs[type] = "roundrobin"
+SWU_IMAGE_rootfs[compressed] = "zlib"
+SWU_IMAGE_rootfs[properties] += "subtype:image"
+SWU_IMAGE_rootfs[properties] += "configfilecheck:/etc/os-release@not_match@IMAGE_UUID=${TARGET_IMAGE_UUID}"
+
+SWU_FILES += "kernel"
+SWU_FILE_kernel[filename] = "linux.efi"
+SWU_FILE_kernel[path] = "linux.efi"
+SWU_FILE_kernel[type] = "roundrobin"
+SWU_FILE_kernel[device] = "C:BOOT0:linux.efi->BOOT0,C:BOOT1:linux.efi->BOOT1"
+SWU_FILE_kernel[filesystem] = "vfat"
+SWU_FILE_kernel[properties] = "subtype:kernel"
+
+EFI_BOOTLOADER_NAME = "${@efi_bootloader_name(d)}"
+SWU_ADDITIONAL_FILES += "${@d.getVar('EFI_BOOTLOADER_NAME') if bb.utils.to_boolean(d.getVar('SWU_EBG_UPDATE')) else ''}"
+
+SWU_FILES += "${@'ebg' if bb.utils.to_boolean(d.getVar('SWU_EBG_UPDATE')) else ''}"
+SWU_FILE_ebg[filename] = "${EFI_BOOTLOADER_NAME}"
+SWU_FILE_ebg[path] = "EFI/BOOT/${EFI_BOOTLOADER_NAME}"
+SWU_FILE_ebg[device] = "${SWU_EFI_BOOT_DEVICE}"
+SWU_FILE_ebg[filesystem] = "vfat"
+SWU_FILE_kernel[properties] = "atomic-install:true"
 
 SWU_SIGNED ?= "1"
 
-- 
2.43.0


