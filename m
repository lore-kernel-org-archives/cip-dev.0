Return-Path: <quirin.gylstorff@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34633C433EF
	for <webhook@archiver.kernel.org>; Mon, 14 Feb 2022 16:25:04 +0000 (UTC)
Received: from mta-64-227.siemens.flowmailer.net
 (mta-64-227.siemens.flowmailer.net [185.136.64.227])
 by mx.groups.io with SMTP id smtpd.web12.36367.1644855902964503410
 for <cip-dev@lists.cip-project.org>;
 Mon, 14 Feb 2022 08:25:03 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=Quirin.Gylstorff@siemens.com header.s=fm1
 header.b=XWbhFUn1;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.64.227,
 mailfrom: fm-51332-202202141624590665daf2bb29ae1e54-qm2ql0@rts-flowmailer.siemens.com)
Received: by mta-64-227.siemens.flowmailer.net with ESMTPSA id
 202202141624590665daf2bb29ae1e54
        for <cip-dev@lists.cip-project.org>;
        Mon, 14 Feb 2022 17:25:00 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=Quirin.Gylstorff@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding;
 bh=VyJNCtRPta8E72XGzvG/2mNsR9rMvdC4Df1uR965Ha8=;
 b=XWbhFUn1q0R4V4gRkQPv4diDwv03wLY48KHdGeqgQCUaCrD/InYWW0LA3WqAVNi13yKjEK
 JxtDx+V5/YOnma858Ccpdokrwqij7nFPXC3rd5rI+BOGyJrCvwimiCkjCkY3FL4DL16pOgAK
 bHATNY4ptYqYlO3/ppp7SNRvJmI+Q=;
From: Quirin.Gylstorff@siemens.com
To: cip-dev@lists.cip-project.org,
	ubely@ilbers.de
Subject: [cip-dev][isar-cip-core][PATCH] efibootguard: Do not copy the efi
 binaries directly into DEPLOY_DIR
Date: Mon, 14 Feb 2022 17:24:58 +0100
Message-Id: <20220214162458.636845-1-Quirin.Gylstorff@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-51332:519-21489:flowmailer
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 14 Feb 2022 16:25:04 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/7598

From: Quirin Gylstorff <quirin.gylstorff@siemens.com>

This allows a rebuild with sstate after `build/tmp` was removed.

This patch makes efibootguardx64.efi binary to be included in .deb package.

Also bg_setenv and efibootguardx64.efi are now used from the wic build change root.

Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
---
 kas/opt/efibootguard.yml                      |  1 +
 .../efibootguard/efibootguard_0.9-git+isar.bb |  5 -----
 .../files/debian/efibootguard.install         |  1 +
 .../files/debian/efibootguard.links           |  1 +
 .../wic/plugins/source/efibootguard-boot.py   |  3 +--
 .../wic/plugins/source/efibootguard-efi.py    | 22 ++++++++++---------
 wic/ebg-signed-bootloader.inc                 |  2 +-
 wic/ebg-sysparts.inc                          |  2 +-
 wic/qemu-amd64-efibootguard-secureboot.wks.in |  2 +-
 9 files changed, 19 insertions(+), 20 deletions(-)
 create mode 100644 recipes-bsp/efibootguard/files/debian/efibootguard.links

diff --git a/kas/opt/efibootguard.yml b/kas/opt/efibootguard.yml
index 75d4ab1..f5f9169 100644
--- a/kas/opt/efibootguard.yml
+++ b/kas/opt/efibootguard.yml
@@ -21,6 +21,7 @@ local_conf_header:
     SWUPDATE_BOOTLOADER = "efibootguard"
 
   efibootguard-wic: |
+    WIC_IMAGER_INSTALL_append = " efibootguard"
     WDOG_TIMEOUT ?= "60"
     WICVARS += "WDOG_TIMEOUT KERNEL_IMAGE INITRD_IMAGE"
     IMAGE_FSTYPES ?= "wic-img"
diff --git a/recipes-bsp/efibootguard/efibootguard_0.9-git+isar.bb b/recipes-bsp/efibootguard/efibootguard_0.9-git+isar.bb
index 2817e5b..171d8d4 100644
--- a/recipes-bsp/efibootguard/efibootguard_0.9-git+isar.bb
+++ b/recipes-bsp/efibootguard/efibootguard_0.9-git+isar.bb
@@ -39,8 +39,3 @@ do_prepare_build() {
     deb_add_changelog
 }
 
