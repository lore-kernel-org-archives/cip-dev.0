Return-Path: <quirin.gylstorff@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A7B5C48260
	for <webhook@archiver.kernel.org>; Fri, 16 Feb 2024 17:24:00 +0000 (UTC)
Received: from mta-64-228.siemens.flowmailer.net (mta-64-228.siemens.flowmailer.net [185.136.64.228])
 by mx.groups.io with SMTP id smtpd.web11.2677.1708104231985500385
 for <cip-dev@lists.cip-project.org>;
 Fri, 16 Feb 2024 09:23:53 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=Quirin.Gylstorff@siemens.com header.s=fm1 header.b=E8kAG8VP;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.64.228, mailfrom: fm-51332-20240216172349d6ca8e74c07bf26412-zzsovj@rts-flowmailer.siemens.com)
Received: by mta-64-228.siemens.flowmailer.net with ESMTPSA id 20240216172349d6ca8e74c07bf26412
        for <cip-dev@lists.cip-project.org>;
        Fri, 16 Feb 2024 18:23:49 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=Quirin.Gylstorff@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding;
 bh=3TgT/r27Iqmm7ZYZmYBPXAjt1uPOftuw1oh6pXhCrHk=;
 b=E8kAG8VPObL7rotsRvF7Nx8CA3bxVxMu+DkDQLiC2uwjPhm8/jBrbQx/LFIXNzv0nE/IES
 m048mcm37Lkwlm1NA5OazQLP+comgCj/k80IVrnlavpZ6vDNKrRA3bs7I71/TrezQyRNeINA
 EpMSr8kIHH81J3Q/dPU10EPr/55Lg=;
From: Quirin Gylstorff <Quirin.Gylstorff@siemens.com>
To: cip-dev@lists.cip-project.org,
	jan.kiszka@siemens.com
Subject: [cip-dev][isar-cip-core][PATCH v5] swupdate.bbclass: add scripts section to the swu file
Date: Fri, 16 Feb 2024 18:23:36 +0100
Message-ID: <20240216172348.313789-1-Quirin.Gylstorff@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-51332:519-21489:flowmailer
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 16 Feb 2024 17:24:00 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/15021

From: Quirin Gylstorff <quirin.gylstorff@siemens.com>

This allows the user to add scripts[1] to the swu file by
setting the variable `SWU_SCRIPTS`. Scripts can be used to
prepare the system for an update.

```
SWU_SCRIPTS = "postinstall"
SWU_SCRIPT_postinstall[file] = "postinstall.sh"
SWU_SCRIPT_postinstall[type] = "postinstall"
```
An optional data element is possible with

```
SWU_SCRIPT_postinstall[data]= "some_data"
```

This will add  `file://<script_file_name>` to the variable `SRC_URI` and
`<script_file_name>` to `SWU_ADDTIONAL_FILES`. The sw-description will contain
the following section:
```
    scripts: (
        {
          filename = "<script_file_name>";
          type = "<script_type>";
          data = "<script_data>";
          sha256 = "<automatically added sha256 of script_file_name>";
        },):
```

[1]: https://sbabic.github.io/swupdate/sw-description.html?#scripts

Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
---
 classes/swupdate.bbclass                    | 46 +++++++++++
 doc/README.swupdate.md                      | 86 +++++++++++++++++++++
 recipes-core/images/swu/sw-description.tmpl |  1 +
 3 files changed, 133 insertions(+)

diff --git a/classes/swupdate.bbclass b/classes/swupdate.bbclass
index 403bdef..75a421d 100644
--- a/classes/swupdate.bbclass
+++ b/classes/swupdate.bbclass
@@ -57,6 +57,7 @@ IMAGE_TEMPLATE_VARS:swu = " \
     SWU_NAME \
     SWU_FILE_NODES \
     SWU_BOOTLOADER_FILE_NODE \
+    SWU_SCRIPTS_NODE \
     "
 
 # TARGET_IMAGE_UUID needs to be generated before completing the template
@@ -93,6 +94,51 @@ python add_swu_compression(){
         d.setVar('SWU_COMPRESSION_NODE', '')
 }
 
