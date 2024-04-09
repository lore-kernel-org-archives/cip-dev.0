Return-Path: <quirin.gylstorff@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DAB68CD1296
	for <webhook@archiver.kernel.org>; Tue,  9 Apr 2024 13:06:50 +0000 (UTC)
Received: from mta-64-226.siemens.flowmailer.net (mta-64-226.siemens.flowmailer.net [185.136.64.226])
 by mx.groups.io with SMTP id smtpd.web10.135727.1712668003131510768
 for <cip-dev@lists.cip-project.org>;
 Tue, 09 Apr 2024 06:06:43 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=Quirin.Gylstorff@siemens.com header.s=fm1 header.b=VzVQbokA;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.64.226, mailfrom: fm-51332-20240409130641f3b2cbc3b68bfcfffb-monxyl@rts-flowmailer.siemens.com)
Received: by mta-64-226.siemens.flowmailer.net with ESMTPSA id 20240409130641f3b2cbc3b68bfcfffb
        for <cip-dev@lists.cip-project.org>;
        Tue, 09 Apr 2024 15:06:41 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=Quirin.Gylstorff@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:References:In-Reply-To;
 bh=lP8vPta3VBv1pv1h9gXXM2wjvwupA4CkmTLpNinx7gg=;
 b=VzVQbokAHqG5sXfSCxUMQElLOhskQpBC+BD9KqEPqQIDcjfsO7KNOemiDaG3YPV53ugVrB
 PQu9oWASL22N+z1BiAK3/JtdSACPsH60P4UU1bSzh0JRuqVikzDRtx34O6bDIQdkhIU5gCzL
 0i7oInroC06CV46+wxkGPX3pzyYKI=;
From: Quirin Gylstorff <Quirin.Gylstorff@siemens.com>
To: jan.kiszka@siemens.com,
	cip-dev@lists.cip-project.org,
	johnxw@amazon.com
Subject: [cip-dev][isar-cip-core][PATCH v3 09/15] initramfs-crypt-hook: split hook in multiple files
Date: Tue,  9 Apr 2024 15:05:26 +0200
Message-ID: <20240409130638.559398-10-Quirin.Gylstorff@siemens.com>
In-Reply-To: <20240409130638.559398-1-Quirin.Gylstorff@siemens.com>
References: <20240409130638.559398-1-Quirin.Gylstorff@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-51332:519-21489:flowmailer
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 09 Apr 2024 13:06:50 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/15515

From: Quirin Gylstorff <quirin.gylstorff@siemens.com>

Split the clevis hook in Distro specific files to increase
the readability.

Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
---
 ...pt_partition.clevis.bullseye_or_later.hook | 34 +++++++++++++++++++
 .../encrypt_partition.clevis.buster.hook      | 30 ++++++++++++++++
 .../files/encrypt_partition.clevis.hook       | 16 ---------
 .../initramfs-crypt-hook_0.1.bb               | 18 +++++++++-
 4 files changed, 81 insertions(+), 17 deletions(-)
 create mode 100755 recipes-initramfs/initramfs-crypt-hook/files/encrypt_partition.clevis.bullseye_or_later.hook
 create mode 100755 recipes-initramfs/initramfs-crypt-hook/files/encrypt_partition.clevis.buster.hook

