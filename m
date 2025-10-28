Return-Path: <adithya.balakumar@toshiba-tsip.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94B75CCF9F1
	for <webhook@archiver.kernel.org>; Tue, 28 Oct 2025 05:34:45 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.135])
 by mx.groups.io with SMTP id smtpd.web11.2055.1761629680876111609
 for <cip-dev@lists.cip-project.org>;
 Mon, 27 Oct 2025 22:34:41 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: toshiba-tsip.com, ip: 210.130.202.135, mailfrom: adithya.balakumar@toshiba-tsip.com)
Received: by mo-csw.securemx.jp (mx-mo-csw1801) id 59S5YcdV420798; Tue, 28 Oct 2025 14:34:38 +0900
X-Iguazu-Qid: 2yAbz4OZcbeLK802ur
X-Iguazu-QSIG: v=2; s=0; t=1761629677; q=2yAbz4OZcbeLK802ur; m=s3J9NYDwtrTRFcII2+nyKDQ/BrYY5KC5OrqVMiioZBU=
Received: from imx2-a.toshiba.co.jp (imx2-a.toshiba.co.jp [106.186.93.35])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	 id 4cwfFn5JZcz1xnZ; Tue, 28 Oct 2025 14:34:37 +0900 (JST)
From: Adithya.Balakumar@toshiba-tsip.com
To: cip-dev@lists.cip-project.org, jan.kiszka@siemens.com
Cc: Adithya Balakumar <Adithya.Balakumar@toshiba-tsip.com>,
        shivanand.kunijadar@toshiba-tsip.com, dinesh.kumar@toshiba-tsip.com,
        kazuhiro3.hayashi@toshiba.co.jp, akunuri.sahithi@toshiba-tsip.com
Subject: [isar-cip-core][RFC v2 1/5] SWUpdate: Use self-built SWUpdate 2025.05+dfsg-3 for trixie
Date: Tue, 28 Oct 2025 01:46:18 -0400
X-TSB-HOP2: ON
Message-Id: <20251028054623.2268466-2-Adithya.Balakumar@toshiba-tsip.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20251028054623.2268466-1-Adithya.Balakumar@toshiba-tsip.com>
References: <20251028054623.2268466-1-Adithya.Balakumar@toshiba-tsip.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-OriginalArrivalTime: 28 Oct 2025 05:34:34.0968 (UTC) FILETIME=[8B444580:01DC47CC]
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 28 Oct 2025 05:34:45 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/20244

From: Adithya Balakumar <Adithya.Balakumar@toshiba-tsip.com>

SWUpdate debian package for trixie (2024.12.1+dfsg-3) has an issue[1] when used with suricatta wfx.
The issue is solved in upstream and the fix is also backported to debian but only to 2025.05+dfsg-3

For now build SWUpdate(2025.05+dfsg-3) from source.

[1] https://bugs.debian.org/cgi-bin/bugreport.cgi?bug=1118485

Signed-off-by: Adithya Balakumar <Adithya.Balakumar@toshiba-tsip.com>
---
 conf/distro/cip-core-trixie.conf              |  1 +
 recipes-core/images/swupdate.inc              |  3 +-
 .../swupdate/swupdate_2025.05+dfsg-3.bb       | 36 +++++++++++++++++++
 3 files changed, 39 insertions(+), 1 deletion(-)
 create mode 100644 recipes-core/swupdate/swupdate_2025.05+dfsg-3.bb

diff --git a/conf/distro/cip-core-trixie.conf b/conf/distro/cip-core-trixie.conf
index b133bbb..663f2b0 100644
--- a/conf/distro/cip-core-trixie.conf
+++ b/conf/distro/cip-core-trixie.conf
@@ -12,5 +12,6 @@
 require conf/distro/debian-trixie.conf
 require cip-core-common.inc
 
+PREFERRED_VERSION_swupdate ?= "2025.05%"
 PREFERRED_VERSION_linux-cip ?= "6.12.%"
 PREFERRED_VERSION_linux-cip-rt ?= "6.12.%"
diff --git a/recipes-core/images/swupdate.inc b/recipes-core/images/swupdate.inc
index 75be566..47f18c5 100644
--- a/recipes-core/images/swupdate.inc
+++ b/recipes-core/images/swupdate.inc
@@ -28,10 +28,11 @@ SWUPDATE_SELFBUILT ?= "0"
 SWUPDATE_SELFBUILT:buster = "1"
 SWUPDATE_SELFBUILT:bullseye = "1"
 SWUPDATE_SELFBUILT:bookworm = "1"
+SWUPDATE_SELFBUILT:trixie = "1"
 
 python() {
     base_distro = d.getVar('BASE_DISTRO_CODENAME')
-    if base_distro not in ['buster', 'bullseye', 'bookworm'] and \
+    if base_distro not in ['buster', 'bullseye', 'bookworm', 'trixie'] and \
        bb.utils.to_boolean(d.getVar('SWUPDATE_SELFBUILT')):
         bb.fatal(f'Self-built SWUpdate not supported for {base_distro}')
 
diff --git a/recipes-core/swupdate/swupdate_2025.05+dfsg-3.bb b/recipes-core/swupdate/swupdate_2025.05+dfsg-3.bb
new file mode 100644
index 0000000..5c47d68
--- /dev/null
+++ b/recipes-core/swupdate/swupdate_2025.05+dfsg-3.bb
@@ -0,0 +1,36 @@
+#
+# CIP Core, generic profile
+#
+# Copyright (c) Toshiba Corporation, 2025
+#
+# Authors:
+#  Adithya Balakumar <adithya.balakumar@toshiba-tsip.com> 
+#
+# SPDX-License-Identifier: MIT
+
+inherit dpkg
+
+require swupdate.inc
+
+DEPENDS += "libebgenv-dev"
+DEPENDS += "libubootenv-dev"
+
+DEB_BUILD_PROFILES += "nodoc"
+DEB_BUILD_OPTIONS += "nodoc"
+
+FILESEXTRAPATHS:prepend := "${FILE_DIRNAME}/files/${PV}:"
+
+SRC_URI = "git://salsa.debian.org/debian/swupdate.git;protocol=https;branch=debian/master;destsuffix=${P}"
+
+SRCREV = "421a70d4449a9b036ed5a0598ae9b70a82dabfb8"
+
+DEB_BUILD_PROFILES += "cross nocheck"
+ISAR_CROSS_COMPILE:trixie = "0"
+
+CHANGELOG_V ?= "${PV}+cip-${SRCREV}"
+
+do_prepare_build() {
+    deb_add_changelog
+    cd ${WORKDIR}
+    tar cJf ${PN}_${PV}+cip.orig.tar.xz --exclude=.git --exclude=debian ${P}
+}
-- 
2.39.5



