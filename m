Return-Path: <SRS0=8nTD=MA=lists.cip-project.org=bounce+64572+6609+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01857C07E96
	for <cip-dev@archiver.kernel.org>; Thu,  8 Jul 2021 08:32:35 +0000 (UTC)
Received: from mail02.groups.io (mail02.groups.io [66.175.222.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5390C61CDF
	for <cip-dev@archiver.kernel.org>; Thu,  8 Jul 2021 08:32:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5390C61CDF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=siemens.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+6609+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id SzzEYY4521723x0e3oGqjzly; Thu, 08 Jul 2021 01:32:33 -0700
X-Received: from goliath.siemens.de (goliath.siemens.de [192.35.17.28])
 by mx.groups.io with SMTP id smtpd.web08.9177.1625733152705591656
 for <cip-dev@lists.cip-project.org>;
 Thu, 08 Jul 2021 01:32:33 -0700
X-Received: from mail2.sbs.de (mail2.sbs.de [192.129.41.66])
	by goliath.siemens.de (8.15.2/8.15.2) with ESMTPS id 1688WU5v007955
	(version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <cip-dev@lists.cip-project.org>; Thu, 8 Jul 2021 10:32:30 +0200
X-Received: from md2dvrtc.fritz.box ([139.22.43.67])
	by mail2.sbs.de (8.15.2/8.15.2) with ESMTP id 1688WTbI005459;
	Thu, 8 Jul 2021 10:32:29 +0200
From: "Quirin Gylstorff" <quirin.gylstorff@siemens.com>
To: Jan.Kiszka@siemens.com, cip-dev@lists.cip-project.org
Cc: Quirin Gylstorff <quirin.gylstorff@siemens.com>
Subject: [cip-dev][isar-cip-core][PATCH] initramfs-config: Remove dependency to patch
Date: Thu,  8 Jul 2021 10:32:29 +0200
Message-Id: <20210708083229.2259-1-Quirin.Gylstorff@siemens.com>
MIME-Version: 1.0
Precedence: Bulk
List-Unsubscribe: <mailto:cip-dev+unsubscribe@lists.cip-project.org>
List-Subscribe: <mailto:cip-dev+subscribe@lists.cip-project.org>
List-Help: <mailto:cip-dev+help@lists.cip-project.org>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: R7qh74uNFalcFI0Rp1ry2qmcx4520388AA=
Content-Type: multipart/mixed; boundary="YBmw8RD1HiurkcqvCBf9"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1625733153;
 bh=FQNdWS4VR27xiRR7/6TEfpOe411sqqH+9jDzoWNfYB0=;
 h=Cc:Content-Type:Date:From:Reply-To:Subject:To;
 b=Jzpia8G0lwWl/f9Inn77eFrfJN4+aopzcIU4816bWPqGcqatycN21iewAyv/uXEgage
 fY6QKy+jaWSAnpjVzlKRSnKeJbJVIqz2DnixW2ikyu6aNZ9t5YU9Q3xZ4p9/0a34E/jTH
 sBW0F+U4QPLxkVGV4SkYk3Img4OPf01fHZg=

--YBmw8RD1HiurkcqvCBf9
Content-Transfer-Encoding: 8bit

From: Quirin Gylstorff <quirin.gylstorff@siemens.com>

The solution proposed by the patch[1] is not longer necessary.
Remove the patch and rework initramfs-config.

[1]: isar-patches/v7-0001-meta-support-Generate-a-custom-initramfs.patch

Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
---
 ...-support-Generate-a-custom-initramfs.patch | 207 ------------------
 kas-cip.yml                                   |   4 -
 .../initramfs-config/files/postinst           |   6 +
 .../initramfs-config/files/postinst.ext       |   3 -
 .../initramfs-abrootfs-secureboot_0.1.bb      |   9 +-
 5 files changed, 9 insertions(+), 220 deletions(-)
 delete mode 100644 isar-patches/v7-0001-meta-support-Generate-a-custom-initramfs.patch
 create mode 100644 recipes-support/initramfs-config/files/postinst
 delete mode 100644 recipes-support/initramfs-config/files/postinst.ext

diff --git a/isar-patches/v7-0001-meta-support-Generate-a-custom-initramfs.patch b/isar-patches/v7-0001-meta-support-Generate-a-custom-initramfs.patch
deleted file mode 100644
index f8fb28e..0000000
--- a/isar-patches/v7-0001-meta-support-Generate-a-custom-initramfs.patch
+++ /dev/null
@@ -1,207 +0,0 @@
-From 7c85e2e363fd39e60bf5041d02e14e8bd62c1a68 Mon Sep 17 00:00:00 2001
-From: Quirin Gylstorff <quirin.gylstorff@siemens.com>
-Date: Tue, 24 Mar 2020 17:58:08 +0100
-Subject: [PATCH v7 1/3] meta/support: Generate a custom initramfs
-
-This package sets the Parameters for mkinitramfs/update-intramfs
-before it regenerates the initrd.img of debian with a modified version.
-
-Use cases are the remove unnecessary kernel modules to reduce the
-size of the initrd by using the parameters:
-```
-INITRAMFS_MODULES = "list"
-INITRAMFS_MODULE_LIST += "ext4"
-```
-
-Set the boot root during the initrd generation by setting `INITRAMFS_ROOT`.
-
-see also man pages of mkinitramfs and initramfs.conf.
-
-Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
----
- .../initramfs-config/initramfs-config_0.1.bb  |  6 +++
- .../initramfs-config/files/control.tmpl       | 12 +++++
- .../initramfs-config/files/postinst.tmpl      | 50 +++++++++++++++++++
- .../initramfs-config/files/postrm.tmpl        | 41 +++++++++++++++
- .../initramfs-config/initramfs-config.inc     | 32 ++++++++++++
- 5 files changed, 141 insertions(+)
- create mode 100644 meta-isar/recipes-support/initramfs-config/initramfs-config_0.1.bb
- create mode 100644 meta/recipes-support/initramfs-config/files/control.tmpl
- create mode 100644 meta/recipes-support/initramfs-config/files/postinst.tmpl
- create mode 100644 meta/recipes-support/initramfs-config/files/postrm.tmpl
- create mode 100644 meta/recipes-support/initramfs-config/initramfs-config.inc
-
-diff --git a/meta-isar/recipes-support/initramfs-config/initramfs-config_0.1.bb b/meta-isar/recipes-support/initramfs-config/initramfs-config_0.1.bb
-new file mode 100644
-index 0000000..c951e8a
---- /dev/null
-+++ b/meta-isar/recipes-support/initramfs-config/initramfs-config_0.1.bb
-@@ -0,0 +1,6 @@
-+#
-+# Copyright (C) Siemens AG, 2020
-+#
-+# SPDX-License-Identifier: MIT
-+
-+require recipes-support/initramfs-config/initramfs-config.inc
-diff --git a/meta/recipes-support/initramfs-config/files/control.tmpl b/meta/recipes-support/initramfs-config/files/control.tmpl
-new file mode 100644
-index 0000000..66984eb
---- /dev/null
-+++ b/meta/recipes-support/initramfs-config/files/control.tmpl
-@@ -0,0 +1,12 @@
-+Source: ${PN}
-+Section: misc
-+Priority: optional
-+Standards-Version: 3.9.6
-+Maintainer: isar-users <isar-users@googlegroups.com>
-+Build-Depends: debhelper (>= 9)
-+
-+
-+Package: ${PN}
-+Architecture: any
-+Depends: ${shlibs:Depends}, ${misc:Depends}, initramfs-tools-core, ${DEBIAN_DEPENDS}
-+Description: Configuration files for a custom initramfs
-diff --git a/meta/recipes-support/initramfs-config/files/postinst.tmpl b/meta/recipes-support/initramfs-config/files/postinst.tmpl
-new file mode 100644
-index 0000000..e523906
---- /dev/null
-+++ b/meta/recipes-support/initramfs-config/files/postinst.tmpl
-@@ -0,0 +1,50 @@
-+#!/bin/sh
-+# postinst script for initramfs-config
-+#
-+# see: dh_installdeb(1)
-+
-+set -e
-+
-+case "$1" in
-+    configure)
-+        INITRAMFS_CONF=/etc/initramfs-tools/initramfs.conf
-+        if [ -f ${INITRAMFS_CONF} ]; then
-+            sed -i -E 's/(^MODULES=).*/\1${INITRAMFS_MODULES}/' ${INITRAMFS_CONF}
-+            sed -i -E 's/(^BUSYBOX=).*/\1${INITRAMFS_BUSYBOX}/' ${INITRAMFS_CONF}
-+            sed -i -E 's/(^COMPRESS=).*/\1${INITRAMFS_COMPRESS}/' ${INITRAMFS_CONF}
-+            sed -i -E 's/(^KEYMAP=).*/\1${INITRAMFS_KEYMAP}/' ${INITRAMFS_CONF}
-+            sed -i -E 's/(^DEVICE=).*/\1${INITRAMFS_NET_DEVICE}/' ${INITRAMFS_CONF}
-+            sed -i -E 's/(^NFSROOT=).*/\1${INITRAMFS_NFSROOT}/' ${INITRAMFS_CONF}
-+            sed -i -E 's/(^RUNSIZE=).*/\1${INITRAMFS_RUNSIZE}/' ${INITRAMFS_CONF}
-+            if grep -Fxq "ROOT=" "${INITRAMFS_CONF}"; then
-+                sed -i -E 's/(^ROOT=).*/\1${INITRAMFS_ROOT}/' ${INITRAMFS_CONF}
-+            else
-+                sed -i -E "\$aROOT=${INITRAMFS_ROOT}" ${INITRAMFS_CONF}
-+            fi
-+        fi
-+
-+        MODULES_LIST_FILE=/etc/initramfs-tools/modules
-+        if [ -f ${MODULES_LIST_FILE} ]; then
-+            for modname in ${INITRAMFS_MODULE_LIST}; do
-+                if ! grep -Fxq "$modname" "${MODULES_LIST_FILE}"; then
-+                    echo "$modname" >> "${MODULES_LIST_FILE}"
-+                fi
-+            done
-+        fi
-+
-+        update-initramfs -v -u
-+
-+    ;;
-+    abort-upgrade|abort-remove|abort-deconfigure)
-+    ;;
-+
-+    *)
-+        echo "postinst called with unknown argument \`$1'" >&2
-+        exit 1
-+        ;;
-+esac
-+# dh_installdeb will replace this with shell code automatically
-+# generated by other debhelper scripts.
-+#DEBHELPER#
-+
-+exit 0
-diff --git a/meta/recipes-support/initramfs-config/files/postrm.tmpl b/meta/recipes-support/initramfs-config/files/postrm.tmpl
-new file mode 100644
-index 0000000..115d9b6
---- /dev/null
-+++ b/meta/recipes-support/initramfs-config/files/postrm.tmpl
-@@ -0,0 +1,41 @@
-+#!/bin/sh
-+# postrm script for initramfs-config
-+#
-+# see: dh_installdeb(1)
-+
-+set -e
-+
-+case "$1" in
-+    purge|remove|upgrade|failed-upgrade|abort-install|abort-upgrade|disappear)
-+        # back to the debian defaults
-+        INITRAMFS_CONF=/etc/initramfs-tools/initramfs.conf
-+        sed -i -E 's/(^MODULES=).*/\1most/' ${INITRAMFS_CONF}
-+        sed -i -E 's/(^BUSYBOX=).*/\1auto/' ${INITRAMFS_CONF}
-+        sed -i -E 's/(^COMPRESS=).*/\1gzip/' ${INITRAMFS_CONF}
-+        sed -i -E 's/(^KEYMAP=).*/\1n/' ${INITRAMFS_CONF}
-+        sed -i -E 's/(^DEVICE=).*/\1/' ${INITRAMFS_CONF}
-+        sed -i -E 's/(^NFSROOT=).*/\1auto/' ${INITRAMFS_CONF}
-+        sed -i -E 's/(^RUNSIZE=).*/\110%/' ${INITRAMFS_CONF}
-+        sed -i -E 's/(^ROOT=).*//' ${INITRAMFS_CONF}
-+
-+        # remove the added modules
-+        MODULES_LIST_FILE=/etc/initramfs-tools/modules
-+        for modname in ${INITRAMFS_MODULE_LIST}; do
-+            sed -i -E 's/$modname//'
-+        done
-+
-+        update-initramfs -v -u
-+    ;;
-+
-+    *)
-+        echo "postrm called with unknown argument \`$1'" >&2
-+        exit 1
-+        ;;
-+esac
-+
-+# dh_installdeb will replace this with shell code automatically
-+# generated by other debhelper scripts.
-+
-+#DEBHELPER#
-+
-+exit 0
-diff --git a/meta/recipes-support/initramfs-config/initramfs-config.inc b/meta/recipes-support/initramfs-config/initramfs-config.inc
-new file mode 100644
-index 0000000..16049a9
---- /dev/null
-+++ b/meta/recipes-support/initramfs-config/initramfs-config.inc
-@@ -0,0 +1,32 @@
-+# This software is a part of ISAR.
-+# Copyright (C) 2020 Siemens AG
-+#
-+# SPDX-License-Identifier: MIT
-+inherit dpkg-raw
-+inherit template
-+DESCRIPTION = "Recipe to set the initramfs configuration and generate a new ramfs"
-+
-+FILESEXTRAPATHS_prepend := "${FILE_DIRNAME}/files:"
-+
-+SRC_URI = "file://postinst.tmpl \
-+           file://postrm.tmpl \
-+           file://control.tmpl \
-+          "
-+
-+INITRAMFS_MODULES ?= "most"
-+INITRAMFS_BUSYBOX ?= "auto"
-+INITRAMFS_COMPRESS ?= "gzip"
-+INITRAMFS_KEYMAP ?= "n"
-+INITRAMFS_NET_DEVICE ?= ""
-+INITRAMFS_NFSROOT ?= "auto"
-+INITRAMFS_RUNSIZE ?= "10%"
-+INITRAMFS_ROOT ?= ""
-+INITRAMFS_MODULE_LIST ?= ""
-+CREATE_NEW_INITRAMFS ?= "n"
-+KERNEL_PACKAGE = "${@ ("linux-image-" + d.getVar("KERNEL_NAME", True)) if d.getVar("KERNEL_NAME", True) else ""}"
-+DEBIAN_DEPENDS += ", ${KERNEL_PACKAGE}"
-+TEMPLATE_FILES = "postinst.tmpl control.tmpl postrm.tmpl"
-+TEMPLATE_VARS += "INITRAMFS_MODULES INITRAMFS_BUSYBOX INITRAMFS_COMPRESS \
-+                  INITRAMFS_KEYMAP INITRAMFS_NET_DEVICE INITRAMFS_NFSROOT \
-+                  INITRAMFS_RUNSIZE INITRAMFS_ROOT INITRAMFS_MODULE_LIST \
-+                  CREATE_NEW_INITRAMFS DEBIAN_DEPENDS PN"
--- 
-2.20.1
-
diff --git a/kas-cip.yml b/kas-cip.yml
index 8fb9004..8522957 100644
--- a/kas-cip.yml
+++ b/kas-cip.yml
@@ -25,10 +25,6 @@ repos:
     refspec: 03124cca669f50b682336a0bdf4ede5a4238e144
     layers:
       meta:
