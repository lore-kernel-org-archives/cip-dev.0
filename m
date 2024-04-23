Return-Path: <srinuvasan.a@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AEBE6C3271E
	for <webhook@archiver.kernel.org>; Mon,  8 Jul 2024 14:50:48 +0000 (UTC)
Received: from mta-64-226.siemens.flowmailer.net (mta-64-226.siemens.flowmailer.net [185.136.64.226])
 by mx.groups.io with SMTP id smtpd.web10.81771.1720450247111192303
 for <cip-dev@lists.cip-project.org>;
 Mon, 08 Jul 2024 07:50:48 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=srinuvasan.a@siemens.com header.s=fm2 header.b=VeqnfGKJ;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.64.226, mailfrom: fm-1324425-20240708145043adb558aaaa2df168b7-bvnn9p@rts-flowmailer.siemens.com)
Received: by mta-64-226.siemens.flowmailer.net with ESMTPSA id 20240708145043adb558aaaa2df168b7
        for <cip-dev@lists.cip-project.org>;
        Mon, 08 Jul 2024 16:50:43 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm2;
 d=siemens.com; i=srinuvasan.a@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=t6lTjJ0RGCyYZn2AzKvMcdgXT/D3wh+GzVkMNnEQQwo=;
 b=VeqnfGKJ1FgsIA4xu4a5BBbZpTQAKfCJJnJX0ABJk7oli35HH298qJhizGUW96v2ykdkli
 /MDYLu+koDCSDD6POCvfugP6GBkq/VcwZE9iiK6exDfTfIEZ5Zji8ik49lqmUP90jRcubjN0
 E91DWUvJdKSMvgvj4gJTD++dcioYU=;
From: srinuvasan.a@siemens.com
To: cip-dev@lists.cip-project.org
Cc: jan.kiszka@siemens.com,
	Srinuvasan A <srinuvasan.a@siemens.com>
Subject: [isar-cip-core][PATCH v3] kas/opt/expand-on-first-boot.yml: add an optional expand-on-first-boot
Date: Tue, 23 Apr 2024 20:24:09 +0530
Message-Id: <20240423145409.175324-1-srinuvasan.a@siemens.com>
In-Reply-To: <a77eabfa-9ed7-4787-8c77-46782aacafa2@siemens.com>
References: <a77eabfa-9ed7-4787-8c77-46782aacafa2@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-1324425:519-21489:flowmailer
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 08 Jul 2024 14:50:48 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/16435

From: Srinuvasan A <srinuvasan.a@siemens.com>

Add expand-on-first-boot package as an optional file, this would be
helpful to understand/debug the expand-on-first boot specifically w.r.t
LUKS support, this systemd service expands the last partition on the
boot medium to the full size of that medium and then deactivates itself.

Signed-off-by: Srinuvasan A <srinuvasan.a@siemens.com>
---
 Kconfig                          |  8 ++++++++
 kas/opt/expand-on-first-boot.yml | 17 +++++++++++++++++
 2 files changed, 25 insertions(+)
 create mode 100644 kas/opt/expand-on-first-boot.yml

diff --git a/Kconfig b/Kconfig
index 96f590a..282fecd 100644
--- a/Kconfig
+++ b/Kconfig
@@ -151,6 +151,14 @@ config KAS_INCLUDE_DEBIAN
 
 comment "Image features"
 
+config EXPAND_ON_FIRST_BOOT
+        bool "Grow last partition to full medium during first boot"
+
+config KAS_INCLUDE_EXPAND_ON_FIRST_BOOT
+        string
+        default "kas/opt/expand-on-first-boot.yml"
+        depends on EXPAND_ON_FIRST_BOOT
+
 config IMAGE_TESTING
 	bool "Test extensions"
 
diff --git a/kas/opt/expand-on-first-boot.yml b/kas/opt/expand-on-first-boot.yml
new file mode 100644
index 0000000..03d666b
--- /dev/null
+++ b/kas/opt/expand-on-first-boot.yml
@@ -0,0 +1,17 @@
+#
+# CIP Core, generic profile
+#
+# Copyright (c) Siemens AG, 2024
+#
+# Authors:
+#  Srinuvasan Arjunan <srinuvasan.a@siemens.com>
+#
+# SPDX-License-Identifier: MIT
+#
+
+header:
+  version: 14
+
+local_conf_header:
+  package-expand-on-first-boot: |
+    IMAGE_INSTALL:append = " expand-on-first-boot"
-- 
2.34.1


