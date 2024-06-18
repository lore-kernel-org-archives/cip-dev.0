Return-Path: <quirin.gylstorff@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B51E7C2BA18
	for <webhook@archiver.kernel.org>; Tue, 18 Jun 2024 15:59:24 +0000 (UTC)
Received: from mta-64-225.siemens.flowmailer.net (mta-64-225.siemens.flowmailer.net [185.136.64.225])
 by mx.groups.io with SMTP id smtpd.web11.90104.1718726360007684356
 for <cip-dev@lists.cip-project.org>;
 Tue, 18 Jun 2024 08:59:21 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=Quirin.Gylstorff@siemens.com header.s=fm2 header.b=PRDALBuK;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.64.225, mailfrom: fm-51332-202406181559154c930c7e7607649e76-sb_bk6@rts-flowmailer.siemens.com)
Received: by mta-64-225.siemens.flowmailer.net with ESMTPSA id 202406181559154c930c7e7607649e76
        for <cip-dev@lists.cip-project.org>;
        Tue, 18 Jun 2024 17:59:16 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm2;
 d=siemens.com; i=Quirin.Gylstorff@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding;
 bh=HovsGruqvOV2m4a+itwZfYf1niOvibs0fA2ObH+xRTo=;
 b=PRDALBuK04MViKFVd9Ly6LTVGkc+HQ12Jg5hMi9KzOgwMbvlbNfLjBThBXyzKGxTw+heMh
 +F0N0do2zY1QOrDeACTImy2CPaPqo6oropVPMnSb/vbXY4xrApE8iCHzSsm4SO5N0XZ/X+uA
 6541QEAysHz0dVmqfogRiIajD+mio=;
From: Quirin Gylstorff <Quirin.Gylstorff@siemens.com>
To: jan.kiszka@siemens.com,
	cip-dev@lists.cip-project.org
Subject: [cip-dev][isar-cip-core][PATCH] swupdate: fix reboot progress with wfx
Date: Tue, 18 Jun 2024 17:56:29 +0200
Message-ID: <20240618155914.1458889-1-Quirin.Gylstorff@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-51332:519-21489:flowmailer
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 18 Jun 2024 15:59:24 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/16283

From: Quirin Gylstorff <quirin.gylstorff@siemens.com>

This back ports the fixes for the wfx progress handler to avoid a
second reboot on the device, see [1]

[1]: https://groups.google.com/g/swupdate/c/wJ6g5lajuYw

Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
---
 ...d-suricatta.ipc.progress_cause-table.patch | 30 +++++++++++
 ...ress-Fix-reboot-mode-message-parsing.patch | 52 +++++++++++++++++++
 recipes-core/swupdate/swupdate_2023.12.bb     |  3 +-
 3 files changed, 84 insertions(+), 1 deletion(-)
 create mode 100644 recipes-core/swupdate/files/2023.12/0001-suricatta-lua-Add-suricatta.ipc.progress_cause-table.patch
 create mode 100644 recipes-core/swupdate/files/2023.12/0002-swupdate-progress-Fix-reboot-mode-message-parsing.patch

