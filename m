Return-Path: <quirin.gylstorff@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32E99C02198
	for <webhook@archiver.kernel.org>; Fri, 14 Feb 2025 12:39:39 +0000 (UTC)
Received: from mta-65-226.siemens.flowmailer.net (mta-65-226.siemens.flowmailer.net [185.136.65.226])
 by mx.groups.io with SMTP id smtpd.web11.20058.1739536774332740940
 for <cip-dev@lists.cip-project.org>;
 Fri, 14 Feb 2025 04:39:35 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=Quirin.Gylstorff@siemens.com header.s=fm2 header.b=BAAY8LbN;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.65.226, mailfrom: fm-51332-202502141239303d2ead02d19b64b30b-yvyuyb@rts-flowmailer.siemens.com)
Received: by mta-65-226.siemens.flowmailer.net with ESMTPSA id 202502141239303d2ead02d19b64b30b
        for <cip-dev@lists.cip-project.org>;
        Fri, 14 Feb 2025 13:39:31 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm2;
 d=siemens.com; i=Quirin.Gylstorff@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding;
 bh=XZ5BwHwBUNOwtWV6GE/sTvtAzVr2QaTdRyAq0vpwiXQ=;
 b=BAAY8LbNd0iN5ZZ34sK+4DUcpjPLM+KaZxUVsuCvOBqkSStOAOB+pB/Wq2uByCdJQ4tjUZ
 rDy02zTBP2bz8lOjtGzSvVFL/GIbbXv11U2zC96sB+AhlXYUWT1oN1ebx91k1JRLGiw3t/8/
 LzrRYhXvuE0lnOKPTmHQpLRTKISAHKbeMRBOgZ1B35WdDoBLIlkwJyzr9//l6APd6VebpIOd
 Gw09woBWeQnXnvTGA3HniMaEll9o6/KbvofqCDcdpmN8gq5EODJJyzH0WyG1K8n+Rz4RVxxD
 /752DwPcPW4234nVZkJKG/S2UMmIk3eFGHbucePA7AeguQvdeyIGDa5Q==;
From: Quirin Gylstorff <Quirin.Gylstorff@siemens.com>
To: cip-dev@lists.cip-project.org,
	jan.kiszka@siemens.com
Subject: [cip-dev][isar-cip-core][PATCH] crypt: do not assume that all system clocks are broken
Date: Fri, 14 Feb 2025 13:33:30 +0100
Message-ID: <20250214123930.701998-1-Quirin.Gylstorff@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-51332:519-21489:flowmailer
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 14 Feb 2025 12:39:39 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/17844

From: Quirin Gylstorff <quirin.gylstorff@siemens.com>

If a system has the following characteristics:
- An unbuffered system clock which starts in the
past (e.g. 01-01-2024)
- The last disk write/mount is after that date(e.g.
01-01-2025)
- The option broken_system_clock is set for e2fsck

A subsequent call of `resize2fs` will always fail
as resize2fs will check if the date of the last check
is after the date of the last mount.

The e2fsck option `-p`(prune) fixes most of these time issues and the
broken_system_clock option is not necessary on most systems.

Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
---
The alternative is to delete the setting of e2fsck option or use
`resizefs --force`. The latter fix has the issue that the force option will
also disable the disk size checks

 .../initramfs-crypt-hook/files/encrypt_partition.env.tmpl   | 1 +
 .../initramfs-crypt-hook/files/local-top-complete           | 6 ++++--
 ...tramfs-crypt-hook_0.6.bb => initramfs-crypt-hook_0.7.bb} | 3 +++
 3 files changed, 8 insertions(+), 2 deletions(-)
 rename recipes-initramfs/initramfs-crypt-hook/{initramfs-crypt-hook_0.6.bb => initramfs-crypt-hook_0.7.bb} (97%)

diff --git a/recipes-initramfs/initramfs-crypt-hook/files/encrypt_partition.env.tmpl b/recipes-initramfs/initramfs-crypt-hook/files/encrypt_partition.env.tmpl
index bb93361..3c5c4c7 100644
--- a/recipes-initramfs/initramfs-crypt-hook/files/encrypt_partition.env.tmpl
+++ b/recipes-initramfs/initramfs-crypt-hook/files/encrypt_partition.env.tmpl
@@ -5,3 +5,4 @@ WATCHDOG_DEV="${INITRAMFS_WATCHDOG_DEVICE}"
 HASH_TYPE="${CRYPT_HASH_TYPE}"
 KEY_ALGORITHM="${CRYPT_KEY_ALGORITHM}"
 ENCRYPTION_IS_OPTIONAL="${CRYPT_ENCRYPTION_OPTIONAL}"
+CRYPT_BROKEN_SYSTEM_CLOCK="${CRYPT_BROKEN_SYSTEM_CLOCK}"
diff --git a/recipes-initramfs/initramfs-crypt-hook/files/local-top-complete b/recipes-initramfs/initramfs-crypt-hook/files/local-top-complete
index 54b8a6e..bb720c7 100644
--- a/recipes-initramfs/initramfs-crypt-hook/files/local-top-complete
+++ b/recipes-initramfs/initramfs-crypt-hook/files/local-top-complete
@@ -75,11 +75,13 @@ reencrypt_existing_partition() {
 	case $partition_fstype in
 	ext*)
 		# reduce the filesystem and partition by 32M to fit the LUKS header
-		export E2FSCK_CONFIG=/tmp/e2fsck.conf
-		cat > "$E2FSCK_CONFIG" << EOF
+		if [ "$CRYPT_BROKEN_SYSTEM_CLOCK" != "0" ]; then
+			export E2FSCK_CONFIG=/tmp/e2fsck.conf
+			cat > "$E2FSCK_CONFIG" << EOF
 [options]
 	broken_system_clock=true
 EOF
+		fi
 		e2fsck -p -f "$1"
 		if ! resize2fs "$1" "${reduced_size_in_kb}"; then
 			panic "reencryption of partition $1 cannot continue - resizing of the partition failed!"
diff --git a/recipes-initramfs/initramfs-crypt-hook/initramfs-crypt-hook_0.6.bb b/recipes-initramfs/initramfs-crypt-hook/initramfs-crypt-hook_0.7.bb
similarity index 97%
rename from recipes-initramfs/initramfs-crypt-hook/initramfs-crypt-hook_0.6.bb
rename to recipes-initramfs/initramfs-crypt-hook/initramfs-crypt-hook_0.7.bb
index df335c9..ec2d6bc 100644
--- a/recipes-initramfs/initramfs-crypt-hook/initramfs-crypt-hook_0.6.bb
+++ b/recipes-initramfs/initramfs-crypt-hook/initramfs-crypt-hook_0.7.bb
@@ -85,6 +85,9 @@ CRYPT_ENCRYPTION_OPTIONAL ??= "false"
 # add support for btrfs encryption
 CRYPT_BTRFS_SUPPORT ??= "0"
 
+## do assume the system clock is broken for partition check
+CRYPT_BROKEN_SYSTEM_CLOCK ??= "0"
+
 TEMPLATE_VARS += "CRYPT_PARTITIONS CRYPT_CREATE_FILE_SYSTEM_CMD \
     CRYPT_SETUP_TIMEOUT INITRAMFS_WATCHDOG_DEVICE CRYPT_HASH_TYPE \
     CRYPT_KEY_ALGORITHM CRYPT_ENCRYPTION_OPTIONAL"
-- 
2.47.0


