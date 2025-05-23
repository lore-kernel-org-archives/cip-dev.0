Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 846A5C54F2E
	for <webhook@archiver.kernel.org>; Fri, 23 May 2025 13:25:10 +0000 (UTC)
Received: from mta-65-227.siemens.flowmailer.net (mta-65-227.siemens.flowmailer.net [185.136.65.227])
 by mx.groups.io with SMTP id smtpd.web10.47930.1748006706421677564
 for <cip-dev@lists.cip-project.org>;
 Fri, 23 May 2025 06:25:07 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=jan.kiszka@siemens.com header.s=fm1 header.b=NBz9/Xnv;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.65.227, mailfrom: fm-294854-20250523132503b878e46ae89c08900c-ivggei@rts-flowmailer.siemens.com)
Received: by mta-65-227.siemens.flowmailer.net with ESMTPSA id 20250523132503b878e46ae89c08900c
        for <cip-dev@lists.cip-project.org>;
        Fri, 23 May 2025 15:25:03 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=jan.kiszka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:References:In-Reply-To;
 bh=xTWBuaMIjXfMntqigVpdVNvut8KRNiYmcL5HfByJl9Y=;
 b=NBz9/XnvzWelEWY40XpUST5yrgTfOTPxmNvjUM9zflNMC+dfMrskhOjTSEcaanQBL++feo
 UFH+MtbbFVLe2ptgUu47GsNtoPWYprh1s3vo76Yd3FjFOtetli+kFOF++8cXXbFXCRcbl+E1
 4hC6jKax+kqtGxORnViR+xZNCuXJ/Dn6qJeMn14vTWTIaHjCcSsmkJQYkGBXE0B0x47PiCyx
 DNXFsu/rJPCd55bTYDjvOf4E/x/y40WK8Ls+6Y4c9/n4HmGDMvmyvJG1teluBarWta1tUK9j
 s1si8TnuuD2t83OwpEV0/qp6vJ8EZ69zIKME22ccen3QbtrzXnD/Huow==;
From: Jan Kiszka <jan.kiszka@siemens.com>
To: cip-dev@lists.cip-project.org
Subject: [isar-cip-core][PATCH 1/3] linux-cip: Prepare for building from git branches
Date: Fri, 23 May 2025 15:25:00 +0200
Message-ID: <87f7ccfab0e862887590bf91547664f5b24dc15a.1748006702.git.jan.kiszka@siemens.com>
In-Reply-To: <cover.1748006702.git.jan.kiszka@siemens.com>
References: <cover.1748006702.git.jan.kiszka@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-294854:519-21489:flowmailer
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 23 May 2025 13:25:10 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/18939

From: Jan Kiszka <jan.kiszka@siemens.com>

Split off to common bits that are relevant for all cip kernel builds
from those that are only used when building release tarballs. This
prepares to build from git branches as well.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 recipes-kernel/linux/linux-cip-common.inc             |  9 +--------
 .../{linux-cip-common.inc => linux-cip-release.inc}   | 11 ++---------
 .../linux/linux-cip-rt_4.19.325-cip118-rt41.bb        |  2 +-
 .../linux/linux-cip-rt_4.4.302-cip98-rt55.bb          |  2 +-
 .../linux/linux-cip-rt_5.10.237-cip60-rt26.bb         |  2 +-
 .../linux/linux-cip-rt_6.1.134-cip41-rt22.bb          |  2 +-
 recipes-kernel/linux/linux-cip_4.19.325-cip120.bb     |  2 +-
 recipes-kernel/linux/linux-cip_4.4.302-cip99.bb       |  2 +-
 recipes-kernel/linux/linux-cip_5.10.237-cip60.bb      |  2 +-
 recipes-kernel/linux/linux-cip_6.1.137-cip42.bb       |  2 +-
 recipes-kernel/linux/linux-cip_6.12.29-cip1.bb        |  2 +-
 11 files changed, 12 insertions(+), 26 deletions(-)
 copy recipes-kernel/linux/{linux-cip-common.inc => linux-cip-release.inc} (50%)

diff --git a/recipes-kernel/linux/linux-cip-common.inc b/recipes-kernel/linux/linux-cip-common.inc
index f20d6a06..aa625674 100644
--- a/recipes-kernel/linux/linux-cip-common.inc
+++ b/recipes-kernel/linux/linux-cip-common.inc
@@ -11,17 +11,10 @@
 
 FILESEXTRAPATHS:prepend := "${FILE_DIRNAME}/files:"
 
