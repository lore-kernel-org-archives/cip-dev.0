Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB279C4167E
	for <webhook@archiver.kernel.org>; Thu,  5 May 2022 16:43:38 +0000 (UTC)
Received: from mta-64-225.siemens.flowmailer.net
 (mta-64-225.siemens.flowmailer.net [185.136.64.225])
 by mx.groups.io with SMTP id smtpd.web09.13556.1651769015245627704
 for <cip-dev@lists.cip-project.org>;
 Thu, 05 May 2022 09:43:36 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=jan.kiszka@siemens.com header.s=fm1 header.b=Byx0wH3Y;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.64.225,
 mailfrom: fm-294854-20220505164332af3cf3312e625e19c9-in9loj@rts-flowmailer.siemens.com)
Received: by mta-64-225.siemens.flowmailer.net with ESMTPSA id
 20220505164332af3cf3312e625e19c9
        for <cip-dev@lists.cip-project.org>;
        Thu, 05 May 2022 18:43:32 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=jan.kiszka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=K35Ae1gfsZ0qcjF3h4mikEhOaqCyQ0NbbkjycvX7GVc=;
 b=Byx0wH3YVamoS3+mVzcOK8JDpdtzXbQeyPdZsXmvLq1yYszAhOneErN7HfM+3IVrox7Ecw
 gafNs7Dfwu5j7TlIiXE4WpVWW9vxxG8RNQpwoWpi55FU/vfhkAsjto2yxMxQhZm0HCitrLU8
 JQsko/tIWmKIJjb1UZtW4nvJpUUyI=;
From: Jan Kiszka <jan.kiszka@siemens.com>
To: cip-dev@lists.cip-project.org
Cc: Quirin Gylstorff <quirin.gylstorff@siemens.com>,
	Christian Storm <christian.storm@siemens.com>
Subject: [isar-cip-core][PATCH v2 04/13] Rework secure boot key handling and
 signing recipes
Date: Thu,  5 May 2022 18:43:20 +0200
Message-Id: 
 <ec0256be52152975c1a9be42ca875059a222cbbc.1651769009.git.jan.kiszka@siemens.com>
In-Reply-To: <cover.1651769009.git.jan.kiszka@siemens.com>
References: <cover.1651769009.git.jan.kiszka@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-294854:519-21489:flowmailer
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 05 May 2022 16:43:38 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/8262

From: Jan Kiszka <jan.kiszka@siemens.com>

Simplify the signing recipe to a single, generic one. Instead, provide
secure-boot-secrets packages that contain the used image key and
certificate at a well-defined location. This allows for easy reuse in
other recipes than ebg-secure-boot-signer. U-Boot will be one.

