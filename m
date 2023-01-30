Return-Path: <quirin.gylstorff@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8B91C636D3
	for <webhook@archiver.kernel.org>; Mon, 30 Jan 2023 15:02:18 +0000 (UTC)
Received: from mta-64-227.siemens.flowmailer.net (mta-64-227.siemens.flowmailer.net [185.136.64.227])
 by mx.groups.io with SMTP id smtpd.web11.43315.1675090929824297304
 for <cip-dev@lists.cip-project.org>;
 Mon, 30 Jan 2023 07:02:10 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=Quirin.Gylstorff@siemens.com header.s=fm1 header.b=fMx/GR7V;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.64.227, mailfrom: fm-51332-202301301502078900137594c40547d6-zv4xuj@rts-flowmailer.siemens.com)
Received: by mta-64-227.siemens.flowmailer.net with ESMTPSA id 202301301502078900137594c40547d6
        for <cip-dev@lists.cip-project.org>;
        Mon, 30 Jan 2023 16:02:08 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=Quirin.Gylstorff@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:References:In-Reply-To;
 bh=8Ft5WaySTWMLhAwveneM0xJmbQQkMzoLnTsO9N+8KS8=;
 b=fMx/GR7Vo7DDVQ2o2spzebSfbW/xAdfPXytFBWk6i7qRbAizbmfVPDdea05fL9dNt7OLE2
 RECCvRohlr7/QAtZG3G7qZWicKY3b9rj+dF51vFjF79/qhVV1PNWpseZzxMHyj/jDzxcbfFz
 Fu02cLqKBHm5VNMrnyvRv2RAolbW4=;
From: Quirin Gylstorff <Quirin.Gylstorff@siemens.com>
To: cip-dev@lists.cip-project.org,
	jan.kiszka@siemens.com,
	christian.storm@siemens.com
Subject: [cip-dev][isar-cip-core][RFC 5/5] Add initramfs hook to encrypt a partition
Date: Mon, 30 Jan 2023 16:02:04 +0100
Message-Id: <20230130150204.697758-6-Quirin.Gylstorff@siemens.com>
In-Reply-To: <20230130150204.697758-1-Quirin.Gylstorff@siemens.com>
References: <20230130150204.697758-1-Quirin.Gylstorff@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-51332:519-21489:flowmailer
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 30 Jan 2023 15:02:18 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/10512

From: Quirin Gylstorff <quirin.gylstorff@siemens.com>

This creates a new luks encrypted ext4 partition with a the
key stored in the tpm2.

The initial key is randomly generated and removed from the
LUKS partition. Therefore a new key cannot be added by the user
and if the LUKS header is corrupted the data is no longer readable.

Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
---
 kas/opt/tpm.yml                               |  2 +
 .../files/create_crypt_partition.script       | 96 +++++++++++++++++++
 .../files/crypt-partition.env.tmpl            |  1 +
 .../initramfs-crypt-hook/files/crypt.hook     | 42 ++++++++
 .../initramfs-crypt-hook_0.1.bb               | 37 +++++++
 5 files changed, 178 insertions(+)
 create mode 100644 recipes-initramfs/initramfs-crypt-hook/files/create_crypt_partition.script
 create mode 100644 recipes-initramfs/initramfs-crypt-hook/files/crypt-partition.env.tmpl
 create mode 100644 recipes-initramfs/initramfs-crypt-hook/files/crypt.hook
 create mode 100644 recipes-initramfs/initramfs-crypt-hook/initramfs-crypt-hook_0.1.bb

diff --git a/kas/opt/tpm.yml b/kas/opt/tpm.yml
index 03e8e47..a77a2be 100644
--- a/kas/opt/tpm.yml
+++ b/kas/opt/tpm.yml
@@ -16,3 +16,5 @@ local_conf_header:
   systemd-cryptenroll: |
     DISTRO_APT_SOURCES_append_bullseye = " conf/distro/debian-bullseye-backports.list"
     DISTRO_APT_PREFERENCES_append_bullseye = " conf/distro/preferences.bullseye-backports.tpm.conf"
