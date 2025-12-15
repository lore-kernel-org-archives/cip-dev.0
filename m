Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8EECFD5B16F
	for <webhook@archiver.kernel.org>; Mon, 15 Dec 2025 06:26:42 +0000 (UTC)
Received: from mta-65-225.siemens.flowmailer.net (mta-65-225.siemens.flowmailer.net [185.136.65.225])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.42272.1765779992287913291
 for <cip-dev@lists.cip-project.org>;
 Sun, 14 Dec 2025 22:26:33 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=jan.kiszka@siemens.com header.s=fm2 header.b=a768d9lM;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.65.225, mailfrom: fm-294854-20251215062629ca637bf7e600020744-jxivnf@rts-flowmailer.siemens.com)
Received: by mta-65-225.siemens.flowmailer.net with ESMTPSA id 20251215062629ca637bf7e600020744
        for <cip-dev@lists.cip-project.org>;
        Mon, 15 Dec 2025 07:26:29 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm2;
 d=siemens.com; i=jan.kiszka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:References:In-Reply-To;
 bh=zieVm2jmK8J7QlZDJWtIoFAEEWn1A9VEwUlzXgaO0xw=;
 b=a768d9lMx8TdQUnt5jMhhwrvECOi+yBTxNR5JGuvBH0zITuvpxOCekDUU1yemHLR11RiAw
 a3oiTKWcRVVzaqw2fMUzpDaUStBJVRITKGLImWNE9Xp6l+h68EvdwtTWnJ3mSfQns4QG06/q
 pbn2lLmEI5yh+jzmV9A+uL9aAPoOWNuF9dE6bifxx4/wAjrTsCkttjyB3GKuQA0/5GVPEwpv
 QjUVb28ajbgt2v2gnRtqeIQ7wjnLQy08h3EDgyDxj7x8Vfun8RQgAtel4iIj9YfDFE1LZnJY
 NduEVX4uFmfMZN8tbGxMeqMAnOB92RtN+EpQWJN1TIj8MOjt8zlF2+GQ==;
From: Jan Kiszka <jan.kiszka@siemens.com>
To: cip-dev@lists.cip-project.org
Subject: [isar-cip-core][PATCH 3/4] Update isar revision
Date: Mon, 15 Dec 2025 07:26:26 +0100
Message-ID: <7dbf47c1bb5724a492aa067feaf797f4fe84d579.1765779987.git.jan.kiszka@siemens.com>
In-Reply-To: <cover.1765779987.git.jan.kiszka@siemens.com>
References: <cover.1765779987.git.jan.kiszka@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-294854:519-21489:flowmailer
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 15 Dec 2025 06:26:42 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/21030

From: Jan Kiszka <jan.kiszka@siemens.com>

Switching to the latest revision allows to drop one patch. The remaining
one is updated to a version that is currently under second review.

Isar switched several recipe includes to classes, and we adopt the
affected recipes accordingly to avoid deprecation warnings.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 ...custom-built-image-name-to-standard-.patch | 134 ++++++++++++++++++
 ...ling-of-initrd-generation-if-there-i.patch |  39 -----
 ...revious-naming-scheme-in-INITRD_DEPL.patch |  32 -----
 kas-cip.yml                                   |   7 +-
 .../optee-os/optee-os-qemu-arm64_4.8.0.bb     |   3 +-
 .../optee-os-tadevkit-qemu-arm64_4.8.0.bb     |   3 +-
 .../optee-os/optee-os-tadevkit-ti-k3_4.8.0.bb |   3 +-
 recipes-bsp/optee-os/optee-os-ti-k3_4.8.0.bb  |   3 +-
 .../trusted-firmware-a-qemu-arm64_2.13.0.bb   |   3 +-
 .../trusted-firmware-a-ti-k3_2.13.bb          |   2 +-
 recipes-bsp/u-boot/u-boot-common-2025.07.inc  |   2 +-
 .../initramfs-abrootfs-hook_0.3.bb            |   2 +-
 .../initramfs-crypt-hook_0.10.bb              |   2 +-
 .../initramfs-erofs-hook_0.2.bb               |   2 +-
 .../initramfs-factory-reset-hook_0.2.bb       |   3 +-
 .../initramfs-overlay-hook_0.4.bb             |   2 +-
 .../initramfs-squashfs-hook_0.2.bb            |   2 +-
 .../initramfs-verity-hook_0.3.bb              |   2 +-
 recipes-kernel/linux/linux-cip-common.inc     |   3 +-
 19 files changed, 157 insertions(+), 92 deletions(-)
 create mode 100644 isar-patches/0001-initramfs-Align-custom-built-image-name-to-standard-.patch
 delete mode 100644 isar-patches/0001-rootfs-Fix-disabling-of-initrd-generation-if-there-i.patch
 delete mode 100644 isar-patches/0002-rootfs-Restore-previous-naming-scheme-in-INITRD_DEPL.patch

