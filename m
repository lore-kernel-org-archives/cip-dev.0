Return-Path: <quirin.gylstorff@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8447FC47074
	for <webhook@archiver.kernel.org>; Fri, 29 Dec 2023 12:31:26 +0000 (UTC)
Received: from mta-65-225.siemens.flowmailer.net (mta-65-225.siemens.flowmailer.net [185.136.65.225])
 by mx.groups.io with SMTP id smtpd.web11.145487.1703853078463353453
 for <cip-dev@lists.cip-project.org>;
 Fri, 29 Dec 2023 04:31:19 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=Quirin.Gylstorff@siemens.com header.s=fm1 header.b=THjge/5n;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.65.225, mailfrom: fm-51332-202312291231165fe5ae272540efe3a0-oyqqz_@rts-flowmailer.siemens.com)
Received: by mta-65-225.siemens.flowmailer.net with ESMTPSA id 202312291231165fe5ae272540efe3a0
        for <cip-dev@lists.cip-project.org>;
        Fri, 29 Dec 2023 13:31:16 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=Quirin.Gylstorff@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:References:In-Reply-To;
 bh=iSo11YgGKfF26Tu508+zrphdN34J1DYOP5aRMP0zbbc=;
 b=THjge/5nA6udNt9mg9Omre4gR8cXP/9KXGDX5TzBSE5CZBH6GzVH715Klkg/l1k8cauhfy
 V4ftgeRCsTh83M+v/SD+T7Di9kngsAz7bbpynORpDnj7s6W0aKY9udwPM9VQkAl37jJGWR51
 j2Z2m1Tt0TFEHs3DW3Ox3lH2D6V8Q=;
From: Quirin Gylstorff <Quirin.Gylstorff@siemens.com>
To: felix.moessbauer@siemens.com,
	jan.kiszka@siemens.com,
	cip-dev@lists.cip-project.org
Subject: [cip-dev][isar-cip-core][RFC v3 4/5] classes: Generate sw-description from bitbake variables
Date: Fri, 29 Dec 2023 13:30:42 +0100
Message-ID: <20231229123111.400555-5-Quirin.Gylstorff@siemens.com>
In-Reply-To: <20231229123111.400555-1-Quirin.Gylstorff@siemens.com>
References: <20231229123111.400555-1-Quirin.Gylstorff@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-51332:519-21489:flowmailer
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 29 Dec 2023 12:31:26 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/14220

From: Quirin Gylstorff <quirin.gylstorff@siemens.com>

This adds the possibility to generate the sw-description files from
the following variables:
 - SWU_IMAGES: Contains the flags to install a image file
 - SWU_FILES: Contains the flags for single files
 - SWU_SCRIPTS: Contains the flags for installation scripts

To generate the sw-description add the following lines to the image
recipe:
```
inherit swupdate
inherit sw-description-generator.bbclass

SWU_IMAGES += "rootfs"
SWU_IMAGE_rootfs[filename] = "${SWU_ROOTFS_PARTITION_NAME}"
SWU_IMAGE_rootfs[device] = "C:BOOT0:linux.efi->${ABROOTFS_PART_UUID_A},C:BOOT1:linux.efi->${ABROOTFS_PART_UUID_B}"
SWU_IMAGE_rootfs[type] = "roundrobin"
SWU_IMAGE_rootfs[properties] += "subtype:image"
SWU_IMAGE_rootfs[properties] += "configfilecheck:/etc/os-release@not_match@IMAGE_UUID=${TARGET_IMAGE_UUID}"

SWU_FILES += "kernel"
SWU_FILE_kernel[filename] = "linux.efi"
SWU_FILE_kernel[path] = "linux.efi"
SWU_FILE_kernel[type] = "roundrobin"
SWU_FILE_kernel[device] = "C:BOOT0:linux.efi->BOOT0,C:BOOT1:linux.efi->BOOT1"
SWU_FILE_kernel[filesystem] = "vfat"
SWU_FILE_kernel[properties] = "subtype:kernel"

```

Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
---
 classes/sw-description-generator.bbclass      | 200 ++++++++++++++++++
 .../jsontolibconf/files/jsontolibconf         |  54 +++++
 .../jsontolibconf/jsontolibconf_0.1.bb        |  22 ++
 3 files changed, 276 insertions(+)
 create mode 100644 classes/sw-description-generator.bbclass
 create mode 100644 recipes-devtools/jsontolibconf/files/jsontolibconf
 create mode 100644 recipes-devtools/jsontolibconf/jsontolibconf_0.1.bb

