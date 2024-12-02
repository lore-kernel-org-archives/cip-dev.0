Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6B21D7832F
	for <webhook@archiver.kernel.org>; Mon,  2 Dec 2024 14:51:39 +0000 (UTC)
Received: from mta-64-226.siemens.flowmailer.net (mta-64-226.siemens.flowmailer.net [185.136.64.226])
 by mx.groups.io with SMTP id smtpd.web10.174654.1733151097003799811
 for <cip-dev@lists.cip-project.org>;
 Mon, 02 Dec 2024 06:51:37 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=jan.kiszka@siemens.com header.s=fm2 header.b=KkYQx1dz;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.64.226, mailfrom: fm-294854-2024120214513462497449d6beffa1ee-g4m6zw@rts-flowmailer.siemens.com)
Received: by mta-64-226.siemens.flowmailer.net with ESMTPSA id 2024120214513462497449d6beffa1ee
        for <cip-dev@lists.cip-project.org>;
        Mon, 02 Dec 2024 15:51:34 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm2;
 d=siemens.com; i=jan.kiszka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=5YY0+KRIeQYAkAHWxPDebV2ucsTtAqUu1gqCAbjvmco=;
 b=KkYQx1dz/wMoBb+vqBjnXPD5q7Ro9Vw49fDKNQy4C/vuDnNWZnNLHhCoAJ6TglQNiqfj/+
 aTPcfDF47fRa4GF8f+kR4zGL552v1tLd3IsYEJb8Xa7DBAhMIekAta9vg7nBTQhKTk/jjvZD
 1/ZUbcvOHkrUUbJUFTgzzmEgeHWXU/lzO6dAEEHoS+CwszCZkcOZogBJrYS1Uk92rjJ579KO
 0k8ddcUa5/c4tIMw+uwD/aCNCfdCmAR5mS4bO+Ili8xSYo0ETowWefkhf5kyE9B1hkNvYRsf
 79p4J/+v6AkzbFxBTYMS6TFjKq4Vz+YIxgoaKNbZM3nAOavi29BrbCsg==;
From: Jan Kiszka <jan.kiszka@siemens.com>
To: cip-dev@lists.cip-project.org
Cc: Alexander Heinisch <alexander.heinisch@siemens.com>,
	Quirin Gylstorff <quirin.gylstorff@siemens.com>
Subject: [isar-cip-core][PATCH 04/10] initramfs-crypt-hook: Convert to hook.inc
Date: Mon,  2 Dec 2024 15:51:07 +0100
Message-ID: <6675ca7a075d6cf7eae4adcd12958c749b464f87.1733151072.git.jan.kiszka@siemens.com>
In-Reply-To: <cover.1733151072.git.jan.kiszka@siemens.com>
References: <cover.1733151072.git.jan.kiszka@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-294854:519-21489:flowmailer
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 02 Dec 2024 14:51:39 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/17315

From: Jan Kiszka <jan.kiszka@siemens.com>

Here, we specifically benefit from the new generator by pulling a lot of
the variations into the bitbake domain. Most of the hook bits are now
generated, code duplications are avoided.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 ...pt_partition.clevis.bullseye_or_later.hook | 34 -------
 .../encrypt_partition.clevis.buster.hook      | 29 ------
 .../files/encrypt_partition.clevis.hook       | 88 -----------------
 .../files/encrypt_partition.systemd.hook      | 68 -------------
 .../initramfs-crypt-hook/files/hook           | 11 +++
 ...artitions.script => local-bottom-complete} |  0
 ...pt_partition.script => local-top-complete} |  0
 .../initramfs-crypt-hook_0.4.bb               | 96 ------------------
 .../initramfs-crypt-hook_0.5.bb               | 97 +++++++++++++++++++
 9 files changed, 108 insertions(+), 315 deletions(-)
 delete mode 100755 recipes-initramfs/initramfs-crypt-hook/files/encrypt_partition.clevis.bullseye_or_later.hook
 delete mode 100755 recipes-initramfs/initramfs-crypt-hook/files/encrypt_partition.clevis.buster.hook
 delete mode 100755 recipes-initramfs/initramfs-crypt-hook/files/encrypt_partition.clevis.hook
 delete mode 100755 recipes-initramfs/initramfs-crypt-hook/files/encrypt_partition.systemd.hook
 create mode 100644 recipes-initramfs/initramfs-crypt-hook/files/hook
 rename recipes-initramfs/initramfs-crypt-hook/files/{mount_crypt_partitions.script => local-bottom-complete} (100%)
 rename recipes-initramfs/initramfs-crypt-hook/files/{encrypt_partition.script => local-top-complete} (100%)
 delete mode 100644 recipes-initramfs/initramfs-crypt-hook/initramfs-crypt-hook_0.4.bb
 create mode 100644 recipes-initramfs/initramfs-crypt-hook/initramfs-crypt-hook_0.5.bb