+
+SWU_EXTEND_SW_DESCRIPTION += "add_scripts"
+python add_scripts(){
+    swu_scripts = d.getVar('SWU_SCRIPTS')
+    if not swu_scripts:
+        return
+    swu_script_entries = swu_scripts.split()
+    script_node_list = []
+    for entry in swu_script_entries:
+        script_entry = f"SWU_SCRIPT_{entry}"
+
+        script_file = d.getVarFlag(script_entry, "file")
+        if not script_file:
+            bb.warn(f"flag 'file' is empty for {script_entry} ")
+            continue
+
+        script_type = d.getVarFlag(script_entry, "type")
+        if not script_type:
+            bb.warn(f"flag 'type' is empty for {script_entry} ")
+            continue
+
+        allowed_script_types = ["lua", "shellscript", "preinstall", "postinstall"]
+        if script_type not in allowed_script_types:
+            bb.warn(f"flag 'type' is not of value {allowed_script_types} ")
+            continue
+
+        script_data = d.getVarFlag(script_entry, "data")
+        node = f"""
+        {{
+          filename = "{script_file}";
+          type = "{script_type}";
+        """
+        if script_data:
+            node += f"""  data = "{script_data}";"""
+        node += f"""
+          sha256 = "{script_file}-sha256";
+        }}"""
+        script_node_list.append(node)
+        d.appendVar('SWU_ADDITIONAL_FILES', " " + script_file)
+        d.appendVar('SRC_URI', f" file://{script_file}")
+
+    swu_scripts_node = "scripts: (" + ','.join([n for n in script_node_list]) + ");"
+    d.appendVar('SWU_SCRIPTS_NODE', swu_scripts_node)
+}
+
 # convert between swupdate compressor name and imagetype extension
 def get_swu_compression_type(d):
     swu_ct = d.getVar('SWU_COMPRESSION_TYPE')
diff --git a/doc/README.swupdate.md b/doc/README.swupdate.md
index 1c94699..88faf23 100644
--- a/doc/README.swupdate.md
+++ b/doc/README.swupdate.md
@@ -21,6 +21,92 @@ window is still possible.
 If the variable `SWU_EBG_UPDATE` is set to `"1"` the update is also stored in
 the `*.swu` file.
 
+## SWUpdate scripts
+
+It is possible to add [scripts](https://sbabic.github.io/swupdate/sw-description.html?#scripts) to a swu file.
+
+To add a script entry in isar-cip-core set the variable `SWU_SCRIPTS`.
+The content of the variable has the following pattern:
+`script_name`
+
+For each `script_name` the following flags need to be set:
+
+```
+SWU_SCRIPT_script_name[file] = "<script_file_name>"
+SWU_SCRIPT_script_name[type] = "<script_type>"
+```
+
+The optional flag `data` can be used as an script argument:
+
+```
+SWU_SCRIPT_script_name[data] = "<script argument>"
+```
+
+The file referenced by `<script_file_name>` is added to the variables `SRC_URI`
+and `SWU_ADDITIONAL_FILES`. Therefore, it needs to be safed in a `FILESPATH`
+location.
+
+The mandatory element `script_type` can have the following values:
+- [lua](https://sbabic.github.io/swupdate/sw-description.html#lua)
+- [shellscript](https://sbabic.github.io/swupdate/sw-description.html#shellscript)
+- [preinstall](https://sbabic.github.io/swupdate/sw-description.html#preinstall)
+- [postinstall](https://sbabic.github.io/swupdate/sw-description.html#postinstall)
+
+### Example: postinstall.sh
+
+```
+SWU_SCRIPTS = "postinstall"
+SWU_SCRIPT_postinstall[file] = "postinstall.sh"
+SWU_SCRIPT_postinstall[type] = "postinstall"
+SWU_SCRIPT_postinstall[data] = "some_data"
+```
+
+This will add  `file://postinstall.sh` to the variable `SRC_URI` and
+`postinstall.sh` to `SWU_ADDTIONAL_FILES`. The sw-description will contain
+the following section:
+```
+    scripts: (
+        {
+          filename = "postinstall.sh";
+          type = "postinstall";
+          data = "some_data"
+          sha256 = "<sha256 of postinstall.sh>";
+        }):
+```
+### Example: Luascript
+The simplest lua script has the following content:
+```lua
+function preinst()
+	local message = "preinst called\n"
+	local success = true
+	return success, message
+end
+function postinst()
+	local message = "postinst called\n"
+	local success = true
+	return success, message
+end
+```
+and is added:
+
+```
+SWU_SCRIPTS = "luascript"
+SWU_SCRIPT_luascript[file] = "luascript.lua"
+SWU_SCRIPT_luascript[type] = "luascript"
+SWU_SCRIPT_luascript[data] = "some_data"
+```
+
+The sw-description will contain the following section:
+```
+    scripts: (
+        {
+          filename = "luascript.lua";
+          type = "lua";
+          data = "some_data"
+          sha256 = "<sha256 of luascript.lua>";
+        }):
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


