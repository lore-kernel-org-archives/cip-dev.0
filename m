Return-Path: <quirin.gylstorff@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A96EBC48260
	for <webhook@archiver.kernel.org>; Thu,  8 Feb 2024 10:46:06 +0000 (UTC)
Received: from mta-64-228.siemens.flowmailer.net (mta-64-228.siemens.flowmailer.net [185.136.64.228])
 by mx.groups.io with SMTP id smtpd.web10.15038.1707389155419171608
 for <cip-dev@lists.cip-project.org>;
 Thu, 08 Feb 2024 02:45:56 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=Quirin.Gylstorff@siemens.com header.s=fm1 header.b=PI0mkIqO;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.64.228, mailfrom: fm-51332-20240208104551d6ca144ceedcfc5a9e-yn3wei@rts-flowmailer.siemens.com)
Received: by mta-64-228.siemens.flowmailer.net with ESMTPSA id 20240208104551d6ca144ceedcfc5a9e
        for <cip-dev@lists.cip-project.org>;
        Thu, 08 Feb 2024 11:45:52 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=Quirin.Gylstorff@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding;
 bh=8iBJx383wcCJgp6/xmfnAseL0tP99U8iwwLVxyLiTVY=;
 b=PI0mkIqOtxTegsWkgD11IiuYLr2rbdajuYXBDYek7VbknfSyDdipzkGz5008/j+oMGAqaB
 Qt9q1vG0+HA2WxFiw+h2KKCxCdpzEKYrbwlOnxKvfXfjS94K4DNjS4P7Ffv6G9yw1SG8zUIm
 9XSOXAd7dD0wekvhP0hSdt0026uR4=;
From: Quirin Gylstorff <Quirin.Gylstorff@siemens.com>
To: jan.kiszka@siemens.com,
	cip-dev@lists.cip-project.org,
	felix.moessbauer@siemens.com
Subject: [cip-dev][isar-cip-core][PATCH v4] swupdate.bbclass: add scripts section to the swu file
Date: Thu,  8 Feb 2024 11:45:28 +0100
Message-ID: <20240208104550.170816-1-Quirin.Gylstorff@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-51332:519-21489:flowmailer
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 08 Feb 2024 10:46:06 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/14919

From: Quirin Gylstorff <quirin.gylstorff@siemens.com>

This allows the user to add scripts[1] to the swu file by
setting the variable `SWU_SCRIPTS`. Scripts can be used to
prepare the system for an update.

```
SWU_SCRIPTS = "<script_file_name>@<script_type>@<optional_data>"
```
This will add  `file://<script_file_name>` to the variable `SRC_URI` and
`<script_file_name>` to `SWU_ADDTIONAL_FILES`. The sw-description will contain
the following section:
```
    scripts: (
        {
          filename = "<script_file_name>";
          type = "<script_type>";
          data = "<optional_data>";
          sha256 = "<automatically added sha256 of script_file_name>";
        },):
```

[1]: https://sbabic.github.io/swupdate/sw-description.html?#scripts

Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
---

Changes v4:
 - rebase onto next
Changes v3:
 - fix message
 - add luascript example to README

Changes v2:
 - change seperator from `:` to `@` as it already used for the
   configfilecheck
 - add optional data entry
 - add warning if less then 2 parameters are given for entry



 classes/swupdate.bbclass                    | 38 +++++++++++
 doc/README.swupdate.md                      | 71 +++++++++++++++++++++
 recipes-core/images/swu/sw-description.tmpl |  1 +
 3 files changed, 110 insertions(+)

diff --git a/classes/swupdate.bbclass b/classes/swupdate.bbclass
index 403bdef..0c451cc 100644
--- a/classes/swupdate.bbclass
+++ b/classes/swupdate.bbclass
@@ -57,6 +57,7 @@ IMAGE_TEMPLATE_VARS:swu = " \
     SWU_NAME \
     SWU_FILE_NODES \
     SWU_BOOTLOADER_FILE_NODE \
+    SWU_SCRIPTS_NODE \
     "
 
 # TARGET_IMAGE_UUID needs to be generated before completing the template
@@ -93,6 +94,43 @@ python add_swu_compression(){
         d.setVar('SWU_COMPRESSION_NODE', '')
 }
 
+
+SWU_EXTEND_SW_DESCRIPTION += "add_scripts"
+python add_scripts(){
+    swu_scripts = d.getVar('SWU_SCRIPTS')
+    if not swu_scripts:
+        return
+    swu_script_entries = [ s for s in swu_scripts.split() ]
+    script_node_list = []
+    for entry in swu_script_entries:
+        script_elems = entry.split('@')
+        if len(script_elems) < 2:
+            bb.warn(f"SWU_SCRIPTS entry:'{entry}' is missing elements.")
+            continue
+
+        script_file = script_elems[0]
+        script_type = script_elems[1]
+        script_data = None
+        if len(script_elems) > 2:
+            script_data = script_elems[2]
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
index 1c94699..1a7fa0f 100644
--- a/doc/README.swupdate.md
+++ b/doc/README.swupdate.md
@@ -21,6 +21,77 @@ window is still possible.
 If the variable `SWU_EBG_UPDATE` is set to `"1"` the update is also stored in
 the `*.swu` file.
 
+## SWUpdate scripts
+
+It is possible to add [scripts](https://sbabic.github.io/swupdate/sw-description.html?#scripts) to a swu file.
+
+To add a script entry in isar-cip-core set the variable `SWU_SCRIPTS`.
+The content of the variable has the following pattern:
+`<script_file_name>@<script_type>@<optional_data>`
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
+        },):
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
+SWU_SCRIPTS = "luascript.lua@lua@some_data"
+
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