diff --git a/isar-patches/0001-initramfs-Align-custom-built-image-name-to-standard-.patch b/isar-patches/0001-initramfs-Align-custom-built-image-name-to-standard-.patch
new file mode 100644
index 00000000..58618a5c
--- /dev/null
+++ b/isar-patches/0001-initramfs-Align-custom-built-image-name-to-standard-.patch
@@ -0,0 +1,134 @@
+From e52be3bd18187191418ea8b2fdd407e1265b462a Mon Sep 17 00:00:00 2001
+From: Jan Kiszka <jan.kiszka@siemens.com>
+Date: Fri, 12 Dec 2025 17:10:49 +0100
+Subject: [PATCH 1/2] initramfs: Align custom built image name to standard one
+
+As now both standard initramfs as well as custom ones define their
+deployment name via INITRD_DEPLOY_FILE, they also need to use the same
+naming pattern, or things are falling apart, e.g. in downstream layers
+that actually use INITRAMFS_IMAGE_NAME as image name source.
+
+Update the testsuite as well, even in places where the image name is
+self-defined, just to avoid confusion.
+
+Fixes: c3c4e72cbfc4 ("image: introduce IMAGE_INITRD, deprecate INITRD_IMAGE")
+Fixes: 8dbffe075b15 ("RECIPE-API-CHANGELOG: Fix entry for IMAGE_INITRD")
+Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
+---
+ RECIPE-API-CHANGELOG.md                              | 10 +++++++++-
+ meta-isar/recipes-initramfs/images/isar-dracut.bb    |  2 +-
+ meta-isar/recipes-initramfs/images/isar-initramfs.bb |  2 +-
+ meta/classes-recipe/image.bbclass                    |  2 +-
+ meta/classes-recipe/initramfs.bbclass                |  2 +-
+ testsuite/citest.py                                  |  6 +++---
+ 6 files changed, 16 insertions(+), 8 deletions(-)
+
+diff --git a/RECIPE-API-CHANGELOG.md b/RECIPE-API-CHANGELOG.md
+index 6d7c56b9..caeeb6e3 100644
+--- a/RECIPE-API-CHANGELOG.md
++++ b/RECIPE-API-CHANGELOG.md
+@@ -843,7 +843,7 @@ ROOTFS_FEATURE += "no-generate-initrd"
+ 
+ INITRD_IMAGE could be set to the full name of an initrd image to be found in
+ DEPLOY_DIR_IMAGE. Downstream layers had to assume how Isar names its image
+-artifacts (presently adding a ${DISTRO}-${IMAGE}.initrd.img suffix to initrd
++artifacts (presently adding a ${DISTRO}-${IMAGE}-initrd.img suffix to initrd
+ images) and insert the build of their initramfs recipe into the image build
+ pipeline.
+ 
+@@ -919,3 +919,11 @@ The following includes were considered internal and are no longer available:
+ The other original includes still exist and inherit the corresponding new
+ class. However, they issue a warning to perform the recommended conversion
+ because these transitional includes will eventually be dropped.
++
++### Align custom initramfs deployment name to standard initramfs
++
++While `INITRAMFS_IMAGE_NAME` ended on `.initrd.img`, standard initramfs where
++deployed as `-initrd.img`. This caused confusion and is now even breaking at
++several points as `INITRD_DEPLOY_FILE` is supposed to be used as canonical
++source of the filename. Therefore, switch `INITRAMFS_IMAGE_NAME` to the
++`-initrd.img` suffix as well.
+diff --git a/meta-isar/recipes-initramfs/images/isar-dracut.bb b/meta-isar/recipes-initramfs/images/isar-dracut.bb
+index aa55e360..cafffc47 100644
+--- a/meta-isar/recipes-initramfs/images/isar-dracut.bb
++++ b/meta-isar/recipes-initramfs/images/isar-dracut.bb
+@@ -1,6 +1,6 @@
+ # Example of a custom initramfs image recipe.  The image will be deployed to
+ #
+-#   build/tmp/deploy/images/${MACHINE}/isar-initramfs-${DISTRO}-${MACHINE}.initrd.img
++#   build/tmp/deploy/images/${MACHINE}/isar-initramfs-${DISTRO}-${MACHINE}-initrd.img
+ #
+ # This software is a part of ISAR.
+ 
+diff --git a/meta-isar/recipes-initramfs/images/isar-initramfs.bb b/meta-isar/recipes-initramfs/images/isar-initramfs.bb
+index d2a946f7..3d7aa203 100644
+--- a/meta-isar/recipes-initramfs/images/isar-initramfs.bb
++++ b/meta-isar/recipes-initramfs/images/isar-initramfs.bb
+@@ -1,6 +1,6 @@
+ # Example of a custom initramfs image recipe.  The image will be deployed to
+ #
+-#   build/tmp/deploy/images/${MACHINE}/isar-initramfs-${DISTRO}-${MACHINE}.initrd.img
++#   build/tmp/deploy/images/${MACHINE}/isar-initramfs-${DISTRO}-${MACHINE}-initrd.img
+ #
+ # This software is a part of ISAR.
+ 
+diff --git a/meta/classes-recipe/image.bbclass b/meta/classes-recipe/image.bbclass
+index 34e40465..e605bc80 100644
+--- a/meta/classes-recipe/image.bbclass
++++ b/meta/classes-recipe/image.bbclass
+@@ -21,7 +21,7 @@ IMAGE_INSTALL += "${KERNEL_IMAGE_PKG}"
+ # Name of the image including distro&machine names
+ IMAGE_FULLNAME = "${PN}-${DISTRO}-${MACHINE}"
+ 
+-# Deprecated; this would be set to e.g. "${INITRAMFS_RECIPE}-${DISTRO}-${MACHINE}.initrd.img"
++# Deprecated; this would be set to e.g. "${INITRAMFS_RECIPE}-${DISTRO}-${MACHINE}-initrd.img"
+ INITRD_IMAGE ?= ""
+ 
+ # IMAGE_INITRD should be used instead (variables consumed by this image class should
+diff --git a/meta/classes-recipe/initramfs.bbclass b/meta/classes-recipe/initramfs.bbclass
+index cd32899d..04a18d0c 100644
+--- a/meta/classes-recipe/initramfs.bbclass
++++ b/meta/classes-recipe/initramfs.bbclass
+@@ -9,7 +9,7 @@ STAMPCLEAN = "${STAMPS_DIR}/${DISTRO}-${DISTRO_ARCH}/${PN}-${MACHINE}/*-*"
+ INITRAMFS_INSTALL ?= ""
+ INITRAMFS_PREINSTALL ?= ""
+ INITRAMFS_ROOTFS ?= "${WORKDIR}/rootfs"
+-INITRAMFS_IMAGE_NAME = "${INITRAMFS_FULLNAME}.initrd.img"
++INITRAMFS_IMAGE_NAME = "${INITRAMFS_FULLNAME}-initrd.img"
+ INITRAMFS_GENERATOR_PKG ??= "initramfs-tools"
+ INITRD_DEPLOY_FILE = "${INITRAMFS_IMAGE_NAME}"
+ 
+diff --git a/testsuite/citest.py b/testsuite/citest.py
+index 27cc9ff6..76a3df69 100755
+--- a/testsuite/citest.py
++++ b/testsuite/citest.py
+@@ -332,7 +332,7 @@ class InitRdBaseTest(CIBaseTest):
+                                           lines='',
+                                           bb_should_fail=False):
+         mc = f'mc:{machine}-{distro.removeprefix("debian-")}'
+-        initrd_image = f'{initrd}-{distro}-{machine}.initrd.img'
++        initrd_image = f'{initrd}-{distro}-{machine}-initrd.img'
+         initrd_path = os.path.join(self.deploy_dir_image(machine), initrd_image)
+ 
+         # cleansstate if the initrd image was already built/deployed to verify
+@@ -387,7 +387,7 @@ class InitRdTest(InitRdBaseTest):
+         machine = 'qemuamd64'
+ 
+         lines = [
+-            f"INITRD_IMAGE = '{initrd}-{distro}-{machine}.initrd.img'",
++            f"INITRD_IMAGE = '{initrd}-{distro}-{machine}-initrd.img'",
+             f"do_image[depends] += '{initrd}:do_build'"
+         ]
+ 
+@@ -413,7 +413,7 @@ class InitRdTest(InitRdBaseTest):
+         # by specifying an invalid recipe name: bitbake should fail.
+         lines = [
+             "IMAGE_INITRD = 'not-a-valid-initrd-recipe'",
+-            f"INITRD_IMAGE = '{initrd}-debian-bookworm-qemuamd64.initrd.img'"
++            f"INITRD_IMAGE = '{initrd}-debian-bookworm-qemuamd64-initrd.img'"
+         ]
+         self.build_image_with_dependent_initrd('isar-image-ci', initrd, lines=lines,
+                                                bb_should_fail=True)
+-- 
+2.51.0
+
diff --git a/isar-patches/0001-rootfs-Fix-disabling-of-initrd-generation-if-there-i.patch b/isar-patches/0001-rootfs-Fix-disabling-of-initrd-generation-if-there-i.patch
deleted file mode 100644
index 9b8e7a67..00000000
--- a/isar-patches/0001-rootfs-Fix-disabling-of-initrd-generation-if-there-i.patch
+++ /dev/null
@@ -1,39 +0,0 @@
-From 1d31b8e84b8d802b7d2028112b10c7130f671fba Mon Sep 17 00:00:00 2001
-From: Jan Kiszka <jan.kiszka@siemens.com>
-Date: Sat, 29 Nov 2025 15:12:20 +0100
-Subject: [PATCH 1/2] rootfs: Fix disabling of initrd generation if there is a
- custom one
-
-The variable is now called IMAGE_INITRD.
-
-Fixes: c3c4e72cbfc4 ("image: introduce IMAGE_INITRD, deprecate INITRD_IMAGE")
-Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
----
- meta/classes/rootfs.bbclass | 4 ++--
- 1 file changed, 2 insertions(+), 2 deletions(-)
-
-diff --git a/meta/classes/rootfs.bbclass b/meta/classes/rootfs.bbclass
-index 70d4bfb8..eb5645af 100644
---- a/meta/classes/rootfs.bbclass
-+++ b/meta/classes/rootfs.bbclass
-@@ -23,7 +23,7 @@ ROOTFS_INITRAMFS_GENERATOR_CMD = "${@ d.getVar('ROOTFS_INITRAMFS_GENERATOR_CMDLI
- ROOTFS_INITRAMFS_GENERATOR_CMDLINE = "${@ initramfs_generator_cmdline(d)}"
- ROOTFS_BASE_DISTRO ?= "${BASE_DISTRO}"
- 
--INITRD_IMAGE ?= ""
-+IMAGE_INITRD ?= ""
- 
- # Features of the rootfs creation:
- # available features are:
-@@ -33,7 +33,7 @@ INITRD_IMAGE ?= ""
- # 'clean-log-files' - delete log files that are not owned by packages
- # 'populate-systemd-preset' - enable systemd units according to systemd presets
- # 'generate-initrd' - generate debian default initrd
--ROOTFS_FEATURES += "${@ 'generate-initrd' if d.getVar('INITRD_IMAGE') == '' else ''}"
-+ROOTFS_FEATURES += "${@ 'generate-initrd' if d.getVar('IMAGE_INITRD') == '' else ''}"
- 
- ROOTFS_APT_ARGS="install --yes -o Debug::pkgProblemResolver=yes"
- 
--- 
-2.51.0
-
diff --git a/isar-patches/0002-rootfs-Restore-previous-naming-scheme-in-INITRD_DEPL.patch b/isar-patches/0002-rootfs-Restore-previous-naming-scheme-in-INITRD_DEPL.patch
deleted file mode 100644
index 9570597f..00000000
--- a/isar-patches/0002-rootfs-Restore-previous-naming-scheme-in-INITRD_DEPL.patch
+++ /dev/null
@@ -1,32 +0,0 @@
-From 9e64d1bfadc310540be73b08b58db67eef207c66 Mon Sep 17 00:00:00 2001
-From: Jan Kiszka <jan.kiszka@siemens.com>
-Date: Sat, 29 Nov 2025 16:03:24 +0100
-Subject: [PATCH 2/2] rootfs: Restore previous naming scheme in
- INITRD_DEPLOY_FILE
-
-Might have been accidentally changed, specifically as initramfs.bbclass
-was not updated as well, and that broke downstream users of
-INITRD_DEPLOY_FILE via wic.
-
-Fixes: c3c4e72cbfc4 ("image: introduce IMAGE_INITRD, deprecate INITRD_IMAGE")
-Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
----
- meta/classes/image.bbclass | 2 +-
- 1 file changed, 1 insertion(+), 1 deletion(-)
-
-diff --git a/meta/classes/image.bbclass b/meta/classes/image.bbclass
-index b030024f..d367d8c7 100644
---- a/meta/classes/image.bbclass
-+++ b/meta/classes/image.bbclass
-@@ -29,7 +29,7 @@ INITRD_IMAGE ?= ""
- IMAGE_INITRD ?= ""
- 
- # Name of the deployed initrd image
--INITRD_DEPLOY_FILE = "${@ d.getVar('IMAGE_INITRD') or '${PN}' }-${DISTRO}-${MACHINE}-initrd.img"
-+INITRD_DEPLOY_FILE = "${@ d.getVar('IMAGE_INITRD') or '${PN}' }-${DISTRO}-${MACHINE}.initrd.img"
- 
- # Make sure dependent initramfs recipe is built
- do_image[depends] += "${@ '${IMAGE_INITRD}:do_build' if '${IMAGE_INITRD}' else '' }"
--- 
-2.51.0
-
diff --git a/kas-cip.yml b/kas-cip.yml
index 8e26d89b..c3bde909 100644
--- a/kas-cip.yml
+++ b/kas-cip.yml
@@ -22,16 +22,13 @@ repos:
 
   isar:
     url: https://github.com/ilbers/isar.git
