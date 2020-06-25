Return-Path: <SRS0=bt+2=AG=lists.cip-project.org=bounce+64572+4827+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2C6AC433E4
	for <cip-dev@archiver.kernel.org>; Thu, 25 Jun 2020 14:10:22 +0000 (UTC)
Received: from web01.groups.io (web01.groups.io [66.175.222.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7D0EA20675
	for <cip-dev@archiver.kernel.org>; Thu, 25 Jun 2020 14:10:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.cip-project.org header.i=@lists.cip-project.org header.b="sAWpPLtv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7D0EA20675
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=siemens.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+4827+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id j04YYY4521723xGSmrSguWx9; Thu, 25 Jun 2020 07:10:22 -0700
X-Received: from goliath.siemens.de (goliath.siemens.de [192.35.17.28])
 by mx.groups.io with SMTP id smtpd.web12.11377.1593094220824663244
 for <cip-dev@lists.cip-project.org>;
 Thu, 25 Jun 2020 07:10:21 -0700
X-Received: from mail1.sbs.de (mail1.sbs.de [192.129.41.35])
	by goliath.siemens.de (8.15.2/8.15.2) with ESMTPS id 05PEAIEj028498
	(version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <cip-dev@lists.cip-project.org>; Thu, 25 Jun 2020 16:10:19 +0200
X-Received: from md2dvrtc.ad001.siemens.net ([167.87.6.122])
	by mail1.sbs.de (8.15.2/8.15.2) with ESMTP id 05PEAFXX000356;
	Thu, 25 Jun 2020 16:10:18 +0200
From: "Quirin Gylstorff" <quirin.gylstorff@siemens.com>
To: cip-dev@lists.cip-project.org, Jan.Kiszka@siemens.com
Cc: Quirin Gylstorff <quirin.gylstorff@siemens.com>
Subject: [cip-dev] [isar-cip-core RFC 4/7] secure-boot: Add secure boot with unified kernel image
Date: Thu, 25 Jun 2020 16:10:12 +0200
Message-Id: <20200625141015.31719-5-Quirin.Gylstorff@siemens.com>
In-Reply-To: <20200625141015.31719-1-Quirin.Gylstorff@siemens.com>
References: <20200625141015.31719-1-Quirin.Gylstorff@siemens.com>
MIME-Version: 1.0
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: bnSFBQ9XR0mRQOFGUuHqAJglx4520388AA=
Content-Type: multipart/mixed; boundary="AhafYBQrLBtg6ZgW0YL8"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1593094222;
 bh=ExSDoS+niUQrpljhIOebYGXu00msvvAbyJptbPAgTXU=;
 h=Cc:Content-Type:Date:From:Reply-To:Subject:To;
 b=sAWpPLtvZSxQcgEhhH2/qte99iJKWdLoZNHc2nFp/zkY/FNvLm+f9353m8+8+DvjZNT
 MPa190/rBj5qa7j03exq46685euiPHgR4/8dHqM8OmNH3bfCl3+Qpc1/j7ydyMgkYnYeQ
 EHVzB3YiXlipA228rADoQsCMB36SrN8Nk3o=

--AhafYBQrLBtg6ZgW0YL8
Content-Transfer-Encoding: 8bit

From: Quirin Gylstorff <quirin.gylstorff@siemens.com>

A unified kernel image contains the os-release, kernel,
kernel commandline, initramfs and efi-stub in one binary.
This binary can be boot by systemd-boot and efibootguard.
It also allows to sign kernel and initramfs as one packages.

Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
---
 kas/opt/ebg-secure-boot-base.yml              | 30 +++++++
 recipes-core/images/cip-core-image.bb         |  2 +-
 .../ebg-secure-boot-secrets_0.1.bb            | 52 +++++++++++
 .../ebg-secure-boot-secrets/files/README.md   |  1 +
 .../files/control.tmpl                        | 12 +++
 .../files/sign_secure_image.sh.tmpl           | 22 +++++
 .../initramfs-config/files/postinst.ext       |  3 +
 .../initramfs-config/files/postinst.tmpl      | 31 -------
 .../initramfs-config_0.1-cip.bb               |  7 +-
 ...enerate-sb-db-from-existing-certificate.sh | 16 ++++
 scripts/generate_secure_boot_keys.sh          | 51 +++++++++++
 .../wic/plugins/source/efibootguard-boot.py   | 87 +++++++++++++++++--
 .../wic/plugins/source/efibootguard-efi.py    | 40 ++++++++-
 scripts/start-efishell.sh                     | 12 +++
 start-qemu.sh                                 | 54 +++++++++---
 wic/ebg-signed-bootloader.inc                 |  2 +
 wic/qemu-amd64-efibootguard.wks               | 11 ++-
 17 files changed, 372 insertions(+), 61 deletions(-)
 create mode 100644 kas/opt/ebg-secure-boot-base.yml
 create mode 100644 recipes-devtools/ebg-secure-boot-secrets/ebg-secure-boot-secrets_0.1.bb
 create mode 100644 recipes-devtools/ebg-secure-boot-secrets/files/README.md
 create mode 100644 recipes-devtools/ebg-secure-boot-secrets/files/control.tmpl
 create mode 100644 recipes-devtools/ebg-secure-boot-secrets/files/sign_secure_image.sh.tmpl
 create mode 100644 recipes-support/initramfs-config/files/postinst.ext
 delete mode 100644 recipes-support/initramfs-config/files/postinst.tmpl
 create mode 100755 scripts/generate-sb-db-from-existing-certificate.sh
 create mode 100755 scripts/generate_secure_boot_keys.sh
 create mode 100755 scripts/start-efishell.sh
 create mode 100644 wic/ebg-signed-bootloader.inc

diff --git a/kas/opt/ebg-secure-boot-base.yml b/kas/opt/ebg-secure-boot-base.yml
new file mode 100644
index 0000000..661ff23
--- /dev/null
+++ b/kas/opt/ebg-secure-boot-base.yml
@@ -0,0 +1,30 @@
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
+header:
+  version: 8
+
+local_conf_header:
+  initramfs: |
+    IMAGE_INSTALL += "initramfs-config"
+
+  efibootguard: |
+    IMAGE_INSTALL += "efibootguard"
+    WDOG_TIMEOUT = "0"
+    WICVARS += "WDOG_TIMEOUT"
+
+  swupdate: |
+    IMAGE_INSTALL += "swupdate"
+    PREFERRED_PROVIDER_swupdate = "swupdate-luahandler"
+    BOOTLOADER = "efibootguard"
+
+  # needed as long as dependencies are not included in ebsy
+  debian-upstream: |
+    DISTRO_APT_SOURCES_append = " conf/distro/debian-${BASE_DISTRO_CODENAME}.list"
diff --git a/recipes-core/images/cip-core-image.bb b/recipes-core/images/cip-core-image.bb
index 9ee4b25..79ba308 100644
--- a/recipes-core/images/cip-core-image.bb
+++ b/recipes-core/images/cip-core-image.bb
@@ -10,7 +10,7 @@
 #
 
 inherit image
-
+inherit image_uuid
 ISAR_RELEASE_CMD = "git -C ${LAYERDIR_cip-core} describe --tags --dirty --always --match 'v[0-9].[0-9]*'"
 DESCRIPTION = "CIP Core image"
 
diff --git a/recipes-devtools/ebg-secure-boot-secrets/ebg-secure-boot-secrets_0.1.bb b/recipes-devtools/ebg-secure-boot-secrets/ebg-secure-boot-secrets_0.1.bb
new file mode 100644
index 0000000..94a79e6
--- /dev/null
+++ b/recipes-devtools/ebg-secure-boot-secrets/ebg-secure-boot-secrets_0.1.bb
@@ -0,0 +1,52 @@
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
+inherit dpkg-raw
+
+DESCRIPTION = "Add user defined secureboot certifcates to the buildchroot and the script to \
+               sign an image with the given keys"
+
+# variables
+SB_CERT_PATH = "/usr/share/ebg-secure-boot"
+SB_CERTDB ??= "democertdb"
+SB_VERIFY_CERT ??= "demoDB.crt"
+SB_KEY_NAME ??= "demoDB"
+
+# used to sign the image
+DEBIAN_DEPENDS = "pesign, sbsigntool"
+
+# this package cannot be install together with:
+DEBIAN_CONFLICTS = "ebg-secure-boot-snakeoil"
+
+SRC_URI = " \
+    file://${SB_CERTDB} \
+    file://${SB_VERIFY_CERT} \
+    file://sign_secure_image.sh.tmpl \
+    file://control.tmpl"
+
+TEMPLATE_FILES = "sign_secure_image.sh.tmpl"
+TEMPLATE_VARS += "SB_CERT_PATH SB_CERTDB SB_VERIFY_CERT SB_KEY_NAME"
+
+TEMPLATE_FILES += "control.tmpl"
+TEMPLATE_VARS += "PN MAINTAINER DPKG_ARCH DEBIAN_DEPENDS DESCRIPTION DEBIAN_CONFLICTS"
+
+do_install() {
+    TARGET=${D}${SB_CERT_PATH}
+    install -m 0700 -d ${TARGET}
+    cp -a ${WORKDIR}/${SB_CERTDB} ${TARGET}/${SB_CERTDB}
+    chmod 700 ${TARGET}/${SB_CERTDB}
+    install -m 0600 ${WORKDIR}/${SB_VERIFY_CERT} ${TARGET}/${SB_VERIFY_CERT}
+    TARGET=${D}/usr/bin
+    install -d ${TARGET}
+    install -m 755 ${WORKDIR}/sign_secure_image.sh ${TARGET}/sign_secure_image.sh
+}
+
+addtask do_install after do_transform_template
diff --git a/recipes-devtools/ebg-secure-boot-secrets/files/README.md b/recipes-devtools/ebg-secure-boot-secrets/files/README.md
new file mode 100644
index 0000000..c739c51
--- /dev/null
+++ b/recipes-devtools/ebg-secure-boot-secrets/files/README.md
@@ -0,0 +1 @@
+For a secure boot image this directory needs to contain the certdb directory and the db.crt file.
diff --git a/recipes-devtools/ebg-secure-boot-secrets/files/control.tmpl b/recipes-devtools/ebg-secure-boot-secrets/files/control.tmpl
new file mode 100644
index 0000000..8361a49
--- /dev/null
+++ b/recipes-devtools/ebg-secure-boot-secrets/files/control.tmpl
@@ -0,0 +1,12 @@
+Source: ${PN}
+Section: misc
+Priority: optional
+Standards-Version: 3.9.6
+Maintainer: ${MAINTAINER}
+Build-Depends: debhelper (>= 9)
+
+Package: ${PN}
+Architecture: ${DPKG_ARCH}
+Depends: ${DEBIAN_DEPENDS}
+Description: ${DESCRIPTION}
+Conflicts: ${DEBIAN_CONFLICTS}
diff --git a/recipes-devtools/ebg-secure-boot-secrets/files/sign_secure_image.sh.tmpl b/recipes-devtools/ebg-secure-boot-secrets/files/sign_secure_image.sh.tmpl
new file mode 100644
index 0000000..e84fd4c
--- /dev/null
+++ b/recipes-devtools/ebg-secure-boot-secrets/files/sign_secure_image.sh.tmpl
@@ -0,0 +1,22 @@
+#!/bin/sh
+set -e
+set -x
+signee=$1
+signed=$2
+
+usage(){
+    echo "sign with debian snakeoil"
+    echo "$0 signee signed"
+    echo "signee: path to the image to be signed"
+    echo "signed: path to store the signed image"
+}
+
+
+if [ -z "$signee" ] || [ -z "$signed" ]; then
+    usage
+    exit 1
+fi
+
+pesign --force --verbose --padding -n ${SB_CERT_PATH}/${SB_CERTDB} -c "${SB_KEY_NAME}" -s -i $signee -o $signed
+sbverify --cert ${SB_CERT_PATH}/${SB_VERIFY_CERT} $signed
+exit 0
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
deleted file mode 100644
index 008f68d..0000000
--- a/recipes-support/initramfs-config/files/postinst.tmpl
+++ /dev/null
@@ -1,31 +0,0 @@
-#!/bin/sh
-if [ -d /usr/share/secureboot ]; then
-    patch -s -p0 /usr/share/initramfs-tools/scripts/local /usr/share/secureboot/secure-boot-debian-local.patch
-fi
-
-INITRAMFS_CONF=/etc/initramfs-tools/initramfs.conf
-if [ -f ${INITRAMFS_CONF} ]; then
-    sed -i -E 's/(^MODULES=).*/\1${INITRAMFS_MODULES}/' ${INITRAMFS_CONF}
-    sed -i -E 's/(^BUSYBOX=).*/\1${INITRAMFS_BUSYBOX}/' ${INITRAMFS_CONF}
-    sed -i -E 's/(^COMPRESS=).*/\1${INITRAMFS_COMPRESS}/' ${INITRAMFS_CONF}
-    sed -i -E 's/(^KEYMAP=).*/\1${INITRAMFS_KEYMAP}/' ${INITRAMFS_CONF}
-    sed -i -E 's/(^DEVICE=).*/\1${INITRAMFS_NET_DEVICE}/' ${INITRAMFS_CONF}
-    sed -i -E 's/(^NFSROOT=).*/\1${INITRAMFS_NFSROOT}/' ${INITRAMFS_CONF}
-    sed -i -E 's/(^RUNSIZE=).*/\1${INITRAMFS_RUNSIZE}/' ${INITRAMFS_CONF}
-    if grep -Fxq "ROOT=" "${INITRAMFS_CONF}"; then
-        sed -i -E 's/(^ROOT=).*/\1${INITRAMFS_ROOT}/' ${INITRAMFS_CONF}
-    else
-        sed -i -E "\$aROOT=${INITRAMFS_ROOT}" ${INITRAMFS_CONF}
-    fi
-fi
-
-MODULES_LIST_FILE=/etc/initramfs-tools/modules
-if [ -f ${MODULES_LIST_FILE} ]; then
-    for modname in ${INITRAMFS_MODULE_LIST}; do
-        if ! grep -Fxq "$modname" "${MODULES_LIST_FILE}"; then
-            echo "$modname" >> "${MODULES_LIST_FILE}"
-        fi
-    done
-fi
-
-update-initramfs -v -u
diff --git a/recipes-support/initramfs-config/initramfs-config_0.1-cip.bb b/recipes-support/initramfs-config/initramfs-config_0.1-cip.bb
index ba1c898..3c8252f 100644
--- a/recipes-support/initramfs-config/initramfs-config_0.1-cip.bb
+++ b/recipes-support/initramfs-config/initramfs-config_0.1-cip.bb
@@ -14,7 +14,8 @@ FILESPATH =. "${LAYERDIR_isar-siemens}/recipes-support/initramfs-config/files:"
 
 DEBIAN_DEPENDS += ", busybox, patch"
 
-SRC_URI += "file://initramfs.lsblk.hook \
+SRC_URI += "file://postinst.ext \
+            file://initramfs.lsblk.hook \
             file://initramfs.image_uuid.hook \
             file://secure-boot-debian-local-patch"
 
@@ -25,7 +26,9 @@ do_install() {
     TARGET=${D}/usr/share/secureboot
     install -m 0755 -d ${TARGET}
     install -m 0644 ${WORKDIR}/secure-boot-debian-local-patch ${TARGET}/secure-boot-debian-local.patch
-
+    sed -i -e 's/exit 0//' ${WORKDIR}/postinst
+    cat ${WORKDIR}/postinst.ext >> ${WORKDIR}/postinst
+    echo "exit 0" >> ${WORKDIR}/postinst
     # add hooks for secure boot
     HOOKS=${D}/etc/initramfs-tools/hooks
 install -m 0755 -d ${HOOKS}
diff --git a/scripts/generate-sb-db-from-existing-certificate.sh b/scripts/generate-sb-db-from-existing-certificate.sh
new file mode 100755
index 0000000..035f189
--- /dev/null
+++ b/scripts/generate-sb-db-from-existing-certificate.sh
@@ -0,0 +1,16 @@
+#!/bin/sh
+name=${SB_NAME:-snakeoil}
+keydir=${SB_KEYDIR:-./keys}
+if [ ! -d  ${keydir} ]; then
+    mkdir -p ${keydir}
+fi
+inkey=${INKEY:-/usr/share/ovmf/PkKek-1-snakeoil.key}
+incert=${INCERT:-/usr/share/ovmf/PkKek-1-snakeoil.pem}
+nick_name=${IN_NICK:-snakeoil}
+TMP=$(mktemp -d)
+mkdir -p ${keydir}/${name}certdb
+certutil -N --empty-password -d ${keydir}/${name}certdb
+openssl pkcs12 -export -out ${TMP}/foo_key.p12 -inkey $inkey  -in $incert  -name $nick_name
+pk12util -i ${TMP}/foo_key.p12 -d ${keydir}/${name}certdb
+cp $incert ${keydir}/$(basename $incert)
+rm -rf $TMP
diff --git a/scripts/generate_secure_boot_keys.sh b/scripts/generate_secure_boot_keys.sh
new file mode 100755
index 0000000..8d3f8c0
--- /dev/null
+++ b/scripts/generate_secure_boot_keys.sh
@@ -0,0 +1,51 @@
+#!/bin/sh
+name=${SB_NAME:-demo}
+keydir=${SB_KEYDIR:-./keys}
+if [ ! -d  ${keydir} ]; then
+    mkdir -p ${keydir}
+fi
+openssl req -new -x509 -newkey rsa:4096 -subj "/CN=${name}PK/" -outform PEM \
+        -keyout ${keydir}/${name}PK.key  -out ${keydir}/${name}PK.crt  -days 3650 -nodes -sha256
+openssl req -new -x509 -newkey rsa:4096 -subj "/CN=${name}KEK/" -outform PEM \
+        -keyout ${keydir}/${name}KEK.key -out ${keydir}/${name}KEK.crt -days 3650 -nodes -sha256
+openssl req -new -x509 -newkey rsa:4096 -subj "/CN=${name}DB/" -outform PEM \
+        -keyout ${keydir}/${name}DB.key  -out ${keydir}/${name}DB.crt  -days 3650 -nodes -sha256
+openssl x509 -in ${keydir}/${name}PK.crt  -out ${keydir}/${name}PK.cer  -outform DER
+openssl x509 -in ${keydir}/${name}KEK.crt -out ${keydir}/${name}KEK.cer -outform DER
+openssl x509 -in ${keydir}/${name}DB.crt  -out ${keydir}/${name}DB.cer  -outform DER
+
+openssl pkcs12 -export -out ${keydir}/${name}DB.p12 \
+        -in ${keydir}/${name}DB.crt -inkey ${keydir}/${name}DB.key -passout pass:
+
+GUID=$(uuidgen --random)
+echo $GUID > ${keydir}/${name}GUID
+
+cert-to-efi-sig-list -g $GUID ${keydir}/${name}PK.crt  ${keydir}/${name}PK.esl
+cert-to-efi-sig-list -g $GUID ${keydir}/${name}KEK.crt ${keydir}/${name}KEK.esl
+cert-to-efi-sig-list -g $GUID ${keydir}/${name}DB.crt  ${keydir}/${name}DB.esl
+rm -f ${keydir}/${name}noPK.esl
+touch ${keydir}/${name}noPK.esl
+
+sign-efi-sig-list -g $GUID  \
+                  -k ${keydir}/${name}PK.key -c ${keydir}/${name}PK.crt \
+                  PK ${keydir}/${name}PK.esl   ${keydir}/${name}PK.auth
+sign-efi-sig-list -g $GUID  \
+                  -k ${keydir}/${name}PK.key -c ${keydir}/${name}PK.crt \
+                  PK ${keydir}/${name}noPK.esl ${keydir}/${name}noPK.auth
+sign-efi-sig-list -g $GUID  \
+                  -k ${keydir}/${name}PK.key -c ${keydir}/${name}PK.crt \
+                  KEK ${keydir}/${name}KEK.esl ${keydir}/${name}KEK.auth
+sign-efi-sig-list -g $GUID  \
+                  -k ${keydir}/${name}PK.key -c ${keydir}/${name}PK.crt \
+                  DB ${keydir}/${name}DB.esl ${keydir}/${name}DB.auth
+
+chmod 0600 ${keydir}/${name}*.key
+mkdir -p ${keydir}/${name}certdb
+certutil -N --empty-password -d ${keydir}/${name}certdb
+
+certutil -A -n 'PK' -d ${keydir}/${name}certdb -t CT,CT,CT -i ${keydir}/${name}PK.crt
+pk12util -W "" -d ${keydir}/${name}certdb -i ${keydir}/${name}DB.p12
+certutil -d ${keydir}/${name}certdb -A -i ${keydir}/${name}DB.crt -n "" -t u
+
+certutil -d ${keydir}/${name}certdb -K
+certutil -d ${keydir}/${name}certdb -L
diff --git a/scripts/lib/wic/plugins/source/efibootguard-boot.py b/scripts/lib/wic/plugins/source/efibootguard-boot.py
index 38d2b2e..d291f75 100644
--- a/scripts/lib/wic/plugins/source/efibootguard-boot.py
+++ b/scripts/lib/wic/plugins/source/efibootguard-boot.py
@@ -80,17 +80,29 @@ class EfibootguardBootPlugin(SourcePlugin):
 
 
         boot_files = source_params.get("files", "").split(' ')
+        uefi_kernel = source_params.get("unified-kernel")
         cmdline = bootloader.append
-        root_dev = source_params.get("root", None)
-        if not root_dev:
-            msger.error("Specify root in source params")
-            exit(1)
+        if uefi_kernel:
+            boot_image = cls._create_unified_kernel_image(rootfs_dir,
+                                                          cr_workdir,
+                                                          cmdline,
+                                                          uefi_kernel,
+                                                          deploy_dir,
+                                                          kernel_image,
+                                                          initrd_image,
+                                                          source_params)
+            boot_files.append(boot_image)
+        else:
+            root_dev = source_params.get("root", None)
+            if not root_dev:
+                msger.error("Specify root in source params")
+                exit(1)
             root_dev = root_dev.replace(":", "=")
 
-        cmdline += " root=%s rw" % root_dev
-        boot_files.append(kernel_image)
-        boot_files.append(initrd_image)
-        cmdline += "initrd=%s" % initrd_image if initrd_image else ""
+            cmdline += " root=%s rw" % root_dev
+            boot_files.append(kernel_image)
+            boot_files.append(initrd_image)
+            cmdline += "initrd=%s" % initrd_image if initrd_image else ""
 
         part_rootfs_dir = "%s/disk/%s.%s" % (cr_workdir,
                                              part.label, part.lineno)
@@ -160,3 +172,62 @@ class EfibootguardBootPlugin(SourcePlugin):
 
         part.size = bootimg_size
         part.source_file = bootimg
+
+    @classmethod
+    def _create_unified_kernel_image(cls, rootfs_dir, cr_workdir, cmdline,
+                                     uefi_kernel, deploy_dir, kernel_image,
+                                     initrd_image, source_params):
+        rootfs_path = rootfs_dir.get('ROOTFS_DIR')
+        os_release_file = "{root}/etc/os-release".format(root=rootfs_path)
+        efistub = "{rootfs_path}/usr/lib/systemd/boot/efi/linuxx64.efi.stub"\
+            .format(rootfs_path=rootfs_path)
+        msger.debug("osrelease path: %s", os_release_file)
+        kernel_cmdline_file = "{cr_workdir}/kernel-command-line-file.txt"\
+            .format(cr_workdir=cr_workdir)
+        with open(kernel_cmdline_file, "w") as cmd_fd:
+            cmd_fd.write(cmdline)
+        uefi_kernel_name = "linux.efi"
+        uefi_kernel_file = "{deploy_dir}/{uefi_kernel_name}"\
+            .format(deploy_dir=deploy_dir, uefi_kernel_name=uefi_kernel_name)
+        kernel = "{deploy_dir}/{kernel_image}"\
+            .format(deploy_dir=deploy_dir, kernel_image=kernel_image)
+        initrd = "{deploy_dir}/{initrd_image}"\
+            .format(deploy_dir=deploy_dir, initrd_image=initrd_image)
+        objcopy_cmd = 'objcopy \
+            --add-section .osrel={os_release_file} \
+            --change-section-vma .osrel=0x20000 \
+            --add-section .cmdline={kernel_cmdline_file} \
+            --change-section-vma .cmdline=0x30000 \
+            --add-section .linux={kernel} \
+            --change-section-vma .linux=0x2000000 \
+            --add-section .initrd={initrd} \
+            --change-section-vma .initrd=0x3000000 \
+            {efistub} {uefi_kernel_file}'.format(
+                os_release_file=os_release_file,
+                kernel_cmdline_file=kernel_cmdline_file,
+                kernel=kernel,
+                initrd=initrd,
+                efistub=efistub,
+                uefi_kernel_file=uefi_kernel_file)
+        exec_cmd(objcopy_cmd)
+
+        return cls._sign_file(name=uefi_kernel_name,
+                              signee=uefi_kernel_file,
+                              deploy_dir=deploy_dir,
+                              source_params=source_params)
+
+    @classmethod
+    def _sign_file(cls, name, signee, deploy_dir, source_params):
+        sign_script = source_params.get("signwith")
+        if sign_script and os.path.exists(sign_script):
+            msger.info("sign with script %s", sign_script)
+            name = name.replace(".efi", ".signed.efi")
+            sign_cmd = "{sign_script} {signee} {deploy_dir}/{name}"\
+                .format(sign_script=sign_script, signee=signee,
+                        deploy_dir=deploy_dir, name=name)
+            exec_cmd(sign_cmd)
+        elif sign_script and not os.path.exists(sign_script):
+            msger.error("Could not find script %s", sign_script)
+            exit(1)
+
+        return name
diff --git a/scripts/lib/wic/plugins/source/efibootguard-efi.py b/scripts/lib/wic/plugins/source/efibootguard-efi.py
index 5ee451f..6647212 100644
--- a/scripts/lib/wic/plugins/source/efibootguard-efi.py
+++ b/scripts/lib/wic/plugins/source/efibootguard-efi.py
@@ -64,10 +64,17 @@ class EfibootguardEFIPlugin(SourcePlugin):
         exec_cmd(create_dir_cmd)
 
         for bootloader in bootloader_files:
-            cp_cmd = "cp %s/%s %s/EFI/BOOT/%s" % (deploy_dir,
-                                                  bootloader,
-                                                  part_rootfs_dir,
-                                                  bootloader)
+            signed_bootloader = cls._sign_file(bootloader,
+                                               "{}/{}".format(deploy_dir,
+                                                              bootloader
+                                                              ),
+                                               cr_workdir,
+                                               source_params)
+            # important the bootloader in deploy_dir is no longer signed
+            cp_cmd = "cp %s/%s %s/EFI/BOOT/%s" % (cr_workdir,
+                                                signed_bootloader,
+                                                part_rootfs_dir,
+                                                bootloader)
             exec_cmd(cp_cmd, True)
         du_cmd = "du --apparent-size -ks %s" % part_rootfs_dir
         blocks = int(exec_cmd(du_cmd).split()[0])
@@ -100,3 +107,28 @@ class EfibootguardEFIPlugin(SourcePlugin):
 
         part.size = efi_part_image_size
         part.source_file = efi_part_image
+
+
+    @classmethod
+    def _sign_file(cls, name, signee, cr_workdir, source_params):
+        sign_script = source_params.get("signwith")
+        if sign_script and os.path.exists(sign_script):
+            work_name = name.replace(".efi", ".signed.efi")
+            sign_cmd = "{sign_script} {signee} \
+            {cr_workdir}/{work_name}".format(sign_script=sign_script,
+                                             signee=signee,
+                                             cr_workdir=cr_workdir,
+                                             work_name=work_name)
+            exec_cmd(sign_cmd)
+        elif sign_script and not os.path.exists(sign_script):
+            msger.error("Could not find script %s", sign_script)
+            exit(1)
+        else:
+            # if we do nothing copy the signee to the work directory
+            work_name = name
+            cp_cmd = "cp {signee} {cr_workdir}/{work_name}".format(
+                signee=signee,
+                cr_workdir=cr_workdir,
+                work_name=work_name)
+            exec_cmd(cp_cmd)
+        return work_name
diff --git a/scripts/start-efishell.sh b/scripts/start-efishell.sh
new file mode 100755
index 0000000..3c56ebc
--- /dev/null
+++ b/scripts/start-efishell.sh
@@ -0,0 +1,12 @@
+#!/bin/sh
+ovmf_code=${OVMF_CODE:-/usr/share/OVMF/OVMF_CODE.secboot.fd}
+ovmf_vars=${OVMF_VARS:-./OVMF_VARS.fd}
+DISK=$1
+qemu-system-x86_64 -enable-kvm -M q35 \
+ 	                 -cpu host,hv_relaxed,hv_vapic,hv-spinlocks=0xfff -smp 2 -m 2G -no-hpet \
+ 	                 -global ICH9-LPC.disable_s3=1 \
+ 	                 -global isa-fdc.driveA= \
+                   -boot menu=on \
+ 	                 -drive if=pflash,format=raw,unit=0,readonly=on,file=${ovmf_code} \
+ 	                 -drive if=pflash,format=raw,file=${ovmf_vars} \
+                   -drive file=fat:rw:$DISK
diff --git a/start-qemu.sh b/start-qemu.sh
index 49f0266..74d1b54 100755
--- a/start-qemu.sh
+++ b/start-qemu.sh
@@ -15,6 +15,8 @@ usage()
 	echo "Usage: $0 ARCHITECTURE [QEMU_OPTIONS]"
 	echo -e "\nSet QEMU_PATH environment variable to use a locally " \
 		"built QEMU version"
+	echo -e "\nSet SECURE_BOOT environment variable to boot a secure boot environment " \
+		"This environment also needs the variables OVMF_VARS and OVMF_CODE set"
 	exit 1
 }
 
@@ -22,17 +24,25 @@ if [ -n "${QEMU_PATH}" ]; then
 	QEMU_PATH="${QEMU_PATH}/"
 fi
 
+if [ -z "${DISTRO_RELEASE}" ]; then
+  DISTRO_RELEASE="buster"
+fi
+if [ -z "${TARGET_IMAGE}" ];then
+	TARGET_IMAGE="cip-core-image"
+fi
+
 case "$1" in
 	x86|x86_64|amd64)
 		DISTRO_ARCH=amd64
 		QEMU=qemu-system-x86_64
 		QEMU_EXTRA_ARGS=" \
-			-cpu host -smp 4 \
-			-enable-kvm -machine q35 \
+			-cpu qemu64 \
+			-smp 4 \
+			-machine q35,accel=kvm:tcg \
 			-device ide-hd,drive=disk \
 			-device virtio-net-pci,netdev=net"
 		KERNEL_CMDLINE=" \
-			root=/dev/sda vga=0x305 console=ttyS0"
+			root=/dev/sda vga=0x305"
 		;;
 	arm64|aarch64)
 		DISTRO_ARCH=arm64
@@ -71,21 +81,41 @@ case "$1" in
 		;;
 esac
 
-if [ -z "${DISTRO_RELEASE}" ]; then
-	DISTRO_RELEASE="buster"
-fi
-
-IMAGE_PREFIX="$(dirname $0)/build/tmp/deploy/images/qemu-${DISTRO_ARCH}/cip-core-image-cip-core-${DISTRO_RELEASE}-qemu-${DISTRO_ARCH}"
-IMAGE_FILE=$(ls ${IMAGE_PREFIX}.ext4.img)
+IMAGE_PREFIX="$(dirname $0)/build/tmp/deploy/images/qemu-${DISTRO_ARCH}/${TARGET_IMAGE}-cip-core-${DISTRO_RELEASE}-qemu-${DISTRO_ARCH}"
 
 if [ -z "${DISPLAY}" ]; then
 	QEMU_EXTRA_ARGS="${QEMU_EXTRA_ARGS} -nographic"
+	case "$1" in
+		x86|x86_64|amd64)
+			KERNEL_CMDLINE="${KERNEL_CMDLINE} console=ttyS0"
+	esac
+fi
+
+
+
+if [ -n "SECURE_BOOT" ]; then
+		ovmf_code=${OVMF_CODE:-/usr/share/OVMF/OVMF_CODE.secboot.fd}
+		ovmf_vars=${OVMF_VARS:-./OVMF_VARS.fd}
+		QEMU_EXTRA_ARGS=" \
+										${QEMU_EXTRA_ARGS} \
+										-global ICH9-LPC.disable_s3=1 \
+											-global isa-fdc.driveA= \
+										"
+		BOOT_FILES="-drive if=pflash,format=raw,unit=0,readonly=on,file=${ovmf_code} \
+									-drive if=pflash,format=raw,file=${ovmf_vars} \
+								-drive file=${IMAGE_PREFIX}.wic.img,discard=unmap,if=none,id=disk,format=raw"
+else
+		IMAGE_FILE=$(ls ${IMAGE_PREFIX}.ext4.img)
+
+		KERNEL_FILE=$(ls ${IMAGE_PREFIX}-vmlinuz* | tail -1)
+		INITRD_FILE=$(ls ${IMAGE_PREFIX}-initrd.img* | tail -1)
+
+		BOOT_FILES=-kernel ${KERNEL_FILE} -append "${KERNEL_CMDLINE}" \
+						-initrd ${INITRD_FILE}
 fi
 
 shift 1
 
 ${QEMU_PATH}${QEMU} \
