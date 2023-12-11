Return-Path: <quirin.gylstorff@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E3BFC10F07
	for <webhook@archiver.kernel.org>; Mon, 11 Dec 2023 12:25:43 +0000 (UTC)
Received: from mta-64-228.siemens.flowmailer.net (mta-64-228.siemens.flowmailer.net [185.136.64.228])
 by mx.groups.io with SMTP id smtpd.web11.7068.1702297533120424445
 for <cip-dev@lists.cip-project.org>;
 Mon, 11 Dec 2023 04:25:34 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=Quirin.Gylstorff@siemens.com header.s=fm1 header.b=awYI7JSD;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.64.228, mailfrom: fm-51332-20231211122531deebe63c878270ab53-v8wqmw@rts-flowmailer.siemens.com)
Received: by mta-64-228.siemens.flowmailer.net with ESMTPSA id 20231211122531deebe63c878270ab53
        for <cip-dev@lists.cip-project.org>;
        Mon, 11 Dec 2023 13:25:31 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=Quirin.Gylstorff@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:References:In-Reply-To;
 bh=CG+wQxEZZGmazjRSmbE70vfkTKnlr75B9+GiYk4cUxM=;
 b=awYI7JSDvySs1Rr6dszIkZjJJS1ebYfyOJH0tDXTR3bpYJ0wJ84v8egHipFDZIFKE6uJA6
 GOXjZc8rvVO8g/nHi/EWMdOS6inmrIHPy0hA6dHZqkSuNYULAlLbHscVgXpcBNBK66+/Y7rh
 xhAy37Q3IPBPUsk4mTFqYXhpJpC7Q=;
From: Quirin Gylstorff <Quirin.Gylstorff@siemens.com>
To: jan.kiszka@siemens.com,
	felix.moessbauer@siemens.com,
	cip-dev@lists.cip-project.org
Subject: [cip-dec][isar-cip-core][RFC v2 3/3] swupdate: Extend sw-description to update efibootguard
Date: Mon, 11 Dec 2023 13:19:21 +0100
Message-ID: <20231211122528.486786-4-Quirin.Gylstorff@siemens.com>
In-Reply-To: <20231211122528.486786-1-Quirin.Gylstorff@siemens.com>
References: <20231211122528.486786-1-Quirin.Gylstorff@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-51332:519-21489:flowmailer
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 11 Dec 2023 12:25:43 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/14019

From: Quirin Gylstorff <quirin.gylstorff@siemens.com>

If the variable `SWU_EBG_UPDATE` is set to `1` an additional file
element is added to the sw-description to replace the ebg.

Use python as newlines are part of the sw-description syntax an
therefore cannot be hold in a bitbake variable, see note in[1].

IMPORTANT: Even if the property 'atomic-install' is set FAT does not
support atomic writes or renames so a powercut can still corrupt the
system[1].

[1]: https://docs.yoctoproject.org/bitbake/2.2/bitbake-user-manual/bitbake-user-manual-metadata.html#line-joining
[2]: https://lore.kernel.org/linux-fsdevel/20191022105413.pj6i3ydetnfgnkzh@pali/

Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
---
 classes/swupdate.bbclass                    | 35 +++++++++++++++++++--
 recipes-core/images/swu/sw-description.tmpl |  2 +-
 2 files changed, 34 insertions(+), 3 deletions(-)

diff --git a/classes/swupdate.bbclass b/classes/swupdate.bbclass
index 0e95e3c..99a4c6f 100644
--- a/classes/swupdate.bbclass
+++ b/classes/swupdate.bbclass
@@ -21,7 +21,8 @@ SWU_VERSION ?= "0.2"
 SWU_NAME ?= "cip software update"
 # space separated list of supported hw. Leave empty to leave out
 SWU_HW_COMPAT ?= ""
-
+SWU_EBG_UPDATE ?= ""
+SWU_EFI_BOOT_DEVICE ?= "/dev/disk/by-uuid/4321-DCBA"
 
 SWU_IMAGE_FILE ?= "${DEPLOY_DIR_IMAGE}/${IMAGE_FULLNAME}.swu"
 SWU_DESCRIPTION_FILE ?= "sw-description"
@@ -48,7 +49,9 @@ IMAGE_TEMPLATE_VARS:swu = " \
     SWU_HW_COMPAT_NODE \
     SWU_COMPRESSION_NODE \
     SWU_VERSION \
-    SWU_NAME"
+    SWU_NAME \
+    SWU_FILE_NODES \
+    "
 
 # TARGET_IMAGE_UUID needs to be generated before completing the template
 addtask do_transform_template after do_generate_image_uuid
@@ -84,6 +87,34 @@ python add_swu_compression(){
         d.setVar('SWU_COMPRESSION_NODE', '')
 }
 
+SWU_EXTEND_SW_DESCRIPTION += "${@ 'add_ebg_update' if d.getVar('SWU_EBG_UPDATE') == '1' else ''}"
+python add_ebg_update(){
+    distro_arch = d.getVar('DISTRO_ARCH')
+    distro_to_efi_arch = {
+            "amd64": "x64",
+            "arm64": "aa64",
+            "armhf": "arm",
+            "i386": "ia32",
+            "riscv64": "riscv64"
+    }
+    efi_boot_loader_file = "boot{}.efi".format(distro_to_efi_arch[distro_arch])
+    efi_boot_device = d.getVar('SWU_EFI_BOOT_DEVICE')
+    swu_ebg_update_node = f""",
+    {{
+           filename = "{efi_boot_loader_file}";
+           path = "EFI/BOOT/{efi_boot_loader_file}";
+           device = "{efi_boot_device}";
+           filesystem = "vfat";
+           sha256 = "{efi_boot_loader_file}-sha256";
+           properties: {{
+                atomic-install = true;
+           }};
+    }}
+    """
+    d.appendVar('SWU_FILE_NODES', swu_ebg_update_node)
+    d.appendVar('SWU_ADDITIONAL_FILES', " " + efi_boot_loader_file)
+}
+
 
 # convert between swupdate compressor name and imagetype extension
 def get_swu_compression_type(d):
diff --git a/recipes-core/images/swu/sw-description.tmpl b/recipes-core/images/swu/sw-description.tmpl
index 6b53a3c..c52372c 100644
--- a/recipes-core/images/swu/sw-description.tmpl
+++ b/recipes-core/images/swu/sw-description.tmpl
@@ -34,5 +34,5 @@ software =
                         subtype = "kernel";
             };
             sha256 = "linux.efi-sha256";
-    });
+    }${SWU_FILE_NODES});
 }
-- 
2.42.0


