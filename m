Return-Path: <yoshitake.kobayashi.x25@mail.toshiba>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9752EEA7955
	for <webhook@archiver.kernel.org>; Fri,  6 Feb 2026 04:48:29 +0000 (UTC)
Received: from mta-65-228.siemens.flowmailer.net (mta-65-228.siemens.flowmailer.net [185.136.65.228])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.25345.1770310074637952045
 for <cip-dev@lists.cip-project.org>;
 Thu, 05 Feb 2026 08:47:56 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=badrikesh.prusty@siemens.com header.s=fm2 header.b=B4u6q9D6;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.65.228, mailfrom: fm-1328765-202602051637464c3fcb13e6000207b0-won25x@rts-flowmailer.siemens.com)
Received: by mta-65-228.siemens.flowmailer.net with ESMTPSA id 202602051637464c3fcb13e6000207b0
        for <cip-dev@lists.cip-project.org>;
        Thu, 05 Feb 2026 17:37:47 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm2;
 d=siemens.com; i=badrikesh.prusty@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc;
 bh=prrmg5CojWt2gefeyyZ8PLXTqmYo1gJacaBKWHd9Oos=;
 b=B4u6q9D6oy01vrP88RL1D4n17bQ3ttkzMvIpY4mjMINsfmk8qZR4Yy5AmIW/30gbp62A5+
 icrzkU/M24i+aKIhWS2v3R/OrZNz3XKHxk+Uy/SiKefgyAmf+6HE5VAbR3Nw7QsTZD8FJPf+
 QO9bjSgVz6pmJolHhJ7aUWSALCGK6MTjzXRIDNebngwHVAFdbtqDeAn7i3d5+0O7S+4YVJws
 YFSiZxd5G42ugQoKR8H77dRXs7E97GGghPvTwKbPTkwPjCA2KxpvCOElDni5GEh0dG8D29zO
 5sdBuVVn3RwAY1qx9LPZJrIVN+t6JTR95tm57/BhYxqDSL7DqMPSqDgg==;
From: Badrikesh Prusty <badrikesh.prusty@siemens.com>
To: cip-dev@lists.cip-project.org
Cc: jan.kiszka@siemens.com,
	Badrikesh Prusty <badrikesh.prusty@siemens.com>
Subject: [isar-cip-core][PATCH] swupdate: use self-built 2025.12 for Debian Trixie
Date: Thu,  5 Feb 2026 11:37:27 -0500
Message-ID: <20260205163727.2995422-1-badrikesh.prusty@siemens.com>
MIME-Version: 1.0
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-1328765:519-21489:flowmailer
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 06 Feb 2026 04:48:29 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/21843

Debian Trixie ships SWUpdate 2024.12 which has an issue: swupdate-client
ignores the daemon's RuntimeDirectory setting and always uses /tmp
sockets, causing IPC failures.

This sets PREFERRED_VERSION_swupdate to 2025.12 and enables
SWUPDATE_SELFBUILT for Trixie. It also adds patches so control and
progress sockets are created under /run/swupdate by default,
matching documentation. swupdate-client now uses these sockets by
default when applying updates.

Closes: #135
Signed-off-by: Badrikesh Prusty <badrikesh.prusty@siemens.com>
---
 conf/distro/cip-core-trixie.conf              |  1 +
 recipes-core/images/swupdate.inc              |  3 +-
 ...date-as-default-socket-directory-ins.patch | 49 +++++++++++++++++++
 recipes-core/swupdate/swupdate_2025.12.bb     | 43 ++++++++++++++++
 4 files changed, 95 insertions(+), 1 deletion(-)
 create mode 100644 recipes-core/swupdate/files/2025.12/0001-ipc-use-run-swupdate-as-default-socket-directory-ins.patch
 create mode 100644 recipes-core/swupdate/swupdate_2025.12.bb

diff --git a/conf/distro/cip-core-trixie.conf b/conf/distro/cip-core-trixie.conf
index b133bbb..4ed2461 100644
--- a/conf/distro/cip-core-trixie.conf
+++ b/conf/distro/cip-core-trixie.conf
@@ -12,5 +12,6 @@
 require conf/distro/debian-trixie.conf
 require cip-core-common.inc
 
+PREFERRED_VERSION_swupdate ?= "2025.12%"
 PREFERRED_VERSION_linux-cip ?= "6.12.%"
 PREFERRED_VERSION_linux-cip-rt ?= "6.12.%"
diff --git a/recipes-core/images/swupdate.inc b/recipes-core/images/swupdate.inc
index 00e972e..c9dbcde 100644
--- a/recipes-core/images/swupdate.inc
+++ b/recipes-core/images/swupdate.inc
@@ -42,10 +42,11 @@ SWUPDATE_SELFBUILT ?= "0"
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
 
