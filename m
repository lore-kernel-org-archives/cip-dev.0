Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95D82D78329
	for <webhook@archiver.kernel.org>; Mon,  2 Dec 2024 14:51:39 +0000 (UTC)
Received: from mta-64-227.siemens.flowmailer.net (mta-64-227.siemens.flowmailer.net [185.136.64.227])
 by mx.groups.io with SMTP id smtpd.web11.175577.1733151097268660198
 for <cip-dev@lists.cip-project.org>;
 Mon, 02 Dec 2024 06:51:37 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=jan.kiszka@siemens.com header.s=fm2 header.b=VOeHXNyT;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.64.227, mailfrom: fm-294854-2024120214513560102f75ca1c039bad-x3i8a0@rts-flowmailer.siemens.com)
Received: by mta-64-227.siemens.flowmailer.net with ESMTPSA id 2024120214513560102f75ca1c039bad
        for <cip-dev@lists.cip-project.org>;
        Mon, 02 Dec 2024 15:51:35 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm2;
 d=siemens.com; i=jan.kiszka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=5dHio+Q6mBlsAPrGojIojLviWgx6+Oy3LoBddFhUkEc=;
 b=VOeHXNyTOua9W2oMpOOveEHMDNxYX9A9FX7VWnH5dNKxP0+45ncEQ3UUzlgyopG3t4szO7
 ytHWbf6+AyBJoC/W3wTNAnmwcHlexnHXQsltcK+qdEgw29EvXN884LxU9hyGiPYCT8b6hcsu
 FlS90A4dlN0EHGuuYPKYPUvuoqhW7S9/TJWwAZ/Jwq8SoS1xLPeYRTeIQuEcF1G0Zngvhs0V
 dP5QYNZmeG9vW97K25MSHJSA5IsmXPCghuEoJ6vFQxkdxReisAqvzBNkCTOjgtyD9cuyRDWQ
 rQpyCaV1AYoCD59X0ZMC++pdSCyuouAfUC++VLKMpzeIPEZlsStnBDzA==;
From: Jan Kiszka <jan.kiszka@siemens.com>
To: cip-dev@lists.cip-project.org
Cc: Alexander Heinisch <alexander.heinisch@siemens.com>,
	Quirin Gylstorff <quirin.gylstorff@siemens.com>
Subject: [isar-cip-core][PATCH 05/10] initramfs-erofs/squashfs-hook: Convert to hook.inc
Date: Mon,  2 Dec 2024 15:51:08 +0100
Message-ID: <5ab2ad8433666362cfe30c5c21d70ae2f36117bb.1733151072.git.jan.kiszka@siemens.com>
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
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/17316

From: Jan Kiszka <jan.kiszka@siemens.com>

Simplifies the recipes to their minimum.

The Debian dependency on erofs-utils was actually not needed, drop it at
this chance.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 .../initramfs-erofs-hook/files/erofs.hook     | 25 -------------------
 .../initramfs-erofs-hook_0.1.bb               | 24 ------------------
 .../initramfs-erofs-hook_0.2.bb               | 14 +++++++++++
 .../initramfs-squashfs-hook_0.1.bb            | 24 ------------------
 .../initramfs-squashfs-hook_0.2.bb            | 14 +++++++++++
 5 files changed, 28 insertions(+), 73 deletions(-)
 delete mode 100644 recipes-initramfs/initramfs-erofs-hook/files/erofs.hook
 delete mode 100644 recipes-initramfs/initramfs-erofs-hook/initramfs-erofs-hook_0.1.bb
 create mode 100644 recipes-initramfs/initramfs-erofs-hook/initramfs-erofs-hook_0.2.bb
 delete mode 100644 recipes-initramfs/initramfs-squashfs-hook/initramfs-squashfs-hook_0.1.bb
 create mode 100644 recipes-initramfs/initramfs-squashfs-hook/initramfs-squashfs-hook_0.2.bb