-KERNEL_MAJOR_MINOR = "${@d.getVar('PV').split('.')[0] + '.' + d.getVar('PV').split('.')[1]}"
-
 KERNEL_DEFCONFIG_VERSION ?= "${KERNEL_MAJOR_MINOR}.y-cip"
 KERNEL_DEFCONFIG ?= "${MACHINE}_defconfig"
 
 require recipes-kernel/linux/linux-custom.inc
 require recipes-kernel/linux/cip-kernel-config.inc
 
-SRC_URI += " \
-    https://cdn.kernel.org/pub/linux/kernel/projects/cip/${KERNEL_MAJOR_MINOR}/linux-cip-${PV}.tar.xz \
-    ${@'file://preempt-rt.cfg' if d.getVar('KERNEL_NAME') == 'cip-rt' else ''} \
-    "
-
-S = "${WORKDIR}/linux-cip-${PV}"
+SRC_URI += "${@'file://preempt-rt.cfg' if d.getVar('KERNEL_NAME') == 'cip-rt' else ''}"
diff --git a/recipes-kernel/linux/linux-cip-common.inc b/recipes-kernel/linux/linux-cip-release.inc
similarity index 50%
copy from recipes-kernel/linux/linux-cip-common.inc
copy to recipes-kernel/linux/linux-cip-release.inc
index f20d6a06..25c2789b 100644
--- a/recipes-kernel/linux/linux-cip-common.inc
+++ b/recipes-kernel/linux/linux-cip-release.inc
@@ -1,7 +1,7 @@
 #
 # CIP Core, generic profile
 #
-# Copyright (c) Siemens AG, 2022-2025
+# Copyright (c) Siemens, 2022-2025
 #
 # Authors:
 #  Jan Kiszka <jan.kiszka@siemens.com>
@@ -9,19 +9,12 @@
 # SPDX-License-Identifier: MIT
 #
 
-FILESEXTRAPATHS:prepend := "${FILE_DIRNAME}/files:"
+require linux-cip-common.inc
 
 KERNEL_MAJOR_MINOR = "${@d.getVar('PV').split('.')[0] + '.' + d.getVar('PV').split('.')[1]}"
 
-KERNEL_DEFCONFIG_VERSION ?= "${KERNEL_MAJOR_MINOR}.y-cip"
-KERNEL_DEFCONFIG ?= "${MACHINE}_defconfig"
-
-require recipes-kernel/linux/linux-custom.inc
-require recipes-kernel/linux/cip-kernel-config.inc
-
 SRC_URI += " \
     https://cdn.kernel.org/pub/linux/kernel/projects/cip/${KERNEL_MAJOR_MINOR}/linux-cip-${PV}.tar.xz \
-    ${@'file://preempt-rt.cfg' if d.getVar('KERNEL_NAME') == 'cip-rt' else ''} \
     "
 
 S = "${WORKDIR}/linux-cip-${PV}"
diff --git a/recipes-kernel/linux/linux-cip-rt_4.19.325-cip118-rt41.bb b/recipes-kernel/linux/linux-cip-rt_4.19.325-cip118-rt41.bb
index 1d791669..8c32f39c 100644
--- a/recipes-kernel/linux/linux-cip-rt_4.19.325-cip118-rt41.bb
+++ b/recipes-kernel/linux/linux-cip-rt_4.19.325-cip118-rt41.bb
@@ -9,6 +9,6 @@
 # SPDX-License-Identifier: MIT
 #
 
-require linux-cip-common.inc
+require linux-cip-release.inc
 
 SRC_URI[sha256sum] = "ac71b31b34e89e7d6daf98a202806037e44203d5d79bc74da5c57f5c24ccf946"
diff --git a/recipes-kernel/linux/linux-cip-rt_4.4.302-cip98-rt55.bb b/recipes-kernel/linux/linux-cip-rt_4.4.302-cip98-rt55.bb
index e5bfca91..8c88eb5e 100644
--- a/recipes-kernel/linux/linux-cip-rt_4.4.302-cip98-rt55.bb
+++ b/recipes-kernel/linux/linux-cip-rt_4.4.302-cip98-rt55.bb
@@ -9,6 +9,6 @@
 # SPDX-License-Identifier: MIT
 #
 
-require linux-cip-common.inc
+require linux-cip-release.inc
 
 SRC_URI[sha256sum] = "70e223852d3a7f711dd511524243df512dcc7799010004b4d99e0acf1f95866a"
diff --git a/recipes-kernel/linux/linux-cip-rt_5.10.237-cip60-rt26.bb b/recipes-kernel/linux/linux-cip-rt_5.10.237-cip60-rt26.bb
index 5440ae62..8edf6e85 100644
--- a/recipes-kernel/linux/linux-cip-rt_5.10.237-cip60-rt26.bb
+++ b/recipes-kernel/linux/linux-cip-rt_5.10.237-cip60-rt26.bb
@@ -9,6 +9,6 @@
 # SPDX-License-Identifier: MIT
 #
 