-    commit: 2efd5d4ca3b4abf2386fe0089594029becdf2801
+    commit: 0174bd2260f1dec2b40deffa89f8028fca7b1557
     layers:
       meta:
     patches:
       p1:
         repo: cip-core
-        path: isar-patches/0001-rootfs-Fix-disabling-of-initrd-generation-if-there-i.patch
-      p2:
-        repo: cip-core
-        path: isar-patches/0002-rootfs-Restore-previous-naming-scheme-in-INITRD_DEPL.patch
+        path: isar-patches/0001-initramfs-Align-custom-built-image-name-to-standard-.patch
 
 bblayers_conf_header:
   standard: |
diff --git a/recipes-bsp/optee-os/optee-os-qemu-arm64_4.8.0.bb b/recipes-bsp/optee-os/optee-os-qemu-arm64_4.8.0.bb
index 18eec20b..881cbc77 100644
--- a/recipes-bsp/optee-os/optee-os-qemu-arm64_4.8.0.bb
+++ b/recipes-bsp/optee-os/optee-os-qemu-arm64_4.8.0.bb
@@ -9,5 +9,6 @@
 # SPDX-License-Identifier: MIT
 #
 
-require recipes-bsp/optee-os/optee-os-custom.inc
+inherit optee-os
+
 require optee-os-qemu-arm64_${PV}.inc
