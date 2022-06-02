Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4439CCA478
	for <webhook@archiver.kernel.org>; Thu,  2 Jun 2022 16:17:53 +0000 (UTC)
Received: from mta-64-227.siemens.flowmailer.net
 (mta-64-227.siemens.flowmailer.net [185.136.64.227])
 by mx.groups.io with SMTP id smtpd.web10.1101.1654186665915218632
 for <cip-dev@lists.cip-project.org>;
 Thu, 02 Jun 2022 09:17:46 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=jan.kiszka@siemens.com header.s=fm1 header.b=hIdQIe/n;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.64.227,
 mailfrom: fm-294854-20220602161742f168a21892cbd26395-lkg0jm@rts-flowmailer.siemens.com)
Received: by mta-64-227.siemens.flowmailer.net with ESMTPSA id
 20220602161742f168a21892cbd26395
        for <cip-dev@lists.cip-project.org>;
        Thu, 02 Jun 2022 18:17:42 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=jan.kiszka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:References:In-Reply-To;
 bh=2ifexCO22k4GEvY2KDFSrAZX4024YUpE36YbJbPVUAU=;
 b=hIdQIe/n0iOkzeXtXJeIlz0odJXVLrj5h+dej9nuV3D0xuIuQGgURVwC0AuHi0CU7RDGyT
 CEmMu/tqCfx9mVOq5kn2L8gPPHe0djfy5mDs4Ad/mCaoyAfd1/LVqXDjuP4UZI0fsBTGAI3A
 LTk2INiQ31c8nfijQ5idchoNWTv48=;
From: Jan Kiszka <jan.kiszka@siemens.com>
To: cip-dev@lists.cip-project.org
Subject: [isar-cip-core][PATCH 1/2] initramfs-abrootfs-hook: Account for
 slower storage devices
Date: Thu,  2 Jun 2022 18:17:40 +0200
Message-Id: 
 <590cdfb4e4c4f66354e144875c28390122be66ea.1654186661.git.jan.kiszka@siemens.com>
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
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/8479

From: Jan Kiszka <jan.kiszka@siemens.com>

Add a retry loop to account for storage devices that do not show up
immediately. Specifically USB can fall under this.

The logic is split along the classic PARTUUID/PARTLABEL case and the
more complex image UUID matching. To avoid continously mounting/
checking/unmounting the same partitions partitions, we keep track of the
already checked ones and only test those that are newly discovered.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 .../files/abrootfs.script                     | 86 +++++++++++++++----
 1 file changed, 71 insertions(+), 15 deletions(-)

diff --git a/recipes-initramfs/initramfs-abrootfs-hook/files/abrootfs.script b/recipes-initramfs/initramfs-abrootfs-hook/files/abrootfs.script
index b61fe30..23bbfe7 100644
--- a/recipes-initramfs/initramfs-abrootfs-hook/files/abrootfs.script
+++ b/recipes-initramfs/initramfs-abrootfs-hook/files/abrootfs.script
@@ -30,37 +30,93 @@ esac
 . /scripts/functions
 . /usr/share/abrootfs/image-uuid.env
 
+find_root_via_image_uuid()
+{
+    for part in $partitions; do
+        if [ "$(blkid -p "${part}" --match-types novfat -s USAGE -o value)" = "filesystem" ]; then
+            mount -o ro -t "$(get_fstype "${part}")" "${part}" "${rootmnt}"
+            . "${rootmnt}/etc/os-release"
+            umount "${rootmnt}"
+            if [ "${IMAGE_UUID}" = "${TARGET_IMAGE_UUID}" ]; then
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
 # broken boot.
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
-        # No Root device was given. Use find the matching IMAGE_UUID
-        partitions=$(blkid -o device)
-        for part in $partitions; do
-            if [ "$(blkid -p ${part} --match-types novfat -s USAGE -o value)" = "filesystem" ]; then
-                mount -o ro -t $(get_fstype $part) $part ${rootmnt}
-                . ${rootmnt}/etc/os-release
-                umount ${rootmnt}
-                if [ "${IMAGE_UUID}" = "${TARGET_IMAGE_UUID}" ]; then
-                    ROOT="$part"
+        # No Root device was given. Search for the matching IMAGE_UUID
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
 
-if [ -z "${ROOT}" ]; then
+if [ -z "${found_root}" ]; then
     panic "Can't find the root device with matching UUID!"
 fi
 
+ROOT="${found_root}"
 echo "ROOT=${ROOT}" >/conf/param.conf
-- 
2.35.3