-dpkg_runbuild_append() {
-    install -m 0755 -d ${DEPLOY_DIR_IMAGE}
-    install -m 0755 ${S}/efibootguardx64.efi ${DEPLOY_DIR_IMAGE}/bootx64.efi
-    install -m 0755 ${S}/bg_setenv ${DEPLOY_DIR_IMAGE}/bg_setenv
-}
diff --git a/recipes-bsp/efibootguard/files/debian/efibootguard.install b/recipes-bsp/efibootguard/files/debian/efibootguard.install
index 8a8d9d3..0239953 100644
--- a/recipes-bsp/efibootguard/files/debian/efibootguard.install
+++ b/recipes-bsp/efibootguard/files/debian/efibootguard.install
@@ -1,2 +1,3 @@
 bg_setenv usr/bin
 bg_printenv usr/bin
+efibootguardx64.efi usr/share/efibootguard
diff --git a/recipes-bsp/efibootguard/files/debian/efibootguard.links b/recipes-bsp/efibootguard/files/debian/efibootguard.links
new file mode 100644
index 0000000..97bab21
--- /dev/null
+++ b/recipes-bsp/efibootguard/files/debian/efibootguard.links
@@ -0,0 +1 @@
+usr/share/efibootguard/efibootguardx64.efi usr/share/efibootguard/bootx64.efi
diff --git a/scripts/lib/wic/plugins/source/efibootguard-boot.py b/scripts/lib/wic/plugins/source/efibootguard-boot.py
index 882729a..05cef4e 100644
--- a/scripts/lib/wic/plugins/source/efibootguard-boot.py
+++ b/scripts/lib/wic/plugins/source/efibootguard-boot.py
@@ -111,9 +111,8 @@ class EfibootguardBootPlugin(SourcePlugin):
 
         cwd = os.getcwd()
         os.chdir(part_rootfs_dir)