+  image-option-tpm: |
+    INITRAMFS_INSTALL += " initramfs-crypt-hook"
diff --git a/recipes-initramfs/initramfs-crypt-hook/files/create_crypt_partition.script b/recipes-initramfs/initramfs-crypt-hook/files/create_crypt_partition.script
new file mode 100644
index 0000000..a30dc59
--- /dev/null
+++ b/recipes-initramfs/initramfs-crypt-hook/files/create_crypt_partition.script
@@ -0,0 +1,96 @@
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
+    # Make sure that this script is run last in local-top
+    local req
+    for req in "${0%/*}"/*; do
+        script="${req##*/}"
+        if [ "$script" != "${0##*/}" ]; then
+            printf '%s\n' "$script"
+        fi
+    done
+}
+case $1 in
+prereqs)
+    prereqs
+    exit 0
+    ;;
+esac
+
+. /scripts/functions
+
+. /usr/share/crypt/crypt-partition.env
+
+# fixed tpm device or do we need to find it
+tpm_device=/dev/tpmrm0
+partition="$PARTITION"
+partition_label=$(echo "$partition" | awk -F "/" '{print $NF}')
+crypt_mount_name="encrypted_$partition_label"
+decrypted_part=/dev/mapper/"$crypt_mount_name"
+
+if [ ! -e "$partition" ]; then
+    panic "$partition does not exist!"
+fi
+
+modprobe tpm_tis
+modprobe tpm_crb
+
+if [ ! -e "$tpm_device" ]; then
+    panic "tpm device '$tpm_device' does not exists - cannot create a encrypted device!"
+fi
+
+# check if partition is already encrypted with systemd-tpm2
+if /usr/sbin/cryptsetup luksDump --batch-mode "$partition" \
+        | grep -q "systemd-tpm2"; then
+    if ! /usr/lib/systemd/systemd-cryptsetup attach "$crypt_mount_name" \
+         "$partition" - tpm2-device="$tpm_device"; then
+        panic "Can't decrypt '$partition' !"
+    fi
+    return
+fi
+
+# create random password for initial encryption
+# this will be dropped after reboot
+
+tmp_key=/tmp/"$partition_label-lukskey"
+openssl rand -base64 32 > "$tmp_key"
+
+/usr/sbin/cryptsetup luksFormat --batch-mode \
+                     --type luks2 "$partition" < "$tmp_key"
+
+#check systemd version and export password if necessary
+if [ -x /usr/bin/systemd-cryptenroll ]; then
+    systemd_version=$(systemd-cryptenroll --version | \
+                          awk -F " " 'NR==1{print $2 }')
+    #check systemd version and export password if necessary
+    if [ "$systemd_version" -ge "251" ]; then
+        PASSWORD=$(cat "$tmp_key" )
+        export PASSWORD
+        /usr/bin/systemd-cryptenroll --tpm2-device="$tpm_device" \
+                                     --tpm2-pcrs=7 "$partition"
+        PASSWORD=
+    else
+       panic "Unknown systemd version: '$systemd_version'!"
+   fi
+fi
+
+wait_for_udev 10
+
+if ! /usr/lib/systemd/systemd-cryptsetup attach "$crypt_mount_name" \
+     "$partition" - tpm2-device="$tpm_device"; then
+    panic "Can't decrypt '$partition' !"
+fi
+
+mke2fs -t ext4 "${decrypted_part}"
+
+# delete initial key
+/usr/bin/systemd-cryptenroll "$partition" --wipe-slot=0
diff --git a/recipes-initramfs/initramfs-crypt-hook/files/crypt-partition.env.tmpl b/recipes-initramfs/initramfs-crypt-hook/files/crypt-partition.env.tmpl
new file mode 100644
index 0000000..04c4123
--- /dev/null
+++ b/recipes-initramfs/initramfs-crypt-hook/files/crypt-partition.env.tmpl
@@ -0,0 +1 @@
+PARTITION=${CRYPT_PARTITION}
diff --git a/recipes-initramfs/initramfs-crypt-hook/files/crypt.hook b/recipes-initramfs/initramfs-crypt-hook/files/crypt.hook
new file mode 100644
index 0000000..38fff49
--- /dev/null
+++ b/recipes-initramfs/initramfs-crypt-hook/files/crypt.hook
@@ -0,0 +1,42 @@
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
+copy_exec /usr/sbin/cryptsetup
+copy_exec /usr/bin/systemd-cryptenroll
+copy_exec /usr/lib/systemd/systemd-cryptsetup
+
+for _LIBRARY in /usr/lib/*/libtss2*; do
+    copy_exec "$_LIBRARY"
+done
+
+copy_file library /usr/share/crypt/crypt-partition.env /usr/share/crypt/crypt-partition.env
diff --git a/recipes-initramfs/initramfs-crypt-hook/initramfs-crypt-hook_0.1.bb b/recipes-initramfs/initramfs-crypt-hook/initramfs-crypt-hook_0.1.bb
new file mode 100644
index 0000000..024ff68
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
+    awk, openssl,  libtss2-esys-3.0.2-0,  libtss2-rc0, libtss2-mu0, e2fsprogs"
+
+SRC_URI += "file://crypt.hook \
+            file://create_crypt_partition.script \
+    file://crypt-partition.env.tmpl"
+
+CRYPT_PARTITION ??= "/dev/disk/by-partlabel/crypt-data"
+CRYPT_MOUNT_POINT ??= "/data"
+
+TEMPLATE_VARS = "CRYPT_PARTITION CRYPT_MOUNT_POINT"
+TEMPLATE_FILES = "crypt-partition.env.tmpl"
+
+do_install[cleandirs] += " \
+    ${D}/usr/share/initramfs-tools/hooks \
+    ${D}/usr/share/crypt \
+    ${D}/usr/share/initramfs-tools/scripts/local-top"
+do_install() {
+    install -m 0600 "${WORKDIR}/crypt-partition.env" "${D}/usr/share/crypt/crypt-partition.env"
+    install -m 0755 "${WORKDIR}/create_crypt_partition.script" \
+        "${D}/usr/share/initramfs-tools/scripts/local-top/crypt"
+    install -m 0755 "${WORKDIR}/crypt.hook" \
+        "${D}/usr/share/initramfs-tools/hooks/crypt"
+}
-- 
2.39.0


