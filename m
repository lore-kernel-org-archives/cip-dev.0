Return-Path: <quirin.gylstorff@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6D49C54EAA
	for <webhook@archiver.kernel.org>; Mon, 30 Jan 2023 11:34:27 +0000 (UTC)
Received: from mta-65-227.siemens.flowmailer.net (mta-65-227.siemens.flowmailer.net [185.136.65.227])
 by mx.groups.io with SMTP id smtpd.web11.38772.1675078456268908481
 for <cip-dev@lists.cip-project.org>;
 Mon, 30 Jan 2023 03:34:17 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=Quirin.Gylstorff@siemens.com header.s=fm1 header.b=bOOgqCYz;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.65.227, mailfrom: fm-51332-20230130113413fc61e426a9682b8264-rwpsr2@rts-flowmailer.siemens.com)
Received: by mta-65-227.siemens.flowmailer.net with ESMTPSA id 20230130113413fc61e426a9682b8264
        for <cip-dev@lists.cip-project.org>;
        Mon, 30 Jan 2023 12:34:13 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=Quirin.Gylstorff@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding;
 bh=Fx9N7VblS4M95JCxWC3MdVwDGC1exYLcrKzcx7v9GPo=;
 b=bOOgqCYzHQBysmv9Sna5F+MmVAWkUFTh5gDtkjA8JqJWixuM4roCZjcQHz4HXsWk3YaGYl
 LdE630kJH9PRTr32Z4WmeV4sqv52JBG5Lqrj+pvr6ITRt+WLz3N8jQyrA+GTtaaOYsRcH2r0
 tr+EqUSAoA0+gDZOoZb9gB5bQxyQk=;
From: Quirin Gylstorff <Quirin.Gylstorff@siemens.com>
To: cip-dev@lists.cip-project.org,
	jan.kiszka@siemens.com
Subject: [cip-dev][isar-cip-core][PATCH] Add bookworm
Date: Mon, 30 Jan 2023 12:34:12 +0100
Message-Id: <20230130113412.628646-1-Quirin.Gylstorff@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-51332:519-21489:flowmailer
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 30 Jan 2023 11:34:27 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/10504

From: Quirin Gylstorff <quirin.gylstorff@siemens.com>

This will add prelimitary support for the debian 12 aka bookworm.

Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
---
 .gitlab-ci.yml                       | 45 ++++++++++++++++++++++++++++
 Kconfig                              |  5 ++++
 conf/distro/cip-core-bookworm.conf   | 17 +++++++++++
 kas/opt/bookworm.yml                 | 15 ++++++++++
 recipes-core/images/efibootguard.inc |  6 ++--
 recipes-core/images/swupdate.inc     |  6 +++-
 6 files changed, 91 insertions(+), 3 deletions(-)
 create mode 100644 conf/distro/cip-core-bookworm.conf
 create mode 100644 kas/opt/bookworm.yml

diff --git a/.gitlab-ci.yml b/.gitlab-ci.yml
index f7c8c88..2b9505d 100644
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
@@ -281,3 +282,47 @@ build:qemu-amd64-secure-boot-buster:
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
+build:hihope-rzg2m-bookworm:
+  extends:
+    - .build_base
+  variables:
+    target: hihope-rzg2m
+    dtb: r8a774a1-hihope-rzg2m-ex.dtb
+    release: bookworm
+
+build:qemu-amd64-secure-boot-bookworm:
+  extends:
+    - .build_base
+  variables:
+    base_yaml: "kas-cip.yml:kas/board/${target}.yml:kas/opt/5.10.yml"
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
index eace4fd..d8d3a06 100644
--- a/recipes-core/images/efibootguard.inc
+++ b/recipes-core/images/efibootguard.inc
@@ -8,8 +8,10 @@
 #
 # SPDX-License-Identifier: MIT
 #
-
-IMAGE_INSTALL_append = " efibootguard"
+OVERRIDES_append = ":${BASE_DISTRO_CODENAME}"
+IMAGE_PREINSTALL_append_bookworm += " efibootguard"
+IMAGE_INSTALL_append_bullseye += " efibootguard"
+IMAGE_INSTALL_append_buster += " efibootguard"
 
 WIC_IMAGER_INSTALL_append = " efibootguard"
 WDOG_TIMEOUT ?= "60"
diff --git a/recipes-core/images/swupdate.inc b/recipes-core/images/swupdate.inc
index 9b2aedc..a47928a 100644
--- a/recipes-core/images/swupdate.inc
+++ b/recipes-core/images/swupdate.inc
@@ -13,7 +13,11 @@ inherit image_uuid
 inherit swupdate
 inherit read-only-rootfs
 
-IMAGE_INSTALL += " swupdate"
+OVERRIDES_append = ":${BASE_DISTRO_CODENAME}"
+
+IMAGE_PREINSTALL_append_bookworm += " swupdate"
+IMAGE_INSTALL_append_bullseye += " swupdate"
+IMAGE_INSTALL_append_buster += " swupdate"
 IMAGE_INSTALL += " swupdate-handler-roundrobin"
 
 ROOTFS_PARTITION_NAME = "${IMAGE_FULLNAME}.wic.p4.gz"
-- 
2.39.0


