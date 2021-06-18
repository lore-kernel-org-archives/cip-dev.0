Return-Path: <SRS0=QITl=LM=lists.cip-project.org=bounce+64572+6541+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04A3CC48BDF
	for <cip-dev@archiver.kernel.org>; Fri, 18 Jun 2021 18:08:43 +0000 (UTC)
Received: from mail02.groups.io (mail02.groups.io [66.175.222.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3F1216127C
	for <cip-dev@archiver.kernel.org>; Fri, 18 Jun 2021 18:08:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3F1216127C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=siemens.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+6541+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id 3ltoYY4521723xlFQwRnwfM1; Fri, 18 Jun 2021 11:08:41 -0700
X-Received: from thoth.sbs.de (thoth.sbs.de [192.35.17.2])
 by mx.groups.io with SMTP id smtpd.web12.11669.1624039720843190763
 for <cip-dev@lists.cip-project.org>;
 Fri, 18 Jun 2021 11:08:41 -0700
X-Received: from mail1.sbs.de (mail1.sbs.de [192.129.41.35])
	by thoth.sbs.de (8.15.2/8.15.2) with ESMTPS id 15II8b6x003420
	(version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <cip-dev@lists.cip-project.org>; Fri, 18 Jun 2021 20:08:38 +0200
X-Received: from md2dvrtc.fritz.box ([139.22.32.20])
	by mail1.sbs.de (8.15.2/8.15.2) with ESMTP id 15II8bjK001260;
	Fri, 18 Jun 2021 20:08:37 +0200
From: "Quirin Gylstorff" <quirin.gylstorff@siemens.com>
To: jan.kiszka@siemens.com, cip-dev@lists.cip-project.org
Cc: Quirin Gylstorff <quirin.gylstorff@siemens.com>
Subject: [cip-dev][isar-cip-core][PATCH v2 1/1] swupdate: Add option to use swupdate-handler-roundrobin
Date: Fri, 18 Jun 2021 20:08:36 +0200
Message-Id: <20210618180836.3387-2-Quirin.Gylstorff@siemens.com>
In-Reply-To: <20210618180836.3387-1-Quirin.Gylstorff@siemens.com>
References: <e36534ba-4ea0-5751-ad5e-d8103deb6549@siemens.com>
 <20210618180836.3387-1-Quirin.Gylstorff@siemens.com>
MIME-Version: 1.0
Precedence: Bulk
List-Unsubscribe: <mailto:cip-dev+unsubscribe@lists.cip-project.org>
List-Subscribe: <mailto:cip-dev+subscribe@lists.cip-project.org>
List-Help: <mailto:cip-dev+help@lists.cip-project.org>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: DrH9jZiNjFMrdlVPQxu0TSsox4520388AA=
Content-Type: multipart/mixed; boundary="PWU11D454MkVjO1a77sJ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1624039721;
 bh=4Sd0cHb0Te5rfZqewEf3hD9iGGhAe7HIrfM/XRILde0=;
 h=Cc:Content-Type:Date:From:Reply-To:Subject:To;
 b=B6M+uwUevaoOP9PVaSei/ffjVhRyAkW0SnGNPx2ia4oV7kiuxZPFGIEC5QH+oePrfvV
 ijxbEpLwyE2FG+5KshNxjp5klaqYtqkvLYMysFwNRee+h6t5RqZjqb4PnHuwARX6tdSb3
 4Cpr1fFfBsPGMKauaHjZ8rwNpFCHec6xlFI=

--PWU11D454MkVjO1a77sJ
Content-Transfer-Encoding: 8bit

From: Quirin Gylstorff <quirin.gylstorff@siemens.com>

The new SWUpdate round-robin handler is available under[1].
Add the Option `SWUPDATE_HANDLER_BOOT_HANDLER_CONFIG` to
set the source of the swupdate-handler-roundrobin configuration.

If another Lua handler should be used,  set the variable
`SWUPDATE_USE_ROUND_ROBIN_HANDLER_REPO` to `0`. Add the alternative
handler to the repository and use the variable
`SWUPDATE_LUASCRIPT` to add the handler to the build.

[1]: https://gitlab.com/cip-project/cip-sw-updates/swupdate-handler-roundrobin

Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
---
 classes/swupdate-config.bbclass               |  14 +-
 kas/opt/ebg-secure-boot-base.yml              |   1 +
 .../files/secure-boot/sw-description.tmpl     |  14 +-
 recipes-core/images/files/sw-description.tmpl |  21 +-
 .../swupdate.handler.efibootguard.ini         |  16 +
 .../files/swupdate.handler.efibootguard.ini   |  26 +
 .../swupdate/files/swupdate_handlers.lua      | 453 ------------------
 recipes-core/swupdate/swupdate.bb             |  13 +-
 8 files changed, 90 insertions(+), 468 deletions(-)
 create mode 100644 recipes-core/swupdate/files/secureboot/swupdate.handler.efibootguard.ini
 create mode 100644 recipes-core/swupdate/files/swupdate.handler.efibootguard.ini
 delete mode 100644 recipes-core/swupdate/files/swupdate_handlers.lua

diff --git a/classes/swupdate-config.bbclass b/classes/swupdate-config.bbclass
index f67ca4f..dfa3579 100644
--- a/classes/swupdate-config.bbclass
+++ b/classes/swupdate-config.bbclass
@@ -17,14 +17,22 @@ BUILD_DEB_DEPENDS = " \
     zlib1g-dev, debhelper, libconfig-dev, libarchive-dev, \
     python-sphinx:native, dh-systemd, libsystemd-dev, libssl-dev, pkg-config"
 
+SRC_URI += " ${@ 'git://gitlab.com/cip-project/cip-sw-updates/swupdate-handler-roundrobin.git;protocol=https;destsuffix=swupdate-handler-roundrobin;name=swupdate-handler-roundrobin;nobranch=1' \
+    if d.getVar('SWUPDATE_USE_ROUND_ROBIN_HANDLER_REPO') == '1' else '' \
+    }"
+SRCREV_swupdate-handler-roundrobin ?= "6f561f136fdbe51d2e9066b934dfcb06b94c6624"
+
+SWUPDATE_USE_ROUND_ROBIN_HANDLER_REPO ?= "1"
+SWUPDATE_LUASCRIPT ?= "swupdate-handler-roundrobin/swupdate_handlers_roundrobin.lua"
+
 KFEATURE_lua = ""
 KFEATURE_lua[BUILD_DEB_DEPENDS] = "liblua5.3-dev"
 KFEATURE_lua[KCONFIG_SNIPPETS] = "file://swupdate_defconfig_lua.snippet"
 
 KFEATURE_luahandler = ""
 KFEATURE_luahandler[KCONFIG_SNIPPETS] = "file://swupdate_defconfig_luahandler.snippet"
-KFEATURE_luahandler[SRC_URI] = "file://${SWUPDATE_LUASCRIPT}"
-
+KFEATURE_luahandler[SRC_URI] = "${@ 'file://${SWUPDATE_LUASCRIPT}' \
+                                  if d.getVar('SWUPDATE_USE_ROUND_ROBIN_HANDLER_REPO') == '0' else '' }"
 KFEATURE_DEPS = ""
 KFEATURE_DEPS[luahandler] = "lua"
 
@@ -59,8 +67,6 @@ KFEATURE_u-boot[DEPENDS] = "${@ 'libubootenv u-boot-${MACHINE}-config' \
                                           else 'libubootenv'}"
 KFEATURE_u-boot[KCONFIG_SNIPPETS] = "file://swupdate_defconfig_u-boot.snippet"
 
-SWUPDATE_LUASCRIPT ?= "swupdate_handlers.lua"
-
 def get_bootloader_featureset(d):
     bootloader = d.getVar("SWUPDATE_BOOTLOADER", True) or ""
     if bootloader == "efibootguard":
diff --git a/kas/opt/ebg-secure-boot-base.yml b/kas/opt/ebg-secure-boot-base.yml
index 35fb42e..8182bd8 100644
--- a/kas/opt/ebg-secure-boot-base.yml
+++ b/kas/opt/ebg-secure-boot-base.yml
@@ -18,3 +18,4 @@ local_conf_header:
   initramfs: |
     IMAGE_INSTALL += "initramfs-abrootfs-secureboot"
     SWU_DESCRIPTION = "secureboot"
+    SWUPDATE_ROUND_ROBIN_HANDLER_CONFIG = "secureboot/swupdate.handler.${SWUPDATE_BOOTLOADER}.ini"
diff --git a/recipes-core/images/files/secure-boot/sw-description.tmpl b/recipes-core/images/files/secure-boot/sw-description.tmpl
index bce97d0..34a58a3 100644
--- a/recipes-core/images/files/secure-boot/sw-description.tmpl
+++ b/recipes-core/images/files/secure-boot/sw-description.tmpl
@@ -14,16 +14,22 @@ software =
     name = "secure boot update"
     images: ({
             filename = "${ROOTFS_PARTITION_NAME}";
-            device = "fedcba98-7654-3210-cafe-5e0710000001,fedcba98-7654-3210-cafe-5e0710000002";
+            device = "sda4,sda5";
             type = "roundrobin";
-            compressed = "true";
+            compressed = "zlib";
             filesystem = "ext4";
+            properties: {
+                        subtype = "image";
+            };
     });
     files: ({
             filename = "linux.signed.efi";
             path = "linux.signed.efi";
-            type = "kernelfile";
-            device = "sda2,sda3";
+            type = "roundrobin";
+            device = "sda4->sda2,sda5->sda3";
             filesystem = "vfat";
+            properties: {
+                        subtype = "kernel";
+            };
     })
 }
diff --git a/recipes-core/images/files/sw-description.tmpl b/recipes-core/images/files/sw-description.tmpl
index bb34088..3309271 100644
--- a/recipes-core/images/files/sw-description.tmpl
+++ b/recipes-core/images/files/sw-description.tmpl
@@ -16,21 +16,30 @@ software =
             filename = "${ROOTFS_PARTITION_NAME}";
             device = "fedcba98-7654-3210-cafe-5e0710000001,fedcba98-7654-3210-cafe-5e0710000002";
             type = "roundrobin";
-            compressed = "true";
+            compressed = "zlib";
             filesystem = "ext4";
+            properties: {
+                        subtype = "image";
+            };
     });
     files: ({
             filename = "${KERNEL_IMAGE}";
             path = "vmlinuz";
-            type = "kernelfile";
-            device = "sda2,sda3";
+            type = "roundrobin";
+            device = "fedcba98-7654-3210-cafe-5e0710000001->sda2,fedcba98-7654-3210-cafe-5e0710000002->sda3";
             filesystem = "vfat";
+            properties: {
+                        subtype = "kernel";
+            };
     },
     {
             filename = "${INITRD_IMAGE}";
-            path = "initrd.img";
-            type = "kernelfile";
-            device = "sda2,sda3";
+            path = "${INITRD_IMAGE}";
+            type = "roundrobin";
+            device = "fedcba98-7654-3210-cafe-5e0710000001->sda2,fedcba98-7654-3210-cafe-5e0710000002->sda3";
             filesystem = "vfat";
+            properties: {
+                        subtype = "initrd";
+            };
     });
 }
