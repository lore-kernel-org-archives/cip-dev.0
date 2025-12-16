Return-Path: <quirin.gylstorff@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5C9DD5C0D1
	for <webhook@archiver.kernel.org>; Tue, 16 Dec 2025 08:26:13 +0000 (UTC)
Received: from mta-65-227.siemens.flowmailer.net (mta-65-227.siemens.flowmailer.net [185.136.65.227])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.17704.1765873563271796138
 for <cip-dev@lists.cip-project.org>;
 Tue, 16 Dec 2025 00:26:04 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=Quirin.Gylstorff@siemens.com header.s=fm2 header.b=WRGkUQha;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.65.227, mailfrom: fm-51332-20251216082600325f472fa900020751-kntt_f@rts-flowmailer.siemens.com)
Received: by mta-65-227.siemens.flowmailer.net with ESMTPSA id 20251216082600325f472fa900020751
        for <cip-dev@lists.cip-project.org>;
        Tue, 16 Dec 2025 09:26:00 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm2;
 d=siemens.com; i=Quirin.Gylstorff@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:References:In-Reply-To;
 bh=eMDnifSRInDqsuGGzScEPLkr9jAQlJBuCaac6ESja+I=;
 b=WRGkUQharYYifOKd26vOitclGkdtQJZd4MV94SY+9RFF+6Tt0GokWLqNA/ABCdDdH8Gbf0
 WZBIjVk9d558kYVCxH5o333YAswSRo0XRWeaJhCZ+g6Ffimsp5qVR7M8JSS7/VCYPqeK7AYc
 jCV8fb0fyDw0H6GW88iORu6DwAi46F/9qL97iQQTn3A4GQY3jrNwWqPCqVnMRA4GW1w2+kZP
 6Ys0JpFWR4dXSzT3/wPNHMaVTzW0+3wlqYf0h2fgXpD3yUna2865cjZA/Im2qZCPj0fCgxO/
 QUU7FHOj9g+IxyyRq+9EaByqQPcoulwKhvFHYrukm/LD7olJtXxxRSDw==;
From: Quirin Gylstorff <Quirin.Gylstorff@siemens.com>
To: jan.kiszka@siemens.com,
	cip-dev@lists.cip-project.org
Subject: [cip-dev][isar-cip-core][PATCH v3 4/4] fix: ensure separate root home dir is recreated after factory-reset
Date: Tue, 16 Dec 2025 09:25:46 +0100
Message-ID: <20251216082559.327416-5-Quirin.Gylstorff@siemens.com>
In-Reply-To: <20251216082559.327416-1-Quirin.Gylstorff@siemens.com>
References: <20251216082559.327416-1-Quirin.Gylstorff@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-51332:519-21489:flowmailer
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 16 Dec 2025 08:26:13 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/21073

From: Quirin Gylstorff <quirin.gylstorff@siemens.com>

If the option `separate-home-part` is used the home partition is deleted
during a factory-reset. To ensure that the root home directory is
available recreate the directory via tmpfiles.

Additional user directories need to be addressed the same.

Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
---
 .../change-root-homedir_0.1.bb                | 15 -----------
 .../change-root-homedir_0.2.bb                | 27 +++++++++++++++++++
 2 files changed, 27 insertions(+), 15 deletions(-)
 delete mode 100644 recipes-core/change-root-homedir/change-root-homedir_0.1.bb
 create mode 100644 recipes-core/change-root-homedir/change-root-homedir_0.2.bb

diff --git a/recipes-core/change-root-homedir/change-root-homedir_0.1.bb b/recipes-core/change-root-homedir/change-root-homedir_0.1.bb
deleted file mode 100644
index 79c7e67..0000000
--- a/recipes-core/change-root-homedir/change-root-homedir_0.1.bb
+++ /dev/null
@@ -1,15 +0,0 @@
-#
-# CIP Core, generic profile
-#
-# Copyright (c) Siemens AG, 2021-2023
-#
-# Authors:
-#  Henning Schild <henning.schild@siemens.com>
-#
-# SPDX-License-Identifier: MIT
-
-inherit dpkg-raw
-
-DESCRIPTION = "Move roots homedir to /home for read-only rootfs"
-
-SRC_URI = "file://postinst"
diff --git a/recipes-core/change-root-homedir/change-root-homedir_0.2.bb b/recipes-core/change-root-homedir/change-root-homedir_0.2.bb
new file mode 100644
index 0000000..3cd415c
--- /dev/null
+++ b/recipes-core/change-root-homedir/change-root-homedir_0.2.bb
@@ -0,0 +1,27 @@
+#
+# CIP Core, generic profile
+#
+# Copyright (c) Siemens AG, 2021-2023
+#
+# Authors:
+#  Henning Schild <henning.schild@siemens.com>
+#
+# SPDX-License-Identifier: MIT
+
+inherit dpkg-raw
+
+DESCRIPTION = "Move roots homedir to /home for read-only rootfs"
+
+SRC_URI = "file://postinst"
+
+do_prepare_build:append:separate-home-part() {
+    if ! grep -q /home/root ${WORKDIR}/${BPN}.tmpfiles; then
+        echo "d /home/root 0700 root root -" >> ${WORKDIR}/${BPN}.tmpfiles
+    fi
+}
+
+do_prepare_build:append() {
+    if [ -f ${WORKDIR}/${BPN}.tmpfiles ]; then
+        cp ${WORKDIR}/${BPN}.tmpfiles ${S}/debian/
+    fi
+}
-- 
2.51.2