-    patches:
-      02-initramfs:
-        path: isar-patches/v7-0001-meta-support-Generate-a-custom-initramfs.patch
-        repo: cip-core
 
 bblayers_conf_header:
   standard: |
diff --git a/recipes-support/initramfs-config/files/postinst b/recipes-support/initramfs-config/files/postinst
new file mode 100644
index 0000000..2d4256d
--- /dev/null
+++ b/recipes-support/initramfs-config/files/postinst
@@ -0,0 +1,6 @@
+#!/bin/sh
+
+# patch local script
+patch -s -p0 /usr/share/initramfs-tools/scripts/local /usr/share/secureboot/secure-boot-debian-local.patch
+
+update-initramfs -v -u
diff --git a/recipes-support/initramfs-config/files/postinst.ext b/recipes-support/initramfs-config/files/postinst.ext
deleted file mode 100644
index cdafa74..0000000
--- a/recipes-support/initramfs-config/files/postinst.ext
+++ /dev/null
@@ -1,3 +0,0 @@
-if [ -d /usr/share/secureboot ]; then
-    patch -s -p0 /usr/share/initramfs-tools/scripts/local /usr/share/secureboot/secure-boot-debian-local.patch
-fi
diff --git a/recipes-support/initramfs-config/initramfs-abrootfs-secureboot_0.1.bb b/recipes-support/initramfs-config/initramfs-abrootfs-secureboot_0.1.bb
index f84f76f..4b257fa 100644
--- a/recipes-support/initramfs-config/initramfs-abrootfs-secureboot_0.1.bb
+++ b/recipes-support/initramfs-config/initramfs-abrootfs-secureboot_0.1.bb
@@ -8,24 +8,21 @@
 #
 # SPDX-License-Identifier: MIT
 
