Return-Path: <quirin.gylstorff@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04643C4332F
	for <webhook@archiver.kernel.org>; Thu,  3 Nov 2022 08:36:51 +0000 (UTC)
Received: from mta-64-227.siemens.flowmailer.net (mta-64-227.siemens.flowmailer.net [185.136.64.227])
 by mx.groups.io with SMTP id smtpd.web12.17087.1667464607772600412
 for <cip-dev@lists.cip-project.org>;
 Thu, 03 Nov 2022 01:36:48 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=Quirin.Gylstorff@siemens.com header.s=fm1 header.b=YRDoo28z;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.64.227, mailfrom: fm-51332-202211030836446c33d67abf99235232-kr1qep@rts-flowmailer.siemens.com)
Received: by mta-64-227.siemens.flowmailer.net with ESMTPSA id 202211030836446c33d67abf99235232
        for <cip-dev@lists.cip-project.org>;
        Thu, 03 Nov 2022 09:36:45 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=Quirin.Gylstorff@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding;
 bh=9chlefSec6JviJgnX2d5tox0ac0qlRCuHtG2FnPYuXc=;
 b=YRDoo28zICuf8exYfr5us7ucdkPQEv2XITCHRjQ0o2hiFBskT5ED1qPLa7sZvZlvBMfOL5
 DIBRHhXczyDIq27juoMygWyl61YFwHwNVWlivs835H8BbA+qOwieiFMJ4PCxGq6welvmZlgq
 ss8mCk4dJvT7nXmuGvWlJzXdyVjXs=;
From: Quirin Gylstorff <Quirin.Gylstorff@siemens.com>
To: felix.moessbauer@siemens.com,
	jan.kiszka@siemens.com,
	cip-dev@lists.cip-project.org
Subject: [cip-dev][isar-cip-core][PATCH] efibootguard: Adapt installation to Debian upstream
Date: Thu,  3 Nov 2022 09:36:43 +0100
Message-Id: <20221103083643.14912-1-Quirin.Gylstorff@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-51332:519-21489:flowmailer
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 03 Nov 2022 08:36:51 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/9903

From: Quirin Gylstorff <quirin.gylstorff@siemens.com>

This allows using the Debian upstream version of efibootguard
in place.

Also add the new libebgenv to the installation.
This fixes the missing library from issue #47[1].

[1]: https://gitlab.com/cip-project/cip-core/isar-cip-core/-/issues/47

Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
---
 recipes-bsp/efibootguard/efibootguard_0.12.bb        |  2 +-
 .../efibootguard/files/debian/efibootguard.install   | 12 +++++-------
 recipes-bsp/efibootguard/files/debian/rules          | 10 ++--------
 scripts/lib/wic/plugins/source/efibootguard-boot.py  | 12 ++++++++++--
 scripts/lib/wic/plugins/source/efibootguard-efi.py   | 12 ++++++++++--
 5 files changed, 28 insertions(+), 20 deletions(-)
 mode change 100755 => 100644 recipes-bsp/efibootguard/files/debian/efibootguard.install

diff --git a/recipes-bsp/efibootguard/efibootguard_0.12.bb b/recipes-bsp/efibootguard/efibootguard_0.12.bb
index 88dc2ed..721b9dc 100644
--- a/recipes-bsp/efibootguard/efibootguard_0.12.bb
+++ b/recipes-bsp/efibootguard/efibootguard_0.12.bb
@@ -26,7 +26,7 @@ PROVIDES = "${PN}"
 PROVIDES += "${PN}-dev"
 
 DEPENDS = "python3-shtab"
-BUILD_DEB_DEPENDS = "dh-exec,autoconf-archive,gnu-efi,libpci-dev,check,pkg-config,python3-shtab"
+BUILD_DEB_DEPENDS = "debhelper,autoconf-archive,check,gnu-efi,libpci-dev,pkg-config,python3-shtab,zlib1g-dev"
 BUILD_DEB_DEPENDS_append_amd64 = ",libc6-dev-i386"
 BUILD_DEB_DEPENDS_append_i386 = ",libc6-dev-i386"
 
