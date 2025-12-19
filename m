Return-Path: <quirin.gylstorff@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E886D767CA
	for <webhook@archiver.kernel.org>; Fri, 19 Dec 2025 10:33:58 +0000 (UTC)
Received: from mta-64-226.siemens.flowmailer.net (mta-64-226.siemens.flowmailer.net [185.136.64.226])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.14146.1766140433397473705
 for <cip-dev@lists.cip-project.org>;
 Fri, 19 Dec 2025 02:33:54 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=Quirin.Gylstorff@siemens.com header.s=fm2 header.b=lk6VBwPZ;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.64.226, mailfrom: fm-51332-202512191033514c46145ddd000207f1-o_3twx@rts-flowmailer.siemens.com)
Received: by mta-64-226.siemens.flowmailer.net with ESMTPSA id 202512191033514c46145ddd000207f1
        for <cip-dev@lists.cip-project.org>;
        Fri, 19 Dec 2025 11:33:51 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm2;
 d=siemens.com; i=Quirin.Gylstorff@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:References:In-Reply-To;
 bh=eg7xScxWlpynSv50qbVXZCTs3kvIk78vuruE319HFZY=;
 b=lk6VBwPZzu11aAcnVPjsEdpGavxE14/PrYhzSFhatRs78/bAIe4vsmz9KiqszXBsO1SIXd
 nUqHyqB6GFOufFZlYbUXI30sGdgx1ZkRzmE31Wyp4FXC2YgFsAW+ygcTBE5Kvm02tDhpiL/T
 IgJ5U72g6nxdi/IH5UXVOnu1psVkWHoTYFMN2BmqbRl7G4iMXZoggbvvKibmgkfqGwcQFS7v
 EXntBndDsOqcTV7+6nibuGa9lx4d7+hcztEgPPzcegUg35g2kAVvc43Y0FJIRDktgEFsS+OI
 dQo1+NRnQXqCI0/ARUI72tFUX+nCN6aAO2cv7HWwDTwyMJVhC+hdvNnA==;
From: Quirin Gylstorff <Quirin.Gylstorff@siemens.com>
To: jan.kiszka@siemens.com,
	clara.kowalsky@siemens.com,
	cip-dev@lists.cip-project.org,
	benedikt.niedermayr@siemens.com
Subject: [cip-dev][isar-cip-core][RFC 4/6] Move efibootguard to swupdate-efibootguard.inc
Date: Fri, 19 Dec 2025 11:31:24 +0100
Message-ID: <20251219103349.1227710-5-Quirin.Gylstorff@siemens.com>
In-Reply-To: <20251219103349.1227710-1-Quirin.Gylstorff@siemens.com>
References: <20251219103349.1227710-1-Quirin.Gylstorff@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-51332:519-21489:flowmailer
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 19 Dec 2025 10:33:58 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/21166

From: Quirin Gylstorff <quirin.gylstorff@siemens.com>

Simplify the generation of A/B root file system with SWUpdate including
efibootguard into swupdate.inc.

With this change it is possible to prepare to rootfs by adding:

```
require recipes-core/images/swupdate.inc
```

Also rename the file to swupdate-efibootguard to indictate the indended
use.

Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
---
 classes-recipe/efibootguard.bbclass           | 64 ++---------------
 kas/opt/ebg-swu.yml                           |  3 -
 recipes-core/images/efibootguard.inc          | 13 +---
 recipes-core/images/swupdate-efibootguard.inc | 70 +++++++++++++++++++
 recipes-core/images/swupdate.inc              |  9 +++
 5 files changed, 85 insertions(+), 74 deletions(-)
 mode change 100644 => 120000 recipes-core/images/efibootguard.inc
 create mode 100644 recipes-core/images/swupdate-efibootguard.inc

diff --git a/classes-recipe/efibootguard.bbclass b/classes-recipe/efibootguard.bbclass
index cbd2376..4e7a2a6 100644
--- a/classes-recipe/efibootguard.bbclass
+++ b/classes-recipe/efibootguard.bbclass
@@ -1,7 +1,7 @@
 #
 # CIP Core, generic profile
 #
-# Copyright (c) Siemens AG, 2024
+# Copyright (c) Siemens AG, 2024 - 2025
 #
 # Authors:
 #  Quirin Gylstorff <quirin.gylstorff@siemens.com>
@@ -9,62 +9,8 @@
 # SPDX-License-Identifier: MIT
 #
 
