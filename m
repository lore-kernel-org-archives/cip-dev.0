Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3C04C433EF
	for <webhook@archiver.kernel.org>; Thu,  5 May 2022 16:43:38 +0000 (UTC)
Received: from mta-65-225.siemens.flowmailer.net
 (mta-65-225.siemens.flowmailer.net [185.136.65.225])
 by mx.groups.io with SMTP id smtpd.web11.13541.1651769014822241356
 for <cip-dev@lists.cip-project.org>;
 Thu, 05 May 2022 09:43:35 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=jan.kiszka@siemens.com header.s=fm1 header.b=Fr7TRiyO;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.65.225,
 mailfrom: fm-294854-202205051643316637f9cd2d42a4bed0-hsxbfp@rts-flowmailer.siemens.com)
Received: by mta-65-225.siemens.flowmailer.net with ESMTPSA id
 202205051643316637f9cd2d42a4bed0
        for <cip-dev@lists.cip-project.org>;
        Thu, 05 May 2022 18:43:31 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=jan.kiszka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=yc1tBJMr8NLC7gYRSH6TtnijvCrtxJTLX06pCsbi0s8=;
 b=Fr7TRiyOJjZrwCxUGt5dH5f8iACYqrJQzIuDxqP4ub6f3q8xWkt1XNBQHDgE+ASO6e2NsC
 AkJgpib4jOg6YmOB6DubIldl448wsrEmTYQvedReJqMqwwQr8k56okZ7e7CCdxwfwa0pNesG
 zo9LWtf4AmHcJ00ncq+RLDw7LufUU=;
From: Jan Kiszka <jan.kiszka@siemens.com>
To: cip-dev@lists.cip-project.org
Cc: Quirin Gylstorff <quirin.gylstorff@siemens.com>,
	Christian Storm <christian.storm@siemens.com>
Subject: [isar-cip-core][PATCH v2 02/13] initramfs-etc-overlay-hook: Install
 overlay module
Date: Thu,  5 May 2022 18:43:18 +0200
Message-Id: 
 <ff9a89cb20920ddbacebc4c78e57e52537466064.1651769009.git.jan.kiszka@siemens.com>
In-Reply-To: <cover.1651769009.git.jan.kiszka@siemens.com>
References: <cover.1651769009.git.jan.kiszka@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-294854:519-21489:flowmailer
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 05 May 2022 16:43:38 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/8256

From: Jan Kiszka <jan.kiszka@siemens.com>

Needed in case overlay support is built as kernel module.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 .../files/etc-overlay.hook                    | 25 +++++++++++++++++++
 .../initramfs-etc-overlay-hook_0.1.bb         |  3 +++
 2 files changed, 28 insertions(+)
 create mode 100644 recipes-initramfs/initramfs-etc-overlay-hook/files/etc-overlay.hook

diff --git a/recipes-initramfs/initramfs-etc-overlay-hook/files/etc-overlay.hook b/recipes-initramfs/initramfs-etc-overlay-hook/files/etc-overlay.hook
new file mode 100644
index 0000000..bfaa7b6
--- /dev/null
+++ b/recipes-initramfs/initramfs-etc-overlay-hook/files/etc-overlay.hook
@@ -0,0 +1,25 @@
+#!/bin/sh
+#
+# CIP Core, generic profile
+#
+# Copyright (c) Siemens AG, 2022
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
+manual_add_modules overlay
diff --git a/recipes-initramfs/initramfs-etc-overlay-hook/initramfs-etc-overlay-hook_0.1.bb b/recipes-initramfs/initramfs-etc-overlay-hook/initramfs-etc-overlay-hook_0.1.bb
index 19e9261..37a04ec 100644
--- a/recipes-initramfs/initramfs-etc-overlay-hook/initramfs-etc-overlay-hook_0.1.bb
+++ b/recipes-initramfs/initramfs-etc-overlay-hook/initramfs-etc-overlay-hook_0.1.bb
@@ -12,6 +12,7 @@
 inherit dpkg-raw
 
 SRC_URI += " \
+    file://etc-overlay.hook \
     file://etc-overlay.script \
     "
 
@@ -22,6 +23,8 @@ do_install[cleandirs] += " \
     ${D}/usr/share/initramfs-tools/scripts/local-bottom"
 
 do_install() {
+    install -m 0755 "${WORKDIR}/etc-overlay.hook" \
+        "${D}/usr/share/initramfs-tools/hooks/etc-overlay"
     install -m 0755 "${WORKDIR}/etc-overlay.script" \
         "${D}/usr/share/initramfs-tools/scripts/local-bottom/etc-overlay"
 }
-- 
2.34.1