diff --git a/recipes-initramfs/initramfs-crypt-hook/files/encrypt_partition.clevis.bullseye_or_later.hook b/recipes-initramfs/initramfs-crypt-hook/files/encrypt_partition.clevis.bullseye_or_later.hook
new file mode 100755
index 0000000..b244d45
--- /dev/null
+++ b/recipes-initramfs/initramfs-crypt-hook/files/encrypt_partition.clevis.bullseye_or_later.hook
@@ -0,0 +1,34 @@
+#!/bin/sh
+# Copyright (C) Siemens AG, 2020-2023
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
+if [ -f /etc/os-release ]; then
+    . /etc/os-release
+fi
+hook_error() {
+    echo "(ERROR): $1" >&2
+    exit 1
+}
+
+copy_exec /usr/bin/clevis-luks-list || hook_error "/usr/bin/clevis-luks-list not found"
+copy_exec /usr/bin/clevis-luks-common-functions || hook_error "/usr/bin/clevis-luks-common-functions not found"
+copy_exec /usr/bin/tpm2_pcrread || hook_error "Unable to copy /usr/bin/tpm2_pcrread"
+copy_exec /usr/bin/tpm2_testparms || hook_error "Unable to copy /usr/bin/tpm2_testparms"
+copy_exec /usr/bin/tpm2_flushcontext || hook_error "Unable to copy /usr/bin/tpm2_flushcontext"
diff --git a/recipes-initramfs/initramfs-crypt-hook/files/encrypt_partition.clevis.buster.hook b/recipes-initramfs/initramfs-crypt-hook/files/encrypt_partition.clevis.buster.hook
new file mode 100755
index 0000000..fd39c34
--- /dev/null
+++ b/recipes-initramfs/initramfs-crypt-hook/files/encrypt_partition.clevis.buster.hook
@@ -0,0 +1,30 @@
+#!/bin/sh
+# Copyright (C) Siemens AG, 2020-2023
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
+if [ -f /etc/os-release ]; then
+    . /etc/os-release
+fi
+hook_error() {
+    echo "(ERROR): $1" >&2
+    exit 1
+}
+copy_exec /usr/bin/tpm2_pcrlist || hook_error "Unable to copy /usr/bin/tpm2_pcrlist"
+
diff --git a/recipes-initramfs/initramfs-crypt-hook/files/encrypt_partition.clevis.hook b/recipes-initramfs/initramfs-crypt-hook/files/encrypt_partition.clevis.hook
index 347551a..1921aba 100755
--- a/recipes-initramfs/initramfs-crypt-hook/files/encrypt_partition.clevis.hook
+++ b/recipes-initramfs/initramfs-crypt-hook/files/encrypt_partition.clevis.hook
@@ -54,27 +54,11 @@ copy_exec /usr/bin/clevis-encrypt-tpm2 || hook_error "/usr/bin/clevis-encrypt-tp
 copy_exec /usr/bin/clevis-decrypt-tpm2 || hook_error "/usr/bin/clevis-decrypt-tpm2 not found"
 copy_exec /usr/bin/clevis-luks-bind || hook_error "/usr/bin/clevis-luks-bind not found"
 copy_exec /usr/bin/clevis-luks-unlock || hook_error "/usr/bin/clevis-luks-unlock not found"
-if [ "$VERSION_CODENAME" != "buster" ] && [ -x /usr/bin/clevis-luks-list ]; then
-    copy_exec /usr/bin/clevis-luks-list || hook_error "/usr/bin/clevis-luks-list not found"
-fi
-if [ "$VERSION_CODENAME" != "buster" ] && [ -x /usr/bin/clevis-luks-common-functions  ]; then
-    copy_exec /usr/bin/clevis-luks-common-functions || hook_error "/usr/bin/clevis-luks-common-functions not found"
-fi
 copy_exec /usr/bin/tpm2_createprimary || hook_error "Unable to copy /usr/bin/tpm2_createprimary"
 copy_exec /usr/bin/tpm2_unseal || hook_error "Unable to copy /usr/bin/tpm2_unseal"
 copy_exec /usr/bin/tpm2_create || hook_error "Unable to copy /usr/bin/tpm2_create"
 copy_exec /usr/bin/tpm2_load || hook_error "Unable to copy /usr/bin/tpm2_load"
-if [ "$VERSION_CODENAME" != "buster" ] && [ -x /usr/bin/tpm2_pcrread ]; then
-    copy_exec /usr/bin/tpm2_pcrread || hook_error "Unable to copy /usr/bin/tpm2_pcrread"
-    copy_exec /usr/bin/tpm2_testparms || hook_error "Unable to copy /usr/bin/tpm2_testparms"
-fi
-if [ "$VERSION_CODENAME" = "buster" ] && [ -x /usr/bin/tpm2_pcrlist ]; then
-    copy_exec /usr/bin/tpm2_pcrlist || hook_error "Unable to copy /usr/bin/tpm2_pcrlist"
-fi
 copy_exec /usr/bin/tpm2_createpolicy || hook_error "Unable to copy /usr/bin/tpm2_createpolicy"
