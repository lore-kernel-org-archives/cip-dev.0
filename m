Return-Path: <quirin.gylstorff@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8545C636CB
	for <webhook@archiver.kernel.org>; Mon, 30 Jan 2023 15:02:18 +0000 (UTC)
Received: from mta-64-228.siemens.flowmailer.net (mta-64-228.siemens.flowmailer.net [185.136.64.228])
 by mx.groups.io with SMTP id smtpd.web10.43227.1675090929384531270
 for <cip-dev@lists.cip-project.org>;
 Mon, 30 Jan 2023 07:02:10 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=Quirin.Gylstorff@siemens.com header.s=fm1 header.b=OfcI8Hyy;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.64.228, mailfrom: fm-51332-20230130150206d092424cfcfe6d9fd8-ihjwm4@rts-flowmailer.siemens.com)
Received: by mta-64-228.siemens.flowmailer.net with ESMTPSA id 20230130150206d092424cfcfe6d9fd8
        for <cip-dev@lists.cip-project.org>;
        Mon, 30 Jan 2023 16:02:06 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=Quirin.Gylstorff@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:References:In-Reply-To;
 bh=SACE9uB+nADL7Lpx0HDplX+DQHCLJ+YCrvGKX8ioWg0=;
 b=OfcI8HyyvmI6pbGxVJt9D6qWDsWYmOK42aSpGUuc6rYKgWAgFIASDy022rJMlltwcGzhYY
 62ClNhMCkgtAbwvJNlJQrnPX8yG7T5zcLLU9kQcQSL1PHQwd0OxMe9tkGSrxNMByUySEpFHq
 kVy1tALfIJ67z0DtSB/+z6Cy410FI=;
From: Quirin Gylstorff <Quirin.Gylstorff@siemens.com>
To: cip-dev@lists.cip-project.org,
	jan.kiszka@siemens.com,
	christian.storm@siemens.com
Subject: [cip-dev][isar-cip-core][RFC 2/5] use bullseye backports for systemd-cryptenroll
Date: Mon, 30 Jan 2023 16:02:01 +0100
Message-Id: <20230130150204.697758-3-Quirin.Gylstorff@siemens.com>
In-Reply-To: <20230130150204.697758-1-Quirin.Gylstorff@siemens.com>
References: <20230130150204.697758-1-Quirin.Gylstorff@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-51332:519-21489:flowmailer
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 30 Jan 2023 15:02:18 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/10511

From: Quirin Gylstorff <quirin.gylstorff@siemens.com>

Systemd >= 251 is required for systemd-cryptenroll. This version
is part of backports.

Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
---
 conf/distro/debian-bullseye-backports.list     |  1 +
 .../preferences.bullseye-backports.tpm.conf    |  3 +++
 kas/opt/tpm.yml                                | 18 ++++++++++++++++++
 3 files changed, 22 insertions(+)
 create mode 100644 conf/distro/debian-bullseye-backports.list
 create mode 100644 conf/distro/preferences.bullseye-backports.tpm.conf
 create mode 100644 kas/opt/tpm.yml

diff --git a/conf/distro/debian-bullseye-backports.list b/conf/distro/debian-bullseye-backports.list
new file mode 100644
index 0000000..3a55e4c
--- /dev/null
+++ b/conf/distro/debian-bullseye-backports.list
@@ -0,0 +1 @@
+deb http://ftp.us.debian.org/debian bullseye-backports main contrib non-free
diff --git a/conf/distro/preferences.bullseye-backports.tpm.conf b/conf/distro/preferences.bullseye-backports.tpm.conf
new file mode 100644
index 0000000..0905fbf
--- /dev/null
+++ b/conf/distro/preferences.bullseye-backports.tpm.conf
@@ -0,0 +1,3 @@
+Package: *
+Pin: release n=bullseye-backports
+Pin-Priority: 801
diff --git a/kas/opt/tpm.yml b/kas/opt/tpm.yml
new file mode 100644
index 0000000..03e8e47
--- /dev/null
+++ b/kas/opt/tpm.yml
@@ -0,0 +1,18 @@
+#
+# CIP Core, generic profile
+#
+# Copyright (c) Siemens AG, 2022
+#
+# Authors:
+#  Quirin Gylstorff <quirin.gylstorff@siemens.com>
+#
+# SPDX-License-Identifier: MIT
+#
+
+header:
+  version: 12
+
+local_conf_header:
+  systemd-cryptenroll: |
+    DISTRO_APT_SOURCES_append_bullseye = " conf/distro/debian-bullseye-backports.list"
+    DISTRO_APT_PREFERENCES_append_bullseye = " conf/distro/preferences.bullseye-backports.tpm.conf"
-- 
2.39.0