diff --git a/recipes-bsp/optee-os/optee-os-tadevkit-qemu-arm64_4.8.0.bb b/recipes-bsp/optee-os/optee-os-tadevkit-qemu-arm64_4.8.0.bb
index 252e7bc4..0bd7c22c 100644
--- a/recipes-bsp/optee-os/optee-os-tadevkit-qemu-arm64_4.8.0.bb
+++ b/recipes-bsp/optee-os/optee-os-tadevkit-qemu-arm64_4.8.0.bb
@@ -9,7 +9,8 @@
 # SPDX-License-Identifier: MIT
 #
 
+inherit optee-os-tadevkit
+
 OPTEE_ENABLE_APPS = "0"
 
-require recipes-bsp/optee-os/optee-os-tadevkit-custom.inc
 require optee-os-qemu-arm64_${PV}.inc
diff --git a/recipes-bsp/optee-os/optee-os-tadevkit-ti-k3_4.8.0.bb b/recipes-bsp/optee-os/optee-os-tadevkit-ti-k3_4.8.0.bb
index 6e396fab..158030aa 100644
--- a/recipes-bsp/optee-os/optee-os-tadevkit-ti-k3_4.8.0.bb
+++ b/recipes-bsp/optee-os/optee-os-tadevkit-ti-k3_4.8.0.bb
@@ -7,7 +7,8 @@
 # SPDX-License-Identifier: MIT
 #
 
