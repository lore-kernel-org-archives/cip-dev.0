Return-Path: <quirin.gylstorff@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50A97C46467
	for <webhook@archiver.kernel.org>; Tue, 10 Jan 2023 12:01:05 +0000 (UTC)
Received: from mta-64-226.siemens.flowmailer.net (mta-64-226.siemens.flowmailer.net [185.136.64.226])
 by mx.groups.io with SMTP id smtpd.web11.102118.1673352060242244625
 for <cip-dev@lists.cip-project.org>;
 Tue, 10 Jan 2023 04:01:01 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=Quirin.Gylstorff@siemens.com header.s=fm1 header.b=dd1es5Xr;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.64.226, mailfrom: fm-51332-20230110120057654abb77872e3b498e-kmpsnc@rts-flowmailer.siemens.com)
Received: by mta-64-226.siemens.flowmailer.net with ESMTPSA id 20230110120057654abb77872e3b498e
        for <cip-dev@lists.cip-project.org>;
        Tue, 10 Jan 2023 13:00:57 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=Quirin.Gylstorff@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding;
 bh=4fqbcRecZvcAWTac0obKtPhxWTXJQlapjYeESiW2VP8=;
 b=dd1es5XrU46eFyIytFMf1CMGV6QA+UZCVq/VydnmvYKKzrej9YUc5Sk3POClk5aj3huSxA
 OrV1C64NgvHuUtOYNpcUBNfPyO/2DqR7iBaPro2HgssecgKjMVtibtu3KU8j+On/lAsiHldS
 el074Tob6Q9tc6EH/tn8ffXqZl6rY=;
From: Quirin Gylstorff <Quirin.Gylstorff@siemens.com>
To: cip-dev@lists.cip-project.org,
	felix.moessbauer@siemens.com,
	jan.kiszka@siemens.com
Subject: [cip-dev][isar-cip-core][PATCH v2] Create a generic initramfs overlay
Date: Tue, 10 Jan 2023 13:00:55 +0100
Message-Id: <20230110120055.463166-1-Quirin.Gylstorff@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-51332:519-21489:flowmailer
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 10 Jan 2023 12:01:05 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/10336

From: Quirin Gylstorff <quirin.gylstorff@siemens.com>

This allows the user to generate multiple overlays in a given
location.

The configuration used the following variables:
 - INITRAMFS_OVERLAY_STORAGE_PARTITION_LABEL: Label of the partition to store the overlays
 - INITRAMFS_OVERLAY_PATHS: space-separated list of overlay directories (lower overlay directories)
 - INITRAMFS_OVERLAY_STORAGE_PATH: path on the storage partition where the upper directory is stored

e.g.:
```
INITRAMFS_OVERLAY_STORAGE_PARTITION_LABEL ??= "var"
INITRAMFS_OVERLAY_PATHS ??= "etc"
INITRAMFS_OVERLAY_STORAGE_PATH ??= "/var/local"
```
This will create an overlay for `/etc` and store it in `/var/local/etc`.

Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
---

Changes v2:
 - INITRAMFS_OVERLAY_STORAGE_PATH contains the full path
 - updated copyright
 - formatting
 - fix typos in commit message

 .../cip-core-initramfs/cip-core-initramfs.bb  |  4 +-
 .../files/etc-overlay.script                  | 36 ---------------
 .../initramfs-etc-overlay-hook_0.1.bb         | 30 -------------
 .../files/overlay.hook}                       |  0
 .../files/overlay.script.tmpl                 | 45 +++++++++++++++++++
 .../initramfs-overlay-hook_0.1.bb             | 40 +++++++++++++++++
 6 files changed, 87 insertions(+), 68 deletions(-)
 delete mode 100644 recipes-initramfs/initramfs-etc-overlay-hook/files/etc-overlay.script
 delete mode 100644 recipes-initramfs/initramfs-etc-overlay-hook/initramfs-etc-overlay-hook_0.1.bb
 rename recipes-initramfs/{initramfs-etc-overlay-hook/files/etc-overlay.hook => initramfs-overlay-hook/files/overlay.hook} (100%)
 create mode 100644 recipes-initramfs/initramfs-overlay-hook/files/overlay.script.tmpl
 create mode 100644 recipes-initramfs/initramfs-overlay-hook/initramfs-overlay-hook_0.1.bb

