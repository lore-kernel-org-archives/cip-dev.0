Return-Path: <alexander.heinisch@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15204C83033
	for <webhook@archiver.kernel.org>; Mon, 30 Jun 2025 18:15:42 +0000 (UTC)
Received: from mta-65-225.siemens.flowmailer.net (mta-65-225.siemens.flowmailer.net [185.136.65.225])
 by mx.groups.io with SMTP id smtpd.web10.48076.1751307332309479940
 for <cip-dev@lists.cip-project.org>;
 Mon, 30 Jun 2025 11:15:32 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=alexander.heinisch@siemens.com header.s=fm1 header.b=nVqh+CVx;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.65.225, mailfrom: fm-1330684-2025063018152905ad5ebb7d99e7b59e-7civ9k@rts-flowmailer.siemens.com)
Received: by mta-65-225.siemens.flowmailer.net with ESMTPSA id 2025063018152905ad5ebb7d99e7b59e
        for <cip-dev@lists.cip-project.org>;
        Mon, 30 Jun 2025 20:15:29 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=alexander.heinisch@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=Xup7gDm/UyLXlKS8DaF249BfI4vVNiXJINWjQDm6Pjs=;
 b=nVqh+CVxjdW1ZYmIK0bCw7gFt/IBd2n1I9SxFyVNcGgwWZixGX0ToQgIOvfw9K1n8VKrR1
 pbxX1jd/WdsKmPIhCkE3LJAPh5gVcWl5Tg9dif1qg/mjMe1I1vgaHLEfY+41hI3kN2fatIVY
 r/2/7QbhVmcTrRLsNn6Ye/0722Xvo8brWhKdMmTDtE9an3eYYaSxD8cTDDRhSbuLoKs5X1Zg
 zBq0259kYaaWZ+fHo0YH/hs5ms6PSyO3Z1qHiMFe+TojooamADcRsnBhOfg77DWEcOP/flkL
 7IIwICpYLMlCLiZwl/V4P4xavd7eREWh6fzzqFMBVM7bV/4F/7iNITWQ==;
From: alexander.heinisch@siemens.com
To: cip-dev@lists.cip-project.org
Cc: jan.kiszka@siemens.com,
	quirin.gylstorff@siemens.com,
	felix.moessbauer@siemens.com,
	Alexander Heinisch <alexander.heinisch@siemens.com>
Subject: [isar-cip-core][RFC 7/7] Added recipe to demo a mutable config setup on /etc with ro /etc
Date: Mon, 30 Jun 2025 20:15:16 +0200
Message-Id: <20250630181516.1718712-8-alexander.heinisch@siemens.com>
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
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/19263

From: Alexander Heinisch <alexander.heinisch@siemens.com>

Signed-off-by: Alexander Heinisch <alexander.heinisch@siemens.com>
---
 kas/opt/config-on-var-demo.yml                | 17 ++++++++++
 .../config-on-var/config-on-var-demo.bb       | 31 +++++++++++++++++++
 .../files/90-demo-app-config.conf             |  5 +++
 .../config-on-var/files/initial-config.yml    |  1 +
 4 files changed, 54 insertions(+)
 create mode 100644 kas/opt/config-on-var-demo.yml
 create mode 100644 recipes-demo/config-on-var/config-on-var-demo.bb
 create mode 100644 recipes-demo/config-on-var/files/90-demo-app-config.conf
 create mode 100644 recipes-demo/config-on-var/files/initial-config.yml

diff --git a/kas/opt/config-on-var-demo.yml b/kas/opt/config-on-var-demo.yml
new file mode 100644
index 0000000..f1ab04a
--- /dev/null
+++ b/kas/opt/config-on-var-demo.yml
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
+  package-config-on-var-demo: |
+    IMAGE_INSTALL:append = " config-on-var-demo"
diff --git a/recipes-demo/config-on-var/config-on-var-demo.bb b/recipes-demo/config-on-var/config-on-var-demo.bb
new file mode 100644
index 0000000..d0d17fc
--- /dev/null
+++ b/recipes-demo/config-on-var/config-on-var-demo.bb
@@ -0,0 +1,31 @@
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
+inherit dpkg-raw
+
+DESCRIPTION = "Persist config on /var/mutable."
+MAINTAINER = "Alexander Heinisch <alexander.heinisch@siemens.com>"
+
+SRC_URI = " \
+    file://initial-config.yml \
+    file://90-demo-app-config.conf \
+    "
+
+do_install[cleandirs] = " \
+    ${D}/etc/tmpfiles.d \
+    ${D}/usr/share/factory/demo-app/ \
+    "
+
+do_install() {
+    install -v -m 644 ${WORKDIR}/90-demo-app-config.conf ${D}/etc/tmpfiles.d/
+
+    install -v -m 640 ${WORKDIR}/initial-config.yml ${D}/usr/share/factory/demo-app/
+}
diff --git a/recipes-demo/config-on-var/files/90-demo-app-config.conf b/recipes-demo/config-on-var/files/90-demo-app-config.conf
new file mode 100644
index 0000000..0021cdd
--- /dev/null
+++ b/recipes-demo/config-on-var/files/90-demo-app-config.conf
@@ -0,0 +1,5 @@
+# create files and directories if don't exist with initial / factory content
+C /var/mutable/demo-app/config.yml    0644 - - - /usr/share/factory/demo-app/initial-config.yml
+
+# create link to mutable config file
+L /etc/demo-app/config.yml            -    - - - /var/mutable/demo-app/config.yml
diff --git a/recipes-demo/config-on-var/files/initial-config.yml b/recipes-demo/config-on-var/files/initial-config.yml
new file mode 100644
index 0000000..a575f55
--- /dev/null
+++ b/recipes-demo/config-on-var/files/initial-config.yml
@@ -0,0 +1 @@
+# this file contains initial default config used for demo-app
-- 
2.39.5