diff --git a/recipes-bsp/efibootguard/files/debian/efibootguard.install b/recipes-bsp/efibootguard/files/debian/efibootguard.install
old mode 100755
new mode 100644
index d3ea007..01cf974
--- a/recipes-bsp/efibootguard/files/debian/efibootguard.install
+++ b/recipes-bsp/efibootguard/files/debian/efibootguard.install
@@ -1,7 +1,5 @@
-#!/usr/bin/dh-exec
-bg_setenv usr/bin
-bg_printenv usr/bin
-tools/bg_gen_unified_kernel usr/bin
-*.efi usr/share/efibootguard
-completion/bash/bg_printenv.bash => usr/share/bash-completion/completions/bg_printenv
-completion/bash/bg_setenv.bash => usr/share/bash-completion/completions/bg_setenv
+usr/bin
+usr/lib/*/efibootguard/kernel-stub*.efi
+usr/lib/*/efibootguard/efibootguard*.efi
+usr/lib/*/libebgenv.so.0*
+usr/share/efibootguard/completion
diff --git a/recipes-bsp/efibootguard/files/debian/rules b/recipes-bsp/efibootguard/files/debian/rules
index 82e9e0e..9c3b916 100755
--- a/recipes-bsp/efibootguard/files/debian/rules
+++ b/recipes-bsp/efibootguard/files/debian/rules
@@ -1,21 +1,15 @@
 #!/usr/bin/make -f
 export DH_VERBOSE=1
-export DEB_BUILD_OPTIONS=hardening=-stackprotector
-export DPKG_EXPORT_BUILDFLAGS=1
-include /usr/share/dpkg/default.mk
+export DEB_BUILD_MAINT_OPTIONS=hardening=+all,-stackprotector
+include /usr/share/dpkg/pkg-info.mk
 
 override_dh_auto_test:
 	# we do not run the tests; that avoids having to pull the fff submodule
 
-override_dh_auto_install:
-	# install using Debian's .install files rather than
-	# make install in order to have a proper package split.
-
 override_dh_installchangelogs:
 	# we're not interested in changelogs
 
 override_dh_installdocs:
 	# we're not interested in docs
-
 %:
 	dh $@ --with autoreconf
diff --git a/scripts/lib/wic/plugins/source/efibootguard-boot.py b/scripts/lib/wic/plugins/source/efibootguard-boot.py
index f9b232b..3d6b2d7 100644
--- a/scripts/lib/wic/plugins/source/efibootguard-boot.py
+++ b/scripts/lib/wic/plugins/source/efibootguard-boot.py
@@ -187,10 +187,18 @@ class EfibootguardBootPlugin(SourcePlugin):
             "armhf": "arm",
             "i386": "ia32"
         }
+        distro_to_lib_arch = {
+            "amd64": "x86_64-linux-gnu",
+            "arm64": "aarch64-linux-gnu",
+            "armhf": "arm-linux-gnueabihf",
+            "i386": "i386-linux-gnu"
+        }
         rootfs_path = rootfs_dir.get('ROOTFS_DIR')
-        efistub = "{rootfs_path}/usr/share/efibootguard/kernel-stub{efiarch}.efi"\
+        distro_arch = get_bitbake_var("DISTRO_ARCH")
+        efistub = "{rootfs_path}/usr/lib/{libpath}/efibootguard/kernel-stub{efiarch}.efi"\
             .format(rootfs_path=rootfs_path,
-                    efiarch=distro_to_efi_arch[get_bitbake_var("DISTRO_ARCH")])
+                    libpath=distro_to_lib_arch[distro_arch],
+                    efiarch=distro_to_efi_arch[distro_arch])
         uefi_kernel_name = "linux.efi"
         uefi_kernel_file = "{deploy_dir}/{uefi_kernel_name}"\
             .format(deploy_dir=deploy_dir, uefi_kernel_name=uefi_kernel_name)
diff --git a/scripts/lib/wic/plugins/source/efibootguard-efi.py b/scripts/lib/wic/plugins/source/efibootguard-efi.py
index a754ee1..2d16fe3 100644
--- a/scripts/lib/wic/plugins/source/efibootguard-efi.py
+++ b/scripts/lib/wic/plugins/source/efibootguard-efi.py
@@ -59,9 +59,17 @@ class EfibootguardEFIPlugin(SourcePlugin):
             "i386": "ia32"
         }
 
+        distro_to_lib_arch = {
+            "amd64": "x86_64-linux-gnu",
+            "arm64": "aarch64-linux-gnu",
+            "armhf": "arm-linux-gnueabihf",
+            "i386": "i386-linux-gnu"
+        }
+
         distro_arch = get_bitbake_var("DISTRO_ARCH")
-        bootloader = "/usr/share/efibootguard/efibootguard{}.efi".format(
-            distro_to_efi_arch[distro_arch])
+        bootloader = "/usr/lib/{libpath}/efibootguard/efibootguard{efiarch}.efi".format(
+            libpath=distro_to_lib_arch[distro_arch],
+            efiarch=distro_to_efi_arch[distro_arch])
         part_rootfs_dir = "%s/disk/%s.%s" % (cr_workdir,
                                              part.label,
                                              part.lineno)
-- 
2.35.1


