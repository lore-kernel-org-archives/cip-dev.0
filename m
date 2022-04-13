Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E551CC352A7
	for <webhook@archiver.kernel.org>; Wed, 13 Apr 2022 15:48:06 +0000 (UTC)
Received: from mta-65-227.siemens.flowmailer.net
 (mta-65-227.siemens.flowmailer.net [185.136.65.227])
 by mx.groups.io with SMTP id smtpd.web10.3583.1649834202622474908
 for <cip-dev@lists.cip-project.org>;
 Wed, 13 Apr 2022 00:16:43 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=jan.kiszka@siemens.com header.s=fm1 header.b=SwCQopuJ;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.65.227,
 mailfrom: fm-294854-20220413071640eb7e9d79a924ce2997-ub0tbx@rts-flowmailer.siemens.com)
Received: by mta-65-227.siemens.flowmailer.net with ESMTPSA id
 20220413071640eb7e9d79a924ce2997
        for <cip-dev@lists.cip-project.org>;
        Wed, 13 Apr 2022 09:16:40 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=jan.kiszka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=qPza/YyG9drxcGvvvkI+UYR1OFWBuJWb5rJkL/dBeCI=;
 b=SwCQopuJEZzMSwtqY7e+eodGRdijwxJtImhDSQavFvrUPlM+fiyVyjqxJ0QF3eIOOzAClT
 VM3ABZ3QWZ/D4iuRI1BWzh6OHZw2Or/AzSb9U2ql48nBGyRVkrQ5yroW6fjsiJsI55oN8w72
 shquwGQYqXkQs04K4ftx5wew6eLek=;
From: Jan Kiszka <jan.kiszka@siemens.com>
To: cip-dev@lists.cip-project.org
Cc: Quirin Gylstorff <quirin.gylstorff@siemens.com>,
	Christian Storm <christian.storm@siemens.com>
Subject: [isar-cip-core][PATCH 10/19] Unify configuration of secure vs.
 non-secure SWUpdate
Date: Wed, 13 Apr 2022 09:16:27 +0200
Message-Id: 
 <a3c984c035728ec7b3bcce3dcdd51ef272663685.1649834193.git.jan.kiszka@siemens.com>
In-Reply-To: <cover.1649834193.git.jan.kiszka@siemens.com>
References: <cover.1649834193.git.jan.kiszka@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-294854:519-21489:flowmailer
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 13 Apr 2022 15:48:06 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/8061

From: Jan Kiszka <jan.kiszka@siemens.com>

The sw-descriptions are practically identical, the roundrobin-handler
ini files are absolutely the same. So drop them and use unified configs.
That allows to drop kas/opt/ebg-secure-boot-base.yml as well.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 kas/opt/ebg-secure-boot-base.yml              | 20 -----------
 kas/opt/ebg-secure-boot-snakeoil.yml          |  2 +-
 .../files/secure-boot/sw-description.tmpl     | 35 -------------------
 recipes-core/images/secureboot.inc            | 21 -----------
 .../swupdate.handler.efibootguard.ini         | 16 ---------
 5 files changed, 1 insertion(+), 93 deletions(-)
 delete mode 100644 kas/opt/ebg-secure-boot-base.yml
 delete mode 100644 recipes-core/images/files/secure-boot/sw-description.tmpl
 delete mode 100644 recipes-core/images/secureboot.inc
 delete mode 100644 recipes-core/swupdate-handler-roundrobin/files/secureboot/swupdate.handler.efibootguard.ini

