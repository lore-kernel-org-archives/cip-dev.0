Return-Path: <quirin.gylstorff@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9CE1AD5B172
	for <webhook@archiver.kernel.org>; Mon, 15 Dec 2025 09:37:33 +0000 (UTC)
Received: from mta-65-225.siemens.flowmailer.net (mta-65-225.siemens.flowmailer.net [185.136.65.225])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.44855.1765791450527653716
 for <cip-dev@lists.cip-project.org>;
 Mon, 15 Dec 2025 01:37:31 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=Quirin.Gylstorff@siemens.com header.s=fm2 header.b=RbNy21vV;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.65.225, mailfrom: fm-51332-2025121509372733087ef64600020747-qfvqmn@rts-flowmailer.siemens.com)
Received: by mta-65-225.siemens.flowmailer.net with ESMTPSA id 2025121509372733087ef64600020747
        for <cip-dev@lists.cip-project.org>;
        Mon, 15 Dec 2025 10:37:28 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm2;
 d=siemens.com; i=Quirin.Gylstorff@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:References:In-Reply-To;
 bh=HKfer5XqZBOjrUoPA/fwD9LSo9Agvb/Hz6YfKrEEm9I=;
 b=RbNy21vVB8wncJchTQYjEXT0hcaANxLQFZXPBwnDhIAwbipKGgsLotlyVMBjAXww3woLz7
 Kwf5CnKD+GliNaI/QS7t02hjAVWgEamkGp8CvyAs+MSZRFGD26K1XWDkE8Mib45tMFhIpwR6
 M7JPO/rJLPpqF2EFtSXNDVmGUwyEuyI17tpG+YUDwZvRK2zGddi27ExC6XoooRgzREhl+F9Q
 d6EkyOc/9J8KnTNllHmQy2XmL1KC8gwtkI4gw8Fz/GpQjtqSDCrNqqz7vs+F3KPaBEwmsguY
 TSz5cq6JFLeZMZyJEO8Ix0IsUQY89MbT4D8XCV2ywL5xgUVXWTeWKzVw==;
From: Quirin Gylstorff <Quirin.Gylstorff@siemens.com>
To: cip-dev@lists.cip-project.org,
	jan.kiszka@siemens.com
Subject: [cip-dev][isar-cip-core][PATCH 3/3] fix: ensure separate root home dir is recreated after factory-reset
Date: Mon, 15 Dec 2025 10:35:54 +0100
Message-ID: <20251215093719.323668-4-Quirin.Gylstorff@siemens.com>
In-Reply-To: <20251215093719.323668-1-Quirin.Gylstorff@siemens.com>
References: <20251215093719.323668-1-Quirin.Gylstorff@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-51332:519-21489:flowmailer
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 15 Dec 2025 09:37:33 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/21033

From: Quirin Gylstorff <quirin.gylstorff@siemens.com>

If the option `separate-home-part` is used the home partition is deleted
during a factory-reset. To ensure that the root home directory is
available recreate it with tmpfiles.

Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
---
 .../change-root-homedir_0.1.bb                | 15 -----------
 .../change-root-homedir_0.2.bb                | 25 +++++++++++++++++++
 .../files/change-root-homedir.tmpfiles        |  0
 3 files changed, 25 insertions(+), 15 deletions(-)
 delete mode 100644 recipes-core/change-root-homedir/change-root-homedir_0.1.bb
 create mode 100644 recipes-core/change-root-homedir/change-root-homedir_0.2.bb
 create mode 100644 recipes-core/change-root-homedir/files/change-root-homedir.tmpfiles

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
index 0000000..0e356cb
--- /dev/null
+++ b/recipes-core/change-root-homedir/change-root-homedir_0.2.bb
@@ -0,0 +1,25 @@
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
+SRC_URI = "file://postinst \
+           file://${BPN}.tmpfiles"
+
+do_prepare_build:append:separate-home-part() {
+    if ! grep -q /home/root ${WORKDIR}/${BPN}.tmpfiles; then
+        echo "d /home/root 0700 root root -" >> ${WORKDIR}/${BPN}.tmpfiles
+    fi
+}
+do_prepare_build:append() {
+    cp ${WORKDIR}/${BPN}.tmpfiles ${S}/debian/
+}
diff --git a/recipes-core/change-root-homedir/files/change-root-homedir.tmpfiles b/recipes-core/change-root-homedir/files/change-root-homedir.tmpfiles
new file mode 100644
index 0000000..e69de29
-- 
2.51.2


