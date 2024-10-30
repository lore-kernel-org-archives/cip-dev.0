Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D188D5CCA5
	for <webhook@archiver.kernel.org>; Wed, 30 Oct 2024 11:52:02 +0000 (UTC)
Received: from mta-64-227.siemens.flowmailer.net (mta-64-227.siemens.flowmailer.net [185.136.64.227])
 by mx.groups.io with SMTP id smtpd.web10.13028.1730289112085338746
 for <cip-dev@lists.cip-project.org>;
 Wed, 30 Oct 2024 04:51:53 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=jan.kiszka@siemens.com header.s=fm1 header.b=Ri83ZFNl;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.64.227, mailfrom: fm-294854-2024103011514870580dd306e78806e8-lsfwc1@rts-flowmailer.siemens.com)
Received: by mta-64-227.siemens.flowmailer.net with ESMTPSA id 2024103011514870580dd306e78806e8
        for <cip-dev@lists.cip-project.org>;
        Wed, 30 Oct 2024 12:51:49 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=jan.kiszka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:References:In-Reply-To;
 bh=WvEqAuXwIQ2S497lUaErWZV8xCSS6/lqKvgULM7A6Vg=;
 b=Ri83ZFNlb9vH9w+NWCDBpE0eytvQURoduUP5cqZLEkqiXxeGsfbvgT7ueoW/KBup2U/Oe8
 9MheCAAJvfPHTOdLasCfRhsg2zMkcQNN4tuse6REL4m+aM/T+7o0AuWz+kyQowo3bnMsPHdi
 034Rdc/hP2N5V+IZaogHE6webWnAkMjTsOkQ80uZVrb4Txj4gihxwwKof2izlMVeexu/HoE6
 F+9usHbh2zq55s5cjK3GiDGxE10hc9Qb7+UTUU/WrIzYqKgEY7wCF6hwm38Jal3fYadh8hA8
 iP1z/kkpkCL6ATGsdB5ftfEtSfkNsjXfVQXsQcs1kXXJE5GMI4RIRowg==;
From: Jan Kiszka <jan.kiszka@siemens.com>
To: cip-dev@lists.cip-project.org
Subject: [isar-cip-core][PATCH 3/6] Add initramfs-erofs-hook
Date: Wed, 30 Oct 2024 12:51:44 +0100
Message-ID: <fe5d4b784eeee78d51b13faa863ee331cbe61bad.1730289107.git.jan.kiszka@siemens.com>
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
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/17118

From: Jan Kiszka <jan.kiszka@siemens.com>

This is basically just search&replace compared to
initramfs-squashfs-hook.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 .../initramfs-erofs-hook/files/erofs.hook     | 25 +++++++++++++++++++
 .../initramfs-erofs-hook_0.1.bb               | 24 ++++++++++++++++++
 2 files changed, 49 insertions(+)
 create mode 100644 recipes-initramfs/initramfs-erofs-hook/files/erofs.hook
 create mode 100644 recipes-initramfs/initramfs-erofs-hook/initramfs-erofs-hook_0.1.bb

diff --git a/recipes-initramfs/initramfs-erofs-hook/files/erofs.hook b/recipes-initramfs/initramfs-erofs-hook/files/erofs.hook
new file mode 100644
index 00000000..cf43bf10
--- /dev/null
+++ b/recipes-initramfs/initramfs-erofs-hook/files/erofs.hook
@@ -0,0 +1,25 @@
+#!/bin/sh
+#
+# CIP Core, generic profile
+#
+# Copyright (c) Siemens AG, 2024
+#
+# Authors:
+#  Jan Kiszka <jan.kiszka@siemens.com>
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
+manual_add_modules erofs
diff --git a/recipes-initramfs/initramfs-erofs-hook/initramfs-erofs-hook_0.1.bb b/recipes-initramfs/initramfs-erofs-hook/initramfs-erofs-hook_0.1.bb
new file mode 100644
index 00000000..ab679c91
--- /dev/null
+++ b/recipes-initramfs/initramfs-erofs-hook/initramfs-erofs-hook_0.1.bb
@@ -0,0 +1,24 @@
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
+inherit dpkg-raw
+
+SRC_URI += "file://erofs.hook"
+
+DEBIAN_DEPENDS = "erofs-utils"
+
+do_install[cleandirs] += " \
+    ${D}/usr/share/initramfs-tools/hooks"
+
+do_install() {
+    install -m 0755 "${WORKDIR}/erofs.hook" \
+        "${D}/usr/share/initramfs-tools/hooks/erofs"
+}
-- 
2.43.0


