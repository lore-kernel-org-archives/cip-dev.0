Return-Path: <quirin.gylstorff@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 687FDC28B22
	for <webhook@archiver.kernel.org>; Wed,  5 Mar 2025 10:28:12 +0000 (UTC)
Received: from mta-64-226.siemens.flowmailer.net (mta-64-226.siemens.flowmailer.net [185.136.64.226])
 by mx.groups.io with SMTP id smtpd.web10.10445.1741170491179514611
 for <cip-dev@lists.cip-project.org>;
 Wed, 05 Mar 2025 02:28:12 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=Quirin.Gylstorff@siemens.com header.s=fm1 header.b=OWEsxdov;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.64.226, mailfrom: fm-51332-202503051028084583d8a8c45407a6ad-krie_6@rts-flowmailer.siemens.com)
Received: by mta-64-226.siemens.flowmailer.net with ESMTPSA id 202503051028084583d8a8c45407a6ad
        for <cip-dev@lists.cip-project.org>;
        Wed, 05 Mar 2025 11:28:08 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=Quirin.Gylstorff@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:References:In-Reply-To;
 bh=ybGc/jMJ37jlEN0Iz4Q9OTgDghwOVjLn3UkN3xc3wmA=;
 b=OWEsxdov0sv3HEtui9MF5Y04usHeD4XOU2W5mPeQNDG0xQezpWXHflT5jUB5Yh7u6ruISI
 4CBnS/IFRQk75iUxElU1Y1VQJOw3UgwY/q2rgVE+yMcVtqddMHAjT3AJM20el9gTTD408m5G
 FFz7uTDDfvG1lW01cbYbdS5LSJmB9zKkQgNaEp2P0JEd1LRkzitYoFN6QRxY5xvFpEfxZLV/
 3Tr9JVE+Y+WhkA/rj/qfp8pY38R2SOAIPT8XVElABL21bkGSynCxy6+M8rms782kg5oApDNB
 QVCqKUmqw1WZMfnk9mpndnatMiZW5gGR9YD7kr3eEVmBbyxsFeuxHrTA==;
From: Quirin Gylstorff <Quirin.Gylstorff@siemens.com>
To: jan.kiszka@siemens.com,
	felix.moessbauer@siemens.com,
	cip-dev@lists.cip-project.org
Subject: [cip-dev][isar-cip-core][PATCH v3 3/6] add move-homedir-var package
Date: Wed,  5 Mar 2025 11:27:42 +0100
Message-ID: <20250305102807.2614514-4-Quirin.Gylstorff@siemens.com>
In-Reply-To: <20250305102807.2614514-1-Quirin.Gylstorff@siemens.com>
References: <20250305102807.2614514-1-Quirin.Gylstorff@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-51332:519-21489:flowmailer
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 05 Mar 2025 10:28:12 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/18040

From: Quirin Gylstorff <quirin.gylstorff@siemens.com>

This creates a tmpfiles to copy /usr/share/immutable-data/home to /var.

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


