X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mta-64-227.siemens.flowmailer.net (mta-64-227.siemens.flowmailer.net [185.136.64.227])
 by mx.groups.io with SMTP id smtpd.web12.18652.1665569276056380120
 for <cip-dev@lists.cip-project.org>;
 Wed, 12 Oct 2022 03:07:58 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=felix.moessbauer@siemens.com header.s=fm1 header.b=EbS4Rfps;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.64.227, mailfrom: fm-72506-202210121007548dfc7516190af709bd-ugbw1d@rts-flowmailer.siemens.com)
Received: by mta-64-227.siemens.flowmailer.net with ESMTPSA id 202210121007548dfc7516190af709bd
        for <cip-dev@lists.cip-project.org>;
        Wed, 12 Oct 2022 12:07:54 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=felix.moessbauer@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=4Hmb18/h4s6/emlkQbXQJK7xoRWnRmFpFcQWrDqte/Q=;
 b=EbS4RfpsGaLP+O3VvOE8xMLNtF5u2z/ETyvVkctS6fRMcPqi0H8LXUzzzwJriXnqH7orui
 gNxfJ/xQtkbDWMTDpay+LlrNbqO2VBQLbYkd1FjwdNtaloQTsndJHnzxGdESAzPPvO+dby+y
 WB5ysAd/RjmAlBGrD8duOyTwma5A4=;
From: Felix Moessbauer <felix.moessbauer@siemens.com>
To: cip-dev@lists.cip-project.org
Cc: jan.kiszka@siemens.com,
	quirin.gylstorff@siemens.com,
	pluto.svc.chengdu.cn@siemens.com,
	Felix Moessbauer <felix.moessbauer@siemens.com>
Subject: [isar-cip-core][PATCH 2/3] fix: add squashfs hook to enforce load of module
Date: Wed, 12 Oct 2022 12:06:40 +0200
Message-Id: <20221012100641.2986740-3-felix.moessbauer@siemens.com>
In-Reply-To: <20221012100641.2986740-1-felix.moessbauer@siemens.com>
References: <20221012100641.2986740-1-felix.moessbauer@siemens.com>
MIME-Version: 1.0
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-72506:519-21489:flowmailer
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="us-ascii"
List-Id: <cip-dev.lists.cip-project.org>

This patch fixes issues when using a stock debian kernel, as this kernel
has no compiled-in support for sqashfs.
By explicitly adding the module to the initramfs we ensure that it is
available.

Signed-off-by: Felix Moessbauer <felix.moessbauer@siemens.com>
---
 kas/opt/ebg-swu.yml                           |  2 +-
 .../files/squashfs.hook                       | 25 +++++++++++++++++++
 .../initramfs-squashfs-hook_0.1.bb            | 24 ++++++++++++++++++
 3 files changed, 50 insertions(+), 1 deletion(-)
 create mode 100644 recipes-initramfs/initramfs-squashfs-hook/files/squashfs.hook
 create mode 100644 recipes-initramfs/initramfs-squashfs-hook/initramfs-squashfs-hook_0.1.bb

diff --git a/kas/opt/ebg-swu.yml b/kas/opt/ebg-swu.yml
index ce37c36..914c743 100644
--- a/kas/opt/ebg-swu.yml
+++ b/kas/opt/ebg-swu.yml
@@ -22,7 +22,7 @@ local_conf_header:
   ebg_swu_image_options: |
     CIP_IMAGE_OPTIONS_append = " efibootguard.inc image-uuid.inc"
   initramfs: |
-    INITRAMFS_INSTALL_append = " initramfs-abrootfs-hook"
+    INITRAMFS_INSTALL_append = " initramfs-abrootfs-hook initramfs-squashfs-hook"
   firmware-binaries: |
     # Add ovmf binaries for qemu
     IMAGER_BUILD_DEPS_append_qemu-amd64 += "ovmf-binaries"
diff --git a/recipes-initramfs/initramfs-squashfs-hook/files/squashfs.hook b/recipes-initramfs/initramfs-squashfs-hook/files/squashfs.hook
new file mode 100644
index 0000000..0b9b208
--- /dev/null
+++ b/recipes-initramfs/initramfs-squashfs-hook/files/squashfs.hook
@@ -0,0 +1,25 @@
+#!/bin/sh
+#
+# CIP Core, generic profile
+#
+# Copyright (c) Siemens AG, 2022
+#
+# Authors:
+#  Felix Moessbauer <felix.moessbauer@siemens.com>
+#
+
+PREREQ=""
+prereqs()
+{
+    echo "$PREREQ"
+}
+case $1 in
+prereqs)
+    prereqs
+    exit 0
+    ;;
+esac
+
+. /usr/share/initramfs-tools/hook-functions
+
+manual_add_modules squashfs
diff --git a/recipes-initramfs/initramfs-squashfs-hook/initramfs-squashfs-hook_0.1.bb b/recipes-initramfs/initramfs-squashfs-hook/initramfs-squashfs-hook_0.1.bb
new file mode 100644
index 0000000..332278f
--- /dev/null
+++ b/recipes-initramfs/initramfs-squashfs-hook/initramfs-squashfs-hook_0.1.bb
@@ -0,0 +1,24 @@
+#
+# CIP Core, generic profile
+#
+# Copyright (c) Siemens AG, 2022
+#
+# Authors:
+#  Felix Moessbauer <felix.moessbauer@siemens.com>
+#
+# SPDX-License-Identifier: MIT
+#
+
+inherit dpkg-raw
+
+SRC_URI += "file://squashfs.hook"
+
+DEBIAN_DEPENDS = "initramfs-tools"
+
+do_install[cleandirs] += " \
+    ${D}/usr/share/initramfs-tools/hooks"
+
+do_install() {
+    install -m 0755 "${WORKDIR}/squashfs.hook" \
+        "${D}/usr/share/initramfs-tools/hooks/squashfs"
+}
-- 
2.30.2