-require linux-cip-common.inc
+require linux-cip-release.inc
 
 SRC_URI[sha256sum] = "e2d8fae539c6429e1680b9875b6b6c16792ee20a85d47b6f8c8227ef679c9886"
diff --git a/recipes-kernel/linux/linux-cip-rt_6.1.134-cip41-rt22.bb b/recipes-kernel/linux/linux-cip-rt_6.1.134-cip41-rt22.bb
index eafe09b8..f4cc8d2a 100644
--- a/recipes-kernel/linux/linux-cip-rt_6.1.134-cip41-rt22.bb
+++ b/recipes-kernel/linux/linux-cip-rt_6.1.134-cip41-rt22.bb
@@ -5,6 +5,6 @@
 #
 # SPDX-License-Identifier: MIT
 
-require linux-cip-common.inc
+require linux-cip-release.inc
 
 SRC_URI[sha256sum] = "8582da7b30925237cf4905988aefe0a8de23bb4e7546e6ebb998419ee121fa7e"
diff --git a/recipes-kernel/linux/linux-cip_4.19.325-cip120.bb b/recipes-kernel/linux/linux-cip_4.19.325-cip120.bb
index 9bdf79c0..cbeef699 100644
--- a/recipes-kernel/linux/linux-cip_4.19.325-cip120.bb
+++ b/recipes-kernel/linux/linux-cip_4.19.325-cip120.bb
@@ -9,6 +9,6 @@
 # SPDX-License-Identifier: MIT
 #
 
-require linux-cip-common.inc
+require linux-cip-release.inc
 
 SRC_URI[sha256sum] = "9149d5ce9bd1a27ebb67358db8c81ef5c3e960c196007d501b731295ce8f7f69"
diff --git a/recipes-kernel/linux/linux-cip_4.4.302-cip99.bb b/recipes-kernel/linux/linux-cip_4.4.302-cip99.bb
index 4eea2e79..bb307304 100644
--- a/recipes-kernel/linux/linux-cip_4.4.302-cip99.bb
+++ b/recipes-kernel/linux/linux-cip_4.4.302-cip99.bb
@@ -9,6 +9,6 @@
 # SPDX-License-Identifier: MIT
 #
 
-require linux-cip-common.inc
+require linux-cip-release.inc
 
 SRC_URI[sha256sum] = "ecc90814484dff84dae3f25ac2da7eb9156dc43c18acf2e806dc71ed4800b558"
diff --git a/recipes-kernel/linux/linux-cip_5.10.237-cip60.bb b/recipes-kernel/linux/linux-cip_5.10.237-cip60.bb
index 7cad5613..81e21268 100644
--- a/recipes-kernel/linux/linux-cip_5.10.237-cip60.bb
+++ b/recipes-kernel/linux/linux-cip_5.10.237-cip60.bb
@@ -9,6 +9,6 @@
 # SPDX-License-Identifier: MIT
 #
 
-require linux-cip-common.inc
+require linux-cip-release.inc
 
 SRC_URI[sha256sum] = "be99dae17d2989965dc6dae2092067332f9965df0dcee8b7d517b823aac67990"
diff --git a/recipes-kernel/linux/linux-cip_6.1.137-cip42.bb b/recipes-kernel/linux/linux-cip_6.1.137-cip42.bb
index 124c205d..125fbe49 100644
--- a/recipes-kernel/linux/linux-cip_6.1.137-cip42.bb
+++ b/recipes-kernel/linux/linux-cip_6.1.137-cip42.bb
@@ -5,6 +5,6 @@
 #
 # SPDX-License-Identifier: MIT
 
-require linux-cip-common.inc
+require linux-cip-release.inc
 
 SRC_URI[sha256sum] = "05e279c5e955e96c85be7f8b19b3cd7aba109343d7837bbfa9b9a1b6362ecf2b"
diff --git a/recipes-kernel/linux/linux-cip_6.12.29-cip1.bb b/recipes-kernel/linux/linux-cip_6.12.29-cip1.bb
index 5b8fbdbc..40a3a702 100644
--- a/recipes-kernel/linux/linux-cip_6.12.29-cip1.bb
+++ b/recipes-kernel/linux/linux-cip_6.12.29-cip1.bb
@@ -5,6 +5,6 @@
 #
 # SPDX-License-Identifier: MIT
 
-require linux-cip-common.inc
+require linux-cip-release.inc
 
 SRC_URI[sha256sum] = "27bf5750e3ac4ed50b3cca0eb910e330eb3b24ec3d078af3d7d626123ba7b819"
-- 
2.43.0


