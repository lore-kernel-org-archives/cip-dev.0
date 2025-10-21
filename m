Return-Path: <adithya.balakumar@toshiba-tsip.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7306CCD1AA
	for <webhook@archiver.kernel.org>; Tue, 21 Oct 2025 12:40:44 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.135])
 by mx.groups.io with SMTP id smtpd.web10.10624.1761050443486670004
 for <cip-dev@lists.cip-project.org>;
 Tue, 21 Oct 2025 05:40:43 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: toshiba-tsip.com, ip: 210.130.202.135, mailfrom: adithya.balakumar@toshiba-tsip.com)
Received: by mo-csw.securemx.jp (mx-mo-csw1801) id 59LCeecL1901566; Tue, 21 Oct 2025 21:40:41 +0900
X-Iguazu-Qid: 2yAbS6oRbuRO52wuKO
X-Iguazu-QSIG: v=2; s=0; t=1761050440; q=2yAbS6oRbuRO52wuKO; m=mkiwn1pzwIMF9L1FXMd9Xocw56oNvhXr6HzUKts5zjQ=
Received: from imx2-a.toshiba.co.jp (imx2-a.toshiba.co.jp [106.186.93.35])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	 id 4crX2c3gZszyPQ; Tue, 21 Oct 2025 21:40:40 +0900 (JST)
From: Adithya.Balakumar@toshiba-tsip.com
To: cip-dev@lists.cip-project.org, jan.kiszka@siemens.com
Cc: Adithya Balakumar <Adithya.Balakumar@toshiba-tsip.com>,
        shivanand.kunijadar@toshiba-tsip.com, dinesh.kumar@toshiba-tsip.com,
        kazuhiro3.hayashi@toshiba.co.jp, akunuri.sahithi@toshiba-tsip.com
Subject: [isar-cip-core][RFC v1 1/5] SWUpdate: Use self-built SWUpdate 2025.05 for trixie
Date: Tue, 21 Oct 2025 08:52:28 -0400
X-TSB-HOP2: ON
Message-Id: <20251021125233.1528087-2-Adithya.Balakumar@toshiba-tsip.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20251021125233.1528087-1-Adithya.Balakumar@toshiba-tsip.com>
References: <20251021125233.1528087-1-Adithya.Balakumar@toshiba-tsip.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-OriginalArrivalTime: 21 Oct 2025 12:40:37.0182 (UTC) FILETIME=[E6A455E0:01DC4287]
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 21 Oct 2025 12:40:44 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/20203

From: Adithya Balakumar <Adithya.Balakumar@toshiba-tsip.com>

SWUpdate debian package for trixie has an issue[1] when used with suricatta wfx.
Although the issue is solved, but the fix isn't yet available in any debian
version.

For now carry the upstream patch and build SWUpdate from source.

[1] https://bugs.debian.org/cgi-bin/bugreport.cgi?bug=1118485

Signed-off-by: Adithya Balakumar <Adithya.Balakumar@toshiba-tsip.com>
---
 conf/distro/cip-core-trixie.conf              |   1 +
 recipes-core/images/swupdate.inc              |   3 +-
 ...x-rebooting-via-tools-swupdate-progr.patch | 129 ++++++++++++++++++
 recipes-core/swupdate/swupdate_2025.05.bb     |  39 ++++++
 4 files changed, 171 insertions(+), 1 deletion(-)
 create mode 100644 recipes-core/swupdate/files/2025.05/0001-suricatta-wfx-Fix-rebooting-via-tools-swupdate-progr.patch
 create mode 100644 recipes-core/swupdate/swupdate_2025.05.bb

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
 