diff --git a/recipes-initramfs/initramfs-crypt-hook/files/encrypt_partition.clevis.bullseye_or_later.hook b/recipes-initramfs/initramfs-crypt-hook/files/encrypt_partition.clevis.bullseye_or_later.hook
deleted file mode 100755
index b244d45f..00000000
--- a/recipes-initramfs/initramfs-crypt-hook/files/encrypt_partition.clevis.bullseye_or_later.hook
+++ /dev/null
@@ -1,34 +0,0 @@
-#!/bin/sh
-# Copyright (C) Siemens AG, 2020-2023
-#
-# SPDX-License-Identifier: MIT
-
-PREREQ=""
-
-prereqs()
-{
-     echo "$PREREQ"
-}
-
-case $1 in
-prereqs)
-     prereqs
-     exit 0
-     ;;
-esac
-
-. /usr/share/initramfs-tools/hook-functions
-
-if [ -f /etc/os-release ]; then
-    . /etc/os-release
-fi
-hook_error() {
-    echo "(ERROR): $1" >&2
-    exit 1
-}
-
-copy_exec /usr/bin/clevis-luks-list || hook_error "/usr/bin/clevis-luks-list not found"
-copy_exec /usr/bin/clevis-luks-common-functions || hook_error "/usr/bin/clevis-luks-common-functions not found"
-copy_exec /usr/bin/tpm2_pcrread || hook_error "Unable to copy /usr/bin/tpm2_pcrread"
-copy_exec /usr/bin/tpm2_testparms || hook_error "Unable to copy /usr/bin/tpm2_testparms"
-copy_exec /usr/bin/tpm2_flushcontext || hook_error "Unable to copy /usr/bin/tpm2_flushcontext"
diff --git a/recipes-initramfs/initramfs-crypt-hook/files/encrypt_partition.clevis.buster.hook b/recipes-initramfs/initramfs-crypt-hook/files/encrypt_partition.clevis.buster.hook
deleted file mode 100755
index 617d40f9..00000000
--- a/recipes-initramfs/initramfs-crypt-hook/files/encrypt_partition.clevis.buster.hook
+++ /dev/null
@@ -1,29 +0,0 @@
-#!/bin/sh
-# Copyright (C) Siemens AG, 2020-2023
-#
-# SPDX-License-Identifier: MIT
-
-PREREQ=""
-
-prereqs()
-{
-     echo "$PREREQ"
-}
-
-case $1 in
-prereqs)
-     prereqs
-     exit 0
-     ;;
-esac
-
-. /usr/share/initramfs-tools/hook-functions
-
-if [ -f /etc/os-release ]; then
-    . /etc/os-release
-fi
-hook_error() {
-    echo "(ERROR): $1" >&2
-    exit 1
-}
-copy_exec /usr/bin/tpm2_pcrlist || hook_error "Unable to copy /usr/bin/tpm2_pcrlist"
diff --git a/recipes-initramfs/initramfs-crypt-hook/files/encrypt_partition.clevis.hook b/recipes-initramfs/initramfs-crypt-hook/files/encrypt_partition.clevis.hook
deleted file mode 100755
index 4e62ef78..00000000
--- a/recipes-initramfs/initramfs-crypt-hook/files/encrypt_partition.clevis.hook
+++ /dev/null
@@ -1,88 +0,0 @@
-#!/bin/sh
-# Copyright (C) Siemens AG, 2020-2023
-#
-# SPDX-License-Identifier: MIT
-
-PREREQ=""
-
-prereqs()
-{
-     echo "$PREREQ"
-}
-
-case $1 in
-prereqs)
-     prereqs
-     exit 0
-     ;;
-esac
-
-. /usr/share/initramfs-tools/hook-functions
-
-if [ -f /etc/os-release ]; then
-    . /etc/os-release
-fi
-hook_error() {
-    echo "(ERROR): $1" >&2
-    exit 1
-}
-
-manual_add_modules tpm
-manual_add_modules tpm_tis_core
-manual_add_modules tpm_tis
-manual_add_modules tpm_crb
-manual_add_modules dm_mod
-manual_add_modules dm_crypt
-
-# add required crypto modules in case
-# the kernel does not have them as default
-manual_add_modules ecb
-manual_add_modules aes_generic
-manual_add_modules xts
-
-copy_exec /usr/bin/openssl || hook_error "/usr/bin/openssl not found"
-copy_exec /usr/sbin/mke2fs || hook_error "/usr/sbin/mke2fs not found"
-copy_exec /usr/bin/grep || hook_error "/usr/bin/grep not found"
-copy_exec /usr/bin/awk || hook_error "/usr/bin/awk not found"
-copy_exec /usr/bin/expr || hook_error "/usr/bin/expr not found"
-copy_exec /usr/sbin/e2fsck || hook_error "/usr/sbin/e2fsck not found"
-copy_exec /usr/sbin/resize2fs || hook_error "/usr/sbin/resize2fs not found"
-copy_exec /usr/sbin/cryptsetup || hook_error "/usr/sbin/cryptsetup not found"
-copy_exec /usr/bin/clevis || hook_error "/usr/bin/clevis not found"
-copy_exec /usr/bin/clevis-decrypt || hook_error "/usr/bin/clevis-decrypt not found"
-copy_exec /usr/bin/clevis-encrypt-tpm2 || hook_error "/usr/bin/clevis-encrypt-tpm2 not found"
-copy_exec /usr/bin/clevis-decrypt-tpm2 || hook_error "/usr/bin/clevis-decrypt-tpm2 not found"
-copy_exec /usr/bin/clevis-luks-bind || hook_error "/usr/bin/clevis-luks-bind not found"
-copy_exec /usr/bin/clevis-luks-unlock || hook_error "/usr/bin/clevis-luks-unlock not found"
-copy_exec /usr/bin/tpm2_createprimary || hook_error "Unable to copy /usr/bin/tpm2_createprimary"
-copy_exec /usr/bin/tpm2_unseal || hook_error "Unable to copy /usr/bin/tpm2_unseal"
-copy_exec /usr/bin/tpm2_create || hook_error "Unable to copy /usr/bin/tpm2_create"
-copy_exec /usr/bin/tpm2_load || hook_error "Unable to copy /usr/bin/tpm2_load"
-copy_exec /usr/bin/tpm2_createpolicy || hook_error "Unable to copy /usr/bin/tpm2_createpolicy"
-copy_exec /usr/bin/bash || hook_error "Unable to copy /usr/bin/bash"
-copy_exec /usr/bin/luksmeta || hook_error "Unable to copy /usr/bin/luksmeta"
-copy_exec /usr/bin/jose || hook_error "Unable to copy /usr/bin/jose"
-copy_exec /usr/bin/sed || hook_error "Unable to copy /usr/bin/sed"
-copy_exec /usr/bin/tail || hook_error "Unable to copy /usr/bin/tail"
-copy_exec /usr/bin/sort || hook_error "Unable to copy /usr/bin/sort"
-copy_exec /usr/bin/rm || hook_error "Unable to copy /usr/bin/rm"
-copy_exec /usr/bin/mktemp || hook_error "Unable to copy /usr/bin/mktemp"
-copy_exec /usr/bin/basename || hook_error "Unable to copy /usr/bin/basename"
-copy_exec /usr/bin/seq || hook_error "Unable to copy /usr/bin/seq"
-copy_exec /usr/bin/pwmake || hook_error "Unable to copy /usr/bin/pwmake"
-copy_exec /usr/bin/file || hook_error "Unable to copy /usr/bin/file "
-copy_exec /usr/lib/*/libgcc_s.so.1 || hook_error "Unable to copy /usr/lib/*/libgcc_s.so.1 "
-copy_exec /usr/bin/uuidparse || hook_error "Unable to copy /usr/bin/uuidparse"
-copy_exec /usr/bin/mountpoint || hook_error "Unable to copy /usr/bin/mountpoint"
-
-if [ -x /usr/sbin/cryptsetup-reencrypt ]; then
-    copy_exec /usr/sbin/cryptsetup-reencrypt
-fi
-
-for _LIBRARY in /usr/lib/*/libtss2*; do
-    copy_exec "$_LIBRARY"
-done
-
-copy_file library /usr/share/encrypt_partition/encrypt_partition.env /usr/share/encrypt_partition/encrypt_partition.env
-copy_file library /usr/share/encrypt_partition/encrypt_partition_tpm2 /usr/share/encrypt_partition/encrypt_partition_tpm2
-copy_file pwmake-config /usr/share/encrypt_partition/pwquality.conf /etc/security/pwquality.conf
diff --git a/recipes-initramfs/initramfs-crypt-hook/files/encrypt_partition.systemd.hook b/recipes-initramfs/initramfs-crypt-hook/files/encrypt_partition.systemd.hook
deleted file mode 100755
index be8c1173..00000000
--- a/recipes-initramfs/initramfs-crypt-hook/files/encrypt_partition.systemd.hook
+++ /dev/null
@@ -1,68 +0,0 @@
-#!/bin/sh
-# Copyright (C) Siemens AG, 2020-2024
-#
-# SPDX-License-Identifier: MIT
-
-PREREQ=""
-
-prereqs()
-{
-     echo "$PREREQ"
-}
-
-case $1 in
-prereqs)
-     prereqs
-     exit 0
-     ;;
-esac
-
-. /usr/share/initramfs-tools/hook-functions
-
-hook_error() {
-    echo "(ERROR): $1" >&2
-    exit 1
-}
-
-manual_add_modules tpm
-manual_add_modules tpm_tis_core
-manual_add_modules tpm_tis
-manual_add_modules tpm_crb
-manual_add_modules dm_mod
-manual_add_modules dm_crypt
-
-# add required crypto modules in case
-# the kernel does not have them as default
-manual_add_modules ecb
-manual_add_modules aes_generic
-manual_add_modules xts
-
-copy_exec /usr/bin/openssl || hook_error "/usr/bin/openssl not found"
-copy_exec /usr/sbin/mke2fs || hook_error "/usr/sbin/mke2fs not found"
-copy_exec /usr/bin/grep || hook_error "/usr/bin/grep not found"
-copy_exec /usr/bin/awk || hook_error "/usr/bin/awk not found"
-copy_exec /usr/bin/expr || hook_error "/usr/bin/expr not found"
-copy_exec /usr/bin/seq || hook_error "/usr/bin/seq not found"
-copy_exec /usr/bin/sleep || hook_error "/usr/bin/sleep not found"
-copy_exec /usr/sbin/e2fsck || hook_error "/usr/sbin/e2fsck not found"
-copy_exec /usr/sbin/resize2fs || hook_error "/usr/sbin/resize2fs not found"
-copy_exec /usr/sbin/cryptsetup || hook_error "/usr/sbin/cryptsetup not found"
-copy_exec /usr/bin/systemd-cryptenroll || hook_error "/usr/bin/systemd-cryptenroll not found"
-copy_exec /usr/lib/systemd/systemd-cryptsetup || hook_error "/usr/lib/systemd/systemd-cryptsetup not found"
-copy_exec /usr/bin/tpm2_pcrread || hook_error "Unable to copy /usr/bin/tpm2_pcrread"
-copy_exec /usr/bin/tpm2_testparms || hook_error "Unable to copy /usr/bin/tpm2_testparms"
-copy_exec /usr/bin/basename || hook_error "Unable to copy /usr/bin/basename"
-copy_exec /usr/bin/uuidparse || hook_error "Unable to copy /usr/bin/uuidparse"
-copy_exec /usr/bin/mountpoint || hook_error "Unable to copy /usr/bin/mountpoint"
-
-copy_exec /usr/lib/*/cryptsetup/libcryptsetup-token-systemd-tpm2.so || hook_error "/usr/lib/*/cryptsetup/libcryptsetup-token-systemd-tpm2.so not found"
-if [ -x /usr/sbin/cryptsetup-reencrypt ]; then
-    copy_exec /usr/sbin/cryptsetup-reencrypt
-fi
-
-for _LIBRARY in /usr/lib/*/libtss2* /usr/lib/*/libgcc_s.so.1; do
-    copy_exec "$_LIBRARY"
-done
-
-copy_file library /usr/share/encrypt_partition/encrypt_partition_tpm2 /usr/share/encrypt_partition/encrypt_partition_tpm2
-copy_file library /usr/share/encrypt_partition/encrypt_partition.env /usr/share/encrypt_partition/encrypt_partition.env
diff --git a/recipes-initramfs/initramfs-crypt-hook/files/hook b/recipes-initramfs/initramfs-crypt-hook/files/hook
new file mode 100644
index 00000000..1e64f624
--- /dev/null
+++ b/recipes-initramfs/initramfs-crypt-hook/files/hook
@@ -0,0 +1,11 @@
+# Copyright (C) Siemens AG, 2020-2024
+#
+# SPDX-License-Identifier: MIT
+
+for _LIBRARY in /usr/lib/*/libtss2*; do
+    copy_exec "$_LIBRARY"
+done
+
+copy_file library /usr/share/encrypt_partition/encrypt_partition.env /usr/share/encrypt_partition/encrypt_partition.env
+copy_file library /usr/share/encrypt_partition/encrypt_partition_tpm2 /usr/share/encrypt_partition/encrypt_partition_tpm2
+copy_file pwmake-config /usr/share/encrypt_partition/pwquality.conf /etc/security/pwquality.conf
diff --git a/recipes-initramfs/initramfs-crypt-hook/files/mount_crypt_partitions.script b/recipes-initramfs/initramfs-crypt-hook/files/local-bottom-complete
similarity index 100%
rename from recipes-initramfs/initramfs-crypt-hook/files/mount_crypt_partitions.script
rename to recipes-initramfs/initramfs-crypt-hook/files/local-bottom-complete
diff --git a/recipes-initramfs/initramfs-crypt-hook/files/encrypt_partition.script b/recipes-initramfs/initramfs-crypt-hook/files/local-top-complete
similarity index 100%
rename from recipes-initramfs/initramfs-crypt-hook/files/encrypt_partition.script
rename to recipes-initramfs/initramfs-crypt-hook/files/local-top-complete
diff --git a/recipes-initramfs/initramfs-crypt-hook/initramfs-crypt-hook_0.4.bb b/recipes-initramfs/initramfs-crypt-hook/initramfs-crypt-hook_0.4.bb
deleted file mode 100644
index 03a2bf44..00000000
--- a/recipes-initramfs/initramfs-crypt-hook/initramfs-crypt-hook_0.4.bb
+++ /dev/null
@@ -1,96 +0,0 @@
-#
-# CIP Core, generic profile
-#
-# Copyright (c) Siemens AG, 2020-2024
-#
-# Authors:
-#  Quirin Gylstorff <quirin.gylstorff@siemens.com>
-#
-# SPDX-License-Identifier: MIT
-
-inherit dpkg-raw
-DEBIAN_DEPENDS = "initramfs-tools, cryptsetup, \
-    awk, openssl,  e2fsprogs, tpm2-tools, coreutils, uuid-runtime"
-
-CLEVIS_DEPEND = ", clevis-luks, jose, bash, luksmeta, file, libpwquality-tools"
-
-DEBIAN_DEPENDS:append:buster = "${CLEVIS_DEPEND}, libgcc-7-dev, libtss2-esys0"
-DEBIAN_DEPENDS:append:bullseye = "${CLEVIS_DEPEND}, libtss2-esys-3.0.2-0, libtss2-rc0, libtss2-mu0"
-DEBIAN_DEPENDS:append:bookworm = ", libtss2-esys-3.0.2-0, libtss2-rc0, libtss2-mu0"
-DEBIAN_DEPENDS:append:trixie = ", systemd-cryptsetup, libtss2-esys-3.0.2-0t64, libtss2-rc0t64, libtss2-mu-4.0.1-0t64"
-DEBIAN_DEPENDS:append = "${@encryption_dependency(d)}"
-
-def encryption_dependency(d):
-    crypt_backend = d.getVar('CRYPT_BACKEND')
-    if crypt_backend == 'clevis':
-        clevis_depends= d.getVar('CLEVIS_DEPEND')
-        return f"{clevis_depends}, clevis-tpm2"
-    elif crypt_backend == 'systemd':
-        return ", systemd (>= 251)"
-    else:
-        bb.error("unkown cryptbackend defined")
-
-def add_additional_clevis_hooks(d):
-    base_distro_code_name = d.getVar('BASE_DISTRO_CODENAME') or ""
-    crypt_backend = d.getVar('CRYPT_BACKEND') or ""
-    if crypt_backend != 'clevis':
-        return ""
-    if base_distro_code_name == "buster":
-        return f"encrypt_partition.{crypt_backend}.buster.hook"
-    else:
-        return f"encrypt_partition.{crypt_backend}.bullseye_or_later.hook"
-
-CRYPT_BACKEND:buster = "clevis"
-CRYPT_BACKEND:bullseye = "clevis"
-CRYPT_BACKEND = "systemd"
-
-SRC_URI += "file://encrypt_partition.env.tmpl \
-            file://encrypt_partition.script \
-            file://encrypt_partition.${CRYPT_BACKEND}.script \
-            file://mount_crypt_partitions.script \
-            file://encrypt_partition.${CRYPT_BACKEND}.hook \
-            file://pwquality.conf"
-ADDITIONAL_CLEVIS_HOOK = "${@add_additional_clevis_hooks(d)}"
-SRC_URI += "${@ 'file://' + d.getVar('ADDITIONAL_CLEVIS_HOOK') if d.getVar('ADDITIONAL_CLEVIS_HOOK')else ''}"
-# CRYPT_PARTITIONS elements are <partition-label>:<mountpoint>:<reencrypt or format>
-CRYPT_PARTITIONS ??= "home:/home:reencrypt var:/var:reencrypt"
-# CRYPT_CREATE_FILE_SYSTEM_CMD contains the shell command to create the filesystem
-# in a newly formatted LUKS Partition
-CRYPT_CREATE_FILE_SYSTEM_CMD ??= "/usr/sbin/mke2fs -t ext4"
-# Timeout for creating / re-encrypting partitions on first boot
-CRYPT_SETUP_TIMEOUT ??= "600"
-# Watchdog to service during the initial setup of the crypto partitions
-INITRAMFS_WATCHDOG_DEVICE ??= "/dev/watchdog"
-# clevis needs tpm hash algorithm type
-CRYPT_HASH_TYPE ??= "sha256"
-CRYPT_KEY_ALGORITHM ??= "ecc"
-CRYPT_ENCRYPTION_OPTIONAL ??= "false"
-
-TEMPLATE_VARS = "CRYPT_PARTITIONS CRYPT_CREATE_FILE_SYSTEM_CMD \
-    CRYPT_SETUP_TIMEOUT INITRAMFS_WATCHDOG_DEVICE CRYPT_HASH_TYPE \
-    CRYPT_KEY_ALGORITHM CRYPT_ENCRYPTION_OPTIONAL"
-TEMPLATE_FILES = "encrypt_partition.env.tmpl"
-
-do_install[cleandirs] += " \
-    ${D}/usr/share/initramfs-tools/hooks \
-    ${D}/usr/share/encrypt_partition \
-    ${D}/usr/share/initramfs-tools/scripts/local-top \
-    ${D}/usr/share/initramfs-tools/scripts/local-bottom"
-
-do_install() {
-    install -m 0600 "${WORKDIR}/encrypt_partition.env" "${D}/usr/share/encrypt_partition/encrypt_partition.env"
-    install -m 0755 "${WORKDIR}/encrypt_partition.script" \
-        "${D}/usr/share/initramfs-tools/scripts/local-top/encrypt_partition"
-    install -m 0755 "${WORKDIR}/encrypt_partition.${CRYPT_BACKEND}.script" \
-        "${D}/usr/share/encrypt_partition/encrypt_partition_tpm2"
-    install -m 0755 "${WORKDIR}/mount_crypt_partitions.script" \
-        "${D}/usr/share/initramfs-tools/scripts/local-bottom/mount_decrypted_partition"
-    install -m 0755 "${WORKDIR}/encrypt_partition.${CRYPT_BACKEND}.hook" \
-        "${D}/usr/share/initramfs-tools/hooks/encrypt_partition"
-    if [ -f "${WORKDIR}"/"${ADDITIONAL_CLEVIS_HOOK}" ]; then
-        install -m 0755 "${WORKDIR}"/"${ADDITIONAL_CLEVIS_HOOK}" \
-            "${D}/usr/share/initramfs-tools/hooks/encrypt_partition.${BASE_DISTRO_CODENAME}"
-    fi
-
-    install -m 0644 "${WORKDIR}/pwquality.conf" "${D}/usr/share/encrypt_partition/pwquality.conf"
-}
diff --git a/recipes-initramfs/initramfs-crypt-hook/initramfs-crypt-hook_0.5.bb b/recipes-initramfs/initramfs-crypt-hook/initramfs-crypt-hook_0.5.bb
new file mode 100644
index 00000000..6ff315ed
--- /dev/null
+++ b/recipes-initramfs/initramfs-crypt-hook/initramfs-crypt-hook_0.5.bb
@@ -0,0 +1,97 @@
+#
+# CIP Core, generic profile
+#
+# Copyright (c) Siemens AG, 2020-2024
+#
+# Authors:
+#  Quirin Gylstorff <quirin.gylstorff@siemens.com>
+#  Jan Kiszka <jan.kiszka@siemens.com>
+#
+# SPDX-License-Identifier: MIT
+
+require recipes-initramfs/initramfs-hook/hook.inc
+
+DEBIAN_DEPENDS .= ", \
+    cryptsetup, \
+    awk, \
+    openssl, \
+    e2fsprogs, \
+    tpm2-tools, \
+    coreutils, \
+    uuid-runtime"
+
+CRYPT_BACKEND:buster = "clevis"
+CRYPT_BACKEND:bullseye = "clevis"
+CRYPT_BACKEND ?= "systemd"
+
+OVERRIDES .= ":${CRYPT_BACKEND}"
+
+DEBIAN_DEPENDS:append:buster = ", libgcc-7-dev, libtss2-esys0"
+DEBIAN_DEPENDS:append:bullseye = ", libtss2-esys-3.0.2-0, libtss2-rc0, libtss2-mu0"
+DEBIAN_DEPENDS:append:bookworm = ", libtss2-esys-3.0.2-0, libtss2-rc0, libtss2-mu0"
+DEBIAN_DEPENDS:append:trixie = ", libtss2-esys-3.0.2-0t64, libtss2-rc0t64, libtss2-mu-4.0.1-0t64"
+
+DEBIAN_DEPENDS:append:clevis = ", clevis-luks, jose, bash, luksmeta, file, libpwquality-tools, clevis-tpm2"
+DEBIAN_DEPENDS:append:systemd:trixie = ", systemd-cryptsetup"
+DEBIAN_DEPENDS:append:systemd = ", systemd (>= 251)"
+
+HOOK_ADD_MODULES = " \
+    tpm tpm_tis_core tpm_tis tpm_crb dm_mod dm_crypt \
+    ecb aes_generic xts"
+
+HOOK_COPY_EXECS = " \
+    openssl mke2fs grep awk expr seq sleep basename uuidparse mountpoint \
+    e2fsck resize2fs cryptsetup \
+    tpm2_pcrread tpm2_testparms tpm2_flushcontext \
+    /usr/lib/*/libgcc_s.so.1"
+
+HOOK_COPY_EXECS:append:clevis = " \
+    clevis clevis-decrypt clevis-encrypt-tpm2 clevis-decrypt-tpm2 \
+    clevis-luks-bind clevis-luks-unlock \
+    clevis-luks-list clevis-luks-common-functions \
+    tpm2_createprimary tpm2_unseal tpm2_create tpm2_load tpm2_createpolicy \
+    bash luksmeta jose sed tail sort rm mktemp pwmake file"
+HOOK_COPY_EXECS:append:systemd = " \
+    systemd-cryptenroll tpm2_pcrread tpm2_testparms \
+    /usr/lib/systemd/systemd-cryptsetup \
+    /usr/lib/*/cryptsetup/libcryptsetup-token-systemd-tpm2.so"
+
+HOOK_COPY_EXECS:append:buster = " cryptsetup-reencrypt tpm2_pcrlist"
+HOOK_COPY_EXECS:remove:buster = " \
+    tpm2_pcrread tpm2_testparms tpm2_flushcontext \
+    clevis-luks-list clevis-luks-common-functions"
+HOOK_COPY_EXECS:append:bullseye = " cryptsetup-reencrypt"
+
+SRC_URI += "file://encrypt_partition.env.tmpl \
+            file://local-top-complete \
+            file://encrypt_partition.${CRYPT_BACKEND}.script \
+            file://local-bottom-complete \
+            file://hook \
+            file://pwquality.conf"
+
+# CRYPT_PARTITIONS elements are <partition-label>:<mountpoint>:<reencrypt or format>
+CRYPT_PARTITIONS ??= "home:/home:reencrypt var:/var:reencrypt"
+# CRYPT_CREATE_FILE_SYSTEM_CMD contains the shell command to create the filesystem
+# in a newly formatted LUKS Partition
+CRYPT_CREATE_FILE_SYSTEM_CMD ??= "/usr/sbin/mke2fs -t ext4"
+# Timeout for creating / re-encrypting partitions on first boot
+CRYPT_SETUP_TIMEOUT ??= "600"
+# Watchdog to service during the initial setup of the crypto partitions
+INITRAMFS_WATCHDOG_DEVICE ??= "/dev/watchdog"
+# clevis needs tpm hash algorithm type
+CRYPT_HASH_TYPE ??= "sha256"
+CRYPT_KEY_ALGORITHM ??= "ecc"
+CRYPT_ENCRYPTION_OPTIONAL ??= "false"
+
+TEMPLATE_VARS += "CRYPT_PARTITIONS CRYPT_CREATE_FILE_SYSTEM_CMD \
+    CRYPT_SETUP_TIMEOUT INITRAMFS_WATCHDOG_DEVICE CRYPT_HASH_TYPE \
+    CRYPT_KEY_ALGORITHM CRYPT_ENCRYPTION_OPTIONAL"
+TEMPLATE_FILES += "encrypt_partition.env.tmpl"
+
+do_install[cleandirs] += "${D}/usr/share/encrypt_partition"
+do_install:prepend() {
+    install -m 0600 "${WORKDIR}/encrypt_partition.env" "${D}/usr/share/encrypt_partition/encrypt_partition.env"
+    install -m 0644 "${WORKDIR}/pwquality.conf" "${D}/usr/share/encrypt_partition/pwquality.conf"
+    install -m 0755 "${WORKDIR}/encrypt_partition.${CRYPT_BACKEND}.script" \
+        "${D}/usr/share/encrypt_partition/encrypt_partition_tpm2"
+}
-- 
2.43.0


