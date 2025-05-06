Return-Path: <quirin.gylstorff@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3FDCC3ABC3
	for <webhook@archiver.kernel.org>; Tue,  6 May 2025 12:08:14 +0000 (UTC)
Received: from mta-65-226.siemens.flowmailer.net (mta-65-226.siemens.flowmailer.net [185.136.65.226])
 by mx.groups.io with SMTP id smtpd.web10.74172.1746533291063258887
 for <cip-dev@lists.cip-project.org>;
 Tue, 06 May 2025 05:08:11 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=Quirin.Gylstorff@siemens.com header.s=fm1 header.b=NFRcFfTT;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.65.226, mailfrom: fm-51332-202505061208081aa454a13c92e75b74-ynhl0d@rts-flowmailer.siemens.com)
Received: by mta-65-226.siemens.flowmailer.net with ESMTPSA id 202505061208081aa454a13c92e75b74
        for <cip-dev@lists.cip-project.org>;
        Tue, 06 May 2025 14:08:08 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=Quirin.Gylstorff@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:References:In-Reply-To;
 bh=pjF5gj+jStI674RRNUT7v6HPA5IXrIhjgJ206uOE/HI=;
 b=NFRcFfTTmKNYbqXbZ+m4Dy96pfJ1oLpqu1auO7YSAU45VPvZ/nzb3J82bjjH+I+EmgQc4s
 XB4UpMxToPPcKKBKPqG0JZ3v4EyHqi0d6DVS7+rSn3WKzn/jP0kNXqmX7b/tnS6wzOBxTp2I
 s+uq+U8odOsQyseQlLJ9Lxx0NahfU0Y4JuH3BV5iWtjN5tgymiXx6IsKAKCunqmpRo/bRa90
 QUnj/ES5VZKsOFtVuyz5BR5zvAVxQLZ9cWDuCx5NSwAArjhxk7kI7boyMSsXM+zjouSV3xAY
 MVAmRGouFQgqs6uiuF1jcH8SgukWmuj0Pvm1TL2newDsY0WbL3qlmblg==;
From: Quirin Gylstorff <Quirin.Gylstorff@siemens.com>
To: cip-dev@lists.cip-project.org,
	jan.kiszka@siemens.com
Subject: [cip-dev][isar-cip-core][RFC v2 2/6] add factory-reset-helper to set the marker file
Date: Tue,  6 May 2025 14:07:44 +0200
Message-ID: <20250506120807.255675-3-Quirin.Gylstorff@siemens.com>
In-Reply-To: <20250506120807.255675-1-Quirin.Gylstorff@siemens.com>
References: <20250506120807.255675-1-Quirin.Gylstorff@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-51332:519-21489:flowmailer
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 06 May 2025 12:08:14 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/18768

From: Quirin Gylstorff <quirin.gylstorff@siemens.com>

This adds an helper script
`/usr/lib/factory-reset/set-factory-reset-marker` which writes the marker file to
the correct location.

Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
---
 .../factory-reset-helper_0.1.bb               | 34 +++++++++++++++++++
 .../files/set-factory-reset-marker.sh.tmpl    | 28 +++++++++++++++
 2 files changed, 62 insertions(+)
 create mode 100644 recipes-support/factory-reset-helper/factory-reset-helper_0.1.bb
 create mode 100644 recipes-support/factory-reset-helper/files/set-factory-reset-marker.sh.tmpl

diff --git a/recipes-support/factory-reset-helper/factory-reset-helper_0.1.bb b/recipes-support/factory-reset-helper/factory-reset-helper_0.1.bb
new file mode 100644
index 0000000..72cf5fd
--- /dev/null
+++ b/recipes-support/factory-reset-helper/factory-reset-helper_0.1.bb
@@ -0,0 +1,34 @@
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
+DPKG_ARCH = "all"
+DESCRIPTION = "helper script to execute a factory reset with a file"
+
+# if this file exists execute a factory reset for the given
+# list of factory-reset targets.
+INITRAMFS_FACTORY_RESET_MARKER ?= ".factory-reset"
+# use labels as crypt setup replaces the label links if
+# an partition is encrypted
+INITRAMFS_FACTORY_RESET_MARKER_STORAGE_DEVICE ??= "/dev/disk/by-partlabel/var"
+
+SRC_URI = "file://set-factory-reset-marker.sh.tmpl"
+
+TEMPLATE_FILES += "set-factory-reset-marker.sh.tmpl"
+TEMPLATE_VARS += " INITRAMFS_FACTORY_RESET_MARKER \
+                   INITRAMFS_FACTORY_RESET_MARKER_STORAGE_DEVICE"
+DEBIAN_DEPENDS .= ", coreutils, util-linux"
+
+do_install[cleandirs] += "${D}/usr/lib/factory-reset/"
+do_install:prepend() {
+    install -m 0755 "${WORKDIR}/set-factory-reset-marker.sh" \
+        "${D}/usr/lib/factory-reset/"
+}
+
diff --git a/recipes-support/factory-reset-helper/files/set-factory-reset-marker.sh.tmpl b/recipes-support/factory-reset-helper/files/set-factory-reset-marker.sh.tmpl
new file mode 100644
index 0000000..eacb8fb
--- /dev/null
+++ b/recipes-support/factory-reset-helper/files/set-factory-reset-marker.sh.tmpl
@@ -0,0 +1,28 @@
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
+
+
+marker="$(basename "${INITRAMFS_FACTORY_RESET_MARKER}")"
+marker_storage_device="${INITRAMFS_FACTORY_RESET_MARKER_STORAGE_DEVICE}"
+
+marker_mnt="$(findmnt  --first-only --output TARGET --noheadings "${marker_storage_device}")"
+tmp_mnt=$(mktemp -d)
+if [ -z "$marker_mnt" ]; then
+  mount "${marker_storage_device}" "$tmp_mnt"
+  marker_mnt="${tmp_mnt}"
+fi
+touch "${marker_mnt}/${marker}"
+
+if mountpoint -q "$tmp_mnt"; then
+   umount "$tmp_mnt"
+fi
+rmdir "$tmp_mnt"
+
-- 
2.47.0


