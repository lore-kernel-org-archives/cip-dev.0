Return-Path: <adithya.balakumar@toshiba-tsip.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4EB77CCF9E0
	for <webhook@archiver.kernel.org>; Tue, 28 Oct 2025 12:09:28 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.134])
 by mx.groups.io with SMTP id smtpd.web10.9682.1761653339874298813
 for <cip-dev@lists.cip-project.org>;
 Tue, 28 Oct 2025 05:09:00 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: toshiba-tsip.com, ip: 210.130.202.134, mailfrom: adithya.balakumar@toshiba-tsip.com)
Received: by mo-csw.securemx.jp (mx-mo-csw1800) id 59SC8w0R3561854; Tue, 28 Oct 2025 21:08:58 +0900
X-Iguazu-Qid: 2yAbeZagRXb17vCy01
X-Iguazu-QSIG: v=2; s=0; t=1761653338; q=2yAbeZagRXb17vCy01; m=ghfDLHwBHJ4hJyHd2dhd1tgKzmCAP7azvucEmQYne3w=
Received: from imx2-a.toshiba.co.jp (imx2-a.toshiba.co.jp [106.186.93.35])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	 id 4cwq0p0vgPz1xnZ; Tue, 28 Oct 2025 21:08:57 +0900 (JST)
From: Adithya.Balakumar@toshiba-tsip.com
To: cip-dev@lists.cip-project.org, jan.kiszka@siemens.com
Cc: Adithya Balakumar <Adithya.Balakumar@toshiba-tsip.com>,
        shivanand.kunijadar@toshiba-tsip.com, dinesh.kumar@toshiba-tsip.com,
        kazuhiro3.hayashi@toshiba.co.jp, akunuri.sahithi@toshiba-tsip.com
Subject: [isar-cip-core][RFC v3 3/5] wfx-customizations: Recipe to add wfx helper specific scripts into target
Date: Tue, 28 Oct 2025 08:20:40 -0400
X-TSB-HOP2: ON
Message-Id: <20251028122042.2355451-4-Adithya.Balakumar@toshiba-tsip.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20251028122042.2355451-1-Adithya.Balakumar@toshiba-tsip.com>
References: <20251028122042.2355451-1-Adithya.Balakumar@toshiba-tsip.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-OriginalArrivalTime: 28 Oct 2025 12:08:53.0330 (UTC) FILETIME=[A0BFD320:01DC4803]
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 28 Oct 2025 12:09:28 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/20257

From: Adithya Balakumar <Adithya.Balakumar@toshiba-tsip.com>

wfx requires a unique clientId for each client device for targeted jobs for
each client. This includes a script that runs as ExecStartPre for SWUpdate
that generates a clientId and sets the same in swupdate.cfg

Signed-off-by: Adithya Balakumar <Adithya.Balakumar@toshiba-tsip.com>
---
 .../wfx-customizations/files/override.conf    |  6 ++++
 .../files/wfx-generate-client-id.sh           |  9 ++++++
 .../wfx-customizations_0.1.bb                 | 28 +++++++++++++++++++
 3 files changed, 43 insertions(+)
 create mode 100644 recipes-core/wfx-customizations/files/override.conf
 create mode 100644 recipes-core/wfx-customizations/files/wfx-generate-client-id.sh
 create mode 100644 recipes-core/wfx-customizations/wfx-customizations_0.1.bb

diff --git a/recipes-core/wfx-customizations/files/override.conf b/recipes-core/wfx-customizations/files/override.conf
new file mode 100644
index 0000000..17ac396
--- /dev/null
+++ b/recipes-core/wfx-customizations/files/override.conf
@@ -0,0 +1,6 @@
+[Unit]
+ConditionPathIsReadWrite=/etc
+
+[Service]
+ExecStartPre=
+ExecStartPre=/usr/lib/swupdate/wfx-generate-client-id.sh
diff --git a/recipes-core/wfx-customizations/files/wfx-generate-client-id.sh b/recipes-core/wfx-customizations/files/wfx-generate-client-id.sh
new file mode 100644
index 0000000..950e444
--- /dev/null
+++ b/recipes-core/wfx-customizations/files/wfx-generate-client-id.sh
@@ -0,0 +1,9 @@
+#!/bin/sh -e
+
+# Use machine-id as the device identifier for suricatta wfx
+device_id=$(cat /etc/machine-id)
+
+# Replace the clientId in /etc/swupdate.cfg
+cp /etc/swupdate.cfg /tmp/swupdate.cfg.backup
+sed "s/__DEVICE_ID__/$device_id/" /etc/swupdate.cfg > /tmp/swupdate.cfg.backup
+mv /tmp/swupdate.cfg.backup /etc/swupdate.cfg
diff --git a/recipes-core/wfx-customizations/wfx-customizations_0.1.bb b/recipes-core/wfx-customizations/wfx-customizations_0.1.bb
new file mode 100644
index 0000000..d44dc63
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
+           file://wfx-generate-client-id.sh"
+
+do_install[cleandirs] = "${D}/etc/"
+do_install() {
+
+    install -d ${D}/etc/systemd/system/swupdate.service.d
+    install -m 0644 ${WORKDIR}/override.conf ${D}/etc/systemd/system/swupdate.service.d
+    install -d ${D}/usr/lib/swupdate
+    install -m 0755 ${WORKDIR}/wfx-generate-client-id.sh ${D}/usr/lib/swupdate
+
+}
-- 
2.39.5



