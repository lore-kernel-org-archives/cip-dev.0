Return-Path: <quirin.gylstorff@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75EF9C54E55
	for <webhook@archiver.kernel.org>; Tue,  5 Mar 2024 16:11:55 +0000 (UTC)
Received: from mta-64-228.siemens.flowmailer.net (mta-64-228.siemens.flowmailer.net [185.136.64.228])
 by mx.groups.io with SMTP id smtpd.web11.27683.1709655103149760485
 for <cip-dev@lists.cip-project.org>;
 Tue, 05 Mar 2024 08:11:49 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=Quirin.Gylstorff@siemens.com header.s=fm1 header.b=qCjoV8op;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.64.228, mailfrom: fm-51332-20240305161130e6752cb9d84f55164a-n_6azn@rts-flowmailer.siemens.com)
Received: by mta-64-228.siemens.flowmailer.net with ESMTPSA id 20240305161130e6752cb9d84f55164a
        for <cip-dev@lists.cip-project.org>;
        Tue, 05 Mar 2024 17:11:30 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=Quirin.Gylstorff@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:References:In-Reply-To;
 bh=atqhpUKn6xgCqbVkczgdWqkVHnEliAq7sYxzPhLF94c=;
 b=qCjoV8opbS00it2mScWQxz5N51XW07Qp0L2jc6N1ScWuVlHJNVR9G4BZusuBIl8gyLnul5
 EG6phoQQrMVzBHESHpg32DFgThlLcYbAGQTILMZgN0w/DMl5O7gBlKPuXxPV3sfWI9HLsB4s
 LXzLyIdYRvvECS7lqkd2IqefLXflU=;
From: Quirin Gylstorff <Quirin.Gylstorff@siemens.com>
To: cip-dev@lists.cip-project.org,
	felix.moessbauer@siemens.com,
	jan.kiszka@siemens.com
Subject: [cip-dev][isar-cip-core][PATCH v3 5/6] format: classes/efibootguard fix spacing
Date: Tue,  5 Mar 2024 17:10:58 +0100
Message-ID: <20240305161128.2777211-6-Quirin.Gylstorff@siemens.com>
In-Reply-To: <20240305161128.2777211-1-Quirin.Gylstorff@siemens.com>
References: <20240305161128.2777211-1-Quirin.Gylstorff@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-51332:519-21489:flowmailer
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 05 Mar 2024 16:11:55 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/15235

From: Quirin Gylstorff <quirin.gylstorff@siemens.com>

Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
---
 classes/efibootguard.bbclass | 38 ++++++++++++++++++------------------
 1 file changed, 19 insertions(+), 19 deletions(-)

diff --git a/classes/efibootguard.bbclass b/classes/efibootguard.bbclass
index 2b4f09e..b130968 100644
--- a/classes/efibootguard.bbclass
+++ b/classes/efibootguard.bbclass
@@ -47,24 +47,24 @@ def efi_bootloader_name(d):
     return "boot{}.efi".format(efi_arch)
 
 SWU_EXTEND_SW_DESCRIPTION += "add_ebg_update"
-python add_ebg_update(){
-   efi_boot_loader_file = efi_bootloader_name(d)
-   efi_boot_device = d.getVar('SWU_EFI_BOOT_DEVICE')
-   swu_ebg_update_node = f"""
-   {{
-          filename = "{efi_boot_loader_file}";
-          path = "EFI/BOOT/{efi_boot_loader_file}";
-          device = "{efi_boot_device}";
-          filesystem = "vfat";
-          sha256 = "{efi_boot_loader_file}-sha256";
-          properties: {{
-               atomic-install = "true";
-          }};
-   }}
-   """
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
 
-   d.setVar('SWU_BOOTLOADER_FILE_NODE', swu_ebg_update_node)
-   ebg_update = d.getVar('SWU_EBG_UPDATE') or ""
-   if ebg_update:
-     d.appendVar('SWU_FILE_NODES', "," + swu_ebg_update_node)
+    d.setVar('SWU_BOOTLOADER_FILE_NODE', swu_ebg_update_node)
+    ebg_update = d.getVar('SWU_EBG_UPDATE') or ""
+    if ebg_update:
+        d.appendVar('SWU_FILE_NODES', "," + swu_ebg_update_node)
 }
-- 
2.43.0


