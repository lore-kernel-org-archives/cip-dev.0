Return-Path: <srinuvasan.a@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 490C6CD5BAD
	for <webhook@archiver.kernel.org>; Thu,  5 Sep 2024 11:45:17 +0000 (UTC)
Received: from mta-65-226.siemens.flowmailer.net (mta-65-226.siemens.flowmailer.net [185.136.65.226])
 by mx.groups.io with SMTP id smtpd.web11.7297.1725536714179887756
 for <cip-dev@lists.cip-project.org>;
 Thu, 05 Sep 2024 04:45:15 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=srinuvasan.a@siemens.com header.s=fm1 header.b=cGyeSfGI;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.65.226, mailfrom: fm-1324425-202409051145108f9b28a4394756a5cf-bovged@rts-flowmailer.siemens.com)
Received: by mta-65-226.siemens.flowmailer.net with ESMTPSA id 202409051145108f9b28a4394756a5cf
        for <cip-dev@lists.cip-project.org>;
        Thu, 05 Sep 2024 13:45:11 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=srinuvasan.a@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=yMUtIhJvDhOKE6tttHeh8tI98DxkYum6CYvoWwfAk0w=;
 b=cGyeSfGI0zKt7xsR5vcaamnKXWeJRasnLXEZVskrZ087atmTiOA1bW0mCl+0y9D3XkJC9F
 hn+bLF9cZ/sseequ3mDt6gE7eq1O0/lTHgIGBCeOqgeGobA88bO12HLkP0jLoc37Hwwa4jVQ
 KcskFucgCWmEKh4zvKR6HWiaUs+IJeRcD2SNyks1ii+TaEnwKcp5lrGAZOrMi0TD0rlTCfCQ
 Nes5/mc+om/z3myOWTtu7om/5DmS+NhpKKotCXO/JWmTA/fCkrq/8PVOFevwwIMsOyE5eq0E
 zOuwMTqSX0lmAA4gIQobojNfdPD7fvQoCe/ovYKYm7zSrtqYfh9wPH+Q==;
From: srinuvasan.a@siemens.com
To: cip-dev@lists.cip-project.org
Cc: quirin.gylstorff@siemens.com,
	jan.kiszka@siemens.com,
	srinuvasan <srinuvasan.a@siemens.com>
Subject: [PATCH v1][isar-cip-core] scripts/lib/wic/plugins/source: Use F-string instead of traditional .format() and modulo(%) methods
Date: Thu,  5 Sep 2024 17:15:29 +0530
Message-Id: <20240905114529.876340-1-srinuvasan.a@siemens.com>
In-Reply-To: <f7a92fdc-894c-417e-b999-16f0c3b1c405@siemens.com>
References: <f7a92fdc-894c-417e-b999-16f0c3b1c405@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-1324425:519-21489:flowmailer
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 05 Sep 2024 11:45:17 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/16851

From: srinuvasan <srinuvasan.a@siemens.com>

Use f string for string interpolation and formatting instead of traditional .format() and modulo (%)
method.

f-strings are generally preferred due to their readability,simplicity and efficiency,
and moreover there is no functional changes apart from the optimization.

Signed-off-by: srinuvasan <srinuvasan.a@siemens.com>
---
 .../wic/plugins/source/efibootguard-boot.py   | 62 ++++++-------------
 .../wic/plugins/source/efibootguard-efi.py    | 37 +++--------
 2 files changed, 29 insertions(+), 70 deletions(-)

diff --git a/scripts/lib/wic/plugins/source/efibootguard-boot.py b/scripts/lib/wic/plugins/source/efibootguard-boot.py
index 2b06fd1..079fef5 100644
--- a/scripts/lib/wic/plugins/source/efibootguard-boot.py
+++ b/scripts/lib/wic/plugins/source/efibootguard-boot.py
@@ -103,34 +103,26 @@ class EfibootguardBootPlugin(SourcePlugin):
                 exit(1)
             root_dev = root_dev.replace(":", "=")
 
-            cmdline += " root=%s rw " % root_dev
+            cmdline += f' root={root_dev} rw'
             boot_files.append(kernel_image)
             boot_files.append(initrd_image)
-            cmdline += "initrd=%s" % initrd_image if initrd_image else ""
+            cmdline += f'initrd={initrd_image}' if initrd_image else ""
 
-        part_rootfs_dir = "%s/disk/%s.%s" % (cr_workdir,
-                                             part.label, part.lineno)
-        create_dir_cmd = "install -d %s" % part_rootfs_dir
+        part_rootfs_dir = f'{cr_workdir}/disk/{part.label}.{part.lineno}'
+        create_dir_cmd = f'install -d {part_rootfs_dir}'
         exec_cmd(create_dir_cmd)
 
         cwd = os.getcwd()
         os.chdir(part_rootfs_dir)
