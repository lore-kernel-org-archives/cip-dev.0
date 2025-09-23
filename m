Return-Path: <quirin.gylstorff@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 633F3CAC5B2
	for <webhook@archiver.kernel.org>; Tue, 23 Sep 2025 10:07:50 +0000 (UTC)
Received: from mta-64-225.siemens.flowmailer.net (mta-64-225.siemens.flowmailer.net [185.136.64.225])
 by mx.groups.io with SMTP id smtpd.web10.13229.1758622066814126735
 for <cip-dev@lists.cip-project.org>;
 Tue, 23 Sep 2025 03:07:47 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=Quirin.Gylstorff@siemens.com header.s=fm1 header.b=ELnvZpYj;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.64.225, mailfrom: fm-51332-202509231007430593da62db000207cc-btnopo@rts-flowmailer.siemens.com)
Received: by mta-64-225.siemens.flowmailer.net with ESMTPSA id 202509231007430593da62db000207cc
        for <cip-dev@lists.cip-project.org>;
        Tue, 23 Sep 2025 12:07:43 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=Quirin.Gylstorff@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:References:In-Reply-To;
 bh=joZSfjZnQBhaatF3JIpDsBDT6/ZSA6zJ00Ljlw7Sl9I=;
 b=ELnvZpYjOlEyiU37Ea0UJBz5lxA5CK2uwKBwr0A3Pm41BjWoepmMy0tm5PIccXZXtBQKpq
 YoeXj3nzkZSfZtOA8w6aGtSCkpZP0/z+DNT0v4RZNXE4yeeSfVMmRkfdcGqAdWFizsV4VmwN
 Yjq7H+Yt/a0qgB4rrdg9LJwSlj+9zlcI/69Y53HDvgULKOfx/9nLigZ9RurukHlF+5mVtvuk
 yFzT/wwPxbuL0vtNM1Vkyo46SnAJIh4kcZodPSdDKoJhNTa+i/MGV9d6doHFE1THhga4L/l3
 mvEOzqWAxQJq6hegx3yllUW80oXMGqbAs175ttMPdVL3lDa4/1aiihww==;
From: Quirin Gylstorff <Quirin.Gylstorff@siemens.com>
To: jan.kiszka@siemens.com,
	cip-dev@lists.cip-project.org
Subject: [cip-dev][isar-cip-core][PATCH v6 1/7] Add factory-reset-helper to set the Marker correctly
Date: Tue, 23 Sep 2025 12:02:35 +0200
Message-ID: <20250923100734.319688-2-Quirin.Gylstorff@siemens.com>
In-Reply-To: <20250923100734.319688-1-Quirin.Gylstorff@siemens.com>
References: <20250923100734.319688-1-Quirin.Gylstorff@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-51332:519-21489:flowmailer
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 23 Sep 2025 10:07:50 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/20095

From: Quirin Gylstorff <quirin.gylstorff@siemens.com>

The factory-reset-helper provides:
- set-factory-reset.sh to set the marker
- get-factory-reset.sh to get the marker

The helper provides a EFI and file based flavor. The
EFI based flavor should be preferred. The file based flavor
is used to set the factory-reset on targets where the EFI variables
can not be written, e.g. QEMU for arm64.

Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
---
 .../factory-reset-helper-efi_0.1.bb           | 23 +++++++
 .../factory-reset-helper-file_0.1.bb          | 19 ++++++
 .../factory-reset-helper.inc                  | 35 ++++++++++
 .../files/get-factory-reset-efivar.sh.tmpl    | 40 ++++++++++++
 .../files/get-factory-reset-file.sh.tmpl      | 65 +++++++++++++++++++
 .../files/set-factory-reset-efivar.sh.tmpl    | 59 +++++++++++++++++
 .../files/set-factory-reset-file.sh.tmpl      | 56 ++++++++++++++++
 7 files changed, 297 insertions(+)
 create mode 100644 recipes-support/factory-reset-helper/factory-reset-helper-efi_0.1.bb
 create mode 100644 recipes-support/factory-reset-helper/factory-reset-helper-file_0.1.bb
 create mode 100644 recipes-support/factory-reset-helper/factory-reset-helper.inc
 create mode 100644 recipes-support/factory-reset-helper/files/get-factory-reset-efivar.sh.tmpl
 create mode 100644 recipes-support/factory-reset-helper/files/get-factory-reset-file.sh.tmpl
 create mode 100644 recipes-support/factory-reset-helper/files/set-factory-reset-efivar.sh.tmpl
 create mode 100644 recipes-support/factory-reset-helper/files/set-factory-reset-file.sh.tmpl