+inherit optee-os-tadevkit
+
 OPTEE_ENABLE_APPS = "0"
 
-require recipes-bsp/optee-os/optee-os-tadevkit-custom.inc
 require optee-os-ti-k3_${PV}.inc
diff --git a/recipes-bsp/optee-os/optee-os-ti-k3_4.8.0.bb b/recipes-bsp/optee-os/optee-os-ti-k3_4.8.0.bb
index e73a7bf9..82fbd53a 100644
--- a/recipes-bsp/optee-os/optee-os-ti-k3_4.8.0.bb
+++ b/recipes-bsp/optee-os/optee-os-ti-k3_4.8.0.bb
@@ -7,7 +7,8 @@
 # SPDX-License-Identifier: MIT
 #
 
-require recipes-bsp/optee-os/optee-os-custom.inc
+inherit optee-os
+
 require optee-os-ti-k3_${PV}.inc
 
 # StMM integration, required by UEFI auth variable management
diff --git a/recipes-bsp/trusted-firmware-a/trusted-firmware-a-qemu-arm64_2.13.0.bb b/recipes-bsp/trusted-firmware-a/trusted-firmware-a-qemu-arm64_2.13.0.bb
index f2ee44ba..a65f2ac1 100644
--- a/recipes-bsp/trusted-firmware-a/trusted-firmware-a-qemu-arm64_2.13.0.bb
+++ b/recipes-bsp/trusted-firmware-a/trusted-firmware-a-qemu-arm64_2.13.0.bb
@@ -10,8 +10,7 @@
 #
 
 inherit deploy-firmware