diff --git a/recipes-initramfs/initramfs-erofs-hook/files/erofs.hook b/recipes-initramfs/initramfs-erofs-hook/files/erofs.hook
deleted file mode 100644
index cf43bf10..00000000
--- a/recipes-initramfs/initramfs-erofs-hook/files/erofs.hook
+++ /dev/null
@@ -1,25 +0,0 @@
-#!/bin/sh
-#
-# CIP Core, generic profile
-#
-# Copyright (c) Siemens AG, 2024
-#
-# Authors:
-#  Jan Kiszka <jan.kiszka@siemens.com>
-#
-
-PREREQ=""
-prereqs()
-{
-    echo "$PREREQ"
-}
-case $1 in
-prereqs)
-    prereqs
-    exit 0
-    ;;
-esac
-
-. /usr/share/initramfs-tools/hook-functions
-
-manual_add_modules erofs
diff --git a/recipes-initramfs/initramfs-erofs-hook/initramfs-erofs-hook_0.1.bb b/recipes-initramfs/initramfs-erofs-hook/initramfs-erofs-hook_0.1.bb
deleted file mode 100644
index ab679c91..00000000
--- a/recipes-initramfs/initramfs-erofs-hook/initramfs-erofs-hook_0.1.bb
+++ /dev/null
@@ -1,24 +0,0 @@
-#
-# CIP Core, generic profile
-#
-# Copyright (c) Siemens AG, 2024
-#
-# Authors:
-#  Jan Kiszka <jan.kiszka@siemens.com>
-#
-# SPDX-License-Identifier: MIT
-#
-
-inherit dpkg-raw
-
-SRC_URI += "file://erofs.hook"
-
-DEBIAN_DEPENDS = "erofs-utils"
-
-do_install[cleandirs] += " \
-    ${D}/usr/share/initramfs-tools/hooks"
-
-do_install() {
-    install -m 0755 "${WORKDIR}/erofs.hook" \
-        "${D}/usr/share/initramfs-tools/hooks/erofs"
-}
diff --git a/recipes-initramfs/initramfs-erofs-hook/initramfs-erofs-hook_0.2.bb b/recipes-initramfs/initramfs-erofs-hook/initramfs-erofs-hook_0.2.bb
new file mode 100644
index 00000000..a7dbb673
--- /dev/null
+++ b/recipes-initramfs/initramfs-erofs-hook/initramfs-erofs-hook_0.2.bb
@@ -0,0 +1,14 @@
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
+require recipes-initramfs/initramfs-hook/hook.inc
+
+HOOK_ADD_MODULES = "erofs"
diff --git a/recipes-initramfs/initramfs-squashfs-hook/initramfs-squashfs-hook_0.1.bb b/recipes-initramfs/initramfs-squashfs-hook/initramfs-squashfs-hook_0.1.bb
deleted file mode 100644
index 332278f5..00000000
--- a/recipes-initramfs/initramfs-squashfs-hook/initramfs-squashfs-hook_0.1.bb
+++ /dev/null
@@ -1,24 +0,0 @@
-#
-# CIP Core, generic profile
-#
-# Copyright (c) Siemens AG, 2022
-#
-# Authors:
-#  Felix Moessbauer <felix.moessbauer@siemens.com>
-#
-# SPDX-License-Identifier: MIT
-#
-
-inherit dpkg-raw
-
-SRC_URI += "file://squashfs.hook"
-
-DEBIAN_DEPENDS = "initramfs-tools"
-
-do_install[cleandirs] += " \
-    ${D}/usr/share/initramfs-tools/hooks"
-
-do_install() {
-    install -m 0755 "${WORKDIR}/squashfs.hook" \
-        "${D}/usr/share/initramfs-tools/hooks/squashfs"
-}
diff --git a/recipes-initramfs/initramfs-squashfs-hook/initramfs-squashfs-hook_0.2.bb b/recipes-initramfs/initramfs-squashfs-hook/initramfs-squashfs-hook_0.2.bb
new file mode 100644
index 00000000..4b199834
--- /dev/null
+++ b/recipes-initramfs/initramfs-squashfs-hook/initramfs-squashfs-hook_0.2.bb
@@ -0,0 +1,14 @@
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
+require recipes-initramfs/initramfs-hook/hook.inc
+
+HOOK_ADD_MODULES = "squashfs"
-- 
2.43.0


