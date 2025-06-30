Return-Path: <alexander.heinisch@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08FF0C83035
	for <webhook@archiver.kernel.org>; Mon, 30 Jun 2025 18:15:42 +0000 (UTC)
Received: from mta-65-225.siemens.flowmailer.net (mta-65-225.siemens.flowmailer.net [185.136.65.225])
 by mx.groups.io with SMTP id smtpd.web10.48077.1751307333401539140
 for <cip-dev@lists.cip-project.org>;
 Mon, 30 Jun 2025 11:15:35 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=alexander.heinisch@siemens.com header.s=fm1 header.b=hL9NcjIN;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.65.225, mailfrom: fm-1330684-20250630181527a127212381e8a381fe-v9vfvt@rts-flowmailer.siemens.com)
Received: by mta-65-225.siemens.flowmailer.net with ESMTPSA id 20250630181527a127212381e8a381fe
        for <cip-dev@lists.cip-project.org>;
        Mon, 30 Jun 2025 20:15:27 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=alexander.heinisch@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=X3sZO5/zB8b3yMYe7aRShiyzZw12abfdX6QbOMU2Z6I=;
 b=hL9NcjINBn/uJjhCD+211pIP62lby2xBcQD2cCAyKkqMRk9vBPMO619imcWDqRqSA91i6a
 MjsIJVnTO1oIw6kHguW73skCEWPkO5vGgc2xDw69+EspQqNuSlN2vKOxW952kl5L/FD0s2zZ
 Tbycty8Uk4C/2FYmUzptF6rf2BQdR6mEUZjy1HPKfuMmo5bVZ8lRtu2q/+zb1ltAXTqu+eVR
 nG8Fm5vuD32O1qf4U1fdWjdlrfVvvorfMj3GaY9R4y8YhwjI5lh227JOG4yDhfYn/M9YJFQs
 UwIdoa5S39yczyjvJpLZdHfpr7n2l0rfwIjBaLWCg+QdZBwhzYpvlOZA==;
From: alexander.heinisch@siemens.com
To: cip-dev@lists.cip-project.org
Cc: jan.kiszka@siemens.com,
	quirin.gylstorff@siemens.com,
	felix.moessbauer@siemens.com,
	Alexander Heinisch <alexander.heinisch@siemens.com>
Subject: [isar-cip-core][RFC 4/7] kconfig: Add option to remove /etc overlay and make /etc ro.
Date: Mon, 30 Jun 2025 20:15:13 +0200
Message-Id: <20250630181516.1718712-5-alexander.heinisch@siemens.com>
In-Reply-To: <20250630181516.1718712-1-alexander.heinisch@siemens.com>
References: <20250630181516.1718712-1-alexander.heinisch@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-1330684:519-21489:flowmailer
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 30 Jun 2025 18:15:42 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/19265

From: Alexander Heinisch <alexander.heinisch@siemens.com>

Signed-off-by: Alexander Heinisch <alexander.heinisch@siemens.com>
---
 Kconfig                  | 11 +++++++++++
 kas/opt/readonly-etc.yml | 17 +++++++++++++++++
 2 files changed, 28 insertions(+)
 create mode 100644 kas/opt/readonly-etc.yml

diff --git a/Kconfig b/Kconfig
index 582cedd..e1bfd1f 100644
--- a/Kconfig
+++ b/Kconfig
@@ -272,6 +272,17 @@ config SEPARATE_HOME_PARTITION
 	  This adds a separate home partition to the build image instead of moving
 	  home to the var partition.
 
+
+config IMAGE_READONLY_ETC
+	bool "Readonly /etc"
+	help
+	  Does not overlay /etc. This makes system config stored on /etc immutable 
+	  and addes special treatment for /etc/machine-id.
+
+config KAS_INCLUDE_READONLY_ETC
+	string
+	default "kas/opt/readonly-etc.yml" if IMAGE_READONLY_ETC
+
 config KAS_INCLUDE_DATA_ENCRYPTION
 	string
 	default "kas/opt/encrypt-data.yml" if IMAGE_DATA_ENCRYPTION
diff --git a/kas/opt/readonly-etc.yml b/kas/opt/readonly-etc.yml
new file mode 100644
index 0000000..c333c32
--- /dev/null
+++ b/kas/opt/readonly-etc.yml
@@ -0,0 +1,17 @@
+#
+# CIP Core, generic profile
+#
+# Copyright (c) Siemens AG, 2025
+#
+# Authors:
+#  Alexander Heinisch <alexander.heinisch@siemens.com>
+#
+# SPDX-License-Identifier: MIT
+#
+
+header:
+  version: 14
+
+local_conf_header:
+  no_overlay: |
+    INITRAMFS_OVERLAY_PATHS:remove = "/etc"
-- 
2.39.5


