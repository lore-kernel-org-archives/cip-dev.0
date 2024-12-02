Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 976BED78321
	for <webhook@archiver.kernel.org>; Mon,  2 Dec 2024 14:51:39 +0000 (UTC)
Received: from mta-64-228.siemens.flowmailer.net (mta-64-228.siemens.flowmailer.net [185.136.64.228])
 by mx.groups.io with SMTP id smtpd.web11.175575.1733151095512780478
 for <cip-dev@lists.cip-project.org>;
 Mon, 02 Dec 2024 06:51:35 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=jan.kiszka@siemens.com header.s=fm2 header.b=W+7RC5Yk;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.64.228, mailfrom: fm-294854-20241202145133aad830ff7dd682cd81-guwuk3@rts-flowmailer.siemens.com)
Received: by mta-64-228.siemens.flowmailer.net with ESMTPSA id 20241202145133aad830ff7dd682cd81
        for <cip-dev@lists.cip-project.org>;
        Mon, 02 Dec 2024 15:51:33 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm2;
 d=siemens.com; i=jan.kiszka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=XsrOyvjQb2NRmAXYNXuidWzNHNPAbUngJrl+5w9QU0s=;
 b=W+7RC5YkVcK+Dp48vr7MNOHf8vqsuisgl4bV3j6BjFp0o2R2BxpB+HB1VY9rDOM1xZYHy0
 IFUbI64KvUZEo++E9ujQ7WCyYpWgD5fyBFJkYtNBFYY2wGLFGwdVl54QPnTif7wVlolZ2+Vl
 wnjYSNHv7jdiVZ2PHyC+scRNGBbgBj1R0uz5PZTp+PijqnHbWl4PycbZvaJGat+nL0jYG+eX
 INIlzCBTbjgqgiGPllFO1o6+BAIWJo6Pt/BxdR8k5IbzOp+VysHmtGhGBGZxY4iUo6yGtvfj
 ob9BOqspoY7Qc8xk8km/zyIx4F89TIKvDjBMJ116pZI7U3Uxb97facLw==;
From: Jan Kiszka <jan.kiszka@siemens.com>
To: cip-dev@lists.cip-project.org
Cc: Alexander Heinisch <alexander.heinisch@siemens.com>,
	Quirin Gylstorff <quirin.gylstorff@siemens.com>
Subject: [isar-cip-core][PATCH 02/10] initramfs-abrootfs-hook: Convert to hook.inc
Date: Mon,  2 Dec 2024 15:51:05 +0100
Message-ID: <0c165d4ff9ef33eb580ebbcf6758958e42e2ad38.1733151072.git.jan.kiszka@siemens.com>
In-Reply-To: <cover.1733151072.git.jan.kiszka@siemens.com>
References: <cover.1733151072.git.jan.kiszka@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-294854:519-21489:flowmailer
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 02 Dec 2024 14:51:39 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/17311

From: Jan Kiszka <jan.kiszka@siemens.com>

Reduces boilerplate code.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 .../files/abrootfs.hook                       | 24 ------------------
 .../initramfs-abrootfs-hook/files/hook        |  5 ++++
 .../{abrootfs.script => local-top-complete}   |  0
 ..._0.1.bb => initramfs-abrootfs-hook_0.2.bb} | 25 ++++++++-----------
 4 files changed, 15 insertions(+), 39 deletions(-)
 delete mode 100644 recipes-initramfs/initramfs-abrootfs-hook/files/abrootfs.hook
 create mode 100644 recipes-initramfs/initramfs-abrootfs-hook/files/hook
 rename recipes-initramfs/initramfs-abrootfs-hook/files/{abrootfs.script => local-top-complete} (100%)
 rename recipes-initramfs/initramfs-abrootfs-hook/{initramfs-abrootfs-hook_0.1.bb => initramfs-abrootfs-hook_0.2.bb} (61%)

