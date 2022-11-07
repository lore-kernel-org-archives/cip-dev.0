Return-Path: <quirin.gylstorff@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E08C6C4332F
	for <webhook@archiver.kernel.org>; Mon,  7 Nov 2022 09:32:30 +0000 (UTC)
Received: from mta-64-228.siemens.flowmailer.net (mta-64-228.siemens.flowmailer.net [185.136.64.228])
 by mx.groups.io with SMTP id smtpd.web09.1576.1667813547929511430
 for <cip-dev@lists.cip-project.org>;
 Mon, 07 Nov 2022 01:32:29 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=Quirin.Gylstorff@siemens.com header.s=fm1 header.b=kUeFIH/q;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.64.228, mailfrom: fm-51332-20221107093147dcba869cfccda32ec2-ovv9x3@rts-flowmailer.siemens.com)
Received: by mta-64-228.siemens.flowmailer.net with ESMTPSA id 20221107093147dcba869cfccda32ec2
        for <cip-dev@lists.cip-project.org>;
        Mon, 07 Nov 2022 10:32:25 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=Quirin.Gylstorff@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:References:In-Reply-To;
 bh=r60r9JNdndX3wRWEiB/K+nnoYF70pFyYXfdFgW/nCoI=;
 b=kUeFIH/qm8cy794W1F0m1Wg6lycQxxoo7NkU+ubnltCMIMpYlKugbUuTgsf386zdgRfrFS
 fDuANe9nLxamZgNHJ7AegMTeF/dQpKWNPBgkTBNHjzw292T3NIi9bFtKx6HF+OMUTHvw006p
 FudgcwkXVzNIVt2Zr1Lgz7WLevvks=;
From: Quirin Gylstorff <Quirin.Gylstorff@siemens.com>
To: Jan.kiszka@siemens.com,
	cip-dev@lists.cip-project.org
Subject: [cip-dev][isar-cip-core][PATCH v2] tmp-fs: Use systemd tmp.mount
Date: Mon,  7 Nov 2022 10:31:46 +0100
Message-Id: <20221107093146.104489-1-Quirin.Gylstorff@siemens.com>
In-Reply-To: <ea6e38ca-1bd8-34fd-7329-f64705912091@siemens.com>
References: <ea6e38ca-1bd8-34fd-7329-f64705912091@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-51332:519-21489:flowmailer
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 07 Nov 2022 09:32:30 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/9938

From: Quirin Gylstorff <quirin.gylstorff@siemens.com>

Debian moves in [1] the tmp.mount to /usr/share.

To use sane defaults use the by systemd provided version of tmp.mount.

To overwrite the options use a drop-in file as described in [2].

[1]: https://salsa.debian.org/systemd-team/systemd/-/commit/5a9a0e7d25ac7ff0f1113ddb4219cc554b20dffa
[2]: https://www.freedesktop.org/software/systemd/man/systemd.unit.html

Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
---

Changes in v2:
 - increased recipe version
 - added empty do_install to avoid log message

 recipes-core/tmp-fs/files/postinst       |  4 ++++
 recipes-core/tmp-fs/files/tmp.mount.tmpl | 11 ----------
 recipes-core/tmp-fs/tmp-fs_0.1.bb        | 26 ------------------------
 recipes-core/tmp-fs/tmp-fs_0.2.bb        | 16 +++++++++++++++
 4 files changed, 20 insertions(+), 37 deletions(-)
 delete mode 100644 recipes-core/tmp-fs/files/tmp.mount.tmpl
 delete mode 100644 recipes-core/tmp-fs/tmp-fs_0.1.bb
 create mode 100644 recipes-core/tmp-fs/tmp-fs_0.2.bb

diff --git a/recipes-core/tmp-fs/files/postinst b/recipes-core/tmp-fs/files/postinst
index 07017fd..2db15ca 100755
--- a/recipes-core/tmp-fs/files/postinst
+++ b/recipes-core/tmp-fs/files/postinst
@@ -1,3 +1,7 @@
 #!/bin/sh
 
+if [ ! -e /etc/systemd/system/tmp.mount ]; then
+    cp /usr/share/systemd/tmp.mount /etc/systemd/system/tmp.mount
+fi
+
 deb-systemd-helper enable tmp.mount  || true
diff --git a/recipes-core/tmp-fs/files/tmp.mount.tmpl b/recipes-core/tmp-fs/files/tmp.mount.tmpl
deleted file mode 100644
index be5e663..0000000
--- a/recipes-core/tmp-fs/files/tmp.mount.tmpl
+++ /dev/null
@@ -1,11 +0,0 @@
-[Unit]
-Description=Create /tmp
-
-[Mount]
-What=tmpfs
-Where=/tmp
-Type=tmpfs
-Options=${TMP_FS_OPTIONS}
-
-[Install]
-WantedBy=local-fs.target
diff --git a/recipes-core/tmp-fs/tmp-fs_0.1.bb b/recipes-core/tmp-fs/tmp-fs_0.1.bb
deleted file mode 100644
index b86b0fb..0000000
--- a/recipes-core/tmp-fs/tmp-fs_0.1.bb
+++ /dev/null
@@ -1,26 +0,0 @@
-#
-# CIP Core, generic profile
-#
-# Copyright (c) Siemens AG, 2021
-#
-# Authors:
-#  Quirin Gylstorff <quirin.gylstorff@siemens.com>
-#
-# SPDX-License-Identifier: MIT
-
-inherit dpkg-raw
-
-SRC_URI = "file://postinst \
-           file://tmp.mount.tmpl"
-
-TMP_FS_SIZE ?= "500M"
-TMP_FS_MODE ?= "755"
-TMP_FS_OPTIONS = "nodev,nosuid,size=${TMP_FS_SIZE},mode=${TMP_FS_MODE}"
-
-TEMPLATE_FILES = "tmp.mount.tmpl"
-TEMPLATE_VARS += "TMP_FS_OPTIONS"
-
-do_install[cleandirs]+="${D}/lib/systemd/system"
-do_install() {
-    install -m 0644 ${WORKDIR}/tmp.mount ${D}/lib/systemd/system/tmp.mount
-}
diff --git a/recipes-core/tmp-fs/tmp-fs_0.2.bb b/recipes-core/tmp-fs/tmp-fs_0.2.bb
new file mode 100644
index 0000000..bb5fcce
--- /dev/null
+++ b/recipes-core/tmp-fs/tmp-fs_0.2.bb
@@ -0,0 +1,16 @@
+#
+# CIP Core, generic profile
+#
+# Copyright (c) Siemens AG, 2021
+#
+# Authors:
+#  Quirin Gylstorff <quirin.gylstorff@siemens.com>
+#
+# SPDX-License-Identifier: MIT
+
+inherit dpkg-raw
+
+SRC_URI = "file://postinst"
+
+do_install() {
+}
-- 
2.35.1


