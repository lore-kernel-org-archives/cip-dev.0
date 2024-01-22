Return-Path: <quirin.gylstorff@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50523C47DD9
	for <webhook@archiver.kernel.org>; Mon, 22 Jan 2024 15:32:42 +0000 (UTC)
Received: from mta-64-225.siemens.flowmailer.net (mta-64-225.siemens.flowmailer.net [185.136.64.225])
 by mx.groups.io with SMTP id smtpd.web10.77044.1705937553405316704
 for <cip-dev@lists.cip-project.org>;
 Mon, 22 Jan 2024 07:32:34 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=Quirin.Gylstorff@siemens.com header.s=fm1 header.b=EHUg0klS;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.64.225, mailfrom: fm-51332-2024012215322813015084ce113ba8d3-fkore8@rts-flowmailer.siemens.com)
Received: by mta-64-225.siemens.flowmailer.net with ESMTPSA id 2024012215322813015084ce113ba8d3
        for <cip-dev@lists.cip-project.org>;
        Mon, 22 Jan 2024 16:32:29 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=Quirin.Gylstorff@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding;
 bh=TNI5zCAG539Zbgk1dNZ55hnblsSjcLUwcGGwGkMDOpQ=;
 b=EHUg0klS6iCj+UjCzYl/gw/osQaaEnyvO0Lbr1x6Ub9htbexwVmVoVnwtifvk8FSAuBwgS
 t0KWP3914GYeswruP8VGlia9LV2/wnNhpDlLVVGev7RwCfDYXeBdVAUcfeY6m60vmnLxdZwW
 jRccikRrszvHHVawoTWzUaDe0VlBg=;
From: Quirin Gylstorff <Quirin.Gylstorff@siemens.com>
To: jan.kiszka@siemens.com,
	cip-dev@lists.cip-project.org
Subject: [cip-dev][isar-cip-core][RFC] swupdate.bbclass: add script section to the swu file
Date: Mon, 22 Jan 2024 16:31:48 +0100
Message-ID: <20240122153227.297536-1-Quirin.Gylstorff@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-51332:519-21489:flowmailer
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 22 Jan 2024 15:32:42 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/14439

From: Quirin Gylstorff <quirin.gylstorff@siemens.com>

This allows the user to add scripts[1] to the swu file by
setting the variable `SWU_SCRIPTS`. Scripts can be used to
prepare the system for an update.

```
SWU_SCRIPTS = "postinstall.sh:postinstall"
```
This will add  `file://postinstall.sh` to the variable `SRC_URI` and
`postinstall.sh` to `SWU_ADDTIONAL_FILES`. The sw-description will contain
the following section:
```
    scripts: (
        {
          filename = "postinstall.sh";
          type = "postinstall";
          sha256 = "<sha256 of postinstall.sh>";
        },):
```

[1]: https://sbabic.github.io/swupdate/sw-description.html?#scripts

Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
---
 classes/swupdate.bbclass                    | 24 +++++++++++++++++
 doc/README.swupdate.md                      | 29 +++++++++++++++++++++
 recipes-core/images/swu/sw-description.tmpl |  1 +
 3 files changed, 54 insertions(+)

diff --git a/classes/swupdate.bbclass b/classes/swupdate.bbclass
index 8f1215d..7d7aa8a 100644
--- a/classes/swupdate.bbclass
+++ b/classes/swupdate.bbclass
@@ -58,6 +58,7 @@ IMAGE_TEMPLATE_VARS:swu = " \
     SWU_NAME \
     SWU_FILE_NODES \
     SWU_BOOTLOADER_FILE_NODE \
+    SWU_SCRIPTS_NODE \
     "
 
 # Add the bootloader file
@@ -123,6 +124,29 @@ python add_ebg_update(){
    d.appendVar('SWU_ADDITIONAL_FILES', " " + efi_boot_loader_file)
 }
 
+SWU_EXTEND_SW_DESCRIPTION += "add_scripts"
+python add_scripts(){
+    swu_scripts = d.getVar('SWU_SCRIPTS')
+    if not swu_scripts:
+        return
+    swu_script_entries = [ s for s in swu_scripts.split() ]
+    script_node_list = []
+    for entry in swu_script_entries:
+        script_file, script_type = entry.split(':')
+        node = f"""
+        {{
+          filename = "{script_file}";
+          type = "{script_type}";
+          sha256 = "{script_file}-sha256";
+        }},"""
+        script_node_list.append(node)
+        d.appendVar('SWU_ADDITIONAL_FILES', " " + script_file)
+        d.appendVar('SRC_URI', f" file://{script_file}")
+
+    swu_scripts_node = "scripts: (" + ''.join([n for n in script_node_list]) + ");"
+    d.appendVar('SWU_SCRIPTS_NODE', swu_scripts_node)
+}
+
 # convert between swupdate compressor name and imagetype extension
 def get_swu_compression_type(d):
     swu_ct = d.getVar('SWU_COMPRESSION_TYPE')
diff --git a/doc/README.swupdate.md b/doc/README.swupdate.md
index 1c94699..5d0f70e 100644
--- a/doc/README.swupdate.md
+++ b/doc/README.swupdate.md
@@ -21,6 +21,35 @@ window is still possible.
 If the variable `SWU_EBG_UPDATE` is set to `"1"` the update is also stored in
 the `*.swu` file.
 
+## SWUpdate scripts
+
+It is possible to add [scripts](https://sbabic.github.io/swupdate/sw-description.html?#scripts) to a swu file.
+
+To add a script entry in isar-cip-core set the variable `SWU_SCRIPTS`.
+The content of the variable has the following pattern:
+`<script_file_name>:<script_type>`
+
+The file referenced by `script_file_name` is added to the variables `SRC_URI`
+and `SWU_ADDITIONAL_FILES`. Therefore, it needs to be safed in a `FILESPATH`
+location.
+
+Example:
+
+```
+SWU_SCRIPTS = "postinstall.sh:postinstall"
+```
+This will add  `file://postinstall.sh` to the variable `SRC_URI` and
+`postinstall.sh` to `SWU_ADDTIONAL_FILES`. The sw-description will contain
+the following section:
+```
+    scripts: (
+        {
+          filename = "postinstall.sh";
+          type = "postinstall";
+          sha256 = "<sha256 of postinstall.sh>";
+        },):
+```
+
 # Building and testing the CIP Core image
 
 Set up `kas-container` as described in the [top-level README](../README.md).
diff --git a/recipes-core/images/swu/sw-description.tmpl b/recipes-core/images/swu/sw-description.tmpl
index c52372c..88cb475 100644
--- a/recipes-core/images/swu/sw-description.tmpl
+++ b/recipes-core/images/swu/sw-description.tmpl
@@ -35,4 +35,5 @@ software =
             };
             sha256 = "linux.efi-sha256";
     }${SWU_FILE_NODES});
+    ${SWU_SCRIPTS_NODE}
 }
-- 
2.43.0


