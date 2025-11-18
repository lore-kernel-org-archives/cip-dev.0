Return-Path: <quirin.gylstorff@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F6D8CEDDB5
	for <webhook@archiver.kernel.org>; Tue, 18 Nov 2025 15:10:41 +0000 (UTC)
Received: from mta-64-226.siemens.flowmailer.net (mta-64-226.siemens.flowmailer.net [185.136.64.226])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.14663.1763478634025697042
 for <cip-dev@lists.cip-project.org>;
 Tue, 18 Nov 2025 07:10:35 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=Quirin.Gylstorff@siemens.com header.s=fm1 header.b=k9vF23ft;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.64.226, mailfrom: fm-51332-2025111815103107204a3efe00020799-hn5kru@rts-flowmailer.siemens.com)
Received: by mta-64-226.siemens.flowmailer.net with ESMTPSA id 2025111815103107204a3efe00020799
        for <cip-dev@lists.cip-project.org>;
        Tue, 18 Nov 2025 16:10:31 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=Quirin.Gylstorff@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:References:In-Reply-To;
 bh=oQ3JVCv/pU1VKMzb/Q39nILV4oDAA9pmiEo1nRJUTEM=;
 b=k9vF23ftP4kHoA7lbnPk8YoHNozbEVa0pqdaMnBXndMcx3ADcKYrJVIhdndobJzNvYoCs0
 mBL9mOMNcG5p9ESOSHU902l/EyTLCrJCjVInfVqmV5klissPsHsdk5nhQFP0SdovpogSU/P/
 BKyrSnwE2WEdIS+BuaImSttVKskM8Qk2YszMoj1vi7PLinw6+qKlF6x8Qyb+XTaxXkwtAd59
 PyJzNgqrM8PUE9kUCf2wFOrfbyDgXWT2GxvHkdjcSRXHVofp8FUqg3GHjqOVBBUy95htJ/Ds
 xa0NVuac700C0epBATOIhEcHhbl/SRkfhwxmttitp3jj7UwRyxKuEIUw==;
From: Quirin Gylstorff <Quirin.Gylstorff@siemens.com>
To: cip-dev@lists.cip-project.org,
	jan.kiszka@siemens.com
Subject: [cip-dev][isar-cip-core][PATCH v2 5/5] initramfs-crypt-hook: Scan if all request partitions are available
Date: Tue, 18 Nov 2025 15:14:48 +0100
Message-ID: <20251118151030.504765-6-Quirin.Gylstorff@siemens.com>
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
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/20617

From: Quirin Gylstorff <quirin.gylstorff@siemens.com>

This fixes an issue found during testing in the cip-lab with debian
trixie as the device was not available[1]:

{"dt": "2025-11-05T17:42:59.297005", "lvl": "target", "msg": "Begin: Mounting root file system ... Begin: Running /scripts/local-top ... /dev/disk/by-partlabel/var: No such file or directory"}
{"dt": "2025-11-05T17:42:59.297463", "lvl": "target", "msg": "Could not find device  mapped to 'var' cannot be encrypted!"}
{"dt": "2025-11-05T17:42:59.297795", "lvl": "target", "msg": "Rebooting automatically due to panic= boot argument"}

[1]: https://lava.ciplatform.org/scheduler/job/1325480

Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
---
 .../files/local-top-complete                  | 19 +++++++++++++++++++
 ...ok_0.9.bb => initramfs-crypt-hook_0.10.bb} |  5 ++++-
 2 files changed, 23 insertions(+), 1 deletion(-)
 rename recipes-initramfs/initramfs-crypt-hook/{initramfs-crypt-hook_0.9.bb => initramfs-crypt-hook_0.10.bb} (98%)

diff --git a/recipes-initramfs/initramfs-crypt-hook/files/local-top-complete b/recipes-initramfs/initramfs-crypt-hook/files/local-top-complete
index 664124d..4f3eafc 100644
--- a/recipes-initramfs/initramfs-crypt-hook/files/local-top-complete
+++ b/recipes-initramfs/initramfs-crypt-hook/files/local-top-complete
@@ -33,6 +33,8 @@ esac
 
 . /scripts/functions
 
+. /scripts/cip-initramfs-functions
+
 # get configuration variables
 . /usr/share/encrypt_partition/encrypt_partition.env
 
@@ -68,6 +70,21 @@ service_watchdog() {
 	done > "$WATCHDOG_DEV"
 }
 
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
+
 reencrypt_existing_partition() {
 	part_size_blocks="$(cat /sys/class/block/"${1##*/}"/size)"
 	# reduce the filesystem and partition by 32M to fit the LUKS header
@@ -221,6 +238,8 @@ fi
 
 prepare_for_encryption
 
+wait_30sec_for_condition check_partitions
+
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
2.51.2