diff --git a/kas/opt/ebg-secure-boot-base.yml b/kas/opt/ebg-secure-boot-base.yml
deleted file mode 100644
index 299b663..0000000
--- a/kas/opt/ebg-secure-boot-base.yml
+++ /dev/null
@@ -1,20 +0,0 @@
-#
-# CIP Core, generic profile
-#
-# Copyright (c) Siemens AG, 2020
-#
-# Authors:
-#  Quirin Gylstorff <quirin.gylstorff@siemens.com>
-#
-# SPDX-License-Identifier: MIT
-#
-
-header:
-  version: 10
-  includes:
-   - kas/opt/efibootguard.yml
-
-local_conf_header:
-  secure_swu: |
-    SWU_DESCRIPTION = "secureboot"
-    SWUPDATE_ROUND_ROBIN_HANDLER_CONFIG = "secureboot/swupdate.handler.${SWUPDATE_BOOTLOADER}.ini"
diff --git a/kas/opt/ebg-secure-boot-snakeoil.yml b/kas/opt/ebg-secure-boot-snakeoil.yml
index 10414fb..28b3545 100644
--- a/kas/opt/ebg-secure-boot-snakeoil.yml
+++ b/kas/opt/ebg-secure-boot-snakeoil.yml
@@ -12,7 +12,7 @@
 header:
   version: 10
   includes:
-   - kas/opt/ebg-secure-boot-base.yml
+   - kas/opt/efibootguard.yml
 
 local_conf_header:
   image-options: |
diff --git a/recipes-core/images/files/secure-boot/sw-description.tmpl b/recipes-core/images/files/secure-boot/sw-description.tmpl
deleted file mode 100644
index 7dc070a..0000000
--- a/recipes-core/images/files/secure-boot/sw-description.tmpl
+++ /dev/null
@@ -1,35 +0,0 @@
-#
-# CIP Core, generic profile
-#
-# Copyright (c) Siemens AG, 2020
-#
-# Authors:
-#  Quirin Gylstorff <quirin.gylstorff@siemens.com>
-#
-# SPDX-License-Identifier: MIT
-#
-software =
-{
-    version = "0.2";
-    name = "secure boot update"
-    images: ({
-            filename = "${ROOTFS_PARTITION_NAME}";
-            device = "sda4,sda5";
-            type = "roundrobin";
-            compressed = "zlib";
-            filesystem = "ext4";
-            properties: {
-                        subtype = "image";
-            };
-    });
-    files: ({
-            filename = "linux.efi";
-            path = "linux.efi";
-            type = "roundrobin";
-            device = "sda4->BOOT0,sda5->BOOT1";
-            filesystem = "vfat";
-            properties: {
-                        subtype = "kernel";
-            };
-    })
-}
diff --git a/recipes-core/images/secureboot.inc b/recipes-core/images/secureboot.inc
deleted file mode 100644
index 6182080..0000000
--- a/recipes-core/images/secureboot.inc
+++ /dev/null
@@ -1,21 +0,0 @@
-#
-# CIP Core, generic profile
-#
-# Copyright (c) Siemens AG, 2020
-#
-# Authors:
-#  Quirin Gylstorff <quirin.gylstorff@siemens.com>
-#
-# SPDX-License-Identifier: MIT
-#
-
-FILESEXTRAPATHS_prepend := "${THISDIR}/files/secure-boot:"
-
-ROOTFS_PARTITION_NAME = "${IMAGE_FULLNAME}.wic.img.p4.gz"
-
-SRC_URI += "file://sw-description.tmpl"
-TEMPLATE_FILES += "sw-description.tmpl"
-
-TEMPLATE_VARS += "ROOTFS_PARTITION_NAME"
-
-SWU_ADDITIONAL_FILES += "linux.efi ${ROOTFS_PARTITION_NAME}"
diff --git a/recipes-core/swupdate-handler-roundrobin/files/secureboot/swupdate.handler.efibootguard.ini b/recipes-core/swupdate-handler-roundrobin/files/secureboot/swupdate.handler.efibootguard.ini
deleted file mode 100644
index b5e8070..0000000
--- a/recipes-core/swupdate-handler-roundrobin/files/secureboot/swupdate.handler.efibootguard.ini
+++ /dev/null
@@ -1,16 +0,0 @@
-[image]
-chainhandler=raw
-
-[image.selector]
-method=getroot_rr
-key=root
-
-[kernel]
-chainhandler=rawfile
-
-[kernel.selector]
-method=getroot_rrmap
-key=root
-
-[kernel.bootenv]
-kernelfile=C:BOOT${rrindex}:linux.efi
-- 
2.34.1


