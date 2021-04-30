Return-Path: <SRS0=teBU=J3=lists.cip-project.org=bounce+64572+6408+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45273C433B4
	for <cip-dev@archiver.kernel.org>; Fri, 30 Apr 2021 13:44:49 +0000 (UTC)
Received: from mail02.groups.io (mail02.groups.io [66.175.222.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A0F8961409
	for <cip-dev@archiver.kernel.org>; Fri, 30 Apr 2021 13:44:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A0F8961409
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=siemens.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+6408+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id 8p7hYY4521723xSebDh3aDQa; Fri, 30 Apr 2021 06:44:48 -0700
X-Received: from gecko.sbs.de (gecko.sbs.de [194.138.37.40])
 by mx.groups.io with SMTP id smtpd.web11.11722.1619790287106173617
 for <cip-dev@lists.cip-project.org>;
 Fri, 30 Apr 2021 06:44:47 -0700
X-Received: from mail1.sbs.de (mail1.sbs.de [192.129.41.35])
	by gecko.sbs.de (8.15.2/8.15.2) with ESMTPS id 13UDiiHB010641
	(version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <cip-dev@lists.cip-project.org>; Fri, 30 Apr 2021 15:44:45 +0200
X-Received: from md2dvrtc.fritz.box ([167.87.11.215])
	by mail1.sbs.de (8.15.2/8.15.2) with ESMTP id 13UDXp1R031236;
	Fri, 30 Apr 2021 15:33:51 +0200
From: "Quirin Gylstorff" <quirin.gylstorff@siemens.com>
To: jan.kiszka@siemens.com, cip-dev@lists.cip-project.org,
        christian.storm@siemens.com
Cc: Quirin Gylstorff <quirin.gylstorff@siemens.com>
Subject: [cip-dev][isar-cip-core][RFC] Add option to use swupdate-handler-roundrobin
Date: Fri, 30 Apr 2021 15:33:51 +0200
Message-Id: <20210430133351.26394-1-Quirin.Gylstorff@siemens.com>
MIME-Version: 1.0
Precedence: Bulk
List-Unsubscribe: <mailto:cip-dev+unsubscribe@lists.cip-project.org>
List-Subscribe: <mailto:cip-dev+subscribe@lists.cip-project.org>
List-Help: <mailto:cip-dev+help@lists.cip-project.org>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: Gq2LUAgqPtAlwvAtoIcBqABJx4520388AA=
Content-Type: multipart/mixed; boundary="RKVepk5eiePoUojpHeqb"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1619790288;
 bh=7fkdDMqijn0ml05rR3VN1f2lztZRQy3eRpBAi4+uKRo=;
 h=Cc:Content-Type:Date:From:Reply-To:Subject:To;
 b=pdNzKYOWwBU3uNhdeqV6ZOXT5lONS00FNeSJ4J+Bqc4bgxEK4CYpZERldEP+D5/pQrI
 hgxCjNGEb0U7Nijn1qDfMHYiKrwmMsfYTF/A9cJHUiOu/97sPW7NTeUQPkvsbPlG91qgu
 yMaQTv0FhVvnTvEDkRtEiUQHNAAbqivItIs=

--RKVepk5eiePoUojpHeqb
Content-Transfer-Encoding: 8bit

From: Quirin Gylstorff <quirin.gylstorff@siemens.com>

The new swupdate round robin handler is available under[1].
Add the Option `SWUPDATE_USE_ROUND_ROBIN_HANDLER_REPO` to
use the handler directly from the repository.

The handler currently doesn't support secureboot.

[1]:https://gitlab.com/cip-playground/swupdate-handler-roundrobin/

Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
---
 classes/swupdate-config.bbclass               | 12 ++++++---
 kas/opt/ebg-secure-boot-base.yml              |  3 +++
 .../files/secure-boot/sw-description.tmpl     |  2 +-
 recipes-core/images/files/sw-description.tmpl | 21 ++++++++++-----
 .../files/swupdate.handler.efibootguard.ini   | 26 +++++++++++++++++++
 recipes-core/swupdate/swupdate.bb             |  9 ++++++-
 6 files changed, 62 insertions(+), 11 deletions(-)
 create mode 100644 recipes-core/swupdate/files/swupdate.handler.efibootguard.ini

diff --git a/classes/swupdate-config.bbclass b/classes/swupdate-config.bbclass
index 8ec1104..e425aa2 100644
--- a/classes/swupdate-config.bbclass
+++ b/classes/swupdate-config.bbclass
@@ -21,9 +21,17 @@ KFEATURE_lua = ""
 KFEATURE_lua[BUILD_DEB_DEPENDS] = "liblua5.3-dev"
 KFEATURE_lua[KCONFIG_SNIPPETS] = "file://swupdate_defconfig_lua.snippet"
 
+SWUPDATE_USE_ROUND_ROBIN_HANDLER_REPO ?= "1"
+
+SRC_URI_append = " ${@ 'git://gitlab.com/cip-playground/swupdate-handler-roundrobin.git;protocol=https;destsuffix=swupdate-handler-roundrobin;name=swupdate-handler-roundrobin' \
+    if d.getVar('SWUPDATE_USE_ROUND_ROBIN_HANDLER_REPO') == '1' else '' \
+    }"
+SRCREV_swupdate-handler-roundrobin ?= "6ac9e49eaa4e866a3eda12eee3a223820ba8e0bf"
+SWUPDATE_LUASCRIPT ?= "swupdate-handler-roundrobin/swupdate_handlers_roundrobin.lua"
 KFEATURE_luahandler = ""
 KFEATURE_luahandler[KCONFIG_SNIPPETS] = "file://swupdate_defconfig_luahandler.snippet"
-KFEATURE_luahandler[SRC_URI] = "file://${SWUPDATE_LUASCRIPT}"
+KFEATURE_luahandler[SRC_URI] = "${@ 'file://${SWUPDATE_LUASCRIPT}' \
+                                  if d.getVar('SWUPDATE_USE_ROUND_ROBIN_HANDLER_REPO') == '0' else '' }"
 
 KFEATURE_DEPS = ""
 KFEATURE_DEPS[luahandler] = "lua"
@@ -58,8 +66,6 @@ KFEATURE_u-boot[DEBIAN_DEPENDS] = "${@ 'libubootenv0.1, u-boot-${MACHINE}-config
 KFEATURE_u-boot[DEPENDS] = "${SWUPDATE_U_BOOT} libubootenv"
 KFEATURE_u-boot[KCONFIG_SNIPPETS] = "file://swupdate_defconfig_u-boot.snippet"
 
-SWUPDATE_LUASCRIPT ?= "swupdate_handlers.lua"
-
 def get_bootloader_featureset(d):
     bootloader = d.getVar("SWUPDATE_BOOTLOADER", True) or ""
     if bootloader == "efibootguard":
diff --git a/kas/opt/ebg-secure-boot-base.yml b/kas/opt/ebg-secure-boot-base.yml
index 30ca35a..484d0e5 100644
--- a/kas/opt/ebg-secure-boot-base.yml
+++ b/kas/opt/ebg-secure-boot-base.yml
@@ -16,3 +16,6 @@ local_conf_header:
   initramfs: |
     IMAGE_INSTALL += "initramfs-abrootfs-secureboot"
     SWU_DESCRIPTION = "secureboot"
+  swupdate-secureboot: |
+    SWUPDATE_USE_ROUND_ROBIN_HANDLER_REPO = "0"
+    SWUPDATE_LUASCRIPT = "swupdate_handler.efibootguard.secureboot.lua"
diff --git a/recipes-core/images/files/secure-boot/sw-description.tmpl b/recipes-core/images/files/secure-boot/sw-description.tmpl
index bce97d0..897d819 100644
--- a/recipes-core/images/files/secure-boot/sw-description.tmpl
+++ b/recipes-core/images/files/secure-boot/sw-description.tmpl
@@ -16,7 +16,7 @@ software =
             filename = "${ROOTFS_PARTITION_NAME}";
             device = "fedcba98-7654-3210-cafe-5e0710000001,fedcba98-7654-3210-cafe-5e0710000002";
             type = "roundrobin";
-            compressed = "true";
+            compressed = "zlib";
             filesystem = "ext4";
     });
     files: ({
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
diff --git a/recipes-core/swupdate/swupdate.bb b/recipes-core/swupdate/swupdate.bb
index 526c72f..c03c70b 100644
--- a/recipes-core/swupdate/swupdate.bb
+++ b/recipes-core/swupdate/swupdate.bb
@@ -29,6 +29,7 @@ DEBIAN_DEPENDS = "${shlibs:Depends}, ${misc:Depends}"
 inherit dpkg
 inherit swupdate-config
 
+SRC_URI += "file://swupdate.handler.${BOOTLOADER}.ini"
 KFEATURES += "luahandler"
 
 S = "${WORKDIR}/git"
@@ -46,5 +47,11 @@ do_prepare_build() {
         echo "configs/${DEFCONFIG}" >> ${S}/.gitignore
     fi
     # luahandler
-    install -m 0644 ${WORKDIR}/${SWUPDATE_LUASCRIPT} ${S}
+    if [ -e ${WORKDIR}/${SWUPDATE_LUASCRIPT} ]; then
+        install -m 0644 ${WORKDIR}/${SWUPDATE_LUASCRIPT} ${S}/swupdate_handlers.lua
+    fi
+    if [ -e "${WORKDIR}/swupdate.handler.${BOOTLOADER}.ini" ]; then
+       install -m 0644 ${WORKDIR}/swupdate.handler.${BOOTLOADER}.ini ${S}/swupdate.handler.ini
+       echo "swupdate.handler.ini etc/" >> ${S}/debian/swupdate.install
+    fi
 }
-- 
2.20.1


--RKVepk5eiePoUojpHeqb
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.
View/Reply Online (#6408): https://lists.cip-project.org/g/cip-dev/message=
/6408
Mute This Topic: https://lists.cip-project.org/mt/82481536/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/4520388=
/727948398/xyzzy [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-


--RKVepk5eiePoUojpHeqb--
