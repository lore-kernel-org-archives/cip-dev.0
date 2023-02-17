Return-Path: <quirin.gylstorff@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2DC4C05027
	for <webhook@archiver.kernel.org>; Fri, 17 Feb 2023 13:05:53 +0000 (UTC)
Received: from mta-65-227.siemens.flowmailer.net (mta-65-227.siemens.flowmailer.net [185.136.65.227])
 by mx.groups.io with SMTP id smtpd.web10.5860.1676639145591542108
 for <cip-dev@lists.cip-project.org>;
 Fri, 17 Feb 2023 05:05:45 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=Quirin.Gylstorff@siemens.com header.s=fm1 header.b=RIHN+MB5;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.65.227, mailfrom: fm-51332-20230217130543fb504b8695b2136ef4-ag8w6z@rts-flowmailer.siemens.com)
Received: by mta-65-227.siemens.flowmailer.net with ESMTPSA id 20230217130543fb504b8695b2136ef4
        for <cip-dev@lists.cip-project.org>;
        Fri, 17 Feb 2023 14:05:43 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=Quirin.Gylstorff@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:References:In-Reply-To;
 bh=WkrcDtG88+qrPknT+8+zwRzbvDPfph8++yh5nfxh2xA=;
 b=RIHN+MB5iY75iUmLBvwrBtRu3B0xagk28r0axRTm4AliJdVveIELBq4Dmp+rBP1unNJHAQ
 p3//36hyneUxHQi+naGEEorMAJacwnzu6l7Y56JQeTWgZWX1nQbnjV/ZYH957N1nIjHpqpNy
 l3k+9/Ll282qk7xfixwmVlbZr2Vlc=;
From: Quirin Gylstorff <Quirin.Gylstorff@siemens.com>
To: cip-dev@lists.cip-project.org,
	christian.storm@siemens.com,
	jan.kiszka@siemens.com
Subject: [cip-dev][isar-cip-core][RFC v2 2/7] use bullseye backports for systemd-cryptenroll
Date: Fri, 17 Feb 2023 14:05:35 +0100
Message-Id: <20230217130540.509910-3-Quirin.Gylstorff@siemens.com>
In-Reply-To: <20230217130540.509910-1-Quirin.Gylstorff@siemens.com>
References: <20230217130540.509910-1-Quirin.Gylstorff@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-51332:519-21489:flowmailer
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 17 Feb 2023 13:05:53 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/10715

From: Quirin Gylstorff <quirin.gylstorff@siemens.com>

Systemd >= 251 is required for systemd-cryptenroll. This version
is part of backports.

Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
---
 conf/distro/debian-bullseye-backports.list    |  1 +
 .../preferences.bullseye-backports.tpm.conf   |  3 +++
 kas/opt/tpm.yml                               | 20 +++++++++++++++++++
 3 files changed, 24 insertions(+)
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
2.39.1


