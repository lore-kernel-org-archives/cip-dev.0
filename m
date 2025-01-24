Return-Path: <quirin.gylstorff@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CCA24C0218B
	for <webhook@archiver.kernel.org>; Fri, 24 Jan 2025 08:07:10 +0000 (UTC)
Received: from mta-65-225.siemens.flowmailer.net (mta-65-225.siemens.flowmailer.net [185.136.65.225])
 by mx.groups.io with SMTP id smtpd.web10.6954.1737706022631775362
 for <cip-dev@lists.cip-project.org>;
 Fri, 24 Jan 2025 00:07:03 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=Quirin.Gylstorff@siemens.com header.s=fm2 header.b=JVKkxvo9;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.65.225, mailfrom: fm-51332-20250124080700fca1d7833a0521ebc9-ggkxxd@rts-flowmailer.siemens.com)
Received: by mta-65-225.siemens.flowmailer.net with ESMTPSA id 20250124080700fca1d7833a0521ebc9
        for <cip-dev@lists.cip-project.org>;
        Fri, 24 Jan 2025 09:07:00 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm2;
 d=siemens.com; i=Quirin.Gylstorff@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:References:In-Reply-To;
 bh=9+nPxDoi/CJE4WX2zcwWT48EokYnKMKJwAKISLG9KDY=;
 b=JVKkxvo9d4+Sqky0yOntmatFp2uFAMNucT8foXmMsrxdN31WxeRL9S6qHDWQB9YBPK+wbh
 ymfXGzmbl5k2GNmB9GczlSmt2vCXL/BwVQEY3JzCG9PxTh/orEGmft6moXALOs56up2xZLYJ
 pcWhQ2oOzZJ0+HB4YfzCeatKzj1oZ9YVyeffZcr43J67mkWS/EKU7j85vIi9W34tszHr1Her
 5JbKYQOxBH1rZqfnGVBha7qFQFMWMDLwDY0oOxKSVgSpQv6P52XJjvqopqfAEMPW2OaN9pzE
 RThwTSMX9h9ZbYx6OLrXYciQ6LR00xK6Ebnq6ETcu53j1Y9YbvcMybPQ==;
From: Quirin Gylstorff <Quirin.Gylstorff@siemens.com>
To: Sai.Sathujoda@toshiba-tsip.com,
	jan.kiszka@siemens.com,
	cip-dev@lists.cip-project.org
Subject: [cip-dev][isar-cip-core][PATCH 2/3] x86-uefi: disable watchdog for testing on mcom
Date: Fri, 24 Jan 2025 09:06:26 +0100
Message-ID: <20250124080659.469424-3-Quirin.Gylstorff@siemens.com>
In-Reply-To: <20250124080659.469424-1-Quirin.Gylstorff@siemens.com>
References: <20250124080659.469424-1-Quirin.Gylstorff@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-51332:519-21489:flowmailer
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 24 Jan 2025 08:07:10 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/17616

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
index 42e247d..97ef031 100644
--- a/.gitlab-ci.yml
+++ b/.gitlab-ci.yml
@@ -64,6 +64,7 @@ default:
     - if [ "${release}" = "bookworm" ]; then base_yaml="${base_yaml}:kas/opt/bookworm.yml"; fi
     - if [ "${release}" = "trixie" ]; then base_yaml="${base_yaml}:kas/opt/trixie.yml"; fi
     - if [ "${encrypt}" = "enable" ]; then base_yaml="${base_yaml}:kas/opt/encrypt-data.yml"; fi
+    - if [ "${disable_watchdog}" = "enable" ]; then base_yaml="${base_yaml}:kas/opt/disable-watchdog.yml"; fi
     - if [ "${swupdate_version}" = "2022.12" ]; then base_yaml="${base_yaml}:kas/opt/swupdate-2022.12.yaml"; fi
     - echo "Building ${base_yaml}"
     - kas build ${base_yaml}
@@ -250,6 +251,7 @@ build:x86-uefi-secure-boot:
     use_rt: disable
     targz: disable
     encrypt: disable
+    disable_watchdog: enable
 
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


