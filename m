Return-Path: <quirin.gylstorff@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 858EEC4332F
	for <webhook@archiver.kernel.org>; Tue, 16 Nov 2021 11:27:57 +0000 (UTC)
Received: from thoth.sbs.de (thoth.sbs.de [192.35.17.2])
 by mx.groups.io with SMTP id smtpd.web08.8583.1637062076132835341
 for <cip-dev@lists.cip-project.org>;
 Tue, 16 Nov 2021 03:27:56 -0800
Authentication-Results: mx.groups.io;
 dkim=missing;
 spf=pass (domain: siemens.com, ip: 192.35.17.2, mailfrom: quirin.gylstorff@siemens.com)
Received: from mail2.sbs.de (mail2.sbs.de [192.129.41.66])
	by thoth.sbs.de (8.15.2/8.15.2) with ESMTPS id 1AGBRsHa006249
	(version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <cip-dev@lists.cip-project.org>; Tue, 16 Nov 2021 12:27:54 +0100
Received: from md2dvrtc.fritz.box ([167.87.1.223])
	by mail2.sbs.de (8.15.2/8.15.2) with ESMTP id 1AGBRqNT006209;
	Tue, 16 Nov 2021 12:27:54 +0100
From: "Q. Gylstorff" <Quirin.Gylstorff@siemens.com>
To: raphael.lisicki@siemens.com, jan.kiszka@siemens.com,
        cip-dev@lists.cip-project.org
Subject: [cip-dev][isar-cip-core]RFC v2 4/9] Create a initrd with support for
 dm-verity
Date: Tue, 16 Nov 2021 12:27:47 +0100
Message-Id: <20211116112752.1521211-5-Quirin.Gylstorff@siemens.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211116112752.1521211-1-Quirin.Gylstorff@siemens.com>
References: <20211116112752.1521211-1-Quirin.Gylstorff@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 16 Nov 2021 11:27:57 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/6927

From: Quirin Gylstorff <quirin.gylstorff@siemens.com>

Adapt the initrd to open a dm-verity partition with a fixed
root hash.

Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
---
 .../cip-core-initramfs/cip-core-initramfs.bb  | 16 +++++
 .../files/verity.conf-hook                    |  1 +
 .../initramfs-verity-hook/files/verity.hook   | 23 +++++++
 .../files/verity.script.tmpl                  | 68 +++++++++++++++++++
 .../initramfs-verity-hook_0.1.bb              | 51 ++++++++++++++
 5 files changed, 159 insertions(+)
 create mode 100644 recipes-initramfs/cip-core-initramfs/cip-core-initramfs.bb
 create mode 100644 recipes-initramfs/initramfs-verity-hook/files/verity.conf-hook
 create mode 100644 recipes-initramfs/initramfs-verity-hook/files/verity.hook
 create mode 100644 recipes-initramfs/initramfs-verity-hook/files/verity.script.tmpl
 create mode 100644 recipes-initramfs/initramfs-verity-hook/initramfs-verity-hook_0.1.bb

