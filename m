Return-Path: <quirin.gylstorff@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E5A2C6FD1F
	for <webhook@archiver.kernel.org>; Mon,  6 Mar 2023 12:39:34 +0000 (UTC)
Received: from mta-64-227.siemens.flowmailer.net (mta-64-227.siemens.flowmailer.net [185.136.64.227])
 by mx.groups.io with SMTP id smtpd.web11.32094.1678106371206793770
 for <cip-dev@lists.cip-project.org>;
 Mon, 06 Mar 2023 04:39:32 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=Quirin.Gylstorff@siemens.com header.s=fm1 header.b=PYgXNwvN;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.64.227, mailfrom: fm-51332-202303061239286d53d670e2bc72aadc-yesjbe@rts-flowmailer.siemens.com)
Received: by mta-64-227.siemens.flowmailer.net with ESMTPSA id 202303061239286d53d670e2bc72aadc
        for <cip-dev@lists.cip-project.org>;
        Mon, 06 Mar 2023 13:39:28 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=Quirin.Gylstorff@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:References:In-Reply-To;
 bh=pgauSzp2ExzfRlGpb9EqcfTdKvzR9mXBjnAyESSMwOA=;
 b=PYgXNwvNQqlpiLkCimaxn9Kk2/3ZhE9wzPO9ErxdFWu7T3A72ljuq+vdE7qYd4UrWkVSym
 hmfLzoYbUccYy4k222zjA3nxDuYR0JeI4cOKzjaSix88qsCL/srG4050QwGHhiV2mFsrTg60
 c5i9i9Df3OdYEyIXBDX526MeFG88s=;
From: Quirin Gylstorff <Quirin.Gylstorff@siemens.com>
To: cip-dev@lists.cip-project.org,
	christian.storm@siemens.com,
	jan.kiszka@siemens.com
Subject: [cip-dev][isar-cip-core][PATCH v4 1/7] use bullseye backports for systemd-cryptenroll
Date: Mon,  6 Mar 2023 13:39:20 +0100
Message-Id: <20230306123926.243471-2-Quirin.Gylstorff@siemens.com>
In-Reply-To: <20230306123926.243471-1-Quirin.Gylstorff@siemens.com>
References: <20230306123926.243471-1-Quirin.Gylstorff@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-51332:519-21489:flowmailer
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 06 Mar 2023 12:39:34 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/10942

From: Quirin Gylstorff <quirin.gylstorff@siemens.com>

Systemd >= 251 is required for systemd-cryptenroll. This version
is part of backports.

Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
---
 conf/distro/debian-bullseye-backports.list    |  1 +
 .../preferences.bullseye-backports.tpm.conf   |  4 ++++
 kas/opt/tpm.yml                               | 20 +++++++++++++++++++
 3 files changed, 25 insertions(+)
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
index 0000000..d61fa64
--- /dev/null
+++ b/conf/distro/preferences.bullseye-backports.tpm.conf
@@ -0,0 +1,4 @@
+Explanation: Use systemd and its dependencies from debian-backports to support systemd-cryptenroll
+Package: libnss-myhostname libnss-mymachines libnss-resolve libnss-systemd libpam-systemd libudev* libsystemd* systemd systemd-* udev
+Pin: release n=bullseye-backports
+Pin-Priority: 801
diff --git a/kas/opt/tpm.yml b/kas/opt/tpm.yml
new file mode 100644
index 0000000..0e4dc95
--- /dev/null
+++ b/kas/opt/tpm.yml
@@ -0,0 +1,20 @@
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
+    DISTRO_APT_SOURCES:append:bullseye = " conf/distro/debian-bullseye-backports.list"
+    DISTRO_APT_PREFERENCES:append:bullseye = " conf/distro/preferences.bullseye-backports.tpm.conf"
+  image-option-tpm: |
+    INITRAMFS_INSTALL += " initramfs-crypt-hook"
-- 
2.39.2


