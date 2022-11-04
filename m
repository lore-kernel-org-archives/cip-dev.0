Return-Path: <quirin.gylstorff@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9F53C433FE
	for <webhook@archiver.kernel.org>; Fri,  4 Nov 2022 13:08:10 +0000 (UTC)
Received: from mta-65-225.siemens.flowmailer.net (mta-65-225.siemens.flowmailer.net [185.136.65.225])
 by mx.groups.io with SMTP id smtpd.web11.10887.1667567279870264566
 for <cip-dev@lists.cip-project.org>;
 Fri, 04 Nov 2022 06:08:01 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=Quirin.Gylstorff@siemens.com header.s=fm1 header.b=R+huCSDp;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.65.225, mailfrom: fm-51332-202211041307577d2624f61a7171b5e0-gbark6@rts-flowmailer.siemens.com)
Received: by mta-65-225.siemens.flowmailer.net with ESMTPSA id 202211041307577d2624f61a7171b5e0
        for <cip-dev@lists.cip-project.org>;
        Fri, 04 Nov 2022 14:07:57 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=Quirin.Gylstorff@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding;
 bh=RmBwwRB0XTqqhEWh5/+BHuEY350H4iByWVDM3g7E9+c=;
 b=R+huCSDpLHNcBL8bgtgY6AZvb4t3jed6nRyeLVkiSGoG7JjCDJ8yENlY+Axqx5q+8a7wcn
 vhVy5Z1QafCDhFk7MdKuNDzO2OYO0GRK2iDr6oiKfn4CwmCcl0cvCfqt6JxMDtT7wBQ7hipg
 usd+9AypVeHz1Jhv3pSXbgf53QHxE=;
From: Quirin Gylstorff <Quirin.Gylstorff@siemens.com>
To: jan.kiszka@siemens.com,
	cip-dev@lists.cip-project.org
Subject: [cip-dev][isar-cip-core][PATCH] tmp-fs: Use systemd tmp.mount
Date: Fri,  4 Nov 2022 14:07:56 +0100
Message-Id: <20221104130756.195716-1-Quirin.Gylstorff@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-51332:519-21489:flowmailer
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 04 Nov 2022 13:08:10 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/9934

From: Quirin Gylstorff <quirin.gylstorff@siemens.com>

Debian moves in [1] the tmp.mount to /usr/share.

To use sane defaults use the by systemd provided version of tmp.mount.

To overwrite the options use a drop-in file as described in [2].

[1]: https://salsa.debian.org/systemd-team/systemd/-/commit/5a9a0e7d25ac7ff0f1113ddb4219cc554b20dffa
[2]: https://www.freedesktop.org/software/systemd/man/systemd.unit.html

Closes https://gitlab.com/cip-project/cip-core/isar-cip-core/-/issues/46

Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
---
 recipes-core/tmp-fs/files/postinst       |  4 ++++
 recipes-core/tmp-fs/files/tmp.mount.tmpl | 11 -----------
 recipes-core/tmp-fs/tmp-fs_0.1.bb        | 12 +-----------
 3 files changed, 5 insertions(+), 22 deletions(-)
 delete mode 100644 recipes-core/tmp-fs/files/tmp.mount.tmpl

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
index b86b0fb..87d04b9 100644
--- a/recipes-core/tmp-fs/tmp-fs_0.1.bb
+++ b/recipes-core/tmp-fs/tmp-fs_0.1.bb
@@ -10,17 +10,7 @@
 
 inherit dpkg-raw
 
-SRC_URI = "file://postinst \
-           file://tmp.mount.tmpl"
+SRC_URI = "file://postinst"
 
-TMP_FS_SIZE ?= "500M"
-TMP_FS_MODE ?= "755"
-TMP_FS_OPTIONS = "nodev,nosuid,size=${TMP_FS_SIZE},mode=${TMP_FS_MODE}"
 
-TEMPLATE_FILES = "tmp.mount.tmpl"
-TEMPLATE_VARS += "TMP_FS_OPTIONS"
 
-do_install[cleandirs]+="${D}/lib/systemd/system"
-do_install() {
-    install -m 0644 ${WORKDIR}/tmp.mount ${D}/lib/systemd/system/tmp.mount
-}
-- 
2.35.1


