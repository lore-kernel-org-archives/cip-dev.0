Return-Path: <quirin.gylstorff@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5412C6FD1F
	for <webhook@archiver.kernel.org>; Fri, 22 Mar 2024 10:06:19 +0000 (UTC)
Received: from mta-64-226.siemens.flowmailer.net (mta-64-226.siemens.flowmailer.net [185.136.64.226])
 by mx.groups.io with SMTP id smtpd.web10.9309.1711101970844202523
 for <cip-dev@lists.cip-project.org>;
 Fri, 22 Mar 2024 03:06:11 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=Quirin.Gylstorff@siemens.com header.s=fm1 header.b=cxR1QVv/;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.64.226, mailfrom: fm-51332-20240322100608891bc966230ee87127-wqjgsj@rts-flowmailer.siemens.com)
Received: by mta-64-226.siemens.flowmailer.net with ESMTPSA id 20240322100608891bc966230ee87127
        for <cip-dev@lists.cip-project.org>;
        Fri, 22 Mar 2024 11:06:08 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=Quirin.Gylstorff@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:References:In-Reply-To;
 bh=EsWalcVDNXtkahH9g39M4UbiYdjj0ZKm+HmxLzsxBKk=;
 b=cxR1QVv/RX3WCRtNzc7CBNER3UTetZx7yYAXltYmtsw4M8zjw6sDCpL9XUx5+2LioA2rcK
 OGGIeg0U0XABK0AIexujcJk7KZKePPOAmoDJa6gU2ySXMyLuxAEKYjvHH7c7pkaJJlh0p+/W
 lg3oaKF6Fdw48HfpKGoOZcmVVJpzg=;
From: Quirin Gylstorff <Quirin.Gylstorff@siemens.com>
To: jan.kiszka@siemens.com,
	cip-dev@lists.cip-project.org,
	johnxw@amazon.com
Subject: [cip-dev][isar-cip-core][PATCH v2 10/13] initramfs-crypt-hook: Consolidate clevis and systemd scripts
Date: Fri, 22 Mar 2024 11:05:20 +0100
Message-ID: <20240322100605.4129226-11-Quirin.Gylstorff@siemens.com>
In-Reply-To: <20240322100605.4129226-1-Quirin.Gylstorff@siemens.com>
References: <20240322100605.4129226-1-Quirin.Gylstorff@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-51332:519-21489:flowmailer
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 22 Mar 2024 10:06:19 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/15408

From: Quirin Gylstorff <quirin.gylstorff@siemens.com>

This reduce the maintaince as the common code is only maintained
once.

Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
---
 .../files/encrypt_partition.clevis.hook       |   1 +
 .../files/encrypt_partition.clevis.script     | 177 ++----------------
 .../files/encrypt_partition.script            | 164 ++++++++++++++++
 .../files/encrypt_partition.systemd.hook      |   1 +
 .../files/encrypt_partition.systemd.script    | 163 ++--------------
 .../initramfs-crypt-hook_0.1.bb               |   5 +-
 6 files changed, 208 insertions(+), 303 deletions(-)
 create mode 100644 recipes-initramfs/initramfs-crypt-hook/files/encrypt_partition.script