-if [ "$VERSION_CODENAME" != "buster" ] && [ -x /usr/bin/tpm2_flushcontext ]; then
-    copy_exec /usr/bin/tpm2_flushcontext || hook_error "Unable to copy /usr/bin/tpm2_flushcontext"
-fi
 copy_exec /usr/bin/bash || hook_error "Unable to copy /usr/bin/bash"
 copy_exec /usr/bin/luksmeta || hook_error "Unable to copy /usr/bin/luksmeta"
 copy_exec /usr/bin/jose || hook_error "Unable to copy /usr/bin/jose"
diff --git a/recipes-initramfs/initramfs-crypt-hook/initramfs-crypt-hook_0.1.bb b/recipes-initramfs/initramfs-crypt-hook/initramfs-crypt-hook_0.1.bb
index 4e60c10..dc46ff8 100644
--- a/recipes-initramfs/initramfs-crypt-hook/initramfs-crypt-hook_0.1.bb
+++ b/recipes-initramfs/initramfs-crypt-hook/initramfs-crypt-hook_0.1.bb
@@ -29,6 +29,16 @@ def encryption_dependency(d):
     else:
         bb.error("unkown cryptbackend defined")
 
+def add_additional_clevis_hooks(d):
+    base_distro_code_name = d.getVar('BASE_DISTRO_CODENAME') or ""
+    crypt_backend = d.getVar('CRYPT_BACKEND') or ""
+    if crypt_backend != 'clevis':
+        return ""
+    if base_distro_code_name == "buster":
+        return f"encrypt_partition.{crypt_backend}.buster.hook"
+    else:
+        return f"encrypt_partition.{crypt_backend}.bullseye_or_later.hook"
+
 CRYPT_BACKEND:buster = "clevis"
 CRYPT_BACKEND:bullseye = "clevis"
 CRYPT_BACKEND = "systemd"
@@ -38,7 +48,8 @@ SRC_URI += "file://encrypt_partition.env.tmpl \
             file://mount_crypt_partitions.script \
             file://encrypt_partition.${CRYPT_BACKEND}.hook \
             file://pwquality.conf"
-
+ADDITIONAL_CLEVIS_HOOK = "${@add_additional_clevis_hooks(d)}"
+SRC_URI += "${@ 'file://' + d.getVar('ADDITIONAL_CLEVIS_HOOK') if d.getVar('ADDITIONAL_CLEVIS_HOOK')else ''}"
 # CRYPT_PARTITIONS elements are <partition-label>:<mountpoint>:<reencrypt or format>
 CRYPT_PARTITIONS ??= "home:/home:reencrypt var:/var:reencrypt"
 # CRYPT_CREATE_FILE_SYSTEM_CMD contains the shell command to create the filesystem
@@ -72,5 +83,10 @@ do_install() {
         "${D}/usr/share/initramfs-tools/scripts/local-bottom/mount_decrypted_partition"
     install -m 0755 "${WORKDIR}/encrypt_partition.${CRYPT_BACKEND}.hook" \
         "${D}/usr/share/initramfs-tools/hooks/encrypt_partition"
+    if [ -f "${WORKDIR}"/"${ADDITIONAL_CLEVIS_HOOK}" ]; then
+        install -m 0755 "${WORKDIR}"/"${ADDITIONAL_CLEVIS_HOOK}" \
+            "${D}/usr/share/initramfs-tools/hooks/encrypt_partition.${BASE_DISTRO_CODENAME}"
+    fi
+
     install -m 0644 "${WORKDIR}/pwquality.conf" "${D}/usr/share/encrypt_partition/pwquality.conf"
 }
-- 
2.43.0


