Return-Path: <SRS0=WNfa=AG=lists.cip-project.org=bounce+64572+4817+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 560B1C433E0
	for <cip-dev@archiver.kernel.org>; Thu, 25 Jun 2020 13:21:18 +0000 (UTC)
Received: from web01.groups.io (web01.groups.io [66.175.222.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 25B4220781
	for <cip-dev@archiver.kernel.org>; Thu, 25 Jun 2020 13:21:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.cip-project.org header.i=@lists.cip-project.org header.b="tthNYAHU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 25B4220781
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=siemens.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+4817+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id GGhkYY4521723xBkxEdMW8Qf; Thu, 25 Jun 2020 06:21:17 -0700
X-Received: from goliath.siemens.de (goliath.siemens.de [192.35.17.28])
 by mx.groups.io with SMTP id smtpd.web10.10410.1593091274717689766
 for <cip-dev@lists.cip-project.org>;
 Thu, 25 Jun 2020 06:21:15 -0700
X-Received: from mail2.sbs.de (mail2.sbs.de [192.129.41.66])
	by goliath.siemens.de (8.15.2/8.15.2) with ESMTPS id 05PDLC7a004540
	(version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <cip-dev@lists.cip-project.org>; Thu, 25 Jun 2020 15:21:12 +0200
X-Received: from md2dvrtc.ad001.siemens.net ([167.87.6.122])
	by mail2.sbs.de (8.15.2/8.15.2) with ESMTP id 05PDLB2G002493;
	Thu, 25 Jun 2020 15:21:12 +0200
From: "Quirin Gylstorff" <quirin.gylstorff@siemens.com>
To: cip-dev@lists.cip-project.org, Jan.Kiszka@siemens.com
Cc: Quirin Gylstorff <quirin.gylstorff@siemens.com>
Subject: [cip-dev] [isar-cip-core RFC 1/4] recipes-bsp: Add efibootguard
Date: Thu, 25 Jun 2020 15:21:08 +0200
Message-Id: <20200625132111.16367-2-Quirin.Gylstorff@siemens.com>
In-Reply-To: <20200625132111.16367-1-Quirin.Gylstorff@siemens.com>
References: <20200625132111.16367-1-Quirin.Gylstorff@siemens.com>
MIME-Version: 1.0
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: 5C2Ux942vXILlRTAza6ymiWIx4520388AA=
Content-Type: multipart/mixed; boundary="0n3g947FlECV8AASRFbs"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1593091277;
 bh=BwyB4T/yEN38y5qFm9zAej7m8qKRuxkwdKpiUd+uIK8=;
 h=Cc:Content-Type:Date:From:Reply-To:Subject:To;
 b=tthNYAHUvhr6Z7aBp1lamZFRNLB2ZFQ+Oq2/g5CWThsmYkDo/kRm6BdxBmePrpmImWo
 j6ywMz9VvVxdX4Gbx9sZV7XlfIeMXYLd5ID37fdgZkI5IH8qimiLd0C2K3tAZDKo1SJAV
 RCCEvNYDwLE/hNgGSjHcQndaJGr1BW2Xzh0=

--0n3g947FlECV8AASRFbs
Content-Transfer-Encoding: 8bit

From: Quirin Gylstorff <quirin.gylstorff@siemens.com>

Add the bootloader efibootguard for A/B partition update
on x86 with EFI.

Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
---
 .../efibootguard/efibootguard_0.6-git+isar.bb |  46 +++++
 recipes-bsp/efibootguard/files/debian/compat  |   1 +
 .../efibootguard/files/debian/control.tmpl    |  20 +++
 .../files/debian/efibootguard-dev.install     |   3 +
 .../files/debian/efibootguard.install         |   2 +
 recipes-bsp/efibootguard/files/debian/rules   |  21 +++
 .../wic/plugins/source/efibootguard-boot.py   | 162 ++++++++++++++++++
 .../wic/plugins/source/efibootguard-efi.py    | 102 +++++++++++
 8 files changed, 357 insertions(+)
 create mode 100644 recipes-bsp/efibootguard/efibootguard_0.6-git+isar.bb
 create mode 100644 recipes-bsp/efibootguard/files/debian/compat
 create mode 100644 recipes-bsp/efibootguard/files/debian/control.tmpl
 create mode 100644 recipes-bsp/efibootguard/files/debian/efibootguard-dev.install
 create mode 100644 recipes-bsp/efibootguard/files/debian/efibootguard.install
 create mode 100755 recipes-bsp/efibootguard/files/debian/rules
 create mode 100644 scripts/lib/wic/plugins/source/efibootguard-boot.py
 create mode 100644 scripts/lib/wic/plugins/source/efibootguard-efi.py

diff --git a/recipes-bsp/efibootguard/efibootguard_0.6-git+isar.bb b/recipes-bsp/efibootguard/efibootguard_0.6-git+isar.bb
new file mode 100644
index 0000000..bf8b50d
--- /dev/null
+++ b/recipes-bsp/efibootguard/efibootguard_0.6-git+isar.bb
@@ -0,0 +1,46 @@
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
+DESCRIPTION = "efibootguard boot loader"
+DESCRIPTION_DEV = "efibootguard development library"
+HOMEPAGE = "https://github.com/siemens/efibootguard"
+LICENSE = "GPL-2.0"
+LIC_FILES_CHKSUM = "file://${LAYERDIR_isar}/licenses/COPYING.GPLv2;md5=751419260aa954499f7abaabaa882bbe"
+MAINTAINER = "Jan Kiszka <jan.kiszka@siemens.com>"
+
+SRC_URI = "git://github.com/siemens/efibootguard.git;branch=master;protocol=https \
+           file://debian \
+          "
+
+S = "${WORKDIR}/git"
+
+SRCREV = "85cae10c9411c52208947d63a2287cfd6e81068a"
+
+PROVIDES = "${PN}"
+PROVIDES += "${PN}-dev"
+
+BUILD_DEB_DEPENDS = "gnu-efi,libpci-dev,check,pkg-config,libc6-dev-i386"
+
+inherit dpkg
+
+TEMPLATE_FILES = "debian/control.tmpl"
+TEMPLATE_VARS += "DESCRIPTION_DEV BUILD_DEB_DEPENDS"
+
+do_prepare_build() {
+    cp -R ${WORKDIR}/debian ${S}
+    deb_add_changelog
+}
+
+dpkg_runbuild_append() {
+    install -m 0755 -d ${DEPLOY_DIR_IMAGE}
+    install -m 0755 ${S}/efibootguardx64.efi ${DEPLOY_DIR_IMAGE}/bootx64.efi
+    install -m 0755 ${S}/bg_setenv ${DEPLOY_DIR_IMAGE}/bg_setenv
+}
diff --git a/recipes-bsp/efibootguard/files/debian/compat b/recipes-bsp/efibootguard/files/debian/compat
new file mode 100644
index 0000000..ec63514
--- /dev/null
+++ b/recipes-bsp/efibootguard/files/debian/compat
@@ -0,0 +1 @@
+9
diff --git a/recipes-bsp/efibootguard/files/debian/control.tmpl b/recipes-bsp/efibootguard/files/debian/control.tmpl
new file mode 100644
index 0000000..54b1994
--- /dev/null
+++ b/recipes-bsp/efibootguard/files/debian/control.tmpl
@@ -0,0 +1,20 @@
+Source: ${PN}
+Section: base
+Priority: optional
+Standards-Version: 3.9.6
+Build-Depends: ${BUILD_DEB_DEPENDS}
+Homepage: ${HOMEPAGE}
+Maintainer: ${MAINTAINER}
+
+Package: ${PN}
+Depends: ${shlibs:Depends}
+Section: base
+Architecture: ${DISTRO_ARCH}
+Priority: required
+Description: ${DESCRIPTION}
+
+Package: ${PN}-dev
+Section: base
+Architecture: ${DISTRO_ARCH}
+Priority: optional
+Description: ${DESCRIPTION_DEV}
diff --git a/recipes-bsp/efibootguard/files/debian/efibootguard-dev.install b/recipes-bsp/efibootguard/files/debian/efibootguard-dev.install
new file mode 100644
index 0000000..7b45bd8
--- /dev/null
+++ b/recipes-bsp/efibootguard/files/debian/efibootguard-dev.install
@@ -0,0 +1,3 @@
+include/ebgenv.h usr/include/efibootguard
+libebgenv.a usr/lib/x86_64-linux-gnu
+
diff --git a/recipes-bsp/efibootguard/files/debian/efibootguard.install b/recipes-bsp/efibootguard/files/debian/efibootguard.install
new file mode 100644
index 0000000..8a8d9d3
--- /dev/null
+++ b/recipes-bsp/efibootguard/files/debian/efibootguard.install
@@ -0,0 +1,2 @@
+bg_setenv usr/bin
+bg_printenv usr/bin
diff --git a/recipes-bsp/efibootguard/files/debian/rules b/recipes-bsp/efibootguard/files/debian/rules
new file mode 100755
index 0000000..82e9e0e
--- /dev/null
+++ b/recipes-bsp/efibootguard/files/debian/rules
@@ -0,0 +1,21 @@
+#!/usr/bin/make -f
+export DH_VERBOSE=1
+export DEB_BUILD_OPTIONS=hardening=-stackprotector
+export DPKG_EXPORT_BUILDFLAGS=1
+include /usr/share/dpkg/default.mk
+
+override_dh_auto_test:
+	# we do not run the tests; that avoids having to pull the fff submodule
+
+override_dh_auto_install:
+	# install using Debian's .install files rather than
+	# make install in order to have a proper package split.
+
+override_dh_installchangelogs:
+	# we're not interested in changelogs
+
+override_dh_installdocs:
+	# we're not interested in docs
+
+%:
+	dh $@ --with autoreconf
diff --git a/scripts/lib/wic/plugins/source/efibootguard-boot.py b/scripts/lib/wic/plugins/source/efibootguard-boot.py
new file mode 100644
index 0000000..38d2b2e
--- /dev/null
+++ b/scripts/lib/wic/plugins/source/efibootguard-boot.py
@@ -0,0 +1,162 @@
+# ex:ts=4:sw=4:sts=4:et
+# -*- tab-width: 4; c-basic-offset: 4; indent-tabs-mode: nil -*-
+#
+# Copyright (c) 2014, Intel Corporation.
+# Copyright (c) 2018, Siemens AG.
+# All rights reserved.
+#
+# This program is free software; you can redistribute it and/or modify
+# it under the terms of the GNU General Public License version 2 as
+# published by the Free Software Foundation.
+#
+# This program is distributed in the hope that it will be useful,
+# but WITHOUT ANY WARRANTY; without even the implied warranty of
+# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+# GNU General Public License for more details.
+#
+# You should have received a copy of the GNU General Public License along
+# with this program; if not, write to the Free Software Foundation, Inc.,
+# 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
+#
+# DESCRIPTION
+# This implements the 'efibootguard-boot' source plugin class for 'wic'
+#
+# AUTHORS
+# Tom Zanussi <tom.zanussi (at] linux.intel.com>
+# Claudius Heine <ch (at] denx.de>
+# Andreas Reichel <andreas.reichel.ext (at] siemens.com>
+# Christian Storm <christian.storm (at] siemens.com>
+
+import os
+import fnmatch
+import sys
+import logging
+
+msger = logging.getLogger('wic')
+
+from wic.pluginbase import SourcePlugin
+from wic.utils.misc import exec_cmd, get_bitbake_var, BOOTDD_EXTRA_SPACE
+
+class EfibootguardBootPlugin(SourcePlugin):
+    """
+    Create EFI Boot Guard partition hosting the
+    environment file plus Kernel files.
+    """
+
+    name = 'efibootguard-boot'
+
+    @classmethod
+    def do_prepare_partition(cls, part, source_params, creator, cr_workdir,
+                             oe_builddir, deploy_dir, kernel_dir,
+                             rootfs_dir, native_sysroot):
+        """
+        Called to do the actual content population for a partition, i.e.,
+        populate an EFI Boot Guard environment partition plus Kernel files.
+        """
+
+        kernel_image = get_bitbake_var("KERNEL_IMAGE")
+        if not kernel_image:
+            msger.warning("KERNEL_IMAGE not set. Use default:")
+            kernel_image = "vmlinuz"
+        boot_image = kernel_image
+
+        initrd_image = get_bitbake_var("INITRD_IMAGE")
+        if not initrd_image:
+            msger.warning("INITRD_IMAGE not set\n")
+            initrd_image = "initrd.img"
+        bootloader = creator.ks.bootloader
+
+        deploy_dir = get_bitbake_var("DEPLOY_DIR_IMAGE")
+        if not deploy_dir:
+            msger.error("DEPLOY_DIR_IMAGE not set, exiting\n")
+            sys.exit(1)
+        creator.deploy_dir = deploy_dir
+
+        wdog_timeout = get_bitbake_var("WDOG_TIMEOUT")
+        if not wdog_timeout:
+            msger.error("Specify watchdog timeout for \
+            efibootguard in local.conf with WDOG_TIMEOUT=")
+            exit(1)
+
+
+        boot_files = source_params.get("files", "").split(' ')
+        cmdline = bootloader.append
+        root_dev = source_params.get("root", None)
+        if not root_dev:
+            msger.error("Specify root in source params")
+            exit(1)
+            root_dev = root_dev.replace(":", "=")
+
+        cmdline += " root=%s rw" % root_dev
+        boot_files.append(kernel_image)
+        boot_files.append(initrd_image)
+        cmdline += "initrd=%s" % initrd_image if initrd_image else ""
+
+        part_rootfs_dir = "%s/disk/%s.%s" % (cr_workdir,
+                                             part.label, part.lineno)
+        create_dir_cmd = "install -d %s" % part_rootfs_dir
+        exec_cmd(create_dir_cmd)
+
+        cwd = os.getcwd()
+        os.chdir(part_rootfs_dir)
+        config_cmd = '%s/bg_setenv -f . -k "C:%s:%s" %s -r %s -w %s' \
+            % (
+                deploy_dir,
+                part.label.upper(),
+                boot_image,
+                '-a "%s"' % cmdline if cmdline else "",
+                source_params.get("revision", 1),
+                wdog_timeout
+            )
+        exec_cmd(config_cmd, True)
+        os.chdir(cwd)
+
+        boot_files = list(filter(None, boot_files))
+        for boot_file in boot_files:
+            if os.path.isfile("%s/%s" % (kernel_dir, kernel_image)):
+                install_cmd = "install -m 0644 %s/%s %s/%s" % \
+                    (kernel_dir, boot_file, part_rootfs_dir, boot_file)
+                exec_cmd(install_cmd)
+            else:
+                msger.error("file %s not found in directory %s",
+                            boot_file, kernel_dir)
+                exit(1)
+        cls._create_img(part_rootfs_dir, part, cr_workdir)
+
+    @classmethod
+    def _create_img(cls, part_rootfs_dir, part, cr_workdir):
+            # Write label as utf-16le to EFILABEL file
+        with open("%s/EFILABEL" % part_rootfs_dir, 'wb') as filedescriptor:
+            filedescriptor.write(part.label.upper().encode("utf-16le"))
+
+        du_cmd = "du --apparent-size -ks %s" % part_rootfs_dir
+        blocks = int(exec_cmd(du_cmd).split()[0])
+
+        extra_blocks = part.get_extra_block_count(blocks)
+        if extra_blocks < BOOTDD_EXTRA_SPACE:
+            extra_blocks = BOOTDD_EXTRA_SPACE
+
+        blocks += extra_blocks
+        blocks = blocks + (16 - (blocks % 16))
+
+        msger.debug("Added %d extra blocks to %s to get to %d total blocks",
+                    extra_blocks, part.mountpoint, blocks)
+
+        # dosfs image, created by mkdosfs
+        bootimg = "%s/%s.%s.img" % (cr_workdir, part.label, part.lineno)
+
+        dosfs_cmd = "mkdosfs -F 16 -S 512 -n %s -C %s %d" % \
+            (part.label.upper(), bootimg, blocks)
+        exec_cmd(dosfs_cmd)
+
+        mcopy_cmd = "mcopy -v -i %s -s %s/* ::/" % (bootimg, part_rootfs_dir)
+        exec_cmd(mcopy_cmd, True)
+
+        chmod_cmd = "chmod 644 %s" % bootimg
+        exec_cmd(chmod_cmd)
+
+        du_cmd = "du -Lbks %s" % bootimg
+        bootimg_size = int(exec_cmd(du_cmd).split()[0])
+
+        part.size = bootimg_size
+        part.source_file = bootimg
diff --git a/scripts/lib/wic/plugins/source/efibootguard-efi.py b/scripts/lib/wic/plugins/source/efibootguard-efi.py
new file mode 100644
index 0000000..5ee451f
--- /dev/null
+++ b/scripts/lib/wic/plugins/source/efibootguard-efi.py
@@ -0,0 +1,102 @@
+# ex:ts=4:sw=4:sts=4:et
+# -*- tab-width: 4; c-basic-offset: 4; indent-tabs-mode: nil -*-
+#
+# Copyright (c) 2014, Intel Corporation.
+# Copyright (c) 2018, Siemens AG.
+# All rights reserved.
+#
+# This program is free software; you can redistribute it and/or modify
+# it under the terms of the GNU General Public License version 2 as
+# published by the Free Software Foundation.
+#
+# This program is distributed in the hope that it will be useful,
+# but WITHOUT ANY WARRANTY; without even the implied warranty of
+# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+# GNU General Public License for more details.
+#
+# You should have received a copy of the GNU General Public License along
+# with this program; if not, write to the Free Software Foundation, Inc.,
+# 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
+#
+# DESCRIPTION
+# This implements the 'efibootguard-efi' source plugin class for 'wic'
+#
+# AUTHORS
+# Tom Zanussi <tom.zanussi (at] linux.intel.com>
+# Claudius Heine <ch (at] denx.de>
+# Andreas Reichel <andreas.reichel.ext (at] siemens.com>
+# Christian Storm <christian.storm (at] siemens.com>
+
+import logging
+import os
+
+msger = logging.getLogger('wic')
+
+from wic.pluginbase import SourcePlugin
+from wic.utils.misc import exec_cmd, get_bitbake_var, BOOTDD_EXTRA_SPACE
+
+class EfibootguardEFIPlugin(SourcePlugin):
+    """
+    Create EFI bootloader partition containing the EFI Boot Guard Bootloader.
+    """
+
+    name = 'efibootguard-efi'
+
+    @classmethod
+    def do_prepare_partition(cls, part, source_params, creator, cr_workdir,
+                             oe_builddir, deploy_dir, kernel_dir,
+                             rootfs_dir, native_sysroot):
+        """
+        Called to do the actual content population for a partition, i.e.,
+        populate an EFI boot partition containing the EFI Boot Guard
+        bootloader binary.
+        """
+        deploy_dir = get_bitbake_var("DEPLOY_DIR_IMAGE")
+        creator.deploy_dir = deploy_dir
+        bootloader_files = source_params.get("bootloader")
+        if not bootloader_files:
+            bootloader_files = "bootx64.efi"
+        bootloader_files = bootloader_files.split(' ')
+        part_rootfs_dir = "%s/disk/%s.%s" % (cr_workdir,
+                                             part.label,
+                                             part.lineno)
+        create_dir_cmd = "install -d %s/EFI/BOOT" % part_rootfs_dir
+        exec_cmd(create_dir_cmd)
+
+        for bootloader in bootloader_files:
+            cp_cmd = "cp %s/%s %s/EFI/BOOT/%s" % (deploy_dir,
+                                                  bootloader,
+                                                  part_rootfs_dir,
+                                                  bootloader)
+            exec_cmd(cp_cmd, True)
+        du_cmd = "du --apparent-size -ks %s" % part_rootfs_dir
+        blocks = int(exec_cmd(du_cmd).split()[0])
+
+        extra_blocks = part.get_extra_block_count(blocks)
+        if extra_blocks < BOOTDD_EXTRA_SPACE:
+            extra_blocks = BOOTDD_EXTRA_SPACE
+        blocks += extra_blocks
+        blocks = blocks + (16 - (blocks % 16))
+
+        msger.debug("Added %d extra blocks to %s to get to %d total blocks",
+                    extra_blocks, part.mountpoint, blocks)
+
+        # dosfs image, created by mkdosfs
+        efi_part_image = "%s/%s.%s.img" % (cr_workdir, part.label, part.lineno)
+
+        dosfs_cmd = "mkdosfs -S 512 -n %s -C %s %d" % \
+            (part.label.upper(), efi_part_image, blocks)
+        exec_cmd(dosfs_cmd)
+
+        mcopy_cmd = "mcopy -v -i %s -s %s/* ::/" % \
+            (efi_part_image, part_rootfs_dir)
+        exec_cmd(mcopy_cmd, True)
+
+        chmod_cmd = "chmod 644 %s" % efi_part_image
+        exec_cmd(chmod_cmd)
+
+        du_cmd = "du -Lbks %s" % efi_part_image
+        efi_part_image_size = int(exec_cmd(du_cmd).split()[0])
+
+        part.size = efi_part_image_size
+        part.source_file = efi_part_image
-- 
2.20.1


--0n3g947FlECV8AASRFbs
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.

View/Reply Online (#4817): https://lists.cip-project.org/g/cip-dev/message=
/4817
Mute This Topic: https://lists.cip-project.org/mt/75102473/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy  [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-

--0n3g947FlECV8AASRFbs--
