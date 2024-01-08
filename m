Return-Path: <quirin.gylstorff@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08C55C3DA6E
	for <webhook@archiver.kernel.org>; Mon,  8 Jan 2024 10:26:54 +0000 (UTC)
Received: from mta-65-227.siemens.flowmailer.net (mta-65-227.siemens.flowmailer.net [185.136.65.227])
 by mx.groups.io with SMTP id smtpd.web10.3845.1704709602862903003
 for <cip-dev@lists.cip-project.org>;
 Mon, 08 Jan 2024 02:26:44 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=Quirin.Gylstorff@siemens.com header.s=fm1 header.b=fzCIDAZ5;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.65.227, mailfrom: fm-51332-20240108102640791b13de080aa3cbf6-yzxwnu@rts-flowmailer.siemens.com)
Received: by mta-65-227.siemens.flowmailer.net with ESMTPSA id 20240108102640791b13de080aa3cbf6
        for <cip-dev@lists.cip-project.org>;
        Mon, 08 Jan 2024 11:26:40 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=Quirin.Gylstorff@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:References:In-Reply-To;
 bh=Q0uHH1rsokRJfkAP1QPz52XMfDYa8++Dsa4HU+HLW08=;
 b=fzCIDAZ5v8JeMoyQgAPBQF/XVFPXxVz6AffnW5SxGmFrJ/Tot/IRInw434oSCz8CRF+S2l
 tzzSQr3W9950zqXWHBQ/aM6IdUf0VAKtC5JP425joME13rBSzJDfnIkzmLE+jSTk2NIChJSA
 aUhdS/nK41Tn3QOS7Db+DVawu0Cyg=;
From: Quirin Gylstorff <Quirin.Gylstorff@siemens.com>
To: felix.moessbauer@siemens.com,
	jan.kiszka@siemens.com,
	cip-dev@lists.cip-project.org
Subject: [cip-dev][isar-cip-core][PATCH v4 3/6] efibootguard-efi.py: copy signed ebg binary to DEPLOY_DIR
Date: Mon,  8 Jan 2024 11:25:51 +0100
Message-ID: <20240108102638.2966221-4-Quirin.Gylstorff@siemens.com>
In-Reply-To: <20240108102638.2966221-1-Quirin.Gylstorff@siemens.com>
References: <20240108102638.2966221-1-Quirin.Gylstorff@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-51332:519-21489:flowmailer
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 08 Jan 2024 10:26:54 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/14270

From: Quirin Gylstorff <quirin.gylstorff@siemens.com>

This allows to add the signed ebg binary to a swu file for
updating the bootloader.

Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
---
 scripts/lib/wic/plugins/source/efibootguard-efi.py | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/scripts/lib/wic/plugins/source/efibootguard-efi.py b/scripts/lib/wic/plugins/source/efibootguard-efi.py
index 9bb6347..e82e990 100644
--- a/scripts/lib/wic/plugins/source/efibootguard-efi.py
+++ b/scripts/lib/wic/plugins/source/efibootguard-efi.py
@@ -66,6 +66,13 @@ class EfibootguardEFIPlugin(SourcePlugin):
             exit(1)
         creator.deploy_dir = deploy_dir
 
+        deploy_dir = get_bitbake_var("DEPLOY_DIR_IMAGE")
+        if not deploy_dir:
+            msger.error("DEPLOY_DIR_IMAGE not set, exiting\n")
+            exit(1)
+        creator.deploy_dir = deploy_dir
+
+        distro_arch = get_bitbake_var("DISTRO_ARCH")
         bootloader = "/usr/lib/{libpath}/efibootguard/efibootguard{efiarch}.efi".format(
                         libpath=libarch,
                         efiarch=efiarch)
@@ -86,6 +93,13 @@ class EfibootguardEFIPlugin(SourcePlugin):
                                               part_rootfs_dir,
                                               name)
         exec_cmd(cp_cmd, True)
+
+        cp_to_deploy_cmd = "cp %s/%s %s/%s" % (cr_workdir,
+                                               signed_bootloader,
+                                               deploy_dir,
+                                               name)
+        exec_cmd(cp_to_deploy_cmd, True)
+
         du_cmd = "du --apparent-size -ks %s" % part_rootfs_dir
         blocks = int(exec_cmd(du_cmd).split()[0])
 
-- 
2.43.0


