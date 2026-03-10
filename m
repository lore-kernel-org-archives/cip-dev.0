Return-Path: <adithya.balakumar@toshiba-tsip.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3B6CFCC9B8
	for <webhook@archiver.kernel.org>; Tue, 10 Mar 2026 04:30:42 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.132])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.33056.1773117031976602193
 for <cip-dev@lists.cip-project.org>;
 Mon, 09 Mar 2026 21:30:32 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: toshiba-tsip.com, ip: 210.130.202.132, mailfrom: adithya.balakumar@toshiba-tsip.com)
Received: by mo-csw.securemx.jp (mx-mo-csw1121) id 62A4UUpf168806; Tue, 10 Mar 2026 13:30:30 +0900
X-Iguazu-Qid: 2rWgzTVwjsoTbdcyPZ
X-Iguazu-QSIG: v=2; s=0; t=1773117030; q=2rWgzTVwjsoTbdcyPZ; m=OmYNXVxcY3bF5FMqO4dNW45rDeWlfLhsRNiKypEyo1Q=
Received: from imx2-a.toshiba.co.jp (imx2-a.toshiba.co.jp [106.186.93.35])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	 id 4fVLXQ0Xytz1xnZ; Tue, 10 Mar 2026 13:30:29 +0900 (JST)
From: Adithya.Balakumar@toshiba-tsip.com
To: cip-dev@lists.cip-project.org, jan.kiszka@siemens.com
Cc: Adithya Balakumar <Adithya.Balakumar@toshiba-tsip.com>,
        shivanand.kunijadar@toshiba-tsip.com, dinesh.kumar@toshiba-tsip.com,
        koshiro.onuki.h55@mail.toshiba, kazuhiro3.hayashi@toshiba.co.jp,
        michael.adler@siemens.com, christian.storm@siemens.com
Subject: [isar-cip-core][RFC v1 2/7] wfx-onboarding-progress-client: Custom progress client for device onboarding with wfx
Date: Tue, 10 Mar 2026 00:45:49 -0400
X-TSB-HOP2: ON
Message-Id: <20260310044554.990348-3-Adithya.Balakumar@toshiba-tsip.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20260310044554.990348-1-Adithya.Balakumar@toshiba-tsip.com>
References: <20260310044554.990348-1-Adithya.Balakumar@toshiba-tsip.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-OriginalArrivalTime: 10 Mar 2026 04:30:23.0983 (UTC) FILETIME=[9CD757F0:01DCB046]
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 10 Mar 2026 04:30:42 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/22218

From: Adithya Balakumar <Adithya.Balakumar@toshiba-tsip.com>

The onboarding update is treated as a configuration update and therefore would not
need a bootloader state update. But the activation of the onboarding update would
need a reboot or atleast restart of relevant services.

Setting the firmware tag in wfx jobs does reboot the system for activation (see [1])
of the update but also updates the bootloader state which is undesirable for this use case.

Hence the need for this simple module that currently just restarts swupdate service  during
activation of the onboarding update.

[1] https://sbabic.github.io/swupdate/suricatta.html#update-activation

Signed-off-by: Adithya Balakumar <Adithya.Balakumar@toshiba-tsip.com>
---
 .../files/postinst                            |  4 +++
 .../wfx-onboarding-progress-client_0.1.bb     | 26 +++++++++++++++++++
 2 files changed, 30 insertions(+)
 create mode 100644 recipes-core/wfx-onboarding-progress-client/files/postinst
 create mode 100644 recipes-core/wfx-onboarding-progress-client/wfx-onboarding-progress-client_0.1.bb

diff --git a/recipes-core/wfx-onboarding-progress-client/files/postinst b/recipes-core/wfx-onboarding-progress-client/files/postinst
new file mode 100644
index 0000000..0d39e3a
--- /dev/null
+++ b/recipes-core/wfx-onboarding-progress-client/files/postinst
@@ -0,0 +1,4 @@
+#!/bin/sh
+set -e
+
+systemctl enable wfx-onboarding-progress.service
\ No newline at end of file
diff --git a/recipes-core/wfx-onboarding-progress-client/wfx-onboarding-progress-client_0.1.bb b/recipes-core/wfx-onboarding-progress-client/wfx-onboarding-progress-client_0.1.bb
new file mode 100644
index 0000000..97d58dc
--- /dev/null
+++ b/recipes-core/wfx-onboarding-progress-client/wfx-onboarding-progress-client_0.1.bb
@@ -0,0 +1,26 @@
+#
+# CIP Core, generic profile
+#
+# Copyright (c) Toshiba Corporation 2026
+#
+# Authors:
+#  Adithya Balakumar <adithya.balakumar@toshiba-tsip.com>
+#
+# SPDX-License-Identifier: MIT
+#
+
+inherit dpkg
+
+SRC_URI += "git://gitlab.com/cip-playground/cip-wfx-onboarding-client-plugin.git;protocol=https;destsuffix=cip-wfx-onboarding-client-plugin;name=cip-wfx-onboarding-client-plugin;branch=master"
+SRCREV_cip-wfx-onboarding-client-plugin ?= "5732bce8ae2d1d744827d42e00cc13ba251bf75c"
+
+WFX_ONBOARDING_PROGRESS_CLIENT = "cip-wfx-onboarding-client-plugin/onboarding-progress-client"
+
+SRC_URI += "file://postinst"
+
+do_prepare_build[cleandirs] += "${S}"
+do_prepare_build() {
+    cp -r ${WORKDIR}/${WFX_ONBOARDING_PROGRESS_CLIENT}/* ${S}/
+
+    deb_add_changelog
+}
-- 
2.39.5



