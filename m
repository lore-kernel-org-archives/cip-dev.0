Return-Path: <quirin.gylstorff@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5B5BC3DA40
	for <webhook@archiver.kernel.org>; Mon,  6 May 2024 14:18:44 +0000 (UTC)
Received: from mta-64-228.siemens.flowmailer.net (mta-64-228.siemens.flowmailer.net [185.136.64.228])
 by mx.groups.io with SMTP id smtpd.web11.21516.1715005117706973248
 for <cip-dev@lists.cip-project.org>;
 Mon, 06 May 2024 07:18:38 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=Quirin.Gylstorff@siemens.com header.s=fm1 header.b=NsxN/GkT;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.64.228, mailfrom: fm-51332-2024050614183576e48ee383d512bfb1-rvyfek@rts-flowmailer.siemens.com)
Received: by mta-64-228.siemens.flowmailer.net with ESMTPSA id 2024050614183576e48ee383d512bfb1
        for <cip-dev@lists.cip-project.org>;
        Mon, 06 May 2024 16:18:35 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=Quirin.Gylstorff@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:References:In-Reply-To;
 bh=UnRcyYY5K11QyDU06ng9fO8NOh+1zJBFth1koXkuLMA=;
 b=NsxN/GkTJSquobNlOHkLILlChm5MjC1D4ntLF8uK/L8/m6Kla53k8uauYQdzsSJNcDZENP
 mIRpCGcVs7dIigsvXjsFrvMwuMMqenSQslA+0v3wf0XaR4GfHvxHU1a9BRnQwioYQG7wF/sm
 n5U+CG5jB1AQ2+meqxwo+8bqI+dd8=;
From: Quirin Gylstorff <Quirin.Gylstorff@siemens.com>
To: cip-dev@lists.cip-project.org,
	jan.kiszka@siemens.com,
	johnxw@amazon.com,
	felix.moessbauer@siemens.com
Subject: [cip-dev][isar-cip-core][PATCH v5 03/11] initramfs-crypt: Only resize partition if ext* formatted
Date: Mon,  6 May 2024 16:17:24 +0200
Message-ID: <20240506141833.3622989-4-Quirin.Gylstorff@siemens.com>
In-Reply-To: <20240506141833.3622989-1-Quirin.Gylstorff@siemens.com>
References: <20240506141833.3622989-1-Quirin.Gylstorff@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-51332:519-21489:flowmailer
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 06 May 2024 14:18:44 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/15829

From: Quirin Gylstorff <quirin.gylstorff@siemens.com>

squashfs or empty partition cannot be resized with resize2fs.

Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
---
 .../files/encrypt_partition.script            | 20 +++++++++++++++----
 1 file changed, 16 insertions(+), 4 deletions(-)

diff --git a/recipes-initramfs/initramfs-crypt-hook/files/encrypt_partition.script b/recipes-initramfs/initramfs-crypt-hook/files/encrypt_partition.script
index 8f6cbf6..2e6abf9 100644
--- a/recipes-initramfs/initramfs-crypt-hook/files/encrypt_partition.script
+++ b/recipes-initramfs/initramfs-crypt-hook/files/encrypt_partition.script
@@ -64,14 +64,26 @@ service_watchdog() {
 reencrypt_existing_partition() {
 	part_size_blocks="$(cat /sys/class/block/"$(awk -v dev="$1" 'BEGIN{split(dev,a,"/"); print a[3]}' )"/size)"
 	# reduce the filesystem and partition by 32M to fit the LUKS header
+	partition_fstype=$(get_fstype "${1}")
 	reduce_device_size=32768
 	reduced_size="$(expr "$part_size_blocks" - 65536 )"
 	reduced_size_in_byte="$(expr "$reduced_size" \* 512)"
 	reduced_size_in_kb="$(expr "$reduced_size_in_byte" / 1024)K"
-	e2fsck -f "$1"
-	if ! resize2fs "$1" "${reduced_size_in_kb}"; then
-		panic "reencryption of filesystem $1 cannot continue!"
-	fi
+	case $partition_fstype in
+	ext*)
+		# reduce the filesystem and partition by 32M to fit the LUKS header
+		e2fsck -f "$1"
+		if ! resize2fs "$1" "${reduced_size_in_kb}"; then
+			panic "reencryption of filesystem $1 cannot continue!"
+		fi
+		;;
+	squashfs|"")
+		echo "skip disk resize as it is not supported or unnecessary for fstype: '$partition_fstype'"
+		;;
+	*)
+		panic "cannot resize parition. unsupport fstype: $partition_fstype"
+		;;
+	esac
 	if [ -x /usr/sbin/cryptsetup-reencrypt ]; then
 		/usr/sbin/cryptsetup-reencrypt --new --reduce-device-size "$reduce_device_size"k "$1" < "$2"
 	else
-- 
2.43.0


