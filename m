Return-Path: <quirin.gylstorff@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30E1EEE49B2
	for <webhook@archiver.kernel.org>; Wed, 23 Aug 2023 13:28:27 +0000 (UTC)
Received: from mta-65-226.siemens.flowmailer.net (mta-65-226.siemens.flowmailer.net [185.136.65.226])
 by mx.groups.io with SMTP id smtpd.web11.11431.1692797303621886433
 for <cip-dev@lists.cip-project.org>;
 Wed, 23 Aug 2023 06:28:25 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=Quirin.Gylstorff@siemens.com header.s=fm1 header.b=AJGk9j8h;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.65.226, mailfrom: fm-51332-202308231328176d18f1a2095eb35c83-gyczdf@rts-flowmailer.siemens.com)
Received: by mta-65-226.siemens.flowmailer.net with ESMTPSA id 202308231328176d18f1a2095eb35c83
        for <cip-dev@lists.cip-project.org>;
        Wed, 23 Aug 2023 15:28:18 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=Quirin.Gylstorff@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding;
 bh=hN5DFp3ocZ34CEUeox7MvuwfxJ1ZUzngOqvt/GggPEY=;
 b=AJGk9j8hQfO2X0r8KVz9LKJtUXvdN/XwCBYuaeklJo2xAzNeAcPEYxReu/0RIj85hs8Cls
 rKvE3xenIrt2KAdgb7HE4OPsuFUixAhcqyjz6jEfaIndNXomzmODSoe5IgtZ4KVBjYkWcFWM
 nBOLKghOxdNdM7JSwsPdoIxg89XSI=;
From: Quirin Gylstorff <Quirin.Gylstorff@siemens.com>
To: cip-dev@lists.cip-project.org,
	jan.kiszka@siemens.com,
	felix.moessbauer@siemens.com
Subject: [cip-dev][isar-cip-core][PATCH] initramfs-verity-hook: Ensure sync on rebuild
Date: Wed, 23 Aug 2023 15:28:16 +0200
Message-Id: <20230823132816.1011054-1-Quirin.Gylstorff@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-51332:519-21489:flowmailer
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 23 Aug 2023 13:28:27 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/12840

From: Quirin Gylstorff <quirin.gylstorff@siemens.com>

Disable the timestamp of the do_install() task to
re-execute when ever a dependency on do_install
is executed.

Without this change the sstate needs to be clean for
every rebuild.

Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
---
 .../initramfs-verity-hook/initramfs-verity-hook_0.1.bb         | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/recipes-initramfs/initramfs-verity-hook/initramfs-verity-hook_0.1.bb b/recipes-initramfs/initramfs-verity-hook/initramfs-verity-hook_0.1.bb
index 3fc63ed..7435649 100644
--- a/recipes-initramfs/initramfs-verity-hook/initramfs-verity-hook_0.1.bb
+++ b/recipes-initramfs/initramfs-verity-hook/initramfs-verity-hook_0.1.bb
@@ -40,6 +40,9 @@ do_install[cleandirs] += " \
     ${D}/usr/share/initramfs-tools/scripts/local-top \
     ${D}/usr/share/initramfs-tools/conf-hooks.d"
 
+# Ensure VERITY_ENV_FILE is updated also when rebuilding initramfs-verity-hook
+do_install[nostamp] = "1"
+
 do_install() {
     # Insert the veritysetup commandline into the script
     if [ -f "${VERITY_ENV_FILE}" ]; then
-- 
2.40.1


