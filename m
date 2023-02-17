Return-Path: <quirin.gylstorff@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CAEB3C64ED8
	for <webhook@archiver.kernel.org>; Fri, 17 Feb 2023 15:26:04 +0000 (UTC)
Received: from mta-64-227.siemens.flowmailer.net (mta-64-227.siemens.flowmailer.net [185.136.64.227])
 by mx.groups.io with SMTP id smtpd.web10.9073.1676647561024653752
 for <cip-dev@lists.cip-project.org>;
 Fri, 17 Feb 2023 07:26:01 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=Quirin.Gylstorff@siemens.com header.s=fm1 header.b=hi2qSufN;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.64.227, mailfrom: fm-51332-20230217152558282f4d45a523441259-kjmlnm@rts-flowmailer.siemens.com)
Received: by mta-64-227.siemens.flowmailer.net with ESMTPSA id 20230217152558282f4d45a523441259
        for <cip-dev@lists.cip-project.org>;
        Fri, 17 Feb 2023 16:25:58 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=Quirin.Gylstorff@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:References:In-Reply-To;
 bh=MOo9gzgY42SBXDvgvLPgTOl2/Z4NpPNtWxvw8liwE9c=;
 b=hi2qSufN7kBXIkj/c4d88MRnb9us8ZsArup0l57SlhE6YacPFNc3QIkMuqZPQDSQuPiV1u
 jJK31rMIUm32M8MbzvpE0NtZ1TNF2YtUoia3EWMwX1JuDo7sly4sXl9Azq2uqv64VRO2ou6j
 dLIGCjpU8ORZb9BVxnBTqLeE1EdmE=;
From: Quirin Gylstorff <Quirin.Gylstorff@siemens.com>
To: cip-dev@lists.cip-project.org,
	jan.kiszka@siemens.com
Subject: [cip-dev][isar-cip-core][PATCH 1/3] Enable Images based on Debian 12 (bookworm)
Date: Fri, 17 Feb 2023 16:25:54 +0100
Message-Id: <20230217152556.516948-2-Quirin.Gylstorff@siemens.com>
In-Reply-To: <20230217152556.516948-1-Quirin.Gylstorff@siemens.com>
References: <20230217152556.516948-1-Quirin.Gylstorff@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-51332:519-21489:flowmailer
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 17 Feb 2023 15:26:04 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/10731

From: Quirin Gylstorff <quirin.gylstorff@siemens.com>

This will add prelimitary support for the debian 12 aka bookworm.

Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
---
 .gitlab-ci.yml                       | 45 ++++++++++++++++++++++++++++
 Kconfig                              |  5 ++++
 conf/distro/cip-core-bookworm.conf   | 16 ++++++++++
 kas/opt/bookworm.yml                 | 15 ++++++++++
 recipes-core/images/efibootguard.inc |  4 +++
 recipes-core/images/swupdate.inc     |  6 +++-
 6 files changed, 90 insertions(+), 1 deletion(-)
 create mode 100644 conf/distro/cip-core-bookworm.conf
 create mode 100644 kas/opt/bookworm.yml

diff --git a/.gitlab-ci.yml b/.gitlab-ci.yml
index f7c8c88..311702f 100644
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
index 0000000..de2e435
--- /dev/null
+++ b/conf/distro/cip-core-bookworm.conf
@@ -0,0 +1,16 @@
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
index b3fe911..bb1aa1d 100644
--- a/recipes-core/images/efibootguard.inc
+++ b/recipes-core/images/efibootguard.inc
@@ -10,6 +10,10 @@
 #
 
 IMAGE_INSTALL:append = " efibootguard"
+IMAGE_PREINSTALL:append:sid = " efibootguard"
+IMAGE_PREINSTALL:append:bookworm = " efibootguard"
+IMAGE_INSTALL:append:bullseye = " efibootguard"
+IMAGE_INSTALL:append:buster = " efibootguard"
 
 WIC_IMAGER_INSTALL:append = " efibootguard:${DISTRO_ARCH}"
 WDOG_TIMEOUT ?= "60"
diff --git a/recipes-core/images/swupdate.inc b/recipes-core/images/swupdate.inc
index 08867cd..817fce0 100644
--- a/recipes-core/images/swupdate.inc
+++ b/recipes-core/images/swupdate.inc
@@ -12,5 +12,9 @@
 inherit image_uuid
 inherit read-only-rootfs
 
-IMAGE_INSTALL += " swupdate"
+IMAGE_PREINSTALL:append:sid = " swupdate"
+IMAGE_PREINSTALL:append:bookworm = " swupdate"
+IMAGE_INSTALL:append:bullseye = " swupdate"
+IMAGE_INSTALL:append:buster = " swupdate"
+
 IMAGE_INSTALL += " swupdate-handler-roundrobin"
-- 
2.39.1


