Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21CEEC54F30
	for <webhook@archiver.kernel.org>; Fri, 23 May 2025 14:48:01 +0000 (UTC)
Received: from mta-64-226.siemens.flowmailer.net (mta-64-226.siemens.flowmailer.net [185.136.64.226])
 by mx.groups.io with SMTP id smtpd.web11.50112.1748011672320032204
 for <cip-dev@lists.cip-project.org>;
 Fri, 23 May 2025 07:47:52 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=jan.kiszka@siemens.com header.s=fm1 header.b=OiLUdmrp;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.64.226, mailfrom: fm-294854-202505231447480229cb389089179e5b-hhvwm2@rts-flowmailer.siemens.com)
Received: by mta-64-226.siemens.flowmailer.net with ESMTPSA id 202505231447480229cb389089179e5b
        for <cip-dev@lists.cip-project.org>;
        Fri, 23 May 2025 16:47:49 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=jan.kiszka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=a686r/s3MoRd2DrZPFP7MC65mVmURN/k0vr2dRXXthM=;
 b=OiLUdmrpdvW2ItVFcgYwmgZPdx1o8QwJ8vU3xXaIRtU/9pQL8FPyf0JIRUtblReegMu87U
 JzG/aNuLbIqr5CzzO29/pS+PaQqi+As5x9Oyj/kJKJuGCEN86xWuvt5gX6mWrbZaVJZ1VuDj
 +NRNkuHSrWJ3VrbmkCDyRat8jZWANdixrchDwEYS6cCBb/ay5F8bJR3oGAunxzoH0Gp40/Kn
 439EDPe8yBzWThvsbJqwkkzqTI8sZxP72iF5+29bqfyUk+OrbpA/sCDrqxbcpFIR1r7lNCE8
 ONFdm1NhDMV6OjuHDuNHjI9ZUxDVsQXdUq8VeFPpC/p21xeJO2w1eqUQ==;
From: Jan Kiszka <jan.kiszka@siemens.com>
To: cip-dev@lists.cip-project.org
Cc: Sai Sree Kartheek Adivi <s-adivi@ti.com>
Subject: [isar-cip-core][PATCH v2 2/5] linux-cip: Add support for building head of development branches
Date: Fri, 23 May 2025 16:47:44 +0200
Message-ID: <b366bf734ebff44f67fd6e2632582c7172ac54ff.1748011667.git.jan.kiszka@siemens.com>
In-Reply-To: <cover.1748011667.git.jan.kiszka@siemens.com>
References: <cover.1748011667.git.jan.kiszka@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-294854:519-21489:flowmailer
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 23 May 2025 14:48:01 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/18944

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
 scripts/update-linux-cip.sh                   |  6 ++--
 12 files changed, 47 insertions(+), 3 deletions(-)
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
diff --git a/scripts/update-linux-cip.sh b/scripts/update-linux-cip.sh
index df70fe2c..8e3647e4 100755
--- a/scripts/update-linux-cip.sh
+++ b/scripts/update-linux-cip.sh
@@ -16,12 +16,12 @@ for MAJOR_VERSION in 4.4 4.19 5.10 6.1 6.12; do
 	RECIPE_FILE=linux-cip_${VERSION}.bb
 	if [ ! -f ${RECIPE_FILE} ]; then
 		echo "Updating recipe to ${VERSION}"
-		git mv linux-cip_${MAJOR_VERSION}*.bb ${RECIPE_FILE}
+		git mv linux-cip_${MAJOR_VERSION}.*.bb ${RECIPE_FILE}
 		SHASUM=${LAST_ENTRY/ */}
 		sed -i 's/\(SRC_URI\[sha256sum\] = "\).*/\1'${SHASUM}'"'/ ${RECIPE_FILE}
 		git add ${RECIPE_FILE}
 		if [ "${MAJOR_VERSION}" == "6.12" ]; then
-			git rm linux-cip-rt_${MAJOR_VERSION}*.bb
+			git rm linux-cip-rt_${MAJOR_VERSION}.*.bb
 			ln -s ${RECIPE_FILE} linux-cip-rt_${VERSION}.bb
 			git add linux-cip-rt_${VERSION}.bb
 		fi
@@ -34,7 +34,7 @@ for MAJOR_VERSION in 4.4 4.19 5.10 6.1 6.12; do
 		RECIPE_FILE=linux-cip-rt_${VERSION}.bb
 		if [ ! -f "${RECIPE_FILE}" ]; then
 			echo "Updating recipe to ${VERSION}"
-			git mv linux-cip-rt_${MAJOR_VERSION}*.bb ${RECIPE_FILE}
+			git mv linux-cip-rt_${MAJOR_VERSION}.*.bb ${RECIPE_FILE}
 			SHASUM=${LAST_ENTRY/ */}
 			sed -i 's/\(SRC_URI\[sha256sum\] = "\).*/\1'${SHASUM}'"'/ ${RECIPE_FILE}
 			git add ${RECIPE_FILE}
-- 
2.43.0


