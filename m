Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D04F8C43334
	for <webhook@archiver.kernel.org>; Thu,  2 Jun 2022 16:17:53 +0000 (UTC)
Received: from mta-65-227.siemens.flowmailer.net
 (mta-65-227.siemens.flowmailer.net [185.136.65.227])
 by mx.groups.io with SMTP id smtpd.web10.1102.1654186666062101044
 for <cip-dev@lists.cip-project.org>;
 Thu, 02 Jun 2022 09:17:47 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=jan.kiszka@siemens.com header.s=fm1 header.b=epXdwrcX;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.65.227,
 mailfrom: fm-294854-20220602161742281501f9214fb7cc9a-2sp8dr@rts-flowmailer.siemens.com)
Received: by mta-65-227.siemens.flowmailer.net with ESMTPSA id
 20220602161742281501f9214fb7cc9a
        for <cip-dev@lists.cip-project.org>;
        Thu, 02 Jun 2022 18:17:42 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=jan.kiszka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:References:In-Reply-To;
 bh=IucXdK3RQuaIbTbMS8cRnJCmj6Q6E7ARUHXVarl+t8c=;
 b=epXdwrcXqYcR9dD+jNw3hWT4K2Abf/PJLCK4mK2fNdYCggMHFlYRn3ez0KaZi/RwNk37Tu
 AD8iYU6X3EjWmaoNo+6FavsHsrCVAS7XDhZ4brhUZA7UqNz9jCJB48BeJRt8NWQNrFoGQlfv
 qycGGP+DvwtkC2L11eFzQWlPUiWmk=;
From: Jan Kiszka <jan.kiszka@siemens.com>
To: cip-dev@lists.cip-project.org
Subject: [isar-cip-core][PATCH 2/2] initramfs-verity-hook: Account for slower
 storage devices
Date: Thu,  2 Jun 2022 18:17:41 +0200
Message-Id: 
 <27f88e9abfcbe9746bb9c202544105de8538ff5d.1654186661.git.jan.kiszka@siemens.com>
In-Reply-To: <cover.1654186661.git.jan.kiszka@siemens.com>
References: <cover.1654186661.git.jan.kiszka@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-294854:519-21489:flowmailer
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 02 Jun 2022 16:17:53 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/8480

From: Jan Kiszka <jan.kiszka@siemens.com>

Same story as for abrootfs-hook, same solution pattern, just different
implementation of find_root_via_image_uuid.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 .../files/verity.script.tmpl                  | 109 ++++++++++++++----
 1 file changed, 88 insertions(+), 21 deletions(-)

diff --git a/recipes-initramfs/initramfs-verity-hook/files/verity.script.tmpl b/recipes-initramfs/initramfs-verity-hook/files/verity.script.tmpl
index da37711..8865b0f 100644
--- a/recipes-initramfs/initramfs-verity-hook/files/verity.script.tmpl
+++ b/recipes-initramfs/initramfs-verity-hook/files/verity.script.tmpl
@@ -1,4 +1,15 @@
 #!/bin/sh
+#
+# CIP Core, generic profile
+#
+# Copyright (c) Siemens AG, 2021-2022
+#
+# Authors:
+#  Quirin Gylstorff <quirin.gylstorff@siemens.com>
+#  Jan Kiszka <jan.kiszka@siemens.com>
+#
+# SPDX-License-Identifier: MIT
+
 prereqs()
 {
     # Make sure that this script is run last in local-top
@@ -22,42 +33,98 @@ esac
 . /scripts/functions
 . /lib/cryptsetup/functions
 . /usr/share/verity-env/verity.env
+
+find_root_via_image_uuid()
+{
+    for part in ${partitions}; do
+        if [ "$(blkid -p ${part} --match-types novfat -s USAGE -o value)" = "filesystem" ]; then
+            verity_uuid=$(
+                veritysetup dump "${part}" --hash-offset "${HASH_OFFSET}" | \
+                    while IFS=":" read key value; do
+                        if [ "${key}" = "UUID" ]; then
+                            # this pattern must use a real tab
+                            echo "${value##*	}"
+                            break
+                        fi
+                    done
+                )
+            if [ "${UUID}" = "${verity_uuid}" ]; then
+                found_root="${part}"
+                break
+            fi
+        fi
+    done
+}
+
 # Even if this script fails horribly, make sure there won't be a chance the
 # current $ROOT will be attempted.  As this device most likely contains a
 # perfectly valid filesystem, it would be mounted successfully, leading to a
 # broken trust chain.
 echo "ROOT=/dev/null" >/conf/param.conf
 wait_for_udev 10
+
 case "$ROOT" in
     PART*)
-        # root was given as PARTUUID= or PARTLABEL=. Use blkid to find the matching
-        # partition
-        ROOT=$(blkid --list-one --output device --match-token "$ROOT")
+        # Root was given as PARTUUID= or PARTLABEL=.
+        # Use blkid to find the matching partition
+        found_root=$(blkid --list-one --output device --match-token "$ROOT")
+        if [ -z "${found_root}" ]; then
+            log_begin_msg "Waiting for ${ROOT}"
+            while true; do
+                sleep 1
+                time_elapsed="$(time_elapsed)"
+
+                found_root=$(blkid --list-one --output device --match-token "$ROOT")
+                if [ -n "${found_root}" ]; then
+                    log_end_msg 1
+                    break
+                fi
+                if [ "${time_elapsed}" -ge 30 ]; then
+                    log_end_msg 0
+                    break
+                fi
+            done
+        fi
         ;;
     "")
         # No Root device was given. Use veritysetup verify to search matching roots
-        partitions=$(blkid -o device)
-        for part in ${partitions}; do
-            if [ "$(blkid -p ${part} --match-types novfat -s USAGE -o value)" = "filesystem" ]; then
-                verity_uuid=$(
-                    veritysetup dump "${part}" --hash-offset "${HASH_OFFSET}" | \
-                        while IFS=":" read key value; do
-                            if [ "${key}" = "UUID" ]; then
-                                # this pattern must use a real tab
-                                echo "${value##*	}"
-                                break
-                            fi
-                        done
-                    )
-                if [ "${UUID}" = "${verity_uuid}" ]; then
-                    ROOT="${part}"
+        partitions="$(blkid -o device)"
+        find_root_via_image_uuid
+        if [ -z "${found_root}" ]; then
+            log_begin_msg "Waiting for IMAGE_UUID=${TARGET_IMAGE_UUID}"
+            scanned_partitions="${partitions}"
+            while true; do
+                sleep 1
+                time_elapsed="$(time_elapsed)"
+
+                unset partitions
+                for part in $(blkid -o device); do
+                    unset found
+                    for scanned_part in ${scanned_partitions}; do
+                        if [ "${scanned_part}" = "${part}" ]; then
+                            found=1
+                            break
+                        fi
+                    done
+                    if [ -z "${found}" ]; then
+                        partitions="${partitions} ${part}"
+                    fi
+                done
+                find_root_via_image_uuid
+                if [ -n "${found_root}" ]; then
+                    log_end_msg 1
                     break
                 fi
-            fi
-        done
+                if [ "${time_elapsed}" -ge 30 ]; then
+                    log_end_msg 0
+                    break
+                fi
+                scanned_partitions="${scanned_partitions} ${partitions}"
+            done
+        fi
         ;;
 esac
-set -- "$ROOT" verityroot
+set -- "${found_root}" verityroot
 if ! veritysetup open \
      ${VERITY_BEHAVIOR_ON_CORRUPTION} \
      --data-block-size "${DATA_BLOCK_SIZE}" \
-- 
2.35.3