-IMAGE_INSTALL:append = " efibootguard-tools libebgenv0"
-IMAGER_INSTALL:wic:append = " efibootguard:${DISTRO_ARCH} efibootguard-tools:${DISTRO_ARCH}"
-WDOG_TIMEOUT ?= "60"
-WICVARS += "WDOG_TIMEOUT KERNEL_IMAGE INITRD_DEPLOY_FILE DTB_FILES EFI_ARCH EFI_LIB_ARCH UKI_FILENAME"
-IMAGE_TYPEDEP:swu:append = " wic"
-
-def distro_to_efi_arch(d):
-    DISTRO_TO_EFI_ARCH = {
-        "amd64": "x64",
-        "arm64": "aa64",
-        "armhf": "arm",
-        "i386": "ia32",
-        "riscv64": "riscv64"
-    }
-    distro_arch = d.getVar('DISTRO_ARCH')
-    return DISTRO_TO_EFI_ARCH[distro_arch]
-
-EFI_ARCH := "${@distro_to_efi_arch(d)}"
-
-def distro_to_lib_arch(d):
-    DISTRO_TO_LIB_ARCH = {
-        "amd64": "x86_64-linux-gnu",
-        "arm64": "aarch64-linux-gnu",
-        "armhf": "arm-linux-gnueabihf",
-        "i386": "i386-linux-gnu",
-        "riscv64": "riscv64-linux-gnu",
-    }
-    distro_arch = d.getVar('DISTRO_ARCH')
-    return DISTRO_TO_LIB_ARCH[distro_arch]
-
-EFI_LIB_ARCH := "${@distro_to_lib_arch(d)}"
-
-# Add the bootloader file
-def efi_bootloader_name(d):
-    efi_arch = distro_to_efi_arch(d)
-    return "boot{}.efi".format(efi_arch)
-
-SWU_EXTEND_SW_DESCRIPTION += "add_ebg_update"
-python add_ebg_update() {
-    efi_boot_loader_file = efi_bootloader_name(d)
-    efi_boot_device = d.getVar('SWU_EFI_BOOT_DEVICE')
-    swu_ebg_update_node = f"""
-    {{
-        filename = "{efi_boot_loader_file}";
-        path = "EFI/BOOT/{efi_boot_loader_file}";
-        device = "{efi_boot_device}";
-        filesystem = "vfat";
-        sha256 = "{efi_boot_loader_file}-sha256";
-        properties: {{
-            atomic-install = "true";
-        }};
-    }}
-    """
-
-    d.setVar('SWU_BOOTLOADER_FILE_NODE', swu_ebg_update_node)
-    ebg_update = d.getVar('SWU_EBG_UPDATE') or ""
-    if ebg_update:
-        d.appendVar('SWU_FILE_NODES', "," + swu_ebg_update_node)
+require recipes-core/images/swupdate-efibootguard.inc
+do_warn_custom_inc() {
+    bbwarn "Please migrate from \"inherit efibootguard\" to \"recipes-core/images/swupdate-efibootguard.inc\""
 }
+addtask warn_custom_inc before do_unpack
diff --git a/kas/opt/ebg-swu.yml b/kas/opt/ebg-swu.yml
index 9b8a0e8..c3733d3 100644
--- a/kas/opt/ebg-swu.yml
+++ b/kas/opt/ebg-swu.yml
@@ -16,11 +16,8 @@ header:
 
 local_conf_header:
   ebg_swu_bootloader: |
-    WKS_FILE ?= "${MACHINE}-efibootguard.wks.in"
     SWUPDATE_BOOTLOADER = "efibootguard"
     IMAGE_INSTALL:remove = "u-boot-script"
-  ebg_swu_image_options: |
-    CIP_IMAGE_OPTIONS:append = " recipes-core/images/efibootguard.inc"
   firmware-binaries: |
     # Add ovmf binaries for qemu
     CIP_IMAGE_OPTIONS:append:qemu-amd64 = " recipes-core/images/deploy-ovmf.inc"
diff --git a/recipes-core/images/efibootguard.inc b/recipes-core/images/efibootguard.inc
deleted file mode 100644
index f512b3c..0000000
--- a/recipes-core/images/efibootguard.inc
+++ /dev/null
@@ -1,12 +0,0 @@
-#
-# CIP Core, generic profile
-#
-# Copyright (c) Siemens AG, 2020, 2024
-#
-# Authors:
-#  Quirin Gylstorff <quirin.gylstorff@siemens.com>
-#
-# SPDX-License-Identifier: MIT
-#
-
-inherit efibootguard
diff --git a/recipes-core/images/efibootguard.inc b/recipes-core/images/efibootguard.inc
new file mode 120000
index 0000000..0bb31dc
--- /dev/null
+++ b/recipes-core/images/efibootguard.inc
@@ -0,0 +1 @@
+swupdate-efibootguard.inc
\ No newline at end of file
diff --git a/recipes-core/images/swupdate-efibootguard.inc b/recipes-core/images/swupdate-efibootguard.inc
new file mode 100644
index 0000000..5b69144
--- /dev/null
+++ b/recipes-core/images/swupdate-efibootguard.inc
@@ -0,0 +1,70 @@
+#
+# CIP Core, generic profile
+#
+# Copyright (c) Siemens AG, 2024 - 2025
+#
+# Authors:
+#  Quirin Gylstorff <quirin.gylstorff@siemens.com>
+#
+# SPDX-License-Identifier: MIT
+#
+
+IMAGE_INSTALL:append = " efibootguard-tools libebgenv0"
+IMAGER_INSTALL:wic:append = " efibootguard:${DISTRO_ARCH} efibootguard-tools:${DISTRO_ARCH}"
+WDOG_TIMEOUT ?= "60"
+WICVARS += "WDOG_TIMEOUT KERNEL_IMAGE INITRD_DEPLOY_FILE DTB_FILES EFI_ARCH EFI_LIB_ARCH UKI_FILENAME"
+IMAGE_TYPEDEP:swu:append = " wic"
+
+def distro_to_efi_arch(d):
+    DISTRO_TO_EFI_ARCH = {
+        "amd64": "x64",
+        "arm64": "aa64",
+        "armhf": "arm",
+        "i386": "ia32",
+        "riscv64": "riscv64"
+    }
+    distro_arch = d.getVar('DISTRO_ARCH')
+    return DISTRO_TO_EFI_ARCH[distro_arch]
+
+EFI_ARCH := "${@distro_to_efi_arch(d)}"
+
+def distro_to_lib_arch(d):
+    DISTRO_TO_LIB_ARCH = {
+        "amd64": "x86_64-linux-gnu",
+        "arm64": "aarch64-linux-gnu",
+        "armhf": "arm-linux-gnueabihf",
+        "i386": "i386-linux-gnu",
+        "riscv64": "riscv64-linux-gnu",
+    }
+    distro_arch = d.getVar('DISTRO_ARCH')
+    return DISTRO_TO_LIB_ARCH[distro_arch]
+
+EFI_LIB_ARCH := "${@distro_to_lib_arch(d)}"
+
+# Add the bootloader file
+def efi_bootloader_name(d):
+    efi_arch = distro_to_efi_arch(d)
+    return "boot{}.efi".format(efi_arch)
+
+SWU_EXTEND_SW_DESCRIPTION += "add_ebg_update"
+python add_ebg_update() {
+    efi_boot_loader_file = efi_bootloader_name(d)
+    efi_boot_device = d.getVar('SWU_EFI_BOOT_DEVICE')
+    swu_ebg_update_node = f"""
+    {{
+        filename = "{efi_boot_loader_file}";
+        path = "EFI/BOOT/{efi_boot_loader_file}";
+        device = "{efi_boot_device}";
+        filesystem = "vfat";
+        sha256 = "{efi_boot_loader_file}-sha256";
+        properties: {{
+            atomic-install = "true";
+        }};
+    }}
+    """
+
+    d.setVar('SWU_BOOTLOADER_FILE_NODE', swu_ebg_update_node)
+    ebg_update = d.getVar('SWU_EBG_UPDATE') or ""
+    if ebg_update:
+        d.appendVar('SWU_FILE_NODES', "," + swu_ebg_update_node)
+}
diff --git a/recipes-core/images/swupdate.inc b/recipes-core/images/swupdate.inc
index 696ee7d..30b4ecf 100644
--- a/recipes-core/images/swupdate.inc
+++ b/recipes-core/images/swupdate.inc
@@ -12,6 +12,15 @@
 inherit image_uuid
 inherit read-only-rootfs
 
+SWUPDATE_BOOTLOADER ??= "efibootguard"
+python __anonymous() {
+    bootloader = d.getVar("SWUPDATE_BOOTLOADER") or "None"
+    if not bootloader in ["efibootguard"]:
+        bb.error("swupdate: SWUPDATE_BOOTLOADER set to incompatible value: " + bootloader)
+}
+
+include recipes-core/images/swupdate-${SWUPDATE_BOOTLOADER}.inc
+
 RO_ROOTFS_TYPE ??= "squashfs"
 IMAGE_TYPEDEP:wic += "${RO_ROOTFS_TYPE}"
 IMAGE_FSTYPES:append = " swu"
-- 
2.51.2