diff --git a/recipes-core/swupdate/files/2023.12/0001-suricatta-lua-Add-suricatta.ipc.progress_cause-table.patch b/recipes-core/swupdate/files/2023.12/0001-suricatta-lua-Add-suricatta.ipc.progress_cause-table.patch
new file mode 100644
index 0000000..69873cb
--- /dev/null
+++ b/recipes-core/swupdate/files/2023.12/0001-suricatta-lua-Add-suricatta.ipc.progress_cause-table.patch
@@ -0,0 +1,30 @@
+From 3ac2b34958a31c3694a78f840201373cfaff6c10 Mon Sep 17 00:00:00 2001
+From: "Storm, Christian" <christian.storm@siemens.com>
+Date: Mon, 3 Jun 2024 20:16:56 +0000
+Subject: [PATCH 1/2] suricatta/lua: Add suricatta.ipc.progress_cause table
+
+Reported-by: Adithya Balakumar <adithya190298@gmail.com>
+Signed-off-by: Christian Storm <christian.storm@siemens.com>
+---
+ suricatta/server_lua.c | 5 +++++
+ 1 file changed, 5 insertions(+)
+
+diff --git a/suricatta/server_lua.c b/suricatta/server_lua.c
+index 7ac5e972..2641a037 100644
+--- a/suricatta/server_lua.c
++++ b/suricatta/server_lua.c
+@@ -1592,6 +1592,11 @@ static int suricatta_lua_module(lua_State *L)
+ 	push_to_table(L, "SUBPROCESS", SUBPROCESS);
+ 	push_to_table(L, "PROGRESS", PROGRESS);
+ 	lua_settable(L, -3);
++	lua_pushstring(L, "progress_cause");
++	lua_newtable(L);
++	push_to_table(L, "CAUSE_NONE", CAUSE_NONE);
++	push_to_table(L, "CAUSE_REBOOT_MODE", CAUSE_REBOOT_MODE);
++	lua_settable(L, -3);
+ 	lua_settable(L, -3);
+ 
+ 	lua_pushstring(L, "status");
+-- 
+2.43.0
+
diff --git a/recipes-core/swupdate/files/2023.12/0002-swupdate-progress-Fix-reboot-mode-message-parsing.patch b/recipes-core/swupdate/files/2023.12/0002-swupdate-progress-Fix-reboot-mode-message-parsing.patch
new file mode 100644
index 0000000..9719057
--- /dev/null
+++ b/recipes-core/swupdate/files/2023.12/0002-swupdate-progress-Fix-reboot-mode-message-parsing.patch
@@ -0,0 +1,52 @@
+From c65f5435eec2a0c51f6f0c356451c2091b2f3fdc Mon Sep 17 00:00:00 2001
+From: "Storm, Christian" <christian.storm@siemens.com>
+Date: Wed, 5 Jun 2024 06:35:24 +0000
+Subject: [PATCH 2/2] swupdate-progress: Fix reboot-mode message parsing
+
+The incoming msg.info reads, e.g.,
+{"0": {"1": { "reboot-mode" : "no-reboot"}}}
+and sscanf() also needs to parse/read over the enclosing
+{"0": <...>}
+part, though discarding it.
+
+While at it, use static buffer allocation as the BSDs don't have %m
+
+Signed-off-by: Christian Storm <christian.storm@siemens.com>
+---
+ tools/swupdate-progress.c | 7 +++----
+ 1 file changed, 3 insertions(+), 4 deletions(-)
+
+diff --git a/tools/swupdate-progress.c b/tools/swupdate-progress.c
+index 584910d4..14040757 100644
+--- a/tools/swupdate-progress.c
++++ b/tools/swupdate-progress.c
+@@ -339,7 +339,7 @@ int main(int argc, char **argv)
+ 		 * Be sure that string in message are Null terminated
+ 		 */
+ 		if (msg.infolen > 0) {
+-			char *reboot_mode;
++			char reboot_mode[20] = { 0 };
+ 			int n, cause;
+ 
+ 			if (msg.infolen >= sizeof(msg.info) - 1) {
+@@ -354,15 +354,14 @@ int main(int argc, char **argv)
+ 			 * will be added, JSON lib should be linked.
+ 			 * NOTE: Until then, the exact string format is imperative!
+ 			 */
+-			n = sscanf(msg.info, "{\"%d\": { \"reboot-mode\" : \"%m[-a-z]\"}}",
+-				   &cause, &reboot_mode);
++			n = sscanf(msg.info, "{\"%*d\": {\"%d\": { \"reboot-mode\" : \"%19[-a-z]\"}}}",
++				   &cause, reboot_mode);
+ 			if (n == 2) {
+ 				if (cause == CAUSE_REBOOT_MODE) {
+ 					if (!strcmp(reboot_mode, "no-reboot")) {
+ 						disable_reboot = true;
+ 					}
+ 				}
+-				free(reboot_mode);
+ 			}
+ 		}
+ 		msg.cur_image[sizeof(msg.cur_image) - 1] = '\0';
+-- 
+2.43.0
+
diff --git a/recipes-core/swupdate/swupdate_2023.12.bb b/recipes-core/swupdate/swupdate_2023.12.bb
index 1c140b0..cc01a98 100644
--- a/recipes-core/swupdate/swupdate_2023.12.bb
+++ b/recipes-core/swupdate/swupdate_2023.12.bb
@@ -27,7 +27,8 @@ SRCREV = "6ccd44a8539ebb880bf0dac408d5db5de7e2de99"
 # patches
 SRC_URI += "file://0001-d-rules-Add-seperate-build_profile-option-for-delta-.patch"
 SRC_URI += "file://0002-d-swupdate-www.install-Fix-path-for-debian-bullseye.patch"
-
+SRC_URI += "file://0001-suricatta-lua-Add-suricatta.ipc.progress_cause-table.patch"
+SRC_URI += "file://0002-swupdate-progress-Fix-reboot-mode-message-parsing.patch"
 # suricatta wfx requires suricatta lua and the dependency
 # is not set automatically
 DEB_BUILD_PROFILES += "pkg.swupdate.suricattalua"
-- 
2.43.0


