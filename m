Return-Path: <quirin.gylstorff@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5415C4167B
	for <webhook@archiver.kernel.org>; Tue, 30 Nov 2021 09:31:01 +0000 (UTC)
Received: from thoth.sbs.de (thoth.sbs.de [192.35.17.2])
 by mx.groups.io with SMTP id smtpd.web10.74459.1638264659559575323
 for <cip-dev@lists.cip-project.org>;
 Tue, 30 Nov 2021 01:31:00 -0800
Authentication-Results: mx.groups.io;
 dkim=missing;
 spf=pass (domain: siemens.com, ip: 192.35.17.2, mailfrom: quirin.gylstorff@siemens.com)
Received: from mail1.sbs.de (mail1.sbs.de [192.129.41.35])
	by thoth.sbs.de (8.15.2/8.15.2) with ESMTPS id 1AU9UvEX003918
	(version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <cip-dev@lists.cip-project.org>; Tue, 30 Nov 2021 10:30:57 +0100
Received: from md2dvrtc.fritz.box ([167.87.34.248])
	by mail1.sbs.de (8.15.2/8.15.2) with ESMTP id 1AU9UuEi020034;
	Tue, 30 Nov 2021 10:30:56 +0100
From: "Q. Gylstorff" <Quirin.Gylstorff@siemens.com>
To: cip-dev@lists.cip-project.org, jan.kiszka@siemens.com
Subject: [cip-dev][isar-cip-core][PATCH 1/9] Add new class to create a
 squashfs based root file system
Date: Tue, 30 Nov 2021 10:30:48 +0100
Message-Id: <20211130093056.324717-2-Quirin.Gylstorff@siemens.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211130093056.324717-1-Quirin.Gylstorff@siemens.com>
References: <20211130093056.324717-1-Quirin.Gylstorff@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 30 Nov 2021 09:31:01 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/7031

From: Quirin Gylstorff <quirin.gylstorff@siemens.com>

This file system is read only and use a reduced image size.

Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
---
 classes/squashfs-img.bbclass | 41 ++++++++++++++++++++++++++++++++++++
 1 file changed, 41 insertions(+)
 create mode 100644 classes/squashfs-img.bbclass

diff --git a/classes/squashfs-img.bbclass b/classes/squashfs-img.bbclass
new file mode 100644
index 0000000..0fcfca5
--- /dev/null
+++ b/classes/squashfs-img.bbclass
@@ -0,0 +1,41 @@
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
+    # use wildcard to exclude only content of the the directory
+    # this allows to use the directory as a mount point
+    args = " -wildcards"
+    for dir in exclude_directories:
+        args += " -e {dir}/* ".format(dir=dir)
+    d.appendVar('SQUASHFS_CREATION_ARGS', args)
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