diff --git a/recipes-initramfs/initramfs-crypt-hook/files/encrypt_partition.clevis.hook b/recipes-initramfs/initramfs-crypt-hook/files/encrypt_partition.clevis.hook
index 1921aba..0bb8ce6 100755
--- a/recipes-initramfs/initramfs-crypt-hook/files/encrypt_partition.clevis.hook
+++ b/recipes-initramfs/initramfs-crypt-hook/files/encrypt_partition.clevis.hook
@@ -81,4 +81,5 @@ for _LIBRARY in /usr/lib/*/libtss2*; do
 done
 
 copy_file library /usr/share/encrypt_partition/encrypt_partition.env /usr/share/encrypt_partition/encrypt_partition.env
+copy_file library /usr/share/encrypt_partition/encrypt_partition_tpm2 /usr/share/encrypt_partition/encrypt_partition_tpm2
 copy_file pwmake-config /usr/share/encrypt_partition/pwquality.conf /etc/security/pwquality.conf
diff --git a/recipes-initramfs/initramfs-crypt-hook/files/encrypt_partition.clevis.script b/recipes-initramfs/initramfs-crypt-hook/files/encrypt_partition.clevis.script
index fdbd9b5..ddb3eab 100644
--- a/recipes-initramfs/initramfs-crypt-hook/files/encrypt_partition.clevis.script
+++ b/recipes-initramfs/initramfs-crypt-hook/files/encrypt_partition.clevis.script
@@ -9,177 +9,38 @@
 #
 # SPDX-License-Identifier: MIT
 
-prereqs()
-{
-	# Make sure that this script is run last in local-top
-	local req
-	for req in "${0%/*}"/*; do
-		script="${req##*/}"
-		if [ "$script" != "${0##*/}" ]; then
-			printf '%s\n' "$script"
-		fi
-	done
-}
-case $1 in
-prereqs)
-	prereqs
-	exit 0
-	;;
-esac
-
-. /scripts/functions
-
-# get configuration variables
-. /usr/share/encrypt_partition/encrypt_partition.env
-
-# load necessary kernel modules:
-modprobe tpm_tis
-modprobe tpm_crb
-
-modprobe ecb
-modprobe aes_generic
-modprobe xts
-
-# this needs to be probed particularly for re-encryption
-modprobe loop
-
-partition_sets="$PARTITIONS"
-create_file_system_cmd="$CREATE_FILE_SYSTEM_CMD"
-pcr_bank_hash_type="$HASH_TYPE"
-tpm_key_algorithm="$KEY_ALGORITHM"
-tpm_encryption_optional="$ENCRYPTION_IS_OPTIONAL"
-if [ -z "${create_file_system_cmd}" ]; then
-	create_file_system_cmd="mke2fs -t ext4"
-fi
-
-service_watchdog() {
-	for n in $(seq $(($SETUP_TIMEOUT / 10)) ); do
-		printf '\0'
-		sleep 10
-	done > "$WATCHDOG_DEV"
-}
 
 open_tpm2_partition() {
+	partition_device="$1"
+	crypt_mount_name="$2"
+	#tpm_device="$3"
 	if ! /usr/bin/clevis luks unlock -n "$crypt_mount_name" \
-		 -d "$1"; then
-		panic "Can't decrypt '$1' !"
+		 -d "$partition_device"; then
+		panic "Can't decrypt '$partition_device' !"
 	fi
 }
 
 enroll_tpm2_token() {
+	partition_device="$1"
+	passphrase="$2"
+	#tpm_device="$3"
+	tpm_key_algorithm="$4"
+	pcr_bank_hash_type="$5"
 	if [ -x /usr/bin/clevis ]; then
-		clevis luks bind -d "$1" tpm2 '{"key":"'"$tpm_key_algorithm"'", "pcr_bank":"'"$pcr_bank_hash_type"'","pcr_ids":"7"}' < "$2"
+		clevis luks bind -d "$partition_device" tpm2 '{"key":"'"$tpm_key_algorithm"'", "pcr_bank":"'"$pcr_bank_hash_type"'","pcr_ids":"7"}' < "$passphrase"
 	else
 		panic "clevis not available cannot enroll tpm2 key!"
 	fi
 }
 
