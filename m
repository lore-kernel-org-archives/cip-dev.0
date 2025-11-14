Return-Path: <quirin.gylstorff@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62F6BCE7AEF
	for <webhook@archiver.kernel.org>; Fri, 14 Nov 2025 11:20:09 +0000 (UTC)
Received: from mta-65-227.siemens.flowmailer.net (mta-65-227.siemens.flowmailer.net [185.136.65.227])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.15633.1763119205948568664
 for <cip-dev@lists.cip-project.org>;
 Fri, 14 Nov 2025 03:20:07 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=Quirin.Gylstorff@siemens.com header.s=fm1 header.b=laCc3u9F;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.65.227, mailfrom: fm-51332-202511141120036a0d0eb1030002072f-kbrlzl@rts-flowmailer.siemens.com)
Received: by mta-65-227.siemens.flowmailer.net with ESMTPSA id 202511141120036a0d0eb1030002072f
        for <cip-dev@lists.cip-project.org>;
        Fri, 14 Nov 2025 12:20:03 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=Quirin.Gylstorff@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:References:In-Reply-To;
 bh=JC2/BggFTlkkO2ayDl/qEuRwEU3aLkHkYDR5Ejrdz3g=;
 b=laCc3u9F7GdYbv57ImDmCWwaFH2u9H2I0ufbRhtaApw29gNr7j7331l2mCaBaYyEAuzP+O
 AhYsN4RzZEgl+cruvs5jb/kv2sTaY2tgmGfayQalgMW0Qjw3mTxNdcMUlUyW4SMXrfR/S6qe
 nPc4i0ey/ooXjWbwvvSuGAzV9ptryEga8Xy2u0OYH7Q7wfF4cs5uvWlKq7JFpEz2vkLzfw7x
 hltyyyZPhjKPBBoSPvcbaqB6t3clX1oxsu8TvH/x4e+Tz+AN16QQVrD87mN7JRjd7vRIe44M
 IZlQWGMiUPlppIzQbhaq4ij+S54fHDirORSGOWwxrTfuLDwogdFkDRkQ==;
From: Quirin Gylstorff <Quirin.Gylstorff@siemens.com>
To: cip-dev@lists.cip-project.org,
	jan.kiszka@siemens.com
Subject: [cip-dev][isar-cip-core][PATCH 5/5] initramfs-crypt-hook: Scan if all request partitions are available
Date: Fri, 14 Nov 2025 12:17:44 +0100
Message-ID: <20251114111925.903740-6-Quirin.Gylstorff@siemens.com>
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
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/20555

From: Quirin Gylstorff <quirin.gylstorff@siemens.com>

This fixes an issue found during testing in the cip-lab with debian
trixie as the device was not available[1]:

{"dt": "2025-11-05T17:42:59.297005", "lvl": "target", "msg": "Begin: Mounting root file system ... Begin: Running /scripts/local-top ... /dev/disk/by-partlabel/var: No such file or directory"}
{"dt": "2025-11-05T17:42:59.297463", "lvl": "target", "msg": "Could not find device  mapped to 'var' cannot be encrypted!"}
{"dt": "2025-11-05T17:42:59.297795", "lvl": "target", "msg": "Rebooting automatically due to panic= boot argument"}

[1]: https://lava.ciplatform.org/scheduler/job/1325480

Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
---
 .../files/local-top-complete                   | 18 +++++++++++++++++-
 ...ook_0.9.bb => initramfs-crypt-hook_0.10.bb} |  5 ++++-
 2 files changed, 21 insertions(+), 2 deletions(-)
 rename recipes-initramfs/initramfs-crypt-hook/{initramfs-crypt-hook_0.9.bb => initramfs-crypt-hook_0.10.bb} (98%)

diff --git a/recipes-initramfs/initramfs-crypt-hook/files/local-top-complete b/recipes-initramfs/initramfs-crypt-hook/files/local-top-complete
index 664124d..74970ce 100644
--- a/recipes-initramfs/initramfs-crypt-hook/files/local-top-complete
+++ b/recipes-initramfs/initramfs-crypt-hook/files/local-top-complete
@@ -33,6 +33,7 @@ esac
 
 . /scripts/functions
 
+. /scripts/cip-initramfs-functions
 # get configuration variables
 . /usr/share/encrypt_partition/encrypt_partition.env
 
@@ -67,6 +68,21 @@ service_watchdog() {
 		sleep 10
 	done > "$WATCHDOG_DEV"
 }
+set -x
+check_partitions()
+{
+	found=0
+	for partition_set in $partition_sets; do
+		partition="$(awk -v var="$partition_set" 'BEGIN{split(var,a,":"); print a[1]}')"
+		if $(blkid | grep -q "$partition"); then
+			found=$((found + 1))
+		fi
+	done
+	if [ "$found" -eq "$(awk -v var="$partition_sets" 'BEGIN{n=split(var,a," "); print n}')" ]; then
+		return 0
+	fi
+	return 1
+}
 
 reencrypt_existing_partition() {
 	part_size_blocks="$(cat /sys/class/block/"${1##*/}"/size)"
@@ -220,7 +236,7 @@ if [ ! -e "$tpm_device" ]; then
 fi
 
 prepare_for_encryption
-
+wait_30sec_for_condition check_partitions
 for partition_set in $partition_sets; do
 	partition="$(awk -v var="$partition_set" 'BEGIN{split(var,a,":"); print a[1]}')"
 	partition_mountpoint="$(awk -v var="$partition_set" 'BEGIN{split(var,a,":"); print a[2]}')"
diff --git a/recipes-initramfs/initramfs-crypt-hook/initramfs-crypt-hook_0.9.bb b/recipes-initramfs/initramfs-crypt-hook/initramfs-crypt-hook_0.10.bb
similarity index 98%
rename from recipes-initramfs/initramfs-crypt-hook/initramfs-crypt-hook_0.9.bb
rename to recipes-initramfs/initramfs-crypt-hook/initramfs-crypt-hook_0.10.bb
index e107575..9aaa03b 100644
--- a/recipes-initramfs/initramfs-crypt-hook/initramfs-crypt-hook_0.9.bb
+++ b/recipes-initramfs/initramfs-crypt-hook/initramfs-crypt-hook_0.10.bb
@@ -11,6 +11,8 @@
 
 require recipes-initramfs/initramfs-hook/hook.inc
 
+RDEPENDS += "initramfs-cip-functions"
+
 DEBIAN_DEPENDS .= ", \
     cryptsetup, \
     awk, \
@@ -18,7 +20,8 @@ DEBIAN_DEPENDS .= ", \
     e2fsprogs, \
     tpm2-tools, \
     coreutils, \
-    uuid-runtime"
+    uuid-runtime, \
+    initramfs-cip-functions"
 
 CRYPT_BACKEND:buster = "clevis"
 CRYPT_BACKEND:bullseye = "clevis"
-- 
2.51.0


