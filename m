Return-Path: <quirin.gylstorff@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 415BACEDDAC
	for <webhook@archiver.kernel.org>; Tue, 18 Nov 2025 15:10:41 +0000 (UTC)
Received: from mta-65-227.siemens.flowmailer.net (mta-65-227.siemens.flowmailer.net [185.136.65.227])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.14661.1763478633905222536
 for <cip-dev@lists.cip-project.org>;
 Tue, 18 Nov 2025 07:10:35 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=Quirin.Gylstorff@siemens.com header.s=fm1 header.b=cXKT8Xjk;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.65.227, mailfrom: fm-51332-20251118151031f217b2b2460002070d-ay4gry@rts-flowmailer.siemens.com)
Received: by mta-65-227.siemens.flowmailer.net with ESMTPSA id 20251118151031f217b2b2460002070d
        for <cip-dev@lists.cip-project.org>;
        Tue, 18 Nov 2025 16:10:31 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=Quirin.Gylstorff@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:References:In-Reply-To;
 bh=PvnnZF0Jutgww9D3G6lfqkmTxgMRHpDhxVY4HIbCgXY=;
 b=cXKT8XjkOb9VofLkgddzoh2Y8Pbwhc0DRBoLLE6BR9cRiNeY7VnH/g2Z5pR3bb8ldGiilr
 ku1mL03hfQCAA+f4D1oRxYMBa8PQ9wi7noMgpbrJickj70D6sJ5sf8z9//0D2ladRCtV5caL
 o1hqyga4sJfFOVoneLypvD3Zhx6z8BozZXWCL/2+mTHUysJDBHgZZN88G/0Vu4LryiXsTxM5
 o/6NKkZlHJ5RsKpOpiyrgxZUoEwnEnYSNE8jmD1rqM/n4zHXinjoOpawvmkdbzyApAudkmTC
 TnEFxtR5B/drgrqLfUQlG4S1Dhsc2WzilKLayPyDTgJUg8NaUgWCtgwg==;
From: Quirin Gylstorff <Quirin.Gylstorff@siemens.com>
To: cip-dev@lists.cip-project.org,
	jan.kiszka@siemens.com
Subject: [cip-dev][isar-cip-core][PATCH v2 1/5] Add cip-functions to initramfs
Date: Tue, 18 Nov 2025 15:14:44 +0100
Message-ID: <20251118151030.504765-2-Quirin.Gylstorff@siemens.com>
In-Reply-To: <20251118151030.504765-1-Quirin.Gylstorff@siemens.com>
References: <20251118151030.504765-1-Quirin.Gylstorff@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-51332:519-21489:flowmailer
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 18 Nov 2025 15:10:41 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/20616

From: Quirin Gylstorff <quirin.gylstorff@siemens.com>

This package installs functions used by multiple initramfs-hooks
introduced in isar-cip-core to de-duplicate code.

Currently the functions are:
- wait_30sec_for_condition used by the hooks for abrootfs and verity rootfs
- find_root_by_part for abrootfs and verity rootfs
- scan_partitions for abrootfs and verity roofs

make increment posix compliant

Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
---
 .../files/cip-initramfs-functions             | 72 +++++++++++++++++++
 .../initramfs-cip-functions_0.1.bb            | 22 ++++++
 2 files changed, 94 insertions(+)
 create mode 100644 recipes-initramfs/initramfs-cip-functions/files/cip-initramfs-functions
 create mode 100644 recipes-initramfs/initramfs-cip-functions/initramfs-cip-functions_0.1.bb

diff --git a/recipes-initramfs/initramfs-cip-functions/files/cip-initramfs-functions b/recipes-initramfs/initramfs-cip-functions/files/cip-initramfs-functions
new file mode 100644
index 0000000..d87bdd0
--- /dev/null
+++ b/recipes-initramfs/initramfs-cip-functions/files/cip-initramfs-functions
@@ -0,0 +1,72 @@
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
+# check condition by calling function given via argument 1
+# if the function does not return true(0) check again
+# every second for up to 30 seconds
+wait_30sec_for_condition() {
+    check_condition="$1"
+    if [ -z "$check_condition" ]; then
+        panic "Argument for function wait_30sec_for_condition is empty"
+        return 0
+    fi
+    time_elapsed=0
+    while true; do
+        sleep 1
+        time_elapsed="$((time_elapsed + 1))"
+        if "$check_condition" ; then
+            log_end_msg 1
+            break
+        fi
+        if [ "${time_elapsed}" -ge 30 ]; then
+            log_end_msg 0
+            break
+        fi
+    done
+}
+
+# check if the device "$ROOT" is valid
+find_root_by_part() {
+    found_root=$(blkid --list-one --output device --match-token "$ROOT")
+    if [ -n "${found_root}" ]; then
+        return 0
+    fi
+    return 1
+}
+
+# This function should be overridden by the user of scan_for_partitions
+find_root_via_image_uuid(){
+    :
+}
+
+# scan partitions for the root device defined by
+# the function find_root_via_image_uuid
+scan_for_partitions() {
+    for part in $(blkid -o device); do
+        unset found
+        for scanned_part in ${scanned_partitions}; do
+            if [ "${scanned_part}" = "${part}" ]; then
+                found=1
+                break
+            fi
+        done
+        if [ -z "${found}" ]; then
+            partitions="${partitions} ${part}"
+        fi
+    done
+    scanned_partitions="${scanned_partitions} ${partitions}"
+    find_root_via_image_uuid "$partitions"
+    if [ -n "${found_root}" ]; then
+        return 0
+    fi
+    return 1
+}
diff --git a/recipes-initramfs/initramfs-cip-functions/initramfs-cip-functions_0.1.bb b/recipes-initramfs/initramfs-cip-functions/initramfs-cip-functions_0.1.bb
new file mode 100644
index 0000000..dc013a0
--- /dev/null
+++ b/recipes-initramfs/initramfs-cip-functions/initramfs-cip-functions_0.1.bb
@@ -0,0 +1,22 @@
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
+inherit dpkg-raw
+
+DPKG_ARCH = "all"
+DESCRIPTION = "helper functions for cip initramfs-tools extensions"
+
+SRC_URI += "file://cip-initramfs-functions"
+
+do_install[cleandirs] += "${D}/usr/share/initramfs-tools/scripts/"
+do_install() {
+    install -m 755 ${WORKDIR}/cip-initramfs-functions ${D}/usr/share/initramfs-tools/scripts/cip-initramfs-functions
+}
-- 
2.51.2