Rather than using the OVMF package as build-time source for the snakeoil
keys, we import the two artifacts here. This allows to run the required
key removal upfront and simplifies the usage for buster. The certificate
has such a long lifetime that also future Debian should use the same
one, thus the snakeoil artifacts of OVMF should stay in sync with our
copy of key and cert. We may revisit this when discontinuing support for
buster, though.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 doc/README.secureboot.md                      | 22 ++++----
 kas/opt/ebg-secure-boot-snakeoil.yml          |  7 +--
 .../ebg-secure-boot-secrets_0.1.bb            | 51 -------------------
 .../ebg-secure-boot-secrets/files/README.md   |  1 -
 .../files/control.tmpl                        | 12 -----
 .../files/sign_secure_image.sh.tmpl           | 22 --------
 .../ebg-secure-boot-signer_0.1.bb             | 26 ++++++++++
 .../files/sign_secure_image.sh                | 33 ++++++++++++
 .../ebg-secure-boot-snakeoil_0.1.bb           | 34 -------------
 .../files/control.tmpl                        | 12 -----
 .../files/sign_secure_image.sh                | 36 -------------
 .../files/PkKek-1-snakeoil.key                | 27 ++++++++++
 .../files/PkKek-1-snakeoil.pem                | 21 ++++++++
 .../secure-boot-key_0.1.bb                    | 14 +++++
 .../secure-boot-secrets.inc                   | 34 +++++++++++++
 .../secure-boot-snakeoil_0.1.bb               | 17 +++++++
 16 files changed, 186 insertions(+), 183 deletions(-)
 delete mode 100644 recipes-devtools/ebg-secure-boot-secrets/ebg-secure-boot-secrets_0.1.bb
 delete mode 100644 recipes-devtools/ebg-secure-boot-secrets/files/README.md
 delete mode 100644 recipes-devtools/ebg-secure-boot-secrets/files/control.tmpl
 delete mode 100644 recipes-devtools/ebg-secure-boot-secrets/files/sign_secure_image.sh.tmpl
 create mode 100644 recipes-devtools/ebg-secure-boot-signer/ebg-secure-boot-signer_0.1.bb
 create mode 100644 recipes-devtools/ebg-secure-boot-signer/files/sign_secure_image.sh
 delete mode 100644 recipes-devtools/ebg-secure-boot-snakeoil/ebg-secure-boot-snakeoil_0.1.bb
 delete mode 100644 recipes-devtools/ebg-secure-boot-snakeoil/files/control.tmpl
 delete mode 100644 recipes-devtools/ebg-secure-boot-snakeoil/files/sign_secure_image.sh
 create mode 100644 recipes-devtools/secure-boot-secrets/files/PkKek-1-snakeoil.key
 create mode 100644 recipes-devtools/secure-boot-secrets/files/PkKek-1-snakeoil.pem
 create mode 100644 recipes-devtools/secure-boot-secrets/secure-boot-key_0.1.bb
 create mode 100644 recipes-devtools/secure-boot-secrets/secure-boot-secrets.inc
 create mode 100644 recipes-devtools/secure-boot-secrets/secure-boot-snakeoil_0.1.bb

diff --git a/doc/README.secureboot.md b/doc/README.secureboot.md
index b2d7be9..c1a0301 100644
--- a/doc/README.secureboot.md
+++ b/doc/README.secureboot.md
@@ -43,24 +43,22 @@ executable or script with the following interface:
 Supply the script name and path to wic by adding
 `signwith=<path and name of the script to sign>"` to sourceparams of the partition.
 
-### Existing packages to sign an image
+### Existing key packages for signing an image
 
-#### ebg-secure-boot-snakeoil
+#### secure-boot-snakeoil
 
 This package uses the snakeoil key and certificate from the ovmf package(0.0~20200229-2)
-backported from Debian bullseye and signs the image.
+backported from Debian bullseye for signing the image.
 
-#### ebg-secure-boot-secrets
-This package takes a user-generated certificate and adds it to the build system.
+#### secure-boot-key
+
+This package takes a user-generated certificate and key adds them to the build system.
 The following variable and steps are necessary to build a secure boot capable image:
 - Set certification information to sign and verify the image with:
-    - SB_CERTDB: The directory containing the certificate database create with certutil
-    - SB_VERIFY_CERT: The certificate to verify the signing process
-    - SB_KEY_NAME: Name of the key in the certificate database
-- if necessary change the script to select the boot partition after an update
-    - recipes-support/initramfs-config/files/initramfs.selectrootfs.script
+    - SB_CERT: The certificate to verify the signing process
+    - SB_KEY: The private key of for the certificate
 
-The files referred by SB_CERTDB and SB_VERIFY_CERT must be store in  `recipes-devtools/ebg-secure-boot-secrets/files/`
+The files referred by SB_CERT and SB_KEY must be store in `recipes-devtools/secure-boot-secrets/files/`.
 
 ## Running in QEMU
 
