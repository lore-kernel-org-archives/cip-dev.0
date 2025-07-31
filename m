Return-Path: <quirin.gylstorff@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50453C87FD2
	for <webhook@archiver.kernel.org>; Thu, 31 Jul 2025 12:00:50 +0000 (UTC)
Received: from mta-65-226.siemens.flowmailer.net (mta-65-226.siemens.flowmailer.net [185.136.65.226])
 by mx.groups.io with SMTP id smtpd.web10.60290.1753963247971493999
 for <cip-dev@lists.cip-project.org>;
 Thu, 31 Jul 2025 05:00:49 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=Quirin.Gylstorff@siemens.com header.s=fm2 header.b=MR2CNZUe;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.65.226, mailfrom: fm-51332-2025073112004450be532f719bed64fc-3c80sk@rts-flowmailer.siemens.com)
Received: by mta-65-226.siemens.flowmailer.net with ESMTPSA id 2025073112004450be532f719bed64fc
        for <cip-dev@lists.cip-project.org>;
        Thu, 31 Jul 2025 14:00:45 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm2;
 d=siemens.com; i=Quirin.Gylstorff@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:References:In-Reply-To;
 bh=ZTHw5Z3Fwr/2RwsJ8uH29Rb4BQ3D9MCDKlBBUk2vBas=;
 b=MR2CNZUe46PqjaSMx2WUpqbPdaG/udw7UcneaNoRVZPzyEyhrEP30VTSa2JATY/JXIOsiJ
 7CJ7gobvHAKZEc4vgDZISYr3pkSGQLrh7P+PDex7DgPq/dD2bC3eUfN2CaWas37xJe8UUUZD
 8g8YTciGN7zDMP0oTW7WVVoQYRhKgPHO314Ou0zffsvgEShCyH2S5/1E6u9Snr2fUOOaDrIJ
 NJBOW21FHQfouzPkXGEkgwKXwZJ7XVCkx8C8bHDtdrpTP1xGFbxKTGFOoa1HAXULyoZ3bfR+
 g1q7AdQhBKnUDBaJ9o2lYu+wmeWLg/j52if85TUq6m3sj5jyZ4/J4Gww==;
From: Quirin Gylstorff <Quirin.Gylstorff@siemens.com>
To: cip-dev@lists.cip-project.org,
	jan.kiszka@siemens.com,
	gokhan.cetin@siemens.com
Subject: [cip-dev][isar-cip-core][PATCH v3 1/7] add factory-reset-helper to set the marker file
Date: Thu, 31 Jul 2025 13:58:40 +0200
Message-ID: <20250731120043.333345-2-Quirin.Gylstorff@siemens.com>
In-Reply-To: <20250731120043.333345-1-Quirin.Gylstorff@siemens.com>
References: <20250731120043.333345-1-Quirin.Gylstorff@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-51332:519-21489:flowmailer
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 31 Jul 2025 12:00:50 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/19643

From: Quirin Gylstorff <quirin.gylstorff@siemens.com>

This adds an helper script
`/usr/lib/factory-reset/set-factory-reset-marker` which writes the marker file to
the correct location.

Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
---
 .../factory-reset-helper-efi_0.1.bb           | 22 +++++++
 .../factory-reset-helper-file_0.1.bb          | 18 ++++++
 .../factory-reset-helper.inc                  | 34 +++++++++++
 .../files/get-factory-reset-efivar.sh.tmpl    | 25 ++++++++
 .../files/get-factory-reset-file.sh.tmpl      | 45 ++++++++++++++
 .../files/set-factory-reset-efivar.sh.tmpl    | 60 +++++++++++++++++++
 .../files/set-factory-reset-file.sh.tmpl      | 57 ++++++++++++++++++
 7 files changed, 261 insertions(+)
 create mode 100644 recipes-support/factory-reset-helper/factory-reset-helper-efi_0.1.bb
 create mode 100644 recipes-support/factory-reset-helper/factory-reset-helper-file_0.1.bb
 create mode 100644 recipes-support/factory-reset-helper/factory-reset-helper.inc
 create mode 100644 recipes-support/factory-reset-helper/files/get-factory-reset-efivar.sh.tmpl
 create mode 100644 recipes-support/factory-reset-helper/files/get-factory-reset-file.sh.tmpl
 create mode 100644 recipes-support/factory-reset-helper/files/set-factory-reset-efivar.sh.tmpl
 create mode 100644 recipes-support/factory-reset-helper/files/set-factory-reset-file.sh.tmpl

