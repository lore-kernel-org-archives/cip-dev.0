Return-Path: <ubely@ilbers.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94E39C77B75
	for <webhook@archiver.kernel.org>; Tue, 16 May 2023 08:50:31 +0000 (UTC)
Received: from shymkent.ilbers.de (shymkent.ilbers.de [85.214.156.166])
 by mx.groups.io with SMTP id smtpd.web10.17253.1684227023106422435
 for <cip-dev@lists.cip-project.org>;
 Tue, 16 May 2023 01:50:23 -0700
Authentication-Results: mx.groups.io;
 dkim=missing; spf=pass (domain: ilbers.de, ip: 85.214.156.166, mailfrom: ubely@ilbers.de)
Received: from baighyz.m.ilbers.de (host-80-81-17-52.static.customer.m-online.net [80.81.17.52])
	(authenticated bits=0)
	by shymkent.ilbers.de (8.15.2/8.15.2/Debian-8+deb9u1) with ESMTPSA id 34G8oJkI005937
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 16 May 2023 10:50:19 +0200
From: Uladzimir Bely <ubely@ilbers.de>
To: cip-dev@lists.cip-project.org, ubely@ilbers.de
Subject: [isar-cip-core][PATCH] IMAGE_TYPEDEP:swu: Don't depend on wic
Date: Tue, 16 May 2023 10:50:18 +0200
Message-Id: <20230516085018.26436-1-ubely@ilbers.de>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 16 May 2023 08:50:31 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/11465

Settings IMAGE_FSTYPE to something like "ext4 swu" or "wic.xz swu"
causes uncompressed '.wic' image left non-removed after the build
finished. This is caused by indirect dependency on "wic" in swupdate
bbclass that can't be overriden by the user in local.conf.

This patch removes this depencency. If the user want to use some wic
partitions to be packed into .swu bundle, they could simply add
directly add "wic" or "wic.xz" to IMAGE_FSTYPE.

Signed-off-by: Uladzimir Bely <ubely@ilbers.de>
---
 classes/swupdate.bbclass | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/classes/swupdate.bbclass b/classes/swupdate.bbclass
index 9a4d509..6f034c1 100644
--- a/classes/swupdate.bbclass
+++ b/classes/swupdate.bbclass
@@ -31,7 +31,7 @@ SWU_SIGNATURE_TYPE ?= "rsa"
 
 SWU_BUILDCHROOT_IMAGE_FILE ?= "${PP_DEPLOY}/${@os.path.basename(d.getVar('SWU_IMAGE_FILE'))}"
 
-IMAGE_TYPEDEP:swu = "wic ${SWU_ROOTFS_TYPE}${@get_swu_compression_type(d)}"
+IMAGE_TYPEDEP:swu = "${SWU_ROOTFS_TYPE}${@get_swu_compression_type(d)}"
 IMAGER_INSTALL:swu += "cpio ${@'openssl' if bb.utils.to_boolean(d.getVar('SWU_SIGNED')) else ''}"
 
 IMAGE_SRC_URI:swu = "file://${SWU_DESCRIPTION_FILE}.tmpl"
-- 
2.20.1