-reencrypt_existing_partition() {
-	part_size_blocks="$(cat /sys/class/block/"$(awk -v dev="$1" 'BEGIN{split(dev,a,"/"); print a[3]}' )"/size)"
-	# reduce the filesystem and partition by 32M to fit the LUKS header
-	reduce_device_size=32768
-	reduced_size="$(expr "$part_size_blocks" - 65536 )"
-	reduced_size_in_byte="$(expr "$reduced_size" \* 512)"
-	reduced_size_in_kb="$(expr "$reduced_size_in_byte" / 1024)K"
-	e2fsck -f "$1"
-	if ! resize2fs "$1" "${reduced_size_in_kb}"; then
-		panic "reencryption of filesystem $1 cannot continue!"
-	fi
-	if [ -x /usr/sbin/cryptsetup-reencrypt ]; then
-		/usr/sbin/cryptsetup-reencrypt --new --reduce-device-size "$reduce_device_size"k "$1" < "$2"
-	else
-		/usr/sbin/cryptsetup reencrypt --encrypt --reduce-device-size "$reduce_device_size"k "$1" < "$2"
+prepare_for_encryption() {
+	# clevis needs /dev/fd create it in the initramfs
+	if [ ! -e /dev/fd ]; then
+		ln -s /proc/self/fd /dev/fd
 	fi
 }
 
-for candidate in /dev/tpm*; do
-	if [ -x /usr/bin/tpm2_pcrread ]; then
-		if ! tpm2_pcrread -T device:"$candidate" "$pcr_bank_hash_type":7 --quiet ; then
-			continue
-		fi
-	elif [ -x /usr/bin/tpm2_pcrlist ]; then
-		export TPM2TOOLS_DEVICE_FILE="$candidate"
-		if ! tpm2_pcrlist -L "$pcr_bank_hash_type":7 > /dev/null; then
-			continue
-		fi
-	fi
-	# Debian buster does not have tpm_testparms
-	if [ -x /usr/bin/tpm2_testparms ]; then
-		if ! tpm2_testparms -T device:"$candidate" "$tpm_key_algorithm" --quiet; then
-			continue
-		fi
-	fi
-	tpm_device=$candidate
-done
-
-if [ ! -e "$tpm_device" ]; then
-	if [ "$tpm_encryption_optional" = "true" ]; then
-		echo "No tpm_device exists abort optional encryption"
-		exit 0
-	fi
-	panic "No tpm device exists or supports pcr_hash '$pcr_bank_hash_type' or '$tpm_key_algorithm' - cannot create a encrypted device!"
-fi
-
-# clevis needs /dev/fd create it in the initramfs
-if [ ! -e /dev/fd ]; then
-	ln -s /proc/self/fd /dev/fd
-fi
-
-for partition_set in $partition_sets; do
-	partition_label="$(awk -v var="$partition_set" 'BEGIN{split(var,a,":"); print a[1]}')"
-	partition_mountpoint="$(awk -v var="$partition_set" 'BEGIN{split(var,a,":"); print a[2]}')"
-	partition_format="$(awk -v var="$partition_set" 'BEGIN{split(var,a,":"); print a[3]}')"
-	partition=/dev/disk/by-partlabel/"$partition_label"
-	crypt_mount_name="encrypted_$partition_label"
-	decrypted_part=/dev/mapper/"$crypt_mount_name"
-	# clevis does not work with links in /dev/disk*
-	part_device=$(readlink -f "$partition")
-	# check if we are trying to mount root
-	if [ "$partition_mountpoint" = "/" ]; then
-		echo "ROOT=$decrypted_part" >/conf/param.conf
-	fi
-
-	if /usr/sbin/cryptsetup luksDump --batch-mode "$partition" \
-			| grep -q "clevis"; then
-		open_tpm2_partition "$part_device"
-		continue
-	fi
-
-	# service watchdog in the background during lengthy re-encryption
-	if [ -z "$watchdog_pid" ]; then
-		service_watchdog &
-		watchdog_pid=$!
-	fi
-
-	# create random password for initial encryption
-	# this will be dropped after reboot
-	tmp_key=/tmp/"$partition_label-lukskey"
-	openssl rand -base64 32 > "$tmp_key"
-
-	case "${partition_format}" in
-		"reencrypt")
-			reencrypt_existing_partition "$part_device" "$tmp_key"
-			enroll_tpm2_token "$part_device" "$tmp_key"
-			open_tpm2_partition "$part_device"
-		;;
-		"format")
-			/usr/sbin/cryptsetup luksFormat --batch-mode \
-				 --type luks2 "$partition" < "$tmp_key"
-			enroll_tpm2_token "$part_device" "$tmp_key"
-			open_tpm2_partition "$part_device"
-			eval "${create_file_system_cmd} ${decrypted_part}"
-		;;
-		*)
-			panic "Unknown value ${partition_format}. Cannot create a encrypted partition !"
-		 ;;
-	esac
-
-
-	# delete initial key
-	# afterwards no new keys can be enrolled
-	cryptsetup -v luksKillSlot -q  "$part_device" 0
-done
-
-if [ -n "$watchdog_pid" ]; then
-	kill "$watchdog_pid"
-fi
+finalize_tpm2_encryption() {
+	partition_device="$1"
+	cryptsetup -v luksKillSlot -q  "$partition_device" 0
+}
diff --git a/recipes-initramfs/initramfs-crypt-hook/files/encrypt_partition.script b/recipes-initramfs/initramfs-crypt-hook/files/encrypt_partition.script
new file mode 100644
index 0000000..8763f69
--- /dev/null
+++ b/recipes-initramfs/initramfs-crypt-hook/files/encrypt_partition.script
@@ -0,0 +1,164 @@
+#!/bin/sh
+#
+# CIP Core, generic profile
+#
+# Copyright (c) Siemens AG, 2023-2024
+#
+# Authors:
+#  Quirin Gylstorff <quirin.gylstorff@siemens.com>
+#
+# SPDX-License-Identifier: MIT
+
+prereqs()
+{
+	# Make sure that this script is run last in local-top
+	local req
+	for req in "${0%/*}"/*; do
+		script="${req##*/}"
+		if [ "$script" != "${0##*/}" ]; then
+			printf '%s\n' "$script"
+		fi
+	done
+}
+case $1 in
+prereqs)
+	prereqs
+	exit 0
+	;;
+esac
+
+. /scripts/functions
+
+# get configuration variables
+. /usr/share/encrypt_partition/encrypt_partition.env
+
+# get the implementation
+. /usr/share/encrypt_partition/encrypt_partition_tpm2
+# load necessary kernel modules:
+modprobe tpm_tis
+modprobe tpm_crb
+
+modprobe ecb
+modprobe aes_generic
+modprobe xts
+
+# this needs to be probed particularly for re-encryption
+modprobe loop
+
+partition_sets="$PARTITIONS"
+create_file_system_cmd="$CREATE_FILE_SYSTEM_CMD"
+pcr_bank_hash_type="$HASH_TYPE"
+tpm_key_algorithm="$KEY_ALGORITHM"
+tpm_encryption_optional="$ENCRYPTION_IS_OPTIONAL"
+if [ -z "${create_file_system_cmd}" ]; then
+	create_file_system_cmd="mke2fs -t ext4"
+fi
+
+service_watchdog() {
+	for n in $(seq $(($SETUP_TIMEOUT / 10)) ); do
+		printf '\0'
+		sleep 10
+	done > "$WATCHDOG_DEV"
+}
+
+reencrypt_existing_partition() {
+	part_size_blocks="$(cat /sys/class/block/"$(awk -v dev="$1" 'BEGIN{split(dev,a,"/"); print a[3]}' )"/size)"
+	# reduce the filesystem and partition by 32M to fit the LUKS header
+	reduce_device_size=32768
+	reduced_size="$(expr "$part_size_blocks" - 65536 )"
+	reduced_size_in_byte="$(expr "$reduced_size" \* 512)"
+	reduced_size_in_kb="$(expr "$reduced_size_in_byte" / 1024)K"
+	e2fsck -f "$1"
+	if ! resize2fs "$1" "${reduced_size_in_kb}"; then
+		panic "reencryption of filesystem $1 cannot continue!"
+	fi
+	if [ -x /usr/sbin/cryptsetup-reencrypt ]; then
+		/usr/sbin/cryptsetup-reencrypt --new --reduce-device-size "$reduce_device_size"k "$1" < "$2"
+	else
+		/usr/sbin/cryptsetup reencrypt --encrypt --reduce-device-size "$reduce_device_size"k "$1" < "$2"
+	fi
+}
+for candidate in /dev/tpm*; do
+	if [ -x /usr/bin/tpm2_pcrread ]; then
+		if ! tpm2_pcrread -T device:"$candidate" "$pcr_bank_hash_type":7 --quiet ; then
+			continue
+		fi
+	elif [ -x /usr/bin/tpm2_pcrlist ]; then
+		export TPM2TOOLS_DEVICE_FILE="$candidate"
+		if ! tpm2_pcrlist -L "$pcr_bank_hash_type":7 > /dev/null; then
+			continue
+		fi
+	fi
+	# Debian buster does not have tpm_testparms
+	if [ -x /usr/bin/tpm2_testparms ]; then
+		if ! tpm2_testparms -T device:"$candidate" "$tpm_key_algorithm" --quiet; then
+			continue
+		fi
+	fi
+	tpm_device=$candidate
+done
+
+if [ ! -e "$tpm_device" ]; then
+	if [ "$tpm_encryption_optional" = "true" ]; then
+		echo "No tpm_device exists abort optional encryption"
+		exit 0
+	fi
+	panic "No tpm device exists or supports pcr_hash '$pcr_bank_hash_type' or '$tpm_key_algorithm' - cannot create a encrypted device!"
+fi
+
+prepare_for_encryption
+
+for partition_set in $partition_sets; do
+	partition_label="$(awk -v var="$partition_set" 'BEGIN{split(var,a,":"); print a[1]}')"
+	partition_mountpoint="$(awk -v var="$partition_set" 'BEGIN{split(var,a,":"); print a[2]}')"
+	partition_format="$(awk -v var="$partition_set" 'BEGIN{split(var,a,":"); print a[3]}')"
+	partition=/dev/disk/by-partlabel/"$partition_label"
+	crypt_mount_name="encrypted_$partition_label"
+	decrypted_part=/dev/mapper/"$crypt_mount_name"
+	part_device=$(readlink -f "$partition")
+	# check if we are trying to mount root
+	if [ "$partition_mountpoint" = "/" ]; then
+		echo "ROOT=$decrypted_part" >/conf/param.conf
+	fi
+
+	if /usr/sbin/cryptsetup luksDump --batch-mode "$partition" \
+			| grep -q "token"; then
+		open_tpm2_partition "$part_device" "$crypt_mount_name" "$tpm_device"
+		continue
+	fi
+
+	# service watchdog in the background during lengthy re-encryption
+	if [ -z "$watchdog_pid" ]; then
+		service_watchdog &
+		watchdog_pid=$!
+	fi
+
+	# create random password for initial encryption
+	# this will be dropped after reboot
+	tmp_key=/tmp/"$partition_label-lukskey"
+	openssl rand -base64 32 > "$tmp_key"
+
+	case "${partition_format}" in
+		"reencrypt")
+			reencrypt_existing_partition "$part_device" "$tmp_key"
+			enroll_tpm2_token "$part_device" "$tmp_key" "$tpm_device" "$tpm_key_algorithm" "$pcr_bank_hash_type"
+			open_tpm2_partition "$part_device" "$crypt_mount_name" "$tpm_device"
+		;;
+		"format")
+			/usr/sbin/cryptsetup luksFormat --batch-mode \
+				 --type luks2 "$partition" < "$tmp_key"
+			enroll_tpm2_token "$part_device" "$tmp_key"
+			open_tpm2_partition "$part_device" "$crypt_mount_name" "$tpm_device"
+			eval "${create_file_system_cmd} ${decrypted_part}"
+		;;
+		*)
+			panic "Unknown value ${partition_format}. Cannot create a encrypted partition !"
+		 ;;
+	esac
+
+	finalize_tpm2_encryption
+done
+
+if [ -n "$watchdog_pid" ]; then
+	kill "$watchdog_pid"
+fi
diff --git a/recipes-initramfs/initramfs-crypt-hook/files/encrypt_partition.systemd.hook b/recipes-initramfs/initramfs-crypt-hook/files/encrypt_partition.systemd.hook
index 6e2a211..941f0b1 100755
--- a/recipes-initramfs/initramfs-crypt-hook/files/encrypt_partition.systemd.hook
+++ b/recipes-initramfs/initramfs-crypt-hook/files/encrypt_partition.systemd.hook
@@ -61,4 +61,5 @@ for _LIBRARY in /usr/lib/*/libtss2* /usr/lib/*/libgcc_s.so.1; do
     copy_exec "$_LIBRARY"
 done
 