diff --git a/recipes-core/swupdate/files/secureboot/swupdate.handler.efibootguard.ini b/recipes-core/swupdate/files/secureboot/swupdate.handler.efibootguard.ini
new file mode 100644
index 0000000..4a109b7
--- /dev/null
+++ b/recipes-core/swupdate/files/secureboot/swupdate.handler.efibootguard.ini
@@ -0,0 +1,16 @@
+[image]
+chainhandler=raw
+
+[image.selector]
+method=getroot_rr
+key=root
+
+[kernel]
+chainhandler=rawfile
+
+[kernel.selector]
+method=getroot_rrmap
+key=root
+
+[kernel.bootenv]
+kernelfile=C:BOOT${rrindex}:linux.signed.efi
diff --git a/recipes-core/swupdate/files/swupdate.handler.efibootguard.ini b/recipes-core/swupdate/files/swupdate.handler.efibootguard.ini
new file mode 100644
index 0000000..3aee76c
--- /dev/null
+++ b/recipes-core/swupdate/files/swupdate.handler.efibootguard.ini
@@ -0,0 +1,26 @@
+[image]
+chainhandler=raw
+
+[image.selector]
+method=cmdline_rr
+key=root
+
+[image.bootenv]
+kernelparams=root=PARTUUID=${rrtarget} ${cmdline_root}
+
+[kernel]
+chainhandler=rawfile
+
+[kernel.selector]
+method=cmdline_rrmap
+key=root
+
+[kernel.bootenv]
+kernelfile=C:BOOT${rrindex}:vmlinuz
+
+[initrd]
+chainhandler=rawfile
+
+[initrd.selector]
+method=cmdline_rrmap
+key=root
diff --git a/recipes-core/swupdate/files/swupdate_handlers.lua b/recipes-core/swupdate/files/swupdate_handlers.lua
deleted file mode 100644
index f2ecc54..0000000
--- a/recipes-core/swupdate/files/swupdate_handlers.lua
+++ /dev/null
@@ -1,453 +0,0 @@
---[[
-
-    Round-robin Image and File Handler.
-
-    Copyright (C) 2019, Siemens AG
-
-    Author: Christian Storm <christian.storm@siemens.com>
-
-    SPDX-License-Identifier: GPL-2.0-or-later
-
-    An `sw-description` file using these handlers may look like:
-        software =
-        {
-            version = "0.1.0";
-            images: ({
-                filename = "rootfs.ext4";
-                device = "sda4,sda5";
-                type = "roundrobin";
-                compressed = false;
-            });
-            files: ({
-                filename = "vmlinuz";
-                path = "vmlinuz";
-                type = "kernelfile";
-                device = "sda2,sda3";
-                filesystem = "vfat";
-            },
-            {
-                filename = "initrd.img";
-                path = "initrd.img";
-                type = "kernelfile";
-                device = "sda2,sda3";
-                filesystem = "vfat";
-            });
-        }
-
-    The semantics is as follows: Instead of having a fixed target device,
-    the 'roundrobin' image handler calculates the target device by parsing
-    /proc/cmdline, matching the root=<device> kernel parameter against its
-    'device' attribute's list of devices, and sets the actual target
-    device to the next 'device' attribute list entry in a round-robin
-    manner. The actual flashing is done via chain-calling another handler,
-    defaulting to the "raw" handler.
-
-    The 'kernelfile' file handler reuses the 'roundrobin' handler's target
-    device calculation by reading the actual target device from the same
-    index into its 'device' attribute's list of devices. The actual placing
-    of files into this partition is done via chain-calling another handler,
-    defaulting to the "rawfile" handler.
-
-    In the above example, if /dev/sda4 is currently booted according to
-    /proc/cmdline, /dev/sda5 will be flashed and the vmlinuz and initrd.img
-    files will be placed on /dev/sda3. If /dev/sda5 is booted, /dev/sda4
-    will be flashed and the vmlinuz and initrd.img files are placed on
-    /dev/sda2.
-    In addition to "classical" device nodes as in this example, partition
-    UUIDs as reported, e.g., by `blkid -s PARTUUID` are also supported.
-    UBI volumes are supported as well by specifying a CSV list of
-    ubi<number>:<label> items.
-
-    Configuration is done via an INI-style configuration file located at
-    /etc/swupdate.handler.ini or via compiled-in configuration (by
-    embedding the Lua handler script into the SWUpdate binary via using
-    CONFIG_EMBEDDED_LUA_HANDLER), the latter having precedence over the
-    former. See the example configuration below.
-    If uncommenting this example block, it will take precedence over any
-    /etc/swupdate.handler.ini configuration file.
-
-    The chain-called handlers can either be specified in the configuration,
-    i.e., a static run-time setting, or via the 'chainhandler' property of
-    an 'image' or 'file' section in the sw-description, with the latter
-    taking precedence over the former, e.g.,
-        ...
-        images: ({
-                filename = "rootfs.ext4";
-                device = "sda4,sda5";
-                type = "roundrobin";
-                properties: {
-                    chainhandler = "myraw";
-                };
-            });
-        ...
-    Such a sw-description fragment will chain-call the imaginary "myraw"
-    handler regardless of what's been configured in the compiled-in or the
-    configuration file.
-    When chain-calling the "rdiff_image" handler, its 'rdiffbase' property
-    is subject to round-robin as well, i.e., the 'rdiffbase' property is
-    expected to be a CSV list as for the 'device' property, and the actual
-    'rdiffbase' property value is calculated following the same round-robin
-    calculation mechanism stated above prior to chain-calling the actual
-    "rdiff_image" handler, e.g.,
-        images: ({
-                filename = "rootfs.ext4";
-                type = "roundrobin";
-                device = "sda4,sda5";
-                properties: {
-                    chainhandler = "rdiff_image";
-                    rdiffbase="sda1,sda2";
-                };
-            });
-    will set the 'rdiffbase' property to /dev/sda2 (/dev/sda1) if /dev/sda4
-    (/dev/sda5) is the currently booted root file system according to
-    /proc/cmdline parsing.
-
-]]
-
-
-local configuration = [[
-[bootloader]
-# Required: bootloader name, uboot and ebg currently supported.
-name=ebg
-# Required: bootloader-specific key-value pairs, e.g., for ebg:
-kernelname=linux.signed.efi
-# For relying on FAT labels, prefix bootlabels with 'L:', e.g., L:BOOT0.
-# For using custom labels, i.e., relying on the contents of an EFILABEL
-# file within the partition, prefix it with 'C:', e.g., C:BOOT0.
-bootlabel={ "C:BOOT0:", "C:BOOT1:" }
-
-# Optional: handler to chain-call for the 'roundrobin' handler,
-# defaulting to 'raw'
-[roundrobin]
-chainhandler=raw
-
-# Optional: handler to chain-call for the 'kernelfile' handler,
-# defaulting to 'rawfile'
-[kernelfile]
-chainhandler=rawfile
-]]
-
--- Default configuration file, tried if no compiled-in config is available.
-local cfgfile = "/etc/swupdate.handler.ini"
-
--- Table holding the configuration.
-local config = {}
-
--- Mandatory configuration [section] and keys
-local BOOTLOADERCFG = {
-    ebg   = {
-        bootloader = {"name", "bootlabel", "kernelname"}
-    },
-    -- TODO fill with mandatory U-Boot configuration
-    uboot = {
-        bootloader = {"name"}
-    }
-}
-
--- enum-alikes to make code more readable
-local BOOTLOADER = { EBG = "ebg", UBOOT = "uboot" }
-local PARTTYPE   = { UUID = 1, PLAIN = 2, UBI = 3 }
-
--- Target table describing the target device the image is to be/has been flashed to.
-local rrtarget = {
-    size = function(self)
-        local _size = 0
-        for index in pairs(self) do _size = _size + 1 end
-        return _size - 1
-    end
-}
-
--- Helper function parsing CSV fields of a struct img_type such as
--- the "device" fields or the "rdiffbase" property.
-local get_device_list = function(device_node_csv_list)
-    local device_list = {}
-    for item in device_node_csv_list:gmatch("([^,]+)") do
-        local device_node = item:gsub("/dev/", "")
-        device_list[#device_list+1] = device_node
-        device_list[device_node] = #device_list
-    end
-    return device_list
-end
-
--- Helper function to determine device node location.
-local get_device_path = function(device_node)
-    if device_node:match("ubi%d+:%S+") then
-        return 0, device_node, PARTTYPE.UBI
-    end
-    local device_path = string.format("/dev/disk/by-partuuid/%s", device_node)
-    local file = io.open(device_path, "rb" )
-    if file then
-        file:close()
-        return 0, device_path, PARTTYPE.UUID
-    end
-    device_path = string.format("/dev/%s", device_node)
-    file = io.open(device_path, "rb" )
-    if file then
-        file:close()
-        return 0, device_path, PARTTYPE.PLAIN
-    end
-    swupdate.error(string.format("Cannot access target device node /dev/{,disk/by-partuuid}/%s", device_node))
-    return 1, nil, nil
-end
-
--- Helper function parsing the INI-style configuration.
-local get_config = function()
-    -- Return configuration right away if it's already parsed.
-    if config ~= nil and #config > 0 then
-        return config
-    end
-
-    -- Get configuration INI-style string.
-    if not configuration then
-        swupdate.trace(string.format("No compiled-in config found, trying %s", cfgfile))
-        local file = io.open(cfgfile, "r" )
-        if not file then
-            swupdate.error(string.format("Cannot open config file %s", cfgfile))
-            return nil
-        end
-        configuration = file:read("*a")
-        file:close()
-    end
-    if configuration:sub(-1) ~= "\n" then
-        configuration=configuration.."\n"
-    end
-
-    -- Parse INI-style contents into config table.
-    local sec, key, value
-    for line in configuration:gmatch("(.-)\n") do
-        if line:match("^%[([%w%p]+)%][%s]*") then
-            sec = line:match("^%[([%w%p]+)%][%s]*")
-            config[sec] = {}
-        elseif sec then
-            key, value = line:match("^([%w%p]-)=(.*)$")
-            if key and value then
-                if tonumber(value)  then value = tonumber(value) end
-                if value == "true"  then value = true            end
-                if value == "false" then value = false           end
-                if value:sub(1,1) == "{" then
-                    local _value = {}
-                    for _key, _ in value:gmatch("\"(%S+)\"") do
-                        table.insert(_value, _key)
-                    end
-                    value = _value
-                end
-                config[sec][key] = value
-            else
-                if not line:match("^$") and not line:match("^#") then
-                    swupdate.warn(string.format("Syntax error, skipping '%s'", line))
-                end
-            end
-        else
-            swupdate.error(string.format("Syntax error. no [section] encountered."))
-            return nil
-        end
-    end
-
-    -- Check config table for mandatory key existence.
-    if config["bootloader"] == nil or config["bootloader"]["name"] == nil then
-        swupdate.error(string.format("Syntax error. no [bootloader] encountered or name= missing therein."))
-        return nil
-    end
-    local bcfg = BOOTLOADERCFG[config.bootloader.name]
-    if not bcfg then
-        swupdate.error(string.format("Bootloader unsupported, name=uboot|ebg missing in [bootloader]?."))
-        return nil
-    end
-    for sec, _ in pairs(bcfg) do
-        for _, key in pairs(bcfg[sec]) do
-            if config[sec] == nil or config[sec][key] == nil then
-                swupdate.error(string.format("Mandatory config key %s= in [%s] not found.", key, sec))
-            end
-        end
-    end
-
-    return config
-end
-
--- Round-robin image handler for updating the root partition.
-function handler_roundrobin(image)
-    -- Read configuration.
-    if not get_config() then
-        swupdate.error("Cannot read configuration.")
-        return 1
-    end
-
-    -- Check if we can chain-call the handler.
-    local chained_handler = "raw"
-    if image.properties ~= nil and image.properties["chainhandler"] ~= nil then
-        chained_handler = image.properties["chainhandler"]
-    elseif config["roundrobin"] ~= nil and config["roundrobin"]["chainhandler"] ~= nil then
-        chained_handler = config["roundrobin"]["chainhandler"]
-    end
-    if not swupdate.handler[chained_handler] then
-        swupdate.error(string.format("'%s' handler not available in SWUpdate distribution.", chained_handler))
-        return 1
-    end
-
-    -- Get device list for round-robin.
-    local devices = get_device_list(image.device)
-    if #devices < 2 then
-        swupdate.error("Specify at least 2 devices in the device= property for 'roundrobin'.")
-        return 1
-    end
-
-    -- Check that rrtarget is unset, else a reboot may be pending.
-    if rrtarget:size() > 0 then
-        swupdate.warn("The 'roundrobin' handler has been run. Is a reboot pending?")
-    end
-
-    -- Determine current root device.
-    local file = io.open("/proc/cmdline", "r")
-    if not file then
-        swupdate.error("Cannot open /proc/cmdline.")
-        return 1
-    end
-    local cmdline = file:read("*l")
-    file:close()
-
-    local rootparam, rootdevice
-    for item in cmdline:gmatch("%S+") do
-        rootparam, rootdevice = item:match("(root=[%u=]*[/dev/]*(%S+))")
-        if rootparam and rootdevice then break end
-    end
-    if not rootdevice then
-        -- Use findmnt to get the rootdev
-      rootdevice = io.popen('findmnt -nl / -o PARTUUID'):read("*l")
-      if not rootdevice then
-        swupdate.error("Cannot determine current root device.")
-        return 1
-      end
-    end
-    swupdate.info(string.format("Current root device is: %s", rootdevice))
-
-    if not devices[rootdevice] then
-        swupdate.error(string.format("Current root device '%s' is not in round-robin root devices list: %s", rootdevice, image.device:gsub("/dev/", "")))
-        return 1
-    end
-
-    -- Perform round-robin calculation for target.
-    local err
-    rrtarget.index = devices[rootdevice] % #devices + 1
-    rrtarget.device_node = devices[rrtarget.index]
-    err, rrtarget.device_path, rrtarget.parttype = get_device_path(devices[rrtarget.index])
-    if err ~= 0 then
-        return 1
-    end
-    swupdate.info(string.format("Using '%s' as 'roundrobin' target via '%s' handler.", rrtarget.device_path, chained_handler))
-
-    -- If the chain-called handler is rdiff_image, adapt the rdiffbase property
-    if chained_handler == "rdiff_image" then
-        if image.properties ~= nil and image.properties["rdiffbase"] ~= nil then
-            local rdiffbase_devices = get_device_list(image.properties["rdiffbase"])
-            if #rdiffbase_devices < 2 then
-                swupdate.error("Specify at least 2 devices in the rdiffbase= property for 'roundrobin'.")
-                return 1
-            end
-            err, image.propierties["rdiffbase"], _ = get_device_path(rdiffbase_devices[rrtarget.index])
-            if err ~= 0 then
-                return 1
-            end
-            swupdate.info(string.format("Using device %s as rdiffbase.", image.properties["rdiffbase"]))
-        else
-            swupdate.error("Property 'rdiffbase' is missing in sw-description.")
-            return 1
-        end
-    end
-
-    -- Actually flash the partition.
-    local msg
-    image.type = chained_handler
-    image.device = rrtarget.device_path
-    err, msg = swupdate.call_handler(chained_handler, image)
-    if err ~= 0 then
-        swupdate.error(string.format("Error chain-calling '%s' handler: %s", chained_handler, (msg or "")))
-        return 1
-    end
-
-    if config.bootloader.name == BOOTLOADER.EBG then
-      if rootparam then
-        local value = cmdline:gsub(
-            rootparam:gsub("%-", "%%-"),
-            string.format("root=%s%s",
-                (rrtarget.parttype == PARTTYPE.PLAIN and "") or (rrtarget.parttype == PARTTYPE.UBI and "") or "PARTUUID=",
-                 rrtarget.parttype == PARTTYPE.PLAIN and rrtarget.device_path or devices[rrtarget.index]
-            )
-        )
-        swupdate.info(string.format("Setting EFI Bootguard environment: kernelparams=%s", value))
-        swupdate.set_bootenv("kernelparams", value)
-      end
-    elseif config.bootloader.name == BOOTLOADER.UBOOT then
-        -- Update U-Boot environment.
-        swupdate.info(string.format("Setting U-Boot environment"))
-        local value = rrtarget.index
-        swupdate.set_bootenv("swupdpart", value);
-    end
-
-    return 0
-end
-
--- File handler for updating kernel files.
-function handler_kernelfile(image)
-    -- Check if we can chain-call the handler.
-    local chained_handler = "rawfile"
-    if image.properties ~= nil and image.properties["chainhandler"] ~= nil then
-        chained_handler = image.properties["chainhandler"]
-    elseif config["kernelfile"] ~= nil and config["kernelfile"]["chainhandler"] ~= nil then
-        chained_handler = config["kernelfile"]["chainhandler"]
-    end
-    if not swupdate.handler[chained_handler] then
-        swupdate.error(string.format("'%s' handler not available in SWUpdate distribution."), chained_handler)
-        return 1
-    end
-
-    -- Check that rrtarget is set, else the 'roundrobin' handler hasn't been run.
-    if rrtarget:size() == 0 then
-        swupdate.error("The 'roundrobin' handler hasn't been run.")
-        swupdate.info("Place 'roundrobin' above 'kernelfile' in sw-description.")
-        return 1
-    end
-
-    -- Get device list for round-robin.
-    local devices = get_device_list(image.device)
-    if #devices < 2 then
-        swupdate.error("Specify at least 2 devices in the device= property for 'kernelfile'.")
-        return 1
-    end
-    if rrtarget.index > #devices then
-        swupdate.error("Cannot map kernel partition to root partition.")
-        return 1
-    end
-
-    -- Perform round-robin indexing for target.
-    local err
-    err, image.device, _ = get_device_path(devices[rrtarget.index])
-    if err ~= 0 then
-        return 1
-    end
-    swupdate.info(string.format("Using '%s' as 'kernelfile' target via '%s' handler.", image.device, chained_handler))
-
-    -- Actually copy the 'kernelfile' files.
-    local msg
-    image.type = chained_handler
-    err, msg = swupdate.call_handler(chained_handler, image)
-    if err ~= 0 then
-        swupdate.error(string.format("Error chain-calling '%s' handler: %s", chained_handler, (msg or "")))
-        return 1
-    end
-
-    if config.bootloader.name == BOOTLOADER.EBG then
-        -- Update EFI Boot Guard environment: kernelfile
-        local value = string.format("%s%s", config.bootloader.bootlabel[rrtarget.index], config.bootloader.kernelname)
-        swupdate.info(string.format("Setting EFI Bootguard environment: kernelfile=%s", value))
-        swupdate.set_bootenv("kernelfile", value)
-    elseif config.bootloader.name == BOOTLOADER.UBOOT then
-        -- Update U-Boot environment.
-        swupdate.info(string.format("Setting U-Boot environment"))
-        -- TODO
-    end
-
-    return 0
-end
-
-swupdate.register_handler("roundrobin", handler_roundrobin, swupdate.HANDLER_MASK.IMAGE_HANDLER)
-swupdate.register_handler("kernelfile", handler_kernelfile, swupdate.HANDLER_MASK.FILE_HANDLER)
diff --git a/recipes-core/swupdate/swupdate.bb b/recipes-core/swupdate/swupdate.bb
index 75eaf8d..4984a63 100644
--- a/recipes-core/swupdate/swupdate.bb
+++ b/recipes-core/swupdate/swupdate.bb
@@ -29,6 +29,8 @@ DEBIAN_DEPENDS = "${shlibs:Depends}, ${misc:Depends}"
 inherit dpkg
 inherit swupdate-config
 
+SWUPDATE_ROUND_ROBIN_HANDLER_CONFIG ?= "swupdate.handler.${SWUPDATE_BOOTLOADER}.ini"
+SRC_URI += "file://${SWUPDATE_ROUND_ROBIN_HANDLER_CONFIG}"
 KFEATURES += "luahandler"
 
 S = "${WORKDIR}/git"
@@ -46,5 +48,14 @@ do_prepare_build() {
         echo "configs/${DEFCONFIG}" >> ${S}/.gitignore
     fi
     # luahandler
-    install -m 0644 ${WORKDIR}/${SWUPDATE_LUASCRIPT} ${S}
+    if [ -e ${WORKDIR}/${SWUPDATE_LUASCRIPT} ]; then
+        install -m 0644 ${WORKDIR}/${SWUPDATE_LUASCRIPT} ${S}/swupdate_handlers.lua
+    fi
+    if [ -e ${WORKDIR}/swupdate.handler.${SWUPDATE_BOOTLOADER}.ini ]; then
+       install -m 0644 ${WORKDIR}/swupdate.handler.${SWUPDATE_BOOTLOADER}.ini ${S}/swupdate.handler.ini
+       echo "swupdate.handler.ini etc/" >> ${S}/debian/swupdate.install
+    elif [ -e ${WORKDIR}/${SWUPDATE_ROUND_ROBIN_HANDLER_CONFIG} ]; then
+       install -m 0644 ${WORKDIR}/${SWUPDATE_ROUND_ROBIN_HANDLER_CONFIG} ${S}/swupdate.handler.ini
+       echo "swupdate.handler.ini etc/" >> ${S}/debian/swupdate.install
+    fi
 }
-- 
2.20.1


--PWU11D454MkVjO1a77sJ
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.
View/Reply Online (#6541): https://lists.cip-project.org/g/cip-dev/message=
/6541
Mute This Topic: https://lists.cip-project.org/mt/83634484/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/4520388=
/727948398/xyzzy [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-


--PWU11D454MkVjO1a77sJ--
