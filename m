Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B837D5CC9F
	for <webhook@archiver.kernel.org>; Wed, 30 Oct 2024 11:52:02 +0000 (UTC)
Received: from mta-64-227.siemens.flowmailer.net (mta-64-227.siemens.flowmailer.net [185.136.64.227])
 by mx.groups.io with SMTP id smtpd.web10.13029.1730289112154326742
 for <cip-dev@lists.cip-project.org>;
 Wed, 30 Oct 2024 04:51:53 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=jan.kiszka@siemens.com header.s=fm1 header.b=Rm25rWqw;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.64.227, mailfrom: fm-294854-2024103011514882bdc9aa06945078ff-mqbckq@rts-flowmailer.siemens.com)
Received: by mta-64-227.siemens.flowmailer.net with ESMTPSA id 2024103011514882bdc9aa06945078ff
        for <cip-dev@lists.cip-project.org>;
        Wed, 30 Oct 2024 12:51:49 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=jan.kiszka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:References:In-Reply-To;
 bh=C/qE2qA5tkrq901SoP3YsbCp3k88TsrG0Wdw9UCMFig=;
 b=Rm25rWqwjXMzr2eDwYgNwlMazJgjFpy+EjH3Xrty99AVxKKfSNfIYV/idWbyHJbcaeZbzv
 fxp1RS/nOVirxxQ6B/4RMtwC9QUWS1bkzvy6KJZmeseUZlxT03R3NAedMRmFAHBCK1Nijy/B
 BlMi2J6pTu7ktoRUBCLI9lO4qz/HUPqiu2Vg3rktOiR8rxJaqGH5suLM6oZSsPDjPKYqwuGK
 9lipbRkaVeQhtqoNU7Cb11iwePwIZde454NiBwntLoyn+ZWedSn6pMdgqmjERZRgWk2Z87eY
 +2kfRpGc3zT8NXlAgLUn6SLBQi1lj6LN7A7Jz+Lip7ALzNA5OSZjVXyg==;
From: Jan Kiszka <jan.kiszka@siemens.com>
To: cip-dev@lists.cip-project.org
Subject: [isar-cip-core][PATCH 4/6] Introduce class for generating EROFS images
Date: Wed, 30 Oct 2024 12:51:45 +0100
Message-ID: <9e610c58e64d927b450fc246f5a271268c5c4d03.1730289107.git.jan.kiszka@siemens.com>
In-Reply-To: <cover.1730289107.git.jan.kiszka@siemens.com>
References: <cover.1730289107.git.jan.kiszka@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-294854:519-21489:flowmailer
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 30 Oct 2024 11:52:02 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/17113

From: Jan Kiszka <jan.kiszka@siemens.com>

This is analogous to the squashfs class.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 classes/erofs.bbclass | 34 ++++++++++++++++++++++++++++++++++
 conf/layer.conf       |  2 +-
 2 files changed, 35 insertions(+), 1 deletion(-)
 create mode 100644 classes/erofs.bbclass

diff --git a/classes/erofs.bbclass b/classes/erofs.bbclass
new file mode 100644
index 00000000..95e7be35
--- /dev/null
+++ b/classes/erofs.bbclass
@@ -0,0 +1,34 @@
+#
+# CIP Core, generic profile
+#
+# Copyright (c) Siemens AG, 2024
+#
+# Authors:
+#  Jan Kiszka <jan.kiszka@siemens.com>
+#
+# SPDX-License-Identifier: MIT
+#
+
+IMAGER_INSTALL:erofs += "erofs-utils"
+
+EROFS_EXCLUDE_DIRS ?= ""
+EROFS_CONTENT ?= "${PP_ROOTFS}"
+EROFS_CREATION_ARGS ?= "-z lz4hc,12"
+
+python __anonymous() {
+    exclude_directories = d.getVar('EROFS_EXCLUDE_DIRS').split()
+    if len(exclude_directories) == 0:
+        return
+    # Use regex to exclude only content of the directory.
+    # This allows to use the directory as a mount point.
+    for dir in exclude_directories:
+        args += " --exclude-regex {dir}/.* ".format(dir=dir)
+    d.appendVar('EROFS_CREATION_ARGS', args)
+}
+
+IMAGE_CMD:erofs[depends] = "${PN}:do_transform_template"
+IMAGE_CMD:erofs() {
+    ${SUDO_CHROOT} /bin/mkfs.erofs \
+        '${IMAGE_FILE_CHROOT}' '${EROFS_CONTENT}' \
+        ${EROFS_CREATION_ARGS}
+}
diff --git a/conf/layer.conf b/conf/layer.conf
index c652a61c..316f4a81 100644
--- a/conf/layer.conf
+++ b/conf/layer.conf
@@ -23,5 +23,5 @@ LAYERSERIES_COMPAT_cip-core = "next"
 LAYERDIR_cip-core = "${LAYERDIR}"
 LAYERDIR_cip-core[vardepvalue] = "isar-cip-core"
 
-IMAGE_CLASSES += "squashfs verity swupdate delta-update"
+IMAGE_CLASSES += "squashfs erofs verity swupdate delta-update"
 
-- 
2.43.0


