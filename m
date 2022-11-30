Return-Path: <quirin.gylstorff@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78BC7C433FE
	for <webhook@archiver.kernel.org>; Wed, 30 Nov 2022 11:18:33 +0000 (UTC)
Received: from mta-64-228.siemens.flowmailer.net (mta-64-228.siemens.flowmailer.net [185.136.64.228])
 by mx.groups.io with SMTP id smtpd.web11.8574.1669807111455154010
 for <cip-dev@lists.cip-project.org>;
 Wed, 30 Nov 2022 03:18:32 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=Quirin.Gylstorff@siemens.com header.s=fm1 header.b=ckPmZ65C;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.64.228, mailfrom: fm-51332-20221130111828ec6277e0389ca3bd4f-3dd3fn@rts-flowmailer.siemens.com)
Received: by mta-64-228.siemens.flowmailer.net with ESMTPSA id 20221130111828ec6277e0389ca3bd4f
        for <cip-dev@lists.cip-project.org>;
        Wed, 30 Nov 2022 12:18:29 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=Quirin.Gylstorff@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding;
 bh=GoVRfxyNvLYP156TEt4i4OBcaIPb6XaYqmHSM4+/F3Y=;
 b=ckPmZ65CI60eN+fV0060lmL9rEiUsRqjd4aWg/BFqOxGHhqu0z2FoPQB90q9Z1FjBF5lmh
 wdqvgA/Pp9/gwYSfNUzZTJxykN5aV/lYf8aNPmoaJYU6avtj4+DZIl5hfQ7aGgVJxBnR7PzC
 xNnxmfrMgT/83e7XEn2PiJnYZBpU0=;
From: Quirin Gylstorff <Quirin.Gylstorff@siemens.com>
To: cip-dev@lists.cip-project.org,
	jan.kiszka@siemens.com
Subject: [cip-dev][isar-cip-core][PATCH] initramfs-abrootfs: check if /etc/os-release exists
Date: Wed, 30 Nov 2022 12:18:27 +0100
Message-Id: <20221130111827.43184-1-Quirin.Gylstorff@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-51332:519-21489:flowmailer
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 30 Nov 2022 11:18:33 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/10143

From: Quirin Gylstorff <quirin.gylstorff@siemens.com>

If a valid root file system does not contain /etc/os-release the
script aborts before checking other root file systems. This occurs
for example if the boot occurs from a USB stick and a ext4 root
file system exists on internal memory.

Also ensure that IMAGE_UUID and TARGET_IMAGE_UUID are not empty
before comparing to each other.

Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
---
 .../initramfs-abrootfs-hook/files/abrootfs.script          | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/recipes-initramfs/initramfs-abrootfs-hook/files/abrootfs.script b/recipes-initramfs/initramfs-abrootfs-hook/files/abrootfs.script
index 23bbfe7..848e829 100644
--- a/recipes-initramfs/initramfs-abrootfs-hook/files/abrootfs.script
+++ b/recipes-initramfs/initramfs-abrootfs-hook/files/abrootfs.script
@@ -35,9 +35,12 @@ find_root_via_image_uuid()
     for part in $partitions; do
         if [ "$(blkid -p "${part}" --match-types novfat -s USAGE -o value)" = "filesystem" ]; then
             mount -o ro -t "$(get_fstype "${part}")" "${part}" "${rootmnt}"
-            . "${rootmnt}/etc/os-release"
+            if [ -e "${rootmnt}/etc/os-release" ]; then
+                . "${rootmnt}/etc/os-release"
+            fi
             umount "${rootmnt}"
-            if [ "${IMAGE_UUID}" = "${TARGET_IMAGE_UUID}" ]; then
+            if [ -n "${IMAGE_UUID}" ] && [ -n "${TARGET_IMAGE_UUID}" ] &&
+                   [ "${IMAGE_UUID}" = "${TARGET_IMAGE_UUID}" ]; then
                 found_root="${part}"
                 break
             fi
-- 
2.35.1