diff --git a/recipes-core/swupdate/files/2025.05/0001-suricatta-wfx-Fix-rebooting-via-tools-swupdate-progr.patch b/recipes-core/swupdate/files/2025.05/0001-suricatta-wfx-Fix-rebooting-via-tools-swupdate-progr.patch
new file mode 100644
index 0000000..68cd6a1
--- /dev/null
+++ b/recipes-core/swupdate/files/2025.05/0001-suricatta-wfx-Fix-rebooting-via-tools-swupdate-progr.patch
@@ -0,0 +1,129 @@
+From 6281f3783a303904981523ed8388b468d58eb5a0 Mon Sep 17 00:00:00 2001
+From: "Storm, Christian" <christian.storm@siemens.com>
+Date: Tue, 15 Jul 2025 08:59:07 +0000
+Subject: [PATCH] suricatta/wfx: Fix rebooting via tools/swupdate-progress.c
+
+The changes leading to commit 077ef4f broke rebooting via
+tools/swupdate-progress.c. Hence, adapt the C Lua bridge
+lua_notify_progress() and update its invocation in
+suricatta/server_wfx.lua as well as updating / fixing
+Lua annotations.
+
+Signed-off-by: Christian Storm <christian.storm@siemens.com>
+---
+ corelib/lua_interface.c  | 17 +++++++++--------
+ doc/source/suricatta.rst |  8 ++++----
+ handlers/swupdate.lua    |  5 +++--
+ suricatta/server_wfx.lua |  6 ++++--
+ suricatta/suricatta.lua  |  5 +++--
+ 5 files changed, 23 insertions(+), 18 deletions(-)
+
+diff --git a/corelib/lua_interface.c b/corelib/lua_interface.c
+index 8d57aaa9..1ff3e5e4 100644
+--- a/corelib/lua_interface.c
++++ b/corelib/lua_interface.c
+@@ -1232,17 +1232,18 @@ static int l_stat(lua_State *L)
+  * @brief Dispatch a message to the progress interface.
+  *
+  * @param [Lua] Message to dispatch to progress interface.
++ * @param [Lua] progress_cause_t number (optional), default: CAUSE_NONE
+  * @return [Lua] nil.
+  */
+ int lua_notify_progress(lua_State *L) {
+-  /*
+-   * NOTE: level is INFOLEVEL for the sake of specifying a level.
+-   * It is unused in core/notifier.c :: progress_notifier() as the
+-   * progress emitter doesn't know about log levels.
+-   */
+-  notify(PROGRESS, RECOVERY_NO_ERROR, INFOLEVEL, luaL_checkstring(L, -1));
+-  lua_pop(L, 1);
+-  return 0;
++	lua_Number cause = CAUSE_NONE;
++	if (lua_isnumber(L, -1) == 1) {
++		cause = lua_tonumber(L, -1);
++		lua_pop(L, 1);
++	}
++	notify(PROGRESS, (progress_cause_t)cause, INFOLEVEL, luaL_checkstring(L, -1));
++	lua_pop(L, 1);
++	return 0;
+ }
+ 
+ /**
+diff --git a/doc/source/suricatta.rst b/doc/source/suricatta.rst
+index 474d02cc..a4081a63 100644
+--- a/doc/source/suricatta.rst
++++ b/doc/source/suricatta.rst
+@@ -557,10 +557,10 @@ The ``suricatta.status`` table exposes the ``server_op_res_t`` enum values defin
+ The ``suricatta.notify`` table provides the usual logging functions to the Lua
+ suricatta module matching their uppercase-named pendants available in the C realm.
+ 
+-One notable exception is ``suricatta.notify.progress(message)`` which dispatches the
+-message to the progress interface (see :doc:`progress`). Custom progress client
+-implementations listening and acting on custom progress messages can be realized
+-using this function.
++One notable exception is ``suricatta.notify.progress(message, cause)`` which 
++dispatches the message to the progress interface (see :doc:`progress`). Custom
++progress client implementations listening and acting on custom progress messages
++can be realized using this function.
+ 
+ All notify functions return ``nil``.
+ 
+diff --git a/handlers/swupdate.lua b/handlers/swupdate.lua
+index aa8a31d0..d32f83b9 100644
+--- a/handlers/swupdate.lua
++++ b/handlers/swupdate.lua
+@@ -63,8 +63,9 @@ swupdate.warn  = function(format, ...) end
+ swupdate.debug = function(format, ...) end
+ 
+ --- Lua equivalent of `notify(PROGRESS, ..., msg)`.
+---- @param msg  string  Message to send to progress interface
+-swupdate.progress = function(msg) end
++--- @param msg    string        Message to send to progress interface
++--- @param cause  number | nil  `progress_cause_t` value as defined in `include/progress_ipc.h`
++swupdate.progress = function(msg, cause) end
+ 
+ --- Lua equivalent of `notify(status, error, INFOLEVEL, msg)`.
+ --- @param status  swupdate.RECOVERY_STATUS  Current status, one of `swupdate.RECOVERY_STATUS`'s values
+diff --git a/suricatta/server_wfx.lua b/suricatta/server_wfx.lua
+index 0978ed50..d0b01bad 100644
+--- a/suricatta/server_wfx.lua
++++ b/suricatta/server_wfx.lua
+@@ -1471,8 +1471,10 @@ M.job.workflow.dispatch:set(
+             suricatta.notify.warn("Cannot initialize progress reporting channel, won't send progress.")
+         end
+ 
+-        suricatta.notify.progress(M.utils.string.escape([[{"%s": { "reboot-mode" : "no-reboot"}}]])
+-            :format(suricatta.ipc.progress_cause.CAUSE_REBOOT_MODE))
++        suricatta.notify.progress(
++            M.utils.string.escape([[{ "reboot-mode" : "no-reboot"}]]),
++            suricatta.ipc.progress_cause.CAUSE_REBOOT_MODE
++        )
+ 
+         suricatta.notify.debug(
+             "%s Version '%s' (Type: %s).",
+diff --git a/suricatta/suricatta.lua b/suricatta/suricatta.lua
+index 24d6eb8f..b8707a25 100644
+--- a/suricatta/suricatta.lua
++++ b/suricatta/suricatta.lua
+@@ -47,6 +47,7 @@ suricatta.status = {
+ --
+ -- Translates to `notify(string.format(message, ...))`,
+ -- @see `corelib/lua_interface.c`
++-- except for `suricatta.notify.progress()`.
+ --
+ --- @class suricatta.notify
+ suricatta.notify = {
+@@ -60,8 +61,8 @@ suricatta.notify = {
+     info     = function(message, ...) end,
+     --- @type fun(message: string, ...: any)
+     warn     = function(message, ...) end,
+-    --- @type fun(message: string, ...: any)
+-    progress = function(message, ...) end,
++    --- @type fun(message: string, cause:suricatta.ipc.progress_cause?)
++    progress = function(message, cause) end,
+ }
+ 
+ 
+-- 
+2.39.5
+
diff --git a/recipes-core/swupdate/swupdate_2025.05.bb b/recipes-core/swupdate/swupdate_2025.05.bb
new file mode 100644
index 0000000..b77236a
--- /dev/null
+++ b/recipes-core/swupdate/swupdate_2025.05.bb
@@ -0,0 +1,39 @@
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
+SRCREV = "25e4534a157b8e432c3bcb4091e75724fcb0a5d4"
+
+# patches
+SRC_URI += "file://0001-suricatta-wfx-Fix-rebooting-via-tools-swupdate-progr.patch"
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