diff --git a/recipes-initramfs/initramfs-abrootfs-hook/files/abrootfs.hook b/recipes-initramfs/initramfs-abrootfs-hook/files/abrootfs.hook
deleted file mode 100644
index bacbc2ee..00000000
--- a/recipes-initramfs/initramfs-abrootfs-hook/files/abrootfs.hook
+++ /dev/null
@@ -1,24 +0,0 @@
-#!/bin/sh
-# Copyright (C) Siemens AG, 2020-2022
-#
-# SPDX-License-Identifier: MIT
-
-PREREQ=""
-
-prereqs()
-{
-     echo "$PREREQ"
-}
-
-case $1 in
-prereqs)
-     prereqs
-     exit 0
-     ;;
-esac
-
-. /usr/share/initramfs-tools/scripts/functions
-. /usr/share/initramfs-tools/hook-functions
-
-copy_exec /usr/bin/lsblk
-copy_file library /usr/share/abrootfs/image-uuid.env /usr/share/abrootfs/image-uuid.env
diff --git a/recipes-initramfs/initramfs-abrootfs-hook/files/hook b/recipes-initramfs/initramfs-abrootfs-hook/files/hook
new file mode 100644
index 00000000..6d4a6129
--- /dev/null
+++ b/recipes-initramfs/initramfs-abrootfs-hook/files/hook
@@ -0,0 +1,5 @@
+# Copyright (C) Siemens AG, 2020-2022
+#
+# SPDX-License-Identifier: MIT
+
+copy_file library /usr/share/abrootfs/image-uuid.env /usr/share/abrootfs/image-uuid.env
diff --git a/recipes-initramfs/initramfs-abrootfs-hook/files/abrootfs.script b/recipes-initramfs/initramfs-abrootfs-hook/files/local-top-complete
similarity index 100%
rename from recipes-initramfs/initramfs-abrootfs-hook/files/abrootfs.script
rename to recipes-initramfs/initramfs-abrootfs-hook/files/local-top-complete
diff --git a/recipes-initramfs/initramfs-abrootfs-hook/initramfs-abrootfs-hook_0.1.bb b/recipes-initramfs/initramfs-abrootfs-hook/initramfs-abrootfs-hook_0.2.bb
similarity index 61%
rename from recipes-initramfs/initramfs-abrootfs-hook/initramfs-abrootfs-hook_0.1.bb
rename to recipes-initramfs/initramfs-abrootfs-hook/initramfs-abrootfs-hook_0.2.bb
index 17c60da4..592f305f 100644
--- a/recipes-initramfs/initramfs-abrootfs-hook/initramfs-abrootfs-hook_0.1.bb
+++ b/recipes-initramfs/initramfs-abrootfs-hook/initramfs-abrootfs-hook_0.2.bb
@@ -1,7 +1,7 @@
 #
 # CIP Core, generic profile
 #
-# Copyright (c) Siemens AG, 2020-2022
+# Copyright (c) Siemens AG, 2020-2024
 #
 # Authors:
 #  Quirin Gylstorff <quirin.gylstorff@siemens.com>
@@ -9,17 +9,19 @@
 #
 # SPDX-License-Identifier: MIT
 
+require recipes-initramfs/initramfs-hook/hook.inc
 
-inherit dpkg-raw
-
-DEBIAN_DEPENDS = "initramfs-tools"
+DEBIAN_DEPENDS .= ", util-linux"
 DEBIAN_CONFLICTS = "initramfs-verity-hook"
 
-SRC_URI += "file://abrootfs.hook \
-            file://abrootfs.script"
+SRC_URI += " \
+    file://hook \
+    file://local-top-complete"
 
 ABROOTFS_IMAGE_RECIPE ?= "cip-core-image"
 
+HOOK_COPY_EXECS = "lsblk"
+
 # This is defined in image.bbclass which cannot be used in a package recipe.
 # However, we need to use IMAGE_FULLNAME to pick up any extensions of it.
 IMAGE_FULLNAME ??= "${ABROOTFS_IMAGE_RECIPE}-${DISTRO}-${MACHINE}"
@@ -27,19 +29,12 @@ IMAGE_FULLNAME ??= "${ABROOTFS_IMAGE_RECIPE}-${DISTRO}-${MACHINE}"
 IMAGE_UUID_ENV_FILE = "${DEPLOY_DIR_IMAGE}/${IMAGE_FULLNAME}.uuid.env"
 
 do_install[depends] += "${ABROOTFS_IMAGE_RECIPE}:do_generate_image_uuid"
-do_install[cleandirs] += " \
-    ${D}/usr/share/initramfs-tools/hooks \
-    ${D}/usr/share/abrootfs \
-    ${D}/usr/share/initramfs-tools/scripts/local-top"
+do_install[cleandirs] += "${D}/usr/share/abrootfs"
 
-do_install() {
+do_install:append() {
     if [ -f "${IMAGE_UUID_ENV_FILE}" ]; then
         install -m 0600 "${IMAGE_UUID_ENV_FILE}" "${D}/usr/share/abrootfs/image-uuid.env"
     else
         bberror "Did not find ${IMAGE_UUID_ENV_FILE}. initramfs will not be build correctly!"
     fi
-    install -m 0755 "${WORKDIR}/abrootfs.script" \
-        "${D}/usr/share/initramfs-tools/scripts/local-top/abrootfs"
-    install -m 0755 "${WORKDIR}/abrootfs.hook" \
-        "${D}/usr/share/initramfs-tools/hooks/abrootfs"
 }
-- 
2.43.0


