Return-Path: <quirin.gylstorff@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64D77C83F03
	for <webhook@archiver.kernel.org>; Wed,  2 Jul 2025 19:47:59 +0000 (UTC)
Received: from mta-64-227.siemens.flowmailer.net (mta-64-227.siemens.flowmailer.net [185.136.64.227])
 by mx.groups.io with SMTP id smtpd.web11.5586.1751485673219454925
 for <cip-dev@lists.cip-project.org>;
 Wed, 02 Jul 2025 12:47:54 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=Quirin.Gylstorff@siemens.com header.s=fm1 header.b=ZZMV3ycn;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.64.227, mailfrom: fm-51332-2025070219474802b29894b328713985-dozkij@rts-flowmailer.siemens.com)
Received: by mta-64-227.siemens.flowmailer.net with ESMTPSA id 2025070219474802b29894b328713985
        for <cip-dev@lists.cip-project.org>;
        Wed, 02 Jul 2025 21:47:48 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=Quirin.Gylstorff@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding;
 bh=tCN31jM1i1simjcRODrr/tM/yIAMgI6YVRYErAQWB48=;
 b=ZZMV3ycnXit0gJvrRaGIWtqkOTvu6oa6Dcz/meNMEZOY17GkRvLgw2vsMIL72uMOATqq/f
 EIgEgeiyfNvQo74Cv0xzbaIKfzistajS+QGqjst9fDtLj/3Uf90KRxBVMg+ZVsxsXhfy9kO+
 dubMV2WGhh8jrKxE4Ij06o4KiWrzdxhDF0ORyUUeeadUY0ynhlDdR6iCHhSnCJ3LizLB4Atp
 trwfhJTuKneUHE3KdNYwAcFVy5gR4v/P5IRMVke+zlgJzHjVnDajsG5qtdKiCX/2pyNUUSN1
 7tTrSXe3IUdcWY/7tK/hPPpj6pfXWxEydz44gpvh7fQaDYWk+ZbfJPgg==;
From: Quirin Gylstorff <Quirin.Gylstorff@siemens.com>
To: cip-dev@lists.cip-project.org,
	felix.moessbauer@siemens.com,
	jan.kiszka@siemens.com
Subject: [cip-dev][isar-cip-core][PATCH] Enable persistent storage of journald
Date: Wed,  2 Jul 2025 21:44:02 +0200
Message-ID: <20250702194747.21837-1-Quirin.Gylstorff@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-51332:519-21489:flowmailer
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 02 Jul 2025 19:47:59 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/19314

From: Quirin Gylstorff <quirin.gylstorff@siemens.com>

This fixes the persistence of journald with an empty /var.
In the default configuration journald only stores files persistent
if the directory /var/log/journal exists. Since commit 1eb074 the
directory no longer exists.

tpmfiles are not a solution as the systemd-journald-flush service
is executed before systemd-tmpfiles-setup.service.

Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
---
 classes/read-only-rootfs.bbclass               |  4 ++++
 .../files/persistent-journal.conf              |  2 ++
 .../journald-config/journald-config_0.1.bb     | 18 ++++++++++++++++++
 3 files changed, 24 insertions(+)
 create mode 100644 recipes-core/journald-config/files/persistent-journal.conf
 create mode 100644 recipes-core/journald-config/journald-config_0.1.bb

diff --git a/classes/read-only-rootfs.bbclass b/classes/read-only-rootfs.bbclass
index e81084d..78cdf60 100644
--- a/classes/read-only-rootfs.bbclass
+++ b/classes/read-only-rootfs.bbclass
@@ -27,8 +27,12 @@ IMAGE_INSTALL:append:bookworm = " tmp-fs"
 
 # For pre bookworm images, empty /var is not usable
 IMAGE_INSTALL:append = " immutable-rootfs"
+IMAGE_INSTALL:append = " journald-config"
 IMAGE_INSTALL:remove:buster = " immutable-rootfs"
 IMAGE_INSTALL:remove:bullseye = " immutable-rootfs"
+IMAGE_INSTALL:remove:buster = " journald-config"
+IMAGE_INSTALL:remove:bullsye = " journald-config"
+
 
 ROOTFS_POSTPROCESS_COMMAND:append =" copy_dpkg_state"
 ROOTFS_POSTPROCESS_COMMAND:remove:buster =" copy_dpkg_state"
diff --git a/recipes-core/journald-config/files/persistent-journal.conf b/recipes-core/journald-config/files/persistent-journal.conf
new file mode 100644
index 0000000..21dfde0
--- /dev/null
+++ b/recipes-core/journald-config/files/persistent-journal.conf
@@ -0,0 +1,2 @@
+[Journal]
+Storage=persistent
diff --git a/recipes-core/journald-config/journald-config_0.1.bb b/recipes-core/journald-config/journald-config_0.1.bb
new file mode 100644
index 0000000..00dbfce
--- /dev/null
+++ b/recipes-core/journald-config/journald-config_0.1.bb
@@ -0,0 +1,18 @@
+#
+# CIP Core, generic profile
+#
+# Copyright (c) Siemens, 2025
+#
+# Authors:
+#  Quirin Gylstorff <quirin.gylstorff@siemens.com>
+#
+# SPDX-License-Identifier: MIT
+
+inherit dpkg-raw
+
+SRC_URI = "file://persistent-journal.conf"
+
+do_install[cleandirs] = "${D}/usr/lib/systemd/journald.conf.d/"
+do_install() {
+    install -v -m 644 "${WORKDIR}"/persistent-journal.conf ${D}/usr/lib/systemd/journald.conf.d/
+}
-- 
2.47.0


