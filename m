Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97042C54F32
	for <webhook@archiver.kernel.org>; Fri, 23 May 2025 13:25:10 +0000 (UTC)
Received: from mta-64-225.siemens.flowmailer.net (mta-64-225.siemens.flowmailer.net [185.136.64.225])
 by mx.groups.io with SMTP id smtpd.web11.48251.1748006706890022165
 for <cip-dev@lists.cip-project.org>;
 Fri, 23 May 2025 06:25:07 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=jan.kiszka@siemens.com header.s=fm1 header.b=SFH9NRKi;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.64.225, mailfrom: fm-294854-2025052313250352edfec5d0df5a393d-v_d4nt@rts-flowmailer.siemens.com)
Received: by mta-64-225.siemens.flowmailer.net with ESMTPSA id 2025052313250352edfec5d0df5a393d
        for <cip-dev@lists.cip-project.org>;
        Fri, 23 May 2025 15:25:03 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=jan.kiszka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:References:In-Reply-To;
 bh=vY2Wzty+DNeEBimR124ucKkROAnld1IQCGU8ErqHq6E=;
 b=SFH9NRKiEeIWTGVL0fud75XDVmV1U3RRC5EwEhhfllogEfn7D82ip4uSb0/BkoCLTL+4/T
 lwmGr24C/0cvtXRziG7owLVbQllGaaZzpjV2fBJhC62u5fODNRJLR1bwAcT3/cX+00E9nSHh
 N9rtaS6JPQyGGXx7BlyQ1PcGNyffWDqtYdJkEyIHeamGQeBsxYDorhYuVdfy+8LOkAmeDzEh
 3AbQki1IhCU4CFvXO8FPw9Bl23htLuDnRdWCc//qbC20F0SYFeKTNNh90a1jztbq9EDXxRuA
 4PLyiifa6YL1MTJBCbnaAuvCeH2VWf8+/znMDexshQ1zsH8MRDc5nkgg==;
From: Jan Kiszka <jan.kiszka@siemens.com>
To: cip-dev@lists.cip-project.org
Subject: [isar-cip-core][PATCH 2/3] linux-cip: Add support for building head of development branches
Date: Fri, 23 May 2025 15:25:01 +0200
Message-ID: <0ec0acccc287e84f8c4e33a70e30caac8d8ef273.1748006702.git.jan.kiszka@siemens.com>
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
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/18940

From: Jan Kiszka <jan.kiszka@siemens.com>

Add a recipe for each CIP kernel version series that selects via AUTOREV
the head of the related git branch and builds the kernel from it. This
enables earlier testing via isar-cip-core.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 recipes-kernel/linux/linux-cip-head.inc       | 34 +++++++++++++++++++
 .../linux/linux-cip-rt_4.19-cip-head.bb       |  1 +
 .../linux/linux-cip-rt_4.4-cip-head.bb        |  1 +
 .../linux/linux-cip-rt_5.10-cip-head.bb       |  1 +
 .../linux/linux-cip-rt_6.1-cip-head.bb        |  1 +
 .../linux/linux-cip-rt_6.12-cip-head.bb       |  1 +
 .../linux/linux-cip_4.19-cip-head.bb          |  1 +
 .../linux/linux-cip_4.4-cip-head.bb           |  1 +
 .../linux/linux-cip_5.10-cip-head.bb          |  1 +
 .../linux/linux-cip_6.1-cip-head.bb           |  1 +
 .../linux/linux-cip_6.12-cip-head.bb          |  1 +
 11 files changed, 44 insertions(+)
 create mode 100644 recipes-kernel/linux/linux-cip-head.inc
 create mode 120000 recipes-kernel/linux/linux-cip-rt_4.19-cip-head.bb
 create mode 120000 recipes-kernel/linux/linux-cip-rt_4.4-cip-head.bb
 create mode 120000 recipes-kernel/linux/linux-cip-rt_5.10-cip-head.bb
 create mode 120000 recipes-kernel/linux/linux-cip-rt_6.1-cip-head.bb
 create mode 120000 recipes-kernel/linux/linux-cip-rt_6.12-cip-head.bb
 create mode 120000 recipes-kernel/linux/linux-cip_4.19-cip-head.bb
 create mode 120000 recipes-kernel/linux/linux-cip_4.4-cip-head.bb
 create mode 120000 recipes-kernel/linux/linux-cip_5.10-cip-head.bb
 create mode 120000 recipes-kernel/linux/linux-cip_6.1-cip-head.bb
 create mode 120000 recipes-kernel/linux/linux-cip_6.12-cip-head.bb

