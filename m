Return-Path: <alexander.heinisch@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27CF5C83037
	for <webhook@archiver.kernel.org>; Mon, 30 Jun 2025 18:15:42 +0000 (UTC)
Received: from mta-65-226.siemens.flowmailer.net (mta-65-226.siemens.flowmailer.net [185.136.65.226])
 by mx.groups.io with SMTP id smtpd.web11.47807.1751307331090766758
 for <cip-dev@lists.cip-project.org>;
 Mon, 30 Jun 2025 11:15:32 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=alexander.heinisch@siemens.com header.s=fm1 header.b=jbUTJPU3;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.65.226, mailfrom: fm-1330684-20250630181528726147f9638853aac1-eafpxd@rts-flowmailer.siemens.com)
Received: by mta-65-226.siemens.flowmailer.net with ESMTPSA id 20250630181528726147f9638853aac1
        for <cip-dev@lists.cip-project.org>;
        Mon, 30 Jun 2025 20:15:28 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=alexander.heinisch@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=EK/5SMEBfG4PdBIBWf6p66hTfWUjUnWmCaqbTYeidVo=;
 b=jbUTJPU3MonRVt5wlSyhNEFXCaMVwFKG9xFdRBZ+oXPOsnBnK+qHvLOW6ASORgNsAD8mcf
 gcHi1woCuVEF8LBYr31I9YBauTzIckYaaoMbU8VGBPzpuJLfnp6d7gwcQzCvztL+Q5Syo9bU
 Wgbq9fBUcwU2MkieBmjWHXv7ePDbkyfTCYmzDWyXSiq40OVX1Ke5nHdAxXuImjtEjHs9ffhV
 jP3dp8/YXrXDVl4gRmIIfGo9i41DQ5GCe2vr2M4CMr5x7A04e3IXUWRP5LBOXAJK6yMEf8iw
 mcP7Ekpobv31IllSgNdKifE2YQWW0qRI989zylMjJTcs1GTnnIEUE20Q==;
From: alexander.heinisch@siemens.com
To: cip-dev@lists.cip-project.org
Cc: jan.kiszka@siemens.com,
	quirin.gylstorff@siemens.com,
	felix.moessbauer@siemens.com,
	Alexander Heinisch <alexander.heinisch@siemens.com>
Subject: [isar-cip-core][RFC 5/7] Added recipe to handle persistent /etc/machine-id backed on /var.
Date: Mon, 30 Jun 2025 20:15:14 +0200
Message-Id: <20250630181516.1718712-6-alexander.heinisch@siemens.com>
In-Reply-To: <20250630181516.1718712-1-alexander.heinisch@siemens.com>
References: <20250630181516.1718712-1-alexander.heinisch@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-1330684:519-21489:flowmailer
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 30 Jun 2025 18:15:42 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/19261

From: Alexander Heinisch <alexander.heinisch@siemens.com>

Signed-off-by: Alexander Heinisch <alexander.heinisch@siemens.com>
---
 Kconfig                                       | 12 ++++++
 kas/opt/machine-id-on-var.yml                 | 17 +++++++++
 .../override.conf                             |  9 +++++
 .../etc/tmpfiles.d/10-mutable-machine-id.conf |  7 ++++
 .../readonly-etc-support/files/postinst       | 10 +++++
 .../readonly-etc-support/machine-id-on-var.bb | 37 +++++++++++++++++++
 6 files changed, 92 insertions(+)
 create mode 100644 kas/opt/machine-id-on-var.yml
 create mode 100644 recipes-security/readonly-etc-support/files/etc/systemd/system/systemd-machine-id-commit.service.d/override.conf
 create mode 100644 recipes-security/readonly-etc-support/files/etc/tmpfiles.d/10-mutable-machine-id.conf
 create mode 100755 recipes-security/readonly-etc-support/files/postinst
 create mode 100644 recipes-security/readonly-etc-support/machine-id-on-var.bb

diff --git a/Kconfig b/Kconfig
index e1bfd1f..c38c341 100644
--- a/Kconfig
+++ b/Kconfig
@@ -283,6 +283,18 @@ config KAS_INCLUDE_READONLY_ETC
 	string
 	default "kas/opt/readonly-etc.yml" if IMAGE_READONLY_ETC
 
+if IMAGE_READONLY_ETC
+
+config MACHINE_ID_ON_VAR
+	bool "Persist machine-id on var"
+
+config KAS_INCLUDE_MACHINE_ID_ON_VAR
+	string
+	default "kas/opt/machine-id-on-var.yml"
+	depends on MACHINE_ID_ON_VAR
+
+endif
+
 config KAS_INCLUDE_DATA_ENCRYPTION
 	string
 	default "kas/opt/encrypt-data.yml" if IMAGE_DATA_ENCRYPTION