-        config_cmd = '/usr/bin/bg_setenv -f . -k "C:%s:%s" %s -r %s -w %s' \
-            % (
-                part.label.upper(),
-                boot_image,
-                '-a "%s"' % cmdline if unified_kernel != 'y' else '',
-                source_params.get("revision", 1),
-                wdog_timeout
-            )
+        cmdline = f'-a "{cmdline}"' if unified_kernel != 'y' else ''
+        config_cmd = f'/usr/bin/bg_setenv -f . -k "C:{part.label.upper()}:{boot_image}" {cmdline} -r {source_params.get("revision", 1)} -w {wdog_timeout}'
         exec_cmd(config_cmd, True)
         os.chdir(cwd)
 
         boot_files = list(filter(None, boot_files))
         for boot_file in boot_files:
-            if os.path.isfile("%s/%s" % (kernel_dir, kernel_image)):
-                install_cmd = "install -m 0644 %s/%s %s/%s" % \
-                    (kernel_dir, boot_file, part_rootfs_dir, boot_file)
+            if os.path.isfile(f'{kernel_dir}/{kernel_image}'):
+                install_cmd = f'install -m 0644 {kernel_dir}/{boot_file} {part_rootfs_dir}/{boot_file}'
                 exec_cmd(install_cmd)
             else:
                 msger.error("file %s not found in directory %s",
@@ -143,14 +135,13 @@ class EfibootguardBootPlugin(SourcePlugin):
     def _create_img(cls, part_rootfs_dir, part, cr_workdir,
                     native_sysroot, oe_builddir):
         # Write label as utf-16le to EFILABEL file
-        with open("%s/EFILABEL" % part_rootfs_dir, 'wb') as filedescriptor:
+        with open(f'{part_rootfs_dir}/EFILABEL', 'wb') as filedescriptor:
             filedescriptor.write(part.label.upper().encode("utf-16le"))
-
-        bootimg = "%s/%s.%s.img" % (cr_workdir, part.label, part.lineno)
+        bootimg = f'{cr_workdir}/{part.label}.{part.lineno}.img'
 
         part.prepare_rootfs_msdos(bootimg, cr_workdir, oe_builddir,
                                   part_rootfs_dir, native_sysroot, None)
-        du_cmd = "du -Lbks %s" % bootimg
+        du_cmd = f'du -Lbks {bootimg}'
         bootimg_size = int(exec_cmd(du_cmd).split()[0])
 
         part.size = bootimg_size
@@ -170,29 +161,16 @@ class EfibootguardBootPlugin(SourcePlugin):
             msger.error("Bitbake variable 'EFI_LIB_ARCH' not set, exiting\n")
             exit(1)
 
-        efistub = "{rootfs_path}/usr/lib/{libpath}/efibootguard/kernel-stub{efiarch}.efi"\
-            .format(rootfs_path=rootfs_path,
-                    libpath=libarch,
-                    efiarch=efiarch)
+        efistub = f'{rootfs_path}/usr/lib/{libarch}/efibootguard/kernel-stub{efiarch}.efi'
         uefi_kernel_name = "linux.efi"
-        uefi_kernel_file = "{deploy_dir}/{uefi_kernel_name}"\
-            .format(deploy_dir=deploy_dir, uefi_kernel_name=uefi_kernel_name)
-        kernel = "{deploy_dir}/{kernel_image}"\
-            .format(deploy_dir=deploy_dir, kernel_image=kernel_image)
-        initrd = "{deploy_dir}/{initrd_image}"\
-            .format(deploy_dir=deploy_dir, initrd_image=initrd_image)
-        cmd = 'bg_gen_unified_kernel {efistub} {kernel} {uefi_kernel_file} \
-            -c "{cmdline}" -i {initrd}'.format(
-                cmdline=cmdline,
-                kernel=kernel,
-                initrd=initrd,
-                efistub=efistub,
-                uefi_kernel_file=uefi_kernel_file)
+        uefi_kernel_file = f'{deploy_dir}/{uefi_kernel_name}'
+        kernel = f'{deploy_dir}/{kernel_image}'
+        initrd = f'{deploy_dir}/{initrd_image}'
+        cmd = f'bg_gen_unified_kernel {efistub} {kernel} {uefi_kernel_file} -c "{cmdline}" -i {initrd}'
         if dtb_files:
             for dtb in dtb_files:
-                cmd += ' -d {deploy_dir}/{dtb_file}'.format(
-                    deploy_dir=deploy_dir,
-                    dtb_file=os.path.basename(dtb))
+                dtb_file=os.path.basename(dtb)
+                cmd += f' -d {deploy_dir}/{dtb_files}'
         exec_cmd(cmd, as_shell=True)
 
         cls._sign_file(signee=uefi_kernel_file, source_params=source_params)
@@ -206,9 +184,7 @@ class EfibootguardBootPlugin(SourcePlugin):
             msger.info("sign with script %s", sign_script)
             orig_signee = signee + ".unsigned"
             os.rename(signee, orig_signee)
-            sign_cmd = "{sign_script} {orig_signee} {signee}"\
-                .format(sign_script=sign_script, orig_signee=orig_signee,
-                        signee=signee)
+            sign_cmd = f'{sign_script} {orig_signee} {signee}'
             exec_cmd(sign_cmd)
         elif sign_script and not os.path.exists(sign_script):
             msger.error("Could not find script %s", sign_script)
diff --git a/scripts/lib/wic/plugins/source/efibootguard-efi.py b/scripts/lib/wic/plugins/source/efibootguard-efi.py
index 48f7523..5d65ffc 100644
--- a/scripts/lib/wic/plugins/source/efibootguard-efi.py
+++ b/scripts/lib/wic/plugins/source/efibootguard-efi.py
@@ -73,38 +73,28 @@ class EfibootguardEFIPlugin(SourcePlugin):
         creator.deploy_dir = deploy_dir
 
         distro_arch = get_bitbake_var("DISTRO_ARCH")
-        bootloader = "/usr/lib/{libpath}/efibootguard/efibootguard{efiarch}.efi".format(
-                        libpath=libarch,
-                        efiarch=efiarch)
-        part_rootfs_dir = "%s/disk/%s.%s" % (cr_workdir,
-                                             part.label,
-                                             part.lineno)
-        create_dir_cmd = "install -d %s/EFI/BOOT" % part_rootfs_dir
+        bootloader = f'/usr/lib/{libarch}/efibootguard/efibootguard{efiarch}.efi'
+        part_rootfs_dir = f'{cr_workdir}/disk/{part.label}.{part.lineno}'
+        create_dir_cmd = f'install -d {part_rootfs_dir}/EFI/BOOT'
         exec_cmd(create_dir_cmd)
 
-        name = "boot{}.efi".format(efiarch)
+        name = f'boot{efiarch}.efi'
 
         signed_bootloader = cls._sign_file(name,
                                            bootloader,
                                            cr_workdir,
                                            source_params)
-        cp_cmd = "cp %s/%s %s/EFI/BOOT/%s" % (cr_workdir,
-                                              signed_bootloader,
-                                              part_rootfs_dir,
-                                              name)
+        cp_cmd = f'cp {cr_workdir}/{signed_bootloader} {part_rootfs_dir}/EFI/BOOT/{name}'
         exec_cmd(cp_cmd, True)
 
-        cp_to_deploy_cmd = "cp %s/%s %s/%s" % (cr_workdir,
-                                               signed_bootloader,
-                                               deploy_dir,
-                                               name)
+        cp_to_deploy_cmd = f'cp {cr_workdir}/{signed_bootloader} {deploy_dir}/{name}'
         exec_cmd(cp_to_deploy_cmd, True)
 
-        efi_part_image = "%s/%s.%s.img" % (cr_workdir, part.label, part.lineno)
+        efi_part_image = f'{cr_workdir}/{part.label}.{part.lineno}.img'
         part.prepare_rootfs_msdos(efi_part_image, cr_workdir, oe_builddir,
                                   part_rootfs_dir, native_sysroot, None)
 
-        du_cmd = "du -Lbks %s" % efi_part_image
+        du_cmd = f'du -Lbks {efi_part_image}'
         efi_part_image_size = int(exec_cmd(du_cmd).split()[0])
 
         part.size = efi_part_image_size
@@ -116,11 +106,7 @@ class EfibootguardEFIPlugin(SourcePlugin):
         sign_script = source_params.get("signwith")
         if sign_script and os.path.exists(sign_script):
             work_name = name.replace(".efi", ".signed.efi")
-            sign_cmd = "{sign_script} {signee} \
-            {cr_workdir}/{work_name}".format(sign_script=sign_script,
-                                             signee=signee,
-                                             cr_workdir=cr_workdir,
-                                             work_name=work_name)
+            sign_cmd = f'{sign_script} {signee} {cr_workdir}/{work_name}'
             exec_cmd(sign_cmd)
         elif sign_script and not os.path.exists(sign_script):
             msger.error("Could not find script %s", sign_script)
@@ -128,9 +114,6 @@ class EfibootguardEFIPlugin(SourcePlugin):
         else:
             # if we do nothing copy the signee to the work directory
             work_name = name
-            cp_cmd = "cp {signee} {cr_workdir}/{work_name}".format(
-                signee=signee,
-                cr_workdir=cr_workdir,
-                work_name=work_name)
+            cp_cmd = f'cp {signee} {cr_workdir}/{work_name}'
             exec_cmd(cp_cmd)
         return work_name
-- 
2.39.2