diff --git a/recipes-support/factory-reset-helper/factory-reset-helper-efi_0.1.bb b/recipes-support/factory-reset-helper/factory-reset-helper-efi_0.1.bb
new file mode 100644
index 0000000..071b1dd
--- /dev/null
+++ b/recipes-support/factory-reset-helper/factory-reset-helper-efi_0.1.bb
@@ -0,0 +1,23 @@
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
+
+DEBIAN_CONFLICTS = "factory-reset-helper-file"
+
+# use systemd-factory-reset as default
+# https://www.freedesktop.org/software/systemd/man/devel/systemd-factory-reset.html#EFI%20Variables
+# The efivariable is defined by ${FACTORY_RESET_MARKER}-${FACTORY_RESET_EFIVARS_GUID}
+FACTORY_RESET_MARKER ?= "FactoryResetRequest"
+# Use a new vendor id instead of the one from systemd
+FACTORY_RESET_EFIVARS_GUID ?= "abc688c9-fee3-41f7-87d3-1076e4a29e8f"
+FACTORY_RESET_TYPE = "efivar"
+
+DEBIAN_DEPENDS .= ", coreutils, util-linux, e2fsprogs, bsdextrautils, efivar"
diff --git a/recipes-support/factory-reset-helper/factory-reset-helper-file_0.1.bb b/recipes-support/factory-reset-helper/factory-reset-helper-file_0.1.bb
new file mode 100644
index 0000000..8d82663
--- /dev/null
+++ b/recipes-support/factory-reset-helper/factory-reset-helper-file_0.1.bb
@@ -0,0 +1,19 @@
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
+
+DEBIAN_CONFLICTS = "factory-reset-helper-efi"
+
+FACTORY_RESET_MARKER ?= ".factory-reset"
+FACTORY_RESET_MARKER_STORAGE_DEVICE ?= "/dev/disk/by-partlabel/var"
+FACTORY_RESET_TYPE = "file"
+
+DEBIAN_DEPENDS .= ", coreutils, util-linux, e2fsprogs, bsdextrautils"
diff --git a/recipes-support/factory-reset-helper/factory-reset-helper.inc b/recipes-support/factory-reset-helper/factory-reset-helper.inc
new file mode 100644
index 0000000..7117a53
--- /dev/null
+++ b/recipes-support/factory-reset-helper/factory-reset-helper.inc
@@ -0,0 +1,35 @@
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
+
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
index 0000000..a34c226
--- /dev/null
+++ b/recipes-support/factory-reset-helper/files/get-factory-reset-efivar.sh.tmpl
@@ -0,0 +1,40 @@
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
+while [ $# -gt 0 ]; do
+  case $1 in
+  -d|--delete)
+    DELETE_MARKER=true
+    shift
+    ;;
+  -*)
+    echo "Unkown option '$1'"
+    usage
+    exit 1
+    ;;
+  esac
+done
+
+marker_file="/sys/firmware/efi/efivars/${FACTORY_RESET_MARKER}-${FACTORY_RESET_EFIVARS_GUID}"
+
+if ! mountpoint -q /sys/firmware/efi/efivars; then
+  if ! mount -t efivarfs none /sys/firmware/efi/efivars; then
+    echo "Could not mount efivarfs"
+    exit 1
+  fi
+fi
+if [ -e "$marker_file" ]; then
+  echo "factory-reset was triggered"
+  if [ "$DELETE_MARKER" = "true" ]; then
+    chattr -i "$marker_file"
+    rm "$marker_file"
+  fi
+fi
diff --git a/recipes-support/factory-reset-helper/files/get-factory-reset-file.sh.tmpl b/recipes-support/factory-reset-helper/files/get-factory-reset-file.sh.tmpl
new file mode 100644
index 0000000..a67558a
--- /dev/null
+++ b/recipes-support/factory-reset-helper/files/get-factory-reset-file.sh.tmpl
@@ -0,0 +1,65 @@
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
+while [ $# -gt 0 ]; do
+  case $1 in
+  -d|--delete)
+  DELETE_MARKER=true
+  shift
+  ;;
+  -*)
+  echo "Unkown option '$1'"
+  usage
+  exit 1
+  ;;
+  esac
+done
+
+
+marker="$(basename "${FACTORY_RESET_MARKER}")"
+marker_storage_device="${FACTORY_RESET_MARKER_STORAGE_DEVICE}"
+storage_mnt="$(findmnt  --first-only --output TARGET --noheadings "${marker_storage_device}")"
+tmp_mount=$(mktemp -d)
+# check for marker
+if [ -z "${storage_mnt}" ]; then
+  time_elapsed=0
+  while true; do
+      sleep 1
+      if [ -n "$(blkid --output value --match-tag TYPE "${marker_storage_device}")" ]; then
+    break
+      fi
+      time_elapsed="$((time_elapsed+1))"
+      if [ "${time_elapsed}" -ge 30 ]; then
+    break
+      fi
+  done
+  if ! mount -t "$(blkid --output value --match-tag TYPE "${marker_storage_device}")" \
+     "${marker_storage_device}" \
+     "${tmp_mount}"; then
+    if "$(type panic 2>/dev/null | grep -q  "is a function")"; then
+      panic "Can't mount ${marker_storage_device}!"
+    else
+      exit 1
+    fi
+  fi
+  storage_mnt="$tmp_mount"
+fi
+if [ -e "${storage_mnt}/${marker}" ]; then
+  echo "factory-reset was triggered"
+  # delete marker
+  if [ "$DELETE_MARKER" = "true" ]; then
+    rm "${storage_mnt}/${marker}"
+  fi
+fi
+if mountpoint -q "$tmp_mount"; then
+  umount "$tmp_mount"
+fi
+rmdir "$tmp_mount"
diff --git a/recipes-support/factory-reset-helper/files/set-factory-reset-efivar.sh.tmpl b/recipes-support/factory-reset-helper/files/set-factory-reset-efivar.sh.tmpl
new file mode 100644
index 0000000..304143f
--- /dev/null
+++ b/recipes-support/factory-reset-helper/files/set-factory-reset-efivar.sh.tmpl
@@ -0,0 +1,59 @@
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
+  if [ ! -e "$marker_file" ]; then
+    tmpfile=$(mktemp)
+    echo "FactoryReset" > "$tmpfile"
+    efivar --write --name="${FACTORY_RESET_EFIVARS_GUID}-${FACTORY_RESET_MARKER}" --attributes=7 -f "$tmpfile"
+  fi
+}
+
+delete_marker() {
+  if [ -e "$marker_file" ]; then
+    chattr -i "$marker_file"
+    rm "$marker_file"
+  fi
+}
+
+if [ $# -eq 0 ]; then
+  usage
+fi
+
+if ! mountpoint -q /sys/firmware/efi/efivars; then
+  if ! mount -t efivarfs none /sys/firmware/efi/efivars; then
+    echo "Could not mount efivarfs"
+    exit 1
+  fi
+fi
+
+while [ $# -gt 0 ]; do
+  case $1 in
+    -c|--create)
+      create_marker
+      shift
+      ;;
+    -d|--delete)
+      delete_marker
+      shift
+      ;;
+    -*)
+      echo "Unkown option '$1'"
+      usage
+      exit 1
+      ;;
+  esac
+done
diff --git a/recipes-support/factory-reset-helper/files/set-factory-reset-file.sh.tmpl b/recipes-support/factory-reset-helper/files/set-factory-reset-file.sh.tmpl
new file mode 100644
index 0000000..bbab959
--- /dev/null
+++ b/recipes-support/factory-reset-helper/files/set-factory-reset-file.sh.tmpl
@@ -0,0 +1,56 @@
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
+while [ $# -gt 0 ]; do
+  case $1 in
+  -c|--create)
+  touch "${marker_mnt}/${marker}"
+  shift
+  ;;
+  -d|--delete)
+  rm -f "${marker_mnt}/${marker}"
+  shift
+  ;;
+  -*)
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
-- 
2.50.1