-
-require recipes-bsp/trusted-firmware-a/trusted-firmware-a-custom.inc
+inherit trusted-firmware-a
 
 SRC_URI += "https://github.com/TrustedFirmware-A/trusted-firmware-a/archive/refs/tags/v${PV}.tar.gz;downloadfilename=trusted-firmware-a-v${PV}.tar.gz"
 SRC_URI[sha256sum] = "28bc15daeeed000ecd30819ecc4851bf9ffc2d33e1d4553a71985c17f47a999e"
diff --git a/recipes-bsp/trusted-firmware-a/trusted-firmware-a-ti-k3_2.13.bb b/recipes-bsp/trusted-firmware-a/trusted-firmware-a-ti-k3_2.13.bb
index 070b9a5f..89728ec1 100644
--- a/recipes-bsp/trusted-firmware-a/trusted-firmware-a-ti-k3_2.13.bb
+++ b/recipes-bsp/trusted-firmware-a/trusted-firmware-a-ti-k3_2.13.bb
@@ -7,7 +7,7 @@
 # SPDX-License-Identifier: MIT
 #
 
-require recipes-bsp/trusted-firmware-a/trusted-firmware-a-custom.inc
+inherit trusted-firmware-a
 
 SRC_URI += "https://github.com/ARM-software/arm-trusted-firmware/archive/v${PV}.tar.gz;downloadfilename=arm-trusted-firmware-${PV}.tar.gz"
 SRC_URI[sha256sum] = "68333c8be57830e7430d7dd39064826729923d86d6bb7af38d713d4e9d15dcf9"
