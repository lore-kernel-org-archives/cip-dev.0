Return-Path: <ubely@ilbers.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 684C1C7EE25
	for <webhook@archiver.kernel.org>; Wed,  7 Jun 2023 12:18:57 +0000 (UTC)
Received: from shymkent.ilbers.de (shymkent.ilbers.de [85.214.156.166])
 by mx.groups.io with SMTP id smtpd.web10.6973.1686140331808965174
 for <cip-dev@lists.cip-project.org>;
 Wed, 07 Jun 2023 05:18:52 -0700
Authentication-Results: mx.groups.io;
 dkim=missing; spf=pass (domain: ilbers.de, ip: 85.214.156.166, mailfrom: ubely@ilbers.de)
Received: from baighyz.m.ilbers.de (host-80-81-17-52.static.customer.m-online.net [80.81.17.52])
	(authenticated bits=0)
	by shymkent.ilbers.de (8.15.2/8.15.2/Debian-8+deb9u1) with ESMTPSA id 357CImXR004304
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 7 Jun 2023 14:18:49 +0200
From: Uladzimir Bely <ubely@ilbers.de>
To: cip-dev@lists.cip-project.org, ubely@ilbers.de
Subject: [isar-cip-core][PATCH v2] IMAGE_TYPEDEP:swu: Don't depend on wic
Date: Wed,  7 Jun 2023 14:18:48 +0200
Message-Id: <20230607121848.31306-1-ubely@ilbers.de>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 07 Jun 2023 12:18:57 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/11906

Settings IMAGE_FSTYPE to something like "ext4 swu" or "wic.xz swu"
causes uncompressed '.wic' image left non-removed after the build
finished. This is caused by indirect dependency on "wic" in swupdate
bbclass that can't be overriden by the user in local.conf.

This patch removes this depencency. If the user want to use some wic
partitions to be packed into .swu bundle, they could simply add
directly append "wic" to IMAGE_FSTYPE and IMAGE_TYPEDEP:swu.

Similar thing is done for efibootguard-enabled images that require
task 'do_image_wic' (that generates "linux.efi" in deploy directory)
to be executed before the task 'do_image_swu' that uses this file.

Signed-off-by: Uladzimir Bely <ubely@ilbers.de>
---
 classes/swupdate.bbclass             | 2 +-
 recipes-core/images/efibootguard.inc | 1 +
 2 files changed, 2 insertions(+), 1 deletion(-)

Changes since v1:
- restored swu dependency from wic for efibootguard-enabled targets

diff --git a/classes/swupdate.bbclass b/classes/swupdate.bbclass
index 6934c0f..ac59c00 100644
--- a/classes/swupdate.bbclass
+++ b/classes/swupdate.bbclass
@@ -31,7 +31,7 @@ SWU_SIGNATURE_TYPE ?= "rsa"
 
 SWU_BUILDCHROOT_IMAGE_FILE ?= "${PP_DEPLOY}/${@os.path.basename(d.getVar('SWU_IMAGE_FILE'))}"
 
-IMAGE_TYPEDEP:swu = "wic ${SWU_ROOTFS_TYPE}${@get_swu_compression_type(d)}"
+IMAGE_TYPEDEP:swu = "${SWU_ROOTFS_TYPE}${@get_swu_compression_type(d)}"
 IMAGER_INSTALL:swu += "cpio ${@'openssl' if bb.utils.to_boolean(d.getVar('SWU_SIGNED')) else ''}"
 
 IMAGE_SRC_URI:swu = "file://${SWU_DESCRIPTION_FILE}.tmpl"
diff --git a/recipes-core/images/efibootguard.inc b/recipes-core/images/efibootguard.inc
index 604c9d7..e6824eb 100644
--- a/recipes-core/images/efibootguard.inc
+++ b/recipes-core/images/efibootguard.inc
@@ -14,3 +14,4 @@ WIC_IMAGER_INSTALL:append = " efibootguard:${DISTRO_ARCH}"
 WDOG_TIMEOUT ?= "60"
 WICVARS += "WDOG_TIMEOUT KERNEL_IMAGE INITRD_DEPLOY_FILE DTB_FILES"
 IMAGE_FSTYPES:append = " wic"
+IMAGE_TYPEDEP:swu:append = " wic"
-- 
2.20.1