-	-drive file=${IMAGE_FILE},discard=unmap,if=none,id=disk,format=raw \
 	-m 1G -serial mon:stdio -netdev user,id=net \
-	-kernel ${IMAGE_PREFIX}-vmlinuz -append "${KERNEL_CMDLINE}" \
-	-initrd ${IMAGE_PREFIX}-initrd.img ${QEMU_EXTRA_ARGS} "$@"
+	${BOOT_FILES} ${QEMU_EXTRA_ARGS} "$@"
diff --git a/wic/ebg-signed-bootloader.inc b/wic/ebg-signed-bootloader.inc
new file mode 100644
index 0000000..667e014
--- /dev/null
+++ b/wic/ebg-signed-bootloader.inc
@@ -0,0 +1,2 @@
+# EFI partition containing efibootguard bootloader binary
+part --source efibootguard-efi  --ondisk sda --size 16M --extra-space 0 --overhead-factor 1 --label efi   --align 1024 --part-type=EF00 --active --sourceparams "signwith=/usr/bin/sign_secure_image.sh"
diff --git a/wic/qemu-amd64-efibootguard.wks b/wic/qemu-amd64-efibootguard.wks
index 74446d3..06e2c85 100644
--- a/wic/qemu-amd64-efibootguard.wks
+++ b/wic/qemu-amd64-efibootguard.wks
@@ -1,5 +1,10 @@
-# short-description: Simatic-ipc227e with EFI Boot Guard and SWUpdate
-# long-description: Disk image for Simatic-ipc227e with EFI Boot Guard and SWUpdate
+# short-description: qemu-amd64 with EFI Boot Guard, secure boot and SWUpdate
+# long-description: Disk image for qemu-amd64 with EFI Boot Guard, secure boot and SWUpdate
+
+include ebg-signed-bootloader.inc
+
+# EFI Boot Guard environment/config partitions plus Kernel files
+part --source efibootguard-boot --ondisk sda --size 32M --extra-space 0 --overhead-factor 1 --label BOOT0 --align 1024 --part-type=0700 --sourceparams "revision=2,unified-kernel=y,signwith=/usr/bin/sign_secure_image.sh"
+part --source efibootguard-boot --ondisk sda --size 32M --extra-space 0 --overhead-factor 1 --label BOOT1 --align 1024 --part-type=0700 --sourceparams "revision=1,unified-kernel=y,signwith=/usr/bin/sign_secure_image.sh"
 
-include ebg-sysparts.inc
 include swupdate-partition.inc
-- 
2.20.1


--AhafYBQrLBtg6ZgW0YL8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.

View/Reply Online (#4827): https://lists.cip-project.org/g/cip-dev/message=
/4827
Mute This Topic: https://lists.cip-project.org/mt/75103453/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy  [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-

--AhafYBQrLBtg6ZgW0YL8--
