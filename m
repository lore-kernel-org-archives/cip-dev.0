Return-Path: <quirin.gylstorff@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80BD6C636D4
	for <webhook@archiver.kernel.org>; Thu,  2 Feb 2023 15:08:16 +0000 (UTC)
Received: from mta-64-227.siemens.flowmailer.net (mta-64-227.siemens.flowmailer.net [185.136.64.227])
 by mx.groups.io with SMTP id smtpd.web10.16800.1675350494695694816
 for <cip-dev@lists.cip-project.org>;
 Thu, 02 Feb 2023 07:08:15 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=Quirin.Gylstorff@siemens.com header.s=fm1 header.b=IWfyKYDH;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.64.227, mailfrom: fm-51332-202302021508123a7a59043b64b6c85e-fws7i8@rts-flowmailer.siemens.com)
Received: by mta-64-227.siemens.flowmailer.net with ESMTPSA id 202302021508123a7a59043b64b6c85e
        for <cip-dev@lists.cip-project.org>;
        Thu, 02 Feb 2023 16:08:12 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=Quirin.Gylstorff@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding;
 bh=jNJumIOJPIiOSYzm0mT6vh0JZTILTIuIL9zp+Hz6flU=;
 b=IWfyKYDHFzVx9f3qBGURDYLRhgblpZdj90hJIMtmAhDDJGEs/otDXJOfATu7QGGGduv3f4
 KyB3/xV5V4a/vkir5uMHFn3eoz3x6i007YCNZvzM46tUPyjDLVN/AIVm0kBcSNdL3dAcQulW
 mZz09RrJG2XR2ePHr1ASKnnb6+YH4=;
From: Quirin Gylstorff <Quirin.Gylstorff@siemens.com>
To: florian.bezdeka@siemens.com,
	cip-dev@lists.cip-project.org,
	Chris.Paterson2@renesas.com,
	jan.kiszka@siemens.com
Subject: [cip-dev][isar-cip-core][PATCH v2] Enable Images based on Debian 12 (bookworm)
Date: Thu,  2 Feb 2023 16:08:11 +0100
Message-Id: <20230202150811.824615-1-Quirin.Gylstorff@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-51332:519-21489:flowmailer
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 02 Feb 2023 15:08:16 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/10569

From: Quirin Gylstorff <quirin.gylstorff@siemens.com>

This will add prelimitary support for the debian 12 aka bookworm.

Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
---
Changes v2:
 - Adjusted blank lines
 - Change Submit subject from "Add bookworm" to "Enable Images based on Debian 12 (bookworm)"
 - Replaced "+=" with "=" if append was used
 - drop pinned kernel for qemu-amd64 secureboot
 - drop Hihope build as firmware-ti-connectivity is not available for bookworm

 .gitlab-ci.yml                       | 37 ++++++++++++++++++++++++++++
 Kconfig                              |  5 ++++
 conf/distro/cip-core-bookworm.conf   | 17 +++++++++++++
 kas/opt/bookworm.yml                 | 15 +++++++++++
 recipes-core/images/efibootguard.inc |  6 ++++-
 recipes-core/images/swupdate.inc     |  6 ++++-
 6 files changed, 84 insertions(+), 2 deletions(-)
 create mode 100644 conf/distro/cip-core-bookworm.conf
 create mode 100644 kas/opt/bookworm.yml

diff --git a/.gitlab-ci.yml b/.gitlab-ci.yml
index f7c8c88..4c4796b 100644
--- a/.gitlab-ci.yml
+++ b/.gitlab-ci.yml
@@ -37,6 +37,7 @@ default:
     - if [ "${targz}" = "enable" ]; then base_yaml="${base_yaml}:kas/opt/targz-img.yml"; fi
     - if [ "${release}" = "buster" ]; then base_yaml="${base_yaml}:kas/opt/buster.yml"; fi
     - if [ "${release}" = "bullseye" ]; then base_yaml="${base_yaml}:kas/opt/bullseye.yml"; fi
+    - if [ "${release}" = "bookworm" ]; then base_yaml="${base_yaml}:kas/opt/bookworm.yml"; fi
     - echo "Building ${base_yaml}"
     - kas build ${base_yaml}
     - if [ "${deploy}" = "enable" ]; then scripts/deploy-cip-core.sh ${release} ${target} ${extension} ${dtb} ${CI_COMMIT_REF_SLUG}; fi
@@ -281,3 +282,39 @@ build:qemu-amd64-secure-boot-buster:
     use_rt: disable
     wic_targz: disable
     deploy: disable
