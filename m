Return-Path: <quirin.gylstorff@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E2FCC6FD1D
	for <webhook@archiver.kernel.org>; Fri, 17 Mar 2023 08:37:47 +0000 (UTC)
Received: from mta-65-225.siemens.flowmailer.net (mta-65-225.siemens.flowmailer.net [185.136.65.225])
 by mx.groups.io with SMTP id smtpd.web10.14647.1679042261626775137
 for <cip-dev@lists.cip-project.org>;
 Fri, 17 Mar 2023 01:37:42 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=Quirin.Gylstorff@siemens.com header.s=fm1 header.b=D8tAYvea;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.65.225, mailfrom: fm-51332-20230317083738292a3d91803dc5b907-lypvlu@rts-flowmailer.siemens.com)
Received: by mta-65-225.siemens.flowmailer.net with ESMTPSA id 20230317083738292a3d91803dc5b907
        for <cip-dev@lists.cip-project.org>;
        Fri, 17 Mar 2023 09:37:38 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=Quirin.Gylstorff@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding;
 bh=oftqOEt9qB5ooqD1sPqcb4yevCewKt+8MoWydUiij+w=;
 b=D8tAYveaughRWkTOCjHs+bV5Q//couUYkEsDn6b7OEyPAbX/WFuku4qT6WfdsQLjRo9z19
 3iA3aG4v9uNyIS2KPF75D9NRnJCkLtI4wVTPWLm/6orLGZoGtVDI4X4b3ZA0Jiefnyus6OYL
 Hlj2hyz5VHk5xNACLzulNxIh/qhIE=;
From: Quirin Gylstorff <Quirin.Gylstorff@siemens.com>
To: jan.kiszka@siemens.com,
	cip-dev@lists.cip-project.org
Subject: [cip-dev][isar-cip-core][PATCH v2] initramfs-crypt-hook: Add clevis for buster and bullseye
Date: Fri, 17 Mar 2023 09:37:37 +0100
Message-Id: <20230317083737.14025-1-Quirin.Gylstorff@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-51332:519-21489:flowmailer
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 17 Mar 2023 08:37:47 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/11033

From: Quirin Gylstorff <quirin.gylstorff@siemens.com>

This will remove the requirement to use bullseye backports.

Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
---

Changes v2:
 - fix whitespaces
 - remove set -x for debugging
 - add comment to explain settings in pwquality.conf
 - cleanup dependencies
 - make system the future default backend 

 .../preferences.bullseye-backports.tpm.conf   |   8 -
 doc/README.tpm2.encryption.md                 |   7 +-
 kas/opt/encrypt-partitions.yml                |   3 -
 .../files/encrypt_partition.clevis.hook       |  79 ++++++++++
 .../files/encrypt_partition.clevis.script     | 138 ++++++++++++++++++
 ...on.hook => encrypt_partition.systemd.hook} |   0
 ...cript => encrypt_partition.systemd.script} |   0
 .../initramfs-crypt-hook/files/pwquality.conf |   3 +
 .../initramfs-crypt-hook_0.1.bb               |  28 +++-
 9 files changed, 242 insertions(+), 24 deletions(-)
 delete mode 100644 conf/distro/preferences.bullseye-backports.tpm.conf
 create mode 100755 recipes-initramfs/initramfs-crypt-hook/files/encrypt_partition.clevis.hook
 create mode 100644 recipes-initramfs/initramfs-crypt-hook/files/encrypt_partition.clevis.script
 rename recipes-initramfs/initramfs-crypt-hook/files/{encrypt_partition.hook => encrypt_partition.systemd.hook} (100%)
 mode change 100644 => 100755
 rename recipes-initramfs/initramfs-crypt-hook/files/{encrypt_partition.script => encrypt_partition.systemd.script} (100%)
 create mode 100644 recipes-initramfs/initramfs-crypt-hook/files/pwquality.conf

