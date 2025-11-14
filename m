Return-Path: <quirin.gylstorff@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7018DCE7AF3
	for <webhook@archiver.kernel.org>; Fri, 14 Nov 2025 11:20:09 +0000 (UTC)
Received: from mta-65-226.siemens.flowmailer.net (mta-65-226.siemens.flowmailer.net [185.136.65.226])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.15636.1763119206420471259
 for <cip-dev@lists.cip-project.org>;
 Fri, 14 Nov 2025 03:20:07 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=Quirin.Gylstorff@siemens.com header.s=fm1 header.b=YKrYF9yq;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.65.226, mailfrom: fm-51332-202511141120025dccd7e379000207aa-vnxmjs@rts-flowmailer.siemens.com)
Received: by mta-65-226.siemens.flowmailer.net with ESMTPSA id 202511141120025dccd7e379000207aa
        for <cip-dev@lists.cip-project.org>;
        Fri, 14 Nov 2025 12:20:03 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=Quirin.Gylstorff@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:References:In-Reply-To;
 bh=AZ9D5fD3FzC8GW5cLugRLaqh7STxe2rptOj05Tef0uk=;
 b=YKrYF9yqbsdpwpcClEppz131lL6tWBtJLmrQz7NX6WYRKG9rgSkxeo5CRTA2Sae4TQuCvH
 VCJsBABZCr3GaV2fdUN1JhL6D0jsUgqMpA36s6tUonK/MIsMSMsOTZiWisH8DKLXbzFP1s5q
 TGm1vnG0fozXxQOs7ZSJ2igIQBAbaW7pLHiJHvVCbImuWSeBheXCUcNX7bKjHAQueLJGVKp3
 QGew7ZbS5weRE8j4N6k70NX0YtlOZR2EGeyM/IclXLgw1Md6n6NsAppQbRNo+rHIZb1/4uSS
 FDuCf3KhSwi2b6Uw/BxGoqugZPjQZV2C79OZnooNnLmH5ppkMyIvdwzQ==;
From: Quirin Gylstorff <Quirin.Gylstorff@siemens.com>
To: cip-dev@lists.cip-project.org,
	jan.kiszka@siemens.com
Subject: [cip-dev][isar-cip-core][PATCH 1/5] Add cip-functions to initramfs
Date: Fri, 14 Nov 2025 12:17:40 +0100
Message-ID: <20251114111925.903740-2-Quirin.Gylstorff@siemens.com>
In-Reply-To: <20251114111925.903740-1-Quirin.Gylstorff@siemens.com>
References: <20251114111925.903740-1-Quirin.Gylstorff@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-51332:519-21489:flowmailer
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 14 Nov 2025 11:20:09 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/20556

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
 .../files/cip-initramfs-functions             | 69 +++++++++++++++++++
 .../initramfs-cip-functions_0.1.bb            | 20 ++++++
 2 files changed, 89 insertions(+)
 create mode 100644 recipes-initramfs/initramfs-cip-functions/files/cip-initramfs-functions
 create mode 100644 recipes-initramfs/initramfs-cip-functions/initramfs-cip-functions_0.1.bb

diff --git a/recipes-initramfs/initramfs-cip-functions/files/cip-initramfs-functions b/recipes-initramfs/initramfs-cip-functions/files/cip-initramfs-functions
new file mode 100644
index 0000000..0bb6f23
--- /dev/null
+++ b/recipes-initramfs/initramfs-cip-functions/files/cip-initramfs-functions
@@ -0,0 +1,69 @@
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
+# check condition with function given by argument 1
+# if the function does not return true(0) check after
+# 1 second again and wait for 30sec
+wait_30sec_for_condition() {
+    check_condition=$1
+    if [ -z "$check_condition" ]; then
+        log_warning_msg "No condition given do not wait"
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
+# only for abrootfs hook and verity hook
+# check if the device "$ROOT" is valid
+find_root_by_part() {
+    found_root=$(blkid --list-one --output device --match-token "$ROOT")
+    if [ -n "${found_root}" ]; then
+        return 0
+    fi
+    return 1
+}
+
+# only for abrootfs hook and verity hook
+# scan paritions for the root device defined by
+# the function find_root_via_image_uuid
+scan_partitions() {
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
index 0000000..a94d03f
--- /dev/null
+++ b/recipes-initramfs/initramfs-cip-functions/initramfs-cip-functions_0.1.bb
@@ -0,0 +1,20 @@
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
+inherit dpkg-raw
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
2.51.0


