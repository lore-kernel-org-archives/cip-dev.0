Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E32A2D31774
	for <webhook@archiver.kernel.org>; Tue,  5 Nov 2024 17:54:43 +0000 (UTC)
Received: from mta-65-225.siemens.flowmailer.net (mta-65-225.siemens.flowmailer.net [185.136.65.225])
 by mx.groups.io with SMTP id smtpd.web10.26674.1730829277219609348
 for <cip-dev@lists.cip-project.org>;
 Tue, 05 Nov 2024 09:54:38 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=jan.kiszka@siemens.com header.s=fm1 header.b=EhNrjOBu;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.65.225, mailfrom: fm-294854-20241105175434b813092ae22da9579e-vhmedc@rts-flowmailer.siemens.com)
Received: by mta-65-225.siemens.flowmailer.net with ESMTPSA id 20241105175434b813092ae22da9579e
        for <cip-dev@lists.cip-project.org>;
        Tue, 05 Nov 2024 18:54:34 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=jan.kiszka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:References:In-Reply-To;
 bh=WvEqAuXwIQ2S497lUaErWZV8xCSS6/lqKvgULM7A6Vg=;
 b=EhNrjOBu6sNOOX28hyTOYUbuxJoKPGwZjbbGXfwEmCBk79Wm1S38p9US+EdeUzzntXvcq4
 J3vKodNIcHaf4rrbWMVGHwCDuKCxdZvy30sKrXCk0yjIK2X+M86XpeyzLkBSpIeUemrWiKle
 HPj8fwKyHakXMkw4NLHtPNSpb1owGaZcUdvodRIFxOdVcCcTYjQsmZU1W82JAuIgkT3cQawx
 33KUL9e93q9B5OsegJ4+XFPBpqohpB3uei0PPFp8ia1RgitI28PG3UdBn05WPR5HWTr6M2jm
 4pcXG0pU7DimNRjEYWW6CN3TOPcwV1VUm7tGWrLnCm1JP3LTXjqczECg==;
From: Jan Kiszka <jan.kiszka@siemens.com>
To: cip-dev@lists.cip-project.org
Subject: [isar-cip-core][PATCH v2 3/6] Add initramfs-erofs-hook
Date: Tue,  5 Nov 2024 18:54:30 +0100
Message-ID: <2fbfc72ee776eb11cd1748f233c266537b55993c.1730829273.git.jan.kiszka@siemens.com>
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
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/17182

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