-        config_cmd = '%s/bg_setenv -f . -k "C:%s:%s" %s -r %s -w %s' \
+        config_cmd = '/usr/bin/bg_setenv -f . -k "C:%s:%s" %s -r %s -w %s' \
             % (
-                deploy_dir,
                 part.label.upper(),
                 boot_image,
                 '-a "%s"' % cmdline if cmdline else "",
diff --git a/scripts/lib/wic/plugins/source/efibootguard-efi.py b/scripts/lib/wic/plugins/source/efibootguard-efi.py
index 9eb2353..613a350 100644
--- a/scripts/lib/wic/plugins/source/efibootguard-efi.py
+++ b/scripts/lib/wic/plugins/source/efibootguard-efi.py
@@ -53,9 +53,9 @@ class EfibootguardEFIPlugin(SourcePlugin):
         """
         deploy_dir = get_bitbake_var("DEPLOY_DIR_IMAGE")
         creator.deploy_dir = deploy_dir
-        bootloader_files = source_params.get("bootloader")
+        bootloader_files = source_params.get("files")
         if not bootloader_files:
-            bootloader_files = "bootx64.efi"
+            bootloader_files = "{}/bootx64.efi".format(deploy_dir)
         bootloader_files = bootloader_files.split(' ')
         part_rootfs_dir = "%s/disk/%s.%s" % (cr_workdir,
                                              part.label,
@@ -63,18 +63,19 @@ class EfibootguardEFIPlugin(SourcePlugin):
         create_dir_cmd = "install -d %s/EFI/BOOT" % part_rootfs_dir
         exec_cmd(create_dir_cmd)
 
-        for bootloader in bootloader_files:
-            signed_bootloader = cls._sign_file(bootloader,
-                                               "{}/{}".format(deploy_dir,
-                                                              bootloader
-                                                              ),
+        for bootloader_path in bootloader_files:
+            name = os.path.basename(bootloader_path)
+            signed_bootloader = cls._sign_file(name,
+                                               bootloader_path,
                                                cr_workdir,
                                                source_params)
+            msger.debug("Copy %s to %s",
+                        signed_bootloader, part_rootfs_dir)
             # important the bootloader in deploy_dir is no longer signed
             cp_cmd = "cp %s/%s %s/EFI/BOOT/%s" % (cr_workdir,
-                                                signed_bootloader,
-                                                part_rootfs_dir,
-                                                bootloader)
+                                                  signed_bootloader,
+                                                  part_rootfs_dir,
+                                                  name)
             exec_cmd(cp_cmd, True)
         du_cmd = "du --apparent-size -ks %s" % part_rootfs_dir
         blocks = int(exec_cmd(du_cmd).split()[0])
@@ -113,6 +114,7 @@ class EfibootguardEFIPlugin(SourcePlugin):
     def _sign_file(cls, name, signee, cr_workdir, source_params):
         sign_script = source_params.get("signwith")
         if sign_script and os.path.exists(sign_script):
+            msger.debug("Sign %s to %s", name, cr_workdir)
             work_name = name.replace(".efi", ".signed.efi")
             sign_cmd = "{sign_script} {signee} \
             {cr_workdir}/{work_name}".format(sign_script=sign_script,
diff --git a/wic/ebg-signed-bootloader.inc b/wic/ebg-signed-bootloader.inc
index 667e014..2fd5c0e 100644
--- a/wic/ebg-signed-bootloader.inc
+++ b/wic/ebg-signed-bootloader.inc
@@ -1,2 +1,2 @@
 # EFI partition containing efibootguard bootloader binary
-part --source efibootguard-efi  --ondisk sda --size 16M --extra-space 0 --overhead-factor 1 --label efi   --align 1024 --part-type=EF00 --active --sourceparams "signwith=/usr/bin/sign_secure_image.sh"
+part --source efibootguard-efi  --ondisk sda --size 16M --extra-space 0 --overhead-factor 1 --label efi   --align 1024 --part-type=EF00 --active --sourceparams "files=/usr/share/efibootguard/bootx64.efi,signwith=/usr/bin/sign_secure_image.sh"
diff --git a/wic/ebg-sysparts.inc b/wic/ebg-sysparts.inc
index dea99e8..18c8508 100644
--- a/wic/ebg-sysparts.inc
+++ b/wic/ebg-sysparts.inc
@@ -1,7 +1,7 @@
 # default partition layout EFI Boot Guard usage
 
 # EFI partition containing efibootguard bootloader binary
-part --source efibootguard-efi  --ondisk sda --size 16M --extra-space 0 --overhead-factor 1 --label efi   --align 1024 --part-type=EF00 --active
+part --source efibootguard-efi  --ondisk sda --size 16M --extra-space 0 --overhead-factor 1 --label efi   --align 1024 --part-type=EF00 --active --sourceparams "files=/usr/share/efibootguard/bootx64.efi"
 
 # EFI Boot Guard environment/config partitions plus Kernel files
 part --source efibootguard-boot --ondisk sda --size 32M --extra-space 0 --overhead-factor 1 --label BOOT0 --align 1024 --part-type=0700 --sourceparams "revision=2,root=PARTUUID:fedcba98-7654-3210-cafe-5e0710000001"
diff --git a/wic/qemu-amd64-efibootguard-secureboot.wks.in b/wic/qemu-amd64-efibootguard-secureboot.wks.in
index 81fd4fe..72a6f8c 100644
--- a/wic/qemu-amd64-efibootguard-secureboot.wks.in
+++ b/wic/qemu-amd64-efibootguard-secureboot.wks.in
@@ -1,5 +1,5 @@
 # EFI partition containing efibootguard bootloader binary
-part --source efibootguard-efi  --ondisk sda --size 16M --extra-space 0 --overhead-factor 1 --label efi   --align 1024 --part-type=EF00 --active --sourceparams "signwith=/usr/bin/sign_secure_image.sh"
+include ebg-signed-bootloader.inc
 
 # EFI Boot Guard environment/config partitions plus Kernel files
 part --source efibootguard-boot --ondisk sda --size 32M --extra-space 0 --overhead-factor 1 --label BOOT0 --align 1024 --part-type=0700 --sourceparams "revision=2,unified-kernel=y,signwith=/usr/bin/sign_secure_image.sh"
-- 
2.34.1


