Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DE3EC54E71
	for <webhook@archiver.kernel.org>; Tue, 20 May 2025 12:43:52 +0000 (UTC)
Received: from mta-64-228.siemens.flowmailer.net (mta-64-228.siemens.flowmailer.net [185.136.64.228])
 by mx.groups.io with SMTP id smtpd.web11.19996.1747745027161363937
 for <cip-dev@lists.cip-project.org>;
 Tue, 20 May 2025 05:43:48 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=jan.kiszka@siemens.com header.s=fm1 header.b=XN7PVcd2;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.64.228, mailfrom: fm-294854-20250520124343de71649e21da64acca-pt_jeo@rts-flowmailer.siemens.com)
Received: by mta-64-228.siemens.flowmailer.net with ESMTPSA id 20250520124343de71649e21da64acca
        for <cip-dev@lists.cip-project.org>;
        Tue, 20 May 2025 14:43:44 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=jan.kiszka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:References:In-Reply-To;
 bh=pNdBeaXQ6IL5M4qUTTm55cCVYTUVwmTXugcEBXkgdtA=;
 b=XN7PVcd2w7+Z3SvS0oP6i2WpTfPTMsKJ5jZwOlkFX8lLC5snZif6p1v0N4JuimrsQu1Njq
 WMwA3G1MNy8KSgHOaaiKCKlW3B4x+TwGQh/iJZjYwl7ULszGr7mQcbV1fxDV8dfaJaz6bPLI
 vyyXxp8uIDu8fUxldyTBYdLxQv2fuBmRwwJBTmeKx+JA7Dg4zJvm3Paec3XywKvn3H2J+uom
 sSJ0HcZg6vTRjHoACNVsKAwogU/dYhRoKyts8w+puZkn26fRUwsWsCCJyieKu7vWAJVd8A4w
 61neQf1cDXn0ua2HgrQBfA2wYMrhbaFx1ei0AVxK8UXciecTl+rmgGjA==;
From: Jan Kiszka <jan.kiszka@siemens.com>
To: cip-dev@lists.cip-project.org
Subject: [isar-cip-core][PATCH 1/4] linux-cip: Fold rt-specific include into a single file
Date: Tue, 20 May 2025 14:43:39 +0200
Message-ID: <a6355ca3e7f2b866c7b87eb193c8adb8eec907c5.1747745022.git.jan.kiszka@siemens.com>
In-Reply-To: <cover.1747745022.git.jan.kiszka@siemens.com>
References: <cover.1747745022.git.jan.kiszka@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-294854:519-21489:flowmailer
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 20 May 2025 12:43:52 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/18926

From: Jan Kiszka <jan.kiszka@siemens.com>

This will simplify the addition of the 6.12 kernel where there is no
need for a separate recipe as there is no separate code base anymore.

At this chance, it turned out that we never built the 6.1-cip-rt kernel
in isar-cip-core with RT settings. That is automatically fixed now as
well.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 recipes-kernel/linux/linux-cip-common.inc         |  3 ++-
 recipes-kernel/linux/linux-cip-rt-common.inc      | 15 ---------------
 .../linux/linux-cip-rt_4.19.325-cip118-rt41.bb    |  4 ++--
 .../linux/linux-cip-rt_4.4.302-cip98-rt55.bb      |  4 ++--
 .../linux/linux-cip-rt_5.10.237-cip60-rt26.bb     |  4 ++--
 5 files changed, 8 insertions(+), 22 deletions(-)
 delete mode 100644 recipes-kernel/linux/linux-cip-rt-common.inc

diff --git a/recipes-kernel/linux/linux-cip-common.inc b/recipes-kernel/linux/linux-cip-common.inc
index 5d1b8ac0..f20d6a06 100644
--- a/recipes-kernel/linux/linux-cip-common.inc
+++ b/recipes-kernel/linux/linux-cip-common.inc
@@ -1,7 +1,7 @@
 #
 # CIP Core, generic profile
 #
-# Copyright (c) Siemens AG, 2022-2023
+# Copyright (c) Siemens AG, 2022-2025
 #
 # Authors:
 #  Jan Kiszka <jan.kiszka@siemens.com>
