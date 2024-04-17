Return-Path: <srinuvasan.a@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10121C30658
	for <webhook@archiver.kernel.org>; Tue,  2 Jul 2024 15:34:00 +0000 (UTC)
Received: from mta-64-228.siemens.flowmailer.net (mta-64-228.siemens.flowmailer.net [185.136.64.228])
 by mx.groups.io with SMTP id smtpd.web10.27511.1719934433752757739
 for <cip-dev@lists.cip-project.org>;
 Tue, 02 Jul 2024 08:33:54 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=srinuvasan.a@siemens.com header.s=fm2 header.b=lPvo3FD6;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.64.228, mailfrom: fm-1324425-2024070215335002e38d8437c2b6acbf-hrwm2s@rts-flowmailer.siemens.com)
Received: by mta-64-228.siemens.flowmailer.net with ESMTPSA id 2024070215335002e38d8437c2b6acbf
        for <cip-dev@lists.cip-project.org>;
        Tue, 02 Jul 2024 17:33:51 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm2;
 d=siemens.com; i=srinuvasan.a@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=qZfZgyzZdw83+CgAd+ipW8QPBG5d24/4mZpHn+OR1l8=;
 b=lPvo3FD6L2eO9gTxhN79A89jUFm7XjEFsafYJEZuRdK9bxw2dWLYHSSOtO/rKIoT02WWSn
 ER219eZ7Jl5wmFvmjAMleQXaq4Ju7F75CS6ZH02AbnsuzHC9PbP4X5rRTXa8Ip30kNGd1ErX
 vSqr0Yqzx3W5vGVCGTnmWkKlMDo4A=;
From: srinuvasan.a@siemens.com
To: cip-dev@lists.cip-project.org
Cc: jan.kiszka@siemens.com,
	Srinuvasan A <srinuvasan.a@siemens.com>
Subject: [isar-cip-core][PATCH v2] kas/opt/expand-on-first-boot.yml: add an optional expand-on-first-boot
Date: Wed, 17 Apr 2024 21:07:12 +0530
Message-Id: <20240417153712.104378-1-srinuvasan.a@siemens.com>
In-Reply-To: <1d3cd14c-24a1-47cb-b48c-b9a711491702@siemens.com>
References: <1d3cd14c-24a1-47cb-b48c-b9a711491702@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-1324425:519-21489:flowmailer
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 02 Jul 2024 15:34:00 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/16362

From: Srinuvasan A <srinuvasan.a@siemens.com>

Add expand-on-first-boot package as an optional file, this would be
helpful to understand/debug the expand-on-first boot specifically w.r.t
LUKS support, this systemd service expands the last partition on a the
boot medium to the full size of that medium and then deactivates itself.

Signed-off-by: Srinuvasan A <srinuvasan.a@siemens.com>
---
 Kconfig                          |  9 +++++++++
 kas/opt/expand-on-first-boot.yml | 17 +++++++++++++++++
 2 files changed, 26 insertions(+)
 create mode 100644 kas/opt/expand-on-first-boot.yml

diff --git a/Kconfig b/Kconfig
index 96f590a..ec7c686 100644
--- a/Kconfig
+++ b/Kconfig
@@ -151,6 +151,15 @@ config KAS_INCLUDE_DEBIAN
 
 comment "Image features"
 
+config EXPAND_ON_FIRST_BOOT
+        bool "expand-on-first-boot"
+        default n
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


