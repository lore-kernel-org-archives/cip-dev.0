Return-Path: <SRS0=9foc=AG=lists.cip-project.org=bounce+64572+4826+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A213CC433E0
	for <cip-dev@archiver.kernel.org>; Thu, 25 Jun 2020 14:10:22 +0000 (UTC)
Received: from web01.groups.io (web01.groups.io [66.175.222.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 70FB82065F
	for <cip-dev@archiver.kernel.org>; Thu, 25 Jun 2020 14:10:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.cip-project.org header.i=@lists.cip-project.org header.b="YLbNBojp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 70FB82065F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=siemens.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+4826+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id 0OefYY4521723xnz0OWTcMBL; Thu, 25 Jun 2020 07:10:22 -0700
X-Received: from goliath.siemens.de (goliath.siemens.de [192.35.17.28])
 by mx.groups.io with SMTP id smtpd.web11.11424.1593094220847029782
 for <cip-dev@lists.cip-project.org>;
 Thu, 25 Jun 2020 07:10:21 -0700
X-Received: from mail1.sbs.de (mail1.sbs.de [192.129.41.35])
	by goliath.siemens.de (8.15.2/8.15.2) with ESMTPS id 05PEAId8028516
	(version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <cip-dev@lists.cip-project.org>; Thu, 25 Jun 2020 16:10:19 +0200
X-Received: from md2dvrtc.ad001.siemens.net ([167.87.6.122])
	by mail1.sbs.de (8.15.2/8.15.2) with ESMTP id 05PEAFXY000356;
	Thu, 25 Jun 2020 16:10:18 +0200
From: "Quirin Gylstorff" <quirin.gylstorff@siemens.com>
To: cip-dev@lists.cip-project.org, Jan.Kiszka@siemens.com
Cc: Quirin Gylstorff <quirin.gylstorff@siemens.com>
Subject: [cip-dev] [isar-cip-core RFC 5/7] secure-boot: Add Debian snakeoil keys for ease-of-use
Date: Thu, 25 Jun 2020 16:10:13 +0200
Message-Id: <20200625141015.31719-6-Quirin.Gylstorff@siemens.com>
In-Reply-To: <20200625141015.31719-1-Quirin.Gylstorff@siemens.com>
References: <20200625141015.31719-1-Quirin.Gylstorff@siemens.com>
MIME-Version: 1.0
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: 1nzqdTtRE6wdM12GGcIdreCcx4520388AA=
Content-Type: multipart/mixed; boundary="c3HPWLkN2qLQFWXfWBTF"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1593094222;
 bh=76+PSi2+1htHgZaeEIk0xoMwd3MPXuFzvGiBO+5O/M8=;
 h=Cc:Content-Type:Date:From:Reply-To:Subject:To;
 b=YLbNBojpK9fsDryMsXMAT1yey4qkghWkEu3AJoMpfyOaaNlWmvzUJeNhGD8OMUNOZkf
 RA/YB9roEufnTNRTEgXC54qphrWDZziRe+/ndQUnEsjmd8arwroRqSpPvrdp2G51/6DGR
 dvYirIclJu5zVGMSbfShCQClNEGiDGAWkos=

--c3HPWLkN2qLQFWXfWBTF
Content-Transfer-Encoding: 8bit

From: Quirin Gylstorff <quirin.gylstorff@siemens.com>

Use the Debian snakeoil keys to have a demo case available without
the OVMF setup. Copy the used keys from the build to the deploy
directory to allow usage in non-Debian distributions.

Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
---
 conf/distro/debian-buster-backports.list      |  1 +
 conf/distro/preferences.ovmf-snakeoil.conf    |  3 ++
 kas/opt/ebg-secure-boot-snakeoil.yml          | 31 ++++++++++++++++
 .../ebg-secure-boot-snakeoil_0.1.bb           | 35 ++++++++++++++++++
 .../files/control.tmpl                        | 12 +++++++
 .../files/sign_secure_image.sh                | 36 +++++++++++++++++++
 .../ovmf-binaries/files/control.tmpl          | 11 ++++++
 .../ovmf-binaries/ovmf-binaries_0.1.bb        | 30 ++++++++++++++++
 start-qemu.sh                                 |  4 +--
 9 files changed, 161 insertions(+), 2 deletions(-)
 create mode 100644 conf/distro/debian-buster-backports.list
 create mode 100644 conf/distro/preferences.ovmf-snakeoil.conf
 create mode 100644 kas/opt/ebg-secure-boot-snakeoil.yml
 create mode 100644 recipes-devtools/ebg-secure-boot-snakeoil/ebg-secure-boot-snakeoil_0.1.bb
 create mode 100644 recipes-devtools/ebg-secure-boot-snakeoil/files/control.tmpl
 create mode 100644 recipes-devtools/ebg-secure-boot-snakeoil/files/sign_secure_image.sh
 create mode 100644 recipes-devtools/ovmf-binaries/files/control.tmpl
 create mode 100644 recipes-devtools/ovmf-binaries/ovmf-binaries_0.1.bb

diff --git a/conf/distro/debian-buster-backports.list b/conf/distro/debian-buster-backports.list
new file mode 100644
index 0000000..f2dd104
--- /dev/null
+++ b/conf/distro/debian-buster-backports.list
@@ -0,0 +1 @@
+deb http://ftp.us.debian.org/debian buster-backports main contrib non-free
diff --git a/conf/distro/preferences.ovmf-snakeoil.conf b/conf/distro/preferences.ovmf-snakeoil.conf
new file mode 100644
index 0000000..b51d1d4
--- /dev/null
+++ b/conf/distro/preferences.ovmf-snakeoil.conf
@@ -0,0 +1,3 @@
+Package: ovmf
+Pin: release n=buster-backports
+Pin-Priority: 801
diff --git a/kas/opt/ebg-secure-boot-snakeoil.yml b/kas/opt/ebg-secure-boot-snakeoil.yml
new file mode 100644
index 0000000..1cc483c
--- /dev/null
+++ b/kas/opt/ebg-secure-boot-snakeoil.yml
@@ -0,0 +1,31 @@
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
+header:
+  version: 8
+  includes:
+   - ebg-secure-boot-base.yml
+
+local_conf_header:
+  secure-boot: |
+    # avoid warning of ebg-secure-boot-secrets recipe
+    SB_CERTDB = "/dev/null"
+    SB_VERIFY_CERT = "/dev/null"
+    SB_KEY_NAME = "/dev/null"
+
+    # Add snakeoil and ovmf binaries for qemu
+    IMAGER_BUILD_DEPS += "ebg-secure-boot-snakeoil ovmf-binaries"
+    IMAGER_INSTALL += "ebg-secure-boot-snakeoil"
+
+  ovmf: |
+    # snakeoil certs are only part of backports
+    DISTRO_APT_SOURCES_append = " conf/distro/debian-buster-backports.list"
+    DISTRO_APT_PREFERENCES_append = " conf/distro/preferences.ovmf-snakeoil.conf"
diff --git a/recipes-devtools/ebg-secure-boot-snakeoil/ebg-secure-boot-snakeoil_0.1.bb b/recipes-devtools/ebg-secure-boot-snakeoil/ebg-secure-boot-snakeoil_0.1.bb
new file mode 100644
index 0000000..89abbcf
--- /dev/null
+++ b/recipes-devtools/ebg-secure-boot-snakeoil/ebg-secure-boot-snakeoil_0.1.bb
@@ -0,0 +1,35 @@
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
+DESCRIPTION = "Add script to sign for secure boot with the debian snakeoil keys"
+# used to sign the image
+DEBIAN_DEPENDS = "pesign,  sbsigntool, ovmf, openssl, libnss3-tools"
+
+
+# this package cannot be install together with:
+DEBIAN_CONFLICTS = "ebg-secure-boot-secrets"
+
+SRC_URI = "file://sign_secure_image.sh \
+           file://control.tmpl"
+
+TEMPLATE_FILES = "control.tmpl"
+TEMPLATE_VARS += "PN MAINTAINER DPKG_ARCH DEBIAN_DEPENDS DESCRIPTION DEBIAN_CONFLICTS"
+
+do_install() {
+    TARGET=${D}/usr/bin
+    install -d ${TARGET}
+    install -m 755 ${WORKDIR}/sign_secure_image.sh ${TARGET}/sign_secure_image.sh
+}
+
+addtask do_install after do_transform_template
+
diff --git a/recipes-devtools/ebg-secure-boot-snakeoil/files/control.tmpl b/recipes-devtools/ebg-secure-boot-snakeoil/files/control.tmpl
new file mode 100644
index 0000000..8361a49
--- /dev/null
+++ b/recipes-devtools/ebg-secure-boot-snakeoil/files/control.tmpl
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
diff --git a/recipes-devtools/ebg-secure-boot-snakeoil/files/sign_secure_image.sh b/recipes-devtools/ebg-secure-boot-snakeoil/files/sign_secure_image.sh
new file mode 100644
index 0000000..081dbe9
--- /dev/null
+++ b/recipes-devtools/ebg-secure-boot-snakeoil/files/sign_secure_image.sh
@@ -0,0 +1,36 @@
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
+name=snakeoil
+keydir=$(mktemp -d)
+inkey=/usr/share/ovmf/PkKek-1-snakeoil.key
+incert=/usr/share/ovmf/PkKek-1-snakeoil.pem
+nick_name=snakeoil
+TMP=$(mktemp -d)
+mkdir -p ${keydir}/${name}certdb
+certutil -N --empty-password -d ${keydir}/${name}certdb
+openssl pkcs12 -export -passin pass:"snakeoil" -passout pass: -out ${TMP}/foo_key.p12 -inkey $inkey  -in $incert  -name $nick_name
+pk12util -W "" -i ${TMP}/foo_key.p12 -d ${keydir}/${name}certdb
+cp $incert ${keydir}/$(basename $incert)
+rm -rf $TMP
+
+pesign --force --verbose --padding -n ${keydir}/${name}certdb -c "$nick_name" -s -i $signee -o $signed
+sbverify --cert $incert $signed
+rm -rf $keydir
+exit 0
diff --git a/recipes-devtools/ovmf-binaries/files/control.tmpl b/recipes-devtools/ovmf-binaries/files/control.tmpl
new file mode 100644
index 0000000..54641d6
--- /dev/null
+++ b/recipes-devtools/ovmf-binaries/files/control.tmpl
@@ -0,0 +1,11 @@
+Source: ${PN}
+Section: misc
+Priority: optional
+Standards-Version: 3.9.6
+Maintainer: ${MAINTAINER}
+Build-Depends: debhelper (>= 9), ${DEBIAN_BUILD_DEPENDS}
+
+Package: ${PN}
+Architecture: ${DPKG_ARCH}
+Depends: ${DEBIAN_DEPENDS}
+Description: ${DESCRIPTION}
diff --git a/recipes-devtools/ovmf-binaries/ovmf-binaries_0.1.bb b/recipes-devtools/ovmf-binaries/ovmf-binaries_0.1.bb
new file mode 100644
index 0000000..025b970
--- /dev/null
+++ b/recipes-devtools/ovmf-binaries/ovmf-binaries_0.1.bb
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
+
+inherit dpkg-raw
+
+DESCRIPTION = "Copy the OVMF biniaries from the build changeroot to the deploy dir"
+
+# this is a empty debian package
+SRC_URI = "file://control.tmpl"
+
+DEBIAN_BUILD_DEPENDS = "ovmf"
+TEMPLATE_FILES = "control.tmpl"
+TEMPLATE_VARS += "PN DEBIAN_DEPENDS MAINTAINER DESCRIPTION DPKG_ARCH DEBIAN_BUILD_DEPENDS"
+
+
+do_extract_ovmf() {
+    install -m 0755 -d ${DEPLOY_DIR_IMAGE}
+    cp -r ${BUILDCHROOT_DIR}/usr/share/OVMF ${DEPLOY_DIR_IMAGE}
+    chown $(id -u):$(id -g) ${DEPLOY_DIR_IMAGE}/OVMF
+}
+
+addtask do_extract_ovmf after do_install_builddeps before do_dpkg_build
diff --git a/start-qemu.sh b/start-qemu.sh
index 74d1b54..3a3b2f7 100755
--- a/start-qemu.sh
+++ b/start-qemu.sh
@@ -94,8 +94,8 @@ fi
 
 
 if [ -n "SECURE_BOOT" ]; then
-		ovmf_code=${OVMF_CODE:-/usr/share/OVMF/OVMF_CODE.secboot.fd}
-		ovmf_vars=${OVMF_VARS:-./OVMF_VARS.fd}
+		ovmf_code=${OVMF_CODE:-./build/tmp/deploy/images/qemu-amd64/OVMF/OVMF_CODE.secboot.fd}
+		ovmf_vars=${OVMF_VARS:-./build/tmp/deploy/images/qemu-amd64/OVMF/OVMF_VARS.snakeoil.fd}
 		QEMU_EXTRA_ARGS=" \
 										${QEMU_EXTRA_ARGS} \
 										-global ICH9-LPC.disable_s3=1 \
-- 
2.20.1


--c3HPWLkN2qLQFWXfWBTF
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.

View/Reply Online (#4826): https://lists.cip-project.org/g/cip-dev/message=
/4826
Mute This Topic: https://lists.cip-project.org/mt/75103452/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy  [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-

--c3HPWLkN2qLQFWXfWBTF--
