Return-Path: <yoshitake.kobayashi@toshiba.co.jp>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38BEFC28B23
	for <webhook@archiver.kernel.org>; Fri,  7 Mar 2025 03:48:46 +0000 (UTC)
Received: from mta-65-227.siemens.flowmailer.net (mta-65-227.siemens.flowmailer.net [185.136.65.227])
 by mx.groups.io with SMTP id smtpd.web11.8954.1741253783701973781
 for <cip-dev@lists.cip-project.org>;
 Thu, 06 Mar 2025 01:36:25 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=gokhan.cetin@siemens.com header.s=fm1 header.b=fxzTqnWE;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.65.227, mailfrom: fm-1328731-20250306093620d6a3ee3f74b2b91243-dsl3fx@rts-flowmailer.siemens.com)
Received: by mta-65-227.siemens.flowmailer.net with ESMTPSA id 20250306093620d6a3ee3f74b2b91243
        for <cip-dev@lists.cip-project.org>;
        Thu, 06 Mar 2025 10:36:20 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=gokhan.cetin@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc;
 bh=Tdke5kwAHjpabYkg0pMpAct7WtEb8NntNq+7Ik5xkTM=;
 b=fxzTqnWEJ2zlTyajIL2fEX3x61vqbhQite26woyv7M0s3WJe6gYjjJMR7GJW1GVAQu8zmk
 8x0/jV7HqB9lkElh2pckvec763iRYNmPrhcjw/WN+layIdp91coeryP12rJysigWoILq+75R
 dYBRNQDCVg9egoTZRu3DvaRCt5W+3gSwpN3RLy557LQTjGfibkoNNj9ww+yb1PwOFwtgw0Z5
 51Hu1+19EvaXZQxeyU7kxRsxoBM2jtCpQnbHxqeypbVfT1l+yoH5XuVdrwHB/bu0cFsb5OFi
 L0ik4vCfGcx+SAWbXjNeDszoNZGnUuKNz4av9VVyGf/VHHIlpxCs4sRQ==;
From: Gokhan Cetin <gokhan.cetin@siemens.com>
To: cip-dev@lists.cip-project.org
Cc: gokhan.cetin@siemens.com,
	quirin.gylstorff@siemens.com,
	jan.kiszka@siemens.com
Subject: [isar-cip-core][PATCH] ebg-secure-boot-signer: convert to signer provider that hooks sign-secure-image
Date: Thu,  6 Mar 2025 10:35:16 +0100
Message-Id: <20250306093516.3232063-1-gokhan.cetin@siemens.com>
MIME-Version: 1.0
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-1328731:519-21489:flowmailer
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 07 Mar 2025 03:48:46 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/18063

These changes split the signing process into two stages.
In the first stage, the `sign-secure-image` script called by the efibootguard wic
plugin now uses a hook to create a detached signature.

This allows downstream layers to provide their own signer scripts in a similar manner
for the second stage, without having to overwrite signer script or partition's source parameter.

Signed-off-by: Gokhan Cetin <gokhan.cetin@siemens.com>
---
 doc/README.secureboot.md                      | 37 +++++++++----
 kas/opt/ebg-secure-boot-snakeoil.yml          |  4 +-
 ...r_0.2.bb => ebg-secure-boot-signer_0.3.bb} | 16 +++---
 .../ebg-secure-boot-signer/files/sign-ebg.sh  | 34 ++++++++++++
 .../files/sign_secure_image.sh                | 38 -------------
 .../files/sign_secure_image.sh                | 55 +++++++++++++++++++
 .../sign-secure-image_0.1.bb                  | 27 +++++++++
 7 files changed, 154 insertions(+), 57 deletions(-)
 rename recipes-devtools/ebg-secure-boot-signer/{ebg-secure-boot-signer_0.2.bb => ebg-secure-boot-signer_0.3.bb} (51%)
 create mode 100644 recipes-devtools/ebg-secure-boot-signer/files/sign-ebg.sh
 delete mode 100644 recipes-devtools/ebg-secure-boot-signer/files/sign_secure_image.sh
 create mode 100644 recipes-devtools/sign-secure-image/files/sign_secure_image.sh
 create mode 100644 recipes-devtools/sign-secure-image/sign-secure-image_0.1.bb

