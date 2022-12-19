Return-Path: <quirin.gylstorff@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2BC5BC4332F
	for <webhook@archiver.kernel.org>; Mon, 19 Dec 2022 13:21:26 +0000 (UTC)
Received: from mta-65-225.siemens.flowmailer.net (mta-65-225.siemens.flowmailer.net [185.136.65.225])
 by mx.groups.io with SMTP id smtpd.web10.21292.1671456083072276859
 for <cip-dev@lists.cip-project.org>;
 Mon, 19 Dec 2022 05:21:24 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=Quirin.Gylstorff@siemens.com header.s=fm1 header.b=qZGdSoks;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.65.225, mailfrom: fm-51332-202212191321196113d426f63269ec2d-1uq2hv@rts-flowmailer.siemens.com)
Received: by mta-65-225.siemens.flowmailer.net with ESMTPSA id 202212191321196113d426f63269ec2d
        for <cip-dev@lists.cip-project.org>;
        Mon, 19 Dec 2022 14:21:20 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=Quirin.Gylstorff@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding;
 bh=+y9wdL97yWKkmHzvB/p0/v5MWOG/SAnMLxwhaJfvuCU=;
 b=qZGdSoks7udsVf5pN7SNXlLcmmE3OhQDrjUXndNoj30//gaMlZ14J5n2szqM/Hza01D2tz
 MvDpg0O/z1VnWUmECyr72hPpM/1OBKmy2smnkSDgNAL6Ag6XfhdFPQGKU1wYgcrLNjAtUPMH
 /9hGkWE/qCeDSdkOoUpmVZQgXuktc=;
From: Quirin Gylstorff <Quirin.Gylstorff@siemens.com>
To: cip-dev@lists.cip-project.org,
	felix.moessbauer@siemens.com,
	jan.kiszka@siemens.com
Subject: [cip-dev][isar-cip-core][RFC] Create a generic initramfs overlay
Date: Mon, 19 Dec 2022 14:21:18 +0100
Message-Id: <20221219132118.325050-1-Quirin.Gylstorff@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-51332:519-21489:flowmailer
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 19 Dec 2022 13:21:26 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/10250

From: Quirin Gylstorff <quirin.gylstorff@siemens.com>

This allows the user to generate multible overlays in a given
location.

The configuration used the following variables:
 - INITRAMFS_OVERLAY_STORAGE_PARTITION_LABEL: Label of the partition to store the overlays
 - INITRAMFS_OVERLAY_PATHS: space separated list of overlay directories (lower overlay directories)
 - INITRAMFS_OVERLAY_STORAGE_PATH: path on the storage partition where the upper directory is stored

e.g.:
```
INITRAMFS_OVERLAY_STORAGE_PARTITION_LABEL ??= "var"
INITRAMFS_OVERLAY_PATHS ??= "etc"
INITRAMFS_OVERLAY_STORAGE_PATH ??= "local"
```
This will create an overlay for `/etc` and store it in `/var/local/etc`.

Closes: https://gitlab.com/cip-project/cip-core/isar-cip-core/-/issues/52

Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
---
 .../cip-core-initramfs/cip-core-initramfs.bb  |  2 +-
 .../files/etc-overlay.script                  | 36 --------------
 .../initramfs-etc-overlay-hook_0.1.bb         | 30 ------------
 .../files/overlay.hook}                       |  0
 .../files/overlay.script.tmpl                 | 47 +++++++++++++++++++
 .../initramfs-overlay-hook_0.1.bb             | 37 +++++++++++++++
 6 files changed, 85 insertions(+), 67 deletions(-)
 delete mode 100644 recipes-initramfs/initramfs-etc-overlay-hook/files/etc-overlay.script
 delete mode 100644 recipes-initramfs/initramfs-etc-overlay-hook/initramfs-etc-overlay-hook_0.1.bb
 rename recipes-initramfs/{initramfs-etc-overlay-hook/files/etc-overlay.hook => initramfs-overlay-hook/files/overlay.hook} (100%)
 create mode 100644 recipes-initramfs/initramfs-overlay-hook/files/overlay.script.tmpl
 create mode 100644 recipes-initramfs/initramfs-overlay-hook/initramfs-overlay-hook_0.1.bb