+copy_file library /usr/share/encrypt_partition/encrypt_partition_tpm2 /usr/share/encrypt_partition/encrypt_partition_tpm2
 copy_file library /usr/share/encrypt_partition/encrypt_partition.env /usr/share/encrypt_partition/encrypt_partition.env
diff --git a/recipes-initramfs/initramfs-crypt-hook/files/encrypt_partition.systemd.script b/recipes-initramfs/initramfs-crypt-hook/files/encrypt_partition.systemd.script
index e0c84ce..611f9cf 100644
--- a/recipes-initramfs/initramfs-crypt-hook/files/encrypt_partition.systemd.script
+++ b/recipes-initramfs/initramfs-crypt-hook/files/encrypt_partition.systemd.script
@@ -9,64 +9,23 @@
 #
 # SPDX-License-Identifier: MIT
 
-prereqs()
-{
-	# Make sure that this script is run last in local-top
-	local req
-	for req in "${0%/*}"/*; do
-		script="${req##*/}"
-		if [ "$script" != "${0##*/}" ]; then
-			printf '%s\n' "$script"
-		fi
-	done
-}
-case $1 in
-prereqs)
-	prereqs
-	exit 0
-	;;
-esac
-
-. /scripts/functions
-
-# get configuration variables
-. /usr/share/encrypt_partition/encrypt_partition.env
-
-# load necessary kernel modules:
-modprobe tpm_tis
-modprobe tpm_crb
-
-modprobe ecb
-modprobe aes_generic
-modprobe xts
-
-# this needs to be probed particularly for re-encryption
-modprobe loop
-
-partition_sets="$PARTITIONS"
-create_file_system_cmd="$CREATE_FILE_SYSTEM_CMD"
-pcr_bank_hash_type="$HASH_TYPE"
-tpm_key_algorithm="$KEY_ALGORITHM"
-tpm_encryption_optional="$ENCRYPTION_IS_OPTIONAL"
-if [ -z "${create_file_system_cmd}" ]; then
-	create_file_system_cmd="mke2fs -t ext4"
-fi
-
-service_watchdog() {
-	for n in $(seq $(($SETUP_TIMEOUT / 10)) ); do
-		printf '\0'
-		sleep 10
-	done > "$WATCHDOG_DEV"
-}
-
 open_tpm2_partition() {
+	partition_device="$1"
+	crypt_mount_name="$2"
+	tpm_device="$3"
 	if ! /usr/lib/systemd/systemd-cryptsetup attach "$crypt_mount_name" \
-		 "$1" - tpm2-device="$tpm_device"; then
-		panic "Can't decrypt '$1' !"
+		 "$partition_device" - tpm2-device="$tpm_device"; then
+		panic "Can't decrypt '$partition_device' !"
 	fi
 }
 
 enroll_tpm2_token() {
+	partition_device="$1"
+	passphrase="$2"
+	tpm_device="$3"
+	#tpm_key_algorithm="$4"
+	#pcr_bank_hash_type="$5"
+
 	# check systemd version and export password if necessary
 	if [ -x /usr/bin/systemd-cryptenroll ]; then
 		systemd_version=$(systemd-cryptenroll --version | \
@@ -74,10 +33,10 @@ enroll_tpm2_token() {
 		# check systemd version and export password if necessary
 		# systemd version 251 does not suport hash_types
 		if [ "$systemd_version" -ge "251" ]; then
-			PASSWORD=$(cat "$2" )
+			PASSWORD=$(cat "$passphrase" )
 			export PASSWORD
 			/usr/bin/systemd-cryptenroll --tpm2-device="$tpm_device" \
-				 --tpm2-pcrs=7 "$1"
+				 --tpm2-pcrs=7 "$partition_device"
 			PASSWORD=
 		else
 			panic "Unknown systemd version: '$systemd_version'!"
@@ -87,96 +46,12 @@ enroll_tpm2_token() {
 	fi
 }
 
-reencrypt_existing_partition() {
-	part_size_blocks="$(cat /sys/class/block/"$(awk -v dev="$1" 'BEGIN{split(dev,a,"/"); print a[3]}' )"/size)"
-	# reduce the filesystem and partition by 32M to fit the LUKS header
-	reduce_device_size=32768
-	reduced_size="$(expr "$part_size_blocks" - 65536 )"
-	reduced_size_in_byte="$(expr "$reduced_size" \* 512)"
-	reduced_size_in_kb="$(expr "$reduced_size_in_byte" / 1024)K"
-	e2fsck -f "$1"
-	if ! resize2fs "$1" "${reduced_size_in_kb}"; then
-		panic "reencryption of filesystem $1 cannot continue!"
-	fi
-	if [ -x /usr/sbin/cryptsetup-reencrypt ]; then
-		/usr/sbin/cryptsetup-reencrypt --new --reduce-device-size "$reduce_device_size"k "$1" < "$2"
-	else
-		/usr/sbin/cryptsetup reencrypt --encrypt --reduce-device-size "$reduce_device_size"k "$1" < "$2"
-	fi
+prepare_for_encryption() {
+	true
 }
 
-for candidate in /dev/tpm*; do
-	if ! tpm2_pcrread -T device:"$candidate" "$pcr_bank_hash_type":7 --quiet 2>/dev/null; then
-		continue
-	fi
-	if ! tpm2_testparms -T device:"$candidate" "$tpm_key_algorithm" --quiet 2>/dev/null; then
-		continue
-	fi
-	tpm_device=$candidate
-done
-
-if [ ! -e "$tpm_device" ]; then
-	if [ "$tpm_encryption_optional" = "true" ]; then
-		echo "No tpm_device exists abort optional encryption"
-		exit 0
-	fi
-	panic "No tpm device exists or supports pcr_hash '$pcr_bank_hash_type' or '$tpm_key_algorithm' - cannot create a encrypted device!"
-fi
-
-for partition_set in $partition_sets; do
-	partition_label="$(awk -v var="$partition_set" 'BEGIN{split(var,a,":"); print a[1]}')"
-	partition_mountpoint="$(awk -v var="$partition_set" 'BEGIN{split(var,a,":"); print a[2]}')"
-	partition_format="$(awk -v var="$partition_set" 'BEGIN{split(var,a,":"); print a[3]}')"
-	partition=/dev/disk/by-partlabel/"$partition_label"
-	crypt_mount_name="encrypted_$partition_label"
-	decrypted_part=/dev/mapper/"$crypt_mount_name"
-	part_device=$(readlink -f "$partition")
-
-	# check if we are trying to mount root
-	if [ "$partition_mountpoint" = "/" ]; then
-		echo "ROOT=$decrypted_part" >/conf/param.conf
-	fi
-	# check if partition is already encrypted with systemd-tpm2
-	if /usr/sbin/cryptsetup luksDump --batch-mode "$partition" \
-			| grep -q "systemd-tpm2"; then
-		open_tpm2_partition "$part_device"
-		continue
-	fi
-
-	# service watchdog in the background during lengthy re-encryption
-	if [ -z "$watchdog_pid" ]; then
-		service_watchdog &
-		watchdog_pid=$!
-	fi
-
-	# create random password for initial encryption
-	# this will be dropped after reboot
-	tmp_key=/tmp/"$partition_label-lukskey"
-	openssl rand -base64 32 > "$tmp_key"
-
-	case "${partition_format}" in
-		"reencrypt")
-			reencrypt_existing_partition "$part_device" "$tmp_key"
-			enroll_tpm2_token "$part_device" "$tmp_key"
-			open_tpm2_partition "$part_device"
-		;;
-		"format")
-			/usr/sbin/cryptsetup luksFormat --batch-mode \
-				 --type luks2 "$partition" < "$tmp_key"
-			enroll_tpm2_token "$part_device" "$tmp_key"
-			open_tpm2_partition "$part_device"
-			eval "${create_file_system_cmd} ${decrypted_part}"
-		;;
-		*)
-			panic "Unknown value ${partition_format}. Cannot create a encrypted partition !"
-		 ;;
-	esac
-
-	# delete initial key
-	# afterwards no new keys can be enrolled
-	/usr/bin/systemd-cryptenroll "$partition" --wipe-slot=0
-done
+finalize_tpm2_encryption() {
+	partition_device="$1"
+-	/usr/bin/systemd-cryptenroll --wipe-slot=0 "$partition_device"
+}
 
-if [ -n "$watchdog_pid" ]; then
-	kill "$watchdog_pid"
-fi
diff --git a/recipes-initramfs/initramfs-crypt-hook/initramfs-crypt-hook_0.1.bb b/recipes-initramfs/initramfs-crypt-hook/initramfs-crypt-hook_0.1.bb
index dc46ff8..1d5a4a7 100644
--- a/recipes-initramfs/initramfs-crypt-hook/initramfs-crypt-hook_0.1.bb
+++ b/recipes-initramfs/initramfs-crypt-hook/initramfs-crypt-hook_0.1.bb
@@ -44,6 +44,7 @@ CRYPT_BACKEND:bullseye = "clevis"
 CRYPT_BACKEND = "systemd"
 
 SRC_URI += "file://encrypt_partition.env.tmpl \
+            file://encrypt_partition.script \
             file://encrypt_partition.${CRYPT_BACKEND}.script \
             file://mount_crypt_partitions.script \
             file://encrypt_partition.${CRYPT_BACKEND}.hook \
@@ -77,8 +78,10 @@ do_install[cleandirs] += " \
 
 do_install() {
     install -m 0600 "${WORKDIR}/encrypt_partition.env" "${D}/usr/share/encrypt_partition/encrypt_partition.env"
-    install -m 0755 "${WORKDIR}/encrypt_partition.${CRYPT_BACKEND}.script" \
+    install -m 0755 "${WORKDIR}/encrypt_partition.script" \
         "${D}/usr/share/initramfs-tools/scripts/local-top/encrypt_partition"
+    install -m 0755 "${WORKDIR}/encrypt_partition.${CRYPT_BACKEND}.script" \
+        "${D}/usr/share/encrypt_partition/encrypt_partition_tpm2"
     install -m 0755 "${WORKDIR}/mount_crypt_partitions.script" \
         "${D}/usr/share/initramfs-tools/scripts/local-bottom/mount_decrypted_partition"
     install -m 0755 "${WORKDIR}/encrypt_partition.${CRYPT_BACKEND}.hook" \
-- 
2.43.0


