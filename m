Return-Path: <quirin.gylstorff@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0900C64ED8
	for <webhook@archiver.kernel.org>; Fri, 17 Feb 2023 13:05:53 +0000 (UTC)
Received: from mta-64-228.siemens.flowmailer.net (mta-64-228.siemens.flowmailer.net [185.136.64.228])
 by mx.groups.io with SMTP id smtpd.web10.5861.1676639145667462777
 for <cip-dev@lists.cip-project.org>;
 Fri, 17 Feb 2023 05:05:45 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=Quirin.Gylstorff@siemens.com header.s=fm1 header.b=VUm7du74;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.64.228, mailfrom: fm-51332-20230217130543402b2e6da89a37a7e1-nb__qz@rts-flowmailer.siemens.com)
Received: by mta-64-228.siemens.flowmailer.net with ESMTPSA id 20230217130543402b2e6da89a37a7e1
        for <cip-dev@lists.cip-project.org>;
        Fri, 17 Feb 2023 14:05:43 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=Quirin.Gylstorff@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:References:In-Reply-To;
 bh=kb2gzLqQ0Kdf8Ua9sTCDfII4OxScHnRG1IDzvyX0sGM=;
 b=VUm7du74Llz8sUY4nM0Wg6swgh9PSnd+VG1LWGPC/1B3Bj0LnHCNYPRfv/m6O7aNpoHwoi
 KcfxoVM0ZjCHdhGE11TR01V9ArcGAVapBuGTyV+k4xBitFAxUjK4Ij2+7rbWT6DaaK/ySfKl
 C5Ygx1VuI2V4/DbQX0n6h6vW3YeuQ=;
From: Quirin Gylstorff <Quirin.Gylstorff@siemens.com>
To: cip-dev@lists.cip-project.org,
	christian.storm@siemens.com,
	jan.kiszka@siemens.com
Subject: [cip-dev][isar-cip-core][RFC v2 4/7] Add initramfs hook to encrypt a partition
Date: Fri, 17 Feb 2023 14:05:37 +0100
Message-Id: <20230217130540.509910-5-Quirin.Gylstorff@siemens.com>
In-Reply-To: <20230217130540.509910-1-Quirin.Gylstorff@siemens.com>
References: <20230217130540.509910-1-Quirin.Gylstorff@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-51332:519-21489:flowmailer
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 17 Feb 2023 13:05:53 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/10716

From: Quirin Gylstorff <quirin.gylstorff@siemens.com>

This creates a new luks encrypted ext4 partition with a the
key stored in the tpm2.

The initial key is randomly generated and removed from the
LUKS partition. Therefore a new key cannot be added by the user
and if the LUKS header is corrupted the data is no longer readable.

Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
---
 .../files/encrypt_partition.env.tmpl          |   2 +
 .../files/encrypt_partition.hook              |  49 +++++++
 .../files/encrypt_partition.script            | 135 ++++++++++++++++++
 .../initramfs-crypt-hook_0.1.bb               |  37 +++++
 wic/x86-efibootguard.wks.in                   |   4 +-
 5 files changed, 225 insertions(+), 2 deletions(-)
 create mode 100644 recipes-initramfs/initramfs-crypt-hook/files/encrypt_partition.env.tmpl
 create mode 100644 recipes-initramfs/initramfs-crypt-hook/files/encrypt_partition.hook
 create mode 100644 recipes-initramfs/initramfs-crypt-hook/files/encrypt_partition.script
 create mode 100644 recipes-initramfs/initramfs-crypt-hook/initramfs-crypt-hook_0.1.bb

