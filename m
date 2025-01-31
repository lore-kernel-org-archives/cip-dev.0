Return-Path: <quirin.gylstorff@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26F04C02197
	for <webhook@archiver.kernel.org>; Fri, 31 Jan 2025 15:26:02 +0000 (UTC)
Received: from mta-64-228.siemens.flowmailer.net (mta-64-228.siemens.flowmailer.net [185.136.64.228])
 by mx.groups.io with SMTP id smtpd.web11.21433.1738337157618820253
 for <cip-dev@lists.cip-project.org>;
 Fri, 31 Jan 2025 07:25:58 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=Quirin.Gylstorff@siemens.com header.s=fm2 header.b=eP5fHp89;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.64.228, mailfrom: fm-51332-20250131152554cd99033b46a12a5b9c-_zrnso@rts-flowmailer.siemens.com)
Received: by mta-64-228.siemens.flowmailer.net with ESMTPSA id 20250131152554cd99033b46a12a5b9c
        for <cip-dev@lists.cip-project.org>;
        Fri, 31 Jan 2025 16:25:54 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm2;
 d=siemens.com; i=Quirin.Gylstorff@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:References:In-Reply-To;
 bh=Q+S201mhAEUPBZfjACdSvJT0NeD5q36GsHomf3PUBE4=;
 b=eP5fHp89sf5yIfQVwK9qy6rYTKptAWrvm7M+yOKPkJ3PtGZ133it8nNX1tfGh1s9HKBIIx
 361FTQcY+B2iyTuqOpvgHJLeseEg6DP6gRCnhUtOertQExn4gy0zTrmgO5rCGLbXZK97xHi1
 Sa3jjUjFiSl50YBY5SsBjNceDqJfX3AeK+lXuWVzcuNkRwbofBDv/S6k2PuEy1aeT2EgxBdy
 gJl6oMcFFxecJUMPsVoYjhzNpsJtbXwyDDboEn0p48vd5EwL0NylYxNFXwRxCIGPYXOrGNap
 cyIs6JXzdNQ/Rzrex7yGcThXI8/4MdBDIcOBbmthpfl13gLwYPHV9HHw==;
From: Quirin Gylstorff <Quirin.Gylstorff@siemens.com>
To: Sai.Sathujoda@toshiba-tsip.com,
	jan.kiszka@siemens.com,
	cip-dev@lists.cip-project.org
Subject: [cip-dev][isar-cip-core][PATCH v3 2/4] x86-uefi: disable watchdog for testing on mcom
Date: Fri, 31 Jan 2025 16:25:30 +0100
Message-ID: <20250131152553.270393-3-Quirin.Gylstorff@siemens.com>
In-Reply-To: <20250131152553.270393-1-Quirin.Gylstorff@siemens.com>
References: <20250131152553.270393-1-Quirin.Gylstorff@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-51332:519-21489:flowmailer
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 31 Jan 2025 15:26:02 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/17722

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
index c44cf8e..dd4baf4 100644
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
@@ -249,6 +250,7 @@ build:x86-uefi-secure-boot:
     extension: security
     use_rt: disable
     targz: disable
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