diff --git a/recipes-initramfs/cip-core-initramfs/cip-core-initramfs.bb b/recipes-initramfs/cip-core-initramfs/cip-core-initramfs.bb
new file mode 100644
index 0000000..825fb9f
--- /dev/null
+++ b/recipes-initramfs/cip-core-initramfs/cip-core-initramfs.bb
@@ -0,0 +1,16 @@
+#
+# CIP Core, generic profile
+#
+# Copyright (c) Siemens AG, 2021
+#
+# Authors:
+#  Quirin Gylstorff <quirin.gylstorff@siemens.com>
+#
+# SPDX-License-Identifier: MIT
+#
+
+inherit initramfs
+
+INITRAMFS_INSTALL += " \
+    initramfs-verity-hook \
+    "
diff --git a/recipes-initramfs/initramfs-verity-hook/files/verity.conf-hook b/recipes-initramfs/initramfs-verity-hook/files/verity.conf-hook
new file mode 100644
index 0000000..9b61fb8
--- /dev/null
+++ b/recipes-initramfs/initramfs-verity-hook/files/verity.conf-hook
@@ -0,0 +1 @@
+BUSYBOX=y
diff --git a/recipes-initramfs/initramfs-verity-hook/files/verity.hook b/recipes-initramfs/initramfs-verity-hook/files/verity.hook
new file mode 100644
index 0000000..5eada8a
--- /dev/null
+++ b/recipes-initramfs/initramfs-verity-hook/files/verity.hook
@@ -0,0 +1,23 @@
+#!/bin/sh
+PREREQ=""
+prereqs()
+{
+    echo "$PREREQ"
+}
+case $1 in
+prereqs)
+    prereqs
+    exit 0
+    ;;
+esac
+
+. /usr/share/initramfs-tools/hook-functions
+# Begin real processing below this line
+
+manual_add_modules dm_mod
+manual_add_modules dm_verity
+
+copy_exec /sbin/veritysetup
+copy_exec /sbin/dmsetup
+copy_file library /lib/cryptsetup/functions /lib/cryptsetup/functions
+copy_file library /usr/share/verity-env/verity.env /usr/share/verity-env/verity.env
diff --git a/recipes-initramfs/initramfs-verity-hook/files/verity.script.tmpl b/recipes-initramfs/initramfs-verity-hook/files/verity.script.tmpl
new file mode 100644
index 0000000..c4f3dc4
--- /dev/null
+++ b/recipes-initramfs/initramfs-verity-hook/files/verity.script.tmpl
@@ -0,0 +1,68 @@
+#!/bin/sh
+prereqs()
+{
+    # Make sure that this script is run last in local-top
+    local req
+    for req in "${0%/*}"/*; do
+        script="${req##*/}"
+        if [ "$script" != "${0##*/}" ] && [ "$script" != "cryptroot" ]; then
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
+. /lib/cryptsetup/functions
+. /usr/share/verity-env/verity.env
+# Even if this script fails horribly, make sure there won't be a chance the
+# current $ROOT will be attempted.  As this device most likely contains a
+# perfectly valid filesystem, it would be mounted successfully, leading to a
+# broken trust chain.
+echo "ROOT=/dev/null" >/conf/param.conf
+wait_for_udev 10
+case "$ROOT" in
+    PART*)
+        # root was given as PARTUUID= or PARTLABEL=. Use blkid to find the matching
+        # partition
+        ROOT=$(blkid --list-one --output device --match-token "$ROOT")
+        ;;
+    "")
+        # No Root device was given. Use veritysetup verify to search matching roots
+        partitions=$(blkid -o device)
+        for part in $partitions; do
+            if [ "$(blkid -p ${part} --match-types novfat -s USAGE -o value)" = "filesystem" ]; then
+                if veritysetup verify \
+                   "$part" "$part" "${ROOT_HASH}" \
+                   --hash-offset "${HASH_OFFSET}";then
+                    ROOT="$part"
+                    break
+                fi
+            fi
+        done
+        ;;
+esac
+set -- "$ROOT" verityroot
+if ! veritysetup open \
+     ${VERITY_BEHAVIOR_ON_CORRUPTION} \
+     --data-block-size "${DATA_BLOCK_SIZE}" \
+     --hash-block-size "${HASH_BLOCK_SIZE}" \
+     --data-blocks "${DATA_BLOCKS}" \
+     --hash-offset "${HASH_OFFSET}" \
+     --salt "${SALT}" \
+     "$1" "$2" "$1" "${ROOT_HASH}"; then
+    panic "Can't open verity rootfs!"
+fi
+
+wait_for_udev 10
+
+if ! ROOT="$(dm_blkdevname verityroot)"; then
+    panic "Can't find the verity root device!"
+fi
+
+echo "ROOT=${ROOT}" >/conf/param.conf
diff --git a/recipes-initramfs/initramfs-verity-hook/initramfs-verity-hook_0.1.bb b/recipes-initramfs/initramfs-verity-hook/initramfs-verity-hook_0.1.bb
new file mode 100644
index 0000000..a7fbf5a
--- /dev/null
+++ b/recipes-initramfs/initramfs-verity-hook/initramfs-verity-hook_0.1.bb
@@ -0,0 +1,51 @@
+#
+# CIP Core, generic profile
+#
+# Copyright (c) Siemens AG, 2021
+#
+# Authors:
+#  Quirin Gylstorff <quirin.gylstorff@siemens.com>
+#
+# SPDX-License-Identifier: MIT
+#
+
+inherit dpkg-raw
+
+SRC_URI += " \
+    file://verity.conf-hook \
+    file://verity.hook \
+    file://verity.script.tmpl \
+    "
+
+VERITY_BEHAVIOR_ON_CORRUPTION ?= "--restart-on-corruption"
+
+TEMPLATE_FILES = "verity.script.tmpl"
+TEMPLATE_VARS += "VERITY_BEHAVIOR_ON_CORRUPTION"
+
+DEBIAN_DEPENDS = "initramfs-tools, cryptsetup"
+
+VERITY_IMAGE_RECIPE ?= "cip-core-image-read-only"
+
+VERITY_ENV_FILE = "${DEPLOY_DIR_IMAGE}/${VERITY_IMAGE_RECIPE}-${DISTRO}-${MACHINE}.verity.env"
+
+do_install[depends] += "${VERITY_IMAGE_RECIPE}:do_verity_image"
+do_install[cleandirs] += " \
+    ${D}/usr/share/initramfs-tools/hooks \
+    ${D}/usr/share/verity-env \
+    ${D}/usr/share/initramfs-tools/scripts/local-top \
+    ${D}/usr/share/initramfs-tools/conf-hooks.d"
+
+do_install() {
+    # Insert the veritysetup commandline into the script
+    if [ -f "${VERITY_ENV_FILE}" ]; then
+        install -m 0600 "${VERITY_ENV_FILE}" "${D}/usr/share/verity-env/verity.env"
+    else
+        bberror "Did not find ${VERITY_ENV_FILE}. initramfs will not be build correctly!"
+    fi
+    install -m 0755 "${WORKDIR}/verity.script" \
+        "${D}/usr/share/initramfs-tools/scripts/local-top/verity"
+    install -m 0755 "${WORKDIR}/verity.hook" \
+        "${D}/usr/share/initramfs-tools/hooks/verity"
+}
+
+addtask do_install after do_transform_template
-- 
2.30.2


