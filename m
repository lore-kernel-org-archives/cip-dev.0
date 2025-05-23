Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92A5FC54ED0
	for <webhook@archiver.kernel.org>; Fri, 23 May 2025 13:25:10 +0000 (UTC)
Received: from mta-64-228.siemens.flowmailer.net (mta-64-228.siemens.flowmailer.net [185.136.64.228])
 by mx.groups.io with SMTP id smtpd.web10.47932.1748006706531901068
 for <cip-dev@lists.cip-project.org>;
 Fri, 23 May 2025 06:25:07 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=jan.kiszka@siemens.com header.s=fm1 header.b=NX50eNF0;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.64.228, mailfrom: fm-294854-20250523132503cc5d44ed36671922e0-h88kkt@rts-flowmailer.siemens.com)
Received: by mta-64-228.siemens.flowmailer.net with ESMTPSA id 20250523132503cc5d44ed36671922e0
        for <cip-dev@lists.cip-project.org>;
        Fri, 23 May 2025 15:25:04 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=jan.kiszka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:References:In-Reply-To;
 bh=ERRthGOhCniRMA/EDeiLYbTUe5iWS008L5Nqg7X+aV8=;
 b=NX50eNF0tf+ycQzgPJSpCAtWKTktr7hR6tdVoj4DKTePqaCH5ssk3crjUERyd0LrsFRfVU
 dM5gTx1jTkSC57mrHEx+7kMhjE2gpgVYkLaZ0k+Sp5Ey9tsLaqTk1zNYfB3IxGNfqJfuDbNT
 UKJ2KOu68oQdi9PPbwUQMmutAzIUQGS8keL54Ij0VkrqSFnsNjEDI6wLl1XFIkEtiZkvCkdx
 WJwy8TFj28w3vkY9wpushPmdP3ytHato3wJSdSu5CpuyZ2/ZybS5k9Ik1HcRjbJb8ed4nOpN
 MlEHbXGdmrCcVpNUh3VuYg9/bBoNMjIxIvv/DNEvyP7nUbQMDGR4vhkA==;
From: Jan Kiszka <jan.kiszka@siemens.com>
To: cip-dev@lists.cip-project.org
Subject: [isar-cip-core][PATCH 3/3] Expose kernel branch head recipes via kas option and Kconfig
Date: Fri, 23 May 2025 15:25:02 +0200
Message-ID: <e4be8285c556c38f3107d2424d2f5eb7bbdad685.1748006702.git.jan.kiszka@siemens.com>
In-Reply-To: <cover.1748006702.git.jan.kiszka@siemens.com>
References: <cover.1748006702.git.jan.kiszka@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-294854:519-21489:flowmailer
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 23 May 2025 13:25:10 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/18942

From: Jan Kiszka <jan.kiszka@siemens.com>

The kas option file adjusts the PREFERRED_VERSION for the CIP kernel so
that the corresponding head recipe is selected. This avoids having to
define an option for each kernel version series.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 Kconfig                 | 11 +++++++++++
 kas/opt/kernel-head.yml | 18 ++++++++++++++++++
 2 files changed, 29 insertions(+)
 create mode 100644 kas/opt/kernel-head.yml

diff --git a/Kconfig b/Kconfig
index 0887125a..18560292 100644
--- a/Kconfig
+++ b/Kconfig
@@ -113,6 +113,17 @@ config KAS_INCLUDE_KERNEL
 	default "kas/opt/6.1.yml" if KERNEL_6_1
 	default "kas/opt/6.12.yml" if KERNEL_6_12
 
+config KERNEL_HEAD
+	bool "Head of selected CIP kernel branch"
+	help
+	  Build head of the git branch that corresponds to the selected CIP
+	  kernel. May point to an unreleased state.
+
+config KAS_INCLUDE_KERNEL_HEAD
+	string
+	default "kas/opt/kernel-head.yml"
+	depends on KERNEL_HEAD
+
 config KERNEL_RT
 	bool "Real-time CIP kernel"
 	depends on !ARCH_RISCV64 || KERNEL_6_12
diff --git a/kas/opt/kernel-head.yml b/kas/opt/kernel-head.yml
new file mode 100644
index 00000000..abb4d624
--- /dev/null
+++ b/kas/opt/kernel-head.yml
@@ -0,0 +1,18 @@
+#
+# CIP Core, generic profile
+#
+# Copyright (c) Siemens, 2025
+#
+# Authors:
+#  Jan Kiszka <jan.kiszka@siemens.com>
+#
+# SPDX-License-Identifier: MIT
+#
+
+header:
+  version: 14
+
+local_conf_header:
+  kernel-version-head: |
+    PREFERRED_VERSION_linux-cip := "${@d.getVar('PREFERRED_VERSION_linux-cip').rsplit('.', 1)[0] + '-cip-head%'}"
+    PREFERRED_VERSION_linux-cip-rt := "${@d.getVar('PREFERRED_VERSION_linux-cip-rt').rsplit('.', 1)[0] + '-cip-head%'}"
-- 
2.43.0


