Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8BD8D7832F
	for <webhook@archiver.kernel.org>; Mon,  2 Dec 2024 14:51:49 +0000 (UTC)
Received: from mta-65-226.siemens.flowmailer.net (mta-65-226.siemens.flowmailer.net [185.136.65.226])
 by mx.groups.io with SMTP id smtpd.web11.175576.1733151096412742655
 for <cip-dev@lists.cip-project.org>;
 Mon, 02 Dec 2024 06:51:39 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=jan.kiszka@siemens.com header.s=fm2 header.b=hZbC4xQb;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.65.226, mailfrom: fm-294854-20241202145138e736ffd6baeadbb182-varmvf@rts-flowmailer.siemens.com)
Received: by mta-65-226.siemens.flowmailer.net with ESMTPSA id 20241202145138e736ffd6baeadbb182
        for <cip-dev@lists.cip-project.org>;
        Mon, 02 Dec 2024 15:51:39 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm2;
 d=siemens.com; i=jan.kiszka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=beRAoREnUKJlD219FMLUUZ6PUnPCKGa77V1/lgvBxuM=;
 b=hZbC4xQbYFPR67es8JVyn/e4vQSVLFbGohCMFxOkSTLgrxGkbfdHXr6wnI4n7pfwBOuIGg
 fbkjt91bqmABItjZqc5XgIvmy6SAwrDOAYw4A7jpg87OfCRMOhLUQuPPq91TkBH1fFXluP6L
 62L54zDWcnPPudaEHVDzKsUPCGzioo/RQknjXgQZ6ciX62ZtbGZQlwLLUwTZ0mosT8+mvnZo
 N7DKufkST+J+r51KsSukFLpDSlEfps3Nq6DQN63ktAaPlyZXs+5ZWeIHKXFIt7jvA64mJAe2
 E8c12ap5Iym13SJjsB7YJ2VyTcWI2JE8ap4lsl6T5WDYQebluOaEf6yQ==;
From: Jan Kiszka <jan.kiszka@siemens.com>
To: cip-dev@lists.cip-project.org
Cc: Alexander Heinisch <alexander.heinisch@siemens.com>,
	Quirin Gylstorff <quirin.gylstorff@siemens.com>
Subject: [isar-cip-core][PATCH 09/10] initramfs-crypt-hook: Add support for expanding encrypted partition
Date: Mon,  2 Dec 2024 15:51:12 +0100
Message-ID: <284175c31c74b2f2e70287cca5d2b90c3e7199b2.1733151072.git.jan.kiszka@siemens.com>
In-Reply-To: <cover.1733151072.git.jan.kiszka@siemens.com>
References: <cover.1733151072.git.jan.kiszka@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-294854:519-21489:flowmailer
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 02 Dec 2024 14:51:49 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/17318

From: Jan Kiszka <jan.kiszka@siemens.com>

The crypt hook already performs resizing or appropriately sized
formatting of partitions it handles during first boot. If we also add
the partition expansion logic from isar's expand-on-first-boot, we
get feature-complete expansion of encrypted partitions.

The feature is controlled by appending ":expand" to the affected
partition in CRYPT_PARTITIONS. In contrast to isar's expansion logic,
we do not have enough information at that time when it is called in
order to identify the target partition automatically. That is another
reason to embed this feature into the crypt hook.

There is not too much code to be taken from isar for this, so it is
easiest to duplicate and adjust that as needed, rather than introducing
some reusable upstream. This might be revisited in the future.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 kas/opt/expand-on-first-boot.yml              |  3 +
 .../files/local-top-complete                  | 63 +++++++++++++++++++
 .../initramfs-crypt-hook_0.5.bb               |  6 +-
 3 files changed, 71 insertions(+), 1 deletion(-)

diff --git a/kas/opt/expand-on-first-boot.yml b/kas/opt/expand-on-first-boot.yml
index 03d666b2..f5be6992 100644
--- a/kas/opt/expand-on-first-boot.yml
+++ b/kas/opt/expand-on-first-boot.yml
@@ -15,3 +15,6 @@ header:
 local_conf_header:
   package-expand-on-first-boot: |
     IMAGE_INSTALL:append = " expand-on-first-boot"
+  expand-before-encrypt: |
+    IMAGE_INSTALL:remove:encrypt-partitions = "expand-on-first-boot"
+    CRYPT_PARTITIONS:append:encrypt-partitions = ":expand"
diff --git a/recipes-initramfs/initramfs-crypt-hook/files/local-top-complete b/recipes-initramfs/initramfs-crypt-hook/files/local-top-complete
index 28548502..834dea22 100644
--- a/recipes-initramfs/initramfs-crypt-hook/files/local-top-complete
+++ b/recipes-initramfs/initramfs-crypt-hook/files/local-top-complete
@@ -95,6 +95,64 @@ EOF
 		/usr/sbin/cryptsetup reencrypt --encrypt --reduce-device-size "$reduce_device_size"k "$1" < "$2"
 	fi
 }