diff --git a/recipes-support/factory-reset-helper/factory-reset-helper-efi_0.1.bb b/recipes-support/factory-reset-helper/factory-reset-helper-efi_0.1.bb
new file mode 100644
index 0000000..ee483b6
--- /dev/null
+++ b/recipes-support/factory-reset-helper/factory-reset-helper-efi_0.1.bb
@@ -0,0 +1,22 @@
+#
+# CIP Core, generic profile
+#
+# Copyright (c) Siemens AG, 2025
+#
+# Authors:
+#  Quirin Gylstorff <quirin.gylstorff@siemens.com>
+#
+# SPDX-License-Identifier: MIT
+
+require recipes-support/factory-reset-helper/factory-reset-helper.inc
+DEBIAN_CONFLICTS = "factory-reset-helper-file"
+
+# use systemd-factory-reset as default
+# https://www.freedesktop.org/software/systemd/man/devel/systemd-factory-reset.html#EFI%20Variables
+# The efivariable is defined by ${FACTORY_RESET_MARKER}-${FACTORY_RESET_EFIVARS_GUID}
+FACTORY_RESET_MARKER ?= "FactoryResetRequest"
+# use the systemd factory reset vendor uuid
+FACTORY_RESET_EFIVARS_GUID ?= "8cf2644b-4b0b-428f-9387-6d876050dc67"
+FACTORY_RESET_TYPE = "efivar"
+
+DEBIAN_DEPENDS .= ", coreutils, util-linux, e2fsprogs, bsdextrautils, efivar"
diff --git a/recipes-support/factory-reset-helper/factory-reset-helper-file_0.1.bb b/recipes-support/factory-reset-helper/factory-reset-helper-file_0.1.bb
new file mode 100644
index 0000000..3e8650b
--- /dev/null
+++ b/recipes-support/factory-reset-helper/factory-reset-helper-file_0.1.bb
@@ -0,0 +1,18 @@
+#
+# CIP Core, generic profile
+#
+# Copyright (c) Siemens AG, 2025
+#
+# Authors:
+#  Quirin Gylstorff <quirin.gylstorff@siemens.com>
+#
+# SPDX-License-Identifier: MIT
+
+require recipes-support/factory-reset-helper/factory-reset-helper.inc
+DEBIAN_CONFLICTS = "factory-reset-helper-efi"
+
+FACTORY_RESET_MARKER ?= ".factory-reset"
+FACTORY_RESET_MARKER_STORAGE_DEVICE ?= "/dev/disk/by-partlabel/efi"
+FACTORY_RESET_TYPE = "file"
+
+DEBIAN_DEPENDS .= ", coreutils, util-linux, e2fsprogs, bsdextrautils"
diff --git a/recipes-support/factory-reset-helper/factory-reset-helper.inc b/recipes-support/factory-reset-helper/factory-reset-helper.inc
new file mode 100644
index 0000000..29ebf77
--- /dev/null
+++ b/recipes-support/factory-reset-helper/factory-reset-helper.inc
@@ -0,0 +1,34 @@
+#
+# CIP Core, generic profile
+#
+# Copyright (c) Siemens AG, 2025
+#
+# Authors:
+#  Quirin Gylstorff <quirin.gylstorff@siemens.com>
+#
+# SPDX-License-Identifier: MIT
+
+inherit dpkg-raw
+DPKG_ARCH = "all"
+DESCRIPTION = "helper script to execute a factory reset"
+
+PROVIDES = "factory-reset-helper"
+DEBIAN_PROVIDES = "factory-reset-helper"
+
+SRC_URI = "file://set-factory-reset-${FACTORY_RESET_TYPE}.sh.tmpl \
+           file://get-factory-reset-${FACTORY_RESET_TYPE}.sh.tmpl"
+
+TEMPLATE_FILES += "set-factory-reset-${FACTORY_RESET_TYPE}.sh.tmpl \
+                   get-factory-reset-${FACTORY_RESET_TYPE}.sh.tmpl"
+
+TEMPLATE_VARS += " FACTORY_RESET_MARKER \
+                   FACTORY_RESET_EFIVARS_GUID \
+                   FACTORY_RESET_MARKER_STORAGE_DEVICE"
+
+do_install[cleandirs] += "${D}/usr/sbin/"
+do_install:prepend() {
+    install -m 0700 "${WORKDIR}/set-factory-reset-${FACTORY_RESET_TYPE}.sh" \
+        "${D}/usr/sbin/set-factory-reset.sh"
+    install -m 0700 "${WORKDIR}/get-factory-reset-${FACTORY_RESET_TYPE}.sh" \
+        "${D}/usr/sbin/get-factory-reset.sh"
+}
diff --git a/recipes-support/factory-reset-helper/files/get-factory-reset-efivar.sh.tmpl b/recipes-support/factory-reset-helper/files/get-factory-reset-efivar.sh.tmpl
new file mode 100644
index 0000000..4af5500
--- /dev/null
+++ b/recipes-support/factory-reset-helper/files/get-factory-reset-efivar.sh.tmpl
@@ -0,0 +1,25 @@
+#!/bin/sh
+#
+# CIP Core, generic profile
+#
+# Copyright (c) Siemens AG, 2025
+#
+# Authors:
+#  Quirin Gylstorff <quirin.gylstorff@siemens.com>
+#
+# SPDX-License-Identifier: MIT
+
+marker_file="/sys/firmware/efi/efivars/${FACTORY_RESET_MARKER}-${FACTORY_RESET_EFIVARS_GUID}"
+
+if ! mountpoint -q /sys/firmware/efi/efivars; then
+	if ! mount -t efivarfs none /sys/firmware/efi/efivars; then
+		echo "Could not mount efivarfs"
+		exit 1
+	fi
+fi
+if [ -e "$marker_file" ]; then
+	echo "factory-reset was triggered"
+	chattr -i "$marker_file"
+	rm "$marker_file"
+fi
+
diff --git a/recipes-support/factory-reset-helper/files/get-factory-reset-file.sh.tmpl b/recipes-support/factory-reset-helper/files/get-factory-reset-file.sh.tmpl
new file mode 100644
index 0000000..639167e
--- /dev/null
+++ b/recipes-support/factory-reset-helper/files/get-factory-reset-file.sh.tmpl
@@ -0,0 +1,45 @@
+#!/bin/sh
+#
+# CIP Core, generic profile
+#
+# Copyright (c) Siemens AG, 2025
+#
+# Authors:
+#  Quirin Gylstorff <quirin.gylstorff@siemens.com>
+#
+# SPDX-License-Identifier: MIT
+
+marker="$(basename ${FACTORY_RESET_MARKER})"
+marker_storage_device="${FACTORY_RESET_MARKER_STORAGE_DEVICE}"
+storage_mnt="$(findmnt findmnt  --first-only --output TARGET --noheadings "${marker_storage_device}")"
+tmp_mount=$(mktemp -d)
+# check for marker
+if [ -z "${storage_mnt}" ]; then
+	while true; do
+	    sleep 1
+	    if [ -n "$(blkid --output value --match-tag TYPE "${marker_storage_device}")" ]; then
+		break
+	    fi
+	    time_elapsed="$(time_elapsed)"
+	    if [ "${time_elapsed}" -ge 30 ]; then
+		log_end_msg 0
+		break
+	    fi
+	done
+	if ! mount -t "$(blkid --output value --match-tag TYPE "${marker_storage_device}")" \
+		 "${marker_storage_device}" \
+		 "${tmp_mount}"; then
+		panic "Can't mount ${marker_storage_device}!"
+	fi
+	storage_mnt="$tmp_mount"
+fi
+if [ -e "${storage_mnt}/${marker}" ]; then
+	echo "factory-reset was triggered"
+	# delete marker
+	rm "${storage_mnt}/${marker}"
+fi
+if mountpoint -q "$tmp_mount"; then
+	umount "$tmp_mount"
+fi
+rmdir "$tmp_mount"
+
diff --git a/recipes-support/factory-reset-helper/files/set-factory-reset-efivar.sh.tmpl b/recipes-support/factory-reset-helper/files/set-factory-reset-efivar.sh.tmpl
new file mode 100644
index 0000000..f5a2273
--- /dev/null
+++ b/recipes-support/factory-reset-helper/files/set-factory-reset-efivar.sh.tmpl
@@ -0,0 +1,60 @@
+#!/bin/sh
+#
+# CIP Core, generic profile
+#
+# Copyright (c) Siemens AG, 2025
+#
+# Authors:
+#  Quirin Gylstorff <quirin.gylstorff@siemens.com>
+#
+# SPDX-License-Identifier: MIT
+
+usage() {
+  echo "$0 --create|--delete"
+}
+marker_file="/sys/firmware/efi/efivars/${FACTORY_RESET_MARKER}-${FACTORY_RESET_EFIVARS_GUID}"
+
+create_marker() {
+	if [ ! -e "$marker_file" ]; then
+		tmpfile=$(mktemp)
+		echo "FactoryReset" > $tmpfile
+		efivar -w -n ${FACTORY_RESET_EFIVARS_GUID}-${FACTORY_RESET_MARKER} -t 7 -f "$tmpfile"
+	fi
+}
+
+delete_marker() {
+	if [ -e "$marker_file" ]; then
+		chattr -i "$marker_file"
+		rm "$marker_file"
+	fi
+}
+
+if [ $# -eq 0 ]; then
+  usage
+fi
+
+if ! mountpoint -q /sys/firmware/efi/efivars; then
+	if ! mount -t efivarfs none /sys/firmware/efi/efivars; then
+		echo "Could not mount efivarfs"
+		exit 1
+	fi
+fi
+
+while [[ $# -gt 0 ]]; do
+  case $1 in
+  -c|--create)
+  create_marker
+  shift
+  ;;
+  -d|--delete)
+  delete_marker
+  shift
+  ;;
+  -*|--*)
+  echo "Unkown option '$1'"
+  usage
+  exit 1
+  ;;
+  esac
+done
+
diff --git a/recipes-support/factory-reset-helper/files/set-factory-reset-file.sh.tmpl b/recipes-support/factory-reset-helper/files/set-factory-reset-file.sh.tmpl
new file mode 100644
index 0000000..3be86fc
--- /dev/null
+++ b/recipes-support/factory-reset-helper/files/set-factory-reset-file.sh.tmpl
@@ -0,0 +1,57 @@
+#!/bin/bash
+#
+# CIP Core, generic profile
+#
+# Copyright (c) Siemens AG, 2025
+#
+# Authors:
+#  Quirin Gylstorff <quirin.gylstorff@siemens.com>
+#
+# SPDX-License-Identifier: MIT
+
+usage() {
+  echo "$0 --create|--delete"
+}
+
+marker="$(basename "${FACTORY_RESET_MARKER}")"
+marker_storage_device="${FACTORY_RESET_MARKER_STORAGE_DEVICE}"
+
+tmp_mnt=$(mktemp -d)
+if [ -n "$marker_storage_device" ]; then
+  marker_mnt="$(findmnt  --first-only --output TARGET --noheadings "${marker_storage_device}")"
+  if [ -z "$marker_mnt" ]; then
+    mount "${marker_storage_device}" "$tmp_mnt"
+    marker_mnt="${tmp_mnt}"
+  fi
+fi
+
+if [ $# -eq 0 ]; then
+  usage
+fi
+if [ -z "${marker_mnt}" ]; then
+   marker_mnt=$(pwd)
+fi
+
+while [[ $# -gt 0 ]]; do
+  case $1 in
+  -c|--create)
+  touch "${marker_mnt}/${marker}"
+  shift
+  ;;
+  -d|--delete)
+  rm -f "${marker_mnt}/${marker}"
+  shift
+  ;;
+  -*|--*)
+  echo "Unkown option '$1'"
+  usage
+  exit 1
+  ;;
+  esac
+done
+
+if mountpoint -q "$tmp_mnt"; then
+   umount "$tmp_mnt"
+fi
+rmdir "$tmp_mnt"
+
-- 
2.50.1