diff --git a/doc/README.secureboot.md b/doc/README.secureboot.md
index 8ab67a8..a7dcb6c 100644
--- a/doc/README.secureboot.md
+++ b/doc/README.secureboot.md
@@ -166,8 +166,8 @@ local_conf_header:
     INITRAMFS_INSTALL:remove = "initramfs-abrootfs-hook"
 
   secure-boot: |
-    IMAGER_BUILD_DEPS += "ebg-secure-boot-signer"
-    IMAGER_INSTALL:wic += "ebg-secure-boot-signer"
+    IMAGER_BUILD_DEPS += "sign-secure-image"
+    IMAGER_INSTALL:wic += "sign-secure-image"
 
     # Use user-generated keys
     PREFERRED_PROVIDER_secure-boot-secrets = "secure-boot-key"
@@ -347,13 +347,30 @@ host$ sudo umount /mnt
 ```
 Launch KeyTool.efi binary from the built in EFI shell and follow step-4 from the section [Add Keys to OVMF](#add-keys-to-ovmf) to inject Secure Boot keys. Otherwise, consult the manual of the specific UEFI Firmware.
 
-Use the recipes [secure-boot-key](###secure-boot-key) to provided the keys
-to the signing script contained in
-[ebg-secure-boot-signer](###ebg-secure-boot-signer).
+### Signing efibootguard and Unified Kernel Image
 
-### [ebg-secure-boot-signer](./recipes-devtools/ebg-secure-boot-signer/ebg-secure-boot-signer_0.2.bb)
+Use the recipes
+[secure-boot-secrets](###./recipes-devtools/sign-secure-image/secure-boot-secrets)
+to provide the secure boot keys to the signing script
+[sign-secure-image](./recipes-devtools/sign-secure-image/sign-secure-image_0.1.bb).
+`sign-secure-image` exports the attributes from the efi to be signed and requests signature from provided
+`ebg-secure-boot-signer` package. Then it imports the signature into the efi and verifies the signed efi with
+public key installed by `secure-boot-secrets`.
 
-During building a efibootguard based wic image the scripts contained in
-the recipe ebg-secure-boot-signer can be used to sign the bootloader and
-unified kernel image(UKI). If the keys are stored in a HSM the script can
-be exchanged to sign the artifacts in a more secure way.
+This layer provides a signer package
+[ebg-secure-boot-signer](./recipes-devtools/ebg-secure-boot-signer/ebg-secure-boot-signer_0.3.bb)
+to be used in cases where both public and private keys are accessible at the project directory level.
+
+If there is a scenario where the private key cannot be accessed, such as HSM based signing or
+server side signing, `secure-boot-secrets` and `ebg-secure-boot-signer` can be provided from
+downstream layers for project specific requirements.
+
+```
+PREFERRED_PROVIDER_secure-boot-secrets = "<own secure boot secrets>"
+PREFERRED_PROVIDER_ebg-secure-boot-signer = "<own secure boot signer>"
+```
+
+The package `ebg-secure-boot-signer` must install its signing executable on `/usr/bin/sign-ebg`.
+This package may depend `secure-boot-signer` if it needs access to secure boot keys as done in this layer
+for signing or verification purposes. In such cases, secure boot keys should always be searched
+in designated locations as `secure-boot.pem` and `secure-boot.key` located in `/usr/share/secure-boot-secrets`.
diff --git a/kas/opt/ebg-secure-boot-snakeoil.yml b/kas/opt/ebg-secure-boot-snakeoil.yml
index 7d8ce65..f1eb782 100644
--- a/kas/opt/ebg-secure-boot-snakeoil.yml
+++ b/kas/opt/ebg-secure-boot-snakeoil.yml
@@ -25,8 +25,8 @@ local_conf_header:
     INITRAMFS_INSTALL:remove = "initramfs-abrootfs-hook"
 
   secure-boot: |
-    IMAGER_BUILD_DEPS += "ebg-secure-boot-signer"
-    IMAGER_INSTALL:wic += "ebg-secure-boot-signer"
+    IMAGER_BUILD_DEPS += "sign-secure-image"
+    IMAGER_INSTALL:wic += "sign-secure-image"
     # Use snakeoil keys
     PREFERRED_PROVIDER_secure-boot-secrets = "secure-boot-snakeoil"
 
diff --git a/recipes-devtools/ebg-secure-boot-signer/ebg-secure-boot-signer_0.2.bb b/recipes-devtools/ebg-secure-boot-signer/ebg-secure-boot-signer_0.3.bb
similarity index 51%
rename from recipes-devtools/ebg-secure-boot-signer/ebg-secure-boot-signer_0.2.bb
rename to recipes-devtools/ebg-secure-boot-signer/ebg-secure-boot-signer_0.3.bb
index 83289d4..3c002e6 100644
--- a/recipes-devtools/ebg-secure-boot-signer/ebg-secure-boot-signer_0.2.bb
+++ b/recipes-devtools/ebg-secure-boot-signer/ebg-secure-boot-signer_0.3.bb
@@ -1,7 +1,7 @@
 #
 # CIP Core, generic profile
 #
-# Copyright (c) Siemens AG, 2020-2022
+# Copyright (c) Siemens AG, 2020-2025
 #
 # Authors:
 #  Quirin Gylstorff <quirin.gylstorff@siemens.com>
@@ -11,17 +11,19 @@
 #
 
 inherit dpkg-raw
+DPKG_ARCH = "all"
+
+PROVIDES = "ebg-secure-boot-signer"
+DEBIAN_PROVIDES = "ebg-secure-boot-signer"
 
 DESCRIPTION = "Signing script for EFI Boot Guard setups"
 
 DEPENDS = "secure-boot-secrets"
-DEBIAN_DEPENDS = "sbsigntool, secure-boot-secrets, faketime"
-DPKG_ARCH = "all"
+DEBIAN_DEPENDS = "secure-boot-secrets, openssl"
 
-SRC_URI = "file://sign_secure_image.sh"
+SRC_URI = "file://sign-ebg.sh"
 
+do_install[cleandirs] = "${D}/usr/bin/"
 do_install() {
-    TARGET=${D}/usr/bin
-    install -d ${TARGET}
-    install -m 755 ${WORKDIR}/sign_secure_image.sh ${TARGET}/sign_secure_image.sh
+    install -m 0755 ${WORKDIR}/sign-ebg.sh ${D}/usr/bin/sign-ebg
 }
diff --git a/recipes-devtools/ebg-secure-boot-signer/files/sign-ebg.sh b/recipes-devtools/ebg-secure-boot-signer/files/sign-ebg.sh
new file mode 100644
index 0000000..9139165
--- /dev/null
+++ b/recipes-devtools/ebg-secure-boot-signer/files/sign-ebg.sh
@@ -0,0 +1,34 @@
+#!/bin/sh
+#
+# CIP Core, generic profile
+#
+# Copyright (c) Siemens AG, 2020-2025
+#
+# Authors:
+#  Quirin Gylstorff <quirin.gylstorff@siemens.com>
+#  Jan Kiszka <jan.kiszka@siemens.com>
+#
+# SPDX-License-Identifier: MIT
+#
+
+set -e
+
+signee=$1
+signature=$2
+
+usage(){
+    echo "sign image attributes with secure boot keys"
+    echo "$0 signee signature"
+    echo "signee: path to the image attributes to be signed"
+    echo "signature: path to store the signature"
+}
+
+if [ -z "$signee" ] || [ -z "$signature" ]; then
+    usage
+    exit 1
+fi
+
+keydir=/usr/share/secure-boot-secrets
+
+openssl dgst -binary -sha256 "${signee}" > "${signee}.digest"
+openssl pkeyutl -sign -in "${signee}.digest" -inkey "${keydir}/secure-boot.key" -pkeyopt digest:sha256 -keyform PEM -out "${signature}"
diff --git a/recipes-devtools/ebg-secure-boot-signer/files/sign_secure_image.sh b/recipes-devtools/ebg-secure-boot-signer/files/sign_secure_image.sh
deleted file mode 100644
index 213cf8a..0000000
--- a/recipes-devtools/ebg-secure-boot-signer/files/sign_secure_image.sh
+++ /dev/null
@@ -1,38 +0,0 @@
-#!/bin/sh
-#
-# CIP Core, generic profile
-#
-# Copyright (c) Siemens AG, 2020-2022
-#
-# Authors:
-#  Quirin Gylstorff <quirin.gylstorff@siemens.com>
-#  Jan Kiszka <jan.kiszka@siemens.com>
-#
-# SPDX-License-Identifier: MIT
-#
-
-set -e
-
-signee=$1
-signed=$2
-
-usage(){
-    echo "sign with image keys"
-    echo "$0 signee signed"
-    echo "signee: path to the image to be signed"
-    echo "signed: path to store the signed image"
-}
-
-if [ -z "$signee" ] || [ -z "$signed" ]; then
-    usage
-    exit 1
-fi
-
-keydir=/usr/share/secure-boot-secrets
-
-faketime_cmd=""
-if [ -n "$SOURCE_DATE_EPOCH" ]; then
-    faketime_cmd="faketime -f \"$(TZ=UTC date -d @$SOURCE_DATE_EPOCH +'%Y-%m-%d %H:%M:%S')\""
-fi
-
-eval $faketime_cmd sbsign --key ${keydir}/secure-boot.key --cert ${keydir}/secure-boot.pem --output $signed $signee
diff --git a/recipes-devtools/sign-secure-image/files/sign_secure_image.sh b/recipes-devtools/sign-secure-image/files/sign_secure_image.sh
new file mode 100644
index 0000000..8456867
--- /dev/null
+++ b/recipes-devtools/sign-secure-image/files/sign_secure_image.sh
@@ -0,0 +1,55 @@
+#!/bin/sh
+#
+# CIP Core, generic profile
+#
+# Copyright (c) Siemens AG, 2025
+#
+# Authors:
+#  Quirin Gylstorff <quirin.gylstorff@siemens.com>
+#  Jan Kiszka <jan.kiszka@siemens.com>
+#  Gokhan Cetin <gokhan.cetin@siemens.com>
+#
+# SPDX-License-Identifier: MIT
+#
+
+set -e
+
+signee=$1
+signed=$2
+
+usage(){
+    echo "sign image with secure boot signer"
+    echo "$0 signee signed"
+    echo "signee: path to the image to be signed"
+    echo "signed: path to store the signed image"
+}
+
+if [ -z "$signee" ] || [ -z "$signed" ]; then
+    usage
+    exit 1
+fi
+
+keydir=/usr/share/secure-boot-secrets
+
+tmpdir=$(mktemp -d)
+
+mkdir "${tmpdir}/certdb"
+certutil -d "${tmpdir}/certdb" cert.db -A -n cert -t ,,u -i "${keydir}/secure-boot.pem"
+
+pesign -i "$signee" -E "${tmpdir}/elf.sattrs"
+
+if [ ! -x /usr/bin/sign-ebg ]; then
+    echo "Could not find the executable '/usr/bin/sign-ebg'" 1>&2
+    exit 1
+fi
+
+if ! /usr/bin/sign-ebg "${tmpdir}/elf.sattrs" "${tmpdir}/elf.sattrs.sig" ; then
+    echo "Could not create signature file for '${signee}'" 1>&2
+    exit 1
+fi
+
+pesign -c cert -n "${tmpdir}/certdb" -R "${tmpdir}/elf.sattrs.sig" -I "${tmpdir}/elf.sattrs" -i "$signee" -o "$signed"
+
+rm -rf "${tmpdir}"
+
+sbverify "$signed" --cert "${keydir}/secure-boot.pem"
diff --git a/recipes-devtools/sign-secure-image/sign-secure-image_0.1.bb b/recipes-devtools/sign-secure-image/sign-secure-image_0.1.bb
new file mode 100644
index 0000000..cdc2d16
--- /dev/null
+++ b/recipes-devtools/sign-secure-image/sign-secure-image_0.1.bb
@@ -0,0 +1,27 @@
+#
+# CIP Core, generic profile
+#
+# Copyright (c) Siemens AG, 2025
+#
+# Authors:
+#  Quirin Gylstorff <quirin.gylstorff@siemens.com>
+#  Jan Kiszka <jan.kiszka@siemens.com>
+#  Gokhan Cetin <gokhan.cetin@siemens.com>
+#
+# SPDX-License-Identifier: MIT
+#
+
+inherit dpkg-raw
+DPKG_ARCH = "all"
+
+DESCRIPTION = "Signing script wrapper for EFI Boot Guard"
+
+DEPENDS = "secure-boot-secrets ebg-secure-boot-signer"
+DEBIAN_DEPENDS = "secure-boot-secrets, ebg-secure-boot-signer, pesign, sbsigntool"
+
+SRC_URI = "file://sign_secure_image.sh"
+
+do_install[cleandirs] = "${D}/usr/bin/"
+do_install() {
+    install -m 755 ${WORKDIR}/sign_secure_image.sh ${D}/usr/bin/sign_secure_image.sh
+}
-- 
2.39.2