@@ -96,7 +94,7 @@ scripts/generate-sb-db-from-existing-certificate.sh
 ```
 This will create the directory `SB_KEYDIR` and will store the `${SB_NAME}certdb` with the given name.
 
-Copy the used certificate and database to `recipes-devtools/ebg-secure-boot-secrets/files/`
+Copy the used certificate and private key to `recipes-devtools/secure-boot-secrets/files/`
 
 #### Generate keys
 
diff --git a/kas/opt/ebg-secure-boot-snakeoil.yml b/kas/opt/ebg-secure-boot-snakeoil.yml
index b329f41..7442eb7 100644
--- a/kas/opt/ebg-secure-boot-snakeoil.yml
+++ b/kas/opt/ebg-secure-boot-snakeoil.yml
@@ -28,6 +28,7 @@ local_conf_header:
     INITRAMFS_INSTALL_append = " initramfs-verity-hook"
 
   secure-boot: |
-    # Add snakeoil binaries for qemu
-    IMAGER_BUILD_DEPS += "ebg-secure-boot-snakeoil"
-    IMAGER_INSTALL += "ebg-secure-boot-snakeoil"
+    IMAGER_BUILD_DEPS += "ebg-secure-boot-signer"
+    IMAGER_INSTALL += "ebg-secure-boot-signer"
+    # Use snakeoil keys
+    PREFERRED_PROVIDER_secure-boot-secrets = "secure-boot-snakeoil"
diff --git a/recipes-devtools/ebg-secure-boot-secrets/ebg-secure-boot-secrets_0.1.bb b/recipes-devtools/ebg-secure-boot-secrets/ebg-secure-boot-secrets_0.1.bb
deleted file mode 100644
index 0d57910..0000000
--- a/recipes-devtools/ebg-secure-boot-secrets/ebg-secure-boot-secrets_0.1.bb
+++ /dev/null
@@ -1,51 +0,0 @@
-#
-# CIP Core, generic profile
-#
-# Copyright (c) Siemens AG, 2020
-#
-# Authors:
-#  Quirin Gylstorff <quirin.gylstorff@siemens.com>
-#
-# SPDX-License-Identifier: MIT
-#
-
-inherit dpkg-raw
-
-DESCRIPTION = "Add user defined secureboot certifcates to the buildchroot and the script to \
-               sign an image with the given keys"
-
-# variables
-SB_CERT_PATH = "/usr/share/ebg-secure-boot"
-SB_CERTDB ??= ""
-SB_VERIFY_CERT ??= ""
-SB_KEY_NAME ??= "demoDB"
-
-# used to sign the image
-DEBIAN_DEPENDS = "pesign, sbsigntool"
-
-# this package cannot be install together with:
-DEBIAN_CONFLICTS = "ebg-secure-boot-snakeoil"
-
-SRC_URI = " \
-    file://sign_secure_image.sh.tmpl \
-    file://control.tmpl"
-SRC_URI_append = " ${@ "file://"+d.getVar('SB_CERTDB') if d.getVar('SB_CERTDB') else '' }"
-SRC_URI_append = " ${@ "file://"+d.getVar('SB_VERIFY_CERT') if d.getVar('SB_VERIFY_CERT') else '' }"
-TEMPLATE_FILES = "sign_secure_image.sh.tmpl"
-TEMPLATE_VARS += "SB_CERT_PATH SB_CERTDB SB_VERIFY_CERT SB_KEY_NAME"
-
-TEMPLATE_FILES += "control.tmpl"
-TEMPLATE_VARS += "PN MAINTAINER DPKG_ARCH DEBIAN_DEPENDS DESCRIPTION DEBIAN_CONFLICTS"
-
-do_install() {
-    TARGET=${D}${SB_CERT_PATH}
-    install -m 0700 -d ${TARGET}
-    cp -a ${WORKDIR}/${SB_CERTDB} ${TARGET}/${SB_CERTDB}
-    chmod 700 ${TARGET}/${SB_CERTDB}
-    install -m 0600 ${WORKDIR}/${SB_VERIFY_CERT} ${TARGET}/${SB_VERIFY_CERT}
-    TARGET=${D}/usr/bin
-    install -d ${TARGET}
-    install -m 755 ${WORKDIR}/sign_secure_image.sh ${TARGET}/sign_secure_image.sh
-}
-
-addtask do_install after do_transform_template
diff --git a/recipes-devtools/ebg-secure-boot-secrets/files/README.md b/recipes-devtools/ebg-secure-boot-secrets/files/README.md
deleted file mode 100644
index c739c51..0000000
--- a/recipes-devtools/ebg-secure-boot-secrets/files/README.md
+++ /dev/null
@@ -1 +0,0 @@
-For a secure boot image this directory needs to contain the certdb directory and the db.crt file.
diff --git a/recipes-devtools/ebg-secure-boot-secrets/files/control.tmpl b/recipes-devtools/ebg-secure-boot-secrets/files/control.tmpl
deleted file mode 100644
index 8361a49..0000000
--- a/recipes-devtools/ebg-secure-boot-secrets/files/control.tmpl
+++ /dev/null
@@ -1,12 +0,0 @@
-Source: ${PN}
-Section: misc
-Priority: optional
-Standards-Version: 3.9.6
-Maintainer: ${MAINTAINER}
-Build-Depends: debhelper (>= 9)
-
-Package: ${PN}
-Architecture: ${DPKG_ARCH}
-Depends: ${DEBIAN_DEPENDS}
-Description: ${DESCRIPTION}
-Conflicts: ${DEBIAN_CONFLICTS}
diff --git a/recipes-devtools/ebg-secure-boot-secrets/files/sign_secure_image.sh.tmpl b/recipes-devtools/ebg-secure-boot-secrets/files/sign_secure_image.sh.tmpl
deleted file mode 100644
index e84fd4c..0000000
--- a/recipes-devtools/ebg-secure-boot-secrets/files/sign_secure_image.sh.tmpl
+++ /dev/null
@@ -1,22 +0,0 @@
-#!/bin/sh
-set -e
-set -x
-signee=$1
-signed=$2
-
-usage(){
-    echo "sign with debian snakeoil"
-    echo "$0 signee signed"
-    echo "signee: path to the image to be signed"
-    echo "signed: path to store the signed image"
-}
-
-
-if [ -z "$signee" ] || [ -z "$signed" ]; then
-    usage
-    exit 1
-fi
-
-pesign --force --verbose --padding -n ${SB_CERT_PATH}/${SB_CERTDB} -c "${SB_KEY_NAME}" -s -i $signee -o $signed
-sbverify --cert ${SB_CERT_PATH}/${SB_VERIFY_CERT} $signed
-exit 0
diff --git a/recipes-devtools/ebg-secure-boot-signer/ebg-secure-boot-signer_0.1.bb b/recipes-devtools/ebg-secure-boot-signer/ebg-secure-boot-signer_0.1.bb
new file mode 100644
index 0000000..546fded
--- /dev/null
+++ b/recipes-devtools/ebg-secure-boot-signer/ebg-secure-boot-signer_0.1.bb
@@ -0,0 +1,26 @@
+#
+# CIP Core, generic profile
+#
+# Copyright (c) Siemens AG, 2020-2022
+#
+# Authors:
+#  Quirin Gylstorff <quirin.gylstorff@siemens.com>
+#  Jan Kiszka <jan.kiszka@siemens.com>
+#
+# SPDX-License-Identifier: MIT
+#
+
+inherit dpkg-raw
+
+DESCRIPTION = "Signing script for EFI Boot Guard setups"
+
+DEPENDS = "secure-boot-secrets"
+DEBIAN_DEPENDS = "sbsigntool, secure-boot-secrets"
+
+SRC_URI = "file://sign_secure_image.sh"
+
+do_install() {
+    TARGET=${D}/usr/bin
+    install -d ${TARGET}
+    install -m 755 ${WORKDIR}/sign_secure_image.sh ${TARGET}/sign_secure_image.sh
+}
diff --git a/recipes-devtools/ebg-secure-boot-signer/files/sign_secure_image.sh b/recipes-devtools/ebg-secure-boot-signer/files/sign_secure_image.sh
new file mode 100644
index 0000000..0c9b898
--- /dev/null
+++ b/recipes-devtools/ebg-secure-boot-signer/files/sign_secure_image.sh
@@ -0,0 +1,33 @@
+#!/bin/sh
+#
+# CIP Core, generic profile
+#
+# Copyright (c) Siemens AG, 2020-2022
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
+signed=$2
+
+usage(){
+    echo "sign with image keys"
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
+sbsign --key ${keydir}/secure-boot.key --cert ${keydir}/secure-boot.pem --output $signed $signee
diff --git a/recipes-devtools/ebg-secure-boot-snakeoil/ebg-secure-boot-snakeoil_0.1.bb b/recipes-devtools/ebg-secure-boot-snakeoil/ebg-secure-boot-snakeoil_0.1.bb
deleted file mode 100644
index 4975d92..0000000
--- a/recipes-devtools/ebg-secure-boot-snakeoil/ebg-secure-boot-snakeoil_0.1.bb
+++ /dev/null
@@ -1,34 +0,0 @@
-#
-# CIP Core, generic profile
-#
-# Copyright (c) Siemens AG, 2020
-#
-# Authors:
-#  Quirin Gylstorff <quirin.gylstorff@siemens.com>
-#
-# SPDX-License-Identifier: MIT
-#
-
-inherit dpkg-raw
-
-DESCRIPTION = "Add script to sign for secure boot with the debian snakeoil keys"
-# used to sign the image
-DEBIAN_DEPENDS = "pesign,  sbsigntool, ovmf, openssl, libnss3-tools"
-
-
-# this package cannot be install together with:
-DEBIAN_CONFLICTS = "ebg-secure-boot-secrets"
-
-SRC_URI = "file://sign_secure_image.sh \
-           file://control.tmpl"
-
-TEMPLATE_FILES = "control.tmpl"
-TEMPLATE_VARS += "PN MAINTAINER DPKG_ARCH DEBIAN_DEPENDS DESCRIPTION DEBIAN_CONFLICTS"
-
-do_install() {
-    TARGET=${D}/usr/bin
-    install -d ${TARGET}
-    install -m 755 ${WORKDIR}/sign_secure_image.sh ${TARGET}/sign_secure_image.sh
-}
-
-addtask do_install after do_transform_template
diff --git a/recipes-devtools/ebg-secure-boot-snakeoil/files/control.tmpl b/recipes-devtools/ebg-secure-boot-snakeoil/files/control.tmpl
deleted file mode 100644
index 8361a49..0000000
--- a/recipes-devtools/ebg-secure-boot-snakeoil/files/control.tmpl
+++ /dev/null
@@ -1,12 +0,0 @@
-Source: ${PN}
-Section: misc
-Priority: optional
-Standards-Version: 3.9.6
-Maintainer: ${MAINTAINER}
-Build-Depends: debhelper (>= 9)
-
-Package: ${PN}
-Architecture: ${DPKG_ARCH}
-Depends: ${DEBIAN_DEPENDS}
-Description: ${DESCRIPTION}
-Conflicts: ${DEBIAN_CONFLICTS}
diff --git a/recipes-devtools/ebg-secure-boot-snakeoil/files/sign_secure_image.sh b/recipes-devtools/ebg-secure-boot-snakeoil/files/sign_secure_image.sh
deleted file mode 100644
index 081dbe9..0000000
--- a/recipes-devtools/ebg-secure-boot-snakeoil/files/sign_secure_image.sh
+++ /dev/null
@@ -1,36 +0,0 @@
-#!/bin/sh
-set -e
-set -x
-signee=$1
-signed=$2
-
-usage(){
-    echo "sign with debian snakeoil"
-    echo "$0 signee signed"
-    echo "signee: path to the image to be signed"
-    echo "signed: path to store the signed image"
-}
-
-
-if [ -z "$signee" ] || [ -z "$signed" ]; then
-    usage
-    exit 1
-fi
-
-name=snakeoil
-keydir=$(mktemp -d)
-inkey=/usr/share/ovmf/PkKek-1-snakeoil.key
-incert=/usr/share/ovmf/PkKek-1-snakeoil.pem
-nick_name=snakeoil
-TMP=$(mktemp -d)
-mkdir -p ${keydir}/${name}certdb
-certutil -N --empty-password -d ${keydir}/${name}certdb
-openssl pkcs12 -export -passin pass:"snakeoil" -passout pass: -out ${TMP}/foo_key.p12 -inkey $inkey  -in $incert  -name $nick_name
-pk12util -W "" -i ${TMP}/foo_key.p12 -d ${keydir}/${name}certdb
-cp $incert ${keydir}/$(basename $incert)
-rm -rf $TMP
-
-pesign --force --verbose --padding -n ${keydir}/${name}certdb -c "$nick_name" -s -i $signee -o $signed
-sbverify --cert $incert $signed
-rm -rf $keydir
-exit 0
diff --git a/recipes-devtools/secure-boot-secrets/files/PkKek-1-snakeoil.key b/recipes-devtools/secure-boot-secrets/files/PkKek-1-snakeoil.key
new file mode 100644
index 0000000..193de62
--- /dev/null
+++ b/recipes-devtools/secure-boot-secrets/files/PkKek-1-snakeoil.key
@@ -0,0 +1,27 @@
+-----BEGIN RSA PRIVATE KEY-----
+MIIEowIBAAKCAQEAyIuuXei5qIw+UvavLxPyyNhx0G6Ijuf9SqxVXOpKcQ+l3ZCc
+KQaCLWCH0pbPQj587zVjgMUd4SHgXdVP6awDz8b0NcLgyzF31pHBmmB3z55nv2Jb
+gI56bix9TEHLpoDs4+cWAb2WZPkW8rV/6YR+xVuE8fi9aAWJ7H4dwUhPzU7RBB1d
+Z1wF6Wv3b8nn1jJa5W8I3zOd+tpWczOsqyRnDnFhMiOulGAiFTtmIXv2VReQf7Tx
+rXdqAAs9dcS3qizzNVgY5XpABtmYu1AjyLwwqXZ+blZ2tmUUJicgw3YdCWtlTAtf
+XZDHf+ZzgCNtTvhb2DzpAVmF/H+A8w8lUJZiBQIDAQABAoIBABET/BRZNj5JOyF7
+im2a6Ej8TazvTMfGr8ZFKLvR4+b+6yQUJYhE2p8colRnrVy5z4/bXw7fOm0qol27
+RaPjlyuBiNhvMQ98tfTa0r7fyjQvDCy7JomrGHf7Z+wvijUys3mw+ynIyF7u62pd
+1HfBZb5OzeKBSTfriNRP5R7JlqooDl+O9JVlnvlJIaFe1rX2sQxZ7F8gVINKIJDv
+n7ZZ0o351uIMjKLqwmliULPTjZ2ZeeJqnkB0pFcWZzEf2wAnrrglYRdnn10oNzhB
+6cXMHJeuEOedXECLZtmynRw1dWZK9+Xku1jEAqTWAoI0OIjrfYYzntwe/kab8w/R
+T7ojFGECgYEA9rGhtmSQiim2h+3iGyXNTEQiEOFFL7E8/1ibfWi3vzDhoLARrnH1
+p45DPgnL664xLHXIUl6/wto79Ij/2qA9mp054nVJ4X4AQgq3xCT/57nL0QHfQLaa
+VdzNIoz4jJT3cO0gYcBAK4Bg+dGGQ6ZUrRRt6VkHG/W6fW0D1e7PnEkCgYEA0Bxj
+Jr4ShNXb7J4YDQ24uSwmc2E1IgX5FjHu/JMKCiyIDWQkrxtVdIL9v6+kmYecyxFJ
+S3Qyr3ZqOHqwN1svYuB/CHyKg6dHrzJyZFTj8cr8h0ZKLDu2xZNFxfBIjn5vitSX
+W9q3477oFG/30Ew12Yee4NhDQkaEuB/Ic9+yv90CgYB2y00rLrwnvDSIunXiSs7U
+xg59gG03rSrJb5rYxj+NkvVj0sWA8qGwASLCUidfo69MUJ+ZgsTnCP5MIFjMp9Ni
+jAne0ko0it+G7fBWRNbyeJb8W+FtIUGqzTv/QlFCKU4KlDW+vLxp9lU8l7gHBabK
+/gZ7kwKIZUlbss5hC7Hv+QKBgQCsQBLBKmlhkTEqs9/sTgMrISPiM/8qXg9BE6tf
+WsTgjuM9UjoaxWEBwroMQnDWsqxQV8p2rYKWQEjC3qmj59Fc4bvDZnGvbnGizPpp
+mOniY8SIouEZo4MwHSmPH8auSnBAVJ3C5VF3K7gj0lknCy03E02phNaGsJ+BVq0v
+W2Qz8QKBgEB5RKiwJhgGQA2o+NJKKUUCDM9iBsO1Yy3QwtDWioKKcdAkxdTg3xR+
+XtJdXq6MkCMWM5em3v6GHPceexn81FZTxGBbIMBYNp0Sp4qs/3lK64ln8m5Qttxe
+70HVtrp9HhG5oFJ3fUuLPcYpE2GMgPM9fIbAWh9GZ4GpTLuPRtWg
+-----END RSA PRIVATE KEY-----
diff --git a/recipes-devtools/secure-boot-secrets/files/PkKek-1-snakeoil.pem b/recipes-devtools/secure-boot-secrets/files/PkKek-1-snakeoil.pem
new file mode 100644
index 0000000..dd02a82
--- /dev/null
+++ b/recipes-devtools/secure-boot-secrets/files/PkKek-1-snakeoil.pem
@@ -0,0 +1,21 @@
+-----BEGIN CERTIFICATE-----
+MIIDdzCCAl+gAwIBAgIULTs+L+8XzClMGhAvyFIdsp/PYgUwDQYJKoZIhvcNAQEL
+BQAwSjELMAkGA1UEBhMCVVMxETAPBgNVBAgMCENvbG9yYWRvMRUwEwYDVQQHDAxG
+b3J0IENvbGxpbnMxETAPBgNVBAoMCFNuYWtlT2lsMCAXDTIwMDkwNzE4NDMyMloY
+DzIxMjAwODE0MTg0MzIyWjBKMQswCQYDVQQGEwJVUzERMA8GA1UECAwIQ29sb3Jh
+ZG8xFTATBgNVBAcMDEZvcnQgQ29sbGluczERMA8GA1UECgwIU25ha2VPaWwwggEi
+MA0GCSqGSIb3DQEBAQUAA4IBDwAwggEKAoIBAQDIi65d6LmojD5S9q8vE/LI2HHQ
+boiO5/1KrFVc6kpxD6XdkJwpBoItYIfSls9CPnzvNWOAxR3hIeBd1U/prAPPxvQ1
+wuDLMXfWkcGaYHfPnme/YluAjnpuLH1MQcumgOzj5xYBvZZk+RbytX/phH7FW4Tx
++L1oBYnsfh3BSE/NTtEEHV1nXAXpa/dvyefWMlrlbwjfM5362lZzM6yrJGcOcWEy
+I66UYCIVO2Yhe/ZVF5B/tPGtd2oACz11xLeqLPM1WBjlekAG2Zi7UCPIvDCpdn5u
+Vna2ZRQmJyDDdh0Ja2VMC19dkMd/5nOAI21O+FvYPOkBWYX8f4DzDyVQlmIFAgMB
+AAGjUzBRMB0GA1UdDgQWBBRjuNXuXfh7mi8I3eTboeYGyFTa2zAfBgNVHSMEGDAW
+gBRjuNXuXfh7mi8I3eTboeYGyFTa2zAPBgNVHRMBAf8EBTADAQH/MA0GCSqGSIb3
+DQEBCwUAA4IBAQBW2ckn0APqBnwSiOXCWkMCnvY7K7UOfxAlotEsMFSrkzdEa4IE
+sn0+A3RV/r3HZGqIaE8GMsBqp8UiVIbL5H67dkqvJEke94/7wEUC16JSSOBc0Mac
+HeArDWsL/WIbzKiVcRrmgX+XwJFlsUN5UtR/feTHR08yiy5srSCIJEqli/cTrOxS
+JAgvWPLxcoFhOKf6Mi+nwWdrQEbpXvvv8Jv/qyyz5e/VmTRY0wIVmUjd+Yseu+5M
+3+cpKtlYaawMxVni5RibA0A12fm+i60fGPrkCNhascUrNY+Oppaf/h+QmKOwEM7h
+pqKXyGFQyU6dB6cFBQ/uD5IABUYuEOuL7VFY
+-----END CERTIFICATE-----
diff --git a/recipes-devtools/secure-boot-secrets/secure-boot-key_0.1.bb b/recipes-devtools/secure-boot-secrets/secure-boot-key_0.1.bb
new file mode 100644
index 0000000..e6ef37c
--- /dev/null
+++ b/recipes-devtools/secure-boot-secrets/secure-boot-key_0.1.bb
@@ -0,0 +1,14 @@
+#
+# CIP Core, generic profile
+#
+# Copyright (c) Siemens AG, 2022
+#
+# Authors:
+#  Jan Kiszka <jan.kiszka@siemens.com>
+#
+# SPDX-License-Identifier: MIT
+#
+
+require secure-boot-secrets.inc
+
+DEBIAN_CONFLICTS = "secure-boot-snakeoil"
diff --git a/recipes-devtools/secure-boot-secrets/secure-boot-secrets.inc b/recipes-devtools/secure-boot-secrets/secure-boot-secrets.inc
new file mode 100644
index 0000000..f53435a
--- /dev/null
+++ b/recipes-devtools/secure-boot-secrets/secure-boot-secrets.inc
@@ -0,0 +1,34 @@
+#
+# CIP Core, generic profile
+#
+# Copyright (c) Siemens AG, 2022
+#
+# Authors:
+#  Jan Kiszka <jan.kiszka@siemens.com>
+#
+# SPDX-License-Identifier: MIT
+#
+
+inherit dpkg-raw
+
+PROVIDES += "secure-boot-secrets"
+
+SB_KEY ??= ""
+SB_CERT ??= ""
+
+SRC_URI_append = " ${@ "file://"+d.getVar('SB_KEY') if d.getVar('SB_KEY') else '' }"
+SRC_URI_append = " ${@ "file://"+d.getVar('SB_CERT') if d.getVar('SB_CERT') else '' }"
+
+do_install() {
+    if [ -z ${SB_KEY} ] || [ -z ${SB_CERT} ]; then
+        bbfatal "You must set SB_KEY and SB_CERT and provide the required files as artifacts to this recipe"
+    fi
+    TARGET=${D}/usr/share/secure-boot-secrets
+    install -d -m 0700 ${TARGET}
+    install -m 0700 ${WORKDIR}/${SB_KEY} ${TARGET}/secure-boot.key
+    install -m 0700 ${WORKDIR}/${SB_CERT} ${TARGET}/secure-boot.pem
+}
+
+do_prepare_build_append() {
+    echo "Provides: secure-boot-secrets" >> ${S}/debian/control
+}
diff --git a/recipes-devtools/secure-boot-secrets/secure-boot-snakeoil_0.1.bb b/recipes-devtools/secure-boot-secrets/secure-boot-snakeoil_0.1.bb
new file mode 100644
index 0000000..24a5352
--- /dev/null
+++ b/recipes-devtools/secure-boot-secrets/secure-boot-snakeoil_0.1.bb
@@ -0,0 +1,17 @@
+#
+# CIP Core, generic profile
+#
+# Copyright (c) Siemens AG, 2022
+#
+# Authors:
+#  Jan Kiszka <jan.kiszka@siemens.com>
+#
+# SPDX-License-Identifier: MIT
+#
+
+require secure-boot-secrets.inc
+
+SB_KEY = "PkKek-1-snakeoil.key"
+SB_CERT = "PkKek-1-snakeoil.pem"
+
+DEBIAN_CONFLICTS = "secure-boot-key"
-- 
2.34.1


