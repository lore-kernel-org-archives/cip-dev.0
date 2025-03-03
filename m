Return-Path: <quirin.gylstorff@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90180C282C6
	for <webhook@archiver.kernel.org>; Mon,  3 Mar 2025 11:23:54 +0000 (UTC)
Received: from mta-65-227.siemens.flowmailer.net (mta-65-227.siemens.flowmailer.net [185.136.65.227])
 by mx.groups.io with SMTP id smtpd.web11.50854.1741001026220557598
 for <cip-dev@lists.cip-project.org>;
 Mon, 03 Mar 2025 03:23:47 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=Quirin.Gylstorff@siemens.com header.s=fm1 header.b=RwXU+1XI;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.65.227, mailfrom: fm-51332-202503031123433597bc92d82222d49d-tlxyuz@rts-flowmailer.siemens.com)
Received: by mta-65-227.siemens.flowmailer.net with ESMTPSA id 202503031123433597bc92d82222d49d
        for <cip-dev@lists.cip-project.org>;
        Mon, 03 Mar 2025 12:23:43 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=Quirin.Gylstorff@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:References:In-Reply-To;
 bh=xH3v7MwNrsf/lqFkcu/bTjtZPXcDMtqU/Ws2TGe4j1Y=;
 b=RwXU+1XIlNwruU+SvljeMwsLUIe2HAsZbtia5cJYBMh2U8P5KBrXqV/bdlx1L+9+FdgDA6
 IM94Ta2BNnGWMP7m2zJAD2p22gr+RItjaITqOSaAZY3GQ7tkPL5tZDR+foSuzHvjmPFE9kVV
 Kvri4snHP7CzPoXFLcfU4nr5r5Myt3DAsrIinTAVHDwKHscFXly74bli4fbtw9qUIuQaVIZC
 HsPilTAp24lX1d6GvIlYWRbwyxkp4KdS7xa9wDT0Uhu0GSjnNKVlXqQ43UNVCvLbTi11Thoy
 kv5s/rMpbnujW2n2cSSDiK8hKppFwCyXv9iIeuxh4ugiaAlqpnUMRQ5Q==;
From: Quirin Gylstorff <Quirin.Gylstorff@siemens.com>
To: cip-dev@lists.cip-project.org,
	jan.kiszka@siemens.com,
	felix.moessbauer@siemens.com,
	ludwig.nussel@siemens.com
Subject: [cip-dev][isar-cip-core][PATCH v2 3/4] add move-homedir-var package
Date: Mon,  3 Mar 2025 12:21:47 +0100
Message-ID: <20250303112342.851020-4-Quirin.Gylstorff@siemens.com>
In-Reply-To: <20250303112342.851020-1-Quirin.Gylstorff@siemens.com>
References: <20250303112342.851020-1-Quirin.Gylstorff@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-51332:519-21489:flowmailer
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 03 Mar 2025 11:23:54 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/18000

From: Quirin Gylstorff <quirin.gylstorff@siemens.com>

This creates a tmpfiles to copy /usr/share/immutable-data/home to /var
Also the recipe moves /home to /var/home and creates a symbolic link
between them.

This is prerequisite to move the home partition to /var as requested
by issue #123.

https://gitlab.com/cip-project/cip-core/isar-cip-core/-/issues/123
Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
---
 .../files/move-homedir-var.tmpfiles.tmpl      |  3 +++
 .../move-homedir-var/move-homedir-var_0.1.bb  | 23 +++++++++++++++++++
 2 files changed, 26 insertions(+)
 create mode 100644 recipes-core/move-homedir-var/files/move-homedir-var.tmpfiles.tmpl
 create mode 100644 recipes-core/move-homedir-var/move-homedir-var_0.1.bb

diff --git a/recipes-core/move-homedir-var/files/move-homedir-var.tmpfiles.tmpl b/recipes-core/move-homedir-var/files/move-homedir-var.tmpfiles.tmpl
new file mode 100644
index 0000000..8a3e535
--- /dev/null
+++ b/recipes-core/move-homedir-var/files/move-homedir-var.tmpfiles.tmpl
@@ -0,0 +1,3 @@
+L /home - - - - /var/home
+C /var/home - - - - ${IMMUTABLE_DATA_DIR}/home
+
diff --git a/recipes-core/move-homedir-var/move-homedir-var_0.1.bb b/recipes-core/move-homedir-var/move-homedir-var_0.1.bb
new file mode 100644
index 0000000..8848df6
--- /dev/null
+++ b/recipes-core/move-homedir-var/move-homedir-var_0.1.bb
@@ -0,0 +1,23 @@
+#
+# CIP Core, generic profile
+#
+# Copyright (c) Siemens AG, 2025
+#
+# Authors:
+#  Quirin Gylstorff <quirin.gylstorff@siemens.com>
+#
+# SPDX-License-Identifier: MIT
+
+inherit dpkg-raw
+
+DEBIAN_CONFLICTS = "home-fs"
+SRC_URI = "file://${BPN}.tmpfiles.tmpl"
+DPKG_ARCH = "all"
+
+IMMUTABLE_DATA_DIR ??= "/usr/share/immutable-data"
+TEMPLATE_VARS = "IMMUTABLE_DATA_DIR"
+TEMPLATE_FILES += "${BPN}.tmpfiles.tmpl"
+
+do_prepare_build:append() {
+    cp ${WORKDIR}/${BPN}.tmpfiles ${S}/debian/
+}
-- 
2.47.0