diff --git a/recipes-initramfs/initramfs-crypt-hook/files/encrypt_partition.env.tmpl b/recipes-initramfs/initramfs-crypt-hook/files/encrypt_partition.env.tmpl
new file mode 100644
index 0000000..943fe4b
--- /dev/null
+++ b/recipes-initramfs/initramfs-crypt-hook/files/encrypt_partition.env.tmpl
@@ -0,0 +1,2 @@
+PARTITIONS="${CRYPT_PARTITIONS}"
+REDUDUCE_DEVICE_SIZE="${CRYPT_REDUDUCE_DEVICE_SIZE}"
diff --git a/recipes-initramfs/initramfs-crypt-hook/files/encrypt_partition.hook b/recipes-initramfs/initramfs-crypt-hook/files/encrypt_partition.hook
new file mode 100644
index 0000000..96e084a
--- /dev/null
+++ b/recipes-initramfs/initramfs-crypt-hook/files/encrypt_partition.hook
@@ -0,0 +1,49 @@
+#!/bin/sh
+# Copyright (C) Siemens AG, 2020-2022
+#
+# SPDX-License-Identifier: MIT
+
+PREREQ=""
+
+prereqs()
+{
+     echo "$PREREQ"
+}
+
+case $1 in
+prereqs)
+     prereqs
+     exit 0
+     ;;
+esac
+
+. /usr/share/initramfs-tools/scripts/functions
+. /usr/share/initramfs-tools/hook-functions
+
+manual_add_modules tpm
+manual_add_modules tpm_tis_core
+manual_add_modules tpm_tis
+manual_add_modules tpm_crb
+manual_add_modules dm_mod
+manual_add_modules dm_crypt
+
+copy_exec /usr/bin/openssl
+copy_exec /usr/sbin/mke2fs
+copy_exec /usr/bin/grep
+copy_exec /usr/bin/awk
+copy_exec /usr/bin/expr
+copy_exec /usr/sbin/e2fsck
+copy_exec /usr/sbin/resize2fs
+copy_exec /usr/sbin/cryptsetup
+copy_exec /usr/bin/systemd-cryptenroll
+copy_exec /usr/lib/systemd/systemd-cryptsetup
+
+if [ -x cryptsetup-reencrypt ]; then
+    copy_exec /usr/sbin/cryptsetup-reencrypt
+fi
+
+for _LIBRARY in /usr/lib/*/libtss2*; do
+    copy_exec "$_LIBRARY"
+done
+
+copy_file library /usr/share/encrypt_partition/encrypt_partition.env /usr/share/encrypt_partition/encrypt_partition.env
diff --git a/recipes-initramfs/initramfs-crypt-hook/files/encrypt_partition.script b/recipes-initramfs/initramfs-crypt-hook/files/encrypt_partition.script
new file mode 100644
index 0000000..e58794e
--- /dev/null
+++ b/recipes-initramfs/initramfs-crypt-hook/files/encrypt_partition.script
@@ -0,0 +1,135 @@
+#!/bin/sh
+#
+# CIP Core, generic profile
+#
+# Copyright (c) Siemens AG, 2023
+#
+# Authors:
+#  Quirin Gylstorff <quirin.gylstorff@siemens.com>
+#
+# SPDX-License-Identifier: MIT
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
+# load necessary kernel modules:
+modprobe tpm_tis
+modprobe tpm_crb
+
+# fixed tpm device or do we need to find it
+tpm_device=/dev/tpmrm0
+partition_sets="$PARTITIONS"
+
+open_tpm2_partition() {
+	if ! /usr/lib/systemd/systemd-cryptsetup attach "$crypt_mount_name" \
+		 "$1" - tpm2-device="$tpm_device"; then
+		panic "Can't decrypt '$1' !"
+	fi
+}
+
+enroll_tpm2_token() {
+	#check systemd version and export password if necessary
+	if [ -x /usr/bin/systemd-cryptenroll ]; then
+		systemd_version=$(systemd-cryptenroll --version | \
+							  awk -F " " 'NR==1{print $2 }')
+		#check systemd version and export password if necessary
+		if [ "$systemd_version" -ge "251" ]; then
+			PASSWORD=$(cat "$2" )
+			export PASSWORD
+			/usr/bin/systemd-cryptenroll --tpm2-device="$tpm_device" \
+										 --tpm2-pcrs=7 "$1"
+			PASSWORD=
+		else
+			panic "Unknown systemd version: '$systemd_version'!"
+		fi
+	fi
+}
+
+reencrypt_existing_partition() {
+	part_device=$(readlink -f "$partition")
+	part_size_blocks=$(cat /sys/class/block/"$(awk -v dev=$part_device 'BEGIN{split(dev,a,"/"); print a[3]}' )"/size)
+	reduced_size=$(expr $part_size_blocks - 65536 )
+	reduced_size_in_byte=$(expr $reduced_size \* 512)
+	reduced_size_in_kb=$(expr $reduced_size_in_byte / 1024)K
+	resize2fs "$1" "$reduced_size_in_kb"
+	if [ -x cryptsetup-reencrypt ]; then
+		/usr/sbin/cryptsetup-reencrypt --new --reduce-device-size "${REDUDUCE_DEVICE_SIZE}" $1 < $2
+	else
+		/usr/sbin/cryptsetup reencrypt --encrypt --reduce-device-size "${REDUDUCE_DEVICE_SIZE}" $1 < $2
+	fi
+
+}
+
+
+if [ ! -e "$tpm_device" ]; then
+	panic "tpm device '$tpm_device' does not exists - cannot create a encrypted device!"
+fi
+
+for partition_set in $partition_sets; do
+	partition_label=$(awk -v var=$partition_set 'BEGIN{split(var,a,":"); print a[1]}')
+	partition_mountpoint=$(awk -v var=$partition_set 'BEGIN{split(var,a,":"); print a[2]}')
+	partition_format=$(awk -v var=$partition_set 'BEGIN{split(var,a,":"); print a[3]}')
+	partition=/dev/disk/by-partlabel/$partition_label
+	crypt_mount_name="encrypted_$partition_label"
+	decrypted_part=/dev/mapper/"$crypt_mount_name"
+
+	# check if partition is already encrypted with systemd-tpm2
+	if /usr/sbin/cryptsetup luksDump --batch-mode "$partition" \
+			| grep -q "systemd-tpm2"; then
+		open_tpm2_partition "$partition"
+		if ! mount -t $(get_fstype "${decrypted_part}") "${decrypted_part}" "${rootmnt}${partition_mountpoint}"; then
+		    panic "Can't mount encrypted partition '${decrypted_part}'!"
+		fi
+		continue
+	fi
+
+	# create random password for initial encryption
+	# this will be dropped after reboot
+	tmp_key=/tmp/"$partition_label-lukskey"
+	openssl rand -base64 32 > "$tmp_key"
+
+	case "${partition_format}" in
+        "reencrypt")
+		    reencrypt_existing_partition "$partition" "$tmp_key"
+		    enroll_tpm2_token "$partition" "$tmp_key"
+		    open_tpm2_partition "$partition"
+        ;;
+        "format")
+		    /usr/sbin/cryptsetup luksFormat --batch-mode \
+							     --type luks2 "$partition" < "$tmp_key"
+		    enroll_tpm2_token "$partition" "$tmp_key"
+		    open_tpm2_partition_tpm2_partition "$partition"
+		    mke2fs -t ext4 "${decrypted_part}"
+        ;;
+        *)
+		    panic "Unknown value ${partition_format}. Cannot create a encrypted partition !"
+         ;;
+	esac
+
+	if ! mount -t $(get_fstype "${decrypted_part}") "${decrypted_part}" "${rootmnt}${partition_mountpoint}"; then
+		panic "Can't mount encrypted partition '${decrypted_part}'!"
+	fi
+
+	# delete initial key
+	# afterwards no new keys can be enrolled
+	/usr/bin/systemd-cryptenroll "$partition" --wipe-slot=0
+done
diff --git a/recipes-initramfs/initramfs-crypt-hook/initramfs-crypt-hook_0.1.bb b/recipes-initramfs/initramfs-crypt-hook/initramfs-crypt-hook_0.1.bb
new file mode 100644
index 0000000..ba2b884
--- /dev/null
+++ b/recipes-initramfs/initramfs-crypt-hook/initramfs-crypt-hook_0.1.bb
@@ -0,0 +1,37 @@
+#
+# CIP Core, generic profile
+#
+# Copyright (c) Siemens AG, 2020-2022
+#
+# Authors:
+#  Quirin Gylstorff <quirin.gylstorff@siemens.com>
+#
+# SPDX-License-Identifier: MIT
+
+
+inherit dpkg-raw
+
+DEBIAN_DEPENDS = "initramfs-tools, cryptsetup, systemd(>= 251), \
+    awk, openssl, libtss2-esys-3.0.2-0, libtss2-rc0, libtss2-mu0, e2fsprogs"
+
+SRC_URI += "file://encrypt_partition.hook \
+            file://encrypt_partition.script \
+    file://encrypt_partition.env.tmpl"
+
+CRYPT_PARTITIONS ??= "home:/home:reencrypt var:/var:reencrypt"
+CRYPT_REDUDUCE_DEVICE_SIZE="32M"
+
+TEMPLATE_VARS = "CRYPT_PARTITIONS CRYPT_REDUDUCE_DEVICE_SIZE"
+TEMPLATE_FILES = "encrypt_partition.env.tmpl"
+
+do_install[cleandirs] += " \
+    ${D}/usr/share/initramfs-tools/hooks \
+    ${D}/usr/share/encrypt_partition \
+    ${D}/usr/share/initramfs-tools/scripts/local-bottom"
+do_install() {
+    install -m 0600 "${WORKDIR}/encrypt_partition.env" "${D}/usr/share/encrypt_partition/encrypt_partition.env"
+    install -m 0755 "${WORKDIR}/encrypt_partition.script" \
+        "${D}/usr/share/initramfs-tools/scripts/local-bottom/encrypt_partition"
+    install -m 0755 "${WORKDIR}/encrypt_partition.hook" \
+        "${D}/usr/share/initramfs-tools/hooks/encrypt_partition"
+}
diff --git a/wic/x86-efibootguard.wks.in b/wic/x86-efibootguard.wks.in
index b635a8b..1d29583 100644
--- a/wic/x86-efibootguard.wks.in
+++ b/wic/x86-efibootguard.wks.in
@@ -7,7 +7,7 @@ part --source rawcopy --sourceparams "file=${IMAGE_FULLNAME}.squashfs" --align 1
 part --source empty --align 1024 --fixed-size 1G --uuid "${ABROOTFS_PART_UUID_B}"
 
 # home and var are extra partitions
-part /home --source rootfs --rootfs-dir=${IMAGE_ROOTFS}/home --fstype=ext4 --label home --align 1024  --size 1G
-part /var --source rootfs --rootfs-dir=${IMAGE_ROOTFS}/var --fstype=ext4 --label var --align 1024  --size 2G
+part /home --source rootfs --rootfs-dir=${IMAGE_ROOTFS}/home --fstype=ext4 --label home --align 1024  --size 1G --extra-space=100M 
+part /var --source rootfs --rootfs-dir=${IMAGE_ROOTFS}/var --fstype=ext4 --label var --align 1024  --size 2G --extra-space=100M
 
 bootloader --ptable gpt --append="console=tty0 console=ttyS0,115200 rootwait earlyprintk"
-- 
2.39.1


