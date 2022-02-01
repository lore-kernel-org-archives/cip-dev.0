Return-Path: <Shivanand.Kunijadar@toshiba-tsip.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5DA65C433FE
	for <webhook@archiver.kernel.org>; Tue,  1 Feb 2022 15:40:16 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.156])
 by mx.groups.io with SMTP id smtpd.web12.49803.1643730015419980166
 for <cip-dev@lists.cip-project.org>;
 Tue, 01 Feb 2022 07:40:15 -0800
Authentication-Results: mx.groups.io;
 dkim=missing;
 spf=pass (domain: toshiba-tsip.com, ip: 210.130.202.156,
 mailfrom: shivanand.kunijadar@toshiba-tsip.com)
Received: by mo-csw.securemx.jp (mx-mo-csw1114) id 211FeCu1018489;
 Wed, 2 Feb 2022 00:40:13 +0900
X-Iguazu-Qid: 2wGrYolv9doEUs4Ttx
X-Iguazu-QSIG: v=2; s=0; t=1643730012; q=2wGrYolv9doEUs4Ttx;
 m=k58yQtv9rpseyaCOny6rRdLZjSmb52viMqhuNwl5psU=
Received: from imx12-a.toshiba.co.jp (imx12-a.toshiba.co.jp [61.202.160.135])
	by relay.securemx.jp (mx-mr1112) id 211FeBV0039156
	(version=TLSv1.2 cipher=AES128-GCM-SHA256 bits=128 verify=NOT);
	Wed, 2 Feb 2022 00:40:12 +0900
From: Shivanand.Kunijadar@toshiba-tsip.com
To: cip-dev@lists.cip-project.org, jan.kiszka@siemens.com,
        quirin.gylstorff@siemens.com
Cc: Shivanand Kunijadar <Shivanand.Kunijadar@toshiba-tsip.com>,
        dinesh.kumar@toshiba-tsip.com, kazuhiro3.hayashi@toshiba.co.jp,
        akihiro27.suzuki@toshiba.co.jp
Subject: [isar-cip-core v2 1/2] Add recipe to cause kernel panic during system
 boot
Date: Tue,  1 Feb 2022 21:05:01 +0530
X-TSB-HOP: ON
X-TSB-HOP2: ON
Message-Id: <20220201153502.14230-2-Shivanand.Kunijadar@toshiba-tsip.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <52fae1ea-25fc-e692-2b51-e503681d2efb@siemens.com>
References: <52fae1ea-25fc-e692-2b51-e503681d2efb@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-OriginalArrivalTime: 01 Feb 2022 15:39:54.0449 (UTC)
 FILETIME=[F5808410:01D81781]
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 01 Feb 2022 15:40:16 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/7559

From: Shivanand Kunijadar <Shivanand.Kunijadar@toshiba-tsip.com>

This recipe adds systemd service to cause kernel panic during system
boot.
It helps to check the swupdate-rollback feature.

Signed-off-by: Shivanand Kunijadar <Shivanand.Kunijadar@toshiba-tsip.com>
---
 kas/opt/kernel-panic.yml                      | 18 ++++++++++++++
 .../kernel-panic/files/sysrq-panic.service    | 10 ++++++++
 recipes-core/kernel-panic/kernel-panic.bb     | 24 +++++++++++++++++++
 3 files changed, 52 insertions(+)
 create mode 100644 kas/opt/kernel-panic.yml
 create mode 100644 recipes-core/kernel-panic/files/sysrq-panic.service
 create mode 100644 recipes-core/kernel-panic/kernel-panic.bb

diff --git a/kas/opt/kernel-panic.yml b/kas/opt/kernel-panic.yml
new file mode 100644
index 0000000..47df7b1
--- /dev/null
+++ b/kas/opt/kernel-panic.yml
@@ -0,0 +1,18 @@
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
+# This kas file adds systemd service file to cause kernel panic during system boot.
+
+header:
+  version: 10
+
+local_conf_header:
+  kernel-panic: |
+    IMAGE_INSTALL_append = " kernel-panic"
diff --git a/recipes-core/kernel-panic/files/sysrq-panic.service b/recipes-core/kernel-panic/files/sysrq-panic.service
new file mode 100644
index 0000000..169a97c
--- /dev/null
+++ b/recipes-core/kernel-panic/files/sysrq-panic.service
@@ -0,0 +1,10 @@
+[Unit]
+Description=sysrq panic
+
+[Service]
+Type=oneshot
+ExecStart=/bin/sh -c "echo c > /proc/sysrq-trigger"
+
+[Install]
+WantedBy=default.target
+
diff --git a/recipes-core/kernel-panic/kernel-panic.bb b/recipes-core/kernel-panic/kernel-panic.bb
new file mode 100644
index 0000000..511febb
--- /dev/null
+++ b/recipes-core/kernel-panic/kernel-panic.bb
@@ -0,0 +1,24 @@
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
+DESCRIPTION = "Systemd service file to cause kernel panic"
+
+SRC_URI = " \
+    file://sysrq-panic.service"
+
+do_install() {
+	install -v -d ${D}/lib/systemd/system
+	install -v -m 0644 ${WORKDIR}/sysrq-panic.service ${D}/lib/systemd/system/
+	install -v -d ${D}/etc/systemd/system/default.target.wants
+	ln -s /lib/systemd/system/sysrq-panic.service ${D}/etc/systemd/system/default.target.wants/
+}
-- 
2.20.1