diff --git a/recipes-bsp/u-boot/u-boot-common-2025.07.inc b/recipes-bsp/u-boot/u-boot-common-2025.07.inc
index 4f0b7d24..ed44bad0 100644
--- a/recipes-bsp/u-boot/u-boot-common-2025.07.inc
+++ b/recipes-bsp/u-boot/u-boot-common-2025.07.inc
@@ -9,7 +9,7 @@
 # SPDX-License-Identifier: MIT
 #
 
-require recipes-bsp/u-boot/u-boot-custom.inc
+inherit u-boot
 
 FILESPATH:append := ":${FILE_DIRNAME}/files"
 
diff --git a/recipes-initramfs/initramfs-abrootfs-hook/initramfs-abrootfs-hook_0.3.bb b/recipes-initramfs/initramfs-abrootfs-hook/initramfs-abrootfs-hook_0.3.bb
index c3ac22e2..3538bcfa 100644
--- a/recipes-initramfs/initramfs-abrootfs-hook/initramfs-abrootfs-hook_0.3.bb
+++ b/recipes-initramfs/initramfs-abrootfs-hook/initramfs-abrootfs-hook_0.3.bb
@@ -9,7 +9,7 @@
 #
 # SPDX-License-Identifier: MIT
 
-require recipes-initramfs/initramfs-hook/hook.inc
+inherit initramfs-hook
 
 RDEPENDS += "initramfs-cip-functions"
 DEBIAN_DEPENDS .= ", util-linux, initramfs-cip-functions"
diff --git a/recipes-initramfs/initramfs-crypt-hook/initramfs-crypt-hook_0.10.bb b/recipes-initramfs/initramfs-crypt-hook/initramfs-crypt-hook_0.10.bb
index 9aaa03b0..e132b9ea 100644
--- a/recipes-initramfs/initramfs-crypt-hook/initramfs-crypt-hook_0.10.bb
+++ b/recipes-initramfs/initramfs-crypt-hook/initramfs-crypt-hook_0.10.bb
@@ -9,7 +9,7 @@
 #
 # SPDX-License-Identifier: MIT
 
-require recipes-initramfs/initramfs-hook/hook.inc
+inherit initramfs-hook
 
 RDEPENDS += "initramfs-cip-functions"
 
diff --git a/recipes-initramfs/initramfs-erofs-hook/initramfs-erofs-hook_0.2.bb b/recipes-initramfs/initramfs-erofs-hook/initramfs-erofs-hook_0.2.bb
index a7dbb673..e4232486 100644
--- a/recipes-initramfs/initramfs-erofs-hook/initramfs-erofs-hook_0.2.bb
+++ b/recipes-initramfs/initramfs-erofs-hook/initramfs-erofs-hook_0.2.bb
@@ -9,6 +9,6 @@
 # SPDX-License-Identifier: MIT
 #
 