diff --git a/recipes-kernel/linux/linux-cip-head.inc b/recipes-kernel/linux/linux-cip-head.inc
new file mode 100644
index 00000000..df604db0
--- /dev/null
+++ b/recipes-kernel/linux/linux-cip-head.inc
@@ -0,0 +1,34 @@
+#
+# CIP Core, generic profile
+#
+# Copyright (c) Siemens, 2025
+#
+# Authors:
+#  Jan Kiszka <jan.kiszka@siemens.com>
+#
+# SPDX-License-Identifier: MIT
+#
+
+require linux-cip-common.inc
+
+def get_commit(d):
+    try:
+        return bb.fetch2.get_srcrev(d).replace('AUTOINC+', '')
+    except bb.fetch2.FetchError:
+        return ""
+
+KERNEL_MAJOR_MINOR := "${@d.getVar('PV').split('-')[0]}"
+
+BRANCH := "${@ \
+    'linux-' + d.getVar('PV').split('-')[0] + '.y-cip' + \
+    ('-rt' if d.getVar('KERNEL_NAME') == 'cip-rt' and \
+              d.getVar('KERNEL_MAJOR_MINOR') in ['4.4', '4.19', '5.10', '6.1'] else '') \
+    }"
+
+PV .= "${@'-g' + get_commit(d)}"
+
+SRC_URI += "git://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.git;protocol=https;branch=${BRANCH};name=cip-kernel"
+SRCREV_FORMAT = "cip-kernel"
+SRCREV_cip-kernel = "${AUTOREV}"
+
+S = "${WORKDIR}/git"
diff --git a/recipes-kernel/linux/linux-cip-rt_4.19-cip-head.bb b/recipes-kernel/linux/linux-cip-rt_4.19-cip-head.bb
new file mode 120000
index 00000000..8f99b54e
--- /dev/null
+++ b/recipes-kernel/linux/linux-cip-rt_4.19-cip-head.bb
@@ -0,0 +1 @@
+linux-cip-head.inc
\ No newline at end of file
diff --git a/recipes-kernel/linux/linux-cip-rt_4.4-cip-head.bb b/recipes-kernel/linux/linux-cip-rt_4.4-cip-head.bb
new file mode 120000
index 00000000..8f99b54e
--- /dev/null
+++ b/recipes-kernel/linux/linux-cip-rt_4.4-cip-head.bb
@@ -0,0 +1 @@
+linux-cip-head.inc
\ No newline at end of file
diff --git a/recipes-kernel/linux/linux-cip-rt_5.10-cip-head.bb b/recipes-kernel/linux/linux-cip-rt_5.10-cip-head.bb
new file mode 120000
index 00000000..8f99b54e
--- /dev/null
+++ b/recipes-kernel/linux/linux-cip-rt_5.10-cip-head.bb
@@ -0,0 +1 @@
+linux-cip-head.inc
\ No newline at end of file
diff --git a/recipes-kernel/linux/linux-cip-rt_6.1-cip-head.bb b/recipes-kernel/linux/linux-cip-rt_6.1-cip-head.bb
new file mode 120000
index 00000000..8f99b54e
--- /dev/null
+++ b/recipes-kernel/linux/linux-cip-rt_6.1-cip-head.bb
@@ -0,0 +1 @@
+linux-cip-head.inc
\ No newline at end of file
diff --git a/recipes-kernel/linux/linux-cip-rt_6.12-cip-head.bb b/recipes-kernel/linux/linux-cip-rt_6.12-cip-head.bb
new file mode 120000
index 00000000..8f99b54e
--- /dev/null
+++ b/recipes-kernel/linux/linux-cip-rt_6.12-cip-head.bb
@@ -0,0 +1 @@
+linux-cip-head.inc
\ No newline at end of file
diff --git a/recipes-kernel/linux/linux-cip_4.19-cip-head.bb b/recipes-kernel/linux/linux-cip_4.19-cip-head.bb
new file mode 120000
index 00000000..8f99b54e
--- /dev/null
+++ b/recipes-kernel/linux/linux-cip_4.19-cip-head.bb
@@ -0,0 +1 @@
+linux-cip-head.inc
\ No newline at end of file
diff --git a/recipes-kernel/linux/linux-cip_4.4-cip-head.bb b/recipes-kernel/linux/linux-cip_4.4-cip-head.bb
new file mode 120000
index 00000000..8f99b54e
--- /dev/null
+++ b/recipes-kernel/linux/linux-cip_4.4-cip-head.bb
@@ -0,0 +1 @@
+linux-cip-head.inc
\ No newline at end of file
diff --git a/recipes-kernel/linux/linux-cip_5.10-cip-head.bb b/recipes-kernel/linux/linux-cip_5.10-cip-head.bb
new file mode 120000
index 00000000..8f99b54e
--- /dev/null
+++ b/recipes-kernel/linux/linux-cip_5.10-cip-head.bb
@@ -0,0 +1 @@
+linux-cip-head.inc
\ No newline at end of file
diff --git a/recipes-kernel/linux/linux-cip_6.1-cip-head.bb b/recipes-kernel/linux/linux-cip_6.1-cip-head.bb
new file mode 120000
index 00000000..8f99b54e
--- /dev/null
+++ b/recipes-kernel/linux/linux-cip_6.1-cip-head.bb
@@ -0,0 +1 @@
+linux-cip-head.inc
\ No newline at end of file
diff --git a/recipes-kernel/linux/linux-cip_6.12-cip-head.bb b/recipes-kernel/linux/linux-cip_6.12-cip-head.bb
new file mode 120000
index 00000000..8f99b54e
--- /dev/null
+++ b/recipes-kernel/linux/linux-cip_6.12-cip-head.bb
@@ -0,0 +1 @@
+linux-cip-head.inc
\ No newline at end of file
-- 
2.43.0


