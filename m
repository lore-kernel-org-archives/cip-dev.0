Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 850C5C61DC7
	for <webhook@archiver.kernel.org>; Wed, 26 Aug 2026 15:21:11 +0000 (UTC)
Received: from mta-64-227.siemens.flowmailer.net (mta-64-227.siemens.flowmailer.net [185.136.64.227])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.15249.1787757660871309619
 for <cip-dev@lists.cip-project.org>;
 Wed, 26 Aug 2026 08:21:01 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=jan.kiszka@siemens.com header.s=fm2 header.b=YNDsiYod;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.64.227, mailfrom: fm-294854-2026082615205843992621850002077f-fv4d8m@rts-flowmailer.siemens.com)
Received: by mta-64-227.siemens.flowmailer.net with ESMTPSA id 2026082615205843992621850002077f
        for <cip-dev@lists.cip-project.org>;
        Wed, 26 Aug 2026 17:20:58 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm2;
 d=siemens.com; i=jan.kiszka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=eCoVsJdAxktZAo205FZLNekP8GYUs2eiip2gVMEayrI=;
 b=YNDsiYodxkvLb7Ap1/CQhtsQCOR79CW0AXF6TXG6YHOa/8iK72121chcZCh55b2GyXyUpi
 hZC5dw619kVycSXf97QsMiBtXGvwIQuMNBTUkLtrYMIGu7kFCScAyZM/5oKo0oDp/XjoQnDV
 eRfhxoHY25+TEEsIVhEJ5Mb53pYZfLhPV2IJ2qBnBt/QXkDGkPYSx4GLJYEsB6dR3crTeiOb
 IHkCFHQZjjzy4bZ+G3bIGafl5Bl8EL7wndsE4ljCz+pgRaviIZ7q7GZQ/dAnbNFhyZmflUTL
 UmCmjkEJkgSiCdDZvjuzOTz93ITa/Rp6GAuVGOLCEbXYehc1N96NrJJQ==;
From: Jan Kiszka <jan.kiszka@siemens.com>
To: cip-dev@lists.cip-project.org
Cc: Sai Sree Kartheek Adivi <s-adivi@ti.com>,
	Quirin Gylstorff <quirin.gylstorff@siemens.com>,
	Alexander Heinisch <alexander.heinisch@siemens.com>
Subject: [isar-cip-core][PATCH v2 3/7] cip-core-initramfs: Automatically deploy EFI secure boot certificates on first boot
Date: Wed, 26 Aug 2026 17:20:51 +0200
Message-ID: <fc5abf12e5ad07f9d69f20d83e41cd77bbfa3f38.1787757655.git.jan.kiszka@siemens.com>
In-Reply-To: <cover.1787757655.git.jan.kiszka@siemens.com>
References: <cover.1787757655.git.jan.kiszka@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-294854:519-21489:flowmailer
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 26 Aug 2026 15:21:11 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/24030

From: Jan Kiszka <jan.kiszka@siemens.com>

This both simplifies the initial deployment of secure boot to a device
as well as makes sure that we will always seal the disk encryption key
against the right state.

We only deploy if secure boot is off and the db is found empty. So this
hook is not intended to be used for key exchange or db extensions. The
former will be once handled via SWUpdate packages, the latter might be
considered given a concrete use case.

Note that due to the primitive implementation of efivarfs detection in
efitools, we need to deploy a horrible hack to make it work against the
mount implementation of busybox in the initramfs. A patch to improve
that issue is pending upstream.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 .../cip-core-initramfs/cip-core-initramfs.bb  |  1 +
 .../initramfs-sbcerts-hook/files/hook         | 16 +++++++++
 .../initramfs-sbcerts-hook/files/local-top    | 34 +++++++++++++++++++
 .../initramfs-sbcerts-hook/files/mount-stub   | 13 +++++++
 .../initramfs-sbcerts-hook_0.1.bb             | 32 +++++++++++++++++
 5 files changed, 96 insertions(+)
 create mode 100644 recipes-initramfs/initramfs-sbcerts-hook/files/hook
 create mode 100644 recipes-initramfs/initramfs-sbcerts-hook/files/local-top
 create mode 100755 recipes-initramfs/initramfs-sbcerts-hook/files/mount-stub
 create mode 100644 recipes-initramfs/initramfs-sbcerts-hook/initramfs-sbcerts-hook_0.1.bb

diff --git a/recipes-initramfs/cip-core-initramfs/cip-core-initramfs.bb b/recipes-initramfs/cip-core-initramfs/cip-core-initramfs.bb
index b686185c..7e77a205 100644
--- a/recipes-initramfs/cip-core-initramfs/cip-core-initramfs.bb
+++ b/recipes-initramfs/cip-core-initramfs/cip-core-initramfs.bb
@@ -22,6 +22,7 @@ INITRAMFS_INSTALL:append:factory-reset = " initramfs-factory-reset-hook"
 INITRAMFS_INSTALL:append:ftpm-stmm = " initramfs-tee-ftpm-hook"
 INITRAMFS_INSTALL:append:swupdate = " initramfs-abrootfs-hook"
 INITRAMFS_INSTALL:append:swupdate = " initramfs-${RO_ROOTFS_TYPE}-hook"