@@ -21,6 +21,7 @@ require recipes-kernel/linux/cip-kernel-config.inc
 
 SRC_URI += " \
     https://cdn.kernel.org/pub/linux/kernel/projects/cip/${KERNEL_MAJOR_MINOR}/linux-cip-${PV}.tar.xz \
+    ${@'file://preempt-rt.cfg' if d.getVar('KERNEL_NAME') == 'cip-rt' else ''} \
     "
 
 S = "${WORKDIR}/linux-cip-${PV}"
diff --git a/recipes-kernel/linux/linux-cip-rt-common.inc b/recipes-kernel/linux/linux-cip-rt-common.inc
deleted file mode 100644
index 8e2c2939..00000000
--- a/recipes-kernel/linux/linux-cip-rt-common.inc
+++ /dev/null
@@ -1,15 +0,0 @@
-#
-# CIP Core, generic profile
-#
-# Copyright (c) Siemens AG, 2019
-#
-# Authors:
-#  Jan Kiszka <jan.kiszka@siemens.com>
-#
-# SPDX-License-Identifier: MIT
-#
-
-require linux-cip-common.inc
-
-SRC_URI += "file://preempt-rt.cfg"
-
diff --git a/recipes-kernel/linux/linux-cip-rt_4.19.325-cip118-rt41.bb b/recipes-kernel/linux/linux-cip-rt_4.19.325-cip118-rt41.bb
index 8d5c31e2..1d791669 100644
--- a/recipes-kernel/linux/linux-cip-rt_4.19.325-cip118-rt41.bb
+++ b/recipes-kernel/linux/linux-cip-rt_4.19.325-cip118-rt41.bb
@@ -1,7 +1,7 @@
 #
 # CIP Core, generic profile
 #
-# Copyright (c) Siemens AG, 2019 - 2023
+# Copyright (c) Siemens AG, 2019-2025
 #
 # Authors:
 #  Jan Kiszka <jan.kiszka@siemens.com>
@@ -9,6 +9,6 @@
 # SPDX-License-Identifier: MIT
 #
 
-require linux-cip-rt-common.inc
+require linux-cip-common.inc
 
 SRC_URI[sha256sum] = "ac71b31b34e89e7d6daf98a202806037e44203d5d79bc74da5c57f5c24ccf946"
diff --git a/recipes-kernel/linux/linux-cip-rt_4.4.302-cip98-rt55.bb b/recipes-kernel/linux/linux-cip-rt_4.4.302-cip98-rt55.bb
index f66c06ea..e5bfca91 100644
--- a/recipes-kernel/linux/linux-cip-rt_4.4.302-cip98-rt55.bb
+++ b/recipes-kernel/linux/linux-cip-rt_4.4.302-cip98-rt55.bb
@@ -1,7 +1,7 @@
 #
 # CIP Core, generic profile
 #
-# Copyright (c) Siemens AG, 2019 - 2023
+# Copyright (c) Siemens AG, 2019-2025
 #
 # Authors:
 #  Jan Kiszka <jan.kiszka@siemens.com>
@@ -9,6 +9,6 @@
 # SPDX-License-Identifier: MIT
 #
 
-require linux-cip-rt-common.inc
+require linux-cip-common.inc
 
 SRC_URI[sha256sum] = "70e223852d3a7f711dd511524243df512dcc7799010004b4d99e0acf1f95866a"
diff --git a/recipes-kernel/linux/linux-cip-rt_5.10.237-cip60-rt26.bb b/recipes-kernel/linux/linux-cip-rt_5.10.237-cip60-rt26.bb
index 212b0937..5440ae62 100644
--- a/recipes-kernel/linux/linux-cip-rt_5.10.237-cip60-rt26.bb
+++ b/recipes-kernel/linux/linux-cip-rt_5.10.237-cip60-rt26.bb
@@ -1,7 +1,7 @@
 #
 # CIP Core, generic profile
 #
-# Copyright (c) Siemens AG, 2021-2023
+# Copyright (c) Siemens AG, 2021-2025
 #
 # Authors:
 #  Jan Kiszka <jan.kiszka@siemens.com>
@@ -9,6 +9,6 @@
 # SPDX-License-Identifier: MIT
 #
 
-require linux-cip-rt-common.inc
+require linux-cip-common.inc
 
 SRC_URI[sha256sum] = "e2d8fae539c6429e1680b9875b6b6c16792ee20a85d47b6f8c8227ef679c9886"
-- 
2.43.0