-require recipes-initramfs/initramfs-hook/hook.inc
+inherit initramfs-hook
 
 HOOK_ADD_MODULES = "erofs"
diff --git a/recipes-initramfs/initramfs-factory-reset-hook/initramfs-factory-reset-hook_0.2.bb b/recipes-initramfs/initramfs-factory-reset-hook/initramfs-factory-reset-hook_0.2.bb
index 2b343506..30ceb235 100644
--- a/recipes-initramfs/initramfs-factory-reset-hook/initramfs-factory-reset-hook_0.2.bb
+++ b/recipes-initramfs/initramfs-factory-reset-hook/initramfs-factory-reset-hook_0.2.bb
@@ -8,7 +8,8 @@
 #
 # SPDX-License-Identifier: MIT
 
-require recipes-initramfs/initramfs-hook/hook.inc
+inherit initramfs-hook
+
 DESCRIPTION = "Delete the content of the given Devices"
 
 # list of partitions by label
diff --git a/recipes-initramfs/initramfs-overlay-hook/initramfs-overlay-hook_0.4.bb b/recipes-initramfs/initramfs-overlay-hook/initramfs-overlay-hook_0.4.bb
index 35f847b3..4ec382c0 100644
--- a/recipes-initramfs/initramfs-overlay-hook/initramfs-overlay-hook_0.4.bb
+++ b/recipes-initramfs/initramfs-overlay-hook/initramfs-overlay-hook_0.4.bb
@@ -10,7 +10,7 @@
 # SPDX-License-Identifier: MIT
 #
 
-require recipes-initramfs/initramfs-hook/hook.inc
+inherit initramfs-hook
 
 INITRAMFS_OVERLAY_RECOVERY_SCRIPT ??= "overlay_recovery_action.script"
 
diff --git a/recipes-initramfs/initramfs-squashfs-hook/initramfs-squashfs-hook_0.2.bb b/recipes-initramfs/initramfs-squashfs-hook/initramfs-squashfs-hook_0.2.bb
index 4b199834..1f5decce 100644
--- a/recipes-initramfs/initramfs-squashfs-hook/initramfs-squashfs-hook_0.2.bb
+++ b/recipes-initramfs/initramfs-squashfs-hook/initramfs-squashfs-hook_0.2.bb
@@ -9,6 +9,6 @@
 # SPDX-License-Identifier: MIT
 #
 
-require recipes-initramfs/initramfs-hook/hook.inc
+inherit initramfs-hook
 
 HOOK_ADD_MODULES = "squashfs"
diff --git a/recipes-initramfs/initramfs-verity-hook/initramfs-verity-hook_0.3.bb b/recipes-initramfs/initramfs-verity-hook/initramfs-verity-hook_0.3.bb
index 37781c9d..a0ee803d 100644
--- a/recipes-initramfs/initramfs-verity-hook/initramfs-verity-hook_0.3.bb
+++ b/recipes-initramfs/initramfs-verity-hook/initramfs-verity-hook_0.3.bb
@@ -9,7 +9,7 @@
 # SPDX-License-Identifier: MIT
 #
 
-require recipes-initramfs/initramfs-hook/hook.inc
+inherit initramfs-hook
 
 SRC_URI += " \
     file://hook \
diff --git a/recipes-kernel/linux/linux-cip-common.inc b/recipes-kernel/linux/linux-cip-common.inc
index 8200c617..b96adbe6 100644
--- a/recipes-kernel/linux/linux-cip-common.inc
+++ b/recipes-kernel/linux/linux-cip-common.inc
@@ -11,7 +11,8 @@
 
 FILESEXTRAPATHS:prepend := "${FILE_DIRNAME}/files:"
 
-require recipes-kernel/linux/linux-custom.inc
+inherit linux-kernel
+
 require recipes-kernel/linux/cip-kernel-config.inc
 
 SRC_URI += "${@'file://preempt-rt.cfg' if d.getVar('KERNEL_NAME') == 'cip-rt' else ''}"
-- 
2.51.0


