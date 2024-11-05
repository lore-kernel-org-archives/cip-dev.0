Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F41BDD31773
	for <webhook@archiver.kernel.org>; Tue,  5 Nov 2024 17:54:43 +0000 (UTC)
Received: from mta-64-227.siemens.flowmailer.net (mta-64-227.siemens.flowmailer.net [185.136.64.227])
 by mx.groups.io with SMTP id smtpd.web10.26675.1730829277268231213
 for <cip-dev@lists.cip-project.org>;
 Tue, 05 Nov 2024 09:54:38 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=jan.kiszka@siemens.com header.s=fm1 header.b=DKG+fhxo;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.64.227, mailfrom: fm-294854-202411051754342ca6328c4683984d56-_vfgr7@rts-flowmailer.siemens.com)
Received: by mta-64-227.siemens.flowmailer.net with ESMTPSA id 202411051754342ca6328c4683984d56
        for <cip-dev@lists.cip-project.org>;
        Tue, 05 Nov 2024 18:54:34 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=jan.kiszka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:References:In-Reply-To;
 bh=C/qE2qA5tkrq901SoP3YsbCp3k88TsrG0Wdw9UCMFig=;
 b=DKG+fhxo0weaGKygkHcJvI8lnWZ2MQG4JXECMsc7ccVStsXeyH1sq3BU8dFlWfoYvXnME2
 EODf5LIl4JNWY9Pm3eh/gAGY5G7z8TbANErzmvX3apTOT6xkhAo8/PLduANNTSAULvwVN4Kp
 asaX3DXGQ1n2/mWCHoFECEZ/Fb7tQR/xJDrBKOedHA8cHqfEb/utYMr+ELDRUkCM/Mns5WXb
 YKGrpU/afy9Rc/X2eDE5hM4FSkgfUCbg2gABNYxrNaZj0q/3F7p6YiDV4TekFmCngW/z5oUu
 hCRwpkpwQPa1S4lHznWPVVK3f9xj9mFVdN8hNRFgi1krb/fHJ/K3LWCA==;
From: Jan Kiszka <jan.kiszka@siemens.com>
To: cip-dev@lists.cip-project.org
Subject: [isar-cip-core][PATCH v2 4/6] Introduce class for generating EROFS images
Date: Tue,  5 Nov 2024 18:54:31 +0100
Message-ID: <f7245cd2660bbc6e34120bb11ef0e9cdea7b2376.1730829273.git.jan.kiszka@siemens.com>
In-Reply-To: <cover.1730829273.git.jan.kiszka@siemens.com>
References: <cover.1730829273.git.jan.kiszka@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-294854:519-21489:flowmailer
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 05 Nov 2024 17:54:43 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/17181

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


