Return-Path: <SRS0=4ehI=AG=lists.cip-project.org=bounce+64572+4825+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6433CC433E3
	for <cip-dev@archiver.kernel.org>; Thu, 25 Jun 2020 14:10:22 +0000 (UTC)
Received: from web01.groups.io (web01.groups.io [66.175.222.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 31FC920702
	for <cip-dev@archiver.kernel.org>; Thu, 25 Jun 2020 14:10:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.cip-project.org header.i=@lists.cip-project.org header.b="lp8DUC5w"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 31FC920702
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=siemens.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+4825+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id cHNhYY4521723x6qWW9rcuvm; Thu, 25 Jun 2020 07:10:22 -0700
X-Received: from david.siemens.de (david.siemens.de [192.35.17.14])
 by mx.groups.io with SMTP id smtpd.web10.11412.1593094219834870584
 for <cip-dev@lists.cip-project.org>;
 Thu, 25 Jun 2020 07:10:20 -0700
X-Received: from mail1.sbs.de (mail1.sbs.de [192.129.41.35])
	by david.siemens.de (8.15.2/8.15.2) with ESMTPS id 05PEAIpo021259
	(version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <cip-dev@lists.cip-project.org>; Thu, 25 Jun 2020 16:10:18 +0200
X-Received: from md2dvrtc.ad001.siemens.net ([167.87.6.122])
	by mail1.sbs.de (8.15.2/8.15.2) with ESMTP id 05PEAFXV000356;
	Thu, 25 Jun 2020 16:10:17 +0200
From: "Quirin Gylstorff" <quirin.gylstorff@siemens.com>
To: cip-dev@lists.cip-project.org, Jan.Kiszka@siemens.com
Cc: Quirin Gylstorff <quirin.gylstorff@siemens.com>
Subject: [cip-dev] [isar-cip-core RFC 2/7] isar-patch: Add initramfs-config patch
Date: Thu, 25 Jun 2020 16:10:10 +0200
Message-Id: <20200625141015.31719-3-Quirin.Gylstorff@siemens.com>
In-Reply-To: <20200625141015.31719-1-Quirin.Gylstorff@siemens.com>
References: <20200625141015.31719-1-Quirin.Gylstorff@siemens.com>
MIME-Version: 1.0
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: GmrjX5glofLdSVxW0uYJA8Etx4520388AA=
Content-Type: multipart/mixed; boundary="gshHgSrxGd54L1aJ4IFi"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1593094222;
 bh=3vflx4vKw1L6GPPtx/gFyWFWl0U7K/Hpar3zWjUKe+c=;
 h=Cc:Content-Type:Date:From:Reply-To:Subject:To;
 b=lp8DUC5wItvOX+jnSxGKcKLTgAwNDdi9qw7geEvrAwXNPEif86xkXJ62OyvK6DtfzAX
 k+BMz9BwdQP9697AwwFk/Pdo7zO3xLfJnKV/wZfAwZRwQB9oiVIYJPz5zfwfZYyLNOC0M
 P4a7SAKsZZtzMpfPUOU2Vs+UfH7jYy9OAQQ=

--gshHgSrxGd54L1aJ4IFi
Content-Transfer-Encoding: 8bit

From: Quirin Gylstorff <quirin.gylstorff@siemens.com>

Adapt the initramfs generation to set for example the root device
in the initramfs

Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
---
 ...-support-Generate-a-custom-initramfs.patch | 208 ++++++++++++++++++
 kas/cip.yml                                   |   3 +
 2 files changed, 211 insertions(+)
 create mode 100644 isar-patches/v6-0001-meta-support-Generate-a-custom-initramfs.patch

diff --git a/isar-patches/v6-0001-meta-support-Generate-a-custom-initramfs.patch b/isar-patches/v6-0001-meta-support-Generate-a-custom-initramfs.patch
new file mode 100644
index 0000000..fba2c75
--- /dev/null
+++ b/isar-patches/v6-0001-meta-support-Generate-a-custom-initramfs.patch
@@ -0,0 +1,208 @@
+From a03831a79adc936567e16ab07c59a5704a619668 Mon Sep 17 00:00:00 2001
+From: Quirin Gylstorff <quirin.gylstorff@siemens.com>
+Date: Tue, 24 Mar 2020 17:58:08 +0100
+Subject: [PATCH v6 1/3] meta/support: Generate a custom initramfs
+
+This package sets the Parameters for mkinitramfs/update-intramfs
+before it regenerates the initrd.img of debian with a modified version.
+
+Use cases are the remove unnecessary kernel modules to reduce the
+size of the initrd by using the parameters:
+```
+INITRAMFS_MODULES = "list"
+INITRAMFS_MODULE_LIST += "ext4"
+```
+
+Set the boot root during the initrd generation by setting `INITRAMFS_ROOT`.
+
+see also man pages of mkinitramfs and initramfs.conf.
+
+Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
+---
+ .../initramfs-config/initramfs-config_0.1.bb  |  7 +++
+ .../initramfs-config/files/control.tmpl       | 12 +++++
+ .../initramfs-config/files/postinst.tmpl      | 50 +++++++++++++++++++
+ .../initramfs-config/files/postrm.tmpl        | 41 +++++++++++++++
+ .../initramfs-config/initramfs-config.inc     | 32 ++++++++++++
+ 5 files changed, 142 insertions(+)
+ create mode 100644 meta-isar/recipes-support/initramfs-config/initramfs-config_0.1.bb
+ create mode 100644 meta/recipes-support/initramfs-config/files/control.tmpl
+ create mode 100644 meta/recipes-support/initramfs-config/files/postinst.tmpl
+ create mode 100644 meta/recipes-support/initramfs-config/files/postrm.tmpl
+ create mode 100644 meta/recipes-support/initramfs-config/initramfs-config.inc
+
+diff --git a/meta-isar/recipes-support/initramfs-config/initramfs-config_0.1.bb b/meta-isar/recipes-support/initramfs-config/initramfs-config_0.1.bb
+new file mode 100644
+index 0000000..0eb70d7
+--- /dev/null
++++ b/meta-isar/recipes-support/initramfs-config/initramfs-config_0.1.bb
+@@ -0,0 +1,7 @@
++#
++# Copyright (C) Siemens ag, 2020
++#
++# SPDX-License-Identifier: MIT
++
++require recipes-support/initramfs-config/initramfs-config.inc
++
+diff --git a/meta/recipes-support/initramfs-config/files/control.tmpl b/meta/recipes-support/initramfs-config/files/control.tmpl
+new file mode 100644
+index 0000000..66984eb
+--- /dev/null
++++ b/meta/recipes-support/initramfs-config/files/control.tmpl
+@@ -0,0 +1,12 @@
++Source: ${PN}
++Section: misc
++Priority: optional
++Standards-Version: 3.9.6
++Maintainer: isar-users <isar-users@googlegroups.com>
++Build-Depends: debhelper (>= 9)
++
++
++Package: ${PN}
++Architecture: any
++Depends: ${shlibs:Depends}, ${misc:Depends}, initramfs-tools-core, ${DEBIAN_DEPENDS}
++Description: Configuration files for a custom initramfs
+diff --git a/meta/recipes-support/initramfs-config/files/postinst.tmpl b/meta/recipes-support/initramfs-config/files/postinst.tmpl
+new file mode 100644
+index 0000000..e523906
+--- /dev/null
++++ b/meta/recipes-support/initramfs-config/files/postinst.tmpl
+@@ -0,0 +1,50 @@
++#!/bin/sh
++# postinst script for initramfs-config
++#
++# see: dh_installdeb(1)
++
++set -e
++
++case "$1" in
++    configure)
++        INITRAMFS_CONF=/etc/initramfs-tools/initramfs.conf
++        if [ -f ${INITRAMFS_CONF} ]; then
++            sed -i -E 's/(^MODULES=).*/\1${INITRAMFS_MODULES}/' ${INITRAMFS_CONF}
++            sed -i -E 's/(^BUSYBOX=).*/\1${INITRAMFS_BUSYBOX}/' ${INITRAMFS_CONF}
++            sed -i -E 's/(^COMPRESS=).*/\1${INITRAMFS_COMPRESS}/' ${INITRAMFS_CONF}
++            sed -i -E 's/(^KEYMAP=).*/\1${INITRAMFS_KEYMAP}/' ${INITRAMFS_CONF}
++            sed -i -E 's/(^DEVICE=).*/\1${INITRAMFS_NET_DEVICE}/' ${INITRAMFS_CONF}
++            sed -i -E 's/(^NFSROOT=).*/\1${INITRAMFS_NFSROOT}/' ${INITRAMFS_CONF}
++            sed -i -E 's/(^RUNSIZE=).*/\1${INITRAMFS_RUNSIZE}/' ${INITRAMFS_CONF}
++            if grep -Fxq "ROOT=" "${INITRAMFS_CONF}"; then
++                sed -i -E 's/(^ROOT=).*/\1${INITRAMFS_ROOT}/' ${INITRAMFS_CONF}
++            else
++                sed -i -E "\$aROOT=${INITRAMFS_ROOT}" ${INITRAMFS_CONF}
++            fi
++        fi
++
++        MODULES_LIST_FILE=/etc/initramfs-tools/modules
++        if [ -f ${MODULES_LIST_FILE} ]; then
++            for modname in ${INITRAMFS_MODULE_LIST}; do
++                if ! grep -Fxq "$modname" "${MODULES_LIST_FILE}"; then
++                    echo "$modname" >> "${MODULES_LIST_FILE}"
++                fi
++            done
++        fi
++
++        update-initramfs -v -u
++
++    ;;
++    abort-upgrade|abort-remove|abort-deconfigure)
++    ;;
++
++    *)
++        echo "postinst called with unknown argument \`$1'" >&2
++        exit 1
++        ;;
++esac
++# dh_installdeb will replace this with shell code automatically
++# generated by other debhelper scripts.
++#DEBHELPER#
++
++exit 0
+diff --git a/meta/recipes-support/initramfs-config/files/postrm.tmpl b/meta/recipes-support/initramfs-config/files/postrm.tmpl
+new file mode 100644
+index 0000000..115d9b6
+--- /dev/null
++++ b/meta/recipes-support/initramfs-config/files/postrm.tmpl
+@@ -0,0 +1,41 @@
++#!/bin/sh
++# postrm script for initramfs-config
++#
++# see: dh_installdeb(1)
++
++set -e
++
++case "$1" in
++    purge|remove|upgrade|failed-upgrade|abort-install|abort-upgrade|disappear)
++        # back to the debian defaults
++        INITRAMFS_CONF=/etc/initramfs-tools/initramfs.conf
++        sed -i -E 's/(^MODULES=).*/\1most/' ${INITRAMFS_CONF}
++        sed -i -E 's/(^BUSYBOX=).*/\1auto/' ${INITRAMFS_CONF}
++        sed -i -E 's/(^COMPRESS=).*/\1gzip/' ${INITRAMFS_CONF}
++        sed -i -E 's/(^KEYMAP=).*/\1n/' ${INITRAMFS_CONF}
++        sed -i -E 's/(^DEVICE=).*/\1/' ${INITRAMFS_CONF}
++        sed -i -E 's/(^NFSROOT=).*/\1auto/' ${INITRAMFS_CONF}
++        sed -i -E 's/(^RUNSIZE=).*/\110%/' ${INITRAMFS_CONF}
++        sed -i -E 's/(^ROOT=).*//' ${INITRAMFS_CONF}
++
++        # remove the added modules
++        MODULES_LIST_FILE=/etc/initramfs-tools/modules
++        for modname in ${INITRAMFS_MODULE_LIST}; do
++            sed -i -E 's/$modname//'
++        done
++
++        update-initramfs -v -u
++    ;;
++
++    *)
++        echo "postrm called with unknown argument \`$1'" >&2
++        exit 1
++        ;;
++esac
++
++# dh_installdeb will replace this with shell code automatically
++# generated by other debhelper scripts.
++
++#DEBHELPER#
++
++exit 0
+diff --git a/meta/recipes-support/initramfs-config/initramfs-config.inc b/meta/recipes-support/initramfs-config/initramfs-config.inc
+new file mode 100644
+index 0000000..16049a9
+--- /dev/null
++++ b/meta/recipes-support/initramfs-config/initramfs-config.inc
+@@ -0,0 +1,32 @@
++# This software is a part of ISAR.
++# Copyright (C) 2020 Siemens AG
++#
++# SPDX-License-Identifier: MIT
++inherit dpkg-raw
++inherit template
++DESCRIPTION = "Recipe to set the initramfs configuration and generate a new ramfs"
++
++FILESEXTRAPATHS_prepend := "${FILE_DIRNAME}/files:"
++
++SRC_URI = "file://postinst.tmpl \
++           file://postrm.tmpl \
++           file://control.tmpl \
++          "
++
++INITRAMFS_MODULES ?= "most"
++INITRAMFS_BUSYBOX ?= "auto"
++INITRAMFS_COMPRESS ?= "gzip"
++INITRAMFS_KEYMAP ?= "n"
++INITRAMFS_NET_DEVICE ?= ""
++INITRAMFS_NFSROOT ?= "auto"
++INITRAMFS_RUNSIZE ?= "10%"
++INITRAMFS_ROOT ?= ""
++INITRAMFS_MODULE_LIST ?= ""
++CREATE_NEW_INITRAMFS ?= "n"
++KERNEL_PACKAGE = "${@ ("linux-image-" + d.getVar("KERNEL_NAME", True)) if d.getVar("KERNEL_NAME", True) else ""}"
++DEBIAN_DEPENDS += ", ${KERNEL_PACKAGE}"
++TEMPLATE_FILES = "postinst.tmpl control.tmpl postrm.tmpl"
++TEMPLATE_VARS += "INITRAMFS_MODULES INITRAMFS_BUSYBOX INITRAMFS_COMPRESS \
++                  INITRAMFS_KEYMAP INITRAMFS_NET_DEVICE INITRAMFS_NFSROOT \
++                  INITRAMFS_RUNSIZE INITRAMFS_ROOT INITRAMFS_MODULE_LIST \
++                  CREATE_NEW_INITRAMFS DEBIAN_DEPENDS PN"
+-- 
+2.20.1
+
diff --git a/kas/cip.yml b/kas/cip.yml
index 0da07db..e471aa2 100644
--- a/kas/cip.yml
+++ b/kas/cip.yml
@@ -26,6 +26,9 @@ repos:
       01-libubootenv:
         path: isar-patches/0001-u-boot-add-libubootenv.patch
         repo: cip-core
+      secure-boot:
+        path: isar-patches/v6-0001-meta-support-Generate-a-custom-initramfs.patch
+        repo: cip-core
 
 bblayers_conf_header:
   standard: |
-- 
2.20.1


--gshHgSrxGd54L1aJ4IFi
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.

View/Reply Online (#4825): https://lists.cip-project.org/g/cip-dev/message=
/4825
Mute This Topic: https://lists.cip-project.org/mt/75103451/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy  [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-

--gshHgSrxGd54L1aJ4IFi--
