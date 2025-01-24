Return-Path: <quirin.gylstorff@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B4DEC0218C
	for <webhook@archiver.kernel.org>; Fri, 24 Jan 2025 13:22:53 +0000 (UTC)
Received: from mta-64-226.siemens.flowmailer.net (mta-64-226.siemens.flowmailer.net [185.136.64.226])
 by mx.groups.io with SMTP id smtpd.web10.11708.1737724970328834013
 for <cip-dev@lists.cip-project.org>;
 Fri, 24 Jan 2025 05:22:51 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=Quirin.Gylstorff@siemens.com header.s=fm2 header.b=bABtjGT1;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.64.226, mailfrom: fm-51332-20250124132247de25fc1bba761b294c-1o85fm@rts-flowmailer.siemens.com)
Received: by mta-64-226.siemens.flowmailer.net with ESMTPSA id 20250124132247de25fc1bba761b294c
        for <cip-dev@lists.cip-project.org>;
        Fri, 24 Jan 2025 14:22:47 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm2;
 d=siemens.com; i=Quirin.Gylstorff@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:References:In-Reply-To;
 bh=7e0uEODWrFUwl9U1/6XANRfw491QZF2ZgjNAqy1l8Os=;
 b=bABtjGT1qfTG60Jvx1M5BfjVkSJjJYoF/aMSqPGpwWK0xc1YTYLtN3tQ369Pgma+wwbx0w
 dDRrU5QxvjiVFZ+W9D1eDLgUnlMRBxo0K158SJXmIYpRH2fw8rtYF4q6sidxfZyp+IATRGEp
 /7lDn9wYwOgqB2/m1QEz74KHiqL2qC6Al1/7l1dOaEKDbVpIUPOLg+HDDnc02Wdb7D9Lee/r
 pN8ahdGI7NdwwDpnsxjuA1v1ydJV8fyDFnwqgLJ7AJF798OBdg6iO2H9Nmm3NODmCKzEz9Xq
 BD5w3NKcw5ks1t1lqkBu+lEWg3pnpW0nQ71Ouu/53HWIUlmHsZPy7KFg==;
From: Quirin Gylstorff <Quirin.Gylstorff@siemens.com>
To: Sai.Sathujoda@toshiba-tsip.com,
	jan.kiszka@siemens.com,
	cip-dev@lists.cip-project.org
Subject: [cip-dev][isar-cip-core][PATCH v2 2/3] x86-uefi: disable watchdog for testing on mcom
Date: Fri, 24 Jan 2025 14:22:20 +0100
Message-ID: <20250124132246.64738-3-Quirin.Gylstorff@siemens.com>
In-Reply-To: <20250124132246.64738-1-Quirin.Gylstorff@siemens.com>
References: <20250124132246.64738-1-Quirin.Gylstorff@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-51332:519-21489:flowmailer
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 24 Jan 2025 13:22:53 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/17656

From: Quirin Gylstorff <quirin.gylstorff@siemens.com>

Due to the multiple watchdogs available on the mcom
device efibootguard select the iTCO watchdog and the
Linux kernel selects the WDAT watchdog which leads to
an system reboot during booting as the Linux kernel no
longer drives the iTCO watchdog.

Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
---
 .gitlab-ci.yml               |  2 ++
 kas/opt/disable-watchdog.yml | 15 +++++++++++++++
 2 files changed, 17 insertions(+)
 create mode 100644 kas/opt/disable-watchdog.yml

diff --git a/.gitlab-ci.yml b/.gitlab-ci.yml
index 42e247d..686ce48 100644
--- a/.gitlab-ci.yml
+++ b/.gitlab-ci.yml
@@ -64,6 +64,7 @@ default:
     - if [ "${release}" = "bookworm" ]; then base_yaml="${base_yaml}:kas/opt/bookworm.yml"; fi
     - if [ "${release}" = "trixie" ]; then base_yaml="${base_yaml}:kas/opt/trixie.yml"; fi
     - if [ "${encrypt}" = "enable" ]; then base_yaml="${base_yaml}:kas/opt/encrypt-data.yml"; fi
+    - if [ "${watchdog}" = "disable" ]; then base_yaml="${base_yaml}:kas/opt/disable-watchdog.yml"; fi
     - if [ "${swupdate_version}" = "2022.12" ]; then base_yaml="${base_yaml}:kas/opt/swupdate-2022.12.yaml"; fi
     - echo "Building ${base_yaml}"
     - kas build ${base_yaml}
@@ -250,6 +251,7 @@ build:x86-uefi-secure-boot:
     use_rt: disable
     targz: disable
     encrypt: disable
+    watchdog: disable
 
 build:qemu-amd64-swupdate:
   extends:
diff --git a/kas/opt/disable-watchdog.yml b/kas/opt/disable-watchdog.yml
new file mode 100644
index 0000000..88ece6b
--- /dev/null
+++ b/kas/opt/disable-watchdog.yml
@@ -0,0 +1,15 @@
+#
+# Copyright (c) Siemens AG, 2025
+#
+# Authors:
+#  Quirin Gylstorff <quirin.gylstorff@siemens.com>
+#
+# SPDX-License-Identifier: MIT
+#
+
+header:
+  version: 14
+
+local_conf_header:
+  no-watchdog: |
+    WDOG_TIMEOUT = "0"
-- 
2.47.0