+
+expand_partition() {
+	boot_device="$(echo "${part_device}" | sed 's/p\?[0-9]*$//')"
+	last_part="$(sfdisk -d "${boot_device}" 2>/dev/null | \
+		     tail -1 | cut -d ' ' -f 1)"
+	if [ "$last_part" != "$1" ]; then
+		log_warning_msg "To be expanded partition is not last - skipping expansion"
+		return
+	fi
+
+	buffer_size=32768
+	boot_device_name=${boot_device##*/}
+	disk_size="$(cat /sys/class/block/"${boot_device_name}"/size)"
+	all_parts_size=0
+	for partition in /sys/class/block/"${boot_device_name}"/"${boot_device_name}"*; do
+		part_size=$(cat "${partition}"/size)
+		all_parts_size=$((all_parts_size + part_size))
+	done
+
+	minimal_size=$((all_parts_size + buffer_size))
+	if [ "$disk_size" -lt "$minimal_size" ]; then
+		return
+	fi
+
+	log_begin_msg "Expanding partition $last_part"
+
+	is_gpt="$(sfdisk -d "${boot_device}" 2>/dev/null | grep -q "label: gpt" \
+		  && echo 1 || echo 0)"
+	if [ "$is_gpt" = "1" ]; then
+		dd if="${boot_device}" of=/tmp/__mbr__.bak count=1 >/dev/null 2>&1
+	fi
+
+	# Transform the partition table as follows:
+	#
+	# - Remove any 'last-lba' header so sfdisk uses the entire available
+	#   space.
+	# - If this partition table is MBR and an extended partition container
+	#   (EBR) exists, we assume this needs to be expanded as well; remove
+	#   its size field so sfdisk expands it.
+	# - For the previously fetched last partition, also remove the size
+	#   field so sfdisk expands it.
+	sfdisk -d "${boot_device}" 2>/dev/null | \
+		grep -v last-lba | \
+		sed 's|^\(.*, \)size=[^,]*, \(type=[f5]\)$|\1\2|' | \
+		sed 's|^\('"${last_part}"' .*, \)size=[^,]*, |\1|' | \
+		sfdisk --force "${boot_device}" >/dev/null 2>&1
+
+	if [ "$is_gpt" = "1" ]; then
+		dd if=/tmp/__mbr__.bak of="${boot_device}" >/dev/null 2>&1
+		rm /tmp/__mbr__.bak
+	fi
+
+	# Inform the kernel about the partitioning change
+	partx -u "${last_part}"
+
+	log_end_msg
+}
+
 for candidate in /dev/tpm*; do
 	if [ -x /usr/bin/tpm2_pcrread ]; then
 		if ! tpm2_pcrread -T device:"$candidate" "$pcr_bank_hash_type":7 --quiet ; then
@@ -129,6 +187,7 @@ for partition_set in $partition_sets; do
 	partition="$(awk -v var="$partition_set" 'BEGIN{split(var,a,":"); print a[1]}')"
 	partition_mountpoint="$(awk -v var="$partition_set" 'BEGIN{split(var,a,":"); print a[2]}')"
 	partition_format="$(awk -v var="$partition_set" 'BEGIN{split(var,a,":"); print a[3]}')"
+	partition_expand="$(awk -v var="$partition_set" 'BEGIN{split(var,a,":"); print a[4]}')"
 	case "$partition" in
 		/*)
 			part_device=$(readlink -f "$partition")
@@ -153,6 +212,10 @@ for partition_set in $partition_sets; do
 		echo "ROOT=$decrypted_part" >/conf/param.conf
 	fi
 
+	if [ "$partition_expand" = "expand" ]; then
+		expand_partition $part_device
+	fi
+
 	if /usr/sbin/cryptsetup luksDump --batch-mode "$part_device" \
 			| grep -q "luks2"; then
 		open_tpm2_partition "$part_device" "$crypt_mount_name" "$tpm_device"
diff --git a/recipes-initramfs/initramfs-crypt-hook/initramfs-crypt-hook_0.5.bb b/recipes-initramfs/initramfs-crypt-hook/initramfs-crypt-hook_0.5.bb
index 6ff315ed..71ee44db 100644
--- a/recipes-initramfs/initramfs-crypt-hook/initramfs-crypt-hook_0.5.bb
+++ b/recipes-initramfs/initramfs-crypt-hook/initramfs-crypt-hook_0.5.bb
@@ -69,7 +69,7 @@ SRC_URI += "file://encrypt_partition.env.tmpl \
             file://hook \
             file://pwquality.conf"
 
-# CRYPT_PARTITIONS elements are <partition-label>:<mountpoint>:<reencrypt or format>
+# CRYPT_PARTITIONS elements are <partition-label>:<mountpoint>:<reencrypt or format>[:expand]
 CRYPT_PARTITIONS ??= "home:/home:reencrypt var:/var:reencrypt"
 # CRYPT_CREATE_FILE_SYSTEM_CMD contains the shell command to create the filesystem
 # in a newly formatted LUKS Partition
@@ -88,6 +88,10 @@ TEMPLATE_VARS += "CRYPT_PARTITIONS CRYPT_CREATE_FILE_SYSTEM_CMD \
     CRYPT_KEY_ALGORITHM CRYPT_ENCRYPTION_OPTIONAL"
 TEMPLATE_FILES += "encrypt_partition.env.tmpl"
 
+OVERRIDES .= "${@':expand-on-crypt' if ':expand' in d.getVar('CRYPT_PARTITIONS') else ''}"
+DEBIAN_DEPENDS:append:expand-on-crypt = ", fdisk, util-linux"
+HOOK_COPY_EXECS:append:expand-on-crypt = " sed sfdisk tail cut dd partx rm"
+
 do_install[cleandirs] += "${D}/usr/share/encrypt_partition"
 do_install:prepend() {
     install -m 0600 "${WORKDIR}/encrypt_partition.env" "${D}/usr/share/encrypt_partition/encrypt_partition.env"
-- 
2.43.0


