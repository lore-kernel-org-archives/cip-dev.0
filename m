Return-Path: <SRS0=JKFT=BD=lists.cip-project.org=bounce+64572+5006+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5EF94C433E3
	for <cip-dev@archiver.kernel.org>; Fri, 24 Jul 2020 15:01:52 +0000 (UTC)
Received: from web01.groups.io (web01.groups.io [66.175.222.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 28EFF20714
	for <cip-dev@archiver.kernel.org>; Fri, 24 Jul 2020 15:01:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.cip-project.org header.i=@lists.cip-project.org header.b="l/KgCoKK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 28EFF20714
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=siemens.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+5006+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id XGJAYY4521723xbVMI5dc20x; Fri, 24 Jul 2020 08:01:51 -0700
X-Received: from goliath.siemens.de (goliath.siemens.de [192.35.17.28])
 by mx.groups.io with SMTP id smtpd.web12.8005.1595602910462967785
 for <cip-dev@lists.cip-project.org>;
 Fri, 24 Jul 2020 08:01:51 -0700
X-Received: from mail1.sbs.de (mail1.sbs.de [192.129.41.35])
	by goliath.siemens.de (8.15.2/8.15.2) with ESMTPS id 06OF1mQm020644
	(version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <cip-dev@lists.cip-project.org>; Fri, 24 Jul 2020 17:01:48 +0200
X-Received: from md2dvrtc.fritz.box ([167.87.3.170])
	by mail1.sbs.de (8.15.2/8.15.2) with ESMTP id 06OF1lbo027266;
	Fri, 24 Jul 2020 17:01:48 +0200
From: "Quirin Gylstorff" <quirin.gylstorff@siemens.com>
To: cip-dev@lists.cip-project.org, Jan.Kiszka@siemens.com
Cc: Quirin Gylstorff <quirin.gylstorff@siemens.com>
Subject: [cip-dev] [isar-cip-core PATCH v3 3/6] secure-boot: select boot partition in initramfs
Date: Fri, 24 Jul 2020 17:01:44 +0200
Message-Id: <20200724150147.8253-4-Quirin.Gylstorff@siemens.com>
In-Reply-To: <20200724150147.8253-1-Quirin.Gylstorff@siemens.com>
References: <20200629125400.13968-1-Quirin.Gylstorff@siemens.com>
 <20200724150147.8253-1-Quirin.Gylstorff@siemens.com>
MIME-Version: 1.0
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: bmblbCKs5OMQmQZVhlusl3IOx4520388AA=
Content-Type: multipart/mixed; boundary="JLJA4E0zb09F2X34glUL"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1595602911;
 bh=df+89ZRBEHZYIPFwy4tK8cTvL7u+AQfFhy2OilCAdIA=;
 h=Cc:Content-Type:Date:From:Reply-To:Subject:To;
 b=l/KgCoKKo2nA3/G8sYFe8J3jiiRsjyAaSMpwnEFGQhS6oq5s7/JQQBc/GC7lwAeRQ9u
 FJaBeJ79r3aZiAJELCmY8l5tWQ9eUkEYt6tEr7ibap7MLC4tKsYouEgNzf93c9okMxOoY
 LF193sECbGlpzi86xLe2+YaDSaBSLvoljzw=

--JLJA4E0zb09F2X34glUL
Content-Transfer-Encoding: 8bit

From: Quirin Gylstorff <quirin.gylstorff@siemens.com>

As the usage of a unified kernel image freeze the kernel commmandline
during build time the rootfs selection for swupdate can no longer be
done with the kernel commandline and must be done later in the boot
process. Read the root filesystem /etc/os-release and check if it contains
the same uuid as stored in the initramfs . If the uuids are the same
boot the root file system.

Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
---
 classes/image_uuid.bbclass                    | 33 ++++++++
 .../files/initramfs.image_uuid.hook           | 33 ++++++++
 .../files/initramfs.lsblk.hook                | 29 +++++++
 .../initramfs-config/files/postinst.ext       |  3 +
 .../initramfs-config/files/postinst.tmpl      | 31 ++++++++
 .../files/secure-boot-debian-local-patch      | 79 +++++++++++++++++++
 .../initramfs-abrootfs-secureboot_0.1.bb      | 38 +++++++++
 7 files changed, 246 insertions(+)
 create mode 100644 classes/image_uuid.bbclass
 create mode 100644 recipes-support/initramfs-config/files/initramfs.image_uuid.hook
 create mode 100644 recipes-support/initramfs-config/files/initramfs.lsblk.hook
 create mode 100644 recipes-support/initramfs-config/files/postinst.ext
 create mode 100644 recipes-support/initramfs-config/files/postinst.tmpl
 create mode 100644 recipes-support/initramfs-config/files/secure-boot-debian-local-patch
 create mode 100644 recipes-support/initramfs-config/initramfs-abrootfs-secureboot_0.1.bb

diff --git a/classes/image_uuid.bbclass b/classes/image_uuid.bbclass
new file mode 100644
index 0000000..9098411
--- /dev/null
+++ b/classes/image_uuid.bbclass
@@ -0,0 +1,33 @@
+#
+# CIP Core, generic profile
+#
+# Copyright (c) Siemens AG, 2020
+#
+# Authors:
+#  Quirin Gylstorff <quirin.gylstorff@siemens.com>
+#
+# SPDX-License-Identifier: MIT
+#
+
+def generate_image_uuid(d):
+    import uuid
+
+    base_hash = d.getVar("BB_BASEHASH_task-do_rootfs_install", True)
+    if base_hash is None:
+        return None
+    return str(uuid.UUID(base_hash[:32], version=4))
+
+IMAGE_UUID ?= "${@generate_image_uuid()}"
+
+do_generate_image_uuid[vardeps] += "IMAGE_UUID"
+do_generate_image_uuid[depends] = "buildchroot-target:do_build"
+do_generate_image_uuid() {
+    sudo sed -i '/^IMAGE_UUID=.*/d' '${IMAGE_ROOTFS}/etc/os-release'
+    echo "IMAGE_UUID=\"${IMAGE_UUID}\"" | \
+        sudo tee -a '${IMAGE_ROOTFS}/etc/os-release'
+    image_do_mounts
+
+    # update initramfs to add uuid
+    sudo chroot '${IMAGE_ROOTFS}' update-initramfs -u
+}
+addtask generate_image_uuid before do_copy_boot_files after do_rootfs_install
diff --git a/recipes-support/initramfs-config/files/initramfs.image_uuid.hook b/recipes-support/initramfs-config/files/initramfs.image_uuid.hook
new file mode 100644
index 0000000..910ce84
--- /dev/null
+++ b/recipes-support/initramfs-config/files/initramfs.image_uuid.hook
@@ -0,0 +1,33 @@
+# This software is a part of ISAR.
+# Copyright (C) Siemens AG, 2020
+#
+# SPDX-License-Identifier: MIT
+
+#!/bin/sh
+set -x
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
+if [ ! -e /etc/os-release ]; then
+	echo "Warning: couldn't find /etc/os-release!"
+	exit 0
+fi
+
+IMAGE_UUID=$(sed -n 's/^IMAGE_UUID="\(.*\)"/\1/p' /etc/os-release)
+echo "${IMAGE_UUID}" > "${DESTDIR}/conf/image_uuid"
+
+exit 0
\ No newline at end of file
diff --git a/recipes-support/initramfs-config/files/initramfs.lsblk.hook b/recipes-support/initramfs-config/files/initramfs.lsblk.hook
new file mode 100644
index 0000000..cf32404
--- /dev/null
+++ b/recipes-support/initramfs-config/files/initramfs.lsblk.hook
@@ -0,0 +1,29 @@
+# This software is a part of ISAR.
+# Copyright (C) Siemens AG, 2020
+#
+# SPDX-License-Identifier: MIT
+
+#!/bin/sh
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
+if [ ! -x /usr/bin/lsblk ]; then
+	echo "Warning: couldn't find /usr/bin/lsblk!"
+	exit 0
+fi
+
+copy_exec /usr/bin/lsblk
diff --git a/recipes-support/initramfs-config/files/postinst.ext b/recipes-support/initramfs-config/files/postinst.ext
new file mode 100644
index 0000000..cdafa74
--- /dev/null
+++ b/recipes-support/initramfs-config/files/postinst.ext
@@ -0,0 +1,3 @@
+if [ -d /usr/share/secureboot ]; then
+    patch -s -p0 /usr/share/initramfs-tools/scripts/local /usr/share/secureboot/secure-boot-debian-local.patch
+fi
diff --git a/recipes-support/initramfs-config/files/postinst.tmpl b/recipes-support/initramfs-config/files/postinst.tmpl
new file mode 100644
index 0000000..008f68d
--- /dev/null
+++ b/recipes-support/initramfs-config/files/postinst.tmpl
@@ -0,0 +1,31 @@
+#!/bin/sh
+if [ -d /usr/share/secureboot ]; then
+    patch -s -p0 /usr/share/initramfs-tools/scripts/local /usr/share/secureboot/secure-boot-debian-local.patch
+fi
+
+INITRAMFS_CONF=/etc/initramfs-tools/initramfs.conf
+if [ -f ${INITRAMFS_CONF} ]; then
+    sed -i -E 's/(^MODULES=).*/\1${INITRAMFS_MODULES}/' ${INITRAMFS_CONF}
+    sed -i -E 's/(^BUSYBOX=).*/\1${INITRAMFS_BUSYBOX}/' ${INITRAMFS_CONF}
+    sed -i -E 's/(^COMPRESS=).*/\1${INITRAMFS_COMPRESS}/' ${INITRAMFS_CONF}
+    sed -i -E 's/(^KEYMAP=).*/\1${INITRAMFS_KEYMAP}/' ${INITRAMFS_CONF}
+    sed -i -E 's/(^DEVICE=).*/\1${INITRAMFS_NET_DEVICE}/' ${INITRAMFS_CONF}
+    sed -i -E 's/(^NFSROOT=).*/\1${INITRAMFS_NFSROOT}/' ${INITRAMFS_CONF}
+    sed -i -E 's/(^RUNSIZE=).*/\1${INITRAMFS_RUNSIZE}/' ${INITRAMFS_CONF}
+    if grep -Fxq "ROOT=" "${INITRAMFS_CONF}"; then
+        sed -i -E 's/(^ROOT=).*/\1${INITRAMFS_ROOT}/' ${INITRAMFS_CONF}
+    else
+        sed -i -E "\$aROOT=${INITRAMFS_ROOT}" ${INITRAMFS_CONF}
+    fi
+fi
+
+MODULES_LIST_FILE=/etc/initramfs-tools/modules
+if [ -f ${MODULES_LIST_FILE} ]; then
+    for modname in ${INITRAMFS_MODULE_LIST}; do
+        if ! grep -Fxq "$modname" "${MODULES_LIST_FILE}"; then
+            echo "$modname" >> "${MODULES_LIST_FILE}"
+        fi
+    done
+fi
+
+update-initramfs -v -u
diff --git a/recipes-support/initramfs-config/files/secure-boot-debian-local-patch b/recipes-support/initramfs-config/files/secure-boot-debian-local-patch
new file mode 100644
index 0000000..219578c
--- /dev/null
+++ b/recipes-support/initramfs-config/files/secure-boot-debian-local-patch
@@ -0,0 +1,79 @@
+--- local	2020-07-02 14:59:15.461895194 +0200
++++ ../../../../../../../../../../../recipes-support/initramfs-config/files/local	2020-07-02 14:58:58.405730914 +0200
+@@ -1,5 +1,4 @@
+ # Local filesystem mounting			-*- shell-script -*-
+-
+ local_top()
+ {
+ 	if [ "${local_top_used}" != "yes" ]; then
+@@ -155,34 +154,47 @@
+ local_mount_root()
+ {
+ 	local_top
+-	if [ -z "${ROOT}" ]; then
+-		panic "No root device specified. Boot arguments must include a root= parameter."
+-	fi
+-	local_device_setup "${ROOT}" "root file system"
+-	ROOT="${DEV}"
+-
+-	# Get the root filesystem type if not set
+-	if [ -z "${ROOTFSTYPE}" ] || [ "${ROOTFSTYPE}" = auto ]; then
+-		FSTYPE=$(get_fstype "${ROOT}")
+-	else
+-		FSTYPE=${ROOTFSTYPE}
++	if [ ! -e /conf/image_uuid ]; then
++		 panic "could not find image_uuid to select correct root file system"
+ 	fi
++	local INITRAMFS_IMAGE_UUID=$(cat /conf/image_uuid)
++	local partitions=$(blkid -o device)
++	for part in $partitions; do
++			if [ "$(blkid -p ${part} --match-types novfat -s USAGE -o value)" = "filesystem" ]; then
++					local_device_setup "${part}" "root file system"
++					ROOT="${DEV}"
++
++					# Get the root filesystem type if not set
++					if [ -z "${ROOTFSTYPE}" ] || [ "${ROOTFSTYPE}" = auto ]; then
++							FSTYPE=$(get_fstype "${ROOT}")
++					else
++							FSTYPE=${ROOTFSTYPE}
++					fi
+ 
+-	local_premount
++				local_premount
+ 
+-	if [ "${readonly?}" = "y" ]; then
+-		roflag=-r
+-	else
+-		roflag=-w
+-	fi
++				if [ "${readonly?}" = "y" ]; then
++						roflag=-r
++				else
++						roflag=-w
++				fi
++				checkfs "${ROOT}" root "${FSTYPE}"
+ 
+-	checkfs "${ROOT}" root "${FSTYPE}"
++				# Mount root
++				# shellcheck disable=SC2086
++				if mount ${roflag} ${FSTYPE:+-t "${FSTYPE}"} ${ROOTFLAGS} "${ROOT}" "${rootmnt?}"; then
++						if [ -e "${rootmnt?}"/etc/os-release ]; then
++								image_uuid=$(sed -n 's/^IMAGE_UUID=//p' "${rootmnt?}"/etc/os-release | tr -d '"' )
++								if [ "${INITRAMFS_IMAGE_UUID}" = "${image_uuid}" ]; then
++										return
++								fi
++						fi
++						umount "${rootmnt?}"
++				fi
++			fi
++	done
++	panic "Could not find ROOTFS with matching UUID $INITRAMFS_IMAGE_UUID"
+ 
+-	# Mount root
+-	# shellcheck disable=SC2086
+-	if ! mount ${roflag} ${FSTYPE:+-t "${FSTYPE}"} ${ROOTFLAGS} "${ROOT}" "${rootmnt?}"; then
+-		panic "Failed to mount ${ROOT} as root file system."
+-	fi
+ }
+ 
+ local_mount_fs()
diff --git a/recipes-support/initramfs-config/initramfs-abrootfs-secureboot_0.1.bb b/recipes-support/initramfs-config/initramfs-abrootfs-secureboot_0.1.bb
new file mode 100644
index 0000000..0be9871
--- /dev/null
+++ b/recipes-support/initramfs-config/initramfs-abrootfs-secureboot_0.1.bb
@@ -0,0 +1,38 @@
+#
+# CIP Core, generic profile
+#
+# Copyright (c) Siemens AG, 2020
+#
+# Authors:
+#  Quirin Gylstorff <quirin.gylstorff@siemens.com>
+#
+# SPDX-License-Identifier: MIT
+
+require recipes-support/initramfs-config/initramfs-config.inc
+
+FILESPATH =. "${LAYERDIR_isar-siemens}/recipes-support/initramfs-config/files:"
+
+DEBIAN_DEPENDS += ", busybox, patch"
+
+SRC_URI += "file://postinst.ext \
+            file://initramfs.lsblk.hook \
+            file://initramfs.image_uuid.hook \
+            file://secure-boot-debian-local-patch"
+
+INITRAMFS_BUSYBOX = "y"
+
+do_install() {
+    # add patch for local to /usr/share/secure boot
+    TARGET=${D}/usr/share/secureboot
+    install -m 0755 -d ${TARGET}
+    install -m 0644 ${WORKDIR}/secure-boot-debian-local-patch ${TARGET}/secure-boot-debian-local.patch
+    # patch postinst
+    sed -i -e '/configure)/r ${WORKDIR}/postinst.ext' ${WORKDIR}/postinst
+
+    # add hooks for secure boot
+    HOOKS=${D}/etc/initramfs-tools/hooks
+install -m 0755 -d ${HOOKS}
+    install -m 0740 ${WORKDIR}/initramfs.lsblk.hook ${HOOKS}/lsblk.hook
+    install -m 0740 ${WORKDIR}/initramfs.image_uuid.hook ${HOOKS}/image_uuid.hook
+}
+addtask do_install after do_transform_template
-- 
2.20.1


--JLJA4E0zb09F2X34glUL
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.

View/Reply Online (#5006): https://lists.cip-project.org/g/cip-dev/message=
/5006
Mute This Topic: https://lists.cip-project.org/mt/75767904/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy  [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-

--JLJA4E0zb09F2X34glUL--