diff --git a/conf/distro/preferences.bullseye-backports.tpm.conf b/conf/distro/preferences.bullseye-backports.tpm.conf
deleted file mode 100644
index 60c4265..0000000
--- a/conf/distro/preferences.bullseye-backports.tpm.conf
+++ /dev/null
@@ -1,8 +0,0 @@
-Package: *
-Pin: release n=bullseye-backports
-Pin-Priority: -1
-
-Explanation: Use systemd and its dependencies from debian-backports to support systemd-cryptenroll
-Package: libnss-myhostname libnss-mymachines libnss-resolve libnss-systemd libpam-systemd libudev* libsystemd* systemd systemd-* udev
-Pin: release n=bullseye-backports
-Pin-Priority: 801
diff --git a/doc/README.tpm2.encryption.md b/doc/README.tpm2.encryption.md
index 7914bf3..0df7f39 100644
--- a/doc/README.tpm2.encryption.md
+++ b/doc/README.tpm2.encryption.md
@@ -6,10 +6,6 @@ passphrase on the device.
 
 ## Requirements
 
-To enroll the keys Debian 12(bookworm) or Debian 11(bullseye) with backports is required.
-The implementation in Debian 11 is for *demonstration purpose only* as we need backports for
-systemd >= 248. [systemd version 248](https://github.com/systemd/systemd/blob/a41ac8ac407a1a58612059a45229f0d440f58e28/NEWS#L3391) adds the necessary systemd-cryptenroll functionality.
-
 Testing with qemu-amd64 requires the package `swtpm`. Under Debian/Ubuntu this can be installed
 
 ``` shell
@@ -18,7 +14,8 @@ apt-get install swtpm
 
 ## TPM2 protected LUKS passphrase
 
-The recipe `initramfs-crypt-hook` uses `systemd-cryptenroll` to enroll a TPM2 protected LUKS passphrase.
+The recipe `initramfs-crypt-hook` uses `systemd-cryptenroll` (Debian 12 and later)
+or `clevis` (Debian 10 and Debian 11) to enroll a TPM2 protected LUKS passphrase.
 The procedure for storing a key is described in [systemd/src/shared/tpm2-util.c](https://github.com/systemd/systemd/blob/0254e4d66af7aa893b31b2326335ded5dde48b51/src/shared/tpm2-util.c#L1395).
 
 ## How to build an QEMU image with TPM encryption
diff --git a/kas/opt/encrypt-partitions.yml b/kas/opt/encrypt-partitions.yml
index 418e753..2fe38f8 100644
--- a/kas/opt/encrypt-partitions.yml
+++ b/kas/opt/encrypt-partitions.yml
@@ -13,8 +13,5 @@ header:
   version: 12
 
 local_conf_header:
-  systemd-cryptenroll: |
-    DISTRO_APT_SOURCES:append:bullseye = " conf/distro/debian-bullseye-backports.list"
-    DISTRO_APT_PREFERENCES:append:bullseye = " conf/distro/preferences.bullseye-backports.tpm.conf"
   initramfs-option-encrypt-partitions: |
     OVERRIDES .= ":encrypt-partitions"
diff --git a/recipes-initramfs/initramfs-crypt-hook/files/encrypt_partition.clevis.hook b/recipes-initramfs/initramfs-crypt-hook/files/encrypt_partition.clevis.hook
new file mode 100755
index 0000000..07c9d96
--- /dev/null
+++ b/recipes-initramfs/initramfs-crypt-hook/files/encrypt_partition.clevis.hook
@@ -0,0 +1,79 @@
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
+. /usr/share/initramfs-tools/hook-functions
+
+hook_error() {
+    echo "(ERROR): $2" >&2
+    exit 1
+}
+
+manual_add_modules tpm
+manual_add_modules tpm_tis_core
+manual_add_modules tpm_tis
+manual_add_modules tpm_crb
+manual_add_modules dm_mod
+manual_add_modules dm_crypt
+
+copy_exec /usr/bin/openssl || hook_error "/usr/bin/openssl not found"
+copy_exec /usr/sbin/mke2fs || hook_error "/usr/sbin/mke2fs not found"
+copy_exec /usr/bin/grep || hook_error "/usr/bin/grep not found"
+copy_exec /usr/bin/awk || hook_error "/usr/bin/awk not found"
+copy_exec /usr/bin/expr || hook_error "/usr/bin/expr not found"
+copy_exec /usr/sbin/e2fsck || hook_error "/usr/sbin/e2fsck not found"
+copy_exec /usr/sbin/resize2fs || hook_error "/usr/sbin/resize2fs not found"
+copy_exec /usr/sbin/cryptsetup || hook_error "/usr/sbin/cryptsetup not found"
+copy_exec /usr/bin/clevis || hook_error "/usr/bin/clevis not found"
+copy_exec /usr/bin/clevis-decrypt || hook_error "/usr/bin/clevis-decrypt not found"
+copy_exec /usr/bin/clevis-encrypt-tpm2 || hook_error "/usr/bin/clevis-encrypt-tpm2 not found"
+copy_exec /usr/bin/clevis-decrypt-tpm2 || hook_error "/usr/bin/clevis-decrypt-tpm2 not found"
+copy_exec /usr/bin/clevis-luks-bind || hook_error "/usr/bin/clevis-luks-bind not found"
+copy_exec /usr/bin/clevis-luks-unlock || hook_error "/usr/bin/clevis-luks-unlock not found"
+copy_exec /usr/bin/clevis-luks-list || hook_error "/usr/bin/clevis-luks-list not found"
+copy_exec /usr/bin/clevis-luks-common-functions || hook_error "/usr/bin/clevis-luks-common-functions not found"
+copy_exec /usr/bin/tpm2_createprimary || hook_error "Unable to copy /usr/bin/tpm2_createprimary" 
+copy_exec /usr/bin/tpm2_unseal || hook_error "Unable to copy /usr/bin/tpm2_unseal"
+copy_exec /usr/bin/tpm2_create || hook_error "Unable to copy /usr/bin/tpm2_create"
+copy_exec /usr/bin/tpm2_load || hook_error "Unable to copy /usr/bin/tpm2_load"
+copy_exec /usr/bin/tpm2_pcrread || hook_error "Unable to copy /usr/bin/tpm2_pcrread"
+copy_exec /usr/bin/tpm2_createpolicy || hook_error "Unable to copy /usr/bin/tpm2_createpolicy"
+copy_exec /usr/bin/tpm2_flushcontext || hook_error "Unable to copy /usr/bin/tpm2_flushcontext"
+copy_exec /usr/bin/bash || hook_error "Unable to copy /usr/bin/bash"
+copy_exec /usr/bin/luksmeta || hook_error "Unable to copy /usr/bin/luksmeta"
+copy_exec /usr/bin/jose || hook_error "Unable to copy /usr/bin/jose"
+copy_exec /usr/bin/sed || hook_error "Unable to copy /usr/bin/sed"
+copy_exec /usr/bin/tail || hook_error "Unable to copy /usr/bin/tail"
+copy_exec /usr/bin/sort || hook_error "Unable to copy /usr/bin/sort"
+copy_exec /usr/bin/rm || hook_error "Unable to copy /usr/bin/rm"
+copy_exec /usr/bin/mktemp || hook_error "Unable to copy /usr/bin/mktemp"
+copy_exec /usr/bin/basename || hook_error "Unable to copy /usr/bin/basename"
+copy_exec /usr/bin/seq || hook_error "Unable to copy /usr/bin/seq"
+copy_exec /usr/bin/pwmake || hook_error "Unable to copy /usr/bin/pwmake"
+copy_exec /usr/bin/file || hook_error "Unable to copy /usr/bin/file "
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
+copy_file pwmake-config /usr/share/encrypt_partition/pwquality.conf /etc/security/pwquality.conf
diff --git a/recipes-initramfs/initramfs-crypt-hook/files/encrypt_partition.clevis.script b/recipes-initramfs/initramfs-crypt-hook/files/encrypt_partition.clevis.script
new file mode 100644
index 0000000..37bb024
--- /dev/null
+++ b/recipes-initramfs/initramfs-crypt-hook/files/encrypt_partition.clevis.script
@@ -0,0 +1,138 @@
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
+create_file_system_cmd="$CREATE_FILE_SYSTEM_CMD"
+
+if [ -z "${create_file_system_cmd}" ];then
+	create_file_system_cmd="mke2fs -t ext4"
+fi
+
+open_tpm2_partition() {
+	if ! /usr/bin/clevis luks unlock -n "$crypt_mount_name" \
+		 -d "$1"; then
+		panic "Can't decrypt '$1' !"
+	fi
+}
+
+enroll_tpm2_token() {
+	if [ -x /usr/bin/clevis ]; then
+		 clevis luks bind -d "$1" tpm2 '{"pcr_ids":"7"}' < "$2"
+	else
+		panic "clevis not available cannot enroll tpm2 key!"
+	fi
+}
+
+reencrypt_existing_partition() {
+	part_size_blocks="$(cat /sys/class/block/"$(awk -v dev="$1" 'BEGIN{split(dev,a,"/"); print a[3]}' )"/size)"
+	# reduce the filesystem and partition by 32M to fit the LUKS header
+	reduce_device_size=32768
+	reduced_size="$(expr "$part_size_blocks" - 65536 )"
+	reduced_size_in_byte="$(expr "$reduced_size" \* 512)"
+	reduced_size_in_kb="$(expr "$reduced_size_in_byte" / 1024)K"
+	resize2fs "$1" "${reduced_size_in_kb}"
+	if [ -x cryptsetup-reencrypt ]; then
+		/usr/sbin/cryptsetup-reencrypt --new --reduce-device-size "$reduce_device_size"k "$1" < "$2"
+	else
+		/usr/sbin/cryptsetup reencrypt --encrypt --reduce-device-size "$reduce_device_size"k "$1" < "$2"
+	fi
+
+}
+
+if [ ! -e "$tpm_device" ]; then
+	panic "tpm device '$tpm_device' does not exists - cannot create a encrypted device!"
+fi
+
+# clevis needs /dev/fd create it in the initramfs
+if [ ! -e /dev/fd ]; then
+	ln -s /proc/self/fd /dev/fd
+fi
+
+for partition_set in $partition_sets; do
+	partition_label="$(awk -v var="$partition_set" 'BEGIN{split(var,a,":"); print a[1]}')"
+	partition_mountpoint="$(awk -v var="$partition_set" 'BEGIN{split(var,a,":"); print a[2]}')"
+	partition_format="$(awk -v var="$partition_set" 'BEGIN{split(var,a,":"); print a[3]}')"
+	partition=/dev/disk/by-partlabel/$partition_label
+	crypt_mount_name="encrypted_$partition_label"
+	decrypted_part=/dev/mapper/"$crypt_mount_name"
+	# clevis does not work with links in /dev/disk*
+	part_device=$(readlink -f "$partition")
+
+	if /usr/sbin/cryptsetup luksDump --batch-mode "$partition" \
+			| grep -q "clevis"; then
+		open_tpm2_partition "$part_device"
+		if ! mount -t "$(get_fstype "${decrypted_part}")" "${decrypted_part}" \
+			 "${rootmnt}${partition_mountpoint}"; then
+			panic "Can't mount encrypted partition '${decrypted_part}'!"
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
+		"reencrypt")
+			reencrypt_existing_partition "$part_device" "$tmp_key"
+			enroll_tpm2_token "$part_device" "$tmp_key"
+			open_tpm2_partition "$part_device"
+		;;
+		"format")
+			/usr/sbin/cryptsetup luksFormat --batch-mode \
+				 --type luks2 "$partition" < "$tmp_key"
+			enroll_tpm2_token "$part_device" "$tmp_key"
+			open_tpm2_partition_tpm2_partition "$part_device"
+			eval "${create_file_system_cmd} ${decrypted_part}"
+		;;
+		*)
+			panic "Unknown value ${partition_format}. Cannot create a encrypted partition !"
+		 ;;
+	esac
+
+	if ! mount -t "$(get_fstype "${decrypted_part}")" "${decrypted_part}" \
+		 "${rootmnt}${partition_mountpoint}"; then
+		panic "Can't mount encrypted partition '${decrypted_part}'!"
+	fi
+
+	# delete initial key
+	# afterwards no new keys can be enrolled
+	cryptsetup -v luksKillSlot -q  "$part_device" 0
+done
diff --git a/recipes-initramfs/initramfs-crypt-hook/files/encrypt_partition.hook b/recipes-initramfs/initramfs-crypt-hook/files/encrypt_partition.systemd.hook
old mode 100644
new mode 100755
similarity index 100%
rename from recipes-initramfs/initramfs-crypt-hook/files/encrypt_partition.hook
rename to recipes-initramfs/initramfs-crypt-hook/files/encrypt_partition.systemd.hook
diff --git a/recipes-initramfs/initramfs-crypt-hook/files/encrypt_partition.script b/recipes-initramfs/initramfs-crypt-hook/files/encrypt_partition.systemd.script
similarity index 100%
rename from recipes-initramfs/initramfs-crypt-hook/files/encrypt_partition.script
rename to recipes-initramfs/initramfs-crypt-hook/files/encrypt_partition.systemd.script
diff --git a/recipes-initramfs/initramfs-crypt-hook/files/pwquality.conf b/recipes-initramfs/initramfs-crypt-hook/files/pwquality.conf
new file mode 100644
index 0000000..d4c8981
--- /dev/null
+++ b/recipes-initramfs/initramfs-crypt-hook/files/pwquality.conf
@@ -0,0 +1,3 @@
+# we don't have a dictionary in the initramfs
+# this solves the error "Password generation failed - required entropy too low for settings"
+dictcheck = 0
diff --git a/recipes-initramfs/initramfs-crypt-hook/initramfs-crypt-hook_0.1.bb b/recipes-initramfs/initramfs-crypt-hook/initramfs-crypt-hook_0.1.bb
index c5b2268..f1ff404 100644
--- a/recipes-initramfs/initramfs-crypt-hook/initramfs-crypt-hook_0.1.bb
+++ b/recipes-initramfs/initramfs-crypt-hook/initramfs-crypt-hook_0.1.bb
@@ -9,13 +9,23 @@
 # SPDX-License-Identifier: MIT
 
 inherit dpkg-raw
-
-DEBIAN_DEPENDS = "initramfs-tools, cryptsetup, systemd(>= 251), \
+DEBIAN_DEPENDS = "initramfs-tools, cryptsetup,  \
     awk, openssl, libtss2-esys-3.0.2-0, libtss2-rc0, libtss2-mu0, e2fsprogs"
 
-SRC_URI += "file://encrypt_partition.hook \
-            file://encrypt_partition.script \
-            file://encrypt_partition.env.tmpl"
+CLEVIS_DEPEND = ", clevis-luks, jose, bash, luksmeta, file, libpwquality-tools"
+
+DEBIAN_DEPENDS:append:buster = "${CLEVIS_DEPEND}"
+DEBIAN_DEPENDS:append:bullseye = "${CLEVIS_DEPEND}"
+DEBIAN_DEPENDS:append = ", systemd (>= 251) | clevis-tpm2"
+
+CRYPT_BACKEND:buster = "clevis"
+CRYPT_BACKEND:bullseye = "clevis"
+CRYPT_BACKEND = "systemd"
+
+SRC_URI += "file://encrypt_partition.env.tmpl \
+            file://encrypt_partition.${CRYPT_BACKEND}.script \
+            file://encrypt_partition.${CRYPT_BACKEND}.hook \
+            file://pwquality.conf"
 
 # CRYPT_PARTITIONS elements are <partition-label>:<mountpoint>:<reencrypt or format>
 CRYPT_PARTITIONS ??= "home:/home:reencrypt var:/var:reencrypt"
@@ -29,11 +39,13 @@ TEMPLATE_FILES = "encrypt_partition.env.tmpl"
 do_install[cleandirs] += " \
     ${D}/usr/share/initramfs-tools/hooks \
     ${D}/usr/share/encrypt_partition \
-    ${D}/usr/share/initramfs-tools/scripts/local-bottom"
+    ${D}/usr/share/initramfs-tools/scripts/local-bottom \
+    ${D}/usr/lib/encrypt_partition"
 do_install() {
     install -m 0600 "${WORKDIR}/encrypt_partition.env" "${D}/usr/share/encrypt_partition/encrypt_partition.env"
-    install -m 0755 "${WORKDIR}/encrypt_partition.script" \
+    install -m 0755 "${WORKDIR}/encrypt_partition.${CRYPT_BACKEND}.script" \
         "${D}/usr/share/initramfs-tools/scripts/local-bottom/encrypt_partition"
-    install -m 0755 "${WORKDIR}/encrypt_partition.hook" \
+    install -m 0755 "${WORKDIR}/encrypt_partition.${CRYPT_BACKEND}.hook" \
         "${D}/usr/share/initramfs-tools/hooks/encrypt_partition"
+    install -m 0644 "${WORKDIR}/pwquality.conf" "${D}/usr/share/encrypt_partition/pwquality.conf"
 }
-- 
2.39.2