+INITRAMFS_INSTALL:append:secureboot = " initramfs-sbcerts-hook"
 INITRAMFS_INSTALL:append:secureboot = " initramfs-verity-hook"
 # abrootfs cannot be installed together with verity
 INITRAMFS_INSTALL:remove:secureboot = "initramfs-abrootfs-hook"
diff --git a/recipes-initramfs/initramfs-sbcerts-hook/files/hook b/recipes-initramfs/initramfs-sbcerts-hook/files/hook
new file mode 100644
index 00000000..df645134
--- /dev/null
+++ b/recipes-initramfs/initramfs-sbcerts-hook/files/hook
@@ -0,0 +1,16 @@
+#
+# CIP Core, generic profile
+#
+# Copyright (c) Siemens AG, 2026
+#
+# Authors:
+#  Jan Kiszka <jan.kiszka@siemens.com>
+#
+# SPDX-License-Identifier: MIT
+#
+
+copy_file binary /usr/share/secure-boot-efi-certs/db.auth
+copy_file binary /usr/share/secure-boot-efi-certs/KEK.auth
+copy_file binary /usr/share/secure-boot-efi-certs/PK.auth
+
+copy_file binary /usr/share/initramfs-sbcerts-hook/mount
diff --git a/recipes-initramfs/initramfs-sbcerts-hook/files/local-top b/recipes-initramfs/initramfs-sbcerts-hook/files/local-top
new file mode 100644
index 00000000..e3b7a0fc
--- /dev/null
+++ b/recipes-initramfs/initramfs-sbcerts-hook/files/local-top
@@ -0,0 +1,34 @@
+#
+# CIP Core, generic profile
+#
+# Copyright (c) Siemens AG, 2026
+#
+# Authors:
+#  Jan Kiszka <jan.kiszka@siemens.com>
+#
+# SPDX-License-Identifier: MIT
+#
+
+. /scripts/cip-initramfs-functions
+
+if secure_boot_enabled; then
+	exit 0
+fi
+
+ORIG_PATH="$PATH"
+export PATH="/usr/share/initramfs-sbcerts-hook:$PATH"
+
+if ! efi-readvar -v db | grep -q "has no entries"; then
+	export PATH="$ORIG_PATH"
+	log_warning_msg "Not securely booting, but certificates already deployed"
+	exit 0
+fi
+
+log_begin_msg "Deploying EFI secure boot certificates"
+efi-updatevar -f /usr/share/secure-boot-efi-certs/db.auth db
+efi-updatevar -f /usr/share/secure-boot-efi-certs/KEK.auth KEK
+efi-updatevar -f /usr/share/secure-boot-efi-certs/PK.auth PK
+log_end_msg
+
+log_success_msg "Rebooting after certificate deployment..."
+reboot
diff --git a/recipes-initramfs/initramfs-sbcerts-hook/files/mount-stub b/recipes-initramfs/initramfs-sbcerts-hook/files/mount-stub
new file mode 100755
index 00000000..408b584e
--- /dev/null
+++ b/recipes-initramfs/initramfs-sbcerts-hook/files/mount-stub
@@ -0,0 +1,13 @@
+#!/bin/sh
+#
+# CIP Core, generic profile
+#
+# Copyright (c) Siemens AG, 2026
+#
+# Authors:
+#  Jan Kiszka <jan.kiszka@siemens.com>
+#
+# SPDX-License-Identifier: MIT
+#
+
+echo "none on /sys/firmware/efi/efivars type efivarfs"
diff --git a/recipes-initramfs/initramfs-sbcerts-hook/initramfs-sbcerts-hook_0.1.bb b/recipes-initramfs/initramfs-sbcerts-hook/initramfs-sbcerts-hook_0.1.bb
new file mode 100644
index 00000000..d7a3abcf
--- /dev/null
+++ b/recipes-initramfs/initramfs-sbcerts-hook/initramfs-sbcerts-hook_0.1.bb
@@ -0,0 +1,32 @@
+#
+# CIP Core, generic profile
+#
+# Copyright (c) Siemens AG, 2026
+#
+# Authors:
+#  Jan Kiszka <jan.kiszka@siemens.com>
+#
+# SPDX-License-Identifier: MIT
+#
+
+inherit initramfs-hook
+
+MAINTAINER = "cip-dev <cip-dev@lists.cip-project.org>"
+DESCRIPTION = "Initramfs hook to deploy UEFI secure boot certificates during early boot"
+
+DEPENDS = "secure-boot-efi-certs initramfs-cip-functions"
+DEBIAN_DEPENDS .= ", secure-boot-efi-certs, efitools, initramfs-cip-functions"
+
+HOOK_COPY_EXECS = "cmp mountpoint efi-readvar efi-updatevar grep"
+
+HOOK_ADD_MODULES = "efivarfs"
+
+SRC_URI += " \
+    file://hook \
+    file://local-top \
+    file://mount-stub"
+
+do_install[cleandirs] += "${D}/usr/share/${BPN}"
+do_install:append() {
+    install "${WORKDIR}/mount-stub" "${D}/usr/share/${BPN}/mount"
+}
-- 
2.47.3


