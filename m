Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3322BC54F47
	for <webhook@archiver.kernel.org>; Fri, 23 May 2025 14:48:01 +0000 (UTC)
Received: from mta-65-227.siemens.flowmailer.net (mta-65-227.siemens.flowmailer.net [185.136.65.227])
 by mx.groups.io with SMTP id smtpd.web10.49810.1748011672238080513
 for <cip-dev@lists.cip-project.org>;
 Fri, 23 May 2025 07:47:53 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=jan.kiszka@siemens.com header.s=fm1 header.b=KKKI0TXj;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.65.227, mailfrom: fm-294854-20250523144748e576e40d5fec582a81-6el0fs@rts-flowmailer.siemens.com)
Received: by mta-65-227.siemens.flowmailer.net with ESMTPSA id 20250523144748e576e40d5fec582a81
        for <cip-dev@lists.cip-project.org>;
        Fri, 23 May 2025 16:47:49 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=jan.kiszka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=ERRthGOhCniRMA/EDeiLYbTUe5iWS008L5Nqg7X+aV8=;
 b=KKKI0TXjz6OpF8K4LfXx0EyjYFCwtbktXu9sGGSC/8aiHaWJ94hPZT3fgKYzXgLO4lG8MP
 e19je2tyx3Zn1z655ebqAfTIgvCZleK/Pzhytyf9icQxACr0R9vgKTlucumolh9+2bCoz0du
 G7zEkgHukirjjFNHWFlnqtGoYNYcwNPH4P79KMursglIIfA7EOv9kqEBwXep9xsmCjFL8GsK
 YcpGNqqCEDShBykx5iAeT+KoanE6zz7/o71BONuu2sPD/nASA5Djl2Z5sNq+cdnAXuTP4AY7
 9gvaBMFn2OsiK20Pwy/DSG6d5ztKbMeFuHdCxE7Bg6vmom9KwbOv0X5Q==;
From: Jan Kiszka <jan.kiszka@siemens.com>
To: cip-dev@lists.cip-project.org
Cc: Sai Sree Kartheek Adivi <s-adivi@ti.com>
Subject: [isar-cip-core][PATCH v2 3/5] Expose kernel branch head recipes via kas option and Kconfig
Date: Fri, 23 May 2025 16:47:45 +0200
Message-ID: <5f42c016426fb5ce955c4eae42a9fbc0c041c8c5.1748011667.git.jan.kiszka@siemens.com>
In-Reply-To: <cover.1748011667.git.jan.kiszka@siemens.com>
References: <cover.1748011667.git.jan.kiszka@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-294854:519-21489:flowmailer
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 23 May 2025 14:48:01 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/18949

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