diff --git a/recipes-initramfs/cip-core-initramfs/cip-core-initramfs.bb b/recipes-initramfs/cip-core-initramfs/cip-core-initramfs.bb
index 9e0ee26..860021d 100644
--- a/recipes-initramfs/cip-core-initramfs/cip-core-initramfs.bb
+++ b/recipes-initramfs/cip-core-initramfs/cip-core-initramfs.bb
@@ -12,5 +12,5 @@
 inherit initramfs
 
 INITRAMFS_INSTALL += " \
-    initramfs-etc-overlay-hook \
+    initramfs-overlay-hook \
     "
diff --git a/recipes-initramfs/initramfs-etc-overlay-hook/files/etc-overlay.script b/recipes-initramfs/initramfs-etc-overlay-hook/files/etc-overlay.script
deleted file mode 100644
index 6e5aacd..0000000
--- a/recipes-initramfs/initramfs-etc-overlay-hook/files/etc-overlay.script
+++ /dev/null
@@ -1,36 +0,0 @@
-#!/bin/sh
-#
-# CIP Core, generic profile
-#
-# Copyright (c) Siemens AG, 2022
-#
-# Authors:
-#  Jan Kiszka <jan.kiszka@siemens.com>
-#
-
-PREREQ=""
-
-prereqs()
-{
-	echo "$PREREQ"
-}
-
-case $1 in
-# get pre-requisites
-prereqs)
-	prereqs
-	exit 0
-	;;
-esac
-
-. /scripts/functions
-
-if ! mount -t $(get_fstype /dev/disk/by-label/var) /dev/disk/by-label/var ${rootmnt}/var; then
-	panic "Can't mount /var partition - overlay will not work!"
-fi
-
-mkdir -p ${rootmnt}/var/local/etc
-mkdir -p ${rootmnt}/var/local/.atomic
-if ! mount -t overlay -o lowerdir=${rootmnt}/etc,upperdir=${rootmnt}/var/local/etc,workdir=${rootmnt}/var/local/.atomic overlay ${rootmnt}/etc; then
-	panic "Can't mount overlay!"
-fi
diff --git a/recipes-initramfs/initramfs-etc-overlay-hook/initramfs-etc-overlay-hook_0.1.bb b/recipes-initramfs/initramfs-etc-overlay-hook/initramfs-etc-overlay-hook_0.1.bb
deleted file mode 100644
index 37a04ec..0000000
--- a/recipes-initramfs/initramfs-etc-overlay-hook/initramfs-etc-overlay-hook_0.1.bb
+++ /dev/null
@@ -1,30 +0,0 @@
-#
-# CIP Core, generic profile
-#
-# Copyright (c) Siemens AG, 2022
-#
-# Authors:
-#  Jan Kiszka <jan.kiszka@siemens.com>
-#
-# SPDX-License-Identifier: MIT
-#
-
-inherit dpkg-raw
-
-SRC_URI += " \
-    file://etc-overlay.hook \
-    file://etc-overlay.script \
-    "
-
-DEBIAN_DEPENDS = "initramfs-tools"
-
-do_install[cleandirs] += " \
-    ${D}/usr/share/initramfs-tools/hooks \
-    ${D}/usr/share/initramfs-tools/scripts/local-bottom"
-
-do_install() {
-    install -m 0755 "${WORKDIR}/etc-overlay.hook" \
-        "${D}/usr/share/initramfs-tools/hooks/etc-overlay"
-    install -m 0755 "${WORKDIR}/etc-overlay.script" \
-        "${D}/usr/share/initramfs-tools/scripts/local-bottom/etc-overlay"
-}
diff --git a/recipes-initramfs/initramfs-etc-overlay-hook/files/etc-overlay.hook b/recipes-initramfs/initramfs-overlay-hook/files/overlay.hook
similarity index 100%
rename from recipes-initramfs/initramfs-etc-overlay-hook/files/etc-overlay.hook
rename to recipes-initramfs/initramfs-overlay-hook/files/overlay.hook
diff --git a/recipes-initramfs/initramfs-overlay-hook/files/overlay.script.tmpl b/recipes-initramfs/initramfs-overlay-hook/files/overlay.script.tmpl
new file mode 100644
index 0000000..7acabbe
--- /dev/null
+++ b/recipes-initramfs/initramfs-overlay-hook/files/overlay.script.tmpl
@@ -0,0 +1,47 @@
+#!/bin/sh
+#
+# CIP Core, generic profile
+#
+# Copyright (c) Siemens AG, 2022
+#
+# Authors:
+#  Jan Kiszka <jan.kiszka@siemens.com>
+#
+
+PREREQ=""
+
+prereqs()
+{
+	echo "$PREREQ"
+}
+
+case $1 in
+# get pre-requisites
+prereqs)
+	prereqs
+	exit 0
+	;;
+esac
+
+. /scripts/functions
+
+ovl_upper_dir_partition=${INITRAMFS_OVERLAY_STORAGE_PARTITION_LABEL}
+if [ -n "${INITRAMFS_OVERLAY_STORAGE_PATH}" ]; then
+    ovl_path=${rootmnt}/${ovl_upper_dir_partition}/${INITRAMFS_OVERLAY_STORAGE_PATH}
+else
+    ovl_path=${rootmnt}/${ovl_upper_dir_partition}
+fi
+
+if ! mount -t $(get_fstype /dev/disk/by-label/${ovl_upper_dir_partition}) /dev/disk/by-label/${ovl_upper_dir_partition} ${rootmnt}/${ovl_upper_dir_partition}; then
+	panic "Can't mount /${ovl_upper_dir_partition} partition - overlay will not work!"
+fi
+
+for ovl_lower_dir in ${INITRAMFS_OVERLAY_PATHS}; do
+    ovl_atomic_dir=.${ovl_lower_dir}-atomic
+
+    mkdir -p ${ovl_path}/${ovl_lower_dir}
+    mkdir -p ${ovl_path}/${ovl_atomic_dir}
+    if ! mount -t overlay -o lowerdir=${rootmnt}/${ovl_lower_dir},upperdir=${ovl_path}/${ovl_lower_dir},workdir=${ovl_path}/${ovl_atomic_dir} overlay ${rootmnt}/${ovl_lower_dir}; then
+	    panic "Can't mount overlay for '$ovl_lower_dir' !"
+    fi
+done
diff --git a/recipes-initramfs/initramfs-overlay-hook/initramfs-overlay-hook_0.1.bb b/recipes-initramfs/initramfs-overlay-hook/initramfs-overlay-hook_0.1.bb
new file mode 100644
index 0000000..ee8635a
--- /dev/null
+++ b/recipes-initramfs/initramfs-overlay-hook/initramfs-overlay-hook_0.1.bb
@@ -0,0 +1,37 @@
+#
+# CIP Core, generic profile
+#
+# Copyright (c) Siemens AG, 2022
+#
+# Authors:
+#  Jan Kiszka <jan.kiszka@siemens.com>
+#
+# SPDX-License-Identifier: MIT
+#
+
+inherit dpkg-raw
+
+SRC_URI += " \
+    file://overlay.hook \
+    file://overlay.script.tmpl \
+    "
+
+INITRAMFS_OVERLAY_STORAGE_PARTITION_LABEL ??= "var"
+INITRAMFS_OVERLAY_PATHS ??= "etc"
+INITRAMFS_OVERLAY_STORAGE_PATH ??= "local"
+
+TEMPLATE_FILES = "overlay.script.tmpl"
+TEMPLATE_VARS += "INITRAMFS_OVERLAY_STORAGE_PARTITION_LABEL INITRAMFS_OVERLAY_STORAGE_PATH INITRAMFS_OVERLAY_PATHS"
+
+DEBIAN_DEPENDS = "initramfs-tools"
+
+do_install[cleandirs] += " \
+    ${D}/usr/share/initramfs-tools/hooks \
+    ${D}/usr/share/initramfs-tools/scripts/local-bottom"
+
+do_install() {
+    install -m 0755 "${WORKDIR}/overlay.hook" \
+        "${D}/usr/share/initramfs-tools/hooks/overlay"
+    install -m 0755 "${WORKDIR}/overlay.script" \
+        "${D}/usr/share/initramfs-tools/scripts/local-bottom/overlay"
+}
-- 
2.35.1


