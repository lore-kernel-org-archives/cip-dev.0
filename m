Return-Path: <quirin.gylstorff@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 675DFC433FE
	for <webhook@archiver.kernel.org>; Fri, 12 Nov 2021 11:50:22 +0000 (UTC)
Received: from goliath.siemens.de (goliath.siemens.de [192.35.17.28])
 by mx.groups.io with SMTP id smtpd.web10.14759.1636717821214977162
 for <cip-dev@lists.cip-project.org>;
 Fri, 12 Nov 2021 03:50:21 -0800
Authentication-Results: mx.groups.io;
 dkim=missing;
 spf=pass (domain: siemens.com, ip: 192.35.17.28, mailfrom: quirin.gylstorff@siemens.com)
Received: from mail2.sbs.de (mail2.sbs.de [192.129.41.66])
	by goliath.siemens.de (8.15.2/8.15.2) with ESMTPS id 1ACBoIbW008769
	(version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <cip-dev@lists.cip-project.org>; Fri, 12 Nov 2021 12:50:18 +0100
Received: from md2dvrtc.fritz.box ([167.87.35.150])
	by mail2.sbs.de (8.15.2/8.15.2) with ESMTP id 1ACBoHAg023845;
	Fri, 12 Nov 2021 12:50:18 +0100
From: "Q. Gylstorff" <Quirin.Gylstorff@siemens.com>
To: cip-dev@lists.cip-project.org, jan.kiszka@siemens.com
Subject: [cip-dev][isar-cip-core][RFC 1/8] Add new class to create a squashfs
 based root file system
Date: Fri, 12 Nov 2021 12:50:09 +0100
Message-Id: <20211112115017.401779-2-Quirin.Gylstorff@siemens.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211112115017.401779-1-Quirin.Gylstorff@siemens.com>
References: <20211112115017.401779-1-Quirin.Gylstorff@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 12 Nov 2021 11:50:22 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/6881

From: Quirin Gylstorff <quirin.gylstorff@siemens.com>

This file system is read only and use a reduced image size.

Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
---
 classes/squashfs-img.bbclass | 42 ++++++++++++++++++++++++++++++++++++
 1 file changed, 42 insertions(+)
 create mode 100644 classes/squashfs-img.bbclass

diff --git a/classes/squashfs-img.bbclass b/classes/squashfs-img.bbclass
new file mode 100644
index 0000000..f827e8c
--- /dev/null
+++ b/classes/squashfs-img.bbclass
@@ -0,0 +1,42 @@
+#
+# CIP Core, generic profile
+#
+# Copyright (c) Siemens AG, 2021
+#
+# Authors:
+#  Quirin Gylstorff <quirin.gylstorff@siemens.com>
+#
+# SPDX-License-Identifier: MIT
+#
+
+SQUASHFS_IMAGE_FILE = "${IMAGE_FULLNAME}.squashfs.img"
+
+IMAGER_INSTALL += "squashfs-tools"
+
+SQUASHFS_EXCLUDE_DIRS ?= ""
+SQUASHFS_CONTENT ?= "${PP_ROOTFS}"
+SQUASHFS_CREATION_ARGS ?= " "
+# Generate squashfs filesystem image
+python __anonymous() {
+    exclude_directories = (d.getVar('SQUASHFS_EXCLUDE_DIRS') or "").split()
+    if len(exclude_directories) == 0:
+        return
+    args=d.getVar('SQUASHFS_CREATION_ARGS')
+    args+=" -wildcards"
+    # use wildcard to exclude only content of the the directory
+    # this allows to use the directory as a mount point
+    for dir in exclude_directories:
+        args+=" -e {dir}/* ".format(dir=dir)
+    d.setVar('SQUASHFS_CREATION_ARGS', args)
+}
+
+do_squashfs_image() {
+    rm -f '${DEPLOY_DIR_IMAGE}/${SQUASHFS_IMAGE_FILE}'
+
+    image_do_mounts
+
+    sudo chroot "${BUILDCHROOT_DIR}" /bin/mksquashfs  \
+        "${SQUASHFS_CONTENT}" "${PP_DEPLOY}/${SQUASHFS_IMAGE_FILE}" \
+        ${SQUASHFS_CREATION_ARGS}
+}
+addtask do_squashfs_image before do_image after do_image_tools do_excl_directories
-- 
2.30.2


