Return-Path: <quirin.gylstorff@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55DB2C74A5B
	for <webhook@archiver.kernel.org>; Thu,  9 Mar 2023 10:28:30 +0000 (UTC)
Received: from mta-65-227.siemens.flowmailer.net (mta-65-227.siemens.flowmailer.net [185.136.65.227])
 by mx.groups.io with SMTP id smtpd.web11.10024.1678357705840435795
 for <cip-dev@lists.cip-project.org>;
 Thu, 09 Mar 2023 02:28:26 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=Quirin.Gylstorff@siemens.com header.s=fm1 header.b=aXW1oxKv;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.65.227, mailfrom: fm-51332-202303091028234149930d1b98315ba7-7ndzfi@rts-flowmailer.siemens.com)
Received: by mta-65-227.siemens.flowmailer.net with ESMTPSA id 202303091028234149930d1b98315ba7
        for <cip-dev@lists.cip-project.org>;
        Thu, 09 Mar 2023 11:28:23 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=Quirin.Gylstorff@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:References:In-Reply-To;
 bh=NJBEPsDanDfqrn2U66WPsk/3buuoQ80AyCrTpPu7gPk=;
 b=aXW1oxKvOSKK2yCN2hykOJnSpwfzKokZMt9ohuv8dI8M1kLpPhrBIXb8ss8UJsTIYDnEU4
 cJV8EPpg63kTrA7XA/uzhVrEELSA91k2H6su9reV+9jHweGyXKjXY1nYacfDlCh0AZ1rxbs2
 3kIVbTl4386aawwcnpezuMgVmCLBw=;
From: Quirin Gylstorff <Quirin.Gylstorff@siemens.com>
To: cip-dev@lists.cip-project.org,
	christian.storm@siemens.com,
	jan.kiszka@siemens.com
Subject: [cip-dev][isar-cip-core][PATCH v6 1/7] use bullseye backports for systemd-cryptenroll
Date: Thu,  9 Mar 2023 11:28:15 +0100
Message-Id: <20230309102821.307140-2-Quirin.Gylstorff@siemens.com>
In-Reply-To: <20230309102821.307140-1-Quirin.Gylstorff@siemens.com>
References: <20230309102821.307140-1-Quirin.Gylstorff@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-51332:519-21489:flowmailer
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 09 Mar 2023 10:28:30 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/10963

From: Quirin Gylstorff <quirin.gylstorff@siemens.com>

Systemd >= 251 is required for systemd-cryptenroll. This version
is part of backports.

Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
---
 conf/distro/debian-bullseye-backports.list    |  1 +
 .../preferences.bullseye-backports.tpm.conf   |  8 ++++++++
 kas/opt/encrypt-partitions.yml                | 20 +++++++++++++++++++
 3 files changed, 29 insertions(+)
 create mode 100644 conf/distro/debian-bullseye-backports.list
 create mode 100644 conf/distro/preferences.bullseye-backports.tpm.conf
 create mode 100644 kas/opt/encrypt-partitions.yml

diff --git a/conf/distro/debian-bullseye-backports.list b/conf/distro/debian-bullseye-backports.list
new file mode 100644
index 0000000..3a55e4c
--- /dev/null
+++ b/conf/distro/debian-bullseye-backports.list
@@ -0,0 +1 @@
+deb http://ftp.us.debian.org/debian bullseye-backports main contrib non-free
diff --git a/conf/distro/preferences.bullseye-backports.tpm.conf b/conf/distro/preferences.bullseye-backports.tpm.conf
new file mode 100644
index 0000000..60c4265
--- /dev/null
+++ b/conf/distro/preferences.bullseye-backports.tpm.conf
@@ -0,0 +1,8 @@
+Package: *
+Pin: release n=bullseye-backports
+Pin-Priority: -1
+
+Explanation: Use systemd and its dependencies from debian-backports to support systemd-cryptenroll
+Package: libnss-myhostname libnss-mymachines libnss-resolve libnss-systemd libpam-systemd libudev* libsystemd* systemd systemd-* udev
+Pin: release n=bullseye-backports
+Pin-Priority: 801
diff --git a/kas/opt/encrypt-partitions.yml b/kas/opt/encrypt-partitions.yml
new file mode 100644
index 0000000..1f91c0c
--- /dev/null
+++ b/kas/opt/encrypt-partitions.yml
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
+
+
-- 
2.39.2