diff --git a/recipes-initramfs/cip-core-initramfs/cip-core-initramfs.bb b/recipes-initramfs/cip-core-initramfs/cip-core-initramfs.bb
index 9e0ee26..2935ed8 100644
--- a/recipes-initramfs/cip-core-initramfs/cip-core-initramfs.bb
+++ b/recipes-initramfs/cip-core-initramfs/cip-core-initramfs.bb
@@ -1,7 +1,7 @@
 #
 # CIP Core, generic profile
 #
-# Copyright (c) Siemens AG, 2021
+# Copyright (c) Siemens AG, 2021 - 2023
 #
 # Authors:
 #  Quirin Gylstorff <quirin.gylstorff@siemens.com>
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
index 0000000..dad14f7
--- /dev/null
+++ b/recipes-initramfs/initramfs-overlay-hook/files/overlay.script.tmpl
@@ -0,0 +1,45 @@
+#!/bin/sh
+#
+# CIP Core, generic profile
+#
+# Copyright (c) Siemens AG, 2022-2023
+#
+# Authors:
+#  Jan Kiszka <jan.kiszka@siemens.com>
+#  Quirin Gylstorff <quirin.gylstorff@siemens.com>
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
+ovl_partition_label=${INITRAMFS_OVERLAY_STORAGE_PARTITION_LABEL}
+ovl_storage_path=${rootmnt}${INITRAMFS_OVERLAY_STORAGE_PATH}
+ovl_lower_dirs=${INITRAMFS_OVERLAY_PATHS}
+
+if ! mount -t $(get_fstype /dev/disk/by-label/${ovl_partition_label}) /dev/disk/by-label/${ovl_partition_label} ${rootmnt}/${ovl_partition_label}; then
+	panic "Can't mount /${ovl_partition_label} partition - overlay will not work!"
+fi
+
+for ovl_lower_dir in ${ovl_lower_dirs}; do
+    ovl_atomic_dir=.${ovl_lower_dir}-atomic
+
+    mkdir -p ${ovl_storage_path}/${ovl_lower_dir}
+    mkdir -p ${ovl_storage_path}/${ovl_atomic_dir}
+    if ! mount -t overlay -o lowerdir=${rootmnt}/${ovl_lower_dir},upperdir=${ovl_storage_path}/${ovl_lower_dir},workdir=${ovl_storage_path}/${ovl_atomic_dir} overlay ${rootmnt}/${ovl_lower_dir}; then
+	    panic "Can't mount overlay for '$ovl_lower_dir' !"
+    fi
+done
diff --git a/recipes-initramfs/initramfs-overlay-hook/initramfs-overlay-hook_0.1.bb b/recipes-initramfs/initramfs-overlay-hook/initramfs-overlay-hook_0.1.bb
new file mode 100644
index 0000000..25910b8
--- /dev/null
+++ b/recipes-initramfs/initramfs-overlay-hook/initramfs-overlay-hook_0.1.bb
@@ -0,0 +1,40 @@
+#
+# CIP Core, generic profile
+#
+# Copyright (c) Siemens AG, 2022 - 2023
+#
+# Authors:
+#  Jan Kiszka <jan.kiszka@siemens.com>
+#  Quirin Gylstorff <quirin.gylstorff@siemens.com>
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
+INITRAMFS_OVERLAY_STORAGE_PATH ??= "/var/local"
+
+TEMPLATE_FILES = "overlay.script.tmpl"
+TEMPLATE_VARS += "INITRAMFS_OVERLAY_STORAGE_PARTITION_LABEL \
+    INITRAMFS_OVERLAY_STORAGE_PATH \
+    INITRAMFS_OVERLAY_PATHS"
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
2.39.0