+
+# bookworm images
+build:simatic-ipc227e-bookworm:
+  extends:
+    - .build_base
+  variables:
+    target: simatic-ipc227e
+    release: bookworm
+
+build:bbb-bookworm:
+  extends:
+    - .build_base
+  variables:
+    target: bbb
+    dtb: am335x-boneblack.dtb
+    release: bookworm
+
+build:iwg20m-bookworm:
+  extends:
+    - .build_base
+  variables:
+    target: iwg20m
+    dtb: r8a7743-iwg20d-q7-dbcm-ca.dtb
+    release: bookworm
+
+build:qemu-amd64-secure-boot-bookworm:
+  extends:
+    - .build_base
+  variables:
+    base_yaml: "kas-cip.yml:kas/board/${target}.yml"
+    release: bookworm
+    target: qemu-amd64
+    extension: ebg-secure-boot-snakeoil
+    use_rt: disable
+    wic_targz: disable
+    deploy: disable
diff --git a/Kconfig b/Kconfig
index cd24ce2..87056b9 100644
--- a/Kconfig
+++ b/Kconfig
@@ -128,6 +128,10 @@ config DEBIAN_BULLSEYE
 	bool "bullseye (11)"
 	depends on !ARCH_RISCV64
 
+config DEBIAN_BOOKWORM
+	bool "bookworm (12)"
+	depends on !ARCH_RISCV64
+
 config DEBIAN_SID_PORTS
 	bool "sid (unstable) with unofficial ports"
 	depends on ARCH_RISCV64
@@ -138,6 +142,7 @@ config KAS_INCLUDE_DEBIAN
 	string
 	default "kas/opt/buster.yml" if DEBIAN_BUSTER
 	default "kas/opt/bullseye.yml" if DEBIAN_BULLSEYE
+	default "kas/opt/bookworm.yml" if DEBIAN_BOOKWORM
 	default "kas/opt/sid-ports.yml" if DEBIAN_SID_PORTS
 
 comment "Image features"
diff --git a/conf/distro/cip-core-bookworm.conf b/conf/distro/cip-core-bookworm.conf
new file mode 100644
index 0000000..86c97a1
--- /dev/null
+++ b/conf/distro/cip-core-bookworm.conf
@@ -0,0 +1,17 @@
+#
+# CIP Core, generic profile
+#
+# Copyright (c) Siemens AG, 2023
+#
+# Authors:
+#  Quirin Gylstorff <quirin.gylstorff@siemens.com>
+#
+# SPDX-License-Identifier: MIT
+#
+
+require conf/distro/debian-bookworm.conf
+require cip-core-common.inc
+
+PREFERRED_VERSION_efibootguard ?= "0.13.%"
+PREFERRED_VERSION_linux-cip ?= "5.10.%"
+PREFERRED_VERSION_linux-cip-rt ?= "5.10.%"
diff --git a/kas/opt/bookworm.yml b/kas/opt/bookworm.yml
new file mode 100644
index 0000000..8b4431b
--- /dev/null
+++ b/kas/opt/bookworm.yml
@@ -0,0 +1,15 @@
+#
+# CIP Core, generic profile
+#
+# Copyright (c) Siemens AG, 2023
+#
+# Authors:
+#  Quirin Gylstorff <quirin.gylstorff@siemens.com>
+#
+# SPDX-License-Identifier: MIT
+#
+
+header:
+  version: 12
+
+distro: cip-core-bookworm
diff --git a/recipes-core/images/efibootguard.inc b/recipes-core/images/efibootguard.inc
index eace4fd..29444f6 100644
--- a/recipes-core/images/efibootguard.inc
+++ b/recipes-core/images/efibootguard.inc
@@ -9,7 +9,11 @@
 # SPDX-License-Identifier: MIT
 #
 
-IMAGE_INSTALL_append = " efibootguard"
+OVERRIDES_append = ":${BASE_DISTRO_CODENAME}"
+
+IMAGE_PREINSTALL_append_bookworm = " efibootguard"
+IMAGE_INSTALL_append_bullseye = " efibootguard"
+IMAGE_INSTALL_append_buster = " efibootguard"
 
 WIC_IMAGER_INSTALL_append = " efibootguard"
 WDOG_TIMEOUT ?= "60"
diff --git a/recipes-core/images/swupdate.inc b/recipes-core/images/swupdate.inc
index 9b2aedc..f3f24a8 100644
--- a/recipes-core/images/swupdate.inc
+++ b/recipes-core/images/swupdate.inc
@@ -13,7 +13,11 @@ inherit image_uuid
 inherit swupdate
 inherit read-only-rootfs
 
-IMAGE_INSTALL += " swupdate"
+OVERRIDES_append = ":${BASE_DISTRO_CODENAME}"
+
+IMAGE_PREINSTALL_append_bookworm = " swupdate"
+IMAGE_INSTALL_append_bullseye = " swupdate"
+IMAGE_INSTALL_append_buster = " swupdate"
 IMAGE_INSTALL += " swupdate-handler-roundrobin"
 
 ROOTFS_PARTITION_NAME = "${IMAGE_FULLNAME}.wic.p4.gz"
-- 
2.39.1