diff --git a/kas/opt/machine-id-on-var.yml b/kas/opt/machine-id-on-var.yml
new file mode 100644
index 0000000..48b90f3
--- /dev/null
+++ b/kas/opt/machine-id-on-var.yml
@@ -0,0 +1,17 @@
+#
+# CIP Core, generic profile
+#
+# Copyright (c) Siemens AG, 2025
+#
+# Authors:
+#  Alexander Heinisch <alexander.heinisch@siemens.com>
+#
+# SPDX-License-Identifier: MIT
+#
+
+header:
+  version: 14
+
+local_conf_header:
+  package-machine-id-on-var: |
+    IMAGE_INSTALL:append = " machine-id-on-var"
diff --git a/recipes-security/readonly-etc-support/files/etc/systemd/system/systemd-machine-id-commit.service.d/override.conf b/recipes-security/readonly-etc-support/files/etc/systemd/system/systemd-machine-id-commit.service.d/override.conf
new file mode 100644
index 0000000..b2cb65e
--- /dev/null
+++ b/recipes-security/readonly-etc-support/files/etc/systemd/system/systemd-machine-id-commit.service.d/override.conf
@@ -0,0 +1,9 @@
+[Unit]
+ConditionPathIsReadWrite=
+ConditionPathIsReadWrite=/var/mutable/etc/
+ConditionPathIsMountPoint=
+ConditionPathIsMountPoint=/var/mutable/etc/machine-id
+
+[Service]
+ExecStart=
+ExecStart=systemd-machine-id-setup --commit --root=/var/mutable/
diff --git a/recipes-security/readonly-etc-support/files/etc/tmpfiles.d/10-mutable-machine-id.conf b/recipes-security/readonly-etc-support/files/etc/tmpfiles.d/10-mutable-machine-id.conf
new file mode 100644
index 0000000..f45ec9b
--- /dev/null
+++ b/recipes-security/readonly-etc-support/files/etc/tmpfiles.d/10-mutable-machine-id.conf
@@ -0,0 +1,7 @@
+# create files and directories if don't exist
+d /var/mutable/etc                            0775 root root -
+f /var/mutable/etc/machine-id                 0444 root root -
+
+# adjust mode and ownership on individual files and directories
+z /var/mutable/etc                            0775 root root -
+z /var/mutable/etc/machine-id                 0444 root root -
diff --git a/recipes-security/readonly-etc-support/files/postinst b/recipes-security/readonly-etc-support/files/postinst
new file mode 100755
index 0000000..1563768
--- /dev/null
+++ b/recipes-security/readonly-etc-support/files/postinst
@@ -0,0 +1,10 @@
+#!/bin/sh
+set -e
+
+if [ -f /etc/machine-id ]; then
+    mv /etc/machine-id /var/mutable/etc/machine-id
+else
+    touch /var/mutable/etc/machine-id
+fi
+
+ln -s ../var/mutable/etc/machine-id /etc/machine-id
diff --git a/recipes-security/readonly-etc-support/machine-id-on-var.bb b/recipes-security/readonly-etc-support/machine-id-on-var.bb
new file mode 100644
index 0000000..1951120
--- /dev/null
+++ b/recipes-security/readonly-etc-support/machine-id-on-var.bb
@@ -0,0 +1,37 @@
+#
+# CIP Core, generic profile
+#
+# Copyright (c) Siemens AG, 2025
+#
+# Authors:
+#  Alexander Heinisch <alexander.heinisch@siemens.com>
+#
+# SPDX-License-Identifier: MIT
+#
+
+inherit dpkg-raw
+
+DESCRIPTION = "Persist /etc/machine-id on /var/mutable."
+MAINTAINER = "Alexander Heinisch <alexander.heinisch@siemens.com>"
+
+DEBIAN_DEPENDS = "systemd"
+
+SRC_URI = " \
+    file://etc/tmpfiles.d/10-mutable-machine-id.conf \
+    file://etc/systemd/system/systemd-machine-id-commit.service.d/override.conf \
+    file://postinst \
+    "
+
+do_install[cleandirs] = " \
+    ${D}/etc/ \
+    ${D}/etc/tmpfiles.d/ \
+    ${D}/etc/systemd/system/systemd-machine-id-commit.service.d/ \
+    ${D}/var/mutable/etc/ \
+    "
+
+
+do_install() {
+    install -v -m 644 ${WORKDIR}/etc/tmpfiles.d/10-mutable-machine-id.conf ${D}/etc/tmpfiles.d/
+
+    install -v -m 644 ${WORKDIR}/etc/systemd/system/systemd-machine-id-commit.service.d/override.conf ${D}/etc/systemd/system/systemd-machine-id-commit.service.d/
+}
-- 
2.39.5