diff --git a/classes/sw-description-generator.bbclass b/classes/sw-description-generator.bbclass
new file mode 100644
index 0000000..2e9f5e9
--- /dev/null
+++ b/classes/sw-description-generator.bbclass
@@ -0,0 +1,200 @@
+#
+# CIP Core, generic profile
+#
+# Copyright (c) Siemens AG, 2020-2023
+#
+# Authors:
+#  Quirin Gylstorff <quirin.gylstorff@siemens.com>
+#
+# SPDX-License-Identifier: MIT
+
+# This class generates the sw-description from the variables:
+SWU_IMAGES ??= ""
+SWU_FILES ??= ""
+SWU_SCRIPTS ??= ""
+
+# Each image/file/script added by these variables needs to be specified in
+# the following format. See also
+# https://sbabic.github.io/swupdate/sw-description.html
+
+# EXAMPLE configuration
+# the following configuration installs a new rootfs,kernel and
+# bootloader to the target
+#
+# Add the root filesystem image:
+# SWU_IMAGES += "rootfs"
+# SWU_IMAGE_rootfs[filename] = "${SWU_ROOTFS_PARTITION_NAME}"
+# SWU_IMAGE_rootfs[device] = "C:BOOT0:linux.efi->${ABROOTFS_PART_UUID_A},C:BOOT1:linux.efi->${ABROOTFS_PART_UUID_B}"
+# SWU_IMAGE_rootfs[type] = "roundrobin"
+# SWU_IMAGE_rootfs[compressed] = "zlib"
+# SWU_IMAGE_rootfs[properties] += "subtype:image"
+# SWU_IMAGE_rootfs[properties] += "configfilecheck:/etc/os-release@not_match@IMAGE_UUID=${TARGET_IMAGE_UUID}"
+#
+# Add the kernel file
+# SWU_FILES += "kernel"
+# SWU_FILE_kernel[filename] = "linux.efi"
+# SWU_FILE_kernel[path] = "linux.efi"
+# SWU_FILE_kernel[type] = "roundrobin"
+# SWU_FILE_kernel[device] = "C:BOOT0:linux.efi->BOOT0,C:BOOT1:linux.efi->BOOT1"
+# SWU_FILE_kernel[filesystem] = "vfat"
+# SWU_FILE_kernel[properties] = "subtype:kernel"
+#
+# Add the bootloader file
+# SWU_FILES += "ebg"
+# SWU_FILE_ebg[filename] = "bootx64.efi"
+# SWU_FILE_ebg[path] = "EFI/BOOT/bootx64.efi"
+# SWU_FILE_ebg[device] = "/dev/disk/by-uuid/4321-DCBA"
+# SWU_FILE_ebg[filesystem] = "vfat"
+#
+# Add some preinstallation script
+# SWU_SCRIPTS += "preinstall"
+# SWU_SCRIPT_preinstall[filename] = "preinstall.sh"
+# SWU_SCRIPT_preinstall[type] = "preinstall.sh"
+
+def add_flag_to_dict(d, var, flagname, dictionary):
+    flag = d.getVarFlag(var,  flagname) or ""
+    if flag:
+        dictionary.update({flagname: flag})
+
+
+def add_list_to_dict(d, var_entry, flagname, dictionary):
+    flag = d.getVarFlag(var_entry,  flagname) or ""
+    if flag:
+        entries = flag.split()
+        result = {}
+        for entry in entries:
+            key, value = entry.split(':')
+            result.update({key: value})
+        dictionary.update({flagname: result})
+
+
+def get_entries_from_var(d, entries_var, entry_var):
+    entries = (d.getVar(entries_var) or "").split()
+    if not entries:
+        return None
+    # see https://sbabic.github.io/swupdate/sw-description.html
+    # sha256 is added directly
+    # data, encrypted and hook are currently not supported
+    possible_image_flags = ("filename", "type",
+                            "device",
+                            "compressed", "name", "version",
+                            "install-if-different",
+                            "install-if-higher",
+                             "installed-directly",
+                            "offset", )
+    possible_file_flags = ("filename", "type",
+                           "device",
+                           "compressed", "name", "version",
+                           "install-if-different",
+                           "install-if-higher",
+                           "filesystem", "path", "preserve-attributes")
+    possible_script_flags = ("filename", "type")
+    entry_var_to_flags = {
+            "SWU_IMAGE": possible_image_flags,
+            "SWU_FILE": possible_file_flags,
+            "SWU_SCRIPT": possible_script_flags,
+    }
+
+    entry_list = []
+    for entry in entries:
+        elem = {}
+        var_entry = f"{entry_var}_{entry}"
+        for flag in entry_var_to_flags[entry_var]:
+            add_flag_to_dict(d, var_entry, flag, elem)
+            if flag == "filename":
+                # filename handling
+                filename = elem.get("filename")
+                if not filename:
+                    bb.warn(f"No filename for {var_entry}. Entry will not be added to sw-description")
+                    continue
+                elem.update({ "sha256": f"{filename}-sha256" })
+
+        add_list_to_dict(d, var_entry, "properties", elem)
+        entry_list.append(elem)
+    # we return a tuple as this allow to generate json or libconfig
+    # swuconfigurations
+    return tuple(entry_list)
+
+
+def generate_sw_description(d):
+    sw_description = {}
+    # in theory we can have multiple boards
+    # this is currently not support
+    board = {}
+    hw_compat = d.getVar('SWU_HW_COMPAT')
+    if hw_compat:
+        hw_entries = ', '. join(['"' + h + '"' for h in hw_compat.split()])
+        board.update({"hardware-compatibility": hw_entries})
+    #   Images
+    sw_images = get_entries_from_var(d, "SWU_IMAGES", "SWU_IMAGE")
+    if sw_images:
+        board.update({"images": sw_images})
+    #   Files
+    sw_files = get_entries_from_var(d, "SWU_FILES", "SWU_FILE")
+    if sw_files:
+        board.update({"files": sw_files})
+    #   Scripts
+    sw_scripts = get_entries_from_var(d, "SWU_SCRIPTS", "SWU_SCRIPT")
+    if sw_scripts:
+        board.update({"scripts": sw_scripts})
+
+    boardname = d.getVar("SWU_BOARD_NAME")
+    if boardname and hw_compat:
+        software.update({boardname: board})
+    else:
+        software = board
+
+    swu_version = d.getVar('SWU_VERSION')
+    name = d.getVar('SWU_NAME')
+    reboot = d.getVar('SWU_REBOOT')
+    transition_marker = d.get('SWU_BOOTLOADER_TRANSITION_MARKER')
+
+    software.update({'version': swu_version, 'name': name})
+    if reboot:
+        software.update({'reboot': reboot, })
+    if transition_marker:
+        software.update({'bootloader_transaction_marker':  transition_marker, })
+
+
+    sw_description.update({"software": software})
+
+    return sw_description
+
+
+covert_to_libconfig () {
+    if [ -e '${WORKDIR}/${SWU_DESCRIPTION_FILE}.json' ]; then
+        rm -f '${WORKDIR}/${SWU_DESCRIPTION_FILE}'
+        imager_run -p -d ${PP_WORK} -u root <<'EOIMAGER'
+    jsontolibconf '${PP_WORK}/${SWU_DESCRIPTION_FILE}.json' --output_file '${PP_WORK}/${SWU_DESCRIPTION_FILE}'
+EOIMAGER
+    fi
+    sudo chown -R $(id -u):$(id -g) '${WORKDIR}/${SWU_DESCRIPTION_FILE}'
+}
+
+IMAGER_BUILD_DEPS += "jsontolibconf"
+INSTALL_write_sw_description += "jsontolibconf"
+
+do_write_sw_description[network] = "${TASK_USE_SUDO}"
+python do_write_sw_description () {
+    import json
+    import os
+    workdir = d.getVar("WORKDIR")
+    sw_desc_file = d.getVar("SWU_DESCRIPTION_FILE")
+    swu_files = (d.getVar('SWU_IMAGES'), d.getVar('SWU_FILES'), d.getVar('SWU_SCRIPTS'))
+    if os.path.exists(f"{workdir}/{sw_desc_file}.tmpl") and \
+        [x for x in swu_files if x is not None]:
+        bb.warn(f"{sw_desc_file}.tmpl template exists. \
+                sw-description will not be be generate from variables \
+                SWU_IMAGES, SWU_FILES and SWU_SCRIPTS")
+        pass
+    sw_description = generate_sw_description(d)
+
+    with open(f"{workdir}/{sw_desc_file}.json","w") as sw_desc_fd:
+        json.dump(sw_description, sw_desc_fd, indent=2)
+    bb.build.exec_func("covert_to_libconfig", d)
+}
+
+IMAGE_SRC_URI:swu:remove = "file://${SWU_DESCRIPTION_FILE}.tmpl"
+IMAGE_TEMPLATE_FILES:swu:remove = "${SWU_DESCRIPTION_FILE}.tmpl"
+
+addtask do_write_sw_description after do_generate_image_uuid before do_transform_template
diff --git a/recipes-devtools/jsontolibconf/files/jsontolibconf b/recipes-devtools/jsontolibconf/files/jsontolibconf
new file mode 100644
index 0000000..897daa3
--- /dev/null
+++ b/recipes-devtools/jsontolibconf/files/jsontolibconf
@@ -0,0 +1,54 @@
+#!/usr/bin/env python3
+#
+# CIP Core, generic profile
+#
+# Copyright (c) Siemens AG, 2023
+#
+# Authors:
+#  Quirin Gylstorff <quirin.gylstorff@siemens.com>
+#
+# SPDX-License-Identifier: MIT
+
+import json
+import libconf
+import argparse
+from os import path
+from sys import exit
+
+
+def convert_lists_to_tuples(obj):
+    if isinstance(obj, list):
+        return tuple(obj)
+    elif isinstance(obj, dict):
+        return {key: convert_lists_to_tuples(value) for key, value in obj.items()}
+    else:
+        return obj
+
+
+def convert_json_to_libconfig(input_file, output_file):
+    if not path.exists(input_file):
+        print(f"Error: The file {input_file} does not exists. Abort!")
+        exit(1)
+
+    with open(input_file, "r") as json_fd:
+        json_obj = json.load(json_fd)
+
+    converted_json_obj = convert_lists_to_tuples(json_obj)
+
+    libconf_data = libconf.dumps(converted_json_obj)
+    if output_file:
+        with open(output_file, "w") as libconf_fd:
+            libconf_fd.write(libconf_data)
+    else:
+        print(libconf_data)
+
+
+if __name__ == "__main__":
+    parser = argparse.ArgumentParser(
+        description="Convert a json file to a libconfig file"
+    )
+    parser.add_argument("input_file", help="Input JSON file name")
+    parser.add_argument("--output_file", help="Output libconfig file name")
+
+    args = parser.parse_args()
+    convert_json_to_libconfig(args.input_file, args.output_file)
diff --git a/recipes-devtools/jsontolibconf/jsontolibconf_0.1.bb b/recipes-devtools/jsontolibconf/jsontolibconf_0.1.bb
new file mode 100644
index 0000000..97a5d5f
--- /dev/null
+++ b/recipes-devtools/jsontolibconf/jsontolibconf_0.1.bb
@@ -0,0 +1,22 @@
+#
+# CIP Core, generic profile
+#
+# Copyright (c) Siemens AG, 2023
+#
+# Authors:
+#  Quirin Gylstorff <quirin.gylstorff@siemens.com>
+#
+# SPDX-License-Identifier: MIT
+
+inherit dpkg-raw
+
+SRC_URI = "file://jsontolibconf"
+
+DEBIAN_DEPENDS = "python3-libconf"
+
+DPKG_ARCH = "all"
+
+do_install[cleandirs] = "${D}/usr/bin"
+do_install() {
+    install -m 755 ${WORKDIR}/jsontolibconf ${D}/usr/bin/
+}
-- 
2.43.0