diff --git a/recipes-core/swupdate/files/2025.12/0001-ipc-use-run-swupdate-as-default-socket-directory-ins.patch b/recipes-core/swupdate/files/2025.12/0001-ipc-use-run-swupdate-as-default-socket-directory-ins.patch
new file mode 100644
index 0000000..e87c8bc
--- /dev/null
+++ b/recipes-core/swupdate/files/2025.12/0001-ipc-use-run-swupdate-as-default-socket-directory-ins.patch
@@ -0,0 +1,49 @@
+From c89f62d0a68e5c45e3f052edf6c3d77bba8c67e5 Mon Sep 17 00:00:00 2001
+From: Badrikesh Prusty <badrikesh.prusty@siemens.com>
+Date: Tue, 3 Feb 2026 11:25:18 +0530
+Subject: [PATCH] ipc: use /run/swupdate as default socket directory instead of
+ /tmp
+
+Change the default socket directory for control and progress IPC from
+/tmp to /run/swupdate.
+
+This aligns with systemd conventions (RuntimeDirectory=swupdate) and
+the documentation in `doc/source/swupdate.rst`. It also improves
+security by avoiding world-writable /tmp and provides deterministic,
+predictable paths for both daemon and clients.
+
+Signed-off-by: Badrikesh Prusty <badrikesh.prusty@siemens.com>
+---
+ ipc/network_ipc.c  | 2 +-
+ ipc/progress_ipc.c | 2 +-
+ 2 files changed, 2 insertions(+), 2 deletions(-)
+
+diff --git a/ipc/network_ipc.c b/ipc/network_ipc.c
+index 099587d4..e167d0b1 100644
+--- a/ipc/network_ipc.c
++++ b/ipc/network_ipc.c
+@@ -32,7 +32,7 @@ char *get_ctrl_socket(void) {
+ 			socketdir = getenv("TMPDIR");
+ 		}
+ 		if (!socketdir)
+-			socketdir = "/tmp";
++			socketdir = "/run/swupdate";
+ 		if (asprintf(&SOCKET_CTRL_PATH, "%s/%s", socketdir, SOCKET_CTRL_DEFAULT) == -1)
+ 			return (char *)"/tmp/"SOCKET_CTRL_DEFAULT;
+ 	}
+diff --git a/ipc/progress_ipc.c b/ipc/progress_ipc.c
+index d3689271..382a83c9 100644
+--- a/ipc/progress_ipc.c
++++ b/ipc/progress_ipc.c
+@@ -41,7 +41,7 @@ char *get_prog_socket(void) {
+ 			socketdir = getenv("TMPDIR");
+ 		}
+ 		if(!socketdir){
+-			socketdir = "/tmp";
++			socketdir = "/run/swupdate";
+ 		}
+ 		if (asprintf(&SOCKET_PROGRESS_PATH, "%s/%s", socketdir, SOCKET_PROGRESS_DEFAULT) == -1)
+ 			return (char *)"/tmp/"SOCKET_PROGRESS_DEFAULT;
+-- 
+2.39.5
+
diff --git a/recipes-core/swupdate/swupdate_2025.12.bb b/recipes-core/swupdate/swupdate_2025.12.bb
new file mode 100644
index 0000000..d53545e
--- /dev/null
+++ b/recipes-core/swupdate/swupdate_2025.12.bb
@@ -0,0 +1,43 @@
+#
+# CIP Core, generic profile
+#
+# Copyright (c) Siemens AG, 2026
+#
+# Authors:
+#  Badrikesh Prusty <badrikesh.prusty@siemens.com>
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
+SRCREV = "1fa1ce0c85423f228529d2fccbe8813f07040536"
+
+# patches
+SRC_URI += "file://0001-ipc-use-run-swupdate-as-default-socket-directory-ins.patch"
+
+# Disable cross for arm and arm64 on bullseye
+# with cross compile we have a unsat-dependency to dh-nodejs on arm/arm64
+ISAR_CROSS_COMPILE:bullseye = "0"
+
+# add cross build and deactivate testing for arm based builds
+DEB_BUILD_PROFILES += "cross nocheck"
+
+CHANGELOG_V ?= "${PV}+cip-${SRCREV}"
+
+do_prepare_build() {
+    deb_add_changelog
+    cd ${WORKDIR}
+    tar cJf ${PN}_${PV}+cip.orig.tar.xz ${TAR_REPRO_OPTS} ${P}
+}
-- 
2.39.5