-require recipes-support/initramfs-config/initramfs-config.inc
+
+inherit dpkg-raw
 
 DEBIAN_DEPENDS += ", busybox, patch"
 
-SRC_URI += "file://postinst.ext \
+SRC_URI += "file://postinst \
             file://initramfs.lsblk.hook \
             file://initramfs.image_uuid.hook \
             file://secure-boot-debian-local-patch"
 
-INITRAMFS_BUSYBOX = "y"
-
 do_install() {
     # add patch for local to /usr/share/secure boot
     TARGET=${D}/usr/share/secureboot
     install -m 0755 -d ${TARGET}
     install -m 0644 ${WORKDIR}/secure-boot-debian-local-patch ${TARGET}/secure-boot-debian-local.patch
-    # patch postinst
-    sed -i -e '/configure)/r ${WORKDIR}/postinst.ext' ${WORKDIR}/postinst
 
     # add hooks for secure boot
     HOOKS=${D}/etc/initramfs-tools/hooks
-- 
2.20.1


--YBmw8RD1HiurkcqvCBf9
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.
View/Reply Online (#6609): https://lists.cip-project.org/g/cip-dev/message=
/6609
Mute This Topic: https://lists.cip-project.org/mt/84063674/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/4520388=
/727948398/xyzzy [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-


--YBmw8RD1HiurkcqvCBf9--
