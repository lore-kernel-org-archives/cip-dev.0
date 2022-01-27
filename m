Return-Path: <Shivanand.Kunijadar@toshiba-tsip.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09A99C433EF
	for <webhook@archiver.kernel.org>; Thu, 27 Jan 2022 14:25:38 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.158])
 by mx.groups.io with SMTP id smtpd.web12.28624.1643293535688109702
 for <cip-dev@lists.cip-project.org>;
 Thu, 27 Jan 2022 06:25:36 -0800
Authentication-Results: mx.groups.io;
 dkim=missing;
 spf=pass (domain: toshiba-tsip.com, ip: 210.130.202.158,
 mailfrom: shivanand.kunijadar@toshiba-tsip.com)
Received: by mo-csw.securemx.jp (mx-mo-csw1116) id 20REPWCa009075;
 Thu, 27 Jan 2022 23:25:32 +0900
X-Iguazu-Qid: 2wGrVsu7KfddsHBYDQ
X-Iguazu-QSIG: v=2; s=0; t=1643293532; q=2wGrVsu7KfddsHBYDQ;
 m=ogkDSnI4KSq0QGrjlKuNtNsyVU1MLEBNsztrODSDkBg=
Received: from imx12-a.toshiba.co.jp (imx12-a.toshiba.co.jp [61.202.160.135])
	by relay.securemx.jp (mx-mr1113) id 20REPULD029004
	(version=TLSv1.2 cipher=AES128-GCM-SHA256 bits=128 verify=NOT);
	Thu, 27 Jan 2022 23:25:31 +0900
From: Shivanand.Kunijadar@toshiba-tsip.com
To: cip-dev@lists.cip-project.org, jan.kiszka@siemens.com,
        quirin.gylstorff@siemens.com
Cc: Shivanand Kunijadar <Shivanand.Kunijadar@toshiba-tsip.com>,
        dinesh.kumar@toshiba-tsip.com
Subject: [isar-cip-core] swupdate: add recipe to cause kernel panic during
 system boot
Date: Thu, 27 Jan 2022 19:50:42 +0530
X-TSB-HOP: ON
X-TSB-HOP2: ON
Message-Id: <20220127142042.6692-1-Shivanand.Kunijadar@toshiba-tsip.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-OriginalArrivalTime: 27 Jan 2022 14:25:29.0522 (UTC)
 FILETIME=[BC21F920:01D81389]
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 27 Jan 2022 14:25:38 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/7503

From: Shivanand Kunijadar <Shivanand.Kunijadar@toshiba-tsip.com>

Cc: dinesh.kumar@toshiba-tsip.com,
    kazuhiro3.hayashi@toshiba.co.jp,
    akihiro27.suzuki@toshiba.co.jp

This recipe adds necessary scripts to cause kernel panic during system
boot, these scripts are required to test swupdate rollback feature.

Signed-off-by: Shivanand Kunijadar <Shivanand.Kunijadar@toshiba-tsip.com>
---
 kas/opt/swupdate-rollback.yml                 | 19 +++++++++++++
 .../files/sysrq-panic.service                 | 10 +++++++
 .../swupdate-rollback/files/sysrq-panic.sh    |  4 +++
 .../swupdate-rollback/swupdate-rollback.bb    | 27 +++++++++++++++++++
 4 files changed, 60 insertions(+)
 create mode 100644 kas/opt/swupdate-rollback.yml
 create mode 100644 recipes-core/swupdate-rollback/files/sysrq-panic.service
 create mode 100644 recipes-core/swupdate-rollback/files/sysrq-panic.sh
 create mode 100644 recipes-core/swupdate-rollback/swupdate-rollback.bb

diff --git a/kas/opt/swupdate-rollback.yml b/kas/opt/swupdate-rollback.yml
new file mode 100644
index 0000000..a3b0e28
--- /dev/null
+++ b/kas/opt/swupdate-rollback.yml
@@ -0,0 +1,19 @@
+#
+# CIP Core, generic profile
+#
+# Copyright (c) Toshiba Corporation, 2022
+#
+# Authors:
+#  Shivanand Kunijadar <Shivanand.Kunijadar@toshiba-tsip.com>
+#
+# SPDX-License-Identifier: MIT
+#
+# This kas file adds necessary scripts to cause kernel panic during system boot
+# which are required to test swupdate rollback feature
+
+header:
+  version: 10
+
+local_conf_header:
+  swupdate: |
+    IMAGE_INSTALL_append = " swupdate-rollback"
diff --git a/recipes-core/swupdate-rollback/files/sysrq-panic.service b/recipes-core/swupdate-rollback/files/sysrq-panic.service
new file mode 100644
index 0000000..ae868f9
--- /dev/null
+++ b/recipes-core/swupdate-rollback/files/sysrq-panic.service
@@ -0,0 +1,10 @@
+[Unit]
+Description=sysrq panic
+
+[Service]
+Type=oneshot
+ExecStart=/root/sysrq-panic.sh
+
+[Install]
+WantedBy=default.target
+
diff --git a/recipes-core/swupdate-rollback/files/sysrq-panic.sh b/recipes-core/swupdate-rollback/files/sysrq-panic.sh
new file mode 100644
index 0000000..a3c1bb7
--- /dev/null
+++ b/recipes-core/swupdate-rollback/files/sysrq-panic.sh
@@ -0,0 +1,4 @@
+#!/bin/sh
+
+echo c > /proc/sysrq-trigger
+
diff --git a/recipes-core/swupdate-rollback/swupdate-rollback.bb b/recipes-core/swupdate-rollback/swupdate-rollback.bb
new file mode 100644
index 0000000..5c93bb5
--- /dev/null
+++ b/recipes-core/swupdate-rollback/swupdate-rollback.bb
@@ -0,0 +1,27 @@
+#
+# CIP Core, generic profile
+#
+# Copyright (c) Toshiba Corporation, 2022
+#
+# Authors:
+#  Shivanand Kunijadar <Shivanand.Kunijadar@toshiba-tsip.com>
+#
+# SPDX-License-Identifier: MIT
+#
+
+inherit dpkg-raw
+
+DESCRIPTION = "Script and service files to cause kernel panic"
+
+SRC_URI = " \
+    file://sysrq-panic.sh \
+    file://sysrq-panic.service"
+
+do_install() {
+	install -v -d ${D}/root
+	install -v -m 0755 ${WORKDIR}/sysrq-panic.sh ${D}/root/
+	install -v -d ${D}/lib/systemd/system
+	install -v -m 0644 ${WORKDIR}/sysrq-panic.service ${D}/lib/systemd/system/
+	install -v -d ${D}/etc/systemd/system/default.target.wants
+	ln -s /lib/systemd/system/sysrq-panic.service ${D}/etc/systemd/system/default.target.wants/
+}
-- 
2.20.1



