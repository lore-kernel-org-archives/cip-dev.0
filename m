Return-Path: <quirin.gylstorff@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B3F5C021A7
	for <webhook@archiver.kernel.org>; Tue, 11 Feb 2025 08:51:39 +0000 (UTC)
Received: from mta-64-227.siemens.flowmailer.net (mta-64-227.siemens.flowmailer.net [185.136.64.227])
 by mx.groups.io with SMTP id smtpd.web10.7693.1739263889172002717
 for <cip-dev@lists.cip-project.org>;
 Tue, 11 Feb 2025 00:51:30 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=Quirin.Gylstorff@siemens.com header.s=fm2 header.b=VkVY6hN4;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.64.227, mailfrom: fm-51332-20250211085126182583a17dc754aeb5-su4opj@rts-flowmailer.siemens.com)
Received: by mta-64-227.siemens.flowmailer.net with ESMTPSA id 20250211085126182583a17dc754aeb5
        for <cip-dev@lists.cip-project.org>;
        Tue, 11 Feb 2025 09:51:26 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm2;
 d=siemens.com; i=Quirin.Gylstorff@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:References:In-Reply-To;
 bh=kl+6oAG+egWKDdttaMknqUe/abcHGhaxQ2X6KvyI9PY=;
 b=VkVY6hN4OJHAY5VGtMIDtfVrC4+ByaYxkX3JnxxFXyhitBq8JI7ulZoINXcJjafmW85Ou4
 IR/uk1RlXBzc9qXtdy54YLOSMkD3GteHiBJwFIOjR8FQPnWHK85IbDE3X1txudqPhs+8Ljax
 d8RQZeQtOM/8ycIT/P+q6U3VKv0gQH59fZKrqR87qWbBt5PhR1M/fTfaDl5LA72oeouXpifq
 Awx6Ad4QWK2ySx+GneTVmvwRyxOOcEE+iyAeBnI/ad7TDU4Xom49L7y9jRpREWGg9UZ+Dxkb
 EVRrSzT2xdF6GZkHShiKefPBfc/VnHa9CgzoIpx2C3eM8WR3J05yqF8w==;
From: Quirin Gylstorff <Quirin.Gylstorff@siemens.com>
To: cip-dev@lists.cip-project.org,
	jan.kiszka@siemens.com,
	felix.moessbauer@siemens.com,
	ludwig.nussel@siemens.com
Subject: [cip-dev][isar-cip-core][RFC 3/4] add move-homedir-var package
Date: Tue, 11 Feb 2025 09:49:10 +0100
Message-ID: <20250211085125.22154-4-Quirin.Gylstorff@siemens.com>
In-Reply-To: <20250211085125.22154-1-Quirin.Gylstorff@siemens.com>
References: <20250211085125.22154-1-Quirin.Gylstorff@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-51332:519-21489:flowmailer
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 11 Feb 2025 08:51:39 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/17805

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
 recipes-core/move-homedir-var/files/postinst  | 20 ++++++++++++++++
 .../move-homedir-var/move-homedir-var_0.1.bb  | 24 +++++++++++++++++++
 3 files changed, 47 insertions(+)
 create mode 100644 recipes-core/move-homedir-var/files/move-homedir-var.tmpfiles.tmpl
 create mode 100644 recipes-core/move-homedir-var/files/postinst
 create mode 100644 recipes-core/move-homedir-var/move-homedir-var_0.1.bb

diff --git a/recipes-core/move-homedir-var/files/move-homedir-var.tmpfiles.tmpl b/recipes-core/move-homedir-var/files/move-homedir-var.tmpfiles.tmpl
new file mode 100644
index 0000000..4dd691d
--- /dev/null
+++ b/recipes-core/move-homedir-var/files/move-homedir-var.tmpfiles.tmpl
@@ -0,0 +1,3 @@
+L /home - - - - /var/home
+C /var/home - - - - /${IMMUTABLE_DATA_DIR}/home
+
diff --git a/recipes-core/move-homedir-var/files/postinst b/recipes-core/move-homedir-var/files/postinst
new file mode 100644
index 0000000..c2575a5
--- /dev/null
+++ b/recipes-core/move-homedir-var/files/postinst
@@ -0,0 +1,20 @@
+#!/bin/sh
+#
+# CIP Core, generic profile
+#
+# Copyright (c) Siemens AG, 2025
+#
+# Authors:
+#  Quirin Gylstorff <quirin.gylstorff@siemens.com>
+#
+# SPDX-License-Identifier: MIT
+#
+
+set -e
+
+if [ ! -L /home ]; then
+	# usermod --move-home can not be used while the target user
+	# has running processes, also we keep a symlink here
+	mv /home /var/
+	ln -s /var/home /home
+fi
diff --git a/recipes-core/move-homedir-var/move-homedir-var_0.1.bb b/recipes-core/move-homedir-var/move-homedir-var_0.1.bb
new file mode 100644
index 0000000..965de92
--- /dev/null
+++ b/recipes-core/move-homedir-var/move-homedir-var_0.1.bb
@@ -0,0 +1,24 @@
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
+SRC_URI = "file://postinst \
+           file://${BPN}.tmpfiles.tmpl"
+DPKG_ARCH = "all"
+
+IMMUTABLE_DATA_DIR ??= "usr/share/immutable-data"
+TEMPLATE_VARS = "IMMUTABLE_DATA_DIR"
+TEMPLATE_FILES += "${BPN}.tmpfiles.tmpl"
+
+do_prepare_build:append() {
+    cp ${WORKDIR}/${BPN}.tmpfiles ${S}/debian/
+}
-- 
2.47.0


