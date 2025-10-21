Return-Path: <adithya.balakumar@toshiba-tsip.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97633CCD1AA
	for <webhook@archiver.kernel.org>; Tue, 21 Oct 2025 12:40:54 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.134])
 by mx.groups.io with SMTP id smtpd.web11.10740.1761050444833304136
 for <cip-dev@lists.cip-project.org>;
 Tue, 21 Oct 2025 05:40:45 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: toshiba-tsip.com, ip: 210.130.202.134, mailfrom: adithya.balakumar@toshiba-tsip.com)
Received: by mo-csw.securemx.jp (mx-mo-csw1800) id 59LCehgr3881171; Tue, 21 Oct 2025 21:40:43 +0900
X-Iguazu-Qid: 2yAbc3FhhcGKA2R6vI
X-Iguazu-QSIG: v=2; s=0; t=1761050443; q=2yAbc3FhhcGKA2R6vI; m=H7yuM+DdZhxzixy+NXE1WcLtvv+WyNgiPJ/TqPg2Ejs=
Received: from imx2-a.toshiba.co.jp (imx2-a.toshiba.co.jp [106.186.93.35])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	 id 4crX2g2GcGzyPQ; Tue, 21 Oct 2025 21:40:42 +0900 (JST)
From: Adithya.Balakumar@toshiba-tsip.com
To: cip-dev@lists.cip-project.org, jan.kiszka@siemens.com
Cc: Adithya Balakumar <Adithya.Balakumar@toshiba-tsip.com>,
        shivanand.kunijadar@toshiba-tsip.com, dinesh.kumar@toshiba-tsip.com,
        kazuhiro3.hayashi@toshiba.co.jp, akunuri.sahithi@toshiba-tsip.com
Subject: [isar-cip-core][RFC v1 3/5] wfx-customizations: Recipe to add wfx helper specific scripts into target
Date: Tue, 21 Oct 2025 08:52:30 -0400
X-TSB-HOP2: ON
Message-Id: <20251021125233.1528087-4-Adithya.Balakumar@toshiba-tsip.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20251021125233.1528087-1-Adithya.Balakumar@toshiba-tsip.com>
References: <20251021125233.1528087-1-Adithya.Balakumar@toshiba-tsip.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-OriginalArrivalTime: 21 Oct 2025 12:40:37.0338 (UTC) FILETIME=[E6BC23A0:01DC4287]
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 21 Oct 2025 12:40:54 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/20205

From: Adithya Balakumar <Adithya.Balakumar@toshiba-tsip.com>

wfx requires a unique clientId for each client device for targeted jobs for
each client. This includes a script that runs as ExecStartPre for SWUpdate
that generates a clientId and sets the same in swupdate.cfg

Signed-off-by: Adithya Balakumar <Adithya.Balakumar@toshiba-tsip.com>
---
 .../wfx-customizations/files/override.conf    |  6 ++++
 .../files/wfx-generate-uuid.sh                | 22 +++++++++++++++
 .../wfx-customizations_0.1.bb                 | 28 +++++++++++++++++++
 3 files changed, 56 insertions(+)
 create mode 100644 recipes-core/wfx-customizations/files/override.conf
 create mode 100644 recipes-core/wfx-customizations/files/wfx-generate-uuid.sh
 create mode 100644 recipes-core/wfx-customizations/wfx-customizations_0.1.bb

diff --git a/recipes-core/wfx-customizations/files/override.conf b/recipes-core/wfx-customizations/files/override.conf
new file mode 100644
index 0000000..4ad8551
--- /dev/null
+++ b/recipes-core/wfx-customizations/files/override.conf
@@ -0,0 +1,6 @@
+[Unit]
+ConditionPathIsReadWrite=/etc
+
+[Service]
+ExecStartPre=
+ExecStartPre=/usr/lib/swupdate/wfx-generate-uuid.sh
\ No newline at end of file
diff --git a/recipes-core/wfx-customizations/files/wfx-generate-uuid.sh b/recipes-core/wfx-customizations/files/wfx-generate-uuid.sh
new file mode 100644
index 0000000..6ee2eba
--- /dev/null
+++ b/recipes-core/wfx-customizations/files/wfx-generate-uuid.sh
@@ -0,0 +1,22 @@
+#!/bin/sh -e
+
+# Generate a UUID from machine serial number using a SHA-256 hash
+generate_uuid() {
+  serial_no=$(cat /etc/machine-id)
+
+  # Generate a SHA-256 hash and extract the first 32 hex characters
+  hash=$(echo -n "$serial_no" | sha256sum | awk '{print $1}' | cut -c1-32)
+
+  # Format the hash into a UUID format: 8-4-4-4-12
+  uuid=$(echo "$hash" | sed -E 's/^(.{8})(.{4})(.{4})(.{4})(.{12}).*/\1-\2-\3-\4-\5/')
+
+  echo "$uuid"
+}
+
+# Generate a UUID from the serial number
+device_id=$(generate_uuid)
+
+# Replace the clientId in /etc/swupdate.cfg
+cp /etc/swupdate.cfg /tmp/swupdate.cfg.backup
+sed "s/__DEVICE_ID__/$device_id/" /etc/swupdate.cfg > /tmp/swupdate.cfg.backup
+mv /tmp/swupdate.cfg.backup /etc/swupdate.cfg
\ No newline at end of file
diff --git a/recipes-core/wfx-customizations/wfx-customizations_0.1.bb b/recipes-core/wfx-customizations/wfx-customizations_0.1.bb
new file mode 100644
index 0000000..43fc2fd
--- /dev/null
+++ b/recipes-core/wfx-customizations/wfx-customizations_0.1.bb
@@ -0,0 +1,28 @@
+#
+# CIP Core, generic profile
+#
+# Copyright (c) Toshiba Corporation 2025
+#
+# Authors:
+#  Adithya Balakumar <adithya.balakumar@toshiba-tsip.com>
+#
+# SPDX-License-Identifier: MIT
+#
+
+inherit dpkg-raw
+
+PROVIDES := "${PN}"
+DEBIAN_PROVIDES := "${PN}"
+
+SRC_URI = "file://override.conf \
+           file://wfx-generate-uuid.sh"
+
+do_install[cleandirs] = "${D}/etc/"
+do_install() {
+
+    install -d ${D}/etc/systemd/system/swupdate.service.d
+    install -m 0644 ${WORKDIR}/override.conf ${D}/etc/systemd/system/swupdate.service.d
+    install -d ${D}/usr/lib/swupdate
+    install -m 0755 ${WORKDIR}/wfx-generate-uuid.sh ${D}/usr/lib/swupdate
+
+}
-- 
2.39.5



